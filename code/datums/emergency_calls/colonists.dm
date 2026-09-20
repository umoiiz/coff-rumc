//Colonist ERT with only basic items for events.
/datum/emergency_call/colonist
	name = "Colonists"


/datum/emergency_call/colonist/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你只是一个普通的殖民者,希望能成为别的什么.</b>")
	to_chat(H, "<B>遵循工作人员或你的领袖在角色内分配的所有指示.</b>")


/datum/emergency_call/colonist/create_member(datum/mind/M)
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

	var/datum/job/J = SSjob.GetJobType(/datum/job/colonist)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a colonist. You... wait for further orders!")]</p>")
