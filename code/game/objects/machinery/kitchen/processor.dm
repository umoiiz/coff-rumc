/obj/machinery/processor
	name = "Food Processor"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "processor"
	layer = GIB_LAYER
	density = TRUE
	anchored = TRUE
	coverage = 20
	use_power = IDLE_POWER_USE
	idle_power_usage = 5
	active_power_usage = 500
	var/broken = 0
	var/processing = 0

/obj/machinery/processor/nopower
	use_power = NO_POWER_USE

/datum/food_processor_process
	var/input
	var/output
	var/time = 40

/datum/food_processor_process/process(loc, what)
	if(output && loc)
		new output(loc)
	if(what)
		qdel(what)

/obj/machinery/processor/proc/select_recipe(X)
	for(var/Type in subtypesof(/datum/food_processor_process))
		var/datum/food_processor_process/P = new Type()
		if(!istype(X, P.input))
			continue
		return P
	return 0

/obj/machinery/processor/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(processing)
		to_chat(user, span_warning("处理器正在处理中."))
		return TRUE

	if(length(contents))
		to_chat(user, span_warning("处理室内已经有东西了."))
		return TRUE

	var/obj/O = I

	if(isgrabitem(I))
		var/obj/item/grab/G = I
		O = G.grabbed_thing

	var/datum/food_processor_process/P = select_recipe(O)
	if(!P)
		to_chat(user, span_warning("那大概无法搅拌."))
		return TRUE
	user.visible_message("[user]将[O]放入[src].", \
		"You put the [O] into [src].")
	user.drop_held_item()
	O.forceMove(src)

/obj/machinery/processor/grab_interact(obj/item/grab/grab, mob/user, base_damage = BASE_OBJ_SLAM_DAMAGE, is_sharp = FALSE)
	if(!is_operational())
		return ..()
	if(isxeno(user))
		return
	if(!isliving(grab.grabbed_thing))
		return
	if(user.a_intent != INTENT_HARM)
		return
	if(user.grab_state <= GRAB_AGGRESSIVE)
		to_chat(user, span_warning("你需要更好的握持才能这样做!"))
		return
	var/mob/living/grabbed_mob = grab.grabbed_thing
	user.visible_message(span_danger("[user]开始将[grabbed_mob]强行塞入[src]!"), span_notice("你开始将[grabbed_mob]强行塞入[src]!"))
	if(!do_after(user, 3 SECONDS, NONE, src, BUSY_ICON_HOSTILE))
		return

	user.visible_message(span_danger("[user]处理[grabbed_mob]!"), span_notice("你处理[grabbed_mob]!"), "你听到搅动声.")
	log_combat(user, grabbed_mob, "food processed")
	playsound(loc, 'sound/machines/blender.ogg', 25, 1)
	grabbed_mob.apply_damage(80, BRUTE, "head", MELEE, TRUE, updating_health = TRUE)
	return TRUE

/obj/machinery/processor/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(machine_stat != 0) //NOPOWER etc
		return
	if(processing)
		to_chat(user, span_warning("处理器正在处理中."))
		return TRUE
	if(length(contents) == 0)
		to_chat(user, span_warning("处理器是空的."))
		return TRUE
	for(var/O in contents)
		var/datum/food_processor_process/P = select_recipe(O)
		if(!P)
			stack_trace("[O] in processor doesn't have a suitable recipe.") //-rastaf0
			continue
		processing = 1
		user.visible_message(span_notice("[user]开启了[src]."), \
			"You turn on [src].", \
			"You hear a food processor.")
		playsound(loc, 'sound/machines/blender.ogg', 25, 1)
		use_power(active_power_usage)
		sleep(P.time)
		P.process(loc, O)
		processing = 0
	visible_message(span_notice("\the [src]完成处理."), \
		"You hear the food processor stopping/")
