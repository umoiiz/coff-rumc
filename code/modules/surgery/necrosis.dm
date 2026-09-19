

/datum/surgery_step/necro
	priority = 3
	var/necro_step

/datum/surgery_step/necro/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(target_zone == "mouth" || target_zone == "eyes")
		return SURGERY_CANNOT_USE

	if(affected.surgery_open_stage == 2 && (affected.limb_status & LIMB_NECROTIZED) && affected.necro_surgery_stage == necro_step)
		return SURGERY_CAN_USE

	return SURGERY_CANNOT_USE


/datum/surgery_step/necro/fix_dead_tissue //Debridement

	allowed_tools = list(
		/obj/item/tool/surgery/scalpel = 100,		\
		/obj/item/tool/kitchen/knife = 75,	\
		/obj/item/shard = 50, 		\
	)

	can_infect = 1
	blood_level = 1

	min_duration = NECRO_REMOVE_MIN_DURATION
	max_duration = NECRO_REMOVE_MAX_DURATION
	necro_step = 0

	preop_sound = 'sound/misc/surgery/scalpel1.ogg'
	success_sound = 'sound/misc/surgery/scalpel2.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/necro/fix_dead_tissue/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]切除[target]的[affected.display_name]里的坏死组织。") , \
	span_notice("你开始用\the [tool]切除[target]的[affected.display_name]里的坏死组织。"))
	target.balloon_alert_to_viewers("正在切割...")
	target.custom_pain("The pain in [affected.display_name] is unbearable!", 1)
	..()

/datum/surgery_step/necro/fix_dead_tissue/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]切除了[target][affected.display_name]中的坏死组织。"), \
		span_notice("你切除了[target][affected.display_name]中的坏死组织,但无法避免对周围组织造成一些损伤。"))
	target.balloon_alert_to_viewers("成功")
	affected.necro_surgery_stage = 1
	affected.createwound(CUT, 30)
	affected.germ_level = min(affected.germ_level, 600) //Ensure that necrosis won't immediately reform
	return ..()

/datum/surgery_step/necro/fix_dead_tissue/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手滑了一下,用\the [tool]切开了[target][affected.display_name]内的一根动脉!"), \
	span_warning("你的手滑了一下,用\the [tool]切开了[target][affected.display_name]内的一根动脉!"))
	target.balloon_alert_to_viewers("滑脱!")
	affected.createwound(CUT, 20)

/datum/surgery_step/necro/treat_necrosis

	allowed_tools = list(
		/obj/item/tool/surgery/surgical_membrane = 100,
	)

	can_infect = 0
	blood_level = 0

	min_duration = NECRO_TREAT_MIN_DURATION
	max_duration = NECRO_TREAT_MAX_DURATION
	necro_step = 1

	preop_sound = 'sound/misc/surgery/clothingrustle1.ogg'
	success_sound = 'sound/misc/surgery/organ1.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/necro/treat_necrosis/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始将\the [tool]敷用到[target][affected.display_name]断裂的组织上。") , \
	span_notice("你开始将\the [tool]敷用到[target][affected.display_name]断裂的组织上。"))
	target.custom_pain("Something in your [affected.display_name] is causing you a lot of pain!", 1)
	target.balloon_alert_to_viewers("正在敷用...")
	..()

/datum/surgery_step/necro/treat_necrosis/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	target.update_body()

	user.visible_message(span_notice("[user]将\the [tool]敷用到[target][affected.display_name]断裂的组织上。"), \
	span_notice("你将\the [tool]敷用到[target][affected.display_name]断裂的组织上,将其修复。"))
	target.balloon_alert_to_viewers("成功")
	affected.necro_surgery_stage = 0
	affected.heal_limb_damage(affected.brute_dam * 0.5, updating_health = TRUE)
	affected.germ_level = max(0, affected.germ_level - 100) //Right at infection level 2 if it was previously above the cap
	affected.remove_limb_flags(LIMB_NECROTIZED)
	affected.bandage()
	return ..()

/datum/surgery_step/treat_necrosis/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手滑了一下,将\the [tool]敷到了[target][affected.display_name]的错误位置!") , \
	span_warning("你的手滑了一下,将\the [tool]敷到了[target][affected.display_name]的错误位置!"))
	target.balloon_alert_to_viewers("滑脱!")
