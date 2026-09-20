//Darude sandstorm starts playing
/datum/weather/ash_storm/sand
	name = "severe sandstorm"
	telegraph_message = span_userdanger("你看到地平线上升起一片尘云. 这可不妙...")
	telegraph_duration = 300
	telegraph_overlay = "dust_med"
	telegraph_sound = 'sound/effects/siren.ogg'

	weather_message = span_userdanger("<i>滚烫的沙子和狂风拍打着你! 快进去!</i>")
	weather_duration_lower = 600
	weather_duration_upper = 1200
	weather_overlay = "dust_high"

	end_message = span_danger("呼啸的风吹走了最后一丝沙子, 归于往常的低语. 现在外面应该安全了.")
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
	to_chat(L, span_danger("你被粗沙拍打着!"))

/datum/weather/ash_storm/sand/harmless
	name = "Sandfall"
	desc = "一场过境的沙尘暴用沙子覆盖了该区域."

	telegraph_message = span_danger("风开始增强, 将沙子从地面吹起...")
	telegraph_overlay = "dust_low"
	telegraph_sound = null

	weather_message = span_notice("轻柔的沙尘如怪诞的雪花般在你周围飘落.风暴似乎已经绕过了你...")
	weather_overlay = "dust_med"

	end_message = span_notice("落沙减缓,停止.你脚下的台地上又积了一层沙.")
	end_overlay = "dust_low"

	aesthetic = TRUE

	probability = 60
	repeatable = TRUE
