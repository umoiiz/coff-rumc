/obj/item/clothing/head/helmet
	name = "头盔"
	desc = "标准安保装备. 保护头部免受撞击."
	icon_state = "helmet"
	worn_icon_state = "helmet"
	accuracy_mod = 0
	soft_armor = list(MELEE = 50, BULLET = 15, LASER = 50, ENERGY = 10, BOMB = 25, BIO = 0, FIRE = 10, ACID = 10)
	atom_flags = CONDUCT
	inventory_flags = COVEREYES|BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDEEYES
	cold_protection_flags = HEAD
	heat_protection_flags = HEAD
	min_cold_protection_temperature = HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROTECTION_TEMPERATURE
	colorable_allowed = HAIR_CONCEALING_CHANGE_ALLOWED
	siemens_coefficient = 0.7
	w_class = WEIGHT_CLASS_NORMAL
	armor_features_flags = ARMOR_NO_DECAP
	item_flags = SYNTH_RESTRICTED

/obj/item/clothing/head/helmet/riot
	name = "防暴头盔"
	desc = "这是一顶专为防御近距离攻击而设计的头盔. 它能护住你的耳朵."
	icon_state = "riot"
	soft_armor = list(MELEE = 82, BULLET = 15, LASER = 5, ENERGY = 5, BOMB = 5, BIO = 2, FIRE = 5, ACID = 5)
	inventory_flags = COVEREYES|BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDEEYES|HIDETOPHAIR
	item_flags = SYNTH_RESTRICTED

/obj/item/clothing/head/helmet/HoS
	name = "安保主管帽"
	desc = "安保主管的帽子. 用来向军官们展示谁才是老大."
	icon_state = "hoscap"
	soft_armor = list(MELEE = 80, BULLET = 60, LASER = 50, ENERGY = 10, BOMB = 25, BIO = 10, FIRE = 10, ACID = 10)
	inventory_flags = COVEREYES
	inv_hide_flags = HIDEEARS
	armor_protection_flags = NONE
	siemens_coefficient = 0.8
	item_flags = SYNTH_RESTRICTED

/obj/item/clothing/head/helmet/HoS/dermal
	name = "皮层装甲贴片"
	desc = "你不太确定自己是怎么把它戴上和取下的, 但它能很好地植入你的头部."
	icon_state = "dermal"
	worn_icon_state = "dermal"
	siemens_coefficient = 0.6

/obj/item/clothing/head/helmet/warden
	name = "典狱长帽"
	desc = "这是一顶配发给安保部队典狱长的特殊头盔. 保护头部免受撞击."
	icon_state = "policehelm"
	inventory_flags = NONE
	inv_hide_flags = NONE
	armor_protection_flags = NONE

/obj/item/clothing/head/helmet/hop
	name = "船员资源帽"
	desc = "一顶时尚的帽子, 既能保护你免受愤怒的前船员伤害, 又能给你一种虚假的权威感."
	icon_state = "hopcap"
	inventory_flags = NONE
	inv_hide_flags = NONE
	armor_protection_flags = NONE

/obj/item/clothing/head/helmet/formalcaptain
	name = "阅兵帽"
	desc = "任何处于指挥位置的人都不应缺少一顶完美无瑕的白色终极权威之帽."
	icon_state = "officercap"
	inventory_flags = NONE
	inv_hide_flags = NONE
	armor_protection_flags = NONE

/obj/item/clothing/head/helmet/swat
	name = "\improper 特警头盔"
	desc = "它们常被训练有素的特警队员使用."
	icon_state = "swat"
	worn_icon_state = "swat"
	soft_armor = list(MELEE = 80, BULLET = 60, LASER = 50, ENERGY = 25, BOMB = 50, BIO = 10, FIRE = 25, ACID = 25)
	inventory_flags = COVEREYES|BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDEEYES
	cold_protection_flags = HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.5
	anti_hug = 1
	item_flags = SYNTH_RESTRICTED

/obj/item/clothing/head/helmet/thunderdome
	name = "\improper 雷霆穹顶头盔"
	desc = "<i>'让战斗开始吧!'</i>"
	icon_state = "thunderdome"
	inventory_flags = COVEREYES|BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDEEYES
	worn_icon_state = "thunderdome"
	soft_armor = list(MELEE = 80, BULLET = 60, LASER = 50, ENERGY = 10, BOMB = 25, BIO = 10, FIRE = 10, ACID = 10)
	cold_protection_flags = HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 1

/obj/item/clothing/head/helmet/gladiator
	name = "角斗士头盔"
	desc = "万岁, 皇帝, 将死之人向您致敬."
	icon_state = "gladiator"
	worn_icon_state = "gladiator"
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = HIDEMASK|HIDEEARS|HIDEEYES|HIDEALLHAIR
	siemens_coefficient = 1

/*===========================MARINES HELMETS=================================
=======================================================================*/

/obj/item/clothing/head/helmet/marine
	name = "\improper M10型陆战队头盔"
	desc = "一顶标准M10型头盔. 标签上写着: '开棺葬礼与闭棺葬礼之间的区别. 戴在头上以获得最佳效果.'."
	icon = 'icons/obj/clothing/headwear/marine_helmets.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_helmets.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	icon_state = "helmet"
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 50, FIRE = 50, ACID = 50)
	max_integrity = 5
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS
	attachments_by_slot = list(
		ATTACHMENT_SLOT_STORAGE,
	)
	attachments_allowed = list(
		/obj/item/armor_module/storage/helmet,
	)
	starting_attachments = list(/obj/item/armor_module/storage/helmet)
	var/list/helmet_overlays
	///marine helmet behaviour flags
	var/marine_helmet_flags = HELMET_GARB_OVERLAY|HELMET_STORE_GARB
	/// items that fit in the helmet: strict type = iconstate to show
	var/static/list/allowed_helmet_items = list(
		/obj/item/tool/lighter/random = "helmet_lighter_",
		/obj/item/tool/lighter/zippo = "helmet_lighter_zippo",
		/obj/item/storage/box/matches = "helmet_matches",
		/obj/item/storage/fancy/cigarettes = "helmet_cig_kpack",
		/obj/item/storage/fancy/cigarettes/kpack = "helmet_cig_kpack",
		/obj/item/storage/fancy/cigarettes/luckystars = "helmet_cig_ls",
		/obj/item/storage/fancy/cigarettes/dromedaryco = "helmet_cig_kpack",
		/obj/item/storage/fancy/cigarettes/lady_finger = "helmet_cig_lf",
		/obj/item/toy/deck = "helmet_card_card",
		/obj/item/toy/handcard = "helmet_card_card",
		/obj/item/reagent_containers/food/drinks/flask/marine = "helmet_canteen",
		/obj/item/reagent_containers/food/snacks/enrg_bar = "helmet_snack_eat",
		/obj/item/reagent_containers/food/snacks/packaged_burrito = "helmet_snack_burrito",
		/obj/item/clothing/glasses/mgoggles = "goggles",
		/obj/item/clothing/glasses/mgoggles/prescription = "goggles",
		/obj/item/clothing/glasses/hud/medgoggles = "goggles",
		/obj/item/clothing/glasses/hud/medgoggles/prescription = "goggles",
		/obj/item/clothing/glasses/meson/enggoggles = "enggoggles",
		/obj/item/clothing/glasses/meson/enggoggles/prescription = "enggoggles",
		/obj/item/clothing/head/hairflower = "flower_pin",
	)

/obj/item/clothing/head/helmet/marine/Initialize(mapload)
	. = ..()
	helmet_overlays = list("damage","band","item") //To make things simple.

///Updates the helmet_overlays list, inserting and removing images from it as necesarry
/obj/item/clothing/head/helmet/marine/update_overlays()
	. = ..()
	if(!attachments_by_slot[ATTACHMENT_SLOT_STORAGE])
		return
	if(!istype(attachments_by_slot[ATTACHMENT_SLOT_STORAGE], /obj/item/armor_module/storage))
		return
	var/obj/item/armor_module/storage/armor_storage = attachments_by_slot[ATTACHMENT_SLOT_STORAGE]

	if(length(armor_storage.contents) && (marine_helmet_flags & HELMET_GARB_OVERLAY))
		if(!helmet_overlays["band"])
			var/image/I = image('icons/obj/clothing/headwear/marine_hats.dmi', src, "helmet_band")
			helmet_overlays["band"] = I

		if(!helmet_overlays["item"])
			var/obj/O = armor_storage.contents[1]
			if(O.type in allowed_helmet_items)
				var/image/I = image('icons/obj/clothing/headwear/marine_hats.dmi', src, "[allowed_helmet_items[O.type]][O.type == /obj/item/tool/lighter/random ? O:clr : ""]")
				helmet_overlays["item"] = I

	else
		if(helmet_overlays["item"])
			var/image/RI = helmet_overlays["item"]
			helmet_overlays["item"] = null
			qdel(RI)
		if(helmet_overlays["band"])
			var/image/J = helmet_overlays["band"]
			helmet_overlays["band"] = null
			qdel(J)

	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_head()

/obj/item/clothing/head/helmet/marine/apply_custom(mutable_appearance/standing, inhands, icon_used, state_used)
	if(inhands)
		return
	. = ..()
	var/mutable_appearance/M
	for(var/i in helmet_overlays)
		M = helmet_overlays[i]
		if(!M)
			continue

		M = mutable_appearance('icons/mob/modular/modular_helmet_storage.dmi', M.icon_state)
		standing.overlays += M

/obj/item/clothing/head/helmet/marine/specialist
	name = "\improper B18头盔"
	desc = "与B18防御装甲配套的B18头盔. 它沉重, 加固, 并能保护更多面部."
	icon_state = "minigunner_helmet"
	soft_armor = list(MELEE = 75, BULLET = 80, LASER = 75, ENERGY = 65, BOMB = 70, BIO = 65, FIRE = 65, ACID = 65)
	inv_hide_flags = HIDEALLHAIR|HIDEEARS
	item_flags = SYNTH_RESTRICTED
	resistance_flags = UNACIDABLE
	anti_hug = 6
	item_map_variant_flags = (ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_PRISON_VARIANT|ITEM_ICE_PROTECTION)

/obj/item/clothing/head/helmet/marine/grenadier
	name = "\improper B17头盔"
	desc = "一款为配合B17陆战队装甲而制造的重型头盔. 几乎防爆. 除非你站在核弹或类似东西旁边."
	icon_state = "grenadier_helmet"
	soft_armor = list(MELEE = 75, BULLET = 70, LASER = 60, ENERGY = 65, BOMB = 100, BIO = 60, FIRE = 65, ACID = 60)
	inv_hide_flags = HIDEALLHAIR|HIDEEARS
	max_heat_protection_temperature = HEAVYARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	resistance_flags = UNACIDABLE
	item_flags = SYNTH_RESTRICTED
	anti_hug = 4
	item_map_variant_flags = (ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_PRISON_VARIANT|ITEM_ICE_PROTECTION)

/obj/item/clothing/head/helmet/marine/pilot
	name = "\improper M30战术头盔"
	desc = "M30战术头盔左侧有一个目镜滤光器, 用于过滤战术数据. 它被TGN的飞行员使用. 这顶是枪金属蓝色的."
	icon_state = "helmetp2"
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 50, FIRE = 50, ACID = 50)
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDETOPHAIR
	marine_helmet_flags = NONE
	item_map_variant_flags = null

/obj/item/clothing/head/helmet/marine/pilot/green
	name = "\improper M30战术头盔"
	desc = "M30战术头盔左侧有一个目镜滤光器, 用于过滤战术数据. 它被TGN的飞行员使用. 这顶是绿色的."
	icon_state = "helmetp"

/obj/item/clothing/head/helmet/marine/mech_pilot
	name = "\improper M12C型神经链接头盔"
	icon_state = "mech_pilot_helmet"
	desc = "一顶轻便头盔, 后部有一个小端口. 通过将TGMC机甲飞行员直接整合到机甲服系统中, 提供更低的响应时间, 尽管这当然不会让他们更聪明."
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/head/helmet/marine/assault_crewman
	name = "\improper M12B型坦克手头盔"
	icon_state = "assault_crewman_helmet"
	desc = "一顶轻便头盔. 主要为使用者提供保护, 以免被弹出的弹壳击中头部."
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/head/helmet/marine/transport_crewman
	name = "\improper M12A型运输头盔"
	icon_state = "transport_crewman_helmet"
	desc = "一顶轻便头盔, 后部有一个小端口. 提供不错的保护, 以防鲁莽驾驶."
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/head/helmet/marine/riot
	name = "M8防暴头盔"
	desc = "它是广泛使用的防暴头盔的改进版, 用于对付愤怒的陆战队员. 具有高防弹保护."
	icon_state = "marine_riot"
	soft_armor = list(MELEE = 65, BULLET = 110, LASER = 110, ENERGY = 5, BOMB = 50, BIO = 50, FIRE = 50, ACID = 30)
	inventory_flags = COVEREYES|BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDEEYES|HIDETOPHAIR
	item_flags = SYNTH_RESTRICTED

/*=============================PMCS==================================
=======================================================================*/

/obj/item/clothing/head/helmet/marine/veteran
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	item_flags = SYNTH_RESTRICTED

/obj/item/clothing/head/helmet/marine/veteran/pmc
	name = "\improper PMC战术头盔"
	desc = "一顶由柔性芳纶材料制成的防护头盔. 许多安保公司的标准配发防护装备."
	icon_state = "pmc_helmet"
	soft_armor = list(MELEE = 65, BULLET = 65, LASER = 60, ENERGY = 55, BOMB = 60, BIO = 50, FIRE = 55, ACID = 55)
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = NONE
	marine_helmet_flags = NONE

/obj/item/clothing/head/helmet/marine/veteran/pmc/leader
	name = "\improper PMC贝雷帽"
	desc = "任何有抱负的雇佣兵领袖的时尚巅峰. 设计用于保护头部免受轻微撞击."
	icon_state = "officer_hat"
	soft_armor = list(MELEE = 70, BULLET = 70, LASER = 65, ENERGY = 55, BOMB = 60, BIO = 50, FIRE = 55, ACID = 60)

/obj/item/clothing/head/helmet/marine/veteran/pmc/sniper
	name = "\improper PMC狙击手头盔"
	desc = "PMC射手佩戴的头盔"
	icon_state = "pmc_sniper_hat"
	armor_protection_flags = HEAD|FACE|EYES
	soft_armor = list(MELEE = 65, BULLET = 75, LASER = 55, ENERGY = 60, BOMB = 70, BIO = 50, FIRE = 60, ACID = 60)
	inventory_flags = COVEREYES|COVERMOUTH|BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDEEYES|HIDEFACE|HIDEMASK|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/veteran/pmc/gunner
	name = "\improper PMC机枪手头盔"
	desc = "许多安保公司使用的标准头盔的改进版, 带有增加保护的面罩."
	icon_state = "pmc_heavyhelmet"
	armor_protection_flags = HEAD|FACE|EYES
	soft_armor = list(MELEE = 75, BULLET = 85, LASER = 80, ENERGY = 65, BOMB = 80, BIO = 50, FIRE = 65, ACID = 65)
	inventory_flags = COVEREYES|COVERMOUTH|BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDEEYES|HIDEFACE|HIDEMASK|HIDEALLHAIR

/obj/item/clothing/head/helmet/marine/veteran/pmc/commando
	name = "\improper PMC突击队头盔"
	desc = "为Nanotrasen精英突击队制造的完全封闭式装甲头盔."
	icon_state = "commando_helmet"
	armor_protection_flags = HEAD|FACE|EYES
	soft_armor = list(MELEE = 95, BULLET = 120, LASER = 200, ENERGY = 200, BOMB = 90, BIO = 100, FIRE = 90, ACID = 95)
	inventory_flags = COVEREYES|COVERMOUTH|BLOCKSHARPOBJ|BLOCKGASEFFECT
	inv_hide_flags = HIDEEARS|HIDEEYES|HIDEFACE|HIDEMASK|HIDEALLHAIR
	eye_protection = 2
	anti_hug = 50
	resistance_flags = UNACIDABLE

/*==========================DISTRESS=================================
=======================================================================*/

/*=========================Imperium==================================*/

/obj/item/clothing/head/helmet/marine/imperial
	name = "\improper 帝国卫队防弹头盔"
	desc = "与防弹甲配套的标准帝国卫队头盔, 它也是大规模生产的, 它可能能救你的命, 也许吧."
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	icon_state = "guardhelm"
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	worn_icon_state = "guardhelm"
	item_flags = SYNTH_RESTRICTED
	soft_armor = list(MELEE = 85, BULLET = 75, LASER = 70, ENERGY = 70, BOMB = 60, BIO = 50, FIRE = 50, ACID = 50)

/obj/item/clothing/head/helmet/marine/imperial/sergeant
	name = "\improper 帝国卫队中士头盔"
	desc = "与中士装甲配套的头盔, 与防弹变体不同, 这顶确实能保护你."
	icon_state = "guardhelm"
	soft_armor = list(MELEE = 85, BULLET = 85, LASER = 85, ENERGY = 85, BOMB = 85, BIO = 50, FIRE = 80, ACID = 80)

/obj/item/clothing/head/helmet/marine/imperial/sergeant/veteran
	name = "\improper 帝国卫队甲壳头盔"
	desc = "与重型甲壳装甲配套的头盔, 这是相当严肃的防护."
	icon_state = "guardvethelm"
	soft_armor = list(MELEE = 90, BULLET = 90, LASER = 90, ENERGY = 90, BOMB = 90, BIO = 30, FIRE = 90, ACID = 90)

/obj/item/clothing/head/helmet/upp
	name = "\improper UM4头盔"
	desc = "一款为UM/UH系统使用而设计的带裙边头盔."
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	icon_state = "upp_helmet1"
	item_flags = SYNTH_RESTRICTED
	soft_armor = list(MELEE = 70, BULLET = 55, LASER = 40, ENERGY = 35, BOMB = 35, BIO = 5, FIRE = 35, ACID = 35)
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/head/helmet/upp/heavy
	name = "\improper UH7头盔"
	icon_state = "upp_helmet_heavy"
	soft_armor = list(MELEE = 90, BULLET = 85, LASER = 60, ENERGY = 65, BOMB = 85, BIO = 5, FIRE = 65, ACID = 65)
	resistance_flags = UNACIDABLE
	anti_hug = 3

//head rag

/obj/item/clothing/head/helmet/specrag
	name = "专家头巾"
	desc = "重型武器操作员佩戴的用来挡汗的帽子."
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	icon_state = "spec"
	soft_armor = list(MELEE = 35, BULLET = 35, LASER = 35, ENERGY = 15, BOMB = 10, BIO = 0, FIRE = 15, ACID = 15)
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS

/*===========================HELGHAST - MERCENARY================================
=====================================================================*/

/obj/item/clothing/head/helmet/marine/veteran/mercenary
	name = "\improper K12陶瓷头盔"
	desc = "一个未知雇佣兵组织佩戴的坚固头盔."
	icon_state = "mercenary_heavy_helmet"
	armor_protection_flags = HEAD|FACE|EYES
	soft_armor = list(MELEE = 80, BULLET = 80, LASER = 50, ENERGY = 60, BOMB = 70, BIO = 10, FIRE = 60, ACID = 60)
	inventory_flags = COVEREYES|COVERMOUTH|BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDEEYES|HIDEFACE|HIDEMASK|HIDEALLHAIR
	marine_helmet_flags = NONE

/obj/item/clothing/head/helmet/marine/veteran/mercenary/miner
	name = "\improper Y8矿工头盔"
	desc = "一个未知雇佣兵组织佩戴的坚固头盔."
	icon_state = "mercenary_miner_helmet"
	armor_protection_flags = HEAD|FACE|EYES
	soft_armor = list(MELEE = 55, BULLET = 55, LASER = 45, ENERGY = 55, BOMB = 55, BIO = 10, FIRE = 55, ACID = 55)


/obj/item/clothing/head/helmet/marine/veteran/mercenary/engineer
	name = "\improper Z7工程师头盔"
	desc = "一顶由未知雇佣兵组织佩戴的坚固头盔."
	icon_state = "mercenary_engineer_helmet"
	armor_protection_flags = HEAD|FACE|EYES
	soft_armor = list(MELEE = 55, BULLET = 60, LASER = 45, ENERGY = 55, BOMB = 60, BIO = 10, FIRE = 55, ACID = 55)



/obj/item/clothing/head/helmet/marine/som
	name = "\improper S6战斗头盔"
	desc = "一顶源自采矿殖民地时期经过重度改装的头部防护装备的头盔. 防护能力很差,但总比没有强."
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	icon_state = "som_helmet"
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	worn_icon_state = "som_helmet"
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 50, FIRE = 50, ACID = 50)
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = NONE
	marine_helmet_flags = NONE


/obj/item/clothing/head/helmet/marine/som/veteran
	name = "\improper S7战斗头盔"
	desc = "一顶源自采矿殖民地时期经过重度改装的头部防护装备的头盔. 似乎经过了大量改装."
	icon_state = "som_helmet_veteran"
	worn_icon_state = "som_helmet_veteran"
	soft_armor = list(MELEE = 65, BULLET = 65, LASER = 65, ENERGY = 35, BOMB = 30, BIO = 50, FIRE = 35, ACID = 50)


/obj/item/clothing/head/helmet/marine/som/leader
	name = "\improper S8战斗头盔"
	desc = "一顶源自采矿殖民地时期经过重度改装的头部防护装备的头盔."
	icon_state = "som_helmet_leader"
	worn_icon_state = "som_helmet_leader"
	soft_armor = list(MELEE = 55, BULLET = 65, LASER = 65, ENERGY = 30, BOMB = 20, BIO = 50, FIRE = 30, ACID = 50)

/obj/item/clothing/head/helmet/sectoid
	name = "灵能场"
	desc = "一片无形的能量场,它能保护佩戴者,但会阻止穿戴任何衣物."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield-blue"
	item_flags = DELONDROP
	soft_armor = list(MELEE = 65, BULLET = 60, LASER = 30, ENERGY = 20, BOMB = 25, BIO = 40, FIRE = 20, ACID = 20)
	anti_hug = 5

/obj/item/clothing/head/helmet/sectoid/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SECTOID_TRAIT)

/obj/item/clothing/head/helmet/marine/icc
	name = "\improper Modelle/20战斗头盔"
	desc = "一顶标准的ICCAF头盔,被其所有军种使用. 它被设计为兼顾实用与战斗用途,对爆炸和子弹具有显著的高抗性."
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	icon_state = "icc"
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	worn_icon_state = "icc"
	soft_armor = list(MELEE = 50, BULLET = 60, LASER = 50, ENERGY = 60, BOMB = 70, BIO = 10, FIRE = 60, ACID = 50)

/obj/item/clothing/head/helmet/marine/icc/guard
	name = "\improper Modelle/21战斗头盔"
	desc = "一顶高品质的ICCGF头盔,大多见于ICC最精锐的部队,更广为人知的名称为'卫队'. 与ICC的大多数头盔一样,它被设计为兼顾实用与战斗用途,对爆炸和子弹具有显著的高抗性."
	icon_state = "icc_guard"
	worn_icon_state = "icc_guard"
	soft_armor = list(MELEE = 60, BULLET = 65, LASER = 40, ENERGY = 60, BOMB = 80, BIO = 10, FIRE = 55, ACID = 40)

/obj/item/clothing/head/helmet/marine/icc/guard/heavy
	name = "\improper Modelle/22战斗头盔"
	desc = "一顶高品质的ICCGF头盔,大多见于ICC最精锐的部队,更广为人知的名称为'卫队'. 与ICC的大多数头盔一样,它被设计为兼顾实用与战斗用途,对爆炸和子弹具有显著的高抗性,这一顶经过了重度加固."
	icon_state = "icc_guard_heavy"
	worn_icon_state = "icc_guard_heavy"
	soft_armor = list(MELEE = 65, BULLET = 70, LASER = 40, ENERGY = 60, BOMB = 85, BIO = 10, FIRE = 55, ACID = 40)

/obj/item/clothing/head/helmet/marine/vsd
	name = "Crasher多威胁防弹头盔"
	desc = "维亚切斯拉夫的步兵头盔,不过对你的光头保护不大."
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	icon_state = "vsd_main"
	worn_icon_state = "vsd_main"
	worn_icon_list =  list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
	)
	soft_armor = list(MELEE = 50, BULLET = 60, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 10, FIRE = 20, ACID = 30)

/obj/item/clothing/head/helmet/marine/vsd/medic
	name = "Crasher多威胁'医疗'防弹头盔"
	icon_state = "vsd_medic"
	worn_icon_state = "vsd_medic"

/obj/item/clothing/head/helmet/marine/vsd/secondary
	name = "Crasher多威胁防弹头盔"
	icon_state = "vsd_secondary"
	worn_icon_state = "vsd_secondary"

/obj/item/clothing/head/helmet/marine/vsd/upp
	name = "Crasher多威胁防弹头盔"
	icon_state = "vsd_upp"
	worn_icon_state = "vsd_upp"

/obj/item/clothing/head/helmet/marine/vsd/pyro
	name = "Crasher多威胁'火焰'防弹头盔"
	desc = "一顶为维亚切斯拉夫火焰兵改装的头盔."
	icon_state = "vsd_pyro"
	worn_icon_state = "vsd_pyro"
	soft_armor = list(MELEE = 50, BULLET = 60, LASER = 30, ENERGY = 30, BOMB = 25, BIO = 10, FIRE = 60, ACID = 30)

/obj/item/clothing/head/helmet/marine/vsd/juggernaut
	name = "Crasher多威胁'重装'防弹头盔"
	desc = "维亚切斯拉夫的重装头盔,看起来像一顶普通的防暴头盔. 头盔侧面写着:'来打我啊!'."
	icon_state = "vsd_juggernaut_one"
	worn_icon_state = "vsd_juggernaut_one"
	soft_armor = list(MELEE = 50, BULLET = 85, LASER = 10, ENERGY = 10, BOMB = 25, BIO = 10, FIRE = 20, ACID = 30)

/obj/item/clothing/head/helmet/marine/vsd/eod
	name = "Crasher多威胁'辛迪加'防弹头盔"
	desc = "维亚切斯拉夫的辛迪加资助头盔."
	inv_hide_flags = HIDEEARS|HIDEEYES|HIDEALLHAIR|HIDEMASK
	icon_state = "vsd_juggernaut_two"
	worn_icon_state = "vsd_juggernaut_two"
	soft_armor = list(MELEE = 50, BULLET = 60, LASER = 10, ENERGY = 10, BOMB = 60, BIO = 10, FIRE = 20, ACID = 30)
