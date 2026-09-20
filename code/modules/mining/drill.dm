/obj/machinery/mining
	icon = 'icons/obj/mining_drill.dmi'
	anchored = FALSE
	use_power = 0 //The drill takes power directly from a cell.
	density = TRUE
	layer = ABOVE_MOB_LAYER //So it draws over mobs in the tile north of it.

/obj/machinery/mining/drill
	name = "mining drill head"
	desc = "一个巨大的钻头."
	icon_state = "mining_drill"

/obj/machinery/mining/drill/braced
	anchored = TRUE
	icon_state = "mining_drill_braced"

/obj/machinery/mining/brace
	name = "mining drill brace"
	desc = "工业钻头的机械支架.看起来足足有两英尺厚."
	icon_state = "mining_brace"

/obj/machinery/mining/brace/active
	name = "active mining drill brace"
	icon_state = "mining_brace_active"
	anchored = TRUE
	
