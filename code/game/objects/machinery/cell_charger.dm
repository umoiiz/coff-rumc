/obj/machinery/cell_charger
	name = "heavy-duty cell charger"
	desc = "标准充电器的更强大版本,专为给能量电池充电而设计."
	icon = 'icons/obj/power.dmi'
	icon_state = "ccharger0"
	anchored = TRUE
	use_power = IDLE_POWER_USE
	wrenchable = TRUE
	idle_power_usage = 5
	active_power_usage = 40000	//40 kW. (this the power drawn when charging)
	power_channel = EQUIP
	var/obj/item/cell/charging = null
	var/chargelevel = -1

/obj/machinery/cell_charger/proc/updateicon()
	icon_state = "ccharger[charging ? 1 : 0]"

	if(charging && !(machine_stat & (BROKEN|NOPOWER)) )
		var/newlevel = round(charging.percent() * 4 / 99)
		//to_chat(world, "nl: [newlevel]")

		if(chargelevel != newlevel)

			overlays.Cut()
			overlays += "ccharger-o[newlevel]"

			chargelevel = newlevel
	else
		overlays.Cut()

/obj/machinery/cell_charger/examine(mob/user)
	. = ..()
	. += "There's [charging ? "a" : "no"] cell in the charger."
	if(charging)
		. += "Current charge: [charging.charge]"

/obj/machinery/cell_charger/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(machine_stat & BROKEN)
		return

	if(istype(I, /obj/item/cell) && anchored)
		var/obj/item/cell/our_cell = I
		if(!our_cell.rechargable)
			balloon_alert(user, "不可充电")
			return

		if(charging)
			to_chat(user, span_warning("充电器中已经有一块电池了."))
			return

		var/area/A = loc.loc
		if(!isarea(A))
			return

		if(A.power_equip == 0) // There's no APC in this area, don't try to cheat power!
			to_chat(user, span_warning("当你试图插入电池时,[name] 闪起了红光!"))
			return

		if(user.transferItemToLoc(our_cell, src))
			charging = our_cell
			user.visible_message("[user] 将一块电池插入充电器.", "你将一块电池插入充电器.")
			chargelevel = -1
			start_processing()

		updateicon()

/obj/machinery/cell_charger/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(charging)
		to_chat(user, span_warning("先把电池取出来!"))
		return

	anchored = !anchored
	to_chat(user, "你 [anchored ? "attach" : "detach"] 电池充电器 [anchored ? "to" : "from"] 地面")
	playsound(loc, 'sound/items/ratchet.ogg', 25, 1)

/obj/machinery/cell_charger/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(charging)
		usr.put_in_hands(charging)
		charging.update_icon()

		src.charging = null
		user.visible_message("[user] 从充电器中取出电池.", "你从充电器中取出电池.")
		chargelevel = -1
		updateicon()
		stop_processing()

/obj/machinery/cell_charger/emp_act(severity)
	. = ..()
	if(charging)
		charging.emp_act(severity)

/obj/machinery/cell_charger/process()
	//to_chat(world, "ccpt [charging] [stat]")
	if((machine_stat & (BROKEN|NOPOWER)) || !anchored)
		return

	if(charging && !charging.is_fully_charged())
		charging.give(active_power_usage*GLOB.CELLRATE)

		updateicon()
