/obj/item/frame/rack
	name = "货架零件"
	desc = "一套带有多层金属搁板的储物货架组件. 相对便宜,适合大量存储. 需要一些组装."
	icon = 'icons/obj/items/items.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/engineering_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/engineering_right.dmi',
	)
	icon_state = "rack_parts"
	atom_flags = CONDUCT

/obj/item/frame/rack/wrench_act(mob/living/user, obj/item/I)
	. = ..()

	new /obj/item/stack/sheet/metal(loc)
	qdel(src)

/obj/item/frame/rack/attack_self(mob/user as mob)
	if(locate(/obj/structure/table) in user.loc || locate(/obj/structure/barricade) in user.loc)
		to_chat(user, span_warning("此处已有结构."))
		return

	if(locate(/obj/structure/rack) in user.loc)
		to_chat(user, span_warning("此处已有货架."))
		return

	new /obj/structure/rack(user.loc)
	user.drop_held_item()
	qdel(src)
