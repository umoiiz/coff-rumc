//Darude sandstorm starts playing
/datum/weather/ash_storm/sand
	name = "severe sandstorm"
	telegraph_message = span_userdanger("你看到地平线上升起一片尘云. 这可不妙...")
	telegraph_duration = 300
	telegraph_overlay = "dust_med"
	telegraph_sound = 'sound/effects/siren.ogg'

	weather_message = span_userdanger("<i>炙热的沙子和狂风猛烈袭击你! 快进去!</i>")
	weather_duration_lower = 600
	weather_duration_upper = 1200
	weather_overlay = "dust_high"

	end_message = span_danger("呼啸的狂风卷走了最后一片沙尘,归于往常的低语. 现在应该可以安全外出了.")
	end_duration = 300
	end_overlay = "dust_med"

	target_trait = ZTRAIT_SANDSTORM

	probability = 40
	repeatable = FALSE

/datum/weather/ash_storm/sand/weather_act(mob/living/L)
	if(L.stat == DEAD)
		return
	if(is_storm_immune(L))
		return
	L.adjust_brute_loss(6)
	to_chat(L, span_danger("你被粗粝的沙子猛烈袭击!"))

/datum/weather/ash_storm/sand/harmless
	name = "Sandfall"
	desc = "一场过境的沙暴将这片区域覆盖在沙中."

	telegraph_message = span_danger("风开始增强,将沙子从地面吹起...")
	telegraph_overlay = "dust_low"
	telegraph_sound = null

	weather_message = span_notice("温和的沙尘如怪异的雪花般飘落在你周围. 风暴似乎已经绕过了你...")
	weather_overlay = "dust_med"

	end_message = span_notice("沙尘飘落减缓,停止. 你脚下的台地上又多了一层沙子.")
	end_overlay = "dust_low"

	aesthetic = TRUE

	probability = 60
	repeatable = TRUE
