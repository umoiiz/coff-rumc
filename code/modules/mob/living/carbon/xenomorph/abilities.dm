// ***************************************
// *********** Universal abilities
// ***************************************
// Resting
/datum/action/ability/xeno_action/xeno_resting
	name = "Rest"
	desc = "在杂草上休息以恢复生命值和等离子体."
	action_icon_state = "resting"
	action_icon = 'icons/Xeno/actions/general.dmi'
	use_state_flags = ABILITY_USE_LYING|ABILITY_USE_CRESTED|ABILITY_USE_CLOSEDTURF|ABILITY_USE_STAGGERED|ABILITY_USE_INCAP
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_REST,
	)

/datum/action/ability/xeno_action/xeno_resting/action_activate()
	if(!istype(xeno_owner))
		return
	xeno_owner.toggle_resting()
	return succeed_activate()

// ***************************************
// *********** Drone-y abilities
// ***************************************
/datum/action/ability/activable/xeno/plant_weeds
	name = "Plant Weeds"
	desc = "在你的格子上放置一个杂草节点."
	action_icon_state = "plant_weeds"
	action_icon = 'icons/Xeno/actions/construction.dmi'
	ability_cost = 75
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_DROP_WEEDS,
		KEYBINDING_ALTERNATE = COMSIG_XENOABILITY_CHOOSE_WEEDS,
	)
	use_state_flags = ABILITY_USE_LYING
	///the maximum range of the ability
	var/max_range = 0
	///The seleted type of weeds
	var/obj/alien/weeds/node/weed_type = /obj/alien/weeds/node
	///Whether automatic weeding is active
	var/auto_weeding = FALSE
	///The turf that was last weeded
	var/turf/last_weeded_turf

/datum/action/ability/activable/xeno/plant_weeds/New(Target)
	. = ..()
	if(SSmonitor.gamestate == SHUTTERS_CLOSED)
		RegisterSignals(SSdcs, list(COMSIG_GLOB_OPEN_SHUTTERS_EARLY, COMSIG_GLOB_OPEN_TIMED_SHUTTERS_LATE), PROC_REF(update_ability_cost_shutters))

/datum/action/ability/activable/xeno/plant_weeds/can_use_action(atom/A, silent = FALSE, override_flags)
	update_ability_cost()
	return ..()

/// Updates the ability cost based on gamestate.
/datum/action/ability/activable/xeno/plant_weeds/proc/update_ability_cost(shutters_recently_opened)
	ability_cost = initial(ability_cost) * initial(weed_type.ability_cost_mult)
	ability_cost = (!shutters_recently_opened && SSmonitor.gamestate == SHUTTERS_CLOSED) ? ability_cost * 0.5 : ability_cost

/**
 * Updates the ability cost as if the gamestate was not SHUTTERS_CLOSED.
 * The signal happens at the same time of gamestate changing, so that variable cannot be depended on.
 */
/datum/action/ability/activable/xeno/plant_weeds/proc/update_ability_cost_shutters()
	SIGNAL_HANDLER
	UnregisterSignal(SSdcs, list(COMSIG_GLOB_OPEN_SHUTTERS_EARLY, COMSIG_GLOB_OPEN_TIMED_SHUTTERS_LATE))
	update_ability_cost(TRUE)
	update_button_icon()

/datum/action/ability/activable/xeno/plant_weeds/action_activate()
	if(max_range)
		return ..()
	if(can_use_action())
		plant_weeds(owner)

/datum/action/ability/activable/xeno/plant_weeds/use_ability(atom/A)
	plant_weeds(max_range ? A : get_turf(owner))

////Plant a weeds node on the selected atom
/datum/action/ability/activable/xeno/plant_weeds/proc/plant_weeds(atom/A)
	var/turf/T = get_turf(A)

	if(!T.check_alien_construction(owner, FALSE, weed_type))
		return fail_activate()

	if(!T.check_disallow_alien_fortification(null, TRUE))
		to_chat(owner, span_warning("女王母亲禁止我们在这里种植杂草."))
		return fail_activate()

	if(locate(/obj/structure/xeno/trap) in T)
		to_chat(owner, span_warning("路上有一个树脂陷阱!"))
		return fail_activate()

	if(!T.is_weedable())
		to_chat(owner, span_warning("这可不是个建花园的好地方!"))
		return fail_activate()

	if(locate(weed_type) in T)
		to_chat(owner, span_warning("这里已经有一个荚囊了!"))
		return fail_activate()

	owner.visible_message(span_xenonotice("\The [owner] 反刍出一个脉动的节点并将其种植在地上!"), \
		span_xenonotice("我们反刍出一个脉动的节点并将其种植在地上!"), null, 5)
	new weed_type(T)
	last_weeded_turf = T
	playsound(T, SFX_ALIEN_RESIN_BUILD, 25)
	GLOB.round_statistics.weeds_planted++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "weeds_planted")
	if(owner.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
		personal_statistics.weeds_planted++
	add_cooldown()
	succeed_activate()

/datum/action/ability/activable/xeno/plant_weeds/alternate_action_activate()
	INVOKE_ASYNC(src, PROC_REF(choose_weed))
	return COMSIG_KB_ACTIVATED

///Chose which weed will be planted by the xeno owner or toggle automatic weeding
/datum/action/ability/activable/xeno/plant_weeds/proc/choose_weed()
	var/weed_choice = show_radial_menu(owner, owner, GLOB.weed_images_list, radius = 35)
	if(!weed_choice)
		return
	if(weed_choice == AUTOMATIC_WEEDING)
		toggle_auto_weeding()
	else
		for(var/obj/alien/weeds/node/weed_type_possible AS in GLOB.weed_type_list)
			if(initial(weed_type_possible.name) == weed_choice)
				weed_type = weed_type_possible
				update_ability_cost()
				break
		to_chat(owner, span_xenonotice("我们现在使用种植杂草能力时将生成 <b>[weed_choice]\s </b>."))
	update_button_icon()

///Toggles automatic weeding
/datum/action/ability/activable/xeno/plant_weeds/proc/toggle_auto_weeding()
	SIGNAL_HANDLER
	if(auto_weeding)
		UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(owner, COMSIG_MOB_DEATH)
		auto_weeding = FALSE
		to_chat(owner, span_xenonotice("我们将不再自动种植杂草."))
		return
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(weed_on_move))
	RegisterSignal(owner, COMSIG_MOB_DEATH, PROC_REF(toggle_auto_weeding))
	auto_weeding = TRUE
	to_chat(owner, span_xenonotice("我们现在将自动种植杂草."))

///Used for performing automatic weeding
/datum/action/ability/activable/xeno/plant_weeds/proc/weed_on_move(datum/source)
	if(xeno_owner.loc_weeds_type)
		return
	if(get_dist(xeno_owner, last_weeded_turf) < AUTO_WEEDING_MIN_DIST)
		return
	if(!can_use_ability(xeno_owner.loc, TRUE, ABILITY_IGNORE_SELECTED_ABILITY))
		return
	plant_weeds(xeno_owner)

/datum/action/ability/activable/xeno/plant_weeds/update_button_icon()
	name = "Plant Weeds ([ability_cost])"
	action_icon_state = initial(weed_type.name)
	if(auto_weeding)
		if(!visual_references[VREF_IMAGE_ONTOP])
			// below maptext , above selected frames
			visual_references[VREF_IMAGE_ONTOP] = image('icons/Xeno/actions/_actions.dmi', icon_state = "repeating", layer = ACTION_LAYER_IMAGE_ONTOP)
			button.add_overlay(visual_references[VREF_IMAGE_ONTOP])
	else if(visual_references[VREF_IMAGE_ONTOP])
		button.cut_overlay(visual_references[VREF_IMAGE_ONTOP])
		visual_references[VREF_IMAGE_ONTOP] = null
	return ..()

//AI stuff
/datum/action/ability/activable/xeno/plant_weeds/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/xeno/plant_weeds/ai_should_use(target)
	if(!can_use_action(override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(xeno_owner.loc_weeds_type)
		return FALSE
	return TRUE

/datum/action/ability/activable/xeno/plant_weeds/ranged
	max_range = 4

/datum/action/ability/activable/xeno/plant_weeds/ranged/can_use_ability(atom/A, silent = FALSE, override_flags)
	var/area/area = get_area(A)
	if(area.area_flags & MARINE_BASE)
		if(!silent)
			to_chat(owner, span_xenowarning("你不能在这里种植杂草!"))
		return FALSE
	if(!line_of_sight(owner, get_turf(A)))
		to_chat(owner, span_warning("没有视线你不能种植杂草!"))
		return FALSE
	return ..()

/datum/action/ability/activable/xeno/plant_weeds/ranged/can_use_action(silent = FALSE, override_flags, selecting = FALSE)
	if (owner.status_flags & INCORPOREAL)
		return FALSE
	return ..()

// Secrete Resin
/datum/action/ability/activable/xeno/secrete_resin
	name = "Secrete Resin"
	desc = "建造你选择的任何树脂"
	action_icon_state = RESIN_WALL
	action_icon = 'icons/Xeno/actions/construction.dmi'
	target_flags = ABILITY_TURF_TARGET
	ability_cost = 50
	action_type = ACTION_TOGGLE
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_SECRETE_RESIN,
	)
	///Minimum time to build a resin structure
	var/base_wait = 0.5 SECONDS
	///Multiplicator factor to add to the building time, depends on the health of the structure built
	var/scaling_wait = 1.5 SECONDS
	///List of buildable structures. Order corresponds with resin_images_list.
	var/list/buildable_structures = list(
		/turf/closed/wall/resin/regenerating,
		/turf/closed/wall/resin/regenerating/bulletproof,
		/turf/closed/wall/resin/regenerating/fireproof,
		/turf/closed/wall/resin/regenerating/hardy,
		/obj/alien/resin/sticky,
		/obj/structure/mineral_door/resin,
		/obj/structure/bed/nest,
		)
	/// Used for the dragging functionality of pre-shuttter building
	var/dragging = FALSE


/// Helper for handling the start of mouse-down and to begin the drag-building
/datum/action/ability/activable/xeno/secrete_resin/proc/start_resin_drag(mob/user, atom/object, turf/location, control, params)
	SIGNAL_HANDLER

	var/list/modifiers = params2list(params)
	//if(toggled && !(modifiers[BUTTON] == LEFT_CLICK))
	if(toggled && modifiers[BUTTON] == LEFT_CLICK)
		dragging = TRUE
		preshutter_build_resin(get_turf(object))

/// Helper for ending drag-building , activated on mose-up
/datum/action/ability/activable/xeno/secrete_resin/proc/stop_resin_drag()
	SIGNAL_HANDLER
	dragging = FALSE

/// Handles removing the dragging functionality from the action all-togheter on round-start (shutter open)
/datum/action/ability/activable/xeno/secrete_resin/proc/end_resin_drag()
	SIGNAL_HANDLER
	dragging = FALSE
	UnregisterSignal(owner, list(COMSIG_MOB_MOUSEDRAG, COMSIG_MOB_MOUSEUP, COMSIG_MOB_MOUSEDOWN))
	UnregisterSignal(SSdcs, list(COMSIG_GLOB_OPEN_SHUTTERS_EARLY, COMSIG_GLOB_OPEN_TIMED_SHUTTERS_LATE,COMSIG_GLOB_TADPOLE_LANDED_OUT_LZ,COMSIG_GLOB_DROPPOD_LANDED))

/// Extra handling for adding the action for draggin functionality (for instant building)
/datum/action/ability/activable/xeno/secrete_resin/give_action(mob/living/L)
	. = ..()
	if(!CHECK_BITFIELD(SSticker?.mode?.round_type_flags, MODE_ALLOW_XENO_QUICKBUILD))
		return
	if(!SSresinshaping.active)
		return
	var/mutable_appearance/build_maptext = mutable_appearance(icon = null,icon_state = null, layer = ACTION_LAYER_MAPTEXT)
	build_maptext.pixel_x = 12
	build_maptext.pixel_y = -5
	build_maptext.maptext = MAPTEXT(SSresinshaping.get_building_points(owner))
	visual_references[VREF_MUTABLE_BUILDING_COUNTER] = build_maptext
	RegisterSignal(owner, COMSIG_MOB_MOUSEDOWN, PROC_REF(start_resin_drag))
	RegisterSignal(owner, COMSIG_MOB_MOUSEDRAG, PROC_REF(preshutter_resin_drag))
	RegisterSignal(owner, COMSIG_MOB_MOUSEUP, PROC_REF(stop_resin_drag))
	RegisterSignals(SSdcs, list(COMSIG_GLOB_OPEN_SHUTTERS_EARLY, COMSIG_GLOB_OPEN_TIMED_SHUTTERS_LATE,COMSIG_GLOB_TADPOLE_LANDED_OUT_LZ,COMSIG_GLOB_DROPPOD_LANDED), PROC_REF(end_resin_drag))

/// Extra handling to remove the stuff needed for dragging
/datum/action/ability/activable/xeno/secrete_resin/remove_action(mob/living/carbon/xenomorph/X)
	if(!CHECK_BITFIELD(SSticker.mode?.round_type_flags, MODE_ALLOW_XENO_QUICKBUILD))
		return ..()
	UnregisterSignal(owner, list(COMSIG_MOB_MOUSEDRAG, COMSIG_MOB_MOUSEUP, COMSIG_MOB_MOUSEDOWN))
	UnregisterSignal(SSdcs, list(COMSIG_GLOB_OPEN_SHUTTERS_EARLY, COMSIG_GLOB_OPEN_TIMED_SHUTTERS_LATE,COMSIG_GLOB_TADPOLE_LANDED_OUT_LZ,COMSIG_GLOB_DROPPOD_LANDED))
	update_button_icon() //reason for the double return ..() here is owner gets unassigned in one of the parent procs, so we can't call parent before unregistering signals here
	return ..()

/datum/action/ability/activable/xeno/secrete_resin/update_button_icon()
	if(xeno_owner)
		var/atom/A = xeno_owner.selected_resin
		action_icon_state = initial(A.name)
	if(!is_gameplay_level(xeno_owner?.loc?.z))
		return ..() // prevents runtimes
	if(SSmonitor.gamestate == SHUTTERS_CLOSED && CHECK_BITFIELD(SSticker.mode?.round_type_flags, MODE_ALLOW_XENO_QUICKBUILD) && SSresinshaping.active)
		button.cut_overlay(visual_references[VREF_MUTABLE_BUILDING_COUNTER])
		var/mutable_appearance/number = visual_references[VREF_MUTABLE_BUILDING_COUNTER]
		number.maptext = MAPTEXT("[SSresinshaping.get_building_points(owner)]")
		visual_references[VREF_MUTABLE_BUILDING_COUNTER] = number
		button.add_overlay(visual_references[VREF_MUTABLE_BUILDING_COUNTER])
	else if(visual_references[VREF_MUTABLE_BUILDING_COUNTER])
		button.cut_overlay(visual_references[VREF_MUTABLE_BUILDING_COUNTER])
		visual_references[VREF_MUTABLE_BUILDING_COUNTER] = null
	return ..()

/datum/action/ability/activable/xeno/secrete_resin/action_activate()
	//Left click on the secrete resin button opens up radial menu (new type of changing structures).
	if(xeno_owner.selected_ability != src)
		return ..()
	. = ..()
	var/resin_choice = show_radial_menu(owner, owner, GLOB.resin_images_list, radius = 35)
	if(!resin_choice)
		return
	var/i = GLOB.resin_images_list.Find(resin_choice)
	xeno_owner.selected_resin = buildable_structures[i]
	var/atom/A = xeno_owner.selected_resin
	xeno_owner.balloon_alert(xeno_owner, initial(A.name))
	update_button_icon()

/datum/action/ability/activable/xeno/secrete_resin/alternate_action_activate()
	//Right click on secrete resin button cycles through to the next construction type (old method of changing structures).
	if(xeno_owner.selected_ability != src)
		return ..()
	var/i = buildable_structures.Find(xeno_owner.selected_resin)
	if(length(buildable_structures) == i)
		xeno_owner.selected_resin = buildable_structures[1]
	else
		xeno_owner.selected_resin = buildable_structures[i+1]
	var/atom/A = xeno_owner.selected_resin
	xeno_owner.balloon_alert(xeno_owner, initial(A.name))
	update_button_icon()

/datum/action/ability/activable/xeno/secrete_resin/use_ability(atom/A)
	if(get_dist(xeno_owner, A) > xeno_owner.xeno_caste.resin_max_range) //Maximum range is defined in the castedatum with resin_max_range, defaults to 0
		build_resin(get_turf(xeno_owner))
	else
		build_resin(get_turf(A))

/datum/action/ability/activable/xeno/secrete_resin/proc/get_wait()
	. = base_wait
	if(!scaling_wait)
		return

	var/build_resin_modifier = 1
	switch(xeno_owner.selected_resin)
		if(/obj/alien/resin/sticky)
			build_resin_modifier = 0.5
	return (base_wait + scaling_wait - max(0, (scaling_wait * xeno_owner.health / xeno_owner.maxHealth))) * build_resin_modifier

/// A version of build_resin with the plasma drain and distance checks removed.
/datum/action/ability/activable/xeno/secrete_resin/proc/preshutter_build_resin(turf/T)
	if(!SSresinshaping.active)
		stack_trace("[owner] ([key_name(owner)]) didn't have their quickbuild signals unregistered properly and tried using quickbuild after the subsystem was off!")
		end_resin_drag()
		return

	if(!SSresinshaping.get_building_points(owner))
		owner.balloon_alert(owner, "你已经用完了所有的快速建造点数! 等到陆战队员登陆!")
		return

	switch(is_valid_for_resin_structure(T, xeno_owner.selected_resin == /obj/structure/mineral_door/resin, xeno_owner.selected_resin))
		if(ERROR_CANT_WEED)
			owner.balloon_alert(owner, span_notice("这个位置无法支撑一个花园!"))
			return
		if(ERROR_NO_WEED)
			owner.balloon_alert(owner, span_notice("这个位置没有杂草作为支撑!"))
			return
		if(ERROR_NO_SUPPORT)
			owner.balloon_alert(owner, span_notice("这个位置没有相邻的支撑来建造该结构!"))
			return
		if(ERROR_NOT_ALLOWED)
			owner.balloon_alert(owner, span_notice("女王母亲禁止我们在这里建造."))
			return
		if(ERROR_BLOCKER)
			owner.balloon_alert(owner, span_notice("有另一个异形挡住了这个位置!"))
			return
		if(ERROR_FOG)
			owner.balloon_alert(owner, span_notice("雾气将阻止树脂成形!"))
			return
		// it fails a lot here when dragging , so its to prevent spam
		if(ERROR_CONSTRUCT)
			return
		if(ERROR_JUST_NO)
			return

	for(var/mob/living/carbon/human AS in cheap_get_humans_near(T, 7))
		if(human.client && human.stat != DEAD)
			owner.balloon_alert(owner, "附近有类人生物还活着!")
			return

	if(xeno_owner.selected_resin == /obj/structure/bed/nest)
		for(var/obj/structure/bed/nest/xeno_nest in range(2, T))
			owner.balloon_alert(owner, span_notice("另一个巢穴太近了!"))
			return

	if(xeno_owner.selected_resin == /obj/structure/mineral_door/resin)
		for(var/obj/structure/mineral_door/resin/door in range(2, T))
			owner.balloon_alert(owner, span_notice("另一个门太近了!"))
			return

	var/atom/new_resin
	if(ispath(xeno_owner.selected_resin, /turf)) // We should change turfs, not spawn them in directly
		var/list/baseturfs = islist(T.baseturfs) ? T.baseturfs : list(T.baseturfs)
		baseturfs |= T.type
		T.ChangeTurf(xeno_owner.selected_resin, baseturfs)
		new_resin = T
	else
		new_resin = new xeno_owner.selected_resin(T)
	if(new_resin)
		SSresinshaping.increment_build_counter(owner)

/datum/action/ability/activable/xeno/secrete_resin/proc/preshutter_resin_drag(datum/source, atom/src_object, atom/over_object, turf/src_location, turf/over_location, src_control, over_control, params)
	SIGNAL_HANDLER
	if(dragging)
		preshutter_build_resin(get_turf(over_object))

/datum/action/ability/activable/xeno/secrete_resin/proc/build_resin(turf/T)
	if(xeno_owner.selected_resin == /obj/structure/bed/nest)
		for(var/obj/structure/bed/nest/xeno_nest in range (2, T))
			owner.balloon_alert(owner, span_notice("另一个巢穴太近了!"))
			return
	if(xeno_owner.selected_resin == /obj/structure/mineral_door/resin)
		for(var/obj/structure/mineral_door/resin/door in range(2, T))
			owner.balloon_alert(owner, span_notice("另一个门太近了!"))
			return
	switch(is_valid_for_resin_structure(T, xeno_owner.selected_resin == /obj/structure/mineral_door/resin, xeno_owner.selected_resin))
		if(ERROR_CANT_WEED)
			owner.balloon_alert(owner, span_notice("这个位置无法支撑一个花园!"))
			return
		if(ERROR_NO_WEED)
			owner.balloon_alert(owner, span_notice("这个位置没有杂草作为支撑!"))
			return
		if(ERROR_NO_SUPPORT)
			owner.balloon_alert(owner, span_notice("这个位置没有相邻的支撑来建造该结构!"))
			return
		if(ERROR_NOT_ALLOWED)
			owner.balloon_alert(owner, span_notice("女王母亲禁止我们在这里建造."))
			return
		if(ERROR_BLOCKER)
			owner.balloon_alert(owner, span_notice("有另一个异形挡住了这个位置!"))
			return
		if(ERROR_FOG)
			owner.balloon_alert(owner, span_notice("雾气将阻止树脂成形!"))
			return
		// it fails a lot here when dragging , so its to prevent spam
		if(ERROR_CONSTRUCT)
			return
		if(TRUE)
			return
	if(!line_of_sight(owner, T))
		to_chat(owner, span_warning("没有视线你不能分泌树脂!"))
		return fail_activate()
	if(!do_after(xeno_owner, get_wait(), NONE, T, BUSY_ICON_BUILD))
		return fail_activate()
	switch(is_valid_for_resin_structure(T, xeno_owner.selected_resin == /obj/structure/mineral_door/resin, xeno_owner.selected_resin))
		if(ERROR_CANT_WEED)
			owner.balloon_alert(owner, span_notice("这个位置无法支撑一个花园!"))
			return
		if(ERROR_NO_WEED)
			owner.balloon_alert(owner, span_notice("这个位置没有杂草作为支撑!"))
			return
		if(ERROR_NO_SUPPORT)
			owner.balloon_alert(owner, span_notice("这个位置没有相邻的支撑来建造该结构!"))
			return
		if(ERROR_NOT_ALLOWED)
			owner.balloon_alert(owner, span_notice("女王母亲禁止我们在这里建造."))
			return
		if(ERROR_BLOCKER)
			owner.balloon_alert(owner, span_notice("有另一个异形挡住了这个位置!"))
			return
		if(ERROR_FOG)
			owner.balloon_alert(owner, span_notice("雾气将阻止树脂成形!"))
			return
		// it fails a lot here when dragging , so its to prevent spam
		if(ERROR_CONSTRUCT)
			return
		if(TRUE)
			return
	var/atom/AM = xeno_owner.selected_resin
	xeno_owner.visible_message(span_xenowarning("\The [xeno_owner] 反刍出一种浓稠物质并将其塑造成 \a [initial(AM.name)]!"), \
	span_xenonotice("我们反刍出一些树脂并将其塑造成 \a [initial(AM.name)]."), null, 5)
	playsound(owner.loc, SFX_ALIEN_RESIN_BUILD, 25)
	var/atom/new_resin
	if(ispath(xeno_owner.selected_resin, /turf)) // We should change turfs, not spawn them in directly
		var/list/baseturfs = islist(T.baseturfs) ? T.baseturfs : list(T.baseturfs)
		baseturfs |= T.type
		T.ChangeTurf(xeno_owner.selected_resin, baseturfs)
		new_resin = T
	else
		new_resin = new xeno_owner.selected_resin(T)
	switch(xeno_owner.selected_resin)
		if(/obj/alien/resin/sticky)
			ability_cost = initial(ability_cost) / 3
	if(new_resin)
		add_cooldown(SSmonitor.gamestate == SHUTTERS_CLOSED ? get_cooldown() * 0.5 : get_cooldown())
		succeed_activate(SSmonitor.gamestate == SHUTTERS_CLOSED ? ability_cost * 0.5 : ability_cost)
	ability_cost = initial(ability_cost) //Reset the plasma cost
	owner.record_structures_built()

/datum/action/ability/xeno_action/pheromones
	name = "Emit Pheromones"
	desc = "打开你的信息素选项."
	action_icon_state = "emit_pheromones"
	action_icon = 'icons/Xeno/actions/general.dmi'
	ability_cost = 30
	use_state_flags = ABILITY_USE_STAGGERED|ABILITY_USE_NOTTURF|ABILITY_USE_BUSY|ABILITY_USE_LYING|ABILITY_USE_BUCKLED

/datum/action/ability/xeno_action/pheromones/proc/apply_pheros(phero_choice)
	if(xeno_owner.current_aura && xeno_owner.current_aura.aura_types[1] == phero_choice)
		xeno_owner.balloon_alert(xeno_owner, "停止释放")
		QDEL_NULL(xeno_owner.current_aura)
		if(xeno_owner.hive?.living_xeno_ruler == xeno_owner)
			xeno_owner.hive?.update_leader_pheromones()
		xeno_owner.hud_set_pheromone()
		return fail_activate()
	QDEL_NULL(xeno_owner.current_aura)
	xeno_owner.current_aura = SSaura.add_emitter(xeno_owner, phero_choice, 6 + xeno_owner.xeno_caste.aura_strength * 2, xeno_owner.xeno_caste.aura_strength, -1, xeno_owner.faction, xeno_owner.hivenumber)
	xeno_owner.balloon_alert(xeno_owner, "[phero_choice]")
	playsound(xeno_owner.loc, SFX_ALIEN_DROOL, 25)

	if(xeno_owner.hive?.living_xeno_ruler == xeno_owner)
		xeno_owner.hive?.update_leader_pheromones()
	xeno_owner.hud_set_pheromone() //Visual feedback that the xeno has immediately started emitting pheromones
	succeed_activate()

/datum/action/ability/xeno_action/pheromones/action_activate()
	var/phero_choice = show_radial_menu(owner, owner, GLOB.pheromone_images_list, radius = 35)
	if(!phero_choice)
		return fail_activate()
	apply_pheros(phero_choice)

/datum/action/ability/xeno_action/pheromones/emit_recovery
	name = "Toggle Recovery Pheromones"
	desc = "增加你自己和附近队友的治疗效果."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_EMIT_RECOVERY,
	)
	hidden = TRUE

/datum/action/ability/xeno_action/pheromones/emit_recovery/action_activate()
	apply_pheros(AURA_XENO_RECOVERY)

/datum/action/ability/xeno_action/pheromones/emit_warding
	name = "Toggle Warding Pheromones"
	desc = "增加你自己和附近队友的护甲."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_EMIT_WARDING,
	)
	hidden = TRUE

/datum/action/ability/xeno_action/pheromones/emit_warding/action_activate()
	apply_pheros(AURA_XENO_WARDING)

/datum/action/ability/xeno_action/pheromones/emit_frenzy
	name = "Toggle Frenzy Pheromones"
	desc = "增加你自己和附近队友的伤害."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_EMIT_FRENZY,
	)
	hidden = TRUE

/datum/action/ability/xeno_action/pheromones/emit_frenzy/action_activate()
	apply_pheros(AURA_XENO_FRENZY)

/datum/action/ability/activable/xeno/transfer_plasma
	name = "Transfer Plasma"
	desc = "将你的一些等离子体给予一名队友."
	action_icon_state = "transfer_plasma"
	action_icon = 'icons/Xeno/actions/drone.dmi'
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TRANSFER_PLASMA,
	)
	target_flags = ABILITY_MOB_TARGET
	var/plasma_transfer_amount = PLASMA_TRANSFER_AMOUNT
	var/transfer_delay = 2 SECONDS
	var/max_range = 2

/datum/action/ability/activable/xeno/transfer_plasma/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE

	if(!isxeno(A) || A == xeno_owner || !owner.issamexenohive(A))
		return FALSE

	var/mob/living/carbon/xenomorph/target = A

	if(!(target.xeno_caste.can_flags & CASTE_CAN_BE_GIVEN_PLASMA))
		if(!silent)
			to_chat(owner, span_warning("我们不能给那个 caste 等离子体."))
			return FALSE

	if(get_dist(owner, target) > max_range)
		if(!silent)
			to_chat(owner, span_warning("我们需要更靠近 [target]."))
		return FALSE

	if(target.plasma_stored >= target.xeno_caste.plasma_max) //We can't select targets that won't benefit
		to_chat(owner, span_xenowarning("[target] 的等离子体已经满了."))
		return FALSE

/datum/action/ability/activable/xeno/transfer_plasma/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/target = A

	to_chat(xeno_owner, span_notice("我们开始将我们的等离子体集中输送给 [target]."))
	new /obj/effect/temp_visual/transfer_plasma(get_turf(xeno_owner)) //Cool SFX that confirms our source and our target
	new /obj/effect/temp_visual/transfer_plasma(get_turf(target)) //Cool SFX that confirms our source and our target
	playsound(xeno_owner, SFX_ALIEN_DROOL, 25)

	xeno_owner.face_atom(target) //Face our target so we don't look silly

	if(!do_after(xeno_owner, transfer_delay, NONE, null, BUSY_ICON_FRIENDLY))
		return fail_activate()

	if(!can_use_ability(A))
		return fail_activate()

	target.beam(xeno_owner,"drain_life", time = 1 SECONDS, maxdistance = 10) //visual SFX
	target.add_filter("transfer_plasma_outline", 3, outline_filter(1, COLOR_STRONG_MAGENTA))
	addtimer(CALLBACK(target, TYPE_PROC_REF(/datum, remove_filter), "transfer_plasma_outline"), 1 SECONDS) //Failsafe blur removal

	var/amount = plasma_transfer_amount
	if(xeno_owner.plasma_stored < plasma_transfer_amount)
		amount = xeno_owner.plasma_stored //Just use all of it

	else //Otherwise transfer as much as the target can use
		amount = clamp(target.xeno_caste.plasma_max - target.plasma_stored, 0, plasma_transfer_amount)

	xeno_owner.use_plasma(amount)
	target.gain_plasma(amount)
	to_chat(target, span_xenodanger("[xeno_owner] 将 [amount] 单位等离子体转移给了我们. 我们现在有 [target.plasma_stored]/[target.xeno_caste.plasma_max]."))
	to_chat(xeno_owner, span_xenodanger("我们将 [amount] 单位等离子体转移给了 [target]. 我们现在有 [xeno_owner.plasma_stored]/[xeno_owner.xeno_caste.plasma_max]."))
	playsound(xeno_owner, SFX_ALIEN_DROOL, 25)


// ***************************************
// *********** Corrosive Acid
// ***************************************

/datum/action/ability/activable/xeno/corrosive_acid
	name = "Corrosive Acid"
	desc = "用酸液覆盖一个物体以缓慢融化它. 需要几秒钟."
	action_icon_state = "corrosive_acid"
	action_icon = 'icons/Xeno/actions/general.dmi'
	ability_cost = 100
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CORROSIVE_ACID,
	)
	use_state_flags = ABILITY_USE_BUCKLED
	/// How much to reduce acid delay? Lower is faster. Multiplicative.
	var/acid_speed_multiplier = 1
	var/obj/effect/xenomorph/acid/acid_type = /obj/effect/xenomorph/acid

/datum/action/ability/activable/xeno/corrosive_acid/can_use_ability(atom/A, silent = FALSE, override_flags)
	var/obj/effect/xenomorph/acid/current_acid_type = acid_type
	if(SSmonitor.gamestate == SHUTTERS_CLOSED && CHECK_BITFIELD(SSticker.mode?.round_type_flags, MODE_ALLOW_XENO_QUICKBUILD) && SSresinshaping.active)
		current_acid_type = /obj/effect/xenomorph/acid/strong //if it is before shutters open, everyone gets strong acid
	// Check if it's an acid object we're upgrading
	if (istype(A, /obj/effect/xenomorph/acid))
		var/obj/effect/xenomorph/acid/existing_acid = A
		A = existing_acid.acid_t // Swap the target to the target of the acid
	. = ..()
	if(!.)
		return FALSE
	if(!owner.Adjacent(A))
		if(!silent)
			owner.balloon_alert(owner, "[A] 太远了")
		return FALSE
	if(ismob(A))
		if(!silent)
			owner.balloon_alert(owner, "我们不能融化 [A]")
		return FALSE
	switch(A.should_apply_acid(current_acid_type::acid_strength))
		if(ATOM_CANNOT_ACID)
			if(!silent)
				owner.balloon_alert(owner, "我们不能溶解 [A]")
			return FALSE
		if(ATOM_STRONGER_ACID)
			if(!silent)
				owner.balloon_alert(owner, "[A] 已经受到更强或同等强度的酸液作用")
			return FALSE

/datum/action/ability/activable/xeno/corrosive_acid/use_ability(atom/A)
	var/obj/effect/xenomorph/acid/current_acid_type = acid_type
	// Check if it's an acid object we're upgrading
	if(istype(A, /obj/effect/xenomorph/acid))
		var/obj/effect/xenomorph/acid/existing_acid = A
		A = existing_acid.acid_t // Swap the target to the target of the acid


	var/aciddelay = max(0, A.get_acid_delay() * acid_speed_multiplier);
	if(SSmonitor.gamestate == SHUTTERS_CLOSED && CHECK_BITFIELD(SSticker.mode?.round_type_flags, MODE_ALLOW_XENO_QUICKBUILD) && SSresinshaping.active)
		current_acid_type = /obj/effect/xenomorph/acid/strong //if it is before shutters open, everyone gets strong acid
		aciddelay = 0

	if(!A.dissolvability(current_acid_type::acid_strength))
		return fail_activate()

	xeno_owner.face_atom(A)
	to_chat(xeno_owner, span_xenowarning("我们开始生成足够的酸液来融化 [A]"))

	if(!do_after(xeno_owner, aciddelay, NONE, A, BUSY_ICON_HOSTILE))
		return fail_activate()

	if(!can_use_ability(A, TRUE))
		return fail_activate()

	new current_acid_type(get_turf(A), A, A.dissolvability(current_acid_type::acid_strength))
	succeed_activate()

	if(!isturf(A))
		log_combat(xeno_owner, A, "spat on", addition="with corrosive acid")
	xeno_owner.visible_message(span_xenowarning("\The [xeno_owner] 将恶心的黏液团吐满了 \the [A]. 它开始在冒泡的酸液烂泥下嘶嘶作响并融化!"), \
	span_xenowarning("我们将恶心的黏液团吐满了 \the [A]. 它开始在冒泡的酸液烂泥下嘶嘶作响并融化!"), null, 5)
	playsound(xeno_owner.loc, 'sound/bullets/acid_impact1.ogg', 25)

// ***************************************
// *********** Super strong acid
// ***************************************

/datum/action/ability/activable/xeno/corrosive_acid/strong
	name = "Corrosive Acid"
	ability_cost = 200
	acid_type = /obj/effect/xenomorph/acid/strong

/datum/action/ability/activable/xeno/spray_acid
	action_icon = 'icons/Xeno/actions/boiler.dmi'
	action_icon_state = "spray_acid"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_SPRAY_ACID,
	)
	use_state_flags = ABILITY_USE_BUCKLED

/datum/action/ability/activable/xeno/spray_acid/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(!A)
		return FALSE

	var/turf/T = get_turf(owner)
	var/turf/T2 = get_turf(A)
	if(T == T2)
		if(!silent)
			to_chat(owner, span_warning("那太近了!"))
		return FALSE

/datum/action/ability/activable/xeno/spray_acid/on_cooldown_finish()
	playsound(owner.loc, 'sound/voice/alien/drool1.ogg', 50, 1)
	to_chat(owner, span_xenodanger("我们感觉我们的酸腺重新充满了. 我们可以再次喷射酸液了."))
	return ..()

/datum/action/ability/activable/xeno/spray_acid/proc/acid_splat_turf(turf/T)
	. = locate(/obj/effect/xenomorph/spray) in T
	if(!.)
		. = new /obj/effect/xenomorph/spray(T, xeno_owner.xeno_caste.acid_spray_duration, xeno_owner.xeno_caste.acid_spray_damage, xeno_owner)

		for(var/i in T)
			var/atom/A = i
			if(!A)
				continue
			A.acid_spray_act(owner)

/datum/action/ability/activable/xeno/xeno_spit
	name = "Xeno Spit"
	desc = "向你的目标吐出神经毒素或酸液, 最远 7 格."
	action_icon_state = "neurotoxin"
	action_icon = 'icons/Xeno/actions/spit.dmi'
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_XENO_SPIT,
	)
	use_state_flags = ABILITY_USE_LYING|ABILITY_USE_BUCKLED|ABILITY_DO_AFTER_ATTACK|ABILITY_USE_STAGGERED
	target_flags = ABILITY_MOB_TARGET
	///Current target that the xeno is targeting. This is for aiming.
	var/current_target

/datum/action/ability/activable/xeno/xeno_spit/give_action(mob/living/L)
	. = ..()
	owner.AddComponent(/datum/component/automatedfire/autofire, get_cooldown(), _fire_mode = GUN_FIREMODE_AUTOMATIC,  _callback_reset_fire = CALLBACK(src, PROC_REF(reset_fire)), _callback_fire = CALLBACK(src, PROC_REF(fire)))

/datum/action/ability/activable/xeno/xeno_spit/remove_action(mob/living/L)
	clean_target()
	qdel(owner.GetComponent(/datum/component/automatedfire/autofire))
	return ..()

/datum/action/ability/activable/xeno/xeno_spit/update_button_icon()
	if(xeno_owner)
		action_icon_state = "[initial(xeno_owner.ammo.icon_state)]"
	return ..()

/datum/action/ability/activable/xeno/xeno_spit/action_activate()
	if(xeno_owner.selected_ability != src)
		RegisterSignal(xeno_owner, COMSIG_MOB_MOUSEDRAG, PROC_REF(change_target))
		RegisterSignal(xeno_owner, COMSIG_MOB_MOUSEUP, PROC_REF(stop_fire))
		RegisterSignal(xeno_owner, COMSIG_MOB_MOUSEDOWN, PROC_REF(start_fire))
		return ..()
	for(var/i in 1 to length(xeno_owner.xeno_caste.spit_types))
		if(xeno_owner.ammo == GLOB.ammo_list[xeno_owner.xeno_caste.spit_types[i]])
			if(i == length(xeno_owner.xeno_caste.spit_types))
				xeno_owner.ammo = GLOB.ammo_list[xeno_owner.xeno_caste.spit_types[1]]
				break
			xeno_owner.ammo = GLOB.ammo_list[xeno_owner.xeno_caste.spit_types[i+1]]
			break
	to_chat(xeno_owner, span_notice("我们现在将吐出 [xeno_owner.ammo.name] ([xeno_owner.ammo.spit_cost] 等离子体)."))
	xeno_owner.update_spits(TRUE)
	update_button_icon()

/datum/action/ability/activable/xeno/xeno_spit/deselect()
	UnregisterSignal(owner, list(COMSIG_MOB_MOUSEUP, COMSIG_MOB_MOUSEDRAG, COMSIG_MOB_MOUSEDOWN))
	return ..()

/datum/action/ability/activable/xeno/xeno_spit/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(!xeno_owner.check_state())
		return FALSE
	if(xeno_owner.ammo?.spit_cost > xeno_owner.plasma_stored)
		if(!silent)
			to_chat(xeno_owner, span_warning("我们还需要 [xeno_owner.ammo?.spit_cost - xeno_owner.plasma_stored] 等离子体!"))
		return FALSE

/datum/action/ability/activable/xeno/xeno_spit/get_cooldown()
	return (xeno_owner.xeno_caste.spit_delay + xeno_owner.ammo?.added_spit_delay)

/datum/action/ability/activable/xeno/xeno_spit/on_cooldown_finish()
	to_chat(xeno_owner, span_notice("我们感觉我们的神经毒素腺体充满了灵液. 我们可以再次吐出了."))
	return ..()

/datum/action/ability/activable/xeno/xeno_spit/use_ability(atom/A)
	if(owner.client) //If its not an ai it will register to listen for clicks instead of use this proc. We want to call start_fire from here only if the owner is an ai.
		return
	start_fire(object = A, can_use_ability_flags = ABILITY_IGNORE_SELECTED_ABILITY)

///Starts the xeno firing.
/datum/action/ability/activable/xeno/xeno_spit/proc/start_fire(datum/source, atom/object, turf/location, control, params, can_use_ability_flags)
	SIGNAL_HANDLER
	var/list/modifiers = params2list(params)
	if(((modifiers["right"] || modifiers["middle"]) && (modifiers["shift"] || modifiers["ctrl"] || modifiers["left"])) || \
	((modifiers["left"] && modifiers["shift"]) && (modifiers["ctrl"] || modifiers["middle"] || modifiers["right"])) || \
	(modifiers["left"] && !modifiers["shift"]))
		return
	if(!can_use_ability(object, TRUE, can_use_ability_flags))
		return fail_activate()
	if(QDELETED(object))
		return
	set_target(get_turf_on_clickcatcher(object, xeno_owner, params))
	if(!current_target)
		return

	SEND_SIGNAL(owner, COMSIG_XENO_FIRE)
	xeno_owner?.client?.mouse_pointer_icon = 'icons/effects/xeno_target.dmi'

///Fires the spit projectile.
/datum/action/ability/activable/xeno/xeno_spit/proc/fire()
	var/turf/current_turf = get_turf(owner)
	var/sound_to_play = pick(1, 2) == 1 ? 'sound/voice/alien/spitacid.ogg' : 'sound/voice/alien/spitacid2.ogg'
	playsound(xeno_owner.loc, sound_to_play, 25, 1)

	var/atom/movable/projectile/newspit = new /atom/movable/projectile(current_turf)
	ability_cost = xeno_owner.ammo.spit_cost
	newspit.generate_bullet(xeno_owner.ammo, xeno_owner.ammo.damage * SPIT_UPGRADE_BONUS(xeno_owner))
	newspit.def_zone = xeno_owner.get_limbzone_target()
	newspit.fire_at(current_target, xeno_owner, xeno_owner, xeno_owner.ammo.max_range, xeno_owner.ammo.shell_speed)

	if(can_use_ability(current_target) && xeno_owner.client) //xeno_owner.client to make sure autospit doesn't continue for non player mobs.
		succeed_activate()
		return AUTOFIRE_CONTINUE
	fail_activate()
	return NONE

///Resets the autofire component.
/datum/action/ability/activable/xeno/xeno_spit/proc/reset_fire()
	set_target(null)
	owner?.client?.mouse_pointer_icon = initial(owner.client.mouse_pointer_icon)

///Changes the current target.
/datum/action/ability/activable/xeno/xeno_spit/proc/change_target(datum/source, atom/src_object, atom/over_object, turf/src_location, turf/over_location, src_control, over_control, params)
	SIGNAL_HANDLER
	set_target(get_turf_on_clickcatcher(over_object, xeno_owner, params))
	xeno_owner.face_atom(current_target)

///Sets the current target and registers for qdel to prevent hardels
/datum/action/ability/activable/xeno/xeno_spit/proc/set_target(atom/object)
	if(object == current_target || object == xeno_owner)
		return
	if(current_target)
		UnregisterSignal(current_target, COMSIG_QDELETING)
	current_target = object
	if(current_target)
		RegisterSignal(current_target, COMSIG_QDELETING, PROC_REF(clean_target))

///Cleans the current target in case of Hardel
/datum/action/ability/activable/xeno/xeno_spit/proc/clean_target()
	SIGNAL_HANDLER
	current_target = null

///Stops the Autofire component and resets the current cursor.
/datum/action/ability/activable/xeno/xeno_spit/proc/stop_fire()
	SIGNAL_HANDLER
	xeno_owner?.client?.mouse_pointer_icon = initial(xeno_owner.client.mouse_pointer_icon)
	SEND_SIGNAL(xeno_owner, COMSIG_XENO_STOP_FIRE)

/datum/action/ability/activable/xeno/xeno_spit/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/xeno/xeno_spit/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	if(get_dist(target, xeno_owner) > 6)
		return FALSE
	if(!can_use_ability(target, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(!line_of_sight(xeno_owner, target))
		return FALSE
	if(target.get_xeno_hivenumber() == xeno_owner.get_xeno_hivenumber())
		return FALSE
	return TRUE

/datum/action/ability/xeno_action/xenohide
	name = "Hide"
	desc = "使你的精灵隐藏在特定物体后面和桌子下面. 与潜行不同. 不消耗等离子体."
	action_icon_state = "xenohide"
	action_icon = 'icons/Xeno/actions/general.dmi'
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_HIDE,
	)

/datum/action/ability/xeno_action/xenohide/remove_action(mob/living/L)
	UnregisterSignal(L, list(COMSIG_XENOMORPH_POUNCE, COMSIG_MOB_CRIT, COMSIG_MOB_DEATH))
	return ..()

/datum/action/ability/xeno_action/xenohide/can_use_action(silent, override_flags)
	if(HAS_TRAIT(xeno_owner, TRAIT_TANK_DESANT))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "在载具上时不能")
		return FALSE
	return ..()

/datum/action/ability/xeno_action/xenohide/action_activate()
	if(xeno_owner.layer != BELOW_TABLE_LAYER)
		RegisterSignals(xeno_owner, list(COMSIG_XENOMORPH_POUNCE, COMSIG_MOB_CRIT, COMSIG_MOB_DEATH), PROC_REF(unhide))
		xeno_owner.layer = BELOW_TABLE_LAYER
		to_chat(xeno_owner, span_notice("我们现在正在隐藏."))
		button.add_overlay(mutable_appearance('icons/Xeno/actions/_actions.dmi', "selected_purple_frame", ACTION_LAYER_ACTION_ICON_STATE, null, FLOAT_PLANE))
	else
		UnregisterSignal(xeno_owner, list(COMSIG_XENOMORPH_POUNCE, COMSIG_MOB_CRIT, COMSIG_MOB_DEATH))
		xeno_owner.layer = MOB_LAYER
		to_chat(xeno_owner, span_notice("我们已经停止隐藏."))
		button.cut_overlay(mutable_appearance('icons/Xeno/actions/_actions.dmi', "selected_purple_frame", ACTION_LAYER_ACTION_ICON_STATE, null, FLOAT_PLANE))

/datum/action/ability/xeno_action/xenohide/proc/unhide()
	SIGNAL_HANDLER
	UnregisterSignal(xeno_owner, list(COMSIG_XENOMORPH_POUNCE, COMSIG_MOB_CRIT, COMSIG_MOB_DEATH))
	xeno_owner.layer = MOB_LAYER
	to_chat(xeno_owner, span_notice("我们已经停止隐藏."))
	button.cut_overlay(mutable_appearance('icons/Xeno/actions/_actions.dmi', "selected_purple_frame", ACTION_LAYER_ACTION_ICON_STATE, FLOAT_PLANE))

//Neurotox Sting
/datum/action/ability/activable/xeno/neurotox_sting
	name = "Neurotoxin Sting"
	desc = "一种引导近战攻击, 在几秒钟内向目标注入神经毒素, 暂时将其击晕."
	action_icon_state = "neuro_sting"
	action_icon = 'icons/Xeno/actions/sentinel.dmi'
	cooldown_duration = 12 SECONDS
	ability_cost = 150
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_NEUROTOX_STING,
	)
	target_flags = ABILITY_MOB_TARGET
	use_state_flags = ABILITY_USE_BUCKLED
	/// Whatever our victim is injected with.
	var/sting_chemical = /datum/reagent/toxin/xeno_neurotoxin

/datum/action/ability/activable/xeno/neurotox_sting/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE

	if(!A?.can_sting())
		if(!silent)
			to_chat(owner, span_warning("我们的刺击不会影响这个目标!"))
		return FALSE
	if(!owner.Adjacent(A))
		if(!silent && world.time > (xeno_owner.recent_notice + xeno_owner.notice_delay)) //anti-notice spam
			to_chat(xeno_owner, span_warning("我们无法触及这个目标!"))
			xeno_owner.recent_notice = world.time //anti-notice spam
		return FALSE
	var/mob/living/carbon/C = A
	if(isnestedhost(C))
		if(!silent)
			to_chat(owner, span_warning("惭愧,我们重新考虑用尾刺欺负这个可怜的、嵌套的宿主。"))
		return FALSE

/datum/action/ability/activable/xeno/neurotox_sting/on_cooldown_finish()
	playsound(owner.loc, 'sound/voice/alien/drool1.ogg', 50, 1)
	to_chat(owner, span_xenodanger("我们感到毒腺重新充盈。我们可以再次使用[initial(name)]了。"))
	return ..()

/datum/action/ability/activable/xeno/neurotox_sting/use_ability(atom/A)
	succeed_activate()

	add_cooldown()
	xeno_owner.recurring_injection(A, sting_chemical, XENO_NEURO_CHANNEL_TIME, XENO_NEURO_AMOUNT_RECURRING)

	track_stats()

///Adds ability tally to the end-round statistics.
/datum/action/ability/activable/xeno/neurotox_sting/proc/track_stats()
	GLOB.round_statistics.sentinel_neurotoxin_stings++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "sentinel_neurotoxin_stings")

//Ozelomelyn Sting
/datum/action/ability/activable/xeno/neurotox_sting/ozelomelyn
	name = "Ozelomelyn Sting"
	desc = "一种引导近战攻击,在数秒内向目标注入Ozelomelyn,净化化学物质并在其体内造成少量毒素伤害,有中等上限。"
	action_icon_state = "drone_sting"
	action_icon = 'icons/Xeno/actions/shrike.dmi'
	cooldown_duration = 25 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_OZELOMELYN_STING,
	)
	ability_cost = 100
	sting_chemical = /datum/reagent/toxin/xeno_ozelomelyn

///Adds ability tally to the end-round statistics.
/datum/action/ability/activable/xeno/neurotox_sting/ozelomelyn/track_stats()
	GLOB.round_statistics.ozelomelyn_stings++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "ozelomelyn_stings")

//Transvitox Sting
/datum/action/ability/activable/xeno/neurotox_sting/transvitox
	name = "Transvitox Sting"
	desc = "一种引导近战攻击,在数秒内向目标注入Transvitox,在其体内造成少量毒素伤害,有中等上限。"
	cooldown_duration = 12 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_OZELOMELYN_STING,
	)
	ability_cost = 120
	sting_chemical = /datum/reagent/toxin/xeno_transvitox

///Adds ability tally to the end-round statistics.
/datum/action/ability/activable/xeno/neurotox_sting/transvitox/track_stats()
	GLOB.round_statistics.transvitox_stings++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "transvitox_stings")

// ***************************************
// *********** Psychic Whisper
// ***************************************
/datum/action/ability/xeno_action/psychic_whisper
	name = "Psychic Whisper"
	action_icon_state = "psychic_whisper"
	action_icon = 'icons/Xeno/actions/shrike.dmi'
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PSYCHIC_WHISPER,
	)
	use_state_flags = ABILITY_USE_LYING
	target_flags = ABILITY_MOB_TARGET

/datum/action/ability/xeno_action/psychic_whisper/action_activate()
	var/list/target_list = list()
	for(var/mob/living/possible_target in view(WORLD_VIEW, xeno_owner))
		if(possible_target == xeno_owner || !possible_target.client || isxeno(possible_target))
			continue
		target_list += possible_target

	if(!length(target_list))
		to_chat(xeno_owner, span_warning("附近没有人可以低语。"))
		return

	var/mob/living/L = tgui_input_list(xeno_owner, "目标", "向谁发送心灵低语?", target_list)
	if(!L)
		return

	if(!xeno_owner.check_state())
		return

	var/msg = stripped_input("Message:", "Psychic Whisper")
	if(!msg)
		return

	log_directed_talk(xeno_owner, L, msg, LOG_SAY, "psychic whisper")
	to_chat(L, span_alien("你听到脑海中传来一个奇怪的、异形的声音。<i>\"[msg]\"</i>"))
	to_chat(xeno_owner, span_xenonotice("我们说了: \"[msg]\" 对 [L]"))
	message_admins("[xeno_owner] has sent [L] this psychic message: \"[msg]\" at [ADMIN_VERBOSEJMP(xeno_owner)].")

// ***************************************
// *********** Lay Egg
// ***************************************
/datum/action/ability/xeno_action/lay_egg
	name = "Lay Egg"
	desc = "产下一枚卵,会在短暂延迟后孵化出一只幼虫抱脸虫。空卵可以插入抱脸虫。"
	action_icon_state = "lay_egg"
	action_icon = 'icons/Xeno/actions/construction.dmi'
	ability_cost = 200
	cooldown_duration = 12 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_LAY_EGG,
	)

/datum/action/ability/xeno_action/lay_egg/action_activate(mob/living/carbon/xenomorph/user)
	var/turf/current_turf = get_turf(xeno_owner)

	if(!current_turf.check_alien_construction(xeno_owner, planned_building = /obj/alien/egg/facehugger))
		return fail_activate()

	if(!xeno_owner.loc_weeds_type)
		to_chat(user, span_xenowarning("我们的卵在这里无法良好生长。把它们产在树脂上。"))
		return fail_activate()

	xeno_owner.visible_message(span_xenonotice("[xeno_owner]开始产卵。"), \
		span_xenonotice("我们开始产卵。"), null, 5)

	if(!do_after(xeno_owner, 2.5 SECONDS, NONE, current_turf, BUSY_ICON_BUILD, extra_checks = CALLBACK(current_turf, TYPE_PROC_REF(/turf, check_alien_construction), xeno_owner)))
		return fail_activate()

	if(!xeno_owner.loc_weeds_type)
		return fail_activate()

	new /obj/alien/egg/facehugger(current_turf, xeno_owner.hivenumber)
	playsound(current_turf, 'sound/effects/splat.ogg', 15, 1)

	succeed_activate()
	add_cooldown()
	owner.record_traps_created()

////////////////////
/// Rally Hive
///////////////////
/datum/action/ability/xeno_action/rally_hive
	name = "Rally Hive"
	desc = "召集虫巢在目标位置集结,并附带一个箭头指示器。将你当前的生命状态告知虫巢。60秒冷却。"
	action_icon_state = "rally_hive"
	action_icon = 'icons/Xeno/actions/general.dmi'
	ability_cost = 0
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_RALLY_HIVE,
	)
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	cooldown_duration = 60 SECONDS
	use_state_flags = ABILITY_USE_LYING|ABILITY_USE_BUCKLED

/datum/action/ability/xeno_action/rally_hive/action_activate()
	xeno_message("Our leader [xeno_owner] is rallying the hive to [AREACOORD_NO_Z(xeno_owner.loc)]!", "xenoannounce", 6, xeno_owner.hivenumber, FALSE, xeno_owner, 'sound/voice/alien/distantroar_3.ogg',TRUE,null,/atom/movable/screen/arrow/leader_tracker_arrow)
	notify_ghosts("\ [xeno_owner] is rallying the hive to [AREACOORD_NO_Z(xeno_owner.loc)]!", source = xeno_owner, action = NOTIFY_JUMP)

	succeed_activate()
	add_cooldown()

	GLOB.round_statistics.xeno_rally_hive++ //statistics
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "xeno_rally_hive")

/datum/action/ability/xeno_action/rally_minion
	name = "Rally Minions"
	desc = "召集你周围的仆从,如果它们还没有首领,就要求它们跟随你。右键点击可更改仆从行为。"
	action_icon_state = "minion_agressive"
	action_icon = 'icons/Xeno/actions/general.dmi'
	ability_cost = 0
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_RALLY_MINION,
		KEYBINDING_ALTERNATE = COMSIG_XENOABILITY_MINION_BEHAVIOUR,
	)
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	cooldown_duration = 10 SECONDS
	use_state_flags = ABILITY_USE_LYING|ABILITY_USE_BUCKLED
	///If minions should be agressive
	var/minions_agressive = TRUE

/datum/action/ability/xeno_action/rally_minion/update_button_icon()
	action_icon_state = minions_agressive ? "minion_agressive" : "minion_passive"
	return ..()

/datum/action/ability/xeno_action/rally_minion/action_activate()
	succeed_activate()
	add_cooldown()
	owner.emote("roar")
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_AI_MINION_RALLY, owner)
	SEND_SIGNAL(owner, COMSIG_ESCORTING_ATOM_BEHAVIOUR_CHANGED, minions_agressive) //New escorting ais should have the same behaviour as old one

/datum/action/ability/xeno_action/rally_minion/alternate_action_activate()
	minions_agressive = !minions_agressive
	SEND_SIGNAL(owner, COMSIG_ESCORTING_ATOM_BEHAVIOUR_CHANGED, minions_agressive)
	update_button_icon()

/mob/living/carbon/xenomorph/proc/add_abilities()
	for(var/action_path in xeno_caste.actions)
		var/datum/action/ability/xeno_action/action = new action_path(src)
		if(!SSticker.mode || SSticker.mode.xeno_abilities_flags & action.gamemode_flags)
			action.give_action(src)

/mob/living/carbon/xenomorph/proc/remove_abilities()
	for(var/action_datum in mob_abilities)
		qdel(action_datum)

/datum/action/ability/xeno_action/rally_hive/hivemind //Halve the cooldown for Hiveminds as their relative omnipresence means they can actually make use of this lower cooldown.
	cooldown_duration = 30 SECONDS

//*********
// Psy Drain
//*********
/datum/action/ability/activable/xeno/psydrain
	name = "Psy drain"
	desc = "吸取受害者的生命能量以获得幼虫和灵能点"
	action_icon_state = "headbite"
	action_icon = 'icons/Xeno/actions/general.dmi'
	use_state_flags = ABILITY_USE_STAGGERED|ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED //can't use while staggered, defender fortified or crest down
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_HEADBITE,
	)
	gamemode_flags = ABILITY_DISTRESS|ABILITY_CRASH
	ability_cost = 100
	///How much larva points it gives (8 points for one larva in distress)
	var/larva_point_reward = 1

/datum/action/ability/activable/xeno/psydrain/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..() //do after checking the below stuff
	if(!.)
		return
	if(!iscarbon(A))
		return FALSE
	var/mob/living/carbon/victim = A //target of ability
	if(xeno_owner.do_actions) //can't use if busy
		return FALSE
	if(!xeno_owner.Adjacent(victim)) //checks if owner next to target
		return FALSE
	if(xeno_owner.on_fire)
		if(!silent)
			to_chat(xeno_owner, span_warning("我们正忙着着火,做不了这个!"))
		return FALSE
	if(victim.stat != DEAD)
		if(!silent)
			to_chat(xeno_owner, span_warning("这个生物挣扎得太厉害,我们无法吸取它的生命能量。"))
		return FALSE
	if(HAS_TRAIT(victim, TRAIT_PSY_DRAINED))
		if(!silent)
			to_chat(xeno_owner, span_warning("这个生物体内已经没有生命能量了!"))
		return FALSE
	if(!ishuman(victim))
		if(!silent)
			to_chat(xeno_owner, span_warning("我们无法吸取非人类的东西。"))
		return FALSE
	if(issynth(victim)) //checks if target is a synth
		if(!silent)
			to_chat(xeno_owner, span_warning("这个人造构造体没有生命能量可吸取"))
		return FALSE
	xeno_owner.face_atom(victim) //Face towards the target so we don't look silly
	xeno_owner.visible_message(span_xenowarning("\The [xeno_owner]开始张开嘴,向\the [victim]伸出第二颚。"), \
	span_danger("我们正在缓慢吸取\the [victim]的生命能量!"), null, 20)
	var/channel = SSsounds.random_available_channel()
	playsound(xeno_owner, 'sound/magic/nightfall.ogg', 40, channel = channel)
	if(!do_after(xeno_owner, 5 SECONDS, IGNORE_HELD_ITEM, victim, BUSY_ICON_DANGER, extra_checks = CALLBACK(xeno_owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = xeno_owner.health))))
		xeno_owner.visible_message(span_xenowarning("\The [xeno_owner]收回了内颚。"), \
		span_danger("我们收回了内颚。"), null, 20)
		xeno_owner.stop_sound_channel(channel)
		return FALSE
	xeno_owner.stop_sound_channel(channel)
	succeed_activate() //dew it

/datum/action/ability/activable/xeno/psydrain/use_ability(mob/M)
	var/mob/living/carbon/victim = M

	if(HAS_TRAIT(victim, TRAIT_PSY_DRAINED))
		to_chat(xeno_owner, span_warning("有人在我们之前吸取了我们受害者的生命能量!"))
		return fail_activate()

	playsound(xeno_owner, 'sound/magic/end_of_psy_drain.ogg', 40)

	xeno_owner.visible_message(span_xenodanger("\The [victim]的生命能量被\the [xeno_owner]吸取了!"), \
	span_xenodanger("我们感到\the [victim]的生命能量涌入我们体内!"))

	victim.do_jitter_animation(2)
	victim.adjust_clone_loss(20)

	// Caster gets 5 biomass immediately
	xeno_owner.biomass = min(xeno_owner.biomass + 5, 50)

	// All living xenos (including caster) get +0.05 passive biomass gain
	for(var/mob/living/carbon/xenomorph/xeno AS in GLOB.alive_xeno_list_hive[xeno_owner.hivenumber])
		if(xeno.xeno_caste.caste_flags & CASTE_IS_A_MINION)
			continue
		xeno.biomass_gain_bonus += 0.05

	ADD_TRAIT(victim, TRAIT_PSY_DRAINED, TRAIT_PSY_DRAINED)
	if(HAS_TRAIT(victim, TRAIT_UNDEFIBBABLE))
		victim.med_hud_set_status()
	var/psy_points_reward = PSY_DRAIN_REWARD
	if(HAS_TRAIT(victim, TRAIT_HIVE_TARGET))
		SEND_GLOBAL_SIGNAL(COMSIG_GLOB_HIVE_TARGET_DRAINED, xeno_owner)
		psy_points_reward = psy_points_reward * 3
	SSpoints.add_psy_points(xeno_owner.hivenumber, psy_points_reward)
	GLOB.round_statistics.psypoints_from_psydrain += psy_points_reward

	if(xeno_owner.hivenumber != XENO_HIVE_NORMAL)
		return

	if(SSticker.mode && !CHECK_BITFIELD(SSticker.mode.xeno_abilities_flags, ABILITY_CRASH))
		var/datum/job/xeno_job = SSjob.GetJobType(/datum/job/xenomorph)
		xeno_job.add_job_points(larva_point_reward)
		xeno_owner.hive.update_tier_limits()
		GLOB.round_statistics.larva_from_psydrain += larva_point_reward / xeno_job.job_points_needed

	if(owner.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
		personal_statistics.drained++
	log_combat(victim, owner, "was drained.")
	log_game("[key_name(victim)] was drained at [AREACOORD(victim.loc)].")

/datum/action/ability/activable/xeno/psydrain/free
	ability_cost = 0

/////////////////////////////////
// Cocoon
/////////////////////////////////
/datum/action/ability/activable/xeno/cocoon
	name = "Cocoon"
	desc = "吞噬你的受害者,将其茧化在你的腹中。这个茧稍后会自动排出,当里面的陆战队员仍有生命能量时,它会提供灵能点。"
	action_icon_state = "regurgitate"
	action_icon = 'icons/Xeno/actions/general.dmi'
	use_state_flags = ABILITY_USE_STAGGERED|ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED //can't use while staggered, defender fortified or crest down
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_REGURGITATE,
	)
	ability_cost = 100
	gamemode_flags = ABILITY_DISTRESS|ABILITY_CRASH
	///In how much time the cocoon will be ejected
	var/cocoon_production_time = 3 SECONDS

/datum/action/ability/activable/xeno/cocoon/can_use_ability(atom/A, silent, override_flags)
	. = ..()
	if(!.)
		return
	if(!ishuman(A) || issynth(A))
		to_chat(xeno_owner, span_warning("那尝起来不会很好吃。"))
		return FALSE
	var/mob/living/carbon/human/victim = A
	if(xeno_owner.do_actions) //can't use if busy
		return FALSE
	if(!xeno_owner.Adjacent(victim)) //checks if owner next to target
		return FALSE
	if(victim.stat != DEAD)
		if(!silent)
			to_chat(xeno_owner, span_warning("这个生物挣扎得太厉害,我们无法吞噬它。"))
		return FALSE
	if(HAS_TRAIT(victim, TRAIT_PSY_DRAINED))
		if(!silent)
			to_chat(xeno_owner, span_warning("这个生物体内已经没有生命能量了!"))
		return FALSE
	if(victim.buckled)
		if(!silent)
			to_chat(xeno_owner, span_warning("[victim]被扣在了什么东西上。"))
		return FALSE
	if(xeno_owner.on_fire)
		if(!silent)
			to_chat(xeno_owner, span_warning("我们正忙着着火,做不了这个!"))
		return FALSE
	if(xeno_owner.eaten_mob) //Only one thing in the stomach at a time, please
		if(!silent)
			to_chat(xeno_owner, span_warning("我们胃里已经有东西了,那绝对塞不下。"))
		return FALSE
	for(var/obj/effect/forcefield/fog in range(1, xeno_owner))
		if(!silent)
			to_chat(xeno_owner, span_warning("我们离迷雾太近了。"))
		return FALSE
	xeno_owner.face_atom(victim)
	xeno_owner.visible_message(span_danger("[xeno_owner]开始吞噬[victim]!"), \
	span_danger("我们开始吞噬[victim]!"), null, 5)

	succeed_activate()

/datum/action/ability/activable/xeno/cocoon/use_ability(atom/A)
	var/mob/living/carbon/human/victim = A
	var/channel = SSsounds.random_available_channel()
	playsound(xeno_owner, 'sound/vore/struggle.ogg', 40, channel = channel)
	if(!do_after(xeno_owner, 7 SECONDS, IGNORE_HELD_ITEM, victim, BUSY_ICON_DANGER, extra_checks = CALLBACK(owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = xeno_owner.health))))
		to_chat(owner, span_warning("我们停止吞噬\the [victim]。反正它们大概也很难吃。"))
		xeno_owner.stop_sound_channel(channel)
		return fail_activate()
	if(HAS_TRAIT(victim, TRAIT_PSY_DRAINED))
		to_chat(owner, span_warning("有人在我们吞噬之前吸取了我们受害者的生命能量!"))
		return fail_activate()
	owner.visible_message(span_warning("[xeno_owner]吞噬了[victim]!"), \
	span_warning("我们吞噬了[victim]!"), null, 5)
	to_chat(owner, span_warning("我们将在[cocoon_production_time * 0.1]秒后排出茧!在完成之前不要移动。"))
	xeno_owner.eaten_mob = victim
	var/turf/starting_turf = get_turf(victim)
	victim.forceMove(xeno_owner)
	xeno_owner.do_jitter_animation()
	succeed_activate()
	channel = SSsounds.random_available_channel()
	playsound(xeno_owner, 'sound/vore/escape.ogg', 40, channel = channel)
	if(!do_after(xeno_owner, cocoon_production_time, IGNORE_HELD_ITEM, null, BUSY_ICON_DANGER))
		to_chat(owner, span_warning("我们移动得太早了,我们将不得不再次吞噬我们的受害者!"))
		xeno_owner.eject_victim(FALSE, starting_turf)
		xeno_owner.stop_sound_channel(channel)
		return fail_activate()
	victim.dead_ticks = 0
	ADD_TRAIT(victim, TRAIT_STASIS, TRAIT_STASIS)
	xeno_owner.eject_victim(TRUE, starting_turf)
	for(var/mob/living/carbon/xenomorph/xeno AS in GLOB.alive_xeno_list_hive[xeno_owner.hivenumber])
		if(xeno.xeno_caste.caste_flags & CASTE_IS_A_MINION)
			continue
		xeno.biomass_gain_bonus += 0.05
	if(owner.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
		personal_statistics.cocooned++

/////////////////////////////////
// blessing Menu
/////////////////////////////////
/datum/action/ability/xeno_action/blessing_menu
	name = "Mothers Blessings"
	desc = "向女王母亲祈求祝福你的虫巢,以灵能能量作为交换。"
	action_icon_state = "hivestore" // missing icon?
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_BLESSINGSMENU,
	)
	use_state_flags = ABILITY_USE_LYING|ABILITY_USE_CRESTED
	hidden = TRUE

/datum/action/ability/xeno_action/blessing_menu/action_activate()
	xeno_owner.hive.purchases.interact(xeno_owner)
	return succeed_activate()

// ***************************************
// *********** Xeno Warnings
// ***************************************
/obj/effect/temp_visual/xeno_warning
	icon = 'icons/xeno/Effects.dmi'
	icon_state = "generic_warning"
	layer = BELOW_MOB_LAYER

/obj/effect/temp_visual/xeno_warning/Initialize(mapload, _duration = 0.5 SECONDS, _color = COLOR_VIOLET)
	. = ..()
	duration = _duration
	color = _color
	animate(src, time = duration - 0.5 SECONDS)
	animate(alpha = 0, time = 0.5 SECONDS, easing = CIRCULAR_EASING|EASE_OUT)
	notify_ai_hazard()

/// Warns nearby players, in any way or form, of an incoming ability and the range it will affect.
/proc/xeno_warning(list/turf/target_turfs, duration, color)
	if(!length(target_turfs))
		CRASH("do_warning([length(target_turfs)]): improper argument")
	for(var/turf/target_turf AS in target_turfs)
		new /obj/effect/temp_visual/xeno_warning(target_turf, duration, color)
