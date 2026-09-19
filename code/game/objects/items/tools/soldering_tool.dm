/obj/item/tool/surgery/solderingtool
	name = "焊接工具"
	desc = "用于修复战斗机器人创伤的手持工具. 你不需要焊接护目镜."
	icon = 'icons/obj/items/surgery_tools.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/surgery_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/surgery_right.dmi',
	)
	icon_state = "solderingtool"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/tool/surgery/solderingtool/attack(mob/living/carbon/human/H, mob/user)
	if(!istype(H) || user.a_intent != INTENT_HELP)
		return ..()

	var/datum/limb/affecting = CHECK_BITFIELD(user.client.prefs.toggles_gameplay, RADIAL_MEDICAL) ? radial_medical(H, user) : H.get_limb(user.zone_selected)
	if(!affecting)
		return TRUE

	if(!CHECK_BITFIELD(affecting.limb_status, LIMB_ROBOT))
		balloon_alert(user, "肢体不是机械的")
		return TRUE

	if(!affecting.burn_dam && !affecting.brute_dam)
		balloon_alert(user, "没什么可修的!")
		return TRUE

	if(user.do_actions)
		balloon_alert(user, "已经在忙了!")
		return TRUE

	var/repair_time = 1.5 SECONDS
	if(H == user)
		repair_time *= 1.5

	user.visible_message(span_notice("[user]开始焊接[H == user ? "[H.p_their()]" : "[H]'s"][affecting.display_name]上的伤口."),\
		span_notice("你开始焊接[H == user ? "your" : "[H]'s"][affecting.display_name]上的伤口."))

	while((affecting.burn_dam || affecting.brute_dam) && do_after(user, repair_time, NONE, H, BUSY_ICON_BUILD))
		user.visible_message(span_warning("\The [user]用\the [src]焊接了[H == user ? "[H.p_their()]" : "[H]'s"][affecting.display_name]上的伤口."), \
			span_warning("你焊接了[H == user ? "your" : "[H]'s"][affecting.display_name]上的伤口."))
		if(affecting.heal_limb_damage(10, 10, robo_repair = TRUE, updating_health = TRUE))
			H.UpdateDamageIcon()
		if(!(affecting.brute_dam || affecting.burn_dam))
			var/previous_limb = affecting
			for(var/datum/limb/checked_limb AS in H.limbs)
				if(!(checked_limb.limb_status & LIMB_ROBOT))
					continue
				if(!(checked_limb.brute_dam || checked_limb.burn_dam))
					continue
				affecting = checked_limb
				break
			if(previous_limb == affecting)
				balloon_alert(user, "完全修复.")
				break
	return TRUE
