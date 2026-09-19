/obj/item/reagent_containers/food/snacks/tortilla
	name = "玉米饼"
	desc = "你所有墨西哥卷饼的基础."
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "tortilla"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("tortilla" = 1)
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/mexican
	icon = 'icons/obj/items/food/mexican.dmi'

/obj/item/reagent_containers/food/snacks/mexican/burrito
	name = "墨西哥卷饼"
	desc = "玉米饼包裹的美味."
	icon_state = "openburrito"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 4, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("torilla" = 2, "beans" = 3)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mexican/cheesyburrito
	name = "芝士墨西哥卷饼"
	desc = "这是一个填满芝士的墨西哥卷饼."
	icon_state = "cheesyburrito"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("torilla" = 2, "beans" = 3, "cheese" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mexican/carneburrito
	name = "烤牛肉墨西哥卷饼"
	desc = "肉食爱好者的最佳墨西哥卷饼."
	icon_state = "carneburrito"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("torilla" = 2, "meat" = 4)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mexican/fuegoburrito
	name = "火焰等离子墨西哥卷饼"
	desc = "一个超级辣的墨西哥卷饼."
	icon_state = "fuegoburrito"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/consumable/capsaicin = 5, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("torilla" = 2, "beans" = 3, "hot peppers" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mexican/nachos
	name = "玉米片"
	desc = "来自太空墨西哥的薯片."
	icon_state = "nachos"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("nachos" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mexican/cheesynachos
	name = "芝士玉米片"
	desc = "玉米片和融化芝士的美味组合."
	icon_state = "cheesynachos"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/protein = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("nachos" = 2, "cheese" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mexican/cubannachos
	name = "古巴玉米片"
	desc = "那可是些危险辣的玉米片."
	icon_state = "cubannachos"
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/capsaicin = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("nachos" = 2, "hot pepper" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mexican/taco
	name = "经典墨西哥煎饼"
	desc = "一个传统的墨西哥煎饼,有肉,芝士和生菜."
	icon_state = "taco"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("taco" = 4, "meat" = 2, "cheese" = 2, "lettuce" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mexican/taco/plain
	name = "原味墨西哥煎饼"
	desc = "一个传统的墨西哥煎饼,有肉和芝士,没有兔子食物."
	icon_state = "taco_plain"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("taco" = 4, "meat" = 2, "cheese" = 2)

/obj/item/reagent_containers/food/snacks/mexican/enchiladas
	name = "墨西哥辣酱卷饼"
	desc = "墨西哥万岁!"
	icon_state = "enchiladas"
	bitesize = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/protein = 7, /datum/reagent/consumable/capsaicin = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("hot peppers" = 1, "meat" = 3, "cheese" = 1, "sour cream" = 1)
	w_class = WEIGHT_CLASS_SMALL
