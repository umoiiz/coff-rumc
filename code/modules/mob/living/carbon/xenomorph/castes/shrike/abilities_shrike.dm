#define CALLING_BURROWED_DURATION 15 SECONDS

// ***************************************
// *********** Call of the Burrowed
// ***************************************
/datum/action/ability/xeno_action/call_of_the_burrowed
	name = "Call of the Burrowed"
	desc = "尝试召唤所有当前潜藏的幼虫."
	action_icon = 'icons/Xeno/actions/general.dmi'
	action_icon_state = "larva_growth"
	ability_cost = 400
	cooldown_duration = 2 MINUTES
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CALL_OF_THE_BURROWED,
	)
	use_state_flags = ABILITY_USE_LYING

/datum/action/ability/xeno_action/call_of_the_burrowed/action_activate()
	if(!isnormalhive(xeno_owner.hive))
		to_chat(xeno_owner, span_warning("潜藏的幼虫? 多么奇怪的概念... 这不适合我们的巢穴."))
		return FALSE
	var/datum/job/xeno_job = SSjob.GetJobType(/datum/job/xenomorph)
	var/stored_larva = xeno_job.total_positions - xeno_job.current_positions
	if(!stored_larva)
		to_chat(xeno_owner, span_warning("我们的巢穴目前没有潜藏的幼虫可召唤!"))
		return FALSE

	playsound(xeno_owner,'sound/magic/invoke_general.ogg', 75, TRUE)
	new /obj/effect/temp_visual/telekinesis(get_turf(xeno_owner))
	xeno_owner.visible_message(span_xenowarning("一种奇怪的嗡嗡声开始从\the [xeno_owner]发出!"), \
	span_xenodanger("我们召唤幼虫从沉睡中苏醒!"))

	if(stored_larva)
		RegisterSignals(xeno_owner.hive, list(COMSIG_HIVE_XENO_MOTHER_PRE_CHECK, COMSIG_HIVE_XENO_MOTHER_CHECK), PROC_REF(is_burrowed_larva_host))
		xeno_owner.hive.give_larva_to_next_in_queue()
		notify_ghosts("\The <b>[xeno_owner]</b> is calling for the burrowed larvas to wake up!", enter_link = "join_larva=1", enter_text = "Join as Larva", source = xeno_owner, action = NOTIFY_JOIN_AS_LARVA, flashwindow = TRUE)
		addtimer(CALLBACK(src, PROC_REF(calling_larvas_end), xeno_owner), CALLING_BURROWED_DURATION)

	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/call_of_the_burrowed/proc/calling_larvas_end(mob/living/carbon/xenomorph/xeno_owner)
	UnregisterSignal(xeno_owner.hive, list(COMSIG_HIVE_XENO_MOTHER_PRE_CHECK, COMSIG_HIVE_XENO_MOTHER_CHECK))

/datum/action/ability/xeno_action/call_of_the_burrowed/proc/is_burrowed_larva_host(datum/source, list/mothers, list/silos) //Should only register while a viable candidate.
	SIGNAL_HANDLER
	if(!owner.incapacitated())
		mothers += owner //Adding them to the list.

/datum/action/ability/xeno_action/call_of_the_burrowed/free
	ability_cost = 0

// ***************************************
// *********** Psychic Grab
// ***************************************
/datum/action/ability/activable/xeno/psychic_grab
	name = "Psychic Grab"
	desc = "将目标吸引到技能拥有者身边."
	action_icon_state = "grab"
	action_icon = 'icons/Xeno/actions/shrike.dmi'
	cooldown_duration = 12 SECONDS
	ability_cost = 100
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PSYCHIC_GRAB,
	)
	target_flags = ABILITY_MOB_TARGET

/datum/action/ability/activable/xeno/psychic_grab/on_cooldown_finish()
	to_chat(owner, span_notice("我们聚集了足够的精神力量再次抓取某物."))
	return ..()

/datum/action/ability/activable/xeno/psychic_grab/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(QDELETED(target))
		return FALSE
	if(!isitem(target) && !ishuman(target) && !isdroid(target))	//only items, droids, and mobs can be flung.
		return FALSE
	var/max_dist = 5
	if(!line_of_sight(owner, target, max_dist))
		if(!silent)
			to_chat(owner, span_warning("我们必须靠近才能抓取, 我们的心灵无法触及这么远."))
		return FALSE
	if(ishuman(target))
		var/mob/living/carbon/human/victim = target
		if(isnestedhost(victim))
			return FALSE
		if(!CHECK_BITFIELD(use_state_flags|override_flags, ABILITY_IGNORE_DEAD_TARGET) && victim.stat == DEAD)
			return FALSE

/datum/action/ability/activable/xeno/psychic_grab/use_ability(atom/target)
	var/mob/living/victim = target

	owner.visible_message(span_xenowarning("一股奇怪而猛烈的灵能光环突然从\the [owner]发出!"), \
	span_xenowarning("我们正以心灵之力迅速吸引[victim]!"))
	victim.visible_message(span_xenowarning("[victim]正被一股无形的力量迅速吸引走!"), \
	span_xenowarning("你正被一股无形的力量迅速吸引向侧面!"))
	playsound(owner,'sound/effects/magic.ogg', 75, 1)
	playsound(victim,'sound/weapons/alien_claw_block.ogg', 75, 1)
	succeed_activate()
	add_cooldown()
	if(ishuman(victim))
		victim.apply_effects(0.4, 0.1) 	// The fling stuns you enough to remove your gun, otherwise the marine effectively isn't stunned for long.
		shake_camera(victim, 2, 1)

	var/grab_distance = (isitem(victim)) ? 5 : 4 //Objects get flung further away.

	victim.throw_at(owner, grab_distance, 1, owner, TRUE)

// ***************************************
// *********** Psychic Fling
// ***************************************
/datum/action/ability/activable/xeno/psychic_fling
	name = "Psychic Fling"
	desc = "将敌人或物品击飞.一种近距离能力."
	action_icon_state = "fling"
	action_icon = 'icons/Xeno/actions/shrike.dmi'
	cooldown_duration = 12 SECONDS
	ability_cost = 100
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PSYCHIC_FLING,
	)
	target_flags = ABILITY_MOB_TARGET

/datum/action/ability/activable/xeno/psychic_fling/on_cooldown_finish()
	to_chat(owner, span_notice("我们聚集了足够的精神力量再次投掷某物."))
	return ..()

/datum/action/ability/activable/xeno/psychic_fling/can_use_ability(atom/movable/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(QDELETED(target))
		return FALSE
	if(!isitem(target) && !ishuman(target) && !isdroid(target))	//only items, droids, and mobs can be flung.
		return FALSE
	if(target.move_resist >= MOVE_FORCE_OVERPOWERING)
		return FALSE
	var/max_dist = 3 //the distance only goes to 3 now, since this is more of a utility then an attack.
	if(!line_of_sight(owner, target, max_dist))
		if(!silent)
			to_chat(owner, span_warning("我们必须靠近才能投掷,我们的心灵无法触及这么远."))
		return FALSE
	if(ishuman(target))
		var/mob/living/carbon/human/victim = target
		if(isnestedhost(victim))
			return FALSE
		if(!CHECK_BITFIELD(use_state_flags|override_flags, ABILITY_IGNORE_DEAD_TARGET) && victim.stat == DEAD)
			return FALSE

/datum/action/ability/activable/xeno/psychic_fling/use_ability(atom/target)
	var/mob/living/victim = target
	GLOB.round_statistics.psychic_flings++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "psychic_flings")

	owner.visible_message(span_xenowarning("一股奇异而狂暴的灵能光环突然从\the [owner]散发出来!"), \
	span_xenowarning("我们以心灵之力猛烈投掷[victim]!"))
	victim.visible_message(span_xenowarning("[victim]被一股无形的力量猛烈击飞!"), \
	span_xenowarning("你被一股无形的力量猛烈击飞向侧面!"))
	playsound(owner,'sound/effects/magic.ogg', 75, 1)
	playsound(victim,'sound/weapons/alien_claw_block.ogg', 75, 1)

	succeed_activate()
	add_cooldown()
	if(ishuman(victim))
		victim.apply_effects(2 SECONDS, 0.2 SECONDS) 	// The fling stuns you enough to remove your gun, otherwise the marine effectively isn't stunned for long.
		shake_camera(victim, 2, 1)

	var/facing = get_dir(owner, victim)
	var/fling_distance = (isitem(victim)) ? 4 : 3 //Objects get flung further away.
	var/turf/T = victim.loc
	var/turf/temp

	for(var/x in 1 to fling_distance)
		temp = get_step(T, facing)
		if(!temp)
			break
		T = temp
	victim.throw_at(T, fling_distance, 1, owner, TRUE)

// ***************************************
// *********** Unrelenting Force
// ***************************************
/datum/action/ability/activable/xeno/unrelenting_force
	name = "Unrelenting Force"
	desc = "释放我们原始的灵能,推开任何挡在我们路上的人."
	action_icon_state = "screech"
	action_icon = 'icons/Xeno/actions/queen.dmi'
	cooldown_duration = 20 SECONDS
	ability_cost = 300
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY | ABILITY_IGNORE_SELECTED_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_UNRELENTING_FORCE,
		KEYBINDING_ALTERNATE = COMSIG_XENOABILITY_UNRELENTING_FORCE_SELECT,
	)

/datum/action/ability/activable/xeno/unrelenting_force/on_cooldown_finish()
	to_chat(owner, span_notice("我们的心灵已准备好释放另一波力量冲击."))
	return ..()

/datum/action/ability/activable/xeno/unrelenting_force/use_ability(atom/target)
	succeed_activate()
	add_cooldown()
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob, update_icons)), 1 SECONDS)
	xeno_owner.icon_state = "[xeno_owner.xeno_caste.caste_name] Screeching"
	if(target) // Keybind use doesn't have a target
		owner.face_atom(target)

	var/turf/lower_left
	var/turf/upper_right
	switch(owner.dir)
		if(NORTH)
			lower_left = locate(owner.x - 1, owner.y + 1, owner.z)
			upper_right = locate(owner.x + 1, owner.y + 3, owner.z)
		if(SOUTH)
			lower_left = locate(owner.x - 1, owner.y - 3, owner.z)
			upper_right = locate(owner.x + 1, owner.y - 1, owner.z)
		if(WEST)
			lower_left = locate(owner.x - 3, owner.y - 1, owner.z)
			upper_right = locate(owner.x - 1, owner.y + 1, owner.z)
		if(EAST)
			lower_left = locate(owner.x + 1, owner.y - 1, owner.z)
			upper_right = locate(owner.x + 3, owner.y + 1, owner.z)

	var/list/things_to_throw = list()
	for(var/turf/affected_tile in block(lower_left, upper_right)) //everything in the 3x3 block is found.
		affected_tile.Shake(duration = 0.5 SECONDS)
		for(var/atom/movable/affected AS in affected_tile)
			if(!ishuman(affected) && !istype(affected, /obj/item) && !isdroid(affected))
				affected.Shake(duration = 0.5 SECONDS)
				continue
			if(affected.move_resist >= MOVE_FORCE_OVERPOWERING)
				continue
			if(ishuman(affected))
				var/mob/living/carbon/human/H = affected
				if(H.stat == DEAD)
					continue
				H.apply_effects(paralyze = 2 SECONDS)
				shake_camera(H, 2, 1)
			things_to_throw += affected

	for(var/atom/movable/affected AS in things_to_throw)
		var/throwlocation = affected.loc
		for(var/x in 1 to 6)
			throwlocation = get_step(throwlocation, owner.dir)
		affected.throw_at(throwlocation, 6, 1, owner, TRUE)

	owner.visible_message(span_xenowarning("[owner]释放出一股巨大的灵能冲击!"), \
	span_xenowarning("我们释放出一股巨大的灵能冲击!"))

	playsound(owner,'sound/effects/bamf.ogg', 75, TRUE)
	playsound(owner, SFX_ALIEN_ROAR, 50)

// ***************************************
// *********** Psychic Cure
// ***************************************
/datum/action/ability/activable/xeno/psychic_cure
	name = "Psychic Cure"
	desc = "治疗并移除目标身上的负面效果."
	action_icon_state = "heal_xeno"
	action_icon = 'icons/Xeno/actions/drone.dmi'
	cooldown_duration = 1 MINUTES
	ability_cost = 200
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PSYCHIC_CURE,
	)
	target_flags = ABILITY_MOB_TARGET
	var/heal_range = SHRIKE_HEAL_RANGE

/datum/action/ability/activable/xeno/psychic_cure/on_cooldown_finish()
	to_chat(owner, span_notice("我们聚集了足够的精神力量再次治愈姐妹们."))
	return ..()

/datum/action/ability/activable/xeno/psychic_cure/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(QDELETED(target))
		return FALSE
	if(!isxeno(target))
		return FALSE
	var/mob/living/carbon/xenomorph/patient = target
	if(!CHECK_BITFIELD(use_state_flags|override_flags, ABILITY_IGNORE_DEAD_TARGET) && patient.stat == DEAD)
		if(!silent)
			to_chat(owner, span_warning("太迟了.这位姐妹回不来了."))
		return FALSE
	if(!check_distance(patient, silent))
		return FALSE

/datum/action/ability/activable/xeno/psychic_cure/proc/check_distance(atom/target, silent)
	var/dist = get_dist(owner, target)
	if(dist > heal_range)
		if(!silent)
			to_chat(owner, span_warning("超出我们的触及范围...我们需要再靠近[dist - heal_range]步!"))
		return FALSE
	else if(!line_of_sight(owner, target, heal_range))
		if(!silent)
			to_chat(owner, span_warning("没有清晰的视线,我们无法正常集中精神!"))
		return FALSE
	return TRUE

/datum/action/ability/activable/xeno/psychic_cure/use_ability(atom/target)
	if(owner.do_actions)
		return FALSE

	owner.face_atom(target) //Face the target so we don't look stupid
	if(!do_after(owner, 1 SECONDS, NONE, target, BUSY_ICON_FRIENDLY, BUSY_ICON_MEDICAL))
		return FALSE

	if(owner.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
		personal_statistics.heals++
	GLOB.round_statistics.psychic_cures++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "psychic_cures")
	owner.visible_message(span_xenowarning("一股奇异的灵能光环突然从\the [owner]散发出来!"), \
	span_xenowarning("我们以心灵之力治愈[target]!"))
	target.visible_message(span_xenowarning("[target]突然闪烁着寒冷的光芒."), \
	span_xenowarning("我们感到一阵突然的舒缓寒意."))

	playsound(target,'sound/effects/magic.ogg', 75, 1)
	new /obj/effect/temp_visual/telekinesis(get_turf(target))
	var/mob/living/carbon/xenomorph/patient = target
	patient.heal_wounds(SHRIKE_CURE_HEAL_MULTIPLIER)
	patient.adjust_sunder(-SHRIKE_CURE_HEAL_MULTIPLIER)
	if(patient.health > 0) //If they are not in crit after the heal, let's remove evil debuffs.
		patient.SetUnconscious(0)
		patient.SetStun(0)
		patient.SetParalyzed(0)
		patient.set_stagger(0)
		patient.set_slowdown(0)
	patient.update_health()

	owner.changeNext_move(CLICK_CD_RANGE)

	log_combat(owner, patient, "psychically cured")

	succeed_activate()
	add_cooldown()

// ***************************************
// *********** Construct Acid Well
// ***************************************
/datum/action/ability/xeno_action/place_acidwell
	name = "Place acid well"
	desc = "放置一个酸液井,可以扑灭火焰并摧毁粘性手雷."
	action_icon_state = "place_trap"
	action_icon = 'icons/Xeno/actions/construction.dmi'
	ability_cost = 200
	cooldown_duration = 2 MINUTES
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PLACE_ACID_WELL,
	)
	use_state_flags = ABILITY_USE_LYING

/datum/action/ability/xeno_action/place_acidwell/can_use_action(silent = FALSE, override_flags)
	. = ..()
	var/turf/T = get_turf(owner)
	if(!T || !T.is_weedable() || T.density)
		if(!silent)
			to_chat(owner, span_warning("我们无法在这里这么做."))
		return FALSE

	if(!xeno_owner.loc_weeds_type)
		if(!silent)
			to_chat(owner, span_warning("我们只能在杂草上塑形.在开始建造之前,我们必须先找到一些树脂!"))
		return FALSE

	if(!T.check_alien_construction(owner, silent, /obj/structure/xeno/acidwell))
		return FALSE

	if(!T.check_disallow_alien_fortification(owner, silent))
		return FALSE

/datum/action/ability/xeno_action/place_acidwell/action_activate()
	var/turf/T = get_turf(owner)

	for(var/obj/structure/xeno/acidwell/well in range(1, T))
		owner.balloon_alert(owner, span_notice("另一个酸液井太近了!"))
		return

	if(!do_after(owner, 0.5 SECONDS, NONE, T, BUSY_ICON_BUILD))
		return

	playsound(T, SFX_ALIEN_RESIN_BUILD, 25)
	new /obj/structure/xeno/acidwell(T, owner)

	succeed_activate()
	to_chat(owner, span_xenonotice("我们放置了一个酸液井;它可以被注入更多酸液."))
	GLOB.round_statistics.xeno_acid_wells++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "xeno_acid_wells")
	owner.record_traps_created()

// ***************************************
// *********** Psychic Vortex
// ***************************************

#define VORTEX_RANGE 4
#define VORTEX_INITIAL_CHARGE 2 SECONDS
#define VORTEX_POST_INITIAL_CHARGE 0.5 SECONDS

/datum/action/ability/activable/xeno/psychic_vortex
	name = "Pyschic vortex"
	desc = "引导一个相当大的灵能漩涡,将附近的敌人吸入."
	action_icon_state = "vortex"
	action_icon = 'icons/Xeno/actions/shrike.dmi'
	ability_cost = 600
	cooldown_duration = 2 MINUTES
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PSYCHIC_VORTEX,
	)
	/// Used for particles. Holds the particles instead of the mob. See particle_holder for documentation.
	var/obj/effect/abstract/particle_holder/particle_holder
	///The particle type this ability uses
	var/channel_particle = /particles/warlock_charge

/datum/action/ability/activable/xeno/psychic_vortex/on_cooldown_finish()
	to_chat(owner, span_notice("我们的心灵已准备好释放另一个混沌的能量漩涡."))
	return ..()

/datum/action/ability/activable/xeno/psychic_vortex/use_ability(atom/target)
	succeed_activate()
	add_cooldown()

	particle_holder = new(owner, channel_particle)
	particle_holder.pixel_x = 15
	particle_holder.pixel_y = 0

	if(target) // Keybind use doesn't have a target
		owner.face_atom(target)
	ADD_TRAIT(owner, TRAIT_IMMOBILE, VORTEX_ABILITY_TRAIT)
	if(do_after(owner, VORTEX_INITIAL_CHARGE, IGNORE_HELD_ITEM, owner, BUSY_ICON_DANGER))
		vortex_pull()
	if(do_after(owner, VORTEX_POST_INITIAL_CHARGE, IGNORE_HELD_ITEM, owner, BUSY_ICON_DANGER))
		vortex_push()
	if(do_after(owner, VORTEX_POST_INITIAL_CHARGE, IGNORE_HELD_ITEM, owner, BUSY_ICON_DANGER))
		vortex_pull()
	QDEL_NULL(particle_holder)
	REMOVE_TRAIT(owner, TRAIT_IMMOBILE, VORTEX_ABILITY_TRAIT)
	return

/**
 * Checks for any non-anchored movable atom, throwing them towards the shrike/owner using the ability.
 * While causing shake to anything in range with effects applied to humans affected.
 */
/datum/action/ability/activable/xeno/psychic_vortex/proc/vortex_pull()
	playsound(owner, 'sound/effects/seedling_chargeup.ogg', 60)
	for(var/atom/movable/movable_victim in range(VORTEX_RANGE, owner.loc))
		if(movable_victim.anchored || isxeno(movable_victim) || movable_victim.move_resist > MOVE_FORCE_STRONG)
			continue
		if(ishuman(movable_victim))
			var/mob/living/carbon/human/H = movable_victim
			if(H.stat == DEAD)
				continue
			H.apply_effects(paralyze = 0.1 SECONDS)
			H.adjust_stagger(2 SECONDS)
			shake_camera(H, 2, 1)
		else if(isitem(movable_victim))
			var/turf/targetturf = get_turf(owner)
			targetturf = locate(targetturf.x + rand(1, 4), targetturf.y + rand(1, 4), targetturf.z)
			movable_victim.throw_at(targetturf, 4, 1, owner, FALSE, FALSE)
		movable_victim.throw_at(owner, 4, 1, owner, FALSE, FALSE)

/// Randomly throws movable atoms in the radius of the vortex abilites range, different each use.
/datum/action/ability/activable/xeno/psychic_vortex/proc/vortex_push()
	for(var/atom/movable/movable_victim in range(VORTEX_RANGE, owner.loc))
		if(movable_victim.anchored || isxeno(movable_victim) || movable_victim.move_resist == INFINITY)
			continue
		if(ishuman(movable_victim))
			var/mob/living/carbon/human/human_victim = movable_victim
			if(human_victim.stat == DEAD)
				continue
		var/turf/targetturf = get_turf(owner)
		targetturf = locate(targetturf.x + rand(1, 4), targetturf.y + rand(1, 4), targetturf.z)
		movable_victim.throw_at(targetturf, 4, 1, owner, FALSE, FALSE)
