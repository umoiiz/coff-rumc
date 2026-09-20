//Base SOM veteran outfit
/datum/outfit/quick/som/veteran
	name = "SOM Squad Veteran"
	jobtype = "SOM Squad Veteran"

	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/veteran/webbing
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/shield
	gloves = /obj/item/clothing/gloves/marine/som/veteran
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som/veteran
	glasses = /obj/item/clothing/glasses/meson
	r_pocket = /obj/item/storage/pouch/firstaid/som/combat_patrol
	l_pocket = /obj/item/storage/pouch/grenade/som/combat_patrol
	back = /obj/item/storage/backpack/satchel/som

	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
	)

	suit_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/isotonic = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
	)

/datum/outfit/quick/som/veteran/standard_assaultrifle
	name = "V-31 Veteran Infantryman"
	desc = "重装武装的SOM精英.配备一支V-31突击步枪,集成'微型榴弹'轨道发射器,重型护甲,大量各种手榴弹以及穿甲弹药.对重甲目标表现出色,同时充足的手榴弹提供了更强的战术灵活性."

	back = /obj/item/storage/backpack/lightpack/som
	suit_store = /obj/item/weapon/gun/rifle/som/veteran
	belt = /obj/item/storage/belt/marine/som/som_rifle_ap

	backpack_contents = list(
		/obj/item/explosive/plastique = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/ammo_magazine/rifle/som/ap = 2,
		/obj/item/explosive/grenade/som = 2,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/smoke_burst = 1,
	)
	webbing_contents = list(
		/obj/item/ammo_magazine/handful/micro_grenade = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/dragonbreath = 2,
		/obj/item/ammo_magazine/handful/micro_grenade/cluster = 2,
	)

/datum/outfit/quick/som/veteran/standard_smg
	name = "V-21 Veteran Infantryman"
	desc = "近距离高伤害,高速度.配备一支V-21冲锋枪,可变射速,在正确使用时能实现极高的射速,重型护甲,多种手榴弹以及穿甲弹药.可在近距离到中距离提供出色的火力,尤其是对抗重甲目标,并且机动性出奇地好."

	suit_store = /obj/item/weapon/gun/smg/som/veteran
	belt = /obj/item/storage/belt/marine/som/som_smg_ap

	backpack_contents = list(
		/obj/item/explosive/plastique = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/ammo_magazine/smg/som/ap = 3,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/incendiary/som = 1,
		/obj/item/explosive/grenade/flashbang/stun = 1,
		/obj/item/storage/box/mre/som = 1,
	)
/datum/outfit/quick/som/veteran/breacher
	name = "Charger Veteran Breacher"
	desc = "重甲破门配置.配备一支为更好地单手使用而配置的沃尔基特充能枪,升级有'洛里卡'护甲增强的重型护甲,一面登舰盾以及多种手榴弹.顶级防护和致命的近距离火力."

	head = /obj/item/clothing/head/modular/som/lorica
	glasses = /obj/item/clothing/glasses/welding/flipped
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/lorica
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/somvet
	belt = /obj/item/storage/belt/marine/som/volkite
	r_hand = /obj/item/weapon/shield/riot/marine/som

	backpack_contents = list(
		/obj/item/tool/weldingtool/largetank = 1,
		/obj/item/explosive/plastique = 6,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/explosive/grenade/incendiary/som = 1,
		/obj/item/tool/extinguisher/mini = 1,
	)

/datum/outfit/quick/som/veteran/charger
	name = "Charger Veteran Infantryman"
	desc = "重装武装的SOM精英.配备一支沃尔基特充能枪,带有运动传感器和陀螺稳定器以便更好地单手使用,重型护甲以及多种手榴弹.沃尔基特武器异常危险,尤其是对抗护甲薄弱或密集聚集的敌人.充能枪是SOM首屈一指的近/中距离武器,机动性良好,可(有些困难地)单手使用."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/scout
	belt = /obj/item/storage/belt/marine/som/volkite

	backpack_contents = list(
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/cell/lasgun/volkite = 2,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/incendiary/som = 1,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/storage/box/mre/som = 1,
	)

/datum/outfit/quick/som/veteran/caliver
	name = "Caliver Veteran Infantryman"
	desc = "重装武装的SOM精英.配备一支沃尔基特步枪,重型护甲以及多种手榴弹.沃尔基特武器异常危险,尤其是对抗护甲薄弱或密集聚集的敌人.步枪在所有距离都能提供致命的火力.谨慎接近."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/caliver/standard
	belt = /obj/item/storage/belt/marine/som/volkite

	backpack_contents = list(
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/explosive/plastique = 3,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/incendiary/som = 1,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/storage/box/mre/som = 1,
	)

/datum/outfit/quick/som/veteran/caliver_pack
	name = "Caliver Veteran Rifleman"
	desc = "重装武装的SOM精英.配备一支沃尔基特步枪,带有运动传感器,重型护甲,大量手榴弹以及一个背部自充电电源.沃尔基特武器异常危险,尤其是对抗护甲薄弱或密集聚集的敌人.步枪在所有距离都能提供致命的火力,而电源组允许持续射击,尽管在长时间使用后充电可能难以跟上武器的需求."
	quantity = 2

	belt = /obj/item/storage/belt/grenade/som
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/caliver/tacsensor
	l_pocket = /obj/item/storage/pouch/pistol/som
	back = /obj/item/cell/lasgun/volkite/powerpack

	webbing_contents = list(
		/obj/item/ammo_magazine/pistol/som = 3,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/storage/box/mre/som = 1,
	)
	belt_contents = list(
		/obj/item/explosive/grenade/smokebomb/som = 2,
		/obj/item/explosive/grenade/smokebomb/satrapine = 2,
		/obj/item/explosive/grenade/flashbang/stun = 2,
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/incendiary/som = 1,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
	)

/datum/outfit/quick/som/veteran/mpi
	name = "MPI_KM Veteran Infantryman"
	desc = "重装武装的SOM精英,带有怀旧口味.配备一支MPI_KM突击步枪,带有下挂式榴弹发射器以及大量手榴弹.一种在最初的火星叛乱期间常见的旧式武器,MPI良好的停止作用,可靠性以及恰到好处的怀旧感意味着尽管它已经老旧,在SOM中仍有人使用."

	suit_store = /obj/item/weapon/gun/rifle/mpi_km/grenadier
	belt = /obj/item/storage/belt/marine/som/mpi_plum

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/ammo_magazine/rifle/mpi_km/extended = 1,
		/obj/item/tool/extinguisher = 1,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 4,
		/obj/item/explosive/grenade/incendiary/som = 1,
	)

/datum/outfit/quick/som/veteran/carbine
	name = "V-34 Veteran Infantryman"
	desc = "重装武装的SOM精英,带有怀旧口味.配备一支传家宝V-34卡宾枪以及大量手榴弹.一种在最初的火星叛乱期间被广泛使用的旧式武器,这一支被保存下来并代代相传.V-34在很大程度上已被VX-32超越,然而凭借其高口径弹药和良好的射速,它不可被低估."

	suit_store = /obj/item/weapon/gun/rifle/som_carbine/mag_harness
	belt = /obj/item/storage/belt/marine/som/carbine

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/ammo_magazine/rifle/mpi_km/carbine = 1,
		/obj/item/tool/extinguisher = 1,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 4,
		/obj/item/explosive/grenade/incendiary/som = 1,
	)

/datum/outfit/quick/som/veteran/culverin
	name = "Culverin Veteran Machinegunner"
	desc = "重甲重型火力支援.配备一支沃尔基特重机枪和自充电背包电源组,以及一支霰弹枪副武器.重机枪是SOM被观察到部署的最强大的单兵便携武器.能够在长时间内倾泻巨大的火力.尽管背挂式电源组是自充电的,但它无法跟上该枪巨大的能量需求,因此持续,长时间的使用会大大降低武器的效能."
	quantity = 2

	belt = /obj/item/weapon/gun/shotgun/double/sawn
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/culverin/magharness
	back = /obj/item/cell/lasgun/volkite/powerpack

	webbing_contents = list(
		/obj/item/ammo_magazine/handful/buckshot = 3,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/storage/box/mre/som = 1,
	)

/datum/outfit/quick/som/veteran/rocket_man
	name = "V-71 Rocket Veteran"
	desc = "战争罪行从未如此简单.配备一支V-71火箭筒,带有燃烧弹头和辐射弹头,以及一支使用放射性弹药的V-21冲锋枪,带有'米特拉达梯'环境保护系统的重型护甲,以及辐射手榴弹.旨在让敌人心生恐惧,并以致命的燃烧和辐射效果削弱他们,提供出色的反步兵支援."
	quantity = 2

	head = /obj/item/clothing/head/modular/som/bio
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/mithridatius
	suit_store = /obj/item/weapon/gun/smg/som/support
	belt = /obj/item/storage/belt/marine/som
	back = /obj/item/storage/holster/backholster/rpg/som/war_crimes
	l_pocket = /obj/item/storage/pouch/grenade/som

	belt_contents = list(
		/obj/item/ammo_magazine/smg/som = 2,
		/obj/item/ammo_magazine/smg/som/rad = 4,
	)
	l_pocket_contents = list(
		/obj/item/explosive/grenade/smokebomb/satrapine = 3,
		/obj/item/explosive/grenade/rad = 3,
	)
	webbing_contents = list(
		/obj/item/ammo_magazine/packet/p10x20mm = 1,
		/obj/item/ammo_magazine/smg/som/incendiary = 1,
		/obj/item/binoculars = 1,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/storage/box/mre/som = 1,
	)

/datum/outfit/quick/som/veteran/blinker
	name = "Blink Assault Veteran"
	desc = "冲击近战突击职业.配备一个闪现驱动器和一把能量剑,轻型护甲以及一支备用点射型V-11.闪现驱动器允许短距离传送,对使用者有一定风险,但正确使用时能让他们毫不费力地拉近距离斩杀敌人."
	quantity = 2

	wear_suit = /obj/item/clothing/suit/modular/som/light/shield
	belt = /obj/item/storage/holster/belt/pistol/m4a3/som
	suit_store = /obj/item/weapon/energy/sword/som
	back = /obj/item/blink_drive

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 3,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/storage/box/mre/som = 1,
	)
	belt_contents = list(
		/obj/item/ammo_magazine/pistol/som/extended = 6,
		/obj/item/weapon/gun/pistol/som/burst = 1,
	)
