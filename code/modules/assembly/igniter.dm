/obj/item/assembly/igniter
	name = "点火器"
	desc = "一种能够点燃可燃物质的小型电子装置."
	icon_state = "igniter"
	var/datum/effect_system/spark_spread/sparks
	heat = 1000

/obj/item/assembly/igniter/Initialize(mapload)
	. = ..()
	sparks = new
	sparks.set_up(2, 0, src)
	sparks.attach(src)

/obj/item/assembly/igniter/Destroy()
	QDEL_NULL(sparks)
	return ..()

/obj/item/assembly/igniter/activate()
	. = ..()
	if(!.)
		return FALSE //Cooldown check
	sparks.start()
	return TRUE

/obj/item/assembly/igniter/attack_self(mob/user)
	activate()
