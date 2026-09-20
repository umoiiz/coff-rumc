#define BANDAGE (1<<0)
#define SALVE (1<<1)
#define DISINFECT (1<<2)

/obj/item/stack/medical
	name = "医疗包"
	singular_name = "medical pack"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_right.dmi',
	)
	amount = 10
	max_amount = 10
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 4
	throw_range = 20
	///Medical skill level needed to not get a fumble delay
	var/skill_level_needed = SKILL_MEDICAL_UNTRAINED
	///Fumble delay applied without sufficient skill
	var/unskilled_delay = SKILL_TASK_TRIVIAL

	var/alien = FALSE

/obj/item/stack/medical/attack_self(mob/user)
	. = ..()
	attack(user, user)

/obj/item/stack/medical/attack(mob/living/M, mob/living/user)
	. = ..()
	if(.)
		return

	if(!ishuman(M))
		M.balloon_alert(user, "不是人类")
		return FALSE
	var/mob/living/carbon/human/target = M

	if(!ishuman(user))
		target.balloon_alert(user, "不够灵巧")
		return FALSE

	if(user.do_actions)
		target.balloon_alert(user, "已经忙碌")
		return

	var/datum/limb/affecting = user?.client?.prefs?.toggles_gameplay & RADIAL_MEDICAL ? radial_medical(target, user) : target.get_limb(user.zone_selected)
	if(!user.get_active_held_item(src))
		return
	if(HAS_TRAIT(target, TRAIT_FOREIGN_BIO) && !alien)
		to_chat(user, span_warning("\The [src]与[target]的生理结构不兼容!"))
		return TRUE
	if(!affecting)
		return FALSE

	if(!can_affect_limb(affecting))
		target.balloon_alert(user, "肢体是[affecting.limb_status & LIMB_ROBOT ? "robotic": "organic"]!")
		return FALSE

	return affecting

///Checks for whether the limb is appropriately organic/robotic
/obj/item/stack/medical/proc/can_affect_limb(datum/limb/affecting)
	return !(affecting.limb_status & LIMB_ROBOT)

/obj/item/stack/medical/heal_pack
	name = "柏拉图式纱布"
	amount = 40
	max_amount = 40
	///How much brute damage this pack heals when applied to a limb
	var/heal_brute = 0
	///How much burn damage this pack heals when applied to a limb
	var/heal_burn = 0
	///Set of wound flags applied by use, including BANDAGE, SALVE, and DISINFECT
	var/heal_flags = NONE


/obj/item/stack/medical/heal_pack/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!.) // note this true/false is inverted because we want to get the limb
		return

	var/datum/limb/affecting = .
	var/mob/living/carbon/human/patient = M //If we've got to this point, the parent proc already checked they're human

	if(affecting.limb_status & LIMB_DESTROYED)
		patient.balloon_alert(user, "肢体已毁")
		return FALSE

	var/unskilled_penalty = (user.skills.getRating(SKILL_MEDICAL) < skill_level_needed) ? 0.5 : 1
	var/list/patient_limbs = patient.limbs.Copy()
	patient_limbs -= affecting
	while(affecting && amount)
		if(!do_after(user, SKILL_TASK_VERY_EASY / (unskilled_penalty ** 2), NONE, patient, BUSY_ICON_FRIENDLY, BUSY_ICON_MEDICAL, extra_checks = CALLBACK(src, PROC_REF(can_affect_limb), affecting)))
			patient.balloon_alert(user, "停止护理")
			return FALSE
		var/affected = heal_limb(affecting, unskilled_penalty)
		if(affected)
			use(1)
			record_healing(user,M)
		generate_treatment_messages(user, patient, affecting, affected)
		affecting = null
		while(!affecting)
			var/candidate = popleft(patient_limbs)
			if(can_heal_limb(candidate))
				affecting = candidate
				break
			if(!length(patient_limbs))
				break
	patient.balloon_alert(user, "完成护理")
	return TRUE

/// return TRUE if a given limb can be healed by src, FALSE otherwise
/obj/item/stack/medical/heal_pack/proc/can_heal_limb(datum/limb/affecting)
	if(!affecting)
		return FALSE
	if(affecting.limb_status & LIMB_DESTROYED)
		return FALSE
	if(!can_affect_limb(affecting))
		return FALSE
	if(heal_flags & BANDAGE && !affecting.is_bandaged())
		return TRUE
	if(heal_flags & SALVE && !affecting.is_salved())
		return TRUE
	if(heal_flags & DISINFECT && !affecting.is_disinfected())
		return TRUE
	return FALSE

///Applies the heal_pack to a specified limb. Unskilled penalty is a multiplier between 0 and 1 on brute/burn healing effectiveness
/obj/item/stack/medical/heal_pack/proc/heal_limb(datum/limb/affecting, unskilled_penalty)
	var/affected = FALSE
	if(heal_flags & BANDAGE)
		affected |= affecting.bandage()
	if(heal_flags & SALVE)
		affected |= affecting.salve()
	if(heal_flags & DISINFECT)
		affected |= affecting.disinfect()

	if(affected)
		affecting.heal_limb_damage(heal_brute * unskilled_penalty, heal_burn * unskilled_penalty, updating_health = TRUE)

	return affected

///Purely visual, generates the success/failure messages for using a health pack
/obj/item/stack/medical/heal_pack/proc/generate_treatment_messages(mob/user, mob/patient, datum/limb/target_limb, success)
	if(!success)
		to_chat(user, span_warning("[patient]的[target_limb.display_name]上的伤口已经处理过了."))
		return
	user.visible_message(span_green("[user]用[src]处理了[patient]的[target_limb.display_name]上的伤口."),
	span_green("你用[src]处理了[patient]的[target_limb.display_name]上的伤口.") )

/obj/item/stack/medical/heal_pack/gauze
	name = "纱布卷"
	singular_name = "medical gauze"
	desc = "一些无菌纱布,用于包裹血淋淋的残肢."
	icon_state = "brutepack"
	heal_brute = 3
	heal_flags = BANDAGE

/obj/item/stack/medical/heal_pack/gauze/generate_treatment_messages(mob/user, mob/patient, datum/limb/target_limb, success)
	if(!success)
		to_chat(user, span_warning("[patient]的[target_limb.display_name]上的伤口已经处理过了."))
		return
	user.visible_message(span_green("[user]包扎了[patient]的[target_limb.display_name]."),
		span_green("你包扎了[patient]的[target_limb.display_name].") )

/obj/item/stack/medical/heal_pack/ointment
	name = "药膏"
	desc = "用于治疗烧伤、感染伤口,以及缓解特殊部位的瘙痒。"
	gender = PLURAL
	singular_name = "ointment"
	icon_state = "ointment"
	heal_burn = 3
	heal_flags = SALVE

/obj/item/stack/medical/heal_pack/ointment/generate_treatment_messages(mob/user, mob/patient, datum/limb/target_limb, success)
	if(!success)
		to_chat(user, span_warning("[patient]的[target_limb.display_name]上的伤口已经处理过了。"))
		return
	user.visible_message(span_green("[user]为[patient]的[target_limb.display_name]涂抹药膏。"),
	span_green("你为[patient]的[target_limb.display_name]涂抹药膏。"))

/obj/item/stack/medical/heal_pack/gauze/sectoid
	name = "\improper 的治疗树脂包"
	singular_name = "healing resin pack"
	desc = "一个装满黏稠异形树脂的奇怪工具。似乎是用来覆盖伤口的。"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_fixovein"
	heal_brute = 20
	heal_burn = 20
	heal_flags = BANDAGE | SALVE | DISINFECT


/obj/item/stack/medical/heal_pack/advanced
	dir = NORTH
	atom_flags = DIRLOCK
	skill_level_needed = SKILL_MEDICAL_PRACTICED
	unskilled_delay = SKILL_TASK_EASY

/obj/item/stack/medical/heal_pack/advanced/bruise_pack
	name = "高级创伤包"
	singular_name = "advanced trauma kit"
	desc = "用于严重伤势的高级创伤包。"
	icon_state = "traumakit"
	heal_brute = 12
	heal_flags = BANDAGE | DISINFECT

/obj/item/stack/medical/heal_pack/advanced/bruise_pack/generate_treatment_messages(mob/user, mob/patient, datum/limb/target_limb, success)
	if(!success)
		to_chat(user, span_warning("[patient]的[target_limb.display_name]上的伤口已经处理过了。"))
		return
	user.visible_message(span_green("[user]清理[patient]的[target_limb.display_name]并用生物胶封闭伤口。"),
		span_green("你清理并封闭[patient]的[target_limb.display_name]上的所有伤口。"))

/obj/item/stack/medical/heal_pack/advanced/burn_pack
	name = "高级烧伤包"
	singular_name = "advanced burn kit"
	desc = "用于严重烧伤的高级治疗包。"
	icon_state = "burnkit"
	heal_burn = 12
	heal_flags = SALVE | DISINFECT

/obj/item/stack/medical/heal_pack/advanced/burn_pack/generate_treatment_messages(mob/user, mob/patient, datum/limb/target_limb, success)
	if(!success)
		to_chat(user, span_warning("[patient]的[target_limb.display_name]上的伤口已经处理过了。"))
		return
	user.visible_message(span_green("[user]用再生膜覆盖[patient]的[target_limb.display_name]上的伤口。"),
	span_green("你用再生膜覆盖[patient]的[target_limb.display_name]上的伤口。"))

/obj/item/stack/medical/splint
	name = "医用夹板"
	desc = "用于固定骨折。"
	singular_name = "medical splint"
	icon_state = "splint"
	amount = 5
	max_amount = 5
	skill_level_needed = SKILL_MEDICAL_PRACTICED
	unskilled_delay = SKILL_TASK_TOUGH
	///How much splint health per medical skill is applied
	var/applied_splint_health = 15


/obj/item/stack/medical/splint/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!.) // note this true/false is inverted because we want to get the limb
		return

	if(user.skills.getRating(SKILL_MEDICAL) < skill_level_needed)
		if(user.do_actions)
			M.balloon_alert(user, "已经忙着了")
			return FALSE
		if(!do_after(user, unskilled_delay, NONE, M, BUSY_ICON_UNSKILLED, BUSY_ICON_MEDICAL))
			return FALSE

	var/datum/limb/affecting = .
	if(M == user && ((!user.hand && affecting.body_part == ARM_RIGHT) || (user.hand && affecting.body_part == ARM_LEFT)))
		user.balloon_alert(user, "你正在使用那条手臂!")
		return
	if(affecting.apply_splints(src, user == M ? (applied_splint_health*max(user.skills.getRating(SKILL_MEDICAL) - 1, 0)) : applied_splint_health*user.skills.getRating(SKILL_MEDICAL), user, M))
		use(1)
		return TRUE
	return FALSE

/obj/item/stack/medical/heal_pack/advanced/bruise_pack/predator
	name = "疗伤草药"
	singular_name = "mending herb"
	desc = "由柔软叶片制成的药膏,用于涂抹瘀伤。"
	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "brute_herbs"
	heal_brute = 15
	alien = TRUE

/obj/item/stack/medical/heal_pack/ointment/predator
	name = "舒缓草药"
	singular_name = "soothing herb"
	desc = "由冰凉的蓝色花瓣制成的药膏,用于涂抹烧伤。"
	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "burn_herbs"
	heal_burn = 15
	alien = TRUE

/// return TRUE if a given limb can be healed by src, FALSE otherwise
/obj/item/stack/medical/heal_pack/can_heal_limb(datum/limb/affecting)
	if(zero_amount())
		return FALSE
	if(!affecting)
		return FALSE
	if(affecting.limb_status & LIMB_DESTROYED)
		return FALSE
	if(!can_affect_limb(affecting))
		return FALSE
	if(heal_flags & BANDAGE && !affecting.is_bandaged())
		return TRUE
	if(heal_flags & SALVE && !affecting.is_salved())
		return TRUE
	if(heal_flags & DISINFECT && !affecting.is_disinfected())
		return TRUE
	return FALSE

/obj/item/stack/medical/heal_pack/advanced/bruise_combat_pack
	name = "战斗创伤包"
	singular_name = "combat trauma kit"
	desc = "用于长时间战斗环境的昂贵大型医疗包。相比普通医疗包有更多空间和更好的药品。"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_right.dmi',
	)
	icon_state = "brute_advanced"
	worn_icon_state = "brute_advanced"
	amount = 140
	max_amount = 140
	w_class = WEIGHT_CLASS_NORMAL
	heal_brute = 15
	number_of_extra_variants = 6
	heal_flags = BANDAGE|DISINFECT

/obj/item/stack/medical/heal_pack/advanced/bruise_combat_pack/generate_treatment_messages(mob/user, mob/patient, datum/limb/target_limb, success)
	if(!success)
		to_chat(user, span_warning("[patient]的[target_limb.display_name]上的伤口已经处理过了。"))
		return
	user.visible_message(span_notice("[user]清理[patient]的[target_limb.display_name]并用生物胶封闭伤口。"),
		span_notice("你清理并封闭[patient]的[target_limb.display_name]上的所有伤口。"))

/obj/item/stack/medical/heal_pack/advanced/burn_combat_pack
	name = "战斗烧伤包"
	singular_name = "combat burn kit"
	desc = "用于长时间战斗环境的昂贵大型医疗包。相比普通医疗包有更多空间和更好的药品。"
	icon = 'icons/obj/stack_objects.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_right.dmi',
	)
	icon_state = "burn_advanced"
	worn_icon_state = "burn_advanced"
	w_class = WEIGHT_CLASS_NORMAL
	amount = 140
	max_amount = 140
	heal_burn = 15
	number_of_extra_variants = 6
	heal_flags = SALVE|DISINFECT

/obj/item/stack/medical/heal_pack/advanced/burn_combat_pack/generate_treatment_messages(mob/user, mob/patient, datum/limb/target_limb, success)
	if(!success)
		to_chat(user, span_warning("[patient]的[target_limb.display_name]上的伤口已经处理过了。"))
		return
	user.visible_message(span_notice("[user]用再生膜覆盖[patient]的[target_limb.display_name]上的伤口。"),
	span_notice("你用再生膜覆盖[patient]的[target_limb.display_name]上的伤口。"))

/obj/item/stack/medical/heal_pack/advanced/bruise_pack/predator
	name = "疗伤草药"
	singular_name = "mending herb"
	desc = "由柔软叶片制成的药膏,用于涂抹瘀伤。"
	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "brute_herbs"
	heal_brute = 15
	alien = TRUE

/obj/item/stack/medical/heal_pack/ointment/predator
	name = "舒缓草药"
	singular_name = "soothing herb"
	desc = "由冰凉的蓝色花瓣制成的药膏,用于涂抹烧伤。"
	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "burn_herbs"
	heal_burn = 15
	alien = TRUE

#undef BANDAGE
#undef SALVE
#undef DISINFECT
