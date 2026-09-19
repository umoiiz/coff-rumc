/obj/structure/fence
	name = "围栏"
	desc = "一张铺设在两根柱子之间的大型金属网.旨在作为一种廉价的区域分隔方式,同时允许人透过它看到另一边."
	icon = 'icons/obj/smooth_objects/fence.dmi'
	base_icon_state = "fence"
	icon_state = "fence-icon"
	density = TRUE
	anchored = TRUE //We can not be moved.
	coverage = 5
	layer = ABOVE_WINDOW_LAYER
	max_integrity = 150 //Its cheap but still viable to repair, cant be moved around, about 7 runner hits to take down
	resistance_flags = XENO_DAMAGEABLE
	minimap_color = MINIMAP_FENCE
	coverage = 0 //4 rods doesn't provide any cover
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_FENCE)
	canSmoothWith = list(SMOOTH_GROUP_FENCE)
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 50, BIO = 0, FIRE = 0, ACID = 0)
	/// Cut fences can be passed through
	var/cut = FALSE
	///Chance for the fence to break on /init
	var/chance_to_break = 80 //Defaults to 80%

/obj/structure/fence/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/stack/rods) && obj_integrity < max_integrity)
		if(user.skills.getRating(SKILL_CONSTRUCTION) < SKILL_CONSTRUCTION_PLASTEEL)
			user.visible_message(span_notice("[user]笨手笨脚地摸索着如何修复[src]的线路."),
			span_notice("你笨手笨脚地摸索着如何修复[src]的线路."))
			var/fumbling_time = 10 SECONDS - 2 SECONDS * user.skills.getRating(SKILL_CONSTRUCTION)
			if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
				return

		var/obj/item/stack/rods/R = I
		var/amount_needed = 4
		if(obj_integrity)
			amount_needed = 4

		if(R.amount < amount_needed)
			to_chat(user, span_warning("你需要更多金属棒来修复[src]."))
			return

		user.visible_message(span_notice("[user]开始用[R]修复[src]."),
		span_notice("你开始用[R]修复[src]"))
		playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)

		if(!do_after(user, 30, NONE, src, BUSY_ICON_FRIENDLY))
			return

		if(R.amount < amount_needed)
			to_chat(user, span_warning("你需要更多金属棒来修复[src]."))
			return

		R.use(amount_needed)
		repair_damage(max_integrity, user)
		cut = 0
		density = TRUE
		icon = 'icons/obj/smooth_objects/fence.dmi'
		playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)
		user.visible_message(span_notice("[user]用[R]修复了[src]."),
		span_notice("你用[R]修复了[src]"))

/obj/structure/fence/grab_interact(obj/item/grab/grab, mob/user, base_damage = BASE_OBJ_SLAM_DAMAGE, is_sharp = FALSE)
	if(!isliving(grab.grabbed_thing))
		return

	var/mob/living/grabbed_mob = grab.grabbed_thing
	var/state = user.grab_state
	user.drop_held_item()
	var/damage = (user.skills.getRating(SKILL_CQC) * CQC_SKILL_DAMAGE_MOD)
	switch(state)
		if(GRAB_PASSIVE)
			damage += BASE_OBJ_SLAM_DAMAGE
			grabbed_mob.visible_message(span_warning("[user]把[grabbed_mob]猛砸向\the [src]!"))
			log_combat(user, grabbed_mob, "slammed", "", "against \the [src]")
		if(GRAB_AGGRESSIVE)
			damage += BASE_OBJ_SLAM_DAMAGE * 1.5
			grabbed_mob.visible_message(span_danger("[user]把[grabbed_mob]猛击向\the [src]!"))
			log_combat(user, grabbed_mob, "bashed", "", "against \the [src]")
			if(prob(50))
				grabbed_mob.Paralyze(2 SECONDS)
		if(GRAB_NECK)
			damage += BASE_OBJ_SLAM_DAMAGE * 2
			grabbed_mob.visible_message(span_danger("<big>[user]把[grabbed_mob]压碎在\the [src]上!</big>"))
			log_combat(user, grabbed_mob, "crushed", "", "against \the [src]")
			grabbed_mob.Paralyze(2 SECONDS)
	grabbed_mob.apply_damage(damage, blocked = MELEE, updating_health = TRUE)
	take_damage(damage * 2, BRUTE, MELEE)
	return TRUE

/obj/structure/fence/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	if(cut)
		return
	user.visible_message(span_notice("[user]开始用[I]切割[src]."),
	span_notice("你开始用[I]切割[src]"))
	playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)
	if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return
	playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)
	user.visible_message(span_notice("[user]用[I]切穿了[src]."),
	span_notice("你用[I]砍穿了[src]"))
	deconstruct(TRUE)

/obj/structure/fence/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	SHOULD_CALL_PARENT(FALSE)
	if(disassembled)
		new /obj/item/stack/rods(loc)
	cut = TRUE
	density = FALSE
	icon = 'icons/obj/smooth_objects/brokenfence.dmi'

/obj/structure/fence/Initialize(mapload, start_dir)
	. = ..()

	if(prob(chance_to_break))
		obj_integrity = 0
		deconstruct(FALSE)

	if(start_dir)
		setDir(start_dir)

/obj/structure/fence/Destroy()
	density = FALSE
	icon = 'icons/obj/smooth_objects/brokenfence.dmi'
	return ..()

/obj/structure/fence/fire_act(burn_level, flame_color)
	take_damage(burn_level, BURN, FIRE)

/obj/structure/fence/broken
	chance_to_break = 100
