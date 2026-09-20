ADMIN_VERB(set_view_range, R_FUN, "Set View Range", "Sets custom view range for yourself", ADMIN_CATEGORY_FUN)

	if(user.view_size.get_client_view_size() != user.view_size.default)
		user.view_size.reset_to_default()
		return

	var/newview = input(user, "Select view range:", "Change View Range", 7) as null|num
	if(!newview)
		return

	newview = VIEW_NUM_TO_STRING(newview)
	if(newview == user.view)
		return

	user.view_size.set_view_radius_to(newview)

	log_admin("[key_name(user)] changed their view range to [user.view].")
	message_admins("[ADMIN_TPMONTY(user.mob)] changed their view range to [user.view].")

ADMIN_VERB(emp, R_FUN, "EM Pulse", "Release an EMP of your size of choice", ADMIN_CATEGORY_FUN)
	var/heavy = input(user, "Range of heavy pulse.", "EM Pulse") as num|null
	if(isnull(heavy))
		return

	var/light = input(user,"Range of light pulse.", "EM Pulse") as num|null
	if(isnull(light))
		return

	heavy = clamp(heavy, 0, 10000)
	light = clamp(light, 0, 10000)

	empulse(user.mob, heavy, light)

	log_admin("[key_name(user,)] created an EM Pulse ([heavy], [light]) at [AREACOORD(user.mob)].")
	message_admins("[ADMIN_TPMONTY(user.mob)] created an EM Pulse ([heavy], [light]) at [ADMIN_VERBOSEJMP(user.mob)].")

ADMIN_VERB(queen_report, R_FUN, "Queen Mother Report", "Play a Queen mother report to xenos.", ADMIN_CATEGORY_FUN)
	var/customname = tgui_input_text(user, "你希望这份报告标题是什么?", "报告标题", "Queen Mother Directive", encode = FALSE)
	var/input = tgui_input_text(user, "这应该是来自异形种族统治者的一条消息.", "女王母亲报告", "", multiline = TRUE, encode = FALSE)
	if(!input || !customname)
		return


	for(var/i in (GLOB.xeno_mob_list + GLOB.observer_list))
		var/mob/M = i
		to_chat(M, assemble_alert(
			title = customname,
			message = input,
			color_override = "purple"
		))

	log_admin("[key_name(user)] created a Queen Mother report: [input]")
	message_admins("[ADMIN_TPMONTY(user.mob)] created a Queen Mother report.")

ADMIN_VERB(hive_status, R_FUN, "Check Hive Status", "Check the status of the hive.", ADMIN_CATEGORY_FUN)
	if(!SSticker)
		return

	check_hive_status(user)

	log_admin("[key_name(user)] checked the hive status.")
	message_admins("[key_name_admin(user)] checked the hive status.")

ADMIN_VERB(ai_report, R_FUN, "AI Report", "Create an AI report to players", ADMIN_CATEGORY_FUN)
	var/customname = tgui_input_text(user, "你希望AI被称为什么?.", "AI报告", "AI", encode = FALSE)
	var/input = tgui_input_text(user, "这应该是来自飞船AI的一条消息.", "AI报告", multiline = TRUE, encode = FALSE)
	if(!input || !customname)
		return

	var/paper
	switch(tgui_alert(user, "你想在通讯控制台打印一份纸质文件吗?", "AI报告", list("Yes", "No", "Cancel")))
		if("Yes")
			paper = TRUE
		if("No")
			paper = FALSE
		else
			return

	priority_announce(input, customname, sound = 'sound/misc/interference.ogg')

	if(paper)
		print_command_report(input, "[customname] Update", announce = FALSE)

	log_admin("[key_name(user)] has created an AI report: [input]")
	message_admins("[ADMIN_TPMONTY(user.mob)] has created an AI report: [input]")

ADMIN_VERB(command_report, R_FUN, "Command Report", "Create a custom command report", ADMIN_CATEGORY_FUN)
	var/customname = tgui_input_text(user, "为报告选择一个标题.", "标题", "TGMC Update", encode = FALSE)
	if(!customname)
		return
	var/customsubtitle = tgui_input_text(user, "为报告选择一个副标题.", "副标题", "", encode = FALSE)
	var/input = tgui_input_text(user, "请输入任何你想要的内容.任何内容.严肃的.", "什么?", "", multiline = TRUE, encode = FALSE)
	if(!input)
		return
	var/override = tgui_input_list(user, "为报告选择一种颜色.", "颜色", faction_alert_colors - "default", default = "blue")

	if(tgui_alert(user, "你想在通讯控制台打印一份纸质文件吗?", null, list("Yes", "No")) == "Yes")
		print_command_report(input, "[SSmapping.configs[SHIP_MAP].map_name] Update", announce = FALSE)

	switch(tgui_alert(user, "这应该向全体人员公告吗?", "公告", list("Yes", "No", "Cancel")))
		if("Yes")
			priority_announce(input, customname, customsubtitle, sound = 'sound/AI/commandreport.ogg', color_override = override);
		if("No")
			priority_announce("新公告已在所有通讯控制台可用.", "收到一条机密传输", type = ANNOUNCEMENT_PRIORITY, sound = 'sound/AI/commandreport.ogg')
		else
			return

	log_admin("[key_name(user)] has created a command report: [input]")
	message_admins("[ADMIN_TPMONTY(user.mob)] has created a command report.")

ADMIN_VERB(narrate_global, R_FUN, "Global Narrate", "Directly send text to everyone", ADMIN_CATEGORY_FUN)
	var/msg = tgui_input_text(user, "输入你希望所有人看到的文本.", "全局叙述", multiline = TRUE , encode = FALSE)

	if(!msg)
		return

	to_chat(world, msg)

	log_admin("GlobalNarrate: [key_name(user)] : [msg]")
	message_admins("[ADMIN_TPMONTY(user.mob)] used Global Narrate: [msg]")

ADMIN_VERB_AND_CONTEXT_MENU(narrate_direct, R_FUN, "Direct Narrate", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_MAIN, mob/M in GLOB.mob_list)
	var/msg = tgui_input_text(user, "输入你希望你的目标看到的文本.", "直接叙述", multiline = TRUE, encode = FALSE)
	if(!msg)
		return

	to_chat(M, "[msg]")

	log_admin("DirectNarrate: [key_name(user)] to [key_name(M)]: [msg]")
	message_admins("[ADMIN_TPMONTY(user.mob)] used Direct Narrate on [ADMIN_TPMONTY(M)]: [msg]")
ADMIN_VERB_AND_CONTEXT_MENU(subtle_message, R_FUN, "Subtle Message", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_FUN, mob/M in GLOB.mob_list)
	var/msg = tgui_input_text(user, "向[key_name(M)]发送隐秘私信:", "隐秘消息", "", multiline = TRUE, encode = FALSE)

	if(!M?.client || !msg)
		return

	if(check_rights(R_ADMIN, FALSE))
		msg = noscript(msg)
	else
		msg = sanitize(msg)

	to_chat(M, "<b>你脑海中听到一个声音... [msg]</b>")

	admin_ticket_log(M, "[key_name_admin(user)] used Subtle Message: [sanitize(msg)]")
	log_admin("SubtleMessage: [key_name(user)] to [key_name(M)]: [msg]")
	message_admins("[ADMIN_TPMONTY(user.mob)] used Subtle Message on [ADMIN_TPMONTY(M)]: [msg]")

ADMIN_VERB(award_medal, R_FUN, "Award a Medal", "Award a medal to a marine player", ADMIN_CATEGORY_FUN)
	give_medal_award()

ADMIN_VERB(custom_info, R_FUN, "Change Custom Info", "Set a custom info to show to everyone and new joining players", ADMIN_CATEGORY_FUN)
	var/new_info = tgui_input_text(user, "设置玩家在加入时或通过OOC标签页获得的定制信息.", "定制信息", GLOB.custom_info, multiline = TRUE, encode = FALSE)
	new_info = noscript(new_info)
	if(isnull(new_info) || GLOB.custom_info == new_info)
		return

	if(!new_info)
		log_admin("[key_name(user)] has cleared the custom info.")
		message_admins("[ADMIN_TPMONTY(user.mob)] has cleared the custom info.")
		return

	GLOB.custom_info = new_info

	to_chat(world, assemble_alert(
		title = "定制信息",
		subtitle = "管理员为本回合设置了定制信息.",
		message = GLOB.custom_info,
		color_override = "red"
	))
	SEND_SOUND(user, sound('sound/misc/adm_announce.ogg'))

	log_admin("[key_name(user)] has changed the custom event text: [GLOB.custom_info]")
	message_admins("[ADMIN_TPMONTY(user.mob)] has changed the custom event text.")

/client/verb/custom_info()
	set category = "OOC"
	set name = "Custom Info"

	if(!GLOB.custom_info)
		to_chat(src, span_notice("当前没有设置定制信息."))
		return

	to_chat(src, assemble_alert(
		title = "定制信息",
		subtitle = "管理员为本回合设置了定制信息.",
		message = GLOB.custom_info,
		color_override = "red"
	))
	SEND_SOUND(src, sound('sound/misc/adm_announce.ogg'))

ADMIN_VERB(sound_file, R_SOUND, "Play Imported Sound", "Play a sound imported from anywhere on your computer.", ADMIN_CATEGORY_FUN, S as sound)
	var/heard_midi = 0
	var/sound/uploaded_sound = sound(S, repeat = 0, wait = 1, channel = CHANNEL_MIDI)
	uploaded_sound.priority = 250

	var/style = tgui_alert(user, "全局或本地播放声音?", "播放导入的声音", list("Global", "Local"), timeout = 0)
	switch(style)
		if("Global")
			for(var/i in GLOB.clients)
				var/client/C = i
				if(C.prefs.volume_adminmusic)
					uploaded_sound.volume = C.prefs.volume_adminmusic
					SEND_SOUND(C, uploaded_sound)
					heard_midi++
		if("Local")
			playsound(get_turf(user.mob), uploaded_sound, 50, 0)
			for(var/mob/M in view())
				heard_midi++
		else
			return
	log_admin("[key_name(user)] played sound '[S]' for [heard_midi] player(s). [length(GLOB.clients) - heard_midi] player(s) [style == "Global" ? "have disabled admin midis" : "were out of view"].")
	message_admins("[ADMIN_TPMONTY(user.mob)] played sound '[S]' for [heard_midi] player(s). [length(GLOB.clients) - heard_midi] player(s) [style == "Global" ? "have disabled admin midis" : "were out of view"].")

ADMIN_VERB(sound_web, R_SOUND, "Play Internet Sound", "Play a sound using a link to a website.", ADMIN_CATEGORY_FUN)
	var/ytdl = get_configured_yt_dlp()
	var/cobalt = CONFIG_GET(string/cobalt_base_api)
	if(!ytdl && !cobalt)
		to_chat(user, span_warning("未配置 yt-dlp 或 cobalt.tools, 操作不可用."))
		return

	var/web_sound_input = input("Enter content URL (supported sites only)", "Play Internet Sound") as text|null
	if(!istext(web_sound_input) || !length(web_sound_input))
		return

	web_sound_input = trim(web_sound_input)

	if(findtext(web_sound_input, ":") && !findtext(web_sound_input, GLOB.is_http_protocol))
		to_chat(user, span_warning("不允许使用非 http(s) URI."))
		to_chat(user, span_warning("对于像 ytsearch: 这样的 yt-dlp 快捷方式, 请使用网站中相应的完整 URL."))
		return

	var/datum/internet_media/backend
	if(cobalt)
		backend = new /datum/internet_media/cobalt()
	else
		backend = new /datum/internet_media/yt_dlp()

	var/datum/media_response/media = backend.get_media(web_sound_input)
	if(!media)
		to_chat(user, span_warning("[backend.error]"))
		return

	var/web_sound_url = media.url
	var/title = media.title
	var/list/music_extra_data = list()
	var/show = FALSE

	if(title)
		music_extra_data["duration"] = media.start_time ? DisplayTimeText(media.start_time * 1 SECONDS) : null
		music_extra_data["link"] = web_sound_input
		switch(tgui_alert(user, "向玩家显示此歌曲的标题和链接?\n[title]", "播放网络声音", list("Yes", "No", "Cancel")))
			if("Yes")
				music_extra_data["title"] = title
				show = TRUE
			if("No")
				music_extra_data["link"] = "Song Link Hidden"
				music_extra_data["title"] = "Song Title Hidden"
				show = FALSE
			else
				return
	else
		music_extra_data["link"] = web_sound_input

	if(web_sound_url && !findtext(web_sound_url, GLOB.is_http_protocol))
		to_chat(user, span_warning("已阻止: 内容 URL 未使用 http(s) 协议"))
		to_chat(user, span_warning("媒体提供程序返回的内容 URL 未使用 HTTP 或 HTTPS 协议"))
		return

	var/list/targets
	var/style = tgui_input_list(user, "你想全局播放还是对异形/陆战队播放?", null, list("Globally", "Xenos", "Marines", "Locally"))
	switch(style)
		if("Globally")
			targets = GLOB.player_list
		if("Xenos")
			targets = GLOB.xeno_mob_list + GLOB.observer_list
		if("Marines")
			targets = GLOB.human_mob_list + GLOB.observer_list
		if("Locally")
			targets = viewers(user.view, user.mob)
		else
			return

	var/to_show_text
	var/anon = tgui_alert(user, "显示谁播放了歌曲?", "鸣谢自己?", list("No", "Yes", "Cancel"))
	switch(anon)
		if("Yes")
			if(show)
				to_show_text = "[user.ckey] played: <a href='[music_extra_data["link"]]'>[title]</a>"
			else
				to_show_text = "[user.ckey] played some music"
		if("No")
			if(show)
				to_show_text = "An admin played: <a href='[music_extra_data["link"]]'>[title]</a>"
		else
			return
	for(var/i as anything in targets)
		var/mob/M = i
		var/client/C = M?.client
		if(!C?.prefs)
			continue
		if(C.prefs.volume_adminmusic)
			C.tgui_panel?.play_music(web_sound_url, music_extra_data)
			to_chat(C, span_boldannounce(to_show_text))

	log_admin("[key_name(user)] played web sound: [web_sound_input] - [title] - [style]")
	message_admins("[ADMIN_TPMONTY(user.mob)] played web sound: [web_sound_input] - [title] - [style]")

ADMIN_VERB(sound_stop, R_SOUND, "Stop Regular Sounds", "Stop all sounds currently playing.", ADMIN_CATEGORY_FUN)
	for(var/mob/M in GLOB.player_list)
		if(M.client)
			SEND_SOUND(M, sound(null))

	log_admin("[key_name(user)] stopped regular sounds.")
	message_admins("[ADMIN_TPMONTY(user.mob)] stopped regular sounds.")

ADMIN_VERB(music_stop, R_SOUND, "Stop Playing Music", "Stop currently playing internet sound.", ADMIN_CATEGORY_FUN)
	for(var/i in GLOB.clients)
		var/client/C = i
		C?.tgui_panel?.stop_music()

	log_admin("[key_name(user)] stopped the currently playing music.")
	message_admins("[ADMIN_TPMONTY(user.mob)] stopped the currently playing music.")

ADMIN_VERB(announce, R_FUN, "Admin Announce", "Do an admin announcement to all players.", ADMIN_CATEGORY_FUN)
	var/message = tgui_input_text(user, "要发送的全局消息:", "管理员公告", multiline = TRUE, encode = FALSE)

	message = noscript(message)

	if(!message)
		return

	log_admin("Announce: [key_name(user)] : [message]")
	message_admins("[ADMIN_TPMONTY(user.mob)] Announces:")
	send_ooc_announcement(message, "From [user.holder.fakekey ? "Administrator" : user.ckey]", style = OOC_ALERT_ADMIN)

ADMIN_VERB(force_distress, R_FUN, "Distress Beacon", "Call a distress beacon manually.", ADMIN_CATEGORY_FUN)
	if(!SSticker?.mode)
		to_chat(user, span_warning("请先等待回合开始."))

	if(SSticker.mode.waiting_for_candidates)
		to_chat(user, span_warning("请等待当前信标完成."))
		return

	if(SSticker.mode.picked_call)
		SSticker.mode.picked_call.reset()
		SSticker.mode.picked_call = null

	var/list/list_of_calls = list()
	for(var/datum/emergency_call/L in SSticker.mode.all_calls)
		if(L.name)
			list_of_calls += L.name

	list_of_calls += "Randomize"

	var/choice = tgui_input_list(user, "你想呼叫哪种求救信号?", null, list_of_calls)
	if(!choice)
		return

	if(choice == "Randomize")
		SSticker.mode.picked_call = SSticker.mode.get_random_call()
	else
		for(var/datum/emergency_call/C in SSticker.mode.all_calls)
			if(C.name == choice)
				SSticker.mode.picked_call = C
				break

	if(!istype(SSticker.mode.picked_call))
		return

	var/max = tgui_input_number(user, "最大生物数量应为多少?", "最大生物数", SSticker.mode.picked_call.mob_max)
	if(!max || max < 1)
		return

	SSticker.mode.picked_call.mob_max = max

	var/min = tgui_input_number(user, "最小生物数量应为多少?", "最小生物数", SSticker.mode.picked_call.mob_min)
	if(!min || min < 1)
		min = 0

	SSticker.mode.picked_call.mob_min = min

	var/is_announcing = TRUE
	if(tgui_alert(user, "你想向服务器全体玩家公告求救信标吗? 这会将求救信标显示给所有玩家.", "公告求救信标?", list("Yes", "No")) != "Yes")
		is_announcing = FALSE

	SSticker.mode.picked_call.activate(is_announcing)

	log_admin("[key_name(user)] called a [choice == "Randomize" ? "randomized ":""]distress beacon: [SSticker.mode.picked_call.name]. Min: [min], Max: [max].")
	message_admins("[ADMIN_TPMONTY(user.mob)] called a [choice == "Randomize" ? "randomized ":""]distress beacon: [SSticker.mode.picked_call.name] Min: [min], Max: [max].")

ADMIN_VERB(drop_bomb, R_FUN, "Drop Bomb", "Cause an explosion of varying strength at your location.", ADMIN_CATEGORY_FUN)
	var/choice = tgui_input_list(user, "你想产生哪种爆炸?", "投放炸弹", list("CAS: Widow Maker", "CAS: Banshee", "CAS: Keeper", "CAS: Fatty", "CAS: Napalm", "Small Bomb", "Medium Bomb", "Big Bomb", "Custom Bomb"))
	switch(choice)
		if("CAS: Widow Maker")
			playsound(user.mob.loc, 'sound/machines/hydraulics_2.ogg', 70, TRUE)
			new /obj/effect/overlay/temp/blinking_laser (user.mob.loc)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(delayed_detonate_bomb), get_turf(user.mob.loc), 320, 80, 3), 1 SECONDS)
		if("CAS: Banshee")
			playsound(user.mob.loc, 'sound/machines/hydraulics_2.ogg', 70, TRUE)
			new /obj/effect/overlay/temp/blinking_laser (user.mob.loc)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(delayed_detonate_bomb_banshee), get_turf(user.mob.loc)), 1 SECONDS)
		if("CAS: Keeper")
			playsound(user.mob.loc, 'sound/machines/hydraulics_2.ogg', 70, TRUE)
			new /obj/effect/overlay/temp/blinking_laser (user.mob.loc)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(delayed_detonate_bomb), get_turf(user.mob.loc), 450, 120, 3), 1 SECONDS)
		if("CAS: Fatty")
			playsound(user.mob.loc, 'sound/machines/hydraulics_2.ogg', 70, TRUE)
			new /obj/effect/overlay/temp/blinking_laser (user.mob.loc)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(delayed_detonate_bomb_fatty), get_turf(user.mob.loc)), 1 SECONDS)
		if("CAS: Napalm")
			playsound(user.mob.loc, 'sound/machines/hydraulics_2.ogg', 70, TRUE)
			new /obj/effect/overlay/temp/blinking_laser (user.mob.loc)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(delayed_detonate_bomb_napalm), get_turf(user.mob.loc)), 1 SECONDS)
		if("Small Bomb")
			cell_explosion(user.mob.loc, 150, 50)
		if("Medium Bomb")
			cell_explosion(user.mob.loc, 250, 75)
		if("Big Bomb")
			cell_explosion(user.mob.loc, 420, 70)
		if("Custom Bomb")
			var/input_severity = tgui_input_number(user, "爆炸强度:", "投放炸弹", 500, EXPLOSION_MAX_POWER, 1)
			if(isnull(input_severity))
				return
			var/input_falloff = tgui_input_number(user, "爆炸衰减:", "投放炸弹", 50, EXPLOSION_MAX_POWER, 1)
			if(isnull(input_falloff))
				return
			var/input_shape
			switch(tgui_alert(user, "衰减形状", "选择衰减形状", list("Linear", "Exponential"), 0))
				if("Linear")
					input_shape = EXPLOSION_FALLOFF_SHAPE_LINEAR
				if("Exponential")
					input_shape = EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL
			switch(tgui_alert(user, "部署载荷?", "强度: [input_severity] | 衰减: [input_falloff]", list("Launch!", "Cancel"), 0))
				if("Launch!")
					cell_explosion(user.mob.loc, input_severity, input_falloff, input_shape)
				else
					return
			choice = "[choice] ([input_severity], [input_falloff])" //For better logging.
		else
			return

	log_admin("[key_name(user)] dropped a [choice] at [AREACOORD(user.mob)].")
	message_admins("[ADMIN_TPMONTY(user.mob)] dropped a [choice] at [ADMIN_VERBOSEJMP(user.mob)].")

/proc/delayed_detonate_bomb(turf/impact, input_power, input_falloff, ceiling_debris)
	if(ceiling_debris)
		impact.ceiling_debris_check(ceiling_debris)
	cell_explosion(impact, input_power, input_falloff)

/proc/delayed_detonate_bomb_banshee(turf/impact)
	impact.ceiling_debris_check(3)
	cell_explosion(impact, 320, 100)
	flame_radius(7, impact)

/proc/delayed_detonate_bomb_fatty(turf/impact)
	impact.ceiling_debris_check(2)
	cell_explosion(impact, 250, 90)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(delayed_detonate_bomb_fatty_final), impact), 3 SECONDS)

/proc/delayed_detonate_bomb_fatty_final(turf/impact)
	var/list/impact_coords = list(list(-3, 3), list(0, 4), list(3, 3), list(-4, 0), list(4, 0), list(-3, -3), list(0, -4), list(3, -3))
	for(var/i in 1 to 8)
		var/list/coords = impact_coords[i]
		var/turf/detonation_target = locate(impact.x+coords[1],impact.y+coords[2],impact.z)
		detonation_target.ceiling_debris_check(2)
		cell_explosion(detonation_target, 250, 90, adminlog = FALSE)

/proc/delayed_detonate_bomb_napalm(turf/impact)
	impact.ceiling_debris_check(3)
	cell_explosion(impact, 250, 90)
	flame_radius(5, impact, 30, 60)

ADMIN_VERB(drop_ob, R_FUN, "Drop OB", "Cause an OB explosion of varying strength at your location", ADMIN_CATEGORY_FUN)
	var/list/firemodes = list("Standard OB List", "Custom HE", "Custom Cluster", "Custom Incendiary", "Custom Plasmaloss")
	var/mode = tgui_input_list(user, "选择开火模式:", "开火模式", firemodes)
	// Select the warhead.
	var/obj/structure/ob_ammo/warhead/warhead
	switch(mode)
		if("Standard OB List")
			var/list/warheads = subtypesof(/obj/structure/ob_ammo/warhead/)
			var/choice = tgui_input_list(user, "选择弹头:", "要使用的弹头", warheads)
			warhead = new choice
		if("Custom HE")
			var/obj/structure/ob_ammo/warhead/explosive/OBShell = new
			OBShell.explosion_power = tgui_input_number(user, "墙体清除爆炸应具有多少爆炸威力?", "设置清除威力", 1425, EXPLOSION_MAX_POWER, 1)
			if(isnull(OBShell.explosion_power))
				return
			OBShell.explosion_falloff = tgui_input_number(user, "墙体清除爆炸应具有多少衰减?", "设置清除衰减", 90, EXPLOSION_MAX_POWER, 1)
			if(isnull(OBShell.explosion_falloff))
				return
			warhead = OBShell
		if("Custom Cluster")
			var/obj/structure/ob_ammo/warhead/cluster/OBShell = new
			OBShell.cluster_amount = tgui_input_number(user, "应发射多少轮齐射?", "设置集束数量", 25, 100)
			if(isnull(OBShell.cluster_amount))
				return
			OBShell.cluster_power = tgui_input_number(user, "爆炸应有多强?", "设置爆炸威力", 240, EXPLOSION_MAX_POWER, 1)
			if(isnull(OBShell.cluster_power))
				return
			OBShell.cluster_falloff = tgui_input_number(user, "爆炸应有多少衰减?", "设置爆炸衰减", 40, EXPLOSION_MAX_POWER, 1)
			if(isnull(OBShell.cluster_falloff))
				return
			warhead = OBShell
		if("Custom Incendiary")
			var/obj/structure/ob_ammo/warhead/incendiary/OBShell = new
			OBShell.flame_intensity = tgui_input_number(user, "火焰应有多猛烈?", "设置火焰强度", 36)
			if(isnull(OBShell.flame_intensity))
				return
			OBShell.flame_duration = tgui_input_number(user, "火焰应持续多久?", "设置火焰持续时间", 40)
			if(isnull(OBShell.flame_duration))
				return
			var/list/fire_colors = list("red", "green", "blue")
			OBShell.flame_colour = tgui_input_list(user, "选择火焰颜色:", "火焰颜色", fire_colors, "blue")
			if(isnull(OBShell.flame_colour))
				return
			OBShell.smoke_radius = tgui_input_number(user, "烟雾应扩散多远?", "设置烟雾半径", 17, 255, 1, 0)
			if(isnull(OBShell.smoke_radius))
				return
			OBShell.smoke_duration = tgui_input_number(user, "烟雾应持续多久?", "设置烟雾持续时间", 20, 360, 1, 0)
			if(isnull(OBShell.smoke_duration))
				return
			warhead = OBShell
		if("Custom Plasmaloss")
			var/obj/structure/ob_ammo/warhead/plasmaloss/OBShell = new
			OBShell.smoke_radius = tgui_input_number(user, "烟雾半径应为多少格?", "设置烟雾半径", 25, 255, 1, 0)
			if(isnull(OBShell.smoke_radius))
				return
			OBShell.smoke_duration = tgui_input_number(user, "烟雾应持续多久?", "设置烟雾持续时间", 30, 360, 1, 0)
			if(isnull(OBShell.smoke_duration))
				return
			warhead = OBShell
		else
			return

	var/turf/target = get_turf(user.mob.loc)

	switch(tgui_input_list(user, "你到底想要什么?", "模式", list("Immitate Orbital Cannon shot.", "Spawn OB effects.", "Spawn Warhead."), "Immitate Orbital Cannon shot", 0))
		if("Immitate Orbital Cannon shot.")
			playsound_z_humans(target.z, 'sound/effects/OB_warning_announce.ogg', 100) //for marines on ground
			playsound(target, 'sound/effects/OB_warning_announce_novoiceover.ogg', 125, FALSE, 30, 10) //VOX-less version for xenomorphs

			var/impact_time = 10 SECONDS
			var/impact_timerid = addtimer(CALLBACK(warhead, TYPE_PROC_REF(/obj/structure/ob_ammo/warhead, warhead_impact), target), impact_time, TIMER_STOPPABLE)

			var/canceltext = "Warhead: [warhead.warhead_kind]. Impact at [ADMIN_VERBOSEJMP(target)] <a href='byond://?_src_=holder;[HrefToken(TRUE)];cancelob=[impact_timerid]'>\[CANCEL OB\]</a>"
			message_admins("[span_prefix("OB FIRED:")] <span class='message linkify'>[canceltext]</span>")
			log_game("OB fired by [key_name(user)] at [AREACOORD(target)], OB type: [warhead.warhead_kind], timerid to cancel: [impact_timerid]")
			notify_ghosts("<b>[key_name(user)]</b> has just fired \the <b>[warhead]</b>!", source = target, action = NOTIFY_JUMP)

			warhead.impact_message(target, impact_time)

			sleep((impact_time / 3) - 0.5 SECONDS)
			for(var/mob/our_mob AS in hearers(WARHEAD_FALLING_SOUND_RANGE, target))
				our_mob.playsound_local(target, 'sound/effects/OB_incoming.ogg', falloff = 2)
			new /obj/effect/temp_visual/ob_impact(target, warhead)
		if("Spawn OB effects.")
			message_admins("[key_name(user)] has fired \an [warhead.name] at ([target.x],[target.y],[target.z]).")
			warhead.warhead_impact(target)
		if("Spawn Warhead.")
			warhead.loc = target

ADMIN_VERB(change_security_level, R_FUN, "Set Security Level", "Set the security level of the ship", ADMIN_CATEGORY_FUN)
	var/sec_level = tgui_input_list(user, "当前安全等级为 [SSsecurity_level.get_current_level_as_text()]. 选择新的安全等级.", "设置安全等级", SSsecurity_level.available_levels - SSsecurity_level.get_current_level_as_text())
	if(!sec_level)
		return

	if(tgui_alert(user, "从 [SSsecurity_level.get_current_level_as_text()] 切换到 [sec_level]?", "设置安全等级", list("Yes", "No")) != "Yes")
		return

	SSsecurity_level.set_level(sec_level, TRUE)

	log_admin("[key_name(user)] changed the security level to [sec_level].")
	message_admins("[ADMIN_TPMONTY(user.mob)] changed the security level to [sec_level].")

ADMIN_VERB_ONLY_CONTEXT_MENU(rank_and_equipment, R_FUN, "Rank and Equipment", mob/living/carbon/human/H in GLOB.human_mob_list)
	var/dat = "<br>"
	var/obj/item/card/id/C = H.wear_id

	if(!H.mind)
		dat += "No mind! <a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=createmind;mob=[REF(H)]'>Create</a><br>"
		dat += "Take-over job: [H.job ? H.job.title : "None"] <a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=rank;mob=[REF(H)]'>Edit</a><br>"
		if(ismarinejob(H.job))
			dat += "Squad: [H.assigned_squad] <a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=squad;mob=[REF(H)]'>Edit</a><br>"
	else
		dat += "Job: [H.job ? H.job.title : "Unassigned"] <a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=rank;mob=[REF(H)]'>Edit</a> "
		dat += "<a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=rank;doequip=1;mob=[REF(H)]'>Edit and Equip</a> "
		dat += "<a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=rank;doset=1;mob=[REF(H)]'>Edit and Set</a><br>"
		dat += "<br>"
		dat += "Skillset: [H.skills.name] <a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=skills;mob=[REF(H)]'>Edit</a><br>"
		dat += "Comms title: [H.comm_title] <a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=commstitle;mob=[REF(H)]'>Edit</a><br>"
		if(ismarinejob(H.job))
			dat += "Squad: [H.assigned_squad] <a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=squad;mob=[REF(H)]'>Edit</a><br>"
	if(istype(C))
		dat += "<br>"
		dat += "Chat title: [get_paygrades(C.paygrade, FALSE, H.gender)] <a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=chattitle;mob=[REF(H)];id=[REF(C)]'>Edit</a><br>"
		dat += "ID title: [C.assignment] <a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=idtitle;mob=[REF(H)];id=[REF(C)]'>Edit</a><br>"
		dat += "ID name: [C.registered_name] <a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=idname;mob=[REF(H)];id=[REF(C)]'>Edit</a><br>"
		dat += "Access: [get_access_job_name(C)] <a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=access;mob=[REF(H)];id=[REF(C)]'>Edit</a><br>"
	else
		dat += "No ID! <a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=createid;mob=[REF(H)]'>Give ID</a><br>"

	dat += "<br>"
	dat += "<a href='byond://?src=[REF(user.holder)];[HrefToken()];rank=equipment;mob=[REF(H)]'>Select Equipment</a>"


	var/datum/browser/browser = new(user.mob, "edit_rank_[key_name(H)]", "<div align='center'>Edit Rank [key_name(H)]</div>", 400, 350)
	browser.set_content(dat)
	browser.open(FALSE)

ADMIN_VERB_ONLY_CONTEXT_MENU(edit_appearance, R_FUN, "Edit Appearance", mob/living/carbon/human/H in GLOB.human_mob_list)
	if(!istype(H))
		return

	var/hcolor = "#[num2hex(H.r_hair, 2)][num2hex(H.g_hair, 2)][num2hex(H.b_hair, 2)]"
	var/fcolor = "#[num2hex(H.r_facial, 2)][num2hex(H.g_facial, 2)][num2hex(H.b_facial, 2)]"
	var/ecolor = "#[num2hex(H.r_eyes, 2)][num2hex(H.g_eyes, 2)][num2hex(H.b_eyes, 2)]"
	var/bcolor = "#[num2hex(H.r_skin, 2)][num2hex(H.g_skin, 2)][num2hex(H.b_skin, 2)]"

	var/dat = "<br>"

	dat += "Hair style: [H.h_style] <a href='byond://?src=[REF(user.holder)];[HrefToken()];appearance=hairstyle;mob=[REF(H)]'>Edit</a><br>"
	dat += "Hair color: <font face='fixedsys' size='3' color='[hcolor]'><table style='display:inline;' bgcolor='[hcolor]'><tr><td>_.</td></tr></table></font> <a href='byond://?src=[REF(user.holder)];[HrefToken()];appearance=haircolor;mob=[REF(H)]'>Edit</a><br>"
	dat += "<br>"
	dat += "Facial hair style: [H.f_style] <a href='byond://?src=[REF(user.holder)];[HrefToken()];appearance=facialhairstyle;mob=[REF(H)]'>Edit</a><br>"
	dat += "Facial hair color: <font face='fixedsys' size='3' color='[fcolor]'><table style='display:inline;' bgcolor='[fcolor]'><tr><td>_.</td></tr></table></font> <a href='byond://?src=[REF(user.holder)];[HrefToken()];appearance=facialhaircolor;mob=[REF(H)]'>Edit</a><br>"
	dat += "<br>"
	dat += "Eye color: <font face='fixedsys' size='3' color='[ecolor]'><table style='display:inline;' bgcolor='[ecolor]'><tr><td>_.</td></tr></table></font> <a href='byond://?src=[REF(user.holder)];[HrefToken()];appearance=eyecolor;mob=[REF(H)]'>Edit</a><br>"
	dat += "Body color: <font face='fixedsys' size='3' color='[bcolor]'><table style='display:inline;' bgcolor='[bcolor]'><tr><td>_.</td></tr></table></font> <a href='byond://?src=[REF(user.holder)];[HrefToken()];appearance=bodycolor;mob=[REF(H)]'>Edit</a><br>"
	dat += "<br>"
	dat += "Gender: [H.gender] <a href='byond://?src=[REF(user.holder)];[HrefToken()];appearance=gender;mob=[REF(H)]'>Edit</a><br>"
	dat += "Ethnicity: [H.ethnicity] <a href='byond://?src=[REF(user.holder)];[HrefToken()];appearance=ethnicity;mob=[REF(H)]'>Edit</a><br>"
	dat += "Species: [H.species] <a href='byond://?src=[REF(user.holder)];[HrefToken()];appearance=species;mob=[REF(H)]'>Edit</a><br>"

	var/datum/browser/browser = new(user.mob, "edit_appearance_[key_name(H)]", "<div align='center'>Edit Appearance [key_name(H)]</div>")
	browser.set_content(dat)
	browser.open(FALSE)

ADMIN_VERB_ONLY_CONTEXT_MENU(offer, R_ADMIN, "Offer Mob", mob/living/L in GLOB.mob_living_list)
	if(L.client)
		if(tgui_alert(user, "此生物内有玩家, 你确定要继续吗?", "提供生物", list("Yes", "No")) != "Yes")
			return
		L.ghostize(FALSE)

	else if(L in GLOB.offered_mob_list)
		switch(tgui_alert(user, "此生物已被提供, 你想重新公告吗?", "提供生物", list("Yes", "Remove", "Cancel")))
			if("Remove")
				GLOB.offered_mob_list -= L
				log_admin("[key_name(user)] has removed offer of [key_name_admin(L)].")
				message_admins("[ADMIN_TPMONTY(user.mob)] has removed offer of [ADMIN_TPMONTY(L)].")
				return
			if(!"Yes")
				return

	else if(tgui_alert(user, "你确定要提供此生物吗?", "提供生物", list("Yes", "No")) != "Yes")
		return

	if(!istype(L))
		to_chat(user, span_warning("目标不再有效."))
		return

	L.offer_mob()

	log_admin("[key_name(user)] has offered [key_name_admin(L)].")
	message_admins("[ADMIN_TPMONTY(user.mob)] has offered [ADMIN_TPMONTY(L)].")

ADMIN_VERB_ONLY_CONTEXT_MENU(xeno_panel, R_FUN, "Xeno Panel", mob/living/carbon/xenomorph/X in GLOB.xeno_mob_list)
	if(!istype(X))
		return

	var/dat = "<br>"

	dat += "Hive: [X.hive.hivenumber] <a href='byond://?src=[REF(user.holder)];[HrefToken()];xeno=hive;mob=[REF(X)]'>Edit</a><br>"
	dat += "Nicknumber: [X.nicknumber] <a href='byond://?src=[REF(user.holder)];[HrefToken()];xeno=nicknumber;mob=[REF(X)]'>Edit</a><br>"
	dat += "Upgrade Tier: [X.xeno_caste.upgrade_name] <a href='byond://?src=[REF(user.holder)];[HrefToken()];xeno=upgrade;mob=[REF(X)]'>Edit</a><br>"

	var/datum/browser/browser = new(user.mob, "xeno_panel_[key_name(X)]", "<div align='center'>Xeno Panel [key_name(X)]</div>")
	browser.set_content(dat)
	browser.open(FALSE)

ADMIN_VERB_ONLY_CONTEXT_MENU(release, R_FUN, "Release Obj", obj/OB in world)
	var/mob/M = user.mob

	if(!M.control_object)
		return

	var/obj/O = M.control_object

	var/datum/player_details/P = GLOB.player_details[M.ckey]

	M.real_name = P.played_names[length(P.played_names)]
	M.name = M.real_name

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.name = H.get_visible_name()

	M.loc = get_turf(M.control_object)
	M.reset_perspective()
	M.control_object = null

	log_admin("[key_name(user)] has released [O] ([O.type]).")
	message_admins("[ADMIN_TPMONTY(user.mob)] has released [O] ([O.type]).")

ADMIN_VERB_ONLY_CONTEXT_MENU(possess, R_FUN, "Possess Obj", obj/O in world)
	var/mob/M = user.mob

	M.loc = O
	M.real_name = O.name
	M.name = O.name
	M.reset_perspective()
	M.control_object = O

	log_admin("[key_name(user)] has possessed [O] ([O.type]).")
	message_admins("[ADMIN_TPMONTY(user.mob)] has possessed [O] ([O.type]).")

ADMIN_VERB_AND_CONTEXT_MENU(imaginary_friend, R_FUN|R_MENTOR, "Imaginary Friend", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_MAIN, mob/living/living_mob AS in GLOB.mob_living_list)
	if(istype(user.mob, /mob/camera/imaginary_friend))
		var/mob/camera/imaginary_friend/IF = user.mob
		IF.ghostize()
		return

	var/mob/living/friend_owner = user.holder.apicker("Select by:", "Imaginary Friend", list(APICKER_CLIENT, APICKER_LIVING))
	if(!friend_owner)
		// nothing was picked, probably canceled
		return
	user.holder.create_ifriend(friend_owner)

/// Handles actually spawning in the friend, if the rest of the checks pass
/datum/admins/proc/create_ifriend(mob/living/friend_owner, seek_confirm = FALSE)
	if(!check_rights(R_FUN|R_MENTOR))
		return
	if(!istype(friend_owner)) // living only
		to_chat(usr, span_warning("该生物不能拥有假想朋友") )
		return
	if(seek_confirm && tgui_alert(usr, "成为 [friend_owner] 的假想朋友?", "确认", list("Yes", "No")) != "Yes")
		return

	var/client/C = usr.client
	if(!isobserver(C.mob))
		if(is_mentor(C) && tgui_alert(usr, "没有管理员的帮助,你将无法回到原来的身体.你确定吗?", "确认", list("Yes", "No")) != "Yes")
			return
		SSadmin_verbs.dynamic_invoke_verb(C, /datum/admin_verb/aghost)
	var/mob/camera/imaginary_friend/IF = new(get_turf(friend_owner), friend_owner)
	C.mob.mind.transfer_to(IF)

	admin_ticket_log(friend_owner, "[key_name_admin(C)] became an imaginary friend of [key_name(friend_owner)]")
	log_admin("[key_name(IF)] started being imaginary friend of [key_name(friend_owner)].")
	message_admins("[ADMIN_TPMONTY(IF)] started being imaginary friend of [ADMIN_TPMONTY(friend_owner)].")

ADMIN_VERB(force_dropship, R_FUN, "Force Dropship", "Force a dropship to move", ADMIN_CATEGORY_DEBUG)
	if(!length(SSshuttle.dropship_list) && !SSshuttle.canterbury)
		return

	var/list/available_shuttles = list()
	for(var/i in SSshuttle.mobile_docking_ports)
		var/obj/docking_port/mobile/M = i
		available_shuttles["[M.name] ([M.shuttle_id])"] = M.shuttle_id

	var/answer = tgui_input_list(user, "你想移动哪艘穿梭机?", "强制运输机", available_shuttles)
	var/shuttle_id = available_shuttles[answer]
	if(!shuttle_id)
		return

	var/obj/docking_port/mobile/D
	for(var/i in SSshuttle.mobile_docking_ports)
		var/obj/docking_port/mobile/M = i
		if(M.shuttle_id != shuttle_id)
			continue
		D = M

	if(!D)
		to_chat(user, span_warning("无法找到穿梭机"))
		return

	if(D.mode != SHUTTLE_IDLE && tgui_alert(user, "[D.name] 未处于空闲状态,仍要移动吗?", "强制运输机", list("Yes", "No")) != "Yes")
		return

	var/list/valid_docks = list()
	var/i = 1
	for(var/obj/docking_port/stationary/S in SSshuttle.stationary_docking_ports)
		if(istype(S, /obj/docking_port/stationary/transit))
			continue // Don't use transit destinations
		if(!D.check_dock(S, silent=TRUE))
			continue
		valid_docks["[S.name] ([i++])"] = S

	if(!length(valid_docks))
		to_chat(user, span_warning("未找到有效目的地!"))
		return

	var/dock = tgui_input_list(user, "选择目的地.", "强制运输机", valid_docks)
	if(!dock)
		return

	var/obj/docking_port/stationary/target = valid_docks[dock]
	if(!target)
		to_chat(user, span_warning("未找到有效停靠点!"))
		return

	var/instant = FALSE
	if(tgui_alert(user, "你想立即移动 [D.name] 吗?", "强制运输机", list("Yes", "No")) == "Yes")
		instant = TRUE

	var/success = SSshuttle.moveShuttleToDock(D.shuttle_id, target, !instant)
	switch(success)
		if(0)
			success = "successfully"
		if(1)
			success = "failing to find the shuttle"
		if(2)
			success = "failing to dock"
		else
			success = "failing somehow"

	log_admin("[key_name(user)] has moved [D.name] ([D.shuttle_id]) to [target] ([target.shuttle_id])[instant ? " instantly" : ""] [success].")
	message_admins("[ADMIN_TPMONTY(user.mob)] has moved [D.name] ([D.shuttle_id]) to [target] ([target.shuttle_id])[instant ? " instantly" : ""] [success].")

ADMIN_VERB(play_cinematic, R_FUN, "Play Cinematic", "Play a selected cinematic", ADMIN_CATEGORY_FUN)
	var/datum/cinematic/choice = tgui_input_list(user, "选择要播放的过场动画.", "播放过场动画", subtypesof(/datum/cinematic))
	if(!choice)
		return

	Cinematic(initial(choice.id), world)

	log_admin("[key_name(user)] played the [choice] cinematic.")
	message_admins("[ADMIN_TPMONTY(user.mob)] played the [choice] cinematic.")

ADMIN_VERB(set_tip, R_FUN, "Set Tip", "Set a tip of the round", ADMIN_CATEGORY_FUN)
	var/tip = tgui_input_text(user, "请指定你想发送给玩家的提示.", "提示", multiline = TRUE, encode = FALSE)
	if(!tip)
		return

	SSticker.selected_tip = tip

	//If we've already tipped, then send it straight away.
	if(SSticker.tipped)
		SSticker.send_tip_of_the_round()

	log_admin("[key_name(user)] set a tip of the round: [tip]")
	message_admins("[ADMIN_TPMONTY(user.mob)] set a tip of the round.")

ADMIN_VERB(ghost_interact, R_FUN, "Ghost Interact", "Toggle ghost interact mode", ADMIN_CATEGORY_FUN)
	user.holder.ghost_interact = !user.holder.ghost_interact

	log_admin("[key_name(user)] has [user.holder.ghost_interact ? "enabled" : "disabled"] ghost interact.")
	message_admins("[ADMIN_TPMONTY(user.mob)] has [user.holder.ghost_interact ? "enabled" : "disabled"] ghost interact.")

ADMIN_VERB(run_weather, R_FUN, "Run Weather", "Triggers a weather on the z-level you choose.", ADMIN_CATEGORY_FUN)
	var/weather_type = tgui_input_list(user, "选择一种天气", "天气", subtypesof(/datum/weather))
	if(!weather_type)
		return

	var/turf/T = get_turf(user.mob)
	var/z_level = tgui_input_number(user, "目标Z轴层级?", "Z轴层级", T?.z)
	if(!isnum(z_level))
		return

	SSweather.run_weather(weather_type, z_level)

	message_admins("[key_name_admin(user)] started weather of type [weather_type] on the z-level [z_level].")
	log_admin("[key_name(user)] started weather of type [weather_type] on the z-level [z_level].")

///client verb to set round end sound
ADMIN_VERB(set_round_end_sound, R_SOUND, "Set Round End Sound", "Set a sound to play when the server restarts", ADMIN_CATEGORY_FUN, S as sound)
	SSticker.SetRoundEndSound(S)

	log_admin("[key_name(user)] set the round end sound to [S]")
	message_admins("[key_name_admin(user)] set the round end sound to [S]")

ADMIN_VERB(adjust_gravity, R_FUN, "Adjust Gravity", "Adjusts gravity/jump components of all mobs.", ADMIN_CATEGORY_FUN)
	var/choice = tgui_input_list(user, "你想将重力设置为多少?", "重力调整", list("Standard gravity", "Low gravity", "John Woo", "Exceeding orbital velocity"))
	switch(choice)
		if("Standard gravity")
			to_chat(GLOB.mob_living_list, span_userdanger("你感觉重力恢复正常了."))
			for(var/mob/living/living_mob AS in GLOB.mob_living_list)
				living_mob.set_jump_component()
		if("Low gravity")
			to_chat(GLOB.mob_living_list, span_userdanger("你感觉重力轻轻拉扯着你."))
			for(var/mob/living/living_mob AS in GLOB.mob_living_list)
				living_mob.set_jump_component(duration = 1 SECONDS, cooldown = 1.5 SECONDS, cost = 2, height = 32, jump_pass_flags = PASS_LOW_STRUCTURE|PASS_FIRE|PASS_DEFENSIVE_STRUCTURE|PASS_TANK)
		if("John Woo")
			to_chat(GLOB.mob_living_list, span_userdanger("你感觉重力变弱了,有种想飞起来的冲动."))
			for(var/mob/living/living_mob AS in GLOB.mob_living_list)
				living_mob.set_jump_component(duration = 1 SECONDS, cooldown = 1.5 SECONDS, cost = 2, height = 48, sound = SFX_JUMP, flags = JUMP_SPIN, jump_pass_flags = HOVERING|PASS_PROJECTILE|PASS_TANK)
		if("Exceeding orbital velocity")
			to_chat(GLOB.mob_living_list, span_userdanger("你感觉重力消失殆尽.你还能落回地面吗?"))
			for(var/mob/living/living_mob AS in GLOB.mob_living_list)
				living_mob.set_jump_component(duration = 4 SECONDS, cooldown = 6 SECONDS, cost = 0, height = 128, sound = SFX_JUMP, flags = JUMP_SPIN, jump_pass_flags = HOVERING|PASS_PROJECTILE|PASS_TANK)
		else
			return

	log_admin("[key_name(user)] set gravity to [choice].")

ADMIN_VERB(ai_squad, R_FUN, "Spawn AI squad", "Spawns a AI squad of your choice", ADMIN_CATEGORY_FUN)
	var/squad_choice = tgui_input_list(user, "你想生成哪个小队?", "小队选择", GLOB.ai_squad_presets)
	if(!squad_choice)
		return
	var/quantity = tgui_input_number(user, "你想在小队中生成多少个生物?", title = "小队规模", default = 5, max_value = length(GLOB.ai_squad_presets[squad_choice]), min_value = 1, timeout = 0, round_value = TRUE)
	if(!quantity)
		return
	var/turf/spawn_loc = get_turf(user.mob)
	if(!spawn_loc)
		return
	var/list/spawn_list = GLOB.ai_squad_presets[squad_choice]
	spawn_list = spawn_list.Copy(1, quantity + 1)
	spawn_npc_squad(spawn_loc, spawn_list)

	message_admins("[key_name_admin(user)] spawned a [quantity] man [squad_choice] of AI humans in [AREACOORD(spawn_loc)].")
	log_admin("[key_name(user)] spawned a [quantity] man [squad_choice] of AI humans in [AREACOORD(spawn_loc)].")

ADMIN_VERB(load_lazy_template, R_FUN, "Load/Jump Lazy Template", "Loads a lazy template and/or jumps to it.", ADMIN_CATEGORY_FUN)
	var/list/choices = LAZY_TEMPLATE_KEY_LIST_ALL()
	var/choice = tgui_input_list(user, "按键?", "延迟加载器", choices)
	var/teleport_to_template = tgui_input_list(user, "加载后跳转到模板?", "跳转到哪里?", list("Yes", "No"))
	if(!choice)
		return

	choice = choices[choice]
	if(!choice)
		to_chat(user, span_warning("未找到该按键对应的模板,请报告此问题!"))
		return

	var/already_loaded = LAZYACCESS(SSmapping.loaded_lazy_templates, choice)
	var/force_load = FALSE
	if(already_loaded && (tgui_alert(user, "模板已加载.", "", list("Jump", "Load Again")) == "Load Again"))
		force_load = TRUE

	var/datum/turf_reservation/reservation = SSmapping.lazy_load_template(choice, force = force_load)
	if(!reservation)
		to_chat(user, span_boldwarning("加载模板失败!"))
		return

	if(teleport_to_template == "Yes")
		if(!isobserver(user.mob))
			SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/aghost)
		user.mob.forceMove(reservation.bottom_left_turfs[1])
		to_chat(user, span_notice("模板已加载,你已被移动到保留区域的左下角."))

	message_admins("[key_name_admin(user)] has loaded lazy template '[choice]'")
