// Coffees and Teas

/datum/glass_style/drinking_glass/coffee
	required_drink_type = /datum/reagent/consumable/coffee
	name = "glass of coffee"
	desc = "别摔了它,否则滚烫的液体和玻璃碎片会飞得到处都是。"
	icon_state = "glass_brown"

/datum/glass_style/drinking_glass/tea
	required_drink_type = /datum/reagent/consumable/tea
	name = "glass of tea"
	desc = "从这里喝它似乎不太合适。"
	icon_state = "teaglass"

/datum/glass_style/drinking_glass/icecoffee
	required_drink_type = /datum/reagent/consumable/coffee/icecoffee
	name = "iced coffee"
	desc = "一杯让你提神醒脑的饮品!"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "icedcoffeeglass"

/datum/glass_style/drinking_glass/hot_ice_coffee
	required_drink_type = /datum/reagent/consumable/hot_ice_coffee
	name = "hot ice coffee"
	desc = "一杯烈酒——这可不便宜。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "hoticecoffee"

/datum/glass_style/drinking_glass/icetea
	required_drink_type = /datum/reagent/consumable/tea/icetea
	name = "iced tea"
	desc = "全天然、富含抗氧化剂的风味体验。"
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "icedteaglass"

/datum/glass_style/drinking_glass/soy_latte
	required_drink_type = /datum/reagent/consumable/coffee/soy_latte
	name = "soy latte"
	desc = "你阅读时喝的一杯不错又清爽的饮料。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "soy_latte"

/datum/glass_style/drinking_glass/cafe_latte
	required_drink_type = /datum/reagent/consumable/coffee/cafe_latte
	name = "cafe latte"
	desc = "你阅读时喝的一杯不错、浓烈又清爽的饮料。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "cafe_latte"

/datum/glass_style/drinking_glass/pumpkin_latte
	required_drink_type = /datum/reagent/consumable/pumpkin_latte
	name = "pumpkin latte"
	desc = "咖啡和南瓜汁的混合物。"
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "pumpkin_latte"

/datum/glass_style/has_foodtype/drinking_glass/hot_coco
	required_drink_type = /datum/reagent/consumable/hot_coco
	name = "glass of hot coco"
	desc = "一种最受欢迎的冬季饮品,让你暖和起来。"
	icon_state = "chocolateglass"
	drink_type = SUGAR | DAIRY

/datum/glass_style/drinking_glass/italian_coco
	required_drink_type = /datum/reagent/consumable/italian_coco
	name = "glass of italian coco"
	desc = "对冬季最爱饮品的改良,为了取悦人而做。"
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "italiancoco"

/datum/glass_style/drinking_glass/mushroom_tea
	required_drink_type = /datum/reagent/consumable/mushroom_tea
	name = "glass of mushroom tea"
	desc = "作为饮品来说,咸得奇怪。"
	icon_state = "mushroom_tea_glass"

/datum/glass_style/drinking_glass/t_letter
	required_drink_type = /datum/reagent/consumable/t_letter
	name = "glass of T"
	desc = "第20。"
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "tletter"
