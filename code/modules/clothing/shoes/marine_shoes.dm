/obj/item/clothing/shoes/marine
	name = "陆战队战斗靴"
	desc = "标准配发战斗靴, 用于战斗场景或战斗情况. 一切皆战斗, 始终如此."
	icon_state = "marine"
	worn_icon_state = "marine"
	armor_protection_flags = FEET
	cold_protection_flags = FEET
	heat_protection_flags = FEET
	inventory_flags = NOQUICKEQUIP|NOSLIPPING
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.7
	storage_type = /datum/storage/internal/shoes
	/// The knife we add to the storage on Initialize
	var/obj/item/knife_to_add

/obj/item/clothing/shoes/marine/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/clothing/shoes/marine/PopulateContents()
	if(knife_to_add)
		new knife_to_add(src)

/obj/item/clothing/shoes/marine/update_icon_state()
	. = ..()
	icon_state = initial(icon_state)
	if(!storage_datum)
		return
	for(var/obj/item/item AS in contents)
		if(!istype(item, /obj/item/weapon/combat_knife) && !istype(item, /obj/item/attachable/bayonetknife) && !istype(item, /obj/item/stack/throwing_knife))
			continue
		icon_state += "-knife"
		break

/obj/item/clothing/shoes/marine/full
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/brown
	name = "棕色陆战队战斗靴"
	icon_state = "marine_brown"
	worn_icon_state = "marine_brown"

/obj/item/clothing/shoes/marine/brown/full
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/upp
	knife_to_add = /obj/item/weapon/combat_knife/upp

/obj/item/clothing/shoes/marinechief
	name = "大副鞋"
	desc = "制作本片仅杀害了少量猴子、小猫和孤儿."
	icon_state = "laceups"
	soft_armor = list(MELEE = 35, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)
	inventory_flags = NOSLIPPING
	siemens_coefficient = 0.6

/obj/item/clothing/shoes/marinechief/captain
	name = "队长的鞋子"
	desc = "拥有特殊鞋底,能更好地践踏脚下的东西."

/obj/item/clothing/shoes/marinechief/som
	name = "军官的靴子"
	desc = "一双闪亮的靴子,通常出现在SOM军官的脚上."
	icon_state = "som_officer_boots"

/obj/item/clothing/shoes/marinechief/sa
	name = "空间特工的鞋子"
	desc = "空间特工穿的鞋子."
	item_flags = DELONDROP

/obj/item/clothing/shoes/marine/pmc
	name = "擦亮的鞋子"
	desc = "时尚的巅峰,但看起来织入了防护纤维."
	icon_state = "jackboots"
	worn_icon_state = "jackboots"
	armor_protection_flags = FEET
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 15)
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE
	cold_protection_flags = FEET
	heat_protection_flags = FEET
	inventory_flags = NOSLIPPING
	siemens_coefficient = 0.6

/obj/item/clothing/shoes/marine/pmc/full
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/deathsquad
	name = "\improper PMC突击队靴"
	desc = "一双重装甲、耐酸的靴子."
	icon_state = "commando_boots"
	worn_icon_state = "commando_boots"
	permeability_coefficient = 0.01
	soft_armor = list(MELEE = 40, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)
	siemens_coefficient = 0.2
	resistance_flags = UNACIDABLE

/obj/item/clothing/shoes/marine/deathsquad
	knife_to_add = /obj/item/weapon/combat_knife

/*=========Imperium=========*/

/obj/item/clothing/shoes/marine/imperial
	name = "卫军作战靴"
	desc = "发给帝国卫队的一双靴子,和他们使用的其他任何东西一样,都是批量生产的."
	//icon_state = ""
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)

/obj/item/clothing/shoes/marine/som
	name = "\improper S11作战鞋"
	desc = "起源可追溯到旧采矿殖民地的鞋子.它们被制造出来可不只是为了走路."
	icon_state = "som"
	worn_icon_state = "som"

/obj/item/clothing/shoes/marine/som/knife
	knife_to_add = /obj/item/attachable/bayonetknife/som

/obj/item/clothing/shoes/sectoid
	name = "灵能场"
	desc = "一片无形的能量场,它保护穿戴者,但会阻止穿戴任何衣物."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield-blue"
	item_flags = DELONDROP
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)
	inventory_flags = NOSLIPPING

/obj/item/clothing/shoes/sectoid/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SECTOID_TRAIT)

/obj/item/clothing/shoes/cowboy
	name = "结实的西部靴"
	desc = "既结实又老派,它们能让你在任何星球上免遭蛇咬脚踝.这些靴子不能储存任何东西,但凭借脚跟那些多余的靴刺增添了额外的时尚感."
	icon_state = "cboots"
	worn_icon_state = "cboots"

/obj/item/clothing/shoes/marine/clf
	name = "\improper 边境靴"
	desc = "一双磨损严重的靴子,常见于大多数外殖民地."
	icon_state = "boots"
	worn_icon_state = "boots"

/obj/item/clothing/shoes/marine/vsd
	name = "\improper 作战靴"
	desc = "V.S.D的标准配发作战靴"
	icon_state = "boots"
	worn_icon_state = "boots"

/obj/item/clothing/shoes/marine/vsd/full
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/clf/full
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/icc
	name = "\improper Modelle/32作战鞋"
	desc = "一双结实的劳保靴."
	icon_state = "icc"

/obj/item/clothing/shoes/marine/icc/knife
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/icc/guard
	name = "\improper Modelle/33战术鞋"
	desc = "一双结实的战术靴."
	icon_state = "icc_guard"

/obj/item/clothing/shoes/marine/icc/guard/knife
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/headskin
	name = "陆战队老兵作战靴"
	desc = "普通的作战靴.它们没有任何不寻常之处.没有任何."
	icon_state = "headskin"
	worn_icon_state = "headskin"

/obj/item/clothing/shoes/marine/headskin
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/separatist
	name = "强化靴TS-28"
	desc = "结实的橡胶化靴子,可防潮、防小碎片和冲击.这些鞋子的手工设计,当然,被生产机器取消了,以便尽可能为所有员工提供供应."
	icon_state = "separatist"
	worn_icon_state = "separatist"

/obj/item/clothing/shoes/marine/separatist
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/srf //Basically SWAT shoes combined with galoshes.
	name = "作战靴"
	desc = "当你真的想要升温的时候"
	icon_state = "swat"
	worn_icon_state = "swat"
	item_flags = SYNTH_RESTRICTED
	soft_armor = list(MELEE = 80, BULLET = 60, LASER = 50, ENERGY = 25, BOMB = 50, BIO = 10, FIRE = 25, ACID = 25)
	inventory_flags = NOSLIPPING
	siemens_coefficient = 0.6

	cold_protection_flags = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/shoes/marine/srf/full
	knife_to_add = /obj/item/weapon/combat_knife
