/obj/machinery/newscaster
	name = "newscaster"
	desc = "一个标准的纳米传思授权新闻推送处理器,用于商业空间站.所有你绝对用不上的新闻,尽在一处!"
	icon = 'icons/obj/terminals.dmi'
	icon_state = "newscaster_normal"
	anchored = TRUE


/obj/item/newspaper
	name = "报纸"
	desc = "一份《狮鹫报》,在纳米传思空间站上流通的报纸."
	icon = 'icons/obj/items/paper.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/books_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/books_right.dmi',
	)
	icon_state = "newspaper"
	w_class = WEIGHT_CLASS_TINY	//Let's make it fit in trashbags!
	attack_verb = list("baps")
