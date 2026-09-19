/obj/item/stack/snow
	name = "雪堆"
	desc = "一些雪堆."
	singular_name = "layer"
	icon_state = "snow_stack"
	w_class = WEIGHT_CLASS_HUGE
	force = 2
	throw_speed = 5
	throw_range = 1
	max_amount = 25

/obj/item/stack/snow/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(!istype(I, /obj/item/tool/shovel))
		return

	var/obj/item/tool/shovel/ET = I
	if(ET.folded)
		to_chat(user, span_warning("你必须先展开你的铲子!"))
		return

	if(!isturf(loc))
		return

	if(ET.dirt_amt && ET.dirt_type == DIRT_TYPE_SNOW)
		if(amount < max_amount + ET.dirt_amt)
			amount += ET.dirt_amt
		else
			new /obj/item/stack/snow(loc, ET.dirt_amt)
		ET.dirt_amt = 0
		ET.update_icon()
		return

	to_chat(user, span_notice("你开始从[src]中取雪."))
	playsound(user.loc, 'sound/effects/thud.ogg', 40, 1, 6)

	if(!do_after(user, ET.shovelspeed, NONE, src, BUSY_ICON_BUILD))
		return

	var/transf_amt = ET.dirt_amt_per_dig
	if(amount < ET.dirt_amt_per_dig)
		transf_amt = amount

	ET.dirt_amt = transf_amt
	ET.dirt_type = DIRT_TYPE_SNOW
	to_chat(user, span_notice("你从[src]中取了雪."))
	ET.update_icon()
	use(transf_amt)
	return TRUE

/obj/item/stack/snow/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(!isopenturf(target))
		return
	if(user.do_actions)
		return
	var/turf/open/T = target
	if(T.get_dirt_type() == DIRT_TYPE_SNOW)
		var/turf/open/floor/plating/ground/snow/snowy_turf = T
		if(snowy_turf.slayer >= 3)
			to_chat(user, "这片地面已经铺满了雪.")
			return
		if(amount < 5)
			to_chat(user, span_warning("你需要5堆雪才能覆盖地面."))
			return
		to_chat(user, "你开始把一些雪放回地面.")
		if(!do_after(user, 15, IGNORE_HELD_ITEM, target, BUSY_ICON_BUILD))
			return
		if(snowy_turf.slayer >= 3)
			return
		to_chat(user, "你在地面上铺了一层新雪.")
		snowy_turf.slayer += 1
		snowy_turf.update_appearance()
		snowy_turf.update_sides()
		use(5)

/obj/item/stack/snow/attack_self(mob/user)
	var/turf/T = get_turf(user)
	if(T.get_dirt_type() != DIRT_TYPE_SNOW)
		to_chat(user, span_warning("你无法在这个位置建造雪地路障!"))
		return

	if(user.do_actions)
		return

	if(amount < 5)
		to_chat(user, span_warning("你需要5堆雪才能建造一个路障."))
		return

	//Using same safeties as other constructions
	for(var/obj/O in user.loc) //Objects, we don't care about mobs. Turfs are checked elsewhere
		if(!O.density)
			continue
		if(O.atom_flags & ON_BORDER)
			if(O.dir == user.dir)
				to_chat(user, span_warning("这个方向上已经有\a [O.name]了!"))
				return
		else
			to_chat(user, span_warning("你需要一个空旷无阻的区域来建造沙袋路障!"))
			return
			
	user.visible_message(span_notice("[user]开始组装一个雪地路障."),
	span_notice("你开始组装一个雪地路障."))
	if(!do_after(user, 20, NONE, src, BUSY_ICON_BUILD))
		return
	if(amount < 5)
		return
	for(var/obj/O in user.loc) //Objects, we don't care about mobs. Turfs are checked elsewhere
		if(O.density)
			if(!(O.atom_flags & ON_BORDER) || O.dir == user.dir)
				return
	var/obj/structure/barricade/snow/SB = new(user.loc, user.dir)
	user.visible_message(span_notice("[user]组装了一个雪地路障."),
	span_notice("你组装了一个雪地路障."))
	SB.setDir(user.dir)
	use(5)
