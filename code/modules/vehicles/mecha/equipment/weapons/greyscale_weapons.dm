/*!
 * Greyscale mech equipment file
 *
 * Basically all equipment that you can add onto a mech should go here
 * naming scheme is [Greek titan/titan relative] + [weapon type]
 * when setting variance remember that it's negatively modified by the arm it's attached to
 * note that weapon vars are not the same as guns
 * Notably:
 * No autoburst var, uses basic var instead
 * only one firemode per gun
 * equip_cooldown gets overriden unless propjectile is thrown
 */

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/pistol
	name = "\improper 科托斯手枪"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "机甲可用的最小武器.威力不大,但能让机甲获得更高的机动性."
	icon_state = "pistol"
	fire_sound = 'sound/mecha/weapons/mech_pistol.ogg'
	muzzle_iconstate = "muzzle_flash_light"
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,30), "S" = list(-2,16), "E" = list(44,16), "W" = list(-13,36)),
		MECHA_L_ARM = list("N" = list(-4,30), "S" = list(32,16), "E" = list(44,36), "W" = list(-13,16)),
	)
	can_equip = TRUE
	ammotype = /datum/ammo/bullet/pistol/mech
	max_integrity = 500
	projectiles = 20
	projectiles_cache = 400
	projectiles_cache_max = 400
	variance = 10
	slowdown = 0
	projectile_delay = 0.3 SECONDS
	ammo_type = MECHA_AMMO_PISTOL
	hud_icons = list("pistol", "pistol_empty")
	fire_mode = GUN_FIREMODE_SEMIAUTO

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/burstpistol
	name = "\improper 克里乌斯连发手枪"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "一种为机甲配备的连发武器.比大型武器提供更高的机动性和精准度,但伤害降低."
	icon_state = "burstpistol"
	fire_sound = 'sound/mecha/weapons/mech_pistol.ogg'
	muzzle_iconstate = "muzzle_flash_light"
	can_equip = TRUE
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,30), "S" = list(-2,8), "E" = list(52,8), "W" = list(-21,28)),
		MECHA_L_ARM = list("N" = list(-4,30), "S" = list(32,8), "E" = list(52,28), "W" = list(-20,8)),
	)
	ammotype = /datum/ammo/bullet/pistol/mech/burst
	max_integrity = 450
	projectiles = 42
	projectiles_cache = 840
	projectiles_cache_max = 840
	variance = 15
	slowdown = 0.1
	projectile_delay = 0.6 SECONDS
	burst_amount = 3
	projectile_burst_delay = 0.1 SECONDS
	ammo_type = MECHA_AMMO_BURSTPISTOL
	hud_icons = list("pistol_light", "pistol_empty")
	fire_mode = GUN_FIREMODE_AUTOBURST

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/smg
	name = "\improper 科乌斯冲锋枪"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "作为最小的自动射击武器,它提供更好的机动性,但火力不如大多数更大的同类武器."
	muzzle_iconstate = "muzzle_flash_light"
	icon_state = "smg"
	fire_sound = 'sound/mecha/weapons/mech_smg.ogg'
	can_equip = TRUE
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,30), "S" = list(-2,12), "E" = list(54,14), "W" = list(-20,34)),
		MECHA_L_ARM = list("N" = list(-4,30), "S" = list(32,12), "E" = list(52,34), "W" = list(-22,14)),
	)
	ammotype = /datum/ammo/bullet/smg/mech
	max_integrity = 400
	projectiles = 60
	projectiles_cache = 900
	projectiles_cache_max = 900
	variance = 20
	projectile_delay = 0.15 SECONDS
	slowdown = 0.15
	ammo_type = MECHA_AMMO_SMG
	hud_icons = list("smg", "smg_empty")
	fire_mode = GUN_FIREMODE_AUTOMATIC

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/burstrifle
	name = "\improper 忒堤斯连发步枪"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "中型机甲突击武器.与克洛诺斯突击步枪相似,但以连发方式射击."
	icon_state = "burstrifle"
	fire_sound = 'sound/mecha/weapons/mech_rifle.ogg'
	can_equip = TRUE
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,30), "S" = list(-2,-6), "E" = list(64,17), "W" = list(-33,37)),
		MECHA_L_ARM = list("N" = list(-4,30), "S" = list(32,-6), "E" = list(63,37), "W" = list(-34,17)),
	)
	ammotype = /datum/ammo/bullet/rifle/mech/burst
	max_integrity = 400
	projectiles = 72
	projectiles_cache = 720
	projectiles_cache_max = 720
	variance = 15
	projectile_delay = 0.6 SECONDS
	burst_amount = 3
	projectile_burst_delay = 0.2 SECONDS
	slowdown = 0.25
	ammo_type = MECHA_AMMO_BURSTRIFLE
	hud_icons = list("hivelo", "hivelo_empty")
	fire_mode = GUN_FIREMODE_AUTOBURST

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/assault_rifle
	name = "\improper 克洛诺斯突击步枪"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "TGMC机甲部队的标准超大型多用途步枪."
	icon_state = "assaultrifle"
	fire_sound = 'sound/mecha/weapons/mech_rifle.ogg'
	can_equip = TRUE
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,30), "S" = list(-2,-6), "E" = list(64,17), "W" = list(-34,37)),
		MECHA_L_ARM = list("N" = list(-4,30), "S" = list(32,-6), "E" = list(64,37), "W" = list(-34,17)),
	)
	ammotype = /datum/ammo/bullet/rifle/mech
	max_integrity = 400
	projectiles = 80
	projectiles_cache = 960
	projectiles_cache_max = 960
	variance = 15
	projectile_delay = 0.2 SECONDS
	slowdown = 0.2
	ammo_type = MECHA_AMMO_RIFLE
	hud_icons = list("rifle", "rifle_empty")
	fire_mode = GUN_FIREMODE_AUTOMATIC

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/shotgun
	name = "\improper 菲比霰弹枪"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "TGMC的经典武器,但更大更好!发射超大号鹿弹,在近距离战斗中造成高伤害."
	icon_state = "shotgun"
	fire_sound = 'sound/mecha/weapons/mech_shotgun.ogg'
	can_equip = TRUE
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,30), "S" = list(-2,-4), "E" = list(61,16), "W" = list(-31,36)),
		MECHA_L_ARM = list("N" = list(-4,30), "S" = list(32,-4), "E" = list(61,36), "W" = list(-31,16)),
	)
	ammotype = /datum/ammo/bullet/shotgun/mech
	max_integrity = 350
	projectiles = 10
	projectiles_cache = 120
	projectiles_cache_max = 120
	variance = 6
	projectile_delay = 2.0 SECONDS
	slowdown = 0.3
	ammo_type = MECHA_AMMO_SHOTGUN
	hud_icons = list("shotgun_buckshot", "shotgun_empty")
	fire_mode = GUN_FIREMODE_SEMIAUTO

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/greyscale_lmg
	name = "\improper 布里阿瑞俄斯轻机枪"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "一坨巨大的金属块,发射基础流血轻机枪弹.和标准轻机枪一样,但更大,更好,更重."
	icon_state = "lmg"
	fire_sound = 'sound/mecha/weapons/mech_lmg.ogg'
	can_equip = TRUE
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,30), "S" = list(-2,-6), "E" = list(64,17), "W" = list(-34,37)),
		MECHA_L_ARM = list("N" = list(-4,30), "S" = list(32,-6), "E" = list(64,37), "W" = list(-34,17)),
	)
	ammotype = /datum/ammo/bullet/rifle/mech/lmg
	max_integrity = 400
	projectiles = 120
	projectiles_cache = 1200
	projectiles_cache_max = 1200
	variance = 25
	projectile_delay = 0.15 SECONDS
	slowdown = 0.3
	ammo_type = MECHA_AMMO_GREY_LMG
	hud_icons = list("rifle_heavy", "rifle_empty")
	fire_mode = GUN_FIREMODE_AUTOMATIC

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/light_cannon
	name = "\improper 勒托轻型自动炮"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "一种弹鼓供弹的自动炮,发射在子弹撞击时向前方锥形区域爆裂的破片弹.对成群的敌人格外有效."
	icon_state = "lightcannon"
	fire_sound = 'sound/mecha/weapons/mech_light_cannon.ogg'
	can_equip = TRUE
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,30), "S" = list(-2,-15), "E" = list(80,4), "W" = list(-50,24)),
		MECHA_L_ARM = list("N" = list(-4,30), "S" = list(32,-15), "E" = list(80,24), "W" = list(-50,4)),
	)
	ammotype = /datum/ammo/tx54/mech
	max_integrity = 400
	projectiles = 30
	projectiles_cache = 300
	projectiles_cache_max = 300
	variance = 20
	projectile_delay = 0.7 SECONDS
	slowdown = 0.4
	ammo_type = MECHA_AMMO_LIGHTCANNON
	hud_icons = list("grenade_airburst", "grenade_empty")
	fire_mode = GUN_FIREMODE_AUTOMATIC

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser_rifle
	name = "\improper 埃该翁激光步枪"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "标准机甲激光步枪.不需要补充弹药,发射立即命中的高精准度激光,但与同类武器相比伤害略低."
	icon_state = "lasermg"
	fire_sound = 'sound/mecha/weapons/mech_laser_heavy.ogg'
	can_equip = TRUE
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(33,68), "S" = list(-2,-6), "E" = list(80,13), "W" = list(-50,33)),
		MECHA_L_ARM = list("N" = list(0,68), "S" = list(32,-6), "E" = list(80,33), "W" = list(-50,13)),
	)
	ammotype = /datum/ammo/energy/lasgun/marine/mech
	max_integrity = 400
	energy_drain = 10
	variance = 0
	projectile_delay = 0.4 SECONDS
	slowdown = 0.4
	fire_mode = GUN_FIREMODE_AUTOMATIC

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser_projector
	name = "\improper 古革斯激光投射器"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "一种激光投射器,能够连发射击.不需要补充弹药,发射立即命中的高精准度激光,但与同类武器相比伤害略低."
	icon_state = "laserrifle"
	fire_sound = 'sound/mecha/weapons/mech_laser_heavy.ogg'
	can_equip = TRUE
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(33,52), "S" = list(-2,-6), "E" = list(75,11), "W" = list(-45,31)),
		MECHA_L_ARM = list("N" = list(0,52), "S" = list(32,-6), "E" = list(75,31), "W" = list(-45,11)),
	)
	ammotype = /datum/ammo/energy/lasgun/marine/mech/burst
	max_integrity = 400
	energy_drain = 5
	variance = 0
	projectile_delay = 0.6 SECONDS
	burst_amount = 3
	projectile_burst_delay = 0.2 SECONDS
	slowdown = 0.4
	fire_mode = GUN_FIREMODE_AUTOBURST

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser_smg
	name = "\improper 谟涅摩叙涅激光冲锋枪"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "标准机甲激光冲锋枪.不需要补充弹药,发射立即命中的高精准度激光,但与同类武器相比伤害略低.比激光步枪更具机动性."
	icon_state = "lasersmg"
	fire_sound = 'sound/mecha/weapons/mech_laser_light.ogg'
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(33,48), "S" = list(-2,6), "E" = list(67,11), "W" = list(-37,31)),
		MECHA_L_ARM = list("N" = list(0,48), "S" = list(32,6), "E" = list(67,31), "W" = list(-37,11)),
	)
	can_equip = TRUE
	ammotype = /datum/ammo/energy/lasgun/marine/mech/smg
	max_integrity = 400
	energy_drain = 5
	variance = 0
	projectile_delay = 0.2 SECONDS
	slowdown = 0.2
	fire_mode = GUN_FIREMODE_AUTOMATIC

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/heavy_cannon
	name = "\improper 忒弥斯重型加农炮"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "没有什么比安装在战争机器人上的坦克炮更能表达\"去死吧\"了.尽管每射一发都需要重新装填,但威力巨大."
	icon_state = "heavycannon"
	fire_sound = 'sound/mecha/weapons/mech_heavy_cannon.ogg'
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,48), "S" = list(-1,1), "E" = list(72,32), "W" = list(-42,48)),
		MECHA_L_ARM = list("N" = list(-4,48), "S" = list(33,1), "E" = list(72,48), "W" = list(-42,32)),
	)
	can_equip = TRUE
	ammotype = /datum/ammo/bullet/apfsds
	max_integrity = 400
	projectiles = 1
	projectiles_cache = 15
	projectiles_cache_max = 15
	variance = 0
	projectile_delay = 1 SECONDS
	slowdown = 1.2
	ammo_type = MECHA_AMMO_HEAVYCANNON
	hud_icons = list("shell_apcr", "shell_empty")
	fire_mode = GUN_FIREMODE_SEMIAUTO

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/minigun
	name = "\improper 瑞亚火神炮"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "当你可以躲在弹雨后面时,机动性就不需要了!开火前需要预热."
	icon_state = "minigun"
	fire_sound = 'sound/mecha/weapons/mech_minigun.ogg'
	windup_sound = 'sound/weapons/guns/fire/tank_minigun_start.ogg'
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(35,60), "S" = list(-2,-11), "E" = list(64,0), "W" = list(-34,20)),
		MECHA_L_ARM = list("N" = list(-2,60), "S" = list(32,-11), "E" = list(64,20), "W" = list(-34,0)),
	)
	can_equip = TRUE
	ammotype = /datum/ammo/bullet/minigun/mech
	max_integrity = 400
	projectiles = 200
	projectiles_cache = 800
	projectiles_cache_max = 800
	variance = 35
	projectile_delay = 1.5
	slowdown = 0.7
	windup_delay = 0.5 SECONDS
	ammo_type = MECHA_AMMO_MINIGUN
	hud_icons = list("smartgun", "smartgun_empty")
	fire_mode = GUN_FIREMODE_AUTOMATIC

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/sniper
	name = "\improper 俄刻阿诺斯狙击步枪"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "一种只能由机甲使用的反坦克步枪.最初设计用于对抗小型装甲车辆,但对付体型相近的生物也同样有效.具有敌我识别."
	icon_state = "sniper"
	fire_sound = 'sound/mecha/weapons/mech_sniper.ogg'
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,30), "S" = list(-2,-14), "E" = list(80,0), "W" = list(-50,22)),
		MECHA_L_ARM = list("N" = list(-4,30), "S" = list(32,-14), "E" = list(80,22), "W" = list(-50,0)),
	)
	can_equip = TRUE
	ammotype = /datum/ammo/bullet/sniper/mech
	max_integrity = 200
	projectiles = 15
	projectiles_cache = 90
	projectiles_cache_max = 90
	variance = -15
	projectile_delay = 1 SECONDS
	slowdown = 0.6
	ammo_type = MECHA_AMMO_SNIPER
	hud_icons = list("sniper_supersonic", "sniper_empty")
	fire_mode = GUN_FIREMODE_SEMIAUTO

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/grenadelauncher
	name = "\improper 许珀里翁榴弹发射器"
	desc = "TGMC对于更大的爆炸是否更好这一问题的明确答案.发射标准HEDP榴弹."
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	icon_state = "grenadelauncher"
	fire_sound = 'sound/weapons/guns/fire/grenadelauncher.ogg'
	can_equip = TRUE
	ammotype = /obj/item/explosive/grenade
	max_integrity = 350
	projectiles = 10
	projectiles_cache = 40
	projectiles_cache_max = 40
	projectile_delay = 1.5 SECONDS
	missile_speed = 1.5
	equip_cooldown = 2 SECONDS
	slowdown = 0.4
	ammo_type = MECHA_AMMO_GRENADE
	hud_icons = list("grenade_he", "grenade_empty")
	fire_mode = GUN_FIREMODE_SEMIAUTO

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/grenadelauncher/proj_init(obj/item/explosive/grenade/nade, mob/user)
	var/turf/T = get_turf(src)
	log_game("[key_name(user)] fired a [nade] in [AREACOORD(T)]")
	nade.det_time = min(1 SECONDS, nade.det_time)
	nade.launched = TRUE
	nade.activate(user)
	nade.throwforce += nade.launchforce

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/flamethrower
	name = "\improper 赫利俄斯火焰喷射器"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "一种专为机甲安装的火焰喷射器.机动性差,但额外的凝固汽油弹完全弥补了这一点."
	icon_state = "flamer"
	fire_sound = 'sound/mecha/weapons/mech_flamer.ogg'
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,30), "S" = list(-2,-11), "E" = list(77,3), "W" = list(-47,23)),
		MECHA_L_ARM = list("N" = list(-4,30), "S" = list(32,-11), "E" = list(77,23), "W" = list(-47,3)),
	)
	can_equip = TRUE
	ammotype = /datum/ammo/flamethrower/mech_flamer
	max_integrity = 250
	projectiles = 20
	projectiles_cache = 20 // low ammo counts so player cant just spam fire while rushing infinitely
	projectiles_cache_max = 20
	variance = 0
	projectile_delay = 2 SECONDS
	slowdown = 0.4
	ammo_type = MECHA_AMMO_FLAMER
	hud_icons = list("flame", "flame_empty")
	fire_mode = GUN_FIREMODE_SEMIAUTO

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/rpg
	name = "\improper 伊阿珀托斯导弹舱"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "一种机甲导弹舱.备用弹药不多,需要频繁进行外部补给.但是嘿,一路爆炸的导弹!"
	icon_state = "rpg"
	fire_sound = 'sound/mecha/weapons/mech_rpg.ogg'
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,48), "S" = list(-1,1), "E" = list(56,20), "W" = list(-26,36)),
		MECHA_L_ARM = list("N" = list(-4,48), "S" = list(33,1), "E" = list(56,36), "W" = list(-26,20)),
	)
	can_equip = TRUE
	ammotype = /datum/ammo/rocket/mech
	max_integrity = 400
	projectiles = 1
	projectiles_cache = 1
	projectiles_cache_max = 1
	variance = 0
	projectile_delay = 2 SECONDS
	slowdown = 0.7
	ammo_type = MECHA_AMMO_RPG
	hud_icons = list("rocket_he", "rocket_empty")
	fire_mode = GUN_FIREMODE_SEMIAUTO

//////////////////////////
//NON GUNS BEYOND HERE
//////////////////////////

#define LASER_DASH_RANGE_NORMAL 3
#define LASER_DASH_RANGE_ENHANCED 5

/obj/item/mecha_parts/mecha_equipment/laser_sword
	name = "\improper 月光粒子切割器"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "一种由压缩能量制成的专用机甲激光刀刃,拥有难以想象的力量.其紧凑的尺寸允许快速,短距离的攻击.激活时,会过载腿部执行器向前冲刺,然后用超高温等离子束进行切割.近战核心可增加切割范围和冲刺距离.它是TGMC优秀机甲近战进攻能力系列中的顶级近战武器."
	icon_state = "moonlight"
	can_equip = TRUE
	max_integrity = 400
	slowdown = 0
	equip_cooldown = 3 SECONDS
	energy_drain = 100
	range = MECHA_MELEE|MECHA_RANGED
	force = 150
	/// holder var for the mob that is attacking right now
	var/mob/cutter

/obj/item/mecha_parts/mecha_equipment/laser_sword/action_checks(atom/target, ignore_cooldown)
	. = ..()
	if(!.)
		return
	if(chassis.zoom_mode)
		to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_warning("Unable to dash while in zoom mode!")]")
		return FALSE
	if(cutter)
		to_chat(chassis.occupants, "[icon2html(src, chassis.occupants)][span_warning("Already in use!")]")
		return FALSE

/obj/item/mecha_parts/mecha_equipment/laser_sword/action(mob/source, atom/target, list/modifiers)
	if(!action_checks(target))
		return
	//melee swipe, no need to dash
	if(chassis.Adjacent(target))
		execute_melee(source, modifiers)
		return ..()

	//try dash to target
	var/laser_dash_range = HAS_TRAIT(chassis, TRAIT_MELEE_CORE) ? LASER_DASH_RANGE_ENHANCED : LASER_DASH_RANGE_NORMAL

	chassis.add_filter("dash_blur", 1, radial_blur_filter(0.3))
	icon_state += "_on"
	chassis.update_icon()
	new /obj/effect/temp_visual/after_image(chassis.loc, chassis)
	RegisterSignal(chassis, COMSIG_MOVABLE_POST_THROW, PROC_REF(end_dash))
	cutter = source
	chassis.atom_flags |= DIRLOCK
	RegisterSignal(chassis, COMSIG_MOVABLE_MOVED, PROC_REF(drop_afterimage))
	RegisterSignal(chassis, COMSIG_MOVABLE_BUMP, PROC_REF(on_bump))
	chassis.throw_at(target, laser_dash_range, 1)
	return ..()

///signal handler, drops afterimage every move executed while dashing
/obj/item/mecha_parts/mecha_equipment/laser_sword/proc/drop_afterimage(datum/source)
	SIGNAL_HANDLER
	new /obj/effect/temp_visual/after_image(chassis.loc, chassis)

///Wrapper for mob bump attacks mid lunge
/obj/item/mecha_parts/mecha_equipment/laser_sword/proc/on_bump(datum/source, atom/bumped)
	SIGNAL_HANDLER
	if(!ismob(bumped))
		return
	INVOKE_ASYNC(src, PROC_REF(do_bump_attack), bumped)
	return COMPONENT_BUMP_RESOLVED

///Hits a mob in the way
/obj/item/mecha_parts/mecha_equipment/laser_sword/proc/do_bump_attack(mob/living/bumped_mob)
	bumped_mob.attackby(src, cutter)

///Ends dash and executes attack
/obj/item/mecha_parts/mecha_equipment/laser_sword/proc/end_dash(datum/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, list(COMSIG_MOVABLE_POST_THROW, COMSIG_MOVABLE_MOVED, COMSIG_MOVABLE_BUMP))
	chassis.remove_filter("dash_blur")
	icon_state = initial(icon_state)
	chassis.update_icon()
	execute_melee(cutter)
	cutter = null
	chassis.atom_flags &= ~DIRLOCK

///executes a melee attack in the direction that the mech is facing
/obj/item/mecha_parts/mecha_equipment/laser_sword/proc/execute_melee(mob/source, list/modifiers)
	var/list/turf/targets
	if(HAS_TRAIT(chassis, TRAIT_MELEE_CORE))
		targets = list(get_step(chassis, chassis.dir), get_step(chassis, turn(chassis.dir, 45)), get_step(chassis, turn(chassis.dir, -45)))
	else
		targets = list(get_step(chassis, chassis.dir))
	if(!targets[1])
		return
	playsound(chassis, 'sound/mecha/weapons/laser_sword.ogg', 30)

	var/old_intent = source.a_intent
	source.a_intent = INTENT_HARM
	for(var/turf/target AS in targets)
		chassis.do_attack_animation(target, ATTACK_EFFECT_LASERSWORD)
		for(var/atom/movable/slashed AS in target)
			slashed.attackby(src, source, list2params(modifiers))
	source.a_intent = old_intent

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser_spear
	name = "\improper 阳光粒子穿刺枪"
	desc = "一种为TGMC战斗机甲制造的压缩能量长矛.一种用于中短距离强力防御的近战武器.激活时伸出一根超高温等离子长矛,刺穿路径上的一切.近战核心将同时增加其范围和威力.它是TGMC优秀机甲近战进攻能力系列中的顶级近战武器."
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	icon_state = "lance"
	fire_sound = 'sound/mecha/weapons/laser_sword.ogg'
	windup_sound = 'sound/weapons/guns/fire/tank_minigun_start.OGG'
	can_equip = TRUE
	ammotype = /datum/ammo/energy/lasgun/marine/mech/lance_strike
	max_integrity = 400
	slowdown = 0.15
	windup_delay = 0.6 SECONDS
	projectile_delay = 3 SECONDS
	energy_drain = 100
	variance = 0
	range = MECHA_MELEE|MECHA_RANGED
	muzzle_iconstate = null
	muzzle_flash_color = COLOR_PULSE_BLUE
	fire_mode = GUN_FIREMODE_SEMIAUTO

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser_spear/action_checks(mob/source, atom/target, list/modifiers)
	. = ..()
	if(!.)
		return FALSE
	ammotype = HAS_TRAIT(chassis, TRAIT_MELEE_CORE) ? /datum/ammo/energy/lasgun/marine/mech/lance_strike/super : /datum/ammo/energy/lasgun/marine/mech/lance_strike
