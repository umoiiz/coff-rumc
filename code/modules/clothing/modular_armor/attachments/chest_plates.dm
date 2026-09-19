/**
 *
 *  Chestplates
 *
 */
/obj/item/armor_module/armor/chest
	icon_state = "chest"
	slot = ATTACHMENT_SLOT_CHESTPLATE
	greyscale_config = /datum/greyscale_config/armor_mk1/infantry

/obj/item/armor_module/armor/chest/marine
	name = "\improper 猎兵式中型步兵胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供中等防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为步兵装甲部件."
	soft_armor = MARINE_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_MEDIUM

/obj/item/armor_module/armor/chest/marine/skirmisher
	name = "\improper 猎兵式轻型游击兵胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供轻微防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为游击兵装甲部件."
	soft_armor = MARINE_ARMOR_LIGHT
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	greyscale_config = /datum/greyscale_config/armor_mk1/skirmisher

/obj/item/armor_module/armor/chest/marine/skirmisher/scout
	name = "\improper 猎兵式轻型侦察兵胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供轻微防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为侦察兵装甲部件."
	greyscale_config = /datum/greyscale_config/armor_mk1/scout

/obj/item/armor_module/armor/chest/marine/skirmisher/trooper
	name = "\improper 猎兵式突击兵胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供高防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为突击兵装甲部件."
	greyscale_config = /datum/greyscale_config/armor_mk1/trooper

/obj/item/armor_module/armor/chest/marine/assault
	name = "\improper 猎兵式重型突击胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供高防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为突击装甲部件."
	soft_armor = MARINE_ARMOR_HEAVY
	slowdown = SLOWDOWN_ARMOR_HEAVY
	greyscale_config = /datum/greyscale_config/armor_mk1

/obj/item/armor_module/armor/chest/marine/eva
	name = "\improper 猎兵式中型EVA胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供中等防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为EVA装甲部件."
	greyscale_config = /datum/greyscale_config/armor_mk1/eva

/obj/item/armor_module/armor/chest/marine/assault/eod
	name = "\improper 猎兵式重型EOD胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供高防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为EOD装甲部件."
	greyscale_config = /datum/greyscale_config/armor_mk1/eod

/obj/item/armor_module/armor/chest/marine/helljumper
	name = "\improper 猎兵式地狱伞兵胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供高防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为地狱伞兵装甲部件."
	greyscale_config = /datum/greyscale_config/armor_mk1/helljumper

/obj/item/armor_module/armor/chest/marine/ranger
	name = "\improper 猎兵式游骑兵胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供高防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为游骑兵装甲部件."
	greyscale_config = /datum/greyscale_config/armor_mk1/ranger

/obj/item/armor_module/armor/chest/marine/mjolnir
	name = "\improper 猎兵式雷神胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供中等防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为雷神装甲部件."
	greyscale_config = /datum/greyscale_config/armor_mk1/mjolnir

/obj/item/armor_module/armor/chest/marine/kabuto
	name = "\improper 样式型兜甲胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供高防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为兜甲装甲部件."
	greyscale_config = /datum/greyscale_config/armor_mk1/kabuto

/obj/item/armor_module/armor/chest/marine/hotaru
	name = "\improper 样式型萤火虫胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供高防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为萤火虫装甲部件."
	greyscale_config = /datum/greyscale_config/armor_mk1/hotaru

/obj/item/armor_module/armor/chest/marine/dashe
	name = "\improper 样式型冲角胸甲"
	desc = "专为猎兵战斗外骨骼设计.附着时提供高防护和负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.该装甲似乎被标记为冲角装甲部件."
	greyscale_config = /datum/greyscale_config/armor_mk1/dashe

// Hardsuit Chest Plates
/obj/item/armor_module/armor/chest/marine/hardsuit
	icon_state_variants = list(
		"normal",
		"webbing",
	)
	current_variant = "normal"
	greyscale_colors = ARMOR_PALETTE_BLACK
	colorable_colors = ARMOR_PALETTES_LIST
	colorable_allowed = ICON_STATE_VARIANTS_ALLOWED|PRESET_COLORS_ALLOWED
	starting_attachments = list(/obj/item/armor_module/armor/secondary_color/chest/webbing)
	attachments_allowed = list(/obj/item/armor_module/armor/secondary_color/chest/webbing)
	attachments_by_slot = list(ATTACHMENT_SLOT_CHEST_SECONDARY_COLOR)

/obj/item/armor_module/armor/chest/marine/hardsuit/syndicate_markfive
	name = "\improper 斑点迷彩Mark V破门者胸甲"
	desc = "专为斑点迷彩WY-01外骨骼设计.附着时提供高防护,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.所有臂甲具有相同的防护和减速,这意味着只有更换胸甲才会产生显著的装甲差异.该装甲似乎被标记为Mark V装甲部件."
	soft_armor = MARINE_ARMOR_HEAVY
	slowdown = SLOWDOWN_ARMOR_HEAVY
	greyscale_config = /datum/greyscale_config/hardsuit_variant/syndicate_markfive

/obj/item/armor_module/armor/chest/marine/hardsuit/syndicate_markthree
	name = "\improper 斑点迷彩Mark III掠夺者胸甲"
	desc = "专为斑点迷彩WY-01外骨骼设计.附着时提供中等防护,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.所有臂甲具有相同的防护和减速,这意味着只有更换胸甲才会产生显著的装甲差异.该装甲似乎被标记为Mark III装甲部件."
	soft_armor = MARINE_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	greyscale_config = /datum/greyscale_config/hardsuit_variant/syndicate_markthree

/obj/item/armor_module/armor/chest/marine/hardsuit/syndicate_markone
	name = "\improper 斑点迷彩Mark I突袭者胸甲"
	desc = "专为斑点迷彩WY-01外骨骼设计.附着时提供轻微防护,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.所有臂甲具有相同的防护和减速,这意味着只有更换胸甲才会产生显著的装甲差异.该装甲似乎被标记为Mark I装甲部件."
	soft_armor = MARINE_ARMOR_LIGHT
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	greyscale_config = /datum/greyscale_config/hardsuit_variant

//VSD Hardsuits
/obj/item/armor_module/armor/chest/marine/vsd_hardsuit
	name = "\improper 粉碎者超重型MT/41\"火卫一\"胸甲"
	desc = "专为CrashCore MT/P外骨骼设计.附着时提供极佳的防护,代价是负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.这意味着只有更换胸甲才会产生显著的装甲差异.该装甲似乎被标记为\"火卫一\"装甲部件."
	soft_armor = MARINE_ARMOR_HEAVY
	slowdown = SLOWDOWN_ARMOR_HEAVY
	greyscale_config = /datum/greyscale_config/vsd_hardsuit
	starting_attachments = list(/obj/item/armor_module/armor/secondary_color/chest/visor_color)

/obj/item/armor_module/armor/chest/marine/vsd_hardsuit/clementia
	name = "\improper 粉碎者超重型MT/41\"克莱门提亚\"胸甲"
	desc = "专为CrashCore MT/P外骨骼设计.附着时提供极佳的防护,代价是负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.这意味着只有更换胸甲才会产生显著的装甲差异.该装甲似乎被标记为\"克莱门提亚\"装甲部件."
	greyscale_config = /datum/greyscale_config/vsd_hardsuit/alt
	starting_attachments = list(/obj/item/armor_module/armor/secondary_color/chest)

/obj/item/armor_module/armor/chest/marine/vsd_hardsuit/hephaestus
	name = "\improper 粉碎者超重型MT/41\"赫菲斯托斯\"胸甲"
	desc = "专为CrashCore MT/P外骨骼设计.附着时提供极佳的防护,代价是负重,并且相当容易从装甲上安装和拆卸.点击装甲框架以安装.这意味着只有更换胸甲才会产生显著的装甲差异.该装甲似乎被标记为\"赫菲斯托斯\"装甲部件."
	greyscale_config = /datum/greyscale_config/vsd_hardsuit/alt_two
	starting_attachments = list(/obj/item/armor_module/armor/secondary_color/chest)
