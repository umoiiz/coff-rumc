/datum/keybinding/admin
	category = CATEGORY_ADMIN
	weight = WEIGHT_ADMIN

/datum/keybinding/admin/down(client/user)
	. = ..()
	if(.)
		return

	if(isnull(user.holder)) //blocking non admins triggering warning messages
		return TRUE

/datum/keybinding/admin/admin_say
	hotkey_keys = list("F3")
	name = ADMIN_CHANNEL
	full_name = "管理员说"
	description = "Talk with other admins."
	keybind_signal = COMSIG_KB_ADMIN_ASAY_DOWN

/datum/keybinding/admin/mentor_say
	hotkey_keys = list("F4")
	name = MENTOR_CHANNEL
	full_name = "导师说"
	description = "Speak with other mentors."
	keybind_signal = COMSIG_KB_ADMIN_MSAY_DOWN

/datum/keybinding/admin/dead_say
	hotkey_keys = list("F5")
	name = DEAD_CHANNEL
	full_name = "死亡说"
	description = "Speak with the dead."
	keybind_signal = COMSIG_KB_ADMIN_DSAY_DOWN

/datum/keybinding/admin/toggle_buildmode_self
	hotkey_keys = list("F7")
	name = "toggle_buildmode"
	full_name = "切换建造模式"
	description = "Toggles buildmode"
	keybind_signal = COMSIG_KB_ADMIN_TOGGLEBUILDMODE_DOWN

/datum/keybinding/admin/toggle_buildmode_self/down(client/user)
	. = ..()
	if(.)
		return
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/get_togglebuildmode)
	return TRUE

/datum/keybinding/admin/view_tags
	hotkey_keys = list("F9")
	name = "view_tags"
	full_name = "查看标签"
	description = "Open the View-Tags menu"
	keybind_signal = COMSIG_KB_ADMIN_VIEWTAGS_DOWN

/datum/keybinding/admin/view_tags/down(client/user)
	. = ..()
	if(.)
		return
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/display_tags)
	return TRUE
