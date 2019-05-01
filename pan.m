#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* CLAIM never_0 */
	case 3: // STATE 1 - vehicle1.pml:95 - [((vspeed>(lspeed+5)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][1] = 1;
		if (!((now.vspeed>(now.lspeed+5))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 3 - vehicle1.pml:96 - [((vspeed<(lspeed-5)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported3 = 0;
			if (verbose && !reported3)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported3 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported3 = 0;
			if (verbose && !reported3)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported3 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][3] = 1;
		if (!((now.vspeed<(now.lspeed-5))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 5 - vehicle1.pml:97 - [((vspeed>(tspeed+5)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported5 = 0;
			if (verbose && !reported5)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported5 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported5 = 0;
			if (verbose && !reported5)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported5 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][5] = 1;
		if (!((now.vspeed>(now.tspeed+5))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 7 - vehicle1.pml:98 - [((vspeed<(tspeed-5)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported7 = 0;
			if (verbose && !reported7)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported7 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported7 = 0;
			if (verbose && !reported7)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported7 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][7] = 1;
		if (!((now.vspeed<(now.tspeed-5))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 9 - vehicle1.pml:99 - [(((((vspeed<=(lspeed+5))&&(vspeed>=(lspeed-5)))&&(vspeed<=(lspeed+5)))&&(vspeed>=(lspeed-5))))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported9 = 0;
			if (verbose && !reported9)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported9 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported9 = 0;
			if (verbose && !reported9)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported9 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][9] = 1;
		if (!(((((now.vspeed<=(now.lspeed+5))&&(now.vspeed>=(now.lspeed-5)))&&(now.vspeed<=(now.lspeed+5)))&&(now.vspeed>=(now.lspeed-5)))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 13 - vehicle1.pml:103 - [((vspeed>(lspeed+5)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported13 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported13 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][13] = 1;
		if (!((now.vspeed>(now.lspeed+5))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 15 - vehicle1.pml:104 - [((vspeed<(lspeed-5)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported15 = 0;
			if (verbose && !reported15)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported15 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported15 = 0;
			if (verbose && !reported15)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported15 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][15] = 1;
		if (!((now.vspeed<(now.lspeed-5))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 17 - vehicle1.pml:105 - [((vspeed>(tspeed+5)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported17 = 0;
			if (verbose && !reported17)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported17 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported17 = 0;
			if (verbose && !reported17)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported17 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][17] = 1;
		if (!((now.vspeed>(now.tspeed+5))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 19 - vehicle1.pml:106 - [((vspeed<(tspeed-5)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported19 = 0;
			if (verbose && !reported19)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported19 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported19 = 0;
			if (verbose && !reported19)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported19 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][19] = 1;
		if (!((now.vspeed<(now.tspeed-5))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 21 - vehicle1.pml:107 - [(((((vspeed<=(lspeed+5))&&(vspeed>=(lspeed-5)))&&(vspeed<=(lspeed+5)))&&(vspeed>=(lspeed-5))))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported21 = 0;
			if (verbose && !reported21)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported21 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported21 = 0;
			if (verbose && !reported21)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported21 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][21] = 1;
		if (!(((((now.vspeed<=(now.lspeed+5))&&(now.vspeed>=(now.lspeed-5)))&&(now.vspeed<=(now.lspeed+5)))&&(now.vspeed>=(now.lspeed-5)))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 26 - vehicle1.pml:111 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported26 = 0;
			if (verbose && !reported26)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported26 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported26 = 0;
			if (verbose && !reported26)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported26 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][26] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 14: // STATE 1 - vehicle1.pml:82 - [clock = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[3][1] = 1;
		(trpt+1)->bup.oval = now.clock;
		now.clock = 0;
#ifdef VAR_RANGES
		logval("clock", now.clock);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 2 - vehicle1.pml:82 - [printf('Starting 0\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[3][2] = 1;
		Printf("Starting 0\n");
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 3 - vehicle1.pml:85 - [(run leader(0,v1tov2))] (0:0:0 - 1)
		IfNotBlocked
		reached[3][3] = 1;
		if (!(addproc(II, 1, 0, 0, ((P3 *)this)->v1tov2, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 4 - vehicle1.pml:85 - [(run vehicle(1,v1tov2,v3tov2))] (0:0:0 - 1)
		IfNotBlocked
		reached[3][4] = 1;
		if (!(addproc(II, 1, 1, 1, ((P3 *)this)->v1tov2, ((P3 *)this)->v3tov2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 5 - vehicle1.pml:85 - [(run tail(2,v3tov2))] (0:0:0 - 1)
		IfNotBlocked
		reached[3][5] = 1;
		if (!(addproc(II, 1, 2, 2, ((P3 *)this)->v3tov2, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 19: // STATE 6 - vehicle1.pml:86 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[3][6] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC tail */
	case 20: // STATE 1 - vehicle1.pml:64 - [printf('tail: starting\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[2][1] = 1;
		Printf("tail: starting\n");
		_m = 3; goto P999; /* 0 */
	case 21: // STATE 2 - vehicle1.pml:66 - [(((clock%3)==vnum))] (0:0:0 - 3)
		IfNotBlocked
		reached[2][2] = 1;
		if (!(((now.clock%3)==((P2 *)this)->vnum)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 22: // STATE 3 - vehicle1.pml:67 - [printf('tail: my turn\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[2][3] = 1;
		Printf("tail: my turn\n");
		_m = 3; goto P999; /* 0 */
	case 23: // STATE 4 - vehicle1.pml:69 - [((clock>100))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][4] = 1;
		if (!((now.clock>100)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 24: // STATE 6 - vehicle1.pml:70 - [((clock<=100))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][6] = 1;
		if (!((now.clock<=100)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 25: // STATE 7 - vehicle1.pml:71 - [out!(clock%5)] (0:0:0 - 1)
		IfNotBlocked
		reached[2][7] = 1;
		if (q_full(((P2 *)this)->out))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P2 *)this)->out);
		sprintf(simtmp, "%d", (now.clock%5)); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P2 *)this)->out, 0, (now.clock%5), 1);
		_m = 2; goto P999; /* 0 */
	case 26: // STATE 8 - vehicle1.pml:72 - [tspeed = (clock%5)] (0:0:1 - 1)
		IfNotBlocked
		reached[2][8] = 1;
		(trpt+1)->bup.oval = now.tspeed;
		now.tspeed = (now.clock%5);
#ifdef VAR_RANGES
		logval("tspeed", now.tspeed);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 27: // STATE 9 - vehicle1.pml:73 - [printf('tail: speed %d\\n',(clock%5))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][9] = 1;
		Printf("tail: speed %d\n", (now.clock%5));
		_m = 3; goto P999; /* 0 */
	case 28: // STATE 10 - vehicle1.pml:74 - [clock = (clock+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[2][10] = 1;
		(trpt+1)->bup.oval = now.clock;
		now.clock = (now.clock+1);
#ifdef VAR_RANGES
		logval("clock", now.clock);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 29: // STATE 14 - vehicle1.pml:77 - [clock = (clock+1)] (0:0:1 - 3)
		IfNotBlocked
		reached[2][14] = 1;
		(trpt+1)->bup.oval = now.clock;
		now.clock = (now.clock+1);
#ifdef VAR_RANGES
		logval("clock", now.clock);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 30: // STATE 15 - vehicle1.pml:77 - [printf('tail: finishing\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[2][15] = 1;
		Printf("tail: finishing\n");
		_m = 3; goto P999; /* 0 */
	case 31: // STATE 16 - vehicle1.pml:78 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[2][16] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC vehicle */
	case 32: // STATE 1 - vehicle1.pml:33 - [printf('vehicle: starting\\n')] (0:4:2 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		Printf("vehicle: starting\n");
		/* merge: lin1 = 0(4, 2, 4) */
		reached[1][2] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((P1 *)this)->lin1;
		((P1 *)this)->lin1 = 0;
#ifdef VAR_RANGES
		logval("vehicle:lin1", ((P1 *)this)->lin1);
#endif
		;
		/* merge: tin1 = 0(4, 3, 4) */
		reached[1][3] = 1;
		(trpt+1)->bup.ovals[1] = ((P1 *)this)->tin1;
		((P1 *)this)->tin1 = 0;
#ifdef VAR_RANGES
		logval("vehicle:tin1", ((P1 *)this)->tin1);
#endif
		;
		_m = 3; goto P999; /* 2 */
	case 33: // STATE 4 - vehicle1.pml:36 - [(((clock%3)==vnum))] (0:0:0 - 3)
		IfNotBlocked
		reached[1][4] = 1;
		if (!(((now.clock%3)==((P1 *)this)->vnum)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 34: // STATE 5 - vehicle1.pml:37 - [printf('vehicle: my turn\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[1][5] = 1;
		Printf("vehicle: my turn\n");
		_m = 3; goto P999; /* 0 */
	case 35: // STATE 6 - vehicle1.pml:43 - [((clock>100))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][6] = 1;
		if (!((now.clock>100)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 36: // STATE 8 - vehicle1.pml:44 - [((clock<=100))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][8] = 1;
		if (!((now.clock<=100)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 37: // STATE 9 - vehicle1.pml:46 - [(((len(l_in)==0)&&(len(t_in)==0)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][9] = 1;
		if (!(((q_len(((P1 *)this)->l_in)==0)&&(q_len(((P1 *)this)->t_in)==0))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 38: // STATE 10 - vehicle1.pml:47 - [printf('vehicle: no msgs\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[1][10] = 1;
		Printf("vehicle: no msgs\n");
		_m = 3; goto P999; /* 0 */
	case 39: // STATE 11 - vehicle1.pml:48 - [(((len(l_in)!=0)&&(len(t_in)==0)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][11] = 1;
		if (!(((q_len(((P1 *)this)->l_in)!=0)&&(q_len(((P1 *)this)->t_in)==0))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 40: // STATE 12 - vehicle1.pml:49 - [l_in?lin1] (0:0:1 - 1)
		reached[1][12] = 1;
		if (q_len(((P1 *)this)->l_in) == 0) continue;

		XX=1;
		(trpt+1)->bup.oval = ((P1 *)this)->lin1;
		;
		((P1 *)this)->lin1 = qrecv(((P1 *)this)->l_in, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("vehicle:lin1", ((P1 *)this)->lin1);
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)this)->l_in);
		sprintf(simtmp, "%d", ((P1 *)this)->lin1); strcat(simvals, simtmp);		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 41: // STATE 13 - vehicle1.pml:49 - [printf('vehicle: received and adjust speed (%d)\\n',lin1)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][13] = 1;
		Printf("vehicle: received and adjust speed (%d)\n", ((P1 *)this)->lin1);
		_m = 3; goto P999; /* 0 */
	case 42: // STATE 14 - vehicle1.pml:49 - [lspeed = lin1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][14] = 1;
		(trpt+1)->bup.oval = now.lspeed;
		now.lspeed = ((P1 *)this)->lin1;
#ifdef VAR_RANGES
		logval("lspeed", now.lspeed);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 43: // STATE 15 - vehicle1.pml:50 - [(((len(l_in)==0)&&(len(t_in)!=0)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][15] = 1;
		if (!(((q_len(((P1 *)this)->l_in)==0)&&(q_len(((P1 *)this)->t_in)!=0))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 44: // STATE 16 - vehicle1.pml:51 - [t_in?tin1] (0:0:1 - 1)
		reached[1][16] = 1;
		if (q_len(((P1 *)this)->t_in) == 0) continue;

		XX=1;
		(trpt+1)->bup.oval = ((P1 *)this)->tin1;
		;
		((P1 *)this)->tin1 = qrecv(((P1 *)this)->t_in, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("vehicle:tin1", ((P1 *)this)->tin1);
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)this)->t_in);
		sprintf(simtmp, "%d", ((P1 *)this)->tin1); strcat(simvals, simtmp);		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 45: // STATE 17 - vehicle1.pml:51 - [printf('vehicle: received and adjust speed (%d)\\n',tin1)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][17] = 1;
		Printf("vehicle: received and adjust speed (%d)\n", ((P1 *)this)->tin1);
		_m = 3; goto P999; /* 0 */
	case 46: // STATE 18 - vehicle1.pml:51 - [lspeed = tin1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][18] = 1;
		(trpt+1)->bup.oval = now.lspeed;
		now.lspeed = ((P1 *)this)->tin1;
#ifdef VAR_RANGES
		logval("lspeed", now.lspeed);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 47: // STATE 19 - vehicle1.pml:52 - [(((len(l_in)!=0)&&(len(t_in)!=0)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][19] = 1;
		if (!(((q_len(((P1 *)this)->l_in)!=0)&&(q_len(((P1 *)this)->t_in)!=0))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 48: // STATE 20 - vehicle1.pml:53 - [l_in?lin1] (0:0:1 - 1)
		reached[1][20] = 1;
		if (q_len(((P1 *)this)->l_in) == 0) continue;

		XX=1;
		(trpt+1)->bup.oval = ((P1 *)this)->lin1;
		;
		((P1 *)this)->lin1 = qrecv(((P1 *)this)->l_in, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("vehicle:lin1", ((P1 *)this)->lin1);
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)this)->l_in);
		sprintf(simtmp, "%d", ((P1 *)this)->lin1); strcat(simvals, simtmp);		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 49: // STATE 21 - vehicle1.pml:53 - [t_in?tin1] (0:0:1 - 1)
		reached[1][21] = 1;
		if (q_len(((P1 *)this)->t_in) == 0) continue;

		XX=1;
		(trpt+1)->bup.oval = ((P1 *)this)->tin1;
		;
		((P1 *)this)->tin1 = qrecv(((P1 *)this)->t_in, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("vehicle:tin1", ((P1 *)this)->tin1);
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)this)->t_in);
		sprintf(simtmp, "%d", ((P1 *)this)->tin1); strcat(simvals, simtmp);		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 50: // STATE 22 - vehicle1.pml:53 - [vspeed = ((lin1+tin1)/2)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][22] = 1;
		(trpt+1)->bup.oval = now.vspeed;
		now.vspeed = ((((P1 *)this)->lin1+((P1 *)this)->tin1)/2);
#ifdef VAR_RANGES
		logval("vspeed", now.vspeed);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 51: // STATE 23 - vehicle1.pml:54 - [printf('vehicle: received (%d,%d) and adjusted speed to %d\\n',lin1,tin1,vspeed)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][23] = 1;
		Printf("vehicle: received (%d,%d) and adjusted speed to %d\n", ((P1 *)this)->lin1, ((P1 *)this)->tin1, now.vspeed);
		_m = 3; goto P999; /* 0 */
	case 52: // STATE 26 - vehicle1.pml:56 - [clock = (clock+1)] (0:0:1 - 5)
		IfNotBlocked
		reached[1][26] = 1;
		(trpt+1)->bup.oval = now.clock;
		now.clock = (now.clock+1);
#ifdef VAR_RANGES
		logval("clock", now.clock);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 53: // STATE 30 - vehicle1.pml:59 - [clock = (clock+1)] (0:0:1 - 3)
		IfNotBlocked
		reached[1][30] = 1;
		(trpt+1)->bup.oval = now.clock;
		now.clock = (now.clock+1);
#ifdef VAR_RANGES
		logval("clock", now.clock);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 54: // STATE 31 - vehicle1.pml:59 - [printf('vehicle: finishing\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[1][31] = 1;
		Printf("vehicle: finishing\n");
		_m = 3; goto P999; /* 0 */
	case 55: // STATE 32 - vehicle1.pml:60 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][32] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC leader */
	case 56: // STATE 1 - vehicle1.pml:15 - [printf('leader: starting\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		Printf("leader: starting\n");
		_m = 3; goto P999; /* 0 */
	case 57: // STATE 2 - vehicle1.pml:17 - [(((clock%3)==vnum))] (0:0:0 - 3)
		IfNotBlocked
		reached[0][2] = 1;
		if (!(((now.clock%3)==((P0 *)this)->vnum)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 58: // STATE 3 - vehicle1.pml:18 - [printf('leader: my turn\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		Printf("leader: my turn\n");
		_m = 3; goto P999; /* 0 */
	case 59: // STATE 4 - vehicle1.pml:20 - [((clock>100))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		if (!((now.clock>100)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 60: // STATE 6 - vehicle1.pml:21 - [((clock<=100))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		if (!((now.clock<=100)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 61: // STATE 7 - vehicle1.pml:22 - [out!(clock%5)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][7] = 1;
		if (q_full(((P0 *)this)->out))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P0 *)this)->out);
		sprintf(simtmp, "%d", (now.clock%5)); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P0 *)this)->out, 0, (now.clock%5), 1);
		_m = 2; goto P999; /* 0 */
	case 62: // STATE 8 - vehicle1.pml:23 - [lspeed = (clock%5)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][8] = 1;
		(trpt+1)->bup.oval = now.lspeed;
		now.lspeed = (now.clock%5);
#ifdef VAR_RANGES
		logval("lspeed", now.lspeed);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 63: // STATE 9 - vehicle1.pml:24 - [printf('leader: speed %d\\n',(clock%5))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][9] = 1;
		Printf("leader: speed %d\n", (now.clock%5));
		_m = 3; goto P999; /* 0 */
	case 64: // STATE 10 - vehicle1.pml:25 - [clock = (clock+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][10] = 1;
		(trpt+1)->bup.oval = now.clock;
		now.clock = (now.clock+1);
#ifdef VAR_RANGES
		logval("clock", now.clock);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 65: // STATE 14 - vehicle1.pml:28 - [clock = (clock+1)] (0:0:1 - 3)
		IfNotBlocked
		reached[0][14] = 1;
		(trpt+1)->bup.oval = now.clock;
		now.clock = (now.clock+1);
#ifdef VAR_RANGES
		logval("clock", now.clock);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 66: // STATE 15 - vehicle1.pml:28 - [printf('leader: finishing\\n')] (0:0:0 - 1)
		IfNotBlocked
		reached[0][15] = 1;
		Printf("leader: finishing\n");
		_m = 3; goto P999; /* 0 */
	case 67: // STATE 16 - vehicle1.pml:29 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][16] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

