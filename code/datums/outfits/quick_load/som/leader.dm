//Base SOM leader outfit
/datum/outfit/quick/som/squad_leader
	name = "SOM Squad Leader"
	jobtype = "SOM Squad Leader"

	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/leader/webbing
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/leader/valk
	gloves = /obj/item/clothing/gloves/marine/som/veteran
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som/leader
	glasses = /obj/item/clothing/glasses/hud/health
	r_pocket = /obj/item/storage/pouch/firstaid/som/combat_patrol_leader
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

/datum/outfit/quick/som/squad_leader/standard_assaultrifle
	name = "V-31 Squad Leader"
	desc = "战术实用型. 配备了V-31突击步枪, 带有集成\"微型榴弹\"轨道发射器, 带有\"瓦尔基里\"自动医疗模块的戈耳工重型装甲, 种类繁多的榴弹以及穿甲弹药. 对重装甲目标表现优异, 同时充足的榴弹提供了更大的战术灵活性."

	back = /obj/item/storage/backpack/lightpack/som
	suit_store = /obj/item/weapon/gun/rifle/som/veteran
	belt = /obj/item/storage/belt/marine/som/som_rifle_ap

	backpack_contents = list(
		/obj/item/explosive/plastique = 3,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta = 1,
		/obj/item/ammo_magazine/rifle/som/ap = 2,
		/obj/item/ammo_magazine/handful/micro_grenade = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/dragonbreath = 2,
		/obj/item/ammo_magazine/handful/micro_grenade/cluster = 2,
		/obj/item/ammo_magazine/handful/micro_grenade/smoke_burst = 1,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/cell/lasgun/volkite/small = 1,
		/obj/item/binoculars/fire_support/campaign/som = 1,
	)

/datum/outfit/quick/som/squad_leader/standard_smg
	name = "V-21 Squad Leader"
	desc = "近距离高伤害, 高速度. 配备了V-21冲锋枪, 其可变射速在正确使用时可实现极高的射速, 带有\"瓦尔基里\"自动医疗模块的戈耳工重型装甲, 种类丰富的榴弹和穿甲弹药. 可实现出色的近到中距离火力, 尤其是对重装甲目标, 并且机动性出奇地好."

	suit_store = /obj/item/weapon/gun/smg/som/veteran
	belt = /obj/item/storage/belt/marine/som/som_smg_ap

	backpack_contents = list(
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta = 1,
		/obj/item/cell/lasgun/volkite/small = 1,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/explosive/plastique = 2,
		/obj/item/ammo_magazine/smg/som/ap = 1,
		/obj/item/ammo_magazine/smg/som/incendiary = 2,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 3,
		/obj/item/explosive/grenade/flashbang/stun = 1,
		/obj/item/binoculars/fire_support/campaign/som = 1,
	)

/datum/outfit/quick/som/squad_leader/charger
	name = "Charger Squad Leader"
	desc = "献给喜欢近距离面对面作战的领导者. 配备了带有运动传感器和陀螺稳定器以便更好地单手使用的沃尔凯特充能枪, 带有\"瓦尔基里\"自动医疗模块的戈耳工重型装甲以及种类丰富的榴弹. 可实现出色的近到中距离火力, 并具有一流的生存能力. 非常危险."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/scout
	belt = /obj/item/storage/belt/marine/som/volkite

	backpack_contents = list(
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta = 1,
		/obj/item/cell/lasgun/volkite/small = 1,
		/obj/item/tool/extinguisher = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/cell/lasgun/volkite = 2,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/binoculars/fire_support/campaign/som = 1,
		/obj/item/explosive/grenade/flashbang/stun = 1,
		/obj/item/storage/box/mre/som = 1,
	)

/datum/outfit/quick/som/squad_leader/caliver
	name = "Caliver Squad Leader"
	desc = "以优势火力取胜. 配备了沃尔凯特步枪和运动传感器, 带有\"瓦尔基里\"自动医疗模块的戈耳工重型装甲以及种类丰富的榴弹. 可在所有距离上造成出色伤害, 并具有一流的生存能力. 非常危险."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/caliver/tacsensor
	belt = /obj/item/storage/belt/marine/som/volkite

	backpack_contents = list(
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta = 1,
		/obj/item/cell/lasgun/volkite/small = 1,
		/obj/item/tool/extinguisher = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/cell/lasgun/volkite = 2,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/binoculars/fire_support/campaign/som = 1,
		/obj/item/explosive/grenade/flashbang/stun = 1,
		/obj/item/storage/box/mre/som = 1,
	)

/datum/outfit/quick/som/squad_leader/mpi
	name = "MPI_KM Squad Leader"
	desc = "献给有怀旧情结的领导者. 配备了MPI_KM突击步枪, 带有下挂式榴弹发射器, 带有\"瓦尔基里\"自动医疗模块的戈耳工重型装甲以及大量榴弹. 这是一种旧式武器, 在最初的 Martian 叛乱期间很常见, MPI良好的停止力, 可靠性以及恰到好处的怀旧感意味着尽管它已经老旧, 在SOM中仍有一些人在使用."

	suit_store = /obj/item/weapon/gun/rifle/mpi_km/grenadier
	belt = /obj/item/storage/belt/marine/som/mpi_plum

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta = 1,
		/obj/item/cell/lasgun/volkite/small = 2,
		/obj/item/ammo_magazine/rifle/mpi_km/extended = 1,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/explosive/plastique = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 4,
		/obj/item/binoculars/fire_support/campaign/som = 1,
	)
