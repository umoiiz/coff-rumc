/obj/item/explosive/grenade/spawnergrenade/smartdisc
	name = "智能飞盘"
	spawner_type = /mob/living/simple_animal/hostile/smartdisc
	deliveryamt = 1
	desc = "一件奇怪的外星科技产物.它有许多锯齿状的、旋转的刀刃和奇异的文字."
	item_flags = ITEM_PREDATOR
	icon = 'icons/obj/hunter/pred_gear.dmi'
	worn_icon_list = list(
		slot_back_str = 'icons/mob/hunter/pred_gear.dmi',
		slot_l_hand_str = 'icons/mob/hunter/items_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/hunter/items_righthand.dmi'
	)
	icon_state = "disc"
	worn_icon_state = "pred_disc"
	w_class = WEIGHT_CLASS_TINY
	det_time = 30
	resistance_flags = UNACIDABLE
	embedding = list("embed_chance" = 0, "embedded_fall_chance" = 0)

	force = 15
	throwforce = 35
	throw_speed = 1

	throw_sound = 'sound/effects/smartdisk_throw.ogg'
	hitsound = 'sound/effects/smartdisk_hit.ogg'

	var/mob/living/simple_animal/hostile/smartdisc/spawned_item

/obj/item/explosive/grenade/spawnergrenade/smartdisc/afterattack(atom/A, mob/user, proximity, params)
	if(istype(A, /obj/item/clothing/gloves/yautja))
		var/obj/item/clothing/gloves/yautja/bracer = A
		if(length(bracer.discs) < bracer.max_disc_cap)
			if(src in bracer.discs)
				to_chat(user, span_warning("你解除了[bracer]与[src]的连接."))
				playsound(user.loc, 'sound/items/pred_bracer.ogg', 75, 1)
				bracer.discs -= src
			else
				bracer.discs += src
				to_chat(user, span_warning("你将[src]连接到[bracer]."))
				playsound(user.loc, 'sound/items/pred_bracer.ogg', 75, 1)
		else
			if(src in bracer.discs)
				to_chat(user, span_warning("你解除了[bracer]与[src]的连接."))
				playsound(user.loc, 'sound/items/pred_bracer.ogg', 75, 1)
				bracer.discs -= src
			else
				to_chat(user, span_warning("你的上限是[bracer.max_disc_cap],在飞盘前解除连接,以添加另一个."))
		bracer.owner.update_action_buttons()
	..()

/obj/item/explosive/grenade/spawnergrenade/smartdisc/throw_at(atom/target, range, speed, thrower, spin, flying)
	..()
	var/mob/user = usr
	if(!active && isyautja(user) && (icon_state == initial(icon_state)))
		boomerang(user)

/obj/item/explosive/grenade/spawnergrenade/smartdisc/proc/boomerang(mob/user)
	active = TRUE
	icon_state = initial(icon_state) + "_active"
	sleep(1 SECONDS)
	var/mob/living/L = find_target(user)
	if(L)
		throw_at(L.loc, 4, 6.67, usr)
	sleep(1 SECONDS)
	throw_at(usr, 12, 1, usr)
	addtimer(CALLBACK(src, PROC_REF(clear_boomerang)), 1 SECONDS)
	playsound(src, 'sound/effects/smartdisk_throw.ogg', 25)

/obj/item/explosive/grenade/spawnergrenade/smartdisc/proc/clear_boomerang()
	active = FALSE
	icon_state = initial(icon_state)

/obj/item/explosive/grenade/spawnergrenade/smartdisc/proc/find_target(mob/user)
	var/atom/T = null
	for(var/mob/living/A in listtargets(4))
		if(A == src)
			continue
		if(isliving(A))
			var/mob/living/L = A
			if(L.faction == user.faction)
				continue
			else if(isyautja(L))
				continue
			else if (L.stat == DEAD)
				continue
			else
				T = L
				break
	return T

/obj/item/explosive/grenade/spawnergrenade/smartdisc/proc/listtargets(dist = 3)
	var/list/L = hearers(src, dist)
	return L

/obj/item/explosive/grenade/spawnergrenade/smartdisc/attack_self(mob/user)
	..()

	if(active)
		return

	if(!isyautja(user))
		if(prob(75))
			to_chat(user, span_warning("你摆弄着飞盘,但什么也没发生.也许再试一次?"))
			return
	to_chat(user, span_warning("你激活了智能飞盘,它嗡嗡地转动起来!"))
	activate(user)
	add_fingerprint(user)
	var/mob/living/carbon/C = user
	if(istype(C) && !C.in_throw_mode)
		C.throw_mode_on()

/obj/item/explosive/grenade/spawnergrenade/smartdisc/activate(mob/user)
	if(active)
		return

	if(user)
		log_attack("[key_name(user)] primed \a [src] in [get_area(user)] ([user.loc.x],[user.loc.y],[user.loc.z]).", user.loc.x, user.loc.y, user.loc.z)

	icon_state = initial(icon_state) + "_active"
	active = TRUE
	playsound(loc, 'sound/items/countdown.ogg', 25, 1)
	update_icon()
	addtimer(CALLBACK(src, PROC_REF(prime)), det_time)

/obj/item/explosive/grenade/spawnergrenade/smartdisc/prime()
	if(spawner_type && deliveryamt)
		// Make a quick flash
		var/turf/T = get_turf(src)
		var/mob/living/simple_animal/hostile/smartdisc/x = new spawner_type
		if(istype(loc, /mob))
			var/mob/handler = loc
			handler.temporarilyRemoveItemFromInventory(src, TRUE)
		x.forceMove(T)
		forceMove(x)
		spawned_item = x
		x.spawner_item = src
	return

/obj/item/explosive/grenade/spawnergrenade/smartdisc/throw_impact(atom/hit_atom)
	if(isyautja(hit_atom))
		var/mob/living/carbon/human/H = hit_atom
		if(H.put_in_hands(src))
			clear_boomerang()
			hit_atom.visible_message("[hit_atom]熟练地在空中接住了[src].","你轻松地接住了[src].")
			throwing = FALSE
			return TURF_ENTER_ALREADY_MOVED
		return FALSE
	..()

/mob/living/simple_animal/hostile/smartdisc
	name = "smart-disc"
	desc = "一阵狂暴旋转的刀刃与外星科技."
	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "disc_active"
	icon_living = "disc_active"
	icon_dead = "disc"
	icon_gib = "disc"
	speak_chance = 0
	turns_per_move = 1
	response_help = "stares at the"
	response_disarm = "bats aside the"
	response_harm = "hits the"
	speed = -2
	maxHealth = 60
	health = 60
	attack_same = 0
	density = FALSE
	mob_size = MOB_SIZE_SMALL

	obj_damage = 50
	melee_damage = 25
	harm_intent_damage = 10
	attacktext = "slices"
	attack_sound = 'sound/effects/smartdisk_hit.ogg'


	faction = FACTION_YAUTJA

	var/obj/item/explosive/grenade/spawnergrenade/smartdisc/spawner_item

	var/lifetime = 8 //About 15 seconds.
	var/time_idle = 0


/mob/living/simple_animal/hostile/smartdisc/Process_Spacemove(check_drift = 0)
	return 1


/mob/living/simple_animal/hostile/smartdisc/bullet_act(atom/movable/projectile/proj)
	. = ..()

	if(prob(60 - proj.damage))
		return 0

	if(!proj || proj.damage <= 0)
		return 0

	apply_damage(proj.damage, BRUTE)
	return 1

/mob/living/simple_animal/hostile/smartdisc/Life(seconds_per_tick, times_fired)
	. = ..()
	lifetime--
	if(lifetime <= 0 || time_idle > 3)
		visible_message("\The [src]停止旋转,滑落到地板上.")
		drop_real_disc()
		qdel(src)
		return

/mob/living/simple_animal/hostile/smartdisc/death(gibbing = FALSE, deathmessage = "seizes up and falls limp...", silent = FALSE)
	visible_message("\The [src]停止旋转,滑落到地板上.")
	drop_real_disc()
	. = ..()
	QDEL_IN(src, 0.1 SECONDS)

/mob/living/simple_animal/hostile/smartdisc/proc/drop_real_disc()
	spawner_item.forceMove(loc)
	spawner_item.icon_state = initial(spawner_item.icon_state)
	spawner_item.overlays.Cut()
	spawner_item.active = FALSE
	// don't make GC cry
	spawner_item.spawned_item = null
	spawner_item = null
	qdel(src)

/mob/living/simple_animal/hostile/smartdisc/gib()
	visible_message("\The [src]爆炸了!")
	. = ..()
	QDEL_IN(src, 0.1 SECONDS)

/mob/living/simple_animal/hostile/smartdisc/FindTarget()
	var/atom/T = null
	stop_automated_movement = 0

	for(var/atom/A in ListTargets(5))
		if(A == src)
			continue

		if(isliving(A))
			var/mob/living/L = A
			if(L.faction == faction)
				continue
			else if(L in friends)
				continue
			else if(isyautja(L))
				continue
			else if (L.stat == DEAD)
				continue
			else
				if(!L.stat)
					T = L
					break
	GiveTarget(T)
	return T

/mob/living/simple_animal/hostile/smartdisc/ListTargets(dist = 7)
	var/list/L = hearers(src, dist)
	return L

/mob/living/simple_animal/hostile/smartdisc/AttackingTarget()
	if(QDELETED(target))  return
	if(!Adjacent(target))  return
	if(isliving(target))
		var/mob/living/L = target
		L.attack_animal(src)
		if(prob(5))
			L.apply_effect(3, EFFECT_PARALYZE)
			L.visible_message(span_danger("\The [src]凶猛地劈砍\the [L]!"))
			log_attack("[key_name(L)] was knocked down by [src]")
		log_attack("[key_name(L)] was attacked by [src]")
		return L
