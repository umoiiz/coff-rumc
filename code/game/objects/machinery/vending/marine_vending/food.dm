/obj/machinery/vending/marineFood
	name = "\improper 陆战队食品饮料贩卖机"
	desc = "标准配给食品饮料贩卖机,包含标准军用食品和饮料."
	icon_state = "sustenance"
	icon_vend = "sustenance-vend"
	icon_deny = "sustenance-deny"
	wrenchable = FALSE
	isshared = TRUE
	product_ads = "标准配给陆战队食品!;对你有好处,而且不是世上最糟的东西.;他妈的吃就完了.;想要更好的伙食,你当初就该加入空军.;几口就1200卡路里!;加点塔巴斯科辣酱让它变好吃!;尝尝玉米面包.;尝尝披萨.;尝尝意面.;尝尝豆腐,软蛋.;尝尝猪肉.;9种口味的蛋白质!;你绝对猜不出神秘口味是什么!"
	products = list(
		/obj/item/reagent_containers/food/snacks/protein_pack = -1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal1 = -1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal2 = -1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal3 = -1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal4 = -1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal5 = -1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal6 = -1,
		/obj/item/storage/box/mre = -1,
		/obj/item/reagent_containers/food/drinks/flask/marine = -1,
	)
//Christmas inventory
/*
					/obj/item/reagent_containers/food/snacks/mre_pack/xmas1 = 25,
					/obj/item/reagent_containers/food/snacks/mre_pack/xmas2 = 25,
					/obj/item/reagent_containers/food/snacks/mre_pack/xmas3 = 25)*/

/obj/machinery/vending/marineFood/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE

/obj/machinery/vending/marineFood/som
	name = "\improper SOM食品饮料贩卖机"
	faction = FACTION_SOM
	products = list(
		/obj/item/reagent_containers/food/snacks/protein_pack/som = -1,
		/obj/item/storage/box/mre/som = -1,
		/obj/item/reagent_containers/food/drinks/flask/marine = -1,
	)
