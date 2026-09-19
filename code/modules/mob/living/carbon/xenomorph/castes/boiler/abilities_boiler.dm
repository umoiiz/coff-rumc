//Defines for boiler globs. Their icon states, specifically. Also used to reference their typepaths and for the radials.
#define BOILER_GLOB_NEURO "neuro_glob"
#define BOILER_GLOB_ACID "acid_glob"
#define BOILER_GLOB_NEURO_LANCE	"neuro_lance_glob"
#define BOILER_GLOB_ACID_LANCE	"acid_lance_glob"

///List of globs, keyed by icon state. Used for radial selection.
GLOBAL_LIST_INIT(boiler_glob_list, list(
	BOILER_GLOB_ACID = /datum/ammo/xeno/boiler_gas/corrosive,
	BOILER_GLOB_ACID_LANCE = /datum/ammo/xeno/boiler_gas/corrosive/lance,
))

///List of glob action button images, used for radial selection.
GLOBAL_LIST_INIT(boiler_glob_image_list, list(
	BOILER_GLOB_ACID = image('icons/Xeno/actions/boiler.dmi', icon_state = BOILER_GLOB_ACID),
	BOILER_GLOB_ACID_LANCE = image('icons/Xeno/actions/boiler.dmi', icon_state = BOILER_GLOB_ACID_LANCE),
))

// ***************************************
// *********** Long range sight
// ***************************************

/datum/action/ability/xeno_action/toggle_long_range
	name = "Toggle Long Range Sight"
	desc = "朝你面朝的方向激活你的武器瞄具. 必须保持静止才能使用."
	action_icon_state = "toggle_long_range"
	action_icon = 'icons/Xeno/actions/boiler.dmi'
	ability_cost = 20
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_LONG_RANGE_SIGHT,
	)

/datum/action/ability/xeno_action/toggle_long_range/action_activate()
	if(xeno_owner.xeno_flags & XENO_ZOOMED)
		xeno_owner.zoom_out()
		xeno_owner.visible_message(span_notice("[xeno_owner]不再眺望远方."), \
		span_notice("我们不再眺望远方."), null, 5)
	else
		xeno_owner.visible_message(span_notice("[xeno_owner]开始眺望远方."), \
			span_notice("我们开始聚焦视线眺望远方."), null, 5)
		if(!do_after(xeno_owner, 1 SECONDS, IGNORE_HELD_ITEM, null, BUSY_ICON_GENERIC) || xeno_owner.xeno_flags & XENO_ZOOMED)
			return
		xeno_owner.zoom_in(11)
		return ..()

// ***************************************
// *********** Gas type toggle
// ***************************************

/datum/action/ability/xeno_action/toggle_bomb
	name = "Toggle Bombard Type"
	desc = "在可用的酸液球类型之间切换轰击者的轰击类型."
	action_icon_state = "toggle_bomb0"
	action_icon = 'icons/Xeno/actions/boiler.dmi'
	use_state_flags = ABILITY_USE_BUSY|ABILITY_USE_LYING
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TOGGLE_BOMB,
		KEYBINDING_ALTERNATE = COMSIG_XENOABILITY_TOGGLE_BOMB_RADIAL,
	)

/datum/action/ability/xeno_action/toggle_bomb/action_activate()
	var/list/spit_types = xeno_owner.xeno_caste.spit_types
	var/found_pos = spit_types.Find(xeno_owner.ammo?.type)
	if(!found_pos)
		xeno_owner.ammo = GLOB.ammo_list[spit_types[1]]
	else
		xeno_owner.ammo = GLOB.ammo_list[spit_types[(found_pos % length(spit_types)) + 1]]	//Loop around if we would exceed the length
	var/datum/ammo/xeno/boiler_gas/corrosive/boiler_glob = xeno_owner.ammo
	to_chat(xeno_owner, span_notice(boiler_glob.select_text))
	update_button_icon()

/datum/action/ability/xeno_action/toggle_bomb/alternate_action_activate()
	. = COMSIG_KB_ACTIVATED
	if(!can_use_action())
		return
	if(length(xeno_owner.xeno_caste.spit_types) <= 2)	//If we only have two or less glob types, we just use default select anyways.
		action_activate()
		return
	INVOKE_ASYNC(src, PROC_REF(select_glob_radial))

/**
 * Opens a radial menu to select a glob in and sets current ammo to the selected result.
 * * On selecting nothing, merely keeps current ammo.
 * * Dynamically adjusts depending on which globs a boiler has access to, provided the global lists are maintained, though this fact isn't too relevant unless someone adds more.
**/
/datum/action/ability/xeno_action/toggle_bomb/proc/select_glob_radial()
	var/list/available_globs = list()
	for(var/datum/ammo/xeno/boiler_gas/corrosive/glob_type AS in xeno_owner.xeno_caste.spit_types)
		var/glob_image = GLOB.boiler_glob_image_list[initial(glob_type.icon_key)]
		if(!glob_image)
			continue
		available_globs[initial(glob_type.icon_key)] = glob_image

	var/glob_choice = show_radial_menu(owner, owner, available_globs, radius = 48)
	if(!glob_choice)
		return
	var/referenced_path = GLOB.boiler_glob_list[glob_choice]
	xeno_owner.ammo = GLOB.ammo_list[referenced_path]
	var/datum/ammo/xeno/boiler_gas/corrosive/boiler_glob = xeno_owner.ammo
	to_chat(xeno_owner, span_notice(boiler_glob.select_text))
	update_button_icon()

/datum/action/ability/xeno_action/toggle_bomb/update_button_icon()
	var/datum/ammo/xeno/boiler_gas/corrosive/boiler_glob = xeno_owner.ammo	//Should be safe as this always selects a ammo.
	action_icon_state = boiler_glob.icon_key
	return ..()

// ***************************************
// *********** Gas cloud bomb maker
// ***************************************

/datum/action/ability/xeno_action/create_boiler_bomb
	name = "Create bomb"
	action_icon_state = "toggle_bomb0" //to be changed
	action_icon = 'icons/Xeno/actions/boiler.dmi'
	desc = "制造一枚当前所选类型的轰击者轰击弹."
	ability_cost = 200
	use_state_flags = ABILITY_USE_BUSY|ABILITY_USE_LYING
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CREATE_BOMB,
	)

/datum/action/ability/xeno_action/create_boiler_bomb/New(Target)
	. = ..()
	desc = "Creates a Boiler Bombard of the type currently selected. Reduces bombard cooldown by [BOILER_BOMBARD_COOLDOWN_REDUCTION] seconds for each stored. Begins to emit light when surpassing [BOILER_LUMINOSITY_THRESHOLD] globs stored."

/datum/action/ability/xeno_action/create_boiler_bomb/action_activate()
	if(xeno_owner.xeno_flags & XENO_ZOOMED)
		xeno_owner.balloon_alert(xeno_owner,"放大时无法使用!")
		return

	if(xeno_owner.corrosive_ammo >= xeno_owner.xeno_caste.max_ammo)
		to_chat(xeno_owner, span_notice("我们无法携带更多酸液球了."))
		return

	succeed_activate()
	xeno_owner.corrosive_ammo++
	to_chat(xeno_owner, span_notice("我们准备一枚腐蚀性酸液球."))
	update_button_icon()
	xeno_owner.update_ammo_glow()

/datum/action/ability/xeno_action/create_boiler_bomb/update_button_icon()
	action_icon_state = "bomb_count_[xeno_owner.corrosive_ammo]"
	return ..()

/particles/xeno_smoke/acid_light
	color = "#9dcf30"

// ***************************************
// *********** Gas cloud bombs
// ***************************************
/datum/action/ability/activable/xeno/bombard
	name = "Bombard"
	desc = "发射一团酸液."
	action_icon_state = "bombard"
	action_icon = 'icons/Xeno/actions/boiler.dmi'
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_BOMBARD,
	)
	use_state_flags = NONE

/datum/action/ability/activable/xeno/bombard/get_cooldown()
	return xeno_owner.xeno_caste.bomb_delay - xeno_owner.corrosive_ammo * BOILER_BOMBARD_COOLDOWN_REDUCTION SECONDS

/datum/action/ability/activable/xeno/bombard/on_cooldown_finish()
	to_chat(xeno_owner, span_notice("我们感到毒素腺体膨胀. 我们可以再次轰击一片区域了."))
	if(xeno_owner.selected_ability == src)
		xeno_owner.set_bombard_pointer()
	return ..()

/// Signal proc for clicking at a distance
/datum/action/ability/activable/xeno/bombard/proc/on_ranged_attack(mob/living/carbon/xenomorph/xeno_owner, atom/A, params)
	SIGNAL_HANDLER
	if(can_use_ability(A, TRUE))
		INVOKE_ASYNC(src, PROC_REF(use_ability), A)

/datum/action/ability/activable/xeno/bombard/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	var/turf/T = get_turf(A)
	var/turf/S = get_turf(owner)

	if(xeno_owner.corrosive_ammo <= 0)
		xeno_owner.balloon_alert(xeno_owner, "没有腐蚀性酸液球.")
		return FALSE

	if(!isturf(T) || T.z != S.z)
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "无效目标.")
		return FALSE

	if(get_dist(T, S) <= 5) //Magic number
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "太近了!")
		return FALSE

/datum/action/ability/activable/xeno/bombard/on_selection()
	if(!xeno_owner)
		return
	var/current_ammo = xeno_owner.corrosive_ammo
	if(current_ammo <= 0)
		to_chat(xeno_owner, span_notice("我们没有准备好任何可发射的东西."))
		return FALSE

	xeno_owner.visible_message(span_notice("\The [xeno_owner]开始将爪子挖入地面."), \
	span_notice("我们开始将自己挖入地面."), null, 5)
	if(!do_after(xeno_owner, 3 SECONDS, IGNORE_HELD_ITEM, null, BUSY_ICON_HOSTILE))
		on_deselection()
		xeno_owner.selected_ability = null
		xeno_owner.update_action_button_icons()
		xeno_owner.reset_bombard_pointer()
		return FALSE

	xeno_owner.visible_message(span_notice("\The [xeno_owner]将自己挖入地面!"), \
		span_notice("我们将自己挖入地面! 如果我们移动, 就必须再次等待才能开火."), null, 5)
	xeno_owner.set_bombard_pointer()
	RegisterSignal(xeno_owner, COMSIG_MOB_ATTACK_RANGED, TYPE_PROC_REF(/datum/action/ability/activable/xeno/bombard, on_ranged_attack))

/datum/action/ability/activable/xeno/bombard/on_deselection()
	if(xeno_owner?.selected_ability == src)
		xeno_owner.reset_bombard_pointer()
		to_chat(xeno_owner, span_notice("我们放松了姿态."))
	UnregisterSignal(owner, COMSIG_MOB_ATTACK_RANGED)

/mob/living/carbon/xenomorph/boiler/Moved(atom/OldLoc, Dir)
	. = ..()
	if(selected_ability?.type == /datum/action/ability/activable/xeno/bombard)
		var/datum/action/ability/activable/xeno/bombard/bomb = actions_by_path[/datum/action/ability/activable/xeno/bombard]
		bomb.on_deselection()
		selected_ability.button.icon_state = "template"
		selected_ability = null
		update_action_button_icons()

/mob/living/carbon/xenomorph/proc/set_bombard_pointer()
	if(client)
		client.mouse_pointer_icon = 'icons/mecha/mecha_mouse.dmi'

/mob/living/carbon/xenomorph/proc/reset_bombard_pointer()
	if(client)
		client.mouse_pointer_icon = initial(client.mouse_pointer_icon)

/datum/action/ability/activable/xeno/bombard/use_ability(atom/A)
	var/turf/target = get_turf(A)

	if(!istype(target))
		return

	to_chat(xeno_owner, span_xenonotice("我们开始积蓄压力."))

	if(!do_after(xeno_owner, 2 SECONDS, IGNORE_HELD_ITEM, target, BUSY_ICON_DANGER))
		to_chat(xeno_owner, span_warning("我们决定不发射."))
		return fail_activate()

	if(!can_use_ability(target, FALSE, ABILITY_IGNORE_PLASMA))
		return fail_activate()

	if((locate(/obj/effect/forcefield/fog) in xeno_owner.loc) && !get_nearest_target(xeno_owner, 5, TARGET_HUMAN, xeno_owner.faction, xeno_owner.hivenumber)) //говнокод, да
		return

	xeno_owner.visible_message(span_xenowarning("\The [xeno_owner]发射出一大团酸液飞向远方!"), \
	span_xenowarning("我们发射出一大团酸液飞向远方!"), null, 5)

	var/atom/movable/projectile/P = new /atom/movable/projectile(xeno_owner.loc)
	P.generate_bullet(xeno_owner.ammo)
	P.fire_at(target, xeno_owner, xeno_owner, xeno_owner.ammo.max_range, xeno_owner.ammo.shell_speed)
	playsound(xeno_owner, 'sound/effects/blobattack.ogg', 25, 1)
	GLOB.round_statistics.boiler_acid_smokes++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "boiler_acid_smokes")
	xeno_owner.corrosive_ammo--
	owner.record_war_crime()

	xeno_owner.update_ammo_glow()
	update_button_icon()
	add_cooldown()

/datum/action/ability/activable/xeno/bombard/clean_action()
	xeno_owner.reset_bombard_pointer()
	return ..()

// ***************************************
// *********** Acid spray
// ***************************************

/datum/action/ability/activable/xeno/spray_acid/line/boiler
	cooldown_duration = 9 SECONDS

/datum/action/ability/activable/xeno/acid_shroud
	name = "Acid Shroud"
	action_icon_state = "acid_shroud"
	action_icon = 'icons/Xeno/actions/boiler.dmi'
	desc = "在你自己下方制造一片烟雾, 代价是轰击开火冷却时间更长."
	ability_cost = 200
	cooldown_duration = 30 SECONDS
	use_state_flags = ABILITY_USE_BUSY|ABILITY_USE_LYING
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY | ABILITY_IGNORE_SELECTED_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ACID_SHROUD,
		KEYBINDING_ALTERNATE = COMSIG_XENOABILITY_ACID_SHROUD_SELECT,
	)

/datum/action/ability/activable/xeno/acid_shroud/use_ability(atom/A)
	var/datum/effect_system/smoke_spread/emitted_gas = new /datum/effect_system/smoke_spread/xeno/acid(xeno_owner)
	emitted_gas.set_up(4, get_turf(xeno_owner))
	emitted_gas.start()
	succeed_activate()
	add_cooldown()
	var/datum/action/ability/activable/xeno/bombard/bombard_action = xeno_owner.actions_by_path[/datum/action/ability/activable/xeno/bombard]
	if(bombard_action?.cooldown_timer) //You need to clear a cooldown to add another, so that is done here.
		deltimer(bombard_action.cooldown_timer)
		bombard_action.cooldown_timer = null
		bombard_action.countdown.stop()
	bombard_action?.add_cooldown(xeno_owner.xeno_caste.bomb_delay + 8.5 SECONDS - (xeno_owner.corrosive_ammo * BOILER_BOMBARD_COOLDOWN_REDUCTION SECONDS)) //The cooldown of Bombard that is added when this ability is used. It is the calculation of Bombard cooldown + 10 seconds.
