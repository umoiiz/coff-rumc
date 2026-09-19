/datum/emergency_call/freelancers
	name = "Freelancer Mercenary Group"
	base_probability = 26
	alignement_factor = -1
	///Number of current Grenadiers in this squad.
	var/grenadiers
	///Max amount of Grenadiers allowed in this squad.
	var/max_grenadiers = 2


/datum/emergency_call/freelancers/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是[pick(25;"a space station", 25;"Earth", 50;"one of the many colonized planets")]殖民地中一个[pick(75;"distant", 25;"close")]家庭的一员.</b>")
	to_chat(H, "<B>然而,由于你殖民地中的[pick("a famine", "a poverty", "a disease outbreak", "a small-scale disaster", "an uprising", "a mutiny", "the unbearable conditions", "the bad state", "the harsh opinion")],你抛弃了她.然后你被[pick("your cousin, who is a freelancer", "some freelancers", "a group of freelancers", "a squad of ex-military freelancers", "your long-lived companion, who is a freelancer")]雇佣,成为一个自由雇佣兵团体的一员.</b>")
	to_chat(H, "")
	to_chat(H, "<B>今天,一艘TGMC舰船,[SSmapping.configs[SHIP_MAP].map_name],在[SSmapping.configs[GROUND_MAP].map_name]的轨道上发出了求救信号.你希望你能活着回来拿到你的报酬!</b>")
	to_chat(H, "<B>确保他们不被摧毁.只要你活着就收取报酬.</b>")


/datum/emergency_call/freelancers/create_member(datum/mind/M)
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
		var/datum/job/J = SSjob.GetJobType(/datum/job/freelancer/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是被指派带领这支队伍响应附近发出的TGMC求救信号的自由雇佣兵.让你的队伍保持完整,以确保他们赚到报酬!</notice></p>")
		return

	if(medics < max_medics)
		var/datum/job/J = SSjob.GetJobType(/datum/job/freelancer/medic)
		H.apply_assigned_role_to_spawn(J)
		medics++
		to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是被指派到这支队伍响应附近发出的TGMC求救信号的自由雇佣兵医疗兵.不要让你的队友在战斗中倒下!</notice></p>")
		return

	if(grenadiers < max_grenadiers)
		var/datum/job/J = SSjob.GetJobType(/datum/job/freelancer/veteran)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, span_notice("你是当地抵抗组织殖民地解放阵线的一名掷弹兵."))
		grenadiers++
		return

	var/datum/job/J = SSjob.GetJobType(/datum/job/freelancer/standard)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是一名自由佣兵,被指派到这个小组,以响应附近发送的TGMC求救信号. 不要让你和你的队伍放松警惕!</notice></p>")
