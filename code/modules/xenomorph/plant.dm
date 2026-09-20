/obj/structure/xeno/plant
	name = "异形植物"
	max_integrity = 5
	icon = 'icons/Xeno/plants.dmi'
	interaction_flags = INTERACT_CHECK_INCAPACITATED
	///The plant's icon once it's fully grown
	var/mature_icon_state
	///Is the plant ready to be used ?
	var/mature = FALSE
	///How long does it take for the plant to be useable
	var/maturation_time = 2 MINUTES

/obj/structure/xeno/plant/Initialize(mapload, _hivenumber)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(on_mature)), maturation_time)
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('icons/UI_icons/map_blips.dmi', null, "[mature_icon_state]", MINIMAP_BLIPS_LAYER))

/obj/structure/xeno/plant/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE
	if(!mature && isxeno(user))
		balloon_alert(user, "未完全成长")
		return FALSE

/obj/structure/xeno/plant/update_icon_state()
	. = ..()
	icon_state = (mature) ? mature_icon_state : initial(icon_state)

///Called whenever someone uses the plant, xeno or marine
/obj/structure/xeno/plant/proc/on_use(mob/user)
	mature = FALSE
	update_icon()
	addtimer(CALLBACK(src, PROC_REF(on_mature)), maturation_time)
	return TRUE

///Called when the plant reaches maturity
/obj/structure/xeno/plant/proc/on_mature(mob/user)
	playsound(src, SFX_ALIEN_RESIN_BUILD, 25)
	mature = TRUE
	update_icon()

/obj/structure/xeno/plant/attack_hand(mob/living/user)
	if(!can_interact(user))
		return ..()
	return on_use(user)

/obj/structure/xeno/plant/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if((xeno_attacker.status_flags & INCORPOREAL))
		return FALSE

	if(xeno_attacker.a_intent == INTENT_HARM && isxenodrone(xeno_attacker))
		balloon_alert(xeno_attacker, "已拔起植物")
		xeno_attacker.do_attack_animation(src)
		deconstruct(TRUE)
		return FALSE
	if(can_interact(xeno_attacker))
		return on_use(xeno_attacker)
	return TRUE

/obj/structure/xeno/plant/heal_fruit
	name = "生命果实"
	desc = "它几乎很诱人, 如果不是因为那绿色和内部流动的液体的话..."
	icon_state = "heal_fruit_immature"
	mature_icon_state = "heal_fruit"
	///Minimum amount of health recovered
	var/healing_amount_min = 125
	///Maximum amount of health recovered, depends on the xeno's max health
	var/healing_amount_max_health_scaling = 0.5

/obj/structure/xeno/plant/heal_fruit/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(!disassembled && mature)
		var/datum/effect_system/smoke_spread/xeno/acid/plant_explosion = new(get_turf(src))
		plant_explosion.set_up(3,src)
		plant_explosion.start()
		visible_message(span_danger("[src]爆裂, 释放出毒气!"))
	return ..()

/obj/structure/xeno/plant/heal_fruit/on_use(mob/user)
	balloon_alert(user, "食用中...")
	if(!do_after(user, 2 SECONDS, IGNORE_HELD_ITEM, src))
		return FALSE
	if(!isxeno(user))
		deconstruct(FALSE)
		return TRUE

	var/mob/living/carbon/xenomorph/X = user
	var/heal_amount = max(healing_amount_min, healing_amount_max_health_scaling * X.xeno_caste.max_health)
	X.heal_xeno_damage(heal_amount, FALSE)
	playsound(user, SFX_ALIEN_DROOL, 25)
	balloon_alert(X, "生命值已恢复")
	to_chat(X, span_xenowarning("当[src]治疗我们的伤口时, 我们感到一阵突然的舒缓凉意."))

	return ..()

/obj/structure/xeno/plant/armor_fruit
	name = "坚硬果实"
	desc = "这种果实的内容物由坚硬的外壳保护."
	icon_state = "armor_fruit_immature"
	mature_icon_state = "armor_fruit"
	///How much total sunder should we remove
	var/sunder_removal = 30

/obj/structure/xeno/plant/armor_fruit/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(!disassembled && mature)
		for (var/mob/living/carbon/human/nearby_human AS in cheap_get_humans_near(src, 1))
			var/turf/far_away_lands = get_turf(nearby_human)
			for(var/x in 1 to 20)
				var/turf/next_turf = get_step(far_away_lands, REVERSE_DIR(nearby_human.dir))
				if(!next_turf)
					break
				far_away_lands = next_turf

			nearby_human.throw_at(far_away_lands, 20, spin = TRUE)
			to_chat(nearby_human, span_warning("[src]爆裂, 释放出一阵强烈的加压气体!"))
			nearby_human.adjust_stagger(3 SECONDS)
			nearby_human.apply_damage(30, BRUTE, "chest", BOMB)
	return ..()

/obj/structure/xeno/plant/armor_fruit/on_use(mob/user)
	balloon_alert(user, "食用中...")
	if(!do_after(user, 2 SECONDS, IGNORE_HELD_ITEM, src))
		return FALSE
	if(!isxeno(user))
		deconstruct(FALSE)
		return TRUE

	balloon_alert(user, "护甲已恢复")
	to_chat(user, span_xenowarning("我们褪去破碎的鳞片, 新的鳞片生长出来替代它们!"))
	var/mob/living/carbon/xenomorph/X = user
	X.adjust_sunder(-sunder_removal)
	playsound(user, SFX_ALIEN_DROOL, 25)
	return ..()

/obj/structure/xeno/plant/plasma_fruit
	name = "能量果实"
	desc = "一颗青色的果实, 像生物的心脏一样跳动"
	icon_state = "plasma_fruit_immature"
	mature_icon_state = "plasma_fruit"
	///How much bonus plasma should we restore during the duration, 1 being 100% from base regen
	var/bonus_regen = 1
	///How long should the buff last
	var/duration = 1 MINUTES

/obj/structure/xeno/plant/plasma_fruit/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(!disassembled && mature)
		var/datum/effect_system/smoke_spread/xeno/pyrogen_fire/plant_explosion = new(get_turf(src))
		plant_explosion.set_up(4, src)
		plant_explosion.start()
		visible_message(span_warning("[src]爆裂, 释放出蓝色高温气体!"))
	return ..()

/obj/structure/xeno/plant/plasma_fruit/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE
	if(!isxeno(user))
		return
	var/mob/living/carbon/xenomorph/X = user
	if(X.has_status_effect(STATUS_EFFECT_PLASMA_SURGE))
		balloon_alert(X, "等离子体再生已提升")
		return FALSE

/obj/structure/xeno/plant/plasma_fruit/on_use(mob/user)
	balloon_alert(user, "食用中...")
	if(!do_after(user, 2 SECONDS, IGNORE_HELD_ITEM, src))
		return FALSE
	if(!isxeno(user))
		deconstruct(FALSE)
		return TRUE

	var/mob/living/carbon/xenomorph/X = user
	if(!(X.xeno_caste.can_flags & CASTE_CAN_BE_GIVEN_PLASMA))
		to_chat(X, span_xenowarning("但我们的身体排斥这颗果实, 我们不是同一种等离子体类型!"))
		return FALSE
	X.apply_status_effect(/datum/status_effect/plasma_surge, X.xeno_caste.plasma_max, bonus_regen, duration)
	balloon_alert(X, "等离子体已恢复")
	to_chat(X, span_xenowarning("[src]恢复我们的等离子体储备, 我们的生物体超速运转!"))
	playsound(user, SFX_ALIEN_DROOL, 25)
	return ..()

/obj/structure/xeno/plant/stealth_plant
	name = "夜影"
	desc = "一朵美丽的花, 然而它对异形巢穴能有什么用途, 你无法理解..."
	icon_state = "stealth_plant_immature"
	mature_icon_state = "stealth_plant"
	maturation_time = 4 MINUTES
	///The radius of the passive structure camouflage, requires line of sight
	var/camouflage_range = 7
	///The range of the active stealth ability, does not require line of sight
	var/active_camouflage_pulse_range = 10
	///How long should veil last
	var/active_camouflage_duration = 20 SECONDS
	///How long until the plant can be activated again
	var/cooldown = 2 MINUTES
	///Is the active ability veil on cooldown ?
	var/on_cooldown = FALSE
	///The list of passively camouflaged structures
	var/list/obj/structure/xeno/camouflaged_structures = list()
	////The list of actively camouflaged xenos by veil
	var/list/mob/living/carbon/xenomorph/camouflaged_xenos = list()

/obj/structure/xeno/plant/stealth_plant/on_mature(mob/user)
	. = ..()
	START_PROCESSING(SSslowprocess, src)

/obj/structure/xeno/plant/stealth_plant/Destroy()
	for(var/obj/structure/xeno/xeno_struct AS in camouflaged_structures)
		xeno_struct.alpha = initial(xeno_struct.alpha)
	unveil()
	STOP_PROCESSING(SSslowprocess, src)
	return ..()

/obj/structure/xeno/plant/stealth_plant/process()
	for(var/turf/tile AS in RANGE_TURFS(camouflage_range, loc))
		for(var/obj/structure/xeno/xeno_struct in tile)
			if(istype(xeno_struct, /obj/structure/xeno/plant) || !line_of_sight(src, xeno_struct)) //We don't hide plants
				continue
			camouflaged_structures.Add(xeno_struct)
			xeno_struct.alpha = STEALTH_PLANT_PASSIVE_CAMOUFLAGE_ALPHA

/obj/structure/xeno/plant/stealth_plant/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE
	if(ishuman(user))
		balloon_alert(user, "什么也没发生")
		to_chat(user, span_notice("你抚摸[src]的花瓣, 什么也没发生."))
		return FALSE
	if(on_cooldown)
		balloon_alert(user, "尚未准备好")
		to_chat(user, span_xenowarning("[src]柔和的光芒闪烁, 我们应该给它更多时间恢复!"))
		return FALSE

/obj/structure/xeno/plant/stealth_plant/on_use(mob/user)
	balloon_alert(user, "摇晃中...")
	if(!do_after(user, 2 SECONDS, IGNORE_HELD_ITEM, src))
		return FALSE
	visible_message(span_danger("[src]释放出一阵发光的花粉!"))
	veil()
	return TRUE

///Hides all nearby xenos
/obj/structure/xeno/plant/stealth_plant/proc/veil()
	for(var/turf/tile in RANGE_TURFS(camouflage_range, loc))
		for(var/mob/living/carbon/xenomorph/X in tile)
			if(X.stat == DEAD || isxenohunter(X) || X.alpha != 255) //We don't mess with xenos capable of going stealth by themselves
				continue
			X.alpha = HUNTER_STEALTH_RUN_ALPHA
			ADD_TRAIT(X, TRAIT_STEALTH, XENO_TRAIT)
			new /obj/effect/temp_visual/alien_fruit_eaten(get_turf(X))
			balloon_alert(X, "我们现在融入环境")
			to_chat(X, span_xenowarning("[src]的花粉与我们的鳞片发生反应, 我们正在融入周围环境!"))
			camouflaged_xenos.Add(X)
	on_cooldown = TRUE
	addtimer(CALLBACK(src, PROC_REF(unveil)), active_camouflage_duration)
	addtimer(CALLBACK(src, PROC_REF(ready)), cooldown)

///Called when veil() can be used once again
/obj/structure/xeno/plant/stealth_plant/proc/ready()
	visible_message(span_danger("[src]的花瓣色调变化, 它已准备好释放更多花粉."))
	on_cooldown = FALSE

///Reveals all xenos hidden by veil()
/obj/structure/xeno/plant/stealth_plant/proc/unveil()
	for(var/mob/living/carbon/xenomorph/X AS in camouflaged_xenos)
		X.alpha = initial(X.alpha)
		REMOVE_TRAIT(X, TRAIT_STEALTH, XENO_TRAIT)
		balloon_alert(X, "效果消退")
		to_chat(X, span_xenowarning("[src]的效果消退了!"))
