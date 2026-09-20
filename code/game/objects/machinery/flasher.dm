// It is a gizmo that flashes a small area
/obj/machinery/flasher
	name = "Mounted flash"
	desc = "一个壁挂式闪光灯泡装置."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "mflash1"
	anchored = TRUE
	power_channel = EQUIP
	use_power = IDLE_POWER_USE
	idle_power_usage = 2
	active_power_usage = 1500
	var/id = null
	///this is roughly the size of brig cell
	var/range = 2
	var/disable = 0
	///Don't want it getting spammed like regular flashes
	var/last_flash = 0
	///How knocked down targets are when flashed.
	var/strength = 20 SECONDS
	var/base_state = "mflash"

/obj/machinery/flasher/cell1
	name = "Cell 1 Flash"

/obj/machinery/flasher/cell2
	name = "Cell 2 Flash"

/obj/machinery/flasher/portable //Portable version of the flasher. Only flashes when anchored
	name = "portable flasher"
	desc = "一个便携式闪光装置. 用扳手激活和停用. 无法探测缓慢移动."
	icon_state = "pflash1"
	strength = 8
	anchored = FALSE
	base_state = "pflash"
	density = TRUE

/obj/machinery/flasher/update_icon_state()
	. = ..()
	if(!(machine_stat & NOPOWER))
		icon_state = "[base_state]1"
	else
		icon_state = "[base_state]1-p"

/obj/machinery/flasher/wirecutter_act(mob/living/user, obj/item/W)
	disable = !disable
	if(disable)
		user.visible_message(span_warning("[user]断开了[src]的闪光灯泡!"), span_warning("你断开了[src]的闪光灯泡!"))
	if(!disable)
		user.visible_message(span_warning("[user]连接了[src]的闪光灯泡!"), span_warning("你连接了[src]的闪光灯泡!"))

/obj/machinery/flasher/attack_ai()
	if(anchored)
		return flash()

/obj/machinery/flasher/proc/flash()
	if(!(powered()))
		return
	if((disable) || (last_flash && world.time < last_flash + 150))
		return

	playsound(loc, 'sound/weapons/flash.ogg', 25, 1)
	flick("[base_state]_flash", src)
	last_flash = world.time
	use_power(active_power_usage)

	for(var/mob/living/L in viewers(src, null))
		if(get_dist(src, L) > range)
			continue

		if(isxeno(L))
			continue

		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			if(H.get_eye_protection() > 0)
				continue
			var/datum/internal_organ/eyes/E = H.get_organ_slot(ORGAN_SLOT_EYES)
			if(E && (E.damage > E.min_bruised_damage && prob(E.damage + 50)))
				H.flash_act()
				E.take_damage(rand(1, 5))
		else
			L.flash_act()

		L.Paralyze(strength)

/obj/machinery/flasher/emp_act(severity)
	. = ..()
	if(machine_stat & (BROKEN|NOPOWER))
		return
	if(prob(75 / severity))
		flash()

/obj/machinery/flasher/portable/HasProximity(atom/movable/AM as mob|obj)
	if((disable) || (last_flash && world.time < last_flash + 150))
		return

	if(iscarbon(AM))
		var/mob/living/carbon/M = AM
		if((M.m_intent != MOVE_INTENT_WALK) && (anchored))
			flash()

/obj/machinery/flasher/portable/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	anchored = !anchored
	if(!anchored)
		user.show_message(span_warning("[src]现已固定。"))
		overlays += "[base_state]-s"
	else
		user.show_message(span_warning("[src]现在可以移动了。"))
		overlays.Cut()

/obj/machinery/flasher_button/attack_ai(mob/user as mob)
	return attack_hand(user)

/obj/machinery/flasher_button/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	return attack_hand(user)

/obj/machinery/flasher_button/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if(active)
		return

	if(!allowed(user))
		to_chat(user, span_warning("访问被拒绝。"))
		return

	use_power(active_power_usage)

	active = 1
	icon_state = "launcheron"

	for(var/obj/machinery/flasher/M in GLOB.machines)
		if(M.id == id)
			INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/machinery/flasher, flash))

	sleep(5 SECONDS)

	icon_state = "launcher"
	active = 0
