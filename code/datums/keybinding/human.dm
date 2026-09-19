/datum/keybinding/human
	category = CATEGORY_HUMAN
	weight = WEIGHT_MOB
	description = ""

/datum/keybinding/human/quick_equip
	keybind_signal = COMSIG_KB_QUICKEQUIP
	///The quick equip slot the keybind will equip to, checked by the reciever of the keybind signal.
	var/quick_equip_slot

/datum/keybinding/human/quick_equip/quick_equip_primary
	hotkey_keys = list("E")
	name = "quick_equip_1"
	full_name = "快速装备 1"
	quick_equip_slot = 1

/datum/keybinding/human/quick_equip/quick_equip_secondary
	hotkey_keys = list("ShiftE")
	name = "quick_equip_2"
	full_name = "快速装备 2"
	quick_equip_slot = 2

/datum/keybinding/human/quick_equip/quick_equip_tertiary
	name = "quick_equip_3"
	full_name = "快速装备 3"
	quick_equip_slot = 3

/datum/keybinding/human/quick_equip/quick_equip_quaternary
	name = "quick_equip_4"
	full_name = "快速装备 4"
	quick_equip_slot = 4

/datum/keybinding/human/quick_equip/quick_equip_quinary
	name = "quick_equip_5"
	full_name = "快速装备 5"
	quick_equip_slot = 5

/datum/keybinding/human/interact_other_hand
	name = "interact_other_hand"
	full_name = "与另一只手互动"
	keybind_signal = COMSIG_KB_HUMAN_INTERACT_OTHER_HAND

/datum/keybinding/human/interact_other_hand/down(client/user)
	. = ..()
	if(.)
		return

	if(!ishuman(user.mob))
		return
	var/mob/living/carbon/human/human_user = user.mob

	human_user.interact_other_hand()

/datum/keybinding/human/unique_action
	hotkey_keys = list("Space")
	name = "unique_action"
	full_name = "执行独特动作"
	keybind_signal = COMSIG_KB_UNIQUEACTION

/datum/keybinding/human/rail_attachment
	hotkey_keys = list("F")
	name = "rail_attachment"
	full_name = "激活轨道配件"
	keybind_signal = COMSIG_KB_RAILATTACHMENT

/datum/keybinding/human/muzzle_attachment
	name = "muzzle_attachment"
	full_name = "激活枪管配件"
	keybind_signal = COMSIG_KB_MUZZLEATTACHMENT

/datum/keybinding/human/underrail_attachment
	name = "underrail_attachment"
	full_name = "激活下挂配件"
	keybind_signal = COMSIG_KB_UNDERRAILATTACHMENT

/datum/keybinding/human/unload_gun
	name = "unload_gun"
	full_name = "卸载枪械"
	keybind_signal = COMSIG_KB_UNLOADGUN

/datum/keybinding/human/toggle_gun_safety
	name = "toggle_safety"
	full_name = "切换枪械保险"
	keybind_signal = COMSIG_KB_GUN_SAFETY

/datum/keybinding/human/toggle_aim_mode
	hotkey_keys = list("6")
	name = "toggle_aim_mode"
	full_name = "切换瞄准模式"
	keybind_signal = COMSIG_KB_AIMMODE

/datum/keybinding/human/switch_fire_mode
	name = "switch_fire_mode"
	full_name = "切换开火模式"
	keybind_signal = COMSIG_KB_FIREMODE

/datum/keybinding/human/toggle_auto_eject
	name = "toggle_auto_eject"
	full_name = "切换自动弹匣弹出"
	keybind_signal = COMSIG_KB_AUTOEJECT

/datum/keybinding/human/overhead_grenade_launcher
	name = "overhead_grenade_launcher"
	full_name = "切换顶置榴弹发射器模式"
	description = "Toggle between direct and indirect fire modes for grenade launchers"
	keybind_signal = COMSIG_KB_OVERHEAD_GRENADE_LAUNCHER

/datum/keybinding/human/give
	name = "give"
	full_name = "给予"
	description = "Give the held item to the nearby marine"
	keybind_signal = COMSIG_KB_GIVE

/datum/keybinding/human/vali_configure
	name = "vali_configure"
	full_name = "配置瓦利化学增强"
	description = "Vali settings menu"
	keybind_signal = COMSIG_KB_VALI_CONFIGURE

/datum/keybinding/human/vali_heal
	name = "vali_heal"
	full_name = "激活瓦利治疗"
	keybind_signal = COMSIG_KB_VALI_HEAL

/datum/keybinding/human/vali_connect
	name = "vali_connect"
	full_name = "连接瓦利"
	description = "Connect Vali system to your weapon"
	keybind_signal = COMSIG_KB_VALI_CONNECT

/datum/keybinding/human/suit_analyzer
	name = "suit_analyzer"
	full_name = "激活战衣生命分析仪"
	keybind_signal = COMSIG_KB_SUITANALYZER

/datum/keybinding/human/toggle_helmet_module
	hotkey_keys = list("h")
	name = "toggle_helmet_module"
	full_name = "切换头盔模块"
	description = "Toggles your helmet module on or off or activates it"
	keybind_signal = COMSIG_KB_HELMETMODULE

/datum/keybinding/human/toggle_armor_module
	hotkey_keys = list("j")
	name = "toggle_armor_module"
	full_name = "切换护甲模块"
	description = "Toggles your armor module or activates it"
	keybind_signal = COMSIG_KB_ARMORMODULE

/datum/keybinding/human/toggle_suit_light
	hotkey_keys = list("l")
	name = "toggle_suit_light"
	full_name = "切换战衣灯"
	description = "Toggles your suit light on or off"
	keybind_signal = COMSIG_KB_SUITLIGHT

/datum/keybinding/human/activate_robot_autorepair
	hotkey_keys = list("g")
	name = "autorepair"
	full_name = "激活战斗机器人自动修复"
	description = "Activate combat robot's autorepair"
	keybind_signal = COMSIG_KB_ROBOT_AUTOREPAIR

/datum/keybinding/human/move_order
	name = "move_order"
	full_name = "下达移动命令"
	description = "Order marines to move faster"
	keybind_signal = COMSIG_KB_MOVEORDER

/datum/keybinding/human/hold_order
	name = "hold_order"
	full_name = "下达坚守命令"
	description = "Order marines to hold ground"
	keybind_signal = COMSIG_KB_HOLDORDER

/datum/keybinding/human/focus_order
	name = "focus_order"
	full_name = "下达集火命令"
	description = "Order marines to aim better"
	keybind_signal = COMSIG_KB_FOCUSORDER

/datum/keybinding/human/rally_order
	name = "rally_order"
	full_name = "发送集结命令"
	description = "Order marines to rally"
	keybind_signal = COMSIG_KB_RALLYORDER

/datum/keybinding/human/send_order
	name = "send_order"
	full_name = "发送命令"
	description = "Order marines a certain message"
	keybind_signal = COMSIG_KB_SENDORDER

/datum/keybinding/human/attack_order
	name = "attack_order"
	full_name = "下达攻击命令"
	description = "Order and rally marines to attack"
	keybind_signal = COMSIG_KB_ATTACKORDER

/datum/keybinding/human/defend_order
	name = "defend_order"
	full_name = "下达防守命令"
	description = "Order and rally marines to defend"
	keybind_signal = COMSIG_KB_DEFENDORDER

/datum/keybinding/human/retreat_order
	name = "retreat_order"
	full_name = "下达撤退命令"
	description = "Order and rally marines to retreat"
	keybind_signal = COMSIG_KB_RETREATORDER

/datum/keybinding/human/vehicle_honk
	name = "vehicle_honk"
	full_name = "鸣笛"
	description = "Tell marines to move so that they don't get run over"
	keybind_signal = COMSIG_KB_VEHICLEHONK

/datum/keybinding/human/place_hologram
	name = "place_hologram"
	full_name = "放置全息影像"
	description = "Place a holographic template of a structure"
	keybind_signal = COMSIG_ABILITY_PLACE_HOLOGRAM
	hotkey_keys = list("E")

/datum/keybinding/human/select_buildtype
	name = "select_buildtype"
	full_name = "选择建造类型"
	description = "Select the structure to use when using Place Hologram"
	keybind_signal = COMSIG_ABILITY_SELECT_BUILDTYPE
	hotkey_keys = list("Q")
