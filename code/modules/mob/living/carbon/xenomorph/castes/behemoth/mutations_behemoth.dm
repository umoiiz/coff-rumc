#define STATUS_EFFECT_SHELL_FOUNDATIONS /datum/status_effect/behemoth/foundations
#define STATUS_EFFECT_SPUR_EARTH_MIGHT /datum/status_effect/behemoth/earth_might
#define STATUS_EFFECT_VEIL_GUIDED_CLAIM /datum/status_effect/behemoth/guided_claim

/datum/xeno_mutation/behemoth
	category = "Enhancement"
	caste_restrictions = list("behemoth")

/datum/status_effect/behemoth
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	/// The xenomorph that owns this status effect.
	var/mob/living/carbon/xenomorph/xenomorph_owner

/datum/xeno_mutation/behemoth/foundations
	name = "Foundations"
	desc = "你現在可以創建額外的土柱,但其最大生命值會降低."
	cost = 10
	icon_state = "shell_foundations"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SHELL_FOUNDATIONS
	buff_desc = "Increased Earth Pillars limit, reduced pillar health."

/atom/movable/screen/alert/status_effect/behemoth/foundations
	name = "Foundations"
	desc = "提高土柱上限,降低柱子生命值."
	icon_state = "xenobuff_attack"

/datum/status_effect/behemoth/foundations
	id = "upgrade_shell_foundations"
	alert_type = /atom/movable/screen/alert/status_effect/behemoth/foundations

/datum/status_effect/behemoth/foundations/on_apply()
	xenomorph_owner = owner
	var/datum/action/ability/activable/xeno/earth_riser/ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/earth_riser]
	if(!ability)
		return FALSE
	ability.creation_limit = FOUNDATIONS_MAXIMUM_AMOUNT
	ability.update_button_icon()
	return TRUE

/datum/status_effect/behemoth/foundations/on_remove()
	var/datum/action/ability/activable/xeno/earth_riser/ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/earth_riser]
	if(!ability)
		return
	ability.creation_limit = initial(ability.creation_limit)
	while(length(ability.active_pillars) > ability.creation_limit)
		ability.alternate_action_activate()
	ability.update_button_icon()
	return ..()

/datum/xeno_mutation/behemoth/earth_might
	name = "Earth's Might"
	desc = "手持土柱時,地裂將造成額外傷害,但會在此過程中損壞柱子."
	cost = 10
	icon_state = "spur_earth_might"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_SPUR_EARTH_MIGHT
	buff_desc = "Geocrush deals more damage while holding a Pillar, but takes damage."

/atom/movable/screen/alert/status_effect/behemoth/earth_might
	name = "Earth's Might"
	desc = "手持柱子時地裂造成更多傷害,但會受到傷害."
	icon_state = "xenobuff_attack"

/datum/status_effect/behemoth/earth_might
	id = "upgrade_spur_earth_might"
	alert_type = /atom/movable/screen/alert/status_effect/behemoth/earth_might

/datum/status_effect/behemoth/earth_might/on_apply()
	xenomorph_owner = owner
	var/datum/action/ability/activable/xeno/geocrush/ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/geocrush]
	if(!ability)
		return FALSE
	ability.spur_mutation = TRUE
	return TRUE

/datum/status_effect/behemoth/earth_might/on_remove()
	var/datum/action/ability/activable/xeno/geocrush/ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/geocrush]
	if(!ability)
		return
	ability.spur_mutation = FALSE
	return ..()

/datum/xeno_mutation/behemoth/guided_claim
	name = "Guided Claim"
	desc = "奪取的範圍增加."
	cost = 10
	icon_state = "veil_guided_claim"
	tier = 1
	parent_name = null
	child_name = null
	status_effect_type = STATUS_EFFECT_VEIL_GUIDED_CLAIM
	buff_desc = "Increased Seize range."

/atom/movable/screen/alert/status_effect/behemoth/guided_claim
	name = "Guided Claim"
	desc = "增加奪取範圍."
	icon_state = "xenobuff_attack"

/datum/status_effect/behemoth/guided_claim
	id = "upgrade_veil_guided_claim"
	alert_type = /atom/movable/screen/alert/status_effect/behemoth/guided_claim

/datum/status_effect/behemoth/guided_claim/on_apply()
	xenomorph_owner = owner
	var/datum/action/ability/activable/xeno/behemoth_seize/ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/behemoth_seize]
	if(!ability)
		return FALSE
	ability.action_range += GUIDED_CLAIM_ADDITIONAL_RANGE
	return TRUE

/datum/status_effect/behemoth/guided_claim/on_remove()
	var/datum/action/ability/activable/xeno/behemoth_seize/ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/behemoth_seize]
	if(!ability)
		return
	ability.action_range -= GUIDED_CLAIM_ADDITIONAL_RANGE
	return ..()
