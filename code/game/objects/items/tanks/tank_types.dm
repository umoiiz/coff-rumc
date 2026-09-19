/obj/item/tank/oxygen
	name = "氧气罐"
	desc = "一个氧气罐."
	icon_state = "oxygen"

/obj/item/tank/oxygen/yellow
	desc = "一个氧气罐, 这个是黄色的."
	icon_state = "oxygen_f"

/obj/item/tank/oxygen/red
	desc = "一个氧气罐, 这个是红色的."
	icon_state = "oxygen_fr"

/obj/item/tank/anesthetic
	name = "麻醉罐"
	desc = "一个装有N2O/O2混合气体的罐子."
	icon_state = "anesthetic"
	worn_icon_state = "anesthetic"

/obj/item/tank/air
	name = "空气罐"
	desc = "混合了任何东西?"
	icon_state = "oxygen"

/obj/item/tank/phoron
	name = "phoron罐"
	desc = "含有危险的phoron. 请勿吸入. 警告: 极易燃."
	icon_state = "phoron"
	atom_flags = CONDUCT
	equip_slot_flags = NONE	//they have no straps!

/obj/item/tank/emergency_oxygen
	name = "应急氧气罐"
	desc = "用于紧急情况. 含有非常少的氧气, 所以尽量节省, 直到你真正需要它."
	icon_state = "emergency"
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_TINY
	force = 4

/obj/item/tank/emergency_oxygen/engi
	name = "扩展容量应急氧气罐"
	icon_state = "emergency_engi"

/obj/item/tank/emergency_oxygen/double
	name = "双联应急氧气罐"
	icon_state = "emergency_double"

/obj/item/tank/nitrogen
	name = "氮气罐"
	desc = "一个氮气罐."
	icon_state = "oxygen_fr"
