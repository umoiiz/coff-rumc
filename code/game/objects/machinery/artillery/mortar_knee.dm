/obj/item/mortar_kit/knee
	name = "\improper TA-10膝迫击炮"
	desc = "一种手动、需要乘员操作的迫击炮系统,旨在向瞄准的任何目标倾泻50毫米炮弹,通常最广为人知的名字是\"膝\"迫击炮.实际上无法从你的膝盖上发射,所以需要先架设好才能开火.载荷较轻,但射速极高."
	icon = 'icons/obj/artillery/knee_mortar.dmi'
	icon_state = "knee_mortar"
	max_integrity = 250
	w_class = WEIGHT_CLASS_NORMAL
	deployable_item = /obj/machinery/deployable/mortar/knee

/obj/machinery/deployable/mortar/knee
	offset_per_turfs = 12
	fire_sound = 'sound/weapons/guns/fire/kneemortar_fire.ogg'
	fall_sound = 'sound/weapons/guns/misc/kneemortar_whistle.ogg'
	minimum_range = 5
	allowed_shells = list(
		/obj/item/mortal_shell/knee,
		/obj/item/mortal_shell/flare,
	)

	cool_off_time = 4 SECONDS
	reload_time = 0.5 SECONDS
	fire_delay = 0.5 SECONDS
	max_spread = 6
