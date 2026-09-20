// ***************************************
// *********** Flay
// ***************************************
/datum/action/ability/activable/xeno/flay
	name = "Flay"
	action_icon_state = "flay"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "通过快速挥击从受害的陆战队员身上撕下一块血肉, 为你的生物质收集增加100生物质."
	ability_cost = 0
	cooldown_duration = 20 SECONDS
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_FLAY,
	)

/datum/action/ability/activable/xeno/flay/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/human/target_human = target
	if(!ishuman(target))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "不适用!")
		return FALSE

	if(!xeno_owner.Adjacent(target_human))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "不相邻!")
		return FALSE

	if(target_human.stat == DEAD)
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "已死亡!")
		return FALSE

/datum/action/ability/activable/xeno/flay/use_ability(mob/living/carbon/human/target_human)
	xeno_owner.face_atom(target_human)
	xeno_owner.do_attack_animation(target_human, ATTACK_EFFECT_REDSLASH)
	xeno_owner.visible_message(target_human, span_danger("[xeno_owner]剥下并撕裂了[target_human]的皮肤和血肉!"))
	playsound(target_human, SFX_ALIEN_CLAW_FLESH, 25, TRUE)
	target_human.emote("scream")
	xeno_owner.emote("roar")
	target_human.apply_damage(30, def_zone = BODY_ZONE_CHEST, blocked = MELEE, sharp = TRUE, edge = FALSE, updating_health = TRUE, penetration = 15)
	target_human.Paralyze(0.8 SECONDS)

	xeno_owner.gain_plasma(xeno_owner.xeno_caste.flay_plasma_gain)

	add_cooldown()

// ***************************************
// *********** Pincushion
// ***************************************
/datum/action/ability/activable/xeno/pincushion
	name = "Pincushion"
	action_icon_state = "pincushion"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "从你的尾部发射一根脊刺. 这种攻击将有助于威慑任何有机体, 并在直接战斗中支援你的傀儡和队友."
	cooldown_duration = 5 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PINCUSHION,
	)

/datum/action/ability/activable/xeno/pincushion/can_use_ability(atom/victim, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return
	if(xeno_owner.do_actions)
		return FALSE
	xeno_owner.face_atom(victim)
	if(!do_after(xeno_owner, 0.3 SECONDS, IGNORE_HELD_ITEM|IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE, victim, BUSY_ICON_DANGER, extra_checks = CALLBACK(xeno_owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = xeno_owner.health))))
		return FALSE
	succeed_activate()

/datum/action/ability/activable/xeno/pincushion/use_ability(atom/victim)
	var/turf/current_turf = get_turf(owner)
	playsound(xeno_owner.loc, 'sound/bullets/spear_armor1.ogg', 25, 1)
	xeno_owner.visible_message(span_warning("[xeno_owner]射出一根尖刺!"), span_xenonotice("我们从体内发射一根脊刺."))

	var/atom/movable/projectile/spine = new /atom/movable/projectile(current_turf)
	spine.generate_bullet(/datum/ammo/xeno/spine)
	spine.def_zone = xeno_owner.get_limbzone_target()
	spine.fire_at(victim, xeno_owner, xeno_owner, range = 6, speed = 1)

	add_cooldown()
// ***************************************
// *********** Dreadful Presence
// ***************************************
#define DREAD_RANGE 6
/datum/action/ability/xeno_action/dreadful_presence
	name = "Dreadful Presence"
	action_icon_state = "dreadful_presence"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "散发出一种威胁性的存在感, 使有机体心生恐惧并短暂减速."
	ability_cost = 50
	cooldown_duration = 20 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_DREADFULPRESENCE,
	)
	/// Should it give a status effect that deals stamina damage instead? If so, how much stamina damage per second?
	var/stamina_draining

/datum/action/ability/xeno_action/dreadful_presence/action_activate()
	var/obj/effect/overlay/dread/effect = new
	owner.vis_contents += effect
	for(var/mob/living/carbon/human/human in view(DREAD_RANGE, owner.loc))
		to_chat(human, span_userdanger("一股压倒性的恐惧感席卷了你... 你被暂时减速了!"))
		if(stamina_draining)
			human.apply_status_effect(STATUS_EFFECT_DRAINING_DREAD, stamina_draining)
		else
			human.apply_status_effect(STATUS_EFFECT_DREAD)
		addtimer(CALLBACK(human, TYPE_PROC_REF(/mob/living/carbon/human, emote), "scream"), rand(1,2))
	addtimer(CALLBACK(src, PROC_REF(clear_effect), effect), 3 SECONDS)
	add_cooldown()
	succeed_activate()

/datum/action/ability/xeno_action/dreadful_presence/proc/clear_effect(atom/effect)
	owner.vis_contents -= effect
	qdel(effect)

#undef DREAD_RANGE
// ***************************************
// *********** Refurbish Husk
// ***************************************
/datum/action/ability/activable/xeno/refurbish_husk
	name = "Refurbish Husk"
	action_icon_state = "refurbish_husk"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "采集尸体的生物质和器官, 以制造一个肉傀儡来为你效力."
	cooldown_duration = 25 SECONDS
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_REFURBISHHUSK,
	)
	/// List of all our puppets
	var/list/mob/living/carbon/xenomorph/puppet/puppets = list()

/datum/action/ability/activable/xeno/refurbish_husk/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/target_human = target
	if(!ishuman(target))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "不适用!")
		return FALSE
	if(length(puppets) >= xeno_owner.xeno_caste.max_puppets)
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "傀儡过多! (上限: [xeno_owner.xeno_caste.max_puppets])")
		return FALSE
	if(HAS_TRAIT(target, TRAIT_MAPSPAWNED) || HAS_TRAIT(target, TRAIT_HOLLOW))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "毫无用处!")
		return FALSE

	if(!xeno_owner.Adjacent(target_human))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "不相邻!")
		return FALSE

#ifndef TESTING
	if(!HAS_TRAIT(target_human, TRAIT_UNDEFIBBABLE) || target_human.stat != DEAD)
		xeno_owner.balloon_alert(xeno_owner, "未死亡且无法复活!")
		return FALSE
#endif

	xeno_owner.face_atom(target_human)
	xeno_owner.visible_message(target_human, span_danger("[xeno_owner]开始切割, 对[target_human]做着各种可怕的事情!"))
	if(!do_after(xeno_owner, 8 SECONDS, IGNORE_HELD_ITEM, target_human, BUSY_ICON_DANGER, extra_checks = CALLBACK(xeno_owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = xeno_owner.health))))
		return FALSE
	succeed_activate()

/datum/action/ability/activable/xeno/refurbish_husk/use_ability(mob/living/carbon/human/victim)
	var/turf/victim_turf = get_turf(victim)

	ADD_TRAIT(victim, TRAIT_HOLLOW, TRAIT_GENERIC)
	victim.spawn_gibs()
	var/mob/living/carbon/xenomorph/puppet/puppet = new(victim_turf, owner)
	puppet.name = victim.name
	puppet.voice = victim.voice
	add_puppet(puppet)
	add_cooldown()

/// Adds a puppet to our list
/datum/action/ability/activable/xeno/refurbish_husk/proc/add_puppet(mob/living/carbon/xenomorph/puppet/new_puppet)
	RegisterSignals(new_puppet, list(COMSIG_MOB_DEATH, COMSIG_QDELETING), PROC_REF(remove_puppet))
	RegisterSignal(new_puppet, COMSIG_XENOMORPH_POSTATTACK_LIVING, PROC_REF(postattack))
	puppets += new_puppet

/// Cleans up puppet from our list
/datum/action/ability/activable/xeno/refurbish_husk/proc/remove_puppet(datum/source)
	SIGNAL_HANDLER
	puppets -= source
	UnregisterSignal(source, list(COMSIG_MOB_DEATH, COMSIG_QDELETING, COMSIG_XENOMORPH_POSTATTACK_LIVING))

/datum/action/ability/activable/xeno/refurbish_husk/proc/postattack(mob/living/source, mob/living/target, damage)
	SIGNAL_HANDLER
	if(target.stat == DEAD)
		return
	xeno_owner.gain_plasma(floor(damage / 0.9))

// ***************************************
// *********** Stitch Puppet
// ***************************************
/datum/action/ability/activable/xeno/puppet
	name = "Stitch Puppet"
	action_icon_state = "stitch_puppet"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "在相邻的目标位置制造一个血肉人造体来为你效力."
	cooldown_duration = 20 SECONDS
	target_flags = ABILITY_TURF_TARGET
	use_state_flags = ABILITY_USE_LYING|ABILITY_IGNORE_COOLDOWN
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PUPPET,
	)
	var/current_charges = 3
	var/max_charges = 3

/datum/action/ability/activable/xeno/puppet/give_action(mob/living/L)
	. = ..()
	var/max_puppets = xeno_owner?.xeno_caste.max_puppets ? xeno_owner.xeno_caste.max_puppets : 4
	desc = "Creates a flesh homunculus to do your bidding, at an adjacent target location. You can only deploy [max_puppets] puppets at one time."

	var/mutable_appearance/counter_maptext = mutable_appearance(icon = null, icon_state = null, layer = ACTION_LAYER_MAPTEXT)
	counter_maptext.pixel_x = 16
	counter_maptext.pixel_y = -4
	counter_maptext.maptext = MAPTEXT("[current_charges]/[max_charges]")
	visual_references[VREF_MUTABLE_PUPPET_CHARGES] = counter_maptext

/datum/action/ability/activable/xeno/puppet/remove_action(mob/living/carbon/xenomorph/X)
	button.cut_overlay(visual_references[VREF_MUTABLE_PUPPET_CHARGES])
	visual_references[VREF_MUTABLE_PUPPET_CHARGES] = null
	return ..()

/datum/action/ability/activable/xeno/puppet/update_button_icon()
	button.cut_overlay(visual_references[VREF_MUTABLE_PUPPET_CHARGES])
	var/mutable_appearance/number = visual_references[VREF_MUTABLE_PUPPET_CHARGES]
	number?.maptext = MAPTEXT("[current_charges]/[max_charges]")
	visual_references[VREF_MUTABLE_PUPPET_CHARGES] = number
	button.add_overlay(visual_references[VREF_MUTABLE_PUPPET_CHARGES])
	return ..()

/datum/action/ability/activable/xeno/puppet/on_cooldown_finish()
	current_charges = clamp(current_charges + 1, 0, max_charges)
	update_button_icon()
	if(current_charges < max_charges)
		cooldown_timer = addtimer(CALLBACK(src, PROC_REF(on_cooldown_finish)), cooldown_duration, TIMER_STOPPABLE)
		return
	return ..()

/datum/action/ability/activable/xeno/puppet/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE

	if(current_charges <= 0)
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "无充能")
		return FALSE

	if(isclosedturf(target))
		if(!silent)
			target.balloon_alert(xeno_owner, "区域密集")
		return FALSE

	var/datum/action/ability/activable/xeno/refurbish_husk/huskaction = owner.actions_by_path[/datum/action/ability/activable/xeno/refurbish_husk]
	if(length(huskaction.puppets) >= xeno_owner.xeno_caste.max_puppets)
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "傀儡过多! (上限: [xeno_owner.xeno_caste.max_puppets])")
		return FALSE

	if(!xeno_owner.Adjacent(target))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "不相邻!")
		return FALSE

	xeno_owner.face_atom(target)
	xeno_owner.visible_message(span_warning("[xeno_owner]开始吐出生物质, 并熟练地将各种零碎部件缝合在一起!"))
	if(!do_after(xeno_owner, 5 SECONDS, IGNORE_HELD_ITEM, target, BUSY_ICON_CLOCK, extra_checks = CALLBACK(xeno_owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = xeno_owner.health))))
		return FALSE

	xeno_owner.visible_message(span_warning("[xeno_owner]形成了一个令人作呕的傀儡!"))
	var/turf/target_turf = get_turf(target)
	huskaction.add_puppet(new /mob/living/carbon/xenomorph/puppet(target_turf, owner))

	current_charges--
	update_button_icon()
	add_cooldown()
	succeed_activate()
	return TRUE

// ***************************************
// *********** Organic Bomb
// ***************************************
/datum/action/ability/activable/xeno/organic_bomb
	name = "Organic Bomb"
	action_icon_state = "organic_bomb"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "使我们的一个傀儡在选定后引爆, 从傀儡体内向四面八方喷出酸液, 将傀儡炸成碎块."
	cooldown_duration = 30 SECONDS
	ability_cost = 100
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ORGANICBOMB,
	)

/datum/action/ability/activable/xeno/organic_bomb/use_ability(mob/living/victim)
	. = ..()
	var/datum/action/ability/activable/xeno/refurbish_husk/huskaction = owner.actions_by_path[/datum/action/ability/activable/xeno/refurbish_husk]
	if(length(huskaction.puppets) <= 0)
		owner.balloon_alert(owner, "没有傀儡")
		return fail_activate()
	if(!istype(victim, /mob/living/carbon/xenomorph/puppet) || !(victim in huskaction.puppets))
		victim.balloon_alert(owner, "不是我们的傀儡")
		return fail_activate()
	if(!SEND_SIGNAL(victim, COMSIG_PUPPET_CHANGE_ORDER, PUPPET_SEEK_CLOSEST))
		victim.balloon_alert(owner, "失败")
		return fail_activate()
	RegisterSignal(victim, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(start_exploding))
	RegisterSignal(victim, COMSIG_MOB_DEATH, PROC_REF(detonate))
	addtimer(CALLBACK(src, PROC_REF(start_exploding), victim), 5 SECONDS)
	add_cooldown()

///asynchronous signal handler for start_exploding_async
/datum/action/ability/activable/xeno/organic_bomb/proc/start_exploding(mob/living/puppet)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(start_exploding_async), puppet)

///makes a puppet start a do_after to dexplode
/datum/action/ability/activable/xeno/organic_bomb/proc/start_exploding_async(mob/living/puppet)
	puppet.visible_message(span_danger("[puppet]膨胀起来, 并缓缓展开它缝合的躯体!"))
	if(do_after(puppet, 1.5 SECONDS, IGNORE_HELD_ITEM, puppet, BUSY_ICON_DANGER))
		detonate(puppet)

///detonates a puppet causing a spray of acid
/datum/action/ability/activable/xeno/organic_bomb/proc/detonate(mob/living/puppet)
	SIGNAL_HANDLER
	UnregisterSignal(puppet, list(COMSIG_XENOMORPH_ATTACK_LIVING, COMSIG_MOB_DEATH))
	var/turf/our_turf = get_turf(puppet)
	our_turf.visible_message(span_danger("[puppet]爆裂开来, 释放出腐蚀性酸液!"))
	playsound(our_turf, 'sound/bullets/acid_impact1.ogg', 50, 1)
	if(!QDELETED(puppet))
		puppet.gib()

	for(var/turf/acid_tile AS in RANGE_TURFS(2, our_turf))
		if(!line_of_sight(our_turf,acid_tile) || isclosedturf(acid_tile))
			continue
		xenomorph_spray(acid_tile, 12 SECONDS, 18, null, TRUE)
// ***************************************
// *********** Articulate
// ***************************************
/datum/action/ability/activable/xeno/articulate
	name = "Articulate"
	action_icon_state = "mimicry"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "直接控制一个傀儡的声带. 允许你通过你的傀儡直接与人类交谈."
	cooldown_duration = 10 SECONDS
	target_flags = ABILITY_MOB_TARGET
	///Whether we should cancel instead of doing the thing when activated
	var/talking = FALSE
	///our current target
	var/mob/living/carbon/active_target

/datum/action/ability/activable/xeno/articulate/use_ability(mob/living/victim)
	if(talking)
		cancel(owner)
		return fail_activate()
	var/datum/action/ability/activable/xeno/refurbish_husk/huskaction = owner.actions_by_path[/datum/action/ability/activable/xeno/refurbish_husk]
	if(!istype(victim, /mob/living/carbon/xenomorph/puppet) || !(victim in huskaction.puppets))
		victim.balloon_alert(owner, "不是我们的傀儡")
		return fail_activate()
	owner.balloon_alert(owner, "正在引导声音, 移动或激活以取消!")
	active_target = victim
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(relay_speech))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(cancel))
	RegisterSignal(victim, COMSIG_QDELETING, PROC_REF(cancel))
	talking = TRUE
	add_cooldown()

/datum/action/ability/activable/xeno/articulate/proc/relay_speech(mob/living/carbon/source, arguments)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(relay_speech_async), active_target, arguments[SPEECH_MESSAGE])

/datum/action/ability/activable/xeno/articulate/proc/relay_speech_async(mob/living/carbon/target, text)
	target.say(text, language = /datum/language/common, forced = "puppeteer articulate ability")

/datum/action/ability/activable/xeno/articulate/proc/cancel(atom/target)
	SIGNAL_HANDLER
	if(talking)
		owner.balloon_alert(owner, "已取消!")
	talking = FALSE
	active_target = null
	UnregisterSignal(owner, list(COMSIG_MOB_SAY, COMSIG_MOVABLE_MOVED, COMSIG_QDELETING))

// ***************************************
// *********** Tendrils (Primordial)
// ***************************************
/datum/action/ability/activable/xeno/tendril_patch
	name = "Tendrils"
	action_icon_state = "living_construct"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "将新制造的触须埋入地下, 以在3x3区域内缠住有机体."
	ability_cost = 175
	cooldown_duration = 40 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TENDRILS,
	)

/datum/action/ability/activable/xeno/tendril_patch/use_ability(atom/movable/victim)
	var/turf/their_turf = get_turf(victim)
	var/mob/living/living_owner = owner
	living_owner.face_atom(victim)
	living_owner.visible_message(span_warning("[living_owner]开始形成生物质并将其压入地面!"))
	if(!do_after(living_owner, 3 SECONDS, IGNORE_HELD_ITEM, victim, BUSY_ICON_DANGER, extra_checks = CALLBACK(living_owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = living_owner.health))))
		return FALSE
	their_turf.visible_message(span_warning("[living_owner]的触须从地面爆出!"))
	for(var/turf/tile AS in RANGE_TURFS(1, their_turf))
		if(!locate(/obj/effect/tentacle) in tile.contents)
			new /obj/effect/tentacle(tile)
	add_cooldown()

/obj/effect/tentacle
	name = "tendril"
	icon = 'icons/effects/effects.dmi'
	icon_state = "tendril_1"
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	anchored = TRUE

/obj/effect/tentacle/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(start_grabbing)), 0.4 SECONDS)

/// change our icon state and start a 0.3 second timer to call grab()
/obj/effect/tentacle/proc/start_grabbing()
	icon_state = "tendril_2"
	addtimer(CALLBACK(src, PROC_REF(grab)), 0.3 SECONDS, TIMER_STOPPABLE)

/// brute damage and paralyze everyone on our tile
/obj/effect/tentacle/proc/grab()
	for (var/mob/living/victim in loc)
		if (victim.stat == DEAD)
			continue
		if(isxeno(victim))
			continue
		balloon_alert(victim, "被缠住!")
		visible_message(span_danger("[src]缠住了[victim]!"))
		victim.adjust_brute_loss(10)
		victim.Paralyze(2 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(retract)), 0.3 SECONDS)

/// change our icon to our retracting icon and delete in 0.3 seconds
/obj/effect/tentacle/proc/retract()
	icon_state = "tendril_3"
	QDEL_IN(src, 0.4 SECONDS)

// ***************************************
// *********** Blessing
// ***************************************
/datum/action/ability/activable/xeno/puppet_blessings
	name = "Bestow Blessing"
	action_icon_state = "emit_pheromones"
	action_icon = 'icons/Xeno/actions/general.dmi'
	ability_cost = 200
	desc = "给予一个傀儡永久升级."
	cooldown_duration = 30 SECONDS
	use_state_flags = ABILITY_USE_STAGGERED|ABILITY_USE_NOTTURF|ABILITY_USE_BUSY|ABILITY_USE_LYING
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_BESTOWBLESSINGS,
	)

/datum/action/ability/activable/xeno/puppet_blessings/can_use_ability(mob/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return fail_activate()
	if(!istype(target, /mob/living/carbon/xenomorph/puppet))
		owner.balloon_alert(owner, "不是傀儡")
		return fail_activate()
	succeed_activate()

/datum/action/ability/activable/xeno/puppet_blessings/use_ability(mob/living/victim)
	var/choice = show_radial_menu(owner, owner, GLOB.puppeteer_phero_images_list, radius = 35)
	if(!choice)
		return fail_activate()
	var/effect_path
	switch(choice)
		if(AURA_XENO_BLESSFRENZY)
			effect_path = /datum/status_effect/blessing/frenzy
		if(AURA_XENO_BLESSFURY)
			effect_path = /datum/status_effect/blessing/fury
		if(AURA_XENO_BLESSWARDING)
			effect_path = /datum/status_effect/blessing/warding
	if(victim.has_status_effect(effect_path))
		victim.balloon_alert(owner, "已拥有此祝福!")
		return fail_activate()
	victim.balloon_alert(owner, "[choice]")
	victim.apply_status_effect(effect_path, xeno_owner)
	victim.med_hud_set_status()
	playsound(get_turf(xeno_owner), SFX_ALIEN_DROOL, 25)
	add_cooldown()

// ***************************************
// *********** Unleash puppets
// ***************************************
/datum/action/ability/xeno_action/puppeteer_unleash
	name = "Unleash Puppets"
	action_icon_state = "enrage"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "派出你的傀儡攻击附近的人类"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_UNLEASHPUPPETS,
	)

/datum/action/ability/xeno_action/puppeteer_unleash/action_activate(mob/living/victim)
	if(SEND_SIGNAL(owner, COMSIG_PUPPET_CHANGE_ALL_ORDER, PUPPET_ATTACK))
		owner.balloon_alert(owner, "成功")
		owner.visible_message(span_warning("[owner]迅速操纵傀儡的心灵之弦, 命令它们发起攻击!"))
	else
		owner.balloon_alert(owner, "失败")

// ***************************************
// *********** Recall puppets
// ***************************************
/datum/action/ability/xeno_action/puppeteer_recall
	name = "Recall Puppets"
	action_icon = 'icons/mob/actions.dmi'
	action_icon_state = "rally"
	desc = "召回你的傀儡再次跟随你"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_RECALLPUPPETS,
	)

/datum/action/ability/xeno_action/puppeteer_recall/action_activate(mob/living/victim)
	if(SEND_SIGNAL(owner, COMSIG_PUPPET_CHANGE_ALL_ORDER, PUPPET_RECALL))
		owner.balloon_alert(owner, "成功")
		owner.visible_message(span_warning("[owner]迅速操纵傀儡的心灵之弦, 将它们拉近!"))
	else
		owner.balloon_alert(owner, "失败")
