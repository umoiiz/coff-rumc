/obj/structure/computerframe
	density = TRUE
	anchored = TRUE
	name = "计算机框架"
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "0"
	var/state = 0
	var/obj/item/circuitboard/computer/circuit

/obj/structure/computerframe/attackby(obj/item/I, mob/user, params)
	switch(state)
		if(0)
			if(iswrench(I))
				playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
				if(!do_after(user, 20, NONE, src, BUSY_ICON_BUILD))
					return

				to_chat(user, span_notice("你将框架扳到位."))
				anchored = TRUE
				state = 1

			else if(iswelder(I))
				var/obj/item/tool/weldingtool/WT = I
				if(!WT.remove_fuel(0, user))
					to_chat(user, "[WT]必须开启才能完成此任务.")
					return

				playsound(loc, 'sound/items/welder.ogg', 25, 1)
				if(!do_after(user, 20, NONE, src, BUSY_ICON_BUILD, extra_checks = CALLBACK(WT, TYPE_PROC_REF(/obj/item/tool/weldingtool, isOn))))
					return FALSE

				to_chat(user, span_notice("你拆解了框架."))
				new /obj/item/stack/sheet/metal(loc, 5)
				qdel(src)
		if(1)
			if(iswrench(I))
				playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
				if(!do_after(user, 20, NONE, src, BUSY_ICON_BUILD))
					return

				to_chat(user, span_notice("你松开了框架."))
				anchored = FALSE
				state = 0

			else if(istype(I, /obj/item/circuitboard/computer) && !circuit)
				if(!user.drop_held_item())
					return

				playsound(loc, 'sound/items/deconstruct.ogg', 25, 1)
				to_chat(user, span_notice("你将电路板放入框架内."))
				icon_state = "1"
				circuit = I
				I.forceMove(src)

			else if(isscrewdriver(I) && circuit)
				playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
				to_chat(user, span_notice("你将电路板拧到位."))
				state = 2
				icon_state = "2"

			else if(iscrowbar(I) && circuit)
				playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
				to_chat(user, span_notice("你拆下了电路板."))
				state = 1
				icon_state = "0"
				circuit.forceMove(loc)
				circuit = null
		if(2)
			if(isscrewdriver(I) && circuit)
				playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
				to_chat(user, span_notice("你松开了电路板."))
				state = 1
				icon_state = "1"

			else if(iscablecoil(I))
				var/obj/item/stack/cable_coil/C = I
				if(C.get_amount() < 5)
					to_chat(user, span_warning("你需要五圈电线才能将它们添加到框架上."))
					return
				to_chat(user, span_notice("你开始向框架添加线缆."))

				playsound(loc, 'sound/items/deconstruct.ogg', 25, 1)

				if(!do_after(user, 20, NONE, src, BUSY_ICON_BUILD) || state != 2 || !C.use(5))
					return FALSE

				to_chat(user, span_notice("你向框架添加了线缆."))
				state = 3
				icon_state = "3"
		if(3)
			if(iswirecutter(I))
				playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)
				to_chat(user, span_notice("你拆下了线缆."))
				state = 2
				icon_state = "2"
				var/obj/item/stack/cable_coil/A = new(loc)
				A.amount = 5

			else if(istype(I, /obj/item/stack/sheet/glass))
				var/obj/item/stack/sheet/glass/G = I
				if(G.get_amount() < 2)
					to_chat(user, span_warning("你需要两块玻璃才能装入玻璃面板."))
					return
				playsound(loc, 'sound/items/deconstruct.ogg', 25, 1)
				to_chat(user, span_notice("你开始装入玻璃面板."))

				if(!do_after(user, 20, NONE, src, BUSY_ICON_BUILD) || state != 3 || !G.use(2))
					return FALSE

				to_chat(user, span_notice("你装入了玻璃面板."))
				state = 4
				icon_state = "4"
		if(4)
			if(iscrowbar(I))
				playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
				to_chat(user, span_notice("你拆下了玻璃面板."))
				state = 3
				icon_state = "3"
				new /obj/item/stack/sheet/glass(loc, 2)

			else if(isscrewdriver(I))
				playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
				to_chat(user, span_notice("你连接了显示器."))
				var/B = new circuit.build_path(loc)
				circuit.construct(B)
				qdel(src)
