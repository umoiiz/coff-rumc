/mob/living/silicon/ai/compose_freq(atom/movable/speaker, radio_freq)
	var/job = speaker.GetJob()
	var/namepart = "[speaker.GetVoice()][speaker.get_alt_name()]"

	return radio_freq ? "\[[get_radio_name(radio_freq)][job ? " <a href='byond://?src=[REF(src)];track=[html_encode(namepart)]'>([job])</a>": ""]\] " : ""

/mob/living/silicon/ai/radio(message, message_mode, list/spans, language)
	if(incapacitated())
		return FALSE
	if(control_disabled)
		to_chat(src, span_danger("你的无线电发射器已离线!"))
		return FALSE
	return ..()


/// Handles relayed speech
/mob/living/silicon/ai/proc/holopad_talk(message, language)
	message = trim(message)
	if(!message)
		return

	var/obj/machinery/holopad/T = current
	if(!istype(T) || !T.masters[src])
		to_chat(src, span_warning("未连接全息投影仪."))
		return

	var/turf/padturf = get_turf(T)
	var/padloc
	if(padturf)
		padloc = AREACOORD(padturf)
	else
		padloc = "(UNKNOWN)"
	log_talk(message, LOG_SAY, tag = "HOLOPAD in [padloc]")
	send_speech(message, 7, T, "robot", message_language = language)
	to_chat(src, span_notice("全息投影仪传输: [real_name]: \"[message]\""))

/mob/living/silicon/ai/get_message_mode(message)
	var/static/regex/holopad_finder = regex(@"[:.#][hH]")
	if(holopad_finder.Find(message, 1, 1))
		return MODE_RELAYED
	return ..()
