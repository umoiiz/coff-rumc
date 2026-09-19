


/datum/surgery_step/cut_limb
	can_infect = 1
	allowed_tools = list(
		/obj/item/tool/surgery/circular_saw = 100,
		/obj/item/tool/hatchet = 75,
		/obj/item/weapon/sword = 75,
	)

	min_duration = 90
	max_duration = 110

	preop_sound = 'sound/misc/surgery/saw.ogg'
	success_sound = 'sound/misc/surgery/organ1.ogg'
	failure_sound = 'sound/effects/bone_break6.ogg'

/datum/surgery_step/cut_limb/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(!affected)
		return SURGERY_CANNOT_USE
	if(affected.limb_status & LIMB_DESTROYED) //already missing
		return SURGERY_CANNOT_USE
	if(affected.surgery_open_stage) //avoids conflict with sawing skull open
		return SURGERY_CANNOT_USE
	if(target_zone == "chest" || target_zone == "groin" || target_zone == "head") //can't amputate the chest
		return SURGERY_CANNOT_USE
	return SURGERY_CAN_USE

/datum/surgery_step/cut_limb/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]正开始用\the [tool]切断[target]的[affected.display_name].") , \
	span_notice("你正开始用\the [tool]切断[target]的[affected.display_name]."))
	target.balloon_alert_to_viewers("锯切中...")
	target.custom_pain("Your [affected.display_name] is being ripped apart!", 1)
	return ..()

/datum/surgery_step/cut_limb/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]切断了[target]的[affected.display_name]."), \
	span_notice("你用\the [tool]切断了[target]的[affected.display_name]."))
	target.balloon_alert_to_viewers("成功")
	affected.drop_limb(TRUE, silent = TRUE)
	target.update_health()
	return ..()

/datum/surgery_step/generic/cut_limb/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手一滑, 用\the [tool]锯穿了[target]的[affected.display_name]中的骨头!"), \
	span_warning("你的手一滑, 用\the [tool]锯穿了[target]的[affected.display_name]中的骨头!"))
	target.balloon_alert_to_viewers("失手!")
	affected.createwound(CUT, 30)
	affected.fracture()
	affected.update_wounds()
