/obj/item/frame/table
	name = "桌子部件"
	desc = "一套桌子套件,包括一块大型平整金属桌面和四条桌腿.需要一些组装."
	gender = PLURAL
	icon = 'icons/obj/items/items.dmi'
	icon_state = "table_parts"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/engineering_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/engineering_right.dmi',
	)
	worn_icon_state = "table_parts"
	atom_flags = CONDUCT
	attack_verb = list("slams", "bashes", "batters", "bludgeons", "thrashes", "whacks")
	/// What type of table it creates when assembled
	var/table_type = /obj/structure/table
	/// What type of resource we drop on deconstruct
	var/deconstruct_type = /obj/item/stack/sheet/metal

/obj/item/frame/table/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	var/turf/table_turf = get_turf(src)
	if(istype(I, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = I
		if(!R.use(4))
			to_chat(user, span_warning("你至少需要四根金属棒来加固[src]."))
			return

		new /obj/item/frame/table/reinforced(table_turf)
		to_chat(user, span_notice("你加固了[src]."))
		user.temporarilyRemoveItemFromInventory(src)
		qdel(src)

	if(istype(I, /obj/item/stack/sheet/wood))
		var/obj/item/stack/sheet/wood/S = I

		if(!S.use(2))
			to_chat(user, span_warning("你至少需要两张木板来替换[src]的金属部件."))
			return

		new /obj/item/frame/table/wood(table_turf)
		new /obj/item/stack/sheet/metal(table_turf)
		to_chat(user, span_notice("你替换了[src]的金属部件."))
		user.temporarilyRemoveItemFromInventory(src)
		qdel(src)

/obj/item/frame/table/wrench_act(mob/living/user, obj/item/I)
	. = ..()

	if(!deconstruct_type)
		return
	new deconstruct_type(get_turf(src))
	qdel(src)

/obj/item/frame/table/attack_self(mob/user)
	if(locate(/obj/structure/table) in get_turf(user))
		to_chat(user, span_warning("这里已经建了另一张桌子了."))
		return
	if(istype(get_area(loc), /area/shuttle))  //HANGAR/SHUTTLE BUILDING
		to_chat(user, span_warning("不行.这片区域需要留给运输机."))
		return

	new table_type(user.loc)
	user.drop_held_item()
	qdel(src)

/obj/item/frame/table/nometal
	deconstruct_type = null

/*
* Mainship Table Parts
*/

/obj/item/frame/table/mainship
	table_type = /obj/structure/table/mainship

/obj/item/frame/table/mainship/nometal
	deconstruct_type = null
	table_type = /obj/structure/table/mainship/nometal

/*
* Reinforced Table Parts
*/

/obj/item/frame/table/reinforced
	name = "加固桌子部件"
	desc = "一套桌子套件,包括一块大型平整金属桌面和四条桌腿.这套套件带有侧板.需要一些组装."
	icon = 'icons/obj/items/items.dmi'
	icon_state = "reinf_tableparts"
	table_type = /obj/structure/table/reinforced

/*
* Wooden Table Parts
*/

/obj/item/frame/table/wood
	name = "木桌部件"
	desc = "一套桌子套件,包括一块大型平整木质桌面和四条桌腿.需要一些组装."
	icon_state = "wood_tableparts"
	atom_flags = null
	table_type = /obj/structure/table/wood
	deconstruct_type = /obj/item/stack/sheet/wood

/obj/item/frame/table/wood/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/stack/tile/carpet))
		var/obj/item/stack/tile/carpet/C = I
		if(!C.use(1))
			return

		to_chat(user, span_notice("你在[src]上铺了一层地毯."))
		new /obj/item/frame/table/gambling(get_turf(src))
		qdel(src)

/obj/item/frame/table/fancywood
	icon_state = "fwood_tableparts"

/obj/item/frame/table/rusticwood
	icon_state = "pwood_tableparts"

/*
* Gambling Table Parts
*/

/obj/item/frame/table/gambling
	name = "赌桌部件"
	desc = "一套桌子套件,包括一块大型平整木质和地毯桌面和四条桌腿.需要一些组装."
	icon_state = "gamble_tableparts"
	atom_flags = null
	table_type = /obj/structure/table/wood/gambling
	deconstruct_type = /obj/item/stack/sheet/wood

/obj/item/frame/table/gambling/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	to_chat(user, span_notice("你从[src]上撬出了地毯."))
	new /obj/item/stack/tile/carpet(loc)
	new /obj/item/frame/table/wood(loc)
	qdel(src)
