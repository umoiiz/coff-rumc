#define MAX_SQUAD_NAME_LEN 15

/obj/machinery/computer/squad_manager
	name = "squad managment console"
	desc = "用于小队管理的控制台。允许小队长管理他们的小队。"
	screen_overlay = "rdcomp"
	light_color = LIGHT_COLOR_PINK
	interaction_flags = NONE

/obj/machinery/computer/squad_manager/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SquadManager", name)
		ui.open()

/obj/machinery/computer/squad_manager/ui_data(mob/user)
	var/list/data = list()
	data["active_squads"] = list()
	for(var/datum/squad/squad AS in SSjob.active_squads[user.faction])
		var/leader_name = squad.squad_leader?.real_name ? squad.squad_leader.real_name : "NONE"
		data["active_squads"] += list(list("name" = squad.name, "leader" = leader_name, "color" = squad.color))
	data["valid_colors"] = GLOB.custom_squad_colors
	return data

/obj/machinery/computer/squad_manager/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/user = usr
	if(!ismarineleaderjob(user.job))
		to_chat(user, span_danger("你必须是小队长才能编辑小队。"))
		return

	if(user.assigned_squad?.type == /datum/squad) //means its a generated squad
		to_chat(user, span_danger("你已经在已创建的小队中了。"))
		return

	if(action != "create_squad")
		return

	var/new_name = params["name"]
	var/new_color = params["color"]
	var/new_desc = sanitize(params["desc"])

	if(!GLOB.custom_squad_colors[new_color])
		return

	if(length(new_name) > MAX_SQUAD_NAME_LEN)
		to_chat(user, span_danger("小队名称太长"))
		return FALSE
	new_name = sanitize(new_name)

	var/filter_result = is_ic_filtered(new_name)
	if(filter_result)
		to_chat(user, span_warning("该名称包含IC聊天中禁止的词语! 请考虑查看服务器规则。\n<span replaceRegex='show_filtered_ic_chat'>\"[new_name]\"</span>"))
		SSblackbox.record_feedback(FEEDBACK_TALLY, "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))
		REPORT_CHAT_FILTER_TO_USER(user, filter_result)
		log_filter("Squad naming", new_name, filter_result)
		return FALSE

	if(NON_ASCII_CHECK(new_desc))
		to_chat(user, span_danger("小队描述包含IC聊天中禁止的字符"))
		return

	var/filter_result_desc = is_ic_filtered(new_name)
	if(filter_result_desc)
		SSblackbox.record_feedback(FEEDBACK_TALLY, "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))
		REPORT_CHAT_FILTER_TO_USER(user, filter_result_desc)
		log_filter("Squad description", new_desc, filter_result_desc)
		return

	var/datum/squad/new_squad = create_squad(new_name, new_color, user)
	if(!new_squad)
		to_chat(user, span_danger("错误: 小队创建失败"))
		return FALSE
	var/log_msg = "[key_name(user)] has created a new squad. Name: [new_name], Color: [new_color]"
	log_game(log_msg)
	message_admins(log_msg)
	new_squad.desc = new_desc
	ui_close(user)
	balloon_alert(user, "\"[new_name]\"已创建")
