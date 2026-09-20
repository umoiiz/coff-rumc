/datum/supply_packs/weapons
	group = "武器"
	containertype = /obj/structure/closet/crate/weapon

/datum/supply_packs/weapons/tesla
	name = "特斯拉电击步枪"
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/tesla)
	cost = 600

/datum/supply_packs/weapons/e50
	name = "E-50 激光发射器"
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/e50)
	cost = 400

/datum/supply_packs/weapons/tx55
	name = "AR-55 理想单兵战斗武器步枪"
	contains = list(/obj/item/weapon/gun/rifle/tx55)
	cost = 525

/datum/supply_packs/weapons/pepperball
	name = "PB-12 胡椒球枪"
	contains = list(/obj/item/weapon/gun/rifle/pepperball)
	cost = 100

/datum/supply_packs/weapons/b11
	name = "B11 智能瞄准镜"
	contains = list(/obj/item/attachable/b11_scope)
	cost = 150

/datum/supply_packs/weapons/b15
	name = "B15 智能瞄准镜"
	contains = list(/obj/item/attachable/b15_scope)
	cost = 150

/datum/supply_packs/weapons/railgun
	name = "SR-220 磁轨炮"
	contains = list(/obj/item/weapon/gun/rifle/railgun)
	cost = 400

/datum/supply_packs/weapons/railgun_ammo
	name = "SR-220 磁轨炮脱壳穿甲弹 APDS 弹"
	contains = list(/obj/item/ammo_magazine/railgun)
	cost = 50

/datum/supply_packs/weapons/railgun_ammo/hvap
	name = "SR-220 磁轨炮高速穿甲弹 HVAP 弹"
	contains = list(/obj/item/ammo_magazine/railgun/hvap)
	cost = 50

/datum/supply_packs/weapons/railgun_ammo/smart
	name = "SR-220 磁轨炮智能穿甲弹 SAP 弹"
	contains = list(/obj/item/ammo_magazine/railgun/smart)
	cost = 50

/datum/supply_packs/weapons/tx8
	name = "BR-8 侦察步枪"
	contains = list(/obj/item/weapon/gun/rifle/tx8)
	cost = 400

/datum/supply_packs/weapons/scout_regular
	name = "BR-8 侦察步枪弹匣"
	contains = list(/obj/item/ammo_magazine/rifle/tx8)
	cost = 20

/datum/supply_packs/weapons/scout_regular_box
	name = "BR-8 侦察步枪弹药箱"
	contains = list(/obj/item/ammo_magazine/packet/scout_rifle)
	cost = 50

/datum/supply_packs/weapons/scout_impact
	name = "BR-8 侦察步枪冲击弹匣"
	contains = list(/obj/item/ammo_magazine/rifle/tx8/impact)
	cost = 40

/datum/supply_packs/weapons/scout_impact_box
	name = "BR-8 侦察步枪冲击弹药箱"
	contains = list(/obj/item/ammo_magazine/packet/scout_rifle/impact)
	cost = 100

/datum/supply_packs/weapons/scout_incendiary
	name = "BR-8 侦察步枪燃烧弹匣"
	contains = list(/obj/item/ammo_magazine/rifle/tx8/incendiary)
	cost = 40

/datum/supply_packs/weapons/scout_incendiary_box
	name = "BR-8 侦察步枪燃烧弹药箱"
	contains = list(/obj/item/ammo_magazine/packet/scout_rifle/incendiary)
	cost = 100

/datum/supply_packs/weapons/zx76
	name = "ZX-76 双管点射霰弹枪"
	contains = list(/obj/item/weapon/gun/shotgun/zx76)
	cost = 1000

/datum/supply_packs/weapons/shotguntracker
	name = "12号口径追踪弹"
	contains = list(/obj/item/ammo_magazine/shotgun/tracker)
	cost = 50

/datum/supply_packs/weapons/incendiaryslugs
	name = "燃烧独头弹盒"
	contains = list(/obj/item/ammo_magazine/shotgun/incendiary)
	cost = 100

/datum/supply_packs/weapons/sr81
	name = "SR-81 敌我识别自动狙击套件"
	contains = list(/obj/item/weapon/gun/rifle/sr81)
	cost = 500

/datum/supply_packs/weapons/sr81_ammo
	name = "SR-81 敌我识别狙击弹匣"
	contains = list(/obj/item/ammo_magazine/rifle/sr81)
	cost = 30

/datum/supply_packs/weapons/sr81_packet
	name = "SR-81 敌我识别狙击弹药箱"
	contains = list(/obj/item/ammo_magazine/packet/sr81)
	cost = 50

/datum/supply_packs/weapons/antimaterial
	name = "SR-26 反器材步枪 (AMR) 套件"
	contains = list(/obj/item/weapon/gun/rifle/sniper/antimaterial)
	cost = 775

/datum/supply_packs/weapons/antimaterial_ammo
	name = "SR-26 反器材步枪弹匣"
	contains = list(/obj/item/ammo_magazine/sniper)
	cost = 30

/datum/supply_packs/weapons/antimaterial_incend_ammo
	name = "SR-26 反器材步枪燃烧弹匣"
	contains = list(/obj/item/ammo_magazine/sniper/incendiary)
	cost = 50

/datum/supply_packs/weapons/antimaterial_flak_ammo
	name = "SR-26 反器材步枪高射弹匣"
	contains = list(/obj/item/ammo_magazine/sniper/flak)
	cost = 40

/datum/supply_packs/weapons/specminigun
	name = "MG-100 维护者加特林机枪"
	contains = list(/obj/item/weapon/gun/minigun)
	cost = MINIGUN_PRICE

/datum/supply_packs/weapons/minigun
	name = "MG-100 维护者加特林机枪电源包"
	contains = list(/obj/item/ammo_magazine/minigun_powerpack)
	cost = 50

/datum/supply_packs/weapons/flamethrower
	name = "FL-84 喷火器"
	contains = list(/obj/item/weapon/gun/flamer/big_flamer/marinestandard)
	cost = 150

/datum/supply_packs/weapons/napalm
	name = "FL-84 标准燃料罐"
	contains = list(/obj/item/ammo_magazine/flamer_tank/large)
	cost = 60

/datum/supply_packs/weapons/napalm_G
	name = "FL-84 G燃料罐"
	contains = list(/obj/item/ammo_magazine/flamer_tank/large/G)
	cost = 75

/datum/supply_packs/weapons/napalm_X
	name = "FL-84 X燃料罐"
	contains = list(/obj/item/ammo_magazine/flamer_tank/large/X)
	cost = 300

/datum/supply_packs/weapons/back_fuel_tank
	name = "标准背包燃料罐"
	contains = list(/obj/item/ammo_magazine/flamer_tank/backtank)
	cost = 200

/datum/supply_packs/weapons/back_fuel_tank_g
	name = "G燃料罐"
	contains = list(/obj/item/ammo_magazine/flamer_tank/backtank/G)
	cost = 150

/datum/supply_packs/weapons/back_fuel_tank_x
	name = "X燃料背包罐"
	contains = list(/obj/item/ammo_magazine/flamer_tank/backtank/X)
	cost = 600

/datum/supply_packs/weapons/mini_fuel_tank_g
	name = "G燃料迷你罐"
	contains = list(/obj/item/ammo_magazine/flamer_tank/mini/G)
	cost = 5

/datum/supply_packs/weapons/mini_fuel_tank_x
	name = "X燃料迷你罐"
	contains = list(/obj/item/ammo_magazine/flamer_tank/mini/X)
	cost = 20

/datum/supply_packs/weapons/fueltank_g
	name = "G燃料罐"
	contains = list(/obj/structure/reagent_dispensers/fueltank/gfuel)
	cost = 150
	containertype = null

/datum/supply_packs/weapons/fueltank
	name = "X燃料罐"
	contains = list(/obj/structure/reagent_dispensers/fueltank/xfuel)
	cost = 600
	containertype = null

/datum/supply_packs/weapons/mateba
	name = "Mateba 自动左轮手枪弹链"
	contains = list(/obj/item/storage/holster/belt/revolver/mateba/full)
	notes = "Contains 6 speedloaders"
	cost = 150

/datum/supply_packs/weapons/mateba_ammo
	name = "Mateba 弹匣"
	contains = list(/obj/item/ammo_magazine/revolver/mateba)
	cost = 30

/datum/supply_packs/weapons/mateba_packet
	name = "Mateba 弹药包"
	contains = list(/obj/item/ammo_magazine/packet/mateba)
	cost = 120

/datum/supply_packs/weapons/sr127_flak
	name = "SR-127 高射弹匣"
	contains = list(/obj/item/ammo_magazine/rifle/sr127/flak)
	cost = 50

/datum/supply_packs/weapons/rechargemag
	name = "Terra Experimental TE-X 充电电池"
	contains = list(/obj/item/cell/lasgun/lasrifle/recharger)
	cost = 60

/datum/supply_packs/weapons/xray_gun
	name = "Terra Experimental TE-X 激光步枪"
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/xray)
	cost = 500

/datum/supply_packs/weapons/rocketsledge
	name = "火箭大锤"
	contains = list(/obj/item/weapon/twohanded/sledgehammer/rocketsledge)
	cost = 600

/datum/supply_packs/weapons/chainsaw
	name = "电锯"
	contains = list(/obj/item/weapon/twohanded/chainsaw)
	cost = 500

/datum/supply_packs/weapons/vector_incendiary
	name = "维克托燃烧弹匣"
	contains = list(/obj/item/ammo_magazine/smg/vector/incendiary)
	cost = 20 //40 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/valihalberd
	name = "VAL-HAL-A"
	contains = list(/obj/item/weapon/twohanded/glaive/halberd/harvester)
	cost = 600

/datum/supply_packs/weapons/t500case
	name = "R-500捆绑包"
	contains = list(/obj/item/storage/briefcase/t500)
	cost = 50

/datum/supply_packs/weapons/r76case
	name = "R76捆绑包"
	contains = list(/obj/item/storage/briefcase/standard_magnum)
	cost = 120

/datum/supply_packs/weapons/r76_speedloader
	name = "R76快速装弹器 (x4)"
	contains = list(
		/obj/item/ammo_magazine/revolver/standard_magnum,
		/obj/item/ammo_magazine/revolver/standard_magnum,
		/obj/item/ammo_magazine/revolver/standard_magnum,
		/obj/item/ammo_magazine/revolver/standard_magnum,
	)
	cost = 40

/datum/supply_packs/weapons/ar12_incendiary
	name = "AR-12燃烧弹匣"
	contains = list(/obj/item/ammo_magazine/rifle/ar12/incendiary)
	cost = 30 //50 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/type16_extended_mag
	name = "16式扩容弹匣"
	contains = list(/obj/item/ammo_magazine/rifle/type16/extended)
	cost = 15
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/ar21_extended_mag
	name = "AR-21扩容弹匣"
	contains = list(/obj/item/ammo_magazine/rifle/ar21/extended)
	cost = 50 //50 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/p9mm_incendiary
	name = "9毫米燃烧弹包"
	contains = list(/obj/item/ammo_magazine/packet/p9mm/incendiary)
	cost = 30 //70 rounds
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/weapons/plasma_cells
	name = "WML等离子能量电池 (x3)"
	contains = list(
		/obj/item/cell/lasgun/plasma,
		/obj/item/cell/lasgun/plasma,
		/obj/item/cell/lasgun/plasma,
	)
	cost = 100

/datum/supply_packs/weapons/plasma_smg
	name = "PL-51等离子冲锋枪"
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma/smg)
	cost = 400

/datum/supply_packs/weapons/plasma_rifle
	name = "PL-38等离子步枪"
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma/rifle)
	cost = 350

/datum/supply_packs/weapons/plasma_cannon
	name = "PL-96等离子炮"
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma/cannon)
	cost = 400
