/client/verb/toggle_statistics()
	set category = "Preferences.Chat"
	set name = "Toggle Statistics"

	prefs.toggles_chat ^= CHAT_STATISTICS
	prefs.save_preferences()

	to_chat(src, span_notice("回合结束时你将[(prefs.toggles_chat & CHAT_STATISTICS) ? "see all statistics" : "not see any statistics"]."))

/client/verb/toggle_ghost_ears()
	set category = "Preferences.Chat"
	set name = "Toggle Ghost Ears"

	prefs.toggles_chat ^= CHAT_GHOSTEARS
	prefs.save_preferences()

	to_chat(src, span_notice("作为幽灵,你现在将[(prefs.toggles_chat & CHAT_GHOSTEARS) ? "see all speech in the world" : "only see speech from nearby mobs"]."))

/client/verb/middle_mousetoggle()
	set name = "Toggle Middle/Shift Clicking"
	set category = "Preferences"

	prefs.toggles_gameplay ^= MIDDLESHIFTCLICKING
	prefs.save_preferences()

	to_chat(src, span_notice("选定的特殊能力现在将通过[(prefs.toggles_gameplay & MIDDLESHIFTCLICKING) ? "middle button" : "shift"]点击激活."))

	prefs.save_preferences()

/client/verb/toggle_ghost_sight()
	set category = "Preferences.Chat"
	set name = "Toggle Ghost Sight"

	prefs.toggles_chat ^= CHAT_GHOSTSIGHT
	prefs.save_preferences()

	to_chat(src, span_notice("作为幽灵,你现在将[(prefs.toggles_chat & CHAT_GHOSTSIGHT) ? "see all emotes in the world" : "only see emotes from nearby mobs"]."))

/client/verb/toggle_ghost_radio()
	set category = "Preferences.Chat"
	set name = "Toggle Ghost Radio"

	prefs.toggles_chat ^= CHAT_GHOSTRADIO
	prefs.save_preferences()

	to_chat(src, span_notice("作为幽灵,你现在将[(prefs.toggles_chat & CHAT_GHOSTRADIO) ? "hear all radio chat in the world" : "only hear from nearby speakers"]."))

/client/proc/toggle_ghost_speaker()
	set category = "Preferences.Chat"
	set name = "Toggle Speakers"

	prefs.toggles_chat ^= CHAT_RADIO
	prefs.save_preferences()

	to_chat(usr, span_notice("你将[(prefs.toggles_chat & CHAT_RADIO) ? "now" : "no longer"]看到来自无线电或扬声器的无线电通讯."))

/client/verb/toggle_ghost_hivemind()
	set category = "Preferences.Chat"
	set name = "Toggle Ghost Hivemind"

	prefs.toggles_chat ^= CHAT_GHOSTHIVEMIND
	prefs.save_preferences()

	to_chat(src, span_notice("作为幽灵,你现在将[(prefs.toggles_chat & CHAT_GHOSTHIVEMIND) ? "now see chatter from the Xenomorph Hivemind" : "no longer see chatter from the Xenomorph Hivemind"]."))

/client/verb/toggle_deadchat_self()
	set category = "Preferences.Chat"
	set name = "Toggle  Deadchat"

	prefs.toggles_chat ^= CHAT_DEAD
	prefs.save_preferences()

	to_chat(src, span_notice("你将[(prefs.toggles_chat & CHAT_DEAD) ? "now" : "no longer"]看到死亡聊天."))

/client/verb/toggle_radial_medical()
	set category = "Preferences"
	set name = "Toggle Radial Medical Wheel"

	prefs.toggles_gameplay ^= RADIAL_MEDICAL
	prefs.save_preferences()

	to_chat(src, span_notice("你将[(prefs.toggles_gameplay & RADIAL_MEDICAL) ? "now" : "no longer"]使用医疗用途的径向菜单."))

/client/verb/toggle_radial_stacks()
	set category = "Preferences"
	set name = "Toggle Radial Stacks Wheel"

	prefs.toggles_gameplay ^= RADIAL_STACKS
	prefs.save_preferences()

	to_chat(src, span_notice("你将[(prefs.toggles_gameplay & RADIAL_STACKS) ? "now" : "no longer"]在与材料堆交互时使用径向菜单."))

/client/verb/toggle_ooc_self()
	set category = "Preferences.Chat"
	set name = "Toggle  OOC"

	prefs.toggles_chat ^= CHAT_OOC
	prefs.save_preferences()

	to_chat(src, span_notice("你将[(prefs.toggles_chat & CHAT_OOC) ? "now" : "no longer"]看到OOC频道的消息."))

/client/verb/toggle_looc_self()
	set category = "Preferences.Chat"
	set name = "Toggle  LOOC"

	prefs.toggles_chat ^= CHAT_LOOC
	prefs.save_preferences()

	to_chat(src, span_notice("你将[(prefs.toggles_chat & CHAT_LOOC) ? "now" : "no longer"]看到LOOC频道的消息."))

/client/verb/toggle_ooc_country_flag()
	set category = "Preferences.Chat"
	set name = "Toggle OOC Country Flag"

	if(!(CONFIG_GET(flag/ooc_country_flags)))
		to_chat(src, span_warning("本服务器已禁用OOC国旗."))
		return

	prefs.show_ooc_country_flag = !prefs.show_ooc_country_flag
	prefs.save_preferences()

	to_chat(src, span_notice("你的国旗将[(prefs.show_ooc_country_flag) ? "now" : "no longer"]出现在OOC聊天中你的名字前."))

/client/verb/toggle_special()
	set category = "Preferences"
	set name = "Toggle Special Roles"

	var/role = tgui_input_list(usr, "选择一个要切换的角色", "切换特殊角色", BE_SPECIAL_FLAGS)
	var/role_flag = BE_SPECIAL_FLAGS[role]
	if(!role_flag)
		return
	prefs.be_special ^= role_flag
	prefs.save_character()

	to_chat(src, span_notice("你将[(prefs.be_special & role_flag) ? "now" : "no longer"]被考虑参与[role]事件 (在可能的情况下)."))

/client/verb/setup_character()
	set category = "Preferences"
	set name = "游戏设置"
	set desc = "Allows you to access the Setup Character screen. Changes to your character won't take effect until next round, but other changes will."
	prefs.ShowChoices(mob)

GLOBAL_LIST_INIT(ghost_forms, list("Default" = GHOST_DEFAULT_FORM, "Ghost Ian 1" = "ghostian", "Ghost Ian 2" = "ghostian2", "Skeleton" = "skeleghost", "Red" = "ghost_red",\
							"Black" = "ghost_black", "Blue" = "ghost_blue", "Yellow" = "ghost_yellow", "Green" = "ghost_green", "Pink" = "ghost_pink", \
							"Cyan" = "ghost_cyan", "Dark Blue" = "ghost_dblue", "Dark Red" = "ghost_dred", "Dark Green" = "ghost_dgreen", \
							"Dark Cyan" = "ghost_dcyan", "Grey" = "ghost_grey", "Dark Yellow" = "ghost_dyellow", "Dark Pink" = "ghost_dpink",\
							"Purple" = "ghost_purpleswirl", "Funky" = "ghost_funkypurp", "Transparent Pink" = "ghost_pinksherbert", "Blaze it" = "ghost_blazeit",\
							"Mellow" = "ghost_mellow", "Rainbow" = "ghost_rainbow", "Camo" = "ghost_camo", "Fire" = "ghost_fire", "Cat" = "catghost"))

/client/proc/pick_form()
	var/new_form = tgui_input_list(src, "选择你的幽灵形态:", "幽灵自定义", GLOB.ghost_forms)
	if(!new_form)
		return

	prefs.ghost_form = GLOB.ghost_forms[new_form]
	prefs.save_preferences()

	to_chat(src, span_notice("你将以观察者身份开始时使用[new_form]幽灵形态."))

	if(!isobserver(mob))
		return

	var/mob/dead/observer/O = mob
	O.pick_form(GLOB.ghost_forms[new_form])

GLOBAL_LIST_INIT(ghost_orbits, list(GHOST_ORBIT_CIRCLE, GHOST_ORBIT_TRIANGLE, GHOST_ORBIT_SQUARE, GHOST_ORBIT_HEXAGON, GHOST_ORBIT_PENTAGON))

/client/proc/pick_ghost_orbit()
	var/new_orbit = tgui_input_list(src, "选择你的幽灵环绕:", "幽灵自定义", GLOB.ghost_orbits)
	if(!new_orbit)
		return

	prefs.ghost_orbit = new_orbit
	prefs.save_preferences()

	to_chat(src, span_notice("你将使用[new_orbit]作为幽灵."))

	if(!isobserver(mob))
		return

	var/mob/dead/observer/O = mob
	O.ghost_orbit = new_orbit

GLOBAL_LIST_INIT(ghost_others_options, list(GHOST_OTHERS_SIMPLE, GHOST_OTHERS_DEFAULT_SPRITE, GHOST_OTHERS_THEIR_SETTING))

/client/proc/pick_ghost_other_form()
	var/new_others = tgui_input_list(src, "选择你如何看待其他观察者:", "幽灵自定义", GLOB.ghost_others_options)
	if(!new_others)
		return

	prefs.ghost_others = new_others
	prefs.save_preferences()

	to_chat(src, span_notice("你现在将把以观察者身份开始的人视为[new_others]."))

	if(!isobserver(mob))
		return

	var/mob/dead/observer/O = mob
	O.ghost_others = new_others

/client/verb/pick_ghost_customization()
	set category = "Preferences"
	set name = "Ghost Customization"
	set desc = "Customize your ghastly appearance."

	switch(tgui_alert(src, "你想更改哪个设置?", "幽灵自定义", list("Ghost Form", "Ghost Orbit", "Ghosts of others")))
		if("Ghost Form")
			pick_form()
		if("Ghost Orbit")
			pick_ghost_orbit()
		if("Ghosts of others")
			pick_ghost_other_form()

/client/verb/toggle_deadchat_arrivalrattle()
	set category = "Preferences.Chat"
	set name = "Toggle Deadchat arrivalrattles"
	set desc = "Announces when a player spawns for the first time."

	TOGGLE_BITFIELD(prefs.toggles_deadchat, DISABLE_ARRIVALRATTLE)
	to_chat(usr, span_notice("新生成公告已[(prefs.toggles_deadchat & DISABLE_ARRIVALRATTLE) ? "disabled" : "enabled"]."))

/client/verb/toggle_deadchat_deathrattle()
	set category = "Preferences.Chat"
	set name = "Toggle Deadchat deathrattles"
	set desc = "Announces when a player dies."

	TOGGLE_BITFIELD(prefs.toggles_deadchat, DISABLE_DEATHRATTLE)
	to_chat(usr, span_notice("死亡公告已[(prefs.toggles_deadchat & DISABLE_DEATHRATTLE) ? "disabled" : "enabled"]."))
