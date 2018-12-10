//C = Confidentiality (Vehicles only receive messages intended for them)
//I = Integrity (The contents of the received message are the same as when it was sent)
//A = Availability (CAM messages are sent on time and arrive within some time bound)

//Cooperative Awareness Messages (CAM) generation for vehicle j.
//These are used to inform other vehicles of the current vehicle's state
//CAM messages are intended for all that receive them so proving Confidentiality is unnecessary


datatype CAM = CAM(id:int,seqno:int, time:int, heading:int, speed:int, position:int)
//Main method to get everything going
method Main()
{
  var carNo := 10;
  var SleepInterval := 3;
  var TxInterval := 5;
  var c := 0;
  
  //for receive
  
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
method sendCAM(SleepInterval:int, TxInterval:int, j:int) returns (msgs:seq<CAM>)
  requires SleepInterval <= TxInterval;
  requires TxInterval > 0 && TxInterval <= 10;
  
  //One CAM is sent for every TxInterval
  ensures TxInterval >= 1 ==> |msgs| >= TxInterval; //This is the Availability property from CIA
{
  var LastBroadcast := 0;
  var seqno := 0;
  var prevheading, prevspeed, prevpos;
  var now, heading, speed, pos;
  
  var headingthreshold, speedthreshold := 4,4;
  var posthreshold := 0.5 as real;
  var i := 0;
  msgs := [];
  var headingchanged:bool, speedchanged:bool, poschanged: bool := false, false, false;
  
  while(i < 100)
  decreases 100 - i;
  // These invariants say that a CAM is sent if the change in a value is above some interval
  invariant  headingchanged || speedchanged || poschanged || (now - LastBroadcast >= TxInterval && |msgs| >0)  ==> CAM(j,seqno,now,heading,speed,pos) in msgs;
  invariant |msgs| >= i/TxInterval;
  {
    //Get the current time
    now := Now();
    
    //Get vehicle information
    heading := GetHeading();
    speed := GetSpeed();
    pos := GetPosition();
    
    //Check if this information has changed
    headingchanged := abs(heading - prevheading) >= headingthreshold;
    speedchanged := abs(speed - prevspeed)>=speedthreshold;
    poschanged := abs(pos - prevpos)>=posthreshold.Floor;
    //If any information has changed, or a CAM hasn't been sent recently, then send a CAM
    if(headingchanged||speedchanged||poschanged||(now - LastBroadcast >= TxInterval)){
      seqno := (seqno + 1) % 256; //seqno is an 8 bit integer
      msgs := msgs + [CAM(j,seqno,now,heading,speed,pos)];
      LastBroadcast := now;
      //Set current values as old values
      prevheading := heading;
      prevspeed := speed;
      prevpos := pos;
    }
    Sleep(SleepInterval);
    i := i + 1;
 }
 return msgs;
}

//idea: CAMS are uploaded to a sequence and their index matches their id 
method receiveCAM(fromid:int, cams:seq<CAM>) returns ()
requires 0 <= fromid < |cams|;
requires fromid == cams[fromid].id;  //To check that the vehicle the message claims it was sent from was actually sent from that vehicle.
{
  //var prev':= cams[fromid];
  //cams[fromid] := CAM(fromid,seqno,t, heading, speed, pos);

  //if(seqno <= prev'.seqno || hasOverflowed(seqno, prev'.seqno))
  //{ 
    //Skip previously received messages, don't expect this to happen. Needed to prevent replay attacks
  //}

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

method GetPosition() returns (p:int)
{
  
}

function method abs(x: int): int
{
   if x < 0 then -x else x
}


method Sleep(SleepInterval:int) returns ()
{}


function method hasOverflowed(s1:int, s2:int): bool{
  s1>s2
}

function method Sign(magnitude:int):int{
  magnitude
}

function method Magnitude(heading:int):int{
  heading
}

method Brake(s:int)  returns (deceleration:int)
ensures 0<= deceleration <= 10; // 10 should be 9.81 but left it as 10 so that I could use ints for simplicity 
{ 
  deceleration := 8;

}