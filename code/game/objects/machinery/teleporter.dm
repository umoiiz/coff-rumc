/obj/machinery/computer/teleporter
	name = "Teleporter"
	desc = "用于控制已连接的传送枢纽和传送站."
	icon_state = "computer"
	screen_overlay = "teleport"


/obj/machinery/teleport
	name = "teleport"
	icon = 'icons/obj/stationobjs.dmi'
	density = TRUE
	anchored = TRUE


/obj/machinery/teleport/hub
	name = "teleporter hub"
	desc = "它是传送机器的枢纽."
	icon_state = "tele0"


/obj/machinery/teleport/station
	name = "station"
	desc = "它是传送站."
	icon_state = "controller"
