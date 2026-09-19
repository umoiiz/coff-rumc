/// For all of the items that are really just the user's hand used in different ways, mostly (all, really) from emotes
/obj/item/hand_item
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "offhand"
	force = 0
	throwforce = 0
	item_flags = DELONDROP|ITEM_ABSTRACT|HAND_ITEM

/obj/item/hand_item/circlegame
	name = "圈起的手"
	desc = "如果有人在你腰部以下看这个,你就可以敲他们."
	icon_state = "madeyoulook"
	attack_verb = list("bops")

/obj/item/hand_item/circlegame/Initialize(mapload)
	. = ..()
	var/mob/living/owner = loc
	if(!istype(owner))
		return
	RegisterSignal(owner, COMSIG_ATOM_EXAMINE, PROC_REF(owner_examined))

/obj/item/hand_item/circlegame/Destroy()
	var/mob/owner = loc
	if(istype(owner))
		UnregisterSignal(owner, COMSIG_ATOM_EXAMINE)
	return ..()

/obj/item/hand_item/circlegame/dropped(mob/user)
	UnregisterSignal(user, COMSIG_ATOM_EXAMINE) //loc will have changed by the time this is called, so Destroy() can't catch it
	// this is a dropdel item.
	return ..()

/// Stage 1: The mistake is made
/obj/item/hand_item/circlegame/proc/owner_examined(mob/living/owner, mob/living/sucker)
	SIGNAL_HANDLER

	if(!istype(sucker) || !in_range(owner, sucker))
		return
	addtimer(CALLBACK(src, PROC_REF(wait_a_second), owner, sucker), 0.4 SECONDS)

/// Stage 2: Fear sets in
/obj/item/hand_item/circlegame/proc/wait_a_second(mob/living/owner, mob/living/sucker)
	if(QDELETED(sucker) || QDELETED(src) || QDELETED(owner))
		return

	if(owner == sucker) // big mood
		to_chat(owner, span_danger("等一下...你刚刚看了你自己的[src.name]!"))
		addtimer(CALLBACK(src, PROC_REF(self_gottem), owner), 1 SECONDS)
	else
		to_chat(sucker, span_danger("等一下...那是-"))
		addtimer(CALLBACK(src, PROC_REF(gottem), owner, sucker), 0.6 SECONDS)

/// Stage 3A: We face our own failures
/obj/item/hand_item/circlegame/proc/self_gottem(mob/living/owner)
	if(QDELETED(src) || QDELETED(owner))
		return

	playsound(get_turf(owner), 'sound/effects/hit_punch.ogg', 50, TRUE)
	owner.visible_message(span_danger("[owner]羞愧地用[owner.p_their()][name]敲了[owner.p_them()]自己."), span_userdanger("你羞愧地用自己的[name]敲了自己."), \
		span_hear("你听到一声闷响!"))
	log_combat(owner, owner, "bopped", name, "(self)")
	owner.do_attack_animation(owner, used_item = src)
	owner.apply_damage(100, STAMINA)
	owner.Knockdown(1 SECONDS)
	qdel(src)

/// Stage 3B: We face our reckoning (unless we moved away or they're incapacitated)
/obj/item/hand_item/circlegame/proc/gottem(mob/living/owner, mob/living/sucker)
	if(QDELETED(sucker))
		return

	if(QDELETED(src) || QDELETED(owner))
		to_chat(sucker, span_warning("算了...一定是你的错觉..."))
		return

	if(!in_range(owner, sucker))
		to_chat(sucker, span_notice("呼...你在[owner]注意到你看到了[owner.p_their()][name]之前移开了..."))
		return

	to_chat(owner, span_warning("[sucker]低头看着你的[name],然后试图移开[sucker.p_their()]的视线,但已经太晚了!"))
	to_chat(sucker, span_danger("<b>[owner]看到了你眼中的恐惧,因为你试图把目光从[owner.p_their()][name]上移开!</b>"))

	owner.face_atom(sucker)

	playsound(get_turf(owner), 'sound/effects/hit_punch.ogg', 50, TRUE)
	owner.do_attack_animation(sucker, used_item = src)

	owner.visible_message(span_danger("[owner]用[owner.p_their()][name]敲了[sucker]!"), span_danger("你用你的[name]敲了[sucker]!"), \
		span_hear("你听到一声闷响!"), ignored_mob = sucker)
	sucker.apply_damage(15, STAMINA)
	log_combat(owner, sucker, "bopped", name, "(setup)")
	to_chat(sucker, span_userdanger("[owner]用[owner.p_their()][name]敲了你!"))
	qdel(src)
