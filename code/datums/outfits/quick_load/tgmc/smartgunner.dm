//Base TGMC smartgunner outfit
/datum/outfit/quick/tgmc/smartgunner
	name = "TGMC Squad Smartgunner"
	jobtype = SQUAD_SMARTGUNNER

	belt = /obj/item/belt_harness/marine
	ears = /obj/item/radio/headset/mainship/marine
	glasses = /obj/item/clothing/glasses/night/m56_goggles
	w_uniform = /obj/item/clothing/under/marine/black_vest
	shoes = /obj/item/clothing/shoes/marine/full
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/tyr_two
	gloves = /obj/item/clothing/gloves/marine
	mask = /obj/item/clothing/mask/gas/tactical
	head = /obj/item/clothing/head/modular/m10x/tyr
	r_pocket = /obj/item/storage/pouch/firstaid/combat_patrol
	l_pocket = /obj/item/storage/pouch/grenade/combat_patrol
	back = /obj/item/storage/backpack/marine/satchel

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

/datum/outfit/quick/tgmc/smartgunner/sg29
	name = "SG29 Smart Machinegunner"
	desc = "一把比普通熊,或者说陆战队员更聪明的枪.配备一支SG-29智能机枪以及升级有'提尔'额外护甲模块的重型护甲,SG凭借你的敌我识别弹药负责提供机动,精准的火力支援."

	suit_store = /obj/item/weapon/gun/rifle/sg29/patrol

	backpack_contents = list(
		/obj/item/ammo_magazine/sg29 = 4,
		/obj/item/weapon/gun/pistol/vp70/tactical = 1,
	)
	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/pistol/vp70 = 4,
	)

/datum/outfit/quick/tgmc/smartgunner/minigun_sg
	name = "SG85 Smart Machinegunner"
	desc = "子弹比脑子还多.配备一支SG-85智能加特林机枪,一支MP-19副武器,升级有'提尔'额外护甲模块的重型护甲以及一大堆子弹.当你想要倾泻如消防水管般的火力时使用.尽量不要把弹药打光."

	belt = /obj/item/storage/belt/sparepouch
	suit_store = /obj/item/weapon/gun/minigun/smart_minigun/motion_detector
	back = /obj/item/ammo_magazine/minigun_powerpack/smartgun

	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/smg/mp19 = 4,
	)
	belt_contents = list(
		/obj/item/ammo_magazine/packet/smart_minigun = 2,
		/obj/item/weapon/gun/smg/mp19/compact = 1,
	)

/datum/outfit/quick/tgmc/smartgunner/sg62
	name = "SG62 Smart Machinegunner"
	desc = "灵活与精准.配备一支SG-62智能目标步枪以及升级有'提尔'额外护甲模块的重型护甲.集成的观测步枪带有多种灵活的弹药类型,结合高伤害,穿透力和敌我识别,构成一套危险的支持装备."

	belt = /obj/item/storage/belt/marine/sg62
	suit_store = /obj/item/weapon/gun/rifle/sg62/motion

	backpack_contents = list(
		/obj/item/ammo_magazine/rifle/sg153/incendiary = 2,
		/obj/item/ammo_magazine/rifle/sg153/tungsten = 2,
		/obj/item/ammo_magazine/pistol/vp70 = 2,
		/obj/item/weapon/gun/pistol/vp70/tactical = 1,
	)
	webbing_contents = list(
		/obj/item/storage/box/mre = 1,
		/obj/item/ammo_magazine/rifle/sg153/highimpact = 4,
	)
