/*
* The 'fancy' path is for objects like donut boxes that show how many items are in the storage item on the sprite itself
* .. Sorry for the shitty path name, I couldnt think of a better one.
*
* WARNING: var/icon_type is used for both examine text and sprite name. Please look at the procs below and adjust your sprite names accordingly
*
* Contains:
*		Donut Box
*		Egg Box
*		Candle Box
*		Crayon Box
*		Cigarette Box
*		Vial Box
*/

/obj/item/storage/fancy
	icon = 'icons/obj/items/food/food.dmi'
	icon_state = "donutbox6"
	name = "甜甜圈盒"
	var/icon_type = "donut"
	var/spawn_type
	var/spawn_number

/obj/item/storage/fancy/Initialize(mapload, ...)
	. = ..()
	if(spawn_type)
		storage_datum.set_holdable(can_hold_list = list(spawn_type))
		for(var/i in 1 to spawn_number)
			new spawn_type(src)

/obj/item/storage/fancy/update_icon_state()
	. = ..()
	icon_state = "[icon_type]box[length(contents)]"

/obj/item/storage/fancy/examine(mob/user)
	. = ..()
	switch(length(contents))
		if(0)
			. += "There are no [icon_type]s left in the box."
		if(1)
			. += "There is one [icon_type] left in the box."
		if(2 to INFINITY)
			. += "There are [length(contents)] [icon_type]s in the box."

/*
* Egg Box
*/

/obj/item/storage/fancy/egg_box
	icon = 'icons/obj/items/food/packaged.dmi'
	icon_state = "eggbox"
	icon_type = "egg"
	name = "鸡蛋盒"
	spawn_type = /obj/item/reagent_containers/food/snacks/egg
	spawn_number = 12

/obj/item/storage/fancy/egg_box/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 12
	storage_datum.max_storage_space = 24

/*
* Candle Box
*/

/obj/item/storage/fancy/candle_box
	name = "蜡烛包"
	desc = "一包红色蜡烛."
	icon = 'icons/obj/items/candle.dmi'
	icon_state = "candlebox5"
	icon_type = "candle"
	worn_icon_state = "candlebox5"
	throwforce = 2
	equip_slot_flags = ITEM_SLOT_BELT
	spawn_type = /obj/item/tool/candle
	spawn_number = 5

/obj/item/storage/fancy/candle_box/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 5

/*
* Crayon Box
*/

/obj/item/storage/fancy/crayons
	name = "蜡笔盒"
	desc = "一盒蜡笔, 满足你所有绘制符文的需求."
	icon = 'icons/obj/items/crayons.dmi'
	icon_state = "crayonbox"
	w_class = WEIGHT_CLASS_SMALL
	icon_type = "crayon"

/obj/item/storage/fancy/crayons/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 6
	storage_datum.set_holdable(can_hold_list = list(/obj/item/toy/crayon))

/obj/item/storage/fancy/crayons/PopulateContents()
	new /obj/item/toy/crayon/red(src)
	new /obj/item/toy/crayon/orange(src)
	new /obj/item/toy/crayon/yellow(src)
	new /obj/item/toy/crayon/green(src)
	new /obj/item/toy/crayon/blue(src)
	new /obj/item/toy/crayon/purple(src)

/obj/item/storage/fancy/crayons/update_overlays()
	. = ..()
	. += image('icons/obj/items/crayons.dmi', "crayonbox")
	for(var/obj/item/toy/crayon/crayon in contents)
		. += image('icons/obj/items/crayons.dmi', crayon.colourName)

/obj/item/storage/fancy/crayons/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(!istype(I, /obj/item/toy/crayon))
		return
	var/obj/item/toy/crayon/C = I
	switch(C.colourName)
		if("mime")
			to_chat(user, "这支蜡笔太悲伤了, 无法被装进这个盒子里.")
		if("rainbow")
			to_chat(user, "这支蜡笔太强大了, 无法被装进这个盒子里.")

////////////
//CIG PACK//
////////////
/obj/item/storage/fancy/cigarettes
	name = "香烟包"
	desc = "最受欢迎的太空香烟品牌, 太空奥运会的赞助商."
	icon = 'icons/obj/items/cigarettes.dmi'
	icon_state = "cigpacket"
	worn_icon_state = "cigpacket"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 2
	equip_slot_flags = ITEM_SLOT_BELT
	icon_type = "cigarette"
	spawn_type = /obj/item/clothing/mask/cigarette
	spawn_number = 18

/obj/item/storage/fancy/cigarettes/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_storage_space = 18
	storage_datum.storage_slots = 18
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/clothing/mask/cigarette,
		/obj/item/tool/lighter,
	))

/obj/item/storage/fancy/cigarettes/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][length(contents)]"

/obj/item/storage/fancy/cigarettes/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M, /mob))
		return

	if(M == user && user.zone_selected == "mouth" && length(contents) > 0 && !user.wear_mask)
		var/obj/item/clothing/mask/cigarette/C = locate() in src
		if(C)
			storage_datum.remove_from_storage(C, get_turf(user), user)
			user.equip_to_slot_if_possible(C, SLOT_WEAR_MASK)
			to_chat(user, span_notice("你从烟盒中取出一支香烟."))
			update_icon()
		return
	return ..()

/obj/item/storage/fancy/chemrettes
	name = "Chemrette烟包"
	desc = "Terragov出品, 化学填充香烟. 现在带有额外口味!"
	icon = 'icons/obj/items/cigarettes.dmi'
	icon_state = "chempacketbox"
	worn_icon_state = "chempacketbox"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 2
	equip_slot_flags = ITEM_SLOT_BELT
	icon_type = "chempacket"

/obj/item/storage/fancy/chemrettes/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 18
	storage_datum.max_storage_space = 18
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/clothing/mask/cigarette,
		/obj/item/tool/lighter,
		/obj/item/storage/box/matches,
	))

/obj/item/storage/fancy/chemrettes/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/clothing/mask/cigarette/bica(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/mask/cigarette/kelo(src)
	for(var/i in 1 to 5)
		new /obj/item/clothing/mask/cigarette/tram(src)
	for(var/i in 1 to 5)
		new /obj/item/clothing/mask/cigarette/antitox(src)
	new /obj/item/clothing/mask/cigarette/emergency(src)
	new /obj/item/tool/lighter(src)

/obj/item/storage/fancy/chemrettes/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][length(contents)]"

/obj/item/storage/fancy/cigarettes/dromedaryco
	name = "\improper Nanotrasen Gold烟包"
	desc = "建设更美好的世界, 卷制更好的香烟. 这些高档香烟是Nanotrasen进军市场的产品. 背后有一支强大的法律团队支持."
	icon_state = "ntpacket"
	worn_icon_state = "ntpacket"

/obj/item/storage/fancy/cigarettes/luckystars
	name = "\improper Lucky Stars烟包"
	desc = "由合成舱培烟草制成的醇和混合烟. 其商业广告曲保证让你挥之不去."
	icon_state = "lspacket"
	worn_icon_state = "lspacket"

/obj/item/storage/fancy/cigarettes/kpack
	name = "\improper Koorlander Gold烟包"
	desc = "Koorlander, Gold: 3%烟草. 97%其他. 适合你想看起来酷, 而缓慢可怕死亡的风险并不真正构成因素的时候."
	icon_state = "kpacket"
	worn_icon_state = "kpacket"

/obj/item/storage/fancy/cigarettes/lady_finger
	name = "\improper ArctiCool薄荷烟包"
	desc = "一款入门级香烟品牌, 包装为亮蓝色. 适合你想闻起来像润喉糖和烟味的时候."
	icon_state = "acpacket"
	worn_icon_state = "acpacket"

/obj/item/storage/fancy/cigar
	name = "雪茄盒"
	desc = "一个用于在不抽时存放雪茄的盒子."
	icon_state = "cigarcase"
	worn_icon_state = "cigarcase"
	icon = 'icons/obj/items/cigarettes.dmi'
	w_class = WEIGHT_CLASS_TINY
	throwforce = 2
	equip_slot_flags = ITEM_SLOT_BELT
	spawn_type = /obj/item/clothing/mask/cigarette/cigar
	spawn_number = 7
	icon_type = "cigar"

/obj/item/storage/fancy/cigar/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 7

/obj/item/storage/fancy/cigar/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][length(contents)]"

/obj/item/storage/fancy/cigar/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M, /mob))
		return

	if(M == user && user.zone_selected == "mouth" && length(contents) > 0 && !user.wear_mask)
		var/obj/item/clothing/mask/cigarette/cigar/C = locate() in src
		if(C)
			storage_datum.remove_from_storage(C, get_turf(user), user)
			user.equip_to_slot_if_possible(C, SLOT_WEAR_MASK)
			to_chat(user, span_notice("你从盒中取出一支雪茄."))
			update_icon()
		return
	return ..()

/*
* Vial Box
*/

/obj/item/storage/fancy/vials
	icon = 'icons/obj/items/storage/vialbox.dmi'
	icon_state = "vialbox6"
	icon_type = "vial"
	name = "药瓶储存盒"
	spawn_type = /obj/item/reagent_containers/glass/beaker/vial
	spawn_number = 6

/obj/item/storage/fancy/vials/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 6

/obj/item/storage/fancy/vials/prison
	icon = 'icons/obj/machines/virology.dmi'
