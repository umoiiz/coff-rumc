/obj/item/taperecorder
	desc = "一种可以录制长达一小时对话并回放的设备.回放时会自动翻译内容."
	name = "通用录音机"
	icon = 'icons/obj/device.dmi'
	icon_state = "taperecorderidle"
	worn_icon_state = "analyzer"
	w_class = WEIGHT_CLASS_SMALL

	var/recording = 0
	var/playing = 0
	var/timerecorded = 0
	var/playsleepseconds = 0
	var/list/storedinfo = list()
	var/list/timestamp = list()
	var/canprint = 1
	atom_flags = CONDUCT
	throwforce = 2
	throw_speed = 4
	throw_range = 20

/obj/item/taperecorder/Initialize(mapload)
	. = ..()
	become_hearing_sensitive()

/obj/item/taperecorder/Hear(message, atom/movable/speaker, message_langs, raw_message, radio_freq, spans, message_mode)
	. = ..()

	if(recording)
		timestamp += timerecorded
		storedinfo += "\[[time2text(timerecorded * 10, "mm:ss")]\] [speaker.name]: \"[message]\""

/obj/item/taperecorder/verb/record()
	set name = "Start Recording"
	set category = "IC.Tape Recorder"

	if(usr.stat)
		return
	icon_state = "taperecorderrecording"
	if(timerecorded < 3600 && playing == 0)
		to_chat(usr, span_notice("录音已开始."))
		recording = 1
		timestamp+= timerecorded
		storedinfo += "\[[time2text(timerecorded*10,"mm:ss")]\] Recording started."
		for(timerecorded, timerecorded<3600)
			if(recording == 0)
				break
			timerecorded++
			sleep(1 SECONDS)
		recording = 0
		icon_state = "taperecorderidle"
		return
	else
		to_chat(usr, span_notice("[src]的内存已满,或者它正在回放其内存."))


/obj/item/taperecorder/verb/stop()
	set name = "Stop"
	set category = "IC.Tape Recorder"

	if(usr.stat)
		return
	if(recording == 1)
		recording = 0
		timestamp+= timerecorded
		storedinfo += "\[[time2text(timerecorded*10,"mm:ss")]\] Recording stopped."
		to_chat(usr, span_notice("录音已停止."))
		icon_state = "taperecorderidle"
		return
	else if(playing == 1)
		playing = 0
		var/turf/T = get_turf(src)
		T.visible_message("<font color=Maroon><B>[src]</B>: 回放已停止.</font>")
		icon_state = "taperecorderidle"
		return


/obj/item/taperecorder/verb/clear_memory()
	set name = "Clear Memory"
	set category = "IC.Tape Recorder"

	if(usr.stat)
		return
	if(recording == 1 || playing == 1)
		to_chat(usr, span_notice("回放或录音时无法清除内存!"))
		return
	else
		if(storedinfo)	storedinfo.Cut()
		if(timestamp)	timestamp.Cut()
		timerecorded = 0
		to_chat(usr, span_notice("内存已清除."))
		return


/obj/item/taperecorder/verb/playback_memory()
	set name = "Playback Memory"
	set category = "IC.Tape Recorder"

	if(usr.stat)
		return
	if(recording == 1)
		to_chat(usr, span_notice("录音时无法回放!"))
		return
	if(playing == 1)
		to_chat(usr, span_notice("你已经在回放了!"))
		return
	playing = 1
	icon_state = "taperecorderplaying"
	to_chat(usr, span_notice("回放已开始."))
	for(var/i=1,timerecorded<3600,sleep(10 * (playsleepseconds) ))
		if(playing == 0)
			break
		if(length(storedinfo) < i)
			break
		var/turf/T = get_turf(src)
		T.visible_message("<font color=Maroon><B>[src]</B>: [storedinfo[i]]</font>")
		if(length(storedinfo) < i+1)
			playsleepseconds = 1
			sleep(1 SECONDS)
			T = get_turf(src)
			T.visible_message("<font color=Maroon><B>[src]</B>: 录音结束.</font>")
		else
			playsleepseconds = timestamp[i+1] - timestamp[i]
		if(playsleepseconds > 14)
			sleep(1 SECONDS)
			T = get_turf(src)
			T.visible_message("<font color=Maroon><B>[src]</B>: 跳过[playsleepseconds]秒静音</font>")
			playsleepseconds = 1
		i++
	icon_state = "taperecorderidle"
	playing = 0


/obj/item/taperecorder/verb/print_transcript()
	set name = "Print Transcript"
	set category = "IC.Tape Recorder"

	if(usr.stat)
		return
	if(!canprint)
		to_chat(usr, span_notice("录音机无法那么快地打印!"))
		return
	if(recording == 1 || playing == 1)
		to_chat(usr, span_notice("回放或录音时无法打印转录文本!"))
		return
	to_chat(usr, span_notice("转录文本已打印."))
	var/obj/item/paper/P = new /obj/item/paper(get_turf(src))
	var/t1 = "<B>Transcript:</B><BR><BR>"
	for(var/i=1,length(storedinfo) >= i,i++)
		t1 += "[storedinfo[i]]<BR>"
	P.info = t1
	P.name = "Transcript"
	canprint = 0
	sleep(30 SECONDS)
	canprint = 1


/obj/item/taperecorder/attack_self(mob/user)
	if(recording == 0 && playing == 0)
		if(usr.stat)
			return
		icon_state = "taperecorderrecording"
		if(timerecorded < 3600 && playing == 0)
			to_chat(usr, span_notice("录音已开始."))
			recording = 1
			timestamp+= timerecorded
			storedinfo += "\[[time2text(timerecorded*10,"mm:ss")]\] Recording started."
			for(timerecorded, timerecorded<3600)
				if(recording == 0)
					break
				timerecorded++
				sleep(1 SECONDS)
			recording = 0
			icon_state = "taperecorderidle"
			return
		else
			to_chat(usr, span_warning("[src]的内存已满,或者它正在回放其内存."))
	else
		if(usr.stat)
			to_chat(usr, "当你失去行动能力时不行.")
			return
		if(recording == 1)
			recording = 0
			timestamp+= timerecorded
			storedinfo += "\[[time2text(timerecorded*10,"mm:ss")]\] Recording stopped."
			to_chat(usr, span_notice("录音已停止."))
			icon_state = "taperecorderidle"
			return
		else if(playing == 1)
			playing = 0
			audible_message("<font color=Maroon><B>[src]</B>: 回放已停止.</font>")
			icon_state = "taperecorderidle"
			return
		else
			to_chat(usr, span_warning("停止什么?"))
			return
