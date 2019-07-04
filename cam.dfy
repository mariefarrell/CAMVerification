//C = Confidentiality (Vehicles only receive messages intended for them)
//I = Integrity (The contents of the received message are the same as when it was sent)
//A = Availability (CAM messages are sent on time and arrive within some time bound)

//Cooperative Awareness Messages (CAM) generation for vehicle j.
//These are used to inform other vehicles of the current vehicle's state
//CAM messages are intended for all that receive them so proving Confidentiality is unnecessary


datatype CAM = CAM(id:int, time:int, heading:int, speed:int, position:int)
//Main method to get everything going

// Min and Max CAM generation times in ms
const T_GenCamMin := 100;
const T_GenCamMax := 1000;

const N_GenCamMax := 3;
const N_GenCamDefault := N_GenCamMax;

// Thresholds
const headingthreshold := 4;
const speedthreshold := 4;
const posthreshold := 0.5 as real;

method Main()
{
  var carNos := 2;
  var T_CheckCamGen := 3; // Every 10ms, check status
  var T_GenCam_DCC := 100; // Every 100ms, minimum time interval between two consecutive CAM generations 
  var MaxMsgs := 100; // Max number of messages to verify for

  var c := 0;
  while (c < carNos)
  decreases carNos - c;
  {
    var res, now := sendCAM(T_CheckCamGen, T_GenCam_DCC, c, 0, MaxMsgs);
    c := c + 1;
    print c, ": ", |res|, " ", res, " @ ", now, "\n";

    var rc := 0;
    while (rc < carNos)
    decreases carNos - rc;
    {
      var closer := receiveCAM(rc, now, res);
      rc := rc + 1;
    }
  }
}

method sendCAM(T_CheckCamGen:int, T_GenCam_DCC:int, j: int, start: int, max_msgs: int) returns (msgs:seq<CAM>, now:int)
  requires 0 < T_CheckCamGen <= T_GenCamMin; // Check more requestly than the minimum generation period for changes in vehicle state
  requires T_GenCamMin <= T_GenCam_DCC <= T_GenCamMax;
  requires start >= 0;
  requires max_msgs >= 0;

  ensures T_GenCam_DCC * |msgs| <= (now - start) <= T_GenCamMax * |msgs|;
  ensures |msgs| >= 2 ==> forall i: int :: 1 <= i < |msgs| ==> T_GenCam_DCC <= (msgs[i].time - msgs[i-1].time) <= T_GenCamMax;
  ensures |msgs| == max_msgs;
{
  var T_GenCam := T_GenCamMax; // currently valid upper limit of the CAM generation interval
  var T_GenCamNext := T_GenCam;
  var N_GenCam := N_GenCamDefault;
  var trigger_two_count := 0;
  
  now := start;
  var LastBroadcast, PrevLastBroadcast := now, now;

  var heading, speed, pos := GetHeading(j, now), GetSpeed(j, now), GetPosition(j, now);
  var prevheading, prevspeed, prevpos, statechanged := -1, -1, -1, false;

  msgs := [];
  var prevsent := msgs;

  while (|msgs| < max_msgs)
  decreases max_msgs - |msgs|;
  invariant 0 <= |msgs| <= max_msgs;

  // Check variables remain within valid ranges
  invariant 0 < N_GenCam <= N_GenCamMax;
  invariant T_GenCamMin <= T_GenCamNext <= T_GenCamMax;
  invariant T_GenCamMin <= T_GenCam <= T_GenCamMax;

  invariant start <= PrevLastBroadcast <= now;
  invariant now == LastBroadcast;
  invariant now - T_GenCamMax <= PrevLastBroadcast <= LastBroadcast;  

  // Check that messages are sent often enough
  invariant |msgs| >= 1 ==> msgs[|msgs|-1].time == LastBroadcast;
  invariant |msgs| >= 2 ==> msgs[|msgs|-2].time == PrevLastBroadcast;

  invariant now > start ==> T_GenCam_DCC <= LastBroadcast - PrevLastBroadcast <= T_GenCamMax;
  
  // Message sent conditions (don't test when entering the loop)
  invariant now > start ==> CAM(j,now,heading,speed,pos) in msgs;
  invariant now > start ==> |prevsent| + 1 == |msgs|;

  invariant |msgs| >= 2 ==> forall i: int :: 1 <= i < |msgs| ==> (T_GenCam_DCC <= (msgs[i].time - msgs[i-1].time) <= T_GenCamMax);

  invariant T_GenCamMin * |msgs| <= T_GenCam_DCC * |msgs|;
  invariant T_GenCam_DCC * |msgs| <= (now - start);
  invariant now > start ==> (now - start) <= T_GenCamMax * |msgs|;
  {
    prevsent, PrevLastBroadcast := msgs, LastBroadcast;
    T_GenCam := T_GenCamNext;
    statechanged := false;

    // Advance time to the earliest a CAM can be sent (T_CamGen_DCC used as congestion control)
    now := now + T_GenCam_DCC;

    // Find the time at which information has changed or we have waited T_GenCam
    while (true)
    decreases LastBroadcast + T_GenCam - now;
    invariant now - LastBroadcast <= max(T_GenCam_DCC, T_GenCam);
    {
        // Get vehicle information
        heading, speed, pos := GetHeading(j, now), GetSpeed(j, now), GetPosition(j, now);
      
        // Check if this information has changed
        statechanged := abs(heading - prevheading) >= headingthreshold ||
                        abs(speed - prevspeed) >= speedthreshold ||
                        abs(pos - prevpos) >= posthreshold.Floor;
        
        if (statechanged || now - LastBroadcast >= T_GenCam)
        {
            break; // Don't sleep if we need to send a CAM
        }
        else
        {
            now := now + T_CheckCamGen; // Sleep for a bit to advance time
        }
    }

    assert LastBroadcast + T_GenCam_DCC <= now <= LastBroadcast + T_GenCamMax;
    
    msgs := msgs + [CAM(j,now,heading,speed,pos)];
    
    if (statechanged) { // Trigger 1
      T_GenCamNext := now - LastBroadcast;
      trigger_two_count := 0; // Reset
    }
    else if (now - LastBroadcast >= T_GenCam){ // Trigger 2
      trigger_two_count := trigger_two_count + 1;
      if (trigger_two_count == N_GenCam) {
        T_GenCamNext := T_GenCamMax;
      }
    }

    // Set current values as old values
    LastBroadcast := now;
    prevheading, prevspeed, prevpos := heading, speed, pos;
  }
  return msgs, now;
}

method receiveCAM(j: int, now: int, cams:seq<CAM>) returns (closer:seq<bool>)
ensures |cams| == |closer|;
{
  closer := [];

  while (|closer| < |cams|)
  decreases |cams| - |closer|;
  invariant 0 <= |closer| <= |cams|;
  {
    var i := |closer|;

    var timediff := now - cams[i].time;
    var dist := Distance(cams[i].position, GetPosition(j, now));

    var dist_early := dist + GetSpeed(j, now) * -timediff;
    var dist_now := dist + cams[i].speed * timediff;

    closer := closer + [dist_now < dist_early]; // Record if getting closer
  }
}

//helper functions and methods are below

function method GetHeading(j: int, now: int) :int
{
  20
}

function method GetSpeed(j: int, now: int):int
{
  50
}

function method GetPosition(j: int, now: int):int
{
  10
}

function method abs(x: int): int
{
   if x < 0 then -x else x
}

function method max(x: int, y: int): int
{
  if x < y then y else x
}

function method Distance(posa: int, posx: int): int
{
  abs(posa - posx)
}

