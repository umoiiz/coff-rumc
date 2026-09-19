/datum/emergency_call/upp
	name = "USL Pirate Band"
	base_probability = 0
	shuttle_id = SHUTTLE_DISTRESS_UPP
	spawn_type = /mob/living/carbon/human/species/moth


/datum/emergency_call/upp/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你在[pick(50;"an asteriod", 25;"a famished colony", 25;"a classified station")]长大, 拥有[pick(75;"few", 25;"some")]的财产或奢侈品.</B>")
	to_chat(H, "<B>与你一起长大的家人是[pick(50;"getting by", 25;"impoverished", 25;"starving")], 你是[pick(10;"two", 20;"three", 30;"four", 20;"five", 20;"six")]个孩子之一.</B>")
	to_chat(H, "<B>你出身于[pick(50;"pirates", 25;"renegades", 25;"rogue soldiers")]的悠久血脉, 并很快加入了当地团伙以改善生活条件.</B>")
	to_chat(H, "")
	to_chat(H, "<B>今天, 一艘TGMC飞船, [SSmapping.configs[SHIP_MAP].map_name], 在[SSmapping.configs[GROUND_MAP].map_name]的轨道上发出了求救信号. 你的USL突击海盗团出发了, 你的掠夺开始了!</b>")
	to_chat(H, "<B>必要时消灭TGMC部队. 不要伤害平民, 除非他们先攻击你.</B>")
	to_chat(H, span_notice("你说一种人类无法理解的语言, 只有你和你的海盗同伴能懂.<br>在说话动词中输入<b>\",0 <text>\"</b>以用银河通用语说话.<br>在说话动词中输入<b>\";,0 <text>\"</b>以用银河通用语进行无线电通讯."))


/datum/emergency_call/upp/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return

	var/mob/original = M.current
	var/mob/living/carbon/human/H = .

	H.name = GLOB.namepool[/datum/namepool/moth].random_name(H)
	H.real_name = H.name

	M.transfer_to(H, TRUE)
	H.fully_replace_character_name(M.name, H.real_name)

	if(original)
		qdel(original)

	print_backstory(H)

	if(!leader)
		leader = H
		var/datum/job/J = SSjob.GetJobType(/datum/job/upp/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are the leader of the USL pirate band in responding to the TGMC distress signal sent nearby. Let your squadmates march to battle, for the USL!")]</p>")
		return

	if(medics < max_medics)
		var/datum/job/J = SSjob.GetJobType(/datum/job/upp/medic)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a medic of the USL pirate band to respond to the TGMC distress signal sent nearby. Kit up and get ready to tend wounds!")]</p>")
		medics++
		return

	if(prob(20))
		var/datum/job/J = SSjob.GetJobType(/datum/job/upp/heavy)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a specialist of the USL pirate band to respond to the TGMC distress signal sent nearby. Crush the vermin!")]</p>")
		return

	var/datum/job/J = SSjob.GetJobType(/datum/job/upp/standard)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a member of the USL pirate band to respond to the TGMC distress signal sent nearby. Do not forget your training, stand tall with your other pirates!")]</p>")

/datum/emergency_call/upphvh
	name = "USL Pirate Band (Human vs. Human)"
	base_probability = 0
	shuttle_id = SHUTTLE_DISTRESS_UPP
	spawn_type = /mob/living/carbon/human/species/moth


/datum/emergency_call/upphvh/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你在[pick(50;"an asteriod", 25;"a famished colony", 25;"a classified station")]长大, 拥有[pick(75;"few", 25;"some")]的财产或奢侈品.</B>")
	to_chat(H, "<B>与你一起长大的家人是[pick(50;"getting by", 25;"impoverished", 25;"starving")], 你是[pick(10;"two", 20;"three", 30;"four", 20;"five", 20;"six")]个孩子之一.</B>")
	to_chat(H, "<B>你出身于[pick(50;"pirates", 25;"renegades", 25;"rogue soldiers")]的悠久血脉, 并很快加入了当地团伙以改善生活条件.</B>")
	to_chat(H, "")
	to_chat(H, "<B>今天, 一艘TGMC飞船, [SSmapping.configs[SHIP_MAP].map_name], 在[SSmapping.configs[GROUND_MAP].map_name]的轨道上发出了求救信号. 你的USL突击海盗团出发了, 你的掠夺开始了!</b>")
	to_chat(H, "<B>必要时消灭TGMC部队. 不要伤害平民, 除非他们先攻击你.</B>")
	to_chat(H, span_notice("你说一种人类无法理解的语言, 只有你和你的海盗同伴能懂.<br>在说话动词中输入<b>\",0 <text>\"</b>以用银河通用语说话.<br>在说话动词中输入<b>\";,0 <text>\"</b>以用银河通用语进行无线电通讯."))


/datum/emergency_call/upphvh/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return

	var/mob/original = M.current
	var/mob/living/carbon/human/H = .

	H.name = GLOB.namepool[/datum/namepool/moth].random_name(H)
	H.real_name = H.name

	M.transfer_to(H, TRUE)
	H.fully_replace_character_name(M.name, H.real_name)

	if(original)
		qdel(original)

	print_backstory(H)

	if(!leader)
		leader = H
		var/datum/job/J = SSjob.GetJobType(/datum/job/upp/leader/hvh)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are the leader of the USL pirate band in responding to the TGMC distress signal sent nearby. Let your squadmates march to battle, for the USL!")]</p>")
		return

	if(medics < max_medics)
		var/datum/job/J = SSjob.GetJobType(/datum/job/upp/medic/hvh)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a medic of the USL pirate band to respond to the TGMC distress signal sent nearby. Kit up and get ready to tend wounds!")]</p>")
		medics++
		return

	if(prob(20))
		var/datum/job/J = SSjob.GetJobType(/datum/job/upp/heavy/hvh)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a specialist of the USL pirate band to respond to the TGMC distress signal sent nearby. Crush the vermin!")]</p>")
		return

	var/datum/job/J = SSjob.GetJobType(/datum/job/upp/standard/hvh)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a member of the USL pirate band to respond to the TGMC distress signal sent nearby. Do not forget your training, stand tall with your other pirates!")]</p>")

/datum/emergency_call/upphvh/human
	name = "USL Human Pirate Band (Human vs. Human)"
	spawn_type = /mob/living/carbon/human
