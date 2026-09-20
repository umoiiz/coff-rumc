/obj/item/ammo_magazine/revolver
	name = "\improper R-44 马格南快速装弹器 (.44)"
	desc = "一个左轮快速装弹器."
	default_ammo = /datum/ammo/bullet/revolver
	equip_slot_flags = NONE
	caliber = CALIBER_44
	icon = 'icons/obj/items/ammo/revolver.dmi'
	icon_state = "m44"
	icon_state_mini = "mag_revolver_bronze"
	w_class = WEIGHT_CLASS_SMALL
	max_rounds = 6

/obj/item/ammo_magazine/revolver/rifle
	name = "\improper M1855 快速装弹器 (.44LS)"
	desc = "一个用于 M1855 的快速装弹器, 采用特殊设计使步枪快速装弹成为可能. .44 马格南的加长版本, 带有铀钕核心."
	icon_state = "44LS"
	default_ammo = /datum/ammo/bullet/revolver/rifle
	caliber = CALIBER_44LS
	max_rounds = 8

/obj/item/ammo_magazine/revolver/t500
	name = "\improper R-500 快速装弹器 (.500)"
	icon_state = "t500"
	desc = "一个 R-500 'Nigredo' 左轮快速装弹器."
	default_ammo = /datum/ammo/bullet/revolver/t500
	caliber = CALIBER_500
	max_rounds = 5

/obj/item/ammo_magazine/revolver/t500/slavs
	name = "\improper R-500 快速装弹器 (.500 'Slavs')"
	icon_state = "t500_sv"
	default_ammo = /datum/ammo/bullet/revolver/t500/slavs

/obj/item/ammo_magazine/revolver/t312
	name = "\improper R-312 白色快车快速装弹器 (.500)"
	desc = "一个 R-312 'Albedo' 左轮快速装弹器."
	icon_state = "t500_we"
	default_ammo = /datum/ammo/bullet/revolver/t312
	caliber = CALIBER_500_EMB
	max_rounds = 5

/obj/item/ammo_magazine/revolver/t312/med
	name = "R-312 EMB 快速装弹器"
	desc = "一个 R-500 'Albedo' 左轮快速装弹器."

/obj/item/ammo_magazine/revolver/t312/med/adrenaline
	name = "R-312 肾上腺素 EMB 快速装弹器"
	icon_state = "t500_adr"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/adrenaline

/obj/item/ammo_magazine/revolver/t312/med/rr
	name = "R-312 俄罗斯红 EMB 快速装弹器"
	icon_state = "t500_rr"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/rr

/obj/item/ammo_magazine/revolver/t312/med/md
	name = "R-312 美拉德姆 EMB 快速装弹器"
	icon_state = "t500_md"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/md

/obj/item/ammo_magazine/revolver/t312/med/neu
	name = "R-312 神经碱 EMB 快速装弹器"
	icon_state = "t500_neu"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/neu

/obj/item/ammo_magazine/revolver/marksman
	name = "\improper R-44 精确射手快速装弹器 (.44)"
	default_ammo = /datum/ammo/bullet/revolver/marksman
	caliber = CALIBER_44
	icon_state = "m_m44"
	icon_state_mini = "mag_revolver_bronze_red"

/obj/item/ammo_magazine/revolver/heavy
	name = "\improper R-44 PW-MX 快速装弹器 (.44)"
	default_ammo = /datum/ammo/bullet/revolver/heavy
	caliber = CALIBER_44
	icon_state = "h_m44"
	icon_state_mini = "mag_revolver_bronze_purple"

/obj/item/ammo_magazine/revolver/r44
	name = "\improper R-44 马格南快速装弹器 (.44)"
	desc = "一个左轮快速装弹器."
	default_ammo = /datum/ammo/bullet/revolver/r44
	equip_slot_flags = NONE
	caliber = CALIBER_44
	icon_state = "tp44"
	icon_state_mini = "mag_revolver"
	w_class = WEIGHT_CLASS_SMALL
	max_rounds = 7

/obj/item/ammo_magazine/revolver/upp
	name = "\improper N-Y 快速装弹器 (7.62x38mmR)"
	default_ammo = /datum/ammo/bullet/revolver/small
	caliber = CALIBER_762X38
	icon_state = "ny762"
	icon_state_mini = "mag_revolver_blue"
	max_rounds = 7

/obj/item/ammo_magazine/revolver/small
	name = "\improper 'Bote' .357 快速装弹器 (.357)"
	desc = "一个左轮快速装弹器, 装填特殊 357 弹, 命中时会弹跳. 在朋友和家人身边要小心!"
	default_ammo = /datum/ammo/bullet/revolver/ricochet/four
	caliber = CALIBER_357
	icon_state = "sw357"
	icon_state_mini = "mag_revolver_greyred"
	max_rounds = 6

/obj/item/ammo_magazine/revolver/mateba
	name = "\improper Mateba 快速装弹器 (.454)"
	default_ammo = /datum/ammo/bullet/revolver/highimpact
	caliber = CALIBER_454
	icon_state = "mateba"
	icon_state_mini = "mag_revolver"
	max_rounds = 6

/obj/item/ammo_magazine/revolver/cmb
	name = "\improper CMB 左轮快速装弹器 (.357)"
	default_ammo = /datum/ammo/bullet/revolver/small
	caliber = CALIBER_357
	icon_state = "cmb"
	icon_state_mini = "mag_revolver_greypurple"
	max_rounds = 6

/obj/item/ammo_magazine/revolver/judge
	name = "\improper Judge 快速装弹器 (.45L)"
	desc = "一个用于 Judge 的左轮快速装弹器, 这些弹药使用高初速发射药, 几乎没有散布和衰减."
	default_ammo = /datum/ammo/bullet/revolver/judge
	caliber = CALIBER_45L
	max_rounds = 5
	icon_state = "m_m44"
	icon_state_mini = "mag_revolver_bronze_red"

/obj/item/ammo_magazine/revolver/judge/buckshot
	name = "\improper Judge 鹿弹快速装弹器 (.45L)"
	desc = "一个用于 Judge 的左轮快速装弹器, 内部装满细小弹丸, 散布大但近战伤害高."
	default_ammo = /datum/ammo/bullet/shotgun/mbx900_buckshot
	caliber = CALIBER_45L
	icon_state = "h_m44"
	icon_state_mini = "mag_revolver_bronze_purple"

/obj/item/ammo_magazine/revolver/standard_magnum
	name = "\improper R-76 快速装弹器 (12x7mm)"
	desc = "一个用于 R-76 马格南的左轮快速装弹器, 注意你的肩膀, 命中时会使大多数中等体型目标眩晕."
	default_ammo = /datum/ammo/bullet/revolver/t76
	max_rounds = 5
	caliber = CALIBER_12X7
	icon_state = "t76"
	icon_state_mini = "mag_revolver_red"
