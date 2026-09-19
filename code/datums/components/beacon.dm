///This component is used to give stuff beacon functionality.
/datum/component/beacon
	///Is the beacon active?
	var/active = FALSE
	///The reference to the beacon datum
	var/datum/supply_beacon/beacon_datum
	///The camera attached to the beacon
	var/obj/machinery/camera/beacon_cam
	///Should the parent anchor on activation?
	var/anchor = FALSE
	///How long it takes for this item to activate it's signal/deploy
	var/anchor_time = 0
	///The icon state when this beacon is active
	var/active_icon_state = ""
	///The icon state of minimap marker
	var/minimap_icon = ""
	///The mob who activated this beacon
	var/mob/activator

/datum/component/beacon/Initialize(_anchor = FALSE, _anchor_time = 0, _active_icon_state = "", _minimap_icon = "")
	. = ..()
	if(_anchor && !_anchor_time || !_anchor && _anchor_time)
		stack_trace("The beacon component has been added to [parent.type] and is missing either the anchor var or the time to anchor")
		return COMPONENT_INCOMPATIBLE
	if(!ismovableatom(parent)) //if some goober admin tries to add it to a turf or something
		return COMPONENT_INCOMPATIBLE
	anchor = _anchor
	anchor_time = _anchor_time
	active_icon_state = _active_icon_state
	minimap_icon = _minimap_icon

/datum/component/beacon/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, PROC_REF(on_attack_self))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_NAME, PROC_REF(on_update_name))
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attack_hand))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_ICON_STATE, PROC_REF(on_update_icon_state))
	RegisterSignal(parent, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_z_change))

/datum/component/beacon/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_ITEM_ATTACK_SELF,
		COMSIG_ATOM_UPDATE_NAME,
		COMSIG_ATOM_ATTACK_HAND,
		COMSIG_ATOM_EXAMINE,
		COMSIG_ATOM_UPDATE_ICON_STATE,
		COMSIG_MOVABLE_Z_CHANGED,
		))
	QDEL_NULL(beacon_datum)
	QDEL_NULL(beacon_cam)
	activator = null

///Toggles the active state of the beacon
/datum/component/beacon/proc/toggle_activation(atom/movable/source, mob/user)
	active = !active

	if(active)
		INVOKE_ASYNC(src, PROC_REF(activate), source, user)
	else
		INVOKE_ASYNC(src, PROC_REF(deactivate), source, user)

///The proc that gets called when the user uses the item in their hand
/datum/component/beacon/proc/on_attack_self(atom/movable/source, mob/user)
	SIGNAL_HANDLER

	if(!ishuman(user))
		return

	if(length(user.do_actions))
		user.balloon_alert(user, "忙碌!")
		return

	INVOKE_ASYNC(src, PROC_REF(toggle_activation), source, user)

///This will only get called when you want to deactivate a beacon, ie clicking a deployed beacon
/datum/component/beacon/proc/on_attack_hand(atom/movable/source, mob/user)
	if(!source.anchored || !ishuman(user))
		return

	if(length(user.do_actions))
		user.balloon_alert(user, "忙碌!")
		return

	INVOKE_ASYNC(src, PROC_REF(deactivate), source, user)

///Activates the beacon
/datum/component/beacon/proc/activate(atom/movable/source, mob/user)
	var/turf/location = get_turf(source)
	var/area/A = get_area(location)
	if(A && istype(A) && A.ceiling >= CEILING_DEEP_UNDERGROUND)
		to_chat(user, span_warning("如果你站在地下深处,这不会起作用."))
		active = FALSE
		return FALSE

	if(istype(A, /area/shuttle/dropship))
		to_chat(user, span_warning("你必须在外面的运输机旁才能使用它,否则无法传输."))
		active = FALSE
		return FALSE

	if(length(user.do_actions))
		user.balloon_alert(user, "忙碌!")
		active = FALSE
		return

	if(anchor && anchor_time)
		var/delay = max(1.5 SECONDS, anchor_time - 2 SECONDS * user.skills.getRating(SKILL_LEADERSHIP))
		user.visible_message(span_notice("[user]开始在地面上设置[source]."),
		span_notice("你开始在地面上设置[source]并输入它所需的所有数据."))
		if(!do_after(user, delay, NONE, source))
			user.balloon_alert(user, "保持不动!")
			active = FALSE
			return

	activator = user

	if(anchor) //Only anchored beacons have cameras and lights
		var/obj/machinery/camera/beacon_cam/BC = new(source, "[user.get_paygrade()] [user.name] [source]")
		user.dropItemToGround(source)
		beacon_cam = BC
		source.anchored = TRUE
		source.layer = ABOVE_OBJ_LAYER
		source.set_light(2, 1)
		var/marker_flags = GLOB.faction_to_minimap_flag[user.faction]
		if(!marker_flags)
			marker_flags = MINIMAP_FLAG_MARINE
		if(minimap_icon)
			SSminimaps.add_marker(source, marker_flags, image('icons/UI_icons/map_blips.dmi', null, minimap_icon, MINIMAP_BLIPS_LAYER))

	message_admins("[ADMIN_TPMONTY(user)] set up a supply beacon.") //do something with this
	playsound(source, 'sound/machines/twobeep.ogg', 15, 1)
	user.visible_message("[user]激活了[source]的信号.")
	user.show_message(span_notice("[source]发出哔声并显示,\"你当前的坐标已被补给控制台登记. 经度 [location.x]. 纬度 [location.y]. 区域ID: [get_area(source)]\""), EMOTE_AUDIBLE, span_notice("[source]震动了,但你听不到它!"))
	beacon_datum = new /datum/supply_beacon("[user.name] + [A]", get_turf(source), user.faction)
	RegisterSignal(beacon_datum, COMSIG_QDELETING, PROC_REF(clean_beacon_datum))
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_SUPPLY_BEACON_CREATED, src)
	source.update_appearance()

///Deactivates the beacon
/datum/component/beacon/proc/deactivate(atom/movable/source, mob/user)
	if(length(user?.do_actions))
		user.balloon_alert(user, "忙碌!")
		active = TRUE
		return
	if(source.anchored)
		if(user)
			var/delay = max(1 SECONDS, anchor_time * 0.5 - 2 SECONDS * user.skills.getRating(SKILL_LEADERSHIP)) //Half as long as setting it up.
			user.visible_message(span_notice("[user]开始从地面上移除[source]."),
			span_notice("你开始从地面上移除[source],将其停用."))
			if(!do_after(user, delay, NONE, source, BUSY_ICON_GENERIC))
				user.balloon_alert(user, "保持不动!")
				active = TRUE
				return
			user.put_in_active_hand(source)
		source.anchored = FALSE
		source.layer = initial(source.layer)
		source.set_light(0)
		SSminimaps.remove_marker(source)

	user.show_message(span_warning("[source]发出哔声并显示,\"你的最后位置已无法被补给控制台访问."), EMOTE_AUDIBLE, span_notice("[source]震动了,但你听不到它!"))
	source.visible_message(span_warning("[source]停止发出信号."))
	QDEL_NULL(beacon_cam)
	QDEL_NULL(beacon_datum)
	activator = null
	playsound(source, 'sound/machines/twobeep.ogg', 15, 1)
	active = FALSE //this is here because of attack hand
	source.update_appearance()

///Adds an extra line of instructions to the examine
/datum/component/beacon/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_notice("在手中激活以创建补给信标信号.")

///If the signal source dies, the beacon datum should as well
/datum/component/beacon/proc/clean_beacon_datum()
	SIGNAL_HANDLER
	beacon_datum = null

///Gives the beacon broadcaster object the appropriate, descriptive name
/datum/component/beacon/proc/on_update_name(atom/source, updates)
	SIGNAL_HANDLER
	if(active)
		source.name += " - [get_area(source)] - [activator]"
		return
	source.name = initial(source.name)

///Updates the icon state of the object to an active state, if it has one
/datum/component/beacon/proc/on_update_icon_state(atom/source, updates)
	SIGNAL_HANDLER
	if(active && active_icon_state)
		source.icon = icon(source.icon, active_icon_state)
	else
		source.icon = initial(source.icon)

///What happens when we change Z level
/datum/component/beacon/proc/on_z_change(atom/source, old_z, new_z)
	SIGNAL_HANDLER
	if(active)
		beacon_datum.drop_location = get_turf(source)
		return

/datum/component/beacon/ai_droid/RegisterWithParent()
	RegisterSignal(parent, COMSIG_UNMANNED_COORDINATES, PROC_REF(toggle_activation))

/datum/component/beacon/antenna/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(on_z_change))

/datum/supply_beacon
	/// Name printed on the supply console
	var/name = ""
	/// Where the supply drops will land
	var/turf/drop_location
	/// The faction of the beacon
	var/faction = ""

/datum/supply_beacon/New(_name, turf/_drop_location, _faction, life_time = 0 SECONDS)
	name = _name
	drop_location = _drop_location
	faction = _faction
	GLOB.supply_beacon[name] = src
	if(life_time)
		QDEL_IN(src, life_time)

/// Remove that beacon from the list of glob supply beacon
/datum/supply_beacon/Destroy()
	GLOB.supply_beacon -= name
	return ..()
