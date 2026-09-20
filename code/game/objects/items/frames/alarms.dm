/*
FIRE ALARM ITEM
Handheld fire alarm frame, for placing on walls
Code shamelessly copied from apc_frame
*/
/obj/item/frame/fire_alarm
	name = "火灾警报器框架"
	desc = "用于建造火灾警报器"
	icon = 'icons/obj/objects.dmi'
	icon_state = "fire_bitem"
	atom_flags = CONDUCT

/obj/item/frame/fire_alarm/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	new /obj/item/stack/sheet/metal(loc, 2)
	qdel(src)

/obj/item/frame/fire_alarm/proc/try_build(turf/on_wall, mob/user)
	if(get_dist(on_wall,user)>1)
		return

	var/ndir = get_dir(on_wall,user)
	if(!(ndir in GLOB.cardinals))
		return

	var/turf/loc = get_turf(user)
	var/area/A = loc.loc
	if(!isfloorturf(loc))
		loc.balloon_alert(user, "位置不佳")
		return
	if(A.requires_power == 0 || A.name == "Space")
		loc.balloon_alert(user, "区域不佳")
		return

	if(gotwallitem(loc, ndir))
		loc.balloon_alert(user, "已被占用")
		return

	new /obj/machinery/firealarm(loc, ndir, 1)

	qdel(src)
