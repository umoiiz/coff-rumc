/datum/emergency_call/pizza
	name = "Pizza Delivery"
	mob_max = 3
	base_probability = 0

/datum/emergency_call/pizza/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是一个受雇于Zippy Pizza Corporation的披萨配送员.</b>")
	to_chat(H, "<B>你的工作是配送你的披萨.你非常确定这是正确的地方...</b>")
	to_chat(H, "<B>确保你收下小费。</b>")

/datum/emergency_call/pizza/create_member(datum/mind/M)
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

	var/datum/job/J = SSjob.GetJobType(/datum/job/pizza)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a Zippy Pizza delivery person and are assigned by your employers to... deliver pizza on the ship via distress signal!")]</p>")
