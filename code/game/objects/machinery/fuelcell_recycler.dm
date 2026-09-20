/obj/machinery/fuelcell_recycler
	name = "fuel cell recycler"
	desc = "一台带有旋转风扇和顶部两个圆柱形孔洞的大型机器。用于为燃料电池补充燃料。"
	icon = 'icons/obj/machines/fusion_engine.dmi'
	icon_state = "recycler"
	anchored = TRUE
	density = TRUE
	idle_power_usage = 5
	active_power_usage = 15000
	bound_height = 32
	bound_width = 32
	resistance_flags = RESIST_ALL
	var/obj/item/fuel_cell/cell_left = null
	var/obj/item/fuel_cell/cell_right = null

/obj/machinery/fuelcell_recycler/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(!istype(I, /obj/item/fuel_cell))
		return
	if(!cell_left)
		if(user.transferItemToLoc(I, src))
			cell_left = I
			start_processing()
	else if(!cell_right)
		if(user.transferItemToLoc(I, src))
			cell_right = I
			start_processing()
	else
		to_chat(user, span_notice("回收机已满!"))
	update_icon()
	return

/obj/machinery/fuelcell_recycler/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(cell_left == null && cell_right == null)
		to_chat(user, span_notice("回收机是空的。"))
		return

	if(cell_right == null)
		cell_left.update_icon()
		user.put_in_hands(cell_left)
		cell_left = null
		update_icon()
	else if(cell_left == null)
		cell_right.update_icon()
		user.put_in_hands(cell_right)
		cell_right = null
		update_icon()
	else
		if(cell_left.get_fuel_percent() > cell_right.get_fuel_percent())
			cell_left.update_icon()
			user.put_in_hands(cell_left)
			cell_left = null
			update_icon()
		else
			cell_right.update_icon()
			user.put_in_hands(cell_right)
			cell_right = null
			update_icon()

/obj/machinery/fuelcell_recycler/process()
	if(machine_stat & (BROKEN|NOPOWER))
		update_icon()
		return
	if(!cell_left && !cell_right)
		update_icon()
		stop_processing()
		return
	else
		var/active = FALSE
		if(cell_left != null)
			if(!cell_left.is_regenerated())
				active = TRUE
				cell_left.give(active_power_usage*(GLOB.CELLRATE * 0.1))
		if(cell_right != null)
			if(!cell_right.is_regenerated())
				active = TRUE
				cell_right.give(active_power_usage*(GLOB.CELLRATE * 0.1))
		if(!active)
			stop_processing()

		update_icon()

/obj/machinery/fuelcell_recycler/update_icon_state()
	. = ..()
	if(machine_stat & (BROKEN|NOPOWER))
		icon_state = "recycler0"
	else
		icon_state = "recycler"

/obj/machinery/fuelcell_recycler/update_overlays()
	. = ..()

	if(machine_stat & (BROKEN|NOPOWER))
		if(cell_left != null)
			. += "recycler-left-cell"
		if(cell_right != null)
			. += "recycler-right-cell"
		return

	var/overlay_builder = "recycler-"
	if(cell_left == null && cell_right == null)
		return
	if(cell_right == null)
		if(cell_left.is_regenerated())
			overlay_builder += "left-charged"
		else
			overlay_builder += "left-charging"

		. += overlay_builder
		. += "recycler-left-cell"
		return
	else if(cell_left == null)
		if(cell_right.is_regenerated())
			overlay_builder += "right-charged"
		else
			overlay_builder += "right-charging"

		. += overlay_builder
		. += "recycler-right-cell"
		return
	else // both left and right cells are there
		if(cell_left.is_regenerated())
			overlay_builder += "left-charged"
		else
			overlay_builder += "left-charging"

		if(cell_right.is_regenerated())
			overlay_builder += "-right-charged"
		else
			overlay_builder += "-right-charging"

		. += overlay_builder
		. += "recycler-left-cell"
		. += "recycler-right-cell"
