// ***************************************
// *********** Tail sweep
// ***************************************
/datum/action/ability/xeno_action/tail_sweep
	name = "Tail Sweep"
	desc = "击中你周围所有相邻单位, 将其击退并击倒."
	action_icon_state = "tail_sweep"
	action_icon = 'icons/Xeno/actions/defender.dmi'
	ability_cost = 35
	use_state_flags = ABILITY_USE_CRESTED
	cooldown_duration = 12 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TAIL_SWEEP,
	)
	/// How far does it knockback?
	var/knockback_distance = 1
	/// How long does it stagger?
	var/stagger_duration = 0 SECONDS
	/// How long does it paralyze?
	var/paralyze_duration = 0.5 SECONDS
	/// If this deals damage, what type of damage is it?
	var/damage_type = BRUTE
	/// The multiplier of the damage to be applied.
	var/damage_multiplier = 1

/datum/action/ability/xeno_action/tail_sweep/can_use_action(silent, override_flags)
	. = ..()
	if(xeno_owner.crest_defense && xeno_owner.plasma_stored < (ability_cost * 2))
		to_chat(xeno_owner, span_xenowarning("我们的等离子体不够, 还需要[(ability_cost * 2) - xeno_owner.plasma_stored]点等离子体!"))
		return FALSE

/datum/action/ability/xeno_action/tail_sweep/action_activate()
	GLOB.round_statistics.defender_tail_sweeps++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "defender_tail_sweeps")
	xeno_owner.visible_message(span_xenowarning("\The [xeno_owner]大幅环形扫动尾巴!"), \
	span_xenowarning("我们大幅环形扫动尾巴!"))

	xeno_owner.add_filter("defender_tail_sweep", 2, gauss_blur_filter(1)) //Add cool SFX
	xeno_owner.spin(4, 1)
	xeno_owner.enable_throw_parry(0.6 SECONDS)
	playsound(xeno_owner,pick('sound/effects/alien/tail_swipe1.ogg','sound/effects/alien/tail_swipe2.ogg','sound/effects/alien/tail_swipe3.ogg'), 25, 1) //Sound effects

	var/sweep_range = 1
	var/list/L = orange(sweep_range, xeno_owner)		// Not actually the fruit

	for(var/obj/item/explosive/grenade/G in L)
		G.knockback(xeno_owner, 6, 2)

	for(var/obj/machinery/deployable/mounted/sentry/sentry in L)
		var/damage = xeno_owner.xeno_caste.melee_damage
		sentry.take_damage(damage, BRUTE, MELEE)
		sentry.knock_down()

	for(var/mob/living/carbon/human/H in L)
		if(H.stat == DEAD || !xeno_owner.Adjacent(H))
			continue
		H.add_filter("defender_tail_sweep", 2, gauss_blur_filter(1)) //Add cool SFX; motion blur
		addtimer(CALLBACK(H, TYPE_PROC_REF(/datum, remove_filter), "defender_tail_sweep"), 0.5 SECONDS) //Remove cool SFX
		var/damage = xeno_owner.xeno_caste.melee_damage
		var/affecting = H.get_limb(ran_zone(null, 0))
		if(!affecting) //Still nothing??
			affecting = H.get_limb("chest") //Gotta have a torso?!
		if(damage_multiplier > 0)
			H.apply_damage(damage * damage_multiplier, damage_type, updating_health = TRUE)
		if(knockback_distance >= 1)
			H.knockback(xeno_owner, knockback_distance, 4)
		if(stagger_duration)
			H.adjust_stagger(stagger_duration)
		if(paralyze_duration)
			H.Paralyze(paralyze_duration)
		GLOB.round_statistics.defender_tail_sweep_hits++
		SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "defender_tail_sweep_hits")
		shake_camera(H, 2, 1)

		to_chat(H, span_xenowarning("我们被\the [xeno_owner]的扫尾击中!"))
		playsound(H,'sound/weapons/alien_claw_block.ogg', 50, 1)

	addtimer(CALLBACK(xeno_owner, TYPE_PROC_REF(/datum, remove_filter), "defender_tail_sweep"), 0.5 SECONDS) //Remove cool SFX
	succeed_activate()
	if(xeno_owner.crest_defense)
		xeno_owner.use_plasma(ability_cost)
	add_cooldown()

/datum/action/ability/xeno_action/tail_sweep/on_cooldown_finish()
	to_chat(xeno_owner, span_notice("我们积蓄了足够的力量再次扫尾."))
	owner.playsound_local(owner, 'sound/effects/alien/newlarva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/xeno_action/tail_sweep/ai_should_start_consider()
	return TRUE

/datum/action/ability/xeno_action/tail_sweep/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	if(get_dist(target, xeno_owner) > 1)
		return FALSE
	if(!can_use_action(override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_xeno_hivenumber() == xeno_owner.get_xeno_hivenumber())
		return FALSE
	return TRUE

// ***************************************
// *********** Forward Charge
// ***************************************
/datum/action/ability/activable/xeno/charge/forward_charge
	name = "Forward Charge"
	desc = "冲锋最多4格并击倒沿途所有目标."
	action_icon_state = "pounce"
	action_icon = 'icons/Xeno/actions/runner.dmi'
	cooldown_duration = 10 SECONDS
	ability_cost = 80
	use_state_flags = ABILITY_USE_CRESTED|ABILITY_USE_FORTIFIED
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_FORWARD_CHARGE,
	)
	charge_range = DEFENDER_CHARGE_RANGE
	///How long is the windup before charging
	var/windup_time = 0.5 SECONDS

/datum/action/ability/activable/xeno/charge/forward_charge/use_ability(atom/A)
	if(!A)
		return

	if(!do_after(xeno_owner, windup_time, IGNORE_HELD_ITEM, xeno_owner, BUSY_ICON_DANGER, extra_checks = CALLBACK(src, PROC_REF(can_use_ability), A, FALSE, ABILITY_USE_BUSY)))
		return fail_activate()

	if(xeno_owner.fortify)
		var/datum/action/ability/xeno_action/fortify/fortify_action = xeno_owner.actions_by_path[/datum/action/ability/xeno_action/fortify]

		fortify_action.set_fortify(FALSE, TRUE)
		fortify_action.add_cooldown()
		to_chat(xeno_owner, span_xenowarning("我们迅速解除蜷缩, 准备向前猛冲."))

	xeno_owner.visible_message(span_danger("[xeno_owner]向\the [A]冲锋!"), \
	span_danger("我们向\the [A]冲锋!") )
	xeno_owner.emote("roar")
	succeed_activate()

	RegisterSignal(xeno_owner, COMSIG_XENO_OBJ_THROW_HIT, PROC_REF(obj_hit))
	RegisterSignal(xeno_owner, COMSIG_XENOMORPH_LEAP_BUMP, PROC_REF(mob_hit))
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_POST_THROW, PROC_REF(charge_complete))
	xeno_owner.xeno_flags |= XENO_LEAPING

	xeno_owner.throw_at(A, charge_range, 5, xeno_owner)

	add_cooldown()

/datum/action/ability/activable/xeno/charge/forward_charge/mob_hit(datum/source, mob/living/living_target)
	. = TRUE
	if(living_target.stat || isxeno(living_target) || !(iscarbon(living_target))) //we leap past xenos
		return
	var/mob/living/carbon/carbon_victim = living_target
	var/extra_dmg = xeno_owner.xeno_caste.melee_damage * xeno_owner.xeno_melee_damage_modifier * 0.5 // 50% dmg reduction
	carbon_victim.attack_alien_harm(xeno_owner, extra_dmg, FALSE, TRUE, FALSE, TRUE) //Location is always random, cannot crit, harm only
	var/target_turf = get_ranged_target_turf(carbon_victim, get_dir(src, carbon_victim), rand(1, 2)) //we blast our victim behind us
	target_turf = get_step_rand(target_turf) //Scatter
	carbon_victim.throw_at(get_turf(target_turf), charge_range, 5, src)
	carbon_victim.Paralyze(4 SECONDS)

/datum/action/ability/activable/xeno/charge/forward_charge/ai_should_use(atom/target)
	. = ..()
	if(!.)
		return
	action_activate()
	LAZYINCREMENT(owner.do_actions, target)
	addtimer(CALLBACK(src, PROC_REF(decrease_do_action), target), windup_time)
	return TRUE

///Decrease the do_actions of the owner
/datum/action/ability/activable/xeno/charge/forward_charge/proc/decrease_do_action(atom/target)
	LAZYDECREMENT(owner.do_actions, target)

// ***************************************
// *********** Crest defense
// ***************************************
/datum/action/ability/xeno_action/toggle_crest_defense
	name = "Toggle Crest Defense"
	desc = "以移动速度为代价提高你对投射物的抗性. 在头冠防御状态下可以使用能力."
	action_icon_state = "crest_defense"
	action_icon = 'icons/Xeno/actions/defender.dmi'
	use_state_flags = ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED // duh
	cooldown_duration = 1 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CREST_DEFENSE,
	)
	var/last_crest_bonus = 0

/datum/action/ability/xeno_action/toggle_crest_defense/give_action()
	. = ..()
	last_crest_bonus = xeno_owner.xeno_caste.crest_defense_armor

/datum/action/ability/xeno_action/toggle_crest_defense/on_xeno_upgrade()
	if(xeno_owner.crest_defense)
		xeno_owner.soft_armor = xeno_owner.soft_armor.modifyAllRatings(-last_crest_bonus)
		last_crest_bonus = xeno_owner.xeno_caste.crest_defense_armor
		xeno_owner.soft_armor = xeno_owner.soft_armor.modifyAllRatings(last_crest_bonus)
		xeno_owner.add_movespeed_modifier(MOVESPEED_ID_CRESTDEFENSE, TRUE, 0, NONE, TRUE, xeno_owner.xeno_caste.crest_defense_slowdown)
	else
		last_crest_bonus = xeno_owner.xeno_caste.crest_defense_armor

/datum/action/ability/xeno_action/toggle_crest_defense/on_cooldown_finish()
	to_chat(xeno_owner, span_notice("我们可以[xeno_owner.crest_defense ? "raise" : "lower"]我们的头冠."))
	return ..()

/datum/action/ability/xeno_action/toggle_crest_defense/action_activate()
	if(xeno_owner.crest_defense)
		set_crest_defense(FALSE)
		add_cooldown()
		return succeed_activate()

	var/was_fortified = xeno_owner.fortify
	if(xeno_owner.fortify)
		var/datum/action/ability/xeno_action/fortify/FT = xeno_owner.actions_by_path[/datum/action/ability/xeno_action/fortify]
		if(FT.cooldown_timer)
			to_chat(xeno_owner, span_xenowarning("我们还不能解除蜷缩!"))
			return fail_activate()
		FT.set_fortify(FALSE, TRUE)
		FT.add_cooldown()
		to_chat(xeno_owner, span_xenowarning("我们小心地解除蜷缩, 保持头冠低垂."))

	set_crest_defense(TRUE, was_fortified)
	add_cooldown()
	return succeed_activate()

/datum/action/ability/xeno_action/toggle_crest_defense/proc/set_crest_defense(on, silent = FALSE)
	if(on)
		if(!silent)
			to_chat(xeno_owner, span_xenowarning("我们蜷缩成防御姿态."))
		GLOB.round_statistics.defender_crest_lowerings++
		SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "defender_crest_lowerings")
		ADD_TRAIT(xeno_owner, TRAIT_STAGGERIMMUNE, CREST_DEFENSE_TRAIT) //Can now endure impacts/damages that would make lesser xenos flinch
		xeno_owner.move_resist = MOVE_FORCE_EXTREMELY_STRONG
		xeno_owner.soft_armor = xeno_owner.soft_armor.modifyAllRatings(last_crest_bonus)
		xeno_owner.add_movespeed_modifier(MOVESPEED_ID_CRESTDEFENSE, TRUE, 0, NONE, TRUE, xeno_owner.xeno_caste.crest_defense_slowdown)
	else
		if(!silent)
			to_chat(xeno_owner, span_xenowarning("我们抬起我们的头冠."))
		GLOB.round_statistics.defender_crest_raises++
		SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "defender_crest_raises")
		REMOVE_TRAIT(xeno_owner, TRAIT_STAGGERIMMUNE, CREST_DEFENSE_TRAIT)
		xeno_owner.move_resist = initial(xeno_owner.move_resist)
		xeno_owner.soft_armor = xeno_owner.soft_armor.modifyAllRatings(-last_crest_bonus)
		xeno_owner.remove_movespeed_modifier(MOVESPEED_ID_CRESTDEFENSE)

	xeno_owner.crest_defense = on
	xeno_owner.update_icons()

// ***************************************
// *********** Fortify
// ***************************************
/datum/action/ability/xeno_action/fortify
	name = "Fortify"
	desc = "扎稳脚跟以获得大幅防御加成."
	action_icon_state = "fortify"
	action_icon = 'icons/Xeno/actions/defender.dmi'
	use_state_flags = ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED // duh
	cooldown_duration = 1 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_FORTIFY,
	)
	var/last_fortify_bonus = 0
	var/move_on_fortifed = FALSE

/datum/action/ability/xeno_action/fortify/give_action(mob/living/L)
	. = ..()
	last_fortify_bonus = xeno_owner.xeno_caste.fortify_armor
	RegisterSignals(L, list(COMSIG_MOB_CRIT, COMSIG_MOB_DEATH), PROC_REF(on_crit))

/datum/action/ability/xeno_action/fortify/remove_action(mob/living/L)
	UnregisterSignal(L, list(COMSIG_MOB_CRIT, COMSIG_MOB_DEATH))
	return ..()

/datum/action/ability/xeno_action/fortify/on_xeno_upgrade()
	if(xeno_owner.fortify)
		xeno_owner.soft_armor = xeno_owner.soft_armor.modifyAllRatings(-last_fortify_bonus)
		xeno_owner.soft_armor = xeno_owner.soft_armor.modifyRating(BOMB = -last_fortify_bonus)

		last_fortify_bonus = xeno_owner.xeno_caste.fortify_armor

		xeno_owner.soft_armor = xeno_owner.soft_armor.modifyAllRatings(last_fortify_bonus)
		xeno_owner.soft_armor = xeno_owner.soft_armor.modifyRating(BOMB = last_fortify_bonus)
	else
		last_fortify_bonus = xeno_owner.xeno_caste.fortify_armor

/datum/action/ability/xeno_action/fortify/on_cooldown_finish()
	to_chat(xeno_owner, span_notice("我们可以再次[xeno_owner.fortify ? "stand up" : "fortify"]了."))
	return ..()

/datum/action/ability/xeno_action/fortify/action_activate()
	if(xeno_owner.fortify)
		set_fortify(FALSE)
		add_cooldown()
		return succeed_activate()

	var/was_crested = xeno_owner.crest_defense
	if(xeno_owner.crest_defense)
		var/datum/action/ability/xeno_action/toggle_crest_defense/CD = xeno_owner.actions_by_path[/datum/action/ability/xeno_action/toggle_crest_defense]
		if(CD.cooldown_timer)
			to_chat(xeno_owner, span_xenowarning("我们还不能转入防御姿态!"))
			return fail_activate()
		CD.set_crest_defense(FALSE, TRUE)
		CD.add_cooldown()
		to_chat(xeno_owner, span_xenowarning("我们将低垂的头冠缩回体内."))

	var/datum/action/ability/activable/xeno/charge/forward_charge/combo_cooldown = xeno_owner.actions_by_path[/datum/action/ability/activable/xeno/charge/forward_charge]
	combo_cooldown?.add_cooldown(cooldown_duration)

	set_fortify(TRUE, was_crested)
	add_cooldown()
	return succeed_activate()

/datum/action/ability/xeno_action/fortify/proc/set_fortify(on, silent = FALSE)
	GLOB.round_statistics.defender_fortifiy_toggles++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "defender_fortifiy_toggles")
	if(on)
		if(move_on_fortifed)
			xeno_owner.add_movespeed_modifier(MOVESPEED_ID_FORTIFY, TRUE, 0, NONE, TRUE, 5)
		else
			ADD_TRAIT(xeno_owner, TRAIT_IMMOBILE, FORTIFY_TRAIT)
		ADD_TRAIT(xeno_owner, TRAIT_STOPS_TANK_COLLISION, FORTIFY_TRAIT)
		if(!silent)
			to_chat(xeno_owner, span_xenowarning("我们蜷缩成防御姿态."))
		xeno_owner.soft_armor = xeno_owner.soft_armor.modifyAllRatings(last_fortify_bonus)
		xeno_owner.soft_armor = xeno_owner.soft_armor.modifyRating(BOMB = last_fortify_bonus) //double bomb bonus for explosion immunity
		owner.drop_all_held_items() // drop items (hugger/jelly)
	else
		if(!silent)
			to_chat(xeno_owner, span_xenowarning("我们恢复正常姿态."))
		xeno_owner.soft_armor = xeno_owner.soft_armor.modifyAllRatings(-last_fortify_bonus)
		xeno_owner.soft_armor = xeno_owner.soft_armor.modifyRating(BOMB = -last_fortify_bonus)
		if(move_on_fortifed)
			xeno_owner.remove_movespeed_modifier(MOVESPEED_ID_FORTIFY)
		else
			REMOVE_TRAIT(xeno_owner, TRAIT_IMMOBILE, FORTIFY_TRAIT)
		REMOVE_TRAIT(xeno_owner, TRAIT_STOPS_TANK_COLLISION, FORTIFY_TRAIT)

	xeno_owner.fortify = on
	xeno_owner.anchored = on
	playsound(xeno_owner.loc, 'sound/effects/stonedoor_openclose.ogg', 30, TRUE)
	xeno_owner.update_icons()

/datum/action/ability/xeno_action/fortify/proc/on_crit()
	SIGNAL_HANDLER
	set_fortify(FALSE, TRUE)

/datum/action/ability/xeno_action/fortify/steel_crest
	move_on_fortifed = TRUE

// ***************************************
// *********** Regenerate Skin
// ***************************************
/datum/action/ability/xeno_action/regenerate_skin
	name = "Regenerate Skin"
	desc = "再生你的坚硬外骨骼皮肤, 恢复部分生命值并移除所有破损."
	action_icon_state = "regenerate_skin"
	action_icon = 'icons/Xeno/actions/defender.dmi'
	use_state_flags = ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED|ABILITY_TARGET_SELF|ABILITY_IGNORE_SELECTED_ABILITY|ABILITY_KEYBIND_USE_ABILITY
	ability_cost = 80
	cooldown_duration = 1 MINUTES
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_REGENERATE_SKIN,
	)

/datum/action/ability/xeno_action/regenerate_skin/on_cooldown_finish()
	to_chat(xeno_owner, span_notice("我们感觉已准备好蜕去皮肤并长出新的."))
	return ..()

/datum/action/ability/xeno_action/regenerate_skin/action_activate()
	if(!can_use_action(TRUE))
		return fail_activate()

	if(xeno_owner.on_fire)
		to_chat(xeno_owner, span_xenowarning("着火时无法使用该能力."))
		return fail_activate()

	xeno_owner.emote("roar")
	xeno_owner.visible_message(span_warning("\the [xeno_owner]的皮肤碎裂, 可以看到新的皮肤层取而代之!"),
		span_notice("我们蜕去皮肤, 露出下方崭新的皮肤层!"))

	xeno_owner.do_jitter_animation(1000)
	xeno_owner.set_sunder(0)
	xeno_owner.heal_overall_damage(50, 50, updating_health = TRUE)
	add_cooldown()
	return succeed_activate()


// ***************************************
// *********** Centrifugal force
// ***************************************
/datum/action/ability/xeno_action/centrifugal_force
	name = "Centrifugal force"
	desc = "快速旋转并击中你周围所有相邻人类, 将其击退并击倒. 头冠激活时消耗双倍等离子体."
	action_icon_state = "centrifugal_force"
	action_icon = 'icons/Xeno/actions/defender.dmi'
	ability_cost = 15
	use_state_flags = ABILITY_USE_CRESTED
	cooldown_duration = 30 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CENTRIFUGAL_FORCE,
	)
	///bool whether we should take a random step this tick
	var/step_tick = FALSE
	///timer hash for the timer we use when spinning
	var/spin_loop_timer

/datum/action/ability/xeno_action/centrifugal_force/can_use_action(silent, override_flags)
	if(spin_loop_timer)
		return TRUE
	. = ..()
	if(xeno_owner.crest_defense && xeno_owner.plasma_stored < (ability_cost * 2))
		to_chat(xeno_owner, span_xenowarning("我们的等离子体不够, 还需要[(ability_cost * 2) - xeno_owner.plasma_stored]点等离子体!"))
		return FALSE

/datum/action/ability/xeno_action/centrifugal_force/action_activate()
	if(spin_loop_timer)
		stop_spin()
		return
	if(!can_use_action(TRUE))
		return fail_activate()
	if(!do_after(owner, 0.5 SECONDS, NONE, owner, BUSY_ICON_DANGER, extra_checks = CALLBACK(src, PROC_REF(can_use_action), FALSE, ABILITY_USE_BUSY)))
		return fail_activate()
	owner.visible_message(span_xenowarning("\The [owner]开始环形扫动尾巴!"), \
		span_xenowarning("我们开始大幅环形扫动尾巴!"))
	do_spin() //kick it off

	spin_loop_timer = addtimer(CALLBACK(src, PROC_REF(do_spin)), 5, TIMER_STOPPABLE)
	add_cooldown()
	RegisterSignals(owner, list(SIGNAL_ADDTRAIT(TRAIT_FLOORED), SIGNAL_ADDTRAIT(TRAIT_INCAPACITATED), SIGNAL_ADDTRAIT(TRAIT_IMMOBILE)), PROC_REF(stop_spin))

/// runs a spin, then starts the timer for a new spin if needed
/datum/action/ability/xeno_action/centrifugal_force/proc/do_spin()
	spin_loop_timer = null
	xeno_owner.spin(4, 1)
	xeno_owner.enable_throw_parry(0.6 SECONDS)
	playsound(xeno_owner, pick('sound/effects/alien/tail_swipe1.ogg','sound/effects/alien/tail_swipe2.ogg','sound/effects/alien/tail_swipe3.ogg'), 25, 1) //Sound effects

	for(var/obj/item/explosive/grenade/G in orange (1, xeno_owner))
		G.knockback(xeno_owner, 6, 2)

	for(var/obj/machinery/deployable/mounted/sentry/sentry in orange (1, xeno_owner))
		var/damage = xeno_owner.xeno_caste.melee_damage
		sentry.take_damage(damage, BRUTE, MELEE)
		sentry.knock_down()

	for(var/mob/living/carbon/human/slapped in orange(1, xeno_owner))
		if(slapped.stat == DEAD)
			continue
		slapped.add_filter("defender_tail_sweep", 2, gauss_blur_filter(1)) //Add cool SFX; motion blur
		addtimer(CALLBACK(slapped, TYPE_PROC_REF(/datum, remove_filter), "defender_tail_sweep"), 0.5 SECONDS) //Remove cool SFX
		var/damage = xeno_owner.xeno_caste.melee_damage * 0.5
		var/affecting = slapped.get_limb(ran_zone(null, 0))
		if(!affecting)
			affecting = slapped.get_limb("chest")
		slapped.knockback(xeno_owner, 1, 4)
		slapped.apply_damage(damage, BRUTE, affecting, MELEE)
		slapped.apply_damage(damage, STAMINA, updating_health = TRUE)
		slapped.Paralyze(0.3 SECONDS)
		shake_camera(slapped, 2, 1)

		to_chat(slapped, span_xenowarning("我们被\the [xeno_owner]的飞旋尾巴击中!"))
		playsound(slapped, 'sound/weapons/alien_claw_block.ogg', 50, 1)

	succeed_activate(xeno_owner.crest_defense ? ability_cost * 2 : ability_cost)
	if(step_tick)
		step(xeno_owner, pick(GLOB.alldirs))
	step_tick = !step_tick

	if(can_use_action(xeno_owner, ABILITY_IGNORE_COOLDOWN))
		spin_loop_timer = addtimer(CALLBACK(src, PROC_REF(do_spin)), 5, TIMER_STOPPABLE)
		return
	stop_spin()

/// stops spin and unregisters all listeners
/datum/action/ability/xeno_action/centrifugal_force/proc/stop_spin()
	SIGNAL_HANDLER
	if(spin_loop_timer)
		deltimer(spin_loop_timer)
		spin_loop_timer = null
	UnregisterSignal(owner, list(SIGNAL_ADDTRAIT(TRAIT_FLOORED), SIGNAL_ADDTRAIT(TRAIT_INCAPACITATED), SIGNAL_ADDTRAIT(TRAIT_IMMOBILE)))

// ***************************************
// *********** Headbutt
// ***************************************

/datum/action/ability/activable/xeno/headbutt
	name = "Headbutt"
	desc = "用头撞向指定目标."
	action_icon_state = "headbutt"
	action_icon = 'icons/Xeno/actions/defender.dmi'
	cooldown_duration = 5 SECONDS
	ability_cost = 35
	use_state_flags = ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED // yea
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_STEELCREST_HEADBUTT,
	)
	target_flags = ABILITY_MOB_TARGET
	var/base_damage = 30

/datum/action/ability/activable/xeno/headbutt/on_cooldown_finish()
	to_chat(owner, span_notice("我们积蓄了足够的力量再次头撞."))
	return ..()

/datum/action/ability/activable/xeno/headbutt/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(QDELETED(target))
		return FALSE
	if(!ishuman(target))
		return FALSE
	var/max_dist = 2 - (xeno_owner.crest_defense)
	if(!line_of_sight(owner, target, max_dist))
		if(!silent)
			to_chat(owner, span_warning("我们必须靠近才能头撞"))
		return FALSE
	if(ishuman(target))
		var/mob/living/carbon/human/victim = target
		if(isnestedhost(victim))
			return FALSE
		if(!CHECK_BITFIELD(use_state_flags|override_flags, ABILITY_IGNORE_DEAD_TARGET) && victim.stat == DEAD)
			return FALSE

/datum/action/ability/activable/xeno/headbutt/use_ability(mob/living/victim)
	var/headbutt_distance = 1 + (xeno_owner.crest_defense * 2) + (xeno_owner.fortify * 2)
	var/headbutt_damage = base_damage - (xeno_owner.crest_defense * 10)

	if(!xeno_owner.crest_defense)
		add_cooldown()
		xeno_owner.throw_at(get_step_towards(victim, xeno_owner), 4, 3, owner)
	if(!xeno_owner.Adjacent(victim))
		succeed_activate()
		return

	owner.visible_message(span_xenowarning("[owner]用装甲头冠猛撞[victim]!"), \
	span_xenowarning("我们用装甲头冠猛撞[victim]!"))

	victim.apply_damage(headbutt_damage, BRUTE, BODY_ZONE_CHEST, MELEE)

	xeno_owner.do_attack_animation(victim)

	var/facing = get_dir(xeno_owner, victim)
	var/turf/T = victim.loc
	var/turf/temp
	for(var/x in 1 to headbutt_distance)
		temp = get_step(T, facing)
		if(!temp)
			break
		T = temp
	victim.throw_at(T, headbutt_distance, 1, owner, TRUE)

	playsound(victim,'sound/weapons/alien_claw_block.ogg', 75, 1)

	succeed_activate()
	add_cooldown()

	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "headbutts")

/datum/action/ability/xeno_action/soak
	name = "soak"
	desc = "激活后追踪6秒内受到的伤害, 一旦伤害量达到140, 防御者恢复80点生命值. 如果未达到伤害阈值, 则不会发生任何事."
	action_icon_state = "soak"
	action_icon = 'icons/Xeno/actions/defender.dmi'
	cooldown_duration = 17 SECONDS
	ability_cost = 35
	use_state_flags = ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED // yea
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_STEELCREST_SOAK,
	)
	/// Requires 140 damage taken within 6 seconds to activate the ability
	var/damage_threshold = 140
	/// Heal
	var/heal_amount = 80
	/// Sunder heal
	var/heal_sunder_amount = 25
	/// Initially zero, gets damage added when the ability is activated
	var/damage_accumulated = 0

/datum/action/ability/xeno_action/soak/action_activate(atom/target)
	RegisterSignal(xeno_owner, COMSIG_XENOMORPH_TAKING_DAMAGE, PROC_REF(damage_accumulate))
	addtimer(CALLBACK(src, PROC_REF(stop_accumulating)), 6 SECONDS)

	xeno_owner.balloon_alert(xeno_owner, "开始承受来袭伤害!")
	to_chat(xeno_owner, span_xenonotice("我们开始承受来袭伤害!"))

	xeno_owner.add_filter("steelcrest_enraging", 1, list("type" = "outline", "color" = "#421313", "size" = 1))

	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/soak/proc/damage_accumulate(datum/source, damage)
	SIGNAL_HANDLER

	damage_accumulated += damage

	if(damage_accumulated >= damage_threshold)
		INVOKE_ASYNC(src, PROC_REF(enraged), owner)
		UnregisterSignal(owner, COMSIG_XENOMORPH_TAKING_DAMAGE) // Two Unregistersignal because if the enrage proc doesnt happen, then it needs to stop counting

/datum/action/ability/xeno_action/soak/proc/stop_accumulating()
	UnregisterSignal(owner, COMSIG_XENOMORPH_TAKING_DAMAGE)

	damage_accumulated = 0
	to_chat(owner, span_xenonotice("我们停止承受来袭伤害."))
	owner.remove_filter("steelcrest_enraging")

/datum/action/ability/xeno_action/soak/proc/enraged(mob/living/carbon/xenomorph/enraged_mob)
	enraged_mob.remove_filter("steelcrest_enraging")
	enraged_mob.add_filter("steelcrest_enraged", 1, list("type" = "outline", "color" = "#ad1313", "size" = 1))

	enraged_mob.visible_message(span_warning("[enraged_mob]在受到足够伤害后陷入狂怒!"), \
	span_warning("我们在承受来袭伤害后感到狂怒!"))
	enraged_mob.emote("roar") // reeeeeeeeeee

	enraged_mob.heal_xeno_damage(heal_amount, FALSE)
	enraged_mob.adjust_sunder(-heal_sunder_amount)

	addtimer(CALLBACK(enraged_mob, TYPE_PROC_REF(/datum, remove_filter), "steelcrest_enraged"), 3 SECONDS)
