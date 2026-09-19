/obj/machinery/space_heater
	anchored = FALSE
	density = TRUE
	icon = 'icons/obj/machines/atmos.dmi'
	icon_state = "sheater0"
	name = "space heater"
	desc = "由太空阿米什人使用传统太空技术制造,这款加热器保证不会把空间站点燃."
	allow_pass_flags = PASS_LOW_STRUCTURE|PASSABLE|PASS_WALKOVER
	resistance_flags = XENO_DAMAGEABLE
	max_integrity = 100
	/// The cell inside the heater, used for making it work
	var/obj/item/cell/high/cell
	/// Is the heater on?
	var/on = FALSE
	/// Is the panel on the heater open?
	var/open = FALSE

/obj/machinery/space_heater/Initialize(mapload)
	. = ..()
	cell = new(src)
	update_icon()
	var/static/list/connections = list(
		COMSIG_OBJ_TRY_ALLOW_THROUGH = PROC_REF(can_climb_over),
		COMSIG_FIND_FOOTSTEP_SOUND = TYPE_PROC_REF(/atom/movable, footstep_override),
		COMSIG_TURF_CHECK_COVERED = TYPE_PROC_REF(/atom/movable, turf_cover_check),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/machinery/space_heater/update_icon_state()
	. = ..()
	icon_state = "sheater[on]"

/obj/machinery/space_heater/update_overlays()
	. = ..()
	if(open)
		. += "sheater-open"

/obj/machinery/space_heater/examine(mob/user)
	. = ..()
	. += "The heater is [on ? "on" : "off"] and the hatch is [open ? "open" : "closed"]."
	if(open)
		. += "The power cell is [cell ? "installed" : "missing"]."
	else
		. += "The charge meter reads [cell ? round(cell.percent(),1) : 0]%"

/obj/machinery/space_heater/emp_act(severity)
	if(machine_stat & (BROKEN|NOPOWER))
		return ..()
	if(cell)
		cell.emp_act(severity)
	return ..()

/obj/machinery/space_heater/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	open = !open
	balloon_alert_to_viewers("[user] [open ? "opens" : "closes"] [src]上的舱盖")
	update_icon()

/obj/machinery/space_heater/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(on)
		balloon_alert(user, "先关闭[src]")
		return
	if(!open)
		balloon_alert(user, "舱盖是关闭的")
		return
	if(!cell)
		balloon_alert(user, "没有电池可以撬出")
		return
	balloon_alert(user, "你撬出了电池")
	cell.forceMove(user.drop_location())
	cell = null

/obj/machinery/space_heater/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(!istype(I, /obj/item/cell))
		return
	if(!open)
		balloon_alert(user, "打开舱盖")
		return

	if(cell)
		balloon_alert(user, "[src]已经有电池了.")
		return

	var/obj/item/cell/user_cell = I
	if(!istype(user_cell))
		return

	if(!user.transferItemToLoc(user_cell, src))
		return

	cell = user_cell

	balloon_alert_to_viewers("[user]将电池插入[src]")

/obj/machinery/space_heater/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	on = !on
	if(on)
		start_processing()
	else
		stop_processing()

	balloon_alert_to_viewers("[user]将[src]切换为[on ? "on" : "off"]")
	update_icon()

/obj/machinery/space_heater/process()
	if(!on || !cell || !cell.charge)
		balloon_alert_to_viewers("[src]关闭了")
		update_icon()
		stop_processing()
		return

	for(var/mob/living/carbon/human/H in range(2, src))
		H.adjust_bodytemperature(min(round(T20C - H.bodytemperature)*0.7, 25), 0, T20C)
	cell.use(50 * GLOB.CELLRATE)
