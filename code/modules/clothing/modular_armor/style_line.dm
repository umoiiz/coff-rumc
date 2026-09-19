// ***************************************
// *********** Modular Style Line
// ***************************************
/obj/item/clothing/suit/modular/style
	name = "\improper 潮服"
	desc = "他们穿得可真潮."
	item_map_variant_flags = NONE
	allowed_uniform_type = /obj/item/clothing/under
	icon = 'icons/obj/clothing/suits/marine_suits.dmi'
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/marine_suits.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)

	var/codex_info = {"<BR>This item is part of the <b>Style Line.</b><BR>
	<BR>The <b>Style Line</b> is a line of equipment designed to provide as much style as possible without compromising the user's protection.
	This line of equipment accepts <b>Equalizer modules</b>, which allow the user to alter any given piece of equipment's protection according to their preferences.<BR>"}

/obj/item/clothing/suit/modular/style/generate_attachments_allowed()
	attachments_allowed = general_list_of_marine_modules.Copy()
	attachments_allowed += list(
		/obj/item/armor_module/module/style/light_armor,
		/obj/item/armor_module/module/style/medium_armor,
		/obj/item/armor_module/module/style/heavy_armor,
	)

/obj/item/clothing/suit/modular/style/get_mechanics_info()
	. = ..()
	. += jointext(codex_info, "<br>")

/obj/item/clothing/suit/modular/style/leather_jacket
	name = "\improper 皮夹克"
	desc = "一件时尚的夹克.用风格击败他们."
	icon_state = "leather_jacket"
	worn_icon_state = "leather_jacket_worn"
	icon_state_variants = list(
		"normal",
		"webbing",
	)
	current_variant = "normal"
	greyscale_colors = ARMOR_PALETTE_BLACK
	greyscale_config = /datum/greyscale_config/duster/leather_jacket
	colorable_colors = ARMOR_PALETTES_LIST
	colorable_allowed = ICON_STATE_VARIANTS_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/clothing/suit/modular/style/duster
	name = "\improper 风衣"
	desc = "一件轻便、宽松的可染色长外套,适合那些想要更有风格的人."
	icon_state = "duster"
	worn_icon_state = "duster_worn"
	greyscale_colors = ARMOR_PALETTE_BLACK
	greyscale_config = /datum/greyscale_config/duster
	colorable_colors = ARMOR_PALETTES_LIST
	colorable_allowed = PRESET_COLORS_ALLOWED

/obj/item/clothing/suit/modular/style/Alpha_greatcoat
	name = "\improper 阿尔法大衣"
	desc = "一件旧大衣,不清楚它怎么还没完全撕裂.."
	icon_state = "Alpha_greatcoat"
	worn_icon_state = "Alpha_greatcoat_worn"

/obj/item/clothing/suit/modular/style/Delta_greatcoat
	name = "\improper 德尔塔大衣"
	desc = "一件旧大衣,不清楚它怎么还没完全撕裂.."
	icon_state = "Delta_greatcoat"
	worn_icon_state = "Delta_greatcoat_worn"

/obj/item/clothing/suit/modular/style/Bravo_greatcoat
	name = "\improper 布拉沃大衣"
	desc = "一件旧大衣,不清楚它怎么还没完全撕裂.."
	icon_state = "Bravo_greatcoat"
	worn_icon_state = "Bravo_greatcoat_worn"

/obj/item/clothing/suit/modular/style/Charlie_greatcoat
	name = "\improper 查理大衣"
	desc = "一件旧大衣,不清楚它怎么还没完全撕裂.."
	icon_state = "Charlie_greatcoat"
	worn_icon_state = "Charlie_greatcoat_worn"

// ***************************************
//  Modular hats
/obj/item/clothing/head/modular/style
	name = "\improper 好帽子"
	desc = "好帽子,兄弟.你是怎么找到这个的?"
	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT
	attachments_allowed = list(
		/obj/item/armor_module/armor/badge,
		/obj/item/armor_module/storage/helmet,
		/obj/item/armor_module/armor/stylehat_badge,
		/obj/item/armor_module/armor/stylehat_badge/classic,
		/obj/item/armor_module/armor/stylehat_badge/ushanka,
	)
	attachments_by_slot = list(
		ATTACHMENT_SLOT_VISOR,
		ATTACHMENT_SLOT_STORAGE,
		ATTACHMENT_SLOT_HEAD_MODULE,
		ATTACHMENT_SLOT_BADGE,
		ATTACHMENT_SLOT_CAPE_HIGHLIGHT,
	)

	greyscale_config = /datum/greyscale_config/style_hat
	colorable_allowed = PRESET_COLORS_ALLOWED

	visorless_offset_y = 0

	inv_hide_flags = NONE

	soft_armor = MARINE_ARMOR_HEAVY
	starting_attachments = list(/obj/item/armor_module/storage/helmet)



//marine hats
/obj/item/clothing/head/modular/style/beret
	name = "TGMC贝雷帽"
	desc = "TGMC使用的帽子,通常被认为是最具标志性的军用头饰.通常留给高级军官,但偶尔也会流传到军衔较低的小队队长和受勋老兵手中."
	icon_state = "beret_inhand"
	worn_icon_state = "beret"
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/stylehat_badge)
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/modular/style/classic_beret
	name = "TGMC贝雷帽(经典)"
	desc = "TGMC使用的帽子,通常被认为是最具标志性的军用头饰.通常留给高级军官,但偶尔也会流传到军衔较低的小队队长和受勋老兵手中.这顶是经典款式."
	icon_state = "classic_beret_inhand"
	worn_icon_state = "classic_beret"
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/stylehat_badge/classic)
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/modular/style/boonie
	name = "TGMC奔尼帽"
	desc = "TGMC使用的奔尼帽,专为在阳光充足或植被茂密的环境中作战而设计."
	icon_state = "boonie_inhand"
	worn_icon_state = "boonie"
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/modular/style/cap
	name = "TGMC巡逻帽"
	desc = "TGMC使用的常见巡逻帽,时尚且有多种颜色.主要用于遮挡阳光和避开军官."
	icon_state = "cap_inhand"
	worn_icon_state = "cap"
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/modular/style/slouchhat
	name = "TGMC垂边帽"
	desc = "一顶垂边帽,让你感觉身处澳洲内陆,对吧?帽子下方有\"TGMC财产\"标记."
	icon_state = "slouch_inhand"
	worn_icon_state = "slouch"
	species_exception = list(/datum/species/robot)


/obj/item/clothing/head/modular/style/ushanka
	name = "TGMC护耳冬帽"
	desc = "TGMC使用的舒适护耳冬帽.即使在最严酷的极地环境中也能让你保持温暖."
	icon_state = "ushanka_inhand"
	worn_icon_state = "ushanka"
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/stylehat_badge/ushanka)
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/modular/style/campaignhat
	name = "TGMC战役帽"
	desc = "一顶战役帽,光是看着它就能感受到它散发出的威压气场."
	icon_state = "campaign_inhand"
	worn_icon_state = "campaign"
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/modular/style/beanie
	name = "TGMC毛线帽"
	desc = "一顶毛线帽,光是看着它就让你感觉自己像个\"乌萨马\",或者更准确地说--一种现代现象,人们一戴上毛线帽就突然需要去卧推."
	icon_state = "beanie_inhand"
	worn_icon_state = "beanie"
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/modular/style/headband
	name = "TGMC头带"
	desc = "一条头带.能挡住汗水不流进眼睛,还能让你看起来很酷."
	icon_state = "headband_inhand"
	worn_icon_state = "headband"
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/modular/style/bandana
	name = "TGMC头巾"
	desc = "一条戴在头上的头巾.后侧系带上有TGMC标记,而且不知为何这个结似乎永远不会松开."
	icon_state = "headbandana_inhand"
	worn_icon_state = "headbandana"
	species_exception = list(/datum/species/robot)

// style masks
/obj/item/clothing/mask/gas/modular/skimask
	name = "滑雪面罩"
	desc = "一个时尚的滑雪面罩,可以重新染色.光是看着它就让你感觉自己像个特战队员."
	icon_state = "ski_inhand"
	worn_icon_state = "ski"
	inv_hide_flags = HIDEALLHAIR|HIDEEARS
	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT
	greyscale_config = /datum/greyscale_config/style_hat


/obj/item/clothing/mask/gas/modular/coofmask
	name = "战斗面罩"
	desc = "CFCC是一款精良且现成的、又不失时尚的面罩,随时准备...遮住你的脸."
	icon_state = "coof_inhand"
	worn_icon_state = "coof"
	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT
	greyscale_config = /datum/greyscale_config/style_hat
