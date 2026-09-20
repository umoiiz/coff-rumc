/obj/item/facepaint
	gender = PLURAL
	name = "定制套件"
	desc = "一套用于定制各种护甲和衣物的套件.附带面部涂料!"
	icon = 'icons/obj/items/cosmetics.dmi'
	icon_state = "camo"
	w_class = WEIGHT_CLASS_TINY
	var/colour = "green"
	var/uses = 100

/obj/item/facepaint/green
	name = "绿色定制套件"
	colour = "green"
	icon_state = "green_camo"

/obj/item/facepaint/brown
	name = "棕色定制套件"
	colour = "brown"
	icon_state = "brown_camo"

/obj/item/facepaint/black
	name = "黑色定制套件"
	colour = "black"
	icon_state = "black_camo"

/obj/item/facepaint/sniper
	name = "全身定制套件"
	desc = "一套用于定制各种护甲和衣物的套件.附带全身涂料!"
	colour = "full"
	icon_state = "full_camo"

/obj/item/facepaint/premium
	name = "高级定制套件"
	desc = "一套用于定制武器的套件.附带彩虹涂料!"
	colour = "rainbow"
	icon_state = "rainbow_camo"
	uses = 1

/obj/item/facepaint/attack(mob/M, mob/user)
	. = ..()
	if(!ishuman(M))
		to_chat(user, span_warning("失败了!"))
		return

	var/mob/living/carbon/human/attacked_human = M
	if(attacked_human.makeup_style)	//if they already have lipstick on
		to_chat(user, span_warning("你需要先用纸把旧涂料擦掉!"))
		return

	if(attacked_human != user && attacked_human.client)
		user.visible_message(span_notice("[user]正试图将[src]涂在[attacked_human]的脸上..."), span_notice("你试图将[src]涂在[attacked_human]上..."))
		if(tgui_alert(attacked_human, "涂抹妆容", "你允许[user]在你的脸上涂画吗?", list("Yes","No")) != "Yes")
			return
		if(!user || loc != user || !user.Adjacent(attacked_human))
			return
	paint_face(attacked_human, user)

///Handles applying the makeup
/obj/item/facepaint/proc/paint_face(mob/living/carbon/human/H, mob/user)
	if(!H || !user)
		return //In case they're passed as null.
	user.visible_message(span_notice("[user]小心地将[src]涂在[H]的脸上."), \
		span_notice("你涂抹了[src]."))
	H.makeup_style = colour
	H.alpha = max(0, initial(H.alpha) - 1) // decreases your alpha by 1
	H.update_body()
	uses--
	if(!uses)
		user.temporarilyRemoveItemFromInventory(src)
		user.update_inv_l_hand(0)
		user.update_inv_r_hand()
		qdel(src)
