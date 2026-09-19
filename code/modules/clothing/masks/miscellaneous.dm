/obj/item/clothing/mask/muzzle
	name = "口套"
	desc = "为了阻止那可怕的噪音."
	icon_state = "muzzle"
	worn_icon_state = "muzzle"
	inventory_flags = COVERMOUTH
	armor_protection_flags = NONE
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.90

/obj/item/clothing/mask/surgical
	name = "无菌口罩"
	desc = "一种无菌口罩,旨在帮助防止疾病传播."
	icon_state = "sterile"
	worn_icon_state = "sterile"
	w_class = WEIGHT_CLASS_SMALL
	inventory_flags = COVERMOUTH
	armor_protection_flags = NONE
	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.01
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 25, FIRE = 0, ACID = 0)

/obj/item/clothing/mask/fakemoustache
	name = "假胡子"
	desc = "警告:胡子是假的."
	icon_state = "fake-moustache"
	inv_hide_flags = HIDEFACE
	armor_protection_flags = NONE

/obj/item/clothing/mask/snorkel
	name = "呼吸管"
	desc = "为游泳高手准备."
	icon_state = "snorkel"
	inv_hide_flags = HIDEFACE
	armor_protection_flags = NONE

/obj/item/clothing/mask/balaclava
	name = "巴拉克拉瓦头套"
	desc = "钱多多"
	icon_state = "balaclava"
	worn_icon_state = "balaclava"
	inv_hide_flags = HIDEFACE|HIDEALLHAIR
	armor_protection_flags = FACE
	w_class = WEIGHT_CLASS_SMALL
	worn_icon_list = list(
		slot_wear_mask_str = 'icons/mob/clothing/mask.dmi')

/obj/item/clothing/mask/luchador
	name = "摔角手面具"
	desc = "由强壮的格斗者佩戴,飞身跃起击败敌人!"
	icon_state = "luchag"
	worn_icon_state = "luchag"
	inv_hide_flags = HIDEFACE|HIDEALLHAIR
	cold_protection_flags = HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	armor_protection_flags = HEAD|FACE
	inventory_flags = COVERMOUTH
	w_class = WEIGHT_CLASS_SMALL
	siemens_coefficient = 3

/obj/item/clothing/mask/luchador/tecnicos
	name = "技术流面具"
	desc = "由维护正义、光荣战斗的强壮格斗者佩戴."
	icon_state = "luchador"
	worn_icon_state = "luchador"

/obj/item/clothing/mask/luchador/rudos
	name = "反派面具"
	desc = "由为获胜不择手段的强壮格斗者佩戴."
	icon_state = "luchar"
	worn_icon_state = "luchar"
