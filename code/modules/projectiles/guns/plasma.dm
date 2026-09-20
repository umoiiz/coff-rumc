/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma
	name = "通用等离子武器"
	icon = 'icons/obj/items/gun/plasma64.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/plasma_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/plasma_righthand_1.dmi',
	)
	default_ammo_type = /obj/item/cell/lasgun/plasma
	allowed_ammo_types = list(/obj/item/cell/lasgun/plasma)
	heat_per_fire = 5
	muzzle_flash_color = COLOR_DISABLER_BLUE
	muzzleflash_iconstate = "muzzle_flash_pulse"
	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_AMMO_COUNT_BY_SHOTS_REMAINING
	accuracy_mult = 1
	accuracy_mult_unwielded = 0.5
	scatter = 4
	scatter_unwielded = 35
	movement_acc_penalty_mult = 5
	damage_falloff_mult = 0.25
	overheat_multiplier = 0.5
	cool_amount = 9
	ammo_level_icon = null

/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma/rifle
	name = "\improper PL-38等离子步枪"
	desc = "PL-38等离子步枪是地球政府陆战队军械库中的实验性新增装备,据传是某些走后门合同交易的产物,如果你不介意其相当廉价的冷却系统,它是一把多用途武器.它拥有类似步枪的普通光束模式,能轻易穿透软目标的高能模式,以及能轻易熔化任何被击中目标装甲的爆破模式."
	icon_state = "plasma_rifle"
	worn_icon_state = "plasma_rifle"
	fire_sound = 'sound/weapons/guns/fire/plasma_fire_med.ogg'
	unload_sound = 'sound/weapons/guns/interact/plasma_unload_3.ogg'
	reload_sound = 'sound/weapons/guns/interact/plasma_reload_2.ogg'

	wield_delay = 0.7 SECONDS
	aim_slowdown = 0.5

	accuracy_mult = 1.15
	scatter = 0

	fire_delay = 0.2 SECONDS
	heat_per_fire = 3
	rounds_per_shot = 12
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	ammo_datum_type = /datum/ammo/energy/plasma/rifle_standard
	force = 20
	mode_list = list(
		"Standard" = /datum/lasrifle/base/plasma_rifle/rifle_standard,
		"Piercing" = /datum/lasrifle/base/plasma_rifle/rifle_marksman,
		"Blast" = /datum/lasrifle/base/plasma_rifle/rifle_blast,
	)
	attachable_offset = list("muzzle_x" = 50, "muzzle_y" = 16,"rail_x" = 25, "rail_y" = 25, "under_x" = 37, "under_y" = 10, "stock_x" = 0, "stock_y" = 13)
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/reddot,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
	)

/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma/rifle/standard
	starting_attachment_types = list(
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/attachable/reddot,
		/obj/item/attachable/bayonet,
	)

/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma/rifle/v_grip
	starting_attachment_types = list(
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/reddot,
		/obj/item/attachable/bayonet,
	)

/datum/lasrifle/base/plasma_rifle/rifle_standard
	fire_sound = 'sound/weapons/guns/fire/plasma_fire_med.ogg'
	ammo_datum_type = /datum/ammo/energy/plasma/rifle_standard
	icon_state = "plasma_rifle"
	fire_mode = GUN_FIREMODE_AUTOMATIC
	fire_delay = 0.2 SECONDS
	heat_per_fire = 3
	rounds_per_shot = 12
	radial_icon_state = "plasma_weak"
	message_to_user = "You set the plasma rifle's charge mode to standard fire."

/datum/lasrifle/base/plasma_rifle/rifle_marksman
	fire_sound = 'sound/weapons/guns/fire/plasma_fire_heavy.ogg'
	ammo_datum_type = /datum/ammo/energy/plasma/rifle_marksman
	icon_state = "plasma_rifle"
	fire_mode = GUN_FIREMODE_AUTOMATIC
	fire_delay = 0.6 SECONDS
	heat_per_fire = 12
	rounds_per_shot = 48
	radial_icon_state = "plasma_strong"
	message_to_user = "You set the plasma rifle's charge mode to piercing fire."

/datum/lasrifle/base/plasma_rifle/rifle_blast
	fire_sound = 'sound/weapons/guns/fire/plasma_fire_blast.ogg'
	ammo_datum_type = /datum/ammo/energy/plasma/blast/melting
	icon_state = "plasma_rifle"
	fire_mode = GUN_FIREMODE_AUTOMATIC
	fire_delay = 1.5 SECONDS
	heat_per_fire = 33
	rounds_per_shot = 100
	radial_icon_state = "plasma_multi"
	message_to_user = "You set the plasma rifle's charge mode to blast fire."

/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma/cannon
	name = "\improper PL-96等离子炮"
	desc = "PL-96等离子炮是地球政府陆战队军械库中的实验性新增装备,据传是某些走后门合同交易的产物,是一件绝对令人难以置信的毁灭性武器...如果你不介意其极其糟糕的冷却机制和整体笨重的话.它拥有类似机枪的普通光束模式,能留下毁灭性火焰的火球模式,以及因其击中目标时惊人的破甲潜力而被昵称为\"股骨粉碎者\"的充能模式."
	icon_state = "plasma_cannon"
	worn_icon_state = "plasma_cannon"
	gun_features_flags = GUN_AMMO_COUNTER|GUN_AMMO_COUNT_BY_SHOTS_REMAINING|GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY

	aim_slowdown = 1.2
	wield_delay = 1.7 SECONDS
	movement_acc_penalty_mult = 7

	accuracy_mult = 1
	accuracy_mult_unwielded = 0.5
	scatter = 2

	fire_sound = 'sound/weapons/guns/fire/plasma_fire_heavy.ogg'
	unload_sound = 'sound/weapons/guns/interact/plasma_unload_2.ogg'
	reload_sound = 'sound/weapons/guns/interact/plasma_reload_1.ogg'
	force = 35
	ammo_datum_type = /datum/ammo/energy/plasma/cannon_heavy
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	fire_delay = 2 SECONDS
	heat_per_fire = 50
	rounds_per_shot = 180
	windup_delay = 0.5 SECONDS
	mode_list = list(
		"Standard" = /datum/lasrifle/base/plasma_cannon/cannon_standard,
		"Shatter" = /datum/lasrifle/base/plasma_cannon/shatter_blast,
		"Incendiary" = /datum/lasrifle/base/plasma_cannon/incendiary_blast,
	)
	attachable_offset = list("muzzle_x" = 49, "muzzle_y" = 16,"rail_x" = 25, "rail_y" = 26, "under_x" = 42, "under_y" = 11, "stock_x" = 0, "stock_y" = 13)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/magnetic_harness,
	)

/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma/cannon/mag_harness
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness)

/datum/lasrifle/base/plasma_cannon/cannon_standard
	fire_sound = 'sound/weapons/guns/fire/plasma_fire_heavy.ogg'
	ammo_datum_type = /datum/ammo/energy/plasma/cannon_heavy
	fire_mode = GUN_FIREMODE_AUTOMATIC
	fire_delay = 2 SECONDS
	heat_per_fire = 50
	rounds_per_shot = 180
	windup_delay = 0.5 SECONDS
	icon_state = "plasma_cannon"
	radial_icon_state = "plasma_cannon"
	message_to_user = "You set the plasma cannon's charge mode to standard."

/datum/lasrifle/base/plasma_cannon/shatter_blast
	fire_sound = 'sound/weapons/guns/fire/plasma_fire_blast.ogg'
	ammo_datum_type = /datum/ammo/energy/plasma/blast/shatter
	fire_mode = GUN_FIREMODE_AUTOMATIC
	fire_delay = 1.5 SECONDS
	heat_per_fire = 45
	rounds_per_shot = 150
	windup_delay = 0.5 SECONDS
	icon_state = "plasma_cannon"
	radial_icon_state = "plasma_fire"
	message_to_user = "You set the gun's charge mode to shatter."

/datum/lasrifle/base/plasma_cannon/incendiary_blast
	fire_sound = 'sound/weapons/guns/fire/flamethrower3.ogg'
	ammo_datum_type = /datum/ammo/energy/plasma/blast/incendiary
	fire_mode = GUN_FIREMODE_AUTOMATIC
	fire_delay = 1.5 SECONDS
	heat_per_fire = 40
	rounds_per_shot = 100
	windup_delay = 0.5 SECONDS
	icon_state = "plasma_cannon"
	radial_icon_state = "plasma_strong"
	message_to_user = "You set the plasma cannon's charge mode to incendiary."

/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma/smg
	name = "\improper PL-51等离子冲锋枪"
	desc = "PL-51等离子冲锋枪是TGMC等离子武器系列中的又一实验性新增装备,有人推测这是让AI设计并生成武器图纸和档案的计划的一部分.它与其他等离子武器共享相同的冷却系统,无法持续射击.与其系列中的其他武器相比,它更轻,更易操控,且可单手射击.拥有两种射击模式:标准模式能够从墙壁和固体物体上弹射,超载模式射速较慢,但会在接触目标时造成小范围中等伤害的爆炸."
	icon_state = "plasma_smg"
	worn_icon_state = "plasma_smg"
	gun_skill_category = SKILL_SMGS
	fire_sound = 'sound/weapons/guns/fire/plasma_fire_fast.ogg'
	unload_sound = 'sound/weapons/guns/interact/plasma_unload_3.ogg'
	reload_sound = 'sound/weapons/guns/interact/plasma_reload_3.ogg'
	fire_sound = 'sound/weapons/guns/fire/plasma_fire_fast.ogg'
	ammo_datum_type = /datum/ammo/energy/plasma/smg_standard/four

	wield_delay = 0.5 SECONDS
	aim_slowdown = 0.25
	movement_acc_penalty_mult = 3

	accuracy_mult = 1.1
	accuracy_mult_unwielded = 0.7
	scatter = 9
	scatter_unwielded = 15

	damage_falloff_mult = 0.75

	gun_firemode = GUN_FIREMODE_AUTOMATIC
	fire_delay = 0.15 SECONDS
	heat_per_fire = 3.3
	rounds_per_shot = 12
	mode_list = list(
		"Standard" = /datum/lasrifle/base/plasma_smg/smg_standard,
		"Overcharge" = /datum/lasrifle/base/plasma_smg/smg_overcharge,
	)
	attachable_offset = list("muzzle_x" = 43, "muzzle_y" = 17,"rail_x" = 25, "rail_y" = 25, "under_x" = 33, "under_y" = 11, "stock_x" = 0, "stock_y" = 13)
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/reddot,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
	)

/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma/smg/standard
	starting_attachment_types = list(
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/reddot,
		/obj/item/attachable/bayonet,
	)

/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma/smg/motion_sensor
	starting_attachment_types = list(
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/bayonet,
	)

/datum/lasrifle/base/plasma_smg/smg_standard
	fire_sound = 'sound/weapons/guns/fire/plasma_fire_fast.ogg'
	ammo_datum_type = /datum/ammo/energy/plasma/smg_standard/four
	icon_state = "plasma_smg"
	fire_mode = GUN_FIREMODE_AUTOMATIC
	fire_delay = 0.15 SECONDS
	heat_per_fire = 3.3
	rounds_per_shot = 12
	radial_icon_state = "plasma_bouncy"
	message_to_user = "You set the guns's firemode to standard fire."

/datum/lasrifle/base/plasma_smg/smg_overcharge
	fire_sound = 'sound/weapons/guns/fire/plasma_fire_heavy.ogg'
	ammo_datum_type = /datum/ammo/energy/plasma/blast
	icon_state = "plasma_smg"
	fire_mode = GUN_FIREMODE_AUTOMATIC
	fire_delay = 1 SECONDS
	heat_per_fire = 25
	rounds_per_shot = 90
	radial_icon_state = "plasma_cannon"
	message_to_user = "You set the guns's firemode to overcharge."
