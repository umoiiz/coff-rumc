/obj/item/stack/sheet/animalhide/human
	name = "人皮"
	desc = "人类养殖的副产品."
	singular_name = "human skin piece"
	icon_state = "sheet-hide"

/obj/item/stack/sheet/animalhide/corgi
	name = "柯基皮"
	desc = "柯基养殖的副产品."
	singular_name = "corgi hide piece"
	icon_state = "sheet-corgi"

/obj/item/stack/sheet/animalhide/cat
	name = "猫皮"
	desc = "猫养殖的副产品."
	singular_name = "cat hide piece"
	icon_state = "sheet-cat"

/obj/item/stack/sheet/animalhide/monkey
	name = "猴子皮"
	desc = "猴子养殖的副产品."
	singular_name = "monkey hide piece"
	icon_state = "sheet-monkey"

/obj/item/stack/sheet/animalhide/lizard
	name = "蜥蜴皮"
	desc = "嘶嘶嘶嘶..."
	singular_name = "lizard skin piece"
	icon_state = "sheet-lizard"

/obj/item/stack/sheet/animalhide/xeno
	name = "异形皮"
	desc = "一种可怕生物的皮."
	singular_name = "alien hide piece"
	icon_state = "sheet-xeno"

/obj/item/stack/sheet/animalhide/xeno/kinghide
	name = "王者皮"
	desc = "一种异常变种的皮,它破烂且腐烂."
	color = "#f7897c"

//don't see anywhere else to put these, maybe together they could be used to make the xenos suit?
/obj/item/stack/sheet/xenochitin
	name = "异形甲壳"
	desc = "一种可怕生物的皮的一部分."
	singular_name = "alien hide piece"
	icon = 'icons/mob/alien.dmi'
	icon_state = "chitin"

/obj/item/xenos_claw
	name = "异形爪"
	desc = "一种可怕生物的爪子."
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"

/obj/item/weed_extract
	name = "杂草提取物"
	desc = "一块黏滑的、略带紫色的杂草."
	icon = 'icons/mob/alien.dmi'
	icon_state = "weed_extract"

/obj/item/stack/sheet/hairlesshide
	name = "无毛皮"
	desc = "这块皮已被去除毛发,但仍需鞣制."
	singular_name = "hairless hide piece"
	icon_state = "sheet-hairlesshide"

/obj/item/stack/sheet/wetleather
	name = "湿皮革"
	desc = "这块皮革已被清洗,但仍需晾干."
	singular_name = "wet leather piece"
	icon_state = "sheet-wetleather"
	///How damp it is
	var/wetness = 30

/obj/item/stack/sheet/leather
	name = "皮革"
	desc = "怪物研磨的副产品."
	singular_name = "leather piece"
	icon_state = "sheet-leather"

//Step one - dehairing.
/obj/item/stack/sheet/animalhide/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(I.sharp)
		user.visible_message(span_notice("\the [user]开始剪掉\the [src]的毛发"), span_notice("你开始剪掉\the [src]的毛发"), "你听到刀子摩擦肉的声音")
		if(!do_after(user,50, NONE, src, BUSY_ICON_HOSTILE))
			return

		to_chat(user, span_notice("你剪掉了这只[singular_name]的毛发"))
		for(var/obj/item/stack/sheet/hairlesshide/HS in user.loc)
			if(HS.amount < 50)
				HS.amount++
				use(1)
				break
		var/obj/item/stack/sheet/hairlesshide/HS = new(user.loc)
		HS.amount = 1
		use(1)

//Step two - washing..... it's actually in washing machine code.

//Step three - drying
/obj/item/stack/sheet/wetleather/fire_act(burn_level, flame_color)
	. = ..()
	if(!wetness)
		return
	wetness--
	if(wetness < 0)
		return
	//Try locating an exisitng stack on the tile and add to there if possible
	for(var/obj/item/stack/sheet/leather/leather in loc)
		if(leather.amount < 50)
			leather.amount++
			use(1)
			wetness = initial(wetness)
			break
	//If it gets to here it means it did not find a suitable stack on the tile.
	var/obj/item/stack/sheet/leather/leather = new(loc)
	leather.amount = 1
	wetness = initial(wetness)
	use(1)
