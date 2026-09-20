//Procedures in this file: Robotic limbs attachment
//////////////////////////////////////////////////////////////////
//						LIMB SURGERY							//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/limb
	can_infect = 0
	var/limb_step

/datum/surgery_step/limb/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(!affected)
		return SURGERY_CANNOT_USE
	if(!(affected.limb_status & LIMB_DESTROYED))
		return SURGERY_CANNOT_USE
	if(affected.parent && (affected.parent.limb_status & LIMB_DESTROYED))//parent limb is destroyed
		return SURGERY_CANNOT_USE
	if(affected.limb_replacement_stage != limb_step)
		return SURGERY_CANNOT_USE
	if(affected.body_part == HEAD) //head has its own steps
		return SURGERY_CANNOT_USE
	return SURGERY_CAN_USE

/datum/surgery_step/limb/cut
	allowed_tools = list(
		/obj/item/tool/surgery/scalpel = 100,
		/obj/item/tool/kitchen/knife = 75,
		/obj/item/shard = 50,
	)

	min_duration = ROBOLIMB_CUT_MIN_DURATION
	max_duration = ROBOLIMB_CUT_MAX_DURATION
	limb_step = 0

	preop_sound = 'sound/misc/surgery/scalpel1.ogg'
	success_sound = 'sound/misc/surgery/scalpel2.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/limb/cut/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]切除[target]的[affected.display_name]原先所在处的血肉."), \
	span_notice("你开始用\the [tool]切除[target]的[affected.display_name]原先所在处的血肉."))
	target.balloon_alert_to_viewers("正在切除...")
	..()

/datum/surgery_step/limb/cut/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]切除了[target]的[affected.display_name]原先所在处的血肉."),	\
	span_notice("你用\the [tool]切除了[target]的[affected.display_name]原先所在处的血肉."))
	target.balloon_alert_to_viewers("成功")
	affected.limb_replacement_stage = 1
	return ..()

/datum/surgery_step/limb/cut/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(affected.parent)
		affected = affected.parent
		user.visible_message(span_warning("[user]的手滑了一下,切开了[target]的[affected.display_name]!"), \
		span_warning("你的手滑了一下,切开了[target]的[affected.display_name]!"))
		target.balloon_alert_to_viewers("滑脱!")
		affected.createwound(CUT, 10)
		affected.update_wounds()



/datum/surgery_step/limb/mend
	allowed_tools = list(
		/obj/item/tool/surgery/retractor = 100,
		/obj/item/tool/crowbar = 75,
		/obj/item/tool/kitchen/utensil/fork = 50,
	)

	min_duration = ROBOLIMB_MEND_MIN_DURATION
	max_duration = ROBOLIMB_MEND_MAX_DURATION
	limb_step = 1

	preop_sound = 'sound/misc/surgery/retractor1.ogg'
	success_sound = 'sound/misc/surgery/retractor2.ogg'
	failure_sound = 'sound/misc/surgery/organ1.ogg'


/datum/surgery_step/limb/mend/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用[tool]重新安置[target]的[affected.display_name]原先所在处的血肉和神经末梢."), \
	span_notice("你开始用[tool]重新安置[target]的[affected.display_name]原先所在处的血肉和神经末梢."))
	target.balloon_alert_to_viewers("正在重新安置...")
	..()

/datum/surgery_step/limb/mend/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用[tool]完成了对[target]的[affected.display_name]原先所在处血肉和神经末梢的重新安置."),	\
	span_notice("你用[tool]完成了对[target]的[affected.display_name]原先所在处血肉和神经末梢的重新安置."))
	target.balloon_alert_to_viewers("成功")
	affected.limb_replacement_stage = 2
	return ..()

/datum/surgery_step/limb/mend/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(affected.parent)
		affected = affected.parent
		user.visible_message(span_warning("[user]的手滑了一下,撕裂了[target]的[affected.display_name]上的血肉!"), \
		span_warning("你的手滑了一下,撕裂了[target]的[affected.display_name]上的血肉!"))
		target.balloon_alert_to_viewers("滑脱!")
		target.apply_damage(10, BRUTE, affected, 0, TRUE, updating_health = TRUE)


/datum/surgery_step/limb/prepare
	allowed_tools = list(
		/obj/item/tool/surgery/cautery = 100,
		/obj/item/clothing/mask/cigarette = 75,
		/obj/item/tool/lighter = 50,
		/obj/item/tool/weldingtool = 25,
	)

	min_duration = ROBOLIMB_PREPARE_MIN_DURATION
	max_duration = ROBOLIMB_PREPARE_MAX_DURATION
	limb_step = 2

	preop_sound = 'sound/misc/surgery/cautery1.ogg'
	success_sound = 'sound/misc/surgery/cautery2.ogg'
	failure_sound = 'sound/items/welder2.ogg'

/datum/surgery_step/limb/prepare/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]调整[target]的[affected.display_name]周围的区域."), \
	span_notice("你开始用\the [tool]调整[target]的[affected.display_name]周围的区域."))
	target.balloon_alert_to_viewers("正在调整...")
	..()

/datum/surgery_step/limb/prepare/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]完成了对[target]的[affected.display_name]周围区域的调整."),	\
	span_notice("你已完成调整[target]的[affected.display_name]周围的区域,使用了\the [tool]."))
	target.balloon_alert_to_viewers("成功")
	affected.add_limb_flags(LIMB_AMPUTATED)
	affected.setAmputatedTree()
	affected.limb_replacement_stage = 0
	return ..()

/datum/surgery_step/limb/prepare/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(affected.parent)
		affected = affected.parent
		user.visible_message(span_warning("[user]的手滑了,烧灼了[target]的[affected.display_name]!"), \
		span_warning("你的手滑了,烧灼了[target]的[affected.display_name]!"))
		target.balloon_alert_to_viewers("滑脱了!")
		target.apply_damage(10, BURN, affected, updating_health = TRUE)


/datum/surgery_step/limb/attach
	allowed_tools = list(/obj/item/robot_parts = 100)

	min_duration = ROBOLIMB_ATTACH_MIN_DURATION
	max_duration = ROBOLIMB_ATTACH_MAX_DURATION
	limb_step = 0

	preop_sound = 'sound/misc/surgery/clothingrustle1.ogg'
	success_sound = 'sound/misc/surgery/clothingrustle5.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/limb/attach/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(..())
		var/obj/item/robot_parts/p = tool
		if(p.part)
			if(!(affected.name in p.part))
				return SURGERY_CANNOT_USE
		if(affected.limb_status & LIMB_AMPUTATED)
			return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE

/datum/surgery_step/limb/attach/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始将\the [tool]安装到[target]的[affected.display_name]原本所在的位置."), \
	span_notice("你开始将\the [tool]安装到[target]的[affected.display_name]原本所在的位置."))
	target.balloon_alert_to_viewers("正在安装...")

/datum/surgery_step/limb/attach/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]已将\the [tool]安装到[target]的[affected.display_name]原本所在的位置."),	\
	span_notice("你已将\the [tool]安装到[target]的[affected.display_name]原本所在的位置."))
	target.balloon_alert_to_viewers("成功")

	//Update our dear victim to have a limb again
	if(istype(tool, /obj/item/robot_parts/biotic))
		affected.biotize()
	else
		affected.robotize()

	target.update_body()
	target.update_health()
	target.UpdateDamageIcon()

	//Deal with the limb item properly
	user.temporarilyRemoveItemFromInventory(tool)
	qdel(tool)
	return ..()

/datum/surgery_step/limb/attach/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手滑了,损坏了[target]的[affected.display_name]上的连接器!"), \
	span_warning("你的手滑了,损坏了[target]的[affected.display_name]上的连接器!"))
	target.balloon_alert_to_viewers("滑脱了!")
	target.apply_damage(10, BRUTE, affected, 0, TRUE, updating_health = TRUE)
