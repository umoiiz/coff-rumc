//Base SOM medic outfit
/datum/outfit/quick/som/medic
	name = "SOM Squad Medic"
	jobtype = "SOM Squad Medic"

	belt = /obj/item/storage/belt/lifesaver/som/quick
	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/medic/vest
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som/medic
	gloves = /obj/item/clothing/gloves/marine/som
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som
	glasses = /obj/item/clothing/glasses/hud/health
	r_pocket = /obj/item/storage/pouch/magazine/large/som
	l_pocket = /obj/item/storage/pouch/grenade/som/combat_patrol
	back = /obj/item/storage/backpack/lightpack/som

	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
	)
	webbing_contents = list(
		/obj/item/roller = 1,
		/obj/item/tweezers_advanced = 1,
		/obj/item/storage/pill_bottle/spaceacillin = 1,
		/obj/item/reagent_containers/hypospray/advanced/nanoblood = 1,
		/obj/item/bodybag/cryobag = 1,
		/obj/item/reagent_containers/hypospray/advanced/combat_advanced = 1,
	)
	suit_contents = list(
		/obj/item/tool/extinguisher = 1,
		/obj/item/defibrillator = 1,
	)

/datum/outfit/quick/som/medic/standard_assaultrifle
	name = "V-31 Medic"
	desc = "让你的战友活着并继续战斗. 配备了V-31突击步枪, 带有集成\"微型榴弹\"轨道发射器, 中型装甲以及种类丰富的榴弹. 携带大量医疗补给, 小队医疗兵对于维持战斗能力至关重要. 轨道发射器发射的榴弹必须在飞行途中解除保险, 因此在近距离无效, 但在中距离增加了重要的战术选择."

	suit_store = /obj/item/weapon/gun/rifle/som/standard

	backpack_contents = list(
		/obj/item/ammo_magazine/rifle/som = 3,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/smoke_burst = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/dragonbreath = 1,
		/obj/item/ammo_magazine/handful/micro_grenade = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/som = 3,
	)

/datum/outfit/quick/som/medic/mpi
	name = "MPI_KM Medic"
	desc = "让你的战友活着并继续战斗. 配备了MPI_KM突击步枪, 中型装甲以及种类丰富的榴弹. 携带大量医疗补给, 小队医疗兵对于维持战斗能力至关重要. 这是一种旧式武器, 在最初的 Martian 叛乱期间很常见, MPI良好的停止力, 可靠性以及恰到好处的怀旧感意味着尽管它已经老旧, 在SOM中仍有一些人在使用."

	suit_store = /obj/item/weapon/gun/rifle/mpi_km/black/magharness

	backpack_contents = list(
		/obj/item/ammo_magazine/rifle/mpi_km/black = 4,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/explosive/grenade/som = 3,
		/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/mpi_km/black = 3,
	)

/datum/outfit/quick/som/medic/standard_carbine
	name = "V-34 Medic"
	desc = "让你的战友活着并继续战斗. 配备了V-34卡宾枪, 中型装甲, 具有强大的火力和机动性, 但弹药经济性和射程较差. 携带大量医疗补给, 小队医疗兵对于维持战斗能力至关重要. V-34是一种旧式武器的现代化改进版, 该武器在最初的 Martian 叛乱期间很常见. 非常可靠, 在小型轻量化的包装中具有出色的停止力. 作为VX-32的廉价得多的替代品投入使用."

	suit_store = /obj/item/weapon/gun/rifle/som_carbine/black/standard

	backpack_contents = list(
		/obj/item/ammo_magazine/rifle/mpi_km/carbine/black = 4,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/explosive/grenade/som = 3,
		/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/mpi_km/carbine/black = 3,
	)

/datum/outfit/quick/som/medic/standard_smg
	name = "V-21 Medic"
	desc = "让你的战友活着并继续战斗. 配备了V-21冲锋枪, 其可变射速在正确使用时可实现极高的射速, 中型装甲以及种类丰富的榴弹. 携带大量医疗补给, 小队医疗兵对于维持战斗能力至关重要."

	suit_store = /obj/item/weapon/gun/smg/som/support

	backpack_contents = list(
		/obj/item/ammo_magazine/smg/som = 6,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/explosive/grenade/som = 3,
		/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/smg/som = 3,
	)

/datum/outfit/quick/som/medic/standard_shotgun
	name = "V-51 Medic"
	desc = "让你的战友活着并继续战斗. 配备了V-51半自动霰弹枪, 中型装甲以及种类丰富的榴弹. 携带大量医疗补给, 小队医疗兵对于维持战斗能力至关重要."

	r_pocket = /obj/item/storage/pouch/shotgun/som
	suit_store = /obj/item/weapon/gun/shotgun/som/support

	backpack_contents = list(
		/obj/item/ammo_magazine/handful/flechette = 7,
		/obj/item/storage/box/mre/som = 1,
		/obj/item/explosive/grenade/som = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/handful/flechette = 4,
	)
