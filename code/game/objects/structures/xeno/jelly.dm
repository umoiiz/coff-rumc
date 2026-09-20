/obj/item/resin_jelly
	name = "树脂凝胶"
	desc = "一种恶心粘稠的树脂凝胶,似乎不容易燃烧."
	icon = 'icons/Xeno/xeno_materials.dmi'
	icon_state = "resin_jelly"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 200, ACID = 0)
	var/immune_time = 15 SECONDS
	///Holder to ensure only one user per resin jelly.
	var/current_user

/obj/item/resin_jelly/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(xeno_attacker.status_flags & INCORPOREAL)
		return FALSE

	if(xeno_attacker.xeno_caste.can_flags & CASTE_CAN_HOLD_JELLY)
		return attack_hand(xeno_attacker)
	if(xeno_attacker.do_actions || !isnull(current_user))
		return
	current_user = xeno_attacker
	activate_jelly(xeno_attacker)

/obj/item/resin_jelly/attack_self(mob/living/carbon/xenomorph/user)
	//Activates if the item itself is clicked in hand.
	if(!isxeno(user))
		return
	if(user.do_actions || !isnull(current_user))
		return
	current_user = user
	activate_jelly(user)

/obj/item/resin_jelly/attack(mob/living/carbon/xenomorph/M, mob/living/user)
	//Activates if active hand and clicked on mob in game.
	//Can target self so we need to check for that.
	if(!isxeno(user))
		return TRUE
	if(!isxeno(M))
		M.balloon_alert(user, "无法涂抹")
		return FALSE
	if(user.do_actions || !isnull(current_user))
		return FALSE
	current_user = M
	activate_jelly(M)
	user.temporarilyRemoveItemFromInventory(src)
	return FALSE

/obj/item/resin_jelly/proc/activate_jelly(mob/living/carbon/xenomorph/user)
	user.visible_message(span_notice("[user]的甲壳开始闪烁着一种诡异的光芒..."), span_xenonotice("当我们被[src]覆盖时,我们感到充满力量!"))
	user.emote("roar")
	user.apply_status_effect(STATUS_EFFECT_RESIN_JELLY_COATING)
	SEND_SIGNAL(user, COMSIG_XENOMORPH_RESIN_JELLY_APPLIED)
	qdel(src)

/obj/item/resin_jelly/throw_at(atom/target, range, speed, thrower, spin, flying = FALSE, targetted_throw = TRUE)
	if(isxenohivelord(thrower))
		RegisterSignal(src, COMSIG_MOVABLE_IMPACT, PROC_REF(jelly_throw_hit))
	. = ..()

/obj/item/resin_jelly/proc/jelly_throw_hit(datum/source, atom/hit_atom)
	SIGNAL_HANDLER
	UnregisterSignal(source, COMSIG_MOVABLE_IMPACT)
	if(!isxeno(hit_atom))
		return
	var/mob/living/carbon/xenomorph/xenomorph_target = hit_atom
	if(xenomorph_target.xeno_caste.caste_flags & CASTE_FIRE_IMMUNE)
		return
	xenomorph_target.visible_message(span_notice("[xenomorph_target]被凝胶溅到了!"))
	INVOKE_ASYNC(src, PROC_REF(activate_jelly), xenomorph_target)

///////////////////////
/// Globadier Mines ///
///////////////////////

/obj/structure/xeno/acid_mine
	name = "酸液地雷"
	desc = "一个奇怪的球茎,里面装满了酸液."
	icon = 'icons/obj/items/mine.dmi'
	icon_state = "acid_mine"
	density = FALSE
	opacity = FALSE
	anchored = TRUE
	max_integrity = 5
	hit_sound = SFX_ALIEN_RESIN_BREAK
	/// The damage dealt to mobs nearby the detonation point of the mine
	var/acid_damage = 30

/obj/structure/xeno/acid_mine/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(oncrossed),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/xeno/acid_mine/obj_destruction(damage_amount, damage_type, damage_flag, mob/living/blame_mob)
	detonate(blame_mob)
	return ..()

/// Checks if the mob walking over the mine is human, and calls detonate if so
/obj/structure/xeno/acid_mine/proc/oncrossed(datum/source, atom/movable/A, oldloc, oldlocs)
	SIGNAL_HANDLER
	if(!ishuman(A))
		return
	if(CHECK_MULTIPLE_BITFIELDS(A.allow_pass_flags, HOVERING))
		return
	INVOKE_ASYNC(src, PROC_REF(detonate), A)

///Handles detonating the mine, and dealing damage to those nearby
/obj/structure/xeno/acid_mine/proc/detonate(triggerer)
	for(var/spatter_effect in filled_turfs(get_turf(src), 1, "square", pass_flags_checked = PASS_AIR))
		new /obj/effect/temp_visual/acid_splatter(spatter_effect)
	for(var/mob/living/carbon/human/human_victim AS in cheap_get_humans_near(src,1))
		human_victim.apply_damage(acid_damage/2, BURN, BODY_ZONE_L_LEG, ACID,  penetration = 30)
		human_victim.apply_damage(acid_damage/2, BURN, BODY_ZONE_R_LEG, ACID,  penetration = 30)
		playsound(src, "sound/bullets/acid_impact1.ogg", 10)
	qdel(src)

/obj/structure/xeno/acid_mine/gas_mine
	name = "毒气地雷"
	desc = "一个奇怪的球茎,里面溢满了酸液.时不时有小股气体逸出."
	icon_state = "gas_mine"
	acid_damage = 40

/obj/structure/xeno/acid_mine/gas_mine/detonate(triggerer)
	var/datum/effect_system/smoke_spread/xeno/acid/opaque/smog = new(get_turf(src))
	smog.set_up(1,src)
	smog.start()

//////////////////
/// Incen Mine ///
//////////////////

/obj/structure/xeno/acid_mine/incen_mine
	name = "燃烧地雷"
	desc = "一个紫色的团块,像闪电一样迸发火花."
	icon_state = "incen_mine"

/obj/structure/xeno/acid_mine/incen_mine/detonate(triggerer)
	flame_radius(1, get_turf(src), fire_type = /obj/fire/melting_fire/shattering, burn_intensity = 20, burn_duration = 180, colour = "violet")
	qdel(src)

//////////////////
/// Resin Mine ///
//////////////////

/obj/structure/xeno/acid_mine/resin_mine
	name = "树脂地雷"
	desc = "一个半透明的紫色团块,内部排列着清澈的树脂安瓿."
	icon_state = "resin_mine"

/obj/structure/xeno/acid_mine/resin_mine/detonate(triggerer)
	var/cannotbuild = FALSE
	for(var/turf/resin_tile in filled_turfs(get_turf(src), 0.5, "circle", pass_flags_checked = PASS_AIR))
		cannotbuild = FALSE
		if((resin_tile.density || istype(resin_tile, /turf/open/space))) // No structures in space
			continue

		for(var/obj/O in resin_tile.contents)
			if(istype(O, /obj/alien/resin))
				cannotbuild = TRUE

		if(!cannotbuild)
			new /obj/alien/resin/sticky(resin_tile)

	for(var/mob/living/carbon/human/affected AS in cheap_get_humans_near(src,1))
		if(affected.stat == DEAD)
			continue
		var/throwloc = affected.loc
		for(var/x in 1 to 6)
			throwloc = get_step(throwloc, REVERSE_DIR(affected.dir))
		affected.throw_at(throwloc, 12, 2.5, src, TRUE)
	qdel(src)

//////////////////
/// Neuro Mine ///
//////////////////

/obj/structure/xeno/acid_mine/neuro_mine
	name = "神经毒素地雷"
	desc = "一个颜色怪异的杂草囊,充满了浓密的橙色气体."
	icon_state = "neuro_mine"

/obj/structure/xeno/acid_mine/neuro_mine/detonate(triggerer)
	var/datum/effect_system/smoke_spread/xeno/neuro/medium/gas = new(get_turf(src))
	gas.set_up(2, src)
	gas.start()

	if(ishuman(triggerer))
		var/mob/living/carbon/human/victim = triggerer
		victim.reagents.add_reagent(/datum/reagent/toxin/xeno_neurotoxin, 5)
		to_chat(victim, span_userdanger("你被地雷上的尖刺刺伤了!"))
	qdel(src)

//////////////////////
/// Lifetrade Mine ///
//////////////////////

/obj/structure/xeno/acid_mine/drain_mine
	name = "汲取地雷"
	desc = "一个青色的团块,闪烁着生命之血的光芒."
	icon_state = "emp_mine"

/obj/structure/xeno/acid_mine/drain_mine/detonate(triggerer)
	if(ishuman(triggerer))
		var/mob/living/carbon/human/victim = triggerer
		victim.apply_status_effect(STATUS_EFFECT_LIFEDRAIN)
		new /obj/effect/temp_visual/telekinesis(get_turf(victim))
	var/datum/effect_system/smoke_spread/xeno/hemodile/gas = new(get_turf(src))
	gas.set_up(2, src)
	gas.start()
	qdel(src)
