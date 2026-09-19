/obj/item/tool/rcd
	name = "快速建造装置(RCD)"
	desc = "一种用于快速建造墙壁/地板的装置."
	icon = 'icons/obj/items/tools.dmi'
	icon_state = "rcd"
	opacity = FALSE
	density = FALSE
	anchored = FALSE
	atom_flags = CONDUCT
	force = 10
	throwforce = 10
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL


/obj/item/ammo_rcd
	name = "压缩物质弹药筒"
	desc = "用于RCD的高压缩物质."
	icon = 'icons/obj/items/ammo/misc.dmi'
	icon_state = "rcd"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/tools_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/tools_right.dmi',
	)
	worn_icon_state = "rcdammo"
	opacity = FALSE
	density = FALSE
	anchored = FALSE
