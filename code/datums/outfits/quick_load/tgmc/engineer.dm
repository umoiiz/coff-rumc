//Base TGMC engineer outfit
/datum/outfit/quick/tgmc/engineer
	name = "TGMC Squad Engineer"
	jobtype = SQUAD_ENGINEER

	ears = /obj/item/radio/headset/mainship/marine
	glasses = /obj/item/clothing/glasses/meson
	w_uniform = /obj/item/clothing/under/marine/engineer/black_vest
	shoes = /obj/item/clothing/shoes/marine/full
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/engineer
	gloves = /obj/item/clothing/gloves/marine/insulated
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x/welding
	r_pocket = /obj/item/storage/pouch/firstaid/combat_patrol
	l_pocket = /obj/item/storage/pouch/tools/full
	back = /obj/item/storage/backpack/marine/engineerpack

	head_contents = list(
		/obj/item/explosive/plastique = 2,
	)
	suit_contents = list(
		/obj/item/circuitboard/apc = 1,
		/obj/item/cell/high = 1,
		/obj/item/stack/sheet/plasteel/medium_stack = 1,
		/obj/item/stack/sheet/metal/large_stack = 1,
		/obj/item/stack/barbed_wire/half_stack = 1,
	)

/datum/outfit/quick/tgmc/engineer/rrengineer
	name = "Rocket Specialist"
	desc = "带来重火力. 配备一把AR-18卡宾枪和RL-160以及标准工程师装备. 对抗成群敌方步兵或轻型装甲非常出色, 但弹药有限."
	quantity = 2

	suit_store = /obj/item/weapon/gun/rifle/ar18/engineer
	back = /obj/item/storage/holster/backholster/rpg/low_impact
	belt = /obj/item/storage/belt/marine/ar18

	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/grenade/chem_grenade/razorburn_large = 1,
		/obj/item/explosive/grenade/smokebomb = 1,
	)

/datum/outfit/quick/tgmc/engineer/sentry
	name = "Sentry Technician"
	desc = "开的枪比手还多. 配备一把带有微型火焰喷射器的AR-12突击步枪, 两座迷你哨戒炮以及标准工程师装备. 允许使用者快速建立据点并封锁区域, 前提是放置得当."

	suit_store = /obj/item/weapon/gun/rifle/ar12/engineer
	belt = /obj/item/storage/belt/marine/ar12

	backpack_contents = list(
		/obj/item/weapon/gun/sentry/mini/combat_patrol = 2,
		/obj/item/ammo_magazine/minisentry = 2,
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
	)
	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/flamer_tank/mini = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/grenade/chem_grenade/razorburn_large = 1,
		/obj/item/explosive/grenade/smokebomb = 1,
	)

/datum/outfit/quick/tgmc/engineer/demolition
	name = "Demolition Specialist"
	desc = "轰轰轰, 震翻天. 配备一把SH-15自动霰弹枪和下挂榴弹发射器, 以及一整套令人印象深刻的地雷, 炸药包和手雷, 外加标准工程师装备. 非常适合炸穿任何障碍, 并布雷限制敌人移动."

	suit_store = /obj/item/weapon/gun/rifle/sh15/engineer
	back = /obj/item/storage/backpack/marine/tech
	belt = /obj/item/storage/belt/marine/auto_shotgun

	backpack_contents = list(
		/obj/item/minelayer = 1,
		/obj/item/storage/box/explosive_mines/large = 1,
		/obj/item/storage/box/explosive_mines = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/explosive/plastique/detpack = 3,
		/obj/item/explosive/plastique = 2,
		/obj/item/storage/box/mre = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/explosive/grenade/smokebomb = 1,
	)
	webbing_contents = list(
		/obj/item/tool/extinguisher/mini = 1,
		/obj/item/assembly/signaler = 1,
		/obj/item/explosive/grenade/sticky = 3,
	)
