/**
 *TANK MODULES
 *
 * Attached to the tank and provide abilities/ passive upgrades
 */
/obj/item/tank_module
	name = "坦克模块"
	desc = "请对生成这个的管理员大喊大叫."
	icon = 'icons/obj/armored/hardpoint_modules.dmi'
	icon_state = "ltb_cannon"
	///Special behavior flags
	var/tank_mod_flags = NONE
	///reference to current overlay added to owner
	var/image/overlay
	///vehicle this overlay is attached to
	var/obj/vehicle/sealed/armored/owner
	///Bool whether this module is a driver module or not
	var/is_driver_module = TRUE
	///Bool whether this module is visually attached to the hull or not
	var/attached_to_hull = FALSE

///Called to apply modules to a vehicle
/obj/item/tank_module/proc/on_equip(obj/vehicle/sealed/armored/vehicle, mob/living/user)
	SHOULD_CALL_PARENT(TRUE)
	if(!istype(vehicle))
		return FALSE
	var/slot = is_driver_module ? vehicle.driver_utility_module : vehicle.gunner_utility_module
	if(slot)
		user?.balloon_alert(user, "模块槽已满")
		return FALSE
	user?.temporarilyRemoveItemFromInventory(src)
	forceMove(vehicle)
	if(is_driver_module)
		vehicle.driver_utility_module = src
	else
		vehicle.gunner_utility_module = src
	if(!vehicle.turret_overlay || attached_to_hull)
		overlay = image(vehicle.icon, null, icon_state)
		vehicle.add_overlay(overlay)
	else
		overlay = image(vehicle.turret_overlay.icon, null, icon_state)
		vehicle.turret_overlay.add_overlay(overlay)
	owner = vehicle
	return TRUE

///called to remove this module from its vehicle
/obj/item/tank_module/proc/on_unequip(mob/user)
	SHOULD_CALL_PARENT(TRUE)
	if(owner.driver_utility_module == src)
		owner.driver_utility_module = null
	else
		owner.gunner_utility_module = null
	forceMove(owner.drop_location())
	owner.cut_overlay(overlay)
	owner.turret_overlay?.cut_overlay(overlay)
	owner = null
	overlay = null
	user?.put_in_hands(src)
	return TRUE

/obj/item/tank_module/Destroy()
	if(owner)
		on_unequip()
	return ..()

/obj/item/tank_module/overdrive
	name = "超速模块"
	desc = "一种通过提高燃油效率来增强装甲战车速度的模块."
	icon_state = "overdrive"
	attached_to_hull = TRUE

/obj/item/tank_module/overdrive/on_equip(obj/vehicle/sealed/armored/vehicle, mob/living/user)
	. = ..()
	if(!.)
		return
	vehicle.move_delay -= 0.15 SECONDS

/obj/item/tank_module/overdrive/on_unequip()
	owner.move_delay += 0.15 SECONDS
	return ..()

/obj/item/tank_module/heavy_armor
	name = "重型装甲模块"
	desc = "一种实验性装甲套件,以牺牲机动性为代价显著提高生存能力."
	icon_state = "heavy_armor"
	attached_to_hull = TRUE

/obj/item/tank_module/heavy_armor/on_equip(obj/vehicle/sealed/armored/vehicle, mob/living/user)
	. = ..()
	if(!.)
		return

	vehicle.ram_damage += 100
	vehicle.move_delay += 0.35 SECONDS
	vehicle.max_integrity += 550
	vehicle.obj_integrity += 550

/obj/item/tank_module/heavy_armor/on_unequip()
	owner.move_delay -= 0.35 SECONDS
	owner.ram_damage -= 100
	owner.max_integrity -= 550
	owner.obj_integrity -= 550
	owner.obj_integrity = max(0, owner.obj_integrity)

	return ..()

/obj/item/tank_module/passenger
	name = "乘客模块"
	desc = "一种通过额外座位增加载具载客量的模块."
	icon_state = "uninstalled APC frieght carriage"

/obj/item/tank_module/passenger/on_equip(obj/vehicle/sealed/armored/vehicle, mob/living/user)
	. = ..()
	if(!.)
		return
	vehicle.max_occupants += 4

/obj/item/tank_module/passenger/on_unequip(obj/vehicle/sealed/armored/vehicle, mob/living/user)
	owner.max_occupants -= 4
	return ..()

/obj/item/tank_module/ability
	name = "能力模块"
	desc = "你不应该看到这个."
	icon_state = "overdrive"
	///typepaths for the ability we want to grant
	var/ability_to_grant
	///if given, a single flag of who we want this ability to be granted to
	var/flag_controller = NONE

/obj/item/tank_module/ability/on_equip(obj/vehicle/sealed/armored/vehicle, attach_right)
	. = ..()
	if(!.)
		return
	if(flag_controller)
		vehicle.initialize_controller_action_type(ability_to_grant, flag_controller)
	else
		vehicle.initialize_passenger_action_type(ability_to_grant)

/obj/item/tank_module/ability/on_unequip(atom/moveto)
	if(flag_controller)
		owner.destroy_controller_action_type(ability_to_grant, flag_controller)
	else
		owner.destroy_passenger_action_type(ability_to_grant)
	return ..()

/obj/item/tank_module/ability/zoom
	name = "缩放模块"
	desc = "允许炮手在通过它观察时看得更远.通过它观察时无法使用武器."
	icon_state = "zoom"
	is_driver_module = FALSE
	flag_controller = VEHICLE_CONTROL_EQUIPMENT
	ability_to_grant = /datum/action/vehicle/sealed/armored/zoom

/obj/item/tank_module/ability/smoke_launcher
	name = "烟雾发射器模块"
	desc = "允许驾驶员在坦克前方发射烟幕."
	icon_state = "smoke_launcher"
	tank_mod_flags = TANK_MOD_NOT_FABRICABLE
	is_driver_module = TRUE
	flag_controller = VEHICLE_CONTROL_DRIVE
	ability_to_grant = /datum/action/vehicle/sealed/armored/smoke_screen

/obj/item/tank_module/ability/tesla
	name = "特斯拉模块"
	desc = "允许驾驶员短暂地使载具外壳通电."
	icon_state = "tesla"
	tank_mod_flags = TANK_MOD_NOT_FABRICABLE
	is_driver_module = TRUE
	flag_controller = VEHICLE_CONTROL_DRIVE
	ability_to_grant = /datum/action/vehicle/sealed/armored/tesla

/obj/item/tank_module/interior
	name = "通用内部模块"
	desc = "你不应该看到这个"
	is_driver_module = TRUE
	///max occupants to set when adding this module
	var/set_max_occupants
	/// typepath we want to be using for interiors
	var/interior_typepath

/obj/item/tank_module/interior/Initialize(mapload)
	. = ..()
#ifdef UNIT_TESTS
	if(!interior_typepath && (type != /obj/item/tank_module/interior))
		CRASH("Error: [type] has no interior_typepath")
#endif

/obj/item/tank_module/interior/on_equip(obj/vehicle/sealed/armored/vehicle, mob/living/user)
	. = ..()
	if(!.)
		return
	if(LAZYLEN(vehicle.occupants))
		if(user)
			balloon_alert(user, "乘员仍在内部")
		return FALSE
	QDEL_NULL(vehicle.interior)
	vehicle.interior = new interior_typepath(vehicle, CALLBACK(vehicle, TYPE_PROC_REF(/obj/vehicle/sealed/armored, interior_exit)))
	if(set_max_occupants)
		owner.max_occupants = set_max_occupants

/obj/item/tank_module/interior/on_unequip(mob/user)
	if(LAZYLEN(owner.occupants))
		if(user)
			balloon_alert(user, "乘员仍在内部")
		return FALSE
	QDEL_NULL(owner.interior)
	var/init_type = initial(owner.interior)
	if(init_type)
		owner.interior = new init_type(owner, CALLBACK(owner, TYPE_PROC_REF(/obj/vehicle/sealed/armored, interior_exit)))
	if(set_max_occupants)
		owner.max_occupants = initial(owner.max_occupants)
	return ..()

/obj/item/tank_module/interior/medical
	name = "医疗内部"
	desc = "一种医疗内部套件,配备有手术台和医疗售货机."
	icon_state = "medical_interior"
	interior_typepath = /datum/interior/armored/medical
	set_max_occupants = 12

/obj/item/tank_module/interior/clone_bay
	name = "克隆舱内部"
	desc = "一种克隆内部套件,设计用于快速生产廉价克隆士兵."
	icon_state = "cloner_interior"
	interior_typepath = /datum/interior/armored/clone_bay
	set_max_occupants = 12
