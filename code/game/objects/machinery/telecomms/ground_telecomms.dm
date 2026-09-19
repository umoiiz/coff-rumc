#define TOWER_ON 0
#define TOWER_OFF 1
#define TOWER_BROKEN 2

/obj/machinery/telecomms/relay/preset/tower
	id = "Tower Relay"
	autolinkers = list("relay")
	icon = 'icons/obj/structures/comm_tower2.dmi'
	icon_state = "comm_tower"
	name = "TC-4T telecommunications tower"
	desc = "一个便携式紧凑型 TC-4T 电信塔. 用于建立行星与行星外地点之间的子空间通信线路."
	density = TRUE
	use_power = NO_POWER_USE
	idle_power_usage = 0
	on = FALSE
	freq_listening = TOWER_FREQS
	resistance_flags = RESIST_ALL | DROPSHIP_IMMUNE
	allow_pass_flags = PASS_PROJECTILE|PASS_AIR
	///Health for the miner we use because changing obj_integrity is apparently bad
	var/tower_integrity = 0
	///Max health of the miner
	var/max_tower_integrity = 100
	///Current status of the tower
	var/tower_status = TOWER_BROKEN

/obj/machinery/telecomms/relay/preset/tower/Initialize(mapload)
	. = ..()
	init_marker()

/obj/machinery/miner/Destroy()
	if(src in GLOB.tower_relays)
		GLOB.tower_relays -= src
	return ..()

/obj/machinery/telecomms/relay/preset/tower/proc/init_marker()

	var/marker_icon = ""
	switch(tower_status)
		if(TOWER_ON)
			marker_icon = "comm_tower_on"
		if(TOWER_OFF)
			marker_icon = "comm_tower_off"
		if(TOWER_BROKEN)
			marker_icon= "comm_tower_broken"
	SSminimaps.add_marker(src, MINIMAP_FLAG_ALL, image('icons/UI_icons/map_blips_large.dmi', null, marker_icon, MINIMAP_BLIPS_LAYER))

/obj/machinery/telecomms/relay/preset/tower/update_icon()
	. = ..()
	switch(tower_status)
		if(TOWER_ON)
			icon_state = "comm_tower"
		if(TOWER_OFF)
			icon_state = "comm_tower_off"
		if(TOWER_BROKEN)
			icon_state = "comm_tower_broken"

/obj/machinery/telecomms/relay/preset/tower/welder_act(mob/living/user, obj/item/tool/weldingtool/I)
	. = ..()
	if(tower_status != TOWER_BROKEN)
		return
	if(!I.remove_fuel(1, user))
		to_chat(user, span_warning("你需要更多焊接燃料来完成此任务."))
		return FALSE
	if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
		user.visible_message(span_notice("[user] 摸索着查看 [src] 的内部结构."),
		span_notice("你摸索着查看 [src] 的内部结构."))
		var/fumbling_time = 10 SECONDS - 2 SECONDS * user.skills.getRating(SKILL_ENGINEER)
		if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED, extra_checks = CALLBACK(I, TYPE_PROC_REF(/obj/item/tool/weldingtool, isOn))))
			return FALSE
	user.visible_message(span_notice("[user] 开始焊接 [src] 的内部损伤."),
	span_notice("你开始焊接 [src] 的内部损伤."))
	if(!I.use_tool(src, user, 20 SECONDS, 1, 25, null, BUSY_ICON_BUILD))
		return FALSE
	if(tower_status != TOWER_BROKEN )
		return FALSE
	tower_integrity = max_tower_integrity
	set_tower_status()
	user.visible_message(span_notice("[user] 焊接了 [src] 的内部损伤."),
	span_notice("你焊接了 [src] 的内部损伤."))
	return TRUE

/obj/machinery/telecomms/relay/preset/tower/examine(mob/user)
	. = ..()
	if(!ishuman(user))
		return

	switch(tower_status)
		if(TOWER_ON)
			. += span_info("已开启")
		if(TOWER_OFF)
			. += span_info("已关闭")
		if(TOWER_BROKEN)
			. += span_info("它受到轻微损坏, 你可以看到内部结构. 使用喷灯来修复它.")

/obj/machinery/telecomms/relay/preset/tower/attack_hand(mob/living/user)
	if(tower_status == TOWER_BROKEN)
		to_chat(user, span_warning("[src] 损坏太严重了!"))
		return

	on = !on

	if(on)
		say("It's on")
		GLOB.tower_relays += src
	else
		say("It's off")
		GLOB.tower_relays -= src

	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_TELETOWER)
	set_tower_status()

/obj/machinery/telecomms/relay/preset/tower/attack_alien(mob/living/carbon/xenomorph/X, damage_amount = X.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = "", effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(X.status_flags & INCORPOREAL) //Incorporeal xenos cannot attack physically.
		return
	while(tower_status != TOWER_BROKEN)
		if(X.do_actions)
			return balloon_alert(X, "忙碌")
		if(!do_after(X, 3 SECONDS, NONE, src, BUSY_ICON_DANGER, BUSY_ICON_HOSTILE))
			return
		if(tower_integrity <= 50)
			if(src in GLOB.tower_relays)
				GLOB.tower_relays -= src
			on = FALSE
			SEND_GLOBAL_SIGNAL(COMSIG_GLOB_TELETOWER)
		X.do_attack_animation(src, ATTACK_EFFECT_CLAW)
		X.visible_message(span_danger("[X] 用爪击 \the [src]!"), \
		span_danger("我们用爪击 \the [src]!"), null, 5)
		playsound(loc, SFX_ALIEN_CLAW_METAL, 25, TRUE)
		tower_integrity -= 25
		set_tower_status()

/obj/machinery/telecomms/relay/preset/tower/proc/set_tower_status()
	var/health_percent = round((tower_integrity / max_tower_integrity) * 100)
	var/marker_icon = "comm_tower_broken"
	switch(health_percent)
		if(-INFINITY to 0)
			tower_status = TOWER_BROKEN
			marker_icon = "comm_tower_broken"
		if(1 to INFINITY)
			tower_status = on ? TOWER_ON : TOWER_OFF
			marker_icon = "comm_tower[on ? "_on" : "_off"]"
	SSminimaps.remove_marker(src)
	SSminimaps.add_marker(src, MINIMAP_FLAG_ALL, image('icons/UI_icons/map_blips_large.dmi', null, marker_icon, MINIMAP_BLIPS_LAYER))
	update_icon()

/obj/machinery/telecomms/relay/preset/tower/attack_ai(mob/user)
	return attack_hand(user)

//override
/obj/machinery/telecomms/relay/preset/tower/update_power()
	return

#undef TOWER_ON
#undef TOWER_OFF
#undef TOWER_BROKEN
