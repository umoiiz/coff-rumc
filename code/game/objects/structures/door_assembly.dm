/obj/structure/door_assembly
	name = "气闸组件"
	icon_state = "door_as_0"
	icon = 'icons/obj/doors/door_assembly.dmi'
	anchored = FALSE
	density = TRUE
	resistance_flags = XENO_DAMAGEABLE
	allow_pass_flags = PASS_AIR
	max_integrity = 50
	base_icon_state = ""
	var/state = 0
	var/base_name = "Airlock"
	var/obj/item/circuitboard/airlock/electronics = null
	///the type path of the airlock once completed
	var/airlock_type = ""
	var/glass_type = "/glass"
	var/created_name = null
	/// 0 = glass can be installed.
	/// -1 = glass can't be installed.
	/// 1 = glass is already installed. Text = mineral plating is installed instead.
	var/glass = 0

/obj/structure/door_assembly/Initialize(mapload)
	. = ..()
	update_state()

/obj/structure/door_assembly/door_assembly_com
	base_icon_state = "com"
	base_name = "Command Airlock"
	glass_type = "/glass_command"
	airlock_type = "/command"

/obj/structure/door_assembly/door_assembly_sec
	base_icon_state = "sec"
	base_name = "Security Airlock"
	glass_type = "/glass_security"
	airlock_type = "/security"

/obj/structure/door_assembly/door_assembly_eng
	base_icon_state = "eng"
	base_name = "Engineering Airlock"
	glass_type = "/glass_engineering"
	airlock_type = "/engineering"

/obj/structure/door_assembly/door_assembly_min
	base_icon_state = "min"
	base_name = "Mining Airlock"
	glass_type = "/glass_mining"
	airlock_type = "/mining"

/obj/structure/door_assembly/door_assembly_atmo
	base_icon_state = "atmo"
	base_name = "Atmospherics Airlock"
	glass_type = "/glass_atmos"
	airlock_type = "/atmos"

/obj/structure/door_assembly/door_assembly_research
	base_icon_state = "res"
	base_name = "Research Airlock"
	glass_type = "/glass_research"
	airlock_type = "/research"

/obj/structure/door_assembly/door_assembly_science
	base_icon_state = "sci"
	base_name = "Science Airlock"
	glass_type = "/glass_science"
	airlock_type = "/science"

/obj/structure/door_assembly/door_assembly_med
	base_icon_state = "med"
	base_name = "Medical Airlock"
	glass_type = "/glass_medical"
	airlock_type = "/medical"

/obj/structure/door_assembly/door_assembly_mai
	base_icon_state = "mai"
	base_name = "Maintenance Airlock"
	airlock_type = "/maintenance"
	glass = -1

/obj/structure/door_assembly/door_assembly_ext
	base_icon_state = "ext"
	base_name = "External Airlock"
	airlock_type = "/external"
	glass = -1

/obj/structure/door_assembly/door_assembly_fre
	base_icon_state = "fre"
	base_name = "Freezer Airlock"
	airlock_type = "/freezer"
	glass = -1

/obj/structure/door_assembly/door_assembly_hatch
	base_icon_state = "hatch"
	base_name = "Airtight Hatch"
	airlock_type = "/hatch"
	glass = -1

/obj/structure/door_assembly/door_assembly_mhatch
	base_icon_state = "mhatch"
	base_name = "Maintenance Hatch"
	airlock_type = "/maintenance_hatch"
	glass = -1

/obj/structure/door_assembly/door_assembly_highsecurity // Borrowing this until WJohnston makes sprites for the assembly
	base_icon_state = "highsec"
	base_name = "High Security Airlock"
	airlock_type = "/highsecurity"
	glass = -1

/obj/structure/door_assembly/multi_tile
	icon = 'icons/obj/doors/door_assembly2x1.dmi'
	dir = EAST
	base_icon_state = "g" //Remember to delete this line when reverting "glass" var to 1.
	airlock_type = "/multi_tile/glass"
	glass = -1 //To prevent bugs in deconstruction process.
	var/width = 1

/obj/structure/door_assembly/multi_tile/Initialize(mapload)
	. = ..()
	if(dir in list(EAST, WEST))
		bound_width = width * world.icon_size
		bound_height = world.icon_size
	else
		bound_width = world.icon_size
		bound_height = width * world.icon_size
	update_state()

/obj/structure/door_assembly/multi_tile/Move(atom/newloc, direction, glide_size_override)
	. = ..()
	if(dir in list(EAST, WEST))
		bound_width = width * world.icon_size
		bound_height = world.icon_size
	else
		bound_width = world.icon_size
		bound_height = width * world.icon_size

/obj/structure/door_assembly/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/tool/pen))
		var/t = copytext(stripped_input(user, "Enter the name for the door.", name, created_name), 1, MAX_NAME_LEN)
		if(!t)
			return
		if(!in_range(src, user) && loc != user)
			return
		created_name = t

	else if(iscablecoil(I) && state == 0 && anchored)
		var/obj/item/stack/cable_coil/C = I
		if(C.get_amount() < 1)
			to_chat(user, span_warning("你需要一段线圈来给气闸组件接线."))
			return

		user.visible_message("[user]给气闸组件接线.", "你开始给气闸组件接线.")

		if(!do_after(user, 40, NONE, src, BUSY_ICON_BUILD) || state != 0 || !anchored)
			return

		if(!C.use(1))
			return

		state = 1
		to_chat(user, span_notice("你给气闸接好了线."))

	else if(istype(I, /obj/item/circuitboard/airlock) && state == 1 && I.icon_state != "door_electronics_smoked")
		playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
		user.visible_message("[user]将电子设备安装到气闸组件中.", "你开始将电子设备安装到气闸组件中.")

		if(!do_after(user, 40, NONE, src, BUSY_ICON_BUILD))
			return

		user.drop_held_item()
		I.forceMove(src)
		to_chat(user, span_notice("你安装了气闸电子设备!"))
		state = 2
		name = "Near finished Airlock Assembly"
		electronics = I

	else if(istype(I, /obj/item/stack/sheet) && !glass)
		var/obj/item/stack/sheet/S = I
		if(S.get_amount() < 1)
			return

		if(istype(S, /obj/item/stack/sheet/glass/reinforced))
			playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
			user.visible_message("[user]将[S.name]添加到气闸组件中.", "你开始将[S.name]安装到气闸组件中.")
			if(!do_after(user, 40, NONE, src, BUSY_ICON_BUILD) && !glass)
				return

			if(!S.use(1))
				return

			to_chat(user, span_notice("你将强化玻璃窗安装到气闸组件中."))
			glass = 1

		else if(istype(S, /obj/item/stack/sheet/mineral) && S.sheettype)
			var/M = S.sheettype
			if(S.get_amount() < 2)
				return

			playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
			user.visible_message("[user]将[S.name]添加到气闸组件中.", "你开始将[S.name]安装到气闸组件中.")
			if(!do_after(user, 40, NONE, src, BUSY_ICON_BUILD) && !glass)
				return

			if(!S.use(2))
				return

			to_chat(user, span_notice("你将[M]板材安装到气闸组件中."))
			glass = "[M]"
	update_state()

/obj/structure/door_assembly/welder_act(mob/living/user, obj/item/I)
	. = ..()

	if((!istext(glass) || glass != 1 || anchored))
		return
	var/obj/item/tool/weldingtool/WT = I
	if(!WT.remove_fuel(0, user))
		to_chat(user, span_notice("你需要更多焊接燃料."))
		return
	playsound(loc, 'sound/items/welder2.ogg', 25, 1)
	if(istext(glass))
		user.visible_message("[user]将[glass]板材从气闸组件上焊下来.", "你开始将[glass]板材从气闸组件上焊下来.")
		if(!do_after(user, 40, NONE, src, BUSY_ICON_BUILD))
			return
		if(!WT.isOn())
			return
		to_chat(user, span_notice("你把[glass]板材焊下来了!"))
		var/M = text2path("/obj/item/stack/sheet/mineral/[glass]")
		new M(loc, 2)
		glass = 0
	else if(glass == 1)
		user.visible_message("[user]将玻璃板从气闸组件中焊出来.", "你开始将玻璃板从气闸组件中焊出来.")
		if(!do_after(user, 40, NONE, src, BUSY_ICON_BUILD))
			return
		if(!WT.isOn())
			return
		to_chat(user, span_notice("你把玻璃板焊出来了!"))
		new /obj/item/stack/sheet/glass/reinforced(loc)
		glass = 0
	else if(!anchored)
		user.visible_message("[user]拆解了气闸组件.", "你开始拆解气闸组件.")
		if(!do_after(user, 40, NONE, src, BUSY_ICON_BUILD))
			return
		if(!WT.isOn())
			return
		to_chat(user, span_notice("你拆解了气闸组件!"))
		new /obj/item/stack/sheet/metal(loc, 4)
		qdel(src)
	update_state()

/obj/structure/door_assembly/wrench_act(mob/living/user, obj/item/I)
	. = ..()

	if(state != 0)
		return
	playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
	if(anchored)
		user.visible_message("[user]将气闸组件从地板上松开.", "你开始将气闸组件从地板上松开.")
	else
		user.visible_message("[user]将气闸组件固定在地板上.", "你开始将气闸组件固定在地板上.")
	if(!do_after(user, 40, NONE, src, BUSY_ICON_BUILD))
		return
	to_chat(user, span_notice("你[anchored ? "un" : ""]将气闸组件固定好了!"))
	anchored = !anchored
	update_state()

/obj/structure/door_assembly/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	if(state != 1)
		return
	playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)
	user.visible_message("[user]剪断了气闸组件的电线.", "你开始剪断气闸组件的电线.")
	if(!do_after(user, 4 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return
	to_chat(user, span_notice("你剪断了气闸电线!"))
	new /obj/item/stack/cable_coil(loc, 1)
	state = 0
	update_state()

/obj/structure/door_assembly/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(state != 2)
		return
	playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
	user.visible_message("[user]从气闸组件中移除了电子设备.", "你开始从气闸组件中移除电子设备.")
	if(!do_after(user, 4 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return
	to_chat(user, span_notice("你移除了气闸电子设备!"))
	state = 1
	name = "Wired Airlock Assembly"
	var/obj/item/circuitboard/airlock/AE
	if(!electronics)
		AE = new (loc)
	else
		AE = electronics
		electronics = null
		AE.forceMove(loc)
	update_state()

/obj/structure/door_assembly/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(state != 2)
		return
	playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
	to_chat(user, span_notice("现在完成气闸."))
	if(!do_after(user, 4 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return
	to_chat(user, span_notice("你完成了气闸!"))
	var/path
	if(istext(glass))
		path = text2path("/obj/machinery/door/airlock/[glass]")
	else if(glass == 1)
		path = text2path("/obj/machinery/door/airlock[glass_type]")
	else
		path = text2path("/obj/machinery/door/airlock[airlock_type]")
	var/obj/machinery/door/airlock/A = new path(loc)
	A.assembly_type = type
	A.electronics = electronics
	if(electronics.one_access)
		A.req_access = null
		A.req_one_access = electronics.conf_access
	else
		A.req_access = electronics.conf_access
	if(created_name)
		A.name = created_name
	else
		A.name = "[istext(glass) ? "[glass] airlock" : base_name]"
	electronics.forceMove(A)
	qdel(src)
	update_state()

/obj/structure/door_assembly/proc/update_state()
	icon_state = "door_as_[glass == 1 ? "g" : ""][istext(glass) ? glass : base_icon_state][state]"
	name = ""
	switch (state)
		if(0)
			if (anchored)
				name = "Secured "
		if(1)
			name = "Wired "
		if(2)
			name = "Near Finished "
	name += "[glass == 1 ? "Window " : ""][istext(glass) ? "[glass] Airlock" : base_name] Assembly"
