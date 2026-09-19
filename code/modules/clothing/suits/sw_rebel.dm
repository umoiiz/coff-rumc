// Броня повстанцев - наследует от КЛФников статы
/obj/item/clothing/suit/storage/faction/militia/rebel
	name = "\improper 义军士兵背心"
	desc = "义军同盟士兵穿着的简易装甲背心."
	icon = 'icons/mob/clothing/suits/sw_suits.dmi'
	icon_state = "rebel_vest"
	worn_icon_state = "rebel_vest"
	worn_icon_state_worn = TRUE
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/sw_suits.dmi',
		slot_l_hand_str = 'icons/mob/inhands/clothing/suits_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/clothing/suits_right.dmi',
	)
	slowdown = 0
	soft_armor = list(MELEE = 20, BULLET = 25, LASER = 20, ENERGY = 15, BOMB = 10, BIO = 0, FIRE = 5, ACID = 5)

/obj/item/clothing/suit/storage/faction/militia/rebel/officer
	name = "\improper 义军军官背心"
	desc = "义军同盟军官穿着的卡其色和橙色背心."
	icon_state = "rebel_officer_vest"
	worn_icon_state = "rebel_officer_vest"
	soft_armor = list(MELEE = 25, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 15, BIO = 0, FIRE = 5, ACID = 5)

