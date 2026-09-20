/obj/structure/grille
	desc = "一个由金属杆组成的脆弱格栅,带有将其固定在地板上的螺丝。"
	name = "格栅"
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "grille0"
	hit_sound = 'sound/effects/grillehit.ogg'
	density = TRUE
	anchored = TRUE
	coverage = 10
	atom_flags = CONDUCT
	allow_pass_flags = PASS_AIR|PASS_PROJECTILE|PASS_GRILLE
	layer = OBJ_LAYER
	resistance_flags = XENO_DAMAGEABLE
	soft_armor = list(MELEE = 50, BULLET = 70, LASER = 70, ENERGY = 100, BOMB = 10, BIO = 100, FIRE = 0, ACID = 0)
	max_integrity = 10

/obj/structure/grille/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/egrill)

/obj/structure/grille/broken
	icon_state = "brokengrille"
	obj_integrity = 0
	density = FALSE

/obj/structure/grille/fence
	var/width = 3
	max_integrity = 50

/obj/structure/grille/fence/Initialize(mapload)
	. = ..()

	if(width > 1)
		if(dir in list(EAST, WEST))
			bound_width = width * world.icon_size
			bound_height = world.icon_size
		else
			bound_width = world.icon_size
			bound_height = width * world.icon_size


/obj/structure/grille/fence/east_west
	//width=80
	//height=42
	icon='icons/obj/structures/fence_ew.dmi'
	icon_state = "fence-ew"
	dir = 4

/obj/structure/grille/fence/north_south
	//width=80
	//height=42
	icon='icons/obj/structures/fence_ns.dmi'
	icon_state = "fence-ns"

/obj/structure/grille/ex_act(severity)
	qdel(src)

/obj/structure/grille/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	playsound(loc, 'sound/effects/grillehit.ogg', 25, 1)

	user.visible_message(span_warning("[user]踢了[src]。"), \
						span_warning("你踢了[src]。"), \
						"You hear twisting metal.")

/obj/structure/grille/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(iswirecutter(I))
		playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)
		new /obj/item/stack/rods(loc, 2)
		qdel(src)

	else if(isscrewdriver(I) && isopenturf(loc))
		playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
		anchored = !anchored
		user.visible_message(span_notice("[user][anchored ? "fastens" : "unfastens"]了格栅。"), \
							span_notice("你[anchored ? "fastened the grille to" : "unfastened the grill from"]了地板。"))

	else if(istype(I, /obj/item/stack/sheet/glass))
		var/obj/item/stack/sheet/glass/ST = I
		var/dir_to_set = NORTH

		if(loc == user.loc)
			dir_to_set = user.dir

		else
			if(x != user.x  && y != user.y) //Only supposed to work for cardinal directions.
				to_chat(user, span_notice("你够不到。"))
				return

			else if(x == user.x)
				if(y > user.y)
					dir_to_set = SOUTH
				else
					dir_to_set = NORTH
			else if(y == user.y)
				if(x > user.x)
					dir_to_set = EAST
				else
					dir_to_set = WEST


		for(var/obj/structure/window/W in loc)
			if(W.dir == dir_to_set)
				to_chat(user, span_notice("那里已经有一扇朝这个方向的窗户了。"))
				return

		to_chat(user, span_notice("你开始放置窗户。"))

		if(!do_after(user, 20, NONE, src, BUSY_ICON_BUILD))
			return

		for(var/obj/structure/window/W in loc)
			if(W.dir == dir_to_set)//checking this for a 2nd time to check if a window was made while we were waiting.
				to_chat(user, span_notice("那里已经有一扇朝这个方向的窗户了。"))
				return

		var/wtype = ST.created_window
		if(!ST.use(1))
			return

		var/obj/structure/window/WD = new wtype(loc, dir_to_set, 1)
		to_chat(user, span_notice("你将[WD]放置在[src]上。"))
		WD.update_icon()

/obj/structure/grille/fire_act(burn_level, flame_color)
	if(obj_integrity <= integrity_failure)
		return
	take_damage(1, BURN, FIRE)

/obj/structure/grille/get_dumping_location()
	return null

//MARINE SHIP GRILLE

/obj/structure/grille/smoothing
	icon = 'icons/obj/smooth_objects/grille.dmi'
	icon_state = "grille-0"
	base_icon_state = "grille"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_GRILLE)
	canSmoothWith = list(SMOOTH_GROUP_GRILLE)

