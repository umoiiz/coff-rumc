//Procedures in this file: Facial reconstruction surgery
//////////////////////////////////////////////////////////////////
//						FACE SURGERY							//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/face
	priority = 2
	can_infect = 0
	var/face_step = 0

/datum/surgery_step/face/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(target_zone != "mouth")
		return SURGERY_CANNOT_USE
	if(affected.limb_status & LIMB_DESTROYED)
		return SURGERY_CANNOT_USE
	var/datum/limb/head/H = affected
	if(!istype(H) || !H.disfigured || H.face_surgery_stage != face_step)
		return SURGERY_CANNOT_USE
	return SURGERY_CAN_USE

/datum/surgery_step/face/cut_face
	allowed_tools = list(
		/obj/item/tool/surgery/scalpel = 100,
		/obj/item/tool/kitchen/knife = 75,
		/obj/item/shard = 50,
	)

	min_duration = FACIAL_CUT_MIN_DURATION
	max_duration = FACIAL_CUT_MAX_DURATION
	face_step = 0

/datum/surgery_step/face/cut_face/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/head/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]切开[target]的脸和脖子."), \
	span_notice("你开始用\the [tool]切开[target]的脸和脖子."))
	target.balloon_alert_to_viewers("切开中...")
	..()

/datum/surgery_step/face/cut_face/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/head/affected)
	user.visible_message(span_notice("[user]用\the [tool]切开了[target]的脸和脖子.") , \
	span_notice("你用\the [tool]切开了[target]的脸和脖子."),)
	target.balloon_alert_to_viewers("成功")
	affected.face_surgery_stage = 1
	return ..()

/datum/surgery_step/face/cut_face/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/head/affected)
	user.visible_message(span_warning("[user]的手滑了一下,用\the [tool]切开了[target]的喉咙!") , \
	span_warning("你的手滑了一下,用\the [tool]切开了[target]的喉咙!") )
	target.balloon_alert_to_viewers("滑脱了!")
	affected.createwound(CUT, 60)
	target.Losebreath(10)
	target.update_health()
	affected.update_wounds()


/datum/surgery_step/face/mend_vocal
	allowed_tools = list(
		/obj/item/tool/surgery/hemostat = 100,
		/obj/item/stack/cable_coil = 75,
		/obj/item/assembly/mousetrap = 10,
	)

	min_duration = FACIAL_MEND_MIN_DURATION
	max_duration = FACIAL_MEND_MAX_DURATION
	face_step = 1

/datum/surgery_step/face/mend_vocal/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/head/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]修复[target]的声带."), \
	span_notice("你开始用\the [tool]修复[target]的声带."))
	target.balloon_alert_to_viewers("修复声带中...")
	..()

/datum/surgery_step/face/mend_vocal/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/head/affected)
	user.visible_message(span_notice("[user]用\the [tool]修复了[target]的声带."), \
	span_notice("你用\the [tool]修复了[target]的声带."))
	target.balloon_alert_to_viewers("成功")
	affected.face_surgery_stage = 2
	return ..()

/datum/surgery_step/face/mend_vocal/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/head/affected)
	user.visible_message(span_warning("[user]的手滑了一下,用\the [tool]把[target]的气管夹闭了片刻!"), \
	span_warning("你的手滑了一下,用\the [tool]把[user]的气管夹闭了片刻!"))
	target.balloon_alert_to_viewers("滑脱了!")
	target.Losebreath(10)
	target.update_health()


/datum/surgery_step/face/fix_face
	allowed_tools = list(
		/obj/item/tool/surgery/retractor = 100,
		/obj/item/tool/crowbar = 55,
		/obj/item/tool/kitchen/utensil/fork = 75,
	)

	min_duration = FACIAL_FIX_MIN_DURATION
	max_duration = FACIAL_FIX_MAX_DURATION
	face_step = 2

/datum/surgery_step/face/fix_face/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/head/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]把[target]脸上的皮肤拉回原位."), \
	span_notice("你开始用\the [tool]把[target]脸上的皮肤拉回原位."))
	target.balloon_alert_to_viewers("重塑中...")
	..()

/datum/surgery_step/face/fix_face/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/head/affected)
	user.visible_message(span_notice("[user]用\the [tool]把[target]脸上的皮肤拉回了原位."),	\
	span_notice("你用\the [tool]把[target]脸上的皮肤拉回了原位."))
	target.balloon_alert_to_viewers("成功")
	affected.face_surgery_stage = 3
	return ..()

/datum/surgery_step/face/fix_face/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/head/affected)
	user.visible_message(span_warning("[user]的手滑了一下,用\the [tool]撕裂了[target]脸上的皮肤!"), \
	span_warning("你的手滑了一下,用\the [tool]撕裂了[target]脸上的皮肤!"))
	target.balloon_alert_to_viewers("滑脱了!")
	target.apply_damage(10, BRUTE, affected, 0, TRUE, updating_health = TRUE)


/datum/surgery_step/face/cauterize
	allowed_tools = list(
		/obj/item/tool/surgery/cautery = 100,
		/obj/item/clothing/mask/cigarette = 75,
		/obj/item/tool/lighter = 50,
		/obj/item/tool/weldingtool = 25,
	)

	min_duration = FACIAL_CAUTERISE_MIN_DURATION
	max_duration = FACIAL_CAUTERISE_MAX_DURATION
	face_step = 3


/datum/surgery_step/face/cauterize/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/head/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]烧灼[target]脸和脖子上的切口.") , \
	span_notice("你开始用\the [tool]烧灼[target]脸和脖子上的切口."))
	target.balloon_alert_to_viewers("烧灼中...")
	..()

/datum/surgery_step/face/cauterize/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/head/affected)
	user.visible_message(span_notice("[user]用\the [tool]烧灼了[target]脸和脖子上的切口."), \
	span_notice("你用\the [tool]烧灼了[target]脸和脖子上的切口."))
	target.balloon_alert_to_viewers("成功")
	affected.remove_limb_flags(LIMB_BLEEDING)
	affected.disfigured = 0
	affected.owner.name = affected.owner.get_visible_name()
	affected.face_surgery_stage = 0
	return ..()

/datum/surgery_step/face/cauterize/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/head/affected)
	user.visible_message(span_warning("[user]的手滑了一下,用\the [tool]在[target]脸上留下了一处小烧伤!"), \
	span_warning("你的手滑了一下,用\the [tool]在[target]脸上留下了一处小烧伤!"))
	target.balloon_alert_to_viewers("滑脱了!")
	target.apply_damage(4, BURN, affected, updating_health = TRUE)
