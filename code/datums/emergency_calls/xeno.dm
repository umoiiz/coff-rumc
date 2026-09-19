/datum/emergency_call/xenomorphs
	name = "Xenomorphs"
	base_probability = 11
	auto_shuttle_launch = TRUE
	spawn_type = null
	alignement_factor = 4


/datum/emergency_call/xenomorphs/print_backstory(mob/living/carbon/xenomorph/X)
	to_chat(X, "<B>我们是来自遥远巢穴的异形.</b>")
	to_chat(X, "<B>我们在太空中巡航了多年, 直到一位新领袖联系了我们并接管了我们穿梭机的控制权.</b>") // It may be a shrike or a queen.
	to_chat(X, "<B>帮助我们的领袖接管这个区域. 为了新巢穴!</b>")


/datum/emergency_call/xenomorphs/spawn_items()
	var/turf/drop_spawn = get_spawn_point(TRUE)
	if(istype(drop_spawn))
		new /obj/alien/weeds/node(drop_spawn) //Drop some weeds for xeno plasma regen.

/datum/emergency_call/xenomorphs/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return

	var/mob/original = M.current
	var/turf/spawn_loc = .

	if(!leader)
		. = new /mob/living/carbon/xenomorph/ravager(spawn_loc)
		leader = .
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	if(prob(35))
		. = new /mob/living/carbon/xenomorph/drone(spawn_loc)
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	if(prob(35))
		. = new /mob/living/carbon/xenomorph/spitter(spawn_loc)
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	. = new /mob/living/carbon/xenomorph/hunter(spawn_loc)
	M.transfer_to(., TRUE)
	print_backstory(.)

	if(original)
		qdel(original)
