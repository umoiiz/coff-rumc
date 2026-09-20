/obj/structure/barricade/handrail
	name = "扶手"
	desc = "一个扶手,给你的手用的。哇哦。"
	icon = 'icons/obj/structures/handrail.dmi'
	icon_state = "handrail_a_0"
	barricade_type = "handrail"
	stack_type = /obj/item/stack/sheet/metal
	stack_amount = 2
	destroyed_stack_amount = 1
	can_wire = FALSE
	coverage = 10
	can_change_dmg_state = FALSE
	resistance_flags = XENO_DAMAGEABLE

/obj/structure/barricade/handrail/update_icon_state()
	. = ..()
	switch(dir)
		if(SOUTH)
			layer = ABOVE_MOB_LAYER
		if(NORTH)
			layer = initial(layer) - 0.01
		else
			layer = initial(layer)
	if(!anchored)
		layer = initial(layer)

/obj/structure/barricade/handrail/attackby(obj/item/item, mob/user)
	for(var/obj/effect/xenomorph/acid/A in src.loc)
		if(A.acid_t == src)
			to_chat(user, "你无法靠近那个,它正在融化!")
			return

/obj/structure/barricade/handrail/type_b
	icon_state = "handrail_b_0"
	barricade_type = "handrail_b_0"

/obj/structure/barricade/handrail/strata
	icon_state = "handrail_strata"
	barricade_type = "handrail_strata"

/obj/structure/barricade/handrail/medical
	icon_state = "handrail_med"
	barricade_type = "handrail_med"

/obj/structure/barricade/handrail/kutjevo
	icon_state = "hr_kutjevo"
	barricade_type = "hr_kutjevo"

/obj/structure/barricade/handrail/wire
	icon_state = "wire_rail"
	barricade_type = "wire_rail"

/obj/structure/barricade/handrail/sandstone
	name = "砂岩扶手"
	icon_state = "hr_sandstone"
	barricade_type = "hr_sandstone"
	stack_type = /obj/item/stack/sheet/mineral/sandstone

/obj/structure/barricade/handrail/sandstone/b
	icon_state = "hr_sandstone_b"
	barricade_type = "hr_sandstone_b"
