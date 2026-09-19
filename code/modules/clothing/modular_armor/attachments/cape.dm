#define HIGHLIGHT_VARIANTS "highlight_variants"
#define HOOD "hood"

/obj/item/armor_module/armor/cape
	name = "6E变色斗篷"
	desc = "一款改进7E徽章设计的变色斗篷,这款斗篷支持两种颜色,满足你所有的时尚需求.它还配备了隔热层,因此可以兼作毯子使用."
	icon_state = "cape"
	slot = ATTACHMENT_SLOT_CAPE
	attachment_layer = CAPE_LAYER
	prefered_slot = SLOT_W_UNIFORM
	greyscale_config = /datum/greyscale_config/cape
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_SAME_ICON|ATTACH_APPLY_ON_MOB|ATTACH_ACTIVATION|ATTACH_NO_HANDS
	attach_delay = 0 SECONDS
	detach_delay = 0 SECONDS
	secondary_color = TRUE
	attachments_by_slot = list(ATTACHMENT_SLOT_CAPE_HIGHLIGHT)
	starting_attachments = list(/obj/item/armor_module/armor/cape_highlight)
	attachments_allowed = list(
		/obj/item/armor_module/armor/cape_highlight,
		/obj/item/armor_module/armor/cape_highlight/kama,
	)
	colorable_allowed = PRESET_COLORS_ALLOWED|ICON_STATE_VARIANTS_ALLOWED
	current_variant = "long"
	icon_state_variants = list(
		"long" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"long",
				"long_line",
				"long_skull",
				"long_arrow",
				"long_medic",
				"none",
			),
		),
		"regaly" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"regaly",
				"none",
			),
		),
		"onelong" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"onelong",
				"none",
			),
		),
		"scarf round" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list("none"),
		),
		"scarf tied" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list("none"),
		),
		"scarf" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"scarf",
				"none",
			),
		),
		"striped" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list("none"),
		),
		"geist" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list("none"),
		),
		"ghille" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list("none"),
		),
		"ghille (left)" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list("none"),
		),
		"ghille (right)" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list("none"),
		),
		"ghille (alt)" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list("none"),
		),
		"drifter" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list("none"),
		),
		"normal" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"normal",
				"normal (alt)",
				"none",
			),
		),
		"short" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"short",
				"none",
			),
		),
		"short (old)" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list("none"),
		),
		"shredded" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"shredded",
				"none",
			),
		),
		"half" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"half",
				"none",
			),
		),
		"full" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"full",
				"none",
			),
		),
		"back" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"back",
				"none",
			),
		),
		"cover" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"cover",
				"none",
			),
		),
		"cover (alt)" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"cover (alt)",
				"none",
			),
		),
		"shoal" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"shoal",
				"none",
			),
		),
		"shoal (back)" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"shoal (back)",
				"none",
			),
		),
		"shoal (alt)" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"shoal (alt)",
				"none",
			),
		),
		"rapier (right)" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"rapier (right)",
				"none",
			),
		),
		"rapier (left)" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"rapier (left)",
				"none",
			),
		),
		"overlord" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"overlord",
				"none",
			),
		),
		"overlord (alt)" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"overlord (alt)",
				"none",
			),
		),
		"overlord (altagain)" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"overlord (altagain)",
				"none",
			),
		),
		"star" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"star",
				"none",
			),
		),
		"jacket" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"jacket",
				"none",
			),
		),
		"sniper" = list(
			HOOD = TRUE,
			HIGHLIGHT_VARIANTS = list(
				"sniper",
				"none",
			),
		),
	)

	///True if the hood is up, false if not.
	var/hood = FALSE

/obj/item/armor_module/armor/cape/update_icon_state()
	. = ..()
	var/obj/item/armor_module/highlight = attachments_by_slot[ATTACHMENT_SLOT_CAPE_HIGHLIGHT]
	if(hood)
		icon_state = initial(icon_state) + "_[current_variant]_h"
		worn_icon_state = initial(worn_icon_state) + "_[current_variant]_h"
	else
		icon_state = initial(icon_state) + "_[current_variant]"
		worn_icon_state = initial(worn_icon_state) + "_[current_variant]"
	highlight?.update_icon()
	if(parent)
		parent.update_clothing_icon()

/obj/item/armor_module/armor/cape/activate(mob/living/user)
	. = ..()
	hood = !hood
	update_icon()
	update_greyscale()
	user.update_inv_w_uniform()


/obj/item/armor_module/armor/cape/examine(user)
	. = ..()
	. += span_notice("与<b>面部涂装</b>互动以着色或更改变体.")
	. += span_notice("可附着于<b>制服</b>.")


/obj/item/armor_module/armor/cape/color_item(obj/item/facepaint/paint, mob/user)
	var/old_variant = current_variant
	. = ..()
	if(old_variant == current_variant)
		return
	if(parent)
		UnregisterSignal(parent, COMSIG_ITEM_EQUIPPED)
	icon_state_variants[current_variant][HOOD] ? ENABLE_BITFIELD(attach_features_flags, ATTACH_ACTIVATION) : DISABLE_BITFIELD(attach_features_flags, ATTACH_ACTIVATION)
	if(CHECK_BITFIELD(attach_features_flags, ATTACH_ACTIVATION) && parent)
		RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(handle_actions))
	var/obj/item/armor_module/highlight = attachments_by_slot[ATTACHMENT_SLOT_CAPE_HIGHLIGHT]
	if(!icon_state_variants[current_variant][HOOD])
		hood = FALSE
		highlight?.icon_state = initial(highlight.icon_state) + "_[highlight.current_variant]"
		if(ishuman(parent?.loc))
			LAZYREMOVE(actions_types, /datum/action/item_action/toggle)
			var/datum/action/item_action/toggle/old_action = locate(/datum/action/item_action/toggle) in actions
			old_action?.remove_action(user)
			actions = null
	if(!icon_state_variants[old_variant][HOOD] && icon_state_variants[current_variant][HOOD] && ishuman(parent?.loc))
		LAZYADD(actions_types, /datum/action/item_action/toggle)
		var/datum/action/item_action/toggle/new_action = new(src)
		if(toggle_signal)
			new_action.keybinding_signals = list(KEYBINDING_NORMAL = toggle_signal)
		new_action.give_action(user)
	highlight.current_variant = length(icon_state_variants[current_variant][HIGHLIGHT_VARIANTS]) ? icon_state_variants[current_variant][HIGHLIGHT_VARIANTS][1] : "none"
	highlight.icon_state_variants = icon_state_variants[current_variant][HIGHLIGHT_VARIANTS]
	ENABLE_BITFIELD(highlight.colorable_allowed, PRESET_COLORS_ALLOWED)
	update_icon()
	update_greyscale()
	highlight.update_icon()
	highlight.update_greyscale()
	user.update_inv_w_uniform()

/obj/item/armor_module/armor/cape/kama
	name = "6E变色腰帘"
	desc = "一款改进7E徽章设计的变色腰帘,这款腰帘支持两种颜色,满足你所有的时尚需求.悬挂在腰带上,用于装饰下肢. \n 与面部涂装互动以着色.可附着于制服."
	slot = ATTACHMENT_SLOT_KAMA
	attachment_layer = KAMA_LAYER
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_SAME_ICON|ATTACH_APPLY_ON_MOB|ATTACH_NO_HANDS
	starting_attachments = list(/obj/item/armor_module/armor/cape_highlight/kama)
	greyscale_config = /datum/greyscale_config/cape
	icon_state_variants = list(
		"kama" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"kama",
			),
		),
		"kilt" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"kilt",
			),
		),
		"kilt (alt)" = list(
			HOOD = FALSE,
			HIGHLIGHT_VARIANTS = list(
				"kilt",
			),
		),
	)
	current_variant = "kama"


/obj/item/armor_module/armor/cape_highlight
	name = "斗篷高亮"
	desc = "一款改进7E徽章设计的斗篷,这款斗篷支持六种颜色,满足你所有的时尚需求.这款斗篷的变体功能更接近围巾. \n 与面部涂装互动以着色.可附着于制服.激活它以切换兜帽."
	icon_state = "highlight"
	slot = ATTACHMENT_SLOT_CAPE_HIGHLIGHT
	attach_features_flags = ATTACH_SAME_ICON|ATTACH_APPLY_ON_MOB|ATTACH_NO_HANDS
	colorable_allowed = PRESET_COLORS_ALLOWED|ICON_STATE_VARIANTS_ALLOWED|COLOR_WHEEL_ALLOWED
	greyscale_config = /datum/greyscale_config/cape_highlight
	secondary_color = TRUE
	item_map_variant_flags = NONE
	current_variant = "none"
	greyscale_colors = CAPE_PALETTE_GOLD
	colorable_colors = CAPE_PALETTES_LIST
	icon_state_variants = list(
		"long",
		"long_line",
		"long_skull",
		"long_arrow",
		"long_medic",
		"none",
	)

/obj/item/armor_module/armor/cape_highlight/update_icon_state()
	. = ..()
	if(!parent)
		return
	var/obj/item/armor_module/armor/cape/cape_parent = parent
	if(cape_parent.hood)
		icon_state = initial(icon_state) + "_[current_variant]_h"
	else
		icon_state = initial(icon_state) + "_[current_variant]"


/obj/item/armor_module/armor/cape_highlight/handle_color(datum/source, mob/user, list/obj/item/secondaries)
	if(current_variant == "none" && (length(icon_state_variants) == 1))
		return
	return ..()



/obj/item/armor_module/armor/cape_highlight/kama
	greyscale_config = /datum/greyscale_config/cape_highlight
	colorable_allowed = PRESET_COLORS_ALLOWED
	current_variant = "kama"
	icon_state_variants = list()
