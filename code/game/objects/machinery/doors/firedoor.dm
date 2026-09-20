#define FIREDOOR_MAX_PRESSURE_DIFF 25 // kPa
#define FIREDOOR_MAX_TEMP 50 // °C
#define FIREDOOR_MIN_TEMP 0

// Bitflags
#define FIREDOOR_ALERT_HOT 1
#define FIREDOOR_ALERT_COLD 2

/obj/machinery/door/firedoor
	name = "\improper Emergency Shutter"
	desc = "紧急气密闸门,能够封闭破损区域。"
	icon = 'icons/obj/doors/DoorHazard.dmi'
	icon_state = "door_open"
	req_one_access = list(ACCESS_CIVILIAN_ENGINEERING)
	opacity = FALSE
	density = FALSE
	obj_flags = CAN_BE_HIT
	allow_pass_flags = NONE
	layer = BELOW_OPEN_DOOR_LAYER
	open_layer = BELOW_OPEN_DOOR_LAYER // Just below doors when open
	closed_layer = CLOSED_FIREDOOR_LAYER // Just above doors when closed
	power_channel = ENVIRON
	use_power = TRUE
	idle_power_usage = 5
	active_power_usage = 360
	var/blocked = FALSE
	/// When the door has detected a problem, it locks.
	var/lockdown = FALSE
	var/pdiff_alert = FALSE
	var/pdiff = FALSE
	var/nextstate = null
	var/net_id
	var/list/areas_added
	var/list/users_to_open = new
	var/next_process_time = 0
	var/list/tile_info[4]
	/// 4 dirs, bitflags
	var/list/dir_alerts[4]

	/// MUST be in same order as FIREDOOR_ALERT_*
	var/list/ALERT_STATES=list(
		"hot",
		"cold"
	)

/obj/machinery/door/firedoor/Initialize(mapload)
	. = ..()
	for(var/obj/machinery/door/firedoor/F in loc)
		if(F == src)
			continue
		atom_flags |= INITIALIZED
		return INITIALIZE_HINT_QDEL
	var/area/A = get_area(src)
	RegisterSignal(A, COMSIG_AREA_FIRE_ALARM_SET, PROC_REF(on_fire_alarm))

	ASSERT(istype(A))
	areas_added = list(A)

	for(var/direction as anything in GLOB.cardinals)
		A = get_area(get_step(src,direction))
		if(istype(A) && !(A in areas_added))
			areas_added += A

/obj/machinery/door/firedoor/examine(mob/user) // todo remove the shitty o vars
	. = ..()
	if(get_dist(src, user) > 1 && !isAI(user))
		return

	if(pdiff >= FIREDOOR_MAX_PRESSURE_DIFF)
		. += span_warning("警告:当前压差为[pdiff]kPa!开门可能导致受伤!")

	. += "<b>Sensor readings:</b>"
	for(var/index = 1; index <= length(tile_info); index++)
		var/o = "&nbsp;&nbsp;"
		switch(index)
			if(1)
				o += "NORTH: "
			if(2)
				o += "SOUTH: "
			if(3)
				o += "EAST: "
			if(4)
				o += "WEST: "
		if(tile_info[index] == null)
			o += span_warning("数据不可用")
			. += o
			continue
		var/celsius = convert_k2c(tile_info[index][1])
		var/pressure = tile_info[index][2]
		if(dir_alerts[index] & (FIREDOOR_ALERT_HOT|FIREDOOR_ALERT_COLD))
			o += "<span class='warning'>"
		else
			o += "<span style='color:blue'>"
		o += "[celsius]&deg;C</span> "
		o += "<span style='color:blue'>"
		o += "[pressure]kPa</span></li>"
		. += o

	if(islist(users_to_open) && length(users_to_open))
		var/users_to_open_string = users_to_open[1]
		if(length(users_to_open) >= 2)
			for(var/i = 2 to length(users_to_open))
				users_to_open_string += ", [users_to_open[i]]"
		. += "These people have opened \the [src] during an alert: [users_to_open_string]."

/obj/machinery/door/firedoor/Bumped(atom/AM)
	if(CHECK_BITFIELD(machine_stat, PANEL_OPEN) || operating)
		return
	if(!density)
		return ..()
	return FALSE

/obj/machinery/door/firedoor/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(xeno_attacker.status_flags & INCORPOREAL)
		return FALSE

	var/turf/cur_loc = xeno_attacker.loc
	if(blocked)
		to_chat(xeno_attacker, span_warning("\The [src]被焊接封死了。"))
		return FALSE
	if(!istype(cur_loc))
		return FALSE //Some basic logic here
	if(!density)
		to_chat(xeno_attacker, span_warning("\The [src]已经打开了!"))
		return FALSE

	playsound(loc, 'sound/effects/metal_creaking.ogg', 25, 1)
	xeno_attacker.visible_message(span_warning("\The [xeno_attacker]插入\the [src]并开始撬开它。"), \
	span_warning("我们插入\the [src]并开始撬开它。"), null, 5)

	if(do_after(xeno_attacker, 30, IGNORE_HELD_ITEM, src, BUSY_ICON_BUILD))
		if(blocked)
			to_chat(xeno_attacker, span_warning("\The [src]被焊接封死了。"))
			return FALSE
		if(density) //Make sure it's still closed
			INVOKE_ASYNC(src, PROC_REF(xeno_open), xeno_attacker)

/obj/machinery/door/firedoor/proc/xeno_open(mob/living/carbon/xenomorph/xeno_attacker)
	open(TRUE)
	xeno_attacker.visible_message(span_danger("\The [xeno_attacker]撬开了\the [src]。"), \
	span_danger("我们撬开了\the [src]。"), null, 5)

/obj/machinery/door/firedoor/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(operating)
		return//Already doing something.

	if(blocked)
		to_chat(user, span_warning("\The [src]被焊死了!"))
		return

	var/alarmed = lockdown
	//Checks if there are fire alarms in any areas associated with that firedoor
	for(var/area/A as anything in areas_added)
		if(!A.fire_alarm)
			continue
		alarmed = TRUE

	if(user.incapacitated() || (!user.canmove && !isAI(user)) || (get_dist(src, user) > 1  && !isAI(user)))
		to_chat(user, "抱歉,你必须保持身体健全并靠近\the [src]才能使用它。")
		return
	if(density && (machine_stat & (BROKEN|NOPOWER))) //can still close without power
		to_chat(user, "\The [src]无法运作,你必须手动强行打开它。")
		return

	if(alarmed && density && lockdown && !allowed(user))
		to_chat(user, span_warning("拒绝进入。请等待当局到达,或等待警报解除。"))
		return
	else
		user.visible_message(span_notice("\The [src][density ? "open" : "close"]了\the [user]。"),\
		span_warning("\The [src] [density ? "opens" : "closes"]."),\
		span_hear("你听到一声哔声,然后一扇门打开了。"))

	var/needs_to_close = FALSE
	if(density)
		if(alarmed)
			// Accountability!
			users_to_open |= user.name
			needs_to_close = TRUE
		open()
	else
		close()

	if(needs_to_close)
		addtimer(CALLBACK(src, PROC_REF(closing_process)), 5 SECONDS)

/obj/machinery/door/firedoor/proc/closing_process()
	var/alarmed = FALSE
	for(var/area/A as anything in areas_added) // Just in case a fire alarm is turned off while the firedoor is going through an autoclose cycle
		if(!A.fire_alarm)
			continue
		alarmed = TRUE
	if(alarmed)
		nextstate = FIREDOOR_CLOSED
		close()

/obj/machinery/door/firedoor/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(operating)
		return

	if(blocked)
		user.visible_message(span_danger("\The [user]用\a [I]撬\the [src],但\the [src]被焊接固定住了!"),\
		"You try to pry \the [src] [density ? "open" : "closed"], but it is welded in place!",\
		"You hear someone struggle and metal straining.")

	else if(I.pry_capable) // fucking shitcode
		user.visible_message(span_danger("\The [user]开始用\a [I]强行\the [src][density ? "open" : "closed"]!"),\
				span_notice("你开始用\the [I]强行\the [src][density ? "open" : "closed"]!"),\
				"You hear metal strain.")
		var/old_density = density

		if(!do_after(user, 30, NONE, src, BUSY_ICON_HOSTILE))
			return

		if(blocked || density != old_density)
			return

		user.visible_message(span_danger("\The [user]用\a [I]强行\the [blocked ? "welded " : "" ][name][density ? "open" : "closed"]!"),\
			span_notice("你用\the [I]强行\the [blocked ? "welded " : ""][name][density ? "open" : "closed"]!"),\
			"You hear metal strain and groan, and a door [density ? "opening" : "closing"].")

		if(density)
			open(TRUE)
		else
			close()

/obj/machinery/door/firedoor/welder_act(mob/living/user, obj/item/tool/weldingtool/W)
	. = ..()
	if(!W.remove_fuel(0, user))
		return
	balloon_alert_to_viewers("开始[blocked ? "unwelding" : "welding"]")
	if(!do_after(user, 3 SECONDS, NONE, src, BUSY_ICON_GENERIC))
		balloon_alert_to_viewers("停止焊接")
		return
	blocked = !blocked
	balloon_alert_to_viewers("[blocked ? "welds" : "unwelds"]防火门")
	user.visible_message(span_danger("\The [user][blocked ? "welds" : "unwelds"]\the [src]用\a [W]。"),\
		span_notice("你[blocked ? "weld" : "unweld"]\the [src]用\the [W]。"),\
		span_notice("你听到有东西正在被焊接。"))
	playsound(src, 'sound/items/welder.ogg', 25, 1)
	update_icon()

/obj/machinery/door/firedoor/try_to_activate_door(mob/user)
	return

/obj/machinery/door/firedoor/proc/latetoggle()
	if(operating || !nextstate)
		return
	switch(nextstate)
		if(FIREDOOR_OPEN)
			nextstate = null
			open()
		if(FIREDOOR_CLOSED)
			nextstate = null
			close()

/obj/machinery/door/firedoor/close()
	latetoggle()
	return ..()

/obj/machinery/door/firedoor/open(forced = 0)
	if(!forced)
		if(machine_stat & (BROKEN|NOPOWER))
			return //needs power to open unless it was forced
		else
			use_power(active_power_usage)
	latetoggle()
	return ..()

/obj/machinery/door/firedoor/do_animate(animation)
	switch(animation)
		if("opening")
			flick("door_opening", src)
		if("closing")
			flick("door_closing", src)
	playsound(loc, 'sound/machines/emergency_shutter.ogg', 25)

/obj/machinery/door/firedoor/update_icon_state()
	. = ..()
	if(density)
		icon_state = "door_closed"
	else
		icon_state = "door_open"

/obj/machinery/door/firedoor/update_overlays()
	. = ..()
	if(density)
		if(blocked)
			. += "welded"
		if(pdiff_alert)
			. += "palert"
		if(dir_alerts)
			for(var/d=1;d<=4;d++)
				var/cdir = GLOB.cardinals[d]
				for(var/i=1;i<=length(ALERT_STATES);i++)
					if(dir_alerts[d] & (1<<(i-1)))
						. += new/icon(icon,"alert_[ALERT_STATES[i]]", dir=cdir)
	else
		if(blocked)
			. += "welded_open"

/obj/machinery/door/firedoor/psi_act(psi_power, mob/living/user)
	if(operating)
		to_chat(user, span_warning("防火门已经在移动了。"))
		return
	if(blocked)
		to_chat(user, span_warning("防火门被焊接封死了。"))
		return
	return ..()

/obj/machinery/door/firedoor/proc/on_fire_alarm(datum/source, turned_on)
	SIGNAL_HANDLER
	if(blocked)
		return
	if(turned_on)
		if(operating)
			nextstate = FIREDOOR_CLOSED
			return
		if(!density)
			close()
		return
	if(operating)
		nextstate = OPEN
		return
	if(density)
		open()

/obj/machinery/door/firedoor/mainship
	name = "\improper Emergency Shutter"
	desc = "紧急气密闸门,能够封闭破损区域。"
	icon = 'icons/obj/doors/mainship/purinadoor.dmi'
	icon_state = "door_open"
	openspeed = 4

/obj/machinery/door/firedoor/multi_tile
	icon = 'icons/obj/doors/DoorHazard2x1.dmi'
	width = 2

/obj/machinery/door/firedoor/border_only
	icon = 'icons/obj/doors/edge_Doorfire.dmi'
	atom_flags = ON_BORDER
	allow_pass_flags = PASS_GLASS

/obj/machinery/door/firedoor/border_only/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_try_exit)
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/machinery/door/firedoor/border_only/closed
	icon_state = "door_closed"
	opacity = TRUE
	density = TRUE
