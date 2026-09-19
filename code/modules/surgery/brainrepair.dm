/datum/surgery_step/brain
	var/dmg_min = 0
	var/dmg_max

/datum/surgery_step/brain/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	var/datum/internal_organ/brain/sponge = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!sponge || sponge.damage <= dmg_min || affected.surgery_open_stage != 3 || target_zone != "head")
		return SURGERY_CANNOT_USE
	if(dmg_max && sponge.damage > dmg_max)
		return SURGERY_CANNOT_USE
	return SURGERY_CAN_USE

/datum/surgery_step/brain/bone_chips
	priority = 3
	allowed_tools = list(
		/obj/item/tool/surgery/hemostat = 100,
		/obj/item/tool/wirecutters = 75,
		/obj/item/tool/kitchen/utensil/fork = 20,
	)

	min_duration = BONECHIPS_REMOVAL_MIN_DURATION
	max_duration = BONECHIPS_REMOVAL_MAX_DURATION
	dmg_max = BONECHIPS_MAX_DAMAGE //need to use the FixOVein past this point

/datum/surgery_step/brain/bone_chips/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]从[target]的脑中取出骨屑."), \
	span_notice("你开始用\the [tool]从[target]的脑中取出骨屑."))
	target.balloon_alert_to_viewers("清理骨头中...")
	return ..()

/datum/surgery_step/brain/bone_chips/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]取出了[target]脑中的所有骨屑."),	\
	span_notice("你用\the [tool]取出了[target]脑中的所有骨屑."))
	target.balloon_alert_to_viewers("成功")
	var/datum/internal_organ/brain/sponge = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(sponge)
		sponge.heal_organ_damage(BRAIN_DAMAGE_DEATH) // we heal the maximun amount, so this define should do it
	return ..()

/datum/surgery_step/brain/bone_chips/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手一滑, 将\the [tool]刺入了[target]的脑中!"), \
	span_warning("你的手一滑, 将\the [tool]刺入了[target]的脑中!"))
	target.balloon_alert_to_viewers("失手!")
	target.apply_damage(30, BRUTE, "head", 0, TRUE, updating_health = TRUE)

/datum/surgery_step/brain/hematoma
	priority = 3
	allowed_tools = list(
		/obj/item/tool/surgery/FixOVein = 100,
		/obj/item/stack/cable_coil = 75,
	)

	min_duration = HEMOTOMA_MIN_DURATION
	max_duration = HEMOTOMA_MAX_DURATION
	dmg_min = BONECHIPS_MAX_DAMAGE //below that, you use the hemostat

/datum/surgery_step/brain/hematoma/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]修补[target]脑部的血肿."), \
	span_notice("你开始用\the [tool]修补[target]脑部的血肿."))
	target.balloon_alert_to_viewers("修补中...")
	return ..()

/datum/surgery_step/brain/hematoma/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]修补了[target]脑部的血肿."),	\
	span_notice("你用\the [tool]修补了[target]脑部的血肿."))
	target.balloon_alert_to_viewers("成功")
	var/datum/internal_organ/brain/sponge = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(sponge)
		sponge.heal_organ_damage(BONECHIPS_MAX_DAMAGE)
	return ..()

/datum/surgery_step/brain/hematoma/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手滑了,用\the [tool]挫伤了[target]的大脑!"), \
	span_warning("你的手滑了,用\the [tool]挫伤了[target]的大脑!"))
	target.balloon_alert_to_viewers("失手!")
	target.apply_damage(20, BRUTE, "head", 0, TRUE, updating_health = TRUE)
