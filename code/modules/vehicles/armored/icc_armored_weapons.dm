// Fallow weapons are below.
/obj/item/armored_weapon/icc_lvrt_sarden
	name = "\improper EM-2600 'SARDEN'自动炮"
	desc = "一种用于LVRT 'Fallow'的30毫米自动炮.一种出乎意料的强大自动炮.遗憾的是,弹链供弹系统在与该系统相关的一系列预算削减中丢失了.它装有4发弹夹."
	icon_state = "icc_lvrt_autocannon"
	fire_sound = SFX_AC_FIRE
	interior_fire_sound = null
	ammo = /obj/item/ammo_magazine/tank/sarden_clip
	accepted_ammo = list(/obj/item/ammo_magazine/tank/sarden_clip, /obj/item/ammo_magazine/tank/sarden_clip/high_explosive)
	fire_mode = GUN_FIREMODE_AUTOMATIC
	variance = 2
	projectile_delay = 0.65 SECONDS
	rearm_time = 0.5 SECONDS
	hud_state_empty = "rifle_empty"

/obj/item/armored_weapon/icc_lvrt_cannon
	name = "\improper EM-2500低速炮"
	desc = "一种用于LVRT 'Fallow'的76毫米低速炮.它的飞行速度慢,爆炸性能扎实.它装有76毫米炮弹."
	icon_state = "icc_lvrt_cannon"
	fire_sound = SFX_AC_FIRE
	interior_fire_sound = null
	ammo = /obj/item/ammo_magazine/tank/icc_lowvel_cannon
	accepted_ammo = list(/obj/item/ammo_magazine/tank/icc_lowvel_cannon, /obj/item/ammo_magazine/tank/icc_lowvel_cannon/high_explosive)
	variance = 0
	projectile_delay = 1.5 SECONDS
	rearm_time = 1.5 SECONDS
	hud_state_empty = "rifle_empty"

// generic coax

/obj/item/armored_weapon/icc_coaxial
	name = "EM-94同轴链炮(10x26毫米)"
	desc = "一种带有ICC标记的弹链供弹同轴武器,倾泻铅弹.需要载具的枪管护罩和动力系统才能以任何形式使用.可以使用标准ML-41弹箱或载具专用弹箱."
	icon_state = "icc_lvrt_coax"
	fire_sound = 'sound/weapons/guns/fire/tgmc/kinetic/gun_mg60.ogg'
	armored_weapon_flags = MODULE_SECONDARY|MODULE_FIXED_FIRE_ARC
	ammo = /obj/item/ammo_magazine/icc_mg
	accepted_ammo = list(/obj/item/ammo_magazine/icc_mg)
	fire_mode = GUN_FIREMODE_AUTOMATIC
	projectile_delay = 0.15 SECONDS
	variance = 5
	rearm_time = 3 SECONDS
	hud_state_empty = "rifle_empty"
