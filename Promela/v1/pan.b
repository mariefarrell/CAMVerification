	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* CLAIM never_0 */
;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		
	case 13: // STATE 26
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC :init: */

	case 14: // STATE 1
		;
		now.clock = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 16: // STATE 3
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 17: // STATE 4
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 18: // STATE 5
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 19: // STATE 6
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC tail */
;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		
	case 25: // STATE 7
		;
		_m = unsend(((P2 *)this)->out);
		;
		goto R999;

	case 26: // STATE 8
		;
		now.tspeed = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 28: // STATE 10
		;
		now.clock = trpt->bup.oval;
		;
		goto R999;

	case 29: // STATE 14
		;
		now.clock = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 31: // STATE 16
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC vehicle */

	case 32: // STATE 3
		;
		((P1 *)this)->tin1 = trpt->bup.ovals[1];
		((P1 *)this)->lin1 = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		
	case 40: // STATE 12
		;
		XX = 1;
		unrecv(((P1 *)this)->l_in, XX-1, 0, ((P1 *)this)->lin1, 1);
		((P1 *)this)->lin1 = trpt->bup.oval;
		;
		;
		goto R999;
;
		;
		
	case 42: // STATE 14
		;
		now.lspeed = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 44: // STATE 16
		;
		XX = 1;
		unrecv(((P1 *)this)->t_in, XX-1, 0, ((P1 *)this)->tin1, 1);
		((P1 *)this)->tin1 = trpt->bup.oval;
		;
		;
		goto R999;
;
		;
		
	case 46: // STATE 18
		;
		now.lspeed = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 48: // STATE 20
		;
		XX = 1;
		unrecv(((P1 *)this)->l_in, XX-1, 0, ((P1 *)this)->lin1, 1);
		((P1 *)this)->lin1 = trpt->bup.oval;
		;
		;
		goto R999;

	case 49: // STATE 21
		;
		XX = 1;
		unrecv(((P1 *)this)->t_in, XX-1, 0, ((P1 *)this)->tin1, 1);
		((P1 *)this)->tin1 = trpt->bup.oval;
		;
		;
		goto R999;

	case 50: // STATE 22
		;
		now.vspeed = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 52: // STATE 26
		;
		now.clock = trpt->bup.oval;
		;
		goto R999;

	case 53: // STATE 30
		;
		now.clock = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 55: // STATE 32
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC leader */
;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		
	case 61: // STATE 7
		;
		_m = unsend(((P0 *)this)->out);
		;
		goto R999;

	case 62: // STATE 8
		;
		now.lspeed = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 64: // STATE 10
		;
		now.clock = trpt->bup.oval;
		;
		goto R999;

	case 65: // STATE 14
		;
		now.clock = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 67: // STATE 16
		;
		p_restor(II);
		;
		;
		goto R999;
	}

