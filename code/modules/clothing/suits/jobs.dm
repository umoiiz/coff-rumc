/**
* Job related clothing
*/

//Botonist
/obj/item/clothing/suit/storage/apron
	name = "围裙"
	desc = "一件基本的蓝色围裙."
	icon_state = "apron"
	worn_icon_state = "apron"
	blood_overlay_type = "armor"
	armor_protection_flags = NONE
	allowed = list (
		/obj/item/reagent_containers/spray/plantbgone,
		/obj/item/tool/analyzer/plant_analyzer,
		/obj/item/seeds,
		/obj/item/reagent_containers/glass/fertilizer,
		/obj/item/tool/minihoe,
		/obj/item/flashlight,
		/obj/item/binoculars,
		/obj/item/weapon/combat_knife,
		/obj/item/attachable/bayonetknife,
		/obj/item/storage/holster/blade,
		/obj/item/tool/hatchet,
		/obj/item/tool/scythe
	)


/obj/item/clothing/suit/surgical
	name = "手术围裙"
	desc = "一件用于在手术期间防止体液通过的塑料覆盖物."
	icon_state = "surgical"
	worn_icon_state = "surgical"
	armor_protection_flags = CHEST
	allowed = list(
		/obj/item/tank/emergency_oxygen,
		/obj/item/healthanalyzer,
		/obj/item/flashlight/pen,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/pill,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/tool/surgery,
		/obj/item/stack/nanopaste,
		/obj/item/tweezers,
		/obj/item/tweezers_advanced,
	)
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, FIRE = 0, ACID = 0)


//Captain
/obj/item/clothing/suit/captunic
	name = "舰长阅兵礼服"
	desc = "由舰长穿着以彰显其阶级."
	icon_state = "captunic"
	worn_icon_state = "bio_suit"
	armor_protection_flags = CHEST|ARMS
	inv_hide_flags = HIDEJUMPSUIT

/obj/item/clothing/suit/captunic/capjacket
	name = "舰长制服夹克"
	desc = "一件用于舰长日常穿着的较不正式的夹克."
	icon_state = "capjacket"
	worn_icon_state = "bio_suit"
	armor_protection_flags = CHEST|GROIN|LEGS|ARMS
	inv_hide_flags = HIDEJUMPSUIT

//Chaplain
/obj/item/clothing/suit/chaplain_hoodie
	name = "牧师连帽衫"
	desc = "这套衣服对你说\"嘘\"!"
	icon_state = "chaplain_hoodie"
	worn_icon_state = "chaplain_hoodie"
	armor_protection_flags = CHEST|ARMS

/obj/item/clothing/suit/nun
	name = "修女长袍"
	desc = "这个星系中最虔诚的象征."
	icon_state = "nun"
	worn_icon_state = "nun"
	armor_protection_flags = CHEST|GROIN|LEGS|ARMS
	inv_hide_flags = HIDESHOES|HIDEJUMPSUIT

//Chef
/obj/item/clothing/suit/storage/chef
	name = "厨师围裙"
	desc = "高级厨师使用的围裙."
	icon_state = "chef"
	worn_icon_state = "chef"
	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.50
	armor_protection_flags = CHEST|GROIN|ARMS
	allowed = list(
		/obj/item/tool/kitchen/knife,
		/obj/item/tool/kitchen/knife/butcher,
	)

/obj/item/clothing/suit/storage/chef/classic
	name = "经典的厨师围裙."
	desc = "一条基本、单调的白色厨师围裙."
	icon_state = "apronchef"
	worn_icon_state = "apronchef"
	blood_overlay_type = "armor"
	armor_protection_flags = NONE

/obj/item/clothing/suit/storage/chef/military
	name = "厨师军用围裙"
	desc = "一条漂亮的军用围裙. 看起来上面有些徽章被撕掉了."
	icon_state = "fartumasti"
	worn_icon_state = "fartumasti"
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/storage/holster/blade,
		/obj/item/weapon/sword/harvester,
		/obj/item/storage/belt/knifepouch,
		/obj/item/weapon/twohanded,
	)
	soft_armor = list(MELEE = 20, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

//Security
/obj/item/clothing/suit/security
	desc = "你不该看到这个"
	armor_protection_flags = CHEST|GROIN|ARMS

/obj/item/clothing/suit/security/formal
	name = "正式夹克"
	desc = "一件正式的军用夹克. 不建议在战斗中使用."
	icon_state = "officerbluejacket"

/obj/item/clothing/suit/storage/security/formal/senior_officer
	name = "高级军官夹克"
	desc = "这件衣物专为彰显上级权威而设计."
	icon_state = "hosbluejacket"

/obj/item/clothing/suit/storage/security/formal/senior_officer/tan
	icon_state = "hostanjacket"

//Detective
/obj/item/clothing/suit/storage/det_suit
	name = "大衣"
	desc = "一件18世纪的多用途风衣. 穿它的人意味着是认真的."
	icon_state = "detective"
	worn_icon_state = "det_suit"
	blood_overlay_type = "coat"
	armor_protection_flags = CHEST|ARMS
	allowed = list(
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/weapon/gun,
		/obj/item/ammo_magazine,
		/obj/item/ammo_casing,
		/obj/item/weapon/baton,
		/obj/item/restraints/handcuffs,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/detective_scanner,
		/obj/item/taperecorder,
		/obj/item/weapon/combat_knife,
		/obj/item/attachable/bayonetknife,
		/obj/item/storage/holster/blade,
	)
	soft_armor = list(MELEE = 10, BULLET = 10, LASER = 25, ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 10, ACID = 10)

/obj/item/clothing/suit/storage/det_suit/black
	icon_state = "detective2"

//Forensics
/obj/item/clothing/suit/storage/forensics
	name = "夹克"
	desc = "一件法医技术员夹克."
	worn_icon_state = "det_suit"
	armor_protection_flags = CHEST|ARMS
	allowed = list(
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/weapon/gun,
		/obj/item/ammo_magazine,
		/obj/item/ammo_casing,
		/obj/item/weapon/baton,
		/obj/item/restraints/handcuffs,
		/obj/item/detective_scanner,
		/obj/item/taperecorder,
	)
	soft_armor = list(MELEE = 10, BULLET = 10, LASER = 15, ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 10, ACID = 10)

/obj/item/clothing/suit/storage/forensics/red
	name = "红色夹克"
	desc = "一件红色法医技术员夹克."
	icon_state = "forensics_red"

/obj/item/clothing/suit/storage/forensics/blue
	name = "蓝色夹克"
	desc = "一件蓝色法医技术员夹克."
	icon_state = "forensics_blue"

//Engineering
/obj/item/clothing/suit/storage/hazardvest
	name = "橙色反光安全背心"
	desc = "工作区域使用的高可见度背心."
	icon_state = "hazard"
	worn_icon_state = "hazard"
	blood_overlay_type = "armor"
	allowed = list(
		/obj/item/tool/analyzer,
		/obj/item/flashlight,
		/obj/item/tool/multitool,
		/obj/item/pipe_painter,
		/obj/item/radio,
		/obj/item/t_scanner,
		/obj/item/tool/crowbar,
		/obj/item/tool/screwdriver,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/wrench,
		/obj/item/tank/emergency_oxygen,
		/obj/item/clothing/mask/gas,
		/obj/item/tool/taperoll/engineering,
	)
	armor_protection_flags = CHEST

/obj/item/clothing/suit/storage/hazardvest/lime
	name = "青柠色反光安全背心"
	icon_state = "hazard_lime"
	worn_icon_state = "hazard_lime"

/obj/item/clothing/suit/storage/hazardvest/blue
	name = "蓝色反光安全背心"
	icon_state = "hazard_blue"
	worn_icon_state = "hazard_blue"

//Lawyer
/obj/item/clothing/suit/storage/lawyer/bluejacket
	name = "蓝色西装外套"
	desc = "一件时髦的礼服外套."
	icon_state = "suitjacket_blue_open"
	worn_icon_state = "suitjacket_blue_open"
	blood_overlay_type = "coat"
	armor_protection_flags = CHEST|ARMS

/obj/item/clothing/suit/storage/lawyer/purpjacket
	name = "紫色西装外套"
	desc = "一件时髦的礼服外套."
	icon_state = "suitjacket_purp"
	worn_icon_state = "suitjacket_purp"
	blood_overlay_type = "coat"
	armor_protection_flags = CHEST|ARMS

//Medical
/obj/item/clothing/suit/storage/fr_jacket
	name = "急救员夹克"
	desc = "医疗急救人员穿的高可见度夹克."
	icon_state = "fr_jacket_open"
	worn_icon_state = "fr_jacket"
	blood_overlay_type = "armor"
	allowed = list(
		/obj/item/stack/medical,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/syringe,
		/obj/item/healthanalyzer,
		/obj/item/flashlight,
		/obj/item/radio,
		/obj/item/tank/emergency_oxygen,
	)
	armor_protection_flags = CHEST|ARMS

/obj/item/clothing/suit/storage/fr_jacket/verb/toggle()
	set name = "Toggle Jacket Buttons"
	set category = "IC.Clothing"
	set src in usr

	if(!usr.canmove || usr.stat || usr.restrained())
		return FALSE

	switch(icon_state)
		if("fr_jacket_open")
			src.icon_state = "fr_jacket"
			to_chat(usr, "你扣上了夹克.")
		if("fr_jacket")
			src.icon_state = "fr_jacket_open"
			to_chat(usr, "你解开了夹克.")
	update_clothing_icon()	//so our overlays update

//Mime
/obj/item/clothing/suit/suspenders
	name = "吊带"
	desc = "它们支撑着哑剧表演的幻象."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "suspenders"
	blood_overlay_type = "armor" //it's the less thing that I can put here
	armor_protection_flags = NONE

/obj/item/clothing/suit/storage/snow_suit
	name = "雪地服"
	desc = "一件标准雪地服. 可以保护穿戴者免受极寒."
	icon_state = "snowsuit"
	armor_protection_flags = CHEST|GROIN|ARMS
	cold_protection_flags = CHEST|GROIN|ARMS|LEGS
	soft_armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	blood_overlay_type = "armor"
	siemens_coefficient = 0.7
	permeability_coefficient = 0.8
	allowed = list (/obj/item/flashlight, /obj/item/tank/emergency_oxygen)

/obj/item/clothing/suit/storage/snow_suit/doctor
	name = "医生雪地服"
	icon_state = "snowsuit_doctor"
	permeability_coefficient = 0.6
	soft_armor = list(MELEE = 25, BULLET = 35, LASER = 35, ENERGY = 20, BOMB = 10, BIO = 0, FIRE = 20, ACID = 20)

/obj/item/clothing/suit/storage/snow_suit/engineer
	name = "工程师雪地服"
	icon_state = "snowsuit_engineer"
	soft_armor = list(MELEE = 25, BULLET = 35, LASER = 35, ENERGY = 20, BOMB = 10, BIO = 0, FIRE = 20, ACID = 20)
