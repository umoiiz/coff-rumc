/obj/item/inflatable
	name = "通用充气物"
	desc = "你不该看到这个."
	icon = 'icons/obj/inflatable.dmi'
	hit_sound = 'sound/effects/Glasshit_old.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	///The type of structure we make upon inflation
	var/inflatable_type

/obj/item/inflatable/attack_self(mob/user)
	. = ..()
	balloon_alert(user, "正在充气...")
	if(!do_after(user, 3 SECONDS, NONE, src))
		balloon_alert(user, "被打断了!")
		return
	playsound(loc, 'sound/items/zip.ogg', 25, 1)
	to_chat(user, span_notice("你给[src]充了气."))
	new inflatable_type(get_turf(user))
	qdel(src)

/obj/item/inflatable/wall
	name = "充气墙"
	desc = "一种折叠膜,激活后会迅速膨胀成大型立方体形状."
	icon_state = "folded_wall"
	inflatable_type = /obj/structure/inflatable/wall

/obj/item/inflatable/door
	name = "充气门"
	desc = "一种折叠膜,激活后会迅速膨胀成一扇简易门."
	icon_state = "folded_door"
	inflatable_type = /obj/structure/inflatable/door

/obj/structure/inflatable
	name = "通用充气物"
	desc = "你不该看到这个."
	density = TRUE
	allow_pass_flags = NONE
	icon = 'icons/obj/inflatable.dmi'
	max_integrity = 50
	resistance_flags = XENO_DAMAGEABLE
	///Are we deflated?
	var/deflated = FALSE
	///The type of item we get back upon deflation
	var/inflatable_item
	///The popped variant of this type
	var/popped_variant

/obj/structure/inflatable/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(!deflated)
		deflate(!disassembled)
	return ..()

/obj/structure/inflatable/ex_act(severity)
	if(severity >= EXPLODE_HEAVY)
		qdel(src)
		return
	if(prob(severity * 0.5))
		deflate(TRUE)

/obj/structure/inflatable/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(can_puncture(I))
		visible_message(span_danger("[user]用[I]刺穿了[src]!"))
		deflate(TRUE)

///Handles the structure deflating
/obj/structure/inflatable/proc/deflate(violent = FALSE)
	set waitfor = 0
	if(deflated)
		return
	deflated = TRUE
	playsound(loc, 'sound/machines/hiss.ogg', 25, 1)
	visible_message("[src][violent ? "rapidly" : "slowly"]放气了!")
	flick("wall_[violent ? "popping" : "deflating"]", src)
	addtimer(CALLBACK(src, PROC_REF(post_deflate), violent), violent ? 1 SECONDS : 5 SECONDS)

///Creates the appropriate item after deflation
/obj/structure/inflatable/proc/post_deflate(violent = FALSE)
	if(violent)
		new popped_variant(get_turf(src))
	else
		new inflatable_item(get_turf(src))
	qdel(src)

/obj/structure/inflatable/verb/hand_deflate()
	set name = "Deflate"
	set category = "IC.Object"
	set src in oview(1)

	if(!ishuman(usr))
		return

	if(!deflated)
		balloon_alert(usr, "正在放气...")
		deflate(FALSE)
	else
		balloon_alert(usr, "已经放气了.")

/obj/structure/inflatable/wall
	name = "充气墙"
	desc = "一面充了气的膜.请勿刺穿."
	icon_state = "wall"
	inflatable_item = /obj/item/inflatable/wall
	popped_variant = /obj/structure/inflatable/popped

/obj/structure/inflatable/popped
	name = "破裂的充气墙"
	desc = "它曾经是一面充气墙,现在只是一堆乱七八糟的塑料."
	density = FALSE
	anchored = TRUE
	deflated = TRUE
	icon_state = "wall_popped"

/obj/structure/inflatable/popped/door
	name = "破裂的充气门"
	desc = "它曾经是一扇充气门,现在只是一堆乱七八糟的塑料."
	icon_state = "door_popped"

//TODO make this not copypasta. A simple door component maybe.
/obj/structure/inflatable/door
	name = "充气门"
	icon_state = "door_closed"
	inflatable_item = /obj/item/inflatable/door
	popped_variant = /obj/structure/inflatable/popped/door
	///Are we open?
	var/open = FALSE
	///Are we currently busy opening/closing?
	var/switching_states = FALSE

/obj/structure/inflatable/door/Initialize(mapload)
	. = ..()
	if((locate(/mob/living) in loc) && !open)
		toggle_state()

/obj/structure/inflatable/door/Bumped(atom/user)
	. = ..()
	if(!open)
		return try_toggle_state(user)

/obj/structure/inflatable/door/update_icon()
	. = ..()
	if(open)
		icon_state = "door_open"
	else
		icon_state = "door_closed"

/obj/structure/inflatable/door/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	return try_toggle_state(user)

/obj/structure/inflatable/door/CanAllowThrough(atom/movable/mover, turf/target, height = 0, air_group = 0)
	if(air_group)
		return open
	if(istype(mover, /obj/effect/beam))
		return !opacity
	return ..()

/*
 * Checks all the requirements for opening/closing a door before opening/closing it. Copypasta. TODO: un-copypasta this
 *
 * atom/user - the mob trying to open/close this door
*/
/obj/structure/inflatable/door/proc/try_toggle_state(atom/user)
	if(switching_states || !ismob(user) || locate(/mob/living) in get_turf(src))
		return
	var/mob/M = user
	if(!M.client)
		return
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(C.handcuffed)
			return
	toggle_state()

///The proc that actually does the door closing. Plays the animation, etc. Copypasta. TODO: un-copypasta this
/obj/structure/inflatable/door/proc/toggle_state()
	switching_states = TRUE
	open = !open
	flick("door_[open ? "opening" : "closing"]", src)
	density = !density
	update_icon()
	addtimer(VARSET_CALLBACK(src, switching_states, FALSE), 1 SECONDS)
