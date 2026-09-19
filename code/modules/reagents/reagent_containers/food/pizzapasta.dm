/obj/item/reagent_containers/food/snacks/pizzapasta
	icon = 'icons/obj/items/food/pizzaspaghetti.dmi'
	slices_num = 6
	bitesize = 1
	filling_color = "#BAA14C"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta
	icon = 'icons/obj/items/food/pizzaspaghetti.dmi'
	bitesize = 1
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/margherita
	name = "玛格丽特披萨"
	desc = "披萨的黄金标准."
	icon_state = "pizzamargherita"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzapasta/margheritaslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 40, /datum/reagent/consumable/tomatojuice = 6)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/margheritaslice
	name = "玛格丽特披萨切片"
	desc = "一片经典披萨."
	icon_state = "pizzamargheritaslice"
	filling_color = "#BAA14C"
	bitesize = 2
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/meatpizza
	name = "肉披萨"
	desc = "加了肉配料的披萨."
	icon_state = "meatpizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzapasta/meatpizzaslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 50, /datum/reagent/consumable/tomatojuice = 6)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/meatpizzaslice
	name = "肉披萨切片"
	desc = "一片肉量十足的披萨."
	icon_state = "meatpizzaslice"
	filling_color = "#BAA14C"
	bitesize = 2
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/mushroompizza
	name = "蘑菇披萨"
	desc = "非常特别的披萨"
	icon_state = "mushroompizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzapasta/mushroompizzaslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 35)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushroom" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/mushroompizzaslice
	name = "蘑菇披萨切片"
	desc = "也许这是你人生中最后一片披萨."
	icon_state = "mushroompizzaslice"
	filling_color = "#BAA14C"
	bitesize = 2
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushroom" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/vegetablepizza
	name = "蔬菜披萨"
	desc = "制作这款披萨的过程中没有番茄智人受到伤害."
	icon_state = "vegetablepizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzapasta/vegetablepizzaslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 30, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/medicine/imidazoline = 12)
	tastes = list("crust" = 1, "tomato" = 2, "cheese" = 1, "carrot" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/vegetablepizzaslice
	name = "蔬菜披萨切片"
	desc = "所有不含绿色食材的披萨中最绿的一片披萨"
	icon_state = "vegetablepizzaslice"
	filling_color = "#BAA14C"
	bitesize = 2
	tastes = list("crust" = 1, "tomato" = 2, "cheese" = 1, "carrot" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/donkpocket
	name = "咚克口袋披萨"
	desc = "谁会觉得这是个好主意?"
	icon_state = "donkpocketpizza"
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/protein = 15, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/medicine/tricordrazine = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1, "laziness" = 1)
	slice_path = /obj/item/reagent_containers/food/snacks/pizzapasta/donkpocket

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/donkpocket/raw
	name = "生咚克口袋披萨"
	icon_state = "donkpocketpizza_raw"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzapasta/donkpocket

/obj/item/reagent_containers/food/snacks/pizzapasta/donkpocket
	name = "咚克口袋披萨切片"
	desc = "闻起来像咚克口袋."
	icon_state = "donkpocketpizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1, "laziness" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/dank
	name = "迷幻披萨"
	desc = "嬉皮士的首选披萨."
	icon_state = "dankpizza"
	list_reagents = list(/datum/reagent/consumable/nutriment = 25, /datum/reagent/consumable/doctor_delight = 5, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	slice_path = /obj/item/reagent_containers/food/snacks/pizzapasta/dank

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/dank/raw
	name = "生迷幻披萨"
	icon_state = "dankpizza_raw"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzapasta/dank

/obj/item/reagent_containers/food/snacks/pizzapasta/dank
	name = "迷幻披萨切片"
	desc = "太棒了,老兄..."
	icon_state = "dankpizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/sassysage
	name = "毒舌鼠尾草披萨"
	desc = "你几乎能尝到那股毒舌劲儿."
	icon_state = "sassysagepizza"
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/protein = 15, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	slice_path = /obj/item/reagent_containers/food/snacks/pizzapasta/sassysage

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/sassysage/raw
	name = "生毒舌鼠尾草披萨"
	icon_state = "sassysagepizza_raw"

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/pineapple
	name = "\improper 夏威夷披萨"
	desc = "爱因斯坦谜题的披萨版."
	icon_state = "pineapplepizza"
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/protein = 5, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pineapple" = 2, "ham" = 2)
	slice_path = /obj/item/reagent_containers/food/snacks/pizzapasta/pineapple

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/pineapple/raw
	name = "生夏威夷披萨"
	icon_state = "pineapplepizza_raw"
	slice_path = null

/obj/item/reagent_containers/food/snacks/pizzapasta/pineapple
	name = "\improper 夏威夷披萨片"
	desc = "一片美味的争议."
	icon_state = "pineapplepizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pineapple" = 2, "ham" = 2)

/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/ants
	name = "\improper 蚂蚁派对披萨"
	desc = "/// 里面全是虫子, 记得修复"
	icon_state = "antpizza"
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/tomatojuice = 10, /datum/reagent/consumable/nutriment/vitamin = 4, /datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "insects" = 1)
	slice_path = /obj/item/reagent_containers/food/snacks/pizzapasta/ants

/obj/item/reagent_containers/food/snacks/pizzapasta/ants
	name = "\improper 蚂蚁派对披萨片"
	desc = "做出完美披萨片的秘诀就是别放太多蚂蚁."
	icon_state = "antpizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "insects" = 1)

/obj/item/pizzabox
	name = "披萨盒"
	desc = "适合装披萨的盒子."
	icon = 'icons/obj/items/food/pizzaspaghetti.dmi'
	icon_state = "pizzabox1"
	/// Is the box open?
	var/open = 0
	/// Fancy mess on the lid
	var/ismessy = 0
	/// Content pizza
	var/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/pizza
	/// If the boxes are stacked, they come here
	var/list/boxes = list()
	/// The name of the pizza visible in description
	var/boxtag = ""

/obj/item/pizzabox/Initialize(mapload)
	. = ..()
	if(pizza)
		new pizza(src)

/obj/item/pizzabox/update_desc(updates)
	. = ..()
	if(open && pizza)
		desc = "A box suited for pizzas. It appears to have a [pizza.name] inside."
	else if(boxes.len > 0)
		desc = "A pile of boxes suited for pizzas. There appears to be [boxes.len + 1] boxes in the pile."

		var/obj/item/pizzabox/topbox = boxes[boxes.len]
		var/toptag = topbox.boxtag
		if(toptag != "")
			desc = "[desc] The box on top has a tag, it reads: '[toptag]'."
	else
		desc = "A box suited for pizzas."

		if(boxtag != "")
			desc = "[desc] The box has a tag, it reads: '[boxtag]'."

/obj/item/pizzabox/update_icon_state()
	. = ..()
	if(open)
		if(ismessy)
			icon_state = "pizzabox_messy"
		else
			icon_state = "pizzabox_open"
		return

	icon_state = "pizzabox[boxes.len+1]"

/obj/item/pizzabox/update_overlays()
	. = ..()
	if(open && pizza)
		var/image/pizzaimg = image("pizzaspaghetti.dmi", icon_state = pizza.icon_state)
		pizzaimg.pixel_z = -3
		. += pizzaimg
		return
	// Stupid code because byondcode sucks - imagine blaming the engine for you being bad at coding. TODO: clean this up
	var/doimgtag = 0
	if(boxes.len > 0)
		var/obj/item/pizzabox/topbox = boxes[boxes.len]
		if(topbox.boxtag != "")
			doimgtag = 1
	else
		if(boxtag != "")
			doimgtag = 1

	if(doimgtag)
		var/image/tagimg = image("pizzaspaghetti.dmi", icon_state = "pizzabox_tag")
		tagimg.pixel_z = boxes.len * 3
		. += tagimg

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/pizzabox/attack_hand(mob/living/user)
	if(open && pizza)
		user.put_in_hands(pizza)

		to_chat(user, span_warning("你把[src.pizza]从[src]里拿了出来."))
		src.pizza = null
		update_icon()
		return

	else if(boxes.len > 0)
		if(user.get_inactive_held_item() != src)
			return ..()

		var/obj/item/pizzabox/box = boxes[boxes.len]
		boxes -= box

		user.put_in_hands(box)
		to_chat(user, span_warning("你从手中取出了最上面的[src]."))
		box.update_icon()
		update_icon()
	else
		return ..()

/obj/item/pizzabox/attack_self( mob/user as mob )

	if(boxes.len > 0)
		return

	open = !open

	if(open && pizza)
		ismessy = 1

	update_icon()

/obj/item/pizzabox/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/pizzabox))
		var/obj/item/pizzabox/box = I

		if(box.open || open)
			to_chat(user, span_warning("先把[box]关上!"))
			return

		// Make a list of all boxes to be added
		var/list/boxestoadd = list()
		boxestoadd += box
		for(var/obj/item/pizzabox/i in box.boxes)
			boxestoadd += i

		if((length(boxes) + 1) + length(boxestoadd) > 5)
			to_chat(user, span_warning("堆得太高了!"))
			return

		user.transferItemToLoc(box, src)
		box.boxes = list()
		boxes.Add(boxestoadd)

		box.update_icon()
		update_icon()

		to_chat(user, span_warning("你把[box]放在了[src]上面!"))

	else if(istype(I, /obj/item/reagent_containers/food/snacks/sliceable/pizzapasta))
		if(!open)
			to_chat(user, span_warning("你试着把[I]从盖子塞进去, 但行不通!"))
			return

		user.transferItemToLoc(I, src)
		pizza = I

		update_icon()

		to_chat(user, span_warning("你把[I]放进了[src]里!"))

	else if(istype(I, /obj/item/tool/pen))
		if(open)
			return

		var/t = stripped_input(user, "Enter what you want to add to the tag:", "Write", "", 30)

		boxtag = "[boxtag][t]"

		update_icon()

/obj/item/pizzabox/margherita
	pizza = /obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/margherita
	boxtag = "Margherita Deluxe"

/obj/item/pizzabox/mushroom
	pizza = /obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/mushroompizza
	boxtag = "Mushroom Special"

/obj/item/pizzabox/meat
	pizza = /obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/meatpizza
	boxtag = "Meatlover's Supreme"

/obj/item/pizzabox/donkpocket
	pizza = /obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/donkpocket
	boxtag = "Bangin' Donk"

/obj/item/pizzabox/ants
	pizza = /obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/ants
	boxtag = "Anthill Deluxe"

/obj/item/pizzabox/dank
	pizza = /obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/dank
	boxtag = "Fresh Herbs"

/obj/item/pizzabox/vegetable
	pizza = /obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/vegetablepizza
	boxtag = "Gourmet Vegetable"

/obj/item/pizzabox/sassysage
	pizza = /obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/sassysage
	boxtag = "Sausage Lovers"

/obj/item/pizzabox/pineapple
	pizza = /obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/pineapple
	boxtag = "Honolulu Chew"

///spaghetti prototype used by all subtypes
/obj/item/reagent_containers/food/snacks/pizzapasta
	icon = 'icons/obj/items/food/pizzaspaghetti.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/raw
	name = "意大利面"
	desc = "这才叫好吃的意面!"
	icon_state = "spaghetti"
	tastes = list("pasta" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/boiledspaghetti
	name = "煮熟的意大利面"
	desc = "一盘素面条, 还需要更多配料."
	icon = 'icons/obj/items/food/pizzaspaghetti.dmi'
	icon_state = "spagettiboiled"
	trash = /obj/item/trash/plate
	filling_color = "#FCEE81"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bitesize = 2
	tastes = list("pasta" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/pastatomato
	name = "意大利面"
	desc = "意大利面和碎番茄. 就像你那有暴力倾向的父亲以前做的一样!"
	icon_state = "pastatomato"
	bitesize = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/tomatojuice = 10, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("pasta" = 1, "tomato" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/copypasta
	name = "复制粘贴面"
	desc = "你大概不该尝试这个, 你总听人说它有多糟糕..."
	icon_state = "copypasta"
	bitesize = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/tomatojuice = 20, /datum/reagent/consumable/nutriment/vitamin = 8)
	tastes = list("pasta" = 1, "tomato" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/meatballspaghetti
	name = "意大利面和肉丸"
	desc = "这才叫好吃的肉丸!"
	icon_state = "meatballspaghetti"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/protein = 10, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("pasta" = 1, "meat" = 1)
	trash = /obj/item/trash/plate
	filling_color = "#DE4545"
	bitesize = 3
	tastes = list("pasta" = 1, "tomato" = 1, "meat" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/spesslaw
	name = "律师面"
	desc = "律师的最爱."
	icon_state = "spesslaw"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/protein = 20, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("pasta" = 1, "meat" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/chowmein
	name = "炒面"
	desc = "面条和炒蔬菜的美味混合."
	icon_state = "chowmein"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("noodle" = 1, "tomato" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/beefnoodle
	name = "牛肉面"
	desc = "营养丰富, 有牛肉也有面条."
	icon_state = "beefnoodle"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("noodle" = 1, "meat" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/butternoodles
	name = "黄油面"
	desc = "裹着咸香黄油的面条. 简单顺滑, 但很美味."
	icon_state = "butternoodles"
	list_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("noodle" = 1, "butter" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/mac_n_cheese
	name = "芝士通心粉"
	desc = "用最上等的芝士和面包糠按正宗做法做的. 但它还是比不上即食咚带来的那种满足感."
	icon_state = "mac_n_cheese"
	list_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("cheese" = 1, "breadcrumbs" = 1, "pasta" = 1)

/obj/item/pizzabox/random
	var/list/pizza_choices = list(
		/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/margherita,
		/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/vegetablepizza,
		/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/mushroompizza,
		/obj/item/reagent_containers/food/snacks/sliceable/pizzapasta/meatpizza,
	)

/obj/item/pizzabox/random/Initialize(mapload)
	. = .. ()
	var/pizza_type = pick(pizza_choices)
	pizza = new pizza_type(src)
	boxtag = "Pizza Time"

/obj/item/reagent_containers/food/snacks/pizzapasta/spagetti
	name = "意大利面"
	desc = "一捆生的意大利面."
	icon_state = "spagetti"
	filling_color = "#EDDD00"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	bitesize = 1
	tastes = list("raw pasta" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/sassysage
	name = "俏皮香肠披萨片"
	desc = "美味又俏皮."
	icon_state = "sassysagepizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
