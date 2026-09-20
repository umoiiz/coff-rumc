#define TESLA_TURRET_MAX_RANGE 7
#define TESLA_TURRET_COST_PASSIVE 25
#define TESLA_TURRET_COST_ACTIVE 75

/obj/item/tesla_turret
	name = "特斯拉炮塔"
	desc = "一种会吸取附近异形血浆的炮塔。"
	icon = 'icons/obj/machines/deployable/sentry/tesla.dmi'
	icon_state = "tesla_coil_handheld"
	max_integrity = 200

	/// Variables to be used by the deployable, are moved into the deployable when deployed and back when undeployed.
	/// Range, duh.
	var/max_range = TESLA_TURRET_MAX_RANGE
	/// Battery to run on
	var/obj/item/cell/battery
	/// Cost for having active but doing nothing
	var/passive_cost = TESLA_TURRET_COST_PASSIVE
	/// Cost PER XENO to drain on shock
	var/active_cost = TESLA_TURRET_COST_ACTIVE

/obj/item/tesla_turret/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/deployable_item, /obj/machinery/deployable/tesla_turret, 2 SECONDS, 4 SECONDS)

/obj/item/tesla_turret/Destroy()
	QDEL_NULL(battery)
	return ..()

/obj/item/tesla_turret/examine(mob/user)
	. = ..()
	if(!in_range(src, user))
		return
	if(!battery)
		. += span_warning("它缺少电池,无法开启。")
		return
	. += span_notice("里面有\a [battery]。剩余[battery.charge]/[battery.maxcharge]。")
	. += span_notice("<b>手持使用</b>或<b>右键点击</b>以移除它。")

/obj/item/tesla_turret/get_mechanics_info()
	. = ..()
	. += "It has a range of [max_range] tile\s."
	. += "<br>"
	. += "It passively uses [passive_cost] power."
	. += "<br>"
	. += "It will drain [active_cost] power per xenomorph hit."

/obj/item/tesla_turret/attack_self(mob/living/user)
	. = ..()
	if(!in_range(src, user))
		return
	if(!battery)
		balloon_alert(user, "没有电池")
		return
	user.put_in_hands(battery)
	balloon_alert(user, "已取出电池")
	battery = null

/obj/item/tesla_turret/attack_hand_alternate(mob/living/user)
	. = ..()
	if(!in_range(src, user))
		return
	if(!battery)
		balloon_alert(user, "没有电池")
		return
	user.put_in_hands(battery)
	balloon_alert(user, "已取出电池")
	battery = null

/obj/item/tesla_turret/attackby(obj/item/cell/inserting_item, mob/user, params)
	. = ..()
	if(!istype(inserting_item))
		return
	if(istype(inserting_item, /obj/item/cell/lasgun))
		balloon_alert(user, "放不进去")
		return
	if(battery)
		balloon_alert(user, "已经有")
		return
	if(!user.temporarilyRemoveItemFromInventory(inserting_item))
		return

	battery = inserting_item
	battery.moveToNullspace()
	return TRUE

/obj/machinery/deployable/tesla_turret
	icon = 'icons/obj/machines/deployable/sentry/tesla.dmi'
	icon_state = "defense_base_off"
	base_icon_state = "defense_base"
	density = TRUE
	anchored = TRUE
	resistance_flags = XENO_DAMAGEABLE
	allow_pass_flags = PASSABLE
	hud_possible = list(MACHINE_HEALTH_HUD, MACHINE_AMMO_HUD)
	/// Range, duh.
	var/max_range = TESLA_TURRET_MAX_RANGE
	/// Battery to run on
	var/obj/item/cell/battery
	/// Is this running
	VAR_PRIVATE/active = FALSE
	/// Cost for having active but doing nothing
	var/passive_cost = TESLA_TURRET_COST_PASSIVE
	/// Cost PER XENO to drain on shock
	var/active_cost = TESLA_TURRET_COST_ACTIVE

/obj/machinery/deployable/tesla_turret/Initialize(mapload, obj/item/tesla_turret/internal_item, mob/deployer)
	. = ..()
	if(internal_item)
		max_range = internal_item.max_range
		passive_cost = internal_item.passive_cost
		active_cost = internal_item.active_cost

		battery = internal_item.battery
		internal_item.battery = null

/obj/machinery/deployable/tesla_turret/Destroy()
	QDEL_NULL(battery)
	return ..()

/obj/machinery/deployable/tesla_turret/examine(mob/user)
	. = ..()
	if(!in_range(src, user))
		return
	if(!battery)
		. += span_warning("它缺少电池,无法开启.")
		return
	. += span_notice("里面有\a [battery]. 剩余[battery.charge]/[battery.maxcharge].")
	. += span_notice("<b>右键</b>将其取出.")
	if(!active)
		return
	. += span_warning("它当前处于激活状态.")

/obj/machinery/deployable/tesla_turret/get_mechanics_info()
	. = ..()
	. += "<br>"
	. += "It has a range of [max_range] tile\s."
	. += "<br>"
	. += "It passively uses [passive_cost] power."
	. += "<br>"
	. += "It will drain [active_cost] power per xenomorph hit."

/obj/machinery/deployable/tesla_turret/attackby(obj/item/cell/inserting_item, mob/user, params)
	. = ..()
	if(!istype(inserting_item))
		return
	if(istype(inserting_item, /obj/item/cell/lasgun))
		balloon_alert(user, "放不进去")
		return
	if(battery)
		balloon_alert(user, "已经有")
		return
	if(!user.temporarilyRemoveItemFromInventory(inserting_item))
		return

	battery = inserting_item
	battery.moveToNullspace()
	update_appearance(UPDATE_ICON)
	return TRUE

/obj/machinery/deployable/tesla_turret/attack_hand_alternate(mob/living/user)
	. = ..()
	if(!in_range(src, user))
		return
	if(!battery)
		balloon_alert(user, "没有电池")
		return
	if(active)
		balloon_alert(user, "先关闭")
		return
	user.put_in_hands(battery)
	battery = null
	balloon_alert(user, "已取出电池")
	update_appearance(UPDATE_ICON)

/obj/machinery/deployable/tesla_turret/interact(mob/user)
	. = ..()
	if(isdead(user))
		return
	if(!battery)
		balloon_alert(user, "没有电池")
		return
	if(!battery.use(0))
		balloon_alert(user, "没有电力")
		return
	toggle(!active)

/obj/machinery/deployable/tesla_turret/proc/toggle(state, silent = FALSE)
	if(state)
		active = TRUE
		START_PROCESSING(SSobj, src)
		if(!silent)
			balloon_alert_to_viewers("已开启")
	else
		active = FALSE
		STOP_PROCESSING(SSobj, src)
		if(!silent)
			balloon_alert_to_viewers("已关闭")
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/deployable/tesla_turret/process()
	if(!battery || !active || !battery.use(0))
		balloon_alert_to_viewers("关闭了!")
		toggle(FALSE, TRUE)
		return
	if(battery.use(passive_cost))
		/// Needs to have enough charge to hit at least one xeno
		var/max_targets = max(trunc(battery.charge / active_cost), 0)
		if(!max_targets)
			hud_set_tesla_battery()
			return
		var/xeno_amount = length(zap_beam(src, max_range, 4, max_targets = max_targets))
		if(!xeno_amount)
			hud_set_tesla_battery()
			return
		battery.use(active_cost * xeno_amount)
		playsound(src, 'sound/weapons/guns/fire/tesla.ogg', 60, TRUE)
	else
		balloon_alert_to_viewers("关闭了!")
		toggle(FALSE, TRUE)
	hud_set_tesla_battery()

/obj/machinery/deployable/tesla_turret/disassemble(mob/marine)
	if(active)
		if(shock(marine, 70))
			balloon_alert_to_viewers("冒火花!")
		else
			balloon_alert(marine, "先关闭!")
		return
	return ..()

/obj/machinery/deployable/tesla_turret/post_disassemble(mob/user)
	. = ..()
	if(!.)
		return

	var/obj/item/tesla_turret/internal = internal_item.resolve()
	if(!internal)
		return
	internal.max_range = max_range
	internal.passive_cost = passive_cost
	internal.active_cost = active_cost

	internal.battery = battery
	battery = null

/obj/machinery/deployable/tesla_turret/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][battery ? "" : "_off"]"
	hud_set_tesla_battery()

/obj/machinery/deployable/tesla_turret/update_overlays()
	. = ..()
	. += "tesla_coil[active ? "_on" : ""]"
	hud_set_tesla_battery()

/// I hate this so much, thank you for having a flag called pass_projectile but it only does so up to proj.ammo.barricade_clear_distance
/obj/machinery/deployable/tesla_turret/projectile_hit(atom/movable/projectile/proj, cardinal_move, uncrossing)
	if(src != proj.original_target)
		return FALSE

	return ..()

#undef TESLA_TURRET_MAX_RANGE
#undef TESLA_TURRET_COST_PASSIVE
#undef TESLA_TURRET_COST_ACTIVE
