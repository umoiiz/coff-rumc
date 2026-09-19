/obj/item/implanter/skill
	name = "技能植入器"
	desc = "一支无菌植入注射器, 通常用于植入技能增强植入体."
	icon_state = "skill"
	///Empty icon state
	var/empty_icon = "skill_s"

/obj/item/implanter/skill/examine(mob/user, distance, infix, suffix)
	. = ..()
	if(isnull(internal_implant))
		return
	var/obj/item/implant/skill/implant = internal_implant
	for(var/skill AS in implant.max_skills)
		. += span_notice("它只会将你的技能提升至[implant.max_skills[skill]]级.")

/obj/item/implanter/skill/update_icon_state()
	icon_state = internal_implant ? icon_state : empty_icon

/obj/item/implanter/skill/can_implant(mob/target, mob/user)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/human = target
	if(!(user.zone_selected in internal_implant.allowed_limbs))
		balloon_alert(user, "肢体错误!")
		return FALSE
	var/datum/limb/targetlimb = human.get_limb(user.zone_selected)
	for(var/obj/item/implant/skill/implant in targetlimb.implants)
		if(!istype(implant, /obj/item/implant/skill))
			balloon_alert(user, "肢体已植入!")
			return FALSE
	return TRUE

/obj/item/implanter/skill/cargo
	name = "货物技能植入器"
	desc = "一支无菌植入注射器. 这支用于植入非法技能植入体, 且只能使用一次."
	icon_state = "cargo"
	empty_icon = "cargo_full_s"
	/// Was implanter already spent?
	var/spent = FALSE

/obj/item/implanter/skill/cargo/attack_hand(mob/living/user)
	if(user.get_inactive_held_item() != src || !internal_implant)
		return ..()
	user.put_in_hands(internal_implant)
	internal_implant = null
	icon_state = initial(icon_state)
	spent = FALSE
