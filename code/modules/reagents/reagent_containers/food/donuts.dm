/obj/item/reagent_containers/food/snacks/donut
	name = "甜甜圈"
	desc = "一种甜甜圈糕点,是地球上的常见零食.配咖啡很棒."
	icon = 'icons/obj/items/food/donuts.dmi'
	icon_state = "donut"
	filling_color = "#D9C386"
	var/overlay_state = "donut"
	tastes = list("donut" = 1)

/obj/item/reagent_containers/food/snacks/donut/normal
	name = "甜甜圈"
	desc = "一个甜甜圈.在边境很稀有,所以要珍惜."
	icon_state = "donut"
	tastes = list("donut" = 1)
	list_reagents = list (/datum/reagent/consumable/nutriment = 3)
	bitesize = 3

/obj/item/reagent_containers/food/snacks/donut/normal/Initialize(mapload)
	. = ..()
	if(prob(40))
		icon_state = "donut_pink"
		overlay_state = "fdonut"
		name = "frosted donut"
		desc = "A pink frosted donut. Even more rare on the frontier."
		reagents.add_reagent(/datum/reagent/consumable/sprinkles, 2)
	else if(prob(10))
		icon_state = "donut_homer"
		overlay_state = "fdonut"
		name = "frosted sprinkled donut"
		desc = "A pink frosted donut. The rarest on the frontier."
		reagents.add_reagent(/datum/reagent/consumable/sprinkles, 3)

/obj/item/reagent_containers/food/snacks/donut/chaos
	name = "混沌甜甜圈"
	desc = "就像生活,它的味道从不完全相同."
	icon_state = "donut_chaos"
	filling_color = "#ED11E6"
	tastes = list("donut" = 3, "chaos" = 1)
	list_reagents = list (/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sprinkles = 1)
	bitesize = 10


/obj/item/reagent_containers/food/snacks/donut/chaos/Initialize(mapload)
	. = ..()
	var/chaosselect = pick(1,2,3,4,5,6,7,8,9)
	switch(chaosselect)
		if(1)
			reagents.add_reagent(/datum/reagent/consumable/nutriment, 3)
		if(2)
			reagents.add_reagent(/datum/reagent/consumable/capsaicin, 3)
		if(3)
			reagents.add_reagent(/datum/reagent/consumable/frostoil, 3)
		if(4)
			reagents.add_reagent(/datum/reagent/consumable/sprinkles, 3)
		if(5)
			reagents.add_reagent(/datum/reagent/toxin/phoron, 3)
		if(6)
			reagents.add_reagent(/datum/reagent/consumable/coco, 3)
		if(7)
			reagents.add_reagent(/datum/reagent/consumable/banana, 3)
		if(8)
			reagents.add_reagent(/datum/reagent/consumable/berryjuice, 3)
		if(9)
			reagents.add_reagent(/datum/reagent/medicine/tricordrazine, 3)
	if(prob(30))
		icon_state = "donut2"
		overlay_state = "fdonut2"
		name = "Frosted Chaos Donut"
		reagents.add_reagent(/datum/reagent/consumable/sprinkles, 2)


/obj/item/reagent_containers/food/snacks/donut/jelly
	name = "果酱甜甜圈"
	desc = "你果酱了吗?"
	icon_state = "jelly"
	filling_color = "#ED1169"
	tastes = list("jelly" = 1, "donut" = 3)
	bitesize = 5
	list_reagents = list (/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/berryjuice = 5)


/obj/item/reagent_containers/food/snacks/donut/jelly/Initialize(mapload)
	. = ..()
	if(prob(30))
		icon_state = "jelly_pink"
		overlay_state = "fdonut2"
		name = "Frosted Jelly Donut"
		reagents.add_reagent(/datum/reagent/consumable/sprinkles, 2)

/obj/item/reagent_containers/food/snacks/donut/cherryjelly
	name = "果酱甜甜圈"
	desc = "你果酱了吗?"
	icon_state = "jelly_pink"
	filling_color = "#ED1169"
	list_reagents = list (/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/cherryjelly = 5)


/obj/item/reagent_containers/food/snacks/donut/cherryjelly/Initialize(mapload)
	. = ..()
	if(prob(30))
		icon_state = "jelly_pink"
		overlay_state = "box-donut2"
		name = "Frosted Jelly Donut"
		reagents.add_reagent(/datum/reagent/consumable/sprinkles, 2)

/obj/item/reagent_containers/food/snacks/donut/meat
	name = "肉甜甜圈"
	desc = "尝起来和看起来一样恶心."
	icon_state = "donut_meat"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 3, /datum/reagent/consumable/ketchup = 3)
	tastes = list("meat" = 1, "grease" = 3)

/obj/item/reagent_containers/food/snacks/donut/berry
	name = "粉色甜甜圈"
	desc = "配大豆拿铁很棒."
	icon_state = "donut_pink"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/berryjuice = 3, /datum/reagent/consumable/sprinkles = 1) //Extra sprinkles to reward frosting

/obj/item/reagent_containers/food/snacks/donut/trumpet
	name = "太空人甜甜圈"
	desc = "配一烧杯冷malk很棒."
	icon_state = "donut_purple"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sprinkles = 1)
	tastes = list("donut" = 3, "violets" = 1)

/obj/item/reagent_containers/food/snacks/donut/apple
	name = "苹果甜甜圈"
	desc = "配一小杯肉桂利口酒很棒."
	icon_state = "donut_green"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sprinkles = 1)
	tastes = list("donut" = 3, "green apples" = 1)

/obj/item/reagent_containers/food/snacks/donut/caramel
	name = "焦糖甜甜圈"
	desc = "配一大杯热可可很棒."
	icon_state = "donut_beige"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/caramel = 3, /datum/reagent/consumable/sprinkles = 1)
	tastes = list("donut" = 3, "buttery sweetness" = 1)

/obj/item/reagent_containers/food/snacks/donut/choco
	name = "巧克力甜甜圈"
	desc = "配一杯温牛奶很棒."
	icon_state = "donut_choc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/hot_coco = 3, /datum/reagent/consumable/sprinkles = 1) //the coco reagent is just bitter.
	tastes = list("donut" = 4, "bitterness" = 1)

/obj/item/reagent_containers/food/snacks/donut/choco/Initialize(mapload)
	. = ..()
	if(prob(40))
		icon_state = "donut_choc_sprinkles"
		overlay_state = "fdonut"
		name = "frosted donut"
		desc = "A chocolate frosted donut. Goes great with hot chocolate."
		reagents.add_reagent(/datum/reagent/consumable/sprinkles, 2)

/obj/item/reagent_containers/food/snacks/donut/blumpkin
	name = "blumpkin甜甜圈"
	desc = "配一大杯舒缓的醉人blumpkin很棒."
	icon_state = "donut_blue"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sprinkles = 1)
	tastes = list("donut" = 2, "blumpkin" = 1)

/obj/item/reagent_containers/food/snacks/donut/bungo
	name = "bungo甜甜圈"
	desc = "配一梅森罐嬉皮士之乐很棒."
	icon_state = "donut_yellow"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sprinkles = 1)
	tastes = list("donut" = 3, "tropical sweetness" = 1)

/obj/item/reagent_containers/food/snacks/donut/matcha
	name = "抹茶甜甜圈"
	desc = "配一杯茶很棒."
	icon_state = "donut_olive"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/poisonberryjuice = 3, /datum/reagent/consumable/sprinkles = 1)
	tastes = list("donut" = 3, "matcha" = 1)

/obj/item/reagent_containers/food/snacks/donut/laugh
	name = "甜豌豆甜甜圈"
	desc = "配一瓶Bastion Burbon很棒!"
	icon_state = "donut_laugh"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/laughter = 3)
	tastes = list("donut" = 3, "fizzy tutti frutti" = 1,)

/obj/item/reagent_containers/food/snacks/donut/jelly/trumpet
	name = "太空人果酱甜甜圈"
	desc = "配一烧杯冷malk很棒."
	icon_state = "jelly_purple"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("jelly" = 1, "donut" = 3, "violets" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/apple
	name = "苹果果酱甜甜圈"
	desc = "配一小杯肉桂利口酒很棒."
	icon_state = "jelly_green"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/caramel
	name = "焦糖果酱甜甜圈"
	desc = "配一大杯热可可很棒."
	icon_state = "jelly_beige"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/caramel = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("jelly" = 1, "donut" = 3, "buttery sweetness" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/choco
	name = "巧克力果酱甜甜圈"
	desc = "配一杯温牛奶很棒."
	icon_state = "jelly_choc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/hot_coco = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1) //the coco reagent is just bitter.
	tastes = list("jelly" = 1, "donut" = 4, "bitterness" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/blumpkin
	name = "blumpkin果酱甜甜圈"
	desc = "配一大杯舒缓的醉人blumpkin很棒."
	icon_state = "jelly_blue"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("jelly" = 1, "donut" = 2, "blumpkin" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/bungo
	name = "bungo果酱甜甜圈"
	desc = "配一梅森罐嬉皮士之乐很棒."
	icon_state = "jelly_yellow"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("jelly" = 1, "donut" = 3, "tropical sweetness" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/matcha
	name = "抹茶果酱甜甜圈"
	desc = "配一杯茶很棒."
	icon_state = "jelly_olive"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/poisonberryjuice = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("jelly" = 1, "donut" = 3, "matcha" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/laugh
	name = "甜豌豆果酱甜甜圈"
	desc = "配一瓶Bastion Burbon很棒!"
	icon_state = "jelly_laugh"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/laughter = 3)
	tastes = list("jelly" = 3, "donut" = 1, "fizzy tutti frutti" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly
	name = "果冻甜甜圈"
	desc = "你果冻吗?"
	list_reagents = list(/datum/reagent/toxin/phoron = 3)

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/plain
	icon_state = "jelly"

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/berry
	name = "粉色果冻甜甜圈"
	desc = "搭配一杯豆奶拿铁简直绝配."
	icon_state = "jelly_pink"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/berryjuice = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1) //Extra sprinkles to reward frosting

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/trumpet
	name = "太空人的果冻甜甜圈"
	desc = "搭配一烧杯冰镇马尔克简直绝配."
	icon_state = "jelly_purple"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("jelly" = 1, "donut" = 3, "violets" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/apple
	name = "苹果果冻甜甜圈"
	desc = "搭配一小杯肉桂杜松子酒简直绝配."
	icon_state = "jelly_green"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("jelly" = 1, "donut" = 3, "green apples" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/caramel
	name = "焦糖果冻甜甜圈"
	desc = "搭配一大杯热可可简直绝配."
	icon_state = "jelly_beige"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/caramel = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("jelly" = 1, "donut" = 3, "buttery sweetness" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/choco
	name = "巧克力果冻甜甜圈"
	desc = "搭配一杯温牛奶简直绝配."
	icon_state = "jelly_choc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/hot_coco = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1) //the coco reagent is just bitter.
	tastes = list("jelly" = 1, "donut" = 4, "bitterness" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/blumpkin
	name = "南瓜果冻甜甜圈"
	desc = "搭配一大杯舒缓醉人的南瓜酒简直绝配."
	icon_state = "jelly_blue"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("jelly" = 1, "donut" = 2, "blumpkin" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/bungo
	name = "邦戈果冻甜甜圈"
	desc = "搭配一罐嬉皮士之乐简直绝配."
	icon_state = "jelly_yellow"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("jelly" = 1, "donut" = 3, "tropical sweetness" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/matcha
	name = "抹茶果冻甜甜圈"
	desc = "搭配一杯茶简直绝配."
	icon_state = "jelly_olive"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/poisonberryjuice = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("jelly" = 1, "donut" = 3, "matcha" = 1)

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/laugh
	name = "香豌豆果冻甜甜圈"
	desc = "搭配一瓶堡垒波本简直绝配!"
	icon_state = "jelly_laugh"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/laughter = 3)
	tastes = list("jelly" = 3, "donut" = 1, "fizzy tutti frutti" = 1)
