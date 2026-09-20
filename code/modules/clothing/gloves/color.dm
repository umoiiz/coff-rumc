/obj/item/clothing/gloves/insulated
	desc = "这些手套将保护佩戴者免受电击."
	name = "绝缘手套"
	icon_state = "insulated"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	cold_protection_flags = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/yellow                             //Cheap Chinese Crap
	desc = "这些手套是那款令人垂涎的手套的廉价仿制品,这绝不可能有好结果."
	name = "廉价绝缘手套"
	icon_state = "yellow"
	siemens_coefficient = 1			//Set to a default of 1, gets overridden in New()
	permeability_coefficient = 0.05

/obj/item/clothing/gloves/yellow/Initialize(mapload)
	. = ..()
	siemens_coefficient = pick(0,0.5,0.5,0.5,0.5,0.75,1.5)

/obj/item/clothing/gloves/black
	desc = "这些手套是防火的."
	name = "黑色手套"
	icon_state = "black"
	cold_protection_flags = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/orange
	name = "橙色手套"
	desc = "一副手套,看起来没有任何特别之处."
	icon_state = "orange"

/obj/item/clothing/gloves/red
	name = "红色手套"
	desc = "一副手套,看起来没有任何特别之处."
	icon_state = "red"

/obj/item/clothing/gloves/rainbow
	name = "彩虹手套"
	desc = "一副手套,看起来没有任何特别之处."
	icon_state = "rainbow"

/obj/item/clothing/gloves/blue
	name = "蓝色手套"
	desc = "一副手套,看起来没有任何特别之处."
	icon_state = "blue"

/obj/item/clothing/gloves/purple
	name = "紫色手套"
	desc = "一副手套,看起来没有任何特别之处."
	icon_state = "purple"

/obj/item/clothing/gloves/green
	name = "绿色手套"
	desc = "一副手套,看起来没有任何特别之处."
	icon_state = "green"

/obj/item/clothing/gloves/grey
	name = "灰色手套"
	desc = "一副手套,看起来没有任何特别之处."
	icon_state = "gray"

/obj/item/clothing/gloves/light_brown
	name = "浅棕色手套"
	desc = "一副手套,看起来没有任何特别之处."
	icon_state = "lightbrown"

/obj/item/clothing/gloves/brown
	name = "棕色手套"
	desc = "一副手套,看起来没有任何特别之处."
	icon_state = "brown"

/obj/item/clothing/gloves/sectoid
	name = "灵能场"
	desc = "一片隐形能量场,它能保护穿戴者,但无法穿戴任何衣物."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield-blue"
	item_flags = DELONDROP
	soft_armor = list(MELEE = 25, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)

/obj/item/clothing/gloves/sectoid/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SECTOID_TRAIT)
