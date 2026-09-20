//Base TGMC corpsman outfit
/datum/outfit/quick/tgmc/corpsman
	name = "TGMC Squad Corpsman"
	jobtype = SQUAD_CORPSMAN

	belt = /obj/item/storage/belt/lifesaver/quick
	ears = /obj/item/radio/headset/mainship/marine
	glasses = /obj/item/clothing/glasses/hud/health
	w_uniform = /obj/item/clothing/under/marine/corpsman/corpman_vest
	shoes = /obj/item/clothing/shoes/marine/full
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/mimir
	gloves = /obj/item/clothing/gloves/marine
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x/mimir
	r_pocket = /obj/item/storage/pouch/magazine/large
	l_pocket = /obj/item/storage/pouch/grenade/combat_patrol
	back = /obj/item/storage/backpack/marine/corpsman

	webbing_contents = list(
		/obj/item/bodybag/cryobag = 1,
		/obj/item/roller = 1,
		/obj/item/tweezers_advanced = 1,
		/obj/item/reagent_containers/hypospray/advanced/nanoblood = 1,
		/obj/item/storage/pill_bottle/spaceacillin = 1,
		/obj/item/reagent_containers/hypospray/advanced/combat_advanced = 1,
	)
	suit_contents = list(
		/obj/item/tool/extinguisher = 1,
		/obj/item/defibrillator = 1,
	)
	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/isotonic = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline = 1,
	)

/datum/outfit/quick/tgmc/corpsman/ar12
	name = "AR-12 Corpsman"
	desc = "让其他所有人继续战斗.配备一支AR-12突击步枪,带有下挂式榴弹发射器,一套令人印象深刻的治疗队友的工具,以及一个'密米尔'生物防护模块,让你能在危险环境中继续作战.在医疗后送不可能的情况下,你是你的战友和早逝之间唯一的屏障."

	suit_store = /obj/item/weapon/gun/rifle/ar12/medic

	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 2,
		/obj/item/explosive/grenade = 1,
		/obj/item/explosive/grenade/sticky = 2,
		/obj/item/explosive/grenade/incendiary = 1,
		/obj/item/ammo_magazine/packet/p10x24mm = 1,
		/obj/item/ammo_magazine/rifle/ar12 = 3,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/ar12 = 3,
	)

/datum/outfit/quick/tgmc/corpsman/smg90
	name = "SMG-90 Corpsman"
	desc = "让其他所有人继续战斗.配备一支SMG-90冲锋枪以保持良好机动性,一套令人印象深刻的治疗队友的工具,以及一个'密米尔'生物防护模块,让你能在危险环境中继续作战.在医疗后送不可能的情况下,你是你的战友和早逝之间唯一的屏障."

	suit_store = /obj/item/weapon/gun/smg/smg90/tactical

	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 2,
		/obj/item/ammo_magazine/smg/smg90 = 2,
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/incendiary = 2,
		/obj/item/ammo_magazine/packet/p10x20mm = 1,
		/obj/item/ammo_magazine/smg/smg90 = 3,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/smg/smg90 = 3,
	)

/datum/outfit/quick/tgmc/corpsman/ar21
	name = "AR-21 Corpsman"
	desc = "让其他所有人继续战斗.配备一支AR-21散兵步枪,带有下挂式榴弹发射器,一套令人印象深刻的治疗队友的工具,以及一个'密米尔'生物防护模块,让你能在危险环境中继续作战.在医疗后送不可能的情况下,你是你的战友和早逝之间唯一的屏障."

	suit_store = /obj/item/weapon/gun/rifle/ar21/standard

	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 2,
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/sticky = 2,
		/obj/item/ammo_magazine/packet/p10x25mm = 1,
		/obj/item/ammo_magazine/rifle/ar21 = 3,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/ar21 = 3,
	)

/datum/outfit/quick/tgmc/corpsman/auto_shotgun
	name = "SH-15 Corpsman"
	desc = "让其他所有人继续战斗.配备一支SH-15自动霰弹枪,带有下挂式榴弹发射器,一套令人印象深刻的治疗队友的工具,以及一个'密米尔'生物防护模块,让你能在危险环境中继续作战.在医疗后送不可能的情况下,你是你的战友和早逝之间唯一的屏障."

	suit_store = /obj/item/weapon/gun/rifle/sh15/engineer

	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 2,
		/obj/item/explosive/grenade = 2,
		/obj/item/explosive/grenade/sticky = 2,
		/obj/item/explosive/grenade/incendiary = 1,
		/obj/item/ammo_magazine/rifle/sh15_slug = 2,
		/obj/item/ammo_magazine/rifle/sh15_flechette = 1,
	)
	r_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/sh15_flechette = 2,
		/obj/item/ammo_magazine/rifle/sh15_slug = 1,
		/obj/item/cell/lasgun/lasrifle = 3
	)

/datum/outfit/quick/tgmc/corpsman/laser_medic
	name = "Laser Rifle Corpsman"
	desc = "让其他所有人继续战斗.配备一支带有微型火焰器的激光步枪,一套令人印象深刻的治疗队友的工具,以及一个'密米尔'生物防护模块,让你能在危险环境中继续作战.在医疗后送不可能的情况下,你是你的战友和早逝之间唯一的屏障."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle/medic

	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 2,
		/obj/item/ammo_magazine/flamer_tank/mini = 2,
		/obj/item/cell/lasgun/lasrifle = 5,
	)
	r_pocket_contents = list(
		/obj/item/cell/lasgun/lasrifle = 3,
	)

/datum/outfit/quick/tgmc/corpsman/laser_carbine
	name = "Laser Carbine Corpsman"
	desc = "让其他所有人继续战斗.配备一支带有下挂式榴弹发射器的激光卡宾枪,一套令人印象深刻的治疗队友的工具,以及一个'密米尔'生物防护模块,让你能在危险环境中继续作战.在医疗后送不可能的情况下,你是你的战友和早逝之间唯一的屏障."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_carbine/scout

	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 2,
		/obj/item/explosive/grenade/sticky = 2,
		/obj/item/explosive/grenade = 2,
		/obj/item/cell/lasgun/lasrifle = 4,
	)
	r_pocket_contents = list(
		/obj/item/cell/lasgun/lasrifle = 3,
	)
