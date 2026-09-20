/obj/item/explosive/grenade/flashbang
	name = "闪光弹"
	desc = "一种有时被警察、平民或军队使用的榴弹,先用闪光再用巨响眩晕目标.可能导致听力损失,并使受害者产生难以抑制的暴怒情绪."
	icon_state = "flashbang2"
	worn_icon_state = "flashbang2"
	hud_state = "flashbang"
	arm_sound = 'sound/weapons/armbombpin_2.ogg'
	overlay_type = "blue"
	///This is a cluster weapon, or part of one
	var/banglet = FALSE
	///The range where the maximum effects are applied
	var/inner_range = 2
	///The range where the moderate effects are applied
	var/outer_range = 5
	///The the max of the flashbang
	var/max_range = 7
	///Whether this grenade requires skill to use
	var/mp_only = TRUE

/obj/item/explosive/grenade/flashbang/attack_self(mob/user)
	if(mp_only && (user.skills.getRating(SKILL_POLICE) < SKILL_POLICE_MP))
		to_chat(user, span_warning("你似乎不知道如何使用[src]..."))
		return
	..()


/obj/item/explosive/grenade/flashbang/prime()
	var/turf/target_turf = get_turf(src)
	playsound(target_turf, SFX_FLASHBANG, 65)
	for(var/mob/living/carbon/victim in hearers(max_range, target_turf))
		if(!HAS_TRAIT(victim, TRAIT_FLASHBANGIMMUNE))
			bang(target_turf, victim)

	new/obj/effect/particle_effect/smoke/flashbang(target_turf)
	qdel(src)

///Applies the flashbang effects based off range and ear protection
/obj/item/explosive/grenade/flashbang/proc/bang(turf/T , mob/living/carbon/M)
	to_chat(M, span_danger("砰"))

	//Checking for protection
	var/ear_safety = 0
	if(iscarbon(M))
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(istype(H.wear_ear, /obj/item/clothing/ears/earmuffs))
				ear_safety += 2
			if(istype(H.head, /obj/item/clothing/head/helmet/riot))
				ear_safety += 2
			if(istype(H.head, /obj/item/clothing/head/helmet/marine/veteran/pmc/commando))
				ear_safety += INFINITY
				inner_range = null
				outer_range = null
				max_range = null

	if(get_dist(M, T) <= inner_range)
		inner_effect(T, M, ear_safety)
	else if(get_dist(M, T) <= outer_range)
		outer_effect(T, M, ear_safety)
	else
		max_range_effect(T, M, ear_safety)

	base_effect(T, M, ear_safety) //done afterwards as it contains the eye/ear damage checks

///The effects applied to all mobs in range
/obj/item/explosive/grenade/flashbang/proc/base_effect(turf/T , mob/living/carbon/M, ear_safety)
	if(M.flash_act())
		M.apply_effects(stun = 4 SECONDS, paralyze = 2 SECONDS)
	if(M.ear_damage >= 15)
		to_chat(M, span_warning("你的耳朵开始严重耳鸣!"))
		if(!banglet)
			if (prob(M.ear_damage - 10 + 5))
				to_chat(M, span_warning("你什么都听不见了!"))
				M.disabilities |= DEAF
	else
		if(M.ear_damage >= 5)
			to_chat(M, span_warning("你的耳朵开始耳鸣!"))

///The effects applied to mobs in the inner_range
/obj/item/explosive/grenade/flashbang/proc/inner_effect(turf/T , mob/living/carbon/M, ear_safety)
	if(ear_safety > 0)
		M.apply_effects(stun = 4 SECONDS, paralyze = 2 SECONDS)
	else
		M.apply_effects(stun = 20 SECONDS, paralyze = 6 SECONDS)
		if((prob(14) || (M == src.loc && prob(70))))
			M.adjust_ear_damage(rand(1, 10),15)
		else
			M.adjust_ear_damage(rand(0, 5),10)

///The effects applied to mobs in the outer_range
/obj/item/explosive/grenade/flashbang/proc/outer_effect(turf/T , mob/living/carbon/M, ear_safety)
	if(!ear_safety)
		M.apply_effect(16 SECONDS, EFFECT_STUN)
		M.adjust_ear_damage(rand(0, 3),8)

///The effects applied to mobs outside of outer_range
/obj/item/explosive/grenade/flashbang/proc/max_range_effect(turf/T , mob/living/carbon/M, ear_safety)
	if(!ear_safety)
		M.apply_effect(8 SECONDS, EFFECT_STUN)
		M.adjust_ear_damage(rand(0, 1),6)

//Slows and staggers instead of hardstunning, balanced for HvH
/obj/item/explosive/grenade/flashbang/stun
	name = "眩晕手榴弹"
	desc = "一种榴弹,旨在用刺眼的闪光和剧烈的巨响扰乱爆炸半径内所有人的感官.反复使用可导致耳聋."
	icon_state = "flashbang2"
	worn_icon_state = "flashbang2"
	inner_range = 3
	det_time = 2 SECONDS
	mp_only = FALSE
	overlay_type = "blue"

/obj/item/explosive/grenade/flashbang/stun/base_effect(turf/T , mob/living/carbon/M, ear_safety)
	if(M.ear_damage >= 15)
		to_chat(M, span_warning("你的耳朵开始严重耳鸣!"))
		if(prob(M.ear_damage - 15)) //You have to eat a lot of stun grenades to risk permanently deafening you
			to_chat(M, span_warning("你什么都听不见了!"))
			M.disabilities |= DEAF
	else
		if(M.ear_damage >= 5)
			to_chat(M, span_warning("你的耳朵开始耳鸣!"))

/obj/item/explosive/grenade/flashbang/stun/inner_effect(turf/T , mob/living/carbon/M, ear_safety)
	if(M.flash_act(duration = 10))
		M.blur_eyes(7)

	if(ear_safety > 0)
		M.adjust_stagger(3 SECONDS)
		M.add_slowdown(3)
	else
		M.adjust_stagger(6 SECONDS)
		M.add_slowdown(6)
		if((prob(14) || (M == src.loc && prob(70))))
			M.adjust_ear_damage(rand(1, 10),15)
		else
			M.adjust_ear_damage(rand(0, 5),10)

/obj/item/explosive/grenade/flashbang/stun/outer_effect(turf/T , mob/living/carbon/M, ear_safety)
	if(M.flash_act(duration = 10))
		M.blur_eyes(6)

	if(!ear_safety)
		M.adjust_stagger(4 SECONDS)
		M.add_slowdown(4)
		M.adjust_ear_damage(rand(0, 3),8)

/obj/item/explosive/grenade/flashbang/stun/max_range_effect(turf/T , mob/living/carbon/M, ear_safety)
	if(M.flash_act(duration = 5))
		M.blur_eyes(4)

	if(!ear_safety)
		M.adjust_stagger(2 SECONDS)
		M.add_slowdown(2)
		M.adjust_ear_damage(rand(0, 1),6)
