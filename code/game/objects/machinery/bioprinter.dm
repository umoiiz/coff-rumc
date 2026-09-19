/obj/machinery/bioprinter
	name = "bio/synthetic printer"
	desc = "这是一台可以培育替换器官或制造合成器官的机器。"
	icon = 'icons/obj/surgery.dmi'

	anchored = TRUE
	density = TRUE
	coverage = 30

	icon_state = "bioprinter"

	light_range = 0.5
	light_power = 0.4

	var/working = 0
	var/stored_matter = 0
	var/stored_metal = 0

	//"Name" = list(location, matter, metal, time, isorganic)
	var/list/products = list(
		"biotic left arm (100 - Matter)" = list(/obj/item/robot_parts/biotic/l_arm,  LIMB_MATTER_AMOUNT, 0, LIMB_PRINTING_TIME),
		"biotic right arm (100 - Matter)" = list(/obj/item/robot_parts/biotic/r_arm,  LIMB_MATTER_AMOUNT, 0, LIMB_PRINTING_TIME),
		"biotic left leg (100 - Matter)" = list(/obj/item/robot_parts/biotic/l_leg,  LIMB_MATTER_AMOUNT, 0, LIMB_PRINTING_TIME),
		"biotic right leg (100 - Matter)" = list(/obj/item/robot_parts/biotic/r_leg,  LIMB_MATTER_AMOUNT, 0, LIMB_PRINTING_TIME),
		"synthetic left arm (125 - Metal)" = list(/obj/item/robot_parts/l_arm,  0, LIMB_METAL_AMOUNT, LIMB_PRINTING_TIME),
		"synthetic right arm (125 - Metal)" = list(/obj/item/robot_parts/r_arm,  0, LIMB_METAL_AMOUNT, LIMB_PRINTING_TIME),
		"synthetic left leg (125 - Metal)" = list(/obj/item/robot_parts/l_leg,  0, LIMB_METAL_AMOUNT, LIMB_PRINTING_TIME),
		"synthetic right leg (125 - Metal)" = list(/obj/item/robot_parts/r_leg,  0, LIMB_METAL_AMOUNT, LIMB_PRINTING_TIME),
	)

/obj/machinery/bioprinter/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(working)
		to_chat(user, "已经有东西正在打印了...")
		return
	var/choice = tgui_input_list(user, "您想要打印什么?", null, products)
	if(!choice)
		return
	if(stored_matter >= products[choice][2] && stored_metal >= products[choice][3]) //Matter and metal
		if(working)
			to_chat(user, "已经有东西正在打印了...")
			return
		stored_matter -= products[choice][2] //Matter
		stored_metal -= products[choice][3] //Metal
		to_chat(user, span_notice("\The [src] 正在打印选定的器官。请稍候。"))
		working = 1
		update_icon()
		addtimer(CALLBACK(src, PROC_REF(spawn_new_organ), choice), products[choice][4])
	else
		to_chat(user, "打印机中的材料不足。")

/obj/machinery/bioprinter/proc/spawn_new_organ(choice)
	var/new_organ = products[choice][1]
	new new_organ(get_turf(src))
	working = 0
	visible_message("生物/合成打印机吐出了一个新器官。")
	update_icon()

/obj/machinery/bioprinter/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(istype(I, /obj/item/reagent_containers/glass/beaker))
		var/obj/item/reagent_containers/glass/beaker/B = I
		if(B.reagents.has_reagent(/datum/reagent/medicine/biomass, 30))
			to_chat(user, span_notice("\The [src] 处理 \the [I]。"))
			stored_matter += 200
			B.reagents.remove_reagent(/datum/reagent/medicine/biomass, 30)

	else if(istype(I, /obj/item/limb))
		to_chat(user, span_notice("\The [src] 处理 \the [I]。"))
		stored_matter += 50
		user.drop_held_item()
		qdel(I)

	else if(istype(I, /obj/item/stack/sheet/metal))
		var/obj/item/stack/sheet/metal/M = I
		to_chat(user, span_notice("\The [src] 处理 \the [I]。"))
		stored_metal += M.amount * 100
		user.drop_held_item()
		qdel(I)

/obj/machinery/bioprinter/examine(mob/user)
	. = ..()
	. += "It has [stored_matter] matter and [stored_metal] metal left."

/obj/machinery/bioprinter/update_icon_state()
	. = ..()
	if(machine_stat & NOPOWER)
		icon_state = "bioprinter_off"
		set_light(0, 0)
		return
	if(working)
		icon_state = "bioprinter_busy"
	else
		icon_state = "bioprinter"
	set_light(initial(light_range), initial(light_power))

/obj/machinery/bioprinter/update_overlays()
	. = ..()
	if(machine_stat & (BROKEN|DISABLED|NOPOWER))
		return
	. += emissive_appearance(icon, "[icon_state]_emissive", src, alpha = src.alpha)
	. += mutable_appearance(icon, "[icon_state]_emissive", alpha = src.alpha)

/obj/machinery/bioprinter/stocked
	stored_metal = 1000
	stored_matter = 1000

/obj/machinery/bioprinter/valhalla
	use_power = NO_POWER_USE
	stored_metal = 9999
	stored_matter = 9999
