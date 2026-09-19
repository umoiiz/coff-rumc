/obj/item/clothing/glasses/meson
	name = "光学介子扫描仪"
	desc = "用于保护使用者的眼睛免受有害电磁辐射,也可用作普通安全护目镜.不足以作为焊接防护."
	icon_state = "meson"
	worn_icon_state = "meson"
	deactive_state = "deactivated_meson" // there are differences in mob sprite
	species_exception = list(/datum/species/robot)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/glasses.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/glasses_bravada.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/glasses_charlit.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/glasses_alpharii.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/glasses_deltad.dmi')
	toggleable = TRUE
	vision_flags = SEE_TURFS // todo replace with tgs TRAIT_MESON_VISION
	lighting_cutoff = LIGHTING_CUTOFF_REAL_LOW
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/meson/enggoggles
	name = "\improper 光学介子防弹护目镜"
	desc = "标准配发的TGMC护目镜.这副护目镜内置了光学介子扫描仪."
	icon_state = "enggoggles"
	worn_icon_state = "enggoggles"
	deactive_state = "deactivated_mgoggles"
	goggles_layer = TRUE

/obj/item/clothing/glasses/meson/enggoggles/prescription
	name = "\improper 光学介子处方防弹护目镜"
	desc = "标准配发的TGMC处方护目镜.这副护目镜内置了光学介子扫描仪."
	prescription = TRUE

/obj/item/clothing/glasses/meson/eyepatch
	name = "\improper 介子眼罩"
	desc = "装有介子扫描仪接口的眼罩.专为残疾和/或前卫的工程师设计."
	icon_state = "patchmeson"
	deactive_state = "deactivated_patch"

/obj/item/clothing/glasses/meson/sunglasses
	name = "\improper 介子太阳镜"
	desc = "一副设计师太阳镜.这副眼镜内置了光学介子扫描仪."
	icon_state = "mesonsunglasses"
	worn_icon_state = "mesonsunglasses"
	deactive_state = "deactivated_sunglasses"

/obj/item/clothing/glasses/meson/yautja
	name = "生化面罩X光"
	desc = "由生化面罩生成的视觉叠加层.用于透视物体."
	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "visor_meson"
	worn_icon_state = "visor_meson"
	worn_icon_list = list(
		slot_glasses_str = 'icons/mob/hunter/pred_gear.dmi'
	)
	lighting_cutoff = LIGHTING_CUTOFF_HIGH
	actions_types = null

/obj/item/clothing/glasses/meson/yautja/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

/obj/item/clothing/glasses/meson/yautja/dropped(mob/living/carbon/human/user)
	if(istype(user) && user.glasses == src)
		user.clear_fullscreen("pred_meson", 5)
	..()

/obj/item/clothing/glasses/meson/yautja/equipped(mob/living/carbon/human/user, slot)
	if(slot == SLOT_GLASSES)
		user.overlay_fullscreen("pred_meson", /atom/movable/screen/fullscreen/machine/pred/meson)
	..()

/obj/item/clothing/glasses/meson/yautja/unequipped(mob/living/carbon/human/user, slot)
	if(slot == SLOT_GLASSES)
		user.clear_fullscreen("pred_meson", 5)
	..()
