//Procedures in this file: Fracture repair surgery
//////////////////////////////////////////////////////////////////
//						BONE SURGERY							//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/bone
	var/bone_step

/datum/surgery_step/bone/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(affected.surgery_open_stage >= 2 && !(affected.limb_status & LIMB_DESTROYED) && affected.bone_repair_stage == bone_step && !(affected.limb_status & LIMB_REPAIRED))
		return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE


/datum/surgery_step/bone/glue_bone
	allowed_tools = list(
		/obj/item/tool/surgery/bonegel = 100,
		/obj/item/tool/screwdriver = 75,
	)
	can_infect = 1
	blood_level = 1

	min_duration = BONEGEL_REPAIR_MIN_DURATION
	max_duration = BONEGEL_REPAIR_MAX_DURATION
	bone_step = 0

	preop_sound = 'sound/misc/surgery/clothingrustle1.ogg'
	success_sound = 'sound/misc/surgery/bandage.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/bone/glue_bone/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]为[target]的[affected.display_name]中受损的骨头敷药.") , \
	span_notice("你开始用\the [tool]为[target]的[affected.display_name]中受损的骨头敷药."))
	target.balloon_alert_to_viewers("正在涂抹凝胶...")
	target.custom_pain("Something in your [affected.display_name] is causing you a lot of pain!", 1)
	..()

/datum/surgery_step/bone/glue_bone/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]将一些[tool]涂到[target]位于[affected.display_name]的骨头上."), \
	span_notice("你用\the [tool]将一些[tool]涂到[target]位于[affected.display_name]的骨头上."))
	target.balloon_alert_to_viewers("成功")
	affected.bone_repair_stage = 1
	return ..()

/datum/surgery_step/bone/glue_bone/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手滑了,把[tool]抹进了[target]的[affected.display_name]的切口里!") , \
	span_warning("你的手滑了,把[tool]抹进了[target]的[affected.display_name]的切口里!"))
	target.balloon_alert_to_viewers("滑脱了!")


/datum/surgery_step/bone/set_bone
	allowed_tools = list(
		/obj/item/tool/surgery/bonesetter = 100,
		/obj/item/tool/wrench = 75,
	)

	min_duration = BONESETTER_MIN_DURATION
	max_duration = BONESETTER_MAX_DURATION
	bone_step = 1

	preop_sound = 'sound/misc/surgery/hemostat1.ogg'
	success_sound = 'sound/effects/bone_break6.ogg'
	failure_sound = 'sound/effects/bone_break1.ogg'


/datum/surgery_step/bone/set_bone/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(affected.body_part == HEAD)
		user.visible_message(span_notice("[user]开始用\the [tool]拼合[target]的头骨.")  , \
		span_notice("你开始用\the [tool]拼合[target]的头骨."))
	else
		user.visible_message(span_notice("[user] 正开始用 \the [tool] 将 [target] 的 [affected.display_name] 中的骨头复位。") , \
		span_notice("你正开始用 \the [tool] 将 [target] 的 [affected.display_name] 中的骨头复位。"))
		target.custom_pain("The pain in your [affected.display_name] is going to make you pass out!", 1)
	target.balloon_alert_to_viewers("固定中...")
	..()

/datum/surgery_step/bone/set_bone/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(affected.body_part == HEAD)
		user.visible_message(span_notice("[user] 用 \the [tool] 固定 [target] 的颅骨。") , \
		span_notice("你用 \the [tool] 固定 [target] 的颅骨。"))
	else
		user.visible_message(span_notice("[user] 用 \the [tool] 将 [target] 的 [affected.display_name] 中的骨头复位。"), \
		span_notice("你用 \the [tool] 将 [target] 的 [affected.display_name] 中的骨头复位。"))
	target.balloon_alert_to_viewers("成功")
	affected.remove_limb_flags(LIMB_BROKEN | LIMB_SPLINTED | LIMB_STABILIZED)
	affected.add_limb_flags(LIMB_REPAIRED)
	affected.bone_repair_stage = 0
	return ..()

/datum/surgery_step/bone/set_bone/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	target.balloon_alert_to_viewers("失手了!")
	if(affected.body_part == HEAD)
		user.visible_message(span_warning("[user] 的手滑了, 用 \the [tool] 损伤了 [target] 的脸!")  , \
		span_warning("你的手滑了, 用 \the [tool] 损伤了 [target] 的脸!"))
		var/datum/limb/head/h = affected
		h.createwound(BRUISE, 10)
		h.disfigured = 1
		h.owner.name = h.owner.get_visible_name()
		h.update_wounds()
	else
		user.visible_message(span_warning("[user] 的手滑了, 用 \the [tool] 损伤了 [target] 的 [affected.display_name] 中的骨头!") , \
		span_warning("你的手滑了, 用 \the [tool] 损伤了 [target] 的 [affected.display_name] 中的骨头!"))
		affected.createwound(BRUISE, 5)
		affected.update_wounds()
