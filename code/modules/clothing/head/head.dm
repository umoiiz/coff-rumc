/obj/item/clothing/head
	name = "头部"
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/clothing/hats_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/clothing/hats_right.dmi',
	)
	armor_protection_flags = HEAD
	equip_slot_flags = ITEM_SLOT_HEAD
	w_class = WEIGHT_CLASS_SMALL
	blood_sprite_state = "helmetblood"
	attachments_by_slot = list(ATTACHMENT_SLOT_BADGE)
	attachments_allowed = list(/obj/item/armor_module/armor/badge)
	soft_armor = MARINE_HAT_ARMOR
	var/anti_hug = 0

/obj/item/clothing/head/update_clothing_icon()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_head()

/obj/item/clothing/head/update_greyscale(list/colors, update)
	. = ..()
	if(!greyscale_config)
		return
	worn_icon_list = list(slot_head_str = icon)

/obj/item/clothing/head/examine(mob/user)
	. = ..()
	if(colorable_allowed & HAIR_CONCEALING_CHANGE_ALLOWED)
		. += span_notice("你可以对它使用<b>facepaint</b>来改变它遮盖头发的方式.")

/obj/item/clothing/head/beanie
	name = "\improper TGMC毛线帽"
	desc = "一顶标准的军用毛线帽, 通常由非战斗军事人员和支持人员佩戴, 不过偶尔也会出现在前线. 因其舒适贴身而广受欢迎."
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	icon_state = "beanie_cargo"
	inv_hide_flags = HIDETOPHAIR
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/tgmcberet
	name = "\improper 深灰色贝雷帽"
	desc = "一种通常由TGMC战地军官佩戴的帽子. 偶尔也会流传到下级, 落入小队队长和功勋卓著的老兵手中."
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	icon_state = "beret"
	item_map_variant_flags = NONE
	armor_features_flags = ARMOR_NO_DECAP

/obj/item/clothing/head/tgmcberet/tan
	name = "\improper 棕褐色贝雷帽"
	icon_state = "berettan"
	item_map_variant_flags = (ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT)

/obj/item/clothing/head/tgmcberet/red
	name = "\improper 红色徽章贝雷帽"
	icon_state = "beretred"
	item_map_variant_flags = NONE

/obj/item/clothing/head/tgmcberet/red2
	name = "\improper 红色贝雷帽"
	icon_state = "beretred2"
	item_map_variant_flags = NONE

/obj/item/clothing/head/tgmcberet/red2/erp
	name = "\improper ERP红色贝雷帽"
	desc = "ERP批准的红贝雷帽改进设计, 这一小块布料为何有如此好的缓冲效果是ERP严守的秘密."
	soft_armor = MARINE_ARMOR_MEDIUM

/obj/item/clothing/head/tgmcberet/red2/erp/masterprankster
	desc = "ERP批准的红贝雷帽改进设计, 这一小块布料为何有如此好的缓冲效果是ERP严守的秘密. 这一顶仅由恶作剧大师持有!"
	icon_state = "beretred"

/obj/item/clothing/head/tgmcberet/bloodred
	name = "\improper 血红贝雷帽"
	icon_state = "bloodred_beret"
	item_map_variant_flags = NONE

/obj/item/clothing/head/tgmcberet/blueberet
	name = "\improper 蓝色贝雷帽"
	icon_state = "blue_beret"
	item_map_variant_flags = NONE

/obj/item/clothing/head/tgmcberet/darkgreen
	name = "\improper 深绿色贝雷帽"
	icon_state = "darkgreen_beret"
	item_map_variant_flags = NONE

/obj/item/clothing/head/tgmcberet/green
	name = "\improper 绿色贝雷帽"
	icon_state = "beretgreen"
	item_map_variant_flags = NONE

/obj/item/clothing/head/tgmcberet/snow
	name = "\improper 白色贝雷帽"
	icon_state = "beretsnow"
	item_map_variant_flags = NONE

/obj/item/clothing/head/tgmcberet/wo
	name = "\improper 宪兵司令贝雷帽"
	desc = "一顶印有中尉徽章的贝雷帽. 它闪耀着腐败权威的光芒, 还沾着一块甜甜圈的污渍."
	icon_state = "beretwo"
	item_map_variant_flags = NONE

/obj/item/clothing/head/tgmcberet/fc
	name = "\improper 战地指挥官贝雷帽"
	desc = "一顶印有战地指挥官徽章的贝雷帽. 它能让所有注视它的人心生忠诚与勇气."
	icon_state = "beretfc"
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 10, BIO = 5, FIRE = 50, ACID = 50)
	item_map_variant_flags = NONE

/obj/item/clothing/head/tgmccap
	name = "\improper TGMC作训帽"
	desc = "一顶休闲帽, 偶尔由小队队长和战斗工程师佩戴. 虽然战斗功能有限, 但有些人更喜欢戴它而不是标准配发的头盔."
	icon_state = "cap"
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	species_exception = list(/datum/species/robot)
	item_map_variant_flags = (ITEM_ICE_VARIANT)
	var/flipped_cap = FALSE
	var/base_cap_icon

/obj/item/clothing/head/tgmccap/verb/fliphat()
	set name = "Flip hat"
	set category = "IC.Clothing"
	set src in usr
	if(!isliving(usr))
		return
	if(usr.incapacitated())
		return

	flipped_cap = !flipped_cap
	if(flipped_cap)
		to_chat(usr, "你把帽子转到后面! 你看起来像个傻瓜.")
		icon_state = base_cap_icon + "_b"
	else
		to_chat(usr, "你把帽子转回前面. 这样好多了.")
		icon_state = base_cap_icon

	update_clothing_icon()

/obj/item/clothing/head/tgmccap/ro
	name = "\improper TGMC军官帽"
	desc = "一顶通常由TGMC军官佩戴的帽子. 虽然战斗功能有限, 但有些人更喜欢戴它而不是标准配发的头盔."
	icon_state = "rocap"

/obj/item/clothing/head/tgmccap/ro/navy
	name = "\improper TGMC海军军官帽"
	desc = "一顶通常由TGMC军官佩戴的帽子. 这次是漂亮的藏青色."
	icon_state = "navycap"

/obj/item/clothing/head/tgmccap/req
	name = "\improper TGMC补给帽"
	desc = "这是一顶给不那么体面的军队补给文员戴的花哨帽子."
	icon_state = "cargocap"
	item_map_variant_flags = null

/obj/item/clothing/head/boonie
	name = "奔尼帽"
	desc = "战术酷炫科技的巅峰之作."
	icon_state = "booniehat"
	worn_icon_state = "booniehat"
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/ornamented_cap
	name = "\improper 装饰帽"
	desc = "一顶带帽檐的装饰帽. 这顶的后面似乎被撕破了."
	icon_state = "ornamented_cap"
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',)
	species_exception = list(/datum/species/robot)
	armor_features_flags = ARMOR_NO_DECAP

/obj/item/clothing/head/slouch
	name = "\improper TGMC垂边帽"
	desc = "一顶漂亮的垂边帽, 由一些TGMC士兵在炎热天气的行星上佩戴, 或者只是为了造型. 虽然战斗功能有限, 但有些人更喜欢戴它而不是标准配发的头盔."
	icon_state = "slouch_hat"
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
	)
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/headband
	name = "\improper 青色头巾"
	desc = "一块通常由TGMC中不那么正统的武器操作员佩戴的布. 虽然不提供任何防护, 但比起标准头盔确实更舒适. 有两种时尚颜色可选."
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	icon_state = "headband"
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/headband/red
	name = "\improper 红色头巾"
	icon_state = "headbandred"

/obj/item/clothing/head/headband/rambo
	name = "\improper 鲜红色头巾"
	desc = "它在风中飘扬, 桀骜不驯, 就像戴着它的人一样."
	icon_state = "headband_rambo"

/obj/item/clothing/head/headband/snake
	name = "\improper 黑色头巾"
	desc = "一位传奇士兵头巾的复制品. 可惜它还不能提供无限弹药. 暂时不能."
	icon_state = "headband_snake"

/obj/item/clothing/head/headset
	name = "\improper TGMC耳机"
	desc = "一种通常由无线电操作员和军官使用的耳机. 这个似乎出了故障."
	icon_state = "headset"
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/cmo
	name = "\improper 首席医疗官帽"
	desc = "一顶有些花哨的帽子, 通常由那些希望赢得医疗界尊重的人佩戴."
	icon_state = "cmohat"
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/securitycap
	name = "安保帽"
	desc = "一顶通常由安保人员佩戴的帽子, 舒适且带有轻型护甲."
	icon_state = "security_cap"
	icon = 'icons/obj/clothing/hats.dmi'
	soft_armor = list(MELEE = 15, BULLET = 25, LASER = 20, ENERGY = 20, BOMB = 5, BIO = 5, FIRE = 15, ACID = 5)
	species_exception = list(/datum/species/robot)

/*============================BERETS=================================*/
//Berets have armor, so they have their own category. PMC caps are helmets, so they're in helmets.dm.

/obj/item/clothing/head/beret/marine
	name = "陆战队军官贝雷帽"
	desc = "一顶印有TGMC徽章的贝雷帽. 它散发着尊重与权威."
	icon_state = "hosberet"
	inventory_flags = BLOCKSHARPOBJ

/obj/item/clothing/head/beret/marine/captain
	name = "上尉贝雷帽"
	desc = "一顶印有上尉徽章的贝雷帽. 佩戴者可能会感受到头肩之上沉甸甸的责任."
	icon_state = "centcomcaptain"

/obj/item/clothing/head/beret/marine/techofficer
	name = "技术军官贝雷帽"
	desc = "一顶印有中尉徽章的贝雷帽. 它有种说不出的高效感..."
	icon_state = "e_beret_badge"

/obj/item/clothing/head/beret/marine/logisticsofficer
	name = "后勤军官贝雷帽"
	desc = "一顶印有中尉徽章的贝雷帽. 它令人心生敬意."
	icon_state = "hosberet"

/*=========================PROTECTIVE===============================
=======================================================================*/

/obj/item/clothing/head/ushanka
	name = "护耳冬帽"
	desc = "在西伯利亚过冬的完美选择, 是吧?"
	icon_state = "ushankadown"
	worn_icon_state = "ushankadown"
	species_exception = list(/datum/species/robot)
	cold_protection_flags = HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDETOPHAIR
	anti_hug = 1

/obj/item/clothing/head/ushanka/attack_self(mob/user as mob)
	. = ..()
	if(icon_state == "ushankadown")
		icon_state = "ushankaup"
		worn_icon_state = "ushankaup"
		to_chat(user, "你拉起了护耳冬帽的耳罩.")
	else
		icon_state = "ushankadown"
		worn_icon_state = "ushankadown"
		to_chat(user, "你放下了护耳冬帽的耳罩.")

/obj/item/clothing/head/bearpelt
	name = "熊皮帽"
	desc = "毛茸茸的."
	icon_state = "bearpelt"
	siemens_coefficient = 2
	anti_hug = 4
	armor_protection_flags = HEAD|CHEST|ARMS
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 90, BULLET = 70, LASER = 45, ENERGY = 55, BOMB = 45, BIO = 10, FIRE = 55, ACID = 55)
	cold_protection_flags = HEAD|CHEST|ARMS
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDETOPHAIR

/obj/item/clothing/head/uppcap
	name = "\improper 装甲USL军帽"
	desc = "USL用于秘密行动和低级海盗的标准头部装备."
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	icon_state = "upp_cap"
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	siemens_coefficient = 2
	//anti_hug = 2
	armor_protection_flags = HEAD
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 55, BOMB = 50, BIO = 50, FIRE = 55, ACID = 55)
	cold_protection_flags = HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS
	armor_features_flags = ARMOR_NO_DECAP

/obj/item/clothing/head/uppcap/beret
	name = "\improper 装甲USL贝雷帽"
	icon_state = "upp_beret"

/obj/item/clothing/head/frelancer
	name = "\improper 装甲自由佣兵头盔"
	desc = "一顶坚固的自由佣兵头盔."
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	icon_state = "freelancer_helmet"
	siemens_coefficient = 2
	armor_protection_flags = HEAD
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 55, BOMB = 50, BIO = 50, FIRE = 55, ACID = 55)
	cold_protection_flags = HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS
	armor_features_flags = ARMOR_NO_DECAP
	attachments_by_slot = list(
		ATTACHMENT_SLOT_STORAGE,
		ATTACHMENT_SLOT_HEAD_MODULE,
	)
	attachments_allowed = list(
		/obj/item/armor_module/module/binoculars,
		/obj/item/armor_module/storage/helmet,
	)
	starting_attachments = list(
		/obj/item/armor_module/module/binoculars,
		/obj/item/armor_module/storage/helmet,
	)

/obj/item/clothing/head/frelancer/beret
	name = "\improper 装甲自由佣兵贝雷帽"
	icon_state = "freelancer_beret"
	attachments_allowed = list(
		/obj/item/armor_module/storage/helmet,
	)
	starting_attachments = list(
		/obj/item/armor_module/storage/helmet,
	)

/obj/item/clothing/head/militia
	name = "\improper 装甲民兵头巾"
	desc = "一些民兵部队使用的大兜帽, 用于在边境上隐匿行踪. 由于生产时采用了特殊纤维, 能提供一定的头部防护."
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	icon_state = "rebel_hood"
	siemens_coefficient = 2
	armor_protection_flags = HEAD|CHEST
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 50, FIRE = 50, ACID = 50)
	cold_protection_flags = HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDETOPHAIR
	armor_features_flags = ARMOR_NO_DECAP

/obj/item/clothing/head/commissar
	name = "\improper 政委帽"
	desc = "帝国陆军政委佩戴的军帽. 这一顶似乎散发着威严."
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	icon_state = "commissar_cap"
	species_exception = list(/datum/species/robot)
	soft_armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 15, BIO = 10, FIRE = 20, ACID = 20)
	armor_features_flags = ARMOR_NO_DECAP

/obj/item/clothing/head/strawhat
	name = "\improper 草帽"
	desc = "一顶外侧衬有硬质纤维的帽子, 具有草帽常见的标志性外观. 是气泡区常见的帽子."
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',)
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	icon_state = "straw_hat"
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/squad_headband
	name = "\improper 小队头巾"
	desc = "由超薄特殊布料制成的头巾. 布料厚度带来的不只是头巾飘动的时尚感. 你可以将头巾系在头盔上. 这种小队版头巾通过布料染色工艺拥有秘密的独特功能."
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi'
	)
	icon_state = ""
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	slowdown = -0.1
	w_class = WEIGHT_CLASS_TINY
	species_exception = list(/datum/species/robot, /datum/species/synthetic, /datum/species/human, /datum/species/zombie)

/obj/item/clothing/head/squad_headband/alpha
	name = "\improper 阿尔法小队头巾"
	icon_state = "as_headband"

/obj/item/clothing/head/squad_headband/bravo
	name = "\improper 布拉沃小队头巾"
	icon_state = "bs_headband"

/obj/item/clothing/head/squad_headband/charlie
	name = "\improper 查理小队头巾"
	icon_state = "cs_headband"

/obj/item/clothing/head/squad_headband/delta
	name = "\improper 德尔塔小队头巾"
	icon_state = "ds_headband"

/obj/item/clothing/head/squad_headband/foreign
	name = "\improper 外籍军团头巾"
	icon_state = "fl_headband"

/obj/item/clothing/head/tgmcberet
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/tgmcberet/squad
	name = "\improper 小队贝雷帽"
	icon_state = ""
	desc = "带有TGMC陆战队小队徽章的军用贝雷帽."
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi'
	)

/obj/item/clothing/head/tgmcberet/squad/alpha
	name = "\improper 阿尔法小队贝雷帽"
	desc = "带有TGMC陆战队小队徽章的军用贝雷帽. 这一顶属于阿尔法小队."
	icon_state = "as_beret"

/obj/item/clothing/head/tgmcberet/squad/alpha/black
	name = "\improper 阿尔法小队黑色贝雷帽"
	icon_state = "as_black_beret"
	desc = "带有TGMC陆战队小队徽章的黑色时尚贝雷帽. 这一顶属于阿尔法小队."

/obj/item/clothing/head/tgmcberet/squad/bravo
	name = "\improper 布拉沃小队贝雷帽"
	desc = "带有TGMC陆战队小队徽章的军用贝雷帽. 这一顶属于布拉沃小队."
	icon_state = "bs_beret"

/obj/item/clothing/head/tgmcberet/squad/bravo/black
	name = "\improper 布拉沃小队黑色贝雷帽"
	icon_state = "bs_black_beret"
	desc = "带有TGMC陆战队小队徽章的黑色时尚贝雷帽. 这一顶属于布拉沃小队."

/obj/item/clothing/head/tgmcberet/squad/charlie
	name = "\improper 查理小队贝雷帽"
	icon_state = "cs_beret"
	desc = "带有TGMC陆战队小队徽章的军用贝雷帽. 这一顶属于查理小队."

/obj/item/clothing/head/tgmcberet/squad/charlie/black
	name = "\improper 查理小队黑色贝雷帽"
	icon_state = "cs_black_beret"
	desc = "带有TGMC陆战队小队徽章的黑色时尚贝雷帽. 这一顶属于查理小队."

/obj/item/clothing/head/tgmcberet/squad/delta
	name = "\improper 德尔塔小队贝雷帽"
	desc = "带有TGMC陆战队小队徽章的军用贝雷帽. 这一顶属于德尔塔小队."
	icon_state = "ds_beret"

/obj/item/clothing/head/tgmcberet/squad/delta/black
	name = "\improper 德尔塔小队黑色贝雷帽"
	icon_state = "ds_black_beret"
	desc = "带有TGMC陆战队小队徽章的黑色时尚贝雷帽. 这一顶属于德尔塔小队."

/obj/item/clothing/head/tgmcberet/squad/foreign
	name = "\improper 外籍军团贝雷帽"
	desc = "带有TGMC陆战队小队徽章的军用贝雷帽. 这一顶属于外籍军团."
	icon_state = "fl_beret"

/obj/item/clothing/head/tgmcberet/squad/foreign/black
	name = "\improper 外籍军团黑色贝雷帽"
	icon_state = "fl_black_beret"
	desc = "带有TGMC陆战队小队徽章的黑色时尚贝雷帽. 这一顶属于外籍军团."

/obj/item/clothing/head/tgmcberet/commando
	name = "\improper 陆战队突击队贝雷帽"
	desc = "深绿色贝雷帽, 上面印有旧的TGMC徽章."
	icon_state = "marcommandoberet"
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi'
	)

/obj/item/clothing/head/tgmcberet/vdv
	name = "\improper 空降兵贝雷帽"
	desc = "蓝色徽章的贝雷帽, 不知为何闻起来有乙醇和喷泉水的味道."
	icon_state = "russobluecamohat"
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi'
	)

/obj/item/clothing/head/tgmcberet/medical
	name = "\improper 医疗兵贝雷帽"
	desc = "一顶白色贝雷帽, 上面精细地绣有绿色十字. 它带有一种消毒过的气味."
	icon_state = "medberet"
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi'
	)

/obj/item/clothing/head/hachimaki
	name = "\improper 古代飞行员头巾和围巾套装"
	desc = "古代飞行员围巾套装,围巾保护颈部免受寒风侵袭,头带保护面部免受汗水侵扰"
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/head_0.dmi'
	)
	icon_state = "Banzai"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	w_class = WEIGHT_CLASS_SMALL

	actions_types = list(/datum/action/item_action)
	armor_features_flags = ARMOR_LAMP_OVERLAY|ARMOR_NO_DECAP
	item_flags = SYNTH_RESTRICTED
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/hachimaki/item_action_slot_check(mob/user, slot)
	if(slot != SLOT_HEAD)
		return FALSE
	return TRUE

/obj/item/clothing/head/hachimaki/attack_self(mob/user)
	var/mob/living/carbon/human/activator = user
	if(TIMER_COOLDOWN_RUNNING(user, "Banzai"))
		user.balloon_alert(user, "你最近刚使用过那个表情动作")
		return
	TIMER_COOLDOWN_START(user, "Banzai", 60 SECONDS)
	if(user.gender == FEMALE)
		user.balloon_alert(user, "女性不能使用那个!")
	else
		activator.say("Tenno Heika Banzai!!")
		playsound(get_turf(user), 'sound/voice/banzai1.ogg', 30)

/obj/item/clothing/head/tgmcberet/squad/black
	name = "\improper 阿尔法小队黑色贝雷帽"
	icon_state = "alpha_black_beret"
	desc = "带有TGMC陆战队小队徽章的黑色时尚贝雷帽.这顶属于阿尔法小队."
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi'
	)

/obj/item/clothing/head/tgmcberet/squad/black/bravo
	name = "\improper 布拉沃小队黑色贝雷帽"
	icon_state = "bravo_black_beret"
	desc = "带有TGMC陆战队小队徽章的黑色时尚贝雷帽.这顶属于布拉沃小队."

/obj/item/clothing/head/tgmcberet/squad/black/delta
	name = "\improper 德尔塔小队黑色贝雷帽"
	icon_state = "delta_black_beret"
	desc = "带有TGMC陆战队小队徽章的黑色时尚贝雷帽.这顶属于德尔塔小队."

/obj/item/clothing/head/tgmcberet/squad/black/charlie
	name = "\improper 查理小队黑色贝雷帽"
	icon_state = "charlie_black_beret"
	desc = "带有TGMC陆战队小队徽章的黑色时尚贝雷帽.这顶属于查理小队."

/obj/item/clothing/head/beret/marine
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi'
	)

/obj/item/clothing/head/beret/sec
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi'
	)

/obj/item/clothing/head/beret/sec/mp
	soft_armor = list(MELEE = 10, BULLET = 75, LASER = 75, ENERGY = 0, BOMB = 0, BIO = 85, FIRE = 0, ACID = 0)

/obj/item/clothing/head/beret/sec/warden
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi'
	)

/obj/item/clothing/head/beret/eng
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi'
	)

/obj/item/clothing/head/beret/marine/captain
	icon = 'icons/obj/clothing/headwear/hats.dmi'

/obj/item/clothing/head/beret/marine/captain/black
	icon_state = "black_captain"

/obj/item/clothing/head/beret/marine/staff
	name = "参谋军官贝雷帽"
	desc = "一顶饰有银色徽章的贝雷帽.佩戴者可能会被陆战队员严重误解."
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	icon_state = "so_beret"

//Peaked caps
/obj/item/clothing/head/highcap
	icon = 'icons/obj/clothing/headwear/hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi'
	)
	icon_state = "cap_black"
	inventory_flags = BLOCKSHARPOBJ
	armor_features_flags = ARMOR_NO_DECAP
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/highcap/staff
	name = "参谋军官大檐帽"
	desc = "一顶略显花哨的帽子,通常由那些希望指挥军事行动的人佩戴."
	icon_state = "so_alt"

/obj/item/clothing/head/highcap/captain
	name = "上尉大檐帽"
	desc = "一顶略显花哨的帽子,通常由那些希望掌控一切的人佩戴."
	icon_state = "capitan_alt"

/obj/item/clothing/head/highcap/captain/black
	icon_state = "captain_alt_black"

/obj/item/clothing/head/vsd
	name = "\improper 装甲棒球帽"
	desc = "V.S.D.步兵佩戴的棒球帽,营造出'使命召唤'的感觉."
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/ert_headwear.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	icon = 'icons/obj/clothing/headwear/ert_headwear.dmi'
	icon_state = "vsd_cap"
	worn_icon_state = "vsd_cap"
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 55, BOMB = 50, BIO = 50, FIRE = 55, ACID = 55)
	armor_features_flags = ARMOR_NO_DECAP
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/vsd/beret
	name = "\improper 装甲红色徽章贝雷帽"
	desc = "V.S.D.小队队长佩戴的红色贝雷帽,营造出突击队的感觉."
	icon_state = "beretred"
	worn_icon_state = "vsd_cap"
	icon = 'icons/obj/clothing/headwear/marine_hats.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/marine_hats.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
