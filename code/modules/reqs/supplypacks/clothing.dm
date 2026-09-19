/datum/supply_packs/clothing
	group = "服装"
	containertype = /obj/structure/closet/crate

/datum/supply_packs/clothing/combat_pack
	name = "战斗背包"
	contains = list(/obj/item/storage/backpack/lightpack)
	cost = 150

/datum/supply_packs/clothing/dispenser
	name = "分配器"
	contains = list(/obj/item/storage/backpack/dispenser)
	cost = 400

/datum/supply_packs/clothing/welding_pack
	name = "工程焊接包"
	contains = list(/obj/item/storage/backpack/marine/engineerpack)
	cost = 50

/datum/supply_packs/clothing/radio_pack
	name = "无线电操作员包"
	contains = list(/obj/item/storage/backpack/marine/radiopack)
	cost = 20

/datum/supply_packs/clothing/technician_pack
	name = "工程技术员包"
	contains = list(/obj/item/storage/backpack/marine/tech)
	cost = 50

/datum/supply_packs/clothing/corpsman_satchel
	name = "TGMC医疗兵挎包"
	contains = list(/obj/item/storage/backpack/marine/corpsman/satchel)
	cost = 75

/datum/supply_packs/clothing/corpsman_backpack
	name = "TGMC医疗兵背包"
	contains = list(/obj/item/storage/backpack/marine/corpsman)
	cost = 125 // higher price because it has a better cell

/datum/supply_packs/clothing/Med_hud_implant
	name = "医疗HUD植入器"
	contains = list(/obj/item/implanter/hud/medical)
	cost = 75

/datum/supply_packs/clothing/officer_outfits
	name = "军官制服"
	contains = list(
		/obj/item/clothing/under/marine/officer/ro_suit,
		/obj/item/clothing/under/marine/officer/bridge,
		/obj/item/clothing/under/marine/officer/bridge,
		/obj/item/clothing/under/marine/officer/exec,
		/obj/item/clothing/under/marine/officer/ce,
	)
	cost = 100

/datum/supply_packs/clothing/jetpack
	name = "喷气背包"
	contains = list(/obj/item/jetpack_marine)
	cost = 120

/datum/supply_packs/clothing/night_vision
	name = "BE-47 NVG夜视护目镜"
	contains = list(/obj/item/clothing/glasses/night_vision)
	cost = 400

/datum/supply_packs/clothing/night_vision_mounted
	name = "BE-35 NVG夜视模块"
	contains = list(/obj/item/armor_module/module/night_vision)
	cost = 200

/datum/supply_packs/clothing/night_vision_battery
	name = "夜视电池"
	contains = list(/obj/item/cell/night_vision_battery)
	cost = 100

/datum/supply_packs/clothing/saddle
	name = "奔跑者鞍具"
	contains = list(/obj/item/storage/backpack/marine/duffelbag/xenosaddle)
	cost = 120
