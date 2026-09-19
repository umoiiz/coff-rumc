
/obj/structure/supply_drop
	name = "补给空投平台"
	desc = "将未固定的补给放置于此, 以便舰桥监督官将其空投到别人头上."
	icon = 'icons/turf/decals.dmi'
	icon_state = "stripe_box_thick"
	anchored = TRUE
	density = FALSE
	resistance_flags = RESIST_ALL
	layer = ABOVE_NORMAL_TURF_LAYER
	faction = FACTION_TERRAGOV

/obj/structure/supply_drop/Initialize(mapload)
	. = ..()
	GLOB.supply_pad_list += src

/obj/structure/supply_drop/Destroy()
	GLOB.supply_pad_list -= src
	return ..()

