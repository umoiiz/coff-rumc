/obj/item/restraints
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/security_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/security_right.dmi',
	)
	breakouttime = 2 MINUTES


/obj/item/restraints/resisted_against(datum/source)
	var/mob/living/carbon/perp = source
	if(TIMER_COOLDOWN_RUNNING(perp, COOLDOWN_RESIST))
		return FALSE

	perp.changeNext_move(CLICK_CD_RESIST)

	TIMER_COOLDOWN_START(perp, COOLDOWN_RESIST, CLICK_CD_BREAKOUT)

	perp.resist_restraints(src)


/mob/living/carbon/proc/resist_restraints(obj/item/restraints/cuffs)
	if(do_actions)
		balloon_alert(src, "忙碌")
		return

	visible_message(span_warning("[src]试图移除[cuffs]!"),
	span_notice("你试图移除[cuffs]... (这大约需要[DisplayTimeText(cuffs.breakouttime)],并且你需要保持静止.)"))

	if(!do_after(src, cuffs.breakouttime, IGNORE_HELD_ITEM, target = src))
		return FALSE

	visible_message(span_danger("[src]成功移除了[cuffs]!"),
	span_notice("你成功移除了[cuffs]."))

	dropItemToGround(cuffs) //This will call UnEquip() > update_handcuffed() > UnregisterSignal()
