#define STATE_WRENCHED 1
#define STATE_WELDED 2
#define STATE_WIRED 3
#define STATE_FINISHED 4

/obj/item/frame/camera
	name = "摄像头组件"
	desc = "摄像头的基本构造."
	icon = 'icons/obj/machines/camera.dmi'
	icon_state = "cameracase"

/obj/item/frame/camera/proc/try_build(turf/wall, mob/user)
	if(get_dist(wall, user) > 1)
		return

	var/ndir = get_dir(user, wall)
	if(!(ndir in GLOB.cardinals))
		return

	var/turf/loc = get_turf(user)
	if(!isfloorturf(loc))
		loc.balloon_alert(user, "坏点")
		return

	user.balloon_alert_to_viewers("正在连接")
	playsound(loc, 'sound/machines/click.ogg', 15, 1)
	var/constrdir = REVERSE_DIR(user.dir)
	var/constrloc = user.loc

	if(!do_after(user, 30, NONE, wall, BUSY_ICON_BUILD))
		return

	new /obj/structure/camera_assembly(constrloc, constrdir)

	user.visible_message("[user]将[src]连接到墙上.", \
		"You attach [src] to the wall.")

	qdel(src)

/obj/structure/camera_assembly
	name = "摄像头组件"
	desc = "摄像头的基本构造."
	icon = 'icons/obj/machines/camera.dmi'
	icon_state = "camera_assembly"
	max_integrity = 150
	var/state = STATE_WRENCHED

/obj/structure/camera_assembly/examine(mob/user)
	. = ..()

	switch(state)
		if(STATE_WRENCHED)
			. += span_info("你可以用<b>焊接器</b>将其固定到位, 或用<b>扳手</b>将其移除.")
		if(STATE_WELDED)
			. += span_info("你可以给它添加<b>电线</b>, 或用<b>拆焊</b>将其从墙上取下.")
		if(STATE_WIRED)
			. += span_info("你可以用<b>螺丝刀</b>完成它, 或用<b>拆线</b>开始移除.")
		if(STATE_FINISHED)
			. += span_boldwarning("你不应该看到这个, 告诉程序员!")


/obj/structure/camera_assembly/Initialize(mapload, newDir)
	. = ..()

	if(newDir)
		setDir(newDir)

	switch(dir)
		if(NORTH)
			pixel_y = 16
		if(SOUTH)
			pixel_y = -16
		if(EAST)
			pixel_x = -16
		if(WEST)
			pixel_x = 16

/obj/structure/camera_assembly/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(.)
		return

	if(state == STATE_WELDED)
		if(!istype(I, /obj/item/stack/cable_coil))
			return
		var/obj/item/stack/cable_coil/C = I
		if(!C.use(2))
			to_chat(user, span_warning("你需要两段电缆才能给摄像头接线!"))
			return
		to_chat(user, span_notice("你给[src]添加了电线."))
		state = STATE_WIRED

/obj/structure/camera_assembly/welder_act(mob/living/user, obj/item/I)
	. = ..()
	switch(state)
		if(STATE_WRENCHED)
			if(!weld(I, user))
				return
			to_chat(user, span_notice("你将[src]牢固地焊接到位."))
			anchored = TRUE
			state = STATE_WELDED
		if(STATE_WELDED)
			if(!weld(I, user))
				return
			to_chat(user, span_notice("你从原位拆焊了[src]."))
			anchored = TRUE
			state = STATE_WRENCHED

/obj/structure/camera_assembly/screwdriver_act(mob/user, obj/item/tool)
	. = ..()
	if(.)
		return TRUE

	if(state != STATE_WIRED)
		return FALSE

	tool.play_tool_sound(src)
	var/input = stripped_input(user, "Which networks would you like to connect this camera to? Separate networks with a comma. No Spaces!\nFor example: marinemainship, marine, dropship1, dropship2", "Set Network", "marinemainship")
	if(!input)
		to_chat(user, span_warning("未输入网络."))
		return
	var/list/tempnetwork = splittext(input, ",")
	if(!length(tempnetwork))
		to_chat(user, span_warning("无效的网络输入."))
		return
	for(var/i in tempnetwork)
		tempnetwork -= i
		tempnetwork += lowertext(i)
	state = STATE_FINISHED
	var/obj/machinery/camera/autoname/C = new(loc, dir)
	forceMove(C)
	C.network = tempnetwork
	return TRUE

/obj/structure/camera_assembly/wirecutter_act(mob/user, obj/item/I)
	if(state != STATE_WIRED)
		return FALSE

	new /obj/item/stack/cable_coil(drop_location(), 2)
	I.play_tool_sound(src)
	to_chat(user, span_notice("你切断了电路上的电线."))
	state = STATE_WELDED
	return TRUE

/obj/structure/camera_assembly/wrench_act(mob/user, obj/item/I)
	if(state != STATE_WRENCHED)
		return FALSE
	I.play_tool_sound(src)
	to_chat(user, span_notice("你从原位拆下了[src]."))
	new /obj/item/frame/camera(drop_location())

	qdel(src)
	return TRUE

/obj/structure/camera_assembly/proc/weld(obj/item/tool/weldingtool/W, mob/living/user)
	if(!W.tool_start_check(user, amount = 3))
		return FALSE
	to_chat(user, span_notice("你开始焊接[src]..."))
	if(W.use_tool(src, user, 20, amount = 3, volume = 50))
		return TRUE
	return FALSE

/obj/structure/camera_assembly/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(!(atom_flags & NODECONSTRUCT))
		new /obj/item/stack/sheet/metal(loc)
	return ..()

#undef STATE_WRENCHED
#undef STATE_WELDED
#undef STATE_WIRED
#undef STATE_FINISHED
