/obj/item/clothing/shoes/proc/step_action() //this was made to rewrite clown shoes squeaking
	SEND_SIGNAL(src, COMSIG_SHOES_STEP_ACTION)

/obj/item/clothing/shoes/mime
	name = "哑剧鞋"
	icon_state = "mime"

/obj/item/clothing/shoes/swat
	name = "\improper 特警鞋"
	desc = "当你想要升温的时候."
	icon_state = "swat"
	soft_armor = list(MELEE = 80, BULLET = 60, LASER = 50, ENERGY = 25, BOMB = 50, BIO = 10, FIRE = 25, ACID = 25)
	inventory_flags = NOSLIPPING
	item_flags = SYNTH_RESTRICTED
	siemens_coefficient = 0.6

/obj/item/clothing/shoes/ruggedboot
	name = "粗犷靴"
	desc = "危险环境中工人穿的一双靴子."
	icon_state = "swat"
	soft_armor = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 25, BOMB = 20, BIO = 20, FIRE = 20, ACID = 20)
	inventory_flags = NOSLIPPING
	item_flags = SYNTH_RESTRICTED
	siemens_coefficient = 0.6

	cold_protection_flags = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/shoes/sandal
	desc = "一双相当朴素的木制凉鞋."
	name = "凉鞋"
	icon_state = "wizard"
	armor_protection_flags = NONE

/obj/item/clothing/shoes/sandal/marisa
	desc = "一双魔法黑鞋."
	name = "魔法鞋"
	icon_state = "black"
	armor_protection_flags = FEET

/obj/item/clothing/shoes/galoshes
	desc = "橡胶靴"
	name = "套鞋"
	icon_state = "galoshes"
	permeability_coefficient = 0.05
	inventory_flags = NOSLIPPING
	slowdown = SHOES_SLOWDOWN+1

/obj/item/clothing/shoes/clown_shoes
	desc = "恶作剧者的标准配发小丑鞋.天哪,它们真大!"
	name = "小丑鞋"
	icon_state = "clown"
	worn_icon_state = "clown"
	slowdown = SHOES_SLOWDOWN + 1

/obj/item/clothing/shoes/clown_shoes/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/effects/clownstep1.ogg', 'sound/effects/clownstep2.ogg'), 50)

/obj/item/clothing/shoes/clown_shoes/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_SHOES)
		user.AddElement(/datum/element/waddling)

/obj/item/clothing/shoes/clown_shoes/unequipped(mob/user)
	. = ..()
	user.RemoveElement(/datum/element/waddling)

/obj/item/clothing/shoes/clown_shoes/erp
	desc ="恶作剧者的军用标准配发小丑鞋.天哪,它们真大!而且加固过!"
	name = "加固小丑鞋"
	armor_protection_flags = FEET
	cold_protection_flags = FEET
	heat_protection_flags = FEET
	inventory_flags = NOQUICKEQUIP|NOSLIPPING
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.7

/obj/item/clothing/shoes/jackboots
	name = "长筒军靴"
	desc = "用于战斗场景或战斗情况的安全作战靴.全天候战斗,时刻不停."
	icon_state = "jackboots"
	worn_icon_state = "jackboots"
	siemens_coefficient = 0.7

/obj/item/clothing/shoes/jackboots/mp
	soft_armor = list(MELEE = 10, BULLET = 85, LASER = 85, ENERGY = 5, BOMB = 0, BIO = 85, FIRE = 0, ACID = 0)

/obj/item/clothing/shoes/cult
	name = "靴子"
	desc = "纳尔-西追随者穿的一双靴子."
	icon_state = "cult"
	worn_icon_state = "cult"
	siemens_coefficient = 0.7

	cold_protection_flags = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/shoes/slippers
	name = "兔子拖鞋"
	desc = "毛茸茸!"
	icon_state = "slippers"
	worn_icon_state = "slippers"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/shoes/slippers_worn
	name = "破旧的兔子拖鞋"
	desc = "毛茸茸..."
	icon_state = "slippers_worn"
	worn_icon_state = "slippers_worn"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/shoes/laceup
	name = "系带鞋"
	desc = "时尚的巅峰,而且它们预先擦亮了!"
	icon_state = "laceups"

/obj/item/clothing/shoes/swimmingfins
	desc = "助你游得好."
	name = "游泳脚蹼"
	icon_state = "flippers"
	inventory_flags = NOSLIPPING
	slowdown = SHOES_SLOWDOWN+1

/obj/item/clothing/shoes/snow
	name = "雪地靴"
	desc = "当你的脚和你的心一样冰冷时"
	icon_state = "swat"
	siemens_coefficient = 0.6
	cold_protection_flags = FEET
	heat_protection_flags = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/shoes/techpriest
	name = "技术神甫靴"
	desc = "赞美机魂!"
	icon_state = "tp_boots"
	worn_icon_state = "tp_boots"
	inventory_flags = NOSLIPPING
