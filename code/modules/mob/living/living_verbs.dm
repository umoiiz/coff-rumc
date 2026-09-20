/mob/living/verb/resist()
	set name = "Resist"
	set category = "IC"

	do_resist()

///Handles trying to toggle resting state
/mob/living/proc/toggle_resting()
	if(incapacitated(TRUE))
		return

	if(!resting)
		if(HAS_TRAIT(src, TRAIT_MOVE_VENTCRAWLING))
			return FALSE
		set_resting(TRUE, FALSE)
		return
	if(do_actions)
		balloon_alert(src, "忙碌!")
		return
	get_up()

///Handles getting up, doing a basic check before relaying it to the actual proc that does it
/mob/living/proc/get_up()
	set_resting(FALSE, FALSE)

///Actually handles toggling the resting state
/mob/living/proc/set_resting(rest, silent = TRUE)
	if(status_flags & INCORPOREAL)
		return
	if(rest == resting)
		return
	. = resting
	resting = rest
	if(resting)
		ADD_TRAIT(src, TRAIT_FLOORED, RESTING_TRAIT)
		if(!silent)
			to_chat(src, span_notice("你现在正在休息."))
		SEND_SIGNAL(src, COMSIG_XENOMORPH_REST)
	else
		REMOVE_TRAIT(src, TRAIT_FLOORED, RESTING_TRAIT)
		if(!silent)
			to_chat(src, span_notice("你站起来了."))
		SEND_SIGNAL(src, COMSIG_XENOMORPH_UNREST)
	hud_used?.rest_icon?.update_icon()


/mob/living/verb/ghost()
	set category = "OOC.Ghost"
	set name = "Ghost"

	if(stat == DEAD)
		ghostize(TRUE)
		return

	if(!is_centcom_level(loc?.z) && tgui_alert(src, "你确定要幽灵化吗?\n(你还活着.如果你幽灵化,你将无法回到你的身体.你无法改变主意,所以请明智选择!)", "幽灵化", list("Yes", "No")) != "Yes")
		return

	set_resting(TRUE)
	log_game("[key_name(usr)] has ghosted at [AREACOORD(usr)].")
	message_admins("[ADMIN_TPMONTY(usr)] has ghosted.")
	ghostize(FALSE)

/mob/living/point_to(atom/pointed_atom as mob|obj|turf in view(client.view, src))
	if(!..())
		return FALSE
	if(incapacitated() || HAS_TRAIT(src, TRAIT_FAKEDEATH))
		return FALSE
	visible_message(span_infoplain("[span_name("[src]")]指向了[pointed_atom]."), span_notice("你指向了[pointed_atom]."))
