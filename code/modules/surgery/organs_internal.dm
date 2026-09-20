// Internal surgeries.
/datum/surgery_step/internal
	can_infect = 1
	blood_level = 1

/datum/surgery_step/internal/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(affected.surgery_open_stage == (affected.encased ? 3 : 2))
		return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE

//////////////////////////////////////////////////////////////////
//					ALIEN EMBRYO SURGERY						//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/internal/remove_embryo
	priority = 3
	allowed_tools = list(
		/obj/item/tool/surgery/hemostat = 100,
		/obj/item/tool/wirecutters = 75,
		/obj/item/tool/kitchen/utensil/fork = 20,
	)
	blood_level = 2

	min_duration = 60
	max_duration = 80

	preop_sound = 'sound/misc/surgery/hemostat1.ogg'
	success_sound = 'sound/misc/surgery/organ2.ogg'
	failure_sound = 'sound/misc/surgery/acid_sizzle2.ogg'

/datum/surgery_step/internal/remove_embryo/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(affected.body_part != CHEST)
		return SURGERY_CANNOT_USE
	if(..())
		if(locate(/obj/item/alien_embryo) in target)
			return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE

/datum/surgery_step/internal/remove_embryo/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]从[target]的胸腔中拉出什么东西."), \
					span_notice("你开始用\the [tool]从[target]的胸腔中拉出什么东西."))
	target.balloon_alert_to_viewers("正在拉出...")
	target.custom_pain("Something hurts horribly in your chest!",1)
	..()

/datum/surgery_step/internal/remove_embryo/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	var/obj/item/alien_embryo/A = locate() in target
	if(A)
		user.visible_message(span_warning("[user]从[target]的胸腔中扯出一条扭动的寄生虫!"),
							span_warning("你从[target]的胸腔中扯出一条扭动的寄生虫!"))
		target.balloon_alert_to_viewers("成功")
		var/mob/living/carbon/xenomorph/larva/L = locate() in target //the larva was fully grown, ready to burst.
		if(L)
			L.forceMove(target.loc)
			qdel(A)
		else
			A.forceMove(target.loc)
			target.status_flags &= ~XENO_HOST
			GLOB.round_statistics.larva_surgically_removed++

	affected.createwound(CUT, rand(0,20), 1)
	target.update_health()
	affected.update_wounds()
	return ..()


//////////////////////////////////////////////////////////////////
//				CHEST INTERNAL ORGAN SURGERY					//
//////////////////////////////////////////////////////////////////


/datum/surgery_step/internal/fix_organ
	priority = 1
	allowed_tools = list(
		/obj/item/tool/surgery/surgical_membrane = 100,
	)

	min_duration = FIX_ORGAN_MIN_DURATION
	max_duration = FIX_ORGAN_MAX_DURATION

	preop_sound = 'sound/misc/surgery/clothingrustle1.ogg'
	success_sound = 'sound/misc/surgery/organ1.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/internal/fix_organ/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(..())
		if(affected.body_part == HEAD)//brain and eye damage is fixed by a separate surgery
			return SURGERY_CANNOT_USE
		for(var/datum/internal_organ/I in affected.internal_organs)
			if(I.damage > 0)
				return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE

/datum/surgery_step/internal/fix_organ/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	for(var/datum/internal_organ/I in affected.internal_organs)
		if(I?.damage > 0)
			user.visible_message(span_notice("[user]开始用手术膜处理[target]的[I.name]所受的损伤."), \
			span_notice("你开始用手术膜处理[target]的[I.name]所受的损伤.") )
			target.balloon_alert_to_viewers("正在修复...")

	target.custom_pain("The pain in your [affected.display_name] is living hell!", 1)
	..()

/datum/surgery_step/internal/fix_organ/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	for(var/datum/internal_organ/I in affected.internal_organs)
		if(I?.damage > 0)

			user.visible_message(span_notice("[user]用手术膜处理了[target]的[I.name]所受的损伤."), \
			span_notice("你用手术膜处理了[target]的[I.name]所受的损伤.") )
			I.heal_organ_damage(I.damage)
			target.balloon_alert_to_viewers("成功")
	return ..()

/datum/surgery_step/internal/fix_organ/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手滑了一下,弄得一团糟,用\the [tool]撕裂了[target]的[affected.display_name]内部!"), \
	span_warning("你的手滑了一下,弄得一团糟,用\the [tool]撕裂了[target]的[affected.display_name]内部!"))
	target.balloon_alert_to_viewers("滑脱!")
	var/dam_amt = 2

	if(istype(tool, /obj/item/tool/surgery/surgical_membrane))
		target.adjust_tox_loss(5)

	for(var/datum/internal_organ/I in affected.internal_organs)
		if(I?.damage > 0)
			I.take_damage(dam_amt,0)
	target.update_health()
	affected.update_wounds()
