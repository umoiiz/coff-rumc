/datum/emergency_call/xenomorphs_alpha
	name = "Xenomorphs (Alpha Hive)"
	base_probability = 0
	auto_shuttle_launch = TRUE
	spawn_type = null


/datum/emergency_call/xenomorphs_alpha/print_backstory(mob/living/carbon/xenomorph/X)
	to_chat(X, "<B>我们是来自阿尔法巢穴的异形.</b>")
	to_chat(X, "<B>我们在太空中巡航了多年, 直到一位新女王联系了我们并接管了我们穿梭机的控制权.</b>") // Admin-only ERT, so queens only.
	to_chat(X, "<B>扩张我们的巢穴并摧毁任何胆敢反对我们势力的人, 尤其是其他巢穴. 为了阿尔法巢穴!</b>")


/datum/emergency_call/xenomorphs_alpha/spawn_items()
	var/turf/drop_spawn = get_spawn_point(TRUE)
	if(istype(drop_spawn))
		new /obj/alien/weeds/node(drop_spawn) //Drop some weeds for xeno plasma regen.


/datum/emergency_call/xenomorphs_alpha/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return

	var/mob/original = M.current
	var/turf/spawn_loc = .

	if(!leader)
		. = new /mob/living/carbon/xenomorph/ravager/Alpha(spawn_loc, TRUE) //TRUE for the can_spawn_in_centcom, so they don't get sent to a different hive.
		leader = .
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	if(prob(35))
		. = new /mob/living/carbon/xenomorph/drone/Alpha(spawn_loc, TRUE)
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	if(prob(35))
		. = new /mob/living/carbon/xenomorph/spitter/Alpha(spawn_loc, TRUE)
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	. = new /mob/living/carbon/xenomorph/hunter/Alpha(spawn_loc, TRUE)
	M.transfer_to(., TRUE)
	print_backstory(.)

	if(original)
		qdel(original)
