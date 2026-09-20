//A system to manage and display alerts on screen without needing you to do it yourself

//PUBLIC -  call these wherever you want


/mob/proc/throw_alert(category, type, severity, obj/new_master, override = FALSE)

/* Proc to create or update an alert. Returns the alert if the alert is new or updated, 0 if it was thrown already
category is a text string. Each mob may only have one alert per category; the previous one will be replaced
path is a type path of the actual alert type to throw
severity is an optional number that will be placed at the end of the icon_state for this alert
For example, high pressure's icon_state is "highpressure" and can be serverity 1 or 2 to get "highpressure1" or "highpressure2"
new_master is optional and sets the alert's icon state to "template" in the ui_style icons with the master as an overlay.
Clicks are forwarded to master
Override makes it so the alert is not replaced until cleared by a clear_alert with clear_override, and it's used for hallucinations.
*/

	if(!category || QDELETED(src))
		return

	var/atom/movable/screen/alert/thealert
	if(alerts[category])
		thealert = alerts[category]
		if(thealert.override_alerts)
			return FALSE
		if(new_master && new_master != thealert.master)
			WARNING("[src] threw alert [category] with new_master [new_master] while already having that alert with master [thealert.master]")

			clear_alert(category)
			return .()
		else if(thealert.type != type)
			clear_alert(category)
			return .()
		else if(!severity || severity == thealert.severity)
			if(thealert.timeout)
				clear_alert(category)
				return .()
			else //no need to update
				return FALSE
	else
		thealert = new type()
		thealert.override_alerts = override
		if(override)
			thealert.timeout = null
	thealert.owner = src

	if(new_master)
		var/mutable_appearance/master_appearance = new(new_master)
		master_appearance.appearance_flags = KEEP_TOGETHER
		master_appearance.layer = FLOAT_LAYER
		master_appearance.plane = FLOAT_PLANE
		master_appearance.dir = SOUTH
		master_appearance.pixel_x = new_master.pixel_x
		master_appearance.pixel_y = new_master.pixel_y
		master_appearance.pixel_z = new_master.pixel_z
		thealert.add_overlay(strip_appearance_underlays(master_appearance))
		thealert.icon_state = "template" // We'll set the icon to the client's ui pref in reorganize_alerts()
		thealert.master = new_master
	else
		thealert.icon_state = "[initial(thealert.icon_state)][severity]"
		thealert.severity = severity

	alerts[category] = thealert
	if(client && hud_used)
		hud_used.reorganize_alerts()
	thealert.transform = matrix(32, 0, MATRIX_TRANSLATE)
	animate(thealert, transform = matrix(), time = 1 SECONDS, easing = ELASTIC_EASING)

	if(thealert.timeout)
		addtimer(CALLBACK(src, PROC_REF(alert_timeout), thealert, category), thealert.timeout)
		thealert.timeout = world.time + thealert.timeout - world.tick_lag
	return thealert

/mob/proc/alert_timeout(atom/movable/screen/alert/alert, category)
	if(alert.timeout && alerts[category] == alert && world.time >= alert.timeout)
		clear_alert(category)

// Proc to clear an existing alert.
/mob/proc/clear_alert(category, clear_override = FALSE)
	var/atom/movable/screen/alert/alert = alerts[category]
	if(!alert)
		return FALSE
	if(alert.override_alerts && !clear_override)
		return FALSE

	alerts -= category
	if(client && hud_used)
		hud_used.reorganize_alerts()
		client.screen -= alert
	qdel(alert)

/atom/movable/screen/alert/MouseEntered(location,control,params)
	if(!QDELETED(src))
		openToolTip(usr, src, params, title = name, content = desc)

/atom/movable/screen/alert/MouseExited()
	closeToolTip(usr)

/atom/movable/screen/alert
	icon = 'icons/mob/screen_alert.dmi'
	icon_state = "default"
	name = "Alert"
	desc = "此警报似乎出了些问题, 请报告这个bug"
	mouse_opacity = MOUSE_OPACITY_ICON
	boxed_message_style = "boxed_message blue_box"
	var/timeout = 0 //If set to a number, this alert will clear itself after that many deciseconds
	var/severity = 0
	var/alerttooltipstyle = ""
	var/override_alerts = FALSE //If it is overriding other alerts of the same type
	var/mob/owner //Alert owner

/atom/movable/screen/alert/Click(location, control, params)
	if(!usr?.client)
		return
	var/paramslist = params2list(params)
	if(paramslist["shift"]) // screen objects don't do the normal Click() stuff (but 100% fucking should) so we'll cheat
		to_chat(usr, fieldset_block(name, desc, boxed_message_style))
		return
	if(master)
		return usr.client.Click(master, location, control, params)

/atom/movable/screen/alert/Destroy()
	master = null
	owner = null
	return ..()

//GHOSTS
//TODO: expand this system to replace the pollCandidates/CheckAntagonist/"choose quickly"/etc Yes/No messages
/atom/movable/screen/alert/notify_action
	name = "Notification"
	desc = "一条新通知. 你可以进入查看."
	icon_state = "template"
	timeout = 15 SECONDS
	boxed_message_style = "boxed_message purple_box"
	var/atom/target = null
	var/action = NOTIFY_JUMP

/atom/movable/screen/alert/notify_action/Click()
	var/mob/dead/observer/G = usr
	if(!istype(G) || usr != owner)
		return
	if(!G.client)
		return
	if(!target)
		return
	switch(action)
		if(NOTIFY_ATTACK)
			target.attack_ghost(G)
		if(NOTIFY_JUMP)
			var/turf/T = get_turf(target)
			if(T)
				G.forceMove(T)
		if(NOTIFY_ORBIT)
			G.ManualFollow(target)
		if(NOTIFY_JOIN_AS_LARVA)
			if(!isxeno(target))
				return FALSE
			switch(tgui_alert(G, "你想做什么?", "可用的潜地幼虫来源", list("Join as Larva", "Jump to it", "Cancel")))
				if("Join as Larva")
					var/mob/living/carbon/human/original_corpse = G.can_reenter_corpse.resolve()
					if(SSticker.mode.spawn_larva(G, target) && ishuman(original_corpse))
						original_corpse?.set_undefibbable()
				if("Jump to it")
					G.forceMove(get_turf(target))

//OBJECT-BASED

/atom/movable/screen/alert/restrained/buckled
	name = "Buckled"
	desc = "你被扣在了什么东西上. 点击警报来解开, 除非你被铐住了."
	icon_state = "buckled"

/atom/movable/screen/alert/restrained/handcuffed
	name = "Handcuffed"
	desc = "你被铐住了, 无法行动. 如果有人拖拽你, 你将无法移动. 点击警报来挣脱."
	boxed_message_style = "boxed_message red_box"

/atom/movable/screen/alert/restrained/Click()
	if(!isliving(usr) || usr != owner)
		return
	var/mob/living/L = usr
	return L.do_resist()

// PRIVATE = only edit, use, or override these if you're editing the system as a whole

// Re-render all alerts - also called in /datum/hud/show_hud() because it's needed there
/datum/hud/proc/reorganize_alerts(mob/viewmob)
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client)
		return
	var/list/alerts = mymob.alerts
	if(!length(alerts))
		return FALSE
	if(!hud_shown)
		for(var/category in alerts)
			var/atom/movable/screen/alert/alert = alerts[category]
			screenmob.client.screen -= alert
		return TRUE
	var/c = 0
	for(var/category in alerts)
		var/atom/movable/screen/alert/alert = alerts[category]
		c++
		switch(c)
			if(1)
				. = ui_alert1
			if(2)
				. = ui_alert2
			if(3)
				. = ui_alert3
			if(4)
				. = ui_alert4
			if(5)
				. = ui_alert5 // Right now there's 5 slots
			else
				. = ""
		alert.screen_loc = .
		screenmob.client.screen |= alert
	if(!viewmob)
		for(var/obs in mymob.observers)
			reorganize_alerts(obs)
	return TRUE

//MECHS
/atom/movable/screen/alert/nocell
	name = "Missing Power Cell"
	desc = "单位没有电源电池. 在重新安装电源电池之前没有可用模块. 机器人技术部门可能会提供帮助."
	icon_state = "no_cell"
	boxed_message_style = "boxed_message red_box"

/atom/movable/screen/alert/emptycell
	name = "Out of Power"
	desc = "单位的电源电池已无剩余电量. 在电源电池充电之前没有可用模块."
	icon_state = "empty_cell"
	boxed_message_style = "boxed_message red_box"

/atom/movable/screen/alert/lowcell
	name = "Low Charge"
	desc = "单位的电源电池电量不足."
	icon_state = "low_cell"
	boxed_message_style = "boxed_message red_box"

/atom/movable/screen/alert/low_mech_integrity
	name = "Mech Damaged"
	desc = "机甲完整度过低."
	icon_state = "low_mech_integrity"
	boxed_message_style = "boxed_message red_box"

// HUMAN WARNINGS
/atom/movable/screen/alert/fire
	name = "On Fire"
	desc = "你着火了. 停下, 卧倒并翻滚来扑灭火焰, 或使用灭火器."
	icon_state = "fire"
	boxed_message_style = "boxed_message red_box"

/atom/movable/screen/alert/fire/Click()
	. = ..()
	var/mob/living/L = usr
	if(!istype(L) || usr != owner)
		return
	L.resist()

/atom/movable/screen/alert/not_enough_oxy
	name = "Choking"
	desc = "你的氧气不足. 这可能是由内部损伤或危急状态引起的. 在你昏倒甚至死亡之前找到解决办法!"
	icon_state = ALERT_NOT_ENOUGH_OXYGEN

/atom/movable/screen/alert/hot
	name = "Too Hot"
	desc = "你热得发烫! 试着扑灭自己身上的火, 然后服用凯洛坦来降温!"
	icon_state = "hot"

/atom/movable/screen/alert/cold
	name = "Too Cold"
	desc = "你冻得发冷! 去个更暖和的地方, 下次去寒冷的地方时多穿几层!"
	icon_state = "cold"

/atom/movable/screen/alert/lowpressure
	name = "Low Pressure"
	desc = "你周围的空气稀薄得危险! 尽快进入室内!"
	icon_state = "lowpressure"

/atom/movable/screen/alert/highpressure
	name = "High Pressure"
	desc = "你周围的空气浓稠得危险."
	icon_state = "highpressure"

/atom/movable/screen/alert/hungry
	name = "Hungry"
	desc = "你该吃点东西了. 移动速度降低."
	icon_state = "hungry"
	boxed_message_style = "boxed_message"

/atom/movable/screen/alert/starving
	name = "Starving"
	desc = "你现在能吃掉一匹马. 移动速度显著降低."
	icon_state = "starving"
	boxed_message_style = "boxed_message red_box"

/atom/movable/screen/alert/stuffed
	name = "Stuffed"
	desc = "你吃得有点太多了. 锻炼以消耗多余的营养. 移动速度降低."
	icon_state = "stuffed"
	boxed_message_style = "boxed_message green_box"
