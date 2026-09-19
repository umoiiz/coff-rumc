/obj/machinery/bot
	name = "generic utility robot"
	desc = "一个通用型实用机器人,如果你在游戏中看到这个请使用ahelp。"
	icon = 'icons/obj/aibots.dmi'
	density = FALSE
	anchored = FALSE
	///Keeps track of how many items or whatever have been cleaned
	var/counter = 0
	///So It doesnt infinitely look for an exit and crash the server
	var/stuck_counter = 0
	///strings used on doing an action like cleaning
	var/list/sentences = list()
	///strings used on activating the bot
	var/list/awakeningsentences = list()
	///strings used on shutting down the robot
	var/list/shutdownsentences = list()
	///is the robot active
	var/is_active = FALSE
	///can the robot be turned on or off
	var/alter_operating_mode = FALSE
	///animation to play when the robot is started by hand
	var/activation_animation = null
	///animation to play when the robot is started by hand
	var/deactivation_animation = null
	///icon to set while active
	var/active_icon_state = null

/obj/machinery/bot/Initialize(mapload)
	. = ..()
	if(SStts.tts_enabled)
		var/static/todays_voice
		if(!todays_voice)
			todays_voice = pick(SStts.available_speakers)
		voice = todays_voice
	RegisterSignal(src, COMSIG_AREA_EXITED, PROC_REF(turn_around))
	update_icon()
	if(is_active)
		start_processing()

///Turns the bot around when it leaves an area to make sure it doesnt wander off
/obj/machinery/bot/proc/turn_around(datum/target)
	SIGNAL_HANDLER
	visible_message(span_warning("\The [src]在被移出其指定区域时愤怒地发出哔哔声!"))
	step_to(src, get_step(src,REVERSE_DIR(dir)))

/obj/machinery/bot/process()
	var/list/dirs = CARDINAL_DIRS - REVERSE_DIR(dir)
	var/turf/selection
	var/newdir
	for(var/i=1 to length(dirs))
		newdir = pick_n_take(dirs)
		selection = get_step(src, newdir)
		if(!selection.density)
			break
		newdir = null
	if(!newdir)
		stop_processing()
		addtimer(CALLBACK(src, PROC_REF(reactivate)), 20 SECONDS)
		say("DOOR STUCK, DOOOOR STUCK, AAAAAAH!")
		return
	step_to(src, get_step(src,newdir))

/obj/machinery/bot/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += "A panel on the top says it has cleaned [counter] items!"
	. += "It is currently [is_active ? "on" : "off"]."

/obj/machinery/bot/proc/reactivate()
	stuck_counter = 0
	if(!is_active) //no reactivation if somebody shut us off
		return
	start_processing()

/obj/machinery/bot/Bump(atom/A)
	. = ..()
	if(++stuck_counter <= 3)
		step_to(src, get_step(src, turn(dir, pick(90, -90))))
		return
	visible_message(span_warning("\The [src]在卡住时愤怒地发出哔哔声!"))
	stop_processing()
	addtimer(CALLBACK(src, PROC_REF(reactivate)), 20 SECONDS)

/obj/machinery/bot/attack_hand(mob/living/user)
	. = ..()
	if(!ishuman(user))
		return
	if(!alter_operating_mode)
		to_chat(user, "这个机器人没有开关。")
		return
	if(user.a_intent != INTENT_HELP)
		return
	switch(tgui_alert(user, "你想要打开\the [src][is_active ? "off" : "on"]吗?" , "机器人激活", list("No", "Yes")))
		if("No")
			return
		if("Yes")
			if(is_active)
				bot_shutdown()
			else
				bot_startup()

/obj/machinery/bot/attack_ai(mob/user)
	if(!alter_operating_mode)
		to_chat(user, "这个机器人有防火墙,无法远程访问。")
		return
	switch(tgui_alert(user, "你想要打开\the [src][is_active ? "off" : "on"]吗?" , "机器人激活", list("No", "Yes")))
		if("No")
			return
		if("Yes")
			if(is_active)
				bot_shutdown()
			else
				bot_startup()

///handles bot deactivation process
/obj/machinery/bot/proc/bot_shutdown()
	balloon_alert_to_viewers("关闭电源")
	if(deactivation_animation)
		flick("[deactivation_animation]", src)
	if(length(shutdownsentences))
		say(pick(shutdownsentences))
	is_active = FALSE
	update_icon()
	stop_processing()

///handles bot activation process
/obj/machinery/bot/proc/bot_startup()
	balloon_alert_to_viewers("开启电源")
	if(activation_animation)
		flick("[activation_animation]", src)
	if(length(awakeningsentences))
		say(pick(awakeningsentences))
	is_active = TRUE
	update_icon()
	start_processing()

/obj/machinery/bot/update_icon_state()
	. = ..()
	if(is_active)
		icon_state = active_icon_state
	else
		icon_state = "[initial(icon_state)]"

//these bots are mostly for decoration, you can't turn them on and they have no behavior aside from randomly moving
/obj/machinery/bot/medbot
	name = "Medibot"
	desc = "一个小型医疗机器人。他看起来有些无精打采。"
	icon = 'icons/obj/aibots.dmi'
	icon_state = "medibot0"
	density = FALSE
	anchored = FALSE

/obj/machinery/bot/mulebot
	name = "Mulebot"
	desc = "一个多功能装载效应机器人。"
	icon_state = "mulebot0"
	density = TRUE
	anchored = TRUE
