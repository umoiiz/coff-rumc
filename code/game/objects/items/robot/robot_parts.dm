/obj/item/robot_parts
	name = "机器人部件"
	icon = 'icons/obj/items/robot_parts.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/engineering_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/engineering_right.dmi',
	)
	worn_icon_state = "buildpipe"
	icon_state = "blank"
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	var/list/part

/obj/item/robot_parts/l_arm
	name = "机器人左臂"
	desc = "一条包裹着伪肌肉的骨骼肢体, 带有低导电性外壳."
	icon_state = "l_arm"
	part = list(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND)

/obj/item/robot_parts/r_arm
	name = "机器人右臂"
	desc = "一条包裹着伪肌肉的骨骼肢体, 带有低导电性外壳."
	icon_state = "r_arm"
	part = list(BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND)

/obj/item/robot_parts/l_leg
	name = "机器人左腿"
	desc = "一条包裹着伪肌肉的骨骼肢体, 带有低导电性外壳."
	icon_state = "l_leg"
	part = list(BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT)

/obj/item/robot_parts/r_leg
	name = "机器人右腿"
	desc = "一条包裹着伪肌肉的骨骼肢体, 带有低导电性外壳."
	icon_state = "r_leg"
	part = list(BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)

/obj/item/robot_parts/chest
	name = "机器人躯干"
	desc = "一个重度加固的外壳, 内含赛博格逻辑板, 并留有标准电池的空间."
	icon_state = "chest"

/obj/item/robot_parts/head
	name = "机器人头部"
	desc = "一个标准加固的脑壳, 带有脊柱插接的神经插槽和传感器万向架."
	icon_state = "head"

/obj/item/robot_parts/robot_suit
	name = "机器人内骨骼"
	desc = "一条复杂的金属脊骨, 带有标准肢体插槽和伪肌肉锚点."
	icon_state = "robo_suit"

/obj/item/robot_parts/biotic
	name = "生物肢体"
	icon = 'icons/mob/human_races/r_human.dmi'
	atom_flags = NONE

/obj/item/robot_parts/biotic/l_arm
	name = "生物左臂"
	desc = "一个生物肢体."
	icon_state = "l_arm"
	part = list(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND)

/obj/item/robot_parts/biotic/r_arm
	name = "生物右臂"
	desc = "一个生物肢体."
	icon_state = "r_arm"
	part = list(BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND)

/obj/item/robot_parts/biotic/l_leg
	name = "生物左腿"
	desc = "一个生物肢体."
	icon_state = "l_leg"
	part = list(BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT)

/obj/item/robot_parts/biotic/r_leg
	name = "生物右腿"
	desc = "一个生物肢体."
	icon_state = "r_leg"
	part = list(BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)
