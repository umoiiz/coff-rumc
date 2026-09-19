//This is an uguu head restoration surgery TOTALLY not yoinked from chinsky's limb reattacher

/datum/surgery_step/head
	priority = 1
	can_infect = 0
	allowed_species = list("Synthetic", "Early Synthetic", "Combat Robot")
	var/reattach_step

	preop_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/head/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(!affected)
		return SURGERY_CANNOT_USE
	if(!(affected.limb_status & LIMB_DESTROYED))
		return SURGERY_CANNOT_USE
	if(affected.body_part != HEAD)
		return SURGERY_CANNOT_USE
	if(affected.limb_replacement_stage == reattach_step)
		return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE

/datum/surgery_step/head/peel
	allowed_tools = list(
		/obj/item/tool/surgery/retractor = 100,
		/obj/item/tool/crowbar = 75,
		/obj/item/tool/kitchen/utensil/fork = 50,
	)

	min_duration = 30
	max_duration = 40
	reattach_step = 0


/datum/surgery_step/head/peel/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]剥开[target]头部原本位置上的破烂血肉."), \
	span_notice("你开始用\the [tool]剥开[target]头部原本位置上的破烂血肉."))
	target.balloon_alert_to_viewers("剥离中...")
	..()

/datum/surgery_step/head/peel/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]剥开了[target]头部原本位置上的破烂血肉."),	\
	span_notice("你用\the [tool]剥开了[target]头部原本位置上的破烂血肉."))
	target.balloon_alert_to_viewers("成功")
	affected.limb_replacement_stage = 1
	return ..()

/datum/surgery_step/head/peel/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(affected.parent)
		affected = affected.parent
		user.visible_message(span_warning("[user]的手滑了,撕开了[target]的[affected.display_name]!"), \
		span_warning("你的手滑了,撕开了[target]的[affected.display_name]!"))
		target.balloon_alert_to_viewers("滑脱!")
		affected.createwound(CUT, 10)
		affected.update_wounds()


/datum/surgery_step/head/shape
	allowed_tools = list(
		/obj/item/tool/surgery/FixOVein = 100,
		/obj/item/stack/cable_coil = 75,
		/obj/item/assembly/mousetrap = 10,
	)

	min_duration = 60
	max_duration = 80
	reattach_step = 1

/datum/surgery_step/head/shape/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]重塑[target]的食道和发声区域."), \
	span_notice("你开始用\the [tool]重塑[target]头部的食道和发声区域."))
	target.balloon_alert_to_viewers("重塑中...")
	..()

/datum/surgery_step/head/shape/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]完成了将[target]头部原本位置的血肉和组织重新摆放成解剖学上可辨认的形态."),	\
	span_notice("你用\the [tool]完成了将[target]头部原本位置的血肉和组织重新摆放成解剖学上可辨认的形态."))
	target.balloon_alert_to_viewers("成功")
	affected.limb_replacement_stage = 2
	return ..()

/datum/surgery_step/head/shape/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(affected.parent)
		affected = affected.parent
		user.visible_message(span_warning("[user]的手滑了,进一步撕裂了[target]脖子上的血肉!"), \
		span_warning("你的手滑了,进一步撕裂了[target]脖子上的血肉!"))
		target.balloon_alert_to_viewers("滑脱!")
		target.apply_damage(10, BRUTE, affected, updating_health = TRUE)


/datum/surgery_step/head/suture
	allowed_tools = list(
		/obj/item/tool/surgery/hemostat = 100,
		/obj/item/stack/cable_coil = 60,
		/obj/item/tool/surgery/FixOVein = 80,
	)

	min_duration = 60
	max_duration = 80
	reattach_step = 2

/datum/surgery_step/head/suture/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]正在用\the [tool]将血肉钉合并缝合到[target]的食道和发声区域."), \
	span_notice("你开始用\the [tool]将血肉钉合并缝合到[target]的食道和发声区域."))
	target.balloon_alert_to_viewers("缝合中...")
	..()

/datum/surgery_step/head/suture/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]完成了对[target]脖子的钉合."),	\
	span_notice("你用\the [tool]完成了对[target]脖子的钉合."))
	target.balloon_alert_to_viewers("成功")
	affected.limb_replacement_stage = 3
	return ..()

/datum/surgery_step/head/suture/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(affected.parent)
		affected = affected.parent
		user.visible_message(span_warning("[user]的手滑了,撕裂了[target]脖子上的血肉!"), \
		span_warning("你的手滑了,撕裂了[target]脖子上的血肉!"))
		target.balloon_alert_to_viewers("滑脱!")
		target.apply_damage(10, BRUTE, affected, updating_health = TRUE)


/datum/surgery_step/head/prepare
	allowed_tools = list(
		/obj/item/tool/surgery/cautery = 100,
		/obj/item/clothing/mask/cigarette = 75,
		/obj/item/tool/lighter = 50,
		/obj/item/tool/weldingtool = 25,
	)

	min_duration = 60
	max_duration = 80
	reattach_step = 3

/datum/surgery_step/head/prepare/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]调整[target]脖子周围的区域."), \
	span_notice("你开始用\the [tool]调整[target]脖子周围的区域."))
	target.balloon_alert_to_viewers("调整中...")
	..()

/datum/surgery_step/head/prepare/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]完成了对[target]脖子周围区域的调整."),	\
	span_notice("你用\the [tool]完成了对[target]脖子周围区域的调整."))
	target.balloon_alert_to_viewers("成功")
	affected.limb_replacement_stage = 0
	affected.add_limb_flags(LIMB_AMPUTATED)
	affected.setAmputatedTree()
	return ..()

/datum/surgery_step/head/prepare/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(affected.parent)
		affected = affected.parent
		user.visible_message(span_warning("[user]的手滑了,灼烧了[target]的脖子!"), \
		span_warning("你的手滑了,灼烧了[target]的[affected.display_name]!"))
		target.balloon_alert_to_viewers("滑脱!")
		target.apply_damage(10, BURN, affected, updating_health = TRUE)


/datum/surgery_step/head/attach
	allowed_tools = list(/obj/item/limb/head/synth = 100, /obj/item/limb/head/robotic = 100)
	can_infect = 0
	min_duration = 60
	max_duration = 80
	reattach_step = 0

/datum/surgery_step/head/attach/can_use(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(..())
		if(affected.limb_status & LIMB_AMPUTATED)
			return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE

/datum/surgery_step/head/attach/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始将[tool]连接到[target]重塑后的脖子上."), \
	span_notice("你开始将[tool]连接到[target]重塑后的脖子上."))
	target.balloon_alert_to_viewers("连接中...")
	..()

/datum/surgery_step/head/attach/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]已将[target]的头部连接到身体上."),	\
	span_notice("你已将[target]的头部连接到身体上."))
	target.balloon_alert_to_viewers("成功")

	//Update our dear victim to have a head again

	var/obj/item/limb/head/B = tool

	affected.robotize()
	target.update_health()
	target.update_body()
	target.UpdateDamageIcon()
	target.update_hair()

	//Prepare mind datum
	if(B.brainmob?.mind)
		B.brainmob.mind.transfer_to(target)

	//Deal with the head item properly
	user.temporarilyRemoveItemFromInventory(B)
	qdel(B)
	return ..()

/datum/surgery_step/head/attach/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手滑了,损坏了[target]脖子上的连接器!"), \
	span_warning("你的手滑了一下,损坏了[target]脖子上的连接器!"))
	target.balloon_alert_to_viewers("滑脱了!")
	target.apply_damage(10, BRUTE, affected, 0, TRUE, updating_health = TRUE)
