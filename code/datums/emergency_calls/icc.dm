// ICC
/datum/emergency_call/icc
	name = "Independent Colonial Confederation Squad"
	base_probability = 26
	alignement_factor = 1

/datum/emergency_call/icc/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是独立殖民邦联武装部队(ICCAF)的成员,由ICC组建,ICC是一群前世代飞船殖民地,他们联合起来组成经济和军事联盟,以对抗他们大得多的邻居TerraGov.</b>")
	to_chat(H, "<B>尽管ICC拥有独立于其成员的常备军,但大多数较大的成员保留自己的常备舰队和军队,拥有自己的装备和条令,标准部队以持续资金不足和人员不足而闻名.</b>")
	to_chat(H, "<B>因此,很大一部分舰船人员最终担任临时地面人员,然而真正的步兵,更广为人知的是'卫兵',以高质量部队而闻名.</b>")
	to_chat(H, "")
	to_chat(H, "<B>今天,一艘TerraGov舰船[SSmapping.configs[SHIP_MAP].map_name]在[SSmapping.configs[GROUND_MAP].map_name]的轨道上发出了求救信号.这是我们不被拦截就发动攻击的机会!</b>")
	to_chat(H, "<B>消灭船上的TerraGov人员,夺取舰船.如果有ICC的同伴部队,比如SoM,那么与他们合作实现这个目标.不留俘虏.</B>")

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
		to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是被指派领导这个团队响应附近发出的TGMC求救信号的ICC小队队长.保持你的团队完好无损,接管这艘舰船并完成任务!</notice></p>")
		return

	if(medics < max_medics)
		var/datum/job/J = SSjob.GetJobType(/datum/job/icc/medic)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是被指派确保这群人在响应附近发出的TGMC求救信号时不会死亡的ICCN医疗兵.保持你的团队完好无损,接管这艘舰船并完成任务!</notice></p>")
		medics++
		return

	if(prob(15))
		var/datum/job/J = SSjob.GetJobType(/datum/job/icc/guard)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a trained member of the ICCGF, unlike most you are a dedicated infantryman, better known as a 'Guardsman'. You have been attached to this ICCN group to investigate the TGMC distress signal sent nearby. Be the vanguard of your squad!")]</p>")
		return


	var/datum/job/J = SSjob.GetJobType(/datum/job/icc/standard)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是ICCN的训练有素的成员,你被指派到这个小队,被派去调查附近发出的TGMC求救信号.不要让你和你的团队放松警惕!</notice></p>")
