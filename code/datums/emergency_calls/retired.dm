/datum/emergency_call/retired
	name = "Retired TGMC Veteran Squad"
	base_probability = 5
	alignement_factor = -1

/datum/emergency_call/retired/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是TerraGov陆战队的一名年迈退役成员。</b>")
	to_chat(H, "<B>尽管你可能已过巅峰,但最高指挥部认为你仍有足够能力被派往[SSmapping.configs[SHIP_MAP].map_name],该舰最近发出了求救信号。</b>")
	to_chat(H, "<B>调查求救信号为何发出,并向年轻一代展示该怎么做!</b>")

/datum/emergency_call/retired/create_member(datum/mind/mind_to_assign)
	. = ..()
	if(!.)
		return
	var/mob/original = mind_to_assign.current
	var/mob/living/carbon/human/H = .

	if(H.gender == MALE)
		H.h_style = pick("Bald", "Balding Hair", "Balding Fade", "Balding ponytail", "Balding medium")
	else
		H.h_style = pick("Overeye Very Short", "Updo", "Ponytail 1")

	H.r_hair = 235
	H.g_hair = 235
	H.b_hair = 235
	H.r_facial = 235
	H.g_facial = 235
	H.b_facial = 235
	H.update_hair()

	mind_to_assign.transfer_to(H, TRUE)
	H.fully_replace_character_name(mind_to_assign.name, H.real_name)

	if(original)
		qdel(original)

	print_backstory(H)

	if(!leader)
		leader = H
		var/datum/job/J = SSjob.GetJobType(/datum/job/retired/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是TGMC退役老兵远征队队长!带领你的老兵同袍进行最后一次狂欢!</notice></p>")
		return

	var/datum/job/J = SSjob.GetJobType(/datum/job/retired)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是一名经过强化的TGMC老兵,你可能有几个肢体被替换成了合成版本,但至少你还能走路!跟随远征队队长,重温你的荣耀岁月!</notice></p>")
