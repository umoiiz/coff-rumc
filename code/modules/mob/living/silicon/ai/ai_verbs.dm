/mob/living/silicon/ai/verb/ai_network_change()
	set category = "Silicon"
	set name = "Jump To Network"

	if(incapacitated())
		return

	unset_interaction()
	cameraFollow = null

	var/new_network = tgui_input_list(src, "你想查看哪个网络?", "跳转至网络", available_networks)
	if(!new_network)
		return

	if(!eyeobj)
		view_core()
		return

	for(var/i in GLOB.cameranet.cameras)
		var/obj/machinery/camera/C = i

		if(!C.can_use())
			continue

		if(new_network in C.network)
			eyeobj.setLoc(get_turf(C))
			break

	to_chat(src, span_notice("已切换到\"[uppertext(new_network)]\"摄像头网络."))



/mob/living/silicon/ai/verb/display_status()
	set category = "Silicon"
	set name = "Display Status"

	if(incapacitated())
		return

	var/list/ai_emotions = list("Very Happy", "Happy", "Neutral", "Unsure", "Confused", "Sad", "BSOD", "Blank", "Problems?", "Awesome", "Facepalm", "Thinking", "Friend Computer", "Blue Glow", "Red Glow")
	var/emote = tgui_input_list(usr, "请选择一个状态!", "人工智能状态", ai_emotions)
	if(!emote)
		return

	for(var/obj/machinery/status_display/ai/SD AS in GLOB.ai_status_displays)
		SD.emotion = emote
		SD.update()

	if(emote == "Friend Computer")
		var/datum/radio_frequency/frequency = SSradio.return_frequency(FREQ_STATUS_DISPLAYS)

		if(!frequency)
			return

		var/datum/signal/status_signal = new(list("command" = "friendcomputer"))
		frequency.post_signal(src, status_signal)

	to_chat(src, span_notice("已将显示状态更改为: [emote]"))


/mob/living/silicon/ai/verb/change_hologram()
	set category = "Silicon"
	set name = "Change Hologram"

	if(incapacitated())
		return

	var/hologram = tgui_alert(src, "你想选择一个基于船员的 hologram, 一个动物, 还是切换到一个独特的头像?", "全息影像", list("Crew Member", "Unique", "Animal"))
	switch(hologram)
		if("Crew Member")
			var/list/personnel_list = list()

			for(var/datum/data/record/t in GLOB.datacore.general)
				personnel_list["[t.fields["name"]]: [t.fields["rank"]]"] = t.fields["photo_front"]

			if(!length(personnel_list))
				to_chat(src, span_warning("未找到合适的记录. 正在中止."))
				return

			hologram = tgui_input_list(src, "选择一名船员:", null,personnel_list)
			var/icon/character_icon = personnel_list[hologram]
			if(!character_icon)
				return

			holo_icon = getHologramIcon(icon(character_icon))

		if("Animal")
			var/list/icon_list = list(
			"bear" = 'icons/mob/animal.dmi',
			"carp" = 'icons/mob/animal.dmi',
			"chicken_brown" = 'icons/mob/animal.dmi',
			"corgi" = 'icons/mob/pets.dmi',
			"cow" = 'icons/mob/animal.dmi',
			"crab" = 'icons/mob/animal.dmi',
			"fox" = 'icons/mob/pets.dmi',
			"goat" = 'icons/mob/animal.dmi',
			"cat" = 'icons/mob/pets.dmi',
			"cat2" = 'icons/mob/pets.dmi',
			"parrot_fly" = 'icons/mob/animal.dmi',
			"pug" = 'icons/mob/pets.dmi'
			)

			hologram = tgui_input_list(src, "请选择一个全息影像:", null, icon_list)
			if(!hologram)
				return

			holo_icon = getHologramIcon(icon(icon_list[hologram], hologram))

		if("Unique")
			var/list/icon_list = list(
				"default" = 'icons/mob/ai.dmi',
				"floating face" = 'icons/mob/ai.dmi',
				"xeno_queen" = 'icons/mob/ai.dmi',
				"void_horror" = 'icons/mob/ai.dmi',
				"carp" = 'icons/mob/ai.dmi'
				)

			hologram = tgui_input_list(src, "请选择一个全息影像:", null, icon_list)
			if(!hologram)
				return

			holo_icon = getHologramIcon(icon(icon_list[hologram], hologram))

		else
			return

	to_chat(src, span_notice("已将全息影像更改为: [hologram]"))


/mob/living/silicon/ai/verb/toggle_sensors()
	set category = "Silicon"
	set name = "Toggle Sensors"

	if(incapacitated())
		return

	toggle_sensor_mode()


/mob/living/silicon/ai/verb/make_announcement()
	set category = "Silicon"
	set name = "Make Announcement"

	if(incapacitated())
		return

	if(last_announcement + 60 SECONDS > world.time)
		to_chat(src, span_warning("你必须等待才能再次进行公告."))
		return

	var/input = stripped_input(usr, "Please write a message to announce to the station crew.", "Announcement")
	if(!input || incapacitated())
		return

	last_announcement = world.time
	priority_announce(input, "来自[src]的警报", sound = 'sound/AI/aireport.ogg')


/mob/living/silicon/ai/verb/ai_core_display()
	set category = "Silicon"
	set name = "AI Core Display"

	if(incapacitated())
		return

	var/list/iconstates = GLOB.ai_core_display_screens
	for(var/option in iconstates)
		if(option == "Random")
			iconstates[option] = image(icon = icon, icon_state = "ai-random")
			continue
		iconstates[option] = image(icon = icon, icon_state = resolve_ai_icon(option))

	view_core()

	var/ai_core_icon = tgui_input_list(src, "选择你的人工智能核心显示图标.", "人工智能核心显示", iconstates)
	if(!ai_core_icon || incapacitated())
		return

	icon_state = resolve_ai_icon(ai_core_icon)


/mob/living/silicon/ai/cancel_camera()
	set category = "Silicon"
	set name = "Cancel Camera View"

	view_core()


/mob/living/silicon/ai/verb/toggle_acceleration()
	set category = "Silicon"
	set name = "Toggle Camera Acceleration"

	if(incapacitated())
		return

	acceleration = !acceleration

	to_chat(src, span_notice("摄像头加速已[acceleration ? "enabled" : "disabled"]."))


/mob/living/silicon/ai/verb/radio_settings()
	set category = "Silicon"
	set name = "Radio Settings"

	if(incapacitated())
		return

	if(!radio)
		to_chat(src, span_warning("未检测到内部无线电."))
		return

	to_chat(src, span_notice("正在访问内部无线电设置."))
	radio.interact(src)


/mob/living/silicon/ai/verb/view_manifest()
	set category = "Silicon"
	set name = "View Crew Manifest"

	if(incapacitated())
		return

	GLOB.crew_manifest.open_ui(src)

/mob/living/silicon/ai/verb/toggle_anchor()
	set category = "Silicon"
	set name = "Toggle Floor Bolts"

	if(!isturf(loc)) // if their location isn't a turf
		return // stop
	if(stat == DEAD)
		return

	anchored = !anchored
	if(!anchored)
		move_resist = MOVE_RESIST_DEFAULT
	else
		move_resist = initial(move_resist)
	playsound(loc,'sound/mecha/mechanical_toggle.ogg', 20)

	to_chat(src, span_notice("<b>你现在[anchored ? "" : "un"]已锚定.</b>"))

/mob/living/silicon/ai/verb/show_laws()
	set category = "Silicon"
	set name = "Show Laws"

	if(incapacitated())
		return

	to_chat(src, span_notice("<b>遵守这些法则:</b>"))
	for(var/i in laws)
		to_chat(src, span_notice("[i]"))


/mob/living/silicon/ai/verb/state_laws()
	set category = "Silicon"
	set name = "State Laws"

	if(incapacitated())
		return

	if(tgui_alert(src, "你确定要公告你的法则[radiomod ? " over the [radiomod] channel" : ""]吗?", "陈述法则", list("Yes", "No")) != "Yes")
		return

	say("[radiomod] Current Active Lawset:")

	var/delay = 1 SECONDS
	for(var/i in laws)
		addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, say), "[radiomod] [i]"), delay)
		delay += 1 SECONDS


/mob/living/silicon/ai/verb/set_autosay()
	set category = "Silicon"
	set name = "Set Announce Mode"

	if(incapacitated())
		return

	if(!radio)
		to_chat(src, "未检测到无线电.")
		return

	var/chan = tgui_input_list(usr, "选择一个频道:", "", list("Default", "None") + radio.channels )
	if(!chan)
		return

	if(chan == "Default")
		radiomod = ";"
		chan += " ([radio.frequency])"
	else if(chan == "None")
		radiomod = ""
	else
		for(var/key in GLOB.department_radio_keys)
			if(GLOB.department_radio_keys[key] == chan)
				radiomod = ":" + key
				break

	to_chat(src, span_notice("自动公告[chan == "None" ? "will not use the radio." : "set to [chan]."]"))


/mob/living/silicon/ai/verb/shutdown_systems()
	set category = "Silicon"
	set name = "Shutdown Systems"


	if(tgui_alert(src, "你想关闭你的系统吗? 警告: 这将永久性地使你脱离你的躯体.", "关闭系统", list("Yes", "No")) != "Yes")
		return

	if(tgui_alert(src, "你确定要关闭你的系统吗? 你将无法返回你的身体. 你无法改变主意, 所以请慎重选择!", "确认关闭系统", list("Yes", "No")) != "Yes")
		return

	to_chat(src, span_notice("系统正在关闭..."))
	icon_state = "ai"

	log_game("[key_name(src)] has ghosted at [AREACOORD(src)].")
	message_admins("[ADMIN_TPMONTY(src)] has ghosted.")

	priority_announce("[src]已被断开. 正在等待加载新的人格...", "人工智能故障", sound = 'sound/AI/aileft.ogg')
	ghostize(FALSE)
	offer_mob()
