//items that are frames or assembly used to construct something (table parts, camera assembly, etc...)

/obj/item/frame
// APC FRAME

/obj/item/frame/apc
	name = "APC框架"
	desc = "用于修理或建造APC"
	icon = 'icons/obj/objects.dmi'
	icon_state = "apc_frame"
	atom_flags = CONDUCT

/obj/item/frame/apc/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	new /obj/item/stack/sheet/metal(loc, 2)
	qdel(src)

/obj/item/frame/apc/proc/try_build(turf/on_wall, mob/user)
	if(get_dist(on_wall,user) > 1)
		return
	var/ndir = get_dir(on_wall,user)
	if(!(ndir in GLOB.cardinals))
		return
	var/turf/loc = get_turf(user)
	var/area/A = get_area(loc)
	if(!isfloorturf(loc))
		loc.balloon_alert(user, "无法放置在此处")
		return
	if(A.requires_power == 0 || istype(A, /area/space))
		balloon_alert(user, "无法放置在该区域")
		return
	if(A.get_apc())
		balloon_alert(user, "无法放置,已有APC")
		return //only one APC per area
	if(A.always_unpowered)
		balloon_alert(user, "无法放置,区域不合适")
		return
	for(var/obj/machinery/power/terminal/T in loc)
		if (T.master)
			balloon_alert(user, "无法放置在另一个终端上")
			return
		else
			var/obj/item/stack/cable_coil/C = new /obj/item/stack/cable_coil(loc)
			C.amount = 10
			balloon_alert(user, "切断线缆")
			qdel(T)
	new /obj/machinery/power/apc(loc, ndir, 1)
	qdel(src)
