////////////////////////////////////////////////////////////////////////////////
/// Droppers.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/dropper
	name = "滴管"
	desc = "一个滴管. 可转移5单位."
	icon = 'icons/obj/items/chemistry.dmi'
	icon_state = "dropper0"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(1,2,3,4,5)
	w_class = WEIGHT_CLASS_TINY
	volume = 5
	reagent_flags = TRANSPARENT
	var/filled = 0

/obj/item/reagent_containers/dropper/afterattack(obj/target, mob/user , flag)
	if(!target.reagents || !flag)
		return

	if(filled)

		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			balloon_alert(user, "不行, 满了")
			return

		if(!target.is_injectable() && !ismob(target)) //You can inject humans and food but you cant remove the shit.
			balloon_alert(user, "无法填充物体")
			return

		var/trans = 0

		if(ismob(target))

			var/time = 20 //2/3rds the time of a syringe
			visible_message(span_danger("[user]正试图往[target]的眼睛里滴什么东西!"))

			if(!do_after(user, time, NONE, target, BUSY_ICON_HOSTILE))
				return

			if(ishuman(target))
				var/mob/living/carbon/human/victim = target

				var/obj/item/safe_thing = null
				if( victim.wear_mask )
					if ( victim.wear_mask.inventory_flags & COVEREYES )
						safe_thing = victim.wear_mask
				if( victim.head )
					if ( victim.head.inventory_flags & COVEREYES )
						safe_thing = victim.head
				if(victim.glasses)
					if ( !safe_thing )
						safe_thing = victim.glasses

				if(safe_thing)
					if(!safe_thing.reagents)
						safe_thing.create_reagents(100)
					trans = src.reagents.trans_to(safe_thing, amount_per_transfer_from_this)

					visible_message(span_danger("[user]试图往[target]的眼睛里滴什么东西, 但失败了!"))
					addtimer(CALLBACK(reagents, TYPE_PROC_REF(/datum/reagents, reaction), safe_thing, TOUCH), 5)

					balloon_alert(user, "转移[trans]单位")
					if (src.reagents.total_volume<=0)
						filled = 0
						icon_state = "dropper[filled]"
					return

			visible_message(span_danger("[user]往[target]的眼睛里滴了什么东西!"))
			src.reagents.reaction(target, TOUCH)

			var/mob/living/M = target

			var/list/injected = list()
			for(var/datum/reagent/R in src.reagents.reagent_list)
				injected += R.name
			var/contained = english_list(injected)
			log_combat(user, M, "squirted", src, "Reagents: [contained]")
			record_reagent_consumption(min(amount_per_transfer_from_this, reagents.total_volume), reagents.reagent_list, user, M)

		trans = src.reagents.trans_to(target, amount_per_transfer_from_this)
		balloon_alert(user, "转移[trans]单位")
		if (src.reagents.total_volume<=0)
			filled = 0
			icon_state = "dropper[filled]"

	else

		if(!target.is_open_container() && !istype(target,/obj/structure/reagent_dispensers))
			balloon_alert(user, "无法移除试剂")
			return

		if(!target.reagents.total_volume)
			balloon_alert(user, "空")
			return

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this)

		balloon_alert(user, "用[trans]单位填充滴管")

		filled = 1
		icon_state = "dropper[filled]"

////////////////////////////////////////////////////////////////////////////////
/// Droppers. END
////////////////////////////////////////////////////////////////////////////////
