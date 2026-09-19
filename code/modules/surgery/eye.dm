/datum/surgery_step/eye
	priority = 2
	can_infect = 1
	var/eye_step

/datum/surgery_step/eye/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(!affected || (affected.limb_status & LIMB_DESTROYED))
		return FALSE

	if(target_zone != "eyes")
		return FALSE

	var/datum/internal_organ/eyes/our_eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	if(!our_eyes)
		return FALSE
	if(our_eyes.eye_surgery_stage == eye_step)
		return TRUE

/datum/surgery_step/eye/cut_open
	allowed_tools = list(
		/obj/item/tool/surgery/scalpel = 100,
		/obj/item/tool/kitchen/knife = 75,
		/obj/item/shard = 50,
	)

	min_duration = EYE_CUT_MIN_DURATION
	max_duration = EYE_CUT_MAX_DURATION
	eye_step = 0

/datum/surgery_step/eye/cut_open/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]分离[target]眼睛上的角膜."), \
	span_notice("你开始用\the [tool]分离[target]眼睛上的角膜."))
	target.balloon_alert_to_viewers("分离中...")
	return ..()

/datum/surgery_step/eye/cut_open/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]分离了[target]眼睛上的角膜.") , \
	span_notice("你用\the [tool]分离了[target]眼睛上的角膜."),)
	target.balloon_alert_to_viewers("成功")
	var/datum/internal_organ/eyes/our_eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	our_eyes.eye_surgery_stage = 1
	target.disabilities |= NEARSIGHTED // code\#define\mobs.dm
	return ..()

/datum/surgery_step/eye/cut_open/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手滑了,用\the [tool]割伤了[target]的眼睛!") , \
	span_warning("你的手滑了,用\the [tool]割伤了[target]的眼睛!") )
	target.balloon_alert_to_viewers("失手!")
	affected.createwound(CUT, 10)
	var/datum/internal_organ/eyes/our_eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	our_eyes.take_damage(5, 0)
	target.update_health()
	affected.update_wounds()

/datum/surgery_step/eye/lift_eyes
	allowed_tools = list(
		/obj/item/tool/surgery/retractor = 100,
		/obj/item/tool/kitchen/utensil/fork = 50,
	)

	min_duration = EYE_LIFT_MIN_DURATION
	max_duration = EYE_LIFT_MAX_DURATION
	eye_step = 1

/datum/surgery_step/eye/lift_eyes/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 开始用 \the [tool] 从 [target] 的眼睛上提起角膜."), \
	span_notice("你开始用 \the [tool] 从 [target] 的眼睛上提起角膜."))
	target.balloon_alert_to_viewers("提起中...")
	return ..()

/datum/surgery_step/eye/lift_eyes/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 已用 \the [tool] 从 [target] 的眼睛上提起角膜.") , \
	span_notice("你已用 \the [tool] 从 [target] 的眼睛上提起角膜.") )
	target.balloon_alert_to_viewers("成功")
	var/datum/internal_organ/eyes/our_eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	our_eyes.eye_surgery_stage = 2
	return ..()

/datum/surgery_step/eye/lift_eyes/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user] 的手滑了, 用 \the [tool] 损伤了 [target] 的眼睛!"),
	span_warning("你的手滑了, 用 \the [tool] 损伤了 [target] 的眼睛!"))
	target.balloon_alert_to_viewers("滑脱了!")
	var/datum/internal_organ/eyes/eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	eyes.take_damage(5, 0)
	target.apply_damage(10, BRUTE, affected, updating_health = TRUE)

/datum/surgery_step/eye/mend_eyes
	allowed_tools = list(
		/obj/item/tool/surgery/hemostat = 100,
		/obj/item/stack/cable_coil = 75,
		/obj/item/assembly/mousetrap = 10,
	)

	min_duration = EYE_MEND_MIN_DURATION
	max_duration = EYE_MEND_MAX_DURATION
	eye_step = 2

/datum/surgery_step/eye/mend_eyes/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 开始用 \the [tool] 修补 [target] 眼睛里的神经和晶状体."), \
	span_notice("你开始用 [tool] 修补 [target] 眼睛里的神经和晶状体."))
	target.balloon_alert_to_viewers("修补中...")
	return ..()

/datum/surgery_step/eye/mend_eyes/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 用 \the [tool] 修补了 [target] 的神经和晶状体.") ,	\
	span_notice("你用 \the [tool] 修补了 [target] 的神经和晶状体."))
	target.balloon_alert_to_viewers("成功")
	var/datum/internal_organ/eyes/our_eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	our_eyes.eye_surgery_stage = 3
	return ..()

/datum/surgery_step/eye/mend_eyes/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user] 的手滑了, 把 \the [tool] 刺入 [target] 的眼睛!"),
	span_warning("你的手滑了, 把 \the [tool] 刺入 [target] 的眼睛!"))
	target.balloon_alert_to_viewers("滑脱了!")
	var/datum/internal_organ/eyes/our_eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	our_eyes.take_damage(5, 0)
	target.apply_damage(10, BRUTE, affected, 0, TRUE, updating_health = TRUE)

/datum/surgery_step/eye/cauterize
	allowed_tools = list(
		/obj/item/tool/surgery/cautery = 100,
		/obj/item/clothing/mask/cigarette = 75,
		/obj/item/tool/lighter = 50,
		/obj/item/tool/weldingtool = 25,
	)

	min_duration = EYE_CAUTERISE_MIN_DURATION
	max_duration = EYE_CAUTERISE_MAX_DURATION
	eye_step = 3

/datum/surgery_step/eye/cauterize/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 开始用 \the [tool] 烧灼 [target] 眼睛周围的切口.") , \
	span_notice("你开始用 \the [tool] 烧灼 [target] 眼睛周围的切口."))
	target.balloon_alert_to_viewers("烧灼中...")

/datum/surgery_step/eye/cauterize/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user] 用 \the [tool] 烧灼了 [target] 眼睛周围的切口."), \
	span_notice("你用 \the [tool] 烧灼了 [target] 眼睛周围的切口."))
	target.balloon_alert_to_viewers("成功")
	target.disabilities &= ~NEARSIGHTED
	target.disabilities &= ~BLIND
	var/datum/internal_organ/eyes/our_eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	our_eyes.heal_organ_damage(200) // TODO: add max organ damage cap
	our_eyes.eye_surgery_stage = 0
	return ..()

/datum/surgery_step/eye/cauterize/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user] 的手滑了, 用 \the [tool] 灼烧了 [target] 的眼睛!"),
	span_warning("你的手滑了, 用 \the [tool] 灼烧了 [target] 的眼睛!"))
	target.balloon_alert_to_viewers("滑脱了!")
	var/datum/internal_organ/eyes/our_eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	our_eyes.take_damage(5, 0)
	target.apply_damage(5, BURN, affected, updating_health = TRUE)
