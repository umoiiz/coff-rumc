/mob/living/carbon/human/proc/mark_panel()
	if(stat || (lying_angle && !resting && !has_status_effect(STATUS_EFFECT_SLEEPING)) || (has_status_effect(STATUS_EFFECT_PARALYZED) || has_status_effect(STATUS_EFFECT_UNCONSCIOUS)))
		to_chat(src, span_danger("你现在无法这么做."))
		return

	var/mob/living/carbon/human/T = src
	if(!isyautja(T))
		return

	var/list/options = list()
	var/list/optionsp = list(
		"Mark as Prey",
		"Un-Mark as Prey",
		"Mark as Thralled",
		"Un-Mark as Thralled",
		"Mark as Honored",
		"Un-Mark as Honored",
		"Mark as Dishonorable",
		"Un-Mark as Dishonorable",
		"Mark as Gear Carrier",
		"Un-Mark as Gear Carrier"
	)

	options += optionsp

	var/input = tgui_input_list(usr, "选择要施加的标记", "标记面板", options)

	if(!input)
		return
	else if(input)

		switch(input)
			if("Mark as Prey")
				T.mark_for_hunt()
			if("Un-Mark as Prey")
				T.remove_from_hunt()
			if("Mark as Honored")
				T.mark_honored()
			if("Un-Mark as Honored")
				T.unmark_honored()
			if("Mark as Dishonorable")
				T.mark_dishonored()
			if("Un-Mark as Dishonorable")
				T.unmark_dishonored()
			if("Mark as Gear Carrier")
				T.mark_gear()
			if("Un-Mark as Gear Carrier")
				T.unmark_gear()
			if("Mark as Thralled")
				T.mark_thralled()
			if("Un-Mark as Thralled")
				T.unmark_thralled()

	return

// Mark for Hunt verbs
// Add prey for hunt
/mob/living/carbon/human/proc/mark_for_hunt()
	// Only one prey per pred
	if(hunter_data.prey)
		to_chat(src, span_danger("你已经在猎杀某个目标了."))
		return

	if(!isyautja(src))
		to_chat(src, span_warning("你是怎么获得这个指令的?"))
		return

	// List all possible preys
	// We only target living humans and xenos
	var/list/target_list = list()
	for(var/mob/living/prey in view(7, usr.client))
		if((ishumanbasic(prey) || isxeno(prey)) && prey.stat != DEAD && prey.client)
			target_list += prey

	var/mob/living/carbon/M = tgui_input_list(usr, "目标", "选择一个猎物.", target_list)
	if(!M)
		return
	if(M.hunter_data.hunter)
		to_chat(src, span_yautjabold("[M]正被[M.hunter_data.hunter.real_name]猎杀!"))
		return
	if(M.hunter_data.automatic_target && M.hunter_data.targeted != src)
		to_chat(src, span_yautjabold("[M]已被自动选为其他猎人的猎物!"))
		return
	hunter_data.prey = M
	M.hunter_data.hunter = src
	M.hunter_data.hunted = TRUE
	M.hud_set_hunter()

	// Notify the pred
	to_chat(src, span_yautjabold("你已选择[hunter_data.prey]作为你的下一个猎物."))

	// Notify other preds
	message_all_yautja("[real_name] has chosen [hunter_data.prey] ([max(hunter_data.prey.life_kills_total, hunter_data.prey.default_honor_value)] honor) as their next target at \the [get_area_name(hunter_data.prey)].")

	// log to server file
	log_game("[key_name(src)] has marked [key_name(hunter_data.prey)] for the Hunt in [get_area(hunter_data.prey)] ([x],[y],[z]).")

// Removing prey from hunt (i.e. it died, it bugged, it left the game, etc.)
/mob/living/carbon/human/proc/remove_from_hunt()
	if(!hunter_data.prey)
		to_chat(src, span_danger("你现在没有猎杀任何目标."))
		return

	if(!isyautja(src))
		to_chat(src, span_warning("你是怎么获得这个指令的?"))
		return

	if(alert(usr, "Are you sure you want to abandon this prey?", "Remove from Hunt:", "Yes", "No") != "Yes")
		return
	var/mob/living/carbon/prey = hunter_data.prey
	to_chat(src, span_yautjabold("你已将[prey]从你的猎杀名单中移除."))
	prey.hunter_data.hunter = null
	prey.hunter_data.hunted = FALSE
	log_game("[key_name(src)] has un-marked [key_name(hunter_data.prey)] for the Hunt")
	hunter_data.prey = null
	prey.hud_set_hunter()



/mob/living/carbon/human/proc/mark_honored()
	if(!isyautja(src))
		to_chat(src, span_warning("你是怎么获得这个指令的?"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in view(7, usr.client))
		if((ishumanbasic(target) || isxeno(target)) && target.stat != DEAD)
			target_list += target

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "选择一个目标.", target_list)
	if(!T)
		return
	if(T.hunter_data.honored)
		to_chat(src, span_yautjabold("[T]已经因'[T.hunter_data.honored_reason]'被[T.hunter_data.honored_set.real_name]授予荣誉!"))
		return

	var/reason = stripped_input(usr, "Enter the reason for marking your target as honored.", "Mark as Honored", "", 120)

	if(!reason)
		return

	log_game("[key_name(src)] has marked [key_name(T)] as Honored for '[reason]'.")
	message_all_yautja("[real_name] has marked [T] as Honored for '[reason]'.")

	T.hunter_data.honored_set = src
	hunter_data.honored_targets += T
	T.hunter_data.honored = TRUE
	T.hunter_data.honored_reason = "[reason]' by '[src.real_name]"
	T.hud_set_hunter()



/mob/living/carbon/human/proc/unmark_honored()
	if(!isyautja(src))
		to_chat(src, span_warning("你是怎么获得这个指令的?"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in view(7, usr.client))
		if((ishumanbasic(target) || isxeno(target)) && target.stat != DEAD)
			if(target.hunter_data.honored)
				target_list += target

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "选择一个目标.", target_list)
	if(!T)
		return
	if(!T.hunter_data.honored)
		to_chat(src, span_yautjabold("[T]未被标记为荣誉!"))
		return

	if(!T.hunter_data.honored_set || src == T.hunter_data.honored_set)

		log_game("[key_name(src)] has un-marked [key_name(T)] as honored!")
		message_all_yautja("[real_name] has un-marked [T] as honored!'.")

		T.hunter_data.honored_set = null
		hunter_data.honored_targets += T
		T.hunter_data.honored = FALSE
		T.hunter_data.honored_reason = null
		T.hud_set_hunter()
	else
		to_chat(src, span_yautjabold("你不能撤销活着的兄弟姐妹的行为!"))



/mob/living/carbon/human/proc/mark_dishonored()
	if(!isyautja(src))
		to_chat(src, span_warning("你是怎么获得这个指令的?"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in view(7, usr.client))
		if((ishumanbasic(target) || isxeno(target)) && target.stat != DEAD)
			target_list += target

	if(isyautja(src) && src.hunter_data.thrall)
		target_list += src.hunter_data.thrall

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "选择一个目标.", target_list)
	if(!T)
		return
	if(T.hunter_data.dishonored)
		to_chat(src, span_yautjabold("[T]已经因'[T.hunter_data.dishonored_reason]'被[T.hunter_data.dishonored_set.real_name]标记为耻辱!"))
		return

	var/reason = stripped_input(usr, "Enter the reason for marking your target as dishonorable.", "Mark as Dishonorable", "", 120)

	if(!reason)
		return

	log_game("[key_name(src)] has marked [key_name(T)] as Dishonorable for '[reason]'.")
	message_all_yautja("[real_name] has marked [T] as Dishonorable for '[reason]'.")

	T.hunter_data.dishonored_set = src
	hunter_data.dishonored_targets += T
	T.hunter_data.dishonored = TRUE
	T.hunter_data.dishonored_reason = "[reason]' by '[src.real_name]"
	T.hud_set_hunter()



/mob/living/carbon/human/proc/unmark_dishonored()
	if(!isyautja(src))
		to_chat(src, span_warning("你是怎么获得这个指令的?"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in view(7, usr.client))
		if((ishumanbasic(target) || isxeno(target)) && target.stat != DEAD)
			if(target.job != "Predalien" && target.job != "Predalien Larva")
				if(target.hunter_data.dishonored)
					target_list += target

	if(isyautja(src) && src.hunter_data.thrall)
		target_list += src.hunter_data.thrall

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "选择一个目标.", target_list)
	if(!T)
		return
	if(!T.hunter_data.dishonored)
		to_chat(src, span_yautjabold("[T]未被标记为耻辱!"))
		return

	if(!T.hunter_data.dishonored_set || src == T.hunter_data.dishonored_set)

		log_game("[key_name(src)] has un-marked [key_name(T)] as dishonorable!")
		message_all_yautja("[real_name] has un-marked [T] as dishonorable!'.")

		T.hunter_data.dishonored_set = null
		hunter_data.dishonored_targets -= T
		T.hunter_data.dishonored = FALSE
		T.hunter_data.dishonored_reason = null
		T.hud_set_hunter()
	else
		to_chat(src, span_yautjabold("你不能撤销活着的兄弟姐妹的行为!"))



/mob/living/carbon/human/proc/mark_gear()
	if(!isyautja(src))
		to_chat(src, span_warning("你是怎么获得这个指令的?"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in view(7, usr.client))
		if((ishumanbasic(target) && target.stat != DEAD))
			target_list += target

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "选择一个目标.", target_list)
	if(!T)
		return
	if(T.hunter_data.gear)
		to_chat(src, span_yautjabold("[T]已被[T.hunter_data.gear_set]标记为装备携带者!"))
		return

	log_game("[key_name(src)] has marked [key_name(T)] as a Gear Carrier!")
	message_all_yautja("[real_name] has marked [T] as a Gear Carrier!'.")

	T.hunter_data.gear_set = src
	hunter_data.gear_targets += T
	T.hunter_data.gear = TRUE
	T.hud_set_hunter()



/mob/living/carbon/human/proc/unmark_gear()
	if(!isyautja(src))
		to_chat(src, span_warning("你是怎么获得这个指令的?"))
		return

	var/list/target_list = list()
	for(var/mob/living/carbon/target in view(7, usr.client))
		if((ishumanbasic(target) && target.stat != DEAD))
			if(target.hunter_data.gear)
				target_list += target

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "选择一个目标.", target_list)
	if(!T)
		return
	if(!T.hunter_data.gear)
		to_chat(src, span_yautjabold("[T]未被标记为装备携带者!"))
		return

	if(!T.hunter_data.gear_set || src == T.hunter_data.gear_set)

		log_game("[key_name(src)] has un-marked [key_name(T)] as a Gear Carrier!")
		message_all_yautja("[real_name] has un-marked [T] as a Gear Carrier!'.")

		T.hunter_data.gear_set = null
		hunter_data.gear_targets -= T
		T.hunter_data.gear = FALSE
		T.hud_set_hunter()
	else
		to_chat(src, span_yautjabold("你不能撤销活着的兄弟姐妹的行为!"))


/mob/living/carbon/human/proc/mark_thralled()
	if(!isyautja(src))
		to_chat(src, span_warning("你是怎么获得这个指令的?"))
		return

	if(hunter_data.thrall)
		to_chat(src, span_warning("你已经有一个仆从."))
		return

	// List all possible targets
	// We only target living humans
	var/list/target_list = list()
	for(var/mob/living/carbon/target in view(7, usr.client))
		if(ishumanbasic(target) && target.stat != DEAD)
			target_list += target

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "选择一个目标.", target_list)
	if(!T)
		return
	if(T.hunter_data.thralled)
		to_chat(src, span_yautjabold("[T]已经因'[T.hunter_data.thralled_reason]'被[T.hunter_data.thralled_set.real_name]收为仆从!"))
		return

	var/reason = stripped_input(usr, "Enter the reason for marking your target as thralled.", "Mark as Thralled", "", 120)

	if(!reason)
		return

	log_game("[key_name(src)] has taken [key_name(T)] as their Thrall for '[reason]'.")
	message_all_yautja("[real_name] has taken [T] as their Thrall for '[reason]'.")

	T.hunter_data.thralled_set = src
	T.hunter_data.thralled = TRUE
	T.hunter_data.thralled_reason = reason
	hunter_data.thrall = T
	T.hud_set_hunter()



/mob/living/carbon/human/proc/unmark_thralled()
	if(!isyautja(src))
		to_chat(src, span_warning("你是怎么获得这个指令的?"))
		return

	// List all possible targets
	// We only target living humans
	var/list/target_list = list()
	for(var/mob/living/carbon/target in view(7, usr.client))
		if(ishumanbasic(target) && target.stat != DEAD)
			if(target.hunter_data.thralled)
				target_list += target

	if(isyautja(src) && src.hunter_data.thrall)
		target_list += src.hunter_data.thrall

	var/mob/living/carbon/T = tgui_input_list(usr, "目标", "选择一个目标.", target_list)
	if(!T)
		return
	if(!T.hunter_data.thralled)
		to_chat(src, span_yautjabold("[T]未被标记为仆从!"))
		return

	if(!T.hunter_data.thralled_set || src == T.hunter_data.thralled_set)

		log_game("[key_name(src)] has released [key_name(T)] from thralldom!")
		message_all_yautja("[real_name] has released [T] from thralldom!'.")

		T.hunter_data.thralled_set = null
		T.hunter_data.thralled = FALSE
		T.hunter_data.thralled_reason = null
		hunter_data.thrall = null
		T.hud_set_hunter()
	else
		to_chat(src, span_yautjabold("你不能撤销活着的兄弟姐妹的行为!"))
