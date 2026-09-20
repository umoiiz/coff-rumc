/obj/item/tool/analyzer
	desc = "一个手持式环境扫描仪,可报告当前气体水平."
	name = "分析仪"
	icon = 'icons/obj/device.dmi'
	icon_state = "atmos"
	worn_icon_state = "analyzer"
	w_class = WEIGHT_CLASS_SMALL
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	throwforce = 5
	throw_speed = 4
	throw_range = 20


/obj/item/tool/analyzer/attack_self(mob/user as mob)
	..()
	var/turf/T = get_turf(user)
	if(!T)
		return

	playsound(src, 'sound/effects/pop.ogg', 100)
	var/area/user_area = T.loc
	var/datum/weather/ongoing_weather = null

	if(!user_area.outside)
		to_chat(user, span_warning("[src]的气压计功能在室内无法工作!"))
		return

	for(var/V in SSweather.processing)
		var/datum/weather/W = V
		if(W.barometer_predictable && (T.z in W.impacted_z_levels) && W.area_type == user_area.type && !(W.stage == END_STAGE))
			ongoing_weather = W
			break

	if(ongoing_weather)
		if((ongoing_weather.stage == MAIN_STAGE) || (ongoing_weather.stage == WIND_DOWN_STAGE))
			to_chat(user, span_warning("[src]的气压计功能在风暴[ongoing_weather.stage == MAIN_STAGE ? "already here!" : "winding down."]时无法追踪任何东西"))
			return

		to_chat(user, span_notice("下一场[ongoing_weather]将在[(ongoing_weather.next_hit_time - world.time)/10]秒后袭来."))
		if(ongoing_weather.aesthetic)
			to_chat(user, span_warning("[src]的气压计功能显示下一场风暴将轻轻掠过."))
	else
		var/next_hit = SSweather.next_hit_by_zlevel["[T.z]"]
		var/fixed = next_hit ? timeleft(next_hit) : -1
		if(fixed < 0)
			to_chat(user, span_warning("[src]的气压计功能无法追踪任何天气模式."))
		else
			to_chat(user, span_warning("[src]的气压计功能显示一场风暴将在大约[fixed/10]秒后登陆\]."))
