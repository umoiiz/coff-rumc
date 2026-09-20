/mob/living/proc/do_resist()
	if(next_move > world.time)
		return FALSE

	if(incapacitated(TRUE))
		to_chat(src, span_warning("以你现在的状态无法抵抗."))
		return FALSE

	changeNext_move(CLICK_CD_RESIST)

	SEND_SIGNAL(src, COMSIG_LIVING_DO_RESIST)
	return TRUE
