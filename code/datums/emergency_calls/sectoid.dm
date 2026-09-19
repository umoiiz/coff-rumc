//Sectoids
/datum/emergency_call/sectoid
	name = "Sectoid Expedition"
	base_probability = 26
	spawn_type = /mob/living/carbon/human/species/sectoid
	shuttle_id = SHUTTLE_DISTRESS_UFO
	alignement_factor = 1
	///Max amount of psionics allowed in this squad.
	var/max_psionics = 2

/datum/emergency_call/sectoid/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是一个sectoid,一名大规模克隆的外星士兵和灵能专家.")
	to_chat(H, "<B>你被派来消灭当地人类,并侦察这个太空区域是否有丰富的资源. 我们的扫描仪捕捉到了一艘原始飞船发出的求救信号.</B>")
	to_chat(H, "<B>你的任务很简单: 消灭所有人类,以及任何其他构成威胁的种族.</b>")

/datum/emergency_call/sectoid/create_member(datum/mind/M)
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
	H.update_hair()

	if(!leader)
		leader = H
		var/datum/job/J = SSjob.GetJobType(/datum/job/sectoid/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are the leader of this scouting expedition. You are able to use your stronger psionic powers to protect yourself from harm.")]</p>")
		return

	if(max_psionics)
		var/datum/job/J = SSjob.GetJobType(/datum/job/sectoid/psionic)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a psionic warrior, with moderate psionic potential.")]</p>")
		max_psionics--
		return

	var/datum/job/J = SSjob.GetJobType(/datum/job/sectoid/grunt)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a grunt, with limited psionic potential.")]</p>")
