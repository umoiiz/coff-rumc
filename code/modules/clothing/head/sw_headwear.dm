// GTA:SA bandanas — worn sprites from head_0.dmi

/obj/item/clothing/head/fun
	icon = 'icons/mob/clothing/headwear/head_0.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/head_0.dmi',
		slot_l_hand_str = 'icons/mob/inhands/clothing/hats_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/clothing/hats_right.dmi',
	)

/obj/item/clothing/head/fun/bandana_ballas
	name = "\improper 巴拉斯帮头巾"
	desc = "一条系在前面的紫色头巾."
	icon_state = "bandana_ballas"
	worn_icon_state = "bandana_ballas"
	inv_hide_flags = HIDETOPHAIR

/obj/item/clothing/head/fun/bandana_grove
	name = "\improper 格罗夫街头巾"
	desc = "一条系在前面的绿色头巾."
	icon_state = "bandana_grove"
	worn_icon_state = "bandana_grove"
	inv_hide_flags = HIDETOPHAIR

// Star Wars headwear — worn sprites from sw_helmets.dmi

/obj/item/clothing/head/sw
	icon = 'icons/mob/clothing/headwear/sw_helmets.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/sw_helmets.dmi',
		slot_l_hand_str = 'icons/mob/inhands/clothing/hats_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/clothing/hats_right.dmi',
	)

/obj/item/clothing/head/sw/cap
	armor_protection_flags = HEAD
	soft_armor = list(MELEE = 10, BULLET = 5, LASER = 5, ENERGY = 5, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

/obj/item/clothing/head/helmet/marine/sw
	icon = 'icons/mob/clothing/headwear/sw_helmets.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/sw_helmets.dmi',
		slot_l_hand_str = 'icons/mob/inhands/clothing/hats_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/clothing/hats_right.dmi',
	)
	// SOM medium helmet (modular/som)
	soft_armor = list(MELEE = 45, BULLET = 70, LASER = 60, ENERGY = 60, BOMB = 50, BIO = 50, FIRE = 55, ACID = 50)
	inventory_flags = COVEREYES|BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDEEYES|HIDETOPHAIR

/obj/item/clothing/head/helmet/marine/sw/rebel
	name = "\improper 叛军士兵头盔"
	desc = "一种叛军联盟的强化塑钢头盔."
	icon_state = "rebel_helmet"
	worn_icon_state = "rebel_helmet"
	attachments_allowed = list()
	starting_attachments = list()
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDETOPHAIR
	// SOM light
	soft_armor = list(MELEE = 35, BULLET = 60, LASER = 50, ENERGY = 50, BOMB = 45, BIO = 45, FIRE = 50, ACID = 40)

/obj/item/clothing/head/helmet/marine/sw/rebel/black
	name = "\improper 叛军士兵黑色头盔"
	desc = "叛军联盟士兵头盔的黑色变体."
	icon_state = "rebel_helmet_black"
	worn_icon_state = "rebel_helmet_black"
	soft_armor = list(MELEE = 40, BULLET = 65, LASER = 55, ENERGY = 55, BOMB = 50, BIO = 45, FIRE = 50, ACID = 45)

/obj/item/clothing/head/helmet/marine/sw/clone/phase2
	name = "\improper 第二阶段克隆人士兵头盔"
	desc = "共和国大军克隆人士兵使用的第二阶段头盔."
	icon_state = "replicant_helmet2"
	worn_icon_state = "replicant_helmet2"

/obj/item/clothing/head/helmet/marine/sw/clone/legion501
	name = "\improper 第501军团克隆人士兵头盔"
	desc = "带有第501军团蓝色标记的第二阶段头盔."
	icon_state = "replicant2_501st"
	worn_icon_state = "replicant2_501st"
	soft_armor = list(MELEE = 50, BULLET = 75, LASER = 65, ENERGY = 65, BOMB = 55, BIO = 55, FIRE = 60, ACID = 55)

/obj/item/clothing/head/helmet/marine/sw/clone/battalion212
	name = "\improper 第212营克隆人士兵头盔"
	desc = "带有第212攻击营橙色标记的第二阶段头盔."
	icon_state = "replicant2_212th"
	worn_icon_state = "replicant2_212th"
	soft_armor = list(MELEE = 50, BULLET = 75, LASER = 65, ENERGY = 65, BOMB = 55, BIO = 55, FIRE = 60, ACID = 55)

/obj/item/clothing/head/helmet/marine/sw/clone/scout
	name = "\improper 克隆人侦察兵头盔"
	desc = "带有额外护板用于极地和侦察行动的第二阶段头盔."
	icon_state = "replicant_bilizard"
	worn_icon_state = "replicant_bilizard"

/obj/item/clothing/head/helmet/marine/sw/clone/radiotech
	name = "\improper 克隆人无线电兵头盔"
	desc = "装有远程通信天线的克隆人士兵头盔."
	icon_state = "replicant_radiotech"
	worn_icon_state = "replicant_radiotech"

/obj/item/clothing/head/helmet/marine/sw/clone/commando
	name = "\improper 克隆人突击队头盔"
	desc = "共和国军队克隆人突击队使用的塑钢头盔."
	icon_state = "replicant_commando"
	worn_icon_state = "replicant_commando"
	// SOM leader / heavy
	soft_armor = list(MELEE = 60, BULLET = 80, LASER = 70, ENERGY = 70, BOMB = 60, BIO = 55, FIRE = 65, ACID = 55)

/obj/item/clothing/head/helmet/marine/sw/clone/artillery
	name = "\improper 克隆人炮兵乘员头盔"
	desc = "车辆和炮兵乘员使用的克隆人士兵头盔."
	icon_state = "replicant_art"
	worn_icon_state = "replicant_art"

/obj/item/clothing/head/helmet/marine/sw/clone/engineer
	name = "\improper 克隆人工兵头盔"
	desc = "共和国军队的强化塑钢工兵头盔."
	icon_state = "replicant_engi"
	worn_icon_state = "replicant_engi"

/obj/item/clothing/head/helmet/marine/sw/clone/phase1
	name = "\improper 第一阶段克隆人士兵头盔"
	desc = "共和国大军的强化塑钢第一阶段头盔."
	icon_state = "replicant_helmet"
	worn_icon_state = "replicant_helmet"

/obj/item/clothing/head/helmet/marine/sw/clone/sgt
	name = "\improper 克隆人中士头盔, 第一阶段"
	desc = "带有绿色标记表示中士军衔的第一阶段头盔."
	icon_state = "repsgt_helmet"
	worn_icon_state = "repsgt_helmet"

/obj/item/clothing/head/helmet/marine/sw/clone/lt
	name = "\improper 克隆人少尉头盔, 第一阶段"
	desc = "带有蓝色标记表示少尉军衔的第一阶段头盔."
	icon_state = "replt_helmet"
	worn_icon_state = "replt_helmet"

/obj/item/clothing/head/helmet/marine/sw/clone/captain
	name = "\improper 克隆人上尉头盔, 第一阶段"
	desc = "带有红色标记表示上尉军衔的第一阶段头盔."
	icon_state = "repcaptain_helmet"
	worn_icon_state = "repcaptain_helmet"
	soft_armor = list(MELEE = 60, BULLET = 80, LASER = 70, ENERGY = 70, BOMB = 60, BIO = 55, FIRE = 65, ACID = 55)

/obj/item/clothing/head/helmet/marine/sw/clone/pilot
	name = "\improper 克隆人飞行员头盔, 第一阶段"
	desc = "共和国海军的强化塑钢飞行员头盔."
	icon_state = "reppilot_helmet"
	worn_icon_state = "reppilot_helmet"

/obj/item/clothing/head/helmet/marine/sw/clone/commander
	name = "\improper 克隆人指挥官头盔, 第一阶段"
	desc = "带有黄色标记表示指挥官军衔的第一阶段头盔."
	icon_state = "repcommander_helmet"
	worn_icon_state = "repcommander_helmet"
	soft_armor = list(MELEE = 60, BULLET = 80, LASER = 70, ENERGY = 70, BOMB = 60, BIO = 55, FIRE = 65, ACID = 55)

/obj/item/clothing/head/helmet/marine/sw/clone/mp
	name = "\improper 克隆人宪兵头盔"
	desc = "共和国宪兵的高度强化塑钢头盔."
	icon_state = "repmp_helmet"
	worn_icon_state = "repmp_helmet"
	// SOM veteran
	soft_armor = list(MELEE = 50, BULLET = 75, LASER = 65, ENERGY = 65, BOMB = 55, BIO = 55, FIRE = 60, ACID = 55)

/obj/item/clothing/head/sw/cap/repensign
	name = "\improper 共和国海军少尉军帽"
	desc = "一顶贴合的蓝灰色军官帽."
	icon_state = "repensign_cap"
	worn_icon_state = "repensign_cap"

/obj/item/clothing/head/sw/cap/repnavalcaptain
	name = "\improper 共和国海军上尉军帽"
	desc = "一顶贴合的绿色军官帽."
	icon_state = "repnavalcaptain_cap"
	worn_icon_state = "repnavalcaptain_cap"

/obj/item/clothing/head/sw/cap/repofficer_ensign
	name = "\improper 帝国军官帽"
	desc = "一顶来自战后帝国海军的贴合灰色军官帽."
	icon_state = "repofficer_ensign"
	worn_icon_state = "repofficer_ensign"

/obj/item/clothing/head/sw/cap/repofficer_med
	name = "\improper 共和国医疗军官帽"
	desc = "一顶贴合的灰色医疗军官帽."
	icon_state = "repofficer_med"
	worn_icon_state = "repofficer_med"

/obj/item/clothing/head/sw/cap/repofficer_navcaptain
	name = "\improper 帝国海军上尉军帽"
	desc = "一顶贴合的绿色帝国海军上尉军帽."
	icon_state = "repofficer_navcaptain"
	worn_icon_state = "repofficer_navcaptain"

/obj/item/clothing/head/sw/cap/imp_stormofficer
	name = "\improper 帝国风暴兵军官帽"
	desc = "风暴兵军团军官佩戴的贴合黑色野战帽."
	icon_state = "impofficer_stormofficer"
	worn_icon_state = "impofficer_stormofficer"

/obj/item/clothing/head/helmet/marine/sw/repstormtrooper
	name = "\improper 共和国震击兵头盔"
	desc = "共和国精锐震击兵军团的强化头盔."
	icon_state = "repstormtrooper_helmet"
	worn_icon_state = "repstormtrooper_helmet"

/obj/item/clothing/head/helmet/marine/sw/imperial/airborne
	name = "\improper 帝国空降兵头盔"
	desc = "帝国陆军的强化空降头盔."
	icon_state = "repairborne_helmet"
	worn_icon_state = "repairborne_helmet"
	// SOM lorica (breacher)
	soft_armor = list(MELEE = 60, BULLET = 85, LASER = 80, ENERGY = 80, BOMB = 65, BIO = 55, FIRE = 70, ACID = 60)

/obj/item/clothing/head/helmet/marine/sw/clone/corps41
	name = "\improper 第41精英军团克隆人士兵头盔"
	desc = "带有第41精英军团独特标记的头盔."
	icon_state = "rep4RF_helmet"
	worn_icon_state = "rep4RF_helmet"

/obj/item/clothing/head/helmet/marine/sw/imp_stormofficer
	name = "\improper 帝国风暴兵军官头盔"
	desc = "帝国风暴兵军团军官佩戴的强化头盔."
	icon_state = "impofficer_stormofficer"
	worn_icon_state = "impofficer_stormofficer"

/obj/item/clothing/head/helmet/marine/sw/redguard
	name = "\improper 帝国皇家卫队头盔"
	desc = "皇帝皇家卫队的强化塑钢头盔."
	icon_state = "redguard"
	worn_icon_state = "redguard"
	// SOM lorica
	soft_armor = list(MELEE = 60, BULLET = 85, LASER = 80, ENERGY = 80, BOMB = 65, BIO = 55, FIRE = 70, ACID = 60)

/obj/item/clothing/head/helmet/marine/sw/senateguard
	name = "\improper 议会卫队头盔"
	desc = "银河议会卫队的强化塑钢头盔."
	icon_state = "senateguard"
	worn_icon_state = "senateguard"
	soft_armor = list(MELEE = 60, BULLET = 85, LASER = 80, ENERGY = 80, BOMB = 65, BIO = 55, FIRE = 70, ACID = 60)

/obj/item/clothing/head/helmet/marine/sw/stormsurgeon
	name = "\improper 帝国风暴兵外科医生头盔"
	desc = "帝国医疗军团野战外科医生的强化头盔."
	icon_state = "sturmsurgeon_helmet"
	worn_icon_state = "sturmsurgeon_helmet"

/obj/item/clothing/head/helmet/marine/sw/stormradio
	name = "\improper 帝国风暴兵无线电兵头盔"
	desc = "为远程通信适配的较轻风暴兵头盔."
	icon_state = "stormradio_helmet"
	worn_icon_state = "stormradio_helmet"
