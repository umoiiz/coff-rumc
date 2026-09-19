//Camera only overwatch
/obj/machinery/computer/camera_advanced/overwatch/req
	icon_state = "overwatch_req"
	screen_overlay = "overwatch_req_screen"
	name = "Requisition Overwatch Console"
	desc = "老大哥后勤部要求看到金钱流入名为贪婪的虚空."
	circuit = /obj/item/circuitboard/computer/supplyoverwatch
	overwatch_title = "Requisition"

/obj/machinery/computer/camera_advanced/overwatch/medical
	screen_overlay = "overwatch_med_screen"
	name = "Medical Overwatch Console"
	desc = "监视病人是舰上医疗人员的职责之一. 只要确保你不会感到无聊."
	req_access = list(ACCESS_MARINE_MEDBAY)
	circuit = /obj/item/circuitboard/computer/supplyoverwatch
	overwatch_title = "Medical"

//Military overwatch
/obj/machinery/computer/camera_advanced/overwatch/military/alpha
	name = "Alpha Overwatch Console"

/obj/machinery/computer/camera_advanced/overwatch/military/bravo
	name = "Bravo Overwatch Console"

/obj/machinery/computer/camera_advanced/overwatch/military/charlie
	name = "Charlie Overwatch Console"

/obj/machinery/computer/camera_advanced/overwatch/military/delta
	name = "Delta Overwatch Console"

/obj/machinery/computer/camera_advanced/overwatch/military/main
	icon_state = "overwatch_main"
	screen_overlay = "overwatch_main_screen"
	name = "Main Overwatch Console"
	desc = "用于一般监视目的的最先进机械."
	overwatch_title = "Main"
	console_type = "main"

