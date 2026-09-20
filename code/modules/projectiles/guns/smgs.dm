/obj/item/weapon/gun/smg
	icon = 'icons/obj/items/gun/submachinegun.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/submachinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/submachinegun_righthand_1.dmi',
	)
	fire_sound = 'sound/weapons/guns/fire/smg_light.ogg'
	unload_sound = 'sound/weapons/guns/interact/smg_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/smg_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/smg_cocked.ogg'
	type_of_casings = "bullet"
	muzzleflash_iconstate = "muzzle_flash_light"
	load_method = MAGAZINE //codex
	force = 8
	w_class = WEIGHT_CLASS_BULKY
	wield_delay = 0.6 SECONDS
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)
	gun_skill_category = SKILL_SMGS

	aim_fire_delay = 0.1 SECONDS
	aim_speed_modifier = 1
	fire_delay = 0.3 SECONDS
	burst_amount = 3
	recoil_unwielded = 0.5
	akimbo_additional_delay = 0.2
	akimbo_scatter_mod = 8

	wield_sound =    'sound/weapons/guns/smgs/Deploy_Wave_SMGS.ogg'
	silenced_sound = 'sound/weapons/guns/smgs/SMG-90/SMG90_SIL.ogg'

//-------------------------------------------------------
// MP-19 Machinepistol. It fits here more.

/obj/item/weapon/gun/smg/mp19
	name = "\improper MP-19冲锋手枪"
	desc = "MP-19是地球政府陆战队的标准配发冲锋手枪.以其低后坐力和单手使用时的散布而闻名.通常由没有空间携带更大枪支的专业部队携带,如医疗兵和工程师.使用10x20mm无壳弹."
	icon_state = "t19"
	worn_icon_state = "t19"
	fire_sound =     'sound/weapons/guns/smgs/MP-19/MP19.ogg'
	unload_sound =   'sound/weapons/guns/smgs/MP-19/MP19_clipout.ogg'
	reload_sound =   'sound/weapons/guns/smgs/MP-19/MP19_clipin.ogg'
	cocked_sound =   'sound/weapons/guns/smgs/MP-19/MP19_boltpull.ogg'
	silenced_sound = 'sound/weapons/guns/smgs/MP-19/MP19_SIL.ogg'
	caliber = CALIBER_10X20_CASELESS //codex
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_AUTOBURST)
	max_shells = 45 //codex
	equip_slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	type_of_casings = null
	default_ammo_type = /obj/item/ammo_magazine/smg/mp19
	allowed_ammo_types = list(/obj/item/ammo_magazine/smg/mp19)
	w_class = WEIGHT_CLASS_NORMAL
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/foldable/mp19stock,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/gyro,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/b11_scope,
	)
	starting_attachment_types = list(/obj/item/attachable/foldable/mp19stock)

	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 19,"rail_x" = 9, "rail_y" = 21, "under_x" = 21, "under_y" = 15, "stock_x" = -4, "stock_y" = 16)

	accuracy_mult = 1.1
	accuracy_mult_unwielded = 0.9
	recoil_unwielded = 0
	fire_delay = 0.15 SECONDS

	scatter = 0
	scatter_unwielded = 4

	aim_slowdown = 0.15
	movement_acc_penalty_mult = 2

	akimbo_scatter_mod = 24
	burst_amount = 5
	burst_delay = 0.1 SECONDS
	akimbo_additional_delay = 20 // Literally do not even bother to try

	burst_amount = 1
	autoburst_delay = 0.1 SECONDS
	autoburst_delay = 0.1 SECONDS //this makes it fuller auto
	burst_accuracy_bonus = -0.3
	burst_scatter_mult = 17

/obj/item/weapon/gun/smg/mp19/compact
	starting_attachment_types = list(/obj/item/attachable/foldable/mp19stock, /obj/item/attachable/reddot, /obj/item/attachable/compensator, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/smg/mp19/vgrip
	starting_attachment_types = list(/obj/item/attachable/foldable/mp19stock, /obj/item/attachable/reddot, /obj/item/attachable/compensator, /obj/item/attachable/verticalgrip)

/obj/item/weapon/gun/smg/mp19/scanner
	starting_attachment_types = list(/obj/item/attachable/foldable/mp19stock, /obj/item/attachable/motiondetector, /obj/item/attachable/compensator, /obj/item/attachable/lasersight)

//-------------------------------------------------------
// War is hell. Not glorious.

/obj/item/weapon/gun/smg/smg90
	name = "\improper SMG-90冲锋枪"
	desc = "SMG-90是地球政府陆战队的标准配发冲锋枪.以其紧凑的尺寸和战场上的易用性而闻名.通常由希望携带轻量级枪械冲锋的部队携带.使用10x20mm无壳弹."
	fire_sound =     'sound/weapons/guns/smgs/SMG-90/SMG90.ogg'
	unload_sound =   'sound/weapons/guns/smgs/SMG-90/SMG90_clipout.ogg'
	reload_sound =   'sound/weapons/guns/smgs/SMG-90/SMG90_clipin.ogg'
	cocked_sound =   'sound/weapons/guns/smgs/SMG-90/SMG90_boltpull.ogg'
	silenced_sound = 'sound/weapons/guns/smgs/SMG-90/SMG90_SIL.ogg'
	icon_state = "t90"
	worn_icon_state = "t90"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/submachinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/submachinegun_righthand_1.dmi',
	)
	caliber = CALIBER_10X20_CASELESS //codex
	max_shells = 80 //codex
	equip_slot_flags = ITEM_SLOT_BACK
	wield_delay = 0.7 SECONDS
	force = 20
	type_of_casings = null
	default_ammo_type = /obj/item/ammo_magazine/smg/smg90
	allowed_ammo_types = list(/obj/item/ammo_magazine/smg/smg90)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/b11_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 15,"rail_x" = 22, "rail_y" = 22, "under_x" = 17, "under_y" = 15, "stock_x" = 24, "stock_y" = 10)
	aim_speed_modifier = 0.55
	accuracy_mult = 1.05
	accuracy_mult_unwielded = 0.9
	scatter = 1
	fire_delay = 0.15 SECONDS
	scatter_unwielded = 8
	aim_slowdown = 0.2
	burst_amount = 0

	placed_overlay_iconstate = "t90"

/obj/item/weapon/gun/smg/smg90/breacher
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness)

/obj/item/weapon/gun/smg/smg90/nonstandard
	starting_attachment_types = list(/obj/item/attachable/reddot)

/obj/item/weapon/gun/smg/smg90/tactical
	starting_attachment_types = list(/obj/item/attachable/compensator, /obj/item/attachable/reddot, /obj/item/attachable/lasersight)

//-------------------------------------------------------
//Da slapper.

/obj/item/weapon/gun/smg/t45
	name = "\improper SMG-45重型冲锋枪"
	desc = "SMG-45是地球政府陆战队使用的比寻常更重的冲锋枪.以小巧体积内蕴含强大威力而闻名.通常由希望携带轻量级枪械冲锋同时打出凶狠一击的部队携带,但在远距离上表现不佳.使用.41 AE无壳弹."
	icon = 'icons/obj/items/gun/submachinegun64.dmi'
	icon_state = "t45"
	worn_icon_state = "t45"
	caliber = CALIBER_41AE //codex
	max_shells = 55 //codex
	fire_sound = 'sound/weapons/guns/fire/skorpevo.ogg'
	unload_sound = 'sound/weapons/guns/interact/mp5_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/mp5_reload.ogg'
	equip_slot_flags = ITEM_SLOT_BACK
	type_of_casings = null
	default_ammo_type = /obj/item/ammo_magazine/smg/t45
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/smg/t45,
		/obj/item/ammo_magazine/smg/t45/squashhead,
	)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/gyro,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)

	attachable_offset = list("muzzle_x" = 43, "muzzle_y" = 19,"rail_x" = 22, "rail_y" = 23, "under_x" = 32, "under_y" = 14, "stock_x" = 24, "stock_y" = 16)

	aim_slowdown = 0.25
	accuracy_mult = 1.15
	accuracy_mult_unwielded = 0.85
	fire_delay = 0.25 SECONDS
	burst_delay =  0.2 SECONDS
	burst_amount = 3
	scatter = 2
	scatter_unwielded = 11
	akimbo_additional_delay = 0.4

//-------------------------------------------------------
//M-25 SMG

/obj/item/weapon/gun/smg/m25
	name = "\improper SMG-25冲锋枪"
	desc = "RivArms SMG-25冲锋枪,经典设计的更新版.一种轻型枪械,能够有效地单手使用,非常适合中近距离交战.使用10x20mm弹药,配有大容量弹匣."
	icon = 'icons/obj/items/gun/submachinegun64.dmi'
	icon_state = "m25"
	worn_icon_state = "m25"
	caliber = CALIBER_10X20_CASELESS //codex
	max_shells = 60 //codex
	fire_sound = 'sound/weapons/guns/fire/mp5.ogg'
	unload_sound = 'sound/weapons/guns/interact/mp5_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/mp5_reload.ogg'
	equip_slot_flags = ITEM_SLOT_BACK
	type_of_casings = null
	default_ammo_type = /obj/item/ammo_magazine/smg/m25
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/smg/m25,
		/obj/item/ammo_magazine/smg/m25/ap,
		/obj/item/ammo_magazine/smg/m25/extended,
	)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/gyro,
		/obj/item/attachable/b11_scope,
	)

	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 17,"rail_x" = 9, "rail_y" = 20, "under_x" = 24, "under_y" = 14, "stock_x" = 24, "stock_y" = 16)

	accuracy_mult = 1.1
	accuracy_mult_unwielded = 0.95
	scatter = 4
	fire_delay = 0.2 SECONDS
	scatter_unwielded = 10
	aim_slowdown = 0.15
	burst_amount = 3
	akimbo_additional_delay = 0.4
	damage_falloff_mult = 0.9

/obj/item/weapon/gun/smg/m25/holstered
	starting_attachment_types = list(/obj/item/attachable/reddot, /obj/item/attachable/compensator, /obj/item/attachable/gyro)

/obj/item/weapon/gun/smg/m25/magharness
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/compensator, /obj/item/attachable/gyro)

/obj/item/weapon/gun/smg/m25/elite
	name = "\improper SMG-25B2冲锋枪"
	desc = "RivArms SMG-25冲锋枪,B2变体.具有内置枪管充电器.这种可靠的武器发射穿甲10x20mm弹药,由精英部队使用."
	icon_state = "m25b2"
	worn_icon_state = "m25b2"
	fire_sound = 'sound/weapons/guns/fire/smg_heavy.ogg'
	default_ammo_type = /obj/item/ammo_magazine/smg/m25/ap
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/gyro,
		/obj/item/attachable/b11_scope,
	)

	item_map_variant_flags = NONE

	burst_amount = 4
	accuracy_mult = 1.1
	accuracy_mult_unwielded = 1
	damage_mult = 1.2
	aim_slowdown = 0.2
	scatter = 3

/obj/item/weapon/gun/smg/m25/elite/pmc
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/flashlight/under)

/obj/item/weapon/gun/smg/m25/elite/suppressed
	icon_state = "m25"
	worn_icon_state = "m25"
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/magnetic_harness, /obj/item/attachable/verticalgrip)

/obj/item/weapon/gun/smg/m25/elite/suppressed/breacher
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/magnetic_harness, /obj/item/attachable/gyro)

//-------------------------------------------------------
//SMG-27, based on the grease gun

/obj/item/weapon/gun/smg/mp7
	name = "\improper SMG-27冲锋枪"
	desc = "一种可追溯到数百年前的古老设计,SMG-27在其鼎盛时期很常见.如今它作为廉价的计算机打印复制品或传家宝仅有有限的使用,不过它不知怎么落到了殖民地叛军手中."
	icon_state = "mp7"
	worn_icon_state = "mp7"
	caliber = CALIBER_46X30 //codex
	max_shells = 30 //codex
	fire_sound = 'sound/weapons/guns/fire/mp7.ogg'
	default_ammo_type = /obj/item/ammo_magazine/smg/mp7
	allowed_ammo_types = list(/obj/item/ammo_magazine/smg/mp7)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/b11_scope,
	)

	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 21, "under_x" = 28, "under_y" = 17, "stock_x" = 28, "stock_y" = 17)

	fire_delay = 0.3 SECONDS
	burst_delay = 0.2 SECONDS
	burst_amount = 4
	accuracy_mult_unwielded = 0.9
	scatter = 5
	scatter_unwielded = 10
	damage_mult = 1.2

//-------------------------------------------------------
//SKORPION //Based on the same thing.

/obj/item/weapon/gun/smg/skorpion
	name = "\improper CZ-81冲锋枪"
	desc = "一种坚固的20世纪枪械,是手枪和冲锋枪的结合体.从20发弹匣发射.32ACP口径弹药."
	icon = 'icons/obj/items/gun/submachinegun64.dmi'
	icon_state = "skorpion"
	worn_icon_state = "skorpion"
	caliber = CALIBER_32ACP //codex
	max_shells = 20 //codex
	equip_slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	fire_sound = 'sound/weapons/guns/fire/skorpion.ogg'
	unload_sound = 'sound/weapons/guns/interact/skorpion_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/skorpion_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/skorpion_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/smg/skorpion
	allowed_ammo_types = list(/obj/item/ammo_magazine/smg/skorpion)
	attachable_allowed = list(
		/obj/item/attachable/foldable/skorpion_stock,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/b11_scope,
	)
	starting_attachment_types = list(/obj/item/attachable/foldable/skorpion_stock)
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 21,"rail_x" = 10, "rail_y" = 24, "under_x" = 23, "under_y" = 15, "stock_x" = -21, "stock_y" = -1)

	burst_delay = 0.1 SECONDS
	accuracy_mult = 1.1
	accuracy_mult_unwielded = 0.9
	scatter = 2
	scatter_unwielded = 6
	fire_delay = 0.1 SECONDS
	aim_slowdown = 0.3
	wield_delay = 0.5 SECONDS

/obj/item/weapon/gun/smg/skorpion/mag_harness
	starting_attachment_types = list(/obj/item/attachable/foldable/skorpion_stock, /obj/item/attachable/magnetic_harness)

/obj/item/weapon/gun/smg/skorpion/commando
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/reddot)

//-------------------------------------------------------
//PPSH //Based on the PPSh-41.

/obj/item/weapon/gun/smg/ppsh
	name = "\improper PPSh-17b冲锋枪"
	desc = "PPSh-17b或\"Papasha\"是20世纪苏联型号冲锋枪的复制品,多年来许多恐怖组织都在仿制.尽管其火力较小,但其可靠性,极长的寿命和高射速证明对使用者很有用."
	icon = 'icons/obj/items/gun/submachinegun64.dmi'
	icon_state = "ppsh"
	worn_icon_state = "ppsh"
	caliber = CALIBER_762X25 //codex
	max_shells = 42 //codex
	equip_slot_flags = ITEM_SLOT_BACK
	fire_sound = 'sound/weapons/guns/fire/ppsh.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/ppsh_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/ppsh_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/ppsh_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/ppsh_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/smg/ppsh
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/smg/ppsh,
		/obj/item/ammo_magazine/smg/ppsh/extended,
	)
	attachable_allowed = list(
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/stock/ppsh,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/b11_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_offset = list("muzzle_x" = 38, "muzzle_y" = 19,"rail_x" = 13, "rail_y" = 21, "under_x" = 26, "under_y" = 15, "stock_x" = 19, "stock_y" = 13)
	aim_fire_delay = 0.15 SECONDS
	aim_speed_modifier = 2

	starting_attachment_types = list(
		/obj/item/attachable/stock/ppsh,
	)

	fire_delay = 0.1 SECONDS
	burst_amount = 1
	accuracy_mult = 1.05
	accuracy_mult_unwielded = 0.8
	akimbo_additional_delay = 0.5

	min_scatter = 2
	min_scatter_unwielded = 3
	max_scatter = 15
	max_scatter_unwielded = 25
	scatter_increase = 2
	scatter_increase_unwielded = 8
	scatter_decay = 0.5
	scatter_decay_unwielded = 0.1

//-------------------------------------------------------
//GENERIC UZI //Based on the uzi submachinegun, of course.

/obj/item/weapon/gun/smg/uzi
	name = "\improper SMG-2冲锋枪"
	desc = "廉价,可靠的设计和制造使这款无处不在的冲锋枪尽管年代久远但仍然有用.将射击选择器调到全自动以获得最大火力.如果你真的想大干一场,就用两把."
	icon_state = "uzi"
	icon = 'icons/obj/items/gun/submachinegun64.dmi'
	worn_icon_state = "uzi"
	caliber = CALIBER_9X19 //codex
	max_shells = 32 //codex
	fire_sound = 'sound/weapons/guns/fire/uzi.ogg'
	unload_sound = 'sound/weapons/guns/interact/uzi_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/uzi_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/uzi_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/smg/uzi
	allowed_ammo_types = list(/obj/item/ammo_magazine/smg/uzi, /obj/item/ammo_magazine/smg/uzi/extended)
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 20,"rail_x" = 11, "rail_y" = 27, "under_x" = 22, "under_y" = 16, "stock_x" = 22, "stock_y" = 16)
	fire_delay = 0.15 SECONDS
	burst_amount = 4
	accuracy_mult_unwielded = 0.9
	scatter = 0
	scatter_unwielded = 4
	aim_slowdown = 0.15
	wield_delay = 0.4 SECONDS

/obj/item/weapon/gun/smg/uzi/mag_harness
	default_ammo_type = /obj/item/ammo_magazine/smg/uzi/extended
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness)

//-------------------------------------------------------
// SOM SMG

/obj/item/weapon/gun/smg/som
	name = "\improper V-21冲锋枪"
	desc = "V-21是火星之子使用的主要冲锋枪,设计为可单手或双手有效使用,具有可变射速.全速射击时,除非正确持握使用,其性能会严重下降,而较低射速在必要时仍可有效地单手使用.使用10x20mm无壳弹."
	icon_state = "v21"
	icon = 'icons/obj/items/gun/submachinegun64.dmi'
	worn_icon_state = "v21"
	caliber = CALIBER_10X20_CASELESS
	max_shells = 50
	equip_slot_flags = ITEM_SLOT_BACK
	type_of_casings = null
	default_ammo_type = /obj/item/ammo_magazine/smg/som
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/smg/som,
		/obj/item/ammo_magazine/smg/som/ap,
		/obj/item/ammo_magazine/smg/som/incendiary,
		/obj/item/ammo_magazine/smg/som/extended,
		/obj/item/ammo_magazine/smg/som/rad,
	)
	fire_sound = 'sound/weapons/guns/fire/vector_fire.ogg'
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_AUTOBURST) //full auto, fuller auto

	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/b11_scope,
	)

	attachable_offset = list("muzzle_x" = 38, "muzzle_y" = 20,"rail_x" = 13, "rail_y" = 22, "under_x" = 31, "under_y" = 15, "stock_x" = 24, "stock_y" = 10)

	fire_delay = 0.15 SECONDS
	aim_slowdown = 0.15
	wield_delay = 0.6 SECONDS

	accuracy_mult = 1.05
	accuracy_mult_unwielded = 0.9

	recoil = 0
	recoil_unwielded = 0.5

	scatter = 2
	scatter_unwielded = 8

	burst_amount = 1
	burst_delay = 0.1 SECONDS
	extra_delay = 0.1 SECONDS
	autoburst_delay = 0.1 SECONDS //this makes it fuller auto
	burst_accuracy_bonus = -0.3
	burst_scatter_mult = 15

	akimbo_additional_delay = 0.7

/obj/item/weapon/gun/smg/som/scout
	starting_attachment_types = list(
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/compensator,
		/obj/item/attachable/motiondetector,
	)

/obj/item/weapon/gun/smg/som/one_handed
	starting_attachment_types = list(
		/obj/item/attachable/lasersight,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
	)

/obj/item/weapon/gun/smg/som/veteran
	default_ammo_type = /obj/item/ammo_magazine/smg/som/ap
	starting_attachment_types = list(
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
	)

/obj/item/weapon/gun/smg/som/support
	starting_attachment_types = list(
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/compensator,
		/obj/item/attachable/magnetic_harness,
	)

/obj/item/weapon/gun/smg/som/basic
	starting_attachment_types = list(
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/magnetic_harness,
	)

//-------------------------------------------------------
// PL-38, ICC Machinepistol

/obj/item/weapon/gun/smg/icc_machinepistol
	name = "\improper PL-38冲锋手枪"
	desc = "PL-38是后方ICCAF人员使用的冲锋手枪,它在紧凑的包装中在较远距离上呈现稳定的性能,尽管因其类别射速较慢而有所不足.使用10x20mm无壳弹."
	icon = 'icons/obj/items/gun/submachinegun64.dmi'
	icon_state = "pl38"
	worn_icon_state = "pl38"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/submachinegun_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/submachinegun_righthand_64.dmi',
	)

	inhand_x_dimension = 64
	inhand_y_dimension = 32

	caliber = CALIBER_10X20_CASELESS //codex
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_AUTOBURST)
	max_shells = 32 //codex
	equip_slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	type_of_casings = null
	default_ammo_type = /obj/item/ammo_magazine/smg/icc_machinepistol
	allowed_ammo_types = list(/obj/item/ammo_magazine/smg/icc_machinepistol, /obj/item/ammo_magazine/smg/icc_machinepistol/hp)
	fire_sound = SFX_MP38_FIRE
	unload_sound = 'sound/weapons/guns/interact/mp38_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/mp38_reload.ogg'

	w_class = WEIGHT_CLASS_NORMAL
	attachable_allowed = list(
		/obj/item/attachable/foldable/icc_machinepistol,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/foldable/mp19stock,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/gyro,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/b11_scope,
	)
	starting_attachment_types = list(/obj/item/attachable/foldable/icc_machinepistol)

	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 19,"rail_x" = 9, "rail_y" = 21, "under_x" = 21, "under_y" = 15, "stock_x" = -4, "stock_y" = 16)

	burst_amount = 1
	accuracy_mult = 1.1
	accuracy_mult_unwielded = 0.65
	recoil_unwielded = 0
	fire_delay = 0.2 SECONDS

	scatter = 2
	scatter_unwielded = 5
	aim_slowdown = 0.2
	wield_delay = 0.55 SECONDS

/obj/item/weapon/gun/smg/icc_machinepistol/medic
	starting_attachment_types = list(/obj/item/attachable/foldable/icc_machinepistol, /obj/item/attachable/magnetic_harness, /obj/item/attachable/verticalgrip, /obj/item/attachable/extended_barrel)

//-------------------------------------------------------
// L-40, ICC PDW

/obj/item/weapon/gun/smg/icc_pdw
	name = "\improper L-40个人防卫武器"
	desc = "L-40是ICCAF的主要冲锋枪,通常因其穿甲高速弹而被称为'PDW',虽然它具有足够的远距离性能,但主要是为近距离战斗调校的.使用4.6mm高速无壳弹."
	icon = 'icons/obj/items/gun/submachinegun64.dmi'
	icon_state = "l40"
	worn_icon_state = "l40"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/submachinegun_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/submachinegun_righthand_64.dmi',
	)

	inhand_x_dimension = 64
	inhand_y_dimension = 32

	caliber = CALIBER_46X30
	max_shells = 45
	equip_slot_flags = ITEM_SLOT_BACK
	type_of_casings = null
	default_ammo_type = /obj/item/ammo_magazine/smg/icc_pdw
	allowed_ammo_types = list(/obj/item/ammo_magazine/smg/icc_pdw)
	fire_sound = 'sound/weapons/guns/fire/vector_fire.ogg'
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)

	attachable_allowed = list(
		/obj/item/attachable/stock/icc_pdw,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung/mpi/removeable,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/attachable/b11_scope,
	)
	starting_attachment_types = list(/obj/item/attachable/stock/icc_pdw)

	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 17,"rail_x" = 13, "rail_y" = 20, "under_x" = 31, "under_y" = 13, "stock_x" = 9, "stock_y" = 10)
	actions_types = list(/datum/action/item_action/aim_mode)

	burst_amount = 1
	fire_delay = 0.15 SECONDS
	aim_slowdown = 0.25
	wield_delay = 0.6 SECONDS

	accuracy_mult = 1.05
	accuracy_mult_unwielded = 0.9

	recoil = 0
	recoil_unwielded = 0.5

	scatter = 3
	scatter_unwielded = 8
	damage_falloff_mult = 1.5

/obj/item/weapon/gun/smg/icc_pdw/standard
	starting_attachment_types = list(/obj/item/attachable/stock/icc_pdw, /obj/item/attachable/magnetic_harness, /obj/item/attachable/verticalgrip, /obj/item/attachable/extended_barrel)

///////////////////////////////////////////////////////////////////////
////////////// Vector, based on KRISS Vector 45ACP. ///////////////////
///////////////////////////////////////////////////////////////////////

/obj/item/weapon/gun/smg/vector
	name = "\improper Vector风暴冲锋枪"
	desc = "Vector是地球政府陆战队为提高陆战队员突击能力而开发的.轻量且易于使用.它采用延迟反冲系统,即使在高射速下也大大减少了后坐力.一个高度可定制的平台,可靠且多功能.快速突击的理想武器.使用加长.45 ACP空尖弹匣"
	fire_sound = 'sound/weapons/guns/fire/tp23.ogg'
	icon = 'icons/obj/items/gun/submachinegun64.dmi'
	icon_state = "v45"
	worn_icon_state = "v45"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/submachinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/submachinegun_righthand_1.dmi',
		slot_back_str = 'icons/mob/clothing/back.dmi',
	)
	caliber = CALIBER_45ACP //codex
	max_shells = 25 //codex
	equip_slot_flags = ITEM_SLOT_BACK
	force = 20
	type_of_casings = null
	default_ammo_type = /obj/item/ammo_magazine/smg/vector
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/smg/vector,
		/obj/item/ammo_magazine/smg/vector/incendiary,

	)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/b7_scope,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/pocket_beam,
		/obj/item/attachable/b11_scope,
	)

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 16, "rail_x" = 22, "rail_y" = 19, "under_x" = 26, "under_y" = 14, "stock_x" = 24, "stock_y" = 10)

	fire_delay = 0.1 SECONDS
	damage_mult = 1
	recoil = -5  // Recoil blowback system
	recoil_unwielded = -2
	wield_delay = 0.5 SECONDS

	akimbo_additional_delay = 0.5
	aim_speed_modifier = 0 //no slowdown
	aim_slowdown = 0

	accuracy_mult = 1
	accuracy_mult_unwielded = 0.75 //moving or akimbo yield lower acc
	scatter = -2
	scatter_unwielded = 6 // Not exactly small weapon, and recoil blowback is only for vertical recoil

	movement_acc_penalty_mult = 0.1
	akimbo_scatter_mod = 10

/obj/item/weapon/gun/smg/vector/beginner
	starting_attachment_types = list(/obj/item/attachable/compensator, /obj/item/attachable/magnetic_harness, /obj/item/attachable/lasersight)

//-------------------------------------------------------
// C17 Riot PDW

/obj/item/weapon/gun/smg/vsd_pdw
	name = "\improper C17防暴PDW"
	desc = "C17 PDW,由Crash Core制造,供民用.发射穿甲.45 ACP,使用55发弹鼓,精度和射速尚可.旨在遏制监狱暴动,它的击杀数比逮捕数还多."
	icon = 'icons/obj/items/gun/submachinegun.dmi'
	icon_state = "c17"
	worn_icon_state = "c17"
	caliber = CALIBER_45ACP //codex
	max_shells = 55 //codex
	fire_sound = 'sound/weapons/guns/fire/smg_light.ogg'
	unload_sound = 'sound/weapons/guns/interact/m16_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m16_reload.ogg'
	equip_slot_flags = ITEM_SLOT_BACK
	type_of_casings = null
	default_ammo_type = /obj/item/ammo_magazine/smg/vsd_pdw
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/smg/vsd_pdw,
	)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/gyro,
		/obj/item/attachable/b11_scope,
	)

	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 18,"rail_x" = 14, "rail_y" = 21, "under_x" = 24, "under_y" = 15, "stock_x" = 24, "stock_y" = 16)
	actions_types = list(/datum/action/item_action/aim_mode)

	aim_slowdown = 0.25
	accuracy_mult = 0.55
	accuracy_mult_unwielded = 0.85
	fire_delay = 0.25 SECONDS
	burst_delay =  0.2 SECONDS
	burst_amount = 4
	scatter = 3
	scatter_unwielded = 11
	akimbo_additional_delay = 0.4

/obj/item/weapon/gun/smg/vsd_pdw/standard
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/verticalgrip, /obj/item/attachable/compensator)

/obj/item/weapon/gun/smg/vsd_pdw/medic
	starting_attachment_types = list(/obj/item/attachable/motiondetector, /obj/item/attachable/lasersight, /obj/item/attachable/extended_barrel)
