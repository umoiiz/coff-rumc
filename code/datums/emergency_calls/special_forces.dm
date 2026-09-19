/datum/emergency_call/special_forces
	name = "Local System Special Forces"
	base_probability = 15
	alignement_factor = -1
	///number of available special weapon dudes
	var/max_specialists = 1

/datum/emergency_call/special_forces/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是当地特别响应部队的一员,驻扎在这个与世隔绝的星系中,接受过良好的训练和装备.</b>")
	to_chat(H, "<B>通常,你大部分时间都在为这里为数不多的大人物提供安保,期间在你的基地休息放松,偶尔处理人质事件.</b>")
	to_chat(H, "")
	to_chat(H, "<B>然而,最近,当地的一个定居点最近陷入沉寂,广播出求救信号,与此同时一艘TGMC舰船,[SSmapping.configs[SHIP_MAP].map_name],出现在轨道上,这两者很可能有关联.</b>")
	to_chat(H, "<B>调查他们的存在,并尽你所能帮助下面的殖民地!</b>")

/datum/emergency_call/special_forces/create_member(datum/mind/M)
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
		var/datum/job/J = SSjob.GetJobType(/datum/job/special_forces/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是特种部队队长,被指派带领这个小组响应附近发送的TGMC求救信号. 让你的队伍保持完整并完成任务!</notice></p>")
		return
	if(max_specialists > 0)
		var/datum/job/J = SSjob.GetJobType(/datum/job/special_forces/drone_operator)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are the specially trained drone operator of this special force group directed to investigate the TGMC distress signal sent nearby. Don't let you and your team's guard down!")]</p>")
		max_specialists --
		return
	if(prob(30))
		var/datum/job/J = SSjob.GetJobType(/datum/job/special_forces/breacher)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a specially trained member of this special force group directed to investigate the TGMC distress signal sent nearby. Be the vanguard of your squad!")]</p>")
		return
	var/datum/job/J = SSjob.GetJobType(/datum/job/special_forces/standard)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是这支特种部队的训练有素的成员,被指派前往调查附近发送的TGMC求救信号. 不要让你和你的队伍放松警惕!</notice></p>")
