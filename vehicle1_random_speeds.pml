/* Simple 3 vehicle example with leader (who just sends),
 * vehicle, who receives from both leader and tail, and
 * tail, who just sends:  leader --> vehicle <-- tail */

/* Round robin:
   (clock%3)=0 -> leader; (clock%3)=1 -> vehicle; (clock%3)=2 -> tail */

int clock; 
int lspeed = 0;
int vspeed = 0;
int tspeed = 0;

init
{
  chan v1tov2 = [10] of { int };
  chan v3tov2 = [10] of { int };
  clock = 0; printf("Starting 0\n");
  run leader(0, v1tov2); run vehicle(1, v1tov2, v3tov2); run tail(2, v3tov2)
}  

proctype leader(int vnum; chan out)  /* leader vehicle */
{
   printf("leader: starting\n");
   int random_speed;

   L1: (clock%3) == vnum; /* wait for my turn */
       printf("leader: my turn\n");
       if
	  :: (clock > 100) -> goto FIN
       	  :: (clock <= 100) ->
	     	    out!(10);
		    atomic{lspeed=(10);
	     	    printf("leader: speed %d\n", (10));		    
    		    clock++;}
		    goto L1
       	  :: (clock <= 100) ->
	     	    out!(20);
		    atomic{lspeed=(20);
	     	    printf("leader: speed %d\n", (20));		    
    		    clock++;}
		    goto L1
       	  :: (clock <= 100) ->
	     	    out!(30);
		    atomic{lspeed=(30);
	     	    printf("leader: speed %d\n", (30));		    
    		    clock++;}
		    goto L1
       	  :: (clock <= 100) ->
	     	    out!(40);
		    atomic{lspeed=(40);
	     	    printf("leader: speed %d\n", (40));		    
    		    clock++;}
		    goto L1
       	  :: (clock <= 100) ->
	     	    out!(50);
		    atomic{lspeed=(50);
	     	    printf("leader: speed %d\n", (50));		    
    		    clock++;}
		    goto L1
       	  :: (clock <= 100) ->
	     	    out!(60);
		    atomic{lspeed=(60);
	     	    printf("leader: speed %d\n", (60));		    
    		    clock++;}
		    goto L1
       	  :: (clock <= 100) ->
	     	    out!(70);
		    atomic{lspeed=(70);
	     	    printf("leader: speed %d\n", (70));		    
    		    clock++;}
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
		       ->  l_in?lin1; atomic{printf("vehicle: received and adjust speed (%d)\n", lin1); vspeed=lin1/2}
	     	    :: ((len(l_in)==0) && (len(t_in)!=0))
		       ->  t_in?tin1; atomic{printf("vehicle: received and adjust speed (%d)\n", tin1); vspeed=tin1/2}
	      	    :: ((len(l_in)!=0) && (len(t_in)!=0))
		       ->  l_in?lin1; t_in?tin1; atomic{vspeed = (lin1 + tin1)/2;
		           printf("vehicle: received (%d,%d) and adjusted speed to %d\n", lin1, tin1, vspeed)}
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
	     	    out!(10);
		    atomic{tspeed=(10);
	     	    printf("tail: speed %d\n", (10));		    
    		    clock++;}
		    goto T1
       	  :: (clock <= 100) ->
	     	    out!(20);
		    atomic{tspeed=(20);
	     	    printf("tail: speed %d\n", (20));		    
    		    clock++;}
		    goto T1
       	  :: (clock <= 100) ->
	     	    out!(30);
		    atomic{tspeed=(30);
	     	    printf("tail: speed %d\n", (30));		    
    		    clock++;}
		    goto T1
       	  :: (clock <= 100) ->
	     	    out!(40);
		    atomic{tspeed=(40);
	     	    printf("tail: speed %d\n", (40));		    
    		    clock++;}
		    goto T1
       	  :: (clock <= 100) ->
	     	    out!(50);
		    atomic{tspeed=(50);
	     	    printf("tail: speed %d\n", (50));		    
    		    clock++;}
		    goto T1
       	  :: (clock <= 100) ->
	     	    out!(60);
		    atomic{tspeed=(60);
	     	    printf("tail: speed %d\n", (60));		    
    		    clock++;}
		    goto T1
       	  :: (clock <= 100) ->
	     	    out!(70);
		    atomic{tspeed=(70);
	     	    printf("tail: speed %d\n", (70));		    
    		    clock++;}
		    goto T1
	fi;
	FIN: clock++; printf("tail: finishing\n")
}



/* Original property: [](big_speed_difference => X ~ big_speed_difference)
   Never: <>(big_speed_difference & X big_speed_difference)
   */
never              /* <>(big_speed_difference & X big_speed_difference) */
      {
          T0:
                if
                :: (vspeed > (lspeed+51)) -> goto Bigdiff
		:: (vspeed < (lspeed-51)) -> goto Bigdiff
		:: (vspeed > (tspeed+51)) -> goto Bigdiff
		:: (vspeed < (tspeed-51)) -> goto Bigdiff
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
	Bigdiff:
                if
                :: (vspeed > (lspeed+51)) -> goto Bigdiff2
		:: (vspeed < (lspeed-51)) -> goto Bigdiff2
		:: (vspeed > (tspeed+51)) -> goto Bigdiff2
		:: (vspeed < (tspeed-51)) -> goto Bigdiff2
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
	Bigdiff2:
                if
                :: (vspeed > (lspeed+51)) -> goto Bigdiff3
		:: (vspeed < (lspeed-51)) -> goto Bigdiff3
		:: (vspeed > (tspeed+51)) -> goto Bigdiff3
		:: (vspeed < (tspeed-51)) -> goto Bigdiff3
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
	Bigdiff3:
                if
                :: (vspeed > (lspeed+51)) -> goto Bigdiff4
		:: (vspeed < (lspeed-51)) -> goto Bigdiff4
		:: (vspeed > (tspeed+51)) -> goto Bigdiff4
		:: (vspeed < (tspeed-51)) -> goto Bigdiff4
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
	Bigdiff4:
                if
                :: (vspeed > (lspeed+51)) -> goto Bigdiff5
		:: (vspeed < (lspeed-51)) -> goto Bigdiff5
		:: (vspeed > (tspeed+51)) -> goto Bigdiff5
		:: (vspeed < (tspeed-51)) -> goto Bigdiff5
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
	Bigdiff5:
                if
                :: (vspeed > (lspeed+51)) -> goto Bigdiff6
		:: (vspeed < (lspeed-51)) -> goto Bigdiff6
		:: (vspeed > (tspeed+51)) -> goto Bigdiff6
		:: (vspeed < (tspeed-51)) -> goto Bigdiff6
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
	Bigdiff6:
                if
                :: (vspeed > (lspeed+51)) -> goto Bigdiff7
		:: (vspeed < (lspeed-51)) -> goto Bigdiff7
		:: (vspeed > (tspeed+51)) -> goto Bigdiff7
		:: (vspeed < (tspeed-51)) -> goto Bigdiff7
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
	Bigdiff7:
                if
                :: (vspeed > (lspeed+51)) -> goto Bigdiff8
		:: (vspeed < (lspeed-51)) -> goto Bigdiff8
		:: (vspeed > (tspeed+51)) -> goto Bigdiff8
		:: (vspeed < (tspeed-51)) -> goto Bigdiff8
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
	Bigdiff8:
                if
                :: (vspeed > (lspeed+51)) -> goto Bigdiff9
		:: (vspeed < (lspeed-51)) -> goto Bigdiff9
		:: (vspeed > (tspeed+51)) -> goto Bigdiff9
		:: (vspeed < (tspeed-51)) -> goto Bigdiff9
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
	Bigdiff9:
                if
                :: (vspeed > (lspeed+51)) -> goto Bigdiff10
		:: (vspeed < (lspeed-51)) -> goto Bigdiff10
		:: (vspeed > (tspeed+51)) -> goto Bigdiff10
		:: (vspeed < (tspeed-51)) -> goto Bigdiff10
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
	Bigdiff10:
                if
                :: (vspeed > (lspeed+51)) -> goto Bigdiff11
		:: (vspeed < (lspeed-51)) -> goto Bigdiff11
		:: (vspeed > (tspeed+51)) -> goto Bigdiff11
		:: (vspeed < (tspeed-51)) -> goto Bigdiff11
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
	Bigdiff11:
                if
                :: (vspeed > (lspeed+51)) -> goto Bigdiff12
		:: (vspeed < (lspeed-51)) -> goto Bigdiff12
		:: (vspeed > (tspeed+51)) -> goto Bigdiff12
		:: (vspeed < (tspeed-51)) -> goto Bigdiff12
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
	Bigdiff12:
                if
                :: (vspeed > (lspeed+51)) -> goto accept
		:: (vspeed < (lspeed-51)) -> goto accept
		:: (vspeed > (tspeed+51)) -> goto accept
		:: (vspeed < (tspeed-51)) -> goto accept
		::  ((vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51)) && (vspeed <= (lspeed+51)) && (vspeed >= (lspeed-51))) -> goto T0
		fi;
          accept:
                skip
       }
