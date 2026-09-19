/obj/item/storage/pill_bottle/dice
	name = "一包骰子"
	desc = "一个小容器,里面有骰子."

/obj/item/storage/pill_bottle/dice/PopulateContents()
	new /obj/item/toy/dice(src)
	new /obj/item/toy/dice/d20(src)

/*
* Donut Box
*/

/obj/item/storage/donut_box
	name = "\improper 美味! 甜甜圈"
	desc = "一盒令人垂涎的\"<i>美味!</i>\"品牌甜甜圈."
	icon = 'icons/obj/items/food/donuts.dmi'
	icon_state = "donutbox"
	/// How many items spawn in src
	var/startswith = 6
	/// Are we open?
	var/open = FALSE

/obj/item/storage/donut_box/Initialize(mapload)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(/obj/item/reagent_containers/food/snacks/donut))
	storage_datum.foldable = /obj/item/stack/sheet/cardboard
	storage_datum.storage_slots = 6

/obj/item/storage/donut_box/PopulateContents()
	for(var/i in 1 to startswith)
		new /obj/item/reagent_containers/food/snacks/donut/normal(src)

/obj/item/storage/donut_box/attack_self(mob/user as mob)
	to_chat(user, "你 [open ? "close [src]. Another time, then." : "open [src]. Mmmmm... donuts."]")
	open = !open
	update_icon()
	if(!length(contents))
		return ..()

/obj/item/storage/donut_box/update_icon_state()
	. = ..()
	if(!open)
		icon_state = "donutbox"
		return
	icon_state = "donutbox_o"

/obj/item/storage/donut_box/update_overlays()
	. = ..()
	if(!open)
		return
	var/i = 0
	for(var/obj/item/reagent_containers/food/snacks/donut/D in contents)
		i++
		var/image/img = image('icons/obj/items/food/donuts.dmi', "[D.overlay_state]-[i]")
		. += img

/obj/item/storage/donut_box/empty
	icon_state = "donutbox_o"
	startswith = 0
