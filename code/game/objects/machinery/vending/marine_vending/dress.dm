/obj/machinery/vending/dress_supply
	name = "\improper 泰拉政府科技礼服贩卖机"
	desc = "一个自动化衣架,连接着海量礼服储备."
	icon_state = "marineuniform"
	icon_vend = "marineuniform_vend"
	icon_deny = "marineuniform"
	req_one_access = list(ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_PREP, ACCESS_MARINE_CARGO)
	product_ads = "嘿!你!别再像个乌龟了,开始像个真正的陆战队员吧!;白色礼服,刚下熨衣板!;能穿着装甲杀敌,何不穿着时尚杀敌?;这些制服笔挺得光看着就能割伤自己!"
	wrenchable = FALSE
	isshared = TRUE
	products = list(
		/obj/effect/vendor_bundle/white_dress = -1,
		/obj/item/clothing/under/marine/whites = -1,
		/obj/item/clothing/suit/white_dress_jacket = -1,
		/obj/item/clothing/head/white_dress = -1,
		/obj/item/clothing/shoes/white = -1,
		/obj/item/clothing/gloves/white = -1,
		/obj/effect/vendor_bundle/service_uniform = -1,
		/obj/item/clothing/under/marine/service = -1,
		/obj/item/clothing/head/garrisoncap = -1,
		/obj/item/clothing/head/servicecap = -1,
		/obj/item/clothing/under/marine/black_suit = -1,
	)

/obj/machinery/vending/dress_supply/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
