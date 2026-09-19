/obj/item/clothing/shoes/marine
	name = "海军陆战队作战靴"
	desc = "用于作战场景或作战情况的标准配发作战靴.全天候作战,时刻准备着."
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
	name = "棕色海军陆战队作战靴"
	icon_state = "marine_brown"
	worn_icon_state = "marine_brown"

/obj/item/clothing/shoes/marine/brown/full
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/upp
	knife_to_add = /obj/item/weapon/combat_knife/upp

/obj/item/clothing/shoes/marinechief
	name = "长官鞋"
	desc = "制作这双鞋只杀害了少量的猴子,小猫和孤儿."
	icon_state = "laceups"
	soft_armor = list(MELEE = 35, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)
	inventory_flags = NOSLIPPING
	siemens_coefficient = 0.6

/obj/item/clothing/shoes/marinechief/captain
	name = "舰长鞋"
	desc = "拥有特殊的鞋底,能更好地践踏那些在你下面的人."

/obj/item/clothing/shoes/marinechief/som
	name = "军官靴"
	desc = "一双锃亮的靴子,通常出现在SOM军官的脚上."
	icon_state = "som_officer_boots"

/obj/item/clothing/shoes/marinechief/sa
	name = "空间特工鞋"
	desc = "空间特工穿的鞋."
	item_flags = DELONDROP

/obj/item/clothing/shoes/marine/pmc
	name = "擦亮的鞋"
	desc = "时尚的巅峰,但这些鞋似乎是用防护纤维编织而成的."
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
	desc = "一双重装甲,耐酸的靴子."
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
	desc = "配发给帝国卫队的靴子,就像他们使用的其他任何东西一样,是批量生产的."
	//icon_state = ""
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)

/obj/item/clothing/shoes/marine/som
	name = "\improper S11作战鞋"
	desc = "起源可追溯到旧采矿殖民地的鞋子.这些鞋的用途远不止走路."
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
	desc = "既结实又复古,它们能在任何星球上保护你的脚踝免受蛇咬.这些靴子不能存放任何东西,但后跟上那些多余的靴刺增添了额外的时尚感."
	icon_state = "cboots"
	worn_icon_state = "cboots"

/obj/item/clothing/shoes/marine/clf
	name = "\improper 边境靴"
	desc = "一双磨损严重的靴子,常见于大多数外围殖民地."
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
	desc = "一双结实的工作靴."
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
	name = "海军陆战队老兵作战靴"
	desc = "普通的作战靴.它们没有任何不寻常之处.没有任何."
	icon_state = "headskin"
	worn_icon_state = "headskin"

/obj/item/clothing/shoes/marine/headskin
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/separatist
	name = "强化靴TS-28"
	desc = "非常坚固的橡胶靴,能防潮,防小碎片和冲击.这些鞋的手工设计,当然,被生产机器取消了,以便尽可能为所有员工提供供应."
	icon_state = "separatist"
	worn_icon_state = "separatist"

/obj/item/clothing/shoes/marine/separatist
	knife_to_add = /obj/item/weapon/combat_knife

/obj/item/clothing/shoes/marine/srf //Basically SWAT shoes combined with galoshes.
	name = "作战靴"
	desc = "当你真的想要火力全开的时候"
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
