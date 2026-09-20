/datum/emergency_call/upp_commando
	name = "USL Pirate Band Elites"
	base_probability = 0
	shuttle_id = SHUTTLE_DISTRESS_UPP
	spawn_type = /mob/living/carbon/human/species/moth


/datum/emergency_call/upp_commando/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你在[pick(50;"an asteriod", 25;"a famished colony", 25;"a classified station")]长大,拥有[pick(75;"few", 25;"some")]的财物或奢侈品。</B>")
	to_chat(H, "<B>与你一起长大的家庭是[pick(50;"getting by", 25;"impoverished", 25;"starving")],而你是[pick(10;"two", 20;"three", 30;"four", 20;"five", 20;"six")]个孩子之一。</B>")
	to_chat(H, "<B>你出身于世代相传的[pick(25;"professionals", 25;"renegades", 50;"rogue soldiers")],并很快加入了当地团伙以改善生活条件。</B>")
	to_chat(H, "")
	to_chat(H, "<B>今天,你和你的队友在长期静伏于当地小行星带后,被联合太空鳞翅目派往[SSmapping.configs[SHIP_MAP].map_name]。开始渗透任务!</b>")
	to_chat(H, "<B>必要时消灭TGMC部队. 除非平民先攻击你,否则不要伤害他们.</B>")
	to_chat(H, span_notice("你说的语言人类无法理解,只有你和其他海盗同伴能听懂.<br>在说动词中输入<b>\",0 <text>\"</b>以用银河通用语说话.<br>在说动词中输入<b>\";,0 <text>\"</b>以用银河通用语进行无线电通讯."))


/datum/emergency_call/upp_commando/create_member(datum/mind/M)
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
		var/datum/job/J = SSjob.GetJobType(/datum/job/upp/commando/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are the leader of the Elite USL pirate band.")]</p>")
		return

	if(medics < max_medics)
		var/datum/job/J = SSjob.GetJobType(/datum/job/upp/commando/medic)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are the medic of the Elite USL pirate band.")]</p>")
		medics++
		return

	var/datum/job/J = SSjob.GetJobType(/datum/job/upp/commando/leader)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a member of the Elite USL pirate band.")]</p>")
