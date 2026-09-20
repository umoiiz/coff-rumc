/datum/surgery_step/mcomp_wounds
	var/required_trait = TRAIT_YAUTJA_TECH// Only predators can do this
	var/depth_op = 0

/datum/surgery_step/mcomp_wounds/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(target_zone != "chest")
		return SURGERY_CANNOT_USE
	if(HAS_TRAIT(user, required_trait) && (target.get_brute_loss() || target.get_fire_loss() || depth_op) && affected.surgery_open_stage == depth_op) //Heals brute or burn
		return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE

//------------------------------------

/datum/surgery_step/mcomp_wounds/mstabilize_wounds
	allowed_tools = list(
		/obj/item/tool/surgery/stabilizer_gel = 100,
		/obj/item/tool/surgery/bonegel = 60,
		/obj/item/stack/cable_coil = 40,
	)
	min_duration = 1 SECONDS
	max_duration = 5 SECONDS

	blood_level = 1
	depth_op = 0

/datum/surgery_step/mcomp_wounds/mstabilize_wounds/begin_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(user == target)
		user.visible_message(span_notice("[user]开始用[tool]稳定自身身上的伤口."),
		span_notice("你开始用[tool]稳定自身的伤口."))
	else
		user.affected_message(target,
		span_notice("你开始用[tool]稳定[target]身上的伤口."),
		span_notice("[user]开始用[tool]稳定你身上的伤口."),
		span_notice("[user]开始用[tool]稳定[target]身上的伤口."))

/datum/surgery_step/mcomp_wounds/mstabilize_wounds/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	target.heal_overall_damage(40,40)
	playsound(target, 'sound/misc/cautery.ogg', 25)

	if(isyautja(target))
		target.emote("click2")
	else
		target.emote("pain")

	affected.surgery_open_stage = 0.25
	if(user == target)
		user.visible_message(span_notice("[user]用[tool]完成了对自身伤口的稳定."),
			span_notice("你用[tool]完成了对自身伤口的稳定."))
	else
		user.affected_message(target,
			span_notice("你用[tool]完成了对[target]伤口的稳定."),
			span_notice("[user]用[tool]完成了对你伤口的稳定."),
			span_notice("[user]用[tool]完成了对[target]伤口的治疗."))

/datum/surgery_step/mcomp_wounds/mstabilize_wounds/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	return FALSE

/datum/surgery_step/mcomp_wounds/mtend_wounds
	allowed_tools = list(
		/obj/item/tool/surgery/healing_gun = 100,
	)
	min_duration = 12 SECONDS
	max_duration = 15 SECONDS

	blood_level = 1
	depth_op = 0.25

/datum/surgery_step/mcomp_wounds/mtend_wounds/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	. = ..()

	if(!.)
		return FALSE

	var/obj/item/tool/surgery/healing_gun/gun = tool
	if(!gun.loaded)
		to_chat(user, span_warning("枪里没有胶囊你就无法治疗自己!"))
		return FALSE
	return TRUE

/datum/surgery_step/mcomp_wounds/mtend_wounds/begin_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	playsound(target, 'sound/misc/heal_gun.ogg', 25)
	flick("healing_gun_on", tool)

	if(user == target)
		user.visible_message(span_notice("[user]开始用[tool]处理其身上已稳定的伤口."),
		span_notice("你开始用[tool]处理自己身上已稳定的伤口."))
	else
		user.affected_message(target,
			span_notice("你开始用[tool]处理[target]身上已稳定的伤口."),
			span_notice("[user]开始用[tool]处理你身上已稳定的伤口."),
			span_notice("[user]开始用[tool]处理[target]身上已稳定的伤口."))

	target.custom_pain("It feels like your body is being stabbed with needles - because it is!")

/datum/surgery_step/mcomp_wounds/mtend_wounds/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	target.heal_overall_damage(65,65)

	for(var/datum/internal_organ/organ in target.internal_organs) //Fixes all organs
		organ.heal_organ_damage(100)

	affected.surgery_open_stage = 0.75
	if(isyautja(target))
		target.emote("click")
	else
		target.emote("pain")

	if(user == target)
		user.visible_message(span_notice("[user]用[tool]完成了对其身上已稳定伤口的处理."),
			span_notice("你用[tool]完成了对自己身上已稳定伤口的处理."))
	else
		user.affected_message(target,
			span_notice("你用[tool]完成了对[target]已稳定伤口的处理."),
			span_notice("[user]用[tool]完成了对你已稳定伤口的处理."),
			span_notice("[user]用[tool]完成了对[target]已稳定伤口的处理."))

	if(!istype(tool, /obj/item/tool/surgery/healing_gun))
		return
	var/obj/item/tool/surgery/healing_gun/gun = tool
	gun.loaded = FALSE
	gun.update_icon()

/datum/surgery_step/mcomp_wounds/mtend_wounds/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	return FALSE

/datum/surgery_step/mcomp_wounds/mclamp_wound
	allowed_tools = list(
		/obj/item/tool/surgery/wound_clamp = 100,
		/obj/item/tool/surgery/cautery = 60,
	)
	min_duration = 4 SECONDS
	max_duration = 10 SECONDS

	depth_op = 0.75

/datum/surgery_step/mcomp_wounds/mclamp_wound/begin_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	playsound(target, 'sound/misc/cautery2.ogg', 25)
	flick("wound_clamp_on", tool)

	if(user == target)
		user.visible_message(span_notice("[user]开始用[tool]缝合其身上已处理的伤口."),
			span_notice("你开始用[tool]缝合自己已处理的伤口."))
	else
		user.affected_message(target,
			span_notice("你开始用[tool]缝合[target]身上已处理的伤口."),
			span_notice("[user]开始用[tool]夹合你身上已处理的伤口."),
			span_notice("[user]开始用[tool]夹合[target]身上已处理的伤口."))

/datum/surgery_step/mcomp_wounds/mclamp_wound/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	target.heal_overall_damage(65,65) //makes sure that all damage is healed
	playsound(target, 'sound/misc/cautery.ogg', 25)

	if(user == target)
		user.visible_message(span_notice("[user]用[tool]完成了对其身上已处理伤口的缝合."),
			span_notice("你用[tool]完成了对自己身上已处理伤口的缝合."))
	else
		user.affected_message(target,
			span_notice("你用[tool]完成了对[target]已处理伤口的缝合."),
			span_notice("[user]用[tool]完成了对你已处理伤口的缝合."),
			span_notice("[user]用[tool]完成了对[target]已处理伤口的缝合."))

	if(isyautja(target))
		target.emote("loudroar")
	else
		target.emote("pain")

	affected.surgery_open_stage = 0

/datum/surgery_step/mcomp_wounds/mclamp_wound/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	return FALSE
