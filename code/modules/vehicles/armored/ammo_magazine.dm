//FEB 2024 NOTE: some of these are missing loading_sounds, fix it before using these ingame
//Special ammo magazines for hardpoint modules. Some may not be here since you can use normal magazines on them
/obj/item/ammo_magazine/tank
	icon = 'icons/obj/items/ammo/tank.dmi'
	magazine_flags = NONE
	///loading sound to play when
	var/loading_sound

/obj/item/ammo_magazine/tank/ltb_cannon
	name = "LTB高爆弹(105mm)"
	desc = "一枚105mm高爆弹,装填有致命的爆炸性装药。"
	caliber = CALIBER_105MM
	icon_state = "ltb"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/rocket/ltb
	max_rounds = 1
	loading_sound = 'sound/vehicles/weapons/ltb_reload.ogg'

/obj/item/ammo_magazine/tank/ltb_cannon/heavy
	name = "LTB高爆+弹(105mm)"
	desc = "一枚105mm高爆弹,装填有极具爆炸性的装药。"
	default_ammo = /datum/ammo/rocket/ltb/heavy
	magazine_flags = MAGAZINE_NOT_FABRICABLE

/obj/item/ammo_magazine/tank/ltb_cannon/apfds
	name = "LTB尾翼稳定脱壳穿甲弹(105mm)"
	desc = "一枚105mm穿甲弹,具有卓越的速度和穿透特性。可穿透墙壁和目标。"
	icon_state = "ltb_apfds"
	default_ammo = /datum/ammo/bullet/tank_apfds

/obj/item/ammo_magazine/tank/tow_missile
	name = "\improper TOW-III导弹"
	desc = "用于副TOW发射器的TOW-III制导导弹。"
	caliber = CALIBER_68MM
	icon_state = "seekerammo"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/rocket/homing/tow
	max_rounds = 1
	loading_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'

/obj/item/ammo_magazine/tank/microrocket_rack
	name = "微型火箭巢架"
	desc = "一个3x2的挂架,装有高爆制导微型火箭。"
	caliber = CALIBER_32MM
	icon_state = "secondary_rocketpod"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/rocket/homing/microrocket
	max_rounds = 6
	loading_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'

/obj/item/ammo_magazine/tank/ltb_cannon/canister
	name = "LTB霰弹(105mm)"
	desc = "一枚105mm霰弹,用于摧毁软目标。数百颗小金属球的装药在弹道上模拟霰弹枪射击。"
	icon_state = "ltb_canister"
	default_ammo = /datum/ammo/tx54/tank_cannister

/obj/item/ammo_magazine/tank/ltaap_chaingun
	name = "\improper LTA-AP链式机枪弹匣"
	desc = "主武器的链式机枪弹匣。"
	caliber = CALIBER_762X51
	icon_state = "ltaap"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/bullet/minigun/ltaap
	max_rounds = 150
	loading_sound = 'sound/weapons/guns/interact/working_the_bolt.ogg'

/obj/item/ammo_magazine/tank/autocannon
	name = "Bushwhacker自动炮APDS弹箱(30mm)"
	desc = "一个100发自动炮弹箱。装填有穿甲弹。"
	caliber = CALIBER_30X17MM
	icon_state = "tank_autocannon_ap"
	max_rounds = 100
	default_ammo = /datum/ammo/bullet/tank_autocannon

/obj/item/ammo_magazine/tank/autocannon/high_explosive
	name = "Bushwhacker自动炮高爆弹箱(30mm)"
	desc = "一个100发自动炮弹箱。装填有高爆弹。"
	icon_state = "tank_autocannon_he"
	default_ammo = /datum/ammo/rocket/tank_autocannon

/obj/item/ammo_magazine/tank/secondary_cupola
	name = "HSG-102炮塔弹匣"
	desc = "副武器的机枪弹匣"
	caliber = CALIBER_10X28
	icon_state = "cupola"
	loading_sound = 'sound/weapons/guns/interact/working_the_bolt.ogg'
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/bullet/cupola
	max_rounds = 75

/obj/item/ammo_magazine/tank/secondary_flamer_tank
	name = "凝固汽油喷射罐"
	desc = "一个燃料罐,装有副车载火焰喷射器的燃料。此罐装有更流体的混合物,流动更容易但一次燃烧的面积更小。"
	caliber = CALIBER_FUEL_THICK
	icon_state = "sflamer"
	max_rounds = 150
	default_ammo = /datum/ammo/flamethrower/armored_spray

/obj/item/ammo_magazine/tank/tank_glauncher
	name = "榴弹发射器弹匣"
	desc = "副武器的榴弹弹匣"
	caliber = CALIBER_40MM
	icon_state = "glauncher_2"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/grenade_container
	max_rounds = 10

/obj/item/ammo_magazine/tank/tank_glauncher/update_icon_state()
	if(current_rounds >= max_rounds)
		icon_state = "glauncher_2"
	else if(current_rounds <= 0)
		icon_state = "glauncher_0"
	else
		icon_state = "glauncher_1"

/obj/item/ammo_magazine/tank/tank_slauncher
	name = "烟雾发射器弹匣"
	desc = "支援武器的榴弹弹匣"
	caliber = CALIBER_40MM
	icon_state = "slauncher_1"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/grenade_container/smoke
	max_rounds = 6

/obj/item/ammo_magazine/tank/tank_slauncher/update_icon_state()
	icon_state = "slauncher_[current_rounds <= 0 ? "0" : "1"]"

//SOM tank
/obj/item/ammo_magazine/tank/volkite_carronade
	name = "沃尔凯特卡隆炮电池"
	desc = "一个重型一次性电池,用于为沃尔凯特卡隆炮供电。"
	caliber = CALIBER_84MM
	icon_state = "som_tank_cell"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/energy/volkite/heavy
	max_rounds = 3

/obj/item/ammo_magazine/tank/particle_lance
	name = "粒子矛能量电池"
	desc = "一个重型一次性电池,用于为车载粒子矛供电。"
	caliber = CALIBER_84MM
	icon_state = "particle_lance_cell"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/energy/particle_lance
	max_rounds = 1
	loading_sound = 'sound/vehicles/weapons/ltb_reload.ogg'

/obj/item/ammo_magazine/tank/secondary_mlrs
	name = "\improper MLRS弹匣"
	desc = "副武器的MLRS弹匣。装填有制导高爆火箭"
	caliber = CALIBER_40MM
	icon_state = "secondary_mlrs"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/rocket/homing
	max_rounds = 12

/obj/item/ammo_magazine/tank/coilgun
	name = "线圈炮炮弹"
	desc = "一组极高密度的动能穿甲弹,用于车载线圈炮。"
	caliber = CALIBER_84MM
	icon_state = "coilgun"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/rocket/coilgun/holder //this doesn't strictly matter since its overridden
	max_rounds = 1
	loading_sound = 'sound/vehicles/weapons/coilgun_cycle.ogg'

// Recon Tank
/obj/item/ammo_magazine/tank/lowvel_cannon_recon
	name = "EM-2500破甲弹(76mm)"
	desc = "一枚76mm破甲弹,装填用于打击硬目标。"
	caliber = CALIBER_76MM
	icon_state = "lvrt_cannon_heat"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/rocket/lowvel_heat
	max_rounds = 1
	loading_sound = 'sound/vehicles/weapons/ltb_reload.ogg'

/obj/item/ammo_magazine/tank/lowvel_cannon_recon/high_explosive
	name = "EM-2500高爆弹(76mm)"
	desc = "一枚76mm高爆弹,装填用于打击大群软目标。"
	caliber = CALIBER_76MM
	icon_state = "lvrt_cannon_heat"
	default_ammo = /datum/ammo/rocket/lowvel_high_explosive
	max_rounds = 1
	loading_sound = 'sound/vehicles/weapons/ltb_reload.ogg'

/obj/item/ammo_magazine/tank/lowvel_high_explosive_fragmenting_antipersonnel
	name = "EM-2500高爆鹿弹(76mm)"
	desc = "一枚76mm高爆鹿弹,装填有鹿弹破片,用于打击大群软目标。"
	caliber = CALIBER_76MM
	icon_state = "lvrt_cannon_hefa"
	default_ammo = /datum/ammo/rocket/lowvel_high_explosive_fragmenting_antipersonnel
	max_rounds = 1
	loading_sound = 'sound/vehicles/weapons/ltb_reload.ogg'

/obj/item/ammo_magazine/tank/lowvel_canister
	name = "EM-2400高燃燃料"
	desc = "一个装有高燃燃料的罐。"
	caliber = CALIBER_FUEL_THICK
	icon_state = "lvrt_flamer"
	default_ammo = /datum/ammo/flamethrower/blue/lowvel_flamer
	max_rounds = 50
	loading_sound = 'sound/vehicles/weapons/ltb_reload.ogg'

// ICC Recon Tank
/obj/item/ammo_magazine/tank/sarden_clip
	name = "EM-2600'SARDEN'APDS弹夹(30mm)"
	desc = "一个7发EM-2600自动炮弹夹。装填有穿甲弹。"
	caliber = CALIBER_30X17MM
	icon_state = "sarden_clip_apds"
	max_rounds = 7
	default_ammo = /datum/ammo/bullet/sarden

/obj/item/ammo_magazine/tank/sarden_clip/high_explosive
	name = "EM-2600'SARDEN'高爆弹夹(30mm)"
	desc = "一个7发EM-2600自动炮弹夹。装填有高爆弹。"
	caliber = CALIBER_30X17MM
	icon_state = "sarden_clip_apds"
	max_rounds = 7
	default_ammo = /datum/ammo/bullet/sarden/high_explosive

/obj/item/ammo_magazine/tank/icc_lowvel_cannon
	name = "EM-2500破甲弹(76mm)"
	desc = "一枚76mm破甲弹,装填用于打击硬目标。"
	caliber = CALIBER_76MM
	icon_state = "icc_lvrt_cannon_heat"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/rocket/icc_lowvel_heat
	max_rounds = 1
	loading_sound = 'sound/vehicles/weapons/ltb_reload.ogg'

/obj/item/ammo_magazine/tank/icc_lowvel_cannon/high_explosive
	name = "EM-2500高爆弹(76mm)"
	desc = "一枚76mm高爆弹,装填用于打击大群软目标。"
	caliber = CALIBER_76MM
	icon_state = "icc_lvrt_cannon_heat"
	default_ammo = /datum/ammo/rocket/icc_lowvel_high_explosive
	max_rounds = 1
	loading_sound = 'sound/vehicles/weapons/ltb_reload.ogg'

/obj/item/ammo_magazine/tank/tow_missile
	name = "\improper TOW-III导弹"
	desc = "用于副TOW发射器的TOW-III制导导弹。"
	caliber = CALIBER_68MM
	icon_state = "seekerammo"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/rocket/homing/tow
	max_rounds = 1
	loading_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'

/obj/item/ammo_magazine/tank/microrocket_rack
	name = "微型火箭巢架"
	desc = "一个3x2的挂架,装有高爆制导微型火箭。"
	caliber = CALIBER_32MM
	icon_state = "secondary_rocketpod"
	w_class = WEIGHT_CLASS_GIGANTIC
	default_ammo = /datum/ammo/rocket/homing/microrocket
	max_rounds = 6
	loading_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'

/obj/item/ammo_magazine/tank/bfg
	name = "\improper BFG反物质容器"
	desc = "一个反物质收容室,装有用于BFG球体的反物质。请勿打开,有爆炸风险。"
	icon_state = "bfg"
	w_class = WEIGHT_CLASS_GIGANTIC
	caliber = CALIBER_ANTIMATTER
	default_ammo = /datum/ammo/energy/bfg
	max_rounds = 1
	loading_sound = 'sound/vehicles/weapons/ltb_reload.ogg'
