/obj/item/reagent_containers/food/snacks/sandwiches
	icon = 'icons/obj/items/food/bread.dmi'

/obj/item/reagent_containers/food/snacks/sandwiches/breadslice/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/shard) || istype(I, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/sandwiches/csandwich/S = new(loc)
		S.attackby(I, user, params)
		qdel(src)

/obj/item/reagent_containers/food/snacks/sandwiches/grilled_cheese_sandwich
	name = "烤芝士三明治"
	desc = "温暖拉丝的三明治, 配番茄汤再合适不过了."
	icon_state = "toastedsandwich"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/protein = 5, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/carbon = 4)
	tastes = list("toast" = 2, "cheese" = 3, "butter" = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/cheese_sandwich
	name = "芝士三明治"
	desc = "温暖日子里的小点心. ...但要是烤一下呢?"
	icon_state = "sandwich"
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/protein = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("bread" = 1, "cheese" = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/jellysandwich
	name = "果酱三明治"
	desc = "真希望你能有点花生酱来配这个..."
	icon_state = "jellysandwich"
	tastes = list("bread" = 1, "jelly" = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/jellysandwich/cherry
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/cherryjelly = 8, /datum/reagent/consumable/nutriment/vitamin = 4)

/obj/item/reagent_containers/food/snacks/sandwiches/notasandwich
	name = "不是三明治"
	desc = "这东西好像有点不对劲, 你说不上来是什么. 也许是他的胡子."
	icon_state = "notasandwich"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 10)
	tastes = list("nothing suspicious" = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/jelliedtoast
	name = "果酱吐司"
	desc = "一片涂满美味果酱的吐司."
	icon_state = "jellytoast"
	tastes = list("toast" = 1, "jelly" = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/blt
	name = "\improper 培根生菜番茄三明治"
	desc = "经典的培根, 生菜和番茄三明治."
	icon_state = "blt"
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/protein = 5, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("bacon" = 3, "lettuce" = 2, "tomato" = 2, "bread" = 2)

/obj/item/reagent_containers/food/snacks/sandwiches/twobread
	name = "两片面包"
	desc = "这看起来苦得厉害."
	icon_state = "twobread"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("bread" = 2)

/obj/item/reagent_containers/food/snacks/sandwiches/jelliedtoast/cherry
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/cherryjelly = 8, /datum/reagent/consumable/nutriment/vitamin = 4)

/obj/item/reagent_containers/food/snacks/sandwiches/butteredtoast
	name = "黄油吐司"
	desc = "轻轻涂在一片吐司上的黄油."
	icon = 'icons/obj/items/food/bread.dmi'
	icon_state = "butteredtoast"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("butter" = 1, "toast" = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/csandwich
	name = "三明治"
	desc = "自切片面包以来最棒的东西."

	icon_state = "breadslice"
	trash = /obj/item/trash/plate
	bitesize = 2
	var/list/ingredients = list()

/obj/item/reagent_containers/food/snacks/sandwiches/csandwich/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	var/sandwich_limit = 4
	for(var/obj/item/reagent_containers/food/snacks/sandwiches/breadslice/B in ingredients)
		sandwich_limit += 4

	if(length(contents) > sandwich_limit)
		to_chat(user, span_warning("如果你再往\the [src]上放任何东西,它就要塌了."))

	else if(istype(I, /obj/item/shard))
		to_chat(user, span_notice("你把[I]藏在\the [src]里."))
		user.transferItemToLoc(I, src)
		update()

	else if(istype(I, /obj/item/reagent_containers/food/snacks))
		to_chat(user, span_notice("你把[I]铺在\the [src]上."))
		var/obj/item/reagent_containers/F = I
		F.reagents.trans_to(src, F.reagents.total_volume)
		user.transferItemToLoc(I, src)
		ingredients += I
		update()

/obj/item/reagent_containers/food/snacks/sandwiches/csandwich/proc/update()
	var/fullname = "" //We need to build this from the contents of the var.
	var/i = 0

	overlays.Cut()

	for(var/obj/item/reagent_containers/food/snacks/sandwiches/O in ingredients)

		i++
		if(i == 1)
			fullname += "[O.name]"
		else if(i == length(ingredients))
			fullname += " and [O.name]"
		else
			fullname += ", [O.name]"

		var/image/I = new(src.icon, "breadslice_filling")
		I.color = O.filling_color
		I.pixel_x = pick(list(-1,0,1))
		I.pixel_y = (i*2)+1
		overlays += I

	var/image/T = new(src.icon, "breadslice")
	T.pixel_x = pick(list(-1,0,1))
	T.pixel_y = (length(ingredients) * 2)+1
	overlays += T

	name = lowertext("[fullname] sandwich")
	if(length(name) > 80) name = "[pick(list("absurd","colossal","enormous","ridiculous"))] sandwich"
	w_class = CEILING(clamp((length(ingredients) * 0.5),1,3),1)

/obj/item/reagent_containers/food/snacks/sandwiches/csandwich/Destroy()
	for(var/obj/item/O in ingredients)
		qdel(O)
	. = ..()

/obj/item/reagent_containers/food/snacks/sandwiches/csandwich/examine(mob/user)
	. = ..()
	var/obj/item/O = pick(contents)
	. += span_notice("你觉得你能在里面看到[O].")

/obj/item/reagent_containers/food/snacks/sandwiches/csandwich/attack(mob/M as mob, mob/user as mob, def_zone)

	var/obj/item/shard
	for(var/obj/item/O in contents)
		if(istype(O,/obj/item/shard))
			shard = O
			break

	var/mob/living/H
	if(istype(M,/mob/living))
		H = M

	if(H && shard && M == user) //This needs a check for feeding the food to other people, but that could be abusable.
		to_chat(H, span_warning("你的嘴被三明治里的[shard.name]划伤了!"))
		H.adjust_brute_loss(5) //TODO: Target head if human.
	return ..()

/obj/item/reagent_containers/food/snacks/sandwiches/sandwich
	name = "三明治"
	desc = "肉、奶酪、面包和几片生菜组成的伟大杰作!亚瑟·登特会为你骄傲的."
	icon_state = "sandwich"
	trash = /obj/item/trash/plate
	filling_color = "#D9BE29"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	bitesize = 2
	tastes = list("meat" = 2, "cheese" = 1, "bread" = 2, "lettuce" = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/toastedsandwich
	name = "烤三明治"
	desc = "要是你还有根胡椒棒就好了."
	icon_state = "toastedsandwich"
	trash = /obj/item/trash/plate
	filling_color = "#D9BE29"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/carbon = 2)
	bitesize = 2
	tastes = list("toast" = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/toastedsandwich
	name = "烤三明治"
	desc = "要是你还有根胡椒棒就好了."
	icon_state = "toastedsandwich"
	trash = /obj/item/trash/plate
	filling_color = "#D9BE29"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/carbon = 2)
	bitesize = 2
	tastes = list("toast" = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/plain
	name = "普通汉堡"
	icon = 'icons/obj/items/food/burgers.dmi'
	icon_state = "hburger"
	desc = "每顿营养早餐的基石."
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/rib
	name = "麦乐肋排堡"
	desc = "一种难以捉摸的肋排形汉堡,在整个银河系都限量供应.没你记忆中那么好吃了."
	icon = 'icons/obj/items/food/burgers.dmi'
	icon_state = "mcrib"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 7, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("bun" = 2, "pork patty" = 4)

/obj/item/reagent_containers/food/snacks/sandwiches/mcguffin
	name = "麦满分"
	desc = "一种廉价油腻的班尼迪克蛋仿制品."
	icon = 'icons/obj/items/food/burgers.dmi'
	icon_state = "mcguffin"
	tastes = list("muffin" = 2, "bacon" = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 7, /datum/reagent/consumable/nutriment/vitamin = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/bread
	name = "面包"
	desc = "一些普通的老式地球面包."
	icon_state = "bread"
	slice_path = /obj/item/reagent_containers/food/snacks/sandwiches/breadslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	filling_color = "#FFE396"
	tastes = list("bread" = 10)

/obj/item/reagent_containers/food/snacks/sandwiches/breadslice
	name = "面包片"
	desc = "一片家的味道."
	icon_state = "breadslice"
	trash = /obj/item/trash/plate
	filling_color = "#D27332"
	bitesize = 2
	tastes = list("bread" = 10)

/obj/item/reagent_containers/food/snacks/sandwiches/creamcheesebread
	name = "奶油芝士面包"
	desc = "好吃好吃好吃!"
	icon_state = "creamcheesebread"
	slice_path = /obj/item/reagent_containers/food/snacks/sandwiches/creamcheesebreadslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	filling_color = "#FFF896"
	tastes = list("bread" = 10, "cheese" = 10)

/obj/item/reagent_containers/food/snacks/sandwiches/creamcheesebreadslice
	name = "奶油芝士面包片"
	desc = "好吃的一片!"
	icon_state = "creamcheesebreadslice"
	trash = /obj/item/trash/plate
	filling_color = "#FFF896"
	bitesize = 2
	tastes = list("bread" = 10, "cheese" = 10)

/obj/item/reagent_containers/food/snacks/sandwiches/marinebread //meme bread for breadify smite
	name = "面包"
	desc = "一些普通的老式地球面包.周围弥漫着一股忏悔的气息."
	icon = 'icons/obj/items/food/bread.dmi'
	icon_state = "breadtg"
	list_reagents = list(/datum/reagent/consumable/nutriment = 60)
	filling_color = "#FFF896"
	bitesize = 2
	tastes = list("guilt" = 1, "salt" = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/Destroy() //delete the marine trapped inside, tasty!
	for(var/i in contents)
		qdel(i)
	return ..()

/obj/item/reagent_containers/food/snacks/sliceable/sandwiches/xenomeatbread
	name = "异形肉面包块"
	desc = "每位有自尊的雄辩绅士的烹饪基础.格外异端."
	icon = 'icons/obj/items/food/bread.dmi'
	icon_state = "xenomeatbread"
	slice_path = /obj/item/reagent_containers/food/snacks/sandwiches/xenomeatbreadslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	filling_color = "#8AFF75"
	tastes = list("bread" = 10, "acid" = 10)

/obj/item/reagent_containers/food/snacks/sandwiches/xenomeatbreadslice
	name = "异形肉面包片"
	desc = "一片美味的肉面包.格外异端."
	icon = 'icons/obj/items/food/bread.dmi'
	icon_state = "xenobreadslice"
	trash = /obj/item/trash/plate
	filling_color = "#8AFF75"
	bitesize = 2
	tastes = list("bread" = 10, "acid" = 10)

/obj/item/reagent_containers/food/snacks/sliceable/sandwiches/bananabread
	name = "香蕉坚果面包"
	desc = "一份天堂般管饱的享受."
	icon = 'icons/obj/items/food/bread.dmi'
	icon_state = "bananabread"
	slice_path = /obj/item/reagent_containers/food/snacks/sandwiches/bananabreadslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/banana = 20)
	filling_color = "#EDE5AD"
	tastes = list("bread" = 10) // bananjuice will also flavour

/obj/item/reagent_containers/food/snacks/sandwiches/bananabreadslice
	name = "香蕉坚果面包片"
	desc = "一片美味的香蕉面包."
	icon = 'icons/obj/items/food/bread.dmi'
	icon_state = "bananabreadslice"
	trash = /obj/item/trash/plate
	filling_color = "#EDE5AD"
	bitesize = 2
	tastes = list("bread" = 10)

/obj/item/reagent_containers/food/snacks/sliceable/sandwiches/meatbread
	name = "肉面包块"
	desc = "每位有自尊的雄辩/tg/绅士的烹饪基础."
	icon = 'icons/obj/items/food/bread.dmi'
	icon_state = "meatbread"
	slice_path = /obj/item/reagent_containers/food/snacks/sandwiches/meatbreadslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	filling_color = "#FF7575"
	tastes = list("bread" = 10, "meat" = 10)

/obj/item/reagent_containers/food/snacks/sandwiches/meatbreadslice
	name = "肉面包片"
	desc = "一片美味的肉面包."
	icon = 'icons/obj/items/food/bread.dmi'
	icon_state = "meatbreadslice"
	trash = /obj/item/trash/plate
	filling_color = "#FF7575"
	bitesize = 2
	tastes = list("bread" = 10, "meat" = 10)

/obj/item/reagent_containers/food/snacks/sliceable/sandwiches/tofubread
	name = "豆腐面包"
	desc = "像肉面包,但是给素食者的.不保证能给你超能力."
	icon = 'icons/obj/items/food/bread.dmi'
	icon_state = "tofubread"
	slice_path = /obj/item/reagent_containers/food/snacks/sandwiches/tofubreadslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	filling_color = "#F7FFE0"
	tastes = list("bread" = 10, "tofu" = 10)

/obj/item/reagent_containers/food/snacks/sandwiches/tofubreadslice
	name = "豆腐面包片"
	desc = "一片美味的豆腐面包."
	icon = 'icons/obj/items/food/bread.dmi'
	icon_state = "tofubreadslice"
	trash = /obj/item/trash/plate
	filling_color = "#F7FFE0"
	bitesize = 2
	tastes = list("bread" = 10, "tofu" = 10)

/obj/item/reagent_containers/food/snacks/sandwiches/emperor_roll
	name = "皇帝卷"
	desc = "帝国核心世界流行的三明治,通常为向皇室致敬而供应."
	icon_state = "emperor_roll"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/protein = 8, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("bread" = 1, "cheese" = 1, "liver" = 1, "caviar" = 1)

/obj/item/reagent_containers/food/snacks/sandwiches/honey_roll
	name = "蜂蜜甜卷"
	desc = "一种加了糖的根茎卷,配有切片水果."
	icon_state = "honey_roll"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 8, /datum/reagent/consumable/honey = 2)
	tastes = list("bread" = 1, "honey" = 1, "fruit" = 1)

//Bread
/obj/item/reagent_containers/food/snacks/sandwiches/corn
	name = "玉米面包"
	desc = "一些地道的乡下风味、狂野带劲、左轮手枪砰砰响、天哪耶哈的玉米面包."
	icon_state = "cornbread"
	list_reagents = list(/datum/reagent/consumable/nutriment = 18)
	tastes = list("cornbread" = 10)
	w_class = WEIGHT_CLASS_SMALL
	bitesize = 2

/obj/item/reagent_containers/food/snacks/sandwiches/corn
	name = "玉米面包片"
	desc = "一块酥脆的牛仔风味玉米面包.心满意足地享用吧."
	icon_state = "cornbread_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
