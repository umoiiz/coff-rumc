/obj/item/mecha_parts/mecha_equipment/armor/melee
	name = "近战装甲强化器"
	desc = "将对抗近战攻击的装甲提高15%."
	icon_state = "armor_melee"
	iconstate_name = "armor_melee"
	protect_name = "Melee Armor"
	can_equip = TRUE
	slowdown = 0.5
	armor_mod = list(MELEE = 15)

/obj/item/mecha_parts/mecha_equipment/armor/acid
	name = "腐蚀装甲强化器"
	desc = "将对抗酸液攻击的装甲提高15%."
	icon_state = "armor_acid"
	iconstate_name = "armor_acid"
	protect_name = "Caustic Armor"
	can_equip = TRUE
	slowdown = 0.4
	armor_mod = list(ACID = 15)

/obj/item/mecha_parts/mecha_equipment/armor/explosive
	name = "爆炸装甲强化器"
	desc = "将对抗爆炸的装甲提高50%."
	icon_state = "armor_explosive"
	iconstate_name = "armor_explosive"
	protect_name = "Explosive Armor"
	can_equip = TRUE
	slowdown = 0.3
	armor_mod = list(BOMB = 50)


/obj/item/mecha_parts/mecha_equipment/generator/greyscale
	name = "phoron引擎"
	desc = "一种为TGMC高级机甲外骨骼设计的先进Nanotrasen phoron引擎核心原型.使用固体phoron作为燃料,点击引擎进行加注.最轻的引擎,机甲可以使用,代价是充能速率和最大燃料容量."
	icon_state = "phoron_engine"
	can_equip = TRUE
	rechargerate = 5
	slowdown = 0.3
	max_fuel = 30000

/obj/item/mecha_parts/mecha_equipment/generator/greyscale/upgraded
	name = "聚变引擎"
	desc = "一种高度实验性的phoron聚变核心.在相同消耗速率下产生更多动力,但比标准phoron引擎更拖慢你的速度.使用固体phoron作为燃料,点击引擎进行加注.最重的引擎,机甲可以使用,代价是因重量而降低速度."
	icon_state = "phoron_engine_adv"
	rechargerate = 10
	slowdown = 0.6
	max_fuel = 60000

/obj/item/mecha_parts/mecha_equipment/energy_optimizer
	name = "能量优化器"
	desc = "一种Nanotrasen品牌的计算机,使用预测算法将所有移动步骤的能耗降低50%."
	icon_state = "optimizer"
	can_equip = TRUE
	equipment_slot = MECHA_POWER
	slowdown = 0.3

/obj/item/mecha_parts/mecha_equipment/energy_optimizer/attach(obj/vehicle/sealed/mecha/M, attach_right)
	. = ..()
	M.normal_step_energy_drain *= 0.50
	M.step_energy_drain *= 0.50
	M.overload_step_energy_drain_min *= 0.50

/obj/item/mecha_parts/mecha_equipment/energy_control/detach(atom/moveto)
	chassis.normal_step_energy_drain /= 0.50
	chassis.step_energy_drain /= 0.50
	chassis.overload_step_energy_drain_min /= 0.50
	return ..()

/obj/item/mecha_parts/mecha_equipment/melee_core
	name = "近战核心"
	desc = "一种蓝空间orion-sperkov转换器.通过你懒得去理解的科学原理,使机甲更快,其武器能汲取更多动力,使其更加危险.然而代价是无法使用弹射物和激光武器."
	icon_state = "melee_core"
	can_equip = TRUE
	equipment_slot = MECHA_UTILITY
	///speed amount we modify the mech by
	var/speed_mod

/obj/item/mecha_parts/mecha_equipment/melee_core/attach(obj/vehicle/sealed/mecha/M, attach_right)
	. = ..()
	ADD_TRAIT(M, TRAIT_MELEE_CORE, REF(src))
	speed_mod = min(chassis.move_delay-1, round(chassis.move_delay * 0.5))
	M.move_delay -= speed_mod

/obj/item/mecha_parts/mecha_equipment/melee_core/detach(atom/moveto)
	REMOVE_TRAIT(chassis, TRAIT_MELEE_CORE, REF(src))
	chassis.move_delay += speed_mod
	return ..()


/obj/item/mecha_parts/mecha_equipment/ability
	name = "通用机甲能力"
	desc = "你不应该看到这个"
	equipment_slot = MECHA_UTILITY
	///if given, a single flag of who we want this ability to be granted to
	var/flag_controller = NONE
	///typepath of ability we want to grant
	var/ability_to_grant
	///reference to image that is used as an overlay
	var/image/overlay

/obj/item/mecha_parts/mecha_equipment/ability/Initialize(mapload)
	. = ..()
	if(icon_state)
		overlay = image('icons/mecha/mecha_ability_overlays.dmi', icon_state = icon_state, layer = 10)

/obj/item/mecha_parts/mecha_equipment/ability/attach(obj/vehicle/sealed/mecha/M, attach_right)
	. = ..()
	M.add_overlay(overlay)
	if(flag_controller)
		M.initialize_controller_action_type(ability_to_grant, flag_controller)
	else
		M.initialize_passenger_action_type(ability_to_grant)

/obj/item/mecha_parts/mecha_equipment/ability/detach(atom/moveto)
	chassis.cut_overlay(overlay)
	if(flag_controller)
		chassis.destroy_controller_action_type(ability_to_grant, flag_controller)
	else
		chassis.destroy_passenger_action_type(ability_to_grant)
	return ..()

/obj/item/mecha_parts/mecha_equipment/ability/dash
	name = "执行器安全超控"
	desc = "一堆杂乱的电子元件,允许使用者覆盖标准安全输入以提高速度,代价是极高的功耗."
	icon_state = "booster"
	can_equip = TRUE
	ability_to_grant = /datum/action/vehicle/sealed/mecha/mech_overload_mode
	///sound to loop when the dash is activated
	var/datum/looping_sound/mech_overload/sound_loop

/obj/item/mecha_parts/mecha_equipment/ability/dash/Initialize(mapload)
	. = ..()
	sound_loop = new

/obj/item/mecha_parts/mecha_equipment/ability/zoom
	name = "增强变焦"
	desc = "一个放大模块,允许驾驶员比使用标准光学设备看得更远.不包含夜视功能."
	icon_state = "zoom"
	can_equip = TRUE
	ability_to_grant = /datum/action/vehicle/sealed/mecha/mech_zoom

/obj/item/mecha_parts/mecha_equipment/ability/smoke
	name = "通用烟雾模块"
	ability_to_grant = /datum/action/vehicle/sealed/mecha/mech_smoke
	///smoke type to spawn when this ability is activated
	var/smoke_type
	///size of smoke cloud that spawns
	var/size = 6
	///duration of smoke cloud that spawns
	var/duration = 8

/obj/item/mecha_parts/mecha_equipment/ability/smoke/attach(obj/vehicle/sealed/mecha/M, attach_right)
	. = ..()
	var/datum/effect_system/smoke_spread/smoke = new smoke_type
	smoke.set_up(size, M, duration)
	smoke.attach(M)
	M.smoke_system = smoke
	M.smoke_charges = initial(M.smoke_charges)

/obj/item/mecha_parts/mecha_equipment/ability/smoke/detach(atom/moveto)
	var/datum/effect_system/smoke_spread/bad/oldsmoke = new
	oldsmoke.set_up(3, chassis)
	oldsmoke.attach(chassis)
	chassis.smoke_system = oldsmoke
	return ..()

/obj/item/mecha_parts/mecha_equipment/ability/smoke/tanglefoot
	name = "缠绕烟雾发生器"
	desc = "一个缠绕烟雾发生器,能够释放大量非致命气体,吸取任何接触到的异形生物的能量."
	icon_state = "tfoot_gas"
	can_equip = TRUE
	ability_to_grant = /datum/action/vehicle/sealed/mecha/mech_smoke
	smoke_type = /datum/effect_system/smoke_spread/plasmaloss

/obj/item/mecha_parts/mecha_equipment/ability/smoke/cloak_smoke
	name = "烟雾发生器"
	desc = "一个多联发射模块,能够产生大量遮蔽烟雾来伪装附近的友军.遗憾的是,巨大的机器人太难用它隐藏了."
	icon_state = "smoke_gas"
	can_equip = TRUE
	ability_to_grant = /datum/action/vehicle/sealed/mecha/mech_smoke
	smoke_type = /datum/effect_system/smoke_spread/tactical
