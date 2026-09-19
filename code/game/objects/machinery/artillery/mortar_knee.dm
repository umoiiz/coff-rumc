/obj/item/mortar_kit/knee
	name = "\improper TA-10膝部迫击炮"
	desc = "一种手动操作的班组迫击炮系统,旨在向瞄准的任何目标倾泻50毫米炮弹,通常被称为\"膝部\"迫击炮。实际上无法从你的膝盖上发射,因此需要先架设才能开火。弹药威力较轻,但射速极高。"
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
