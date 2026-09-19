/datum/action/observer_action/can_use_action()
	. = ..()
	if(!.)
		return FALSE
	if(!isobserver(owner))
		return FALSE
	return TRUE

/datum/action/observer_action/crew_manifest
	name = "Show Crew manifest"
	action_icon = 'icons/obj/items/books.dmi'
	action_icon_state = "book"

/datum/action/observer_action/crew_manifest/action_activate()
	if(!can_use_action())
		return FALSE
	var/mob/dead/observer/O = owner
	O.view_manifest()

/datum/action/observer_action/show_hivestatus
	name = "Show Hive status"
	action_icon = 'icons/Xeno/actions/queen.dmi'
	action_icon_state = "watch_xeno"

/datum/action/observer_action/show_hivestatus/action_activate()
	if(!can_use_action())
		return FALSE
	check_hive_status(usr)

/datum/action/observer_action/take_ssd_mob
	name = "Take SSD mob"
	action_icon_state = "take_ssd"

/datum/action/observer_action/take_ssd_mob/action_activate()
	var/mob/dead/observer/dead_owner = owner

	if(!GLOB.ssd_posses_allowed)
		to_chat(owner, span_warning("当前已禁用接管SSD生物."))
		return

	if(GLOB.key_to_time_of_death[owner.key] + TIME_BEFORE_TAKING_BODY > world.time && !dead_owner.started_as_observer)
		to_chat(owner, span_warning("你死亡时间太短, 无法接管新生物."))
		return

	var/list/mob/living/free_ssd_mobs = list()
	for(var/mob/living/ssd_mob AS in GLOB.ssd_living_mobs)
		if(is_centcom_level(ssd_mob.z) || ssd_mob.afk_status == MOB_RECENTLY_DISCONNECTED || isyautja(ssd_mob))
			continue
		free_ssd_mobs += ssd_mob

	if(!length(free_ssd_mobs))
		to_chat(owner, span_warning("没有任何SSD生物."))
		return FALSE

	var/mob/living/new_mob = tgui_input_list(owner, "选择一个生物", "可用生物", free_ssd_mobs)
	if(!istype(new_mob) || !owner.client)
		return FALSE

	if(new_mob.stat == DEAD)
		to_chat(owner, span_warning("如果该生物已死亡, 你无法加入."))
		return FALSE
	if(tgui_alert(owner, "Are you sure you want to take " + new_mob.real_name +" ("+new_mob.job.title+")?", "接管SSD生物", list("Yes", "No",)) != "Yes")
		return
	if(isxeno(new_mob))
		var/mob/living/carbon/xenomorph/ssd_xeno = new_mob
		if(ssd_xeno.tier != XENO_TIER_MINION && XENODEATHTIME_CHECK(owner))
			XENODEATHTIME_MESSAGE(owner)
			return

	if(HAS_TRAIT(new_mob, TRAIT_POSSESSING))
		to_chat(owner, span_warning("该生物当前正控制着另一个生物."))
		return FALSE

	if(new_mob.client)
		to_chat(owner, span_warning("该生物已被占用."))
		return FALSE

	if(new_mob.afk_status == MOB_RECENTLY_DISCONNECTED) //We do not want to occupy them if they've only been gone for a little bit.
		to_chat(owner, span_warning("该玩家离开时间不够长. 请再等待[round(timeleft(new_mob.afk_timer_id) * 0.1)]秒\s ."))
		return FALSE

	if(is_banned_from(owner.ckey, new_mob?.job?.title))
		to_chat(owner, span_warning("你被禁止担任[new_mob?.job.title]角色."))
		return

	if(!ishuman(new_mob))
		message_admins(span_adminnotice("[owner.key]接管了[new_mob.name], 因为[new_mob.p_they()]处于ssd状态."))
		log_admin("[owner.key] took control of [new_mob.name] as [new_mob.p_they()] was ssd.")
		new_mob.transfer_mob(owner)
		return
	if(CONFIG_GET(flag/prevent_dupe_names) && GLOB.real_names_joined.Find(owner.client.prefs.real_name))
		to_chat(usr, span_warning("已有玩家使用此角色名加入了本轮游戏. 请选择另一个."))
		return
	message_admins(span_adminnotice("[owner.key]接管了[new_mob.name], 因为[new_mob.p_they()]处于ssd状态."))
	log_admin("[owner.key] took control of [new_mob.name] as [new_mob.p_they()] was ssd.")
	new_mob.transfer_mob(owner)
	var/mob/living/carbon/human/H = new_mob
	var/datum/job/j = H.job
	var/datum/outfit/job/o = j.outfit
	H.on_transformation()
	o.handle_id(H)

//respawn button
/datum/action/observer_action/respawn
	name = "Respawn"
	action_icon_state = "respawn"

/datum/action/observer_action/respawn/action_activate()
	var/datum/game_mode/mode = SSticker.mode
	if(!mode)
		to_chat(usr, span_warning("本轮游戏尚未准备好!"))
		return

	mode.player_respawn(owner)

/datum/action/observer_action/find_facehugger_spawn
	name = "Spawn as Facehugger"
	action_icon = 'icons/Xeno/actions/carrier.dmi'
	action_icon_state = "hugger_set"

/datum/action/observer_action/find_facehugger_spawn/action_activate()
	var/mob/dead/observer/dead_owner = owner
	if(GLOB.key_to_time_of_death[owner.key] + TIME_BEFORE_TAKING_BODY > world.time && !dead_owner.started_as_observer)
		to_chat(owner, span_warning("你死亡时间太短, 无法接管新生物."))
		return

	var/list/spawn_point = list()
	var/list/area_names = list()
	var/list/area_namecounts = list()
	var/name

	for(var/obj/structure/xeno/turret/potential_turret AS in GLOB.xeno_resin_turrets_by_hive[XENO_HIVE_NORMAL])
		if(dead_owner.z != potential_turret.z)
			continue
		if(!istype(potential_turret, /obj/structure/xeno/turret/facehugger))
			continue
		var/area/area = get_area(potential_turret)
		if(area in area_names)
			area_namecounts[area]++
			name = "[potential_turret.name] at [area] ([area_namecounts[area]])"
		else
			area_names.Add(area)
			area_namecounts[area] = 1
			name = "[potential_turret.name] at [get_area(potential_turret)]"

		spawn_point[name] = potential_turret

	for(var/mob/living/carbon/xenomorph/potential_xeno AS in GLOB.alive_xeno_list)
		if(dead_owner.z != potential_xeno.z)
			continue
		if(!isxenocarrier(potential_xeno))
			continue

		if(potential_xeno.xeno_caste.huggers_reserved >= potential_xeno.huggers)
			continue

		name = potential_xeno.name
		spawn_point[name] = potential_xeno

	for(var/obj/alien/egg/facehugger/potential_egg AS in GLOB.xeno_egg_hugger)
		if(dead_owner.z != potential_egg.z)
			continue
		if(potential_egg.maturity_stage != potential_egg.stage_ready_to_burst)
			continue
		if(!potential_egg.hugger_type)
			continue
		if(istype(potential_egg, /obj/alien/egg/facehugger/yautja))
			continue

		var/area_egg = get_area(potential_egg)
		if(area_egg in area_names)
			area_namecounts[area_egg]++
			name = "[potential_egg.name] at [area_egg] ([area_namecounts[area_egg]])"
		else
			area_names.Add(area_egg)
			area_namecounts[area_egg] = 1
			name = "[potential_egg.name] at [get_area(potential_egg)]"

		spawn_point[name] = potential_egg

	if(!length_char(spawn_point))
		to_chat(owner, span_warning("你的Z层级没有抱脸虫的生成点."))
		return

	var/selected = tgui_input_list(usr, "请选择一个生成点:", "作为抱脸虫生成", spawn_point)
	if(!selected)
		return

	var/target = spawn_point[selected]
	dead_owner.abstract_move(get_turf(target))

/datum/action/observer_action/join_predator
	name = "Join the Hunt"
	action_icon_state = "pred_ghost"

/datum/action/observer_action/join_predator/give_action(mob/M)
	var/owner_ckey = M.client?.ckey
	if(!owner_ckey)
		return

	if(!(GLOB.roles_whitelist[owner_ckey] & WHITELIST_PREDATOR))
		return

	if(!SSticker.mode || !(SSticker.mode.round_type_flags & MODE_PREDATOR))
		RegisterSignal(SSdcs, COMSIG_GLOB_PREDATOR_ROUND_TOGGLED, PROC_REF(handle_button_status_visuals))

	. = ..()

/datum/action/observer_action/join_predator/can_use_action()
	if(!SSticker.mode || !(SSticker.mode.round_type_flags & MODE_PREDATOR))
		return FALSE
	return TRUE

/datum/action/observer_action/join_predator/action_activate()
	var/mob/dead/observer/activator = owner
	if(SSticker.current_state < GAME_STATE_PLAYING || !SSticker.mode)
		to_chat(activator, span_warning("游戏尚未开始!"))
		return

	if(SSticker.mode.check_predator_late_join(activator))
		SSticker.mode.join_predator(activator)
