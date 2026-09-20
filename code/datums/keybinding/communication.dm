/datum/keybinding/client/communication
	category = CATEGORY_COMMUNICATION

/datum/keybinding/client/communication/say
	hotkey_keys = list("T")
	name = SAY_CHANNEL
	full_name = "IC说"
	keybind_signal = COMSIG_KB_CLIENT_SAY_DOWN

/datum/keybinding/client/communication/radio
	hotkey_keys = list("Y")
	name = RADIO_CHANNEL
	full_name = "IC无线电(;)"
	keybind_signal = COMSIG_KB_CLIENT_RADIO_DOWN

/datum/keybinding/client/communication/ooc
	hotkey_keys = list("O")
	name = OOC_CHANNEL
	full_name = "出戏说(OOC)"
	keybind_signal = COMSIG_KB_CLIENT_OOC_DOWN

/datum/keybinding/client/communication/me
	hotkey_keys = list("M")
	name = ME_CHANNEL
	full_name = "自定义表情(/Me)"
	keybind_signal = COMSIG_KB_CLIENT_ME_DOWN

/datum/keybinding/client/communication/xooc
	name = XOOC_CHANNEL
	full_name = "异形OOC(XOOC)"
	keybind_signal = COMSIG_KB_CLIENT_XOOC_DOWN

/datum/keybinding/client/communication/mooc
	name = MOOC_CHANNEL
	full_name = "陆战队员OOC(MOOC)"
	keybind_signal = COMSIG_KB_CLIENT_MOOC_DOWN

/datum/keybinding/client/communication/looc
	name = LOOC_CHANNEL
	full_name = "本地OOC(LOOC)"
	keybind_signal = COMSIG_KB_CLIENT_LOOC_DOWN

/datum/keybinding/client/communication/say/down(client/user)
	. = ..()
	if(.)
		return
	winset(user, null, "command=[user.tgui_say_create_open_command(SAY_CHANNEL)]")
	return TRUE

/datum/keybinding/client/communication/radio/down(client/user)
	. = ..()
	if(.)
		return
	winset(user, null, "command=[user.tgui_say_create_open_command(RADIO_CHANNEL)]")
	return TRUE

/datum/keybinding/client/communication/ooc/down(client/user)
	. = ..()
	if(.)
		return
	winset(user, null, "command=[user.tgui_say_create_open_command(OOC_CHANNEL)]")
	return TRUE

/datum/keybinding/client/communication/me/down(client/user)
	. = ..()
	if(.)
		return
	winset(user, null, "command=[user.tgui_say_create_open_command(ME_CHANNEL)]")
	return TRUE

/datum/keybinding/client/communication/xooc/down(client/user)
	. = ..()
	if(.)
		return
	winset(user, null, "command=[user.tgui_say_create_open_command(XOOC_CHANNEL)]")
	return TRUE

/datum/keybinding/client/communication/mooc/down(client/user)
	. = ..()
	if(.)
		return
	winset(user, null, "command=[user.tgui_say_create_open_command(MOOC_CHANNEL)]")
	return TRUE

/datum/keybinding/client/communication/looc/down(client/user)
	. = ..()
	if(.)
		return
	winset(user, null, "command=[user.tgui_say_create_open_command(LOOC_CHANNEL)]")
	return TRUE
