/*#########################################
########### Two Handed Weapons ############
#########################################*/
/obj/item/weapon/twohanded/yautja
	icon = 'icons/obj/hunter/pred_gear.dmi'
	worn_icon_list = list(
		slot_back_str = 'icons/mob/hunter/pred_gear.dmi',
		slot_l_hand_str = 'icons/mob/hunter/items_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/hunter/items_righthand.dmi',
		slot_s_store_str = 'icons/mob/hunter/pred_gear.dmi'
	)

	item_flags = TWOHANDED|ITEM_PREDATOR
	resistance_flags = UNACIDABLE
	equip_slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	throw_speed = 10
	edge = TRUE
	hitsound = 'sound/weapons/bladeslice.ogg'
	var/human_adapted = FALSE

/obj/item/weapon/twohanded/yautja/spear
	name = "猎人长矛"
	desc = "一柄设计精美的长矛,由古代文明使用."
	icon_state = "spearhunter"
	worn_icon_state = "spearhunter"
	item_flags = TWOHANDED
	force = 20
	force_activated = 45
	penetration = 25
	throwforce = 40
	sharp = IS_SHARP_ITEM_SIMPLE
	attack_verb = list("attacked", "stabbed", "jabbed", "torn", "gored")

/obj/item/weapon/twohanded/yautja/glaive
	name = "战刃"
	desc = "金属长杆上装着一把巨大而强力的刀刃.武器上刻有神秘的铭文."
	icon_state = "glaive"
	worn_icon_state = "glaive"
	force = 20
	force_activated = 45
	reach = 2
	penetration = 30
	throwforce = 20
	sharp = IS_SHARP_ITEM_BIG
	atom_flags = CONDUCT
	attack_verb = list("sliced", "slashed", "carved", "diced", "gored")
	attack_speed = 20 //Default is 7.

/obj/item/weapon/twohanded/yautja/glaive/attack(mob/living/target, mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	if((human_adapted || isyautja(user)) && isxeno(target))
		var/mob/living/carbon/xenomorph/xenomorph = target
		xenomorph.interference = 30

/obj/item/weapon/twohanded/yautja/glaive/AltClick(mob/user)
	if(!can_interact(user) || !ishuman(user) || !(user.l_hand == src || user.r_hand == src))
		return ..()
	if(!HAS_TRAIT(src, TRAIT_NODROP))
		ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		to_chat(user, span_warning("你握紧了[src]!"))
	else
		REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		to_chat(user, span_notice("你松开了[src]!"))

/obj/item/weapon/twohanded/yautja/glaive/alt
	icon_state = "glaive_alt"
	worn_icon_state = "glaive_alt"

/obj/item/weapon/twohanded/yautja/glaive/damaged
	name = "古代战刃"
	desc = "金属长杆上装着一把巨大而强力的刀刃.武器上刻有神秘的铭文.这把年代久远,已遭受严重的酸蚀,几乎无法使用."
	force = 10
	force_activated = 25
	penetration = 5
	throwforce = 10
	icon_state = "glaive_alt"
	worn_icon_state = "glaive_alt"
	item_flags = TWOHANDED

