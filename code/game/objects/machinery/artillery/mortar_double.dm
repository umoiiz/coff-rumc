/obj/item/mortar_kit/double
	name = "\improper TA-55DB迫击炮"
	desc = "一种手动、需要乘员操作的迫击炮系统,旨在向瞄准的任何目标倾泻80毫米的正义.需要先架设好才能开火.这是一门双管迫击炮,通常可容纳4发炮弹,常安装在TAV上."
	icon_state = "mortar_db"
	icon = 'icons/obj/artillery/mortar_double.dmi'
	max_integrity = 400
	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE|DEPLOYED_NO_PICKUP|DEPLOY_ON_INITIALIZE
	w_class = WEIGHT_CLASS_HUGE
	deployable_item = /obj/machinery/deployable/mortar/double

/obj/machinery/deployable/mortar/double
	reload_time = 2 SECONDS
	fire_amount = 2
	max_rounds = 2
	fire_delay = 0.5 SECONDS
	cool_off_time = 6 SECONDS
	spread = 2
