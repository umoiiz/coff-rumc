/obj/item/clothing/suit/modular/som
	name = "\improper SOM轻型战斗装甲"
	desc = "M-21战斗装甲通常由SOM轻步兵或其他需要更高机动性但牺牲部分防护的专家使用.提供良好的防护,同时对使用者的机动性影响极小.Alt-Click移除已安装的物品.使用它来切换内置手电筒."
	soft_armor = list(MELEE = 45, BULLET = 70, LASER = 60, ENERGY = 60, BOMB = 50, BIO = 50, FIRE = 55, ACID = 50)
	icon = 'icons/mob/modular/som_armor.dmi'
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/modular/som_armor.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	icon_state = "som_medium"
	worn_icon_state = "som_medium"
	slowdown = SLOWDOWN_ARMOR_MEDIUM

	attachments_allowed = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/module/pluto,
		/obj/item/armor_module/module/valkyrie_autodoc/som,
		/obj/item/armor_module/module/fire_proof/som,
		/obj/item/armor_module/module/tyr_extra_armor/som,
		/obj/item/armor_module/module/mimir_environment_protection/som,
		/obj/item/armor_module/module/eshield/som,
		/obj/item/armor_module/storage/general,
		/obj/item/armor_module/storage/ammo_mag,
		/obj/item/armor_module/storage/engineering,
		/obj/item/armor_module/storage/medical,
		/obj/item/armor_module/storage/general/som,
		/obj/item/armor_module/storage/engineering/som,
		/obj/item/armor_module/storage/medical/som,
		/obj/item/armor_module/storage/injector,
		/obj/item/armor_module/storage/grenade,
		/obj/item/armor_module/storage/integrated,
		/obj/item/armor_module/armor/badge,
	)

	icon_state_variants = list(
		"black",
	)
	current_variant = "black"

	allowed_uniform_type = /obj/item/clothing/under

/obj/item/clothing/suit/modular/som/engineer
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/engineering,
	)

/obj/item/clothing/suit/modular/som/medic
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/general/som,
	)

/obj/item/clothing/suit/modular/som/shield
	starting_attachments = list(
		/obj/item/armor_module/module/eshield/som,
		/obj/item/armor_module/storage/medical/som,
	)

/obj/item/clothing/suit/modular/som/light
	name = "\improper SOM侦察兵护甲"
	desc = "M-11侦察兵护甲是一套轻量化套装,在提供合理防护的同时将负重降至最低.通常见于侦察兵或其他一般不会遭到射击的专业单位.Alt-Click可移除附加物品.使用它可切换内置手电筒."
	soft_armor = list(MELEE = 35, BULLET = 60, LASER = 50, ENERGY = 50, BOMB = 45, BIO = 45, FIRE = 50, ACID = 40)
	icon_state = "som_light"
	worn_icon_state = "som_light"
	slowdown = SLOWDOWN_ARMOR_LIGHT

/obj/item/clothing/suit/modular/som/light/shield
	starting_attachments = list(
		/obj/item/armor_module/module/eshield/som,
		/obj/item/armor_module/storage/medical/som,
	)


/obj/item/clothing/suit/modular/som/heavy
	name = "\improper SOM重型战斗护甲"
	desc = "一套标准的M-31重型战斗护甲,由SOM突击部队穿着.提供出色的防护,但会略微降低机动性.Alt-Click可移除附加物品.使用它可切换内置手电筒."
	soft_armor = list(MELEE = 50, BULLET = 75, LASER = 65, ENERGY = 65, BOMB = 55, BIO = 55, FIRE = 60, ACID = 55)
	icon_state = "som_heavy"
	worn_icon_state = "som_heavy"
	slowdown = SLOWDOWN_ARMOR_HEAVY

/obj/item/clothing/suit/modular/som/heavy/pyro
	starting_attachments = list(
		/obj/item/armor_module/module/fire_proof/som,
		/obj/item/armor_module/storage/medical/som,
	)

/obj/item/clothing/suit/modular/som/heavy/lorica
	starting_attachments = list(
		/obj/item/armor_module/module/tyr_extra_armor/som,
		/obj/item/armor_module/storage/medical/som,
	)

/obj/item/clothing/suit/modular/som/heavy/mithridatius
	starting_attachments = list(
		/obj/item/armor_module/module/mimir_environment_protection/som,
		/obj/item/armor_module/storage/medical/som,
	)

/obj/item/clothing/suit/modular/som/heavy/shield
	starting_attachments = list(
		/obj/item/armor_module/module/eshield/som,
		/obj/item/armor_module/storage/medical/som,
	)

/obj/item/clothing/suit/modular/som/heavy/leader
	name = "\improper SOM戈耳工型突击护甲"
	desc = "一套笨重的重型战斗护甲,M-35\"戈耳工\"护甲为用户提供卓越防护,同时不会严重影响机动性.由于建造和维护要求极高,通常见于SOM指挥官或他们最精锐的战斗单位.你需要强大的火力才能击穿它.Alt-Click可移除附加物品.使用它可切换内置手电筒."
	soft_armor = list(MELEE = 60, BULLET = 80, LASER = 70, ENERGY = 70, BOMB = 60, BIO = 55, FIRE = 65, ACID = 55)
	icon_state = "som_leader"
	worn_icon_state = "som_leader"

	siemens_coefficient = 0.4
	permeability_coefficient = 0.5
	gas_transfer_coefficient = 0.5
	attachments_allowed = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/module/pluto,
		/obj/item/armor_module/module/valkyrie_autodoc/som,
		/obj/item/armor_module/module/fire_proof/som,
		/obj/item/armor_module/module/mimir_environment_protection/som,
		/obj/item/armor_module/module/eshield/som,
		/obj/item/armor_module/storage/general,
		/obj/item/armor_module/storage/ammo_mag,
		/obj/item/armor_module/storage/engineering,
		/obj/item/armor_module/storage/medical,
		/obj/item/armor_module/storage/general/som,
		/obj/item/armor_module/storage/engineering/som,
		/obj/item/armor_module/storage/medical/som,
		/obj/item/armor_module/storage/injector,
		/obj/item/armor_module/storage/grenade,
		/obj/item/armor_module/storage/integrated,
		/obj/item/armor_module/armor/badge,
	)

/obj/item/clothing/suit/modular/som/heavy/leader/valk
	starting_attachments = list(
		/obj/item/armor_module/module/valkyrie_autodoc/som,
		/obj/item/armor_module/storage/medical/som,
	)

/obj/item/clothing/suit/modular/som/heavy/leader/officer
	desc = "一套笨重的重型战斗护甲,M-35\"戈耳工\"护甲为用户提供卓越防护,同时不会严重影响机动性.这一套上的金色标记表明它由一名高级战地军官穿着.你需要强大的火力才能击穿它.Alt-Click可移除附加物品.使用它可切换内置手电筒."
	icon_state = "som_officer"
	worn_icon_state = "som_officer"
	starting_attachments = list(
		/obj/item/armor_module/module/valkyrie_autodoc/som,
		/obj/item/armor_module/storage/medical/som,
	)

//helmet

/obj/item/clothing/head/modular/som
	name = "\improper SOM步兵头盔"
	desc = "SOM战斗部队佩戴的标准战斗头盔.采用先进聚合物制成,在不影响视野的情况下提供非常有效的防护."
	icon = 'icons/mob/modular/som_helmets.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/modular/som_helmets.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	icon_state = "som_helmet"
	worn_icon_state = "som_helmet"
	soft_armor = list(MELEE = 45, BULLET = 70, LASER = 60, ENERGY = 60, BOMB = 50, BIO = 50, FIRE = 55, ACID = 50)
	inv_hide_flags = HIDEEARS|HIDEALLHAIR
	armor_protection_flags = HEAD|FACE|EYES
	attachments_allowed = list(
		/obj/item/armor_module/module/binoculars,
		/obj/item/armor_module/module/binoculars/artemis_mark_two,
		/obj/item/armor_module/module/artemis,
		/obj/item/armor_module/module/antenna,
		/obj/item/armor_module/storage/helmet,
		/obj/item/armor_module/armor/badge,
	)
	greyscale_config = null
	starting_attachments = list(/obj/item/armor_module/storage/helmet)
	icon_state_variants = list(
		"black",
	)
	current_variant = "black"
	visorless_offset_y = 0

/obj/item/clothing/head/modular/som/engineer
	name = "\improper SOM工程头盔"
	desc = "一款专为战斗工兵设计的专用头盔.其主要特点是集成了焊接面罩."
	icon_state = "som_helmet_engineer"
	worn_icon_state = "som_helmet_engineer"
	attachments_allowed = list(
		/obj/item/armor_module/storage/helmet,
		/obj/item/armor_module/armor/badge,
		/obj/item/armor_module/module/welding/som,
	)
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/welding/som)

/obj/item/clothing/head/modular/som/bio
	name = "\improper SOM生化防护头盔"
	desc = "这款专用头盔由装备用于处理危险化学、辐射或其他有害物质的SOM人员佩戴.通常由SOM自己释放."
	icon_state = "som_helmet_bio"
	worn_icon_state = "som_helmet_bio"
	soft_armor = list(MELEE = 45, BULLET = 70, LASER = 60, ENERGY = 60, BOMB = 50, BIO = 75, FIRE = 50, ACID = 70)
	siemens_coefficient = 0.1
	permeability_coefficient = 0
	gas_transfer_coefficient = 0.1
	attachments_allowed = list(
		/obj/item/armor_module/storage/helmet,
		/obj/item/armor_module/armor/badge,
	)

/obj/item/clothing/head/modular/som/hades
	name = "\improper 哈迪斯头盔系统"
	desc = "一款与\"哈迪斯\"护甲模块配套的头盔,旨在显著提升防火防护,同时不影响正常耐久度."
	icon_state = "som_helmet_light"
	worn_icon_state = "som_helmet_light"
	soft_armor = list(MELEE = 45, BULLET = 70, LASER = 60, ENERGY = 60, BOMB = 50, BIO = 50, FIRE = 90, ACID = 50)
	attachments_allowed = list(
		/obj/item/armor_module/storage/helmet,
		/obj/item/armor_module/armor/badge,
	)

/obj/item/clothing/head/modular/som/veteran
	name = "\improper SOM老兵头盔"
	desc = "SOM战斗专家佩戴的标准战斗头盔.最先进的材料为更有价值的大脑提供更多防护."
	soft_armor = list(MELEE = 50, BULLET = 75, LASER = 65, ENERGY = 65, BOMB = 55, BIO = 55, FIRE = 60, ACID = 55)

/obj/item/clothing/head/modular/som/lorica
	name = "\improper 洛里卡头盔系统"
	desc = "一款与\"洛里卡\"护甲模块配套的笨重头盔,旨在以显著增加的重量和降低的灵活性为代价提供出色的防护.大量附加护甲提升了对所有伤害的防护."
	icon_state = "som_helmet_lorica"
	worn_icon_state = "som_helmet_lorica"
	soft_armor = list(MELEE = 60, BULLET = 85, LASER = 80, ENERGY = 80, BOMB = 65, BIO = 55, FIRE = 70, ACID = 60)
	attachments_allowed = list(
		/obj/item/armor_module/storage/helmet,
		/obj/item/armor_module/armor/badge,
	)

/obj/item/clothing/head/modular/som/leader
	name = "\improper SOM戈耳工型头盔"
	desc = "为配合戈耳工型突击护甲使用而制造,提供卓越防护.通常见于SOM指挥官或他们最精锐的战斗单位."
	icon_state = "som_helmet_leader"
	worn_icon_state = "som_helmet_leader"
	soft_armor = list(MELEE = 60, BULLET = 80, LASER = 70, ENERGY = 70, BOMB = 60, BIO = 55, FIRE = 65, ACID = 55)
	attachments_allowed = list(
		/obj/item/armor_module/module/binoculars,
		/obj/item/armor_module/module/binoculars/artemis_mark_two,
		/obj/item/armor_module/module/artemis,
		/obj/item/armor_module/module/antenna,
		/obj/item/armor_module/storage/helmet,
		/obj/item/armor_module/armor/badge,
	)

/obj/item/clothing/head/modular/som/leader/officer
	desc = "为配合戈耳工型突击护甲使用而制造,提供卓越防护.这一顶带有金色标记,表明它属于一名高级战地军官."
	icon_state = "som_helmet_officer"
	worn_icon_state = "som_helmet_officer"
