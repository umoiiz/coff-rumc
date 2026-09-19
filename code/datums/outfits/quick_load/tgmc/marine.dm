/datum/outfit/quick/tgmc/marine/ar12
	name = "AR-12 rifleman"
	desc = "经典一线步枪兵. 配备一把带有下挂榴弹发射器的AR-12突击步枪, 重型护甲, 以及大量手雷和弹药. 可靠的全能型."

	suit_store = /obj/item/weapon/gun/rifle/ar12/rifleman
	belt = /obj/item/storage/belt/marine/ar12

	backpack_contents = list(
		/obj/item/weapon/shield/riot/marine/deployable = 1,
		/obj/item/ammo_magazine/packet/p10x24mm = 1,
		/obj/item/ammo_magazine/pistol/p23 = 2,
		/obj/item/weapon/gun/pistol/p23/tactical = 1,
		/obj/item/storage/box/mre = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/sticky = 2,
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/incendiary = 1,
	)

/datum/outfit/quick/tgmc/marine/standard_laserrifle
	name = "Laser Rifleman"
	desc = "当子弹不够用时. 激光步枪配微型火焰喷射器和重型护甲. 激光对SOM护甲更有效, 但无法打断骨头和损伤器官."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle/rifleman
	belt = /obj/item/storage/belt/marine/te_cells

	backpack_contents = list(
		/obj/item/cell/lasgun/lasrifle = 3,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol/tactical = 1,
		/obj/item/storage/box/mre = 1,
	)
	webbing_contents = list(
		/obj/item/ammo_magazine/flamer_tank/mini = 2,
		/obj/item/explosive/grenade = 2,
		/obj/item/tool/extinguisher/mini = 1,
	)

/datum/outfit/quick/tgmc/marine/ar18
	name = "AR-18 Rifleman"
	desc = "现代一线步枪兵. 配备一把带有下挂榴弹发射器的AR-18卡宾枪, 重型护甲, 以及大量手雷和弹药. 相比AR-12拥有更好的机动性和伤害输出, 但弹匣更小, 远距离表现更差."

	suit_store = /obj/item/weapon/gun/rifle/ar18/standard
	belt = /obj/item/storage/belt/marine/ar18

	backpack_contents = list(
		/obj/item/ammo_magazine/packet/p10x24mm = 1,
		/obj/item/ammo_magazine/pistol/p23 = 2,
		/obj/item/ammo_magazine/rifle/ar18 = 1,
		/obj/item/weapon/gun/pistol/p23/tactical = 1,
		/obj/item/storage/box/mre = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/sticky = 2,
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/incendiary = 1,
	)

/datum/outfit/quick/tgmc/marine/combat_rifle
	name = "AR-11 Rifleman"
	desc = "老式步枪兵. 配备一把AR-11战斗步枪和重型护甲, 以及大量手雷和弹药. 拥有大容量弹匣和所有距离上的致命伤害输出, 但缺少现代武器的许多附件选项, 且操作起来有些笨重."

	suit_store = /obj/item/weapon/gun/rifle/ar11/standard
	belt = /obj/item/storage/belt/marine/combat_rifle

	backpack_contents = list(
		/obj/item/ammo_magazine/packet/p492x34mm = 2,
		/obj/item/ammo_magazine/pistol/p23 = 2,
		/obj/item/weapon/gun/pistol/p23/tactical = 1,
		/obj/item/storage/box/mre = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade = 3,
		/obj/item/explosive/grenade/incendiary = 1,
		/obj/item/tool/extinguisher/mini = 1,
	)

/datum/outfit/quick/tgmc/marine/br64
	name = "BR-64 Rifleman"
	desc = "为有品位的步枪兵提供更重的火力. 配备一把带有下挂榴弹发射器的BR-64战斗步枪, 重型护甲, 以及大量手雷和弹药. 更高的伤害和穿透力, 代价是武器更笨重."

	suit_store = /obj/item/weapon/gun/rifle/br64/standard
	belt = /obj/item/storage/belt/marine/br64

	backpack_contents = list(
		/obj/item/weapon/shield/riot/marine/deployable = 1,
		/obj/item/ammo_magazine/packet/p10x265mm = 1,
		/obj/item/ammo_magazine/pistol/p23 = 2,
		/obj/item/weapon/gun/pistol/p23/tactical = 1,
		/obj/item/storage/box/mre = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/sticky = 2,
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/incendiary = 1,
	)

/datum/outfit/quick/tgmc/marine/ar21
	name = "AR-21 Rifleman"
	desc = "以更低射速换取更好的停止作用. 配备一把带有下挂榴弹发射器的AR-21游骑兵步枪, 重型护甲, 以及大量手雷和弹药. 用其重型弹药奖励精准的瞄准."

	suit_store = /obj/item/weapon/gun/rifle/ar21/standard
	belt = /obj/item/storage/belt/marine/ar21

	backpack_contents = list(
		/obj/item/weapon/shield/riot/marine/deployable = 1,
		/obj/item/ammo_magazine/packet/p10x25mm = 1,
		/obj/item/ammo_magazine/pistol/p23 = 2,
		/obj/item/weapon/gun/pistol/p23/tactical = 1,
		/obj/item/storage/box/mre = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/sticky = 2,
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/incendiary = 1,
	)

/datum/outfit/quick/tgmc/marine/alf_shocktrooper
	name = "ALF-51B Shocktrooper"
	desc = "电击突击装备. 配备一把ALF-51B机关卡宾枪, 用Mk.II'提尔'模块强化的重型护甲, 以及大量手雷和弹药. 提供出色的伤害输出和卓越的防护, 然而ALF-51B的截短尺寸意味着它受严重的伤害衰减影响. 最好近距离使用."

	head = /obj/item/clothing/head/modular/m10x/tyr
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/tyr_two
	suit_store = /obj/item/weapon/gun/rifle/alf_machinecarbine/assault
	belt = /obj/item/storage/belt/marine/alf_machinecarbine

	backpack_contents = list(
		/obj/item/ammo_magazine/rifle/alf_machinecarbine = 2,
		/obj/item/weapon/gun/pistol/p23/tactical = 1,
		/obj/item/storage/box/mre = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/tool/extinguisher/mini = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/flashbang/stun = 1,
		/obj/item/ammo_magazine/pistol/p23 = 2,
	)

/datum/outfit/quick/tgmc/marine/mg60
	name = "MG-60 Machinegunner"
	desc = "TGMC的老牌可靠主力. 配备一把带两脚架的MG-60机枪, 重型护甲和一些基础建筑补给. 适合守住阵地和提供火力支援, 代价是牺牲一些机动性."

	belt = /obj/item/storage/belt/sparepouch
	suit_store = /obj/item/weapon/gun/rifle/mg60/machinegunner
	l_pocket = /obj/item/storage/pouch/construction

	backpack_contents = list(
		/obj/item/weapon/shield/riot/marine/deployable = 1,
		/obj/item/ammo_magazine/mg60 = 1,
		/obj/item/weapon/gun/pistol/p23/tactical = 1,
		/obj/item/ammo_magazine/pistol/p23 = 3,
	)
	belt_contents = list(
		/obj/item/ammo_magazine/mg60 = 3,
	)
	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/explosive/grenade/smokebomb = 2,
		/obj/item/explosive/grenade/incendiary = 1,
		/obj/item/explosive/grenade/flashbang/stun = 1,
	)
	l_pocket_contents = list(
		/obj/item/tool/shovel/etool = 1,
		/obj/item/stack/sandbags_empty/half = 1,
		/obj/item/stack/sandbags/large_stack = 1,
		/obj/item/stack/barbed_wire/half_stack = 1,
	)

/datum/outfit/quick/tgmc/marine/mg27
	name = "MG-27 Machinegunner"
	desc = "当你需要能携带的最大枪械时. 配备一把MG-27机枪和迷你瞄准镜, 以及一把MR-25冲锋枪作为副武器, 外加中型护甲和少量建筑补给. 允许提供毁灭性但固定的火力."

	belt = /obj/item/storage/holster/m25
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/shield
	suit_store = /obj/item/weapon/gun/mg27/machinegunner
	l_pocket = /obj/item/storage/pouch/construction
	glasses = /obj/item/clothing/glasses/mgoggles

	backpack_contents = list(
		/obj/item/ammo_magazine/mg27 = 3,
		/obj/item/explosive/grenade/smokebomb = 2,
		/obj/item/explosive/grenade/flashbang/stun = 1,
	)
	belt_contents = list(
		/obj/item/weapon/gun/smg/m25/holstered = 1,
	)
	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/smg/m25 = 4,
	)
	l_pocket_contents = list(
		/obj/item/tool/shovel/etool = 1,
		/obj/item/stack/sandbags_empty/half = 1,
		/obj/item/stack/sandbags/large_stack = 1,
		/obj/item/stack/barbed_wire/half_stack = 1,
	)

/datum/outfit/quick/tgmc/marine/standard_lasermg
	name = "Laser Machinegunner"
	desc = "无后顾之忧的火力优势. 激光机枪配下挂榴弹发射器和重型护甲. 相对机枪而言较轻, 拥有可变射击模式, 使这把武器灵活而危险. 激光对SOM护甲更有效, 但无法打断骨头和损伤器官."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_mlaser/patrol
	belt = /obj/item/storage/belt/marine/te_cells

	backpack_contents = list(
		/obj/item/cell/lasgun/lasrifle = 3,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol/tactical = 1,
		/obj/item/storage/box/mre = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/incendiary = 1,
		/obj/item/explosive/grenade = 3,
		/obj/item/tool/extinguisher/mini = 1,
	)

/datum/outfit/quick/tgmc/marine/pyro
	name = "FL-84 Flamethrower Operator"
	desc = "用于烧敌人, 有时也烧朋友. 配备一把FL-84火焰喷射器和宽喷嘴, SMG-25副武器, 用'苏尔特'防火模块升级的重型护甲, 以及一背罐燃料. 可以极快地烧毁大片区域, 既能逼出敌人也能掩护侧翼. 然而速度非常慢, 远距离无效, 且过度使用会很快耗尽所有可用燃料."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/surt
	mask = /obj/item/clothing/mask/gas/tactical
	head = /obj/item/clothing/head/modular/m10x/surt
	belt = /obj/item/storage/holster/m25
	back = /obj/item/ammo_magazine/flamer_tank/backtank
	suit_store = /obj/item/weapon/gun/flamer/big_flamer/marinestandard/wide

	belt_contents = list(
		/obj/item/weapon/gun/smg/m25/holstered = 1,
	)
	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/smg/m25/extended = 3,
		/obj/item/ammo_magazine/packet/p10x20mm = 1,
	)

/datum/outfit/quick/tgmc/marine/standard_shotgun
	name = "SH-35 Scout"
	desc = "用于近得让人不适的距离. 配备一把使用鹿弹和飞镖弹的SH-35霰弹枪, 一把MP-19副武器, 相当数量的手雷, 以及带有尖端'斯瓦林'护盾模块的轻型护甲. 提供出色的机动性和毁灭性的近距离火力, 但在持续火力下会崩溃."

	belt = /obj/item/storage/belt/shotgun
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/light/shield
	suit_store = /obj/item/weapon/gun/shotgun/pump/t35/standard
	belt = /obj/item/storage/belt/shotgun/mixed

	backpack_contents = list(
		/obj/item/ammo_magazine/smg/mp19 = 3,
		/obj/item/ammo_magazine/packet/p10x20mm = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/synaptizine = 1,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/weapon/gun/smg/mp19/compact = 1,
	)

	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/binoculars = 1,
		/obj/item/explosive/grenade/incendiary = 1,
		/obj/item/explosive/grenade = 2,
	)

/datum/outfit/quick/tgmc/marine/standard_lasercarbine
	name = "Laser Carbine Scout"
	desc = "高机动轻型步兵. 配备一把带有下挂榴弹发射器的激光卡宾枪和一把激光手枪副武器, 大量手雷, 以及带有尖端'斯瓦林'护盾模块的轻型护甲. 出色的机动性, 但不适合持续战斗."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/light/shield
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_carbine/scout
	belt = /obj/item/storage/belt/marine/te_cells

	backpack_contents = list(
		/obj/item/cell/lasgun/lasrifle = 3,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol/tactical = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/synaptizine = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 1,
		/obj/item/explosive/plastique = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/sticky = 3,
		/obj/item/storage/box/mre = 1,
		/obj/item/binoculars = 1,
	)

/datum/outfit/quick/tgmc/marine/light_carbine
	name = "AR-18 Scout"
	desc = "高伤害和高速度. 配备一把带有下挂榴弹发射器的AR-18卡宾枪, 带有尖端'斯瓦林'护盾模块的轻型护甲, 以及大量手雷和弹药. 出色的机动性和伤害输出, 但弹匣容量低, 且护盾未激活时护甲薄弱, 意味着这套装备最适合打了就跑的战术."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/light/shield
	suit_store = /obj/item/weapon/gun/rifle/ar18/scout
	belt = /obj/item/storage/belt/marine/ar18

	backpack_contents = list(
		/obj/item/ammo_magazine/packet/p10x24mm = 2,
		/obj/item/ammo_magazine/rifle/ar18 = 1,
		/obj/item/weapon/gun/pistol/p23/tactical = 1,
		/obj/item/storage/box/mre = 1,
		/obj/item/explosive/plastique = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/sticky = 3,
		/obj/item/ammo_magazine/pistol/p23 = 2,
	)

/datum/outfit/quick/tgmc/marine/shield_tank
	name = "SMG-25 Guardian"
	desc = "专业挡子弹. 配备一把SMG-25冲锋枪, 一面TL-172防御盾牌, 以及用'提尔'模块强化的重型护甲. 旨在吸收尽可能多的来袭伤害以保护你更脆弱的战友, 然而你的机动性和伤害输出明显降低. 另需注意: TL-172出色的热质量意味着它对SOM的沃尔凯特武器异常有效."

	head = /obj/item/clothing/head/modular/m10x/tyr
	glasses = /obj/item/clothing/glasses/welding/flipped
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/tyr_two
	suit_store = /obj/item/weapon/gun/smg/m25/magharness
	belt = /obj/item/storage/belt/marine/secondary
	r_hand = /obj/item/weapon/shield/riot/marine

	backpack_contents = list(
		/obj/item/tool/extinguisher = 1,
		/obj/item/tool/weldingtool/largetank = 1,
		/obj/item/ammo_magazine/smg/m25/extended = 1,
		/obj/item/ammo_magazine/packet/p10x20mm = 2,
		/obj/item/explosive/grenade/smokebomb/cloak = 1,
		/obj/item/storage/box/mre = 1,
	)
	webbing_contents = list(
		/obj/item/explosive/grenade/sticky = 2,
		/obj/item/explosive/grenade/incendiary = 1,
		/obj/item/explosive/grenade = 2,
	)

/datum/outfit/quick/tgmc/marine/machete
	name = "Assault Marine"
	desc = "这看起来不像是标准配发... 配备一把SMG-25冲锋枪, 砍刀和重型起重喷气背包, 以及用'斯瓦林'护盾模块升级的轻型护甲. 不清楚这东西为什么会在这里, 尽管如此它拥有出色的机动性, 并且对你实际能接触到的人来说很可能是毁灭性的."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/light/shield
	back = /obj/item/jetpack_marine/heavy
	belt = /obj/item/storage/holster/blade/machete/full
	suit_store = /obj/item/weapon/gun/smg/m25/magharness

	webbing_contents = list(
		/obj/item/ammo_magazine/smg/m25/extended = 2,
		/obj/item/ammo_magazine/smg/m25 = 3,
	)

/datum/outfit/quick/tgmc/marine/scout
	name = "BR-8 Scout"
	desc = "IFF侦察兵. 配备一把BR-8, 相当数量的手雷, 以及带有尖端'斯瓦林'护盾模块的轻型护甲. 提供良好的机动性和强大的IFF伤害, 但BR-8在近距离难以施展, 且轻型护甲在持续火力下会崩溃."
	quantity = 2

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/light/shield
	suit_store = /obj/item/weapon/gun/rifle/tx8/scout
	belt = /obj/item/storage/belt/marine/tx8

	backpack_contents = list(
		/obj/item/ammo_magazine/smg/mp19 = 3,
		/obj/item/weapon/gun/smg/mp19/scanner = 1,
		/obj/item/ammo_magazine/rifle/tx8 = 2,
	)
	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/binoculars = 1,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/explosive/grenade/m15 = 2,
	)
