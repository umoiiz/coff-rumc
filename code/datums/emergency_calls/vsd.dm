// VSD
/datum/emergency_call/vsd
	name = "Vyacheslav Security Detail PMCs"
	base_probability = 26
	alignement_factor = 0

/datum/emergency_call/vsd/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是辛迪加私人枪手的一员. 维亚切斯拉夫安保队. 你来此以一切必要手段消灭这些企业渣滓. 杀掉挡路的一切.</b>")
	to_chat(H, "<B>你装备了防弹装甲以对抗部分地球政府的武器. 猎兵装甲有弱点, 瞄准头部以及胸甲正下方. 猎兵对5.56有弱点.</b>")
	to_chat(H, "<B>一艘地球政府飞船进入了辛迪加和I.C.C.领空. 你来此击落这艘船. 祝你好运.</b>")
	to_chat(H, "")

/datum/emergency_call/vsd/create_member(datum/mind/M)
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
		var/datum/job/J = SSjob.GetJobType(/datum/job/vsd/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是维亚切斯拉夫\"死亡小队\"的队长. 带领你的人员走向胜利, 不留痕迹. 呼啦!</notice></p>")
		return

	if(medics < max_medics)
		var/datum/job/J = SSjob.GetJobType(/datum/job/vsd/medic)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是小队的生命线. 你装备齐全可以治疗自己和他人, 请多加照顾你的战友. 呼啦!</notice></p>")
		medics++
		return

	if(prob(15))
		var/datum/job/J = SSjob.GetJobType(/datum/job/vsd/spec)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are trained specially in several different skills. You are the gunner, frontliner, EXPLOSION! of your group. Welcome Specialist, protect your group at all costs. Hoorah!")]</p>")
		return

	var/datum/job/J = SSjob.GetJobType(/datum/job/vsd/standard)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'><span class='notice'>你是一名训练有素的维亚切斯拉夫特工. 你不是消耗品. 你受过一切可能的训练以对抗TGMC的武器. 我们不接受任何伤亡. 祝你好运, 新兵, 呼啦!</notice></p>")
