/datum/supply_packs/explosives
	containertype = /obj/structure/closet/crate/ammo
	group = "爆炸物"

/datum/supply_packs/explosives/explosives_mines
	name = "克莱莫地雷"
	notes = "Contains 5 mines"
	contains = list(/obj/item/storage/box/explosive_mines)
	cost = 150

/datum/supply_packs/explosives/explosives_minelayer
	name = "M21 APRDS \"布雷器\""
	contains = list(/obj/item/minelayer)
	cost = 50

/datum/supply_packs/explosives/explosives_razor
	name = "剃刀燃烧手榴弹箱"
	notes = "Contains 15 razor burns"
	contains = list(/obj/item/storage/box/visual/grenade/razorburn)
	cost = 500

/datum/supply_packs/explosives/stickytanglenades
	name = "M45-T粘性绊足手榴弹"
	notes = "Contains 25 M45-T sticky grenade"
	contains = list(/obj/item/storage/box/visual/grenade/drain/sticky)
	cost = 300

/datum/supply_packs/explosives/explosives_antigas
	name = "M40-AG防毒手榴弹箱"
	notes = "Cotains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/antigas)
	cost = 700

/datum/supply_packs/explosives/explosives_sticky
	name = "M40粘性炸药手榴弹箱"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/sticky)
	cost = 310

/datum/supply_packs/explosives/explosives_smokebomb
	name = "M40 HSDP烟雾弹手榴弹箱"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/smokebomb)
	cost = 310

/datum/supply_packs/explosives/explosives_hedp
	name = "M40 HEDP高爆手榴弹箱"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/frag)
	cost = 310

/datum/supply_packs/explosives/explosives_cloaker
	name = "M45隐形手榴弹箱"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/cloaker)
	cost = 310

/datum/supply_packs/explosives/explosives_cloak
	name = "M40-2 SCDP手榴弹箱"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/cloak)
	cost = 310

/datum/supply_packs/explosives/explosives_lasburster
	name = "M80激光爆裂手榴弹箱"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/lasburster)
	cost = 310

/datum/supply_packs/explosives/explosives_hidp
	name = "M40 HIDP燃烧爆炸手榴弹箱"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/incendiary)
	cost = 350

/datum/supply_packs/explosives/explosives_m15
	name = "M15破片手榴弹箱"
	notes = "Contains 15 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/m15)
	cost = 350

/datum/supply_packs/explosives/explosives_trailblazer
	name = "M45开拓者手榴弹箱"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/trailblazer)
	cost = 350

/datum/supply_packs/explosives/explosives_hsdp
	name = "M40 HSDP白磷手榴弹箱"
	notes = "Contains 15 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/phosphorus)
	cost = 700

/datum/supply_packs/explosives/explosives_hefa
	name = "M25 HEFA手榴弹箱"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/hefa)
	cost = 550

/datum/supply_packs/explosives/explosives_plasmadrain
	name = "M40-T毒气手榴弹箱"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/drain)
	cost = 700

/datum/supply_packs/explosives/boomvest
	name = "炸弹背心"
	contains = list(/obj/item/clothing/suit/storage/marine/boomvest)
	cost = 2000

/datum/supply_packs/explosives/plastique
	name = "C4塑胶炸药"
	contains = list(/obj/item/explosive/plastique)
	cost = 30

/datum/supply_packs/explosives/plastique_incendiary
	name = "EX-62成吉思燃烧弹"
	contains = list(/obj/item/explosive/plastique/genghis_charge)
	cost = 150

/datum/supply_packs/explosives/detpack
	name = "定时炸弹"
	contains = list(/obj/item/explosive/plastique/detpack)
	cost = 50

/datum/supply_packs/explosive/plastique_trench
	name = "战壕炸药"
	contains = list(/obj/item/explosive/plastique/trench)
	cost = 30

/datum/supply_packs/explosive/detpack_trench
	name = "改良战壕炸药"
	contains = list(/obj/item/explosive/plastique/detpack/trench)
	cost = 50

/datum/supply_packs/explosives/mortar
	name = "T-50S迫击炮箱"
	contains = list(/obj/item/mortar_kit)
	cost = 250

/datum/supply_packs/explosives/mortar_ammo_he
	name = "T-50S迫击炮高爆弹 (x2)"
	contains = list(/obj/item/mortal_shell/he, /obj/item/mortal_shell/he)
	cost = 10

/datum/supply_packs/explosives/mortar_ammo_incend
	name = "T-50S迫击炮燃烧弹 (x2)"
	contains = list(/obj/item/mortal_shell/incendiary, /obj/item/mortal_shell/incendiary)
	cost = 10

/datum/supply_packs/explosives/mortar_ammo_flare
	name = "T-50S迫击炮照明弹 (x2)"
	notes = "Can be fired out of the MG-100Y howitzer, as well."
	contains = list(/obj/item/mortal_shell/flare, /obj/item/mortal_shell/flare)
	cost = 5

/datum/supply_packs/explosives/mortar_ammo_smoke
	name = "T-50S迫击炮烟雾弹 (x2)"
	contains = list(/obj/item/mortal_shell/smoke, /obj/item/mortal_shell/smoke)
	cost = 5

/datum/supply_packs/explosives/mortar_ammo_plasmaloss
	name = "T-50S迫击炮绊索弹"
	contains = list(/obj/item/mortal_shell/plasmaloss)
	cost = 10

/datum/supply_packs/explosives/mlrs
	name = "TA-40L多管火箭系统"
	contains = list(/obj/item/mortar_kit/mlrs)
	cost = 450

/datum/supply_packs/explosives/mlrs_rockets
	name = "TA-40L多管火箭弹包 (x16)"
	contains = list(/obj/item/storage/box/mlrs_rockets)
	cost = 40

/datum/supply_packs/explosives/mlrs_rockets_gas
	name = "TA-40L X-50多管火箭弹包 (x16)"
	contains = list(/obj/item/storage/box/mlrs_rockets_gas)
	cost = 50

/datum/supply_packs/explosives/mlrs_rockets_tangle
	name = "TA-40L T-33多管火箭弹包 (x16)"
	contains = list(/obj/item/storage/box/mlrs_rockets_tangle)
	cost = 50

/datum/supply_packs/explosives/ai_target_module
	name = "AI火炮瞄准模块"
	contains = list(/obj/item/ai_target_beacon)
	cost = 50
	crash_restricted = TRUE

/datum/supply_packs/explosives/knee_mortar
	name = "T-10K膝部迫击炮"
	contains = list(/obj/item/mortar_kit/knee)
	cost = 50

/datum/supply_packs/explosives/knee_mortar_ammo
	name = "TA-10K膝部迫击炮高爆弹"
	contains = list(/obj/item/mortal_shell/knee, /obj/item/mortal_shell/knee)
	cost = 5

/datum/supply_packs/explosives/explosives_trailblazer_phosphorus
	name = "M45白磷开路手雷箱"
	notes = "Contains 25 grenades"
	contains = list(/obj/item/storage/box/visual/grenade/trailblazer/phosphorus)
	cost = 600

/datum/supply_packs/explosives/howitzer
	name = "TA-100Y榴弹炮"
	contains = list(/obj/item/mortar_kit/howitzer)
	cost = 500

/datum/supply_packs/explosives/howitzer_ammo_he
	name = "TA-100Y榴弹炮高爆弹"
	contains = list(/obj/item/mortal_shell/howitzer/he)
	cost = 30

/datum/supply_packs/explosives/howitzer_ammo_incend
	name = "TA-100Y榴弹炮燃烧弹"
	contains = list(/obj/item/mortal_shell/howitzer/incendiary)
	cost = 30

/datum/supply_packs/explosives/howitzer_ammo_wp
	name = "TA-100Y榴弹炮白磷烟雾弹"
	contains = list(/obj/item/mortal_shell/howitzer/white_phos)
	cost = 45

/datum/supply_packs/explosives/howitzer_ammo_plasmaloss
	name = "TA-100Y榴弹炮绊索弹"
	contains = list(/obj/item/mortal_shell/howitzer/plasmaloss)
	cost = 45
