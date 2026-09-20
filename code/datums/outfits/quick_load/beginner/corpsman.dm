/datum/outfit/quick/beginner/corpsman
	jobtype = SQUAD_CORPSMAN

	w_uniform = /obj/item/clothing/under/marine/corpsman/corpman_vest
	glasses = /obj/item/clothing/glasses/hud/health
	r_hand = /obj/item/medevac_beacon

	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 2,
	)

/datum/outfit/quick/beginner/corpsman/lifesaver
	name = "Standard Lifesaver"
	desc = "奇迹正在发生. \
	手持栓动式莱卡斯特连发枪, 并配备了种类繁多的药品, 以维持整个部队的补给和战斗力."

	suit_store = /obj/item/weapon/gun/shotgun/pump/lever/repeater/beginner
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/mimirinjector
	gloves = /obj/item/clothing/gloves/defibrillator
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x/mimir
	r_pocket = /obj/item/storage/pouch/medkit/medic
	l_pocket = /obj/item/storage/pouch/shotgun
	back = /obj/item/storage/backpack/marine/corpsman
	belt = /obj/item/storage/belt/lifesaver/beginner
	l_hand = /obj/item/paper/tutorial/lifesaver

	webbing_contents = list(
		/obj/item/roller = 1,
		/obj/item/bodybag/cryobag = 1,
		/obj/item/reagent_containers/hypospray/advanced/oxycodone = 1,
		/obj/item/reagent_containers/hypospray/advanced/nanoblood = 1,
		/obj/item/roller/medevac = 1,
		/obj/item/tweezers = 1,
	)
	suit_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = 8,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon = 2,
	)
	backpack_contents = list(
		/obj/item/storage/box/m94 = 3,
		/obj/item/ammo_magazine/packet/p4570 = 7,
		/obj/item/tool/extinguisher/mini = 1,
	)
	l_pocket_contents = list(
		/obj/item/ammo_magazine/handful/repeater = 7,
	)

/datum/outfit/quick/beginner/corpsman/hypobelt
	name = "Standard Hypobelt"
	desc = "将战斗融入战斗医疗兵. \
	手持泵动式SH-35霰弹枪, 并配备了一条装满注射器的腰带, 用于快速治疗状况不佳的患者."

	suit_store = /obj/item/weapon/gun/shotgun/pump/t35/beginner
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/light/lightmedical
	gloves = /obj/item/clothing/gloves/healthanalyzer
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/m10x/antenna
	r_pocket = /obj/item/storage/pouch/medkit/medic
	l_pocket = /obj/item/storage/pouch/shotgun
	back = /obj/item/storage/backpack/marine/corpsman
	belt = /obj/item/storage/belt/hypospraybelt/beginner
	l_hand = /obj/item/paper/tutorial/hypobelt

	webbing_contents = list(
		/obj/item/stack/medical/splint = 6
	)
	suit_contents = list(
		/obj/item/roller = 1,
		/obj/item/bodybag/cryobag = 1,
		/obj/item/reagent_containers/hypospray/advanced/oxycodone = 1,
		/obj/item/roller/medevac = 1,
		/obj/item/tweezers = 1,
	)
	l_pocket_contents = list(
		/obj/item/ammo_magazine/handful/slug = 7,
	)
	backpack_contents = list(
		/obj/item/storage/box/m94 = 3,
		/obj/item/tool/extinguisher = 1,
		/obj/item/defibrillator/advanced = 1,
		/obj/item/ammo_magazine/shotgun = 4,
	)
