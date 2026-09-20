/datum/emergency_call/gta/ballas
	name = "Ballas Street Gang"
	base_probability = 6
	alignement_factor = 1

/datum/emergency_call/gta/ballas/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你代表Ballas——紫色深深流淌在你的血管和你的头巾中.</B>")
	to_chat(H, "<B>街上的消息是[SSmapping.configs[SHIP_MAP].map_name]附近出事了.是时候现身,拿走属于你的东西,并提醒所有人谁掌管这些街区.</B>")
	to_chat(H, "<B>和你的帮派待在一起.别让Grove或公司挡你的路.</B>")

/datum/emergency_call/gta/ballas/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return
	var/mob/original = M.current
	var/mob/living/carbon/human/H = .
	M.transfer_to(H, TRUE)
	H.fully_replace_character_name(M.name, H.real_name)
	if(original)
		qdel(original)
	print_backstory(H)
	if(!leader)
		leader = H
		var/datum/job/J = SSjob.GetJobType(/datum/job/gta/ert/ballas/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_danger("You are the OG of this Ballas crew. Keep the homies in line.")]</p>")
		return
	if(medics < max_medics)
		var/datum/job/J = SSjob.GetJobType(/datum/job/gta/ert/ballas/medic)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_danger("You patch up the Ballas when the shooting starts.")]</p>")
		medics++
		return
	var/datum/job/J = SSjob.GetJobType(/datum/job/gta/ert/ballas/standard)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, span_danger("你是Ballas帮派成员,正在响应求救信号."))

/datum/emergency_call/gta/grove
	name = "Grove Street Families"
	base_probability = 6
	alignement_factor = 1

/datum/emergency_call/gta/grove/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是Grove Street——绿色头巾,忠诚的团队,以及与Ballas的长期恩怨.</B>")
	to_chat(H, "<B>[SSmapping.configs[SHIP_MAP].map_name]附近的混乱意味着机会.和你的兄弟们一起出动,把事情摆平.</B>")
	to_chat(H, "<B>Grove Street,家.至少在这一切之前是.</B>")

/datum/emergency_call/gta/grove/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return
	var/mob/original = M.current
	var/mob/living/carbon/human/H = .
	M.transfer_to(H, TRUE)
	H.fully_replace_character_name(M.name, H.real_name)
	if(original)
		qdel(original)
	print_backstory(H)
	if(!leader)
		leader = H
		var/datum/job/J = SSjob.GetJobType(/datum/job/gta/ert/grove/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_danger("You are the OG of this Grove Street crew. Hold the block down.")]</p>")
		return
	if(medics < max_medics)
		var/datum/job/J = SSjob.GetJobType(/datum/job/gta/ert/grove/medic)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_danger("You keep the Grove alive when bullets fly.")]</p>")
		medics++
		return
	var/datum/job/J = SSjob.GetJobType(/datum/job/gta/ert/grove/standard)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, span_danger("你是Grove Street帮派成员,正在响应求救信号."))
