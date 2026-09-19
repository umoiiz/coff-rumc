/obj/item/reagent_containers/food/snacks/frozen/
	icon = 'icons/obj/items/food/frozen_treats.dmi'

/obj/item/reagent_containers/food/snacks/frozen/icecreamsandwich
	name = "冰淇淋三明治"
	desc = "自带包装的便携冰淇淋."
	icon_state = "icecreamsandwich"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	tastes = list("ice cream" = 1)

/obj/item/reagent_containers/food/snacks/frozen/strawberryicecreamsandwich
	name = "草莓冰淇淋三明治"
	desc = "自带包装的草莓口味便携冰淇淋."
	icon_state = "strawberryicecreamsandwich"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("ice cream" = 2, "berry" = 2)


/obj/item/reagent_containers/food/snacks/frozen/spacefreezy
	name = "太空冰爽"
	desc = "太空中最好的冰淇淋."
	icon_state = "spacefreezy"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("blue cherries" = 2, "ice cream" = 2)

/obj/item/reagent_containers/food/snacks/frozen/sundae
	name = "圣代"
	desc = "一道经典的甜点."
	icon_state = "sundae"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/banana = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("ice cream" = 1, "banana" = 1)

/obj/item/reagent_containers/food/snacks/frozen/honkdae
	name = "小丑圣代"
	desc = "小丑最喜欢的甜点."
	icon_state = "honkdae"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/banana = 10, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("ice cream" = 1, "banana" = 1, "a bad joke" = 1)

/////////////
//SNOWCONES//
/////////////

/obj/item/reagent_containers/food/snacks/frozen/snowcones //We use this as a base for all other snowcones
	name = "无味刨冰"
	desc = "只是刨冰而已. 嚼起来仍然很有趣."
	icon_state = "flavorless_sc"
	list_reagents = list(/datum/reagent/water = 11) // We dont get food for water/juices
	tastes = list("ice" = 1, "water" = 1)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/lime
	name = "青柠刨冰"
	desc = "青柠糖浆淋在纸杯中的雪球上."
	icon_state = "lime_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/limejuice = 5, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "limes" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/lemon
	name = "柠檬刨冰"
	desc = "柠檬糖浆淋在纸杯中的雪球上."
	icon_state = "lemon_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/lemonjuice = 5, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "lemons" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/apple
	name = "苹果刨冰"
	desc = "苹果糖浆淋在纸杯中的雪球上."
	icon_state = "amber_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "apples" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/grape
	name = "葡萄刨冰"
	desc = "葡萄糖浆淋在纸杯中的雪球上."
	icon_state = "grape_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/grapejuice = 5, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "grape" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/orange
	name = "橙子刨冰"
	desc = "橙子糖浆淋在纸杯中的雪球上."
	icon_state = "orange_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/orangejuice = 5, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "orange" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/blue
	name = "蓝樱桃刨冰"
	desc = "蓝莓糖浆淋在纸杯里的雪球上,多么稀有!"
	icon_state = "blue_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "blue" = 5, "cherries" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/red
	name = "樱桃雪锥"
	desc = "樱桃糖浆淋在纸杯里的雪球上."
	icon_state = "red_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/cherryjelly = 5, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "red" = 5, "cherries" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/berry
	name = "浆果雪锥"
	desc = "浆果糖浆淋在纸杯里的雪球上."
	icon_state = "berry_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/berryjuice = 5, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "berries" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/fruitsalad
	name = "水果沙拉雪锥"
	desc = "柑橘糖浆的美妙混合淋在纸杯里的雪球上."
	icon_state = "fruitsalad_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/lemonjuice = 5, /datum/reagent/consumable/limejuice = 5, /datum/reagent/consumable/orangejuice = 5, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "oranges" = 5, "limes" = 5, "lemons" = 5, "citrus" = 5, "salad" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/pineapple
	name = "菠萝雪锥"
	desc = "菠萝糖浆淋在纸杯里的雪球上."
	icon_state = "pineapple_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "pineapples" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/mime
	name = "哑剧雪锥"
	desc = "..."
	icon_state = "mime_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nothing = 5, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "nothing" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/clown
	name = "小丑雪锥"
	desc = "欢笑淋在纸杯里的雪球上."
	icon_state = "clown_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/laughter = 5, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "jokes" = 5, "brainfreeze" = 5, "joy" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/soda
	name = "太空可乐雪锥"
	desc = "太空可乐淋在纸杯里的雪球上."
	icon_state = "soda_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/space_cola = 5, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "cola" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/spacemountainwind
	name = "太空山风雪锥"
	desc = "太空山风淋在纸杯里的雪球上."
	icon_state = "mountainwind_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/spacemountainwind = 5, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "mountain wind" = 5)


/obj/item/reagent_containers/food/snacks/frozen/snowcones/pwrgame
	name = "能量游戏雪锥"
	desc = "能量游戏汽水淋在纸杯里的雪球上."
	icon_state = "pwrgame_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "valid" = 5, "salt" = 5, "wats" = 5)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/honey
	name = "蜂蜜雪锥"
	desc = "蜂蜜淋在纸杯里的雪球上."
	icon_state = "amber_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/honey = 5, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "flowers" = 5, "sweetness" = 5, "wax" = 1)

/obj/item/reagent_containers/food/snacks/frozen/snowcones/rainbow
	name = "彩虹雪锥"
	desc = "纸杯里一个非常色彩缤纷的雪球."
	icon_state = "rainbow_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/laughter = 25, /datum/reagent/water = 11)
	tastes = list("ice" = 1, "water" = 1, "sunlight" = 5, "light" = 5, "slime" = 5, "paint" = 3, "clouds" = 3)

/obj/item/reagent_containers/food/snacks/frozen/popsicle
	name = "虫子冰棒"
	desc = "嗯,这不应该存在."
	icon_state = "popsicle_stick_s"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/milk = 2, /datum/reagent/consumable/vanilla = 2, /datum/reagent/consumable/sugar = 4)
	tastes = list("beetlejuice")

	var/overlay_state = "creamsicle_o" //This is the edible part of the popsicle.
	var/bite_states = 4 //This value value is used for correctly setting the bitesize to ensure every bite changes the sprite. Do not set to zero.


/obj/item/reagent_containers/food/snacks/frozen/popsicle/Initialize(mapload)
	. = ..()
	bitesize = reagents.total_volume / bite_states
	update_icon() // make sure the popsicle overlay is primed so it's not just a stick until you start eating it

/obj/item/reagent_containers/food/snacks/frozen/popsicle/update_overlays()
	. = ..()
	if(!bitecount)
		. += initial(overlay_state)
		return
	. += "[initial(overlay_state)]_[min(bitecount, 3)]"

/obj/item/reagent_containers/food/snacks/frozen/popsicle/proc/after_bite(mob/living/eater, mob/living/feeder, bitecount)
	src.bitecount = bitecount

/obj/item/popsicle_stick
	name = "冰棒棍"
	icon = 'icons/obj/items/food/frozen_treats.dmi'
	icon_state = "popsicle_stick"
	desc = "这根不起眼的小棍通常承载着冰冻美食,此刻它似乎从这种阿特拉斯式的负担中解脱了."

/obj/item/reagent_containers/food/snacks/frozen/popsicle/creamsicle_orange
	name = "橙子奶油冰棒"
	desc = "经典的橙子奶油冰棒.阳光般的冰冻美食."
	list_reagents = list(/datum/reagent/consumable/orangejuice = 4, /datum/reagent/consumable/milk = 2, /datum/reagent/consumable/vanilla = 2, /datum/reagent/consumable/sugar = 4)

/obj/item/reagent_containers/food/snacks/frozen/popsicle/creamsicle_berry
	name = "浆果奶油冰棒"
	desc = "鲜艳的浆果奶油冰棒.浆果味十足的冰冻美食."
	list_reagents = list(/datum/reagent/consumable/berryjuice = 4, /datum/reagent/consumable/milk = 2, /datum/reagent/consumable/vanilla = 2, /datum/reagent/consumable/sugar = 4)
	overlay_state = "creamsicle_m"

/obj/item/reagent_containers/food/snacks/frozen/popsicle/jumbo
	name = "巨型冰淇淋"
	desc = "一个覆盖着浓郁巧克力的奢华冰淇淋.它似乎比你记忆中要小."
	list_reagents = list(/datum/reagent/consumable/hot_coco = 4, /datum/reagent/consumable/milk = 2, /datum/reagent/consumable/vanilla = 3, /datum/reagent/consumable/sugar = 2)
	overlay_state = "jumbo"

/obj/item/reagent_containers/food/snacks/frozen/popsicle/nogga_black
	name = "诺加黑"
	desc = "一种咸味甘草冰淇淋,最近因所有争议记录都随时间遗失而被重新推出.那些不能记住过去的人注定要重蹈覆辙."
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/salt = 1,  /datum/reagent/consumable/milk = 2, /datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/sugar = 4)
	tastes = list("salty liquorice")
	overlay_state = "nogga_black"

/obj/item/reagent_containers/food/snacks/frozen/cornuto
	name = "角筒"
	icon_state = "cornuto"
	desc = "一个那不勒斯香草和巧克力冰淇淋蛋筒.它因撒有焦糖坚果而显得威风凛凛."
	tastes = list("chopped hazelnuts", "waffle")
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/hot_coco = 4, /datum/reagent/consumable/milk = 2, /datum/reagent/consumable/vanilla = 4, /datum/reagent/consumable/sugar = 2)
