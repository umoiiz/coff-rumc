//Procedures in this file: Gneric surgery steps
//////////////////////////////////////////////////////////////////
//						COMMON STEPS							//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/generic
	can_infect = TRUE
	var/open_step

/datum/surgery_step/generic/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(target_zone == "eyes" || target_zone == "mouth") //There are specific steps for eye surgery and face surgery
		return SURGERY_CANNOT_USE
	if(!affected)
		return SURGERY_CANNOT_USE
	if(affected.limb_status & LIMB_DESTROYED)
		return SURGERY_CANNOT_USE
	if(!isnull(open_step) && affected.surgery_open_stage != open_step)
		return SURGERY_CANNOT_USE
	if(target_zone == "head" && target.species && (target.species.species_flags & (IS_SYNTHETIC|ROBOTIC_LIMBS)))
		return SURGERY_CAN_USE
	if(affected.limb_status & LIMB_ROBOT)
		return SURGERY_CANNOT_USE
	return SURGERY_CAN_USE

/datum/surgery_step/generic/incision_manager
	priority = 0.1 //Attempt before generic scalpel step
	allowed_tools = list(/obj/item/tool/surgery/scalpel/manager = 100)

	min_duration = INCISION_MANAGER_MIN_DURATION
	max_duration = INCISION_MANAGER_MAX_DURATION
	open_step = 0

	preop_sound = 'sound/misc/surgery/scalpel1.ogg'
	success_sound = 'sound/misc/surgery/scalpel2.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/generic/incision_manager/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]在[target]的[affected.display_name]上及其内部构造预备切口."), \
	span_notice("你开始用\the [tool]在[target]的[affected.display_name]上及其内部构造预备切口."))
	target.balloon_alert_to_viewers("切开中...")
	target.custom_pain("You feel a horrible, searing pain in your [affected.display_name] as it is pushed apart!",1)
	return ..()

/datum/surgery_step/generic/incision_manager/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]在[target]的[affected.display_name]上及其内部构造了预备切口."), \
	span_notice("你用\the [tool]在[target]的[affected.display_name]上及其内部构造了预备切口."),)
	target.balloon_alert_to_viewers("成功")
	affected.surgery_open_stage = 1

	if(istype(target) && !(target.species.species_flags & NO_BLOOD))
		affected.add_limb_flags(LIMB_BLEEDING)

	affected.createwound(CUT, 1)
	affected.clamp_bleeder() //Hemostat function, clamp bleeders
	affected.surgery_open_stage = 2 //Can immediately proceed to other surgery steps
	target.update_health()
	return ..()

/datum/surgery_step/generic/incision_manager/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手随着系统火花猛地一颤,用\the [tool]在[target]的[affected.display_name]上撕开了一个骇人的洞!"), \
	span_warning("你的手随着系统火花猛地一颤,用\the [tool]在[target]的[affected.display_name]上撕开了一个骇人的洞!"))
	target.balloon_alert_to_viewers("滑脱了!")
	affected.createwound(CUT, 20)
	affected.createwound(BURN, 15)
	affected.update_wounds()

/datum/surgery_step/generic/cut_with_laser
	priority = 0.1 //Attempt before generic scalpel step
	allowed_tools = list(
		/obj/item/tool/surgery/scalpel/laser3 = 95,
		/obj/item/weapon/energy/sword = 5,
	)

	min_duration = 60
	max_duration = 80
	open_step = 0
	can_infect = FALSE

	preop_sound = 'sound/misc/surgery/scalpel1.ogg'
	success_sound = 'sound/misc/surgery/scalpel2.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/generic/cut_with_laser/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]在[target]的[affected.display_name]上进行无血切口."), \
	span_notice("你开始用\the [tool]在[target]的[affected.display_name]上进行无血切口."))
	target.custom_pain("You feel a horrible, searing pain in your [affected.display_name]!", 1)
	target.balloon_alert_to_viewers("切割中...")
	return ..()

/datum/surgery_step/generic/cut_with_laser/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]在[target]的[affected.display_name]上完成了无血切口."), \
	span_notice("你用\the [tool]在[target]的[affected.display_name]上完成了无血切口."))
	target.balloon_alert_to_viewers("成功")
	//Could be cleaner
	affected.surgery_open_stage = 1

	if(istype(target) && !(target.species.species_flags & NO_BLOOD))
		affected.add_limb_flags(LIMB_BLEEDING)

	affected.createwound(CUT, 1)
	affected.clamp_bleeder() //Hemostat function, clamp bleeders
	//spread_germs_to_organ(affected, user) //I don't see the reason for infection with a clean laser incision, when scalpel or ICS is fine
	affected.update_wounds()
	return ..()

/datum/surgery_step/generic/cut_with_laser/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手一滑,刀刃发出杂音,用\the [tool]在[target]的[affected.display_name]上灼出一道长长的切口!"), \
	span_warning("你的手一滑,刀刃发出杂音,用\the [tool]在[target]的[affected.display_name]上灼出一道长长的切口!"))
	target.balloon_alert_to_viewers("滑脱了!")
	affected.createwound(CUT, 7.5)
	affected.createwound(BURN, 12.5)
	affected.update_wounds()

/datum/surgery_step/generic/cut_open
	allowed_tools = list(
		/obj/item/tool/surgery/scalpel = 100,
		/obj/item/tool/kitchen/knife = 75,
		/obj/item/shard = 50,
		/obj/item/weapon/combat_knife = 25,
		/obj/item/stack/throwing_knife = 15,
		/obj/item/weapon/sword/mercsword = 1,
	)

	min_duration = 60
	max_duration = 80
	open_step = 0

	preop_sound = 'sound/misc/surgery/scalpel1.ogg'
	success_sound = 'sound/misc/surgery/scalpel2.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/generic/cut_open/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]在[target]的[affected.display_name]上进行切口."), \
	span_notice("你开始用\the [tool]在[target]的[affected.display_name]上进行切口."))
	target.custom_pain("You feel a horrible pain as if from a sharp knife in your [affected.display_name]!", 1)
	target.balloon_alert_to_viewers("切割中...")
	return ..()

/datum/surgery_step/generic/cut_open/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]在[target]的[affected.display_name]上完成了切口."), \
	span_notice("你用\the [tool]在[target]的[affected.display_name]上完成了切口."),)
	target.balloon_alert_to_viewers("成功")
	affected.surgery_open_stage = 1

	if(istype(target) && !(target.species.species_flags & NO_BLOOD))
		affected.add_limb_flags(LIMB_BLEEDING)

	affected.createwound(CUT, 1)
	target.update_health()
	return ..()

/datum/surgery_step/generic/cut_open/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手一滑,用\the [tool]在错误的位置切开了[target]的[affected.display_name]!"), \
	span_warning("你的手一滑,用\the [tool]在错误的位置切开了[target]的[affected.display_name]!"))
	target.balloon_alert_to_viewers("滑脱了!")
	affected.createwound(CUT, 10)
	affected.update_wounds()



/datum/surgery_step/generic/clamp_bleeders
	allowed_tools = list(
		/obj/item/tool/surgery/hemostat = 100,
		/obj/item/stack/cable_coil = 75,
		/obj/item/assembly/mousetrap = 20,
	)

	min_duration = 40
	max_duration = 60

	preop_sound = 'sound/misc/surgery/hemostat1.ogg'
	success_sound = 'sound/misc/surgery/hemostat1.ogg'
	failure_sound = 'sound/misc/surgery/organ1.ogg'

/datum/surgery_step/generic/clamp_bleeders/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(..())
		if(affected.surgery_open_stage && !(affected.limb_wound_status & LIMB_WOUND_CLAMPED))
			return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE

/datum/surgery_step/generic/clamp_bleeders/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]在[target]的[affected.display_name]中钳夹出血点."), \
	span_notice("你开始用\the [tool]在[target]的[affected.display_name]中钳夹出血点."))
	target.custom_pain("The pain in your [affected.display_name] is maddening!", 1)
	target.balloon_alert_to_viewers("钳夹中...")
	return ..()

/datum/surgery_step/generic/clamp_bleeders/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]在[target]的[affected.display_name]中钳夹出血点."),	\
	span_notice("你用\the [tool]在[target]的[affected.display_name]中钳夹出血点."))
	target.balloon_alert_to_viewers("成功")
	affected.clamp_bleeder()
	spread_germs_to_organ(affected, user)
	return ..()

/datum/surgery_step/generic/clamp_bleeders/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手一滑,用\the [tool]撕裂了[target]的[affected.display_name]中的血管,造成大量出血!"),	\
	span_warning("你的手一滑,用\the [tool]撕裂了[target]的[affected.display_name]中的血管,造成大量出血!"),)
	target.balloon_alert_to_viewers("滑脱了!")
	affected.createwound(CUT, 10)
	affected.update_wounds()



/datum/surgery_step/generic/retract_skin
	allowed_tools = list(
		/obj/item/tool/surgery/retractor = 100,
		/obj/item/tool/crowbar = 75,
		/obj/item/tool/kitchen/utensil/fork = 50,
	)

	min_duration = 30
	max_duration = 40
	open_step = 1

	preop_sound = 'sound/misc/surgery/retractor1.ogg'
	success_sound = 'sound/misc/surgery/retractor2.ogg'
	failure_sound = 'sound/misc/surgery/organ1.ogg'

/datum/surgery_step/generic/retract_skin/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(target_zone == "groin")
		user.visible_message(span_notice("[user]开始用\the [tool]撬开切口并重新排列[target]下腹部的器官."), \
		span_notice("你开始用\the [tool]撬开切口并重新排列[target]下腹部的器官."))
	else
		user.visible_message(span_notice("[user]开始用\the [tool]撬开[target]的[affected.display_name]上的切口."), \
		span_notice("你开始用\the [tool]撬开[target]的[affected.display_name]上的切口."))
	target.custom_pain("It feels like the skin on your [affected.display_name] is on fire!", 1)
	target.balloon_alert_to_viewers("切割中...")
	return ..()

/datum/surgery_step/generic/retract_skin/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(target_zone == "chest")
		user.visible_message(span_notice("[user]用\the [tool]保持[target]躯干的胸腔敞开."), \
		span_notice("你用\the [tool]保持[target]躯干的胸腔敞开."))
	else if(target_zone == "groin")
		user.visible_message(span_notice("[user]用\the [tool]保持[target]下腹部的切口敞开."), \
		span_notice("你用\the [tool]保持[target]下腹部的切口敞开."))
	else
		user.visible_message(span_notice("[user]用\the [tool]保持[target]的[affected.display_name]上的切口敞开."), \
		span_notice("你用\the [tool]保持[target]的[affected.display_name]上的切口敞开."))
	target.balloon_alert_to_viewers("成功")
	affected.surgery_open_stage = 2
	return ..()

/datum/surgery_step/generic/retract_skin/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	if(target_zone == "chest")
		user.visible_message(span_warning("[user]的手一滑,用\the [tool]损伤了[target]躯干中的数个器官!"), \
		span_warning("你的手一滑,用\the [tool]损伤了[target]躯干中的数个器官!"))
	if(target_zone == "groin")
		user.visible_message(span_warning("[user]的手一滑,用\the [tool]损伤了[target]下腹部中的数个器官!"), \
		span_warning("你的手一滑,用\the [tool]损伤了[target]下腹部中的数个器官!"))
	else
		user.visible_message(span_warning("[user]的手一滑,用\the [tool]撕裂了[target]的[affected.display_name]上切口的边缘!"), \
		span_warning("你的手一滑,用\the [tool]撕裂了[target]的[affected.display_name]上切口的边缘!"))
	target.balloon_alert_to_viewers("滑脱了!")
	target.apply_damage(12, BRUTE, affected, 0, TRUE, updating_health = TRUE)
	affected.update_wounds()


/datum/surgery_step/generic/cauterize
	allowed_tools = list(
		/obj/item/tool/surgery/cautery = 100,
		/obj/item/clothing/mask/cigarette = 75,
		/obj/item/tool/lighter = 50,
		/obj/item/tool/weldingtool = 25,
	)

	min_duration = CAUTERY_MIN_DURATION
	max_duration = CAUTERY_MAX_DURATION
	can_infect = FALSE

	preop_sound = 'sound/misc/surgery/cautery1.ogg'
	success_sound = 'sound/misc/surgery/cautery2.ogg'
	failure_sound = 'sound/items/welder2.ogg'

/datum/surgery_step/generic/cauterize/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(..())
		if(affected.surgery_open_stage == 1 || affected.surgery_open_stage == 2)
			return SURGERY_CAN_USE
	return SURGERY_CANNOT_USE

/datum/surgery_step/generic/cauterize/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始用\the [tool]烧灼[target]的[affected.display_name]上的切口.") , \
	span_notice("你开始用\the [tool]烧灼[target]的[affected.display_name]上的切口."))
	target.custom_pain("Your [affected.display_name] is being burned!", 1)
	target.balloon_alert_to_viewers("烧灼中...")
	return ..()

/datum/surgery_step/generic/cauterize/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]用\the [tool]烧灼[target]的[affected.display_name]上的切口."), \
	span_notice("你用\the [tool]烧灼[target]的[affected.display_name]上的切口."))
	target.balloon_alert_to_viewers("成功")
	affected.surgery_open_stage = 0
	affected.remove_limb_flags(LIMB_BLEEDING)
	DISABLE_BITFIELD(affected.limb_wound_status, LIMB_WOUND_CLAMPED) //Once the incision is closed, any clamping we did doesn't matter
	return ..()

/datum/surgery_step/generic/cauterize/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手一滑,用\the [tool]在[target]的[affected.display_name]上留下了一处小烧伤!"), \
	span_warning("你的手一滑,用\the [tool]在[target]的[affected.display_name]上留下了一处小烧伤!"))
	target.balloon_alert_to_viewers("滑脱了!")
	target.apply_damage(3, BURN, affected, updating_health = TRUE)

///Sewing people closed. Not fast, but works on corpses.
/datum/surgery_step/generic/repair
	allowed_tools = list(
		/obj/item/tool/surgery/suture = 100,
		/obj/item/stack/cable_coil = 75,
		/obj/item/shard = 20,
	)
	surgery_skill_required = SKILL_SURGERY_TRAINED
	open_step = 0
	min_duration = SUTURE_MIN_DURATION
	max_duration = SUTURE_MAX_DURATION
	///Healing applied on step success, split between burn and brute
	var/base_healing = 37.5

	preop_sound = 'sound/misc/surgery/retractor1.ogg'
	success_sound = 'sound/misc/surgery/retractor2.ogg'
	failure_sound = 'sound/misc/surgery/organ2.ogg'

/datum/surgery_step/generic/repair/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected, checks_only)
	if(!..())
		return SURGERY_CANNOT_USE
	if(affected.has_external_wound())//limb has treatable damage
		return SURGERY_CAN_USE
	to_chat(user, span_notice("[target]的[affected.display_name]没有外伤.") )
	return SURGERY_INVALID

/datum/surgery_step/generic/repair/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]开始缝合[target]的[affected.display_name]上的伤口.")  , \
	span_notice("你开始缝合[target]的[affected.display_name]上的伤口.") )
	target.custom_pain("Your [affected.display_name] is getting stabbed!!", 1)
	target.balloon_alert_to_viewers("缝合中...")
	return ..()

/datum/surgery_step/generic/repair/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_notice("[user]缝合了[target]的[affected.display_name]上的部分伤口.") , \
	span_notice("你完成了[target]的[affected.display_name]上部分伤口的缝合.") )
	target.balloon_alert_to_viewers("成功")
	var/skilled_healing = base_healing * max(user.skills.getPercent(SKILL_SURGERY, SKILL_SURGERY_MASTER), 0.1)
	var/burn_heal = min(skilled_healing, affected.burn_dam)
	var/brute_heal = max(skilled_healing - burn_heal, 0)
	affected.heal_limb_damage(brute_heal, burn_heal, updating_health = TRUE) //Corpses need their health updated manually since they don't do it themselves
	return ..()

/datum/surgery_step/generic/repair/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/limb/affected)
	user.visible_message(span_warning("[user]的手一滑,用\the [tool]撕裂了[target]的皮肤!") , \
	span_warning("你的手一滑,用\the [tool]撕裂了[target]的皮肤!") )
	target.balloon_alert_to_viewers("滑脱了!")
	affected.take_damage_limb(5, updating_health = TRUE)
