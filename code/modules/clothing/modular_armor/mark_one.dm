//Old jaeger for old grogs
/obj/item/clothing/head/modular/marine/old
	name = "\improper Jaeger Mk.I型步兵头盔"
	desc = "通常与Jaeger战斗外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有步兵标识."
	icon_state = "helmet"
	worn_icon_state = "helmet"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)

	greyscale_config = /datum/greyscale_config/armor_mk1/infantry
	greyscale_colors = ARMOR_PALETTE_DRAB
	colorable_allowed = PRESET_COLORS_ALLOWED|HAIR_CONCEALING_CHANGE_ALLOWED
	colorable_allowed = PRESET_COLORS_ALLOWED


	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old, /obj/item/armor_module/storage/helmet)

/obj/item/clothing/head/modular/marine/old/open
	name = "\improper Jaeger Mk.I型步兵开放式头盔"
	desc = "通常与Jaeger战斗外骨骼搭配使用. 可在头盔挂载点上安装实用功能."
	starting_attachments = list(/obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/infantry/old
	visorless_offset_y = 0

/obj/item/clothing/head/modular/marine/old/eva
	name = "\improper Jaeger Mk.I型EVA头盔"
	desc = "通常与Jaeger战斗外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有EVA标识."
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old/eva, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/eva

/obj/item/clothing/head/modular/marine/old/eva/skull
	name = "\improper Jaeger Mk.I型EVA '骷髅'头盔"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old/eva/skull, /obj/item/armor_module/storage/helmet)

/obj/item/clothing/head/modular/marine/old/skirmisher
	name = "\improper Jaeger Mk.I型散兵头盔"
	desc = "通常与Jaeger战斗外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有散兵标识."
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old/skirmisher, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/skirmisher

/obj/item/clothing/head/modular/marine/old/scout
	name = "\improper Jaeger Mk.I型侦察兵头盔"
	desc = "通常与Jaeger战斗外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有侦察兵标识"
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old/scout, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/scout

/obj/item/clothing/head/modular/marine/old/assault
	name = "\improper Jaeger Mk.I型突击头盔"
	desc = "通常与Jaeger战斗外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有突击标识."
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old/assault, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1

/obj/item/clothing/head/modular/marine/old/eod
	name = "\improper Jaeger Mk.I型排爆头盔"
	desc = "通常与Jaeger战斗外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有排爆标识."
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/old/eod, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/eod

/obj/item/clothing/head/modular/marine/old/mjolnir
	name = "\improper Jaeger Mk.I型雷神之锤头盔"
	desc = "通常与Jaeger战斗外骨骼搭配使用. 可在头盔挂载点上安装实用功能. 带有雷神之锤标识."
	starting_attachments = list(/obj/item/armor_module/armor/visor/marine/mjolnir, /obj/item/armor_module/storage/helmet)
	greyscale_config = /datum/greyscale_config/armor_mk1/mjolnir
