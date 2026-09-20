//Flame thrower.
/obj/item/ammo_magazine/flamer_tank
	name = "燃烧器燃料罐"
	desc = "一个通常装有超浓稠凝固汽油的燃料罐,这是一种粘性可燃液体化学品,用于FL-240燃烧器单元。小心处理。"
	icon_state = "flametank"
	icon = 'icons/obj/items/ammo/flamer.dmi'
	max_rounds = 50 //Per turf.
	current_rounds = 50
	reload_delay = 2 SECONDS
	w_class = WEIGHT_CLASS_NORMAL //making sure you can't sneak this onto your belt.
	caliber = CALIBER_FUEL_THICK //Ultra Thick Napthal Fuel, from the lore book.
	magazine_flags = NONE
	icon_state_mini = "tank_light"

	default_ammo = /datum/ammo/flamethrower

	var/dispenser_type = /obj/structure/reagent_dispensers/fueltank

/obj/item/ammo_magazine/flamer_tank/mini
	name = "微型燃烧器燃料罐"
	desc = "一个通常装有超浓稠凝固汽油的燃料罐,这是一种粘性可燃液体化学品,用于下挂式燃烧器单元。小心处理。"
	icon_state = "flametank_mini"
	reload_delay = 0 SECONDS
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 25
	max_rounds = 25
	icon_state_mini = "tank_orange_mini"

/obj/item/ammo_magazine/flamer_tank/afterattack(obj/target, mob/user , flag) //refuel at fueltanks when we run out of ammo.

	if(!istype(target, /obj/structure/reagent_dispensers) || get_dist(user, target) > 1)
		return ..()
	if(!dispenser_type)
		to_chat(user, span_warning("这无法重新装填!"))
		return ..()
	if(!istype(target, dispenser_type))
		to_chat(user, span_warning("不是正确的燃料罐类型!"))
		return ..()
	if(current_rounds >= max_rounds)
		to_chat(user, span_warning("[src]已经满了。"))
		return ..()
	var/obj/structure/reagent_dispensers/dispenser = target
	if(dispenser.reagents.total_volume == 0)
		to_chat(user, span_warning("这个燃料罐是空的!"))
		return..()

	//Reworked and much simpler equation; fuel capacity minus the current amount, with a check for insufficient fuel
	var/liquid_transfer_amount = min(dispenser.reagents.total_volume, (max_rounds - current_rounds))
	dispenser.reagents.remove_any(liquid_transfer_amount)
	current_rounds += liquid_transfer_amount
	playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
	to_chat(user, span_notice("你用[lowertext(caliber)]重新装填了[src]。"))
	update_icon()

/obj/item/ammo_magazine/flamer_tank/large	// Extra thicc tank
	name = "大型火焰喷射器燃料罐"
	desc = "一个装有超浓稠凝固汽油的大型燃料罐,这是一种粘性可燃液体化学品,用于FL-84火焰喷射器。"
	icon_state = "flametank_large"
	max_rounds = 75
	current_rounds = 75
	reload_delay = 3 SECONDS
	icon_state_mini = "tank_orange"

/obj/item/ammo_magazine/flamer_tank/large/som
	name = "大型火焰喷射器燃料罐"
	desc = "一个装有超浓稠凝固汽油的大型燃料罐,这是一种粘性可燃液体化学品,用于V-62火焰喷射器。"
	icon_state = "flametank_som"
	max_rounds = 75
	current_rounds = 75
	reload_delay = 3 SECONDS
	icon_state_mini = "tank_red"

/obj/item/ammo_magazine/flamer_tank/large/X
	name = "大型火焰喷射器燃料罐(X)"
	desc = "一个装有超浓稠X型凝固汽油燃料的大型燃料罐,这是一种燃烧温度极高的粘性可燃液体化学品,用于FL-84火焰喷射器。小心处理。"
	icon_state = "flametank_large_blue"
	default_ammo = /datum/ammo/flamethrower/blue
	icon_state_mini = "tank_blue"
	dispenser_type = /obj/structure/reagent_dispensers/fueltank/xfuel

/obj/item/ammo_magazine/flamer_tank/mini/X
	name = "微型燃烧器燃料罐(X)"
	desc = "一个装有超浓稠X型凝固汽油燃料的大型燃料罐,这是一种燃烧温度极高的粘性可燃液体化学品,用于下挂式燃烧器单元。小心处理。"
	icon_state = "flametank_mini_blue"
	default_ammo = /datum/ammo/flamethrower/blue
	reload_delay = 0 SECONDS
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 25
	max_rounds = 25
	icon_state_mini = "tank_blue_mini"
	dispenser_type = /obj/structure/reagent_dispensers/fueltank/xfuel

/obj/item/ammo_magazine/flamer_tank/large/G
	name = "大型火焰喷射器燃料罐(G)"
	desc = "一个装有超浓稠G型等离子燃料的大型燃料罐,这是一种粘性可燃液体化学品,用于FL-84火焰喷射器。小心处理。"
	icon_state = "flametank_large_green"
	default_ammo = /datum/ammo/flamethrower/green
	icon_state_mini = "tank_green"
	dispenser_type = /obj/structure/reagent_dispensers/fueltank/gfuel

/obj/item/ammo_magazine/flamer_tank/mini/G
	name = "微型燃烧器燃料罐(G)"
	desc = "一个装有超浓稠G型等离子燃料的大型燃料罐,这是一种燃烧温度极高的粘性可燃液体化学品,用于下挂式燃烧器单元。小心处理。"
	icon_state = "flametank_mini_green"
	default_ammo = /datum/ammo/flamethrower/green
	reload_delay = 0 SECONDS
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 25
	max_rounds = 25
	icon_state_mini = "tank_green_mini"
	dispenser_type = /obj/structure/reagent_dispensers/fueltank/gfuel

/obj/item/ammo_magazine/flamer_tank/large/X/deathsquad
	name = "巨型火焰喷射器X燃料罐"
	desc = "利用蓝空间技术,Nanotrasen成功地将远超你一生所需用量的X燃料装入了这个专用燃料罐中。"
	max_rounds = 225
	current_rounds = 225
	reload_delay = 2 SECONDS

/obj/item/ammo_magazine/flamer_tank/backtank
	name = "背包燃料罐"
	desc = "一种专用燃料罐,用于FL-84火焰喷射器和FL-240燃烧器单元。"
	icon_state = "flamethrower_tank"
	equip_slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	max_rounds = 500
	current_rounds = 500
	reload_delay = 1 SECONDS
	caliber = CALIBER_FUEL_THICK
	magazine_flags = MAGAZINE_WORN
	icon_state_mini = "tank"

	default_ammo = /datum/ammo/flamethrower

/obj/item/ammo_magazine/flamer_tank/backtank/X
	name = "背包燃料罐(X)"
	desc = "一种装有超浓稠X型凝固汽油的专用燃料罐,用于FL-84火焰喷射器和FL-240燃烧器单元。"
	icon_state = "x_flamethrower_tank"
	default_ammo = /datum/ammo/flamethrower/blue
	dispenser_type = /obj/structure/reagent_dispensers/fueltank/xfuel

/obj/item/ammo_magazine/flamer_tank/backtank/G
	name = "背包燃料罐(G)"
	desc = "G型等离子专用燃料罐,用于FL-84火焰喷射器和FL-240焚烧器."
	icon_state = "g_flamethrower_tank"
	default_ammo = /datum/ammo/flamethrower/green
	dispenser_type = /obj/structure/reagent_dispensers/fueltank/gfuel

/obj/item/ammo_magazine/flamer_tank/water
	name = "加压水箱"
	desc = "FL-84下挂式灭火器的水箱.可手动补充."
	icon_state = "watertank"
	max_rounds = 200
	current_rounds = 200
	reload_delay = 0 SECONDS
	w_class = WEIGHT_CLASS_NORMAL
	caliber = CALIBER_WATER //Deep lore
	magazine_flags = NONE
	icon_state_mini = "tank_water"

	default_ammo = /datum/ammo/water
	dispenser_type = /obj/structure/reagent_dispensers/watertank

//The engineer pyro bag internal fuel tank
/obj/item/ammo_magazine/flamer_tank/internal
	name = "内置燃料罐"
	desc = "一大罐超浓稠环烷,一种黏稠的可燃液体化学物质,不过你不该看到这个."
	icon_state = ""
	max_rounds = 280
	current_rounds = 280
	reload_delay = 0 SECONDS

