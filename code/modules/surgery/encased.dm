//Procedures in this file: Generic ribcage opening steps, antifat
//////////////////////////////////////////////////////////////////
//				GENERIC	RIBCAGE SURGERY							//
//////////////////////////////////////////////////////////////////
/datum/surgery_step/open_encased
	priority = 1
	can_infect = 1
	blood_level = 1
	var/open_case_step

/datum/surgery_step/open_encased/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(affected.encased && affected.surgery_open_stage == open_case_step)
		return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE


/datum/surgery_step/open_encased/saw
	allowed_tools = list(
		/obj/item/tool/surgery/circular_saw = 100,
		/obj/item/tool/hatchet = 75,
	)

	min_duration = SAW_OPEN_ENCASED_MIN_DURATION
	max_duration = SAW_OPEN_ENCASED_MAX_DURATION
	open_case_step = 2

	preop_sound = 'sound/misc/surgery/saw.ogg'
	success_sound = 'sound/misc/surgery/organ1.ogg'
	failure_sound = 'sound/effects/bone_break6.ogg'

/datum/surgery_step/open_encased/saw/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 开始用 \the [tool] 切开 [target] 的 [affected.encased]。"), \
	span_notice("你开始用 \the [tool] 切开 [target] 的 [affected.encased]。"))
	target.balloon_alert_to_viewers("锯切中...")
	target.custom_pain("Something hurts horribly in your [affected.display_name]!", 1)
	..()

/datum/surgery_step/open_encased/saw/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 用 \the [tool] 切开了 [target] 的 [affected.encased]。"),		\
	span_notice("你用 \the [tool] 切开了 [target] 的 [affected.encased]。"))
	target.balloon_alert_to_viewers("成功")
	affected.surgery_open_stage = 2.5
	return ..()

/datum/surgery_step/open_encased/saw/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user] 的手滑了, 用 \the [tool] 使 [target] 的 [affected.encased] 开裂!") , \
	span_warning("你的手滑了, 用 \the [tool] 使 [target] 的 [affected.encased] 开裂!") )
	target.balloon_alert_to_viewers("失手了!")

	affected.createwound(CUT, 20)
	affected.fracture()
	affected.update_wounds()


/datum/surgery_step/open_encased/retract
	allowed_tools = list(
		/obj/item/tool/surgery/retractor = 100,
		/obj/item/tool/crowbar = 75,
	)

	min_duration = RETRACT_OPEN_ENCASED_MIN_DURATION
	max_duration = RETRACT_OPEN_ENCASED_MAX_DURATION
	open_case_step = 2.5

	preop_sound = 'sound/misc/surgery/retractor1.ogg'
	success_sound = 'sound/misc/surgery/retractor2.ogg'
	failure_sound = 'sound/misc/surgery/organ1.ogg'

/datum/surgery_step/open_encased/retract/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 开始用 \the [tool] 撬开 [target] 的 [affected.display_name] 中的 [affected.encased]。"), \
	span_notice("你开始用 \the [tool] 撬开 [target] 的 [affected.display_name] 中的 [affected.encased]。"))
	target.balloon_alert_to_viewers("弯曲中...")
	target.custom_pain("Something hurts horribly in your [affected.display_name]!", 1)
	..()

/datum/surgery_step/open_encased/retract/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 用 \the [tool] 撬开了 [target] 的 [affected.encased]。"), \
	span_notice("你用 \the [tool] 撬开了 [target] 的 [affected.encased]。"))
	target.balloon_alert_to_viewers("成功")
	affected.surgery_open_stage = 3

	//Whoops!
	if(prob(10))
		affected.fracture()

	return ..()

/datum/surgery_step/open_encased/retract/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user] 的手滑了, 使 [target] 的 [affected.encased] 开裂!"), \
	span_warning("你的手滑了, 使 [target] 的 [affected.encased] 开裂!"))
	target.balloon_alert_to_viewers("失手了!")

	affected.createwound(BRUISE, 20)
	affected.fracture()
	affected.update_wounds()


/datum/surgery_step/open_encased/close
	allowed_tools = list(
		/obj/item/tool/surgery/retractor = 100,
		/obj/item/tool/crowbar = 75,
	)

	min_duration = RETRACT_CLOSE_ENCASED_MIN_DURATION
	max_duration = RETRACT_CLOSE_ENCASED_MAX_DURATION
	open_case_step = 3

	preop_sound = 'sound/misc/surgery/retractor1.ogg'
	success_sound = 'sound/misc/surgery/retractor2.ogg'
	failure_sound = 'sound/misc/surgery/organ1.ogg'

/datum/surgery_step/open_encased/close/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 开始用 \the [tool] 将 [target] 的 [affected.encased] 弯回原位。"), \
	span_notice("你开始用 \the [tool] 将 [target] 的 [affected.encased] 弯回原位。"))
	target.balloon_alert_to_viewers("弯曲中...")
	target.custom_pain("Something hurts horribly in your [affected.display_name]!", 1)
	..()

/datum/surgery_step/open_encased/close/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 用 \the [tool] 将 [target] 的 [affected.encased] 弯回原位。"), \
	span_notice("你用 \the [tool] 将 [target] 的 [affected.encased] 弯回原位。"))
	target.balloon_alert_to_viewers("成功")
	affected.surgery_open_stage = 2.5
	return ..()

/datum/surgery_step/open_encased/close/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user] 的手滑了, 将 [target] 的 [affected.encased] 弯错了方向!"), \
	span_warning("你的手滑了, 将 [target] 的 [affected.encased] 弯错了方向!"))
	target.balloon_alert_to_viewers("失手了!")
	affected.createwound(BRUISE, 20)
	affected.fracture()
	affected.update_wounds()


/datum/surgery_step/open_encased/mend
	allowed_tools = list(
		/obj/item/tool/surgery/bonegel = 100,
		/obj/item/tool/screwdriver = 75,
	)

	min_duration = BONEGEL_CLOSE_ENCASED_MIN_DURATION
	max_duration = BONEGEL_CLOSE_ENCASED_MAX_DURATION
	open_case_step = 2.5

	preop_sound = 'sound/misc/surgery/clothingrustle1.ogg'
	success_sound = 'sound/misc/surgery/bandage.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/open_encased/mend/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 开始将 \the [tool] 涂抹到 [target] 的 [affected.encased] 上。"), \
	span_notice("你开始将 \the [tool] 涂抹到 [target] 的 [affected.encased] 上。"))
	target.custom_pain("Something hurts horribly in your [affected.display_name]!",1)
	target.balloon_alert_to_viewers("涂抹凝胶...")
	..()

/datum/surgery_step/open_encased/mend/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 将 \the [tool] 涂抹到 [target] 的 [affected.encased] 上。"), \
	span_notice("你将 \the [tool] 涂抹到 [target] 的 [affected.encased] 上。"))
	target.balloon_alert_to_viewers("成功")
	affected.surgery_open_stage = 2
	return ..()

/datum/surgery_step/fat_removal
	allowed_tools = list(
		/obj/item/tool/surgery/scalpel = 100,
		/obj/item/tool/kitchen/knife = 75,
		/obj/item/shard = 50,
		/obj/item/weapon/combat_knife = 25,
		/obj/item/stack/throwing_knife = 15,
		/obj/item/weapon/sword/mercsword = 1,
	)
	min_duration = DEFAT_MIN_DURATION
	max_duration = DEFAT_MAX_DURATION
	priority = 2
	can_infect = TRUE
	blood_level = 1

	preop_sound = 'sound/misc/surgery/scalpel1.ogg'
	success_sound = 'sound/misc/surgery/scalpel2.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/fat_removal/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(target_zone != BODY_ZONE_CHEST) //Ungas only store fat in their chest cavity, it's science fact
		return SURGERY_CANNOT_USE
	if(!affected)
		return SURGERY_CANNOT_USE
	if(affected.limb_status & (LIMB_DESTROYED | LIMB_ROBOT))
		return SURGERY_CANNOT_USE
	if(affected.surgery_open_stage < 2)
		return SURGERY_CANNOT_USE
	if(target.nutrition < NUTRITION_OVERFED)
		return SURGERY_CANNOT_USE
	return SURGERY_CAN_USE

/datum/surgery_step/fat_removal/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 开始用 \the [tool] 切除 [target] 的 [affected.display_name]。"), \
	span_notice("你开始从 [target] 的 [affected.display_name] 中切除脂肪。"))
	target.custom_pain("Something hurts horribly in your [affected.display_name]!",1)
	target.balloon_alert_to_viewers("切除中")
	return ..()

/datum/surgery_step/fat_removal/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 完成了切开 [target] 的 [affected.display_name]。"), \
	span_notice("你从 [target] 的 [affected.display_name] 中移除了多余脂肪。"))
	target.balloon_alert_to_viewers("成功")
	var/nutrition_removed = target.nutrition - (NUTRITION_HUNGRY + 50)
	affected.take_damage_limb(nutrition_removed / 20, 0, TRUE, updating_health = TRUE)
	target.set_nutrition(NUTRITION_HUNGRY + 50)
	return ..()

/datum/surgery_step/fat_removal/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user] 的手滑了, 在 [target] 的 [affected.encased] 上切出一道深口!"), \
	span_warning("你的手滑了, 深深切入 [target] 的 [affected.encased]"))
	target.balloon_alert_to_viewers("失手了!")
	var/nutrition_removed = target.nutrition - (NUTRITION_HUNGRY + 50)
	affected.take_damage_limb(nutrition_removed / 40, 0, TRUE, updating_health = TRUE)
	return ..()
