/obj/machinery/computer/gravity_control_computer
	name = "Gravity Generator Control"
	desc = "一台用于控制本地重力发生器的计算机。仅限合格人员操作。"
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"
	screen_overlay = "airtunnel0e"
	broken_icon = "computer_blue_broken"
	anchored = TRUE
	density = TRUE


/obj/machinery/gravity_generator
	name = "Gravitational Generator"
	desc = "一种设置后能产生重力子场的装置。"
	icon = 'icons/obj/singularity.dmi'
	icon_state = "TheSingGen"
	anchored = TRUE
	density = TRUE
	use_power = TRUE
