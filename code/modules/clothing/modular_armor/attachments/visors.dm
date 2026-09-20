/**
 *  Visors
 *  Visors are slightly different than the other armor types. They allow emissives. If visor_emissive_on is TRUE then it will be applying an emissve to it.
 * 	If allow_emissive is TRUE, Right clicking the Parent item will toggle the emissive.
*/

/obj/item/armor_module/armor/visor
	name = "标准护目镜"
	icon_state = "visor"
	slot = ATTACHMENT_SLOT_VISOR
	attach_features_flags = ATTACH_SAME_ICON|ATTACH_APPLY_ON_MOB
	greyscale_config = /datum/greyscale_config/visors
	greyscale_colors = VISOR_PALETTE_GOLD
	colorable_colors = VISOR_PALETTES_LIST
	secondary_color = TRUE
	item_map_variant_flags = NONE

	///whether this helmet should be using its emissive overlay or not
	var/visor_emissive_on = TRUE
	///Whether or not the helmet is allowed to turn its emissive on or off.
	var/allow_emissive = TRUE

/obj/item/armor_module/armor/visor/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND_ALTERNATE, PROC_REF(toggle_emissive))
	if(visor_emissive_on)
		parent.AddElement(/datum/element/special_clothing_overlay/modular_helmet_visor, HEAD_LAYER, icon_state, icon)
	update_icon()

/obj/item/armor_module/armor/visor/on_detach(obj/item/detaching_from, mob/user)
	UnregisterSignal(parent, COMSIG_ATOM_ATTACK_HAND_ALTERNATE)
	parent.RemoveElement(/datum/element/special_clothing_overlay/modular_helmet_visor, HEAD_LAYER, icon_state, icon)
	update_icon()
	return ..()

///Toggles the visors emmisiveness if allowed.
/obj/item/armor_module/armor/visor/proc/toggle_emissive(datum/source, mob/living/user)
	SIGNAL_HANDLER
	if(!allow_emissive|| (parent && user.get_inactive_held_item() != parent) || (!parent && user.get_inactive_held_item() != src))
		return
	visor_emissive_on = !visor_emissive_on
	if(visor_emissive_on)
		parent?.AddElement(/datum/element/special_clothing_overlay/modular_helmet_visor, HEAD_LAYER, icon_state, icon)
	else
		parent?.RemoveElement(/datum/element/special_clothing_overlay/modular_helmet_visor, HEAD_LAYER, icon_state, icon)
	to_chat(user, span_notice("你[ visor_emissive_on ? "on" : "off" ]\the [src]了头盔的内部照明。"))
	update_icon()
	parent.update_icon()
	return COMPONENT_NO_ATTACK_HAND

/obj/item/armor_module/armor/visor/extra_examine(datum/source, mob/user)
	. = ..()
	if(!allow_emissive)
		return
	to_chat(user, "右键点击头盔以切换护目镜的内部照明。")

/obj/item/armor_module/armor/visor/marine
	name = "\improper Jaeger型步兵护目镜"
	desc = "Jaeger模块化头盔的护目镜配件。此款专为步兵级头盔设计。"
	icon_state = "infantry_visor"

/obj/item/armor_module/armor/visor/marine/skirmisher
	name = "\improper Jaeger型散兵护目镜"
	desc = "Jaeger模块化头盔的护目镜配件。此款专为散兵级头盔设计。"
	icon_state = "skirmisher_visor"

/obj/item/armor_module/armor/visor/marine/scout
	name = "\improper Jaeger型侦察兵护目镜"
	desc = "Jaeger模块化头盔的护目镜配件。此款专为侦察兵级头盔设计。"
	icon_state = "scout_visor"

/obj/item/armor_module/armor/visor/marine/helljumper
	name = "\improper Jaeger型地狱伞兵护目镜"
	desc = "Jaeger模块化头盔的护目镜配件。此款专为地狱伞兵级头盔设计。"
	icon_state = "helljumper_visor"

/obj/item/armor_module/armor/visor/marine/ranger
	name = "\improper Jaeger型游骑兵护目镜"
	desc = "Jaeger模块化头盔的护目镜配件。此款专为游骑兵级头盔设计。"
	icon_state = "ranger_visor"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/traditional
	name = "\improper Jaeger型传统游骑兵护目镜"
	desc = "Jaeger模块化头盔的护目镜配件。此款专为传统游骑兵级头盔设计。"
	icon_state = "traditional_visor"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/trooper
	name = "\improper Jaeger型士兵护目镜"
	desc = "Jaeger模块化头盔的护目镜配件。此款专为士兵级头盔设计。"
	icon_state = "trooper_visor"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/mjolnir
	name = "\improper Jaeger型雷神护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为 Mjolnir 级头盔设计."
	icon_state = "mjolnir_visor"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/mjolnir_open
	name = "\improper Jaeger 式开放式 Mjolnir 护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为 Mjolnir 级头盔设计."
	icon_state = "mjolnir_open_visor"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/kabuto
	name = "\improper Style 式 Kabuto 护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为 Kabuto 级头盔设计."
	icon_state = "kabuto_visor"

/obj/item/armor_module/armor/visor/marine/hotaru
	name = "\improper Style 式 Hotaru 护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为 Hotaru 级头盔设计."
	icon_state = "hotaru_visor"

/obj/item/armor_module/armor/visor/marine/dashe
	name = "\improper Style 式 Dashe 护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为 Dashe 级头盔设计."
	icon_state = "dashe_visor"

/obj/item/armor_module/armor/visor/marine/eva
	name = "\improper Jaeger 式 EVA 护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为 EVA 级头盔设计."
	icon_state = "eva_visor"

/obj/item/armor_module/armor/visor/marine/eva/skull
	name = "\improper Jaeger 式 EVA 骷髅护目镜"
	icon_state = "eva_visor"
	attachments_by_slot = list(ATTACHMENT_SLOT_CAPE_HIGHLIGHT)
	attachments_allowed = list(/obj/item/armor_module/armor/visor_glyph)
	starting_attachments = list(/obj/item/armor_module/armor/visor_glyph)

/obj/item/armor_module/armor/visor/marine/assault
	name = "\improper Jaeger 式突击护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为突击级头盔设计."
	icon_state = "assault_visor"

/obj/item/armor_module/armor/visor/marine/eod
	name = "\improper Jaeger 式 EOD 护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为 EOD 级头盔设计."
	icon_state = "eod_visor"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/gungnir
	name = "\improper Jaeger 式 Gungnir 护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为 Gungnir 级头盔设计."
	icon_state = "gugnir"
	greyscale_config = /datum/greyscale_config/visors/greyscale
	colorable_allowed = COLOR_WHEEL_ALLOWED
	greyscale_colors = LIGHT_COLOR_GREEN

//Robots
/obj/item/armor_module/armor/visor/marine/robot
	name = "\improper XN-1 上部装甲板护目镜"
	desc = "XN-1 上部装甲板的护目镜附件."
	icon_state = "r_medium"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/robot/light
	name = "\improper XN-1-L 上部装甲板护目镜"
	desc = "XN-1-L 上部装甲板的护目镜附件."
	icon_state = "r_light"

/obj/item/armor_module/armor/visor/marine/robot/heavy
	name = "\improper XN-1-H 上部装甲板护目镜"
	desc = "XN-1-H 上部装甲板的护目镜附件."
	icon_state = "r_heavy"


//Xenonaut
/obj/item/armor_module/armor/visor/marine/xenonaut
	name = "\improper Xenonaut 重型护目镜"
	desc = "Xenonaut 重型头盔的护目镜附件"
	icon_state = "xenonaut"


//old jaeger
/obj/item/armor_module/armor/visor/marine/old
	name = "\improper Jaeger 式步兵护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为步兵级头盔设计."
	icon_state = "infantry_visor_old"

/obj/item/armor_module/armor/visor/marine/old/skirmisher
	name = "\improper Jaeger 式散兵护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为散兵级头盔设计."
	icon_state = "skirmisher_visor_old"

/obj/item/armor_module/armor/visor/marine/old/scout
	name = "\improper Jaeger 式侦察兵护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为侦察兵级头盔设计."
	icon_state = "scout_visor_old"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/old/eva
	name = "\improper Jaeger 式 EVA 护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为 EVA 级头盔设计."
	icon_state = "eva_visor_old"

/obj/item/armor_module/armor/visor/marine/old/eva/skull
	name = "\improper Jaeger 式 EVA 骷髅护目镜"
	icon_state = "eva_visor_old"
	attachments_by_slot = list(ATTACHMENT_SLOT_CAPE_HIGHLIGHT)
	attachments_allowed = list(/obj/item/armor_module/armor/visor_glyph/old)
	starting_attachments = list(/obj/item/armor_module/armor/visor_glyph/old)

/obj/item/armor_module/armor/visor/marine/old/assault
	name = "\improper Jaeger 式突击护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为突击级头盔设计."
	icon_state = "assault_visor_old"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/old/eod
	name = "\improper EOD 式护目镜"
	desc = "Jaeger 模块化头盔的护目镜附件. 这款专为 EOD 级头盔设计."
	icon_state = "eod_visor_old"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

//Hardsuit Helmet Visors
/obj/item/armor_module/armor/visor/marine/fourvisor
	name = "\improper FleckTex Mark V 头盔护目镜"
	desc = "FleckTex WY-01 系列模块化头盔的护目镜附件. 这款专为 Mark V 破门手级头盔设计."
	icon_state = "fourvisor_visor"

/obj/item/armor_module/armor/visor/marine/foureyevisor
	name = "\improper FleckTex Mark III 头盔护目镜"
	desc = "FleckTex WY-01 系列模块化头盔的护目镜附件. 这款专为 Mark III 掠夺者级头盔设计."
	icon_state = "foureye_visor"

/obj/item/armor_module/armor/visor/marine/markonevisor
	name = "\improper FleckTex Mark I 头盔护目镜"
	desc = "FleckTex WY-01 系列模块化头盔的护目镜附件. 这款专为 Mark I 袭击者级头盔设计."
	icon_state = "markone_visor"

//VSD hardsuit visor
/obj/item/armor_module/armor/visor/marine/phobos
	name = "\improper Crasher MT/41 'Phobos' 头盔护目镜"
	desc = "Crasher MT/41 系列模块化头盔的护目镜附件. 这款专为 'Phobos' 头盔设计."
	icon_state = "phobos_visor"

/obj/item/armor_module/armor/visor/marine/clementia
	name = "\improper Crasher MT/41 'Clementia' 头盔护目镜"
	desc = "Crasher MT/41 系列模块化头盔的护目镜附件. 这款专为 'Clementia' 头盔设计."
	icon_state = "clementia_visor"

/obj/item/armor_module/armor/visor/marine/hephaestus
	name = "\improper Crasher MT/41 'Hephaestus' 头盔护目镜"
	desc = "Crasher MT/41 系列模块化头盔的护目镜附件. 这款专为 'Hephaestus' 头盔设计."
	icon_state = "hephaestus_visor"
