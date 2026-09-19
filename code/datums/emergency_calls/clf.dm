//Colonial Liberation Front
/datum/emergency_call/clf
	name = "CLF Cell"
	base_probability = 20
	alignement_factor = 1
	///number of available special weapon dudes
	var/max_specialists = 1


/datum/emergency_call/clf/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你在一个[pick(50;" poor", 15;" well-off", 35;"n average")]家庭中[pick("on the TGMC prison station","in the LV-624 jungle","on a desert planet","on an icy colony")]长大.</B>")
	to_chat(H, "<B>你加入了CLF,因为[pick(20;"you harbor a strong hatred for the oppressive TerraGov",5;"you are good at killing, and in times like these this is the place to be", 10;"your militia was absorbed into the CLF")],你被TGMC视为恐怖分子.</B>")
	to_chat(H, "<B>突袭TGMC,并尽可能多地搞破坏.确保任何幸存者在你的监护下逃脱.</b>")


/datum/emergency_call/clf/create_member(datum/mind/M)
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
		var/datum/job/J = SSjob.GetJobType(/datum/job/clf/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, span_notice("你是当地抵抗组织殖民解放阵线的领袖."))
		return
	if(medics < max_medics)
		var/datum/job/J = SSjob.GetJobType(/datum/job/clf/medic)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, span_notice("你是当地抵抗组织殖民解放阵线的医疗兵."))
		medics++
		return
	if(max_specialists > 0)
		var/datum/job/J = SSjob.GetJobType(/datum/job/clf/specialist)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, span_notice("你是当地抵抗组织殖民解放阵线的专家.使用你的特殊武器带领你的队伍走向胜利!"))
		max_specialists --
		return

	var/datum/job/J = SSjob.GetJobType(/datum/job/clf/standard)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, span_notice("你是当地抵抗组织殖民解放阵线的一员."))
