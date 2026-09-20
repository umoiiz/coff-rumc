//Procedures in this file: Inernal wound patching, Implant removal.
//////////////////////////////////////////////////////////////////
//					INTERNAL WOUND PATCHING						//
//////////////////////////////////////////////////////////////////


/datum/surgery_step/fix_vein
	allowed_tools = list(
		/obj/item/tool/surgery/FixOVein = 100,
		/obj/item/stack/cable_coil = 75,
	)
	can_infect = 1
	blood_level = 1

	min_duration = FIXVEIN_MIN_DURATION
	max_duration = FIXVEIN_MAX_DURATION

	preop_sound = 'sound/misc/surgery/organ1.ogg'
	success_sound = 'sound/misc/surgery/clothingrustle1.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/fix_vein/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(affected.surgery_open_stage >= 2)
		if(locate(/datum/wound/internal_bleeding) in affected.wounds)
			return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE

/datum/surgery_step/fix_vein/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]修补[target]的[affected.display_name]中受损的血管.") , \
	span_notice("你开始用\the [tool]修补[target]的[affected.display_name]中受损的血管."))
	target.custom_pain("The pain in [affected.display_name] is unbearable!",1)
	target.balloon_alert_to_viewers("修复中...")
	..()

/datum/surgery_step/fix_vein/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]已经用\the [tool]修补了[target]的[affected.display_name]中受损的血管."), \
		span_notice("你已经用\the [tool]修补了[target]的[affected.display_name]中受损的血管."))
	target.balloon_alert_to_viewers("成功")

	QDEL_LIST(affected.wounds)
	if(ishuman(user) && prob(40))
		user:bloody_hands(target, 0)
	return ..()

/datum/surgery_step/fix_vein/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手滑了,将[tool]涂抹在了[target]的[affected.display_name]切口中!") , \
	span_warning("你的手滑了,将[tool]涂抹在了[target]的[affected.display_name]切口中!"))
	target.balloon_alert_to_viewers("滑脱了!")
	affected.take_damage_limb(5, 0)
	target.update_health()
