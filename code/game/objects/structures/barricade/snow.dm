/obj/structure/barricade/snow
	name = "雪路障"
	desc = "一堆雪堆成的斜坡墙.从数据上看比薄空气更适合当掩体."
	icon_state = "snow_0"
	icon = 'icons/obj/structures/barricades/sandbag.dmi'
	barricade_type = "snow"
	max_integrity = 75
	stack_type = /obj/item/stack/snow
	stack_amount = 5
	destroyed_stack_amount = 0
	can_wire = FALSE

/obj/structure/barricade/snow/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	//Removing the barricades
	if(!istype(I, /obj/item/tool/shovel) || user.a_intent == INTENT_HARM)
		return
	var/obj/item/tool/shovel/ET = I

	if(ET.folded)
		return

	if(LAZYACCESS(user.do_actions, src))
		balloon_alert(user, "已在铲除")
		return

	user.visible_message("[user]开始清除\the [src].", "你开始移除\the [src].")

	if(!do_after(user, ET.shovelspeed, NONE, src, BUSY_ICON_BUILD))
		return

	if(ET.folded)
		return
	deconstruct(!get_self_acid())
