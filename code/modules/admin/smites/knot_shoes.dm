/// Ties the target's shoes
/datum/smite/knot_shoes
	name = "Knot Shoes"

/datum/smite/knot_shoes/effect(client/user, mob/living/carbon/human/target)
	. = ..()
	if (!ishuman(target))
		to_chat(user, span_warning("这个生物没有任何鞋子. 中止."), confidential = TRUE)
		return
	var/obj/item/clothing/shoes/sick_kicks = target.shoes //our target's shoes
	if (!sick_kicks?.can_be_tied)
		to_chat(user, span_warning("[target]没有可系带的鞋子!"), confidential = TRUE)
		return
	if (sick_kicks.tied == SHOES_TIED) //if tied knot the shoes of our victim
		sick_kicks.adjust_laces(SHOES_KNOTTED)
	else //If we're already knotted, revert them back to being tied. Marines aren't smart enough to unknot their own shoes without divine intervention.
		if (tgui_alert(usr, "解开[target]的鞋子?", "继续?", list("Yes", "No")) != "Yes")
			return
		sick_kicks.adjust_laces(SHOES_TIED)
		to_chat(target, span_warning("你系紧的鞋带在一股神圣力量冲刷下再次散开."), confidential = TRUE)

/obj/item/clothing/shoes/proc/adjust_laces(state, mob/user) //adjust the state of target shoes to be tied/untied
	if(!can_be_tied)
		return
	tied = state
	if(tied == SHOES_TIED)
		UnregisterSignal(src, COMSIG_SHOES_STEP_ACTION)
	else
		RegisterSignal(src, COMSIG_SHOES_STEP_ACTION, PROC_REF(check_trip), override=TRUE)


/obj/item/clothing/shoes/proc/check_trip() //check the state of our shoe laces
	SIGNAL_HANDLER
	var/mob/living/carbon/human/our_guy = loc
	if(!istype(our_guy)) // are they REALLY /our guy/?
		return
	if(tied == SHOES_KNOTTED)
		our_guy.Paralyze(1 SECONDS)
		our_guy.Knockdown(2 SECONDS)
		our_guy.adjust_stamina_loss(10) //smacking into the ground drains energy
		our_guy.visible_message(span_danger("[our_guy]被[our_guy.p_their()]系紧的鞋带绊倒并摔倒了! 真是个笨蛋!"), span_userdanger("你被自己系紧的鞋带绊倒, 狠狠摔在地上!"))
