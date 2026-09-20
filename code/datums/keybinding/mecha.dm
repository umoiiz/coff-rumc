/datum/keybinding/mecha
	category = CATEGORY_MECHA
	weight = WEIGHT_MOB

/datum/keybinding/mecha/mech_toggle_strafe
	name = "mech_toggle_strafe"
	full_name = "切换侧步"
	description = "Toggle strafing for your mecha"
	keybind_signal = COMSIG_MECHABILITY_TOGGLE_STRAFE
	hotkey_keys = list("E")

/datum/keybinding/mecha/mech_view_stats
	name = "mech_view_stats"
	full_name = "查看属性"
	description = "View the diagnostics of your mecha"
	keybind_signal = COMSIG_MECHABILITY_VIEW_STATS
	hotkey_keys = list("V")

/datum/keybinding/mecha/smoke
	name = "mecha_smoke"
	full_name = "机甲烟雾"
	description = "Deploy smoke around you"
	keybind_signal = COMSIG_MECHABILITY_SMOKE
	hotkey_keys = list("F")

/datum/keybinding/mecha/toggle_zoom
	name = "toggle_zoom"
	full_name = "机甲缩放"
	description = "Zoom in or out"
	keybind_signal = COMSIG_MECHABILITY_TOGGLE_ZOOM
	hotkey_keys = list("Q")

/datum/keybinding/mecha/skyfall
	name = "mech_skyfall"
	full_name = "机甲天降"
	description = "Fly into the sky and prepare to strike"
	keybind_signal = COMSIG_MECHABILITY_SKYFALL
	hotkey_keys = list("Y")

/datum/keybinding/mecha/strike
	name = "mech_strike"
	full_name = "机甲打击"
	description = "Bombard an area with rockets"
	keybind_signal = COMSIG_MECHABILITY_STRIKE
	hotkey_keys = list("F")

/datum/keybinding/mecha/mech_reload_weapons
	name = "mech_reload_weapons"
	full_name = "机甲装填武器"
	description = "Reload any equipped weapons"
	keybind_signal = COMSIG_MECHABILITY_RELOAD
	hotkey_keys = list("R")
	
/datum/keybinding/mecha/mech_toggle_actuators
	name = "mech_toggle_actuators"
	full_name = "机甲切换执行器"
	description = "Toggle leg actuator overload for your mecha"
	keybind_signal = COMSIG_MECHABILITY_TOGGLE_ACTUATORS
	hotkey_keys = list("X")
