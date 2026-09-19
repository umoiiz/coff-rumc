// Xenonauten suits

/obj/item/clothing/suit/modular/xenonauten
	name = "\improper 异星勇士-M型装甲背心"
	desc = "一件XN-M背心,也被称为异星勇士,是一套带有模块化附件的背心,设计用于多种环境.这件似乎是中型变体.Alt-Click移除附加物品.使用它切换内置手电筒."
	icon_state = "chest"
	worn_icon_state = "chest"
	icon = null
	worn_icon_list = list(slot_wear_suit_str = 'icons/mob/modular/modular_armor.dmi')
	soft_armor = MARINE_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_MEDIUM

	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT
	greyscale_config = /datum/greyscale_config/xenonaut
	colorable_allowed = PRESET_COLORS_ALLOWED
	colorable_colors = ARMOR_PALETTES_LIST
	greyscale_colors = ARMOR_PALETTE_DRAB

	allowed_uniform_type = /obj/item/clothing/under

/obj/item/clothing/suit/modular/xenonauten/generate_attachments_allowed()
	attachments_allowed = general_list_of_marine_modules.Copy()

/obj/item/clothing/suit/modular/xenonauten/hodgrenades
	starting_attachments = list(
		/obj/item/armor_module/module/ballistic_armor,
		/obj/item/armor_module/storage/grenade,
	)

/obj/item/clothing/suit/modular/xenonauten/engineer
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/engineering,
	)

/obj/item/clothing/suit/modular/xenonauten/lightmedical
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/lightgeneral
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/xenonauten/mimir
	starting_attachments = list(
		/obj/item/armor_module/module/mimir_environment_protection/mark1,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/xenonauten/mimirinjector
	starting_attachments = list(
		/obj/item/armor_module/module/mimir_environment_protection/mark1,
		/obj/item/armor_module/storage/injector,
	)

/obj/item/clothing/suit/modular/xenonauten/shield
	starting_attachments = list(
		/obj/item/armor_module/module/eshield,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/valk
	starting_attachments = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/light
	name = "\improper 异星勇士-L型装甲背心"
	desc = "一件XN-L背心,也被称为异星勇士,是一套带有模块化附件的背心,设计用于多种环境.这件似乎是轻型变体.Alt-Click移除附加物品.使用它切换内置手电筒."
	soft_armor = MARINE_ARMOR_LIGHT
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	greyscale_config = /datum/greyscale_config/xenonaut/light

/obj/item/clothing/suit/modular/xenonauten/light/shield
	starting_attachments = list(
		/obj/item/armor_module/module/eshield,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/light/lightmedical
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy
	name = "\improper 异星装甲-H型装甲背心"
	desc = "一件XN-H背心,也被称为异星装甲,一套带有模块化附件的背心,设计用于多种环境。这件似乎是重型变体。Alt-Click移除附加物品。使用它来切换内置手电筒。"
	soft_armor = MARINE_ARMOR_HEAVY
	slowdown = SLOWDOWN_ARMOR_HEAVY
	greyscale_config = /datum/greyscale_config/xenonaut/heavy

/obj/item/clothing/suit/modular/xenonauten/heavy/mimirengi
	starting_attachments = list(
		/obj/item/armor_module/module/mimir_environment_protection/mark1,
		/obj/item/armor_module/storage/engineering,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/leader
	starting_attachments = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/npc_medic
	starting_attachments = list(
		/obj/item/armor_module/module/mimir_environment_protection/mark1,
		/obj/item/armor_module/storage/grenade,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/tyr_onegeneral
	starting_attachments = list(
		/obj/item/armor_module/module/tyr_extra_armor/mark1,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/tyr_one
	starting_attachments = list(
		/obj/item/armor_module/module/tyr_extra_armor/mark1,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/tyr_two
	starting_attachments = list(
		/obj/item/armor_module/module/tyr_extra_armor,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/grenadier //Literally grenades
	starting_attachments = list(
		/obj/item/armor_module/module/ballistic_armor,
		/obj/item/armor_module/storage/grenade,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/surt
	starting_attachments = list(
		/obj/item/armor_module/module/fire_proof,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/heavy/shield
	starting_attachments = list(
		/obj/item/armor_module/module/eshield,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/xenonauten/pilot
	name = "\improper 泰拉政府标准防弹夹克"
	desc = "一种由空投艇飞行员使用的防弹夹克,用于在驾驶舱飞行时保护自己。在保护穿戴者免受高速实心弹丸伤害方面表现出色。"
	item_flags = NONE
	soft_armor = MARINE_ARMOR_HEAVY
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	greyscale_config = /datum/greyscale_config/xenonaut/pilot

	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraints/handcuffs,
		/obj/item/explosive/grenade,
		/obj/item/binoculars,
		/obj/item/weapon/combat_knife,
		/obj/item/attachable/bayonetknife,
		/obj/item/storage/belt/sparepouch,
		/obj/item/storage/holster/blade,
		/obj/item/storage/holster/belt,
		/obj/item/weapon/energy/sword,
	)

/obj/item/clothing/suit/storage/ballistic
	name = "\improper 碎击者多威胁防弹装甲"
	desc = "一套21世纪旧式身体装甲系统的再利用设计。"
	soft_armor = list(MELEE = 30, BULLET = 50, LASER = 20, ENERGY = 25, BOMB = 30, BIO = 5, FIRE = 25, ACID = 30)
	slowdown = SLOWDOWN_ARMOR_LIGHT
	armor_protection_flags = CHEST|GROIN
	icon = 'icons/mob/clothing/suits/marine_armor.dmi'
	icon_state = "ballistic_vest"
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/marine_armor.dmi'
	)
	equip_delay_self = 2 SECONDS

	icon_state_variants = list(
		"urban",
		"jungle",
		"desert",
		"snow",
	)
	colorable_allowed = ICON_STATE_VARIANTS_ALLOWED
	current_variant = "urban"

	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraints/handcuffs,
		/obj/item/explosive/grenade,
		/obj/item/binoculars,
		/obj/item/weapon/combat_knife,
		/obj/item/attachable/bayonetknife,
		/obj/item/storage/belt/sparepouch,
		/obj/item/storage/holster/blade,
		/obj/item/storage/holster/belt,
		/obj/item/weapon/energy/sword,
	)

//Xenonauten helmets
/obj/item/clothing/head/modular/m10x
	name = "\improper M10X型陆战队头盔"
	desc = "一顶带有连接点的标准M10型头盔。标签上写着:'开棺葬礼和闭棺葬礼之间的区别。戴在头上以获得最佳效果。'。"
	worn_icon_state_worn = TRUE
	soft_armor = MARINE_ARMOR_HEAVY
	starting_attachments = list(/obj/item/armor_module/storage/helmet)
	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT

	greyscale_config = /datum/greyscale_config/xenonaut/helm
	greyscale_colors = ARMOR_PALETTE_DRAB

	visorless_offset_y = 0

/obj/item/clothing/head/modular/m10x/hod
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/hod_head)

/obj/item/clothing/head/modular/m10x/freyr
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/artemis)

/obj/item/clothing/head/modular/m10x/antenna
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/antenna)

/obj/item/clothing/head/modular/m10x/welding
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/welding)

/obj/item/clothing/head/modular/m10x/superiorwelding
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/welding/superior)

/obj/item/clothing/head/modular/m10x/mimir
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/mimir_environment_protection/mimir_helmet/mark1)

/obj/item/clothing/head/modular/m10x/tyr
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/tyr_head)

/obj/item/clothing/head/modular/m10x/surt
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/fire_proof_helmet)

/obj/item/clothing/head/modular/m10x/heavy
	name = "\improper M10XE型陆战队头盔"
	desc = "一顶标准M10XE型头盔。这是M10X头盔的改进版本,提供了封闭式面罩装置。"
	worn_icon_state = "helm"
	greyscale_config = /datum/greyscale_config/xenonaut/helm/heavy
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/xenonaut, /obj/item/armor_module/storage/helmet)

/obj/item/clothing/head/modular/m10x/leader
	name = "\improper M11X型队长头盔"
	desc = "一顶为陆战队队长准备的稍显花哨的头盔。这顶头盔带有缓冲垫,以保护你脆弱的大脑。"
	soft_armor = MARINE_ARMOR_HEAVY

/obj/item/clothing/head/modular/m10x/leader/antenna
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/module/antenna)

/obj/item/clothing/suit/modular/xenonauten/light/mk1
	name = "\improper 异星装甲-L-MK1型装甲背心"
	greyscale_config = /datum/greyscale_config/xenonaut/mk1/light

/obj/item/clothing/suit/modular/xenonauten/mk1
	name = "\improper 异星装甲-M-MK1型装甲背心"
	greyscale_config = /datum/greyscale_config/xenonaut/mk1/medium

/obj/item/clothing/suit/modular/xenonauten/heavy/mk1
	name = "\improper 异星装甲-H-MK1型装甲背心"
	greyscale_config = /datum/greyscale_config/xenonaut/mk1/heavy

/obj/item/clothing/head/modular/m10x/mk1
	name = "\improper M10X1型陆战队头盔"
	greyscale_config = /datum/greyscale_config/xenonaut/helm/mk1
