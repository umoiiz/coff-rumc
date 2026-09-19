/obj/item/explosive/grenade
	name = "\improper M40 HEDP榴弹"
	desc = "一种小巧但威力出人意料地强的高爆榴弹，正在逐步取代M15破片榴弹。能够装填进任何榴弹发射器，或用手投掷。"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/items/grenade.dmi'
	icon_state = "grenade"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/grenades_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/grenades_right.dmi',
	)
	worn_icon_state = "grenade"
	throw_speed = 3
	throw_range = 7
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	hitsound = 'sound/weapons/smash.ogg'
	icon_state_mini = "grenade_red"
	///if launched from a UGL/grenade launcher
	var/launched = FALSE
	///bonus impact damage if launched from a UGL/grenade launcher
	var/launchforce = 10
	var/det_time = 4 SECONDS
	///Does it make a danger overlay for humans? Can synths use it?
	var/dangerous = TRUE
	///Будет ли проигрываться звук удара об пол (groundhit_sound)
	var/groundhit_sound_is_playable = TRUE
	///Звук чеки у гранаты
	var/list/arm_sound = list(
		'sound/weapons/grenade/grenade_pinout1.ogg',
		'sound/weapons/grenade/grenade_pinout2.ogg'
	)
	var/hud_state = "grenade_he"
	var/hud_state_empty = "grenade_empty"
	///Звук броска гранаты
	var/throw_sound = 'sound/weapons/grenade/grenade_throw.ogg'
	///Звук удара гранаты об любой турф
	var/list/groundhit_sound = list(
		'sound/weapons/grenade/grenade_hit1.ogg',
		'sound/weapons/grenade/grenade_hit2.ogg'
	)
	/// Power of the explosion
	var/power = 105
	/// Falloff of our explosion, aka distance, by the formula of power / falloff
	var/falloff = 30
	var/overlay_type = "red"
	///The actual timer for the grenade
	var/det_timer

/obj/item/explosive/grenade/Initialize(mapload)
	. = ..()
	det_time = rand(det_time - 1 SECONDS, det_time + 1 SECONDS)

/obj/item/explosive/grenade/attack_self(mob/user)
	if(active)
		return

	if(!user.dextrous)
		balloon_alert(user, "敏捷度不足")
		return

	if(issynth(user) && dangerous && !CONFIG_GET(flag/allow_synthetic_gun_use))
		balloon_alert(user, "不能，与你的程序设定相悖")
		return

	activate(user)

	balloon_alert_to_viewers("引爆榴弹")
	if(dangerous && ishumanbasic(user))
		var/nade_sound = user.gender == FEMALE ? SFX_FEMALE_FRAGOUT : SFX_MALE_FRAGOUT

		for(var/mob/living/carbon/human/H in hearers(6,user))
			H.playsound_local(user, nade_sound, 35)

		var/image/grenade = image('icons/mob/talk.dmi', user, "grenade")
		user.add_emote_overlay(grenade)

/obj/item/explosive/grenade/afterattack(atom/target, mob/user, has_proximity, click_parameters)
	. = ..()
	if(!active)
		return
	user.throw_item(target)

/obj/item/explosive/grenade/update_overlays()
	. = ..()
	if(!dangerous)
		return
	if(active && overlay_type)
		. += image('icons/effects/danger.dmi', icon_state = "danger_[overlay_type]")

/obj/item/explosive/grenade/fire_act(burn_level, flame_color)
	activate()

///Activates the grenade
/obj/item/explosive/grenade/proc/activate(mob/user)
	if(active)
		return

	if(user?.client)
		log_bomber(user, "primed", src)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
		personal_statistics.grenades_primed++

	icon_state = initial(icon_state) + "_active"
	active = TRUE
	playsound(loc, pick(arm_sound), 30, 1, 6)
	if(dangerous)
		GLOB.round_statistics.grenades_thrown++
		SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "grenades_thrown")
		update_icon()
	det_timer = addtimer(CALLBACK(src, PROC_REF(prime)), det_time, TIMER_STOPPABLE)
	notify_ai_hazard()
	return TRUE

/obj/item/explosive/grenade/proc/prime()
	if(ishuman(loc))
		var/mob/living/carbon/human/idiot = loc
		var/in_hand = FALSE
		if(idiot.l_hand == src)
			idiot.amputate_limb(BODY_ZONE_PRECISE_L_HAND)
			in_hand = TRUE
		else if(idiot.r_hand == src)
			idiot.amputate_limb(BODY_ZONE_PRECISE_R_HAND)
			in_hand = TRUE
		if(in_hand)
			idiot.visible_message(span_danger("[idiot]的手被[src]炸成了碎片！"),
			span_userdanger("当[src]炸掉你的手时，你感到难以置信的痛苦和愚蠢。"))
			idiot.emote("scream")
			var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[idiot.ckey]
			personal_statistics.grenade_hand_delimbs ++
	cell_explosion(loc, power = src.power, falloff = src.falloff)
	qdel(src)

///Adjusts det time, used for grenade launchers
/obj/item/explosive/grenade/proc/launched_det_time()
	det_time = min(1 SECONDS, det_time)

/obj/item/explosive/grenade/throw_at(target, range, speed, thrower, spin, flying, targetted_throw)
	. = ..()
	playsound(thrower, throw_sound, 25, 1, 6)

/obj/item/explosive/grenade/throw_impact(atom/hit_atom, speed, bounce)
	. = ..()
	if(groundhit_sound_is_playable)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, pick(groundhit_sound), 20, 1, 9), 0.1 SECONDS)
