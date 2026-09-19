/obj/item/weapon/gun/pistol
	icon = 'icons/obj/items/gun/pistol.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/pistol_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/pistol_righthand_1.dmi',
	)
	fire_sound = 'sound/weapons/guns/fire/pistol.ogg'
	unload_sound = 'sound/weapons/guns/interact/pistol_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/pistol_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/pistol_cocked.ogg'
	muzzleflash_iconstate = "muzzle_flash_light"
	load_method = MAGAZINE //codex
	equip_slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	force = 6
	movement_acc_penalty_mult = 2
	wield_delay = 0.4 SECONDS
	type_of_casings = "bullet"
	gun_skill_category = SKILL_PISTOLS
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/gyro,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/lace,
		/obj/item/attachable/buildasentry,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	actions_types = list(/datum/action/item_action/aim_mode) // all pistols can aim mode
	aim_speed_modifier = 0.65
	scatter = -2
	scatter_unwielded = 4
	akimbo_additional_delay = 0.9
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)

	placed_overlay_iconstate = "pistol"

//-------------------------------------------------------
//P-14 PISTOL

/obj/item/weapon/gun/pistol/p14
	name = "\improper P-14手枪"
	desc = "P-14,由地球军械库生产.一款可靠的副武器,发射9x19mm帕拉贝鲁姆自动弹药.可安装有限数量的配件,射速相当可观,通常取决于你扣动扳机的速度.使用21发9mm弹匣."
	icon_state = "tp14"
	worn_icon_state = "tp14"
	caliber = CALIBER_9X19 //codex
	max_shells = 21 //codex
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_p14.ogg'
	reload_sound = 'sound/weapons/guns/interact/tp14_reload.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/p14
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/p14)

	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 22, "under_x" = 25, "under_y" = 14, "stock_x" = 21, "stock_y" = 17)

	fire_delay = 0.15 SECONDS
	accuracy_mult = 1.1
	accuracy_mult_unwielded = 0.95
	scatter_unwielded = 4
	recoil = -2
	recoil_unwielded = -2
	akimbo_scatter_mod = 8

//-------------------------------------------------------
//PP-7 Plasma Pistol
/obj/item/weapon/gun/pistol/plasma_pistol
	name = "\improper PP-7等离子手枪"
	desc = "一款实验性武器,设计用于点燃地形和目标.磁场相互缠绕时,它发出充满力量的嗡鸣声."
	icon_state = "tx7"
	worn_icon_state = "tx7"
	caliber = CALIBER_PLASMA
	max_shots = 10
	reload_sound = 'sound/weapons/guns/interact/tp14_reload.ogg'
	fire_sound = 'sound/weapons/guns/fire/laser3.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/plasma_pistol
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/plasma_pistol)
	type_of_casings = null
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 20,"rail_x" = 13, "rail_y" = 23, "under_x" = 19, "under_y" = 13, "stock_x" = 21, "stock_y" = 17)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/lace,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/scope/marine,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
	)

	muzzleflash_iconstate = "muzzle_flash_laser"
	gun_features_flags = GUN_CAN_POINTBLANK|GUN_ENERGY|GUN_AMMO_COUNTER|GUN_IS_ATTACHMENT|GUN_SMOKE_PARTICLES
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_AUTO_EJECT|AMMO_RECIEVER_DO_NOT_EJECT_HANDFULS|AMMO_RECIEVER_CYCLE_ONLY_BEFORE_FIRE
	actions_types = list()
	wield_delay = 0.7 SECONDS
	muzzle_flash_color = COLOR_GREEN

	fire_delay = 1.5 SECONDS
	scatter_unwielded = 2
	recoil = -2
	recoil_unwielded = -2

	slot = ATTACHMENT_SLOT_UNDER
	attach_delay = 3 SECONDS
	detach_delay = 3 SECONDS
	pixel_shift_x = 10
	pixel_shift_y = 19

	wield_delay_mod = 0.2 SECONDS

	placed_overlay_iconstate = "tx7"

/obj/item/weapon/gun/pistol/plasma_pistol/beginner
	starting_attachment_types = list(/obj/item/weapon/gun/shotgun/combat/masterkey, /obj/item/attachable/reddot, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/pistol/plasma_pistol/can_attach(obj/item/attaching_to, mob/attacher)
	if(!attachments_by_slot[ATTACHMENT_SLOT_RAIL])
		return TRUE
	to_chat(attacher, span_warning("当[attachments_by_slot[ATTACHMENT_SLOT_RAIL]]占据[src]的导轨槽位时,你无法将[src]安装到[attaching_to]上."))
	return FALSE

/obj/item/weapon/gun/pistol/plasma_pistol/on_attach(obj/item/attached_to, mob/user)
	gun_features_flags |= (GUN_WIELDED_STABLE_FIRING_ONLY|GUN_WIELDED_FIRING_ONLY)
	return ..()

/obj/item/weapon/gun/pistol/plasma_pistol/on_detach(obj/item/attached_to, mob/user)
	gun_features_flags &= ~(GUN_WIELDED_STABLE_FIRING_ONLY|GUN_WIELDED_FIRING_ONLY)
	return ..()

/obj/item/weapon/gun/pistol/plasma_pistol/guardsman_pistol
	name = "\improper 卫军\'的等离子手枪"
	desc = "为了帝皇!"
	icon_state = "tx7w"
	worn_icon_state = "tx7"

//-------------------------------------------------------
//RT-3 pistol

/obj/item/weapon/gun/pistol/rt3
	name = "\improper RT-3靶射手枪"
	desc = "一把RT-3靶射手枪,在整个气泡区内随处可见.发射9mm弹匣弹药."
	icon_state = "rt3"
	worn_icon_state = "rt3"
	caliber = CALIBER_9X19 //codex
	max_shells = 14 //codex
	fire_sound = 'sound/weapons/guns/fire/pistol_service.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/pistol/hp,
		/obj/item/ammo_magazine/pistol/ap,
		/obj/item/ammo_magazine/pistol/incendiary,
		/obj/item/ammo_magazine/pistol/extended,
	)

	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 19,"rail_x" = 19, "rail_y" = 21, "under_x" = 21, "under_y" = 15, "stock_x" = 21, "stock_y" = 17)

	fire_delay = 0.2 SECONDS
	accuracy_mult = 1.15

//-------------------------------------------------------
// P-23 service pistol

/obj/item/weapon/gun/pistol/p23
	name = "\improper P-23制式手枪"
	desc = "一把标准P-23,口径为.45 ACP.弹匣容量较小,但威力更强.配有不可拆卸的激光瞄准器.使用.45弹匣."
	icon_state = "tp23"
	worn_icon_state = "tp23"
	caliber = CALIBER_45ACP //codex
	max_shells = 14 //codex
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_p23.ogg'
	unload_sound = 'sound/weapons/guns/interact/colt_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/colt_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/colt_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/p23
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/p23)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/compensator,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/lace,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_offset = list("muzzle_x" = 31, "muzzle_y" = 22,"rail_x" = 13, "rail_y" = 24, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17)

	fire_delay = 0.2 SECONDS
	accuracy_mult = 1.20 //Has a forced laser sight.
	accuracy_mult_unwielded = 0.95
	recoil = -2
	recoil_unwielded = -2

/obj/item/weapon/gun/pistol/p23/suppressed
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/flashlight) //Tacticool

/obj/item/weapon/gun/pistol/p23/tacticool
	starting_attachment_types = list(/obj/item/attachable/lace, /obj/item/attachable/flashlight) //Tacticool

/obj/item/weapon/gun/pistol/p23/tactical
	starting_attachment_types = list(/obj/item/attachable/reddot)

/obj/item/weapon/gun/pistol/p23/beginner
	starting_attachment_types = list(/obj/item/attachable/lace, /obj/item/attachable/reddot)

//-------------------------------------------------------
//P-1911

/obj/item/weapon/gun/pistol/m1911
	name = "\improper P-1911制式手枪"
	desc = "一把P-1911,口径为.45 ACP.一款老式武器,但其广受欢迎且极其可靠的机构为后世众多半自动手枪提供了模板."
	icon_state = "m1911"
	worn_icon_state = "m1911"
	caliber = CALIBER_45ACP //codex
	max_shells = 10 //codex
	fire_sound = 'sound/weapons/guns/fire/colt.ogg'
	unload_sound = 'sound/weapons/guns/interact/colt_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/colt_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/colt_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/m1911
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/m1911)
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 21,"rail_x" = 17, "rail_y" = 22, "under_x" = 21, "under_y" = 15, "stock_x" = 21, "stock_y" = 17)
	reciever_flags = AMMO_RECIEVER_MAGAZINES
	fire_delay = 0.2 SECONDS
	accuracy_mult = 1.05
	accuracy_mult_unwielded = 0.85
	damage_mult = 1.15
	recoil = -2

/obj/item/weapon/gun/pistol/m1911/custom
	name = "\improper P-1911A1定制手枪"
	desc = "一把经过多项改装的手枪.它似乎被精心保养并代代相传.缺少自动弹匣弹出功能."
	icon_state = "m1911c"
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/quickfire,
		/obj/item/attachable/lace,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
	)
	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	fire_delay = 0.15 SECONDS
	damage_mult = 1.3

//-------------------------------------------------------
//P-22. Blocc

/obj/item/weapon/gun/pistol/g22
	name = "\improper P-22手枪"
	desc = "现代一款广受欢迎的警用枪械.口径为9x19mm."
	icon_state = "g22"
	worn_icon_state = "g22"
	caliber = CALIBER_9X19 //codex
	max_shells = 15 //codex
	fire_sound = 'sound/weapons/guns/fire/beretta.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/beretta_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/beretta_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/beretta_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/beretta_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/g22
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/g22, /obj/item/ammo_magazine/pistol/g22tranq)
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 22, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17)
	burst_amount = 3
	accuracy_mult = 1.15
	scatter_unwielded = 0
	aim_slowdown = 0.2
	fire_delay = 0.2 SECONDS

/obj/item/weapon/gun/pistol/g22/tranq
	name = "\improper P-22定制手枪"
	desc = "一把20世纪为特种部队使用而改装的军用枪械,发射麻醉镖以非致命方式制服敌人.它似乎不接受任何其他配件."
	icon_state = "g22"
	worn_icon_state = "g22"
	caliber = CALIBER_9X19_TRANQUILIZER //codex
	max_shells = 12 //codex
	default_ammo_type = /obj/item/ammo_magazine/pistol/g22tranq
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 21, "under_x" = 21, "under_y" = 15, "stock_x" = 21, "stock_y" = 17)
	starting_attachment_types = list(
		/obj/item/attachable/lasersight,
		/obj/item/attachable/suppressor,
	)

	fire_delay = 0.6 SECONDS
	accuracy_mult = 1.2
	accuracy_mult_unwielded = 1.15
	damage_mult = 0.5


//-------------------------------------------------------
//DEAGLE //Deagle Brand Deagle

/obj/item/weapon/gun/pistol/heavy
	name = "\improper 沙漠之鹰手枪"
	desc = "一把口径为.50AE的马格南手枪,后坐力惊人.这一把刻有铭文,<i>\"以绝对优势火力带来和平\"</i>."
	icon_state = "deagle"
	worn_icon_state = "deagle"
	caliber = CALIBER_50AE //codex
	muzzleflash_iconstate = "muzzle_flash_medium"
	max_shells = 7 //codex
	fire_sound = 'sound/weapons/guns/fire/deagle.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/deagle_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/deagle_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/deagle_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/deagle_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/heavy
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/heavy)
	force = 13
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/quickfire,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/compensator,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/lace,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_offset = list("muzzle_x" = 31, "muzzle_y" = 19,"rail_x" = 9, "rail_y" = 23, "under_x" = 22, "under_y" = 14, "stock_x" = 20, "stock_y" = 17)

	fire_delay = 0.45 SECONDS
	scatter_unwielded = 25
	recoil = 1
	recoil_unwielded = 2
	scatter = 2
	scatter_unwielded = 7
	accuracy_mult = 1
	accuracy_mult_unwielded = 0.7

/obj/item/weapon/gun/pistol/heavy/gold
	name = "\improper 沙漠之鹰定制手枪"
	desc = "一把口径为.50AE的马格南手枪,后坐力惊人.这一把为金色表面,带有大量风格化雕刻."
	icon_state = "g_deagle"
	worn_icon_state = "g_deagle"
//-------------------------------------------------------
//MAUSER MERC PISTOL //Inspired by the Makarov.

/obj/item/weapon/gun/pistol/c99
	name = "\improper Korovin PK-9手枪"
	desc = "一款旧式手枪设计的改进型号,配有集成消音器,口径为极小的.22子弹.这一把装填的是更常见的.22空尖弹,似乎是佣兵版本."
	icon_state = "pk9"
	worn_icon_state = "pk9"
	caliber = CALIBER_22LR //codex
	max_shells = 12 //codex
	fire_sound = 'sound/weapons/guns/fire/pistol_holdout.ogg' // Never heard in-game sadly.
	unload_sound = 'sound/weapons/guns/interact/c99_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/c99_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/c99_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/c99
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/c99, /obj/item/ammo_magazine/pistol/c99t)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/quickfire,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/lace,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/suppressor/unremovable/invisible,
		/obj/item/attachable/shoulder_mount,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 22, "under_x" = 21, "under_y" = 18, "stock_x" = 21, "stock_y" = 18)
	//Making the gun have an invisible silencer since it's supposed to have one.
	starting_attachment_types = list(/obj/item/attachable/suppressor/unremovable/invisible)

	fire_delay = 0.2 SECONDS
	accuracy_mult = 1.3
	scatter_unwielded = 2
	damage_mult = 1.3
	aim_slowdown = 0.1

/obj/item/weapon/gun/pistol/c99/tranq
	desc = "一款可追溯至20世纪的旧式东方设计的改进型号.配有集成消音器,口径为极小的.22子弹.这一把通常装填特殊的低后坐力.22镖弹,可作为危险的麻醉剂使用."
	default_ammo_type = /obj/item/ammo_magazine/pistol/c99t

//-------------------------------------------------------
//PIZZACHIMP PROTECTION

/obj/item/weapon/gun/pistol/holdout
	name = "隐藏式手枪"
	desc = "一把用于藏在难以触及之处的小型手枪.最好别问它从哪来的."
	icon_state = "holdout"
	worn_icon_state = "holdout"
	caliber = CALIBER_22LR //codex
	max_shells = 5 //codex
	fire_sound = 'sound/weapons/guns/fire/pistol_holdout.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/holdout
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/holdout)
	w_class = WEIGHT_CLASS_TINY
	force = 2
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/quickfire,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/lace,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_offset = list("muzzle_x" = 25, "muzzle_y" = 20,"rail_x" = 12, "rail_y" = 22, "under_x" = 17, "under_y" = 15, "stock_x" = 22, "stock_y" = 17)

	fire_delay = 0.15 SECONDS

//-------------------------------------------------------
//P-17 Pocket pistol. Based on a PMM.

/obj/item/weapon/gun/pistol/p17
	name = "\improper P-17袖珍手枪"
	desc = "一把TGMC用作应急手枪的小型手枪,设计用于存放在几乎任何地方.可放入靴子.使用.380 ACP,装在八发弹匣中."
	icon_state = "tp17"
	worn_icon_state = "tp17"
	caliber = CALIBER_380ACP //codex
	max_shells = 8 //codex
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_p17.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/p17
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/p17)
	w_class = WEIGHT_CLASS_TINY
	force = 5
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/lace,
		/obj/item/attachable/flashlight/under,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 22, "under_x" = 17, "under_y" = 15, "stock_x" = 22, "stock_y" = 17)

	fire_delay = 0.15 SECONDS
	recoil = -2
	recoil_unwielded = -2
	scatter_unwielded = 0
	aim_speed_modifier = 0


//-------------------------------------------------------
// Browning Hipower

/obj/item/weapon/gun/pistol/highpower
	name = "\improper 高威力自动马格南手枪"
	desc = "一把威力强大的半自动手枪,口径为毁灭性的.50 AE弹药.被执法者和罪犯使用了数百年,最近以这款新型号重现."
	icon_state = "highpower"
	worn_icon_state = "highpower"
	caliber = CALIBER_50AE //codex
	max_shells = 13 //codex
	fire_sound = 'sound/weapons/guns/fire/hp.ogg'
	unload_sound = 'sound/weapons/guns/interact/hp_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/hp_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/hp_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/highpower
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/highpower)
	force = 10

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_offset = list("muzzle_x" = 27, "muzzle_y" = 20,"rail_x" = 8, "rail_y" = 22, "under_x" = 18, "under_y" = 15, "stock_x" = 16, "stock_y" = 15)

	fire_delay = 0.45 SECONDS
	burst_delay = 0.5 SECONDS
	damage_mult = 1.1
	recoil = 1
	recoil_unwielded = 2
	accuracy_mult_unwielded = 0.6
	scatter = 3
	scatter_unwielded = 7

//-------------------------------------------------------
//VP70

/obj/item/weapon/gun/pistol/vp70
	name = "\improper MK88 Mod 4战斗手枪"
	desc = "一把不常见的自动手枪,用于自卫,基于一个多世纪前的原始VP70.发射9mm穿甲弹,可进行三发点射或全自动射击."
	icon_state = "88m4"
	worn_icon_state = "88m4"
	caliber = CALIBER_9X19 //codex
	max_shells = 18 //codex
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_88mod4.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/vp70_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/vp70_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/vp70_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/vp70_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/vp70
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/pistol/vp70,
		/obj/item/ammo_magazine/pistol/vp70/incendiary,
	)
	force = 8
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/lace,
	)

	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 22,"rail_x" = 19, "rail_y" = 24, "under_x" = 24, "under_y" = 16, "stock_x" = 11, "stock_y" = 10)

	fire_delay = 0.2 SECONDS
	burst_delay = 0.1 SECONDS
	burst_amount = 3
	accuracy_mult = 1.2
	accuracy_mult_unwielded = 0.95
	recoil = 0
	aim_slowdown = 0.2
	scatter = 0
	scatter_unwielded = 6
	akimbo_additional_delay = 2

/obj/item/weapon/gun/pistol/vp70/tactical
	starting_attachment_types = list(/obj/item/attachable/reddot, /obj/item/attachable/lasersight, /obj/item/attachable/compensator)

/obj/item/weapon/gun/pistol/vp70/beginner
	starting_attachment_types = list(/obj/item/attachable/reddot, /obj/item/attachable/lasersight, /obj/item/attachable/lace)

//-------------------------------------------------------
//VP78

/obj/item/weapon/gun/pistol/vp78
	name = "\improper VP78战斗手枪"
	desc = "一把巨大而令人生畏的自动手枪,口径为9mm平头弹.常见于富有的Nanotrasen成员手中."
	icon_state = "vp78"
	worn_icon_state = "vp78"
	caliber = CALIBER_9X19 //codex
	max_shells = 18 //codex
	fire_sound = 'sound/weapons/guns/fire/pistol_large.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/vp70_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/vp70_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/vp70_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/vp70_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/vp78
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/vp78)
	force = 8
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 21,"rail_x" = 9, "rail_y" = 23, "under_x" = 23, "under_y" = 13, "stock_x" = 23, "stock_y" = 13)

	fire_delay = 0.3 SECONDS
	burst_amount = 3
	burst_delay = 0.2 SECONDS
	accuracy_mult = 1.15
	accuracy_mult_unwielded = 0.85
	recoil_unwielded = 3

/obj/item/weapon/gun/pistol/vp78/pmc
	starting_attachment_types = list(/obj/item/attachable/reddot, /obj/item/attachable/gyro, /obj/item/attachable/compensator)

//-------------------------------------------------------
//SOM pistol

/obj/item/weapon/gun/pistol/som
	name = "\improper V-11手枪"
	desc = "火星之子使用的标准副武器.一款可靠而简单的武器,常在外围殖民地的出口市场上见到.通常口径为9mm穿甲弹."
	icon_state = "v11"
	worn_icon_state = "v11"
	caliber = CALIBER_9X19
	max_shells = 18
	fire_sound = 'sound/weapons/guns/fire/vp70.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/vp70_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/vp70_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/vp70_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/vp70_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/som
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/som, /obj/item/ammo_magazine/pistol/som/incendiary, /obj/item/ammo_magazine/pistol/som/extended)
	force = 8
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/lace,
	)

	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 22,"rail_x" = 6, "rail_y" = 23, "under_x" = 24, "under_y" = 15, "stock_x" = 11, "stock_y" = 10)

	fire_delay = 0.15 SECONDS
	accuracy_mult = 1.2
	accuracy_mult_unwielded = 0.95
	recoil = -2
	aim_slowdown = 0.1
	scatter = -1
	scatter_unwielded = 4

/obj/item/weapon/gun/pistol/som/standard
	starting_attachment_types = list(
		/obj/item/attachable/lasersight,
		/obj/item/attachable/reddot,
	)

/obj/item/weapon/gun/pistol/som/burst
	default_ammo_type = /obj/item/ammo_magazine/pistol/som/extended
	starting_attachment_types = list(
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/reddot,
		/obj/item/attachable/lace,
	)
//-------------------------------------------------------
//C96 based on P96

/obj/item/weapon/gun/pistol/vsd_pistol
	name = "\improper C96手枪"
	desc = "一款由殖民地守护者使用的\"防暴\"武器.现已被V.S.D采用,是所有成员的标准副武器.发射穿甲9x19mm帕拉贝鲁姆弹,容量为15发."
	icon_state = "c96"
	worn_icon_state = "c96"
	caliber = CALIBER_9X19
	max_shells = 15
	fire_sound = 'sound/weapons/guns/fire/tp23.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/vp70_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/uzi_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/uzi_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/vp70_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/vsd_pistol
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/vsd_pistol)
	force = 8
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/compensator,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/lace,
	)
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 21,"rail_x" = 11, "rail_y" = 23, "under_x" = 24, "under_y" = 15, "stock_x" = 23, "stock_y" = 13)

	fire_delay = 0.2 SECONDS
	accuracy_mult = 1.0
	accuracy_mult_unwielded = 0.75
	recoil = -2
	aim_slowdown = 0.1
	scatter = -1
	scatter_unwielded = 4

/obj/item/weapon/gun/pistol/vsd_pistol/standard
	starting_attachment_types = list(/obj/item/attachable/reddot,/obj/item/attachable/compensator,/obj/item/attachable/lasersight,)

/obj/item/weapon/gun/pistol/xmdivider
	name = "\improper XM104\"分裂者\"左轮手枪"
	desc = "Intertech独一无二的左轮手枪.发射定制燃烧性.357弹药,具有单动和点射两种射击模式切换.后坐力他妈的像头骡子.你记得最高指挥部说过:\"别让这玩意落到敌人手里\"."
	icon = 'icons/obj/items/gun/pistol64.dmi'
	icon_state = "xm104"
	worn_icon_state = "xm104"
	fire_animation = "xm104_fire"
	caliber = CALIBER_357 //codex
	max_shells = 6
	default_ammo_type = /obj/item/ammo_magazine/pistol/xmdivider
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/xmdivider)
	force = 8
	actions_types = null
	attachable_allowed = list(
		/obj/item/attachable/bayonet,
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/compensator,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/lace,
	)
	attachable_offset = list("muzzle_x" = 39, "muzzle_y" = 19, "rail_x" = 16, "rail_y" = 22, "under_x" = 23, "under_y" = 15, "stock_x" = 10, "stock_y" = 18)
	windup_delay = 0.5 SECONDS
	aim_slowdown = 0.1
	burst_amount = 3
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE)
	windup_sound = 'sound/weapons/guns/fire/t76_start.ogg'
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_r76.ogg'
	fire_delay = 0.75 SECONDS
	akimbo_additional_delay = 0.6
	accuracy_mult_unwielded = 0.85
	accuracy_mult = 1
	scatter_unwielded = 5
	scatter = 2
	recoil = 4
	recoil_unwielded = 3

/obj/item/weapon/gun/pistol/xmdivider/gunslinger
	starting_attachment_types = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
	)

//-------------------------------------------------------
/*
Auto 9 The gun RoboCop uses. A better version of the VP78, with more rounds per magazine. Probably the best pistol around, but takes no attachments.
It is a modified Beretta 93R, and can fire three round burst or single fire. Whether or not anyone else aside RoboCop can use it is not established.
*/

/obj/item/weapon/gun/pistol/auto9
	name = "\improper Auto-9手枪"
	desc = "一款先进的选射冲锋手枪,可进行三发点射.最后一次见到是在底特律清理肮脏的街道."
	icon_state = "auto9"
	worn_icon_state = "auto9"
	caliber = CALIBER_9X19 //codex
	max_shells = 50 //codex
	fire_sound = 'sound/weapons/guns/fire/beretta.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/auto9
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/auto9)
	force = 15
	attachable_allowed = list()
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)


	fire_delay = 0.1 SECONDS
	burst_amount = 3
	recoil_unwielded = 3

//-------------------------------------------------------
// PL-5 ICC Duty Pistol

/obj/item/weapon/gun/pistol/icc_dpistol
	name = "\improper PL-5B2执勤手枪"
	desc = "PL-5是一款久经考验的ICCAF手枪,使用极长时间而核心设计改动极小,凭借其对于该口径而言超常的弹匣容量,最适合近距离使用.口径为.45 ACP."
	icon_state = "pl5"
	worn_icon_state = "pl5"
	icon = 'icons/obj/items/gun/pistol64.dmi'
	caliber = CALIBER_45ACP //codex
	max_shells = 18 //codex
	fire_sound = 'sound/weapons/guns/fire/colt.ogg'
	unload_sound = 'sound/weapons/guns/interact/colt_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/colt_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/colt_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/icc_dpistol
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/icc_dpistol)
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 21,"rail_x" = 17, "rail_y" = 22, "under_x" = 21, "under_y" = 15, "stock_x" = 21, "stock_y" = 17)
	reciever_flags = AMMO_RECIEVER_MAGAZINES
	fire_delay = 0.2 SECONDS
	accuracy_mult = 1.1
	accuracy_mult_unwielded = 0.75
	damage_falloff_mult = 1.25
	recoil = -2
	recoil_unwielded = -1

//-------------------------------------------------------
//The first rule of monkey pistol is we don't talk about monkey pistol.

/obj/item/weapon/gun/pistol/chimp
	name = "\improper CHIMP70手枪"
	desc = "一把威力强大的副武器,主要配发给训练有素的精英刺客死灵赛博特工."
	icon_state = "c70"
	worn_icon_state = "c70"
	muzzleflash_iconstate = "muzzle_flash_medium"
	caliber = CALIBER_70MANKEY //codex
	max_shells = 300 //codex
	default_ammo_type = /obj/item/ammo_magazine/pistol/chimp
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/chimp)
	fire_sound = 'sound/weapons/guns/fire/chimp70.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	force = 8
	type_of_casings = null
	gun_skill_category = SKILL_PISTOLS
	attachable_allowed = list()
	gun_features_flags = GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES

	fire_delay = 0.3 SECONDS
	burst_delay = 0.2 SECONDS
	burst_amount = 2

/obj/item/weapon/gun/pistol/knife
	name = "\improper M6\"日蚀掠袭者\"弹道刀"
	desc = "配发给少数地球政府陆战队队员的备用生存刀.这把...刀上有着多得惊人的配件安装点."
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "elite_knife"
	worn_icon_state = "knife"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/melee_right.dmi',
	)
	reload_sound = 'sound/weapons/flipblade.ogg'
	cocked_sound = 'sound/weapons/guns/interact/pistol_cocked.ogg'
	caliber = CALIBER_ALIEN
	equip_slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	force = 30
	movement_acc_penalty_mult = 3
	aim_slowdown = -0.2
	wield_delay = 1 SECONDS // This is how long a knife takes to pull out in CS.
	fire_sound = 'sound/weapons/guns/fire/pistol_service.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/knife
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/knife)
	type_of_casings = "bullet"
	gun_skill_category = SKILL_PISTOLS
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 14,"rail_x" = 9, "rail_y" = 17, "under_x" = 23, "under_y" = 11, "stock_x" = 23, "stock_y" = 10)
	attachable_allowed = list(
		/obj/item/attachable/quickfire,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/lace,
	)

// Smart pistol, based on Calico M-950
/obj/item/weapon/gun/pistol/smart_pistol
	name = "\improper SP-13智能手枪"
	desc = "SP-13是地球政府陆战队使用的具备敌我识别能力的副武器.尖端的微型化技术允许在手枪上安装KTLD敌我识别系统,尽管制造成本高昂,且使用此类手枪通常需要专业训练.独特的设计特点是将高容量弹匣置于枪管上方,并配有集成瞄具."
	icon = 'icons/obj/items/gun/pistol64.dmi'
	icon_state = "sp13"
	worn_icon_state = "sp13"
	caliber = CALIBER_9X19 //codex
	max_shells = 30 //codex
	fire_sound = 'sound/weapons/guns/fire/tp14.ogg' //same bullets, same sound
	reload_sound = 'sound/weapons/guns/interact/tp14_reload.ogg'
	default_ammo_type = /obj/item/ammo_magazine/pistol/p14/smart_pistol
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/p14/smart_pistol)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/lace,
	)

	gun_features_flags = GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_skill_category = SKILL_SMARTGUN
	actions_types = list() // Inherits aimmode, but has IFF so..
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_SEMIAUTO)

	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 20,"rail_x" = 13, "rail_y" = 23, "under_x" = 19, "under_y" = 13, "stock_x" = 21, "stock_y" = 17)

	aim_slowdown = 0.2
	wield_delay = 0.6 SECONDS
	fire_delay = 0.2 SECONDS
	accuracy_mult = 1.2
	accuracy_mult_unwielded = 0.85
	scatter = 3
	scatter_unwielded = 7
	recoil = -2
	recoil_unwielded = 2
