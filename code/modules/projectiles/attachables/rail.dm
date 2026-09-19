/obj/item/attachable/reddot
	name = "红点瞄准镜"
	desc = "用于短到中距离的红点瞄准镜.没有放大功能,但在瞄准时能大幅提高武器精准度和射速.\nNo缺点."
	icon_state = "reddot"
	slot = ATTACHMENT_SLOT_RAIL
	accuracy_mod = 0.15
	accuracy_unwielded_mod = 0.1
	aim_mode_delay_mod = -0.5
	variants_by_parent_type = list(/obj/item/weapon/gun/rifle/som = "", /obj/item/weapon/gun/shotgun/som = "")

/obj/item/attachable/b7_scope
	name = "B7智能瞄准镜"
	desc = "一个B7智能瞄准镜.没有放大功能,但允许你瞄准并穿过队友射击.\nNo缺点."
	icon_state = "b7"
	slot = ATTACHMENT_SLOT_RAIL
	add_aim_mode = TRUE

/obj/item/attachable/b11_scope
	name = "B11智能瞄准镜"
	desc = "类似于B7瞄准镜,但瞄准时几乎不会减慢你的速度."
	icon_state = "smoll"
	slot = ATTACHMENT_SLOT_RAIL
	add_aim_mode = TRUE
	aim_mode_movement_mult = -0.8

/obj/item/attachable/b15_scope
	name = "B15智能瞄准镜"
	desc = "类似于B7瞄准镜,但瞄准时几乎不会降低射速."
	icon_state = "big"
	slot = ATTACHMENT_SLOT_RAIL
	add_aim_mode = TRUE
	aim_mode_delay_mod = -0.7

/obj/item/attachable/m16sight
	name = "M16机械瞄具"
	desc = "m16标志性的提把式机械瞄具.通常在用户找到值得安装到导轨上的东西后就会被移除."
	icon_state = "m16sight"
	slot = ATTACHMENT_SLOT_RAIL
	accuracy_mod = 0.1
	accuracy_unwielded_mod = 0.05
	movement_acc_penalty_mod = -0.1

/obj/item/attachable/flashlight
	name = "导轨手电筒"
	desc = "一个用于安装在枪械上的简单手电筒.\nHas没有缺点,但除了提供光源外并不是特别有用."
	icon_state = "flashlight"
	light_mod = 6
	light_system = MOVABLE_LIGHT
	slot = ATTACHMENT_SLOT_RAIL
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle
	activation_sound = 'sound/items/flashlight.ogg'

/obj/item/attachable/flashlight/activate(mob/living/user, turn_off)
	turn_light(user, !light_on)

/obj/item/attachable/flashlight/turn_light(mob/user, toggle_on)
	. = ..()

	if(. != CHECKS_PASSED)
		return

	if(ismob(master_gun.loc) && !user)
		user = master_gun.loc
	if(!toggle_on && light_on)
		icon_state = initial(icon_state)
		master_gun.set_light_range(0)
		master_gun.set_light_power(0)
		master_gun.set_light_on(FALSE)
		light_on = FALSE
		REMOVE_TRAIT(master_gun, TRAIT_GUN_FLASHLIGHT_ON, GUN_TRAIT)
	else if(toggle_on & !light_on)
		icon_state = initial(icon_state) +"_on"
		master_gun.set_light_range(light_mod)
		master_gun.set_light_power(3)
		master_gun.set_light_on(TRUE)
		light_on = TRUE
		ADD_TRAIT(master_gun, TRAIT_GUN_FLASHLIGHT_ON, GUN_TRAIT)
	else
		return

	for(var/X in master_gun.actions)
		var/datum/action/A = X
		A.update_button_icon()

	update_icon()

/obj/item/attachable/flashlight/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	to_chat(user, span_notice("你将导轨手电筒改回了普通手电筒."))
	if(loc == user)
		user.temporarilyRemoveItemFromInventory(src)
	var/obj/item/flashlight/F = new(user)
	user.put_in_hands(F) //This proc tries right, left, then drops it all-in-one.
	qdel(src) //Delete da old flashlight

/obj/item/attachable/flashlight/under
	name = "枪管下挂手电筒"
	desc = "一个用于安装在枪械上的简单手电筒.\nHas没有缺点,但除了提供光源外并不是特别有用."
	icon_state = "uflashlight"
	slot = ATTACHMENT_SLOT_UNDER
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION

/obj/item/attachable/quickfire
	name = "速射适配器"
	desc = "一种增强升级的自动装填机制,能更快地发射子弹.\nHowever,它还会降低精准度和点射时发射的子弹数量."
	slot = ATTACHMENT_SLOT_RAIL
	icon_state = "autoloader"
	accuracy_mod = -0.10
	delay_mod = -0.125 SECONDS
	burst_mod = -1
	accuracy_unwielded_mod = -0.15

/obj/item/attachable/magnetic_harness
	name = "磁性挂具"
	desc = "一个磁性连接的挂具套件,可安装在武器的导轨上.当掉落时,武器会挂到TGMC装甲上."
	icon_state = "magnetic"
	slot = ATTACHMENT_SLOT_RAIL
	pixel_shift_x = 13
	///Handles the harness functionality, created when attached to a gun and removed on detach
	var/datum/component/reequip/reequip_component

/obj/item/attachable/magnetic_harness/on_attach(attaching_item, mob/user)
	. = ..()
	if(!master_gun)
		return
	reequip_component = master_gun.AddComponent(/datum/component/reequip, list(SLOT_S_STORE, SLOT_BELT, SLOT_BACK))

/obj/item/attachable/magnetic_harness/on_detach(attaching_item, mob/user)
	. = ..()
	if(master_gun)
		return
	QDEL_NULL(reequip_component)

/obj/item/attachable/buildasentry
	name = "\improper 建造哨戒炮配件系统"
	icon = 'icons/obj/sentry.dmi'
	icon_state = "build_a_sentry_attachment"
	desc = "建造哨戒炮是廉价自动化防御的最新设计.只需将其安装到枪的导轨上并部署.就这么简单!"
	slot = ATTACHMENT_SLOT_RAIL
	size_mod = 1
	pixel_shift_x = 10
	pixel_shift_y = 18
	///Deploy time for the build-a-sentry
	var/deploy_time = 2 SECONDS
	///Undeploy tim for the build-a-sentry
	var/undeploy_time = 2 SECONDS

/obj/item/attachable/buildasentry/can_attach(obj/item/attaching_to, mob/attacher)
	if(!isgun(attaching_to))
		return FALSE
	var/obj/item/weapon/gun/attaching_gun = attaching_to
	if(ispath(attaching_gun.deployable_item, /obj/machinery/deployable/mounted/sentry))
		to_chat(attacher, span_warning("[attaching_gun]已经是一台哨戒机枪了!"))
		return FALSE
	return ..()

/obj/item/attachable/buildasentry/on_attach(attaching_item, mob/user)
	. = ..()
	ENABLE_BITFIELD(master_gun.deploy_flags, IS_DEPLOYABLE)
	ENABLE_BITFIELD(master_gun.item_flags, IS_SENTRY)
	master_gun.deployable_item = /obj/machinery/deployable/mounted/sentry/buildasentry
	master_gun.turret_flags |= TURRET_HAS_CAMERA|TURRET_SAFETY|TURRET_ALERTS
	master_gun.AddComponent(/datum/component/deployable_item, master_gun.deployable_item, deploy_time, undeploy_time)
	update_icon()

/obj/item/attachable/buildasentry/on_detach(detaching_item, mob/user)
	. = ..()
	var/obj/item/weapon/gun/detaching_gun = detaching_item
	DISABLE_BITFIELD(detaching_gun.deploy_flags, IS_DEPLOYABLE)
	DISABLE_BITFIELD(detaching_gun.item_flags, IS_SENTRY)
	qdel(detaching_gun.GetComponent(/datum/component/deployable_item))
	detaching_gun.deployable_item = null
	detaching_gun.turret_flags &= ~(TURRET_HAS_CAMERA|TURRET_SAFETY|TURRET_ALERTS)

/obj/item/attachable/shoulder_mount
	name = "实验性肩部挂载点"
	desc = "战斗技术的全新进步. 该装置一旦安装到枪械上, 就能让枪械挂载到任何模块化装甲上. 一旦安装到装甲上并激活, 枪械将在使用者选择时开火.\nOnce已安装到装甲上, 空手<b>右键点击</b>装甲将选择哪种点击方式触发装甲开火 (中键, 右键, 左键). <b>右键点击</b>弹药将重新装填枪械. 使用<b>独特动作</b>按键绑定将仅在枪械激活时执行武器的独特动作."
	icon = 'icons/mob/modular/shoulder_gun.dmi'
	icon_state = "shoulder_gun"
	slot = ATTACHMENT_SLOT_RAIL
	pixel_shift_x = 13
	///What click the gun will fire on.
	var/fire_mode = "right"
	///Blacklist of item types not allowed to be in the users hand to fire the gun.
	var/list/in_hand_items_blacklist = list(
		/obj/item/weapon/gun,
		/obj/item/weapon/shield,
	)

/obj/item/attachable/shoulder_mount/on_attach(attaching_item, mob/user)
	. = ..()
	var/obj/item/weapon/gun/attaching_gun = attaching_item
	ENABLE_BITFIELD(attach_features_flags, ATTACH_BYPASS_ALLOWED_LIST|ATTACH_APPLY_ON_MOB)
	attaching_gun.AddElement(/datum/element/attachment, ATTACHMENT_SLOT_MODULE, icon, null, null, null, null, 0, 0, attach_features_flags, attach_delay, detach_delay, attach_skill, attach_skill_upper_threshold, attach_sound, attachment_layer = COLLAR_LAYER)
	RegisterSignal(attaching_gun, COMSIG_ATTACHMENT_ATTACHED, PROC_REF(handle_armor_attach))
	RegisterSignal(attaching_gun, COMSIG_ATTACHMENT_DETACHED, PROC_REF(handle_armor_detach))

/obj/item/attachable/shoulder_mount/on_detach(detaching_item, mob/user)
	var/obj/item/weapon/gun/detaching_gun = detaching_item
	detaching_gun.RemoveElement(/datum/element/attachment, ATTACHMENT_SLOT_MODULE, icon, null, null, null, null, 0, 0, attach_features_flags, attach_delay, detach_delay, attach_skill, attach_skill_upper_threshold, attach_sound, attachment_layer = COLLAR_LAYER)
	DISABLE_BITFIELD(attach_features_flags, ATTACH_BYPASS_ALLOWED_LIST|ATTACH_APPLY_ON_MOB)
	UnregisterSignal(detaching_gun, list(COMSIG_ATTACHMENT_ATTACHED, COMSIG_ATTACHMENT_DETACHED))
	return ..()

/obj/item/attachable/shoulder_mount/ui_action_click(mob/living/user, datum/action/item_action/action, obj/item/weapon/gun/G)
	if(!istype(master_gun.loc, /obj/item/clothing/suit/modular) || master_gun.loc.loc != user)
		return
	return activate(user)

/obj/item/attachable/shoulder_mount/activate(mob/user, turn_off)
	. = ..()
	if(CHECK_BITFIELD(master_gun.deploy_flags, IS_DEPLOYED))
		DISABLE_BITFIELD(master_gun.deploy_flags, IS_DEPLOYED)
		UnregisterSignal(user, COMSIG_MOB_MOUSEDOWN)
		master_gun.set_gun_user(null)
		. = FALSE
	else if(!turn_off)
		ENABLE_BITFIELD(master_gun.deploy_flags, IS_DEPLOYED)
		update_icon()
		master_gun.set_gun_user(user)
		RegisterSignal(user, COMSIG_MOB_MOUSEDOWN, PROC_REF(handle_firing))
		master_gun.RegisterSignal(user, COMSIG_MOB_MOUSEDRAG, TYPE_PROC_REF(/obj/item/weapon/gun, change_target))
		. = TRUE
	for(var/datum/action/item_action/toggle/action_to_update AS in actions)
		action_to_update.set_toggle(.)

///Handles the gun attaching to the armor.
/obj/item/attachable/shoulder_mount/proc/handle_armor_attach(datum/source, attaching_item, mob/user)
	SIGNAL_HANDLER
	if(!istype(attaching_item, /obj/item/clothing/suit/modular))
		return
	master_gun.set_gun_user(null)
	RegisterSignal(attaching_item, COMSIG_ITEM_EQUIPPED, PROC_REF(handle_activations))
	RegisterSignal(attaching_item, COMSIG_ATOM_ATTACK_HAND_ALTERNATE, PROC_REF(switch_mode))
	RegisterSignal(attaching_item, COMSIG_ATOM_ATTACKBY_ALTERNATE, PROC_REF(reload_gun))
	RegisterSignal(master_gun, COMSIG_MOB_GUN_FIRED, PROC_REF(after_fire))
	master_gun.base_gun_icon = master_gun.placed_overlay_iconstate
	master_gun.update_icon()

///Handles the gun detaching from the armor.
/obj/item/attachable/shoulder_mount/proc/handle_armor_detach(datum/source, detaching_item, mob/user)
	SIGNAL_HANDLER
	if(!istype(detaching_item, /obj/item/clothing/suit/modular))
		return
	for(var/datum/action/action_to_delete AS in actions)
		if(action_to_delete.target != src)
			continue
		QDEL_NULL(action_to_delete)
		break
	update_icon()
	master_gun.base_gun_icon = initial(master_gun.icon_state)
	master_gun.update_icon()
	UnregisterSignal(detaching_item, list(COMSIG_ITEM_EQUIPPED, COMSIG_ATOM_ATTACK_HAND_ALTERNATE, COMSIG_ATOM_ATTACKBY_ALTERNATE))
	UnregisterSignal(master_gun, COMSIG_MOB_GUN_FIRED)
	UnregisterSignal(user, COMSIG_MOB_MOUSEDOWN)

///Sets up the action.
/obj/item/attachable/shoulder_mount/proc/handle_activations(datum/source, mob/equipper, slot)
	if(!isliving(equipper))
		return
	if(slot != SLOT_WEAR_SUIT)
		LAZYREMOVE(actions_types, /datum/action/item_action/toggle)
		var/datum/action/item_action/toggle/old_action = locate(/datum/action/item_action/toggle) in actions
		if(!old_action)
			return
		old_action.remove_action(equipper)
		actions = null
	else
		LAZYADD(actions_types, /datum/action/item_action/toggle)
		var/datum/action/item_action/toggle/new_action = new(src)
		new_action.give_action(equipper)

///Performs the firing.
/obj/item/attachable/shoulder_mount/proc/handle_firing(datum/source, atom/object, turf/location, control, params)
	SIGNAL_HANDLER
	var/list/modifiers = params2list(params)
	if(!modifiers[fire_mode])
		return
	if(!istype(master_gun.loc, /obj/item/clothing/suit/modular) || master_gun.loc.loc != source)
		return
	if(source.Adjacent(object))
		return
	var/mob/living/user = master_gun.gun_user
	if(user.incapacitated()  || user.lying_angle || LAZYACCESS(user.do_actions, src) || !user.dextrous || (!CHECK_BITFIELD(master_gun.gun_features_flags, GUN_ALLOW_SYNTHETIC) && !CONFIG_GET(flag/allow_synthetic_gun_use) && issynth(user)))
		return
	var/active_hand = user.get_active_held_item()
	var/inactive_hand = user.get_inactive_held_item()
	for(var/item_blacklisted in in_hand_items_blacklist)
		if(!istype(active_hand, item_blacklisted) && !istype(inactive_hand, item_blacklisted))
			continue
		to_chat(user, span_warning("[src]发出哔声. 你手中的枪械或盾牌正在干扰其瞄准. 中止."))
		return
	master_gun.start_fire(source, object, location, control, null, TRUE)

///Switches click fire modes.
/obj/item/attachable/shoulder_mount/proc/switch_mode(datum/source, mob/living/user)
	SIGNAL_HANDLER
	switch(fire_mode)
		if("right")
			fire_mode = "middle"
			to_chat(user, span_notice("[master_gun]现在将在'中键点击'时开火."))
		if("middle")
			fire_mode = "left"
			to_chat(user, span_notice("[master_gun]现在将在'左键点击'时开火."))
		if("left")
			fire_mode = "right"
			to_chat(user, span_notice("[master_gun]现在将在'右键点击'时开火."))

///Reloads the gun
/obj/item/attachable/shoulder_mount/proc/reload_gun(datum/source, obj/item/attacking_item, mob/living/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(master_gun, TYPE_PROC_REF(/obj/item/weapon/gun, reload), attacking_item, user)

///Performs the unique action after firing and checks to see if the user is still able to fire.
/obj/item/attachable/shoulder_mount/proc/after_fire(datum/source, atom/target, obj/item/weapon/gun/fired_gun)
	SIGNAL_HANDLER
	if(CHECK_BITFIELD(master_gun.reciever_flags, AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION))
		INVOKE_ASYNC(master_gun, TYPE_PROC_REF(/obj/item/weapon/gun, do_unique_action), master_gun.gun_user)
	var/mob/living/user = master_gun.gun_user
	var/active_hand = user.get_active_held_item()
	var/inactive_hand = user.get_inactive_held_item()
	for(var/item_blacklisted in in_hand_items_blacklist)
		if(!istype(active_hand, item_blacklisted) && !istype(inactive_hand, item_blacklisted))
			continue
		to_chat(user, span_warning("[src]发出哔声. 你手中的枪械或盾牌正在干扰其瞄准. 停止开火."))
		master_gun.stop_fire()
		return
	if(!user.incapacitated() && !user.lying_angle && !LAZYACCESS(user.do_actions, src) && user.dextrous && (CHECK_BITFIELD(master_gun.gun_features_flags, GUN_ALLOW_SYNTHETIC) || CONFIG_GET(flag/allow_synthetic_gun_use) || !issynth(user)))
		return
	master_gun.stop_fire()
