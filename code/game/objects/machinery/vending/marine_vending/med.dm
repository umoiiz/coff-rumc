/obj/machinery/vending/MarineMed
	name = "\improper 陆战队医疗"
	desc = "陆战队药品分配器 - 由纳米传思制药部门(TM)提供."
	icon_state = "marinemed"
	icon_vend = "marinemed-vend"
	icon_deny = "marinemed-deny"
	product_ads = "去救几条命吧!;给你的医疗舱最好的东西.;只有最好的工具.;全天然化学品!;这东西能救命.;你不想要点吗?"
	req_one_access = ALL_MARINE_ACCESS
	wrenchable = FALSE
	isshared = TRUE
	products = list(
		"药瓶" = list(
			/obj/item/storage/pill_bottle/bicaridine = -1,
			/obj/item/storage/pill_bottle/kelotane = -1,
			/obj/item/storage/pill_bottle/tramadol = -1,
			/obj/item/storage/pill_bottle/tricordrazine = -1,
			/obj/item/storage/pill_bottle/ifosfamide = -1,
			/obj/item/storage/pill_bottle/combatmix = -1,
			/obj/item/storage/pill_bottle/dylovene = -1,
			/obj/item/storage/pill_bottle/dexalin = -1,
			/obj/item/storage/pill_bottle/paracetamol = -1,
			/obj/item/storage/pill_bottle/isotonic = -1,
			/obj/item/storage/pill_bottle/sugar = -1,
			/obj/item/storage/pill_bottle/doctor_delight = -1,
			/obj/item/storage/pill_bottle = -1,
		),
		"自动注射器" = list(
			/obj/item/reagent_containers/hypospray/autoinjector/bicaridine = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/kelotane = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/tramadol = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/tricordrazine = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/dylovene = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/combat = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/isotonic = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/spaceacillin = 20,
			/obj/item/reagent_containers/hypospray/autoinjector/hypervene = 20,
			/obj/item/reagent_containers/hypospray/autoinjector/alkysine = 20,
			/obj/item/reagent_containers/hypospray/autoinjector/imidazoline = 20,
			/obj/item/reagent_containers/hypospray/autoinjector/medicalnanites = 20,
		),
		"治疗包" = list(
			/obj/item/stack/medical/heal_pack/gauze = -1,
			/obj/item/stack/medical/heal_pack/ointment = -1,
			/obj/item/stack/medical/splint = -1,
			/obj/item/stack/medical/heal_pack/advanced/bruise_pack = 50,
			/obj/item/stack/medical/heal_pack/advanced/burn_pack = 50,
		),
		"杂项" = list(
			/obj/item/defibrillator = 8,
			/obj/item/healthanalyzer = 16,
			/obj/item/bodybag/cryobag = 24,
		),
	)

/obj/machinery/vending/MarineMed/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
	req_one_access = null
	products = list(
		"药瓶" = list(
			/obj/item/storage/pill_bottle/bicaridine = -1,
			/obj/item/storage/pill_bottle/kelotane = -1,
			/obj/item/storage/pill_bottle/tramadol = -1,
			/obj/item/storage/pill_bottle/tricordrazine = -1,
			/obj/item/storage/pill_bottle/ifosfamide = -1,
			/obj/item/storage/pill_bottle/combatmix = -1,
			/obj/item/storage/pill_bottle/dylovene = -1,
			/obj/item/storage/pill_bottle/dexalin = -1,
			/obj/item/storage/pill_bottle/paracetamol = -1,
			/obj/item/storage/pill_bottle/isotonic = -1,
			/obj/item/storage/pill_bottle/sugar = -1,
			/obj/item/storage/pill_bottle/doctor_delight = -1,
			/obj/item/storage/pill_bottle = -1,
		),
		"自动注射器" = list(
			/obj/item/reagent_containers/hypospray/autoinjector/bicaridine = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/kelotane = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/tramadol = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/tricordrazine = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/dylovene = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/combat = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/isotonic = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/hypervene = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/alkysine = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/imidazoline = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/quickclot = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/medicalnanites = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/russian_red = -1,
		),
		"治疗包" = list(
			/obj/item/stack/medical/heal_pack/gauze = -1,
			/obj/item/stack/medical/heal_pack/ointment = -1,
			/obj/item/stack/medical/heal_pack/advanced/bruise_pack = -1,
			/obj/item/stack/medical/heal_pack/advanced/burn_pack = -1,
			/obj/item/stack/medical/splint = -1,
		),
		"杂项" = list(
			/obj/item/defibrillator = -1,
			/obj/item/healthanalyzer = -1,
			/obj/item/clothing/gloves/healthanalyzer = -1,
			/obj/item/bodybag/cryobag = -1,
		),
		"英灵殿" = list(
			/obj/item/reagent_containers/hypospray/autoinjector/virilyth = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/roulettium = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/rezadone = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/spaceacillin = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/combat = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/synaptizine = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/neuraline = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = -1,
		))

/obj/machinery/vending/MarineMed/Blood
	name = "\improper MM血液分配器"
	desc = "陆战队医疗品牌血液包分配器."
	icon_state = "bloodvendor"
	icon_vend = "bloodvendor-vend"
	icon_deny = "bloodvendor-deny"
	product_slogans = "市面上最好的血!;完全来自道德来源!;O型阴性是万能供血者,用它!;从今天开始预防低血容量性休克!"
	products = list(
		/obj/item/reagent_containers/blood/APlus = 5,
		/obj/item/reagent_containers/blood/AMinus = 5,
		/obj/item/reagent_containers/blood/BPlus = 5,
		/obj/item/reagent_containers/blood/BMinus = 5,
		/obj/item/reagent_containers/blood/OPlus = 5,
		/obj/item/reagent_containers/blood/OMinus = -1,
		/obj/item/reagent_containers/blood/empty = 10,
	)

/obj/machinery/vending/MarineMed/Blood/build_inventory(list/productlist, category)
	. = ..()
	var/temp_list[] = productlist
	var/obj/item/reagent_containers/blood/temp_path
	var/blood_type
	for(var/datum/vending_product/R AS in (product_records + coin_records))
		if(R.product_path in temp_list)
			temp_path = R.product_path
			blood_type = initial(temp_path.blood_type)
			R.product_name += blood_type? " [blood_type]" : ""
			temp_list -= R.product_path
			if(!length(temp_list)) break

/obj/machinery/vending/MarineMed/Blood/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
	req_one_access = null
	products = list(
		/obj/item/reagent_containers/blood/APlus = -1,
		/obj/item/reagent_containers/blood/AMinus = -1,
		/obj/item/reagent_containers/blood/BPlus = -1,
		/obj/item/reagent_containers/blood/BMinus = -1,
		/obj/item/reagent_containers/blood/OPlus = -1,
		/obj/item/reagent_containers/blood/OMinus = -1,
		/obj/item/reagent_containers/blood/empty = -1,
	)
