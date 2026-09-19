#define INCLUSIVE_MODE 1
#define EXCLUSIVE_MODE 2
#define RECOGNIZER_MODE 3
#define VOICE_SENSOR_MODE 4

/obj/item/assembly/voice
	name = "声音分析仪"
	desc = "一种小型电子设备, 能够记录声音样本, 并在该样本被重复时发送信号."
	icon_state = "voice"
	attachable = TRUE
	verb_say = "beeps"
	verb_ask = "beeps"
	verb_exclaim = "beeps"
	var/listening = FALSE
	var/recorded = "" //the activation message
	var/mode = INCLUSIVE_MODE
	var/static/list/modes = list("inclusive",
								"exclusive",
								"recognizer",
								"voice sensor")

/obj/item/assembly/voice/Initialize(mapload)
	. = ..()
	become_hearing_sensitive()

/obj/item/assembly/voice/examine(mob/user)
	. = ..()
	. += span_notice("使用多功能工具在\"包含\", \"排除\", \"识别\"和\"声音传感器\"模式之间切换.")

/obj/item/assembly/voice/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode)
	. = ..()
	if(speaker == src)
		return FALSE

	if(listening && !radio_freq)
		record_speech(speaker, raw_message, message_language)
	else
		if(check_activation(speaker, raw_message))
			addtimer(CALLBACK(src, PROC_REF(pulse), 0), 10)

/obj/item/assembly/voice/proc/record_speech(atom/movable/speaker, raw_message, datum/language/message_language)
	switch(mode)
		if(INCLUSIVE_MODE)
			recorded = raw_message
			listening = FALSE
			say("Activation message is '[recorded]'.", message_language)
		if(EXCLUSIVE_MODE)
			recorded = raw_message
			listening = FALSE
			say("Activation message is '[recorded]'.", message_language)
		if(RECOGNIZER_MODE)
			recorded = speaker.GetVoice()
			listening = FALSE
			say("Your voice pattern is saved.", message_language)
		if(VOICE_SENSOR_MODE)
			if(length(raw_message))
				addtimer(CALLBACK(src, PROC_REF(pulse), 0), 10)

/obj/item/assembly/voice/proc/check_activation(atom/movable/speaker, raw_message)
	. = FALSE
	switch(mode)
		if(INCLUSIVE_MODE)
			if(findtext(raw_message, recorded))
				. = TRUE
		if(EXCLUSIVE_MODE)
			if(raw_message == recorded)
				. = TRUE
		if(RECOGNIZER_MODE)
			if(speaker.GetVoice() == recorded)
				. = TRUE
		if(VOICE_SENSOR_MODE)
			if(length(raw_message))
				. = TRUE

/obj/item/assembly/voice/multitool_act(mob/living/user, obj/item/I)
	mode %= length(modes)
	mode++
	to_chat(user, span_notice("你将[src]设置为[modes[mode]]模式."))
	listening = FALSE
	recorded = ""
	return TRUE

/obj/item/assembly/voice/activate()
	if(!secured || holder)
		return FALSE
	listening = !listening
	say("[listening ? "Now" : "No longer"] recording input.")
	return TRUE

/obj/item/assembly/voice/attack_self(mob/user)
	if(!user)
		return FALSE
	activate()
	return TRUE

/obj/item/assembly/voice/toggle_secure()
	. = ..()
	listening = FALSE

#undef INCLUSIVE_MODE
#undef EXCLUSIVE_MODE
#undef RECOGNIZER_MODE
#undef VOICE_SENSOR_MODE
