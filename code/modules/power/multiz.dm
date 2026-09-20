/obj/structure/cable/multilayer/multiz //This bridges powernets betwen Z levels
	name = "多层Z轴电缆集线器"
	desc = "一种灵活的超导绝缘多层Z轴集线器,用于重型多层Z轴电力传输."
	icon = 'icons/obj/power.dmi'
	icon_state = "cablerelay-on"
	cable_layer = CABLE_LAYER_1|CABLE_LAYER_2|CABLE_LAYER_3
	machinery_layer = null

/obj/structure/cable/multilayer/multiz/get_cable_connections(powernetless_only)
	. = ..()
	var/turf/T = get_turf(src)
	. +=  locate(/obj/structure/cable/multilayer/multiz) in (GET_TURF_BELOW(T))
	. +=  locate(/obj/structure/cable/multilayer/multiz) in (GET_TURF_ABOVE(T))

/obj/structure/cable/multilayer/multiz/examine(mob/user)
	. += ..()
	var/turf/T = get_turf(src)
	. += span_notice("[locate(/obj/structure/cable/multilayer/multiz) in (GET_TURF_BELOW(T)) ? "Detected" : "Undetected"]集线器向上.")
	. += span_notice("[locate(/obj/structure/cable/multilayer/multiz) in (GET_TURF_ABOVE(T)) ? "Detected" : "Undetected"]集线器向下.")

