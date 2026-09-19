//Ash storms happen frequently on lavaland. They heavily obscure vision, and cause high fire damage to anyone caught outside.
/datum/weather/ash_storm
	name = "ash storm"
	desc = "一场强烈的风暴将灰烬从行星表面卷起并席卷整个区域, 对没有防护的人造成强烈的火焰伤害."

	telegraph_message = span_userdanger("风中升起一阵诡异的哀鸣. 燃烧的灰烬遮蔽了地平线. 寻找掩护.")
	telegraph_duration = 300
	telegraph_overlay = "light_ash"

	weather_message = span_userdanger("<i>灼热的灰烬云翻滚着涌向你周围! 快进去!</i>")
	weather_duration_lower = 600
	weather_duration_upper = 1200
	weather_overlay = "ash_storm"

	end_message = span_danger("尖啸的风吹走了最后的灰烬, 归于往常的低语. 现在出去应该安全了.")
	end_duration = 300
	end_overlay = "light_ash"

	area_type = /area
	protect_indoors = TRUE
	target_trait = ZTRAIT_ASHSTORM

	probability = 40

	barometer_predictable = TRUE

	var/datum/looping_sound/active_ashstorm/sound_active_ashstorm = new(list(), FALSE, TRUE)
	var/datum/looping_sound/weak_ashstorm/sound_weak_ashstorm = new(list(), FALSE, TRUE)

/datum/weather/ash_storm/telegraph()
	. = ..()
	var/list/impacted_mobs = list()
	for(var/mob/impacted_mob AS in GLOB.player_list)
		if(!impacted_mob?.client?.prefs?.volume_weather)
			continue
		var/turf/impacted_mob_turf = get_turf(impacted_mob)
		if(!impacted_mob_turf || !(impacted_mob.z in impacted_z_levels))
			continue
		impacted_mobs |= impacted_mob
		CHECK_TICK

	sound_active_ashstorm.output_atoms = impacted_mobs
	sound_weak_ashstorm.output_atoms = impacted_mobs

	sound_weak_ashstorm.start()

/datum/weather/ash_storm/start()
	. = ..()
	sound_weak_ashstorm.stop()

	sound_active_ashstorm.start()

/datum/weather/ash_storm/wind_down()
	. = ..()
	sound_active_ashstorm.stop()

	sound_weak_ashstorm.start()

/datum/weather/ash_storm/end()
	. = ..()
	sound_weak_ashstorm.stop()

/datum/weather/ash_storm/proc/is_storm_immune(atom/L)
	while (L && !isturf(L))
		if(iscarbon(L))// if we're a non immune mob inside an immune mob we have to reconsider if that mob is immune to protect ourselves
			var/mob/living/carbon/the_mob = L
			if(the_mob.status_flags & INCORPOREAL)
				return TRUE
		L = L.loc //Check parent items immunities (recurses up to the turf)
	return FALSE //RIP you

/datum/weather/ash_storm/weather_act(mob/living/L)
	if(L.stat == DEAD)
		return
	if(is_storm_immune(L))
		return
	L.adjust_fire_loss(6)


//Emberfalls are the result of an ash storm passing by close to the playable area of lavaland. They have a 10% chance to trigger in place of an ash storm.
/datum/weather/ash_storm/emberfall
	name = "emberfall"
	desc = "一场过境的灰烬风暴用无害的余烬覆盖了该区域."

	telegraph_message = span_danger("风中传来一声诡异的呻吟. 燃烧的灰烬遮蔽了地平线.")

	weather_message = span_notice("温和的余烬如怪异的雪花般飘落在你周围. 风暴似乎已经绕过了你...")
	weather_overlay = "light_ash"

	end_message = span_notice("灰烬飘落减缓,停止. 你脚下的玄武岩上又多了一层坚硬的煤烟.")
	end_sound = null

	aesthetic = TRUE

	probability = 60
