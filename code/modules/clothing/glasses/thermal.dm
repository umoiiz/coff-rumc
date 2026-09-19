/obj/item/clothing/glasses/thermal
	name = "光学热成像扫描仪"
	desc = "眼镜形状的热成像仪."
	icon_state = "thermal"
	worn_icon_state = "glasses"
	toggleable = TRUE
	vision_flags = SEE_MOBS // todo replace with tgs TRAIT_THERMAL_VISION
	lighting_cutoff = LIGHTING_CUTOFF_MEDIUM
	eye_protection = -1
	deactive_state = "goggles_off"

/obj/item/clothing/glasses/thermal/emp_act(severity)
	. = ..()
	if(ishuman(loc))
		var/mob/living/carbon/human/M = loc
		to_chat(M, span_warning("光学热成像扫描仪过载并致盲你!"))
		if(M.glasses == src)
			M.blind_eyes(3)
			M.blur_eyes(5)
			M.disabilities |= NEARSIGHTED
			spawn(100)
				M.disabilities &= ~NEARSIGHTED

/obj/item/clothing/glasses/thermal/yautja
	name = "生化面罩热成像"
	desc = "由生化面罩生成的视觉叠加层.用于感知猎物的热量."
	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "visor_thermal"
	worn_icon_state = "visor_thermal"
	worn_icon_list = list(
		slot_glasses_str = 'icons/mob/hunter/pred_gear.dmi'
	)

/obj/item/clothing/glasses/thermal/yautja/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

/obj/item/clothing/glasses/thermal/yautja/dropped(mob/living/carbon/human/user)
	if(istype(user) && user.glasses == src)
		user.clear_fullscreen("machine", 5)
	return ..()

/obj/item/clothing/glasses/thermal/yautja/equipped(mob/living/carbon/human/user, slot)
	if(slot == SLOT_GLASSES)
		user.overlay_fullscreen("machine", /atom/movable/screen/fullscreen/machine/pred)
	return ..()

/obj/item/clothing/glasses/thermal/yautja/unequipped(mob/living/carbon/human/user, slot)
	if(slot == SLOT_GLASSES)
		user.clear_fullscreen("machine", 5)
	return ..()
