#define TELEPORTING_COST 650

//get_acid_delay() usese for how long it take time to apply acid on item/object/wall. References from code/game/atoms/_atom.dm code/game/turfs/walls/r_wall.dm code/game/turfs/walls/walls.dm
//acid dealay for deployable teleporter machinery
/obj/machinery/deployable/teleporter/get_acid_delay()
	return 4 SECONDS

/obj/machinery/deployable/teleporter
	density = FALSE
	max_integrity = 200
	resistance_flags = XENO_DAMAGEABLE
	idle_power_usage = 50
	///List of all teleportable types
	var/static/list/teleportable_types = list(
		/obj/structure/closet,
		/mob/living/carbon/human,
		/obj/machinery,
	)
	///List of banned teleportable types
	var/static/list/blacklisted_types = list(
		/obj/machinery/nuclearbomb
	)

/obj/machinery/deployable/teleporter/examine(mob/user)
	. = ..()
	var/obj/item/teleporter_kit/kit = get_internal_item()
	if(!kit?.cell)
		. += span_notice("它目前缺少电池.")
	else
		var/charges_left = round(kit.cell.charge / TELEPORTING_COST)
		if(charges_left <= 0)
			. += span_notice("它已经没有剩余电量用于传送了!")
		else
			. += span_notice("它还剩余[charges_left]次传送的电量.")
	if(kit?.linked_teleporter)
		. += span_notice("它目前与位于[get_area(kit.linked_teleporter)]的传送器#[kit.linked_teleporter.self_tele_tag]相连.")
	else
		. += span_notice("它没有与任何其他传送器相连.")

/obj/machinery/deployable/teleporter/Initialize(mapload)
	. = ..()
	SSminimaps.add_marker(src, MINIMAP_FLAG_MARINE, image('icons/UI_icons/map_blips.dmi', null, "teleporter", MINIMAP_BLIPS_LAYER))

/obj/machinery/deployable/teleporter/attack_hand(mob/living/user)
	. = ..()
	var/obj/item/teleporter_kit/kit = get_internal_item()
	if(!istype(kit))
		CRASH("A teleporter didn't have an internal item, or it was of the wrong type.")

	if(!powered() && (!kit.cell || kit.cell.charge < TELEPORTING_COST))
		to_chat(user, span_warning("\the [src]上红灯闪烁. 似乎电量不足."))
		playsound(loc,'sound/machines/buzz-two.ogg', 25, FALSE)
		return

	if(!COOLDOWN_FINISHED(kit, teleport_cooldown))
		to_chat(user, span_warning("\The [src]仍在充能! 它将在[round(COOLDOWN_TIMELEFT(kit, teleport_cooldown) * 0.1)]秒后准备就绪."))
		return

	if(!kit.linked_teleporter)
		to_chat(user, span_warning("\The [src]没有与任何其他传送器相连."))
		return

	if(!istype(kit.linked_teleporter.loc, /obj/machinery/deployable/teleporter))
		to_chat(user, span_warning("另一个传送器尚未部署!"))
		return

	var/obj/machinery/deployable/teleporter/deployed_linked_teleporter = kit.linked_teleporter.loc
	var/obj/item/teleporter_kit/linked_kit = deployed_linked_teleporter.get_internal_item()

	if(deployed_linked_teleporter.z != z)
		to_chat(user, span_warning("[src]和[deployed_linked_teleporter]相距太远!"))
		return

	if(!deployed_linked_teleporter.powered() && (!linked_kit?.cell || linked_kit.cell.charge < TELEPORTING_COST))
		to_chat(user, span_warning("[deployed_linked_teleporter]没有通电!"))
		return

	var/list/atom/movable/teleporting = list()
	for(var/atom/movable/thing in loc)
		if(is_type_in_list(thing, blacklisted_types))
			continue
		if(is_type_in_list(thing, teleportable_types) && !thing.anchored)
			teleporting += thing

	if(!length(teleporting))
		to_chat(user, span_warning("在[src]上未检测到可传送的内容!"))
		return

	do_sparks(5, TRUE, src)
	playsound(loc,'sound/effects/phasein.ogg', 50, FALSE)
	COOLDOWN_START(kit, teleport_cooldown, 2 SECONDS)
	COOLDOWN_START(linked_kit, teleport_cooldown, 2 SECONDS)
	if(powered())
		use_power(TELEPORTING_COST * 100)
	else
		kit.cell.charge -= TELEPORTING_COST
		balloon_alert_to_viewers("已使用内部电量")
		playsound(src, 'sound/machines/twobeep.ogg', 15, 1)
	update_icon()
	if(deployed_linked_teleporter.powered())
		deployed_linked_teleporter.use_power(TELEPORTING_COST * 100)
	else
		linked_kit.cell.charge -= TELEPORTING_COST
		deployed_linked_teleporter.balloon_alert_to_viewers("已使用内部电量")
		playsound(deployed_linked_teleporter, 'sound/machines/twobeep.ogg', 15, 1)
	deployed_linked_teleporter.update_icon()
	for(var/atom/movable/thing_to_teleport AS in teleporting)
		thing_to_teleport.forceMove(get_turf(deployed_linked_teleporter))

/obj/machinery/deployable/teleporter/attack_ghost(mob/dead/observer/user)
	. = ..()
	var/obj/item/teleporter_kit/kit = get_internal_item()
	if(!kit.linked_teleporter)
		return
	user.forceMove(get_turf(kit.linked_teleporter))

/obj/machinery/deployable/teleporter/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(!user)
		return
	var/obj/item/teleporter_kit/kit = get_internal_item()
	if(!istype(kit))
		CRASH("A teleporter didn't have an internal item, or it was of the wrong type.")
	if(!kit.cell)
		to_chat(user, span_warning("没有电池可移除!"))
		return
	if(!do_after(user, 2 SECONDS, NONE, src))
		return FALSE
	playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
	to_chat(user , span_notice("你从\the [src]中取出了[kit.cell]."))
	user.put_in_hands(kit.cell)
	kit.cell = null
	update_icon()

/obj/machinery/deployable/teleporter/attackby(obj/item/I, mob/user, params)
	if(!ishuman(user))
		return FALSE
	var/obj/item/teleporter_kit/kit = get_internal_item()
	if(!istype(kit))
		CRASH("A teleporter didn't have an internal item, or it was of the wrong type.")

	if(istype(I, /obj/item/teleporter_kit))
		if(kit.linked_teleporter)
			balloon_alert(user, "该传送器已与另一个相连!")
			return
		balloon_alert(user, "你将两个传送器互相连接.")

		var/obj/item/teleporter_kit/gadget = I
		kit.set_linked_teleporter(gadget)
		gadget.set_linked_teleporter(kit)

	if(!istype(I, /obj/item/cell))
		return FALSE
	if(kit?.cell)
		to_chat(user , span_warning("里面已经有一个电池了,用撬棍把它取出来."))
		return FALSE
	if(!do_after(user, 2 SECONDS, NONE, src))
		return FALSE
	user.temporarilyRemoveItemFromInventory(I)
	I.forceMove(kit)
	kit.cell = I
	playsound(loc, 'sound/items/deconstruct.ogg', 25, 1)
	update_icon()

/obj/machinery/deployable/teleporter/update_icon_state()
	. = ..()
	var/obj/item/teleporter_kit/kit = get_internal_item()
	if(powered() || kit?.cell?.charge > TELEPORTING_COST)
		icon_state = default_icon_state + "_on"
		return
	icon_state = default_icon_state

//acid delay for teleporter item
/obj/item/teleporter_kit/get_acid_delay()
	return 4 SECONDS

/obj/item/teleporter_kit
	name = "\improper ASRS 蓝空间传送器"
	desc = "一种蓝空间传送垫,用于将人员和设备短距离移动到另一个预先链接的传送器.如果区域断电,则使用内置电池提供传送."
	icon = 'icons/obj/machines/teleporter.dmi'
	icon_state = "teleporter"

	max_integrity = 200
	deploy_flags = IS_DEPLOYABLE|DEPLOYED_WRENCH_DISASSEMBLE

	w_class = WEIGHT_CLASS_BULKY
	equip_slot_flags = ITEM_SLOT_BACK
	///The linked teleporter
	var/obj/item/teleporter_kit/linked_teleporter
	///The optional cell to power the teleporter if off the grid
	var/obj/item/cell/cell
	///Tag for teleporters number. Exists for fluff reasons. Shared variable.
	var/static/tele_tag = 78
	///References to the number of the teleporter.
	var/self_tele_tag
	COOLDOWN_DECLARE(teleport_cooldown)

/obj/item/teleporter_kit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/deployable_item, /obj/machinery/deployable/teleporter, 2 SECONDS, 2 SECONDS)
	cell = new /obj/item/cell/high(src)
	tele_tag++
	self_tele_tag = tele_tag
	name = "\improper ASRS Bluespace teleporter #[tele_tag]"

/obj/item/teleporter_kit/Destroy()
	if(linked_teleporter)
		linked_teleporter.linked_teleporter = null
		linked_teleporter = null
	QDEL_NULL(cell)
	return ..()

/obj/item/teleporter_kit/examine(mob/user)
	. = ..()
	. += span_notice("按住 Ctrl 并点击地砖进行部署,使用扳手取消部署,使用撬棍取出电池.")

///Link the two teleporters
/obj/item/teleporter_kit/proc/set_linked_teleporter(obj/item/teleporter_kit/link_teleport)
	if(linked_teleporter)
		CRASH("A teleporter was linked with another teleporter even though it already has a twin!")
	if(link_teleport == src)
		CRASH("A teleporter was linked with itself!")
	linked_teleporter = link_teleport

/obj/item/teleporter_kit/attackby(obj/item/I, mob/user, params)
	if(!ishuman(user))
		return FALSE
	if(!istype(I, /obj/item/teleporter_kit))
		return

	var/obj/item/teleporter_kit/gadget = I
	if(linked_teleporter)
		balloon_alert(user, "传送器已经与另一个传送器链接了!")
		return
	if(linked_teleporter == src)
		balloon_alert(user, "你不能将传送器与自身链接!")
		return
	balloon_alert(user, "你将两个传送器互相链接.")

	set_linked_teleporter(gadget)
	gadget.set_linked_teleporter(src)

/obj/item/teleporter_kit/attack_self(mob/user)
	do_unique_action(user)

/obj/item/teleporter_kit/attack_ghost(mob/dead/observer/user)
	if(!linked_teleporter)
		return
	user.forceMove(get_turf(linked_teleporter))

/obj/effect/teleporter_linker
	name = "\improper ASRS bluespace teleporters"
	desc = "两个蓝空间传送垫,用于将人员和设备短距离移动到另一个预先链接的传送器."

/obj/effect/teleporter_linker/Initialize(mapload)
	. = ..()
	var/obj/item/teleporter_kit/teleporter_a = new(loc)
	var/obj/item/teleporter_kit/teleporter_b = new(loc)
	teleporter_a.set_linked_teleporter(teleporter_b)
	teleporter_b.set_linked_teleporter(teleporter_a)
	qdel(src)

#undef TELEPORTING_COST
