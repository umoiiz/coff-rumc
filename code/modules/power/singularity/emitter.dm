#define EMITTER_DAMAGE_POWER_TRANSFER 450 //used to transfer power to containment field generators

/obj/machinery/power/emitter
	name = "Emitter"
	desc = "这是一台重型工业激光器."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "emitter"
	anchored = FALSE
	density = TRUE
	req_access = list(ACCESS_MARINE_ENGINEERING)
	var/id = null
	use_power = 0	//uses powernet power, not APC power
