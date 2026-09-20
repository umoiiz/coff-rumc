/obj/item/weapon/gun/rifle
	icon = 'icons/obj/items/gun/rifle.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/rifle_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/rifle_righthand_1.dmi',
	)
	reload_sound = 'sound/weapons/guns/interact/rifle_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/cocked.ogg'
	silenced_sound = 'sound/weapons/guns/rifles/AR-12/AR12_SIL.ogg'
	wield_sound =    'sound/weapons/guns/rifles/Deploy_Wave_RIFLES.ogg'
	equip_slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	gun_features_flags = GUN_CAN_POINTBLANK||GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	load_method = MAGAZINE //codex
	aim_slowdown = 0.35
	wield_delay = 0.8 SECONDS
	gun_skill_category = SKILL_RIFLES

	burst_amount = 3
	burst_delay = 0.2 SECONDS
	accuracy_mult_unwielded = 0.6
	scatter = 0
	scatter_unwielded = 13
	recoil_unwielded = 4
	damage_falloff_mult = 0.5
	akimbo_scatter_mod = 8

//-------------------------------------------------------
//AR-18 Carbine

/obj/item/weapon/gun/rifle/ar18
	name = "\improper AR-18 Kauser卡宾枪"
	desc = "凯克勒与霍赫AR-18卡宾枪是地球政府陆战队使用的标准步枪之一.通常被喜欢在战斗中拥有更高机动性的人使用,比如侦察兵和其他轻步兵.使用10x24mm无壳弹药."
	icon_state = "t18"
	worn_icon_state = "t18"
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_ar18.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound =   'sound/weapons/guns/rifles/AR-18/AR18_clipout.ogg'
	reload_sound =   'sound/weapons/guns/rifles/AR-18/AR18_clipin.ogg'
	cocked_sound =   'sound/weapons/guns/rifles/AR-18/AR18_boltpull.ogg'
	silenced_sound = 'sound/weapons/guns/rifles/AR-11/AR11_SIL.ogg'
	caliber = CALIBER_10X24_CASELESS //codex
	max_shells = 36 //codex
	force = 20
	default_ammo_type = /obj/item/ammo_magazine/rifle/ar18
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/ar18,
		/obj/item/ammo_magazine/rifle/ar18/ap,
	)
	attachable_allowed = list(
		/obj/item/attachable/stock/ar18stock,
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/shoulder_mount,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	starting_attachment_types = list(/obj/item/attachable/stock/ar18stock)
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 16,"rail_x" = 5, "rail_y" = 19, "under_x" = 18, "under_y" = 14, "stock_x" = 0, "stock_y" = 13)
	aim_fire_delay = 0.1 SECONDS
	aim_speed_modifier = 2

	fire_delay = 0.2 SECONDS
	burst_delay = 0.1 SECONDS
	extra_delay = 0.1 SECONDS
	accuracy_mult = 1.05
	scatter = 0
	burst_amount = 4
	aim_slowdown = 0.30
	damage_falloff_mult = 0.9
	movement_acc_penalty_mult = 4

/obj/item/weapon/gun/rifle/ar18/pointman
	starting_attachment_types = list(/obj/item/attachable/stock/ar18stock, /obj/item/attachable/lasersight, /obj/item/attachable/flashlight)

/obj/item/weapon/gun/rifle/ar18/standard
	starting_attachment_types = list(/obj/item/attachable/stock/ar18stock, /obj/item/weapon/gun/grenade_launcher/underslung, /obj/item/attachable/reddot, /obj/item/attachable/extended_barrel)

/obj/item/weapon/gun/rifle/ar18/scout
	starting_attachment_types = list(/obj/item/attachable/stock/ar18stock, /obj/item/weapon/gun/grenade_launcher/underslung, /obj/item/attachable/motiondetector, /obj/item/attachable/extended_barrel)

/obj/item/weapon/gun/rifle/ar18/engineer
	starting_attachment_types = list(/obj/item/attachable/stock/ar18stock, /obj/item/attachable/magnetic_harness, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/rifle/ar18/plasma_pistol
	starting_attachment_types = list(/obj/item/attachable/stock/ar18stock, /obj/item/weapon/gun/pistol/plasma_pistol, /obj/item/attachable/motiondetector, /obj/item/attachable/compensator)

/obj/item/weapon/gun/rifle/ar18/beginner
	starting_attachment_types = list(/obj/item/attachable/stock/ar18stock, /obj/item/attachable/magnetic_harness, /obj/item/attachable/angledgrip, /obj/item/attachable/compensator)

//-------------------------------------------------------
//AR-12 Assault Rifle

/obj/item/weapon/gun/rifle/ar12
	name = "\improper AR-12 K&H突击步枪"
	desc = "凯克勒与霍赫AR-12突击步枪曾是地球政府陆战队的标准配发步枪,直到AR-18卡宾枪将其取代.然而,尽管如此,它仍被广泛使用.这把枪本身在大多数情况下都非常好用,但在近距离交战中表现不佳,且相比其他一些枪械较难抵肩.它使用10x24mm无壳弹药."
	icon_state = "t12"
	worn_icon_state = "t12"
	fire_sound = SFX_GUN_AR12
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound =   'sound/weapons/guns/rifles/AR-12/AR12_clipout.ogg'
	reload_sound =   'sound/weapons/guns/rifles/AR-12/AR12_clipin.ogg'
	cocked_sound =   'sound/weapons/guns/rifles/AR-12/AR12_boltpull.ogg'
	caliber = CALIBER_10X24_CASELESS //codex
	max_shells = 50 //codex
	force = 20
	default_ammo_type = /obj/item/ammo_magazine/rifle/ar12
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/ar12,
		/obj/item/ammo_magazine/rifle/ar12/incendiary,
	)
	attachable_allowed = list(
		/obj/item/attachable/stock/ar12stock,
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/angledgrip,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/shoulder_mount,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 17,"rail_x" = 0, "rail_y" = 23, "under_x" = 17, "under_y" = 13, "stock_x" = 0, "stock_y" = 13)
	aim_fire_delay = 0.1 SECONDS
	aim_speed_modifier = 2

	starting_attachment_types = list(/obj/item/attachable/stock/ar12stock)

	fire_delay = 0.2 SECONDS
	burst_delay = 0.15 SECONDS
	extra_delay = 0.05 SECONDS
	accuracy_mult = 1.1
	scatter = -2
	wield_delay = 0.9 SECONDS
	burst_amount = 3
	aim_slowdown = 0.4
	damage_falloff_mult = 0.5

	placed_overlay_iconstate = "t12"

/obj/item/weapon/gun/rifle/ar12/rifleman
	starting_attachment_types = list(/obj/item/attachable/stock/ar12stock, /obj/item/attachable/reddot, /obj/item/attachable/extended_barrel, /obj/item/weapon/gun/grenade_launcher/underslung)

/obj/item/weapon/gun/rifle/ar12/engineer
	starting_attachment_types = list(/obj/item/attachable/stock/ar12stock, /obj/item/attachable/magnetic_harness, /obj/item/attachable/extended_barrel, /obj/item/weapon/gun/flamer/mini_flamer)

/obj/item/weapon/gun/rifle/ar12/medic
	starting_attachment_types = list(/obj/item/attachable/stock/ar12stock, /obj/item/attachable/magnetic_harness, /obj/item/attachable/extended_barrel, /obj/item/weapon/gun/grenade_launcher/underslung)

//-------------------------------------------------------
//DMR-37 DMR

#define DMR_BUMP_FIRE_DELAY 0.3 SECONDS
#define DMR_BUMP_DAMAGE_MULT 0.6
#define DMR_BUMP_ACCURACY_MULT 0.9

/obj/item/weapon/gun/rifle/dmr37
	name = "\improper DMR-37 SCA指定射手步枪"
	desc = "圣克里斯托军械DMR-37是地球政府陆战队的指定射手步枪.它以在超常距离上非常稳定的命中精度而闻名,但它缺乏爆发射击模式或全自动模式.它主要被喜欢比大多数人更谨慎射击的人使用.使用10x27mm无壳口径."
	icon = 'icons/obj/items/gun/marksman64.dmi'
	icon_state = "t37"
	worn_icon_state = "t37"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/marksman_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/marksman_righthand_64.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32

	muzzleflash_iconstate = "muzzle_flash_medium"
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_dmr37.ogg'
	fire_rattle = 'sound/weapons/guns/fire/tgmc/kinetic/gun_dmr37_low.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound =  'sound/weapons/guns/dmr/DMR-37/DMR37_clipout.ogg'
	reload_sound =  'sound/weapons/guns/dmr/DMR-37/DMR37_clipin.ogg'
	cocked_sound =   'sound/weapons/guns/dmr/DMR-37/DMR37_boltpull.ogg'
	silenced_sound = 'sound/weapons/guns/dmr/DMR-37/DMR37_SIL.ogg'
	wield_sound =    'sound/weapons/guns/dmr/Deploy_Wave_DMR.ogg'
	caliber = CALIBER_10X27_CASELESS //codex
	aim_slowdown = 0.75
	wield_delay = 1 SECONDS
	force = 20
	max_shells = 20 //codex
	default_ammo_type = /obj/item/ammo_magazine/rifle/dmr37
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/dmr37)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/gyro,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini/dmr,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/buildasentry,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_CAN_POINTBLANK|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	starting_attachment_types = list(/obj/item/attachable/scope/mini/dmr)
	attachable_offset = list("muzzle_x" = 50, "muzzle_y" = 20,"rail_x" = 21, "rail_y" = 22, "under_x" = 31, "under_y" = 15, "stock_x" = 14, "stock_y" = 10)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.2 SECONDS
	aim_speed_modifier = 2

	fire_delay = 0.65 SECONDS
	accuracy_mult = 1.15
	scatter = -4
	burst_amount = 1
	movement_acc_penalty_mult = 6

	var/bump_fire = FALSE

/obj/item/weapon/gun/rifle/dmr37/toggle_aim_mode(mob/living/carbon/human/user)
	if(bump_fire)
		balloon_alert(user, "你无法在撞火时瞄准")
		return
	return ..()

/obj/item/weapon/gun/rifle/dmr37/unique_action(mob/user)
	if(!user)
		CRASH("switch_modes called with no user.")

	if(bump_fire)
		fire_delay = initial(fire_delay)
		damage_mult = initial(damage_mult)
		accuracy_mult = initial(accuracy_mult)
		bump_fire = FALSE

		balloon_alert(user, "你开始正常射击")
	else
		if(HAS_TRAIT(src, TRAIT_GUN_IS_AIMING))
			toggle_aim_mode(user)
		fire_delay = DMR_BUMP_FIRE_DELAY
		damage_mult = DMR_BUMP_DAMAGE_MULT
		accuracy_mult = DMR_BUMP_ACCURACY_MULT
		bump_fire = TRUE

		balloon_alert(user, "你开始撞火射击")

	SEND_SIGNAL(src, COMSIG_GUN_AUTOFIREDELAY_MODIFIED, fire_delay)

/obj/item/weapon/gun/rifle/dmr37/marksman
	starting_attachment_types = list(/obj/item/attachable/scope, /obj/item/attachable/angledgrip, /obj/item/attachable/extended_barrel)

/obj/item/weapon/gun/rifle/dmr37/beginner
	starting_attachment_types = list(/obj/item/attachable/scope, /obj/item/attachable/verticalgrip, /obj/item/attachable/extended_barrel)

#undef DMR_BUMP_FIRE_DELAY
#undef DMR_BUMP_DAMAGE_MULT
#undef DMR_BUMP_ACCURACY_MULT

//-------------------------------------------------------
//BR-64 BR

/obj/item/weapon/gun/rifle/br64
	name = "\improper BR-64 SCA战斗步枪"
	desc = "圣克里斯托军械BR-64是地球政府陆战队的主力战斗步枪.它以在大多数距离上表现稳定,以及中距离爆发停止力而闻名.它主要被喜欢比平均水平更大口径弹药的人使用.使用10x26.5smm无壳口径."
	icon_state = "t64"
	worn_icon_state = "t64"
	icon = 'icons/obj/items/gun/marksman64.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/marksman_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/marksman_righthand_64.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32

	muzzleflash_iconstate = "muzzle_flash_medium"
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_br64.ogg'
	fire_rattle = 'sound/weapons/guns/fire/tgmc/kinetic/gun_br64_low.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound =   'sound/weapons/guns/dmr/BR-64/BR64_clipout.ogg'
	reload_sound =   'sound/weapons/guns/dmr/BR-64/BR64_clipin.ogg'
	cocked_sound =   'sound/weapons/guns/dmr/BR-64/BR64_boltpull.ogg'
	silenced_sound = 'sound/weapons/guns/dmr/BR-64/BR64_SIL.ogg'
	wield_sound =    'sound/weapons/guns/dmr/Deploy_Wave_DMR.ogg'
	caliber = CALIBER_10X265_CASELESS //codex
	aim_slowdown = 0.55
	wield_delay = 0.9 SECONDS
	force = 20
	max_shells = 36 //codex
	default_ammo_type = /obj/item/ammo_magazine/rifle/br64
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/br64,
	)
	attachable_allowed = list(
		/obj/item/attachable/stock/br64stock,
		/obj/item/weapon/gun/grenade_launcher/underslung/br64,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/gyro,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/buildasentry,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/shoulder_mount,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam, //RUTGMC EDIT
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_CAN_POINTBLANK|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	starting_attachment_types = list(/obj/item/attachable/stock/br64stock, /obj/item/weapon/gun/grenade_launcher/underslung/br64, /obj/item/attachable/scope/mini)
	attachable_offset = list("muzzle_x" = 44, "muzzle_y" = 19,"rail_x" = 18, "rail_y" = 23, "under_x" = 33, "under_y" = 13, "stock_x" = 11, "stock_y" = 14)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.2 SECONDS
	aim_speed_modifier = 3

	fire_delay = 0.3 SECONDS
	burst_amount = 3
	burst_delay = 0.10 SECONDS
	extra_delay = 0.25 SECONDS
	accuracy_mult = 0.9
	scatter = 0

/obj/item/weapon/gun/rifle/br64/standard
	starting_attachment_types = list(/obj/item/attachable/stock/br64stock, /obj/item/weapon/gun/grenade_launcher/underslung/br64, /obj/item/attachable/reddot, /obj/item/attachable/extended_barrel)

//-------------------------------------------------------
//PR-412 Pulse Rifle

/obj/item/weapon/gun/rifle/m412
	name = "\improper PR-412脉冲步枪"
	desc = "PR-412步枪是脉冲工业公司的一款步枪,因其使用电子击发以实现更高初速而被宣传为脉冲步枪.在大多数星系中相当常见.使用10x24mm无壳弹药."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "m412"
	worn_icon_state = "m412"
	muzzleflash_iconstate = "muzzle_flash_medium"
	fire_sound = 'sound/weapons/guns/fire/M412.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/m41a_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m41a_reload.ogg'
	caliber = CALIBER_10X24_CASELESS //codex
	max_shells = 40 //codex
	default_ammo_type = /obj/item/ammo_magazine/rifle
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/rifle/extended,
		/obj/item/ammo_magazine/rifle/incendiary,
		/obj/item/ammo_magazine/rifle/ap,
	)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/buildasentry,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/shoulder_mount,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam, //RUTGMC EDIT
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	starting_attachment_types = list(/obj/item/weapon/gun/grenade_launcher/underslung)
	attachable_offset = list("muzzle_x" = 44, "muzzle_y" = 19,"rail_x" = 15, "rail_y" = 21, "under_x" = 25, "under_y" = 16, "stock_x" = 18, "stock_y" = 15)

	fire_delay = 0.2 SECONDS
	burst_delay = 0.15 SECONDS
	accuracy_mult = 1.1
	scatter = -1
	wield_delay = 0.9 SECONDS
	burst_amount = 3
	aim_slowdown = 0.4
	damage_mult = 1.05 //Has smaller magazines



//-------------------------------------------------------
//PR-412 PMC VARIANT

/obj/item/weapon/gun/rifle/m412/elite
	name = "\improper PR-412E战斗步枪"
	desc = "PR-412脉冲步枪系列的\"精英\"改装版,配发给特种作战单位.它被加装了枪托和一根带有集成枪管充电器的更长枪管,枪身上不知为何还印有一个红色骷髅图案."
	icon_state = "m412e"
	worn_icon_state = "m412e"
	default_ammo_type = /obj/item/ammo_magazine/rifle/ap
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/weapon/gun/grenade_launcher/underslung/elite,
		/obj/item/attachable/buildasentry,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	attachable_offset = list("muzzle_x" = 44, "muzzle_y" = 19,"rail_x" = 15, "rail_y" = 21, "under_x" = 25, "under_y" = 16, "stock_x" = 18, "stock_y" = 15)
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/weapon/gun/grenade_launcher/underslung/elite)
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)


	burst_amount = 1
	burst_delay = 0.15 SECONDS
	accuracy_mult = 1.15
	damage_mult = 1.5
	scatter = -2
	force = 20


//-------------------------------------------------------
//PR-11

/obj/item/weapon/gun/rifle/m41a
	name = "\improper PR-11脉冲步枪"
	desc = "一把奇怪的失败电子击发步枪,当时相当不为人知.不过它引发了现代电子击发的使用热潮.使用10x24mm无壳弹药.拥有不可拆卸的榴弹发射器."
	icon = 'icons/obj/items/gun/machinegun64.dmi'
	icon_state = "m41a"
	worn_icon_state = "m41a"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_1.dmi',
	)
	fire_sound = SFX_GUN_PULSE
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/m41a_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m41a_reload.ogg'
	aim_slowdown = 0.5
	wield_delay = 1.55 SECONDS
	max_shells = 95 //codex
	default_ammo_type = /obj/item/ammo_magazine/rifle/m41a
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/m41a)
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/reddot,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/scope,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/stock/m41a,
		/obj/item/weapon/gun/grenade_launcher/underslung/invisible,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	starting_attachment_types = list(/obj/item/attachable/stock/m41a, /obj/item/weapon/gun/grenade_launcher/underslung/invisible)
	attachable_offset = list("muzzle_x" = 41, "muzzle_y" = 19,"rail_x" = 12, "rail_y" = 24, "under_x" = 24, "under_y" = 13, "stock_x" = 22, "stock_y" = 16)

	burst_amount = 4
	burst_delay = 0.15 SECONDS
	scatter = 0
	fire_delay = 0.2 SECONDS

/obj/item/weapon/gun/rifle/m41a/magharness
	starting_attachment_types = list(
		/obj/item/attachable/stock/m41a,
		/obj/item/attachable/magnetic_harness,
		/obj/item/weapon/gun/grenade_launcher/underslung/invisible,
	)

//-------------------------------------------------------

/obj/item/weapon/gun/rifle/mpi_km
	name = "\improper MPi-KM突击步枪"
	desc = "一把廉价而坚固的步枪,有时更常被称为\"AK\".装填7.62x39mm弹药.尽管除了下挂之外缺乏附件挂点,但凭借其低廉的成本和高于寻常的口径弹药,在黑市上仍是热门产品."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "ak47"
	worn_icon_state = "ak47"
	caliber = CALIBER_762X39 //codex
	muzzleflash_iconstate = "muzzle_flash_medium"
	max_shells = 40 //codex
	fire_sound = 'sound/weapons/guns/fire/ak47.ogg'
	unload_sound = 'sound/weapons/guns/interact/ak47_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/ak47_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/ak47_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/mpi_km/plum
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/mpi_km,
		/obj/item/ammo_magazine/rifle/mpi_km/plum,
		/obj/item/ammo_magazine/rifle/mpi_km/black,
		/obj/item/ammo_magazine/rifle/mpi_km/carbine,
		/obj/item/ammo_magazine/rifle/mpi_km/carbine/plum,
		/obj/item/ammo_magazine/rifle/mpi_km/carbine/black,
		/obj/item/ammo_magazine/rifle/mpi_km/extended,
	)
	aim_slowdown = 0.5
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/stock/mpi_km,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/verticalgrip,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/weapon/gun/grenade_launcher/underslung/mpi, //alt sprite, unremovable
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 35, "muzzle_y" = 18,"rail_x" = 6, "rail_y" = 20, "under_x" = 19, "under_y" = 14, "stock_x" = 5, "stock_y" = 12)
	starting_attachment_types = list(/obj/item/attachable/stock/mpi_km)
	force = 20

	burst_amount = 1
	fire_delay = 0.25 SECONDS
	scatter = 0
	wield_delay = 0.9 SECONDS

	placed_overlay_iconstate = "ak47"

/obj/item/weapon/gun/rifle/mpi_km/standard
	starting_attachment_types = list(
		/obj/item/attachable/stock/mpi_km,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/bayonet,
	)

/obj/item/weapon/gun/rifle/mpi_km/grenadier
	desc = "一把廉价而坚固的步枪,有时更常被称为\"AK\".装填7.62x39mm弹药.这一把内置了下挂榴弹发射器,看起来非常老旧,但保养得很好."
	starting_attachment_types = list(
		/obj/item/attachable/stock/mpi_km,
		/obj/item/weapon/gun/grenade_launcher/underslung/mpi,
		/obj/item/attachable/magnetic_harness,
	)

/obj/item/weapon/gun/rifle/mpi_km/black
	name = "\improper MPi-KM突击步枪"
	desc = "一把由SOM制造的廉价而坚固的步枪,以其可靠性和停止力而闻名.有时更常被称为\"AK\",装填7.62x39mm弹药."
	icon_state = "ak47_black"
	worn_icon_state = "ak47_black"
	default_ammo_type = /obj/item/ammo_magazine/rifle/mpi_km/black
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/stock/mpi_km/black,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/verticalgrip,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/weapon/gun/grenade_launcher/underslung/mpi, //alt sprite, unremovable
		/obj/item/attachable/reddot,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)
	starting_attachment_types = list(/obj/item/attachable/stock/mpi_km/black)

/obj/item/weapon/gun/rifle/mpi_km/black/magharness
	starting_attachment_types = list(
		/obj/item/attachable/stock/mpi_km/black,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/lasersight,
	)

/obj/item/weapon/gun/rifle/mpi_km/black/grenadier
	desc = "一把由SOM制造的廉价而坚固的步枪,以其可靠性和停止力而闻名.有时更常被称为\"AK\",装填7.62x39mm弹药.这一把内置了下挂榴弹发射器."
	starting_attachment_types = list(
		/obj/item/attachable/stock/mpi_km/black,
		/obj/item/weapon/gun/grenade_launcher/underslung/mpi,
		/obj/item/attachable/reddot,
	)

//-------------------------------------------------------
// MPI-KM but for marines

/obj/item/weapon/gun/rifle/type16
	name = "\improper 16式\"重犯\"步枪"
	desc = "MPi-KM步枪的中国仿制品,采用胶木制造并配有皮卡汀尼战术导轨.使用6.02x41mm弹药."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	unique_reskin = list(
		"Polymer" = "ak47_black",
		"Plum" = "ak47",
	)
	icon_state = "ak47"
	worn_icon_state = "ak47"
	caliber = CALIBER_602X41
	muzzleflash_iconstate = "muzzle_flash_medium"
	max_shells = 40
	fire_sound = 'sound/weapons/guns/fire/ak47.ogg'
	unload_sound = 'sound/weapons/guns/interact/ak47_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/ak47_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/ak47_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/type16
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/type16,
		/obj/item/ammo_magazine/rifle/type16/m2,
		/obj/item/ammo_magazine/rifle/type16/extended,
	)
	attachable_allowed = list(
		/obj/item/attachable/stock/mpi_km,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/angledgrip,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/shoulder_mount,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam,
		/obj/item/attachable/b7_scope,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)
	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES|GUN_WIELDED_FIRING_ONLY
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO, GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 35, "muzzle_y" = 18,"rail_x" = 6, "rail_y" = 20, "under_x" = 19, "under_y" = 14, "stock_x" = 5, "stock_y" = 12)
	starting_attachment_types = list(/obj/item/attachable/stock/mpi_km)
	damage_falloff_mult = 0.5
	force = 20
	burst_amount = 2
	autoburst_delay = 0.1 SECONDS
	fire_delay = 0.2 SECONDS
	aim_speed_modifier = 2.5
	placed_overlay_iconstate = "ak47"

/obj/item/weapon/gun/rifle/type16/m2
	name = "\improper 16M2式\"曙光\"卡宾枪"
	desc = "MPi-KM步枪的中国仿制品,采用时尚的聚合物制造,配有战术皮卡汀尼导轨和折叠枪托.使用6.02x41mm弹药."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "v34_black"
	worn_icon_state = "v34_black"
	unique_reskin = list(
		"Polymer" = "v34_black",
		"Plum" = "v34",
	)
	muzzleflash_iconstate = "muzzle_flash"
	max_shells = 30
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo_type = /obj/item/ammo_magazine/rifle/type16/m2
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/type16,
		/obj/item/ammo_magazine/rifle/type16/m2,
		/obj/item/ammo_magazine/rifle/type16/extended,
	)
	attachable_allowed = list(
		/obj/item/attachable/foldable/som_carbine,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/angledgrip,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/b7_scope,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)
	equip_slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 18,"rail_x" = 8, "rail_y" = 20, "under_x" = 17, "under_y" = 13, "stock_x" = -6, "stock_y" = 16)
	starting_attachment_types = list(/obj/item/attachable/foldable/som_carbine)
	force = 10
	burst_amount = 1
	fire_delay = 0.20 SECONDS
	accuracy_mult = 0.75
	scatter = 12
	recoil = 2
	wield_delay = 0.5 SECONDS
	movement_acc_penalty_mult = 4
	burst_amount = 3
	autoburst_delay = 0.10 SECONDS
	damage_falloff_mult = 2.3
	akimbo_additional_delay = 2
	akimbo_scatter_mod = 24
	akimbo_additional_delay = 20
	aim_speed_modifier = 2.5

//-------------------------------------------------------

// RPD

/obj/item/weapon/gun/rifle/lmg_d
	name = "\improper lMG-D轻机枪"
	desc = "一款廉价而坚固的机枪,有时更常被称为\"RPD\".发射7.62x39mm弹药.尽管除了下挂导轨外缺乏其他配件安装点,但凭借其低廉的成本,高容量和高于常规的口径,它仍然是黑市上的热门产品."
	icon = 'icons/obj/items/gun/machinegun64.dmi'
	icon_state = "rpd"
	worn_icon_state = "rpd"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_1.dmi',
	)
	fire_animation = "rpd_fire"
	caliber = CALIBER_762X39 //codex
	muzzleflash_iconstate = "muzzle_flash_medium"
	max_shells = 100  //codex
	wield_delay = 1.4 SECONDS
	aim_slowdown = 0.95
	fire_sound = 'sound/weapons/guns/fire/ak47.ogg'
	unload_sound = 'sound/weapons/guns/interact/ak47_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/ak47_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/ak47_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/lmg_d
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/lmg_d)
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/stock/lmg_d,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/foldable/bipod,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/weapon/gun/grenade_launcher/underslung/mpi,
		/obj/item/attachable/reddot,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)

	attachable_offset = list("muzzle_x" = 35, "muzzle_y" = 18,"rail_x" = 6, "rail_y" = 20, "under_x" = 19, "under_y" = 14, "stock_x" = 6, "stock_y" = 14)
	starting_attachment_types = list(/obj/item/attachable/stock/lmg_d)

	fire_delay = 0.25 SECONDS
	scatter = 2
	burst_amount = 1
	movement_acc_penalty_mult = 6

/obj/item/weapon/gun/rifle/lmg_d/magharness
	starting_attachment_types = list(
		/obj/item/attachable/stock/lmg_d,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/foldable/bipod,
	)

//-------------------------------------------------------
//DP-27

/obj/item/weapon/gun/rifle/dpm
	name = "\improper 捷格加廖夫\"RP\"机枪"
	desc = "一款廉价而坚固的机枪,常见于气泡边缘地带.发射高口径弹药以弥补其缓慢的射速,因其外形相似而通常被称为\"唱片机\".发射7.62x39mm穿甲弹."
	icon = 'icons/obj/items/gun/machinegun64.dmi'
	icon_state = "dp27"
	worn_icon_state = "dp27"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_1.dmi',
	)
	max_shells = 47 //codex
	caliber = CALIBER_762X39 //codex
	fire_sound = SFX_SVD_FIRE
	dry_fire_sound = 'sound/weapons/guns/fire/dpm.ogg'
	unload_sound = 'sound/weapons/guns/interact/dpm_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/dpm_reload.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/dpm
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/dpm)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/dpm,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17,"rail_x" = 22, "rail_y" = 17, "under_x" = 32, "under_y" = 14, "stock_x" = 13, "stock_y" = 9)
	starting_attachment_types = list(/obj/item/attachable/stock/dpm)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.25 SECONDS
	aim_speed_modifier = 0.75

	fire_delay = 0.45 SECONDS
	damage_mult = 2
	burst_amount = 1
	accuracy_mult = 1
	scatter = 2
	recoil = -1
	wield_delay = 0.7 SECONDS
	aim_slowdown = 0.85
	movement_acc_penalty_mult = 4

//-------------------------------------------------------
//M16 RIFLE

/obj/item/weapon/gun/rifle/m16
	name = "\improper FN M16A4突击步枪"
	desc = "一款轻便,多用途的突击步枪,配有30发弹匣,发射5.56x45mm北约弹药.M16平台的第四代产品,这款FN变体增加了全自动射击模式,凭借其高度可定制性在雇佣兵和民兵中仍占有一席之地.它在快速点射方面表现出色,但必须控制好射击节奏."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "m16a4"
	worn_icon_state = "m16a4"
	muzzleflash_iconstate = "muzzle_flash_medium"
	caliber = CALIBER_556X45 //codex
	max_shells = 30 //codex
	fire_sound = 'sound/weapons/guns/fire/m16.ogg'
	unload_sound = 'sound/weapons/guns/interact/m16_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m16_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/m16_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/m16
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/m16)
	aim_slowdown = 0.4
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/m16sight,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/buildasentry,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/shoulder_mount,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE)
	attachable_offset = list("muzzle_x" = 47, "muzzle_y" = 19,"rail_x" = 18, "rail_y" = 24, "under_x" = 29, "under_y" = 15, "stock_x" = 19, "stock_y" = 13)
	aim_fire_delay = 0.2 SECONDS
	aim_speed_modifier = 2.5

	fire_delay = 0.2 SECONDS
	scatter = 2
	extra_delay = -0.05 SECONDS
	burst_delay = 0.15 SECONDS
	accuracy_mult = 1.1
	wield_delay = 0.7 SECONDS
	damage_mult = 1.2

/obj/item/weapon/gun/rifle/m16/freelancer
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/bayonet, /obj/item/weapon/gun/shotgun/combat/masterkey)

/obj/item/weapon/gun/rifle/m16/ugl
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/bayonet, /obj/item/weapon/gun/grenade_launcher/underslung)

/obj/item/weapon/gun/rifle/m16/spec_op
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/suppressor, /obj/item/weapon/gun/shotgun/combat/masterkey)

//-------------------------------------------------------
//FAMAS rifle, based on the F1

/obj/item/weapon/gun/rifle/famas
	name = "\improper FAMAS突击步枪"
	desc = "一款轻便,多用途的高射速突击步枪,配有24发弹匣和短距离瞄准镜,能在短时间内发射5.56x45mm北约弹药."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "famas"
	worn_icon_state = "famas"
	muzzleflash_iconstate = "muzzle_flash_medium"
	caliber = CALIBER_556X45 //codex
	max_shells = 24 //codex
	fire_sound = 'sound/weapons/guns/fire/famas.ogg'
	unload_sound = 'sound/weapons/guns/interact/m16_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m16_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/m16_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/famas
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/famas)
	aim_slowdown = 0.4
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	attachable_offset = list("muzzle_x" = 38, "muzzle_y" = 17,"rail_x" = 22, "rail_y" = 24, "under_x" = 28, "under_y" = 12, "stock_x" = 19, "stock_y" = 13)

	fire_delay = 0.15 SECONDS
	burst_delay = 0.15 SECONDS
	accuracy_mult = 1.15
	wield_delay = 0.7 SECONDS
	damage_mult = 1.2
	scatter = 1
	movement_acc_penalty_mult = 4

/obj/item/weapon/gun/rifle/famas/freelancermedic
	starting_attachment_types = list(/obj/item/attachable/lasersight, /obj/item/attachable/magnetic_harness, /obj/item/attachable/bayonet)


//-------------------------------------------------------
//MG-42 Light Machine Gun

/obj/item/weapon/gun/rifle/mg42
	name = "\improper MG-42考泽轻机枪"
	desc = "考泽MG-42是TGMC目前标准的非IFF能力轻机枪.以其出色的重型火力支援能力而闻名.通常在有人想要守住阵地或提供火力支援时使用.使用10x24mm弹药."

	icon_state = "t42"
	worn_icon_state = "t42"
	icon = 'icons/obj/items/gun/machinegun.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_64.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32

	caliber = CALIBER_10X24_CASELESS //codex
	max_shells = 120 //codex
	force = 30
	aim_slowdown = 0.8
	wield_delay = 1.2 SECONDS
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_mg42.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	cocked_sound = 'sound/weapons/guns/machineguns/MG-42/MG42_boltpull.ogg'
	wield_sound =  'sound/weapons/guns/machineguns/Deploy_Wave_MACHINEGUN.ogg'
	unload_sound = 'sound/weapons/guns/machineguns/MG-42/MG42_clipout.ogg'
	reload_sound = 'sound/weapons/guns/machineguns/MG-42/MG42_clipin.ogg'
	default_ammo_type = /obj/item/ammo_magazine/mg42
	allowed_ammo_types = list(/obj/item/ammo_magazine/mg42)
	attachable_allowed = list(
		/obj/item/attachable/stock/t42stock,
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_AUTOBURST)
	gun_skill_category = SKILL_HEAVY_WEAPONS
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 17,"rail_x" = 4, "rail_y" = 20, "under_x" = 16, "under_y" = 14, "stock_x" = 0, "stock_y" = 13)
	aim_fire_delay = 0.1 SECONDS
	aim_speed_modifier = 2

	starting_attachment_types = list(/obj/item/attachable/stock/t42stock)

	fire_delay = 0.2 SECONDS
	burst_delay = 0.15 SECONDS
	extra_delay = 0.05 SECONDS
	accuracy_mult = 1.1
	accuracy_mult_unwielded = 0.5
	scatter = 2
	scatter_unwielded = 80
	movement_acc_penalty_mult = 6

/obj/item/weapon/gun/rifle/mg42/autorifleman
	starting_attachment_types = list(/obj/item/attachable/verticalgrip, /obj/item/attachable/reddot)

/obj/item/weapon/gun/rifle/mg42/autorifleman
	starting_attachment_types = list(/obj/item/attachable/verticalgrip, /obj/item/attachable/reddot)

//-------------------------------------------------------
//MG-60 General Purpose Machine Gun

/obj/item/weapon/gun/rifle/mg60
	name = "\improper MG-60劳姆金属通用机枪"
	desc = "劳姆金属MG-60通用机枪是TGMC目前标准的通用机枪.虽然通常安装在载具上,但有时也被步兵用于守住要道或压制敌人,或在少数情况下用于行进间射击.使用10x26mm弹箱."
	icon = 'icons/obj/items/gun/machinegun64.dmi'
	icon_state = "t60"
	worn_icon_state = "t60"
	fire_animation = "t60_fire"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_64.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32

	caliber = CALIBER_10X26_CASELESS //codex
	max_shells = 200 //codex
	force = 35
	aim_slowdown = 1.2
	wield_delay = 1.7 SECONDS
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_mg60.ogg'
	fire_rattle = 'sound/weapons/guns/fire/tgmc/kinetic/gun_mg60_low.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/machineguns/MG-60/MG60_boxout.ogg'
	reload_sound = 'sound/weapons/guns/machineguns/MG-60/MG60_boxin.ogg'
	cocked_sound = 'sound/weapons/guns/machineguns/MG-60/MG60_boltpull.ogg'
	wield_sound =  'sound/weapons/guns/machineguns/Deploy_Wave_MACHINEGUN.ogg'
	default_ammo_type = /obj/item/ammo_magazine/mg60
	allowed_ammo_types = list(/obj/item/ammo_magazine/mg60)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/stock/t60stock,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	starting_attachment_types = list(/obj/item/attachable/stock/t60stock)
	gun_skill_category = SKILL_HEAVY_WEAPONS
	attachable_offset = list("muzzle_x" = 42, "muzzle_y" = 21,"rail_x" = 6, "rail_y" = 23, "under_x" = 26, "under_y" = 15, "stock_x" = 8, "stock_y" = 13)
	aim_fire_delay = 0.1 SECONDS
	aim_speed_modifier = 5

	fire_delay = 0.15 SECONDS
	damage_falloff_mult = 0.5
	burst_amount = 1
	accuracy_mult = 0.85
	accuracy_mult_unwielded = 0.4
	scatter = 7
	scatter_unwielded = 45
	movement_acc_penalty_mult = 7.25

	placed_overlay_iconstate = "lmg"

/obj/item/weapon/gun/rifle/mg60/machinegunner
	starting_attachment_types = list(/obj/item/attachable/stock/t60stock, /obj/item/attachable/foldable/bipod, /obj/item/attachable/magnetic_harness, /obj/item/attachable/extended_barrel)

/obj/item/weapon/gun/rifle/mg60/beginner
	starting_attachment_types = list(/obj/item/attachable/stock/t60stock, /obj/item/attachable/foldable/bipod, /obj/item/attachable/magnetic_harness, /obj/item/attachable/heavy_barrel)

//-------------------------------------------------------
//M41AE2 Heavy Pulse Rifle

/obj/item/weapon/gun/rifle/m412l1_hpr
	name = "\improper PR-412L1重型脉冲步枪"
	desc = "一款能够进行压制射击的大型武器,基于PR-412脉冲步枪平台.在点射中效果显著.使用10x24mm无壳弹药."
	icon = 'icons/obj/items/gun/machinegun64.dmi'
	icon_state = "m412l1"
	worn_icon_state = "m412l1"
	fire_animation = "m412l1_fire"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_1.dmi',
	)
	caliber = CALIBER_10X24_CASELESS //codex
	max_shells = 200 //codex
	aim_slowdown = 0.8
	wield_delay = 2.2 SECONDS
	fire_sound = 'sound/weapons/guns/fire/hmg.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/m41a_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m41a_reload.ogg'
	default_ammo_type = /obj/item/ammo_magazine/m412l1_hpr
	allowed_ammo_types = list(/obj/item/ammo_magazine/m412l1_hpr)
	attachable_allowed = list(
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/buildasentry,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	gun_skill_category = SKILL_HEAVY_WEAPONS
	attachable_offset = list("muzzle_x" = 42, "muzzle_y" = 19,"rail_x" = 17, "rail_y" = 21, "under_x" = 31, "under_y" = 15, "stock_x" = 18, "stock_y" = 15)
	aim_speed_modifier = 2

	fire_delay = 0.3 SECONDS
	burst_amount = 5
	burst_delay = 0.1 SECONDS
	accuracy_mult_unwielded = 0.5
	accuracy_mult = 1.05
	scatter = 5
	scatter_unwielded = 25
	recoil_unwielded = 5
	force = 20

	placed_overlay_iconstate = "lmg"

/obj/item/weapon/gun/rifle/m412l1_hpr/freelancer
	starting_attachment_types = list(
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/foldable/bipod,
	)
//-------------------------------------------------------
//USL TYPE 71 RIFLE

/obj/item/weapon/gun/rifle/type71
	name = "\improper 71式\"雷霆\"脉冲步枪"
	desc = "USL海盗的主要步枪,71式是一款可靠的步枪,发射7.62x39mm弹药,采用三发点射以节省弹药.一款符合压倒性火力理论的新型压制型号正在研发中,目前仅配发给USL中有限数量的列兵."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "type71"
	worn_icon_state = "type71"
	unique_reskin = list(
		"Wood" = "type71_wood",
	)
	muzzleflash_iconstate = "muzzle_flash_medium"
	caliber = CALIBER_762X39 //codex
	max_shells = 42 //codex
	fire_sound = 'sound/weapons/guns/fire/type71.ogg'
	unload_sound = 'sound/weapons/guns/interact/type71_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/type71_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/type71_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/type71
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/type71,
	)
	aim_slowdown = 0.6
	wield_delay = 0.9 SECONDS
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/scope,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/angledgrip,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/weapon/gun/flamer/mini_flamer/unremovable,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam,
		/obj/item/attachable/suppressor/unremovable/invisible,
		/obj/item/attachable/scope/unremovable,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_offset = list("muzzle_x" = 41, "muzzle_y" = 19,"rail_x" = 18, "rail_y" = 24, "under_x" = 34, "under_y" = 16, "stock_x" = 19, "stock_y" = 13)
	gun_firemode_list = list(GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	aim_speed_modifier = 2

	fire_delay = 0.25 SECONDS
	burst_amount = 3
	accuracy_mult = 1.1
	accuracy_mult_unwielded = 0.8
	scatter = -1

/obj/item/weapon/gun/rifle/type71/beginner
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/bayonet, /obj/item/attachable/gyro)

/obj/item/weapon/gun/rifle/type71/flamer
	name = "\improper 71式脉冲步枪"
	desc = "这似乎是常见71式的一种较罕见变体,配有下挂式火焰喷射器和改进的机械瞄具."
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 23, "under_x" = 20, "under_y" = 13, "stock_x" = 24, "stock_y" = 13)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/marine,
		/obj/item/weapon/gun/flamer/mini_flamer/unremovable,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)
	starting_attachment_types = list(/obj/item/weapon/gun/flamer/mini_flamer/unremovable)

/obj/item/weapon/gun/rifle/type71/flamer/standard
	starting_attachment_types = list(
		/obj/item/weapon/gun/flamer/mini_flamer/unremovable,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/magnetic_harness,
	)

/obj/item/weapon/gun/rifle/type71/commando
	name = "\improper 73式\"突击队\"脉冲卡宾枪"
	desc = "标准71式的一种更为罕见的变体,此版本包含一体式消音器,瞄准镜以及大量精细调校.许多部件已被更换,打磨和改进.因此,这种变体在精锐部队之外极为罕见."
	icon_state = "type71"
	worn_icon_state = "type71"
	wield_delay = 0.2 SECONDS
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 22, "under_x" = 21, "under_y" = 18, "stock_x" = 21, "stock_y" = 18)
	starting_attachment_types = list(/obj/item/attachable/suppressor/unremovable/invisible, /obj/item/attachable/scope/unremovable)

	fire_delay = 0.3 SECONDS
	burst_amount = 2
	accuracy_mult = 1.25
	accuracy_mult_unwielded = 0.8
	damage_mult = 1.3

//-------------------------------------------------------
//SH-15 AUTOMATIC SHOTGUN

/obj/item/weapon/gun/rifle/sh15
	name = "\improper 绍尔SH-15自动霰弹枪"
	desc = "绍尔SH-15自动突击霰弹枪,这是泰拉军械库的变体.ZX系列枪械的又一迭代产品,不过此后已被规范为TGMC武库的一部分,因此有了SH的编号.它取代了各种霰弹枪型号,成为提供给TGMC的半自动霰弹枪.它带有膛线,主要装填较远射程的弹药,与鹿弹不兼容.使用12发16号弹匣."
	icon_state = "tx15"
	worn_icon_state = "tx15"
	icon = 'icons/obj/items/gun/shotgun.dmi'
	fire_sound =   'sound/weapons/guns/shotgun/SH-15/SH15.ogg'
	unload_sound = 'sound/weapons/guns/shotgun/SH-15/SH15_clipout.ogg'
	reload_sound = 'sound/weapons/guns/shotgun/SH-15/SH15_clipin.ogg'
	cocked_sound = 'sound/weapons/guns/shotgun/SH-15/SH15_boltpull.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/shotgun_empty.ogg'
	caliber = CALIBER_16G //codex
	max_shells = 12 //codex
	force = 20
	default_ammo_type = /obj/item/ammo_magazine/rifle/sh15_slug
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/shotgun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/shotgun_righthand_1.dmi',
	)
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/sh15_slug,
		/obj/item/ammo_magazine/rifle/sh15_flechette,
	)
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/sh15,
		/obj/item/attachable/compensator,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam, //RUTGMC EDIT
		/obj/item/weapon/gun/flamer/hydro_cannon,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES //Its a shotgun type weapon effectively, most shotgun type weapons shouldn't be able to point blank 1 handed.
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	starting_attachment_types = list(/obj/item/attachable/stock/sh15)
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 16,"rail_x" = 12, "rail_y" = 17, "under_x" = 20, "under_y" = 13, "stock_x" = 26, "stock_y" = 13)
	gun_skill_category = SKILL_SHOTGUNS

	fire_delay = 1 SECONDS
	accuracy_mult = 1.15
	burst_amount = 1
	scatter = -2
	movement_acc_penalty_mult = 3

/obj/item/weapon/gun/rifle/sh15/engineer
	starting_attachment_types = list(/obj/item/attachable/stock/sh15, /obj/item/attachable/magnetic_harness, /obj/item/weapon/gun/grenade_launcher/underslung)

/obj/item/weapon/gun/rifle/sh15/standard
	starting_attachment_types = list(/obj/item/attachable/stock/sh15, /obj/item/attachable/magnetic_harness, /obj/item/attachable/heavy_barrel, /obj/item/weapon/gun/grenade_launcher/underslung)

/obj/item/weapon/gun/rifle/sh15/plasma_pistol
	starting_attachment_types = list(/obj/item/attachable/stock/sh15, /obj/item/attachable/motiondetector, /obj/item/attachable/extended_barrel, /obj/item/weapon/gun/pistol/plasma_pistol)

//-------------------------------------------------------
//SG-29 Smart Machine Gun (It's more of a rifle than the SG.)

/obj/item/weapon/gun/rifle/sg29
	name = "\improper SG-29劳姆金属-KT智能机枪"
	desc = "劳姆金属-KT SG-29是TGMC目前标准的具备IFF能力的中型机枪.以其出色的重型火力支援能力而闻名.通常在有人想要守住阵地或提供火力支援时使用.需要特殊训练,且无法关闭IFF.使用10x26mm弹药."
	icon_state = "sg29"
	worn_icon_state = "sg29"
	icon = 'icons/obj/items/gun/machinegun.dmi'
	caliber = CALIBER_10X26_CASELESS //codex
	max_shells = 300 //codex
	force = 30
	aim_slowdown = 0.95
	wield_delay = 1.5 SECONDS
	fire_sound = SFX_GUN_SMARTGUN
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/T42_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/T42_reload.ogg'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_1.dmi',
	)
	default_ammo_type = /obj/item/ammo_magazine/sg29
	allowed_ammo_types = list(/obj/item/ammo_magazine/sg29)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/stock/sgstock,
		/obj/item/attachable/sgbarrel,
		/obj/item/attachable/shoulder_mount,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	starting_attachment_types = list(/obj/item/attachable/stock/sgstock, /obj/item/attachable/sgbarrel)
	gun_skill_category = SKILL_SMARTGUN //Uses SG skill for the penalties.
	attachable_offset = list("muzzle_x" = 42, "muzzle_y" = 17,"rail_x" = 15, "rail_y" = 21, "under_x" = 24, "under_y" = 14, "stock_x" = 12, "stock_y" = 13)

	fire_delay = 0.15 SECONDS
	burst_amount = 0
	accuracy_mult_unwielded = 0.5
	accuracy_mult = 1.1
	scatter = -5
	scatter_unwielded = 40
	movement_acc_penalty_mult = 4

	placed_overlay_iconstate = "smartgun"

/obj/item/weapon/gun/rifle/sg29/pmc
	starting_attachment_types = list(/obj/item/attachable/stock/sgstock, /obj/item/attachable/sgbarrel, /obj/item/attachable/motiondetector, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/rifle/sg29/deathsquad
	starting_attachment_types = list(/obj/item/attachable/stock/sgstock, /obj/item/attachable/sgbarrel, /obj/item/attachable/magnetic_harness, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/rifle/sg29/patrol
	starting_attachment_types = list(/obj/item/attachable/stock/sgstock, /obj/item/attachable/sgbarrel, /obj/item/attachable/motiondetector, /obj/item/attachable/verticalgrip)

/obj/item/weapon/gun/rifle/standard_smartmachinegun
	parent_type = /obj/item/weapon/gun/rifle/sg29

/obj/item/weapon/gun/rifle/standard_smartmachinegun/pmc
	starting_attachment_types = list(/obj/item/attachable/stock/sgstock, /obj/item/attachable/sgbarrel, /obj/item/attachable/motiondetector, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/rifle/standard_smartmachinegun/deathsquad
	starting_attachment_types = list(/obj/item/attachable/stock/sgstock, /obj/item/attachable/sgbarrel, /obj/item/attachable/magnetic_harness, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/rifle/standard_smartmachinegun/patrol
	starting_attachment_types = list(/obj/item/attachable/stock/sgstock, /obj/item/attachable/sgbarrel, /obj/item/attachable/motiondetector, /obj/item/attachable/verticalgrip)

/obj/item/weapon/gun/rifle/standard_smartmachinegun/basic
	starting_attachment_types = list(/obj/item/attachable/stock/sgstock, /obj/item/attachable/sgbarrel, /obj/item/attachable/magnetic_harness, /obj/item/attachable/flashlight/under)

//-------------------------------------------------------
//SG Target Rifle, has underbarreled spotting rifle that applies effects.

/obj/item/weapon/gun/rifle/sg62
	name = "\improper SG-62考泽-KT智能目标步枪"
	desc = "考泽-KT SG-62是泰拉政府陆战队使用的具备IFF能力的步枪,配合一具同样具备IFF能力的观测步枪,可发射配备特种弹药的各种弹种,这是一款能应对多种情况的枪械...前提是你装填了正确的弹药.需要特殊训练,且无法关闭IFF.步枪使用高速10x27mm弹药,下挂步枪使用12x66mm弹药."
	icon = 'icons/obj/items/gun/marksman64.dmi'
	icon_state = "sg62"
	worn_icon_state = "sg62"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/marksman_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/marksman_righthand_1.dmi',
	)
	caliber = CALIBER_10X27_CASELESS //codex
	max_shells = 40 //codex
	aim_slowdown = 0.55
	wield_delay = 0.85 SECONDS
	fire_sound =  'sound/weapons/guns/fire/t62.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/T42_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/T42_reload.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/sg62
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/sg62)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/marine,
		/obj/item/weapon/gun/rifle/sg153,
		/obj/item/attachable/stock/strstock,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	gun_skill_category = SKILL_SMARTGUN //Uses SG skill for the penalties.
	attachable_offset = list("muzzle_x" = 12, "muzzle_y" = 22, "rail_x" = 15, "rail_y" = 22, "under_x" = 28, "under_y" = 16, "stock_x" = 12, "stock_y" = 14)
	starting_attachment_types = list(/obj/item/weapon/gun/rifle/sg153, /obj/item/attachable/stock/strstock)

	fire_delay = 0.4 SECONDS
	burst_amount = 0
	accuracy_mult_unwielded = 0.4
	accuracy_mult = 1.1
	scatter = 0
	scatter_unwielded = 20
	movement_acc_penalty_mult = 8

	placed_overlay_iconstate = "smartgun"

/obj/item/weapon/gun/rifle/sg62/motion
	starting_attachment_types = list(/obj/item/weapon/gun/rifle/sg153, /obj/item/attachable/stock/strstock, /obj/item/attachable/motiondetector)

/obj/item/weapon/gun/rifle/sg153
	name = "SG-153观测步枪"
	desc = "一具下挂式观测步枪,通常安装在另一把枪的上方."
	icon_state = "sg153"
	icon = 'icons/obj/items/gun/marksman64.dmi'
	fire_sound =  'sound/weapons/guns/fire/spottingrifle.ogg'
	caliber = CALIBER_12X7
	slot = ATTACHMENT_SLOT_UNDER
	max_shells = 5
	default_ammo_type =/obj/item/ammo_magazine/rifle/sg153
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/sg153,
		/obj/item/ammo_magazine/rifle/sg153/highimpact,
		/obj/item/ammo_magazine/rifle/sg153/heavyrubber,
		/obj/item/ammo_magazine/rifle/sg153/plasmaloss,
		/obj/item/ammo_magazine/rifle/sg153/tungsten,
		/obj/item/ammo_magazine/rifle/sg153/incendiary,
		/obj/item/ammo_magazine/rifle/sg153/flak,
	)
	force = 5
	attachable_allowed = list()
	actions_types = list()
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	gun_features_flags = GUN_IS_ATTACHMENT|GUN_WIELDED_FIRING_ONLY|GUN_ATTACHMENT_FIRE_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attach_features_flags = NONE
	fire_delay = 1 SECONDS
	accuracy_mult = 1.5
	scatter = -5
	pixel_shift_x = 18
	pixel_shift_y = 16

//-------------------------------------------------------
//Sectoid Rifle

/obj/item/weapon/gun/rifle/sectoid_rifle
	name = "异形步枪"
	desc = "一款来源不寻常的异形武器.它没有扳机,也没有任何明显的开火方式."
	icon_state = "alien_rifle"
	worn_icon_state = "alien_rifle"
	icon = 'icons/obj/items/gun/energy.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/energy_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/energy_righthand_1.dmi',
	)
	fire_sound = 'sound/weapons/guns/fire/alienplasma.ogg'
	fire_rattle = 'sound/weapons/guns/fire/alienplasma.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/vp70_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/m41a_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m4ra_reload.ogg'
	max_shells = 20//codex stuff
	ammo_datum_type = /datum/ammo/energy/sectoid_plasma
	muzzleflash_iconstate = "muzzle_flash_pulse"
	default_ammo_type = /obj/item/ammo_magazine/rifle/sectoid_rifle
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/sectoid_rifle)
	wield_delay = 0.6 SECONDS

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_ENERGY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 23, "under_x" = 23, "under_y" = 15, "stock_x" = 22, "stock_y" = 12)

	fire_delay = 0.5 SECONDS
	burst_amount = 3
	burst_delay = 0.15 SECONDS
	accuracy_mult = 2
	accuracy_mult_unwielded = 0.8
	movement_acc_penalty_mult = 3

/obj/item/weapon/gun/rifle/sectoid_rifle/Initialize(mapload, spawn_empty)
	. = ..()
	AddComponent(/datum/component/reequip, list(SLOT_BACK)) //Sectoids have alien powers that make them not lose their gun

//only sectoids can fire it
/obj/item/weapon/gun/rifle/sectoid_rifle/able_to_fire(mob/user)
	. = ..()
	if(!.)
		return
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/H = user
	if(!(H.species.species_flags & USES_ALIEN_WEAPONS))
		to_chat(user, span_warning("这把枪上没有扳机,你完全不知道该如何开火!"))
		return FALSE
	return TRUE

//-------------------------------------------------------
//SR-127 bolt action sniper rifle

/obj/item/weapon/gun/rifle/sr127
	name = "\improper SR-127鲍尔栓动步枪"
	desc = "鲍尔SR-127是TGMC使用的标准配发栓动步枪.以其远距离精度和射手的使用而闻名,尽管它年代久远且缺乏IFF,但仔细瞄准后仍可从后方提供火力支援.它配有不可拆卸的瞄准镜.使用8.6×70mm弹匣."
	icon = 'icons/obj/items/gun/marksman64.dmi'
	icon_state = "tl127"
	worn_icon_state = "tl127"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/marksman_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/marksman_righthand_64.dmi',
	)

	inhand_x_dimension = 64
	inhand_y_dimension = 32
	fire_sound =     'sound/weapons/guns/sniper/SR-127/SR127.ogg'
	fire_rattle = null
	dry_fire_sound = 'sound/weapons/guns/fire/sniper_empty.ogg'
	unload_sound =   'sound/weapons/guns/sniper/SR-127/SR127_clipout.ogg'
	reload_sound =   'sound/weapons/guns/sniper/SR-127/SR127_clipin.ogg'
	silenced_sound = 'sound/weapons/guns/sniper/SR-127/SR127_SIL.ogg'
	wield_sound =    'sound/weapons/guns/dmr/Deploy_Wave_DMR.ogg'
	cocked_sound = 'sound/weapons/guns/sniper/SR-127/SR127_boltpull.ogg'
	caliber = CALIBER_86X70 //codex
	max_shells = 10 //codex
	default_ammo_type = /obj/item/ammo_magazine/rifle/sr127
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/sr127,
		/obj/item/ammo_magazine/rifle/sr127/flak,
	)
	attachable_allowed = list(
		/obj/item/attachable/scope/unremovable/sr127,
		/obj/item/attachable/stock/sr127stock,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/foldable/bipod,
	)

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	reciever_flags = AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION|AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_UNIQUE_ACTION_LOCKS|AMMO_RECIEVER_AUTO_EJECT

	cock_animation = "tl127_cock"
	cocked_message = "You rack the bolt!"

	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	attachable_offset = list("muzzle_x" = 40, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 22, "under_x" = 33, "under_y" = 16, "stock_x" = 8, "stock_y" = 12)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 1 SECONDS

	starting_attachment_types = list(
		/obj/item/attachable/scope/unremovable/sr127,
		/obj/item/attachable/stock/sr127stock,
	)

	burst_amount = 0
	fire_delay = 1.35 SECONDS
	accuracy_mult = 1.15
	accuracy_mult_unwielded = 0.7
	scatter = -5
	scatter_unwielded = 20
	recoil = 0
	recoil_unwielded = 4
	aim_slowdown = 1
	wield_delay = 1.5 SECONDS
	cock_delay = 0.7 SECONDS
	movement_acc_penalty_mult = 6


/obj/item/weapon/gun/rifle/sr127/unscoped
	starting_attachment_types = list(/obj/item/attachable/stock/sr127stock)

//-------------------------------------------------------
//SR-81 Auto-Sniper

/obj/item/weapon/gun/rifle/sr81
	name = "\improper SR-81考泽-KT自动狙击步枪"
	desc = "考泽-KT SR-81是泰拉政府陆战队的自动狙击步枪,通常与其标志性的夜视仪/KTLD瞄准镜组合搭配使用.它以其同类中较高的射速而著称,在任何距离都有不错的表现.使用8.6x70mm无壳弹药,采用特殊压力以实现IFF射击."
	icon_state = "t81"
	worn_icon_state = "t81"
	icon = 'icons/obj/items/gun/marksman.dmi'
	fire_sound = 'sound/weapons/guns/fire/sniper.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/sniper_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/m41a_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m41a_reload.ogg'
	caliber = CALIBER_86X70 //codex
	max_shells = 20 //codex
	default_ammo_type = /obj/item/ammo_magazine/rifle/sr81
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/sr81)
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/marksman_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/marksman_righthand_1.dmi',
	)
	attachable_allowed = list(
		/obj/item/attachable/sr81,
		/obj/item/attachable/scope/nightvision,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
	)

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 48, "muzzle_y" = 18,"rail_x" = 23, "rail_y" = 23, "under_x" = 38, "under_y" = 16, "stock_x" = 9, "stock_y" = 12)
	starting_attachment_types = list(
		/obj/item/attachable/sr81,
		/obj/item/attachable/scope/nightvision,
	)

	burst_amount = 0
	fire_delay = 0.55 SECONDS
	accuracy_mult = 1.1
	accuracy_mult_unwielded = 0.7
	scatter = -5
	scatter_unwielded = 20
	recoil = 0
	recoil_unwielded = 4
	aim_slowdown = 1
	wield_delay = 1.5 SECONDS
	movement_acc_penalty_mult = 6

//-------------------------------------------------------
//AR-11 Rifle, based on the gamer-11

/obj/item/weapon/gun/rifle/ar11
	name = "\improper AR-11 K&H战斗步枪"
	desc = "凯克勒与霍赫AR-11是TGMC的前标准配发步枪.其中大部分早已被封存入库,但仍有一些出现在陆战队员或雇佣兵手中.它以其大容量弹匣和出色的点射而闻名,但使用起来相当笨拙,尤其是在战斗中.使用4.92×34mm无壳高速弹药."
	icon_state = "tx11"
	worn_icon_state = "tx11"
	caliber = CALIBER_492X34_CASELESS //codex
	max_shells = 70 //codex
	wield_delay = 0.85 SECONDS
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_ar11.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/rifles/AR-11/AR11_clipout.ogg'
	reload_sound = 'sound/weapons/guns/rifles/AR-11/AR11_clipin.ogg'
	cocked_sound = 'sound/weapons/guns/rifles/AR-11/AR11_boltpull.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/ar11
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/ar11)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/scope/mini/ar11,
		/obj/item/attachable/stock/ar11,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	starting_attachment_types = list(/obj/item/attachable/stock/ar11, /obj/item/attachable/scope/mini/ar11)
	attachable_offset = list("muzzle_x" = 31, "muzzle_y" = 17,"rail_x" = 6, "rail_y" = 20, "under_x" = 20, "under_y" = 12, "stock_x" = 17, "stock_y" = 14)

	fire_delay = 0.25 SECONDS
	burst_amount = 3
	burst_delay = 0.05 SECONDS
	extra_delay = 0.15 SECONDS
	accuracy_mult_unwielded = 0.5
	accuracy_mult = 1.15
	scatter = -1
	scatter_unwielded = 15
	aim_slowdown = 0.45
	movement_acc_penalty_mult = 6

/obj/item/weapon/gun/rifle/ar11/scopeless
	starting_attachment_types = list(/obj/item/attachable/stock/ar11)

/obj/item/weapon/gun/rifle/ar11/freelancerone
	starting_attachment_types = list(/obj/item/attachable/stock/ar11, /obj/item/attachable/magnetic_harness, /obj/item/attachable/bayonet, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/rifle/ar11/freelancertwo
	starting_attachment_types = list(/obj/item/attachable/stock/ar11, /obj/item/attachable/motiondetector, /obj/item/attachable/bayonet, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/rifle/ar11/standard
	starting_attachment_types = list(/obj/item/attachable/stock/ar11, /obj/item/attachable/reddot, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/rifle/tx11
	parent_type = /obj/item/weapon/gun/rifle/ar11

/obj/item/weapon/gun/rifle/tx11/scopeless
	starting_attachment_types = list(/obj/item/attachable/stock/ar11)

/obj/item/weapon/gun/rifle/tx11/freelancerone
	starting_attachment_types = list(/obj/item/attachable/stock/ar11, /obj/item/attachable/magnetic_harness, /obj/item/attachable/bayonet, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/rifle/tx11/freelancertwo
	starting_attachment_types = list(/obj/item/attachable/stock/ar11, /obj/item/attachable/motiondetector, /obj/item/attachable/bayonet, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/rifle/tx11/standard
	starting_attachment_types = list(/obj/item/attachable/stock/ar11, /obj/item/attachable/reddot, /obj/item/attachable/lasersight)

//-------------------------------------------------------
//AR-21 Assault Rifle

/obj/item/weapon/gun/rifle/ar21
	name = "\improper AR-21考泽散兵步枪"
	desc = "考泽AR-21是一款多用途步枪,旨在弥合高口径武器与普通步枪之间的差距.它发射强劲的10x25mm弹药,具有不错的停止作用.然而,与更小的同类相比,它在弹匣容量和机动性方面有所不足."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "t21"
	worn_icon_state = "t21"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/rifle_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/rifle_righthand_64.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_ar21.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/t21_empty.ogg'
	unload_sound = 'sound/weapons/guns/rifles/AR-21/AR21_clipout.ogg'
	reload_sound = 'sound/weapons/guns/rifles/AR-21/AR21_clipin.ogg'
	cocked_sound = 'sound/weapons/guns/rifles/AR-21/AR21_boltpull.ogg'
	caliber = CALIBER_10X25_CASELESS //codex
	max_shells = 30 //codex
	force = 20
	default_ammo_type = /obj/item/ammo_magazine/rifle/ar21
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/ar21)
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/ar21,
		/obj/item/ammo_magazine/rifle/ar21/extended,
	)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/scope,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/angledgrip,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 46, "muzzle_y" = 16,"rail_x" = 18, "rail_y" = 19, "under_x" = 34, "under_y" = 13, "stock_x" = 0, "stock_y" = 13)
	aim_speed_modifier = 2.5

	fire_delay = 0.25 SECONDS
	burst_amount = 1
	burst_delay = 0.15 SECONDS
	accuracy_mult = 1.2
	scatter = -2
	wield_delay = 0.8 SECONDS
	aim_slowdown = 0.5
	damage_falloff_mult = 0.5

/obj/item/weapon/gun/rifle/ar21/standard
	starting_attachment_types = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/extended_barrel,
		/obj/item/weapon/gun/grenade_launcher/underslung,
	)

//-------------------------------------------------------
//AF-51B MACHINEcarbine

/obj/item/weapon/gun/rifle/alf_machinecarbine
	name = "\improper ALF-51B考泽机枪卡宾枪"
	desc = "考泽ALF-51B是ALF-51的非官方改装版,后者更常被称为AR-18卡宾枪,改装为冲锋枪长度的枪管,重新适配了更强的弹药,并采用弹链供弹.真正是近战格斗的巅峰.除此之外毫无用处.无法瞄准.使用10x25mm无壳弹药."
	icon_state = "alf51b"
	worn_icon_state = "alf51b"
	icon = 'icons/obj/items/gun/machinegun.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_1.dmi',
	)
	fire_animation = "alf51b_fire"
	fire_sound = 'sound/weapons/guns/fire/t18b.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/t18_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/t18_reload.ogg'
	caliber = CALIBER_10X25_CASELESS //codex
	max_shells = 80 //codex
	force = 20
	default_ammo_type = /obj/item/ammo_magazine/rifle/alf_machinecarbine
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/alf_machinecarbine)
	attachable_allowed = list(
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	attachable_offset = list("muzzle_x" = 31, "muzzle_y" = 16,"rail_x" = 10, "rail_y" = 19, "under_x" = 21, "under_y" = 13, "stock_x" = 0, "stock_y" = 13)

	fire_delay = 0.2 SECONDS
	burst_delay = 0.1 SECONDS
	extra_delay = 0.2 SECONDS
	scatter = 4
	burst_amount = 4
	aim_slowdown = 0.3
	wield_delay = 0.6 SECONDS
	damage_falloff_mult = 3

	movement_acc_penalty_mult = 4

/obj/item/weapon/gun/rifle/alf_machinecarbine/freelancer
	starting_attachment_types = list(
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/bayonet,
	)

/obj/item/weapon/gun/rifle/alf_machinecarbine/assault
	starting_attachment_types = list(
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/verticalgrip,
	)

//-------------------------------------------------------
// MKH-98

/obj/item/weapon/gun/rifle/mkh
	name = "\improper MKH-98风暴步枪"
	desc = "一款公认的经典之作,这款复刻设计被誉为第一款成功的突击步枪概念,通常被称为\"风暴步枪\".其射速高于同类,但容量不足.此版本发射7.62x39mm弹药."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "mkh98"
	worn_icon_state = "mkh98"
	caliber = CALIBER_762X39 //codex
	muzzleflash_iconstate = "muzzle_flash_medium"
	max_shells = 30 //codex
	fire_sound = 'sound/weapons/guns/fire/ak47.ogg'
	unload_sound = 'sound/weapons/guns/interact/ak47_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/ak47_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/ak47_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/mkh
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/mkh)
	aim_slowdown = 0.35
	attachable_allowed = list(
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 51, "muzzle_y" = 18,"rail_x" = 24, "rail_y" = 22, "under_x" = 36, "under_y" = 16, "stock_x" = 0, "stock_y" = 12)

	accuracy_mult = 1.1
	burst_amount = 1
	fire_delay = 0.2 SECONDS
	scatter = 1
	wield_delay = 0.7 SECONDS
	movement_acc_penalty_mult = 4

//-------------------------------------------------------
// GL-54 grenade launcher
/obj/item/weapon/gun/rifle/tx54
	name = "\improper GL-54榴弹发射器"
	desc = "一款弹匣供弹的半自动榴弹发射器,设计用于发射空爆智能榴弹.需要T49瞄准镜进行精确瞄准."
	icon = 'icons/obj/items/gun/special64.dmi'
	icon_state = "tx54"
	worn_icon_state = "tx54"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/special_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/special_righthand_1.dmi',
	)
	max_shells = 5 //codex
	max_chamber_items = 1
	fire_delay = 1.2 SECONDS
	fire_sound = 'sound/weapons/guns/fire/underbarrel_grenadelauncher.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/shotgun_empty.ogg'
	caliber = CALIBER_20MM //codex
	attachable_allowed = list(
		/obj/item/attachable/scope/optical,
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	starting_attachment_types = list(/obj/item/attachable/scope/optical)
	default_ammo_type = null
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/tx54,
		/obj/item/ammo_magazine/rifle/tx54/incendiary,
		/obj/item/ammo_magazine/rifle/tx54/smoke,
		/obj/item/ammo_magazine/rifle/tx54/smoke/dense,
		/obj/item/ammo_magazine/rifle/tx54/smoke/tangle,
		/obj/item/ammo_magazine/rifle/tx54/razor,
	)
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	attachable_offset = list("muzzle_x" = 31, "muzzle_y" = 17,"rail_x" = 12, "rail_y" = 20, "under_x" = 28, "under_y" = 13, "stock_x" = -1, "stock_y" = 17)
	aim_slowdown = 0.8
	wield_delay = 1 SECONDS
	burst_amount = 1
	accuracy_mult = 1.15
	scatter = -2
	aim_fire_delay = 0.2 SECONDS
	aim_speed_modifier = 2

//-------------------------------------------------------
// AR-55 built in grenade launcher

/obj/item/weapon/gun/rifle/tx54/mini
	name = "\improper GL-55 20mm榴弹发射器"
	desc = "一款安装在武器上,可重新装填的五发榴弹发射器."
	icon = 'icons/obj/items/attachments/attachments.dmi'
	icon_state = "tx55gl"
	placed_overlay_iconstate = "tx55gl"
	attachable_allowed = list()
	gun_features_flags = GUN_AMMO_COUNTER|GUN_IS_ATTACHMENT|GUN_ATTACHMENT_FIRE_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	attach_features_flags = NONE
	slot = ATTACHMENT_SLOT_STOCK
	default_ammo_type = /obj/item/ammo_magazine/rifle/tx54
	attach_delay = 3 SECONDS
	detach_delay = 3 SECONDS
	starting_attachment_types = list()

//-------------------------------------------------------
// AR-55 rifle

/obj/item/weapon/gun/rifle/tx55
	name = "\improper AR-55突击步枪"
	desc = "官方编号为\"目标单兵战斗武器\",AR-55具有一个上部无托式20mm榴弹发射器,设计用于发射多种特种弹药,以及一个下挂式突击步枪,使用10x24mm无壳弹药.由于其尺寸和重量,使用起来有些笨重.需要T49瞄准镜进行精确瞄准."
	icon_state = "tx55"
	worn_icon_state = "tx55"
	fire_sound = SFX_GUN_AR12
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/t18_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/t18_reload.ogg'
	caliber = CALIBER_10X24_CASELESS //codex
	max_shells = 36 //codex
	wield_delay = 1.2 SECONDS
	default_ammo_type = /obj/item/ammo_magazine/rifle/ar12
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/ar12,
		/obj/item/ammo_magazine/rifle/ar12/incendiary,
	)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/scope,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/rifle/tx54/mini,
		/obj/item/attachable/scope/optical,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	starting_attachment_types = list(
		/obj/item/weapon/gun/rifle/tx54/mini,
		/obj/item/attachable/scope/optical,
	)
	attachable_offset = list("muzzle_x" = 31, "muzzle_y" = 17,"rail_x" = 13, "rail_y" = 22, "under_x" = 21, "under_y" = 14, "stock_x" = -1, "stock_y" = 17)

	aim_fire_delay = 0.1 SECONDS
	aim_speed_modifier = 2
	fire_delay = 0.2 SECONDS
	burst_delay = 0.15 SECONDS
	extra_delay = 0.05 SECONDS
	accuracy_mult_unwielded = 0.5
	scatter = 1
	scatter_unwielded = 15
	burst_scatter_mult = 2
	aim_slowdown = 1
	movement_acc_penalty_mult = 6

/obj/item/weapon/gun/rifle/tx55/freelancer
	starting_attachment_types = list(
		/obj/item/weapon/gun/rifle/tx54/mini,
		/obj/item/attachable/scope/optical,
		/obj/item/attachable/compensator,
		/obj/item/attachable/gyro,
	)

/obj/item/weapon/gun/rifle/tx55/combat_patrol //no scope for HvH
	starting_attachment_types = list(
		/obj/item/weapon/gun/rifle/tx54/mini,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/compensator,
		/obj/item/attachable/verticalgrip,
	)

//-------------------------------------------------------
//A true classic, the Garand. Ping.

/obj/item/weapon/gun/rifle/garand
	name = "\improper CAU C1加兰德自动装填步枪"
	desc = "卡尔福德-1是卡尔福德军械库制造的经典复刻版,为适应现代而打造.最明显的区别大多是一些小的导轨改装.除此之外,它是一款忠实的复刻品,连标志性的\"叮\"声都一应俱全.使用.30-06弹夹."
	icon = 'icons/obj/items/gun/marksman64.dmi'
	icon_state = "garand"
	worn_icon_state = "garand"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/marksman_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/marksman_righthand_64.dmi',
	)

	inhand_x_dimension = 64
	inhand_y_dimension = 32
	fire_sound = 'sound/weapons/guns/fire/garand.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/sniper_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/garand_ping.ogg'
	reload_sound = 'sound/weapons/guns/interact/m41a_reload.ogg'
	empty_sound = null
	caliber = CALIBER_3006 //codex
	max_shells = 8 //codex
	default_ammo_type = /obj/item/ammo_magazine/rifle/garand
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/garand,
	)
	attachable_allowed = list(
		/obj/item/attachable/stock/garand,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/foldable/bipod,
	)

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_AUTO_EJECT|AMMO_RECIEVER_CYCLE_ONLY_BEFORE_FIRE

	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	attachable_offset = list("muzzle_x" = 40, "muzzle_y" = 19,"rail_x" = 9, "rail_y" = 22, "under_x" = 33, "under_y" = 16, "stock_x" = 0, "stock_y" = 11)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 1.25 SECONDS

	starting_attachment_types = list(
		/obj/item/attachable/stock/garand,
	)

	burst_amount = 0
	fire_delay = 0.8 SECONDS
	accuracy_mult = 1.15
	accuracy_mult_unwielded = 0.75
	scatter = 0
	scatter_unwielded = 25
	recoil = 0
	recoil_unwielded = 4
	aim_slowdown = 0.75
	wield_delay = 1.2 SECONDS
	movement_acc_penalty_mult = 6

//-------------------------------------------------------
// V-31 SOM rifle

/obj/item/weapon/gun/rifle/som
	name = "\improper V-31突击步枪"
	desc = "在引入更先进的能量武器之前,V-31是火星之子的主要步枪.尽管如此,V-31因其相对易于生产和维护,以及内置的用于所谓\"微型\"榴弹的低速轨道炮而继续被广泛使用.由于其紧凑的无托设计,操控性良好,并且在各种距离上都普遍有效.使用10x25mm无壳弹药."
	icon_state = "v31"
	icon = 'icons/obj/items/gun/rifle64.dmi'
	worn_icon_state = "v31"
	fire_sound = 'sound/weapons/guns/fire/som_rifle.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/t18_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/t18_reload.ogg'
	caliber = CALIBER_10X24_CASELESS
	max_shells = 50
	default_ammo_type = /obj/item/ammo_magazine/rifle/som
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/som, /obj/item/ammo_magazine/rifle/som/ap, /obj/item/ammo_magazine/rifle/som/incendiary)
	attachable_allowed = list(
		/obj/item/weapon/gun/shotgun/micro_grenade,
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	starting_attachment_types = list(
		/obj/item/weapon/gun/shotgun/micro_grenade,
	)
	attachable_offset = list("muzzle_x" = 45, "muzzle_y" = 16,"rail_x" = 23, "rail_y" = 24, "under_x" = 33, "under_y" = 11, "stock_x" = -1, "stock_y" = 17)

	wield_delay = 0.8 SECONDS

	aim_fire_delay = 0.1 SECONDS
	aim_speed_modifier = 2

	fire_delay = 0.2 SECONDS
	aim_slowdown = 0.35

	accuracy_mult = 1
	accuracy_mult_unwielded = 0.55
	scatter = -2
	scatter_unwielded = 15

	burst_amount = 3
	burst_scatter_mult = 4
	burst_delay = 0.1 SECONDS
	extra_delay = 0.1 SECONDS

	damage_falloff_mult = 0.7

/obj/item/weapon/gun/rifle/som/standard
	starting_attachment_types = list(
		/obj/item/weapon/gun/shotgun/micro_grenade,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/reddot,
	)

/obj/item/weapon/gun/rifle/som/veteran
	default_ammo_type = /obj/item/ammo_magazine/rifle/som/ap
	starting_attachment_types = list(
		/obj/item/weapon/gun/shotgun/micro_grenade,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/reddot,
	)

/obj/item/weapon/gun/rifle/som/mag_harness
	starting_attachment_types = list(
		/obj/item/weapon/gun/shotgun/micro_grenade,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
	)

/obj/item/weapon/gun/rifle/som/basic //export model
	starting_attachment_types = list(
		/obj/item/weapon/gun/shotgun/micro_grenade,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/bayonet,
	)

//-------------------------------------------------------
// V-34 SOM carbine
/obj/item/weapon/gun/rifle/som_carbine
	name = "\improper V-34卡宾枪"
	desc = "一款古老但坚固的武器,在火星起义中被广泛使用.一款相对轻便紧凑的武器,凭借良好的射速和高口径,它仍然具有相当的威力,尽管在远距离其效能会大幅下降.它发射7.62x39mm弹药."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "v34"
	worn_icon_state = "v34"
	caliber = CALIBER_762X39
	muzzleflash_iconstate = "muzzle_flash"
	max_shells = 30
	fire_sound = 'sound/weapons/guns/fire/ak47.ogg'
	unload_sound = 'sound/weapons/guns/interact/ak47_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/ak47_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/ak47_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/mpi_km/carbine
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/mpi_km,
		/obj/item/ammo_magazine/rifle/mpi_km/plum,
		/obj/item/ammo_magazine/rifle/mpi_km/black,
		/obj/item/ammo_magazine/rifle/mpi_km/carbine,
		/obj/item/ammo_magazine/rifle/mpi_km/carbine/plum,
		/obj/item/ammo_magazine/rifle/mpi_km/carbine/black,
		/obj/item/ammo_magazine/rifle/mpi_km/extended,
	)
	attachable_allowed = list(
		/obj/item/attachable/foldable/som_carbine,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 18,"rail_x" = 8, "rail_y" = 20, "under_x" = 17, "under_y" = 13, "stock_x" = -6, "stock_y" = 16)
	starting_attachment_types = list(/obj/item/attachable/foldable/som_carbine)
	force = 15

	burst_amount = 1
	fire_delay = 0.15 SECONDS
	accuracy_mult = 0.75
	scatter = 12
	recoil = 1.5
	wield_delay = 0.6 SECONDS
	aim_slowdown = 0.3
	movement_acc_penalty_mult = 4
	damage_falloff_mult = 1.4
	damage_mult = 0.9

/obj/item/weapon/gun/rifle/som_carbine/mag_harness
	starting_attachment_types = list(/obj/item/attachable/foldable/som_carbine, /obj/item/attachable/magnetic_harness)

/obj/item/weapon/gun/rifle/som_carbine/black
	desc = "SOM对一款古老武器的现代重新设计,该武器在火星起义中被广泛使用.一款相对轻便紧凑的武器,凭借良好的射速和高口径,它仍然具有相当的威力,尽管在远距离其效能会大幅下降.它发射7.62x39mm弹药."
	icon_state = "v34_black"
	worn_icon_state = "v34_black"
	default_ammo_type = /obj/item/ammo_magazine/rifle/mpi_km/carbine/black
	attachable_allowed = list(
		/obj/item/attachable/foldable/som_carbine,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/reddot,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

/obj/item/weapon/gun/rifle/som_carbine/black/standard
	starting_attachment_types = list(
		/obj/item/attachable/foldable/som_carbine,
		/obj/item/attachable/reddot,
	)

//-------------------------------------------------------
// V-35 battle rifle

/obj/item/weapon/gun/rifle/som_big
	name = "\improper V-35战斗步枪"
	desc = "V-35是SOM武库中较新的成员,\
	其卓越的单发火力可作为极其昂贵且维护密集的沃尔凯特武器的廉价替代品.\
	多种弹药类型进一步赋予了V-35沃尔凯特武器通常缺乏的显著战术灵活性,此外还能使用瞄准模式."

	icon_state = "v35"
	icon = 'icons/obj/items/gun/rifle64.dmi'
	worn_icon_state = "v35"
	ammo_level_icon = "v35"

	muzzleflash_iconstate = "muzzle_flash_medium"
	fire_sound = 'sound/weapons/guns/fire/ks23.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/deagle_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/m4ra_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m4ra_reload.ogg'
	caliber = CALIBER_10X27_CASELESS
	aim_slowdown = 0.75
	wield_delay = 1 SECONDS
	force = 20
	max_shells = 20
	default_ammo_type = /obj/item/ammo_magazine/rifle/som_big
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/som_big,
		/obj/item/ammo_magazine/rifle/som_big/incendiary,
		/obj/item/ammo_magazine/rifle/som_big/anti_armour,
	)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/gyro,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_CAN_POINTBLANK|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 54, "muzzle_y" = 20,"rail_x" = 23, "rail_y" = 22, "under_x" = 45, "under_y" = 14, "stock_x" = 14, "stock_y" = 10)

	fire_delay = 0.65 SECONDS
	accuracy_mult = 1.1
	scatter = -2
	burst_amount = 1
	movement_acc_penalty_mult = 6

	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.2 SECONDS
	aim_speed_modifier = 2

/obj/item/weapon/gun/rifle/som_big/standard
	starting_attachment_types = list(/obj/item/attachable/motiondetector, /obj/item/attachable/extended_barrel, /obj/item/attachable/verticalgrip)

/obj/item/weapon/gun/rifle/som_big/support
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/extended_barrel, /obj/item/attachable/foldable/bipod)
//-------------------------------------------------------
// V-41 SOM LMG

/obj/item/weapon/gun/rifle/som_mg
	name = "\improper V-41机枪"
	desc = "V-41是SOM使用的一款大型单兵便携机枪,能够以牺牲机动性和操控性为代价提供持续,准确的压制火力.常见于他们偏好的快速,机动进攻战术不适用的情况.使用10x26mm无壳弹药."
	icon = 'icons/obj/items/gun/machinegun64.dmi'
	icon_state = "v41"
	worn_icon_state = "v41"
	fire_animation = "v41_fire"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_64.dmi',
	)

	inhand_x_dimension = 64
	inhand_y_dimension = 32
	caliber = CALIBER_10X26_CASELESS
	max_shells = 200
	force = 35
	wield_delay = 1.7 SECONDS
	fire_sound = 'sound/weapons/guns/fire/v41.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/T42_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/v41_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/v41_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/som_mg
	allowed_ammo_types = list(/obj/item/ammo_magazine/som_mg)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/stock/som_mg_stock,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	starting_attachment_types = list(/obj/item/attachable/stock/som_mg_stock)
	gun_skill_category = SKILL_HEAVY_WEAPONS
	attachable_offset = list("muzzle_x" = 53, "muzzle_y" = 19,"rail_x" = 14, "rail_y" = 23, "under_x" = 41, "under_y" = 14, "stock_x" = -32, "stock_y" = 0)
	aim_fire_delay = 0.2 SECONDS
	aim_slowdown = 1.2

	fire_delay = 0.2 SECONDS
	burst_amount = 1
	accuracy_mult = 0.9
	accuracy_mult_unwielded = 0.4
	scatter = 6
	scatter_unwielded = 40
	movement_acc_penalty_mult = 7

	placed_overlay_iconstate = "lmg"

/obj/item/weapon/gun/rifle/som_mg/standard
	starting_attachment_types = list(/obj/item/attachable/stock/som_mg_stock, /obj/item/attachable/foldable/bipod, /obj/item/attachable/reddot, /obj/item/attachable/extended_barrel)

//-------------------------------------------------------
//L-11 ICC Sharpshooter Rifle

/obj/item/weapon/gun/rifle/icc_sharpshooter
	name = "\improper L-11精确射手步枪"
	desc = "L-11是ICCAF使用的一款久经沙场的老式步枪.尽管与大多数专注于近距离作战的ICCAF步枪相比,它相当沉重,冗长且笨拙,但与大多数同类相比,它凭借出色的远距离潜力轻松弥补了不足,主要见于预期进行远距离而非近距离作战的预备部队.使用10x27mm弹匣."
	icon = 'icons/obj/items/gun/marksman64.dmi'
	icon_state = "l11"
	worn_icon_state = "l11"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/marksman_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/marksman_righthand_64.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32

	muzzleflash_iconstate = "muzzle_flash_medium"
	fire_sound = SFX_FAL_FIRE
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/fal_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/fal_reload.ogg'
	caliber = CALIBER_10X27_CASELESS //codex
	aim_slowdown = 0.8
	wield_delay = 1.05 SECONDS
	force = 20
	max_shells = 20 //codex
	default_ammo_type = /obj/item/ammo_magazine/rifle/icc_sharpshooter
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/icc_sharpshooter)
	attachable_allowed = list(
		/obj/item/attachable/stock/icc_sharpshooter,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/gyro,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung/mpi/removeable,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)
	starting_attachment_types = list(/obj/item/attachable/stock/icc_sharpshooter)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_CAN_POINTBLANK|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 40, "muzzle_y" = 14, "rail_x" = 15, "rail_y" = 17, "under_x" = 23, "under_y" = 10, "stock_x" = 17, "stock_y" = 10)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.1 SECONDS
	aim_speed_modifier = 2

	burst_amount = 1
	fire_delay = 0.7 SECONDS
	damage_mult = 1.1
	accuracy_mult = 1.15
	scatter = 0
	movement_acc_penalty_mult = 5

/obj/item/weapon/gun/rifle/icc_sharpshooter/medic
	starting_attachment_types = list(/obj/item/attachable/stock/icc_sharpshooter, /obj/item/attachable/reddot, /obj/item/attachable/verticalgrip, /obj/item/attachable/heavy_barrel)

//-------------------------------------------------------
// L-15 ICC Battlecarbine

/obj/item/weapon/gun/rifle/icc_battlecarbine
	name = "\improper L-15战斗卡宾枪"
	desc = "L-15战斗卡宾枪是ICCAF的标准步枪,拥有高口径弹药和威猛的外形,是一款出色的近战枪械.然而,由于短枪管导致的严重威力衰减,它在远距离表现不佳,使用它的部队说,你必须不惜一切代价拉近距离,才能看到这把武器的真正效力.使用10x25mm无壳弹药."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "l15"
	worn_icon_state = "l15"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/rifle_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/rifle_righthand_64.dmi',
	)

	inhand_x_dimension = 64
	inhand_y_dimension = 32

	fire_sound = 'sound/weapons/guns/fire/mdr.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/mdr_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/mdr_reload.ogg'
	caliber = CALIBER_10X25_CASELESS //codex
	max_shells = 30 //codex
	force = 20
	default_ammo_type = /obj/item/ammo_magazine/rifle/icc_battlecarbine
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/icc_battlecarbine)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/gyro,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung/mpi/removeable,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 44, "muzzle_y" = 19,"rail_x" = 20, "rail_y" = 23, "under_x" = 33, "under_y" = 13, "stock_x" = 0, "stock_y" = 13)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.25 SECONDS
	aim_speed_modifier = 1.65

	burst_amount = 1
	fire_delay = 0.2 SECONDS
	scatter = 3
	aim_slowdown = 0.35
	wield_delay = 0.55 SECONDS
	damage_falloff_mult = 2.5
	movement_acc_penalty_mult = 4

/obj/item/weapon/gun/rifle/icc_battlecarbine/standard
	starting_attachment_types = list(/obj/item/weapon/gun/grenade_launcher/underslung/mpi/removeable, /obj/item/attachable/magnetic_harness, /obj/item/attachable/extended_barrel)


//-------------------------------------------------------
// ML-12 ICC Confrontation Rifle

/obj/item/weapon/gun/rifle/icc_confrontationrifle
	name = "\improper ML-12对抗步枪"
	desc = "ML-12对抗步枪是ICCAF使用的一款绝对的猛兽级武器.在短小的枪身内搭载高口径弹药,它绝对能在近距离撕碎敌方目标,不过操作者在进行后续射击时必须注意其惊人的后坐力.使用10x28mm无壳弹药."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "ml12"
	worn_icon_state = "ml12"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/rifle_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/rifle_righthand_64.dmi',
	)

	inhand_x_dimension = 64
	inhand_y_dimension = 32

	fire_sound = 'sound/weapons/guns/fire/ml12.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/ml12_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/ml12_reload.ogg'
	caliber = CALIBER_10X28_CASELESS //codex
	max_shells = 25 //codex
	force = 20
	default_ammo_type = /obj/item/ammo_magazine/rifle/icc_confrontationrifle
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/icc_confrontationrifle)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 48, "muzzle_y" = 18,"rail_x" = 24, "rail_y" = 26, "under_x" = 36, "under_y" = 14, "stock_x" = 0, "stock_y" = 13)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.3 SECONDS
	aim_speed_modifier = 2.5

	burst_amount = 1
	fire_delay = 0.45 SECONDS
	aim_slowdown = 0.55
	wield_delay = 0.85 SECONDS
	damage_falloff_mult = 2
	movement_acc_penalty_mult = 6.5

	min_scatter = 4
	max_scatter = 20
	scatter_increase = 5
	scatter_decay = 1
	scatter_decay_unwielded = 0.5

/obj/item/weapon/gun/rifle/icc_confrontationrifle/leader
	starting_attachment_types = list(/obj/item/attachable/lasersight, /obj/item/attachable/magnetic_harness, /obj/item/attachable/extended_barrel)

//-------------------------------------------------------
//ML-41 Autoshotgun

/obj/item/weapon/gun/rifle/icc_autoshotgun
	name = "\improper ML-41自动霰弹枪"
	desc = "ML-41自动霰弹枪被ICCAF用于快节奏的登舰突击,配备了适用于各种情况的多种弹药.使用16发12号弹鼓."
	icon = 'icons/obj/items/gun/shotgun64.dmi'
	icon_state = "ml41"
	worn_icon_state = "ml41"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/shotgun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/shotgun_righthand_1.dmi',
	)
	fire_sound = 'sound/weapons/guns/fire/shotgun.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/shotgun_empty.ogg'
	caliber = CALIBER_12G //codex
	max_shells = 16 //codex
	force = 20
	default_ammo_type = /obj/item/ammo_magazine/rifle/icc_autoshotgun
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/icc_autoshotgun,
		/obj/item/ammo_magazine/rifle/icc_autoshotgun/frag,
	)
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/compensator,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/motiondetector,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES //Its a shotgun type weapon effectively, most shotgun type weapons shouldn't be able to point blank 1 handed.
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 26,"rail_x" = 26, "rail_y" = 24, "under_x" = 40, "under_y" = 16, "stock_x" = 26, "stock_y" = 13)
	gun_skill_category = SKILL_SHOTGUNS

	fire_delay = 0.9 SECONDS
	accuracy_mult = 1.15
	damage_mult = 0.5
	aim_slowdown = 0.6
	wield_delay = 0.75 SECONDS
	burst_amount = 1
	scatter = 8
	movement_acc_penalty_mult = 2

/obj/item/weapon/gun/rifle/icc_autoshotgun/guard
	starting_attachment_types = list(/obj/item/attachable/verticalgrip, /obj/item/attachable/magnetic_harness)

//-------------------------------------------------------
//L-88 Assaultcarbine and EM-88 'Export' Varient

/obj/item/weapon/gun/rifle/icc_assaultcarbine
	name = "\improper L-88突击卡宾枪"
	desc = "一款老旧,可靠但过时的无托步枪,由ICCAF预备人员使用,最适合在需要快速清理角落的近战中使用,配有一体式前握把和无倍率瞄准镜以提高精度并减少拖拽.发射5.56x45mm北约弹药."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "l88"
	worn_icon_state = "l88"
	muzzleflash_iconstate = "muzzle_flash_medium"
	caliber = CALIBER_556X45 //codex
	max_shells = 30 //codex
	fire_sound = 'sound/weapons/guns/fire/famas.ogg'
	unload_sound = 'sound/weapons/guns/interact/m16_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m16_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/m16_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/icc_assaultcarbine
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/icc_assaultcarbine,
		/obj/item/ammo_magazine/rifle/icc_assaultcarbine/export,
	)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	attachable_offset = list("muzzle_x" = 44, "muzzle_y" = 19,"rail_x" = 8, "rail_y" = 21, "under_x" = 28, "under_y" = 12, "stock_x" = 19, "stock_y" = 13)

	fire_delay = 0.2 SECONDS
	burst_delay = 0.1 SECONDS
	extra_delay = 0.15 SECONDS
	accuracy_mult = 1.15
	damage_mult = 1.2
	damage_falloff_mult = 0.5
	wield_delay = 0.85 SECONDS
	aim_slowdown = 0.2
	scatter = 0

/obj/item/weapon/gun/rifle/icc_assaultcarbine/export
	name = "\improper L&S EM-88突击卡宾枪"
	desc = "一把老旧、可靠但过时的无托步枪,由于早已退役封存,通常只在ICC星域内见到,其中一些剩余型号有时会通过不正当手段流入TGMC星域.它最适合在近距离作战中使用,当你需要快速清理角落时,它配备了一体式前握把和无倍率瞄准镜,以提高精度并减少拖拽感.使用5.56x45mm NATO弹药."
	icon_state = "l88_export"
	worn_icon_state = "l88_export"
	default_ammo_type = /obj/item/ammo_magazine/rifle/icc_assaultcarbine/export

///////////////////////////////////////////////////////////////////////
////////////////////////  t25, old version .///////////////////////////
///////////////////////////////////////////////////////////////////////

/obj/item/weapon/gun/rifle/t25
	name = "\improper T-25智能步枪"
	desc = "T-25是TGMC目前的标准IFF能力步枪.它以能够出色地提供快速火力支援而闻名.需要特殊训练,并且无法关闭IFF.使用10x26mm弹药."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "t25"
	worn_icon_state = "t25"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/rifle_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/rifle_righthand_1.dmi',
		slot_s_store_str = 'icons/mob/suit_slot.dmi',
		slot_back_str =    'icons/mob/clothing/back.dmi',
	)
	caliber = CALIBER_10X26_CASELESS //codex
	max_shells = 80 //codex
	force = 20
	aim_slowdown = 0.45
	wield_delay = 1 SECONDS
	fire_sound = SFX_GUN_SMARTGUN
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound =   'sound/weapons/guns/interact/T42_unload.ogg'
	reload_sound =   'sound/weapons/guns/interact/T42_reload.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/t25
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/t25, /obj/item/ammo_magazine/rifle/t25/extended)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/compensator,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam,
		/obj/item/attachable/angledgrip,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO, GUN_FIREMODE_AUTOMATIC)
	gun_skill_category = SKILL_SMARTGUN //Uses SG skill for the penalties.
	attachable_offset = list("muzzle_x" = 42, "muzzle_y" = 17,"rail_x" = 15, "rail_y" = 21, "under_x" = 34, "under_y" = 14, "stock_x" = 12, "stock_y" = 13)

	fire_delay = 0.2 SECONDS
	burst_amount = 0
	accuracy_mult_unwielded = 0.5
	accuracy_mult = 1.2
	scatter = -5
	scatter_unwielded = 60

//-------------------------------------------------------
//MG-60 General Purpose Machine Gun

/obj/item/weapon/gun/rifle/icc_mg
	name = "\improper ML-41突击机枪"
	desc = "ML-41是ICCAF部队使用的一种极其轻便的机枪,对于其类别来说轻得不可思议,使其能够用于快速机动,代价是远距离伤害和普遍较高的散布.使用10x26mm弹箱."
	icon = 'icons/obj/items/gun/machinegun64.dmi'
	icon_state = "minimi"
	worn_icon_state = "minimi"
	fire_animation = "minimi_fire"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_64.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32

	caliber = CALIBER_10X26_CASELESS //codex
	max_shells = 200 //codex
	force = 30
	aim_slowdown = 0.85
	wield_delay = 0.95 SECONDS
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_mg60.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/T42_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/T42_reload.ogg'
	default_ammo_type = /obj/item/ammo_magazine/icc_mg
	allowed_ammo_types = list(/obj/item/ammo_magazine/icc_mg, /obj/item/ammo_magazine/icc_mg/belt)
	attachable_allowed = list(
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/stock/t60stock,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	gun_skill_category = SKILL_HEAVY_WEAPONS
	attachable_offset = list("muzzle_x" = 42, "muzzle_y" = 21,"rail_x" = 6, "rail_y" = 23, "under_x" = 26, "under_y" = 15, "stock_x" = 8, "stock_y" = 13)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_speed_modifier = 5

	fire_delay = 0.15 SECONDS
	damage_falloff_mult = 2.5
	burst_amount = 1
	accuracy_mult = 0.85
	accuracy_mult_unwielded = 0.4
	scatter = 5
	scatter_unwielded = 45
	movement_acc_penalty_mult = 6

/obj/item/weapon/gun/rifle/icc_mg/guard
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/heavy_barrel)

// VSD weapons
// L26

/obj/item/weapon/gun/rifle/vsd_lmg
	name = "\improper L26支援机枪"
	desc = "辛迪加的主要通用机枪,使用5.56口径.它的设计似乎...过时但仍然可靠.射速快,后坐力惊人,代价是移动速度."
	icon = 'icons/obj/items/gun/machinegun64.dmi'
	icon_state = "l26"
	worn_icon_state = "l26"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_64.dmi',
	)
	fire_animation = "l26_fire"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_64.dmi',
	)
	caliber = CALIBER_556X45 //codex
	muzzleflash_iconstate = "muzzle_flash_medium"
	max_shells = 200  //codex
	wield_delay = 1.4 SECONDS
	aim_slowdown = 0.95
	fire_sound = 'sound/weapons/guns/fire/famas.ogg'
	unload_sound = 'sound/weapons/guns/interact/ak47_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/ak47_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/ak47_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/vsd_mg
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/vsd_mg)
	inhand_x_dimension = 64
	inhand_y_dimension = 32

	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/foldable/bipod,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/attachable/reddot,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_offset = list("muzzle_x" = 46, "muzzle_y" = 18,"rail_x" = 20, "rail_y" = 20, "under_x" = 31, "under_y" = 11, "stock_x" = 8, "stock_y" = 13)
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	gun_skill_category = SKILL_HEAVY_WEAPONS

	fire_delay = 0.15 SECONDS
	scatter = 5
	burst_amount = 1
	movement_acc_penalty_mult = 8

/obj/item/weapon/gun/rifle/vsd_lmg/standard
	starting_attachment_types = list(/obj/item/attachable/reddot, /obj/item/attachable/foldable/bipod, /obj/item/attachable/extended_barrel)

/obj/item/weapon/gun/rifle/vsd_lmg/engineer
	starting_attachment_types = list(/obj/item/attachable/foldable/bipod, /obj/item/attachable/compensator)

/obj/item/weapon/gun/rifle/vsd_lmg/juggernaut
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/foldable/bipod, /obj/item/attachable/extended_barrel)

// C550

/obj/item/weapon/gun/rifle/vsd_rifle
	name = "\improper C550战斗步枪"
	desc = "Crash Core的第一款步枪.设计上让人联想到Sauer系列,这把枪是近距离作战的完美选择.使用10x27mm口径.能给任何站在你面前的人一记重击."
	icon = 'icons/obj/items/gun/rifle64.dmi'
	icon_state = "c550"
	worn_icon_state = "c550"
	fire_sound = 'sound/weapons/guns/fire/DMR.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/deagle_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/m41a_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m41a_reload.ogg'
	aim_slowdown = 0.5
	wield_delay =  0.9 SECONDS
	max_shells = 30 //codex
	default_ammo_type = /obj/item/ammo_magazine/rifle/vsd_rifle
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/vsd_rifle)
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/reddot,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/scope,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/verticalgrip,
		/obj/item/weapon/gun/grenade_launcher/underslung/invisible,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	attachable_offset = list("muzzle_x" = 58, "muzzle_y" = 18,"rail_x" = 24, "rail_y" = 21, "under_x" = 35, "under_y" = 15, "stock_x" = 8, "stock_y" = 13)
	burst_amount = 4
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	burst_delay = 0.15 SECONDS
	scatter = 0
	fire_delay = 0.2 SECONDS
	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES

/obj/item/weapon/gun/rifle/vsd_rifle/standard
	starting_attachment_types = list(/obj/item/attachable/reddot, /obj/item/attachable/verticalgrip, /obj/item/attachable/extended_barrel)

/obj/item/weapon/gun/rifle/vsd_rifle/medic
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/verticalgrip, /obj/item/attachable/suppressor)
