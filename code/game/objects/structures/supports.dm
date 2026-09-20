/obj/structure/support
	name = "木制支撑柱"
	desc = "这根柱子似乎支撑着天花板,小心不要弄断它. 天花板可能会坍塌."
	icon = 'icons/turf/wood.dmi'
	icon_state = "wood0"
	density = TRUE

	obj_integrity = 250

	/// How far around the pillar is supported
	var/supported_range = 1
	/// The type of debris to spawn when the ceiling collaspses
	var/collapsed_type = /turf/closed/mineral

/obj/structure/support/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_WOOD, -40, 5)

/obj/structure/support/deconstruct(disassembled)
	collapse()
	. = ..()


/obj/structure/support/proc/collapse()
	playsound(loc, "explosion", 100, TRUE)
	var/list/turfs = RANGE_TURFS(supported_range, loc)
	for(var/i in turfs)
		var/turf/T = i
		if(T.density)
			continue
		var/list/baseturfs = islist(T.baseturfs) ? T.baseturfs : list(T.baseturfs)
		baseturfs |= T.type
		T.ChangeTurf(collapsed_type, baseturfs)
