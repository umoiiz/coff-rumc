/obj/vehicle/ridden/bicycle
	name = "bicycle"
	desc = "远离电力."
	icon_state = "bicycle"

/obj/vehicle/ridden/bicycle/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/bicycle)

