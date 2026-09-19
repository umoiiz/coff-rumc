/datum/emergency_call/xenomorphs_corrupted
	name = "Xenomorphs (Corrupted Hive)"
	base_probability = 0
	auto_shuttle_launch = TRUE
	spawn_type = null


/datum/emergency_call/xenomorphs_corrupted/print_backstory(mob/living/carbon/xenomorph/X)
	to_chat(X, "<B>我们是来自高个子宿主创造的人工腐化巢穴的异形.</b>")
	to_chat(X, "<B>我们被困在这艘穿梭机上多年, 直到有人联系了我们并远程接管了我们穿梭机的控制权.</b>")
	to_chat(X, "<B>据我们所知, 似乎有人发射了这艘穿梭机以帮助我们有麻烦的人类同胞.</b>") // Human friendly ERT
	to_chat(X, "<B>扩张我们的巢穴并摧毁我们可能遇到的任何其他巢穴.为了腐化的巢穴!</b>")


/datum/emergency_call/xenomorphs_corrupted/spawn_items()
	var/turf/drop_spawn = get_spawn_point(TRUE)
	if(istype(drop_spawn))
		new /obj/alien/weeds/node(drop_spawn) //Drop some weeds for xeno plasma regen.


/datum/emergency_call/xenomorphs_corrupted/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return

	var/mob/original = M.current
	var/turf/spawn_loc = .

	if(!leader)
		. = new /mob/living/carbon/xenomorph/ravager/Corrupted(spawn_loc, TRUE) //TRUE for the can_spawn_in_centcom, so they don't get sent to a different hive.
		leader = .
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	if(prob(35))
		. = new /mob/living/carbon/xenomorph/drone/Corrupted(spawn_loc, TRUE)
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	if(prob(35))
		. = new /mob/living/carbon/xenomorph/spitter/Corrupted(spawn_loc, TRUE)
		M.transfer_to(., TRUE)
		print_backstory(.)
		return

	. = new /mob/living/carbon/xenomorph/hunter/Corrupted(spawn_loc, TRUE)
	M.transfer_to(., TRUE)
	print_backstory(.)

	if(original)
		qdel(original)
