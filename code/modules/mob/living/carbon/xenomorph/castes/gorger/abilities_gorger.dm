/////////////////////////////////
// Devour
/////////////////////////////////
/datum/action/ability/activable/xeno/devour
	name = "Devour"
	desc = "吞噬你的受害者,以便能更快地搬运它."
	action_icon_state = "abduct"
	action_icon = 'icons/Xeno/actions/gorger.dmi'
	use_state_flags = ABILITY_USE_STAGGERED|ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED //can't use while staggered, defender fortified or crest down
	ability_cost = 0
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_DEVOUR,
	)

/datum/action/ability/activable/xeno/devour/can_use_ability(atom/target, silent, override_flags)
	. = ..()
	if(!.)
		return
	if(!ishuman(target) || issynth(target))
		if(!silent)
			to_chat(owner, span_warning("那尝起来不会很好吃."))
		return FALSE
	var/mob/living/carbon/human/victim = target
	if(owner.do_actions) //can't use if busy
		return FALSE
	if(!owner.Adjacent(victim)) //checks if owner next to target
		return FALSE
	if(!HAS_TRAIT(victim, TRAIT_UNDEFIBBABLE))
		if(!silent)
			to_chat(owner, span_warning("这只生物挣扎得太厉害了,我们无法吞噬它."))
		return FALSE
	if(victim.buckled)
		if(!silent)
			to_chat(owner, span_warning("[victim]被扣在了什么东西上."))
		return FALSE
	if(xeno_owner.eaten_mob)
		if(!silent)
			to_chat(xeno_owner, span_warning("你已经吞下了一个."))
		return FALSE
	if(xeno_owner.on_fire)
		if(!silent)
			to_chat(xeno_owner, span_warning("我们正忙着着火,做不了这个!"))
		return FALSE
	for(var/obj/effect/forcefield/fog in range(1, xeno_owner))
		if(!silent)
			to_chat(xeno_owner, span_warning("我们离迷雾太近了."))
		return FALSE

/datum/action/ability/activable/xeno/devour/action_activate()
	. = ..()
	if(!xeno_owner.eaten_mob)
		return

	var/channel = SSsounds.random_available_channel()
	playsound(xeno_owner, 'sound/vore/escape.ogg', 40, channel = channel)
	if(!do_after(xeno_owner, GORGER_REGURGITATE_DELAY, IGNORE_HELD_ITEM, null, BUSY_ICON_DANGER))
		to_chat(owner, span_warning("我们动得太早了!"))
		xeno_owner.stop_sound_channel(channel)
		return
	xeno_owner.eject_victim()

/datum/action/ability/activable/xeno/devour/use_ability(atom/target)
	var/mob/living/carbon/human/victim = target
	xeno_owner.face_atom(victim)
	xeno_owner.visible_message(span_danger("[xeno_owner]开始吞噬[victim]!"), span_danger("我们开始吞噬[victim]!"), null, 5)
	var/channel = SSsounds.random_available_channel()
	playsound(xeno_owner, 'sound/vore/struggle.ogg', 40, channel = channel)
	if(!do_after(xeno_owner, GORGER_DEVOUR_DELAY, IGNORE_HELD_ITEM, victim, BUSY_ICON_DANGER, extra_checks = CALLBACK(owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = xeno_owner.health))))
		to_chat(owner, span_warning("我们停止吞噬\the [victim]. 反正它们大概也很难吃."))
		xeno_owner.stop_sound_channel(channel)
		return
	owner.visible_message(span_warning("[xeno_owner]吞噬了[victim]!"), span_warning("我们吞噬了[victim]!"), null, 5)
	victim.forceMove(xeno_owner)
	xeno_owner.eaten_mob = victim
	add_cooldown()

/datum/action/ability/activable/xeno/devour/ai_should_use(atom/target)
	return FALSE

// ***************************************
// *********** Drain blood
// ***************************************
/datum/action/ability/activable/xeno/drain
	name = "Drain"
	desc = "抓住一名陆战队员一段时间并吸取其血液, 同时治疗自身. 在此期间你无法攻击, 并且可能被该陆战队员射击. 对已死亡的人类使用时, 你会逐渐治疗或获得过量治疗, 但不会获得血液."
	action_icon_state = "drain"
	action_icon = 'icons/Xeno/actions/gorger.dmi'
	use_state_flags = ABILITY_KEYBIND_USE_ABILITY
	cooldown_duration = 15 SECONDS
	ability_cost = 0
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_DRAIN,
	)

/datum/action/ability/activable/xeno/drain/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!ishuman(target) || issynth(target))
		if(!silent)
			to_chat(owner, span_xenowarning("我们无法吸取这个!"))
		return FALSE

	var/mob/living/carbon/human/target_human = target
	if(!xeno_owner.Adjacent(target_human))
		if(!silent)
			to_chat(xeno_owner, span_notice("我们需要靠近我们的食物."))
		return FALSE

	if(target_human.stat == DEAD)
		if(xeno_owner.do_actions)
			return FALSE
		return TRUE

	if(!.)
		return

	if(xeno_owner.plasma_stored >= xeno_owner.xeno_caste.plasma_max)
		if(!silent)
			to_chat(xeno_owner, span_xenowarning("不需要, 我们现在感觉很满足..."))
		return FALSE

/datum/action/ability/activable/xeno/drain/use_ability(mob/living/carbon/human/target_human)
	if(target_human.stat == DEAD)
		var/overheal_gain = 0
		while((xeno_owner.health < xeno_owner.maxHealth || xeno_owner.overheal < xeno_owner.xeno_caste.overheal_max) && do_after(xeno_owner, 2 SECONDS, NONE, target_human, BUSY_ICON_HOSTILE))
			overheal_gain = xeno_owner.heal_wounds(2.2)
			xeno_owner.adjust_overheal(overheal_gain)
			xeno_owner.adjust_sunder(-2.5)
		to_chat(xeno_owner, span_notice("我们感觉完全恢复了."))
		return
	xeno_owner.face_atom(target_human)
	xeno_owner.emote("roar")
	xeno_owner.AdjustImmobilized(0.5 SECONDS)
	ADD_TRAIT(xeno_owner, TRAIT_HANDS_BLOCKED, src)
	for(var/i = 0; i < GORGER_DRAIN_INSTANCES; i++)
		target_human.Immobilize(GORGER_DRAIN_DELAY)
		if(!do_after(xeno_owner, GORGER_DRAIN_DELAY, IGNORE_HELD_ITEM, target_human))
			break
		target_human.adjust_blood_volume(-15)

		xeno_owner.do_attack_animation(target_human, ATTACK_EFFECT_REDSTAB)
		xeno_owner.visible_message(target_human, span_danger("[xeno_owner]将尾巴刺入[target_human]!"))
		playsound(target_human, SFX_ALIEN_CLAW_FLESH, 25, TRUE)
		target_human.emote("scream")
		target_human.apply_damage(damage = 4, damagetype = BRUTE, def_zone = BODY_ZONE_HEAD, blocked = 0, sharp = TRUE, edge = FALSE, updating_health = TRUE)

		var/drain_heal = GORGER_DRAIN_HEAL
		xeno_owner.heal_xeno_damage(drain_heal, TRUE) // this define shitcoded proc errors if we have a define inside of a define
		xeno_owner.adjust_overheal(drain_heal)
		SEND_SIGNAL(target_human, COMSIG_XENO_DRAIN_HIT, xeno_owner.xeno_caste.drain_plasma_gain, xeno_owner);
		xeno_owner.gain_plasma(xeno_owner.xeno_caste.drain_plasma_gain)

	REMOVE_TRAIT(xeno_owner, TRAIT_HANDS_BLOCKED, src)
	target_human.blur_eyes(1)
	add_cooldown()

/datum/action/ability/activable/xeno/drain/ai_should_use(atom/target)
	return can_use_ability(target, TRUE)

// ***************************************
// *********** Transfusion
// ***************************************

/obj/effect/ebeam/transfusion
	name = "blood transfusion beam"

/datum/action/ability/activable/xeno/transfusion
	name = "Transfusion"
	desc = "恢复另一只异形的部分生命值, 或提供过量治疗, 但消耗血液."
	action_icon_state = "transfusion"
	action_icon = 'icons/Xeno/actions/gorger.dmi'
	//When used on self, drains blood continuosly, slows you down and reduces damage taken, while restoring health over time.
	cooldown_duration = 2 SECONDS
	ability_cost = 20
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TRANSFUSION,
	)

	///Used to keep track of the target's previous health for extra_health_check()
	var/target_health

/datum/action/ability/activable/xeno/transfusion/can_use_ability(atom/target, silent = FALSE, override_flags) //it is set up to only return true on specific xeno or human targets
	. = ..()
	if(!.)
		return

	if(!isxeno(target))
		if(!silent)
			to_chat(owner, span_notice("我们只能恢复熟悉的生物生命体."))
		return FALSE

	var/mob/living/carbon/xenomorph/target_xeno = target

	if(owner.do_actions)
		return FALSE
	if(!line_of_sight(owner, target_xeno, 3) || get_dist(owner, target_xeno) > 3)
		if(!silent)
			to_chat(owner, span_notice("它超出了我们的触及范围, 我们必须靠近, 并且道路必须畅通."))
		return FALSE
	if(target_xeno.stat == DEAD)
		if(!silent)
			to_chat(owner, span_notice("我们只能帮助活着的姐妹."))
		return FALSE
	target_health = target_xeno.health
	var/datum/beam/transfuse_beam = owner.beam(target_xeno, icon_state= "lichbeam", beam_type = /obj/effect/ebeam/essence_link)
	transfuse_beam.visuals.alpha = 127
	if(!do_after(owner, 1 SECONDS, IGNORE_LOC_CHANGE, target_xeno, BUSY_ICON_FRIENDLY, BUSY_ICON_MEDICAL, extra_checks = CALLBACK(src, PROC_REF(extra_health_check), target_xeno)))
		QDEL_NULL(transfuse_beam)
		return FALSE
	QDEL_NULL(transfuse_beam)
	return TRUE

///An extra check for the do_mob in can_use_ability. If the target isn't immobile and has lost health, the ability is cancelled. The ability is also cancelled if the target is knocked into crit DURING the do_mob.
/datum/action/ability/activable/xeno/transfusion/proc/extra_health_check(mob/living/target)
	if((target.health < target_health && !HAS_TRAIT(target, TRAIT_IMMOBILE)) || (target.InCritical() && target_health > target.get_crit_threshold()))
		return FALSE
	target_health = target.health
	return TRUE

/datum/action/ability/activable/xeno/transfusion/use_ability(atom/target)
	var/mob/living/carbon/xenomorph/target_xeno = target
	var/heal_amount = target_xeno.maxHealth * GORGER_TRANSFUSION_HEAL
	target_xeno.heal_xeno_damage(heal_amount, FALSE)
	if(owner.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
		personal_statistics.heals++
	target_xeno.adjust_overheal(heal_amount)
	new /obj/effect/temp_visual/healing(get_turf(target_xeno))
	if(target_xeno.overheal)
		target_xeno.balloon_alert(xeno_owner, "过量治疗: [target_xeno.overheal]/[target_xeno.xeno_caste.overheal_max]")
	add_cooldown()
	succeed_activate()

/datum/action/ability/activable/xeno/transfusion/ai_should_use(atom/target)
	// no healing non-xeno
	if(!isxeno(target))
		return FALSE
	var/mob/living/carbon/xenomorph/target_xeno = target
	if(target_xeno.get_xeno_hivenumber() != owner.get_xeno_hivenumber())
		return FALSE
	// no overhealing
	if(target_xeno.health > target_xeno.maxHealth * (1 - GORGER_TRANSFUSION_HEAL))
		return FALSE
	return can_use_ability(target, TRUE)

// ***************************************
// *********** Rejuvenate
// ***************************************
#define REJUVENATE_MISCLICK_CD "rejuvenate_misclick"
/datum/action/ability/activable/xeno/rejuvenate
	name = "Rejuvenate"
	desc = "持续吸取血液, 减缓你的速度并减少受到的伤害, 同时随时间恢复部分生命值. 再次激活可取消."
	action_icon_state = "rejuvenation"
	action_icon = 'icons/Xeno/actions/gorger.dmi'
	cooldown_duration = 4 SECONDS
	ability_cost = GORGER_REJUVENATE_COST
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_REJUVENATE,
	)
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	use_state_flags = ABILITY_USE_STAGGERED

/datum/action/ability/activable/xeno/rejuvenate/can_use_ability(atom/A, silent, override_flags)
	. = ..()
	if(!.)
		return
	if(TIMER_COOLDOWN_RUNNING(owner, REJUVENATE_MISCLICK_CD))
		return FALSE

/datum/action/ability/activable/xeno/rejuvenate/use_ability(atom/A)
	. = ..()
	if(xeno_owner.has_status_effect(STATUS_EFFECT_XENO_REJUVENATE))
		xeno_owner.remove_status_effect(STATUS_EFFECT_XENO_REJUVENATE)
		add_cooldown()
		return
	xeno_owner.apply_status_effect(STATUS_EFFECT_XENO_REJUVENATE, GORGER_REJUVENATE_DURATION, xeno_owner.maxHealth * GORGER_REJUVENATE_THRESHOLD)
	to_chat(xeno_owner, span_notice("我们动用储备来滋养自身, 我们的甲壳变厚了."))
	succeed_activate()
	TIMER_COOLDOWN_START(xeno_owner, REJUVENATE_MISCLICK_CD, 1 SECONDS)

/datum/action/ability/activable/xeno/rejuvenate/ai_should_use(atom/target)
	return FALSE

#undef REJUVENATE_MISCLICK_CD

// ***************************************
// *********** Psychic Link
// ***************************************
/datum/action/ability/activable/xeno/psychic_link
	name = "Psychic Link"
	desc = "链接到一只异形并代替其承受部分伤害."
	action_icon_state = "psychic_link"
	action_icon = 'icons/Xeno/actions/gorger.dmi'
	cooldown_duration = 15 SECONDS
	ability_cost = 0
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PSYCHIC_LINK,
	)
	///Timer for activating the link
	var/apply_psychic_link_timer
	///Overlay applied on the target xeno while linking
	var/datum/progressicon/target_overlay

/datum/action/ability/activable/xeno/psychic_link/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return
	if(apply_psychic_link_timer)
		if(!silent)
			owner.balloon_alert(owner, "已取消")
		link_cleanup()
		return FALSE
	if(owner.do_actions)
		return FALSE
	if(!isxeno(target))
		if(!silent)
			to_chat(owner, span_notice("我们只能链接到熟悉的生物生命体."))
		return FALSE
	if(xeno_owner.health <= xeno_owner.maxHealth * GORGER_PSYCHIC_LINK_MIN_HEALTH)
		if(!silent)
			to_chat(owner, span_notice("你伤得太重, 无法链接."))
		return FALSE
	if(!line_of_sight(owner, target, GORGER_PSYCHIC_LINK_RANGE))
		if(!silent)
			to_chat(owner, span_notice("它超出了我们的触及范围, 我们必须靠近, 并且道路必须畅通."))
		return FALSE
	return TRUE

/datum/action/ability/activable/xeno/psychic_link/use_ability(atom/target)
	apply_psychic_link_timer = addtimer(CALLBACK(src, PROC_REF(apply_psychic_link), target), GORGER_PSYCHIC_LINK_CHANNEL, TIMER_UNIQUE|TIMER_STOPPABLE)
	target_overlay = new (target, BUSY_ICON_MEDICAL)
	owner.balloon_alert(owner, "正在链接...")

///Activates the link
/datum/action/ability/activable/xeno/psychic_link/proc/apply_psychic_link(atom/target)
	link_cleanup()
	if(HAS_TRAIT(owner, TRAIT_PSY_LINKED) || HAS_TRAIT(target, TRAIT_PSY_LINKED))
		owner.balloon_alert(owner, "正在移除链接...")
		if(do_after(owner, 1 SECONDS, NONE, target, BUSY_ICON_FRIENDLY, BUSY_ICON_FRIENDLY))
			to_chat(owner, span_notice("已取消与[target]的链接."))
			cancel_psychic_link()
		return

	var/psychic_link = xeno_owner.apply_status_effect(STATUS_EFFECT_XENO_PSYCHIC_LINK, -1, target, GORGER_PSYCHIC_LINK_RANGE, GORGER_PSYCHIC_LINK_REDIRECT, xeno_owner.maxHealth * GORGER_PSYCHIC_LINK_MIN_HEALTH, TRUE)
	RegisterSignal(psychic_link, COMSIG_XENO_PSYCHIC_LINK_REMOVED, PROC_REF(status_removed))
	target.balloon_alert(xeno_owner, "链接成功")
	xeno_owner.balloon_alert(target, "已链接到[xeno_owner]")
	succeed_activate()

///Removes the status effect on unrest
/datum/action/ability/activable/xeno/psychic_link/proc/cancel_psychic_link(datum/source)
	xeno_owner.remove_status_effect(STATUS_EFFECT_XENO_PSYCHIC_LINK)

///Cancels the status effect
/datum/action/ability/activable/xeno/psychic_link/proc/status_removed(datum/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, COMSIG_XENO_PSYCHIC_LINK_REMOVED)
	add_cooldown()

///Clears up things used for the linking
/datum/action/ability/activable/xeno/psychic_link/proc/link_cleanup()
	QDEL_NULL(target_overlay)
	deltimer(apply_psychic_link_timer)
	apply_psychic_link_timer = null

/datum/action/ability/activable/xeno/psychic_link/ai_should_use(atom/target)
	return FALSE

// ***************************************
// *********** Carnage
// ***************************************
/datum/action/ability/activable/xeno/carnage
	name = "Carnage"
	desc = "进入饥渴状态, 在下次攻击时获得移动速度和治疗效果, 效果随缺失的血液量提升. 如果你的血液低于一定百分比, 你还会击倒受害者并吸取一些血液, 在此期间你无法移动."
	action_icon_state = "carnage"
	action_icon = 'icons/Xeno/actions/gorger.dmi'
	cooldown_duration = 15 SECONDS
	ability_cost = 0
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CARNAGE,
	)
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY

/datum/action/ability/activable/xeno/carnage/use_ability(atom/A)
	. = ..()
	xeno_owner.apply_status_effect(STATUS_EFFECT_XENO_CARNAGE, 10 SECONDS, xeno_owner.xeno_caste.carnage_plasma_gain, xeno_owner.maxHealth * GORGER_CARNAGE_HEAL, GORGER_CARNAGE_MOVEMENT)
	add_cooldown()

/datum/action/ability/activable/xeno/carnage/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	if(xeno_owner.plasma_stored > xeno_owner.xeno_caste.plasma_max * 0.8 && xeno_owner.health > xeno_owner.maxHealth * 0.9)
		return FALSE
	// nothing gained by slashing allies
	if(target.get_xeno_hivenumber() == xeno_owner.get_xeno_hivenumber())
		return FALSE
	return can_use_ability(target, TRUE)

// ***************************************
// *********** oppose
// ***************************************
/particles/oppose_aoe
	icon = 'icons/effects/particles/generic_particles.dmi'
	icon_state = list("cross" = 1, "x" = 1, "rectangle" = 1, "up_arrow" = 1, "down_arrow" = 1, "square" = 1)
	width = 500
	height = 500
	count = 2000
	spawning = 50
	gravity = list(0, 0.1)
	color = LIGHT_COLOR_BLOOD_MAGIC
	lifespan = 13
	fade = 3
	fadein = 5
	scale = 0.8
	friction = generator(GEN_NUM, 0.1, 0.15)
	spin = generator(GEN_NUM, -20, 20)

/datum/action/ability/activable/xeno/oppose
	name = "Oppose"
	desc = "猛烈地将储存的血液灌注到地面. 你所在格子上的陆战队员会被击退并受伤, 相邻的陆战队员会被击退, 附近的所有异形都会被治疗, 包括你自己."
	action_icon_state = "stomp"
	action_icon = 'icons/Xeno/actions/crusher.dmi'
	cooldown_duration = 30 SECONDS
	ability_cost = GORGER_OPPOSE_COST
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_OPPOSE,
	)
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY

/datum/action/ability/activable/xeno/oppose/use_ability(atom/A)
	. = ..()
	add_cooldown()
	succeed_activate()

	playsound(xeno_owner.loc, 'sound/effects/bang.ogg', 25, 0)
	xeno_owner.visible_message(span_xenodanger("[xeno_owner]将她的双拳砸向地面!"), \
	span_xenodanger("我们将双拳砸向地面!"))

	xeno_owner.create_stomp() //Adds the visual effects. Wom wom wom
	new /obj/effect/temp_visual/oppose_shatter(get_turf(xeno_owner)) //shatter displays stagger range

	var/obj/effect/abstract/particle_holder/aoe_particles = new(owner.loc, /particles/oppose_aoe) //particles display heal range
	aoe_particles.particles.position = generator(GEN_SQUARE, 0, 16 + 3*32, LINEAR_RAND)
	addtimer(CALLBACK(src, PROC_REF(stop_particles), aoe_particles), 0.5 SECONDS)

	var/list/oppose_range = range(3)
	for(var/mob/living/M in oppose_range)
		if(M.stat == DEAD)
			continue
		var/distance = get_dist(M, xeno_owner)
		if(xeno_owner.issamexenohive(M))  //Xenos in range will be healed and overhealed, including you.
			var/mob/living/carbon/xenomorph/target_xeno = M
			var/heal_amount = M.maxHealth * GORGER_OPPOSE_HEAL
			target_xeno.heal_xeno_damage(heal_amount, FALSE)
			target_xeno.adjust_overheal(heal_amount)
			new /obj/effect/temp_visual/healing(get_turf(target_xeno))
			if(owner.client)
				var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
				personal_statistics.heals++
		else if(distance == 0) //if we're right on top of them, they take actual damage
			M.take_overall_damage(20, BRUTE, MELEE, updating_health = TRUE, max_limbs = 3)
			to_chat(M, span_userdanger("[xeno_owner]将她的双拳猛击向你, 将你砸倒在地!"))
			M.adjust_stagger(2 SECONDS)
			M.adjust_slowdown(3)
			shake_camera(M, 3, 3)
		else if(distance == 1) //marines will only be staggerslowed if they're one tile away from you
			shake_camera(M, 2, 2)
			to_chat(M, span_userdanger("血液震碎了周围的地面!"))
			M.adjust_stagger(2 SECONDS)
			M.adjust_slowdown(3)

///Stops particle spawning, then gives existing particles time to fade out before deleting them.
/datum/action/ability/activable/xeno/oppose/proc/stop_particles(obj/effect/abstract/particle_holder/aoe_particles)
	aoe_particles.particles.spawning = 0
	QDEL_IN(aoe_particles, 3 SECONDS)

/datum/action/ability/activable/xeno/oppose/ai_should_use(atom/target)
	return FALSE

// ***************************************
// *********** Feast
// ***************************************

#define FEAST_MISCLICK_CD "feast_misclick"

/datum/action/ability/activable/xeno/feast
	name = "Feast"
	desc = "进入恢复状态. 在此期间你消耗少量血液并治疗自身. 你可以提前取消."
	action_icon_state = "feast"
	action_icon = 'icons/Xeno/actions/gorger.dmi'
	cooldown_duration = 30 SECONDS
	ability_cost = 0
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_FEAST,
	)
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	use_state_flags = ABILITY_USE_STAGGERED

/datum/action/ability/activable/xeno/feast/can_use_ability(atom/target, silent, override_flags)
	. = ..()
	if(TIMER_COOLDOWN_RUNNING(xeno_owner, FEAST_MISCLICK_CD))
		return FALSE
	if(xeno_owner.has_status_effect(STATUS_EFFECT_XENO_FEAST))
		return TRUE
	if(xeno_owner.plasma_stored < xeno_owner.xeno_caste.feast_plasma_drain * 10)
		if(!silent)
			to_chat(xeno_owner, span_notice("不足以开始盛宴. 我们需要[xeno_owner.xeno_caste.feast_plasma_drain * 10]血液."))
		return FALSE

/datum/action/ability/activable/xeno/feast/use_ability(atom/A)
	. = ..()
	if(xeno_owner.has_status_effect(STATUS_EFFECT_XENO_FEAST))
		to_chat(xeno_owner, span_notice("我们决定提前结束我们的盛宴..."))
		xeno_owner.remove_status_effect(STATUS_EFFECT_XENO_FEAST)
		return

	xeno_owner.emote("roar")
	xeno_owner.visible_message(xeno_owner, span_notice("[xeno_owner]开始充满活力!"))
	xeno_owner.apply_status_effect(STATUS_EFFECT_XENO_FEAST, GORGER_FEAST_DURATION, xeno_owner.xeno_caste.feast_plasma_drain)
	TIMER_COOLDOWN_START(src, FEAST_MISCLICK_CD, 2 SECONDS)
	add_cooldown()

/datum/action/ability/activable/xeno/feast/ai_should_use(atom/target)
	// cancel the buff when at full health to conserve plasma, otherwise don't cancel
	if(xeno_owner.has_status_effect(STATUS_EFFECT_XENO_FEAST))
		return xeno_owner.health == xeno_owner.maxHealth
	// small damage has more efficient alternatives to be healed with
	if(xeno_owner.health > xeno_owner.maxHealth * 0.7)
		return FALSE
	// should use the ability when there is enough resource for the buff to tick a moderate amount of times
	if(xeno_owner.plasma_stored / xeno_owner.xeno_caste.feast_plasma_drain < 7)
		return FALSE
	return can_use_ability(target, TRUE)

#undef FEAST_MISCLICK_CD
