/obj/item/stack/flag
	name = "旗帜"
	desc = "一些色彩鲜艳的旗帜."
	singular_name = "flag"
	amount = 10
	max_amount = 10
	icon = 'icons/obj/mining.dmi'
	var/upright = 0
	var/base_state

/obj/item/stack/flag/Initialize(mapload)
	. = ..()
	base_state = icon_state

/obj/item/stack/flag/red
	name = "红旗"
	singular_name = "red flag"
	icon_state = "redflag"

/obj/item/stack/flag/yellow
	name = "黄色旗帜"
	singular_name = "yellow flag"
	icon_state = "yellowflag"

/obj/item/stack/flag/green
	name = "绿色旗帜"
	singular_name = "green flag"
	icon_state = "greenflag"

/obj/item/stack/flag/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(upright && istype(I, type))
		return attack_hand(user)

/obj/item/stack/flag/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(upright)
		upright = 0
		icon_state = base_state
		anchored = FALSE
		visible_message("<b>[user]</b>击倒了[src].")

/obj/item/stack/flag/attack_self(mob/user as mob)
	var/obj/item/stack/flag/F = locate() in get_turf(src)

	var/turf/T = get_turf(src)
	if(!T)
		to_chat(user, "旗帜在这种地形上立不起来.")
		return

	if(F?.upright)
		to_chat(user, "这里已经有一面旗帜了.")
		return

	var/obj/item/stack/flag/newflag = new type(T)
	newflag.amount = 1
	newflag.upright = 1
	anchored = TRUE
	newflag.name = newflag.singular_name
	newflag.icon_state = "[newflag.base_state]_open"
	newflag.visible_message("<b>[user]</b>将[newflag]牢牢插在地上.")
	use(1)
