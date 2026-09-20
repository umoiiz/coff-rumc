/obj/structure/lazarus_sign
	name = "拉撒路着陆点标牌"
	desc = "一块大标牌,上面写着'拉撒路着陆点',其余部分被鲜血涂抹."
	icon = 'icons/obj/landing_signs.dmi'
	icon_state = "laz_sign"
	bound_width = 64
	bound_height = 64
	density = TRUE
	coverage = 15

/obj/structure/solaris_sign
	name = "索拉里斯山脊标牌"
	desc = "一块大标牌,上面写着'索拉里斯山脊 -',其余部分被刮掉了."
	icon = 'icons/obj/landing_signs.dmi'
	icon_state = "red_sign"
	bound_width = 64
	bound_height = 64
	density = TRUE

/obj/structure/kutjevo_sign
	name = "库特耶沃标牌"
	desc = "一块大标牌,上面写着'库特耶沃人口-',其余部分被爪痕遮挡."
	icon = 'icons/obj/landing_signs.dmi'
	icon_state = "kut_sign"
	bound_width = 64
	bound_height = 32
	density = TRUE

/obj/structure/kutjevo_sign/Initialize(mapload)
	. = ..()
	icon_state = "kut_ingame"
	overlays += image(icon, src, "kut_sign_top", layer = ABOVE_ALL_MOB_LAYER, pixel_x = 32)

/obj/structure/prison_sign
	name = "UA监狱对接标牌"
	desc = "一块大标牌,上面写着'UA监狱对接 -',其余部分被爪痕遮挡."
	icon = 'icons/obj/landing_signs.dmi'
	icon_state = "prison_sign"
	bound_width = 64
	bound_height = 64

/obj/structure/ice_sign
	name = "湿婆之冰着陆点标牌"
	desc = "一块大标牌,上面写着'湿婆之冰着陆点 -',弹孔和撕裂的金属遮挡了其余部分."
	icon = 'icons/obj/landing_signs.dmi'
	icon_state = "ice_sign"
	bound_width = 64
	bound_height = 64

/obj/structure/dam_sign
	name = "千草着陆点标牌"
	desc = "一块大标牌,上面写着'千草采矿殖民地',标牌有一半是用日文写的."
	icon = 'icons/obj/landing_signs.dmi'
	icon_state = "dam_sign"
	bound_width = 64
	density = TRUE
	coverage = 15

/obj/structure/dam_sign/damaged
	desc = "一块大标牌,上面写着'千草采矿殖民-',其余部分被看起来像是干涸的血迹和损坏所遮挡."
	icon_state = "dam_sign"

/obj/structure/tachi_sign
	name = "太刀基地标牌"
	desc = "一块大标牌,上面写着'太刀基地位于谷神星V行星',并带有一面火星之子旗帜."
	icon = 'icons/obj/landing_signs.dmi'
	icon_state = "tachi_sign"
	bound_width = 64
	density = TRUE
	coverage = 15

/obj/structure/roci_sign
	name = "罗西南特基地标牌"
	desc = "一块大标牌,上面写着'罗西南特基地',并带有一面火星之子旗帜."
	icon = 'icons/obj/landing_signs.dmi'
	icon_state = "roci_sign"
	bound_width = 64
	density = TRUE
	coverage = 15
