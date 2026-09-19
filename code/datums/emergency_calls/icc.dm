// ICC
/datum/emergency_call/icc
	name = "Independent Colonial Confederation Squad"
	base_probability = 26
	alignement_factor = 1

/datum/emergency_call/icc/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是独立殖民地邦联武装部队(ICCAF)的一员,该部队由ICC组建,ICC是一群前世代飞船殖民地,它们联合起来组成经济和军事联盟,以对抗它们大得多的邻居TerraGov.</b>")
	to_chat(H, "<B>尽管ICC拥有独立于其成员的常备军,但大多数较大的成员仍保留自己的常备舰队和军队,拥有自己的装备和条令,而标准部队则以长期资金不足和人员不足而闻名.</b>")
	to_chat(H, "<B>因此,很大一部分舰船人员最终担任临时地面人员,不过真正的步兵,更常被称为\"卫军\",以高质量部队而闻名.</b>")
	to_chat(H, "")
	to_chat(H, "<B>今天,一艘TerraGov舰船,[SSmapping.configs[SHIP_MAP].map_name],在[SSmapping.configs[GROUND_MAP].map_name]的轨道上发出了求救信号. 这是我们不被拦截就发动攻击的机会!</b>")
	to_chat(H, "<B>消灭舰上的TerraGov人员,夺取这艘船. 如果有像SoM这样的ICC友军部队,则与他们合作达成此目标. 不留俘虏.</B>")

/datum/emergency_call/icc/create_member(datum/mind/M)
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
		var/datum/job/J = SSjob.GetJobType(/datum/job/icc/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是ICC小队队长,被指派带领这个小组响应附近发送的TGMC求救信号. 让你的队伍保持完整,接管这艘舰船并完成任务!</notice></p>")
		return

	if(medics < max_medics)
		var/datum/job/J = SSjob.GetJobType(/datum/job/icc/medic)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是ICCN医疗兵,被指派确保这群人在响应附近发送的TGMC求救信号时不会死掉. 让你的队伍保持完整,接管这艘舰船并完成任务!</notice></p>")
		medics++
		return

	if(prob(15))
		var/datum/job/J = SSjob.GetJobType(/datum/job/icc/guard)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a trained member of the ICCGF, unlike most you are a dedicated infantryman, better known as a 'Guardsman'. You have been attached to this ICCN group to investigate the TGMC distress signal sent nearby. Be the vanguard of your squad!")]</p>")
		return


	var/datum/job/J = SSjob.GetJobType(/datum/job/icc/standard)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是ICCN的训练有素的成员,被指派到这个小队,前往调查附近发送的TGMC求救信号. 不要让你和你的队伍放松警惕!</notice></p>")
