/datum/emergency_call/skeleton
	name = "The Bone Zone"
	base_probability = 0
	spawn_type = /mob/living/carbon/human/species/skeleton


/datum/emergency_call/skeleton/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是一具骷髅,从坟墓之外苏醒.\n\
	你已长眠许久,因战斗或不幸遭遇而被抛入太空虚空,但现在你已苏醒.\n\
	求救呼叫将你从太空中的沉睡中唤醒.\n\
	消灭任何打扰你永恒安息的东西,好让你能再次入睡.</b>")

/datum/emergency_call/skeleton/create_member(datum/mind/M)
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
		var/datum/job/J = SSjob.GetJobType(/datum/job/skeleton/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are the skeleton-in-chief. Lead your long-dead comrades to un-undeath or glory.")]</p>")
		return

	var/datum/job/J = SSjob.GetJobType(/datum/job/skeleton/basic)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a skeleton, with cool bones and stuff.")]</p>")
