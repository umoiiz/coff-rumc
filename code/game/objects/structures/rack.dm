/obj/structure/rack
	name = "货架"
	desc = "一堆金属架子堆叠在一起. 非常适合储存物品, 但作为掩体就不太行了."
	icon = 'icons/obj/objects.dmi'
	icon_state = "rack"
	density = TRUE
	layer = TABLE_LAYER
	anchored = TRUE
	coverage = 20
	climbable = TRUE
	max_integrity = 40
	resistance_flags = XENO_DAMAGEABLE
	allow_pass_flags = PASS_LOW_STRUCTURE|PASSABLE
	/// What parts do we drop on wrench_act
	var/parts = /obj/item/frame/rack
	/// If true drop metal when destroyed; mostly used when we need large amounts of racks without marines hoarding the metal
	var/dropmetal = TRUE

/obj/structure/rack/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_cross),
		COMSIG_OBJ_TRY_ALLOW_THROUGH = PROC_REF(can_climb_over),
		COMSIG_FIND_FOOTSTEP_SOUND = TYPE_PROC_REF(/atom/movable, footstep_override),
		COMSIG_TURF_CHECK_COVERED = TYPE_PROC_REF(/atom/movable, turf_cover_check),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/rack/MouseDrop_T(obj/item/I, mob/user)
	if(!istype(I) || user.get_active_held_item() != I)
		return ..()
	user.drop_held_item()
	if(I.loc != loc)
		step(I, get_dir(I, src))

/obj/structure/rack/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(user.a_intent != INTENT_HARM)
		return user.transferItemToLoc(I, loc)

/obj/structure/rack/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	deconstruct(TRUE)
	playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
	return TRUE

/obj/structure/rack/proc/on_cross(datum/source, atom/movable/O, oldloc, oldlocs)
	SIGNAL_HANDLER
	if(!istype(O,/mob/living/carbon/xenomorph/ravager))
		return
	var/mob/living/carbon/xenomorph/M = O
	if(!M.stat) //No dead xenos jumpin on the bed~
		visible_message(span_danger("[O]直接撞穿了[src]!"))
		deconstruct(FALSE)

/obj/structure/rack/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(disassembled && parts && dropmetal)
		new parts(loc)
	else if(dropmetal)
		new /obj/item/stack/sheet/metal(loc)
	density = FALSE
	return ..()

/obj/structure/rack/nometal
	dropmetal = FALSE
