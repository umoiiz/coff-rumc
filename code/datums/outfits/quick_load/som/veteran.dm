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
	desc = "全副武装的SOM精英. 配备了V-31突击步枪, 带有集成\"微型榴弹\"轨道发射器, 重型装甲, 种类繁多的榴弹以及穿甲弹药. 对重装甲目标表现优异, 同时充足的榴弹提供了更大的战术灵活性."

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
	desc = "近距离高伤害, 高速度. 配备了V-21冲锋枪, 其可变射速在正确使用时可实现极高的射速, 重型装甲, 种类丰富的榴弹和穿甲弹药. 可实现出色的近到中距离火力, 尤其是对重装甲目标, 并且机动性出奇地好."

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
	desc = "重型装甲破门配置. 配备了为更好地单手使用而配置的沃尔凯特充能枪, 升级了\"洛里卡\"装甲加固的重型装甲, 一块登舰盾以及种类丰富的榴弹. 一流的防护和致命的近距离火力."

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
	desc = "全副武装的SOM精英. 配备了带有运动传感器和陀螺稳定器以便更好地单手使用的沃尔凯特充能枪, 重型装甲以及种类丰富的榴弹. 沃尔凯特武器异常危险, 尤其是对装甲薄弱或密集聚集的对手. 充能枪是SOM首屈一指的近/中距离武器, 具有良好的机动性, 并且可以(有些困难地)单手使用."

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
	desc = "全副武装的SOM精英. 配备了沃尔凯特步枪, 重型装甲以及种类丰富的榴弹. 沃尔凯特武器异常危险, 尤其是对装甲薄弱或密集聚集的对手. 步枪可在所有距离上提供致命火力. 谨慎接近."

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
	desc = "全副武装的SOM精英. 配备了带有运动传感器的沃尔凯特步枪, 重型装甲, 大量榴弹以及一个背挂式自充电电源. 沃尔凯特武器异常危险, 尤其是对装甲薄弱或密集聚集的对手. 步枪可在所有距离上提供致命火力, 而电源组允许持续射击一段时间, 尽管在长时间使用后, 充电可能难以跟上武器的需求."
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
	desc = "全副武装的SOM精英, 带有怀旧情结. 配备了MPI_KM突击步枪, 带有下挂式榴弹发射器以及大量榴弹. 这是一种旧式武器, 在最初的 Martian 叛乱期间很常见, MPI良好的停止力, 可靠性以及恰到好处的怀旧感意味着尽管它已经老旧, 在SOM中仍有一些人在使用."

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
	desc = "全副武装的SOM精英, 带有怀旧情结. 配备了祖传的V-34卡宾枪, 以及大量榴弹. 这是一种在最初的 Martian 叛乱期间被广泛使用的旧式武器, 这一把被保存下来并代代相传. V-34在很大程度上已被VX-32超越, 然而凭借其高口径弹药和良好的射速, 它不容小觑."

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
	desc = "重型装甲重型火力支援. 配备了沃尔凯特重炮和自充电背包电源组, 以及一把霰弹枪副武器. 重炮是SOM被观察到部署的最强大的单兵便携武器. 能够在长时间内倾泻巨大的火力. 尽管背挂式电源组是自充电的, 但它无法跟上该枪巨大的能量需求, 因此持续, 长时间的使用会大大降低武器的效能."
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
	desc = "战争罪行从未如此简单. 配备了V-71火箭筒以及燃烧弹头和辐射弹头, 还有一把使用放射性弹药的V-21冲锋枪, 带有\"米特里达梯\"环境保护系统的重型装甲, 以及辐射榴弹. 旨在让敌人心生恐惧, 并以致命的燃烧和辐射效果削弱他们, 提供出色的反步兵支援."
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
	desc = "电击近战突击兵种. 配备闪现驱动器和能量剑, 轻型护甲以及备用连发V-11. 闪现驱动器允许使用者进行短距离传送并承担一定风险, 但若使用得当, 可以让他们毫不费力地拉近距离斩杀敌人."
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
