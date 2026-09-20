/mob/dead/verb/join_as_hellhound()
	set category = "Ghost"
	set name = "Join as Hellhound"
	set desc = "Select an alive and available Hellhound. THIS COMES WITH STRICT RULES. READ THEM OR GET BANNED."

	var/mob/dead/current_mob = src
	if(!current_mob.stat || !current_mob.mind)
		return

	if(SSticker.current_state < GAME_STATE_PLAYING || !SSticker.mode)
		to_chat(src, span_warning("游戏尚未开始!"))
		return

	var/list/hellhound_mob_list = list() // the list we'll be choosing from
	for(var/mob/living/carbon/xenomorph/hellhound/Hellhound as anything in GLOB.hellhound_list)
		if(Hellhound.client)
			continue
		hellhound_mob_list[Hellhound.name] = Hellhound

	var/choice = tgui_input_list(usr, "选择一只地狱犬:", "作为地狱犬加入", hellhound_mob_list)
	if(!choice)
		return

	var/mob/living/carbon/xenomorph/hellhound/Hellhound = hellhound_mob_list[choice]
	if(!Hellhound || !(Hellhound in GLOB.hellhound_list))
		return

	if(QDELETED(Hellhound) || Hellhound.client)
		to_chat(src, span_warning("出了点问题."))
		return

	if(Hellhound.stat == DEAD)
		to_chat(src, span_warning("那只地狱犬已经死亡."))
		return

	current_mob.mind.transfer_to(Hellhound, TRUE)
	Hellhound.generate_name()

/mob/dead/verb/join_as_yautja()
	set category = "Ghost"
	set name = "Join the Hunt"
	set desc = "If you are whitelisted, and it is the right type of round, join in."

	if(!client)
		return

	if(SSticker.current_state < GAME_STATE_PLAYING || !SSticker.mode)
		to_chat(src, span_warning("游戏尚未开始!"))
		return

	if(SSticker.mode.check_predator_late_join(src))
		SSticker.mode.join_predator(src)
