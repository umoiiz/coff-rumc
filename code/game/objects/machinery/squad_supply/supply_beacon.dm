/obj/item/supply_beacon
	name = "补给信标"
	desc = "一个坚固的, 增强版激光指示器, 能够将光束发射到太空中. 激活并投掷它以呼叫补给空投."
	icon = 'icons/obj/items/beacon.dmi'
	icon_state = "motion0"
	w_class = WEIGHT_CLASS_SMALL
	///Var for the window pop-up
	var/datum/supply_ui/requests/supply_interface

/obj/item/supply_beacon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/beacon, TRUE, 60, "motion2", "supply")

/obj/item/supply_beacon/examine(mob/user)
	. = ..()
	. += span_notice("空手右键点击已固定的信标以打开补给界面.")

/obj/item/supply_beacon/attack_hand_alternate(mob/living/user)
	if(!allowed(user) || !anchored)
		return ..()
	if(!supply_interface)
		supply_interface = new(src)

	return supply_interface.interact(user)
