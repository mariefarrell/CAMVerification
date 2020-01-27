/* Simple 3 vehicle example with leader (who just sends),
 * vehicle, who receives from both leader and tail, and
 * tail, who just sends:  leader --> vehicle <-- tail */

/* Round robin:
   (clock%3)=0 -> leader; (clock%3)=1 -> vehicle; (clock%3)=2 -> tail */

int clock; 
int lspeed = 0;
int vspeed = 0;
int tspeed = 0;

proctype leader(int vnum; chan out)  /* leader vehicle */
{
   printf("leader: starting\n"); 

   L1: (clock%3) == vnum; /* wait for my turn */
       printf("leader: my turn\n");
       if
	  :: (clock > 100) -> goto FIN
       	  :: (clock <= 100) ->
	     	    out!(clock%6);
		    lspeed=(clock%6);
	     	    printf("leader: speed %d\n", (clock%6));		    
    		    clock++;
		    goto L1
	fi;
	FIN: clock++; printf("leader: finishing\n")
}

proctype vehicle(int vnum; chan l_in, t_in)   /* vehicle */
{
   printf("vehicle: starting\n"); 
   int lin1, tin1;

   V1: (clock%3) == vnum; /* wait for my turn */
       printf("vehicle: my turn\n");
       /* if we receive no speeds, keep the same value;
          if we receive one speed, set our speed to that;
	  if we receive two speed messages, set our speed to average (rounded down)
	*/
       if
	  :: (clock > 100) -> goto FIN;
       	  :: (clock <= 100) ->
      	     	    if
	     	    :: ((len(l_in)==0) && (len(t_in)==0))
		       ->  printf("vehicle: no msgs\n")
	     	    :: ((len(l_in)!=0) && (len(t_in)==0)) 
		       ->  l_in?lin1; printf("vehicle: received and adjust speed (%d)\n", lin1); lspeed=lin1
	     	    :: ((len(l_in)==0) && (len(t_in)!=0))
		       ->  t_in?tin1; printf("vehicle: received and adjust speed (%d)\n", tin1); lspeed=tin1
	      	    :: ((len(l_in)!=0) && (len(t_in)!=0))
		       ->  l_in?lin1; t_in?tin1; vspeed = (lin1 + tin1)/2;
		           printf("vehicle: received (%d,%d) and adjusted speed to %d\n", lin1, tin1, vspeed)
                    fi;
       		    clock++; 
		    goto V1   		   
        fi;
   	FIN: /* vspeed = 300; */ clock++; printf("vehicle: finishing\n")
}

proctype tail(int vnum; chan out)  /* tail vehicle */
{
   printf("tail: starting\n"); 

   T1: (clock%3) == vnum; /* wait for my turn */
       printf("tail: my turn\n");
       if
	  :: (clock > 100) -> goto FIN;
       	  :: (clock <= 100) ->
	     	    out!(clock%6);
		    tspeed=(clock%6);
	     	    printf("tail: speed %d\n", (clock%6));		    
    		    clock++;
		    goto T1
	fi;
	FIN: clock++; printf("tail: finishing\n")
}

proctype attacker(chan l_in, t_in)   /* attackder */
{
   printf("attacker: starting\n"); 
   int lin1, tin1;
   bool head = 0;
   bool tl = 0;

   A:    (clock > 10); /* wait until under way */
	if
		:: (head == 0) -> printf("attacker: inserting vspeed of 100\n"); l_in!100; l_in!100; head = 1; goto A;
		:: (tl == 0) -> printf("attacker: inserting tspeed of 123\n"); t_in!123; t_in!123; tl = 1; goto A;
		:: (clock <= 100) -> goto A;
		:: (clock > 100) -> goto FIN;
   	fi;
   FIN:  printf("attacker: finishing\n")
}

init
{
  chan v1tov2 = [10] of { int };
  chan v3tov2 = [10] of { int };
  clock = 0; printf("Starting 0\n");
  run leader(0, v1tov2); run vehicle(1, v1tov2, v3tov2); run tail(2, v3tov2);
  run attacker(v1tov2, v3tov2)
}  

/* Original property: [](big_speed_difference => X ~ big_speed_difference)
   Never: <>(big_speed_difference & X big_speed_difference)
   */
never              /* <>(big_speed_difference & X big_speed_difference) */
      {
          T0:
                if
                :: (vspeed > (lspeed+5)) -> goto Bigdiff
		:: (vspeed < (lspeed-5)) -> goto Bigdiff
		:: (vspeed > (tspeed+5)) -> goto Bigdiff
		:: (vspeed < (tspeed-5)) -> goto Bigdiff
		::  ((vspeed <= (lspeed+5)) && (vspeed >= (lspeed-5)) && (vspeed <= (lspeed+5)) && (vspeed >= (lspeed-5))) -> goto T0
		fi;
	Bigdiff:
                if
                :: (vspeed > (lspeed+5)) -> goto accept
		:: (vspeed < (lspeed-5)) -> goto accept
		:: (vspeed > (tspeed+5)) -> goto accept
		:: (vspeed < (tspeed-5)) -> goto accept
		::  ((vspeed <= (lspeed+5)) && (vspeed >= (lspeed-5)) && (vspeed <= (lspeed+5)) && (vspeed >= (lspeed-5))) -> goto T0
		fi;
          accept:
                skip
       }
