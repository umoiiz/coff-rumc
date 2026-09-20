//-------------------------------------------------------
//M41A PULSE RIFLE AMMUNITION

/obj/item/ammo_magazine/rifle
	name = "\improper PR-412 弹匣 (10x24mm)"
	desc = "一个 10mm 突击步枪弹匣."
	caliber = CALIBER_10X24_CASELESS
	icon_state = "m412"
	icon_state_mini = "mag_rifle"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 40
	ammo_band_icon = "m412_band"

/obj/item/ammo_magazine/rifle/extended
	name = "\improper PR-412 加长弹匣 (10x24mm)"
	desc = "一个 10mm 突击步枪加长弹匣."
	icon_state_mini = "mag_rifle_big_yellow"
	max_rounds = 60
	bonus_overlay = "m412_ex"
	ammo_band_color = AMMO_BAND_COLOR_EXTENDED

/obj/item/ammo_magazine/rifle/incendiary
	name = "\improper PR-412 燃烧弹匣 (10x24mm)"
	desc = "一个 10mm 突击步枪弹匣."
	icon_state_mini = "mag_rifle_big_red"
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	bonus_overlay = "m412_incend"
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/ap
	name = "\improper PR-412 AP 弹匣 (10x24mm)"
	desc = "一个 10mm 穿甲弹匣."
	icon_state_mini = "mag_rifle_big_green"
	default_ammo = /datum/ammo/bullet/rifle/ap
	bonus_overlay = "m412_ap"
	ammo_band_color = AMMO_BAND_COLOR_AP

//-------------------------------------------------------
//ar18 Carbine

/obj/item/ammo_magazine/rifle/ar18
	name = "\improper AR-18 弹匣 (10x24mm)"
	desc = "一个 10mm 卡宾枪弹匣."
	caliber = CALIBER_10X24_CASELESS
	icon_state = "t18"
	icon_state_mini = "mag_rifle_big"
	ammo_band_icon = "t18_band"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 36

/obj/item/ammo_magazine/rifle/ar18/ap
	name = "\improper AR-18 AP 弹匣 (10x24mm)"
	desc = "一个 10mm 穿甲卡宾枪弹匣."
	ammo_band_color = AMMO_BAND_COLOR_AP
	default_ammo = /datum/ammo/bullet/rifle/ap

//-------------------------------------------------------
//AR12 Assault Rifle

/obj/item/ammo_magazine/rifle/ar12
	name = "\improper AR-12 弹匣 (10x24mm)"
	desc = "一个 10mm 突击步枪弹匣."
	caliber = CALIBER_10X24_CASELESS
	icon_state = "t12"
	icon_state_mini = "mag_rifle_big"
	ammo_band_icon = "t12_band"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 50

/obj/item/ammo_magazine/rifle/ar12/incendiary
	name = "\improper AR-12 燃烧弹匣 (10x24mm)"
	desc = "一个 10mm 燃烧突击步枪弹匣."
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY
	default_ammo = /datum/ammo/bullet/rifle/incendiary

//-------------------------------------------------------
//DMR37

/obj/item/ammo_magazine/rifle/dmr37
	name = "\improper DMR-37 弹匣 (10x27mm)"
	desc = "一个 10mm 精确射手步枪弹匣."
	caliber = CALIBER_10X27_CASELESS
	icon_state = "t37"
	icon_state_mini = "mag_rifle_big"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle/dmr37
	max_rounds = 20

//-------------------------------------------------------
//BR64

/obj/item/ammo_magazine/rifle/br64
	name = "\improper BR-64 弹匣 (10x26.5mm)"
	desc = "一把10mm战斗步枪弹匣."
	caliber = CALIBER_10X265_CASELESS
	icon_state = "t64"
	icon_state_mini = "mag_rifle_big"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle/br64
	max_rounds = 36
	ammo_band_icon = "t64_band"

//-------------------------------------------------------
//M41A TRUE AND ORIGINAL

/obj/item/ammo_magazine/rifle/m41a
	name = "\improper PR-11弹匣 (10x24mm)"
	desc = "一盒半矩形装填的PR-11脉冲步枪弹药."
	icon_state = "m41a"
	icon_state_mini = "mag_rifle_big_light"
	max_rounds = 95


//-------------------------------------------------------
//Kalashnikov rifles

/obj/item/ammo_magazine/rifle/mpi_km
	name = "\improper MPi-KM弹匣 (7.62x39mm)"
	desc = "一款40发7.62x39mm口径的卡拉什尼科夫系列枪械弹匣."
	caliber = CALIBER_762X39
	icon_state = "ak_40"
	icon_state_mini = "mag_rifle_brown"
	bonus_overlay = "ak_40"
	default_ammo = /datum/ammo/bullet/rifle/mpi_km
	max_rounds = 40
	scatter_mod = 2
	aim_speed_mod = 0.1
	wield_delay_mod = 0.1 SECONDS

/obj/item/ammo_magazine/rifle/mpi_km/plum
	desc = "一款7.62x39mm口径的卡拉什尼科夫系列枪械弹匣. 这款采用了旧式李子色涂装."
	icon_state = "ak_40_plum"
	icon_state_mini = "mag_rifle_darkpurple"
	bonus_overlay = "ak_40_plum"

/obj/item/ammo_magazine/rifle/mpi_km/black
	desc = "一款7.62x39mm口径的卡拉什尼科夫系列枪械弹匣. 这款采用了现代黑色聚合物涂装."
	icon_state = "ak_40_black"
	icon_state_mini = "mag_rifle"
	bonus_overlay = "ak_40_black"

/obj/item/ammo_magazine/rifle/mpi_km/carbine
	name = "\improper V-34弹匣 (7.62x39mm)"
	desc = "一款30发7.62x39mm口径的卡拉什尼科夫系列枪械弹匣."
	icon_state = "ak_30"
	icon_state_mini = "mag_rifle_brown"
	bonus_overlay = "ak_30"
	max_rounds = 30
	scatter_mod = 0
	aim_speed_mod = 0
	wield_delay_mod = 0

/obj/item/ammo_magazine/rifle/mpi_km/carbine/plum
	desc = "一款30发7.62x39mm口径的卡拉什尼科夫系列枪械弹匣. 这款采用了旧式李子色涂装."
	icon_state = "ak_30_plum"
	icon_state_mini = "mag_rifle_darkpurple"
	bonus_overlay = "ak_30_plum"

/obj/item/ammo_magazine/rifle/mpi_km/carbine/black
	desc = "一款30发7.62x39mm口径的卡拉什尼科夫系列枪械弹匣. 这款采用了现代黑色聚合物涂装."
	icon_state = "ak_30_black"
	icon_state_mini = "mag_rifle"
	bonus_overlay = "ak_30_black"

/obj/item/ammo_magazine/rifle/mpi_km/extended
	name = "\improper MPi-KM加长弹匣 (7.62x39mm)"
	desc = "一款60发7.62x39mm口径的卡拉什尼科夫弹匣. 这款弹匣明显偏重."
	icon_state = "ak47_ext"
	icon_state_mini = "mag_rifle"
	bonus_overlay = "ak47_ex"
	max_rounds = 60
	aim_speed_mod = 0.2
	wield_delay_mod = 0.2

// Marine mags for AK
/obj/item/ammo_magazine/rifle/type16
	name = "\improper Type-16步枪弹匣 (6.02x41)"
	desc = "一款40发6.02x41mm口径弹匣."
	caliber = CALIBER_602X41
	icon_state = "ak_40"
	icon_state_mini = "mag_rifle_brown"
	bonus_overlay = "ak_40"
	default_ammo = /datum/ammo/bullet/rifle/type16
	max_rounds = 40
	scatter_mod = 2
	wield_delay_mod = 0.5 SECONDS

/obj/item/ammo_magazine/rifle/type16/m2
	name = "\improper Type-16卡宾枪弹匣 (6.02x41)"
	desc = "一款30发6.02x41mm口径弹匣."
	icon_state = "ak_30_black"
	icon_state_mini = "mag_rifle"
	bonus_overlay = "ak_30_black"
	max_rounds = 30
	scatter_mod = 0
	wield_delay_mod = 0

/obj/item/ammo_magazine/rifle/type16/extended
	name = "\improper Type-16加长弹匣 (6.02x41)"
	desc = "一款50发6.02x41mm口径弹匣."
	icon_state = "ak47_ext"
	icon_state_mini = "mag_rifle"
	bonus_overlay = "ak47_ex"
	max_rounds = 50
	wield_delay_mod = 1 SECONDS

// RPD

/obj/item/ammo_magazine/rifle/lmg_d
	name = "\improper lMG-D弹鼓 (7.62x39mm)"
	desc = "一款100发7.62x39mm口径的卡拉什尼科夫弹鼓, 无法适配大多数卡拉什尼科夫步枪, 因为它是为弹链供弹型号设计的."
	caliber = CALIBER_762X39
	default_ammo = /datum/ammo/bullet/rifle/mpi_km
	icon_state = "rpd"
	icon_state_mini = "mag_drum_big"
	bonus_overlay = "rpd_100"
	max_rounds = 100

//-------------------------------------------------------
//DP-27

/obj/item/ammo_magazine/rifle/dpm
	name = "\improper 捷格加廖夫穿甲弹鼓 (7.62x39mm)"
	desc = "一款用于捷格加廖夫机枪的弹鼓."
	caliber = CALIBER_762X39
	icon_state = "dp27"
	default_ammo = /datum/ammo/bullet/rifle/ap
	max_rounds = 47
	icon_state_mini = "mag_rifle"

//-------------------------------------------------------
//M16 RIFLE

/obj/item/ammo_magazine/rifle/m16
	name = "\improper M16弹匣 (5.56x45mm)"
	desc = "一款用于M16突击步枪平台的5.56x45mm口径弹匣."
	caliber = CALIBER_556X45
	icon_state = "m16" //PLACEHOLDER
	icon_state_mini = "mag_rifle_big"
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 30 //Also comes in 30 and 100 round Beta-C mag.

//-------------------------------------------------------
//FAMAS RIFLE

/obj/item/ammo_magazine/rifle/famas
	name = "\improper FAMAS弹匣 (5.56x45mm)"
	desc = "一款用于FAMAS突击步枪的5.56x45mm口径弹匣."
	caliber = CALIBER_556X45
	icon_state = "famas"
	icon_state_mini = "mag_rifle_greyblue"
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 24

//-------------------------------------------------------
//MG-42 Light Machine Gun

/obj/item/ammo_magazine/mg42
	name = "\improper MG-42弹鼓 (10x24mm)"
	desc = "一款用于MG-42轻机枪的弹鼓."
	icon_state = "t42"
	icon_state_mini = "mag_drum"
	caliber = CALIBER_10X24_CASELESS
	default_ammo = /datum/ammo/bullet/rifle
	w_class = WEIGHT_CLASS_NORMAL
	max_rounds = 120

//-------------------------------------------------------
//MG-60 General Purpose Machine Gun

/obj/item/ammo_magazine/mg60
	name = "\improper MG-60通用机枪弹链箱 (10x26mm)"
	desc = "一款用于MG-60通用机枪的弹链箱."
	icon_state = "t60"
	icon_state_mini = "mag_gpmg"
	caliber = CALIBER_10X26_CASELESS
	default_ammo = /datum/ammo/bullet/rifle/machinegun
	w_class = WEIGHT_CLASS_NORMAL
	max_rounds = 200
	reload_delay = 3 SECONDS

//-------------------------------------------------------
//PR-412L1 HEAVY PULSE RIFLE

/obj/item/ammo_magazine/m412l1_hpr
	name = "\improper PR-412L1弹匣 (10x24mm)"
	desc = "一盒半矩形装填的PR-412L1重型脉冲步枪弹药."
	icon_state = "m412l1"
	icon_state_mini = "mag_box"
	caliber = CALIBER_10X24_CASELESS
	default_ammo = /datum/ammo/bullet/rifle
	w_class = WEIGHT_CLASS_NORMAL
	max_rounds = 200

//-------------------------------------------------------
//UPP TYPE 71 RIFLE

/obj/item/ammo_magazine/rifle/type71
	name = "\improper Type 71弹匣 (7.62x39mm)"
	desc = "一款适配Type 71步枪的7.62x39mm口径弹匣."
	caliber = CALIBER_762X39
	icon_state = "type_71"
	icon_state_mini = "mag_rifle_big"
	ammo_band_icon = "type_71_band"
	default_ammo = /datum/ammo/bullet/rifle/mpi_km
	max_rounds = 42

//sh-15 AUTOMATIC SHOTGUN

/obj/item/ammo_magazine/rifle/sh15_flechette
	name = "\improper SH-15箭形弹弹匣 (16号口径)"
	desc = "一款装填16号口径箭形弹的弹匣, 用于SH-15."
	caliber = CALIBER_16G
	icon_state = "tx15_flechette"
	icon_state_mini = "mag_tx15_flechette"
	default_ammo = /datum/ammo/bullet/shotgun/sh15_flechette
	max_rounds = 12
	bonus_overlay = "tx15_flech"

/obj/item/ammo_magazine/rifle/sh15_slug
	name = "\improper SH-15独头弹弹匣 (16号口径)"
	desc = "一款装填16号口径独头弹的弹匣, 用于SH-15."
	caliber = CALIBER_16G
	icon_state = "tx15_slug"
	icon_state_mini = "mag_tx15_slug"
	default_ammo = /datum/ammo/bullet/shotgun/sh15_slug
	max_rounds = 12
	bonus_overlay = "tx15_slug"

//-------------------------------------------------------
//SMARTMACHINEGUN AMMUNITION

/obj/item/ammo_magazine/sg29
	name = "\improper SG-29弹鼓"
	desc = "一款宽大的弹鼓, 精心装填至容量上限的10x26mm特种智能弹药."
	caliber = CALIBER_10X26_CASELESS
	icon_state = "sg29"
	icon_state_mini = "mag_sg29"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle/t25
	max_rounds = 250
	reload_delay = 1.3 SECONDS

/obj/item/ammo_magazine/standard_smartmachinegun
	parent_type = /obj/item/ammo_magazine/sg29

//-------------------------------------------------------
//SMART TARGET RIFLE AMMUNITION

/obj/item/ammo_magazine/rifle/sg62
	name = "\improper SG-62弹匣 (10x27mm HV)"
	desc = "一款装填10x27mm特种智能弹药的弹匣."
	caliber = CALIBER_10X27_CASELESS
	icon_state = "sg62"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/sg62
	max_rounds = 40
	icon_state_mini = "mag_sg29"

//-------------------------------------------------------
//SPOTTING RIFLE AMMUNITION

/obj/item/ammo_magazine/rifle/sg153
	name = "\improper SG-153弹匣 (12x7mm智能马格南)"
	desc = "一款装填12x7mm致命智能弹药的弹匣, 这些弹药除了威力巨大之外别无他用."
	caliber = CALIBER_12X7
	icon_state = "sg153"
	w_class = WEIGHT_CLASS_SMALL
	default_ammo = /datum/ammo/bullet/sg153
	max_rounds = 5
	icon_state_mini = "mag_sg29"

/obj/item/ammo_magazine/rifle/sg153/highimpact
	name = "\improper SG-153高冲击弹匣 (12x7mm智能马格南)"
	desc = "一款装填12x7mm高冲击智能弹药的弹匣, 这些弹药很可能使其命中的任何目标踉跄并减速."
	icon_state = "sg153_hi"
	default_ammo = /datum/ammo/bullet/sg153/highimpact

/obj/item/ammo_magazine/rifle/sg153/heavyrubber
	name = "\improper SG-153重型橡胶弹匣 (12x7mm智能马格南)"
	desc = "一款装填12x7mm重型橡胶智能弹药的弹匣, 这些弹药很可能使其命中的任何目标眩晕并击退."
	icon_state = "sg153_hr"
	default_ammo = /datum/ammo/bullet/sg153/heavyrubber

/obj/item/ammo_magazine/rifle/sg153/plasmaloss
	name = "\improper SG-153缠足毒弹匣 (12x7mm智能马格南)"
	desc = "一款装填12x7mm尖端涂有'缠足'毒药的智能弹药的弹匣, 这些弹药会抽干命中目标的能量."
	icon_state = "sg153_hr"
	default_ammo = /datum/ammo/bullet/sg153/plasmaloss

/obj/item/ammo_magazine/rifle/sg153/tungsten
	name = "\improper SG-153钨芯弹匣 (12x7mm智能马格南)"
	desc = "一款装填12x7mm钨芯智能弹药的弹匣, 这些弹药会大幅击退其命中的任何目标."
	icon_state = "sg153_tg"
	default_ammo = /datum/ammo/bullet/sg153/tungsten

/obj/item/ammo_magazine/rifle/sg153/incendiary
	name = "\improper SG-153燃烧弹匣 (12x7mm智能马格南)"
	desc = "一款装填12x7mm燃烧智能弹药的弹匣, 这些弹药会点燃其命中的任何目标."
	icon_state = "sg153_ic"
	default_ammo = /datum/ammo/bullet/sg153/incendiary

/obj/item/ammo_magazine/rifle/sg153/flak
	name = "\improper SG-153破片弹匣 (12x7mm智能马格南)"
	desc = "一款装填12x7mm破片智能弹药的弹匣, 这些弹药会在接触有机目标时空爆, 对目标附近的小范围区域造成伤害."
	icon_state = "sg153_fl"
	default_ammo = /datum/ammo/bullet/sg153/flak


//-------------------------------------------------------
//Sectoid Rifle

/obj/item/ammo_magazine/rifle/sectoid_rifle
	name = "异形步枪等离子弹匣"
	desc = "一款装填强大等离子弹药的弹匣. 里面的弹药看起来与你之前见过的任何东西都不一样."
	caliber = CALIBER_ALIEN
	icon_state = "alien_rifle"
	icon_state_mini = "mag_rifle_purple"
	default_ammo = /datum/ammo/energy/sectoid_plasma
	max_rounds = 20

//-------------------------------------------------------
//Marine magazine sniper, or the SR-127.
/obj/item/ammo_magazine/rifle/sr127
	name = "SR-127栓动步枪弹匣"
	desc = "一款装填8.6x70mm步枪弹的弹匣, 用于SR-127."
	caliber = CALIBER_86X70
	icon_state = "tl127"
	icon_state_mini = "mag_rifle_big"
	default_ammo = /datum/ammo/bullet/sniper/pfc
	max_rounds = 10
	bonus_overlay = "tl127_mag"
	ammo_band_icon = "tl127_band"

/obj/item/ammo_magazine/rifle/sr127/flak
	name = "SR-127栓动步枪破片弹匣"
	desc = "一款装填8.6x70mm步枪破片弹的弹匣, 用于SR-127."
	icon_state_mini = "mag_sniper_blue"
	default_ammo = /datum/ammo/bullet/sniper/pfc/flak
	bonus_overlay = "tl127_flak"
	ammo_band_color = AMMO_BAND_COLOR_IMPACT

//-------------------------------------------------------
//Marine magazine automatic sniper, or the SR-81.
/obj/item/ammo_magazine/rifle/sr81
	name = "\improper SR-81自动狙击步枪弹匣"
	desc = "一款装填低压8.6x70mm步枪弹的弹匣, 用于SR-81."
	caliber = CALIBER_86X70
	icon_state = "t81"
	icon_state_mini = "mag_rifle_greyblue"
	default_ammo = /datum/ammo/bullet/sniper/auto
	max_rounds = 20

//-------------------------------------------------------
//AR-11
/obj/item/ammo_magazine/rifle/ar11
	name = "\improper AR-11战斗步枪弹匣"
	desc = "一款装填4.92x34mm步枪弹的弹匣, 用于AR-11."
	caliber = CALIBER_492X34_CASELESS
	icon_state = "tx11"
	icon_state_mini = "mag_tx11"
	default_ammo = /datum/ammo/bullet/rifle/hv
	max_rounds = 70

/obj/item/ammo_magazine/rifle/tx11
	parent_type = /obj/item/ammo_magazine/rifle/ar11

//-------------------------------------------------------
//AR-21
/obj/item/ammo_magazine/rifle/ar21
	name = "\improper AR-21游骑兵步枪弹匣"
	desc = "一款装填10x25mm步枪弹的弹匣, 用于AR-21."
	caliber = CALIBER_10X25_CASELESS
	icon_state = "t21"
	icon_state_mini = "mag_rifle"
	ammo_band_icon = "t21_band"
	default_ammo = /datum/ammo/bullet/rifle/heavy
	max_rounds = 30

/obj/item/ammo_magazine/rifle/ar21/extended
	name = "\improper AR-21加长游骑兵步枪弹匣"
	desc = "一款装填10x25mm步枪弹的加长弹匣, 用于AR-21."
	icon_state = "t21_ext"
	max_rounds = 50
	icon_state_mini = "mag_rifle_big_yellow"
	ammo_band_color = AMMO_BAND_COLOR_EXTENDED
	bonus_overlay = "t21_ext"

//ALF-51B

/obj/item/ammo_magazine/rifle/alf_machinecarbine
	name = "\improper ALF-51B弹匣 (10x25mm)"
	desc = "一款用于ALF-51B机关卡宾枪的弹匣."
	icon_state = "t60"
	icon_state_mini = "mag_gpmg"
	caliber = CALIBER_10X25_CASELESS
	default_ammo = /datum/ammo/bullet/rifle/som_machinegun
	w_class = WEIGHT_CLASS_NORMAL
	max_rounds = 80
	reload_delay = 1 SECONDS

//-------------------------------------------------------
//MKH98

/obj/item/ammo_magazine/rifle/mkh
	name = "\improper MKH-98风暴步枪弹匣"
	desc = "一款装填7.62X39步枪弹的弹匣, 用于MKH."
	caliber = CALIBER_762X39
	icon_state = "mkh98"
	icon_state_mini = "mag_rifle_greyblue"
	default_ammo = /datum/ammo/bullet/rifle/heavy
	max_rounds = 30

//-------------------------------------------------------
//GL-54
/obj/item/ammo_magazine/rifle/tx54
	name = "\improper 20mm空爆榴弹弹匣"
	desc = "装有空爆榴弹的20mm弹匣. 用于GL-54或AR-55."
	caliber = CALIBER_20MM
	icon = 'icons/obj/items/ammo/misc.dmi'
	icon_state = "tx54_airburst"
	icon_state_mini = "mag_sniper_blue"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/tx54
	max_rounds = 8
	greyscale_config = /datum/greyscale_config/ammo
	greyscale_colors = COLOR_AMMO_AIRBURST

/obj/item/ammo_magazine/rifle/tx54/incendiary
	name = "\improper 20mm燃烧榴弹弹匣"
	desc = "装有燃烧榴弹的20mm弹匣. 用于GL-54或AR-55."
	default_ammo = /datum/ammo/tx54/incendiary
	icon_state_mini = "mag_sniper_orange"
	greyscale_colors = COLOR_AMMO_INCENDIARY

/obj/item/ammo_magazine/rifle/tx54/smoke
	name = "\improper 20mm战术烟雾榴弹弹匣"
	desc = "装有战术烟雾榴弹的20mm弹匣. 用于GL-54或AR-55."
	default_ammo = /datum/ammo/tx54/smoke
	icon_state_mini = "mag_sniper_green"
	greyscale_colors = COLOR_AMMO_TACTICAL_SMOKE

/obj/item/ammo_magazine/rifle/tx54/smoke/dense
	name = "\improper 20mm烟雾榴弹弹匣"
	desc = "装有烟雾榴弹的20mm弹匣. 用于GL-54或AR-55."
	default_ammo = /datum/ammo/tx54/smoke/dense
	icon_state_mini = "mag_sniper_cyan"
	greyscale_colors = COLOR_AMMO_SMOKE

/obj/item/ammo_magazine/rifle/tx54/smoke/tangle
	name = "\improper 20mm绊足榴弹弹匣"
	desc = "装有绊足榴弹的20mm弹匣. 用于GL-54或AR-55."
	default_ammo = /datum/ammo/tx54/smoke/tangle
	icon_state_mini = "mag_sniper_purple"
	greyscale_colors = COLOR_AMMO_TANGLEFOOT

/obj/item/ammo_magazine/rifle/tx54/razor
	name = "\improper 20mm剃刀燃烧榴弹弹匣"
	desc = "装有剃刀燃烧榴弹的20mm弹匣. 用于GL-54或AR-55."
	default_ammo = /datum/ammo/tx54/razor
	icon_state_mini = "mag_sniper_yellow"
	greyscale_colors = COLOR_AMMO_RAZORBURN

//-------------------------------------------------------
//Garand
/obj/item/ammo_magazine/rifle/garand
	name = "C1加兰德漏夹"
	desc = "装有.30口径步枪弹的漏夹, 用于C1加兰德."
	caliber = CALIBER_3006
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "garand"
	icon_state_mini = "clips"
	default_ammo = /datum/ammo/bullet/rifle/garand
	max_rounds = 8

//-------------------------------------------------------
//V-31 SOM rifle

/obj/item/ammo_magazine/rifle/som
	name = "\improper V-31弹匣 (10x24mm)"
	desc = "为V-31设计的10mm步枪弹匣."
	caliber = CALIBER_10X24_CASELESS
	icon_state = "v31"
	icon_state_mini = "mag_thin_cyan"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 50
	ammo_band_icon = "v31_band"

/obj/item/ammo_magazine/rifle/som/ap
	name = "\improper V-31穿甲弹匣 (10x24mm)"
	desc = "为V-31设计的10mm步枪弹匣, 装有穿甲弹."
	icon_state_mini = "mag_thin_green"
	default_ammo = /datum/ammo/bullet/rifle/hv
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/som/incendiary
	name = "\improper V-31燃烧弹匣 (10x24mm)"
	desc = "为V-31设计的10mm步枪弹匣, 装有燃烧弹."
	icon_state_mini = "mag_thin_red"
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/som_big
	name = "\improper V-35弹匣 (10x27mm)"
	desc = "为V-35设计的10mm步枪弹匣."
	caliber = CALIBER_10X27_CASELESS
	icon_state = "v35"
	base_ammo_icon = "v35"
	icon_state_mini = "mag_rifle_big"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle/som_big
	max_rounds = 25
	bonus_overlay = "v35_mag"
	magazine_flags = MAGAZINE_REFILLABLE|MAGAZINE_SHOW_AMMO

/obj/item/ammo_magazine/rifle/som_big/incendiary
	name = "\improper V-35燃烧弹匣 (10x27mm)"
	desc = "为V-35设计的10mm步枪弹匣, 装有燃烧弹药."
	icon_state = "v35_incend"
	default_ammo = /datum/ammo/bullet/rifle/som_big/incendiary
	bonus_overlay = "v35_incend"

/obj/item/ammo_magazine/rifle/som_big/anti_armour
	name = "\improper V-35反装甲弹匣 (10x27mm)"
	desc = "为V-35设计的10mm步枪弹匣, 装有强力的反装甲弹药. 对载具造成显著伤害, 并能穿透部分掩体."
	icon_state = "v35_at"
	default_ammo = /datum/ammo/bullet/rifle/som_big/anti_armour
	bonus_overlay = "v35_at"

//-------------------------------------------------------
//V-41 Machine Gun

/obj/item/ammo_magazine/som_mg
	name = "\improper V-41弹箱 (10x26mm)"
	desc = "V-41机枪的弹鼓."
	icon_state = "v41"
	icon_state_mini = "mag_drum_big_long"
	caliber = CALIBER_10X26_CASELESS
	default_ammo = /datum/ammo/bullet/rifle/som_machinegun
	w_class = WEIGHT_CLASS_NORMAL
	max_rounds = 200
	reload_delay = 3 SECONDS

//-------------------------------------------------------
//L-11 Sharpshooter Rifle

/obj/item/ammo_magazine/rifle/icc_sharpshooter
	name = "\improper L-11精确射手步枪弹匣 (10x27mm)"
	desc = "10mm精确射手步枪弹匣."
	caliber = CALIBER_10X27_CASELESS
	icon_state = "l11"
	icon_state_mini = "mag_rifle"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle/dmr37
	max_rounds = 20

//-------------------------------------------------------
//L-15 Battlecarbine
/obj/item/ammo_magazine/rifle/icc_battlecarbine
	name = "\improper L-15战斗卡宾枪弹匣 (10x25mm)"
	desc = "装有10x25mm步枪弹的弹匣, 用于L-15."
	caliber = CALIBER_10X25_CASELESS
	icon_state = "l15"
	icon_state_mini = "mag_rifle"
	default_ammo = /datum/ammo/bullet/rifle/heavy
	max_rounds = 30

//-------------------------------------------------------
//ML-12 Confrontation Rifle
/obj/item/ammo_magazine/rifle/icc_confrontationrifle
	name = "\improper ML-12战斗卡宾枪弹匣 (10x28mm)"
	desc = "装有10x28mm穿甲步枪弹的弹匣, 用于ML-12."
	caliber = CALIBER_10X28_CASELESS
	icon_state = "ml12"
	icon_state_mini = "mag_rifle_big"
	default_ammo = /datum/ammo/bullet/rifle/icc_confrontationrifle
	max_rounds = 25

//-------------------------------------------------------
//ML-41 Autoshotgun
/obj/item/ammo_magazine/rifle/icc_autoshotgun
	name = "\improper ML-41自动霰弹枪飞镖弹鼓"
	desc = "装有12G飞镖弹的弹鼓, 用于ML-41."
	caliber = CALIBER_12G
	icon_state = "ml41"
	default_ammo = /datum/ammo/bullet/shotgun/flechette
	max_rounds = 16
	icon_state_mini = "mag_rifle"

/obj/item/ammo_magazine/rifle/icc_autoshotgun/frag
	name = "\improper ML-41自动霰弹枪破片弹鼓"
	desc = "装有12G破片弹的弹鼓, 用于ML-41."
	caliber = CALIBER_12G
	icon_state = "ml41_frag"
	default_ammo = /datum/ammo/bullet/shotgun/frag
	max_rounds = 12

//-------------------------------------------------------
//L-88 Assault Carbine
/obj/item/ammo_magazine/rifle/icc_assaultcarbine
	name = "\improper L-88突击卡宾枪弹匣 (5.56x45mm)"
	desc = "装有5.56x45mm步枪弹的弹匣, 用于L-88系列枪械."
	caliber = CALIBER_556X45
	icon_state = "aug"
	icon_state_mini = "mag_rifle"
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 30

/obj/item/ammo_magazine/rifle/icc_assaultcarbine/export
	name = "\improper EM-88突击卡宾枪弹匣 (5.56x45mm)"
	desc = "装有5.56x45mm步枪弹的弹匣, 用于EM-88系列枪械."

//-------------------------------------------------------
//

/obj/item/ammo_magazine/rifle/t25
	name = "\improper T-25弹匣 (10x26mm)"
	desc = "10mm突击步枪弹匣."
	caliber = CALIBER_10X26_CASELESS
	icon_state = "t25"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle/t25
	max_rounds = 80
	icon_state_mini = "mag_rifle_big"

/obj/item/ammo_magazine/rifle/t25/extended
	name = "\improper T-25加长弹匣 (10x26mm)"
	desc = "10mm加长突击步枪弹匣."
	icon_state = "t25_ext"
	max_rounds = 120
	icon_state_mini = "mag_rifle_big_yellow"
	bonus_overlay = "t25_ext"

//ML-41 Assault Machinegun
/obj/item/ammo_magazine/icc_mg
	name = "\improper ML-41通用机枪弹箱 (10x26mm)"
	desc = "ML-41突击机枪的弹链箱."
	icon_state = "minimi"
	icon_state_mini = "mag_gpmg"
	caliber = CALIBER_10X26_CASELESS
	default_ammo = /datum/ammo/bullet/rifle/machinegun
	w_class = WEIGHT_CLASS_NORMAL
	max_rounds = 150
	reload_delay = 2 SECONDS

// This is a 'belt'.
/obj/item/ammo_magazine/icc_mg/belt
	name = "\improper ML-41通用机枪背包弹匣 (10x26mm)"
	desc = "ML-41的背包, 弹药装在其中."
	icon_state = "minimi_belt"
	equip_slot_flags = ITEM_SLOT_BELT
	magazine_flags = MAGAZINE_WORN
	w_class = WEIGHT_CLASS_HUGE
	max_rounds = 750

/obj/item/ammo_magazine/icc_mg/packet
	name = "10x26mm弹药盒"
	desc = "装有500发10x26mm无壳弹的弹药盒."
	icon = 'icons/obj/items/ammo/packet.dmi'
	icon_state = "box_minimi"
	current_rounds = 500
	max_rounds = 500

// L26

/obj/item/ammo_magazine/rifle/vsd_mg
	name = "\improper L26弹箱 (5.56x45mm)"
	desc = "L26的200发弹箱."
	caliber = CALIBER_556X45
	default_ammo = /datum/ammo/bullet/rifle/machinegun
	icon_state = "l26"
	icon_state_mini = "mag_gpmg"
	bonus_overlay = "l26_100"
	max_rounds = 200

/obj/item/ammo_magazine/rifle/vsd_rifle
	name = "\improper C550弹匣 (10x27mm)"
	desc = "10x27mm步枪弹匣."
	caliber = CALIBER_10X27_CASELESS
	icon_state = "c550"
	icon_state_mini = "mag_rifle_big"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 30
