/obj/item/assembly/mousetrap
	name = "捕鼠夹"
	desc = "一个方便的小型弹簧陷阱, 用于捕捉有害啮齿动物."
	icon_state = "mousetrap"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/janitor_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/janitor_right.dmi',
	)
	worn_icon_state = "mousetrap"
	attachable = TRUE
	var/armed = FALSE

/obj/item/assembly/mousetrap/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_cross),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/item/assembly/mousetrap/examine(mob/user)
	. = ..()
	. += span_notice("压力板为[armed ? "primed" : "safe"].")


/obj/item/assembly/mousetrap/activate()
	. = ..()
	if(.)
		armed = !armed
		update_icon()
		playsound(src, 'sound/weapons/handcuffs.ogg', 30, TRUE, -3)


/obj/item/assembly/mousetrap/update_icon_state()
	. = ..()
	if(armed)
		icon_state = "mousetraparmed"
	else
		icon_state = "mousetrap"
	holder?.update_icon()


/obj/item/assembly/mousetrap/proc/triggered(mob/target, type = "feet")
	if(!armed)
		return
	var/datum/limb/affecting = null
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		switch(type)
			if("feet")
				if(!H.shoes)
					affecting = H.get_limb(pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
					H.Paralyze(6 SECONDS)
			if(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND)
				if(!H.gloves)
					affecting = H.get_limb(type)
					H.Stun(6 SECONDS)
		affecting?.take_damage_limb(1, 0)
	else if(ismouse(target))
		var/mob/living/simple_animal/mouse/M = target
		visible_message(span_boldannounce("啪!"))
		M.death()
	playsound(src, 'sound/effects/snap.ogg', 50, TRUE)
	armed = FALSE
	update_icon()
	pulse(FALSE)


/obj/item/assembly/mousetrap/attack_self(mob/living/carbon/human/user)
	if(!armed)
		to_chat(user, span_notice("你布设了[src]."))
	else
		to_chat(user, span_notice("你解除了[src]."))
	armed = !armed
	update_icon()
	playsound(src, 'sound/weapons/handcuffs.ogg', 30, TRUE, -3)
	user.record_traps_created()

/obj/item/assembly/mousetrap/proc/on_cross(atom/movable/AM)
	SIGNAL_HANDLER
	if(!armed)
		return
	if(ishuman(AM))
		var/mob/living/carbon/H = AM
		if(H.m_intent == MOVE_INTENT_RUN)
			INVOKE_ASYNC(src, PROC_REF(triggered), H)
			H.visible_message(span_warning("[H]不小心踩到了[src]."), \
							span_warning("你不小心踩到了[src]"))
	else if(ismouse(AM))
		INVOKE_ASYNC(src, PROC_REF(triggered), AM)
	else if(AM.density) // For mousetrap grenades, set off by anything heavy
		INVOKE_ASYNC(src, PROC_REF(triggered), AM)


/obj/item/assembly/mousetrap/on_found(mob/finder)
	if(armed)
		if(finder)
			finder.visible_message(span_warning("[finder]不小心触发了[src], 打断了[finder.p_their()]根手指."), \
								span_warning("你不小心触发了[src]!"))
			triggered(finder, pick(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND))
			return TRUE	//end the search!
		else
			visible_message(span_warning("[src]啪地合上了!"))
			triggered(loc)
			return FALSE
	return FALSE


/obj/item/assembly/mousetrap/hitby(atom/movable/AM, speed = 5)
	if(!armed)
		return ..()
	visible_message(span_warning("[src]被[AM]触发."))
	triggered(null)


/obj/item/assembly/mousetrap/armed
	icon_state = "mousetraparmed"
	armed = TRUE
