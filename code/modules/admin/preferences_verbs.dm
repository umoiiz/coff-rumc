ADMIN_VERB(pref_ff_attack_logs, R_ADMIN, "Toggle FF Attack Log Messages", "Toggle ff attack log preferences", ADMIN_CATEGORY_MAIN)
	user.prefs.load_preferences() // todo dleete this and just put it in the admin tab on the pref ui
	user.prefs.toggles_chat ^= CHAT_FFATTACKLOGS
	user.prefs.save_preferences()

	if(user.prefs.toggles_chat & CHAT_FFATTACKLOGS)
		to_chat(user, span_boldnotice("你现在会收到友军误伤攻击日志消息."))
	else
		to_chat(user, span_boldnotice("你将不再收到友军误伤攻击日志消息."))

ADMIN_VERB(pref_end_attack_logs, R_ADMIN, "Toggle End-Of-Round Attack Log Messages", "Toggle attack logs after the round ends", ADMIN_CATEGORY_MAIN)
	user.prefs.load_preferences() // todo dleete this and just put it in the admin tab on the pref ui
	user.prefs.toggles_chat ^= CHAT_ENDROUNDLOGS
	user.prefs.save_preferences()

	if(user.prefs.toggles_chat & CHAT_ENDROUNDLOGS)
		to_chat(user, span_boldnotice("你现在会收到回合结束攻击日志消息."))
	else
		to_chat(user, span_boldnotice("你将不再收到回合结束攻击日志消息."))

ADMIN_VERB(pref_debug_logs, R_ADMIN, "Toggle Debug Log Messages", "Toggle Debug Log Messages", ADMIN_CATEGORY_MAIN)
	user.prefs.load_preferences() // todo dleete this and just put it in the admin tab on the pref ui
	user.prefs.toggles_chat ^= CHAT_DEBUGLOGS
	user.prefs.save_preferences()

	if(user.prefs.toggles_chat & CHAT_DEBUGLOGS)
		to_chat(user, span_boldnotice("你现在会收到调试日志消息."))
	else
		to_chat(user, span_boldnotice("你将不再收到调试日志消息."))

ADMIN_VERB(set_ooc_color_self, R_COLOR, "OOC Text Color", "Set your own color for OOC", ADMIN_CATEGORY_FUN)
	var/new_ooccolor = input(user, "Please select your OOC colour", "OOC colour") as color|null
	if(!new_ooccolor) // todo dleete this and just put it in the admin tab on the pref ui
		return

	user.prefs.load_preferences()
	user.prefs.ooccolor = new_ooccolor
	user.prefs.save_preferences()

ADMIN_VERB(toggle_prayers, R_MENTOR|R_ADMIN, "Toggle Prayers", "Toggle IC prayers from players", ADMIN_CATEGORY_MAIN)
	user.prefs.toggles_chat ^= CHAT_PRAYER // todo dleete this and just put it in the admin tab on the pref ui
	user.prefs.save_preferences()

	to_chat(user, span_notice("你[(user.prefs.toggles_chat & CHAT_PRAYER) ? "now" : "no longer"]看到祈祷聊天."))
