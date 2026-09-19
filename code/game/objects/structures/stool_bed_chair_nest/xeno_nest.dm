#define NEST_RESIST_TIME 80 SECONDS
#define NEST_UNBUCKLED_COOLDOWN 15 SECONDS

///Alium nests. Essentially beds with an unbuckle delay that only aliums can buckle mobs to.
/obj/structure/bed/nest
	name = ALIEN_NEST
	desc = "这是一堆恶心、黏稠的树脂,形状像个巢穴."
	icon = 'icons/Xeno/Effects.dmi'
	icon_state = "nest"
	hit_sound = SFX_ALIEN_RESIN_BREAK
	buckling_y = 6
	buildstacktype = null //can't be disassembled and doesn't drop anything when destroyed
	resistance_flags = UNACIDABLE|XENO_DAMAGEABLE
	max_integrity = 100
	layer = BELOW_OBJ_LAYER
	var/resisting_time = 0

/obj/structure/bed/nest/grab_interact(obj/item/grab/grab, mob/user, base_damage = BASE_OBJ_SLAM_DAMAGE, is_sharp = FALSE)
	if(!ismob(grab.grabbed_thing))
		return
	var/mob/grabbed_mob = grab.grabbed_thing
	to_chat(user, span_notice("你把[grabbed_mob]放在[src]上."))
	grabbed_mob.forceMove(loc)
	return TRUE

/obj/structure/bed/nest/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(xeno_attacker.status_flags & INCORPOREAL)
		return

	xeno_attacker.visible_message(span_xenonotice("\The [xeno_attacker]开始拆除\the [src]!"), \
	span_xenonotice("我们开始拆除\the [src]."))
	if(!do_after(xeno_attacker, 4 SECONDS, NONE, xeno_attacker, BUSY_ICON_GENERIC))
		return
	if(!istype(src)) // Prevent jumping to other turfs if do_after completes with the wall already gone
		return
	xeno_attacker.do_attack_animation(src, ATTACK_EFFECT_CLAW)
	xeno_attacker.visible_message(span_xenonotice("\The [xeno_attacker]拆除了\the [src]!"), \
	span_xenonotice("我们拆除了\the [src]."))
	playsound(src, SFX_ALIEN_RESIN_BREAK, 25)
	take_damage(max_integrity) // Ensure its destroyed

/obj/structure/bed/nest/user_buckle_mob(mob/living/buckling_mob, mob/user, check_loc = TRUE, silent)
	if(isxenohivemind(user))
		to_chat(user, span_warning("我们缺少肢体来做这件事."))
		return FALSE
	if(user.incapacitated() || !in_range(user, src) || buckling_mob.buckled)
		return FALSE
	if(!isxeno(user))
		to_chat(user, span_warning("恶心!你才不会碰那种东西."))
		return FALSE
	if(LAZYLEN(buckled_mobs))
		to_chat(user, span_warning("[src]里已经有人了."))
		return FALSE
	if(ishuman(buckling_mob))
		var/mob/living/carbon/human/H = buckling_mob
		if(TIMER_COOLDOWN_RUNNING(H, COOLDOWN_NEST))
			to_chat(user, span_warning("[H]最近才解开安全带. 稍等一下."))
			return FALSE

	user.visible_message(span_warning("[user]把[buckling_mob]钉入[src],准备用树脂固定."),
	span_warning("[user]把[buckling_mob]钉入[src],准备用树脂固定."))

	if(!do_after(user, 1 SECONDS, NONE, buckling_mob, BUSY_ICON_HOSTILE))
		return FALSE
	if(QDELETED(src))
		return FALSE
	if(LAZYLEN(buckled_mobs))
		to_chat(user, span_warning("[src]里已经有人了."))
		return FALSE

	buckling_mob.visible_message(span_xenonotice("[user]分泌出厚厚一层恶心的树脂,把[buckling_mob]固定在[src]里!"),
		span_xenonotice("[user]用散发着恶臭的树脂把你浸透,把你困在[src]里!"),
		span_notice("你听到黏糊糊的声音."))
	playsound(loc, SFX_ALIEN_RESIN_MOVE, 50)

	silent = TRUE
	return ..()

/obj/structure/bed/nest/user_unbuckle_mob(mob/living/buckled_mob, mob/user, silent)
	if(buckled_mob != user)
		if(user.incapacitated())
			return FALSE
		buckled_mob.visible_message(span_notice("\The [user]把\the [buckled_mob]从\the [src]中拉了出来!"),
			span_notice("\The [user]把你从\the [src]中拉了出来."),
			span_notice("你听到黏糊糊的声音."))
		playsound(loc, SFX_ALIEN_RESIN_MOVE, 50)
		silent = TRUE
		return ..()
	if(force_nest)
		to_chat(buckled_mob, span_warning("巢穴太厚了,你无法抵抗."))
		return FALSE
	if(buckled_mob.incapacitated(TRUE))
		to_chat(buckled_mob, span_warning("你目前无法尝试那样做."))
		return FALSE
	if(!resisting_time)
		resisting_time = world.time
		buckled_mob.visible_message(span_warning("\The [buckled_mob]挣扎着想要摆脱\the [src]."),
			span_warning("你挣扎着想要摆脱\the [src]."),
			span_notice("你听到黏糊糊的声音."))
		addtimer(CALLBACK(src, PROC_REF(unbuckle_time_message), user), NEST_RESIST_TIME)
		return FALSE
	if(resisting_time + NEST_RESIST_TIME > world.time)
		to_chat(buckled_mob, span_warning("你已经在尝试挣脱了. 再等一会儿."))
		return FALSE
	buckled_mob.visible_message(span_danger("\The [buckled_mob]摆脱了\the [src]!"),
		span_danger("你从\the [src]中挣脱了出来!"),
		span_notice("你听到黏糊糊的声音."))
	silent = TRUE
	return ..()

/obj/structure/bed/nest/proc/unbuckle_time_message(mob/living/user)
	if(QDELETED(user) || !(user in buckled_mobs))
		return //Time has passed, conditions may have changed.
	if(resisting_time + NEST_RESIST_TIME > world.time)
		return //We've been freed and re-nested.
	to_chat(user, span_danger("你已经准备好挣脱了! 再抵抗一次就能脱身!"))

/obj/structure/bed/nest/post_buckle_mob(mob/living/buckling_mob)
	. = ..()
	ENABLE_BITFIELD(buckling_mob.restrained_flags, RESTRAINED_XENO_NEST)
	buckling_mob.pulledby?.stop_pulling()
	buckling_mob.reagents.add_reagent(/datum/reagent/medicine/xenojelly, 15)

/obj/structure/bed/nest/post_unbuckle_mob(mob/living/buckled_mob)
	. = ..()
	resisting_time = 0 //Reset it to keep track on if someone is actively resisting.
	if(QDELETED(buckled_mob))
		return
	DISABLE_BITFIELD(buckled_mob.restrained_flags, RESTRAINED_XENO_NEST)
	TIMER_COOLDOWN_START(buckled_mob, COOLDOWN_NEST, NEST_UNBUCKLED_COOLDOWN)

/obj/structure/bed/nest/update_overlays()
	. = ..()
	if(LAZYLEN(buckled_mobs))
		. += image("icon_state" = "nest_overlay", "layer" = LYING_MOB_LAYER + 0.1)

/obj/structure/bed/nest/fire_act(burn_level, flame_color)
	take_damage(burn_level * 2, BURN, FIRE)

#undef NEST_RESIST_TIME
#undef NEST_UNBUCKLED_COOLDOWN
