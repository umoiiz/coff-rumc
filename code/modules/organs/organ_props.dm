/obj/item/organ
	name = "器官"
	desc = "看起来它大概只是刚掉出来."
	icon = 'icons/obj/items/organs.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/bodyparts_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/bodyparts_right.dmi',
	)

/obj/item/organ/heart
	name = "心脏"
	icon_state = "heart-on"

/obj/item/organ/heart/examine(mob/user)
	. = ..()
	if(iszombiecrashgamemode(SSticker.mode))
		. += span_notice("看起来它可以卖给补给部门换取补给点数.")

/obj/item/organ/heart/get_export_value()
	if(iszombiecrashgamemode(SSticker.mode))
		return 50
	return 0

/obj/item/organ/lungs
	name = "肺"
	icon_state = "lungs"
	gender = PLURAL

/obj/item/organ/kidneys
	name = "肾脏"
	icon_state = "kidneys"
	gender = PLURAL

/obj/item/organ/liver
	name = "肝脏"
	icon_state = "liver"

/obj/item/organ/appendix
	name = "阑尾"
	icon_state = "appendix"

/obj/item/organ/stomach
	name = "胃"
	icon_state = "stomach"

/obj/item/organ/eyes
	name = "眼球"
	icon_state = "eyes"
	gender = PLURAL

/obj/item/organ/brain
	name = "大脑"
	icon_state = "brain2"
