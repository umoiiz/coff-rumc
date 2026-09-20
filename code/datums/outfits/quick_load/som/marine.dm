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
	desc = "典型的SOM步兵.配备一支V-31突击步枪,集成'微型榴弹'轨道发射器,中型护甲以及多种手榴弹.轨道发射器发射的榴弹必须在飞行途中解除保险,因此在近距离无效,但在中距离可提供重要的战术选择."

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
	desc = "对旧日时光的致敬.配备一支MPI_KM突击步枪,带有下挂式榴弹发射器以及大量手榴弹.一种在最初的火星叛乱期间常见的旧式武器,MPI良好的停止作用,可靠性以及恰到好处的怀旧感意味着尽管它已经老旧,在SOM中仍有人使用."

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
	desc = "机动且危险.配备一支V-34卡宾枪,带有'埃癸斯'护盾模块的轻型护甲以及大量手榴弹.V-34是一种在最初的火星叛乱期间常见的旧式武器的现代化改进型.非常可靠,在小型轻量化的包装中拥有出色的停止作用.作为VX-32的廉价得多的替代品而投入使用."

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
	desc = "高机动侦察配置.配备一支V-21冲锋枪,可变射速,在正确使用时能实现极高的射速,带有'埃癸斯'护盾模块的轻型护甲以及多种手榴弹.可提供卓越的机动性和猛烈火力,但在长时间交战中会因轻型护甲和V-21的高射速而陷入劣势."

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
	desc = "用于近距离遭遇.配备一支V-51半自动霰弹枪,带有'埃癸斯'护盾模块的轻型护甲以及大量手榴弹.可提供良好的机动性和危险的近战火力."

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
	desc = "闻起来像胜利.配备一支V-62燃烧器,带有宽喷嘴,一支可快速点射的V-11,升级有'哈迪斯'防火模块的重型护甲,以及一个燃料背罐.拥有高于平均水平的射程,可迅速烧毁大片区域.但会显著减速,缺少集成灭火器,且不加节制地使用会迅速耗尽所有可用燃料."

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
	desc = "重甲破门配置.配备一支V-21冲锋枪,可变射速,在正确使用时能实现极高的射速,重型护甲,一面登舰盾以及多种手榴弹.提供出色的防护,尽管伤害可能不足,尤其是在较远距离."

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
	desc = "当完全不需要任何隐蔽时使用.配备'洛里卡'增强型重型护甲,手持一把巨大的双手破门斧,专为劈开重型护甲而设计.正确使用时,它也能提供一定程度的防护."

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
	desc = "重型固定火力支援.配备一支V-41机枪,点射型V-11副武器以及一些基础建筑补给.虽然常常不适合SOM标准的机动与进攻条令,但V-41通常出现在防御阵地或二线部队中,在这些地方其糟糕的机动性相对于持续火力而言只是小缺点."

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
	desc = "SOM的未来步兵.配备一支沃尔基特充能枪,中型护甲以及多种手榴弹.沃尔基特武器异常危险,尤其是对抗护甲薄弱或密集聚集的敌人.充能枪是SOM首屈一指的近/中距离武器,机动性良好,必要时可(有些困难地)单手使用."
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
