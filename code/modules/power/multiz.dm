/obj/structure/cable/multilayer/multiz //This bridges powernets betwen Z levels
	name = "多层Z轴电缆枢纽"
	desc = "一个柔性、超导绝缘的多层Z轴枢纽,用于重型多层Z轴电力传输."
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
	. += span_notice("[locate(/obj/structure/cable/multilayer/multiz) in (GET_TURF_BELOW(T)) ? "Detected" : "Undetected"]枢纽向上.")
	. += span_notice("[locate(/obj/structure/cable/multilayer/multiz) in (GET_TURF_ABOVE(T)) ? "Detected" : "Undetected"]枢纽向下.")

