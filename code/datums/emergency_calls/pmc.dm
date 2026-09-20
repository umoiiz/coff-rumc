/datum/emergency_call/pmc
	name = "NT Private Military Contractor Squad"
	base_probability = 11
	alignement_factor = -2
	shuttle_id = SHUTTLE_DISTRESS_PMC


/datum/emergency_call/pmc/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>在离开你的[pick(75;"distant", 20;"close", 5;"ever-lovingly close")][pick("family", "friends", "band of friends", "friend group", "relatives", "cousins")][pick("behind", "behind in safety", "behind secretly", "behind regrettably")]后,你决定加入一家为Nanotrasen效力的私人军事承包集团。</b>")
	to_chat(H, "<B>在那里工作被证明对你[pick(50;"very", 20;"somewhat", 5;"astoundingly")]有利可图。</b>")
	to_chat(H, "<B>虽然你是[pick("enlisted as", "officially", "part-time officially", "privately")][pick("an employee", "a security officer", "an officer")],但你的大部分工作都不在账面上。你是一名技艺娴熟的快速响应承包商。</b>")
	to_chat(H, "")
	to_chat(H, "<B>今天,一艘TGMC舰船[SSmapping.configs[SHIP_MAP].map_name]在[SSmapping.configs[GROUND_MAP].map_name]的轨道上发出了求救信号。你的时间不多了,让你的穿梭机起飞!</b>")
	to_chat(H, "<B>确保企业联络官安全。</b>")
	to_chat(H, "<B>如果没有联络官,就消灭威胁,并在返回基地前与舰长合作。</b>")


/datum/emergency_call/pmc/create_member(datum/mind/M)
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
		var/datum/job/J = SSjob.GetJobType(/datum/job/pmc/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are the leader of this private military contractor team in responding to the TGMC distress signal sent out nearby. Address the situation and get your team to safety!")]</p>")
		return

	if(prob(30))
		var/datum/job/J = SSjob.GetJobType(/datum/job/pmc/gunner)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a PMC heavy gunner assigned to this team to respond to the TGMC distress signal sent out nearby. Be the back guard of your squad!")]</p>")
		return

	if(prob(30))
		var/datum/job/J = SSjob.GetJobType(/datum/job/pmc/sniper)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a PMC heavy sniper assigned to this team to respond to the TGMC distress signal sent out nearby. Support your squad with long ranged firepower!")]</p>")
		return

	var/datum/job/J = SSjob.GetJobType(/datum/job/pmc/standard)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a private military contractor assigned to this team to respond to the TGMC distress signal sent out nearby. Assist your team and protect NT's interests whenever possible!")]</p>")
