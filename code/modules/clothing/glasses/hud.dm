/obj/item/clothing/glasses/hud
	name = "HUD"
	desc = "一种可提供(几乎)实时重要信息的平视显示器。"
	armor_protection_flags = NONE //doesn't protect eyes because it's a monocle, duh
	var/hud_type
	var/mob/living/carbon/human/affected_user

/obj/item/clothing/glasses/hud/examine_descriptor(mob/user)
	return "HUD"

/obj/item/clothing/glasses/hud/Destroy()
	if(affected_user)
		deactivate_hud()
	return ..()

/obj/item/clothing/glasses/hud/equipped(mob/user, slot)
	if(!ishuman(user))
		return ..()
	if(slot == SLOT_GLASSES)
		if(active)
			activate_hud(user)
	else if(affected_user)
		deactivate_hud()
	return ..()

/obj/item/clothing/glasses/hud/dropped(mob/user)
	if(affected_user)
		deactivate_hud()
	return ..()

/obj/item/clothing/glasses/hud/activate(mob/user)
	//Run the activation stuff BEFORE getting to the HUD de/activations
	. = ..()

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/hud_user = user
	if(hud_user.glasses != src)
		return

	if(active)
		activate_hud(hud_user)
	else
		deactivate_hud(hud_user)

///Activates the hud(s) these glasses have
/obj/item/clothing/glasses/hud/proc/activate_hud(mob/living/carbon/human/user)
	var/datum/atom_hud/hud_datum = GLOB.huds[hud_type]
	hud_datum.add_hud_to(user)
	affected_user = user

/obj/item/clothing/glasses/hud/proc/deactivate_hud()
	var/datum/atom_hud/hud_datum = GLOB.huds[hud_type]
	hud_datum.remove_hud_from(affected_user)
	affected_user = null

/obj/item/clothing/glasses/hud/health
	name = "\improper HealthMate HUD"
	desc = "一种平视显示器,可扫描视野内的人类并提供其健康状况的准确数据。投影仪可安装在兼容的眼镜上。"
	icon_state = "healthhud"
	deactive_state = "deactivated_med" // there are differences in mob sprite
	toggleable = TRUE
	hud_type = DATA_HUD_MEDICAL_ADVANCED
	species_exception = list(/datum/species/robot)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/glasses.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/glasses_bravada.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/glasses_charlit.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/glasses_alpharii.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/glasses_deltad.dmi')

/obj/item/clothing/glasses/hud/medgoggles
	name = "\improper HealthMate防弹护目镜"
	desc = "标准配发的TGMC护目镜。这副已装配内置HealthMate HUD投影仪。"
	icon_state = "medgoggles"
	worn_icon_state = "medgoggles"
	deactive_state = "deactivated_mgoggles"
	toggleable = TRUE
	hud_type = DATA_HUD_MEDICAL_ADVANCED
	species_exception = list(/datum/species/robot)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/glasses.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/glasses_bravada.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/glasses_charlit.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/glasses_alpharii.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/glasses_deltad.dmi')
	soft_armor = list(MELEE = 40, BULLET = 40, LASER = 0, ENERGY = 15, BOMB = 35, BIO = 10, FIRE = 30, ACID = 30)
	equip_slot_flags = ITEM_SLOT_EYES
	goggles_layer = TRUE

/obj/item/clothing/glasses/hud/medgoggles/prescription
	name = "\improper HealthMate处方防弹护目镜"
	desc = "标准配发的TGMC处方护目镜。这副已装配内置HealthMate HUD投影仪。"
	prescription = TRUE

/obj/item/clothing/glasses/hud/medpatch
	name = "\improper Medpatch HUD"
	desc = "一种平视显示器,可扫描视野内的人类并提供其健康状况的准确数据。专为残疾和/或叛逆的医护兵设计。"
	icon_state = "medpatchhud"
	deactive_state = "deactivated_patch"
	species_exception = list(/datum/species/robot)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/glasses.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/glasses_bravada.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/glasses_charlit.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/glasses_alpharii.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/glasses_deltad.dmi')
	toggleable = TRUE
	hud_type = DATA_HUD_MEDICAL_ADVANCED

/obj/item/clothing/glasses/hud/medglasses
	name = "\improper HealthMate制式处方眼镜"
	desc = "标准配发的TGMC制式处方眼镜。这副已装配内置HealthMate HUD投影仪。"
	icon_state = "medglasses"
	worn_icon_state = "medglasses"
	deactive_state = "deactivated_medglasses"
	species_exception = list(/datum/species/robot)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/glasses.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/glasses_bravada.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/glasses_charlit.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/glasses_alpharii.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/glasses_deltad.dmi')
	prescription = TRUE
	toggleable = TRUE
	hud_type = DATA_HUD_MEDICAL_ADVANCED

/obj/item/clothing/glasses/hud/medsunglasses
	name = "\improper HealthMate太阳镜"
	desc = "一副设计师太阳镜。这副已装配内置HealthMate HUD投影仪。"
	icon_state = "medsunglasses"
	worn_icon_state = "medsunglasses"
	deactive_state = "deactivated_sunglasses"
	species_exception = list(/datum/species/robot)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/glasses.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/glasses_bravada.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/glasses_charlit.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/glasses_alpharii.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/glasses_deltad.dmi')
	prescription = TRUE
	toggleable = TRUE
	hud_type = DATA_HUD_MEDICAL_ADVANCED

/obj/item/clothing/glasses/hud/security
	name = "\improper PatrolMate HUD"
	desc = "一种平视显示器,可扫描视野内的人类并提供其身份状态和安全记录的准确数据。"
	species_exception = list(/datum/species/robot)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/glasses.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/glasses_bravada.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/glasses_charlit.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/glasses_alpharii.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/glasses_deltad.dmi')
	icon_state = "securityhud"
	deactive_state = "deactivated_sec" // there are differences in mob sprite
	toggleable = TRUE

/obj/item/clothing/glasses/hud/xenohud
	name = "XenoMate HUD"
	desc = "一个可扫描附近任何异形数据的平视显示器."
	icon_state = "securityhud"
	deactive_state = "deactivated_sec" // there are differences in mob sprite
	species_exception = list(/datum/species/robot)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/glasses.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/glasses_bravada.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/glasses_charlit.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/glasses_alpharii.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/glasses_deltad.dmi')
	toggleable = TRUE
	hud_type = DATA_HUD_XENO_STATUS

/obj/item/clothing/glasses/hud/sa
	name = "空间特工的太阳镜"
	desc = "空间特工佩戴的眼镜."
	icon_state = "sun"
	worn_icon_state = "sunglasses"
	eye_protection = 2
	hud_type = list(DATA_HUD_MEDICAL_OBSERVER, DATA_HUD_XENO_STATUS, DATA_HUD_SQUAD_TERRAGOV, DATA_HUD_ORDER)
	lighting_cutoff = LIGHTING_CUTOFF_FULLBRIGHT
	activation_sound = null
	deactivation_sound = null

/obj/item/clothing/glasses/hud/sa/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/clothing_tint, TINT_NONE)

/obj/item/clothing/glasses/hud/sa/nodrop
	desc = "空间特工佩戴的眼镜.如果你把它们摘下来,它们就会自我删除!"
	item_flags = DELONDROP
