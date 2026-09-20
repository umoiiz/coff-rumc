
/obj/machinery/microwave
	name = "Microwave"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "mw"
	layer = GIB_LAYER
	density = TRUE
	anchored = TRUE
	coverage = 10
	use_power = IDLE_POWER_USE
	idle_power_usage = 5
	active_power_usage = 500
	/// Is it on?
	var/operating = 0
	/// = {0..100} Does it need cleaning?
	var/dirty = 0
	/// ={0,1,2} How broken is it???
	var/broken = 0
	/// List of the recipes you can use
	var/global/list/datum/recipe/available_recipes
	/// List of the items you can put in
	var/global/list/acceptable_items
	/// List of the reagents you can put in
	var/global/list/acceptable_reagents
	var/global/max_n_of_items = 0

// see code/modules/food/recipes_microwave.dm for recipes

/*******************
*   Initialising
********************/

/obj/machinery/microwave/Initialize(mapload)
	. = ..()
	create_reagents(100, OPENCONTAINER)
	if(!available_recipes)
		available_recipes = new
		for(var/type in subtypesof(/datum/recipe))
			available_recipes += new type
		acceptable_items = new
		acceptable_reagents = new
		for(var/datum/recipe/recipe AS in available_recipes)
			for(var/item in recipe.items)
				acceptable_items |= item
			for(var/reagent in recipe.reagents)
				acceptable_reagents |= reagent
			if(recipe.items)
				max_n_of_items = max(max_n_of_items,length(recipe.items))

/*******************
*   Item Adding
********************/

/obj/machinery/microwave/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(broken > 2)
		balloon_alert(user, "不能,已损坏")
		return TRUE

	else if(dirty == 100)
		if(!istype(I, /obj/item/reagent_containers/spray/cleaner))
			balloon_alert(user, "非常脏")
			return TRUE

		balloon_alert_to_viewers("开始清洁[src]")

		if(!do_after(user, 20, NONE, src, BUSY_ICON_BUILD))
			return TRUE

		balloon_alert_to_viewers("清洁了[src]")
		dirty = 0
		broken = 0
		icon_state = "mw"
		ENABLE_BITFIELD(reagents.reagent_flags, OPENCONTAINER)

	else if(is_type_in_list(I, acceptable_items))
		if(length(contents) >= max_n_of_items)
			balloon_alert(user, "不能,它满了")
			return TRUE

		if(istype(I, /obj/item/stack) && I:get_amount() > 1) // This is bad, but I can't think of how to change it
			var/obj/item/stack/S = I
			new S.type(src)
			S.use(1)
			balloon_alert_to_viewers("[user]将[I]添加到[src]")

		else if(user.drop_held_item())
			I.forceMove(src)
			balloon_alert_to_viewers("[user]已将[I]添加到[src]")

	else if(istype(I,/obj/item/reagent_containers/glass) || \
			istype(I,/obj/item/reagent_containers/food/drinks) || \
			istype(I,/obj/item/reagent_containers/food/condiment))

		if(!I.reagents)
			return TRUE

		for(var/i in I.reagents.reagent_list)
			var/datum/reagent/R = i
			if(!(R.type in acceptable_reagents))
				balloon_alert(user, "不能,材料不兼容烹饪")
				return TRUE

		return FALSE
	else
		balloon_alert(user, "不能用这个烹饪任何东西")
	return TRUE

/obj/machinery/microwave/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(broken != 2)
		return
	balloon_alert_to_viewers("开始修理微波炉")
	if(!do_after(user,20, NONE, src, BUSY_ICON_BUILD))
		return
	balloon_alert_to_viewers("修复了微波炉的一部分")
	broken = 1

/obj/machinery/microwave/wrench_act(mob/living/user, obj/item/I)
	. = ..()

	if(broken != 1)
		return
	balloon_alert_to_viewers("开始修理微波炉的一部分")
	if(!do_after(user,20, NONE, src, BUSY_ICON_BUILD))
		return
	balloon_alert_to_viewers("修复了微波炉")
	icon_state = "mw"
	broken = 0
	dirty = 0
	ENABLE_BITFIELD(reagents.reagent_flags, OPENCONTAINER)

/obj/machinery/microwave/grab_interact(obj/item/grab/grab, mob/user, base_damage = BASE_OBJ_SLAM_DAMAGE, is_sharp = FALSE)
	if(!is_operational())
		return ..()
	if(isxeno(user))
		return
	if(user.do_actions)
		return
	if(!isliving(grab.grabbed_thing))
		return
	if(user.a_intent != INTENT_HARM)
		return
	if(user.grab_state <= GRAB_AGGRESSIVE)
		to_chat(user, span_warning("你需要更好的握持才能这样做!"))
		return
	var/mob/living/grabbed_mob = grab.grabbed_thing
	if(grabbed_mob.mob_size > MOB_SIZE_HUMAN)
		to_chat(user, span_warning("它们太大了放不进去!"))
		return
	user.visible_message(span_danger("[user]开始将[grabbed_mob]强行塞入[src]!"), span_notice("你开始将[grabbed_mob]强行塞入[src]!"))
	if(!do_after(user, 3 SECONDS, NONE, src, BUSY_ICON_HOSTILE, extra_checks = CALLBACK(src, PROC_REF(microwave_victim), grabbed_mob)))
		playsound(src.loc, 'sound/machines/ding.ogg', 25, 1)
		return

	user.visible_message(span_danger("[user]用微波炉加热[grabbed_mob]!"), span_notice("你用微波炉加热[grabbed_mob]!"), "你听到滋滋声.")
	log_combat(user, grabbed_mob, "microwaved")
	playsound(src.loc, 'sound/machines/ding.ogg', 25, 1)
	return TRUE

/obj/machinery/microwave/proc/microwave_victim(mob/living/victim)
	victim.apply_damage(3, BURN, "head", ENERGY, updating_health = TRUE, penetration = 20)
	victim.jitter(5)
	if(prob(10))
		victim.emote("scream")
		victim.adjust_brain_loss(5)
	if(victim.stat != DEAD)
		return TRUE

/obj/machinery/microwave/nopower
	use_power = NO_POWER_USE

/*******************
*   Microwave Menu
********************/

/obj/machinery/microwave/examine(mob/user)
	. = ..()
	if(broken > 0)
		. += span_warning("它看起来坏了.")
		return
	if(dirty == 100)
		. += span_warning("它很脏,使用前需要清洁.")
	if(operating)
		. += span_notice("它目前正在运行.")
		return
	if(!length(contents) && !reagents.total_volume)
		. += span_notice("它是空的.")
		return

	var/list/items_counts = new
	for(var/obj/O in contents)
		items_counts[O.name]++
	. += span_notice("它包含:")
	for(var/item_name in items_counts)
		. += span_notice("- [items_counts[item_name]]x [item_name].")
	for(var/datum/reagent/R in reagents.reagent_list)
		. += span_notice("- [R.volume] 单位\s 的[R.name].")

/// Radial menu, RU/TG-style: only pops up when the microwave actually has something to act on.
/obj/machinery/microwave/interact(mob/user)
	. = ..()
	if(.)
		return

	if(broken > 0)
		balloon_alert(user, "它坏了!")
		return
	if(operating)
		balloon_alert(user, "它已经在烹饪了!")
		return
	if(dirty == 100)
		balloon_alert(user, "它太脏了!")
		return

	if(!length(contents) && !reagents.total_volume)
		balloon_alert(user, "它是空的!")
		return

	var/static/image/radial_cook = image(icon = 'icons/mob/radial_actions.dmi', icon_state = "radial_cook")
	var/static/image/radial_eject = image(icon = 'icons/mob/radial_actions.dmi', icon_state = "radial_eject")
	var/static/list/radial_options = list("cook" = radial_cook, "eject" = radial_eject)

	var/choice = show_radial_menu(user, src, radial_options, custom_check = CALLBACK(src, PROC_REF(check_interactable), user), require_near = TRUE, tooltips = TRUE)
	if(!choice || !check_interactable(user))
		return

	switch(choice)
		if("cook")
			cook()
		if("eject")
			destroy_contents()

/// Whether the radial menu should stay open / the chosen action should still fire.
/obj/machinery/microwave/proc/check_interactable(mob/user)
	return !(broken > 0) && !operating && dirty != 100 && is_operational() && Adjacent(user) && !user.incapacitated()

/***********************************
*   Microwave Menu Handling/Cooking
************************************/
/obj/machinery/microwave/proc/cook()
	if(machine_stat & (NOPOWER|BROKEN))
		return
	start()
	if(reagents.total_volume==0 && !(locate(/obj) in contents)) //dry run
		if(!wzhzhzh(10))
			abort()
			return
		stop()
		return

	var/datum/recipe/recipe = select_recipe(available_recipes,src)
	var/obj/cooked
	if(!recipe)
		dirty += 1
		if(prob(max(10, dirty * 5)))
			if(!wzhzhzh(4))
				abort()
				return
			muck_start()
			wzhzhzh(4)
			muck_finish()
			cooked = fail()
			cooked.loc = loc
			return
		else if(has_extra_item())
			if(!wzhzhzh(4))
				abort()
				return
			broke()
			cooked = fail()
			cooked.loc = loc
			return
		else
			if(!wzhzhzh(10))
				abort()
				return
			stop()
			cooked = fail()
			cooked.loc = loc
			return
	else
		var/halftime = round(recipe.time * 0.1 * 0.5)
		if(!wzhzhzh(halftime))
			abort()
			return
		if(!wzhzhzh(halftime))
			abort()
			cooked = fail()
			cooked.loc = loc
			return
		cooked = recipe.make_food(src)
		stop()
		if(cooked)
			cooked.loc = loc
		return

/obj/machinery/microwave/proc/wzhzhzh(seconds as num)
	for(var/i = 1 to seconds)
		if(machine_stat & (NOPOWER|BROKEN))
			return FALSE
		use_power(active_power_usage)
		sleep(1 SECONDS)
	return TRUE

/obj/machinery/microwave/proc/has_extra_item()
	for(var/obj/O in contents)
		if(!istype(O,/obj/item/reagent_containers/food) && !istype(O, /obj/item/grown))
			return TRUE
	return FALSE

/obj/machinery/microwave/proc/start()
	balloon_alert_to_viewers("开启")
	operating = 1
	icon_state = "mw1"
	updateUsrDialog()

/obj/machinery/microwave/proc/abort()
	balloon_alert_to_viewers("关闭")
	operating = 0 // Turn it off again aferwards
	icon_state = "mw"
	updateUsrDialog()

/obj/machinery/microwave/proc/stop()
	balloon_alert_to_viewers("关闭")
	playsound(loc, 'sound/machines/ding.ogg', 25, 1)
	operating = 0 // Turn it off again aferwards
	icon_state = "mw"
	updateUsrDialog()

/obj/machinery/microwave/proc/destroy_contents()
	for(var/obj/O in contents)
		O.loc = loc
	if(reagents.total_volume)
		dirty++
	reagents.clear_reagents()
	balloon_alert(src, "倒出微波炉内容物")
	updateUsrDialog()

/obj/machinery/microwave/proc/muck_start()
	playsound(loc, 'sound/effects/splat.ogg', 25, 1) // Play a splat sound
	icon_state = "mwbloody1" // Make it look dirty!!

/obj/machinery/microwave/proc/muck_finish()
	playsound(loc, 'sound/machines/ding.ogg', 25, 1)
	visible_message(span_warning("微波炉被污物覆盖了!"))
	dirty = 100 // Make it dirty so it can't be used util cleaned
	DISABLE_BITFIELD(reagents.reagent_flags, OPENCONTAINER) //So you can't add condiments
	icon_state = "mwbloody0" // Make it look dirty too
	operating = 0 // Turn it off again aferwards
	updateUsrDialog()

/obj/machinery/microwave/proc/broke()
	var/datum/effect_system/spark_spread/s = new
	s.set_up(2, 1, src)
	s.start()
	icon_state = "mwb" // Make it look all busted up and shit
	visible_message(span_warning("微波炉坏了!")) //Let them know they're stupid
	broken = 2 // Make it broken so it can't be used util fixed
	DISABLE_BITFIELD(reagents.reagent_flags, OPENCONTAINER) //So you can't add condiments
	operating = 0 // Turn it off again aferwards
	updateUsrDialog()

/obj/machinery/microwave/proc/fail()
	var/obj/item/reagent_containers/food/snacks/badrecipe/ffuu = new(src)
	var/amount = 0
	for(var/obj/O in contents-ffuu)
		amount++
		if(O.reagents)
			var/id = O.reagents.get_master_reagent_id()
			if(id)
				amount+=O.reagents.get_reagent_amount(id)
		qdel(O)
	reagents.clear_reagents()
	ffuu.reagents.add_reagent(/datum/reagent/carbon, amount)
	ffuu.reagents.add_reagent(/datum/reagent/toxin, amount * 0.1)
	return ffuu

