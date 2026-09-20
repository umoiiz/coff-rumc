/datum/keybinding/weapon
	category = CATEGORY_WEAPON
	weight = WEIGHT_MOB

/datum/keybinding/weapon/axe_sweep
	name = "Axe sweep"
	full_name = "破门斧: 斧扫"
	description = "A powerful sweeping blow that hits foes in the direction you are facing. Cannot stun."
	keybind_signal = COMSIG_WEAPONABILITY_AXESWEEP
	hotkey_keys = list("G")

/datum/keybinding/weapon/sword_lunge
	name = "Lunging strike"
	full_name = "剑: 突刺打击"
	description = "Dash a short distance to inflict a staggering blow on an opponent. Cannot stun."
	keybind_signal = COMSIG_WEAPONABILITY_SWORDLUNGE
	hotkey_keys = list("G")

/datum/keybinding/weapon/shield_bash
	name = "Shield bash"
	full_name = "盾: 盾击"
	description = "Slams your shield into a mob in front of you, causing stagger and slowdown. Can also be triggered via right click when equipped in the offhand."
	keybind_signal = COMSIG_WEAPONABILITY_SHIELDBASH
	hotkey_keys = list("U")
