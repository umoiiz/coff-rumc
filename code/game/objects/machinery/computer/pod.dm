/obj/machinery/computer/pod
	name = "Pod Launch Control"
	desc = "发射舱的控制装置.有些人更喜欢操控机甲."
	icon_state = "computer"
	screen_overlay = "computer_generic"
	circuit = /obj/item/circuitboard/computer/pod
	var/id = 1
	var/timing = 0
	var/time = 30
	var/title = "Mass Driver Controls"

/obj/machinery/computer/pod/old
	icon_state = "old"
	screen_overlay = "old_screen"
	name = "DoorMex Control Computer"
	title = "Door Controls"

/obj/machinery/computer/pod/old/syndicate
	name = "ProComp Executive IIc"
	desc = "辛迪加经费紧张.操作外部气闸."
	title = "External Airlock Controls"

/obj/machinery/computer/pod/old/swf
	name = "Magix System IV"
	desc = "一件蕴含大量魔法的神秘神器.运行E-Knock 2.2:术士版"
