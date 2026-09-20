#define STATUS_EFFECT_DRONE_SCOUT /datum/status_effect/drone/scout
#define STATUS_EFFECT_DRONE_TIC /datum/status_effect/drone/together_in_claws
#define STATUS_EFFECT_DRONE_REVENGE /datum/status_effect/drone/revenge
#define STATUS_EFFECT_DRONE_SAVING_GRACE /datum/status_effect/drone/saving_grace

/datum/xeno_mutation/drone
	category = "Enhancement"
	caste_restrictions = list("drone")

/datum/status_effect/drone
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	/// The xenomorph that owns this status effect.
	var/mob/living/carbon/xenomorph/xenomorph_owner

/datum/xeno_mutation/drone/scout
	name = "Scout"
	desc = "站在草丛上时获得显著的护甲加成。"
	cost = 7.5
	icon_state = "drone_scout"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DRONE_SCOUT
	buff_desc = "+15 soft armor while on weeds"

/atom/movable/screen/alert/status_effect/drone/scout
	name = "Scout"
	desc = "在草丛上时+15护甲"
	icon_state = "xenobuff_attack"

/datum/status_effect/drone/scout
	id = "upgrade_drone_scout"
	alert_type = /atom/movable/screen/alert/status_effect/drone/scout

	var/armor = 15
	/// The attached armor that been given, if any.
	var/datum/armor/attached_armor
	/// Timer ID for a proc that revokes the armor given when it times out.
	var/timer_id
	/// How long should the armor be given?
	var/timer_length = 5 SECONDS

/datum/status_effect/drone/scout/on_apply()
	xenomorph_owner = owner
	RegisterSignal(xenomorph_owner, COMSIG_LIVING_WEEDS_AT_LOC_CREATED, PROC_REF(entered_weeds))
	RegisterSignal(xenomorph_owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement))
	if(xenomorph_owner.loc_weeds_type)
		grant_armor()
		return TRUE
	entered_weeds(xenomorph_owner, xenomorph_owner.loc_weeds_type)
	return TRUE

/datum/status_effect/drone/scout/on_remove()
	UnregisterSignal(xenomorph_owner, list(COMSIG_LIVING_WEEDS_AT_LOC_CREATED, COMSIG_MOVABLE_MOVED))
	revoke_armor()
	return ..()

/// Grants armor and removes the timer.
/datum/status_effect/drone/scout/proc/grant_armor()
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	if(attached_armor)
		return
	var/total_armor = 15
	attached_armor = new(total_armor, total_armor, total_armor, total_armor, total_armor, total_armor, total_armor, total_armor)
	xenomorph_owner.soft_armor = xenomorph_owner.soft_armor.attachArmor(attached_armor)

/// Removes armor and the timer.
/datum/status_effect/drone/scout/proc/revoke_armor()
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	if(!attached_armor)
		return
	xenomorph_owner.soft_armor = xenomorph_owner.soft_armor.detachArmor(attached_armor)
	attached_armor = null

/// Grant armor if they are on weeds. Remove armor if they leave weeds.
/datum/status_effect/drone/scout/proc/on_movement(datum/source, atom/old_loc, movement_dir, forced, list/old_locs)
	SIGNAL_HANDLER
	var/obj/alien/weeds/found_weed = locate(/obj/alien/weeds) in xenomorph_owner.loc
	if(found_weed)
		// On weeds - give armor immediately
		grant_armor()
		return
	// Not on weeds - remove armor after timer
	entered_weeds(xenomorph_owner, null)

/datum/status_effect/drone/scout/proc/entered_weeds(datum/source, obj/alien/weeds/location_weeds)
	SIGNAL_HANDLER
	// When NOT on weeds, remove armor after timer_length
	if(timer_id)
		return
	timer_id = addtimer(CALLBACK(src, PROC_REF(revoke_armor)), timer_length, TIMER_STOPPABLE|TIMER_UNIQUE)

//
//
//

/datum/xeno_mutation/drone/together_in_claws
	name = "Together In Claws"
	desc = "从伙伴造成的伤害中回复20%。"
	cost = 5
	icon_state = "drone_together_in_claws"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DRONE_TIC
	buff_desc = "+20% heal from Essence Link partner's damage"

/atom/movable/screen/alert/status_effect/drone/together_in_claws
	name = "Together In Claws"
	desc = "从伙伴的伤害中回复20%"
	icon_state = "xenobuff_attack"

/datum/status_effect/drone/together_in_claws
	id = "upgrade_drone_together_in_claws"
	alert_type = /atom/movable/screen/alert/status_effect/drone/together_in_claws

	/// For the first structure, the percentage to lifesteal.
	var/percentage_initial = 0.2

/datum/status_effect/drone/together_in_claws/on_apply()
	xenomorph_owner = owner
	var/datum/action/ability/activable/xeno/essence_link/ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/essence_link]
	if(!ability)
		return FALSE
	ability.lifesteal_percentage += get_lifesteal(0)
	if(ability.existing_link)
		ability.existing_link.set_lifesteal(ability.lifesteal_percentage)
	return TRUE

/datum/status_effect/drone/together_in_claws/on_remove()
	var/datum/action/ability/activable/xeno/essence_link/ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/essence_link]
	if(!ability)
		return
	ability.lifesteal_percentage -= get_lifesteal(0)
	if(ability.existing_link)
		ability.existing_link.set_lifesteal(ability.lifesteal_percentage)
	return ..()

/// Returns the amount that Essence Link's lifesteal should be.
/datum/status_effect/drone/together_in_claws/proc/get_lifesteal(structure_count, include_initial = TRUE)
	return (include_initial ? percentage_initial : 0)

//
//
//

/datum/xeno_mutation/drone/revenge
	name = "Revenge"
	desc = "如果精华链接因某人死亡而中断,幸存者获得+100%伤害,持续15秒。"
	cost = 5
	icon_state = "drone_revenge"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DRONE_REVENGE
	buff_desc = "+100% damage to survivour if someone dies in link for 15 seconds"

/atom/movable/screen/alert/status_effect/drone/revenge
	name = "Revenge"
	desc = "如果链接中有人死亡,幸存者获得+100%伤害"
	icon_state = "xenobuff_attack"

/datum/status_effect/drone/revenge
	id = "upgrade_drone_revenge"
	alert_type = /atom/movable/screen/alert/status_effect/drone/revenge

	/// For the first structure, the melee damage multiplier to increase by.
	var/modifier_initial = 1

/datum/status_effect/drone/revenge/on_apply()
	xenomorph_owner = owner
	var/datum/action/ability/activable/xeno/essence_link/ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/essence_link]
	if(!ability)
		return
	ability.revenge_modifier += get_modifier(0)
	if(ability.existing_link)
		ability.existing_link.revenge_modifier  += get_modifier(0)
	return TRUE

/datum/status_effect/drone/revenge/on_remove()
	var/datum/action/ability/activable/xeno/essence_link/ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/essence_link]
	if(!ability)
		return
	ability.revenge_modifier -= get_modifier(0)
	if(ability.existing_link)
		ability.existing_link.revenge_modifier += get_modifier(0)
	return ..()

/// Returns the amount that Essence Link's revenge modifier should be.
/datum/status_effect/drone/revenge/proc/get_modifier(structure_count, include_initial = TRUE)
	return (include_initial ? modifier_initial : 0)

//
//
//

/datum/xeno_mutation/drone/saving_grace
	name = "Saving Grace"
	desc = "治疗已链接伙伴时,药膏治疗没有施法时间。"
	cost = 5
	icon_state = "drone_saving_grace"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_DRONE_SAVING_GRACE
	buff_desc = "No cast time for Salve Heal if healing linked partner"

/atom/movable/screen/alert/status_effect/drone/saving_grace
	name = "Saving Grace"
	desc = "没有施法时间,若治疗已链接伙伴"
	icon_state = "xenobuff_attack"

/datum/status_effect/drone/saving_grace
	id = "upgrade_drone_saving_grace"
	alert_type = /atom/movable/screen/alert/status_effect/drone/saving_grace

/datum/status_effect/drone/saving_grace/on_apply()
	xenomorph_owner = owner
	var/datum/action/ability/activable/xeno/psychic_cure/acidic_salve/ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/psychic_cure/acidic_salve]
	if(!ability)
		return FALSE
	ability.saving_grace_enabled = TRUE
	return TRUE

/datum/status_effect/drone/saving_grace/on_remove()
	var/datum/action/ability/activable/xeno/psychic_cure/acidic_salve/ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/psychic_cure/acidic_salve]
	if(!ability)
		return
	ability.saving_grace_enabled = FALSE
	return ..()
