//Jaeger Mk.II

//Medium
/obj/item/clothing/suit/modular/jaeger
	name = "\improper 猎兵步兵中型外骨骼"
	desc = "一种步兵型猎兵战斗外骨骼,可与模块化附件配合使用,以便在多种环境中发挥作用。这件似乎具有中等数量的装甲板。按住Alt并点击可移除附加物品。使用它来切换内置手电筒。"

	icon_state = "chest"
	worn_icon_state = "chest"
	soft_armor = MARINE_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_MEDIUM

	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT

	greyscale_config = /datum/greyscale_config/armor_mk2/infantry
	colorable_allowed = PRESET_COLORS_ALLOWED
	colorable_colors = ARMOR_PALETTES_LIST
	greyscale_colors = ARMOR_PALETTE_DRAB

	allowed_uniform_type = /obj/item/clothing/under

/obj/item/clothing/suit/modular/jaeger/generate_attachments_allowed()
	attachments_allowed = general_list_of_marine_modules.Copy()

/obj/item/clothing/suit/modular/jaeger/eva
	name = "\improper 猎兵EVA中型外骨骼"
	desc = "一种EVA型猎兵战斗外骨骼,可与模块化附件配合使用,以便在多种环境中发挥作用。这件似乎具有中等数量的装甲板。按住Alt并点击可移除附加物品。使用它来切换内置手电筒。"
	greyscale_config = /datum/greyscale_config/armor_mk2/eva

/obj/item/clothing/suit/modular/jaeger/helljumper
	name = "\improper 猎兵地狱伞兵中型外骨骼"
	desc = "一种地狱伞兵型猎兵战斗外骨骼,可与模块化附件配合使用,以便在多种环境中发挥作用。这件似乎具有中等数量的装甲板。按住Alt并点击可移除附加物品。使用它来切换内置手电筒。"
	greyscale_config = /datum/greyscale_config/armor_mk2/helljumper

/obj/item/clothing/suit/modular/jaeger/ranger
	name = "\improper 猎兵游骑兵中型外骨骼"
	desc = "一种游骑兵型猎兵战斗外骨骼,可与模块化附件配合使用,以便在多种环境中发挥作用。这件似乎具有中等数量的装甲板。按住Alt并点击可移除附加物品。使用它来切换内置手电筒。"
	greyscale_config = /datum/greyscale_config/armor_mk2/ranger

/obj/item/clothing/suit/modular/jaeger/hotaru
	name = "\improper 风格型萤火虫中型外骨骼"
	desc = "一种游骑兵型萤火虫战斗外骨骼,可与模块化附件配合使用,以便在多种环境中发挥作用。这件似乎具有中等数量的装甲板。按住Alt并点击可移除附加物品。使用它来切换内置手电筒。"
	greyscale_config = /datum/greyscale_config/armor_mk2/hotaru

// Light

/obj/item/clothing/suit/modular/jaeger/light
	name = "\improper 猎兵侦察兵轻型外骨骼"
	desc = "一种侦察兵型猎兵战斗外骨骼,可与模块化附件配合使用,以便在多种环境中发挥作用。这件似乎具有轻量的装甲板。按住Alt并点击可移除附加物品。使用它来切换内置手电筒。"
	soft_armor = MARINE_ARMOR_LIGHT
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	greyscale_config = /datum/greyscale_config/armor_mk2/scout

/obj/item/clothing/suit/modular/jaeger/light/skirmisher
	name = "\improper 猎兵散兵轻型外骨骼"
	desc = "一种散兵型猎兵战斗外骨骼,可与模块化附件配合使用,以便在多种环境中发挥作用。这件似乎具有轻量的装甲板。按住Alt并点击可移除附加物品。使用它来切换内置手电筒。"
	greyscale_config = /datum/greyscale_config/armor_mk2/skirmisher

/obj/item/clothing/suit/modular/jaeger/light/trooper
	name = "\improper 猎兵步兵轻型外骨骼"
	desc = "一种步兵型猎兵战斗外骨骼,可与模块化附件配合使用,以便在多种环境中发挥作用。这件似乎具有轻量的装甲板。按住Alt并点击可移除附加物品。使用它来切换内置手电筒。"
	greyscale_config = /datum/greyscale_config/armor_mk2/trooper

// Heavy
/obj/item/clothing/suit/modular/jaeger/heavy
	name = "\improper 猎兵冈格尼尔重型外骨骼"
	desc = "一种冈格尼尔型猎兵战斗外骨骼,可与模块化附件配合使用,以便在多种环境中发挥作用。这件似乎具有大量的装甲板。按住Alt并点击可移除附加物品。使用它来切换内置手电筒。"
	soft_armor = MARINE_ARMOR_HEAVY
	slowdown = SLOWDOWN_ARMOR_HEAVY
	greyscale_config = /datum/greyscale_config/armor_mk2/gugnir

/obj/item/clothing/suit/modular/jaeger/heavy/assault
	name = "\improper 猎兵突击重型外骨骼"
	desc = "一种突击型猎兵战斗外骨骼,可与模块化附件配合使用,以便在多种环境中发挥作用。这件似乎具有大量的装甲板。按住Alt并点击可移除附加物品。使用它来切换内置手电筒。"
	greyscale_config = /datum/greyscale_config/armor_mk2

/obj/item/clothing/suit/modular/jaeger/heavy/eod
	name = "\improper 猎兵排爆重型外骨骼"
	desc = "一种排爆型猎兵战斗外骨骼,可与模块化附件配合使用,以便在多种环境中发挥作用。这件似乎具有大量的装甲板。按住Alt并点击可移除附加物品。使用它来切换内置手电筒。"
	greyscale_config = /datum/greyscale_config/armor_mk2/eod

//jaeger hats
/obj/item/clothing/head/modular/marine
	name = "猎兵型步兵头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有步兵标记。"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	icon_state = "helmet"
	worn_icon_state = "helmet"
	icon_override = null
	soft_armor = MARINE_ARMOR_HEAVY
	greyscale_colors = ARMOR_PALETTE_DRAB
	colorable_allowed = PRESET_COLORS_ALLOWED|HAIR_CONCEALING_CHANGE_ALLOWED
	colorable_colors = ARMOR_PALETTES_LIST
	greyscale_config = /datum/greyscale_config/armor_mk2/infantry

	starting_attachments = list(/obj/item/armor_module/armor/visor/marine, /obj/item/armor_module/storage/helmet)

	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT

/obj/item/clothing/head/modular/marine/eva
	name = "猎兵型EVA头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有EVA标记。"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/eva, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/eva

/obj/item/clothing/head/modular/marine/eva/skull
	name = "猎兵型EVA\"骷髅\"头盔"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/eva/skull, /obj/item/armor_module/storage/helmet)

/obj/item/clothing/head/modular/marine/skirmisher
	name = "猎兵型散兵头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有散兵标记。"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/skirmisher, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/skirmisher

/obj/item/clothing/head/modular/marine/scout
	name = "猎兵型侦察兵头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有侦察兵标记"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/scout, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/scout

/obj/item/clothing/head/modular/marine/gungnir
	name = "猎兵型冈格尼尔头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有冈格尼尔标记"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/gungnir, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/gugnir

/obj/item/clothing/head/modular/marine/assault
	name = "猎兵型突击头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有突击标记。"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/assault, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2

/obj/item/clothing/head/modular/marine/eod
	name = "猎兵型排爆头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有排爆标记"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/eod, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/eod

/obj/item/clothing/head/modular/marine/helljumper
	name = "猎兵型地狱伞兵头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有地狱伞兵标记"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/helljumper, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/helljumper
	visorless_offset_y = 0

/obj/item/clothing/head/modular/marine/ranger
	name = "猎兵型游骑兵头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有游骑兵标记"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/ranger, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/ranger

/obj/item/clothing/head/modular/marine/traditional
	name = "猎兵型传统游骑兵头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有传统游骑兵标记"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/traditional, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/traditional

/obj/item/clothing/head/modular/marine/trooper
	name = "猎兵型步兵头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有步兵标记"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/trooper, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/trooper

/obj/item/clothing/head/modular/marine/mjolnir_open
	name = "猎兵Mk.I型开放式雷神头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有雷神标记但露出下颌。"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/mjolnir_open, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk2/mjolnir_open

/obj/item/clothing/head/modular/marine/kabuto
	name = "风格型兜头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有兜标记"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/kabuto, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/kabuto

/obj/item/clothing/head/modular/marine/hotaru
	name = "风格型萤火虫头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有萤火虫标记"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/hotaru, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/hotaru

/obj/item/clothing/head/modular/marine/dashe
	name = "风格型冲刺头盔"
	desc = "通常与猎兵战斗外骨骼搭配使用。可在头盔挂载点上安装实用功能。带有冲刺标记"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/dashe, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/dashe

// Hardsuit Helmets

/obj/item/clothing/head/modular/marine/hardsuit_helm
	name = "斑点迷彩基础硬质服头盔"
	desc = "通常与FleckTex WY-01模块化外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有基础标识"
	greyscale_config = /datum/greyscale_config/hardsuit_variant
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine, /obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/secondary_color/helm)
	attachments_by_slot = list(
		ATTACHMENT_SLOT_VISOR,
		ATTACHMENT_SLOT_STORAGE,
		ATTACHMENT_SLOT_HEAD_MODULE,
		ATTACHMENT_SLOT_BADGE,
		ATTACHMENT_SLOT_HELM_SECONDARY_COLOR,
	)

/obj/item/clothing/head/modular/marine/hardsuit_helm/markfive
	name = "FleckTex Mark V 破门者头盔"
	desc = "通常与FleckTex WY-01模块化外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有破门者标识"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/fourvisor, /obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/secondary_color/helm)
	greyscale_config = /datum/greyscale_config/hardsuit_variant/syndicate_markfive

/obj/item/clothing/head/modular/marine/hardsuit_helm/markthree
	name = "FleckTex Mark III 掠夺者头盔"
	desc = "通常与FleckTex WY-01模块化外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有掠夺者标识"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/foureyevisor, /obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/secondary_color/helm)
	greyscale_config = /datum/greyscale_config/hardsuit_variant/syndicate_markthree

/obj/item/clothing/head/modular/marine/hardsuit_helm/markone
	name = "FleckTex Mark I 突袭者头盔"
	desc = "通常与FleckTex WY-01模块化外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有突袭者标识"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/markonevisor, /obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/secondary_color/helm)
	greyscale_config = /datum/greyscale_config/hardsuit_variant

// VSD hardsuit helms!

/obj/item/clothing/head/modular/marine/vsd_hardsuit
	name = "Crasher MT/41 '福波斯'头盔"
	desc = "通常与CrashCore MT/P模块化外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有'福波斯'标识"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/phobos, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/vsd_hardsuit

/obj/item/clothing/head/modular/marine/vsd_hardsuit/clementia
	name = "Crasher MT/41 '克莱门提亚'头盔"
	desc = "通常与CrashCore MT/P模块化外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有'克莱门提亚'标识"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/clementia, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/vsd_hardsuit/alt

/obj/item/clothing/head/modular/marine/vsd_hardsuit/hephaestus
	name = "Crasher MT/41 '赫菲斯托斯'头盔"
	desc = "通常与CrashCore MT/P模块化外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有'赫菲斯托斯'标识"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/hephaestus, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/vsd_hardsuit/alt_two
