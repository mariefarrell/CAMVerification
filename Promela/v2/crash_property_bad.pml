/* Simple 3 vehicle example with leader (who just sends),
 * vehicle, who receives from both leader and tail, and
 * tail, who just sends:  leader --> vehicle <-- tail */

/* Round robin:
   (clock%3)=0 -> leader; (clock%3)=1 -> vehicle; (clock%3)=2 -> tail */

int clock; 
int lspeed = 0;
int vspeed = 0;
int tspeed = 0;
int vpos = 10;
int tpos = 25;

init
{
  chan v1tov2 = [10] of { int };
  chan v3tov2 = [10] of { int };
  chan v1tov3 = [10] of { int };
  clock = 0; printf("Starting 0\n");
  run leader(0, v1tov2, v1tov3); run vehicle(1, v1tov2, v3tov2); run tail(2, v1tov3, v3tov2)
  run attacker(v1tov2, v3tov2);
}  

proctype leader(int vnum; chan out1, out2)  /* leader vehicle */
{
   printf("leader: starting\n");
   int random_speed;

   L1: (clock%3) == vnum; /* wait for my turn */
       printf("leader: my turn\n");
       if
	  :: (clock > 100) -> goto FIN
       	  :: (clock <= 100) ->
	     	    out1!(1);
		    out2!(1);
		    atomic{lspeed=(1);
	     	    printf("leader: speed %d\n", (1));		    
		    clock++; vpos = vpos + (lspeed - vspeed); tpos = tpos + (lspeed - tspeed); printf("vehicles positions: %d %d\n", vpos, tpos)}
		    goto L1
/*       	  :: (clock <= 100) ->
	     	    out1!(2);
		    out2!(2);
		    atomic{lspeed=(2);
	     	    printf("leader: speed %d\n", (2));		    
		    clock++; vpos = vpos + (lspeed - vspeed); tpos = tpos + (lspeed - tspeed); printf("vehicles positions: %d %d\n", vpos, tpos)}
		    goto L1 */
       	  :: (clock <= 100) ->
	     	    out1!(3);
		    out2!(3);
		    atomic{lspeed=(3);
	     	    printf("leader: speed %d\n", (3));		    
		    clock++; vpos = vpos + (lspeed - vspeed); tpos = tpos + (lspeed - tspeed); printf("vehicles positions: %d %d\n", vpos, tpos)}
		    goto L1
/*       	  :: (clock <= 100) ->
	     	    out1!(4);
		    out2!(4);
		    atomic{lspeed=(4);
	     	    printf("leader: speed %d\n", (4));		    
		    clock++; vpos = vpos + (lspeed - vspeed); tpos = tpos + (lspeed - tspeed); printf("vehicles positions: %d %d\n", vpos, tpos)}
		    goto L1 */
       	  :: (clock <= 100) ->
	     	    out1!(5);
		    out2!(5);
		    atomic{lspeed=(5);
	     	    printf("leader: speed %d\n", (5));		    
		    clock++; vpos = vpos + (lspeed - vspeed); tpos = tpos + (lspeed - tspeed); printf("vehicles positions: %d %d\n", vpos, tpos)}
		    goto L1
	fi;
	FIN: clock++; printf("leader: finishing\n")
}

proctype vehicle(int vnum; chan l_in, t_in)   /* vehicle */
{
   printf("vehicle: starting\n"); 
   int lin1, tin1;
   int pos;

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
		       ->  l_in?lin1; atomic{printf("vehicle: received and adjust speed (%d)\n", lin1); vspeed=lin1/2}
	     	    :: ((len(l_in)==0) && (len(t_in)!=0))
		       ->  t_in?tin1; atomic{printf("vehicle: received and adjust speed (%d)\n", tin1); vspeed=tin1/2}
	      	    :: ((len(l_in)!=0) && (len(t_in)!=0))
		       ->  l_in?lin1; t_in?tin1; atomic{vspeed = (lin1 + tin1)/2;
		           printf("vehicle: received (%d,%d) and adjusted speed to %d\n", lin1, tin1, vspeed)}
                    fi;
       		    atomic{clock++; vpos = vpos + (lspeed - vspeed); tpos = tpos + (lspeed - tspeed); printf("vehicles positions: %d %d\n", vpos, tpos)}
		    goto V1   		   
        fi;
   	FIN: clock++; printf("vehicle: finishing\n")
}

proctype tail(int vnum; chan l_in, out)  /* tail vehicle adopts lead vehicle speed */
{
   printf("tail: starting\n");
   int lin1;

   T1: (clock%3) == vnum; /* wait for my turn */
       printf("tail: my turn\n");
       if
	  :: (clock > 100) -> goto FIN;
       	  :: (clock <= 100) ->
	     if
	     :: ((len(l_in) == 0))
	     	-> printf("tail vehicle: no msgs\n")
	     :: ((len(l_in) != 0))
	        ->l_in?lin1; atomic{tspeed = lin1; printf("tail: recieved %d and adjusted speed to %d\n", lin1, lin1)}; out!lin1;
	     fi;
	     atomic{clock++; vpos = vpos + (lspeed - vspeed); tpos = tpos + (lspeed - tspeed); printf("vehicles positions: %d %d\n", vpos, tpos)}
	     goto T1
	fi;
	FIN: clock++; printf("tail: finishing\n")
}

proctype attacker(chan l_in, t_in)   /* attacker */
{
   printf("attacker: starting\n"); 
   int lin1, tin1;
   bool head = 0;
   bool tl = 0;

   A:    (clock > 10); /* wait until under way */
        if
                :: (head == 0 && len(l_in) != 0) -> atomic{ printf("attacker: inserting vspeed of 1\n"); l_in?lin1; l_in!1; head = 1;} goto A;
                :: (head == 0 && len(l_in) != 0) -> atomic{ printf("attacker: inserting vspeed of 5\n"); l_in?lin1; l_in!5; head = 1;} goto A;
                :: (tl == 0 && len(t_in) != 0) -> atomic{ printf("attacker: inserting tspeed of 1\n"); t_in?tin1; t_in!1; tl = 1;} goto A;
                :: (tl == 0 && len(t_in) != 0) -> atomic{ printf("attacker: inserting tspeed of 5\n"); t_in?tin1; t_in!5; tl = 1;} goto A;
                :: (clock <= 100) -> goto A;
                :: (clock > 100) -> goto FIN;
        fi;
   FIN:  printf("attacker: finishing\n")
}



/* Original property: [] ~(lpos = vpos) /\ []~(vpos = tpos)
   */
never            
      {
	  T1:
		if
		:: (vpos == 0) -> goto accept
		:: (vpos == tpos) -> goto accept
		:: (vpos != 0 && vpos != tpos) -> goto T1
		fi;
          accept:
                skip
       }
