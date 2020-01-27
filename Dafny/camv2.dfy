//Cooperative Awareness Messages (CAM) generation for vehicle j.
//These are used to inform other vehicles of the current vehicle's state
//CAM messages are intended for all that receive them so proving Confidentiality is unnecessary

datatype CAM = CAM(id:int, time:int, heading:int, speed:int, position:int)

datatype PreviousValue<T> = Nil | PreviousValue(value: T)

// Min and Max CAM generation times in ms
const T_GenCamMin := 100;
const T_GenCamMax := 1000;

const N_GenCamMax := 3;
const N_GenCamDefault := N_GenCamMax;

// Thresholds
const headingthreshold := 4; // Degrees
const speedthreshold := 50; //cm\s
const posthreshold := 400; //cm

// Main method to get everything going
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

function method HeadingChanged(s: PreviousValue<int>, current: int): bool
{
  match s
  case Nil => true
  case PreviousValue(x: int) => abs(current - x) >= headingthreshold
}

function method SpeedChanged(s: PreviousValue<int>, current: int): bool
{
  match s
  case Nil => true
  case PreviousValue(x: int) => abs(current - x) >= speedthreshold
}

function method PositionChanged(s: PreviousValue<int>, current: int): bool
{
  match s
  case Nil => true
  case PreviousValue(x: int) => Distance(current, x) >= posthreshold
}

method safeSendCAM(T_CheckCamGen:int, T_GenCam_DCC:int, j: int, start: int, max_msgs: int)
  returns (msgs:seq<CAM>, now:int, safe_T_CheckCamGen:int, safe_T_GenCam_DCC:int)

  requires start >= 0;
  requires max_msgs >= 0;
  requires 0 < N_GenCamDefault <= N_GenCamMax;

  ensures safe_T_GenCam_DCC * |msgs| <= (now - start) <= T_GenCamMax * |msgs|;
  ensures |msgs| >= 2 ==> forall i: int :: 1 <= i < |msgs| ==> safe_T_GenCam_DCC <= msgs[i].time - msgs[i-1].time <= T_GenCamMax;
  ensures |msgs| == max_msgs;
{
  safe_T_CheckCamGen := clamp(T_CheckCamGen, 1, T_GenCamMin);
  safe_T_GenCam_DCC := clamp(T_GenCam_DCC, T_GenCamMin, T_GenCamMax);

  msgs, now := sendCAM(safe_T_CheckCamGen, safe_T_GenCam_DCC, j, start, max_msgs);
}

method sendCAM(T_CheckCamGen:int, T_GenCam_DCC:int, j: int, start: int, max_msgs: int) returns (msgs:seq<CAM>, now:int)
  requires 0 < T_CheckCamGen <= T_GenCamMin; // Check more frequently than the minimum generation period for changes in vehicle state
  requires T_GenCamMin <= T_GenCam_DCC <= T_GenCamMax;
  requires start >= 0;
  requires max_msgs >= 0;
  requires 0 < N_GenCamDefault <= N_GenCamMax;

  ensures T_GenCam_DCC * |msgs| <= (now - start) <= T_GenCamMax * |msgs|;
  ensures |msgs| >= 2 ==> forall i: int :: 1 <= i < |msgs| ==> T_GenCam_DCC <= msgs[i].time - msgs[i-1].time <= T_GenCamMax;
  ensures |msgs| == max_msgs;
{
  var T_GenCam := T_GenCamMax; // currently valid upper limit of the CAM generation interval
  var T_GenCamNext := T_GenCam;
  var N_GenCam := N_GenCamDefault;
  var trigger_two_count := 0;
  
  now := start;
  var LastBroadcast, PrevLastBroadcast := now, now;

  var heading: int := GetHeading(j, now);
  var speed: int := GetSpeed(j, now);
  var pos: int := GetPosition(j, now);
  var prevheading: PreviousValue<int> := Nil;
  var prevspeed: PreviousValue<int> := Nil;
  var prevpos: PreviousValue<int> := Nil;

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

  invariant T_GenCam_DCC * |msgs| <= (now - start);
  invariant now > start ==> (now - start) <= T_GenCamMax * |msgs|;
  {
    prevsent, PrevLastBroadcast := msgs, LastBroadcast;
    T_GenCam := T_GenCamNext;
    var statechanged := false;

    // Advance time to the earliest a CAM can be sent (T_CamGen_DCC used as congestion control)
    now := now + T_GenCam_DCC;

    // Find the time at which information has changed or we have waited T_GenCam
    while (true)
    decreases LastBroadcast + T_GenCam - now;
    invariant now - LastBroadcast <= T_GenCam_DCC || now - LastBroadcast <= T_GenCam;
    {
        // Get vehicle information
        heading := GetHeading(j, now);
        speed := GetSpeed(j, now);
        pos := GetPosition(j, now);

        // Check if this information has changed
        statechanged := 
          HeadingChanged(prevheading, heading) ||
          SpeedChanged(prevspeed, speed) ||
          PositionChanged(prevpos, pos);
        
        if (statechanged)
        {
            break; // Don't sleep if we need to send a CAM because values have changed sufficiently
        }
        else if (now - LastBroadcast + T_CheckCamGen >= T_GenCam)
        {
            break; // Don't sleep if we need to send a CAM because we have reached the wait time limit
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
    prevheading, prevspeed, prevpos := PreviousValue(heading), PreviousValue(speed), PreviousValue(pos);
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

method receiveCAM2(j: int, now: int, cams:seq<CAM>) returns (brake:bool)
requires |cams| > 2;
requires 0 < j < |cams|;
ensures (GetSpeed(j, now) > cams[j-1].speed && now - cams[j-1].time <= T_GenCamMax) ==> brake;
ensures (now - cams[j-1].time > T_GenCamMax && GetPosition(j-1,now) - GetPosition(j, now) < 10) ==> brake;
{
  brake := false;
  if(GetSpeed(j, now) > cams[j-1].speed && now - cams[j-1].time <= T_GenCamMax)
  {
      brake := true;
  }
  else if(now - cams[j-1].time > T_GenCamMax)
  {
    print("Out of date cam detected from preceding vehicle");
    if(GetPosition(j-1,now) - GetPosition(j, now) < 10)
    {
        brake := true;
    }
  }
}

/*function method StoppingDistance(j: int, now: int, speed: int, friction_coeff: float) : int
{
  // Assume g = 9.8
  ((speed * speed) / (2 * 9.8 * friction_coeff)) as int
}*/

const Deceleration : real := 4.5; // m/s

function method TimeToStop(j: int, now: int) : real
{
  GetSpeed(j, now) as real / Deceleration
}

function method InterpolateDistanceNow(j: int, now: int, c: CAM) : int
{
  Distance(c.position, GetPosition(j, now)) + c.speed * (now - c.time)
}
function method InterpolateDistanceEarly(j: int, now: int, c: CAM) : int
{
  Distance(c.position, GetPosition(j, now)) + GetSpeed(j, now) * -(now - c.time)
}

function method TimeToCollision(j: int, now: int, c: CAM) : real
  requires now > c.time
{
  var timediff := now - c.time;
  var dist_early := InterpolateDistanceEarly(j, now, c);
  var dist_now := InterpolateDistanceNow(j, now, c);

  (dist_now - dist_early) as real / timediff as real
}

method receiveCAM3(j: int, now: int, cams:seq<CAM>, TimeToStopFactor: real) returns (brake:bool)
requires forall i : int :: 0 <= i < |cams| ==> cams[i].time < now;
requires TimeToStopFactor >= 1.0;
ensures brake == exists i : int :: 0 <= i < |cams| && TimeToStop(j, now) * TimeToStopFactor <= TimeToCollision(j, now, cams[i]);
{
  var i := 0;

  brake := false;

  while (i < |cams|)
  decreases |cams| - i;
  invariant 0 <= i <= |cams|;
  invariant brake == exists k : int :: 0 <= k < i && TimeToStop(j, now) * TimeToStopFactor <= TimeToCollision(j, now, cams[k]);
  {
    brake := brake || TimeToStop(j, now) * TimeToStopFactor <= TimeToCollision(j, now, cams[i]);

    i := i + 1;
  }
}

method receiveCAM4(j: int, now: int, cams:seq<CAM>, TimeToStopFactor: real, HeadingVariance: int) returns (brake:bool) 
requires |cams|>0;
requires forall i : int :: 0 <= i < |cams| ==> cams[i].time < now;
requires TimeToStopFactor >= 1.0;
requires HeadingVariance >= 0;
ensures brake == exists k : int :: 0 <= k < |cams| && (abs(GetHeading(j, now) - cams[k].heading) <= HeadingVariance)
  && (now - cams[k].time <= T_GenCamMax || Distance(GetPosition(cams[k].id, now), GetPosition(j, now)) < 10)
  && TimeToStop(j, now) * TimeToStopFactor <= TimeToCollision(j, now, cams[k]);
{
  var i := 0;

  brake := false;

  while (i < |cams|)
  decreases |cams| - i;
  invariant 0 <= i <= |cams|;
  invariant  brake == exists k : int :: 0 <= k < i && (abs(GetHeading(j, now) - cams[k].heading) <= HeadingVariance) 
    && (now - cams[k].time <= T_GenCamMax || Distance(GetPosition(cams[k].id, now), GetPosition(j, now)) < 10) 
    && TimeToStop(j, now) * TimeToStopFactor <= TimeToCollision(j, now, cams[k]);
  {
    if(abs(GetHeading(j, now) - cams[i].heading) <= HeadingVariance)//if going in a similar direction
    {
      if(now - cams[i].time <= T_GenCamMax || //if the cam is recent enough
         Distance(GetPosition(cams[i].id, now), GetPosition(j, now)) < 10) //or if the cam is not recent enough then check the sensors
      {
        brake := brake || TimeToStop(j, now) * TimeToStopFactor <= TimeToCollision(j, now, cams[i]);
      }
    } 
    i := i + 1;
  }
}


//helper functions and methods are below

function method GetHeading(j: int, now: int):int
  ensures 0 <= GetHeading(j, now) <= 359

function method GetSpeed(j: int, now: int):int
  ensures 0 <= GetSpeed(j, now) <= 100

function method GetPosition(j: int, now: int):int
  ensures -100000 <= GetPosition(j, now) <= 100000

function method abs(x: int): int
{
   if x < 0 then -x else x
}

function method max(x: int, y: int): int
{
  if x < y then y else x
}

function method clamp(x: int, min: int, max: int): int
{
  if x < min then min else
  if x > max then max else x
}

function method Distance(posa: int, posb: int): int
{
  abs(posa-posb)
}

/*function method sqrt(x: real): real
  ensures sqrt(x*x) == x

function method Distance(posa: Coordinate, posb: Coordinate): real
{
  sqrt((posa.x - posb.x)*(posa.x - posb.x) +
  (posa.y - posb.y)*(posa.y - posb.y) +
  (posa.z - posb.z)*(posa.z - posb.z))
}
*/
