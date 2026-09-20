/obj/item/tweezers
	name = "医用镊子"
	desc = "用于从伤员体内取出弹片的医用镊子."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "tweezers"
	worn_icon_state = "tweezers"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL

/obj/item/tweezers/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/shrapnel_removal, 6 SECONDS)

/obj/item/tweezers_advanced
	name = "\improper ESR-12"
	desc = "能量弹片取出工具,旨在快速从伤者体内取出大量弹片.极其痛苦."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "tweezers_advanced"
	worn_icon_state = "tweezers_advanced"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL

/obj/item/tweezers_advanced/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/shrapnel_removal, 1 SECONDS, 12 SECONDS)
