/*
This file contains:

Sniper rifles
Miniguns
Pepperball gun
Rocket launchers

*/


/*-------------------------------------------------------
SNIPER RIFLES
Keyword rifles. They are subtype of rifles, but still contained here as a specialist weapon.

Because this parent type did not exist
Note that this means that snipers will have a slowdown of 3, due to the scope
*/
/obj/item/weapon/gun/rifle/sniper
	aim_slowdown = 1
	gun_skill_category = SKILL_RIFLES
	wield_delay = 1.2 SECONDS

//Pow! Headshot

/obj/item/weapon/gun/rifle/sniper/antimaterial
	name = "\improper SR-26瞄准镜步枪"
	desc = "SR-26是一种具备IFF能力的狙击步枪,主要由远程射手使用.它在远距离战斗情况和支持狙击方面表现出色.它安装了激光指示器,瞄准镜本身集成了IFF.使用专门制造的10x28无壳弹,以配合该枪奇特的IFF瞄准镜系统.\nIt具有集成的目标标记器和激光瞄准系统.\n\"以优势火力促和平\"."
	icon = 'icons/obj/items/gun/marksman64.dmi'
	icon_state = "t26"
	worn_icon_state = "t26"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/marksman_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/marksman_righthand_1.dmi',
	)
	max_shells = 15 //codex
	caliber = CALIBER_10X28
	fire_sound = 'sound/weapons/guns/fire/sniper.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/sniper_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/sniper_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/sniper_reload.ogg'
	default_ammo_type = /obj/item/ammo_magazine/sniper
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/sniper/incendiary,
		/obj/item/ammo_magazine/sniper/flak,
	)
	force = 12
	wield_delay = 1.4 SECONDS
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 20, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
	attachable_allowed = list(
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/scope/antimaterial,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/sniperbarrel,
		/obj/item/attachable/scope/pmc,
		/obj/item/attachable/shoulder_mount,
	)
	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	starting_attachment_types = list(/obj/item/attachable/scope/antimaterial, /obj/item/attachable/sniperbarrel)

	fire_delay = 2.5 SECONDS
	burst_amount = 1
	accuracy_mult = 1.1
	recoil = 2
	scatter = 0
	movement_acc_penalty_mult = 8

	placed_overlay_iconstate = "antimat"
	var/targetmarker_on = FALSE
	var/targetmarker_primed = FALSE
	var/mob/living/carbon/laser_target = null
	var/obj/item/binoculars/tactical/integrated_laze = null

/obj/item/weapon/gun/rifle/sniper/antimaterial/Initialize(mapload)
	. = ..()
	integrated_laze = new(src)

/obj/item/weapon/gun/rifle/sniper/antimaterial/do_fire(obj/object_to_fire)
	if(targetmarker_primed)
		if(!iscarbon(target))
			return
		if(laser_target)
			deactivate_laser_target()
		if(target.apply_laser())
			activate_laser_target(target, gun_user)
		return
	if(!QDELETED(laser_target))
		target = laser_target
	return ..()
/*
 * This override exists due to the fact the mouseup signal calls start_fire()
 * which tries to get a turf from the clickcatcher, which ends up with the COMSIG_QDELETING signal
 * getting registered on that turf, which we do not care about if we are lazing.
 * The issue with this is that the signal gets registered to the turf and then gets overriden
 * if the gun user ever clicks that turf again (also leaves hanging signals because they dont unregister)
 * Shouldn't mess with reset_fire
*/
/obj/item/weapon/gun/rifle/sniper/antimaterial/set_target(atom/object)
	if(laser_target)
		return ..(laser_target)
	return ..()

/obj/item/weapon/gun/rifle/sniper/antimaterial/do_fire(obj/object_to_fire)
	if(laser_target)
		var/atom/movable/projectile/projectile_to_fire = object_to_fire
		projectile_to_fire.projectile_behavior_flags |= PROJECTILE_PRECISE_TARGET
	return ..()

/obj/item/weapon/gun/rifle/sniper/antimaterial/InterceptClickOn(mob/user, params, atom/object)
	var/list/pa = params2list(params)
	if(!pa.Find("ctrl"))
		return FALSE
	integrated_laze.acquire_target(object, user)
	return TRUE


/atom/proc/apply_laser()
	return FALSE

/mob/living/carbon/apply_laser()
	overlays_standing[LASER_LAYER] = image('icons/obj/items/projectiles.dmi', icon_state = "sniper_laser", layer =-LASER_LAYER)
	apply_overlay(LASER_LAYER)
	return TRUE

/mob/living/carbon/proc/remove_laser()
	return FALSE

/mob/living/carbon/remove_laser()
	remove_overlay(LASER_LAYER)
	return TRUE

/obj/item/weapon/gun/rifle/sniper/antimaterial/unique_action(mob/user)
	if(!targetmarker_primed && !targetmarker_on)
		return laser_on(user)
	return laser_off(user)

/obj/item/weapon/gun/rifle/sniper/antimaterial/Destroy()
	laser_off()
	QDEL_NULL(integrated_laze)
	return ..()

/obj/item/weapon/gun/rifle/sniper/antimaterial/dropped()
	laser_off()
	return ..()

/obj/item/weapon/gun/rifle/sniper/antimaterial/process()
	var/obj/item/attachable/scope = LAZYACCESS(attachments_by_slot, ATTACHMENT_SLOT_RAIL)
	if(!scope.zoom)
		laser_off()
		return
	var/mob/living/user = loc
	if(!istype(user))
		laser_off()
		return
	if(laser_target && !line_of_sight(user, laser_target, 24))
		laser_off()
		to_chat(user, span_danger("你失去了目标的视野!"))
		playsound(user,'sound/machines/click.ogg', 25, 1)

/obj/item/weapon/gun/rifle/sniper/antimaterial/zoom(mob/living/user, tileoffset = 11, viewsize = 12) //tileoffset is client view offset in the direction the user is facing. viewsize is how far out this thing zooms. 7 is normal view
	. = ..()
	var/obj/item/attachable/scope = LAZYACCESS(attachments_by_slot, ATTACHMENT_SLOT_RAIL)
	if(!scope.zoom && (targetmarker_on || targetmarker_primed) )
		laser_off(user)

/obj/item/weapon/gun/rifle/sniper/antimaterial/on_unzoom(mob/user)
	. = ..()
	if(!targetmarker_primed && !laser_target)
		return
	laser_off(user)

/obj/item/weapon/gun/rifle/sniper/antimaterial/proc/activate_laser_target(atom/target, mob/living/user)
	laser_target = target
	to_chat(user, span_danger("你将目标标记器聚焦于[target]!"))
	targetmarker_primed = FALSE
	targetmarker_on = TRUE
	START_PROCESSING(SSobj, src)
	accuracy_mult += 0.50 //We get a big accuracy bonus vs the lasered target

/obj/item/weapon/gun/rifle/sniper/antimaterial/proc/deactivate_laser_target()
	laser_target.remove_laser()
	laser_target = null

/obj/item/weapon/gun/rifle/sniper/antimaterial/proc/laser_on(mob/user)
	var/obj/item/attachable/scope = LAZYACCESS(attachments_by_slot, ATTACHMENT_SLOT_RAIL)
	if(!scope.zoom) //Can only use and prime the laser targeter when zoomed.
		to_chat(user, span_warning("你必须放大才能使用目标标记器!"))
		return TRUE
	targetmarker_primed = TRUE //We prime the target laser
	if(user?.client)
		user.client.click_intercept = src
		to_chat(user, span_notice("<b>你激活目标标记器并仔细瞄准.</b>"))
		playsound(user,'sound/machines/click.ogg', 25, 1)
	return TRUE


/obj/item/weapon/gun/rifle/sniper/antimaterial/proc/laser_off(mob/user)
	SIGNAL_HANDLER
	if(laser_target)
		deactivate_laser_target()
		accuracy_mult -= 0.50 //We lose a big accuracy bonus vs the now unlasered target
		STOP_PROCESSING(SSobj, src)
		targetmarker_on = FALSE
	targetmarker_primed = FALSE
	if(user?.client)
		user.client.click_intercept = null
		to_chat(user, span_notice("<b>你关闭目标标记器.</b>"))
		playsound(user,'sound/machines/click.ogg', 25, 1)
	return TRUE


/obj/item/weapon/gun/rifle/sniper/elite
	name = "\improper SR-42反坦克狙击步枪"
	desc = "来自Nanotrasen的高端磁轨重型狙击步枪,使用可用的最重型弹药,10x99mm无壳弹."
	icon_state = "m42c"
	worn_icon_state = "m42c"
	icon = 'icons/obj/items/gun/marksman.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/marksman_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/marksman_righthand_1.dmi',
	)
	max_shells = 6 //codex
	caliber = CALIBER_10X99
	fire_sound = 'sound/weapons/guns/fire/sniper_heavy.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/sniper_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/sniper_heavy_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/sniper_heavy_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/sniper_heavy_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/sniper/elite
	allowed_ammo_types = list(/obj/item/ammo_magazine/sniper/elite)
	force = 17
	attachable_allowed = list()
	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 15, "rail_y" = 19, "under_x" = 20, "under_y" = 15, "stock_x" = 20, "stock_y" = 15)
	item_map_variant_flags = NONE
	attachable_allowed = list(
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/scope/antimaterial,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/sniperbarrel,
		/obj/item/attachable/scope/pmc,
	)
	starting_attachment_types = list(/obj/item/attachable/scope/pmc, /obj/item/attachable/sniperbarrel)

	fire_delay = 1.5 SECONDS
	accuracy_mult = 1.2
	recoil = 5
	burst_amount = 1
	movement_acc_penalty_mult = 7

//SVD //Based on the Dragunov sniper rifle.

/obj/item/weapon/gun/rifle/sniper/svd
	name = "\improper SR-33德拉贡诺夫狙击步枪"
	desc = "一种半自动狙击步枪,以其精准射击而闻名,并为此从头开始制造.发射7.62x54mmR弹药."
	icon = 'icons/obj/items/gun/marksman64.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/marksman_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/marksman_righthand_64.dmi',
	)
	unique_reskin = list(
		"Red" = "svd_red",
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	icon_state = "svd"
	worn_icon_state = "svd"

	max_shells = 10 //codex
	caliber = CALIBER_762X54 //codex
	fire_sound = SFX_SVD_FIRE
	dry_fire_sound = 'sound/weapons/guns/fire/sniper_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/svd_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/svd_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/svd_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/sniper/svd
	allowed_ammo_types = list(/obj/item/ammo_magazine/sniper/svd)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/slavic,
	)

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17,"rail_x" = 22, "rail_y" = 21, "under_x" = 32, "under_y" = 14, "stock_x" = 20, "stock_y" = 14)
	starting_attachment_types = list(/obj/item/attachable/scope/slavic)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.8 SECONDS
	aim_speed_modifier = 0.75

	fire_delay = 1.2 SECONDS
	burst_amount = 1
	accuracy_mult = 1
	scatter = -5
	recoil = -1
	wield_delay = 2 SECONDS
	movement_acc_penalty_mult = 6

//Based off the XM-8. BR-8 rifle

/obj/item/weapon/gun/rifle/tx8
	name = "\improper BR-8侦察步枪"
	desc ="BR-8是一种轻型专用侦察步枪,主要由轻步兵和侦察兵使用.由于能够使用不同弹药类型,它被设计为可适应不同情况,在所有距离上都能使用.具有IFF.使用专门的超压10x28mm弹药."
	icon = 'icons/obj/items/gun/marksman64.dmi'
	icon_state = "tx8"
	worn_icon_state = "tx8"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/marksman_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/marksman_righthand_1.dmi',
	)
	max_shells = 25 //codex
	muzzleflash_iconstate = "muzzle_flash_medium"
	caliber = CALIBER_10X28_CASELESS //codex
	fire_sound = 'sound/weapons/guns/fire/t64.ogg'
	unload_sound = 'sound/weapons/guns/interact/m4ra_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m4ra_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/m4ra_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/tx8
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/tx8,
		/obj/item/ammo_magazine/rifle/tx8/incendiary,
		/obj/item/ammo_magazine/rifle/tx8/impact,
	)
	force = 16
	aim_slowdown = 0.45
	attachable_allowed = list(
		/obj/item/attachable/reddot,
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
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/angledgrip,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
	)

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	gun_skill_category = SKILL_FIREARMS
	attachable_offset = list("muzzle_x" = 44, "muzzle_y" = 18,"rail_x" = 18, "rail_y" = 24, "under_x" = 31, "under_y" = 15, "stock_x" = 24, "stock_y" = 13)


	fire_delay = 0.4 SECONDS
	burst_amount = 1
	accuracy_mult = 1.2
	scatter = -3

/obj/item/weapon/gun/rifle/tx8/scout
	starting_attachment_types = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/verticalgrip,
	)

//-------------------------------------------------------
// MINIGUN

/obj/item/weapon/gun/minigun
	name = "\improper MG-100维护者转轮机枪"
	desc = "一种六管旋转机枪,单兵便携火力的终极之选.能够倾泻稳定的高速穿甲弹流.尽量不要用它杀死你所有的朋友."
	icon = 'icons/obj/items/gun/machinegun64.dmi'
	icon_state = "minigun"
	worn_icon_state = "minigun"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/machinegun_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/machinegun_righthand_1.dmi',
	)
	fire_animation = "minigun_fire"
	max_shells = 600 //codex
	caliber = CALIBER_762X51 //codex
	load_method = MAGAZINE //codex
	fire_sound = 'sound/weapons/guns/fire/minigun.ogg'
	unload_sound = 'sound/weapons/guns/interact/minigun_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/minigun_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/minigun_cocked.ogg'
	default_ammo_type = null
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/minigun_powerpack,
		/obj/item/ammo_magazine/minigun_powerpack/fancy,
		/obj/item/ammo_magazine/minigun_powerpack/merc,
	)
	w_class = WEIGHT_CLASS_HUGE
	force = 20
	wield_delay = 1.4 SECONDS
	gun_skill_category = SKILL_FIREARMS
	aim_slowdown = 0.8
	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	attachable_allowed = list(/obj/item/attachable/flashlight, /obj/item/attachable/magnetic_harness)
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 21, "under_x" = 24, "under_y" = 14, "stock_x" = 24, "stock_y" = 12)
	aim_fire_delay = 0.1 SECONDS
	aim_speed_modifier = 12

	fire_delay = 0.10 SECONDS
	windup_delay = 0.4 SECONDS
	windup_sound = 'sound/weapons/guns/fire/tank_minigun_start.ogg'
	scatter = 5
	recoil_unwielded = 4
	damage_falloff_mult = 0.5
	movement_acc_penalty_mult = 4

	item_flags = TWOHANDED|AUTOBALANCE_CHECK

/obj/item/weapon/gun/minigun/Initialize(mapload)
	. = ..()
	if(item_flags & AUTOBALANCE_CHECK)
		SSmonitor.stats.miniguns_in_use += src

/obj/item/weapon/gun/minigun/Destroy()
	if(item_flags & AUTOBALANCE_CHECK)
		SSmonitor.stats.miniguns_in_use -= src
	return ..()

/obj/item/weapon/gun/minigun/magharness
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness)

/obj/item/weapon/gun/minigun/valhalla
	item_flags = TWOHANDED

//A minigun that requires only one hand. Meant for use with vehicles
/obj/item/weapon/gun/minigun/one_handed
	name = "\improper 改装MG-100维护者转轮机枪"
	desc = "一把被改装为可单手使用的转轮机枪.旨在用于安装在载具上."

	max_shells = 1000 //codex
	reload_sound = 'sound/weapons/guns/interact/working_the_bolt.ogg'
	default_ammo_type = /obj/item/ammo_magazine/minigun_wheelchair
	allowed_ammo_types = list(/obj/item/ammo_magazine/minigun_wheelchair)
	obj_flags = NONE	//Do not affect autobalance
	item_flags = NONE	//To remove wielding
	equip_slot_flags = NONE
	gun_features_flags = GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	reciever_flags = AMMO_RECIEVER_CYCLE_ONLY_BEFORE_FIRE|AMMO_RECIEVER_MAGAZINES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	actions_types = list()
	attachable_allowed = list()

	recoil = 0
	recoil_unwielded = 0

	windup_delay = 0.7 SECONDS
	movement_acc_penalty_mult = 0

//So that it displays the minigun on the mob as if always wielded
/obj/item/weapon/gun/minigun/one_handed/update_worn_icon_state()
	worn_icon_state = "[base_gun_icon]_w"

// SG minigun

/obj/item/weapon/gun/minigun/smart_minigun
	name = "\improper SG-85智能手持加特林机枪"
	desc = "作为提供支援压制火力的真正怪物,SG-85是TGMC具备IFF能力的转轮机枪,用于重型火力支援任务.拥有比任何其他手持武器都更高的射速.它使用10x26无壳弹."
	icon_state = "minigun_sg"
	worn_icon_state = "minigun_sg"
	fire_animation = "minigun_sg_fire"
	max_shells = 2000 //codex
	caliber = CALIBER_10X26_CASELESS //codex
	allowed_ammo_types = list(/obj/item/ammo_magazine/minigun_powerpack/smartgun)
	wield_delay = 1.7 SECONDS
	gun_features_flags = GUN_AMMO_COUNTER|GUN_WIELDED_FIRING_ONLY|GUN_SMOKE_PARTICLES
	gun_skill_category = SKILL_SMARTGUN
	attachable_allowed = list(/obj/item/attachable/flashlight, /obj/item/attachable/magnetic_harness, /obj/item/attachable/motiondetector)
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 19,"rail_x" = 19, "rail_y" = 29, "under_x" = 24, "under_y" = 14, "stock_x" = 24, "stock_y" = 12) //Only has rail attachments so only the rail variables are properly aligned
	aim_slowdown = 1.2
	actions_types = list()

	fire_delay = 0.1 SECONDS
	scatter = -5
	recoil_unwielded = 4

	item_flags = TWOHANDED

/obj/item/weapon/gun/minigun/smart_minigun/motion_detector
	starting_attachment_types = list(/obj/item/attachable/motiondetector)

// PEPPERBALL GUN

//-------------------------------------------------------
//PB-12

/obj/item/weapon/gun/rifle/pepperball
	name = "\improper PB-12胡椒球枪"
	desc = "PB-12表面上是TGMC使用的防暴装置,颜色鲜亮,通过SAN球发送短效中和化学物质来击倒目标或削弱他们.保证对几乎一切有效.使用SAN球容器作为弹匣."
	icon = 'icons/obj/items/gun/special64.dmi'
	icon_state = "pepperball"
	worn_icon_state = "pepperball"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/special_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/special_righthand_1.dmi',
	)
	equip_slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	max_shells = 100 //codex
	caliber = CALIBER_PEPPERBALL
	fire_sound = SFX_GUN_FB12 // idk why i called it "fb-12", ah too late now
	default_ammo_type = /obj/item/ammo_magazine/rifle/pepperball
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/pepperball)
	wield_delay = 0.7 SECONDS
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 20, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
	attachable_allowed = list(
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/flashlight,
		/obj/item/weapon/gun/flamer/hydro_cannon/pepperball,
		/obj/item/attachable/magnetic_harness,
	) // One

	starting_attachment_types = list(/obj/item/weapon/gun/flamer/hydro_cannon/pepperball)

	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	//actions_types = list(/datum/action/item_action/aim_mode) // RUTGMC DELETION
	aim_fire_delay = 0.1 SECONDS
	aim_speed_modifier = 0.1

	gun_features_flags = GUN_AMMO_COUNTER

	fire_delay = 0.1 SECONDS
	burst_amount = 1
	accuracy_mult = 1
	accuracy_mult_unwielded = 0.75
	scatter = -1
	scatter_unwielded = 2

	placed_overlay_iconstate = "pepper"

/obj/item/weapon/gun/flamer/hydro_cannon/pepperball
	name = "同轴水炮"
	desc = "用于扑灭不幸的错误."
	icon_state = "hydrocannon_pepper"

/obj/item/weapon/gun/rifle/pepperball/pepperball_mini
	name = "迷你胡椒球枪"
	desc = "PB-12胡椒球枪的可附加版本.它具有较小的弹匣容量和较慢的射速."
	icon_state = "pepperball_mini"
	slot = ATTACHMENT_SLOT_UNDER
	max_shells = 20
	default_ammo_type = /obj/item/ammo_magazine/rifle/pepperball/pepperball_mini
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/pepperball/pepperball_mini)
	force = 5
	attachable_allowed = list()
	starting_attachment_types = list()
	actions_types = list()
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	gun_features_flags = GUN_IS_ATTACHMENT | GUN_WIELDED_FIRING_ONLY | GUN_ATTACHMENT_FIRE_ONLY | GUN_AMMO_COUNTER
	fire_delay = 0.2 SECONDS
	attach_delay = 3 SECONDS
	detach_delay = 3 SECONDS
	pixel_shift_x = 18
	pixel_shift_y = 16

	wield_delay_mod = 0.2 SECONDS

/particles/backblast
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	width = 500
	height = 500
	count = 100
	spawning = 100
	lifespan = 0.7 SECONDS
	fade = 8 SECONDS
	grow = 0.1
	drift = generator(GEN_CIRCLE, 0, 5)
	scale = 0.3
	spin = generator(GEN_NUM, -20, 20)
	velocity = list(50, 0)
	friction = generator(GEN_NUM, 0.1, 0.5)

//-------------------------------------------------------
//M5 RPG

/obj/item/weapon/gun/launcher
	icon = 'icons/obj/items/gun/special.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/special_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/special_righthand_1.dmi',
	)

/obj/item/weapon/gun/launcher/rocket
	name = "\improper RL-5火箭发射器"
	desc = "RL-5是银河系周围使用的主要反装甲武器.用于摧毁轻型坦克和敌方建筑,RL-5火箭发射器是一种具有多种战斗用途的危险武器.使用多种84mm火箭弹."
	icon_state = "m5"
	worn_icon_state = "m5"
	max_shells = 1 //codex
	caliber = CALIBER_84MM //codex
	load_method = SINGLE_CASING //codex
	default_ammo_type = /obj/item/ammo_magazine/rocket
	allowed_ammo_types = list(/obj/item/ammo_magazine/rocket)
	equip_slot_flags = NONE
	w_class = WEIGHT_CLASS_HUGE
	force = 15
	wield_delay = 1.4 SECONDS
	wield_penalty = 1.6 SECONDS
	aim_slowdown = 1.75
	general_codex_key = "explosive weapons"
	attachable_allowed = list(
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
	)

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_AUTO_EJECT|AMMO_RECIEVER_AUTO_EJECT_LOCKED
	gun_skill_category = SKILL_FIREARMS
	fire_sound = 'sound/weapons/guns/fire/launcher.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/launcher_empty.ogg'
	reload_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'
	unload_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 6, "rail_y" = 19, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
	fire_delay = 1 SECONDS
	recoil = 1
	scatter = -100
	placed_overlay_iconstate = "sadar"
	windup_delay = 0.4 SECONDS
	///removes backblast damage if false
	var/backblastdamage = TRUE

//Adding in the rocket backblast. The tile behind the specialist gets blasted hard enough to down and slightly wound anyone
/obj/item/weapon/gun/launcher/rocket/apply_gun_modifiers(atom/movable/projectile/projectile_to_fire, atom/target)
	. = ..()
	var/turf/blast_source = get_turf(src)
	var/thrown_dir = REVERSE_DIR(get_dir(blast_source, target))
	var/turf/backblast_loc = get_step(blast_source, thrown_dir)
	var/angle = Get_Angle(loc, target)
	var/x_component = sin(angle) * -30
	var/y_component = cos(angle) * -30
	var/obj/effect/abstract/particle_holder/backblast = new(blast_source, /particles/backblast)
	backblast.particles.velocity = list(x_component, y_component)
	addtimer(VARSET_CALLBACK(backblast.particles, count, 0), 5)
	QDEL_IN(backblast, 0.7 SECONDS)

	if(!backblastdamage)
		return
	for(var/mob/living/carbon/victim in backblast_loc)
		if(victim.lying_angle || victim.stat == DEAD) //Have to be standing up to get the fun stuff
			continue
		victim.adjust_brute_loss(15) //The shockwave hurts, quite a bit. It can knock unarmored targets unconscious in real life
		victim.Paralyze(6 SECONDS) //For good measure
		victim.emote("pain")
		victim.throw_at(get_step(backblast_loc, thrown_dir), 1, 2)


//-------------------------------------------------------
//RL-152 RPG

/obj/item/weapon/gun/launcher/rocket/sadar
	name = "\improper RL-152 SADAR火箭发射器"
	desc = "RL-152是TGMC的主要反装甲武器.用于摧毁轻型坦克和敌方建筑,RL-152火箭发射器是一种具有多种战斗用途的危险武器.使用多种84mm火箭弹."
	icon = 'icons/obj/items/gun/special64.dmi'
	icon_state = "sadar"
	worn_icon_state = "sadar"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/special_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/special_righthand_64.dmi',
		slot_s_store_str = 'icons/mob/suit_slot_64.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	worn_x_dimension = 64
	max_shells = 1
	caliber = CALIBER_84MM
	load_method = SINGLE_CASING
	default_ammo_type = /obj/item/ammo_magazine/rocket/sadar
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rocket/sadar,
		/obj/item/ammo_magazine/rocket/sadar/unguided,
		/obj/item/ammo_magazine/rocket/sadar/ap,
		/obj/item/ammo_magazine/rocket/sadar/wp,
		/obj/item/ammo_magazine/rocket/sadar/wp/unguided,
	)
	equip_slot_flags = NONE
	w_class = WEIGHT_CLASS_HUGE
	force = 15
	wield_delay = 1.4 SECONDS
	wield_penalty = 1.6 SECONDS
	aim_slowdown = 1.75
	general_codex_key = "explosive weapons"
	attachable_allowed = list(
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/buildasentry,
	)

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SHOWS_LOADED|GUN_SMOKE_PARTICLES

	gun_skill_category = SKILL_FIREARMS
	dry_fire_sound = 'sound/weapons/guns/fire/launcher_empty.ogg'
	reload_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'
	unload_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 14, "rail_y" = 21, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)

	fire_delay = 1 SECONDS
	scatter = -100

	item_flags = TWOHANDED|AUTOBALANCE_CHECK

/obj/item/weapon/gun/launcher/rocket/sadar/Initialize(mapload, spawn_empty)
	. = ..()
	if(item_flags & AUTOBALANCE_CHECK)
		SSmonitor.stats.sadar_in_use += src

/obj/item/weapon/gun/launcher/rocket/sadar/Destroy()
	if(item_flags & AUTOBALANCE_CHECK)
		SSmonitor.stats.sadar_in_use -= src
	return ..()

/obj/item/weapon/gun/launcher/rocket/sadar/do_fire(obj/object_to_fire)
	. = ..()
	if(!.)
		return FALSE
	gun_user?.record_war_crime()

/obj/item/weapon/gun/launcher/rocket/sadar/valhalla
	item_flags = TWOHANDED

//-------------------------------------------------------
//M5 RPG'S MEAN FUCKING COUSIN

/obj/item/weapon/gun/launcher/rocket/m57a4
	name = "\improper RL-57A四联温压发射器"
	desc = "RL-57A可能是有史以来制造的最具破坏性的单兵便携武器.它是一种4管导弹发射器,能够连发4枚温压导弹.无需多言."
	icon_state = "m57a4"
	worn_icon_state = "m57a4"
	max_shells = 4 //codex
	caliber = CALIBER_ROCKETARRAY //codex
	load_method = MAGAZINE //codex
	default_ammo_type = /obj/item/ammo_magazine/rocket/m57a4/ds
	allowed_ammo_types = list(/obj/item/ammo_magazine/rocket/m57a4/ds, /obj/item/ammo_magazine/rocket/m57a4)
	aim_slowdown = 2.75
	attachable_allowed = list(
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
	)
	general_codex_key = "explosive weapons"

	fire_delay = 0.6 SECONDS
	burst_delay = 0.4 SECONDS
	burst_amount = 4
	accuracy_mult = 0.8

	placed_overlay_iconstate = "thermo"

/obj/item/weapon/gun/launcher/rocket/m57a4/do_fire(obj/object_to_fire)
	. = ..()
	if(!.)
		return FALSE
	gun_user?.record_war_crime()

/obj/item/weapon/gun/launcher/rocket/m57a4/deathsquad
	attachable_allowed = list(
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/magnetic_harness,
	)
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness)

/obj/item/weapon/gun/launcher/rocket/m57a4/t57
	name = "\improper RL-57四联温压发射器"
	desc = "RL-57可能是最糟糕的单兵武器。它是一种4管导弹发射器,能够连发4枚温压导弹,几乎没有后坐力。无需多言。"
	icon_state = "t57"
	worn_icon_state = "t57"
	default_ammo_type = /obj/item/ammo_magazine/rocket/m57a4
	allowed_ammo_types = list(/obj/item/ammo_magazine/rocket/m57a4)

/obj/item/weapon/gun/launcher/rocket/m57a4/t57/unloaded
	default_ammo_type = null

//-------------------------------------------------------
//RL-160 Recoilless Rifle. Its effectively an RPG codewise.

/obj/item/weapon/gun/launcher/rocket/recoillessrifle
	name = "\improper RL-160无后坐力步枪"
	desc = "RL-160无后坐力步枪是TGMC使用的一种远程爆炸性武器,用于向远距离发射爆炸性炮弹。使用多种67毫米炮弹,设计用于各种用途。"
	icon = 'icons/obj/items/gun/special64.dmi'
	icon_state = "t160"
	worn_icon_state = "t160"
	max_shells = 1 //codex
	caliber = CALIBER_67MM //codex
	load_method = SINGLE_CASING //codex
	default_ammo_type = /obj/item/ammo_magazine/rocket/recoilless
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rocket/recoilless,
		/obj/item/ammo_magazine/rocket/recoilless/light,
		/obj/item/ammo_magazine/rocket/recoilless/low_impact,
		/obj/item/ammo_magazine/rocket/recoilless/smoke,
		/obj/item/ammo_magazine/rocket/recoilless/cloak,
		/obj/item/ammo_magazine/rocket/recoilless/plasmaloss,
		/obj/item/ammo_magazine/rocket/recoilless/heat,
		/obj/item/ammo_magazine/rocket/recoilless/heam,
	)
	equip_slot_flags = NONE
	w_class = WEIGHT_CLASS_HUGE
	force = 15
	wield_delay = 1.2 SECONDS
	wield_penalty = 1.6 SECONDS
	aim_slowdown = 1
	general_codex_key = "explosive weapons"
	attachable_allowed = list(
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
	)

	gun_skill_category = SKILL_FIREARMS
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 15, "rail_y" = 19, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)

	fire_delay = 1 SECONDS
	scatter = -10

/obj/item/weapon/gun/launcher/rocket/recoillessrifle/low_impact
	default_ammo_type = /obj/item/ammo_magazine/rocket/recoilless/low_impact

/obj/item/weapon/gun/launcher/rocket/recoillessrifle/heam
	default_ammo_type = /obj/item/ammo_magazine/rocket/recoilless/heam

//-------------------------------------------------------
//Disposable RPG

/obj/item/weapon/gun/launcher/rocket/oneuse
	name = "\improper RL-72一次性火箭发射器"
	desc = "这是整个银河系广泛使用的主要一次性火箭发射器,无法在战场上重新装填或卸载。这一款发射84毫米爆炸性火箭。按空格键缩短或延长它,分别用于储存或发射。"
	icon = 'icons/obj/items/gun/special64.dmi'
	icon_state = "t72"
	worn_icon_state = "t72"
	max_shells = 1 //codex
	caliber = CALIBER_84MM //codex
	load_method = SINGLE_CASING //codex
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo_type = /obj/item/ammo_magazine/rocket/oneuse
	allowed_ammo_types = list(/obj/item/ammo_magazine/rocket/oneuse)
	reciever_flags = AMMO_RECIEVER_CLOSED|AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_AUTO_EJECT_LOCKED
	equip_slot_flags = ITEM_SLOT_BELT
	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_DEPLOYED_FIRE_ONLY|GUN_SMOKE_PARTICLES
	attachable_allowed = list(/obj/item/attachable/magnetic_harness)
	dry_fire_sound = 'sound/weapons/guns/fire/launcher_empty.ogg'
	reload_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'
	unload_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 6, "rail_y" = 19, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
	fire_delay = 1 SECONDS
	scatter = -100
	/// Indicates extension state of the launcher. True: Fireable and unable to fit in storage. False: Able to fit in storage but must be extended to fire.
	var/extended = FALSE

/obj/item/weapon/gun/launcher/rocket/oneuse/Initialize(mapload, spawn_empty)
	return ..(mapload, FALSE)

// Do a short windup, swap the extension status of the rocket if successful, then swap the flags.
/obj/item/weapon/gun/launcher/rocket/oneuse/unique_action(mob/living/user)
	playsound(user, 'sound/weapons/guns/misc/oneuse_deploy.ogg', 25, 1)
	if(!do_after(user, 20, NONE, src, BUSY_ICON_DANGER))
		return
	extended = !extended
	if(!extended)
		w_class = WEIGHT_CLASS_NORMAL
		gun_features_flags |= GUN_DEPLOYED_FIRE_ONLY
	else
		w_class = WEIGHT_CLASS_BULKY
		gun_features_flags &= ~GUN_DEPLOYED_FIRE_ONLY
	update_icon()

/obj/item/weapon/gun/launcher/rocket/oneuse/update_icon_state()
	. = ..()
	if(extended)
		icon_state = "[base_gun_icon]_extended"
	else
		icon_state = base_gun_icon

/obj/item/weapon/gun/launcher/rocket/oneuse/update_worn_icon_state()
	var/current_state = worn_icon_state

	worn_icon_state = "[base_gun_icon][extended ? "_extended" : ""][item_flags & WIELDED ? "_w" : ""]"

	if(current_state != worn_icon_state && ishuman(gun_user))
		var/mob/living/carbon/human/human_user = gun_user
		if(src == human_user.l_hand)
			human_user.update_inv_l_hand()
		else if (src == human_user.r_hand)
			human_user.update_inv_r_hand()

//SOM RPG
/obj/item/weapon/gun/launcher/rocket/som
	name = "\improper V-71火箭发射器"
	desc = "V-71是SOM使用的单兵便携式火箭推进榴弹发射器。其设计几个世纪以来几乎没有变化,重量轻且制造成本低,同时能够发射多种84毫米火箭,提供出色的战术灵活性。"
	icon = 'icons/obj/items/gun/special64.dmi'
	icon_state = "rpg"
	worn_icon_state = "rpg"
	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SHOWS_LOADED|GUN_SMOKE_PARTICLES
	caliber = CALIBER_84MM //codex
	load_method = MAGAZINE //codex
	default_ammo_type = /obj/item/ammo_magazine/rocket/som
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rocket/som,
		/obj/item/ammo_magazine/rocket/som/light,
		/obj/item/ammo_magazine/rocket/som/rad,
		/obj/item/ammo_magazine/rocket/som/incendiary,
		/obj/item/ammo_magazine/rocket/som/heat,
		/obj/item/ammo_magazine/rocket/som/thermobaric,
	)
	wield_delay = 1.2 SECONDS
	aim_slowdown = 1
	attachable_allowed = list()
	reload_sound = 'sound/weapons/guns/interact/rpg_load.ogg'
	unload_sound = 'sound/weapons/guns/interact/rpg_load.ogg'
	fire_sound = SFX_RPG_FIRE

	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 6, "rail_y" = 19, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)

	windup_delay = 0.6 SECONDS
	scatter = -1
	movement_acc_penalty_mult = 5 //You shouldn't fire this on the move

/obj/item/weapon/gun/launcher/rocket/som/do_fire(obj/object_to_fire)
	. = ..()
	if(!.)
		return FALSE
	if(istype(in_chamber, /obj/item/ammo_magazine/rocket/som/thermobaric || /obj/item/ammo_magazine/rocket/som/rad || /obj/item/ammo_magazine/rocket/som/incendiary))
		gun_user?.record_war_crime()

/obj/item/weapon/gun/launcher/rocket/som/rad
	default_ammo_type = /obj/item/ammo_magazine/rocket/som/rad

/obj/item/weapon/gun/launcher/rocket/som/heat
	default_ammo_type = /obj/item/ammo_magazine/rocket/som/heat

//ICC RPG
/obj/item/weapon/gun/launcher/rocket/icc
	name = "\improper MP-IRL火箭发射器"
	desc = "单兵便携式步兵火箭发射器是ICC使用的单兵便携式弹头发射器。能够发射多种83毫米后装火箭,以紧凑的包装提供出色的战术灵活性。"
	icon = 'icons/obj/items/gun/special64.dmi'
	icon_state = "iccrpg"
	worn_icon_state = "iccrpg"
	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SHOWS_LOADED|GUN_SMOKE_PARTICLES
	caliber = CALIBER_84MM //codex
	load_method = MAGAZINE //codex
	default_ammo_type = /obj/item/ammo_magazine/rocket/icc
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rocket/icc,
		/obj/item/ammo_magazine/rocket/icc/light,
		/obj/item/ammo_magazine/rocket/icc/heat,
		/obj/item/ammo_magazine/rocket/icc/thermobaric,
	)
	wield_delay = 1.2 SECONDS
	aim_slowdown = 1
	attachable_allowed = list()
	reload_sound = 'sound/weapons/guns/interact/rpg_load.ogg'
	unload_sound = 'sound/weapons/guns/interact/rpg_load.ogg'
	fire_sound = SFX_RPG_FIRE

	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 6, "rail_y" = 19, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)

	windup_delay = 0.6 SECONDS
	scatter = -1
	movement_acc_penalty_mult = 5 //You shouldn't fire this on the move

/obj/item/weapon/gun/launcher/rocket/icc/do_fire(obj/object_to_fire)
	. = ..()
	if(!.)
		return FALSE
	if(istype(in_chamber, /obj/item/ammo_magazine/rocket/icc/thermobaric))
		gun_user?.record_war_crime()

//VSD RPG
/obj/item/weapon/gun/launcher/rocket/vsd
	name = "\improper C153肩扛发射器"
	desc = "由Crash Core制造的反人员火箭发射器。主要由V.S.D专家使用,可发射三种专用弹药。高爆弹、燃烧高爆弹和化学覆盖高爆弹。"
	icon = 'icons/obj/items/gun/special64.dmi'
	icon_state = "c153"
	worn_icon_state = "c153"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/special_lefthand_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/special_righthand_64.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SHOWS_LOADED|GUN_SMOKE_PARTICLES
	caliber = CALIBER_84MM //codex
	load_method = MAGAZINE //codex
	default_ammo_type = /obj/item/ammo_magazine/rocket/vsd/he
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rocket/vsd/he,
		/obj/item/ammo_magazine/rocket/vsd/incendiary,
		/obj/item/ammo_magazine/rocket/vsd/chemical,
	)
	wield_delay = 1 SECONDS
	aim_slowdown = 1
	attachable_allowed = list()
	reload_sound = 'sound/weapons/guns/interact/rpg_load.ogg'
	unload_sound = 'sound/weapons/guns/interact/rpg_load.ogg'
	fire_sound = "rpg_fire"

	attachable_offset = list("muzzle_x" = 53, "muzzle_y" = 20, "rail_x" = 44, "rail_y" = 21, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)

	windup_delay = 0.6 SECONDS
	scatter = -1
	movement_acc_penalty_mult = 5 //You shouldn't fire this on the move

/obj/item/weapon/gun/launcher/rocket/vsd/do_fire(obj/object_to_fire)
	. = ..()
	if(!.)
		return FALSE
	if(istype(in_chamber, /obj/item/ammo_magazine/rocket/vsd/incendiary))
		gun_user?.record_war_crime()

//-------------------------------------------------------
//RG-220 Railgun

/obj/item/weapon/gun/rifle/railgun
	name = "\improper RG-220轨道炮"
	desc = "RG-220是一种专用重型轨道炮,旨在击穿硬质装甲以便后续攻击。使用专用罐体进行装填。"
	icon = 'icons/obj/items/gun/special64.dmi'
	icon_state = "railgun"
	worn_icon_state = "railgun"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/special_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/special_righthand_1.dmi',
	)
	max_shells = 3 //codex
	caliber = CALIBER_RAILGUN
	fire_sound = 'sound/weapons/guns/fire/railgun.ogg'
	fire_rattle = 'sound/weapons/guns/fire/railgun.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/sniper_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/sniper_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/sniper_reload.ogg'
	default_ammo_type = /obj/item/ammo_magazine/railgun
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/railgun,
		/obj/item/ammo_magazine/railgun/smart,
		/obj/item/ammo_magazine/railgun/hvap,
	)
	force = 40
	wield_delay = 1.2 SECONDS
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 31, "rail_y" = 23, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
	attachable_allowed = list(
		/obj/item/attachable/magnetic_harness,
	)

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_AMMO_COUNTER
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_AUTO_EJECT|AMMO_RECIEVER_CYCLE_ONLY_BEFORE_FIRE

	fire_delay = 3 SECONDS
	burst_amount = 1
	accuracy_mult = 2
	recoil = 3
	scatter = 0
	movement_acc_penalty_mult = 6

/obj/item/weapon/gun/rifle/railgun/unloaded
	default_ammo_type = null

//-------------------------------------------------------
//ML-120 Coilgun

/obj/item/weapon/gun/rifle/icc_coilgun
	name = "\improper ML-120线圈炮"
	desc = "ML-120线圈炮是ICCAF中最常见的线圈炮,以极高速度发射磁性弹丸。它需要一些蓄力时间,但会穿透墙壁、你的敌人,还有你的友军。所以小心...使用专用罐体进行装填。"
	icon = 'icons/obj/items/gun/special64.dmi'
	icon_state = "ml120"
	worn_icon_state = "ml120"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/gun/special_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/gun/special_righthand_1.dmi',
	)
	max_shells = 5 //codex
	caliber = CALIBER_RAILGUN
	fire_sound = 'sound/weapons/guns/fire/railgun.ogg'
	fire_rattle = 'sound/weapons/guns/fire/railgun.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/sniper_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/sniper_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/sniper_reload.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/icc_coilgun
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/icc_coilgun,
	)
	force = 40
	wield_delay = 1.2 SECONDS
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 31, "rail_y" = 23, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
	attachable_allowed = list(
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/reddot,
	)

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_AUTO_EJECT|AMMO_RECIEVER_CYCLE_ONLY_BEFORE_FIRE

	fire_delay = 1 SECONDS
	windup_delay = 0.5 SECONDS
	burst_amount = 1
	accuracy_mult = 2
	scatter = 0
	movement_acc_penalty_mult = 6
