//Acid rain is part of the natural weather cycle in the humid forests of LV, and cause acid damage to anyone unprotected.
/datum/weather/acid_rain
	name = "acid rain"
	desc = "这颗行星的雷暴本质上是酸性的, 会烧尽任何站在其下没有防护的人."

	telegraph_duration = 400
	telegraph_message = span_userdanger("雷声在远处轰鸣. 你听到酸性水滴嘶嘶地打在顶篷上. 寻找掩护!")
	telegraph_overlay = "rain_med"
	telegraph_sound = 'sound/effects/siren.ogg'

	weather_message = span_userdanger("<i>酸性雨水倾泻在你周围! 快进去!</i>")
	weather_overlay = "acid_rain"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = span_danger("倾盆大雨逐渐减弱为小雨. 现在外面应该安全了.")
	end_overlay = "rain_low"

	area_type = /area
	protect_indoors = TRUE
	target_trait = ZTRAIT_ACIDRAIN

	barometer_predictable = TRUE

	probability = 40
	repeatable = FALSE

	var/datum/looping_sound/acidrain/sound_active_acidrain = new(list(), FALSE, TRUE)

/datum/weather/acid_rain/telegraph()
	. = ..()
	for(var/mob/impacted_mob AS in GLOB.player_list)
		if(!impacted_mob?.client?.prefs?.volume_weather)
			continue
		var/turf/impacted_mob_turf = get_turf(impacted_mob)
		if(!impacted_mob_turf || !(impacted_mob.z in impacted_z_levels))
			continue
		sound_active_acidrain.output_atoms |= impacted_mob
		CHECK_TICK

/datum/weather/acid_rain/start()
	. = ..()
	sound_active_acidrain.start()

/datum/weather/acid_rain/end()
	. = ..()
	sound_active_acidrain.stop()

/datum/weather/acid_rain/weather_act(mob/living/L)
	if(L.stat == DEAD)
		return
	if(prob(L.modify_by_armor(100, ACID)))
		L.adjust_fire_loss(7)
		to_chat(L, span_danger("你感觉酸雨正在将你融化!"))
	L.wash()
	if(L.fire_stacks > -20)
		L.fire_stacks = max(-20, L.fire_stacks - 1)

	if(ishuman(L))
		var/mob/living/carbon/human/human = L
		if(!istype(human.gloves, /obj/item/clothing/gloves/yautja/hunter))
			return
		var/obj/item/clothing/gloves/yautja/hunter/gloves = human.gloves
		if(gloves.cloaked)
			gloves.decloak(L)
			to_chat(L, span_userdanger("<i>雨水干扰了你的隐形装置!</i>"))

/datum/weather/acid_rain/harmless
	target_trait = ZTRAIT_RAIN

	telegraph_message = span_danger("雷声在远处轰鸣. 你听到水滴敲打在顶篷上.")
	telegraph_overlay = "rain_med"
	telegraph_sound = null

	weather_message = span_danger("<i>雨水倾泻在你周围!</i>")
	weather_overlay = "rain_high"

	end_message = span_danger("倾盆大雨逐渐减弱为小雨.")
	end_overlay = "rain_low"

	probability = 60
	repeatable = TRUE

/datum/weather/acid_rain/harmless/weather_act(mob/living/L)
	L.wash()
	if(L.fire_stacks > -20)
		L.fire_stacks = max(-20, L.fire_stacks - 1)
		if(prob(20))
			if(isrobot(L) || isxeno(L))
				return
			var/wetmessage = pick( "You're drenched in water!",
			"You're completely soaked by rainfall!",
			"You become soaked by the heavy rainfall!",
			"Water drips off your uniform as the rain soaks your outfit!",
			"Rushing water rolls off your face as the rain soaks you completely!",
			"Heavy raindrops hit your face as the rain thoroughly soaks your body!",
			"As you move through the heavy rain, your clothes become completely waterlogged!",
			)
			to_chat(L, span_warning(wetmessage))

	if(ishuman(L))
		var/mob/living/carbon/human/human = L
		if(!istype(human.gloves, /obj/item/clothing/gloves/yautja/hunter))
			return
		var/obj/item/clothing/gloves/yautja/hunter/gloves = human.gloves
		if(gloves.cloaked)
			gloves.decloak(L)
			to_chat(L, span_userdanger("<i>雨水干扰了你的隐形装置!</i>"))

