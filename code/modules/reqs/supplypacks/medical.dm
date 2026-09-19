/datum/supply_packs/medical
	group = "医疗"
	containertype = /obj/structure/closet/crate/medical

/datum/supply_packs/medical/advanced_medical
	name = "应急医疗用品"
	contains = list(
		/obj/item/storage/pouch/medical_injectors/medic,
		/obj/item/storage/pouch/medical_injectors/medic,
		/obj/item/storage/pouch/medical_injectors/medic,
		/obj/item/storage/pouch/medical_injectors/medic,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/stack/nanopaste,
	)
	cost = 300

/datum/supply_packs/medical/Sulfasalazine
	name = "柳氮磺吡啶自动注射器"
	contains = list(
		/obj/item/reagent_containers/hypospray/autoinjector/sulfasalazine,
	)
	cost = 250

/datum/supply_packs/medical/biomass
	name = "生物质烧杯"
	contains = list(
		/obj/item/reagent_containers/glass/beaker/biomass,
	)
	cost = 150

/datum/supply_packs/medical/Medical_hud
	name = "健康伴侣医疗HUD"
	contains = list(
		/obj/item/clothing/glasses/hud/health,
	)
	cost = 20

/datum/supply_packs/medical/medical
	name = "药丸与化学品"
	contains = list(
		/obj/item/storage/box/autoinjectors,
		/obj/item/storage/box/syringes,
		/obj/item/reagent_containers/glass/bottle/inaprovaline,
		/obj/item/reagent_containers/glass/bottle/dylovene,
		/obj/item/reagent_containers/glass/bottle/bicaridine,
		/obj/item/reagent_containers/glass/bottle/dexalin,
		/obj/item/reagent_containers/glass/bottle/spaceacillin,
		/obj/item/reagent_containers/glass/bottle/kelotane,
		/obj/item/reagent_containers/glass/bottle/tramadol,
		/obj/item/storage/pill_bottle/inaprovaline,
		/obj/item/storage/pill_bottle/dylovene,
		/obj/item/storage/pill_bottle/bicaridine,
		/obj/item/storage/pill_bottle/dexalin,
		/obj/item/storage/pill_bottle/spaceacillin,
		/obj/item/storage/pill_bottle/kelotane,
		/obj/item/storage/pill_bottle/tramadol,
		/obj/item/storage/pill_bottle/quickclot,
		/obj/item/storage/box/pillbottles,
	)
	cost = 100

/datum/supply_packs/medical/firstaid
	name = "高级急救包"
	contains = list(/obj/item/storage/firstaid/adv)
	cost = 50

/datum/supply_packs/medical/bodybag
	name = "裹尸袋"
	notes = "Contains 7 bodybags"
	contains = list(/obj/item/storage/box/bodybags)
	cost = 50

/datum/supply_packs/medical/cryobag
	name = "停滞袋"
	contains = list(/obj/item/bodybag/cryobag)
	cost = 50

/datum/supply_packs/medical/surgery
	name = "手术设备"
	contains = list(
		/obj/item/storage/surgical_tray,
		/obj/item/clothing/mask/breath/medical,
		/obj/item/tank/anesthetic,
	)
	cost = 100
	access = ACCESS_MARINE_MEDBAY
	containertype = /obj/structure/closet/crate/secure/surgery

/datum/supply_packs/medical/hypospray
	name = "高级注射器"
	contains = list(/obj/item/reagent_containers/hypospray/advanced)
	cost = 50
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/hypospray
	name = "高级大型注射器"
	contains = list(/obj/item/reagent_containers/hypospray/advanced/big)
	cost = 120 //just a little over the regular hypo.
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/medvac
	name = "医疗后送系统"
	contains = list(
		/obj/item/roller/medevac,
		/obj/item/medevac_beacon,
	)
	cost = 500
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/lemolime
	name = "柠檬碱瓶"
	notes = "Contains 1 bottle of lemoline with 30 units each."
	contains = list(
		/obj/item/reagent_containers/glass/bottle/lemoline/doctor,
	)
	cost = 80

/datum/supply_packs/medical/advancedKits
	name = "高级医疗包"
	notes = "Contains 5 advanced packs of each type and 5 splints."
	contains = list(
		/obj/item/stack/medical/heal_pack/advanced/bruise_pack,
		/obj/item/stack/medical/heal_pack/advanced/bruise_pack,
		/obj/item/stack/medical/heal_pack/advanced/bruise_pack,
		/obj/item/stack/medical/heal_pack/advanced/bruise_pack,
		/obj/item/stack/medical/heal_pack/advanced/bruise_pack,
		/obj/item/stack/medical/heal_pack/advanced/burn_pack,
		/obj/item/stack/medical/heal_pack/advanced/burn_pack,
		/obj/item/stack/medical/heal_pack/advanced/burn_pack,
		/obj/item/stack/medical/heal_pack/advanced/burn_pack,
		/obj/item/stack/medical/heal_pack/advanced/burn_pack,
		/obj/item/stack/medical/splint,
		/obj/item/stack/medical/splint,
		/obj/item/stack/medical/splint,
		/obj/item/stack/medical/splint,
		/obj/item/stack/medical/splint,
	)
	cost = 100 //you have ALMOST infinite ones in medbay if you need this crate you fucked up. but no reason to make the price too high either
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/tweezers
	name = "镊子"
	notes = "contains a pair of tweezers."
	contains = list(/obj/item/tweezers)
	cost = 125
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/tweezers_advanced
	name = "高级镊子"
	notes = "contains advanced tweezers."
	contains = list(/obj/item/tweezers_advanced)
	cost = 250
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/implanter
	name = "植入器"
	notes = "contains an implanter for reinsertion of the implant."
	contains = list(/obj/item/implanter/skill/cargo)
	cost = 90

/datum/supply_packs/medical/defibrillator_gloves
	name = "高级除颤器医疗手套"
	notes = "contains advanced defibrillator medical gloves."
	contains = list(/obj/item/clothing/gloves/defibrillator)
	cost = 120
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/defibrillator_compact
	name = "紧凑型除颤器"
	notes = "contains compact defibrillator"
	contains = list(/obj/item/defibrillator/compact)
	cost = 120
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/healthanalyzer_gloves
	name = "健康扫描手套"
	notes = "contains health scanner gloves."
	contains = list(/obj/item/clothing/gloves/healthanalyzer)
	cost = 60
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/deployable_optable
	name = "可部署手术台"
	notes = "Contains an operating table that can be transported and deployed for medical procedures."
	contains = list(/obj/item/deployable_optable)
	cost = 200
	containertype = /obj/structure/closet/crate/secure/surgery

/datum/supply_packs/medical/advanced_medical_kits
	name = "高级医疗套件"
	notes = "contains pair advanced medical kits from medical vendors."
	contains = list(/obj/item/stack/medical/heal_pack/advanced/bruise_combat_pack, /obj/item/stack/medical/heal_pack/advanced/burn_combat_pack)
	cost = 120
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/combat_medicine
	name = "战场医疗"
	notes = "contains 4 hypospray with MD, many injectors peri and quick, neuraline, nanopaste."
	contains = list(
		/obj/item/reagent_containers/hypospray/advanced/meraderm,
		/obj/item/reagent_containers/hypospray/advanced/meraderm,
		/obj/item/reagent_containers/hypospray/advanced/meraderm,
		/obj/item/reagent_containers/hypospray/advanced/meraderm,
		/obj/item/reagent_containers/hypospray/advanced/oxycodone,
		/obj/item/reagent_containers/hypospray/advanced/oxycodone,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus,
		/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/stack/nanopaste,
	) // Кто-то скажет, что это имба, а я вам скажу, что этот набор уже есть в игре буквально самой первой строчкой в медкарго, я просто перепаковал его выставив на общее обозрение.
	cost = 300

/datum/supply_packs/medical/cryomix
	name = "低温烧杯"
	notes = "contains cryomix beaker"
	contains = list (
		/obj/item/reagent_containers/glass/beaker/cryomix,
	)
	cost = 250

/datum/supply_packs/medical/combat_robot_medicine
	name = "机器人战斗维修"
	notes = "contains 5 nanopaste for robots or technic."
	contains = list(
		/obj/item/stack/nanopaste,
		/obj/item/stack/nanopaste,
		/obj/item/stack/nanopaste,
		/obj/item/stack/nanopaste,
		/obj/item/stack/nanopaste,
	)
	cost = 230

/datum/supply_packs/medical/soldering_tool
	name = "焊接工具"
	notes = "contains 1 soldering tool for repair robots."
	contains = list(/obj/item/tool/surgery/solderingtool)
	cost = 30

/datum/supply_packs/medical/nanoblood_hypo
	name = "纳米血液注射器"
	notes = "contains 2 hypo with nanoblood."
	contains = list(
		/obj/item/reagent_containers/hypospray/advanced/nanoblood,
		/obj/item/reagent_containers/hypospray/advanced/nanoblood,
	)
	cost = 100
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/meraderm_pills
	name = "美拉德姆药丸瓶"
	notes = "contains meralyne and dermaline pill bottle."
	contains = list(
		/obj/item/storage/pill_bottle/dermaline,
		/obj/item/storage/pill_bottle/meralyne,
	)
	cost = 250

/datum/supply_packs/medical/bs_beakers
	name = "蓝空间烧杯"
	notes = "contains two BS beakers."
	contains = list(
		/obj/item/reagent_containers/glass/beaker/bluespace,
		/obj/item/reagent_containers/glass/beaker/bluespace,
	)
	cost = 50

/datum/supply_packs/medical/bktt_dispenser
	name = "BKTT分配器"
	notes = "contains one BKTT dispenser."
	contains = list(/obj/item/storage/reagent_tank/bktt)
	cost = 120

/datum/supply_packs/medical/antitox_kit
	name = "抗毒素药丸瓶套件"
	notes = "contains some things against toxins."
	contains = list(
		/obj/item/storage/pill_bottle/hypervene,
		/obj/item/storage/pill_bottle/dylovene,
		/obj/item/storage/pill_bottle/tricordrazine,
	)
	cost = 20

/datum/supply_packs/medical/imialky_kit
	name = "伊米阿尔基药丸瓶套件"
	notes = "contains pill bottles imialky."
	contains = list(
		/obj/item/storage/pill_bottle/imialky,
		/obj/item/storage/pill_bottle/imialky,
	)
	cost = 30

/datum/supply_packs/medical/quick_peri_kit
	name = "速效佩里自动注射器套件"
	notes = "contains quick-clot and peri injectors."
	contains = list(
		/obj/item/reagent_containers/hypospray/autoinjector/quickclot,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon,
	)
	cost = 30

/datum/supply_packs/medical/russian_red_bottle
	name = "俄罗斯红药丸瓶"
	notes = "contains one pill bottle red russian."
	contains = list(/obj/item/storage/pill_bottle/russian_red)
	cost = 250

/datum/supply_packs/medical/synaptizine_injector
	name = "突触嗪自动注射器"
	notes = "contains synaptizine auto injector."
	contains = list(/obj/item/reagent_containers/hypospray/autoinjector/synaptizine)
	cost = 30

/datum/supply_packs/medical/oxycodone_injector
	name = "羟考酮自动注射器"
	notes = "contains oxycodone auto injector."
	contains = list(/obj/item/reagent_containers/hypospray/autoinjector/oxycodone)
	cost = 20

/datum/supply_packs/medical/neuraline_kit
	name ="大型神经碱自动注射器套件"
	notes = "contains five neuraline injectors"
	contains = list(
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
		/obj/item/reagent_containers/hypospray/autoinjector/neuraline,
	)
	cost = 250

/datum/supply_packs/medical/neuraline_kit_injector
	name ="神经碱自动注射器"
	notes = "contains one neuraline injector"
	contains = list(/obj/item/reagent_containers/hypospray/autoinjector/neuraline)
	cost = 70

/datum/supply_packs/medical/bktt_kit
	name = "BKTT药丸瓶套件"
	notes = "contains pill bottles BKTT."
	contains = list(
		/obj/item/storage/pill_bottle/bicaridine,
		/obj/item/storage/pill_bottle/kelotane,
		/obj/item/storage/pill_bottle/tricordrazine,
		/obj/item/storage/pill_bottle/tramadol,
	)
	cost = 20

/datum/supply_packs/medical/medicine_defibrillator
	name = "医疗除颤器"
	notes = "contains medical defibrillator."
	contains = list(/obj/item/defibrillator)
	cost = 50
	containertype = /obj/structure/closet/crate/secure/surgery
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/t312case
	name = "R-312 '阿尔贝多'左轮手枪捆绑包"
	contains = list(/obj/item/storage/briefcase/t312)
	cost = 500

/datum/supply_packs/medical/t312
	name = "R-312 '阿尔贝多'左轮手枪"
	contains = list(/obj/item/attachable/lace/t500, /obj/item/weapon/gun/revolver/t312)
	cost = 150

/datum/supply_packs/medical/t312_adr
	name = "R-312肾上腺素弹药"
	contains = list(/obj/item/ammo_magazine/packet/t312/med/adrenaline, /obj/item/ammo_magazine/revolver/t312/med/adrenaline)
	cost = 50

/datum/supply_packs/medical/t312_rr
	name = "R-312俄罗斯红弹药"
	contains = list(/obj/item/ammo_magazine/packet/t312/med/rr, /obj/item/ammo_magazine/revolver/t312/med/rr)
	cost = 150

/datum/supply_packs/medical/t312_md
	name = "R-312美拉德姆弹药"
	contains = list(/obj/item/ammo_magazine/packet/t312/med/md, /obj/item/ammo_magazine/revolver/t312/med/md)
	cost = 100

/datum/supply_packs/medical/t312_neu
	name = "R-312神经碱弹药"
	contains = list(/obj/item/ammo_magazine/packet/t312/med/neu, /obj/item/ammo_magazine/revolver/t312/med/neu)
	cost = 200

/datum/supply_packs/medical/t312_medkit
	name = "BMSS医疗包袋"
	contains = list(/obj/item/storage/pouch/medkit/t312)
	cost = 10
