/obj/structure/xeno/spawner
	icon = 'icons/Xeno/2x2building.dmi.dmi'
	name = "生成器"
	desc = "一张黏滑渗液的树脂床,里面装满了看起来恶心的蛋状...东西."
	icon_state = "spawner"
	bound_width = 64
	bound_height = 64
	bound_x = -32
	bound_y = -32
	pixel_x = -32
	pixel_y = -24
	max_integrity = 500
	resistance_flags = UNACIDABLE | DROPSHIP_IMMUNE
	xeno_structure_flags = IGNORE_WEED_REMOVAL|CRITICAL_STRUCTURE|XENO_STRUCT_WARNING_RADIUS|XENO_STRUCT_DAMAGE_ALERT
	var/linked_minions = list()

/obj/structure/xeno/spawner/Initialize(mapload, _hivenumber)
	. = ..()
	LAZYADDASSOC(GLOB.xeno_spawners_by_hive, hivenumber, src)
	SSspawning.registerspawner(src, INFINITY, GLOB.xeno_ai_spawnable, 0, 1, CALLBACK(src, PROC_REF(on_spawn)), list(COMSIG_QDELETING, COMSIG_MOB_DEATH))
	SSspawning.spawnerdata[src].required_increment = max(45 SECONDS, 3 MINUTES - SSmonitor.maximum_connected_players_count * SPAWN_RATE_PER_PLAYER)/SSspawning.wait
	SSspawning.spawnerdata[src].max_allowed_mobs = max(2, MAX_SPAWNABLE_MOB_PER_PLAYER * SSmonitor.maximum_connected_players_count)
	set_light(2, 2, LIGHT_COLOR_GREEN)
	update_minimap_icon()

/obj/structure/xeno/spawner/examine(mob/user)
	. = ..()
	var/current_integrity = (obj_integrity / max_integrity) * 100
	switch(current_integrity)
		if(0 to 20)
			. += span_warning("它勉强支撑着,四周到处都在渗漏黏液,大多数蛋都已破碎.但它并非毫无生机.")
		if(20 to 40)
			. += span_warning("它看起来严重受损,动作迟缓.")
		if(40 to 60)
			. += span_warning("它伤痕累累,但似乎还活着.")
		if(60 to 80)
			. += span_warning("它轻微受损,但看起来仍然健康.")
		if(80 to 100)
			. += span_info("它状态良好,健康地搏动着.")

/obj/structure/xeno/spawner/Destroy()
	GLOB.xeno_spawners_by_hive[hivenumber] -= src
	return ..()

///Change minimap icon if spawner is under attack or not
/obj/structure/xeno/spawner/update_minimap_icon()
	SSminimaps.remove_marker(src)
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('icons/UI_icons/map_blips.dmi', null, "spawner[threat_warning ? "_warn" : "_passive"]", MINIMAP_LABELS_LAYER))

/// Transfers the spawned minion to the silo's hivenumber.
/obj/structure/xeno/spawner/proc/on_spawn(list/newly_spawned_things)
	for(var/mob/living/carbon/xenomorph/spawned_minion AS in newly_spawned_things)
		spawned_minion.transfer_to_hive(hivenumber)
		linked_minions += spawned_minion
		if(hivenumber == XENO_HIVE_FALLEN) //snowflake so valhalla isnt filled with minions after you're done
			RegisterSignal(src, COMSIG_QDELETING, PROC_REF(kill_linked_minions))

/obj/structure/xeno/spawner/proc/kill_linked_minions()
	for(var/mob/living/carbon/xenomorph/linked in linked_minions)
		linked.death(TRUE)
	UnregisterSignal(src, COMSIG_QDELETING)
