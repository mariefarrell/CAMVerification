//C = Confidentiality (Vehicles only receive messages intended for them)
//I = Integrity (The contents of the received message are the same as when it was sent)
//A = Availability (CAM messages are sent on time and arrive within some time bound)

//Cooperative Awareness Messages (CAM) generation for vehicle j.
//These are used to inform other vehicles of the current vehicle's state
//CAM messages are intended for all that receive them so proving Confidentiality is unnecessary


datatype CAM = CAM(id:int,seqno:int, time:int, heading:int, speed:int, position:int)
// Min and Max CAM generation times in ms
const T_GenCamMin := 100;
const T_GenCamMax := 1000;

const N_GenCamDefault := 3;
const N_GenCamMax := 3;

// Thresholds
const headingthreshold := 4;
const speedthreshold := 4;
const posthreshold := 0.5 as real;

const MaxTime := 5000; // How many ms to run simulation for

//Main method to get everything going
method Main()
{
  var carNo := 10;
  var T_CheckCamGen := 10; // Every 10ms
  var T_GenCam_DCC := 500; // Every 500ms, minimum time interval between two consecutive CAM generations 
  var c := 0;
  
  //for testing  
  var prev := new CAM [3];
  prev[0] := CAM(1,0,1,2,3,4);//for testing
  prev[1] := CAM(1,1,2,3,4,5);
  prev[2] := CAM(1,2,3,4,5,6);

  while(c<carNo)
  decreases carNo - c;
  {
     //var res := sendCAM(SleepInterval, TxInterval,c);
     c:= c+1;  
     //print res; 
  }
  
}

method sendCAM(T_CheckCamGen:int, T_GenCam_DCC:int, j:int) returns (msgs:seq<CAM>)
  requires 0 < T_CheckCamGen <= T_GenCamMin;
  requires T_GenCamMin <= T_GenCam_DCC <= T_GenCamMax;
  requires T_GenCam_DCC>0;

  //At least one CAM is sent for every TxInterval
  ensures |msgs|>=1; // at least one cam is sent
  ensures MaxTime/T_GenCam_DCC <= |msgs|;
  
{
  var T_GenCam := T_GenCamMax; // currently valid upper limit of the CAM generation interval
  var N_GenCam := N_GenCamDefault; 
  var trigger_two_count := 0;
  
  var LastBroadcast := 0;
  var LastBroadcastDiff := 0;
  var seqno := 0;
  var prevheading, prevspeed, prevpos;
  var now, heading, speed, pos := 0,0,0,0;
  
  
  msgs := [CAM(j,seqno,now,heading,speed,pos)]; // send an initial cam
  
  var headingold:bool, speedold:bool, posold: bool := false, false, false;
  
  var t := 0;
  assert |msgs| >=1;
  while(t < MaxTime)
  decreases MaxTime-t;
  invariant |msgs|>=1;
  invariant LastBroadcastDiff >= T_GenCam_DCC && (headingold || speedold || posold || (LastBroadcastDiff >= T_GenCam_DCC && |msgs|>=1 ))  ==> CAM(j,seqno,now,heading,speed,pos) in msgs;
  invariant t/T_GenCamMin >= 1 ==> |msgs| >= t/T_GenCamMin;
  invariant t/T_GenCamMax >= 1 ==> |msgs| >= t/T_GenCamMax;
  invariant trigger_two_count > 0 && LastBroadcastDiff >= T_GenCam_DCC && LastBroadcastDiff >= T_GenCam &&  t/T_GenCamMax >= 1 ==> |msgs| >= t/T_GenCamMax;
  invariant 0 <= N_GenCam <= N_GenCamMax;
  
  { 
    //Get the current time
    now := t;
    LastBroadcastDiff := now - LastBroadcast;
    
    //Get vehicle information
    heading := GetHeading();
    speed := GetSpeed();
    pos := GetPosition();
    
    //Check if this information has changed
    headingold := abs(heading - prevheading) >= headingthreshold;
    speedold := abs(speed - prevspeed) >= speedthreshold;
    posold := abs(pos - prevpos) >= posthreshold.Floor;
    
    //If any information has changed, or a CAM hasn't been sent recently, then send a CAM
    if(LastBroadcastDiff >= T_GenCam_DCC || (headingold || speedold || posold || LastBroadcastDiff >= T_GenCam)){
      seqno := (seqno + 1) % 256;
      msgs := msgs + [CAM(j,seqno,now,heading,speed,pos)];
      LastBroadcast := now;
      
      if ((headingold || speedold || posold)) { // Trigger 1
        T_GenCam := LastBroadcastDiff;
        trigger_two_count := 0; // Reset
      }
      else if (LastBroadcastDiff >= T_GenCam){ // Trigger 2
        trigger_two_count := trigger_two_count + 1;
        if (trigger_two_count == N_GenCam) {
          T_GenCam := T_GenCamMax;
          
       }
       
     }
     
      //Set current values as old values
      prevheading := heading;
      prevspeed := speed;
      prevpos := pos;
    }   
    t := t + T_CheckCamGen; // Sleep for a bit to advance time
 }
 return msgs;
}

method receiveCAM(fromid:int, cams:seq<CAM>) returns ()
requires 0 <= fromid < |cams|;
requires fromid == cams[fromid].id;  //To check that the vehicle the message claims it was sent from was actually sent from that vehicle.
{
  if(Sign(Magnitude(cams[fromid].heading)) == - Sign(Magnitude(GetHeading())))
  {
    //Ignore cars travelling in the opposite direction to us
  }
 var speeddiff := GetSpeed() - cams[fromid].speed;

 //Negative speeddiff indicates that we are getting closer to the vehicle ahead of us so we may need to brake
 if (speeddiff < 0){
     var deceleration := Brake(cams[fromid].speed);
     var newspeed := cams[fromid].speed - deceleration;
  }
 
}

//helper functions and methods are below

method Now() returns(n:int)
{
  //returns the current time
}

function method GetHeading() :int
{
  20
}

function method GetSpeed():int
{
  50
}

function method GetPosition():int
{
  10
}

function method abs(x: int): int
{
   if x < 0 then -x else x
}

function method Magnitude(heading:int):int{
  heading
}


method Sleep(period:int) returns ()
{
  
}

function method hasOverflowed(s1:int, s2:int): bool{
  s1>s2
}

function method Sign(x:int):int{
  if x < 0 then -1 else 1
}

method Brake(s:int)  returns (deceleration:int)
ensures 0<= deceleration <= 10; // 10 should be 9.81 but left it as 10 so that I could use ints for simplicity 
{ 
  deceleration := 8;
}