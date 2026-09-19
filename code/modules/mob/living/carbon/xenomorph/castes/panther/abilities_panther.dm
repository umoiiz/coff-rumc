/datum/action/ability/activable/xeno/psydrain/panther
	ability_cost = 10

/datum/action/ability/activable/xeno/pounce/panther
	desc = "跃向你的目标,将其扑倒并缴械.成功命中时治疗并恢复一些等离子."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PANTHER_POUNCE,
	)
	cooldown_duration = 8 SECONDS
	ability_cost = 15

/datum/action/ability/activable/xeno/pounce/panther/mob_hit(datum/source, mob/living/M)
	. = ..()
	xeno_owner.gain_plasma(35, TRUE)
	xeno_owner.heal_xeno_damage(25)

// ***************************************
// *********** Tearing tail
// ***************************************

/datum/action/ability/xeno_action/tearingtail
	name = "Tearing tail"
	desc = "打击你周围的所有敌人,用选定的毒素使其中毒,并每命中一个目标就治疗你."
	action_icon_state = "tearing_tail"
	action_icon = 'icons/Xeno/actions/panther.dmi'
	ability_cost = 35
	cooldown_duration = 10 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TEARING_TAIL,
	)
	var/tearing_tail_reagent

/datum/action/ability/xeno_action/tearingtail/action_activate()
	xeno_owner.add_filter("defender_tail_sweep", 2, gauss_blur_filter(1))
	xeno_owner.spin(4, 1)
	xeno_owner.enable_throw_parry(0.6 SECONDS)
	playsound(xeno_owner, pick('sound/effects/alien/tail_swipe1.ogg', 'sound/effects/alien/tail_swipe2.ogg', 'sound/effects/alien/tail_swipe3.ogg'), 25, 1)

	for(var/mob/living/carbon/human/human_target in orange(1, xeno_owner))
		if(human_target.stat == DEAD)
			continue
		if(isnestedhost(human_target))
			continue
		human_target.apply_damage(xeno_owner.xeno_caste.melee_damage, BRUTE, blocked = MELEE)
		xeno_owner.gain_plasma(25, TRUE)
		xeno_owner.heal_xeno_damage(70)
		if(human_target.can_sting())
			human_target.reagents.add_reagent(xeno_owner.selected_reagent, PANTHER_TEARING_TAIL_REAGENT_AMOUNT)
			playsound(human_target, 'sound/effects/spray3.ogg', 15, TRUE)
		shake_camera(human_target, 2, 1)
		to_chat(human_target, span_xenowarning("我们被\the [xeno_owner]的尾扫击中了!"))
		playsound(human_target,'sound/weapons/alien_tail_attack.ogg', 50, 1)

	addtimer(CALLBACK(xeno_owner, TYPE_PROC_REF(/datum, remove_filter), "defender_tail_sweep"), 0.5 SECONDS)
	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/tearingtail/on_cooldown_finish()
	to_chat(xeno_owner, span_notice("我们聚集了足够的力量再次撕裂皮肤."))
	owner.playsound_local(owner, 'sound/effects/alien/newlarva.ogg', 25, 0, 1)
	return ..()

// ***************************************
// *********** Adrenaline Jump
// ***************************************

/datum/action/ability/activable/xeno/adrenalinejump
	name = "Adrenaline Jump"
	desc = "从一定距离跳向目标,将其击倒并拉向你,只有当你距离目标至少3到8格时才有效."
	action_icon_state = "adrenaline_jump"
	action_icon = 'icons/Xeno/actions/panther.dmi'
	ability_cost = 10
	cooldown_duration = 8 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ADRENALINE_JUMP,
	)
	target_flags = ABILITY_MOB_TARGET
	/// The target of our lunge, we keep it to check if we are adjacent everytime we move
	var/atom/lunge_target

/datum/action/ability/activable/xeno/adrenalinejump/on_cooldown_finish()
	to_chat(owner, span_xenodanger("我们准备好再次跳跃了."))
	owner.playsound_local(owner, 'sound/effects/alien/newlarva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/activable/xeno/adrenalinejump/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE

	if(get_dist_euclidean_square(A, owner) > 64) //8 tiles range
		if(!silent)
			to_chat(owner, span_xenonotice("你太远了!"))
		return FALSE

	if(!line_of_sight(A, owner))
		if(!silent)
			owner.balloon_alert(owner, "我们需要清晰的跳跃路线!")
		return FALSE

	if(!isliving(A))
		if(!silent)
			to_chat(owner, span_xenodanger("我们不能跳向那个!"))
		return FALSE

	var/mob/living/living_target = A
	if(living_target.stat == DEAD)
		if(!silent)
			to_chat(owner, span_xenodanger("我们不能跳向那个!"))
		return FALSE
	return TRUE

/datum/action/ability/activable/xeno/adrenalinejump/use_ability(atom/targeted_atom)
	xeno_owner.visible_message(span_xenowarning("\The [xeno_owner]跳向[targeted_atom]!"), \
	span_xenowarning("我们跳向[targeted_atom]!"))

	lunge_target = targeted_atom

	RegisterSignal(lunge_target, COMSIG_QDELETING, PROC_REF(clean_lunge_target))
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_MOVED, PROC_REF(check_if_lunge_possible))
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_POST_THROW, PROC_REF(clean_lunge_target))

	if(lunge_target.Adjacent(xeno_owner)) //They're already in range, pat their head, we messed up.
		to_chat(xeno_owner, span_xenodanger("由于跳跃失败,我们失去了一些肾上腺素!"))
		playsound(xeno_owner,'sound/weapons/thudswoosh.ogg', 75, 1)
		xeno_owner.use_plasma(50, TRUE)
		clean_lunge_target()
	else
		xeno_owner.throw_at(get_step_towards(targeted_atom, xeno_owner), 6, 2, xeno_owner)

	succeed_activate()
	add_cooldown()
	return TRUE

///Check if we are close enough to lunge, and if yes, fling them
/datum/action/ability/activable/xeno/adrenalinejump/proc/check_if_lunge_possible(datum/source)
	SIGNAL_HANDLER
	if(!lunge_target.Adjacent(source))
		return
	pantherfling(lunge_target)

/// Null lunge target and reset throw vars
/datum/action/ability/activable/xeno/adrenalinejump/proc/clean_lunge_target()
	SIGNAL_HANDLER
	UnregisterSignal(lunge_target, COMSIG_QDELETING)
	lunge_target = null
	UnregisterSignal(owner, list(COMSIG_MOVABLE_POST_THROW, COMSIG_MOVABLE_MOVED))
	owner.stop_throw()

/datum/action/ability/activable/xeno/adrenalinejump/proc/pantherfling(mob/living/lunge_target)
	xeno_owner.face_atom(lunge_target)
	xeno_owner.visible_message(span_xenowarning("\The [xeno_owner]轻松绊倒了[lunge_target]!"), \
	span_xenowarning("我们轻松绊倒了[lunge_target]!"))
	playsound(lunge_target,'sound/weapons/alien_claw_block.ogg', 75, 1)

	xeno_owner.do_attack_animation(lunge_target, ATTACK_EFFECT_DISARM2)
	xeno_owner.gain_plasma(50, TRUE)

	if(isxeno(lunge_target) && xeno_owner.issamexenohive(lunge_target))
		return

	lunge_target.ParalyzeNoChain(1 SECONDS)
	lunge_target.throw_at(xeno_owner, 1, 1, xeno_owner)

// ***************************************
// *********** Adrenaline rush
// ***************************************

/datum/action/ability/xeno_action/adrenaline_rush
	name = "Adrenaline rush"
	desc = "激活后以每移动一格消耗3点肾上腺素为代价提高移动速度."
	action_icon_state = "adrenaline_rush"
	action_icon = 'icons/Xeno/actions/panther.dmi'
	ability_cost = 10
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ADRENALINE_RUSH,
	)
	use_state_flags = ABILITY_USE_LYING
	action_type = ACTION_TOGGLE
	/// Is adrenaline rush active?
	var/speed_activated = FALSE

/datum/action/ability/xeno_action/adrenaline_rush/remove_action()
	rush_off(TRUE) // Ensure we remove the movespeed
	return ..()

/datum/action/ability/xeno_action/adrenaline_rush/action_activate()
	if(speed_activated)
		rush_off()
		return fail_activate()
	rush_on()
	succeed_activate()

/datum/action/ability/xeno_action/adrenaline_rush/proc/rush_on(silent = FALSE)
	speed_activated = TRUE
	xeno_owner.add_movespeed_modifier(MOVESPEED_ID_PANTHER_ADRENALINE_RUSH, TRUE, 0, NONE, TRUE, -0.75)
	set_toggle(TRUE)
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_MOVED, PROC_REF(rush_on_moved))

/datum/action/ability/xeno_action/adrenaline_rush/proc/rush_off()
	xeno_owner.remove_movespeed_modifier(MOVESPEED_ID_PANTHER_ADRENALINE_RUSH)
	speed_activated = FALSE
	set_toggle(FALSE)
	UnregisterSignal(xeno_owner, COMSIG_MOVABLE_MOVED)

/datum/action/ability/xeno_action/adrenaline_rush/proc/rush_on_moved(datum/source, atom/oldloc, direction, Forced = FALSE)
	SIGNAL_HANDLER
	if(xeno_owner.plasma_stored < 3)
		xeno_owner.balloon_alert(xeno_owner, "我们太累了,无法继续")
		rush_off()
		return
	xeno_owner.use_plasma(3)

// ***************************************
// *********** Evasive maneuvers
// ***************************************

/datum/action/ability/xeno_action/evasive_maneuvers
	name = "Toggle evasive maneuvers"
	desc = "切换闪避动作,使原本会命中你的非友方投射物偏离."
	action_icon_state = "evasive_maneuvers"
	action_icon = 'icons/Xeno/actions/panther.dmi'
	ability_cost = 35
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_EVASIVE_MANEUVERS,
	)
	cooldown_duration = PANTHER_EVASION_COOLDOWN
	action_type = ACTION_TOGGLE
	///Whether evasion is currently active
	var/evade_active = FALSE

/datum/action/ability/xeno_action/evasive_maneuvers/remove_action(mob/living/L)
	if(evade_active)
		evasion_deactivate()
	return ..()

/datum/action/ability/xeno_action/evasive_maneuvers/can_use_action(silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(xeno_owner.on_fire)
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "着火时无法使用!")
		return FALSE
	return TRUE

/datum/action/ability/xeno_action/evasive_maneuvers/action_activate()
	if(evade_active)
		evasion_deactivate()
		return TRUE
	xeno_owner.balloon_alert(xeno_owner, "开始闪避.")
	to_chat(xeno_owner, span_userdanger("我们采取闪避动作,使我们无法被投射物命中."))
	succeed_activate()

	RegisterSignals(xeno_owner, list(
		COMSIG_LIVING_STATUS_STUN,
		COMSIG_LIVING_STATUS_KNOCKDOWN,
		COMSIG_LIVING_STATUS_PARALYZE,
		COMSIG_LIVING_STATUS_IMMOBILIZE,
		COMSIG_LIVING_STATUS_UNCONSCIOUS,
		COMSIG_LIVING_STATUS_SLEEP,
		COMSIG_LIVING_STATUS_STAGGER,
		COMSIG_LIVING_IGNITED), PROC_REF(evasion_debuff_check))

	RegisterSignal(xeno_owner, COMSIG_MOVABLE_MOVED, PROC_REF(handle_evasion))
	RegisterSignal(xeno_owner, COMSIG_XENO_PROJECTILE_HIT, PROC_REF(evasion_dodge)) //This is where we actually check to see if we dodge the projectile.
	RegisterSignal(xeno_owner, COMSIG_PRE_MOVABLE_IMPACT, PROC_REF(evasion_throw_dodge)) //Register status effects and fire which impact evasion.
	RegisterSignal(xeno_owner, COMSIG_LIVING_HANDLE_VENTCRAWL, PROC_REF(evasion_deactivate))

	set_toggle(TRUE)
	evade_active = TRUE //evasion is currently active

	GLOB.round_statistics.runner_evasions++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "runner_evasions") //Statistics

	handle_evasion()
	START_PROCESSING(SSprocessing, src)

/datum/action/ability/xeno_action/evasive_maneuvers/proc/handle_evasion()
	SIGNAL_HANDLER
	if(xeno_owner.m_intent == MOVE_INTENT_RUN)
		xeno_owner.use_plasma(PANTHER_EVASION_PLASMADRAIN)
	if(xeno_owner.m_intent == MOVE_INTENT_WALK)
		xeno_owner.use_plasma(PANTHER_EVASION_LOW_PLASMADRAIN)
	//If we have 0 plasma after expending evasion upkeep plasma, end evasion.
	if(!xeno_owner.plasma_stored)
		to_chat(xeno_owner, span_xenodanger("我们没有足够的等离子来维持闪避."))
		evasion_deactivate()

///After getting hit with an Evasion disabling debuff, this is where we check to see if evasion is active, and if we actually have debuff stacks
/datum/action/ability/xeno_action/evasive_maneuvers/proc/evasion_debuff_check(datum/source, amount)
	SIGNAL_HANDLER

	if(amount <= 0 || !evade_active) //If evasion isn't active we don't care
		return
	to_chat(xeno_owner, span_userdanger("我们的移动被打断了!"))
	xeno_owner.use_plasma(65, TRUE)

///Where we deactivate evasion and unregister the signals/zero out vars, etc.
/datum/action/ability/xeno_action/evasive_maneuvers/proc/evasion_deactivate()
	SIGNAL_HANDLER
	add_cooldown()
	to_chat(owner, span_xenodanger("我们停止闪避."))

	UnregisterSignal(owner, list(
		COMSIG_MOVABLE_MOVED,
		COMSIG_LIVING_STATUS_STUN,
		COMSIG_LIVING_STATUS_KNOCKDOWN,
		COMSIG_LIVING_STATUS_PARALYZE,
		COMSIG_LIVING_STATUS_IMMOBILIZE,
		COMSIG_LIVING_STATUS_UNCONSCIOUS,
		COMSIG_LIVING_STATUS_SLEEP,
		COMSIG_LIVING_STATUS_STAGGER,
		COMSIG_XENO_PROJECTILE_HIT,
		COMSIG_LIVING_IGNITED,
		COMSIG_PRE_MOVABLE_IMPACT,
		COMSIG_LIVING_HANDLE_VENTCRAWL,
	))

	set_toggle(FALSE)
	evade_active = FALSE //Evasion is no longer active

	owner.balloon_alert(owner, "闪避结束")
	owner.playsound_local(owner, 'sound/voice/alien/hiss8.ogg', 50)

#define PANTHER_EVASION_RUN_DELAY 0.5 SECONDS // If the time since the Runner last moved is equal to or greater than this, its Evasion ends.

/datum/action/ability/xeno_action/evasive_maneuvers/on_cooldown_finish()
	to_chat(owner, span_xenodanger("我们可以再次采取闪避动作了."))
	owner.playsound_local(owner, 'sound/effects/alien/newlarva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/xeno_action/evasive_maneuvers/process()
	if(!evade_active)
		return PROCESS_KILL
	handle_evasion()

///Determines whether or not a thrown projectile is dodged while the Evasion ability is active
/datum/action/ability/xeno_action/evasive_maneuvers/proc/evasion_throw_dodge(datum/source, atom/movable/proj)
	SIGNAL_HANDLER

	if(!evade_active) //If evasion is not active we don't dodge
		return NONE

	if(xeno_owner.last_move_time < (world.time - PANTHER_EVASION_RUN_DELAY)) //Gotta keep moving to benefit from evasion!
		return NONE

	evasion_dodge_sfx(proj)

	return COMPONENT_PRE_MOVABLE_IMPACT_DODGED

///This is where the dodgy magic happens
/datum/action/ability/xeno_action/evasive_maneuvers/proc/evasion_dodge(datum/source, atom/movable/projectile/proj, cardinal_move, uncrossing)
	SIGNAL_HANDLER

	if(!evade_active) //If evasion is not active we don't dodge
		return FALSE

	if(xeno_owner.last_move_time < (world.time - PANTHER_EVASION_RUN_DELAY)) //Gotta keep moving to benefit from evasion!
		return FALSE

	if(xeno_owner.issamexenohive(proj.firer)) //We automatically dodge allied projectiles at no cost, and no benefit to our evasion stacks
		return COMPONENT_PROJECTILE_DODGE

	if(proj.ammo.ammo_behavior_flags & AMMO_FLAME) //We can't dodge literal fire
		return FALSE

	evasion_dodge_sfx(proj)

	return COMPONENT_PROJECTILE_DODGE

///Handles dodge effects and visuals for the Evasion ability.
/datum/action/ability/xeno_action/evasive_maneuvers/proc/evasion_dodge_sfx(atom/movable/proj)
	xeno_owner.visible_message(span_warning("[xeno_owner]轻松躲开了[proj.name]!"), \
	span_xenodanger("我们轻松躲开了[proj.name]!"))

	xeno_owner.add_filter("runner_evasion", 2, gauss_blur_filter(5))
	addtimer(CALLBACK(xeno_owner, TYPE_PROC_REF(/datum, remove_filter), "runner_evasion"), 0.5 SECONDS)
	xeno_owner.do_jitter_animation(4000)

	var/turf/our_turf = get_turf(xeno_owner) //location of after image SFX
	playsound(our_turf, pick(SFX_THROW,'sound/effects/alien/tail_swipe1.ogg', 'sound/effects/alien/tail_swipe2.ogg'), 25, 1) //sound effects
	var/obj/effect/temp_visual/after_image/our_afterimage
	for(var/i = 0 to 2) //number of after images
		our_afterimage = new /obj/effect/temp_visual/after_image(our_turf, owner) //Create the after image.
		our_afterimage.pixel_x = pick(rand(xeno_owner.pixel_x * 3, xeno_owner.pixel_x * 1.5), rand(0, xeno_owner.pixel_x * -1)) //Variation on the xenomorph_owner position

// ***************************************
// *********** Select reagent (panther)
// ***************************************
/datum/action/ability/xeno_action/select_reagent/panther
	desc = "选择用于撕裂尾巴的试剂.血魔碱使目标减速25%,在存在神经毒素时提高到50%,并将受到伤害的20%转化为耐力伤害.转毒素根据受到伤害的40%将钝击/灼烧伤害转化为毒素伤害,最多对目标造成45点毒素,达到该值后造成眩晕.神经毒素在受害者体内停留时间越长,造成的耐力伤害越高,并阻止耐力恢复.奥泽洛梅林清除人类体内的医疗化学物质,同时造成轻微醉酒.血红素根据上述所有试剂的存在与否及数量造成伤害,还会造成轻微钝击伤害和流血."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PANTHER_SELECT_REAGENT,
		KEYBINDING_ALTERNATE = COMSIG_XENOABILITY_RADIAL_SELECT_REAGENT,
	)

/datum/action/ability/xeno_action/select_reagent/panther/give_action(mob/living/L)
	. = ..()
	xeno_owner.selected_reagent = GLOB.panther_toxin_type_list[1] //Set our default
	update_button_icon() //Update immediately to get our default

/datum/action/ability/xeno_action/select_reagent/panther/action_activate()
	var/i = GLOB.panther_toxin_type_list.Find(xeno_owner.selected_reagent)
	if(length_char(GLOB.panther_toxin_type_list) == i)
		xeno_owner.selected_reagent = GLOB.panther_toxin_type_list[1]
	else
		xeno_owner.selected_reagent = GLOB.panther_toxin_type_list[i+1]

	var/atom/A = xeno_owner.selected_reagent
	xeno_owner.balloon_alert(xeno_owner, "[initial(A.name)]")
	update_button_icon()
	return succeed_activate()

/datum/action/ability/xeno_action/select_reagent/panther/select_reagent_radial()
	//List of toxin images
	// This is cursed, don't copy this code its the WRONG way to do this.
	// TODO: generate this from GLOB.panther_toxin_type_list (or wait while offtgmc reworks the defiler code and then copy it )
	var/static/list/panther_toxin_images_list = list(
		REAGENT_HEMODILE = image('icons/Xeno/actions/general.dmi', icon_state = REAGENT_HEMODILE),
		REAGENT_TRANSVITOX = image('icons/Xeno/actions/general.dmi', icon_state = REAGENT_TRANSVITOX),
		REAGENT_OZELOMELYN = image('icons/Xeno/actions/general.dmi', icon_state = REAGENT_OZELOMELYN),
		REAGENT_SANGUINAL = image('icons/Xeno/actions/general.dmi', icon_state = REAGENT_SANGUINAL),
	)
	var/toxin_choice = show_radial_menu(xeno_owner, xeno_owner, panther_toxin_images_list, radius = 48)
	if(!toxin_choice)
		return
	for(var/toxin in GLOB.panther_toxin_type_list)
		var/datum/reagent/our_reagent = GLOB.chemical_reagents_list[toxin]
		if(our_reagent.name == toxin_choice)
			xeno_owner.selected_reagent = our_reagent.type
			break
	xeno_owner.balloon_alert(xeno_owner, "[toxin_choice]")
	update_button_icon()
	return succeed_activate()
