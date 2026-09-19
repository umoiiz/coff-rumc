/datum/weather/snow_storm
	name = "snow storm"
	desc = "猛烈的暴风雪在这颗冰冻星球的地表肆虐,将任何不幸处于其路径上的区域掩埋."
	probability = 90

	telegraph_message = span_warning("飘散的雪粒开始为周围区域蒙上一层薄尘..")
	telegraph_duration = 300
	telegraph_overlay = "light_snow"

	weather_message = span_warning("<i>狂风骤起,密集的雪花开始从天而降!</i>")
	weather_overlay = "snow_storm"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = span_danger("降雪开始减缓.")

	area_type = /area
	protect_indoors = TRUE
	target_trait = ZTRAIT_SNOWSTORM
	aesthetic = TRUE

	barometer_predictable = TRUE
