/obj/structure/barricade/concrete
	name = "混凝土路障"
	desc = "一堵由钢筋混凝土制成的矮墙.看起来能承受大量打击."
	icon_state = "concrete_0"
	icon = 'icons/obj/structures/barricades/concrete.dmi'
	coverage = 100
	max_integrity = 500
	soft_armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 40, BIO = 100, FIRE = 100, ACID = 20)
	stack_type = null
	destroyed_stack_amount = 0
	hit_sound = 'sound/effects/metalhit.ogg'
	barricade_type = "concrete"
	can_wire = FALSE

/obj/structure/barricade/concrete/update_overlays()
	. = ..()
	var/image/new_overlay = image(icon, src, "[icon_state]_overlay", dir == SOUTH ? BELOW_OBJ_LAYER : ABOVE_MOB_LAYER, dir)
	new_overlay.pixel_y = (dir == SOUTH ? -32 : 32)
	. += new_overlay
