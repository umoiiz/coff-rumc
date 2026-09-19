// Coffees and Teas

/datum/glass_style/drinking_glass/coffee
	required_drink_type = /datum/reagent/consumable/coffee
	name = "glass of coffee"
	desc = "别摔了,不然滚烫的液体和玻璃碎片会飞得到处都是."
	icon_state = "glass_brown"

/datum/glass_style/drinking_glass/tea
	required_drink_type = /datum/reagent/consumable/tea
	name = "glass of tea"
	desc = "从这里喝似乎不太对劲."
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
	desc = "一杯烈酒,这可不便宜."
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "hoticecoffee"

/datum/glass_style/drinking_glass/icetea
	required_drink_type = /datum/reagent/consumable/tea/icetea
	name = "iced tea"
	desc = "全天然,富含抗氧化剂的味觉盛宴."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "icedteaglass"

/datum/glass_style/drinking_glass/soy_latte
	required_drink_type = /datum/reagent/consumable/coffee/soy_latte
	name = "soy latte"
	desc = "阅读时来一杯清爽的好饮料."
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "soy_latte"

/datum/glass_style/drinking_glass/cafe_latte
	required_drink_type = /datum/reagent/consumable/coffee/cafe_latte
	name = "cafe latte"
	desc = "阅读时来一杯上好的烈性清爽饮料."
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "cafe_latte"

/datum/glass_style/drinking_glass/pumpkin_latte
	required_drink_type = /datum/reagent/consumable/pumpkin_latte
	name = "pumpkin latte"
	desc = "咖啡和南瓜汁的混合."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "pumpkin_latte"

/datum/glass_style/has_foodtype/drinking_glass/hot_coco
	required_drink_type = /datum/reagent/consumable/hot_coco
	name = "glass of hot coco"
	desc = "最爱的冬日饮品,让你暖起来."
	icon_state = "chocolateglass"
	drink_type = SUGAR | DAIRY

/datum/glass_style/drinking_glass/italian_coco
	required_drink_type = /datum/reagent/consumable/italian_coco
	name = "glass of italian coco"
	desc = "经典冬日饮品的改良版,专为取悦你而制."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "italiancoco"

/datum/glass_style/drinking_glass/mushroom_tea
	required_drink_type = /datum/reagent/consumable/mushroom_tea
	name = "glass of mushroom tea"
	desc = "作为饮料来说咸得奇怪."
	icon_state = "mushroom_tea_glass"

/datum/glass_style/drinking_glass/t_letter
	required_drink_type = /datum/reagent/consumable/t_letter
	name = "glass of T"
	desc = "第20号."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "tletter"
