#define COMMS_PAGE_MAIN "main"
#define COMMS_PAGE_MESSAGES "messages"
#define COMMS_PAGE_VIEW_MESSAGE "viewmessage"
#define COMMS_PAGE_STATUS "status"
#define COMMS_PAGE_ALERT "alert"
#define COMMS_PAGE_CONFIRM_ALERT "confirm_alert"

// The communications computer
/obj/machinery/computer/communications
	name = "communications console"
	desc = "这可用于各种重要功能."
	icon_state = "computer_small"
	screen_overlay = "comm"
	req_access = list(ACCESS_MARINE_BRIDGE)
	circuit = /obj/item/circuitboard/computer/communications
	interaction_flags = INTERACT_MACHINE_TGUI
	var/prints_intercept = TRUE
	var/authenticated = 0
	var/list/messagetitle = list()
	var/list/messagetext = list()
	var/currmsg = 0
	var/aicurrmsg = 0
	var/page = COMMS_PAGE_MAIN
	var/cooldown_message = FALSE //Based on world.time.
	var/cooldown_request = FALSE
	var/cooldown_central = FALSE
	var/just_called = FALSE
	var/tmp_alertlevel = SEC_LEVEL_GREEN

	var/status_display_freq = "1435"
	var/stat_msg1
	var/stat_msg2

/obj/machinery/computer/communications/bee
	machine_stat = BROKEN

/obj/machinery/computer/communications/bee/Initialize(mapload)
	. = ..()
	update_icon()

/obj/machinery/computer/communications/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CommunicationsConsole", name)
		ui.open()

/obj/machinery/computer/communications/ui_static_data(mob/user)
	. = list()
	.["cooldown_request"] = COOLDOWN_COMM_REQUEST
	.["cooldown_central"] = COOLDOWN_COMM_CENTRAL
	.["cooldown_message"] = COOLDOWN_COMM_MESSAGE
	.["evacuation_time_lock"] = EVACUATION_TIME_LOCK
	.["ert_allowed"] = CONFIG_GET(flag/infestation_ert_allowed)
	.["ship_map_name"] = SSmapping.configs[SHIP_MAP]?.map_name || "the ship"

/obj/machinery/computer/communications/ui_data(mob/user)
	. = list()
	.["authenticated"] = authenticated
	.["page"] = page
	.["worldtime"] = world.time
	.["alert_level"] = SSsecurity_level.get_current_level_as_number()
	.["alert_level_text"] = SSsecurity_level.get_current_level_as_text()
	.["tmp_alertlevel"] = tmp_alertlevel
	.["tmp_alertlevel_text"] = SSsecurity_level.number_level_to_text(tmp_alertlevel)
	.["evac_status"] = SSevacuation.evac_status
	.["dest_status"] = SSevacuation.dest_status
	.["time_message"] = cooldown_message
	.["time_request"] = cooldown_request
	.["time_central"] = cooldown_central
	.["stat_msg1"] = stat_msg1
	.["stat_msg2"] = stat_msg2
	.["admins_online"] = length(GLOB.admins) > 0
	.["cannot_switch_alert"] = !!(SSsecurity_level.current_security_level.sec_level_flags & SEC_LEVEL_FLAG_CANNOT_SWITCH)
	.["state_of_emergency"] = !!(SSsecurity_level.current_security_level.sec_level_flags & SEC_LEVEL_FLAG_STATE_OF_EMERGENCY) || !!SSevacuation.evac_status

	if(SSevacuation.evac_status == EVACUATION_STATUS_INITIATING)
		.["evac_eta"] = SSevacuation.get_status_panel_eta()

	var/list/available_alerts = list()
	if(!(SSsecurity_level.current_security_level.sec_level_flags & SEC_LEVEL_FLAG_CANNOT_SWITCH))
		for(var/iter_level_text AS in SSsecurity_level.available_levels)
			var/datum/security_level/iter_level_datum = SSsecurity_level.available_levels[iter_level_text]
			if(!(iter_level_datum.sec_level_flags & SEC_LEVEL_FLAG_CAN_SWITCH_COMMS_CONSOLE))
				continue
			available_alerts += list(list(
				"name" = iter_level_datum.name,
				"ref" = iter_level_datum.name,
			))
	.["available_alert_levels"] = available_alerts

	var/list/messages = list()
	if(length(messagetitle))
		for(var/i in 1 to length(messagetitle))
			messages += list(list(
				"title" = messagetitle[i],
				"text" = messagetext[i],
				"number" = i,
			))
	.["messages"] = length(messages) ? messages : null

	if(page == COMMS_PAGE_VIEW_MESSAGE && currmsg && currmsg <= length(messagetitle))
		.["current_message"] = list(
			"title" = messagetitle[currmsg],
			"text" = messagetext[currmsg],
			"number" = currmsg,
		)
	else
		.["current_message"] = null

/obj/machinery/computer/communications/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/mob/user = ui.user

	switch(action)
		if("main")
			page = COMMS_PAGE_MAIN
			currmsg = 0
			. = TRUE

		if("login")
			if(isAI(user))
				authenticated = 2
				. = TRUE
				return
			if(!ishuman(user))
				return FALSE
			var/mob/living/carbon/human/human_user = user
			var/obj/item/card/id/id_card = human_user.get_active_held_item()
			if(!istype(id_card))
				id_card = human_user.wear_id
			if(!istype(id_card))
				return FALSE
			if(check_access(id_card))
				authenticated = 1
			if(ACCESS_MARINE_BRIDGE in id_card.access)
				authenticated = 2
			. = TRUE

		if("logout")
			authenticated = 0
			page = COMMS_PAGE_MAIN
			currmsg = 0
			. = TRUE

		if("changeseclevel")
			if(!authenticated)
				return FALSE
			page = COMMS_PAGE_ALERT
			. = TRUE

		if("securitylevel")
			if(!authenticated)
				return FALSE
			tmp_alertlevel = SSsecurity_level.text_level_to_number(params["newalertlevel"])
			if(!tmp_alertlevel)
				tmp_alertlevel = SEC_LEVEL_GREEN
			if(isAI(user))
				switch_alert_level(tmp_alertlevel)
				tmp_alertlevel = SEC_LEVEL_GREEN
				page = COMMS_PAGE_MAIN
			else
				page = COMMS_PAGE_CONFIRM_ALERT
			. = TRUE

		if("swipeidseclevel")
			if(!authenticated)
				return FALSE
			var/obj/item/card/id/id_card = user.get_active_held_item()
			if(!istype(id_card))
				to_chat(user, span_warning("你需要刷你的ID卡."))
				return FALSE
			if((ACCESS_MARINE_CAPTAIN in id_card.access) || (ACCESS_MARINE_BRIDGE in id_card.access))
				switch_alert_level(tmp_alertlevel)
			else
				to_chat(user, span_warning("你无权执行此操作."))
			tmp_alertlevel = SEC_LEVEL_GREEN
			page = COMMS_PAGE_MAIN
			. = TRUE

		if("status")
			if(!authenticated)
				return FALSE
			page = COMMS_PAGE_STATUS
			. = TRUE

		if("setstat")
			if(!authenticated)
				return FALSE
			var/statdisp = params["statdisp"]
			switch(statdisp)
				if("message")
					post_status("message", stat_msg1, stat_msg2)
				if("alert")
					post_status("alert", params["alert"])
				else
					post_status(statdisp)
			. = TRUE

		if("setmsg1")
			if(!authenticated)
				return FALSE
			stat_msg1 = reject_bad_text(tgui_input_text(user, "第1行", "输入消息文本", stat_msg1, 40, encode = FALSE))
			. = TRUE

		if("setmsg2")
			if(!authenticated)
				return FALSE
			stat_msg2 = reject_bad_text(tgui_input_text(user, "第2行", "输入消息文本", stat_msg2, 40, encode = FALSE))
			. = TRUE

		if("messagelist")
			if(!authenticated)
				return FALSE
			currmsg = 0
			page = COMMS_PAGE_MESSAGES
			. = TRUE

		if("viewmessage")
			if(!authenticated)
				return FALSE
			var/message_num = text2num(params["message-num"])
			if(!message_num || message_num < 1 || message_num > length(messagetitle))
				page = COMMS_PAGE_MESSAGES
				currmsg = 0
			else
				currmsg = message_num
				page = COMMS_PAGE_VIEW_MESSAGE
			. = TRUE

		if("delmessage")
			if(!authenticated)
				return FALSE
			var/message_num = text2num(params["number"])
			if(!message_num)
				message_num = currmsg
			if(!message_num || message_num < 1 || message_num > length(messagetitle))
				page = COMMS_PAGE_MESSAGES
				return TRUE
			var/title = messagetitle[message_num]
			var/text = messagetext[message_num]
			messagetitle.Remove(title)
			messagetext.Remove(text)
			if(message_num == aicurrmsg)
				aicurrmsg = 0
			currmsg = 0
			page = COMMS_PAGE_MESSAGES
			. = TRUE

		if("announce")
			if(authenticated != 2)
				return FALSE
			if(TIMER_COOLDOWN_RUNNING(user, COOLDOWN_HUD_ORDER))
				to_chat(user, span_warning("你最近刚刚发送过公告或消息!"))
				return FALSE
			if(world.time < cooldown_message + COOLDOWN_COMM_MESSAGE)
				to_chat(user, span_warning("请至少间隔[COOLDOWN_COMM_MESSAGE * 0.1]秒\s 再发送公告."))
				return FALSE

			var/input = tgui_input_text(user, "请撰写一条向空间站船员发布的公告消息.", "优先公告", "", multiline = TRUE, encode = FALSE, max_length = 100)
			if(!input || !(user in view(1, src)) || authenticated != 2 || world.time < cooldown_message + COOLDOWN_COMM_MESSAGE)
				return FALSE

			var/filter_result = CAN_BYPASS_FILTER(user) ? null : is_ic_filtered(input)
			if(filter_result)
				to_chat(user, span_warning("该公告包含了一个在IC聊天中被禁止的词语! 请考虑查阅服务器规则.\n<span replaceRegex='show_filtered_ic_chat'>\"[input]\"</span>"))
				SSblackbox.record_feedback(FEEDBACK_TALLY, "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))
				REPORT_CHAT_FILTER_TO_USER(src, filter_result)
				log_filter("IC", input, filter_result)
				return FALSE

			if(NON_ASCII_CHECK(input))
				to_chat(user, span_warning("该公告包含了在IC聊天中被禁止的字符! 请考虑查阅服务器规则."))
				return FALSE

			var/mob/living/carbon/human/sender = user
			priority_announce(input, subtitle = "由[sender.get_paygrade(0) ? sender.get_paygrade(0) : sender.job.title] [sender.real_name]发送", type = ANNOUNCEMENT_COMMAND)
			message_admins("[ADMIN_TPMONTY(user)] has just sent a command announcement")
			log_game("[key_name(user)] has just sent a command announcement.")
			TIMER_COOLDOWN_START(user, COOLDOWN_HUD_ORDER, CIC_ORDER_COOLDOWN)
			cooldown_message = world.time
			. = TRUE

		if("award")
			if(authenticated != 2)
				return FALSE
			if(!isliving(user))
				to_chat(user, span_warning("只有队长才能授予勋章."))
				return FALSE
			var/mob/living/living_user = user
			if(!ismarinecaptainjob(living_user.job))
				to_chat(user, span_warning("只有队长才能授予勋章."))
				return FALSE
			if(give_medal_award(loc))
				visible_message(span_notice("[src]打印了一枚勋章."))
			. = TRUE

		if("messageTGMC")
			if(authenticated != 2)
				return FALSE
			if(!length(GLOB.admins))
				to_chat(user, span_warning("TGMC通讯离线."))
				return FALSE
			if(world.time < cooldown_central + COOLDOWN_COMM_CENTRAL)
				to_chat(user, span_warning("阵列回收中. 请稍候."))
				return FALSE

			var/msg = tgui_input_text(user, "请选择要发送给TGMC最高指挥部的消息. 请注意,此过程非常昂贵,滥用将导致终止. 发送不保证会得到回复. 在你发送另一条消息之前会有短暂延迟. 请清晰简洁.", "要中止,请发送空消息.", "", encode = FALSE)
			if(!msg || !user.Adjacent(src) || authenticated != 2 || world.time < cooldown_central + COOLDOWN_COMM_CENTRAL)
				return FALSE

			tgmc_message(msg, user)
			to_chat(user, span_notice("消息已发送."))
			user.log_talk(msg, LOG_SAY, tag = "TGMC announcement")
			cooldown_central = world.time
			. = TRUE

		if("evacuation_start")
			if(authenticated != 2)
				return FALSE
			if(world.time < EVACUATION_TIME_LOCK)
				to_chat(user, span_warning("TGMC协议不允许立即撤离. 请再等待[round((EVACUATION_TIME_LOCK - world.time) / 600)]分钟后再试."))
				return FALSE

			if(!SSticker?.mode)
				to_chat(user, span_warning("在撤离进行之前,必须激活[SSmapping.configs[SHIP_MAP].map_name]的求救信标."))
				return FALSE

			if(SSsecurity_level.get_current_level_as_number() < SEC_LEVEL_RED)
				to_chat(user, span_warning("飞船必须处于红色警报状态才能执行撤离程序."))
				return FALSE

			if(SSevacuation.scuttle_flags & SDEVAC_TIMELOCK_flags)
				to_chat(user, span_warning("传感器未检测到足够的威胁."))
				return FALSE

			if(SSevacuation.scuttle_flags & EVACUATION_DENY_flags)
				to_chat(user, span_warning("TGMC已锁定撤离舱的部署."))
				return FALSE

			if(!SSevacuation.initiate_evacuation())
				to_chat(user, span_warning("你现在无法启动撤离程序!"))
				return FALSE

			if(!SSevacuation.dest_master)
				SSevacuation.prepare()
			SSevacuation.enable_self_destruct()

			log_game("[key_name(user)] has called for an emergency evacuation.")
			message_admins("[ADMIN_TPMONTY(user)] has called for an emergency evacuation.")
			post_status("shuttle")
			. = TRUE

		if("delta_cancel")
			if(authenticated != 2)
				return FALSE
			if(!SSevacuation.cancel_evacuation())
				to_chat(user, span_warning("你现在无法取消撤离!"))
				return FALSE
			addtimer(CALLBACK(src, PROC_REF(evacuation_cancel)), 3.5 SECONDS)
			log_game("[key_name(user)] has canceled the emergency evacuation.")
			message_admins("[ADMIN_TPMONTY(user)] has canceled the emergency evacuation.")
			. = TRUE

		if("distress")
			if(authenticated != 2)
				return FALSE
			if(!CONFIG_GET(flag/infestation_ert_allowed))
				log_admin_private("[key_name(user)] may have attempted a href exploit on a [src]. [AREACOORD(user)].")
				message_admins("[ADMIN_TPMONTY(user)] may be attempting a href exploit on a [src]. [ADMIN_VERBOSEJMP(user)].")
				return FALSE

			if(!SSticker?.mode)
				return FALSE

			if(just_called || SSticker.mode.waiting_for_candidates)
				to_chat(user, span_warning("求救信标刚刚发射."))
				return FALSE

			if(SSticker.mode.on_distress_cooldown)
				to_chat(user, span_warning("求救信标目前正在重新校准."))
				return FALSE

			var/list/ship = SSticker.mode.count_humans_and_xenos(SSmapping.levels_by_trait(ZTRAIT_MARINE_MAIN_SHIP))
			var/ship_marines = ship[1]
			var/ship_xenos = ship[2]
			var/list/all_counts = SSticker.mode.count_humans_and_xenos()
			var/all_marines = all_counts[1]
			var/all_xenos = all_counts[2]
			if((all_xenos < round(all_marines * 0.8)) && (ship_xenos < round(ship_marines * 0.5)))
				to_chat(user, span_warning("传感器未检测到足够的威胁,无需发射求救信标."))
				return FALSE

			SSticker.mode.distress_cancelled = FALSE
			just_called = TRUE

			var/datum/emergency_call/emergency_call = SSticker.mode.get_random_call()

			var/admin_response = admin_approval("<span color='prefix'>DISTRESS:</span> [ADMIN_TPMONTY(user)] has called a Distress Beacon that was received by [emergency_call.name]. Humans: [all_marines], Xenos: [all_xenos].",
				user_message = span_boldnotice("除非最高指挥部另有回应,否则求救信标将在60秒后发射."),
				options = list("approve" = "approve", "deny" = "deny", "deny without annoncing" = "deny without annoncing"),
				user = user, admin_sound = sound('sound/effects/sos-morse-code.ogg', channel = CHANNEL_ADMIN))
			just_called = FALSE
			cooldown_request = world.time
			if(admin_response == "deny")
				SSticker.mode.distress_cancelled = TRUE
				priority_announce("求救信号已被封锁. 发射管正在重新校准.", "求救信标", sound = 'sound/AI/distress_deny.ogg')
				return FALSE
			if(admin_response == "deny without annoncing")
				SSticker.mode.distress_cancelled = TRUE
				return FALSE
			if(SSticker.mode.on_distress_cooldown || SSticker.mode.waiting_for_candidates)
				return FALSE
			SSticker.mode.activate_distress(emergency_call)
			emergency_call.base_probability = 0
			. = TRUE

/obj/machinery/computer/communications/proc/evacuation_cancel()
	if(SSevacuation.evac_status != EVACUATION_STATUS_STANDING_BY) // nothing changed during the wait
		return
	//if the self_destruct is active we try to cancel it (which includes lowering alert level to red)
	if(SSevacuation.cancel_self_destruct(TRUE))
		return
	//if SD wasn't active (likely canceled manually in the SD room), then we lower the alert level manually.
	SSsecurity_level.set_level(SEC_LEVEL_RED, TRUE) //both SD and evac are inactive, lowering the security level.

/obj/machinery/computer/communications/proc/post_status(command, data1, data2)


/obj/machinery/computer/communications/proc/switch_alert_level(new_level)
	var/old_level = SSsecurity_level.get_current_level_as_text()
	SSsecurity_level.set_level(new_level)
	if(SSsecurity_level.get_current_level_as_text() == old_level)
		return //Only notify the admins if an actual change happened
	log_game("[key_name(usr)] has changed the security level from [old_level] to [SSsecurity_level.get_current_level_as_text()].")
	message_admins("[ADMIN_TPMONTY(usr)] has changed the security level from [old_level] to [SSsecurity_level.get_current_level_as_text()].")


#undef COMMS_PAGE_MAIN
#undef COMMS_PAGE_MESSAGES
#undef COMMS_PAGE_VIEW_MESSAGE
#undef COMMS_PAGE_STATUS
#undef COMMS_PAGE_ALERT
#undef COMMS_PAGE_CONFIRM_ALERT
