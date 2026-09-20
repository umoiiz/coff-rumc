//Base SOM engineer outfit
/datum/outfit/quick/som/engineer
	name = "SOM Squad Engineer"
	jobtype = "SOM Squad Engineer"

	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/webbing
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som/engineer
	gloves = /obj/item/clothing/gloves/marine/som/insulated
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som/engineer
	glasses = /obj/item/clothing/glasses/meson
	r_pocket = /obj/item/storage/pouch/firstaid/som/combat_patrol
	l_pocket = /obj/item/storage/pouch/tools/som/full
	back = /obj/item/storage/backpack/lightpack/som

	head_contents = list(
		/obj/item/explosive/plastique = 1,
	)

	suit_contents = list(
		/obj/item/circuitboard/apc = 1,
		/obj/item/cell/high = 1,
		/obj/item/stack/sheet/plasteel/medium_stack = 1,
		/obj/item/stack/sheet/metal/large_stack = 1,
		/obj/item/stack/barbed_wire/half_stack = 1,
	)

/datum/outfit/quick/som/engineer/standard_assaultrifle
	name = "V-31 Engineer"
	desc = "战场工程师;建造与拆除.配备一支V-31突击步枪,集成'微型榴弹'轨道发射器,中型护甲,一个可部署的COPE哨戒炮以及多种爆炸物.拥有各种补给和装备,可在战场上建造,维修或实施爆破.对于一支全面发展的战斗部队来说,是宝贵的支援资产.轨道发射器发射的榴弹必须在飞行途中解除保险,因此在近距离无效,但在中距离可提供重要的战术选择."

	suit_store = /obj/item/weapon/gun/rifle/som/standard
	belt = /obj/item/storage/belt/marine/som/som_rifle

	backpack_contents = list(
		/obj/item/tool/extinguisher = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/explosive/plastique/detpack = 4,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope = 1,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/plastique = 2,
	)

	webbing_contents = list(
		/obj/item/ammo_magazine/handful/micro_grenade = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/dragonbreath = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/cluster = 2,
		/obj/item/explosive/grenade/smokebomb/satrapine = 1,
	)

/datum/outfit/quick/som/engineer/mpi
	name = "MPI-KM Engineer"
	desc = "战场工程师;建造与拆除.配备一支MPI_KM突击步枪,中型护甲,一个可部署的COPE哨戒炮以及多种爆炸物.拥有各种补给和装备,可在战场上建造,维修或实施爆破.对于一支全面发展的战斗部队来说,是宝贵的支援资产.一种在最初的火星叛乱期间常见的旧式武器,MPI良好的停止作用,可靠性以及恰到好处的怀旧感意味着尽管它已经老旧,在SOM中仍有人使用."

	suit_store = /obj/item/weapon/gun/rifle/mpi_km/black/magharness
	belt = /obj/item/storage/belt/marine/som/mpi_black

	backpack_contents = list(
		/obj/item/tool/extinguisher = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/explosive/plastique/detpack = 4,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope = 1,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/plastique = 2,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 3,
		/obj/item/explosive/grenade/smokebomb/som = 1,
		/obj/item/explosive/grenade/smokebomb/satrapine = 1,
	)

/datum/outfit/quick/som/engineer/standard_carbine
	name = "V-34 Engineer"
	desc = "战场工程师;建造与拆除.配备一支V-34卡宾枪,中型护甲,一个可部署的COPE哨戒炮以及多种爆炸物.拥有各种补给和装备,可在战场上建造,维修或实施爆破.对于一支全面发展的战斗部队来说,是宝贵的支援资产.V-34是一种在最初的火星叛乱期间常见的旧式武器的现代化改进型.非常可靠,在小型轻量化的包装中拥有出色的停止作用.作为VX-32的廉价得多的替代品而投入使用."

	suit_store = /obj/item/weapon/gun/rifle/som_carbine/black/standard
	belt = /obj/item/storage/belt/marine/som/carbine_black

	backpack_contents = list(
		/obj/item/tool/extinguisher = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/explosive/plastique/detpack = 4,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope = 1,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/plastique = 2,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 3,
		/obj/item/explosive/grenade/smokebomb/som = 1,
		/obj/item/explosive/grenade/smokebomb/satrapine = 1,
	)

/datum/outfit/quick/som/engineer/standard_smg
	name = "V-21 Engineer"
	desc = "战场工程师;建造与拆除.配备一支V-21冲锋枪,可变射速,在正确使用时能实现极高的射速,中型护甲,一个可部署的COPE哨戒炮以及多种爆炸物.拥有各种补给和装备,可在战场上建造,维修或实施爆破.对于一支全面发展的战斗部队来说,是宝贵的支援资产."

	suit_store = /obj/item/weapon/gun/smg/som/support
	belt = /obj/item/storage/belt/marine/som/som_smg

	backpack_contents = list(
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/explosive/plastique/detpack = 3,
		/obj/item/ammo_magazine/smg/som = 2,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope = 1,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/plastique = 2,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/smokebomb/som = 2,
		/obj/item/explosive/grenade/flashbang/stun = 1,
		/obj/item/explosive/grenade/som = 1,
		/obj/item/explosive/grenade/smokebomb/satrapine = 1,
	)

/datum/outfit/quick/som/engineer/standard_shotgun
	name = "V-51 Engineer"
	desc = "战场工程师;建造与拆除.配备一支V-51半自动霰弹枪,中型护甲,一个可部署的COPE哨戒炮以及多种爆炸物.拥有各种补给和装备,可在战场上建造,维修或实施爆破.对于一支全面发展的战斗部队来说,是宝贵的支援资产."

	belt = /obj/item/storage/belt/shotgun/som/flechette
	suit_store = /obj/item/weapon/gun/shotgun/som/support

	backpack_contents = list(
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/explosive/plastique/detpack = 3,
		/obj/item/ammo_magazine/handful/buckshot = 2,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/cope = 1,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/plastique = 2,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/smokebomb/som = 2,
		/obj/item/explosive/grenade/flashbang/stun = 1,
		/obj/item/explosive/grenade/som = 1,
		/obj/item/explosive/grenade/smokebomb/satrapine = 1,
	)
