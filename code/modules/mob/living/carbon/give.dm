/mob/living/carbon/verb/give()
	set category = "IC"
	set name = "Give"
	var/mob/living/carbon/human/is_giving = usr
	is_giving.do_give()

///Signal handler for give keybind
/mob/living/carbon/proc/give_signal_handler()
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(do_give))

///Look for a nearby human to give the held item, and ask him if he wants it
/mob/living/carbon/proc/do_give()
	if(stat != CONSCIOUS)
		return
	if(!hand && r_hand == null)
		to_chat(usr, span_warning("你右手没有任何东西可以给出."))
		return
	if(hand && l_hand == null)
		to_chat(usr, span_warning("你左手没有任何东西可以给出."))
		return
	var/mob/living/carbon/to_give_to
	for(var/mob/living/carbon/human AS in cheap_get_humans_near(src, 1))
		if(human.stat == CONSCIOUS && human.client && src != human)
			to_give_to = human
			break
	if(!to_give_to)
		return
	var/obj/item/item
	if(hand)
		item = l_hand
	else if(!hand)
		item = r_hand
	if(!istype(item) || HAS_TRAIT(src, TRAIT_NODROP) || (item.item_flags & DELONDROP|ITEM_ABSTRACT|HAND_ITEM))
		return
	if(to_give_to.r_hand && to_give_to.l_hand)
		to_chat(src, span_warning("[to_give_to]的双手都满了."))
		return
	if(tgui_alert(to_give_to, "[src]想给你\a [item]?", null, list("Yes","No")) != "Yes")
		return
	if(!Adjacent(to_give_to))
		to_chat(src, span_warning("你在给予物品时需要保持在可触及的距离内."))
		to_chat(to_give_to, span_warning("[src]移动得太远了."))
		return
	if((hand && l_hand != item) || (!hand && r_hand != item))
		to_chat(src, span_warning("你需要将物品保持在你的活跃手中."))
		to_chat(to_give_to, span_warning("[src]似乎已经放弃将[item]给你了."))
		return
	if(to_give_to.r_hand != null && to_give_to.l_hand != null)
		to_chat(src, span_warning("[to_give_to]的双手都满了."))
		to_chat(to_give_to, span_warning("你的双手都满了."))
		return
	if(!drop_held_item())
		return
	if(!to_give_to.put_in_hands(item))
		return
	visible_message(span_notice("[src]将[item]递给[to_give_to]."),
	span_notice("你将[item]递给[to_give_to]."), null, 4)
