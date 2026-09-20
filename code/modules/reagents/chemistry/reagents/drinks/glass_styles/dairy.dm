// Dairy

/datum/glass_style/has_foodtype/drinking_glass/milk
	required_drink_type = /datum/reagent/consumable/milk
	name = "glass of milk"
	desc = "白色又营养的好东西!"
	icon_state = "glass_white"
	drink_type = DAIRY | BREAKFAST

/datum/glass_style/has_foodtype/juicebox/milk
	required_drink_type = /datum/reagent/consumable/milk
	name = "carton of milk"
	desc = "对成长中的太空探险者来说是极好的钙来源。"
	icon_state = "milkbox"
	drink_type = DAIRY | BREAKFAST

/datum/glass_style/has_foodtype/juicebox/chocolate_milk
	required_drink_type = /datum/reagent/consumable/milk/chocolate_milk
	name = "carton of chocolate milk"
	desc = "给酷小孩喝的牛奶!"
	icon_state = "chocolatebox"
	drink_type = SUGAR | DAIRY

/datum/glass_style/drinking_glass/soymilk
	required_drink_type = /datum/reagent/consumable/soymilk
	name = "glass of soy milk"
	desc = "白色又营养的豆奶好东西!"
	icon_state = "glass_white"

/datum/glass_style/drinking_glass/cream
	required_drink_type = /datum/reagent/consumable/cream
	name = "glass of cream"
	desc = "呃www..."
	icon_state = "glass_white"

/datum/glass_style/drinking_glass/coconut_milk
	required_drink_type = /datum/reagent/consumable/coconut_milk
	name = "glass of coconut milk"
	desc = "热带的精华,安全地装在一只杯子里。"
	icon = 'icons/obj/drinks/drinks.dmi'
	icon_state = "glass_white"
