//Base SOM marine outfit
/datum/outfit/quick/som/marine
	name = "SOM Squad Marine"
	jobtype = "SOM Squad Standard"

	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/webbing
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som/shield
	gloves = /obj/item/clothing/gloves/marine/som
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som
	r_pocket = /obj/item/storage/pouch/firstaid/som/combat_patrol
	l_pocket = /obj/item/storage/pouch/grenade/som/combat_patrol
	back = /obj/item/storage/backpack/satchel/som

	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/combat = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
	)

	suit_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/isotonic = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
	)

/datum/outfit/quick/som/marine/standard_assaultrifle
	name = "V-31 Infantryman"
	desc = "典型的SOM步兵. 配备了V-31突击步枪, 带有集成\"微型榴弹\"轨道发射器, 中型装甲以及种类丰富的榴弹. 轨道发射器发射的榴弹必须在飞行途中解除保险, 因此在近距离无效, 但在中距离增加了重要的战术选择."

	suit_store = /obj/item/weapon/gun/rifle/som/standard
	belt = /obj/item/storage/belt/marine/som/som_rifle

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/ammo_magazine/rifle/som = 2,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 1,
		/obj/item/ammo_magazine/handful/micro_grenade = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/dragonbreath = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/cluster = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/smoke_burst = 1,
	)

/datum/outfit/quick/som/marine/mpi
	name = "MPI_KM Infantryman"
	desc = "对更早时代的致敬. 配备了MPI_KM突击步枪, 带有下挂式榴弹发射器以及大量榴弹. 这是一种旧式武器, 在最初的 Martian 叛乱期间很常见, MPI良好的停止力, 可靠性以及恰到好处的怀旧感意味着尽管它已经老旧, 在SOM中仍有一些人在使用."

	suit_store = /obj/item/weapon/gun/rifle/mpi_km/black/grenadier
	belt = /obj/item/storage/belt/marine/som/mpi_black

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/ammo_magazine/rifle/mpi_km/black = 2,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 4,
		/obj/item/explosive/grenade/incendiary/som = 1,
	)

/datum/outfit/quick/som/marine/light_carbine
	name = "V-34 Light Infantryman"
	desc = "机动而危险. 配备了V-34卡宾枪, 带有\"神盾\"护盾模块的轻型装甲以及大量榴弹. V-34是一种旧式武器的现代化改进版, 该武器在最初的 Martian 叛乱期间很常见. 非常可靠, 在小型轻量化的包装中具有出色的停止力. 作为VX-32的廉价得多的替代品投入使用."

	wear_suit = /obj/item/clothing/suit/modular/som/light/shield
	suit_store = /obj/item/weapon/gun/rifle/som_carbine/black/standard
	belt = /obj/item/storage/belt/marine/som/carbine_black

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/ammo_magazine/rifle/mpi_km/carbine/black = 2,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 4,
		/obj/item/explosive/grenade/incendiary/som = 1,
	)

/datum/outfit/quick/som/marine/scout
	name = "V-21 Light Infantryman"
	desc = "高机动侦察配置. 配备了V-21冲锋枪, 其可变射速在正确使用时可实现极高的射速, 带有\"神盾\"护盾模块的轻型装甲以及种类丰富的榴弹. 可实现卓越的机动性和猛烈火力, 但在持久交战中会表现不佳, 此时低装甲和V-21的高射速可能成为负担."

	wear_suit = /obj/item/clothing/suit/modular/som/light/shield
	suit_store = /obj/item/weapon/gun/smg/som/scout
	belt = /obj/item/storage/belt/marine/som/som_smg

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/ammo_magazine/smg/som = 3,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/incendiary/som = 2,
		/obj/item/binoculars = 1,
	)

/datum/outfit/quick/som/marine/shotgunner
	name = "V-51 Pointman"
	desc = "用于近距离遭遇. 配备了V-51半自动霰弹枪, 带有\"神盾\"护盾模块的轻型装甲以及大量榴弹. 可实现良好的机动性和危险的近战火力."

	belt = /obj/item/storage/belt/shotgun/som/mixed
	wear_suit = /obj/item/clothing/suit/modular/som/light/shield
	suit_store = /obj/item/weapon/gun/shotgun/som/standard

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 3,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/explosive/grenade/flashbang/stun = 2,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/incendiary/som = 2,
		/obj/item/binoculars = 1,
	)

/datum/outfit/quick/som/marine/pyro
	name = "V-62 Flamethrower Operator"
	desc = "闻起来像胜利. 配备了V-62焚烧器和宽喷嘴, 可快速点射的V-11, 升级了\"哈迪斯\"防火模块的重型装甲, 以及一背包燃料. 具有高于平均水平的射程, 可以快速烧毁大片区域. 但它有严重的减速问题, 缺少集成灭火器, 且无节制的使用会导致迅速消耗所有可用燃料."

	head = /obj/item/clothing/head/modular/som/hades
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/pyro
	belt = /obj/item/storage/holster/belt/pistol/m4a3/som
	back = /obj/item/ammo_magazine/flamer_tank/backtank
	suit_store = /obj/item/weapon/gun/flamer/som/mag_harness

	belt_contents = list(
		/obj/item/ammo_magazine/pistol/som/extended = 6,
		/obj/item/weapon/gun/pistol/som/burst = 1,
	)

	webbing_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/explosive/grenade/som = 1,
		/obj/item/ammo_magazine/pistol/som/extended = 2,
	)

/datum/outfit/quick/som/marine/breacher
	name = "V-21 Breacher"
	desc = "重型装甲破门配置. 配备了V-21冲锋枪, 其可变射速在正确使用时可实现极高的射速, 重型装甲, 一块登舰盾以及种类丰富的榴弹. 提供了出色的防护, 尽管伤害可能不足, 尤其是在较远距离."

	glasses = /obj/item/clothing/glasses/welding/flipped
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/shield
	suit_store = /obj/item/weapon/gun/smg/som/one_handed
	belt = /obj/item/storage/belt/marine/som/som_smg
	r_hand = /obj/item/weapon/shield/riot/marine/som

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/tool/weldingtool/largetank = 1,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
		/obj/item/ammo_magazine/smg/som = 4,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/incendiary/som = 2,
		/obj/item/explosive/grenade/flashbang/stun = 1,
	)

/datum/outfit/quick/som/marine/breacher_melee
	name = "CQC Breacher"
	desc = "当需要完全不加掩饰时. 配备了\"洛里卡\"增强型重型装甲, 并装备了一把巨大的双手破门斧, 专为劈开重型装甲而设计. 正确使用时, 它也能提供一定程度的保护."

	head = /obj/item/clothing/head/modular/som/lorica
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/lorica
	suit_store = /obj/item/weapon/twohanded/fireaxe/som
	belt = /obj/item/storage/holster/belt/pistol/m4a3/som

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/explosive/plastique = 3,
		/obj/item/tool/extinguisher = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/synaptizine = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 1,
	)
	belt_contents = list(
		/obj/item/ammo_magazine/pistol/som/extended = 6,
		/obj/item/weapon/gun/pistol/som/burst = 1,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 4,
		/obj/item/explosive/grenade/incendiary/som = 1,
	)

/datum/outfit/quick/som/marine/machine_gunner
	name = "V-41 Machinegunner"
	desc = "重型固定火力支援. 配备了V-41机枪, 点射型V-11副武器以及一些基础建造补给. 虽然往往不适合SOM标准的机动和进攻条令, V-41通常出现在防御阵地或二线部队中, 在这些地方其糟糕的机动性与持续火力相比只是一个小缺点."

	suit_store = /obj/item/weapon/gun/rifle/som_mg/standard
	belt = /obj/item/storage/holster/belt/pistol/m4a3/som
	l_pocket = /obj/item/storage/pouch/construction/som

	belt_contents = list(
		/obj/item/ammo_magazine/pistol/som/extended = 6,
		/obj/item/weapon/gun/pistol/som/burst = 1,
	)

	backpack_contents = list(
		/obj/item/ammo_magazine/som_mg = 4,
		/obj/item/tool/extinguisher = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/smokebomb/som = 1,
		/obj/item/explosive/grenade/smokebomb/satrapine = 1,
		/obj/item/storage/box/mre/som = 1,
	)
	l_pocket_contents = list(
		/obj/item/tool/shovel/etool = 1,
		/obj/item/stack/sandbags_empty/half = 1,
		/obj/item/stack/sandbags/large_stack = 1,
		/obj/item/stack/barbed_wire/half_stack = 1,
	)

/datum/outfit/quick/som/marine/charger
	name = "Charger Infantryman"
	desc = "SOM的未来步兵. 配备了沃尔凯特充能枪, 中型装甲以及种类丰富的榴弹. 沃尔凯特武器异常危险, 尤其是对装甲薄弱或密集聚集的对手. 充能枪是SOM首屈一指的近/中距离武器, 具有良好的机动性, 必要时可以(有些困难地)单手使用."
	quantity = 4

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/magharness
	belt = /obj/item/storage/belt/marine/som/volkite

	backpack_contents = list(
		/obj/item/storage/box/mre/som = 1,
		/obj/item/ammo_magazine/pistol/som = 2,
		/obj/item/weapon/gun/pistol/som/standard = 1,
		/obj/item/cell/lasgun/volkite = 2,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/som = 2,
		/obj/item/explosive/grenade/incendiary/som = 2,
		/obj/item/tool/extinguisher/mini = 1,
	)
