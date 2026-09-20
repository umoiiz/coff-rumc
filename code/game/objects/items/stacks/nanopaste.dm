/obj/item/stack/nanopaste
	name = "纳米修复膏"
	singular_name = "nanite swarm"
	desc = "一管含有修复纳米机器人集群的膏体。在修复机械装置方面非常有效。"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "tube"
	amount = 10
	max_amount = 10
	w_class = WEIGHT_CLASS_SMALL


/obj/item/stack/nanopaste/attack(mob/living/M as mob, mob/user as mob)
	if (!istype(M) || !istype(user))
		return 0

	if (istype(M,/mob/living/carbon/human))		//Repairing robolimbs
		var/mob/living/carbon/human/H = M
		var/datum/limb/S = H.get_limb(user.zone_selected)

		if(H.species.species_flags & IS_SYNTHETIC)
			H.set_blood_volume(BLOOD_VOLUME_NORMAL)

		if(S.surgery_open_stage == 0)
			if (S && (S.limb_status & LIMB_ROBOT))
				if(user.do_actions || !do_after(user, 1 SECONDS, NONE, src, BUSY_ICON_MEDICAL))
					return
				if(S.get_damage())
					S.heal_limb_damage(15, 15, robo_repair = TRUE, updating_health = TRUE)
					use(1)
					user.visible_message(span_notice("[user]用[src]在[user != M ? "[M]'s" : ""]的[S.display_name]上涂抹了一些纳米修复膏。"),\
					span_notice("你在[user == M ? "your" : "[M]'s"]的[S.display_name]上涂抹了一些纳米修复膏。"))
				else
					to_chat(user, span_notice("这里没什么可修的。"))
		else
			if (H.can_be_operated_on())
				if (do_surgery(H,user,src))
					return
			else
				to_chat(user, span_notice("这里面没什么可修的。"))
