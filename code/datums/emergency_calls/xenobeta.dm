/datum/emergency_call/xenomorphs_beta
	name = "Xenomorphs (Beta Hive)"
	base_probability = 0
	auto_shuttle_launch = TRUE
	spawn_type = null


/datum/emergency_call/xenomorphs_beta/print_backstory(mob/living/carbon/xenomorph/X)
	to_chat(X, "<B>我们是来自贝塔巢穴的异形.</b>")
	to_chat(X, "<B>我们在太空中游荡了多年,直到一位新女王联系上我们并接管了我们穿梭机的控制权.</b>") // Admin-only ERT, so queens only.
	to_chat(X, "<B>扩张我们的巢穴,摧毁任何胆敢对抗我们势力的人,尤其是其他巢穴. 为了贝塔巢穴!</b>")


/datum/emergency_call/xenomorphs_beta/spawn_items()
	var/turf/drop_spawn = get_spawn_point(TRUE)
	if(istype(drop_spawn))
		new /obj/alien/weeds/node(drop_spawn) //Drop some weeds for xeno plasma regen.


/datum/emergency_call/xenomorphs_beta/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return

	var/mob/original = M.current
	var/turf/spawn_loc = .

	if(!leader)
		. = new /mob/living/carbon/xenomorph/ravager/Beta(spawn_loc, TRUE) //TRUE for the can_spawn_in_centcom, so they don't get sent to a different hive.
		leader = .
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	if(prob(35))
		. = new /mob/living/carbon/xenomorph/drone/Beta(spawn_loc, TRUE)
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	if(prob(35))
		. = new /mob/living/carbon/xenomorph/spitter/Beta(spawn_loc, TRUE)
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	. = new /mob/living/carbon/xenomorph/hunter/Beta(spawn_loc, TRUE)
	M.transfer_to(., TRUE)
	print_backstory(.)

	if(original)
		qdel(original)
