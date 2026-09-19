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
	to_chat(user, span_notice("你切换了[ visor_emissive_on ? "on" : "off" ] \the [src]的内部照明。"))
	update_icon()
	parent.update_icon()
	return COMPONENT_NO_ATTACK_HAND

/obj/item/armor_module/armor/visor/extra_examine(datum/source, mob/user)
	. = ..()
	if(!allow_emissive)
		return
	to_chat(user, "右键点击头盔以切换护目镜内部照明。")

/obj/item/armor_module/armor/visor/marine
	name = "\improper Jaeger型步兵护目镜"
	desc = "Jaeger模块化头盔的护目镜附件。此款专为步兵级头盔设计。"
	icon_state = "infantry_visor"

/obj/item/armor_module/armor/visor/marine/skirmisher
	name = "\improper Jaeger型散兵护目镜"
	desc = "Jaeger模块化头盔的护目镜附件。此款专为散兵级头盔设计。"
	icon_state = "skirmisher_visor"

/obj/item/armor_module/armor/visor/marine/scout
	name = "\improper Jaeger型侦察兵护目镜"
	desc = "Jaeger模块化头盔的护目镜附件。此款专为侦察兵级头盔设计。"
	icon_state = "scout_visor"

/obj/item/armor_module/armor/visor/marine/helljumper
	name = "\improper 猎兵型地狱伞兵护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为地狱伞兵级头盔设计."
	icon_state = "helljumper_visor"

/obj/item/armor_module/armor/visor/marine/ranger
	name = "\improper 猎兵型游骑兵护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为游骑兵级头盔设计."
	icon_state = "ranger_visor"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/traditional
	name = "\improper 猎兵型传统游骑兵护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为传统游骑兵级头盔设计."
	icon_state = "traditional_visor"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/trooper
	name = "\improper 猎兵型步兵护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为步兵级头盔设计."
	icon_state = "trooper_visor"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/mjolnir
	name = "\improper 猎兵型雷神护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为雷神级头盔设计."
	icon_state = "mjolnir_visor"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/mjolnir_open
	name = "\improper 猎兵型开放式雷神护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为雷神级头盔设计."
	icon_state = "mjolnir_open_visor"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/kabuto
	name = "\improper 风格型兜甲护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为兜甲级头盔设计."
	icon_state = "kabuto_visor"

/obj/item/armor_module/armor/visor/marine/hotaru
	name = "\improper 风格型萤火虫护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为萤火虫级头盔设计."
	icon_state = "hotaru_visor"

/obj/item/armor_module/armor/visor/marine/dashe
	name = "\improper 风格型冲角护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为冲角级头盔设计."
	icon_state = "dashe_visor"

/obj/item/armor_module/armor/visor/marine/eva
	name = "\improper 猎兵型EVA护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为EVA级头盔设计."
	icon_state = "eva_visor"

/obj/item/armor_module/armor/visor/marine/eva/skull
	name = "\improper 猎兵型EVA骷髅护目镜"
	icon_state = "eva_visor"
	attachments_by_slot = list(ATTACHMENT_SLOT_CAPE_HIGHLIGHT)
	attachments_allowed = list(/obj/item/armor_module/armor/visor_glyph)
	starting_attachments = list(/obj/item/armor_module/armor/visor_glyph)

/obj/item/armor_module/armor/visor/marine/assault
	name = "\improper 猎兵型突击护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为突击级头盔设计."
	icon_state = "assault_visor"

/obj/item/armor_module/armor/visor/marine/eod
	name = "\improper 猎兵型排爆护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为排爆级头盔设计."
	icon_state = "eod_visor"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/gungnir
	name = "\improper 猎兵型冈格尼尔护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为冈格尼尔级头盔设计."
	icon_state = "gugnir"
	greyscale_config = /datum/greyscale_config/visors/greyscale
	colorable_allowed = COLOR_WHEEL_ALLOWED
	greyscale_colors = LIGHT_COLOR_GREEN

//Robots
/obj/item/armor_module/armor/visor/marine/robot
	name = "\improper XN-1上部装甲板护目镜"
	desc = "XN-1上部装甲板的护目镜配件."
	icon_state = "r_medium"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/robot/light
	name = "\improper XN-1-L上部装甲板护目镜"
	desc = "XN-1-L上部装甲板的护目镜配件."
	icon_state = "r_light"

/obj/item/armor_module/armor/visor/marine/robot/heavy
	name = "\improper XN-1-H上部装甲板护目镜"
	desc = "XN-1-H上部装甲板的护目镜配件."
	icon_state = "r_heavy"


//Xenonaut
/obj/item/armor_module/armor/visor/marine/xenonaut
	name = "\improper 异星重装护目镜"
	desc = "异星重装头盔的护目镜配件"
	icon_state = "xenonaut"


//old jaeger
/obj/item/armor_module/armor/visor/marine/old
	name = "\improper 猎兵型步兵护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为步兵级头盔设计."
	icon_state = "infantry_visor_old"

/obj/item/armor_module/armor/visor/marine/old/skirmisher
	name = "\improper 猎兵型散兵护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为散兵级头盔设计."
	icon_state = "skirmisher_visor_old"

/obj/item/armor_module/armor/visor/marine/old/scout
	name = "\improper 猎兵型侦察护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为侦察级头盔设计."
	icon_state = "scout_visor_old"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/old/eva
	name = "\improper 猎兵型EVA护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为EVA级头盔设计."
	icon_state = "eva_visor_old"

/obj/item/armor_module/armor/visor/marine/old/eva/skull
	name = "\improper 猎兵型EVA骷髅护目镜"
	icon_state = "eva_visor_old"
	attachments_by_slot = list(ATTACHMENT_SLOT_CAPE_HIGHLIGHT)
	attachments_allowed = list(/obj/item/armor_module/armor/visor_glyph/old)
	starting_attachments = list(/obj/item/armor_module/armor/visor_glyph/old)

/obj/item/armor_module/armor/visor/marine/old/assault
	name = "\improper 猎兵型突击护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为突击级头盔设计."
	icon_state = "assault_visor_old"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/armor_module/armor/visor/marine/old/eod
	name = "\improper 型排爆护目镜"
	desc = "猎兵模块化头盔的护目镜配件. 这款专为排爆级头盔设计."
	icon_state = "eod_visor_old"
	colorable_allowed = COLOR_WHEEL_ALLOWED|PRESET_COLORS_ALLOWED

//Hardsuit Helmet Visors
/obj/item/armor_module/armor/visor/marine/fourvisor
	name = "\improper 斑点迷彩Mark V头盔护目镜"
	desc = "斑点迷彩WY-01系列模块化头盔的护目镜配件. 这款专为Mark V破门手级头盔设计."
	icon_state = "fourvisor_visor"

/obj/item/armor_module/armor/visor/marine/foureyevisor
	name = "\improper 斑点迷彩Mark III头盔护目镜"
	desc = "斑点迷彩WY-01系列模块化头盔的护目镜配件. 这款专为Mark III掠夺者级头盔设计."
	icon_state = "foureye_visor"

/obj/item/armor_module/armor/visor/marine/markonevisor
	name = "\improper 斑点迷彩Mark I头盔护目镜"
	desc = "斑点迷彩WY-01系列模块化头盔的护目镜配件. 这款专为Mark I突袭者级头盔设计."
	icon_state = "markone_visor"

//VSD hardsuit visor
/obj/item/armor_module/armor/visor/marine/phobos
	name = "\improper 粉碎者MT/41\"福波斯\"头盔护目镜"
	desc = "粉碎者MT/41系列模块化头盔的护目镜配件. 这款专为\"福波斯\"头盔设计."
	icon_state = "phobos_visor"

/obj/item/armor_module/armor/visor/marine/clementia
	name = "\improper 粉碎者MT/41\"克莱门提亚\"头盔护目镜"
	desc = "粉碎者MT/41系列模块化头盔的护目镜配件. 这款专为\"克莱门提亚\"头盔设计."
	icon_state = "clementia_visor"

/obj/item/armor_module/armor/visor/marine/hephaestus
	name = "\improper 粉碎者MT/41\"赫菲斯托斯\"头盔护目镜"
	desc = "粉碎者MT/41系列模块化头盔的护目镜配件. 这款专为\"赫菲斯托斯\"头盔设计."
	icon_state = "hephaestus_visor"
