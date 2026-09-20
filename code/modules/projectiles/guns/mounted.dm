///box for storage of ammo and gun
/obj/item/storage/box/hsg102
	name = "\improper HSG-102 箱子"
	desc = "一个大型且生锈的金属箱. 它没有怎么被使用过. 其顶部用褪色的字母写着, \"这是一把 HSG-102 重型智能枪\". 上面还有许多其他警告标签,但已经褪色得无法阅读."
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "hsg102_crate"
	w_class = WEIGHT_CLASS_HUGE

/obj/item/storage/box/hsg102/Initialize(mapload)
	. = ..()
	storage_datum.storage_slots = 7
	storage_datum.storage_type_limits = list(
	bypass_w_limit = list(
		/obj/item/weapon/gun/hsg102,
		/obj/item/ammo_magazine/hsg102,
	))

/obj/item/storage/box/hsg102/PopulateContents()
	new /obj/item/weapon/gun/hsg102(src)
	new /obj/item/ammo_magazine/hsg102(src)

///HSG-102, now with full auto. It is not a superclass of deployed guns, however there are a few varients.
/obj/item/weapon/gun/hsg102
	name = "\improper HSG-102 安装式重型智能机枪"
	desc = "HSG-102 重型机枪,它太重了,没有三脚架就无法手持或操作. 具备敌我识别能力. 无需额外工作,只需用 Ctrl-点击部署它. 部署后可以用喷灯修理."

	w_class = WEIGHT_CLASS_HUGE
	equip_slot_flags = ITEM_SLOT_BACK
	icon = 'icons/obj/items/gun/hmg.dmi'
	icon_state = "turret"

	fire_sound = 'sound/weapons/guns/fire/hmg2.ogg'
	reload_sound = 'sound/weapons/guns/machineguns/HMG-08/HMG-08_jam.ogg'

	default_ammo_type = /obj/item/ammo_magazine/hsg102

	scatter = 10
	deployed_scatter_change = -10
	fire_delay = 0.25 SECONDS

	burst_amount = 3
	burst_delay = 0.1 SECONDS
	extra_delay = 1 SECONDS
	accuracy_mult = 1.2 //it's got a bipod
	burst_accuracy_bonus = 1
	burst_scatter_mult = 0

	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE
	gun_features_flags = GUN_AMMO_COUNTER|GUN_DEPLOYED_FIRE_ONLY|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOMATIC)

	attachable_allowed = list(/obj/item/attachable/scope/unremovable/hsg102)
	starting_attachment_types = list(/obj/item/attachable/scope/unremovable/hsg102)
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/hsg102,
	)

	deploy_time = 3 SECONDS
	undeploy_time = 3 SECONDS
	deployable_item = /obj/machinery/deployable/mounted

	max_integrity = 200
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 0, ACID = 20)

///Unmovable ship mounted version.
/obj/item/weapon/gun/hsg102/hsg_nest
	name = "\improper HSG-102 重型智能枪巢"
	desc = "一把 HSG-102 重型智能枪安装在一个带有沙袋的小型加固支柱上,提供一个小型机枪巢,满足你所有的防御需求.</span>"
	icon = 'icons/obj/items/gun/hmg.dmi'
	icon_state = "entrenched"

	default_ammo_type = /obj/item/ammo_magazine/hsg102/hsg_nest

	attachable_allowed = list(/obj/item/attachable/scope/unremovable/hsg102/nest)
	starting_attachment_types = list(
		/obj/item/attachable/scope/unremovable/hsg102/nest,
	)

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/hsg102,
		/obj/item/ammo_magazine/hsg102/hsg_nest,
	)
	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE|DEPLOYED_NO_PICKUP|DEPLOY_ON_INITIALIZE
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 0, ACID = 0)

/obj/item/weapon/gun/hsg102/hsg_nest/sandless
	icon_state = "entrenched_sandless"

//-------------------------------------------------------
//MG-2005 mounted minigun

/obj/item/weapon/gun/standard_minigun
	name = "\improper MG-2005 安装式迷你炮"
	desc = "MG-2005固定式机枪原理简单,能以极快速度倾泻大量子弹,撕碎异形虫群."

	w_class = WEIGHT_CLASS_HUGE
	equip_slot_flags = ITEM_SLOT_BACK
	icon = 'icons/obj/items/gun/hmg.dmi'
	icon_state = "minigun"
	caliber = CALIBER_762X51

	fire_sound = 'sound/weapons/guns/fire/minigun.ogg'
	reload_sound = 'sound/weapons/guns/interact/minigun_cocked.ogg'

	default_ammo_type = /obj/item/ammo_magazine/heavy_minigun

	scatter = 10
	deployed_scatter_change = -8
	fire_delay = 0.10 SECONDS
	windup_delay = 0.4 SECONDS
	windup_sound = 'sound/weapons/guns/fire/tank_minigun_start.ogg'

	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE
	gun_features_flags = GUN_AMMO_COUNTER|GUN_DEPLOYED_FIRE_ONLY|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_time = 2 SECONDS
	aim_fire_delay = 0.05 SECONDS

	attachable_allowed = list(/obj/item/attachable/scope/unremovable/hsg102)
	starting_attachment_types = list(/obj/item/attachable/scope/unremovable/hsg102)

	allowed_ammo_types = list(/obj/item/ammo_magazine/heavy_minigun)

	deploy_time = 5 SECONDS
	undeploy_time = 3 SECONDS
	deployable_item = /obj/machinery/deployable/mounted

	max_integrity = 300
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 0, ACID = 20)

///Unmovable ship mounted version.
/obj/item/weapon/gun/standard_minigun/nest
	name = "\improper MG-2005固定式机枪巢"
	desc = "一挺MG-2005固定式机枪架设在一个配有沙袋的小型加固支柱上."
	icon_state = "minigun_nest"

	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE|DEPLOYED_NO_PICKUP|DEPLOY_ON_INITIALIZE

	attachable_allowed = list(/obj/item/attachable/scope/unremovable/hsg102/nest)
	starting_attachment_types = list(/obj/item/attachable/scope/unremovable/hsg102/nest)
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 0, ACID = 20)

//-------------------------------------------------------
//ATR-22 mounted heavy anti-air gun

/obj/item/weapon/gun/atr22
	name = "\improper ATR-22固定式高射炮"
	desc = "ATR-22是一门采用后坐式炮管的20毫米自动炮,专为对付低空飞行目标而设计,但它也能以极高效率在中距离打击地面目标,尽管其后坐力使得几乎不可能命中近距离目标,其炮弹能撕碎装甲敌人或墙壁等硬目标.两门炮管可以同时开火而非依次射击,但这样做会带来巨大的散布惩罚."
	w_class = WEIGHT_CLASS_HUGE
	equip_slot_flags = ITEM_SLOT_BACK
	icon = 'icons/obj/artillery/atr22.dmi'
	icon_state = "autocannon"
	fire_sound = SFX_AC_FIRE
	reload_sound = 'sound/weapons/guns/interact/minigun_cocked.ogg'

	default_ammo_type = /obj/item/ammo_magazine/atr22

	scatter = 10
	deployed_scatter_change = -10
	fire_delay = 0.4 SECONDS
	burst_amount = 12
	burst_delay = 0.2 SECONDS
	burst_scatter_mult = 0.65
	extra_delay = 1.5 SECONDS

	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE|DEPLOYED_NO_PICKUP|DEPLOY_ON_INITIALIZE
	gun_features_flags = GUN_AMMO_COUNTER|GUN_DEPLOYED_FIRE_ONLY|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_BURSTFIRE, GUN_FIREMODE_AUTOBURST)

	attachable_allowed = list(/obj/item/attachable/scope/unremovable/at36)

	starting_attachment_types = list(/obj/item/attachable/scope/unremovable/at36)

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/atr22,
		/obj/item/ammo_magazine/atr22/flak,
	)

	undeploy_time = 2000 SECONDS
	deployable_item = /obj/machinery/deployable/mounted/moveable/atr22

	max_integrity = 500
	soft_armor = list(MELEE = 60, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 0, ACID = 0)

/obj/machinery/deployable/mounted/moveable/atr22
	resistance_flags = XENO_DAMAGEABLE|UNACIDABLE
	coverage = 85 //has a shield

//-------------------------------------------------------
//TE-9001 mounted heavy laser

/obj/item/weapon/gun/energy/lasgun/lasrifle/heavy_laser
	name = "\improper TE-9001固定式重型激光"
	desc = "TE-9001固定式重型激光是一种不具备敌我识别能力的重型激光,威力足以在命中点引发规模可观的火灾,这种武器在区域封锁方面表现出色,同时具备直射火力能力."

	w_class = WEIGHT_CLASS_HUGE
	equip_slot_flags = ITEM_SLOT_BACK
	icon_state = "heavylaser_nest"
	icon = 'icons/obj/items/gun/hmg.dmi'
	ammo_level_icon = ""

	fire_sound = 'sound/weapons/guns/fire/tank_flamethrower.ogg'
	reload_sound = 'sound/weapons/guns/interact/minigun_cocked.ogg'

	default_ammo_type = /obj/item/cell/lasgun/heavy_laser
	ammo_datum_type = /datum/ammo/energy/lasgun/marine/heavy_laser

	scatter = 10
	deployed_scatter_change = -10
	fire_delay = 0.7 SECONDS

	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE|DEPLOYED_NO_PICKUP|DEPLOY_ON_INITIALIZE
	gun_features_flags = GUN_AMMO_COUNTER|GUN_DEPLOYED_FIRE_ONLY|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES|GUN_AMMO_COUNT_BY_SHOTS_REMAINING
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)

	attachable_allowed = list(/obj/item/attachable/scope/unremovable/hsg102/nest)
	starting_attachment_types = list(/obj/item/attachable/scope/unremovable/hsg102/nest)

	allowed_ammo_types = list(/obj/item/cell/lasgun/heavy_laser)

	deploy_time = 5 SECONDS
	undeploy_time = 3 SECONDS
	deployable_item = /obj/machinery/deployable/mounted

	max_integrity = 400
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 0, ACID = 0)

	mode_list = list(
		"Standard" = /datum/lasrifle/heavy_laser/standard,
		"Shatter Burst" = /datum/lasrifle/heavy_laser/burst,
		"Ricochet" = /datum/lasrifle/heavy_laser/ricochet,
	)

/datum/lasrifle/heavy_laser/standard
	rounds_per_shot = 15
	ammo_datum_type = /datum/ammo/energy/lasgun/marine/heavy_laser
	fire_delay = 0.7 SECONDS
	burst_amount = 1
	fire_sound = 'sound/weapons/guns/fire/tank_flamethrower.ogg'
	message_to_user = "You set the heavy laser to glob mode."
	fire_mode = GUN_FIREMODE_SEMIAUTO
	icon_state = "heavylaser"
	radial_icon_state = "laser_overcharge"
	description = "Fires a laser glob that ignites things on hit."

/datum/lasrifle/heavy_laser/burst
	rounds_per_shot = 5
	ammo_datum_type = /datum/ammo/energy/lasgun/marine/shatter/heavy_laser
	fire_delay = 1 SECONDS
	burst_amount = 3
	fire_sound = 'sound/weapons/guns/fire/Laser Rifle Standard.ogg'
	message_to_user = "You set the heavy laser to burst fire mode."
	fire_mode = GUN_FIREMODE_AUTOBURST
	icon_state = "heavylaser"
	description = "Fires a rapid pulse laser, dealing mediocre damage and shattering armor, but suffers from increased scatter and poorer falloff."

/datum/lasrifle/heavy_laser/ricochet
	rounds_per_shot = 15
	fire_delay = 0.5 SECONDS
	ammo_datum_type = /datum/ammo/energy/lasgun/marine/ricochet/four
	fire_sound = 'sound/weapons/guns/fire/laser3.ogg'
	message_to_user = "You set the heavy laser to ricochet mode."
	fire_mode = GUN_FIREMODE_SEMIAUTO
	icon_state = "heavylaser"
	radial_icon_state = "laser_ricochet"
	description = "Fires an experiment laser pulse capable of bouncing off many wall surfaces. The laser increases in potency when bouncing, before collapsing entirely after exceeding its threshold."

/obj/item/weapon/gun/energy/lasgun/lasrifle/heavy_laser/deployable
	icon_state = "heavylaser"
	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE

//-------------------------------------------------------
//FK-88 mounted heavy infantry support gun

/obj/item/weapon/gun/fk88
	name = "\improper FK-88固定式高射炮"
	desc = "FK-88是一门大炮,官方用途是对付大型敌对野生动物或失控人群,这门炮绝对会让任何被其火力线笼罩的东西度过非常糟糕的一天.需要相当长的时间来校准射击.使用15厘米炮弹."

	w_class = WEIGHT_CLASS_HUGE
	equip_slot_flags = ITEM_SLOT_BACK
	icon = 'icons/obj/artillery/fk88.dmi'
	icon_state = "isg"
	fire_sound = 'sound/weapons/guns/fire/tank_cannon1.ogg'
	reload_sound = 'sound/weapons/guns/interact/tat36_reload.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/launcher_empty.ogg'

	default_ammo_type = /obj/item/ammo_magazine/fk88/he
	max_shells = 1 //codex
	caliber = CALIBER_15CM // codex

	scatter = 10
	deployed_scatter_change = -10
	fire_delay = 10 SECONDS

	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE|DEPLOYED_NO_PICKUP|DEPLOY_ON_INITIALIZE|DEPLOYED_ANCHORED_FIRING_ONLY
	gun_features_flags = GUN_AMMO_COUNTER|GUN_DEPLOYED_FIRE_ONLY|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)

	attachable_allowed = list(/obj/item/attachable/scope/unremovable/hsg102/nest)

	starting_attachment_types = list(/obj/item/attachable/scope/unremovable/hsg102/nest)

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/fk88/he,
		/obj/item/ammo_magazine/fk88/he/unguided,
		/obj/item/ammo_magazine/fk88/sabot,
	)

	deploy_time = 6 SECONDS
	undeploy_time = 3 SECONDS
	deployable_item = /obj/machinery/deployable/mounted/moveable/fk88

	max_integrity = 800
	soft_armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 0, ACID = 0)

/obj/machinery/deployable/mounted/moveable/fk88
	coverage = 90 // Has a shield.
	anchor_time = 4 SECONDS
	has_anchored_sprite = TRUE
	pixel_x = -16
	pixel_y = -11

///This is my meme version, the first version of the HSG-102 to have auto-fire, revel in its presence.
/obj/item/weapon/gun/hsg102/death
	name = "\improper \"死亡化身\"重型智能机枪"
	desc = "它看起来像一挺普通的HSG-102,但其侧面和顶部隐约闪烁着古老的文字.它渴求鲜血."

	aim_slowdown = 3
	scatter = 30
	deployed_scatter_change = -27

	fire_delay = 0.5
	burst_amount = 3
	burst_delay = 0.1 SECONDS

	aim_slowdown = 3
	wield_delay = 5 SECONDS

	gun_features_flags = GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES

// This is a deployed IFF-less MACHINEGUN, has 500 rounds, drums do not fit anywhere but your belt slot and your back slot. But it has 500 rounds. That's nice.

/obj/item/weapon/gun/hmg08
	name = "\improper HMG-08重机枪"
	desc = "一件绝对的怪物级武器,这是一挺由某个疯狂军械师现代化改装的水冷式重机枪,还附带了一套轮式套件.考虑到轮式套件的零件混杂,你觉得它来自另一种型号的枪.坚守咽喉要道的巅峰之作.弹箱可容纳500发10x28毫米无壳弹.不具备敌我识别能力.建议仔细瞄准.部署后可用喷灯修复.按住Alt右键可将其拔出锚定并重新锚定."
	w_class = WEIGHT_CLASS_HUGE
	equip_slot_flags = ITEM_SLOT_BACK
	icon = 'icons/obj/items/gun/hmg.dmi'
	icon_state = "mg08"
	worn_icon_state = "mg08"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_1.dmi',
	)

	fire_sound = 'sound/weapons/guns/fire/mg08.ogg'
	reload_sound = 'sound/weapons/guns/machineguns/HMG-08/HMG-08_jam.ogg'
	caliber = CALIBER_10X28

	default_ammo_type = /obj/item/ammo_magazine/hmg08
	allowed_ammo_types = list(/obj/item/ammo_magazine/hmg08, /obj/item/ammo_magazine/hmg08/small)

	scatter = 10
	deployed_scatter_change = -8
	fire_delay = 0.2 SECONDS
	accuracy_mult = 1.1 //it's mounted

	burst_amount = 1

	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE
	gun_features_flags = GUN_AMMO_COUNTER|GUN_DEPLOYED_FIRE_ONLY|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)

	attachable_allowed = list(
		/obj/item/attachable/scope/unremovable/hmg08,
	)

	starting_attachment_types = list(
		/obj/item/attachable/scope/unremovable/hmg08,
	)

	deploy_time = 8 SECONDS
	undeploy_time = 3 SECONDS
	deployable_item = /obj/machinery/deployable/mounted/moveable/fast

	max_integrity = 200
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 0, ACID = 20)

//-------------------------------------------------------
//MG-27 Medium Machine Gun

/obj/item/weapon/gun/mg27
	name = "\improper MG-27中型机枪"
	desc = "MG-27是SG-29老旧的无敌我识别能力的表亲,专为在短时间内进行快速精准的机枪射击而设计,你可以站着使用它,但这不是个好主意.实战中使用三脚架.使用10x27毫米弹箱."
	equip_slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/items/gun/machinegun64.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_1.dmi',
	)
	icon_state = "t27"
	worn_icon_state = "t27"
	caliber = CALIBER_10X27_CASELESS // codex
	max_shells = 150 //codex
	force = 40
	aim_slowdown = 1.2
	wield_delay = 2.2 SECONDS
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_mg27.ogg'
	fire_rattle = 'sound/weapons/guns/fire/tgmc/kinetic/gun_mg27_low.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound =   'sound/weapons/guns/machineguns/MG-27/MG27_boxout.ogg'
	reload_sound =   'sound/weapons/guns/machineguns/MG-27/MG27_boxin.ogg'
	cocked_sound = 	 'sound/weapons/guns/machineguns/MG-27/MG27_boltpull.ogg'
	silenced_sound = 'sound/weapons/guns/machineguns/MG-27/MG27_SIL.ogg'
	wield_sound = 	 'sound/weapons/guns/machineguns/Deploy_Wave_MACHINEGUN.ogg'
	default_ammo_type = /obj/item/ammo_magazine/mg27
	allowed_ammo_types = list(/obj/item/ammo_magazine/mg27)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/unremovable/mg27,
		/obj/item/attachable/b11_scope,
		/obj/item/attachable/b15_scope,
	)
	attachable_offset = list("muzzle_x" = 45, "muzzle_y" = 19,"rail_x" = 18, "rail_y" = 24, "under_x" = 28, "under_y" = 13, "stock_x" = 0, "stock_y" = 0)

	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE
	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	deployable_item = /obj/machinery/deployable/mounted
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.05 SECONDS
	aim_speed_modifier = 5
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 0, ACID = 0)

	scatter = 30 // you're not firing this standing.
	deployed_scatter_change = -70 // innumerable amount of reduced scatter when deployed,
	recoil = 2
	scatter_unwielded = 45
	accuracy_mult = 1.1 //it's got a bipod
	fire_delay = 0.15 SECONDS
	burst_amount = 1
	deploy_time = 1 SECONDS
	damage_falloff_mult = 0.25
	undeploy_time = 0.5 SECONDS
	max_integrity = 200

/obj/item/weapon/gun/mg27/machinegunner
	starting_attachment_types = list(/obj/item/attachable/scope/unremovable/mg27)

/obj/item/weapon/gun/clf_heavyrifle
	name = "\improper PTR-41/1785反机甲枪"
	desc = "PTR-41/1785是一种为对付装甲而现代化改装的下等解决方案,虽然可以站着使用,但显然不是个好主意.建议在部署两脚架后使用.它使用14.5毫米高速弹,被击中的不幸灵魂身上必定会留下一个洞."
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/items/gun/marksman64.dmi'
	icon_state = "ptrs"
	worn_icon_state = "ptrs"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/marksman_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/marksman_righthand_64.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	caliber = CALIBER_14X5 // codex
	max_shells = 5 //codex
	max_chamber_items = 5
	force = 30
	fire_sound = 'sound/weapons/guns/fire/ptrs.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	reload_sound = 'sound/weapons/guns/interact/shotgun_shell_insert.ogg'
	hand_reload_sound = 'sound/weapons/guns/interact/shotgun_shell_insert.ogg'
	cocked_sound = 'sound/weapons/guns/interact/shotgun_reload.ogg'
	opened_sound = 'sound/weapons/guns/interact/shotgun_open.ogg'
	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY
	reciever_flags = AMMO_RECIEVER_HANDFULS
	default_ammo_type = /datum/ammo/bullet/sniper/clf_heavyrifle
	attachable_allowed = list(
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/stock/clf_heavyrifle,
		/obj/item/attachable/scope,
	)

	starting_attachment_types = list(/obj/item/attachable/stock/clf_heavyrifle)
	attachable_offset = list("muzzle_x" = 45, "muzzle_y" = 19,"rail_x" = 18, "rail_y" = 24, "under_x" = 28, "under_y" = 13, "stock_x" = 8, "stock_y" = 0)

	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE
	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY
	deployable_item = /obj/machinery/deployable/mounted
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 2 SECONDS
	aim_speed_modifier = 3
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 0, ENERGY = 0, BOMB = 50, BIO = 100, FIRE = 0, ACID = 0)

	scatter = 16
	deployed_scatter_change = -16
	recoil = 4
	scatter_unwielded = 45
	accuracy_mult = 1
	burst_amount = 1
	fire_delay = 1.35 SECONDS
	aim_slowdown = 2
	deploy_time = 1 SECONDS // Meant to be used by ERT's
	undeploy_time = 0.25 SECONDS
	movement_acc_penalty_mult = 20 // Good luck hitting on the move, bruv

/obj/item/weapon/gun/clf_heavyrifle/imported
	name = "\improper PTR-41/1785I1"
	desc = "PTR-41/1785I1是原版PTR-41的进口版本,更换了机匣,使得可以安装更常见的T-47瞄准镜.然而,更换机匣也带来了一些不便,这就是为什么瞄准时射击需要更长时间.除此之外,它几乎是完全的复制品.虽然可以站着使用,但显然不是个好主意.建议在部署两脚架后使用.它使用14.5毫米高速弹,被击中的不幸灵魂身上必定会留下一个洞."
	attachable_allowed = list(
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/stock/clf_heavyrifle,
		/obj/item/attachable/scope/marine,
	)

	aim_fire_delay = 3 SECONDS
//-------------------------------------------------------
//AT-36 Anti Tank Gun

/obj/item/weapon/gun/at36
	name = "\improper AT-36反坦克炮"
	desc = "AT-36是TGMC使用的一种轻型两用反坦克和反人员武器.用于在短时间内摧毁轻型车辆或碉堡.最好由两人操作.它可以通过轮子移动,并配有与武器一体的弹药架.一旦部署就无法收起!它使用多种类型的37毫米炮弹箱.按住Alt右键点击可将其锚定,使其无法被任何人移动,再次按住Alt右键点击可移动它."
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/artillery/at36.dmi'
	icon_state = "tat36"
	worn_icon_state = "tat36"
	caliber = CALIBER_37MM // codex
	max_shells = 1 //codex
	fire_sound = 'sound/weapons/guns/fire/tat36.ogg'
	reload_sound = 'sound/weapons/guns/interact/tat36_reload.ogg'
	default_ammo_type = /obj/item/ammo_magazine/at36
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/at36,
		/obj/item/ammo_magazine/at36/apcr,
		/obj/item/ammo_magazine/at36/he,
		/obj/item/ammo_magazine/at36/beehive,
		/obj/item/ammo_magazine/at36/incend,
	)
	attachable_offset = list("muzzle_x" = 45, "muzzle_y" = 20,"rail_x" = 18, "rail_y" = 22, "under_x" = 28, "under_y" = 13, "stock_x" = 0, "stock_y" = 0)
	starting_attachment_types = list(/obj/item/attachable/scope/unremovable/at36)
	attachable_allowed = list(/obj/item/attachable/scope/unremovable/at36)

	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE|DEPLOYED_NO_PICKUP|DEPLOY_ON_INITIALIZE|DEPLOYED_NO_ROTATE_ANCHORED|DEPLOYED_ANCHORED_FIRING_ONLY
	gun_features_flags = GUN_AMMO_COUNTER|GUN_DEPLOYED_FIRE_ONLY|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES

	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_time = 6 SECONDS
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_AUTO_EJECT
	soft_armor = list(MELEE = 60, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 0, ACID = 0)

	scatter = 0
	recoil = 3
	fire_delay = 3 SECONDS
	burst_amount = 1
	undeploy_time = 2000 SECONDS
	max_integrity = 500
	deployable_item = /obj/machinery/deployable/mounted/moveable/at36

/obj/machinery/deployable/mounted/moveable/at36
	resistance_flags = XENO_DAMAGEABLE|UNACIDABLE
	coverage = 85 //has a shield
	anchor_time = 1 SECONDS
	///The internal storage of our atgun
	var/obj/item/storage/atgun_ammo_rack/sponson = /obj/item/storage/atgun_ammo_rack

/obj/item/storage/atgun_ammo_rack
	storage_type = /datum/storage/internal/ammo_rack

/obj/machinery/deployable/mounted/moveable/at36/Destroy()
	if(sponson)
		QDEL_NULL(sponson)
	return ..()

/obj/machinery/deployable/mounted/moveable/at36/Initialize(mapload)
	. = ..()
	sponson = new sponson(src)

/obj/machinery/deployable/mounted/moveable/at36/attackby(obj/item/I, mob/user, params)
	var/obj/item/weapon/gun/at36/internal_gun = get_internal_item()
	if(user.interactee == src && (I.type in internal_gun?.allowed_ammo_types))
		balloon_alert(user, "正忙!")
		return

	if(!sponson.attackby(I, user, params))
		return ..()

/obj/machinery/deployable/mounted/moveable/at36/attack_hand_alternate(mob/living/user)
	if(user.interactee == src)
		balloon_alert(user, "正忙!")
		return
	return sponson.attack_hand_alternate(user)

/obj/machinery/deployable/mounted/moveable/at36/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	if(!ishuman(usr) || usr.lying_angle || usr.incapacitated())
		return FALSE

	if(usr.interactee == src)
		balloon_alert(usr, "正忙!")
		return

	if(over == usr && Adjacent(usr)) //This must come before the screen objects only block
		sponson.storage_datum.open(usr)
		return FALSE

//AGLS-37, or Automatic Grenade Launching System 37, a fully automatic mounted grenade launcher that fires fragmentation and HE shells, can't be turned.

/obj/item/weapon/gun/agls37
	name = "\improper AGLS-37 Kauser自动榴弹发射器"
	desc = "AGLS-37自动榴弹发射系统具备敌我识别能力,它太重了,没有三脚架就无法手持或操作.背面写着:\"该武器造成的爆炸和破片不具备友军伤害能力.Kauser没有义务为你或你的朋友购买新的身体部件,如果你或他们失去了这些部件.\"\nCan用Ctrl-Click部署.部署后可用喷灯修复."
	w_class = WEIGHT_CLASS_HUGE
	equip_slot_flags = ITEM_SLOT_BACK
	caliber = CALIBER_40MM
	icon = 'icons/obj/items/gun/hmg.dmi'
	icon_state = "agls"
	fire_sound = 'sound/weapons/guns/fire/agls.ogg'
	reload_sound = 'sound/weapons/guns/interact/minigun_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/agls37
	scatter = 0
	fire_delay = 1 SECONDS
	burst_amount = 0
	accuracy_mult = 1.2 //it's got a bipod
	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE
	gun_features_flags = GUN_AMMO_COUNTER|GUN_DEPLOYED_FIRE_ONLY|GUN_WIELDED_FIRING_ONLY
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)

	attachable_allowed = list(
		/obj/item/attachable/scope/unremovable/at36,
	)

	starting_attachment_types = list(
		/obj/item/attachable/scope/unremovable/at36,
	)

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/agls37,
		/obj/item/ammo_magazine/agls37/fragmentation,
		/obj/item/ammo_magazine/agls37/incendiary,
		/obj/item/ammo_magazine/agls37/flare,
		/obj/item/ammo_magazine/agls37/cloak,
		/obj/item/ammo_magazine/agls37/tanglefoot,
	)

	deploy_time = 5 SECONDS
	undeploy_time = 3 SECONDS
	deployable_item = /obj/machinery/deployable/mounted


	max_integrity = 300
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 0, ACID = 20)

/obj/item/weapon/gun/agls37/do_fire(obj/object_to_fire)
	. = ..()
	if(!.)
		return FALSE
	if(istype(in_chamber, /obj/item/ammo_magazine/agls37/incendiary))
		gun_user?.record_war_crime()

// Non-TGMC HMG

/obj/item/weapon/gun/kord
	name = "\improper KRD-61ES固定式重机枪"
	desc = "KRD-61ES机枪是ML-91重机枪的出口型号.它太重了,没有三脚架就无法手持或操作.无需额外操作,只需用Ctrl-Click部署.部署后可用喷灯修复."
	icon = 'icons/obj/items/gun/machinegun64.dmi'
	icon_state = "kord"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_1.dmi',
	)
	fire_sound = 'sound/weapons/guns/fire/hmg2.ogg'
	reload_sound = 'sound/weapons/guns/interact/minigun_cocked.ogg'

	w_class = WEIGHT_CLASS_HUGE
	equip_slot_flags = ITEM_SLOT_BACK

	scatter = 10
	deployed_scatter_change = -10
	accuracy_mult = 1.2 //it's got a bipod
	fire_delay = 0.25 SECONDS

	default_ammo_type = /obj/item/ammo_magazine/kord
	allowed_ammo_types = list(/obj/item/ammo_magazine/kord)

	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE
	gun_features_flags = GUN_AMMO_COUNTER|GUN_DEPLOYED_FIRE_ONLY|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	aim_fire_delay = 0.05 SECONDS
	aim_speed_modifier = 5
	attachable_allowed = list(/obj/item/attachable/scope/unremovable/hsg102)
	starting_attachment_types = list(/obj/item/attachable/scope/unremovable/hsg102)

	deploy_time = 1.5 SECONDS
	undeploy_time = 0.5 SECONDS
	deployable_item = /obj/machinery/deployable/mounted

	max_integrity = 200
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 0, ACID = 20)

	allowed_ammo_types = list(/obj/item/ammo_magazine/kord)
