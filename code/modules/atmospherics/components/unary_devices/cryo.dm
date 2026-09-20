#define CRYOMOBS 'icons/obj/cryo_mobs.dmi'

/obj/machinery/atmospherics/components/unary/cryo_cell
	name = "cryo cell"
	icon = 'icons/obj/machines/cryogenics2.dmi'
	icon_state = "cell_mapper"
	density = TRUE
	max_integrity = 350
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 100, BOMB = 0, BIO = 100, FIRE = 30, ACID = 30)
	layer = ABOVE_MOB_LAYER
	pipe_flags = PIPING_ONE_PER_TURF|PIPING_DEFAULT_LAYER_ONLY
	interaction_flags = INTERACT_MACHINE_TGUI
	light_range = 2
	light_power = 0.5
	light_color = LIGHT_COLOR_EMISSIVE_GREEN
	vent_movement = NONE
	device_type = NONE
	var/autoeject = FALSE
	var/release_notice = FALSE
	var/temperature = 100
	var/efficiency = 1
	var/sleep_factor = 0.00125
	var/unconscious_factor = 0.001
	var/heat_capacity = 20000
	var/conduction_coefficient = 0.3
	var/obj/item/reagent_containers/glass/beaker = null
	var/reagent_transfer = 0
	var/obj/item/radio/headset/mainship/doc/radio
	///Number of ticks permitted to elapse without a patient before the cryotube shuts itself off to save processing
	var/idle_ticks_until_shutdown = 60
	var/running_anim = FALSE
	var/escape_in_progress = FALSE
	var/message_cooldown
	var/breakout_time = 300
	var/mob/living/carbon/occupant

/obj/machinery/atmospherics/components/unary/cryo_cell/Initialize(mapload)
	. = ..()
	initialize_directions = dir
	beaker = new /obj/item/reagent_containers/glass/beaker/cryomix
	radio = new(src)
	update_icon()

/obj/machinery/atmospherics/components/unary/cryo_cell/proc/process_occupant()
	if(!occupant)
		return
	if(occupant.stat == DEAD)
		return
	if(!occupant.get_brute_loss(TRUE) && !occupant.get_fire_loss(TRUE) && !occupant.get_clone_loss() && autoeject) //release the patient automatically when brute and burn are handled on non-robotic limbs
		go_out(TRUE)
		return
	occupant.bodytemperature = 100 //Atmos is long gone, we'll just set temp directly.
	occupant.Sleeping(20 SECONDS)

	//You'll heal slowly just from being in an active pod, but chemicals speed it up.
	if(occupant.get_oxy_loss())
		occupant.adjust_oxy_loss(-1)
	if (occupant.get_tox_loss())
		occupant.adjust_tox_loss(-1)
	occupant.heal_overall_damage(1, 1, updating_health = TRUE)
	var/has_cryo = occupant.reagents.get_reagent_amount(/datum/reagent/medicine/cryoxadone) >= 1
	var/has_clonexa = occupant.reagents.get_reagent_amount(/datum/reagent/medicine/clonexadone) >= 1
	var/has_cryo_medicine = has_cryo || has_clonexa
	if(beaker && !has_cryo_medicine)
		beaker.reagents.trans_to(occupant, 1, 10)
		beaker.reagents.reaction(occupant)

/obj/machinery/atmospherics/components/unary/cryo_cell/on_construction()
	return ..(dir, dir)

/obj/machinery/atmospherics/components/unary/cryo_cell/RefreshParts()
	var/C
	for(var/obj/item/stock_parts/matter_bin/M in component_parts)
		C += M.rating

	efficiency = initial(efficiency) * C
	sleep_factor = initial(sleep_factor) * C
	unconscious_factor = initial(unconscious_factor) * C
	heat_capacity = initial(heat_capacity) / C
	conduction_coefficient = initial(conduction_coefficient) * C

/obj/machinery/atmospherics/components/unary/cryo_cell/examine(mob/user) //this is leaving out everything but efficiency since they follow the same idea of "better beaker, better results"
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. +=  span_notice("状态显示读数: 效率为<b>[efficiency*100]%</b>.")
	if(occupant)
		if(on)
			. += "Someone's inside [src]!"
		else
			. += "You can barely make out a form floating in [src]."
	else
		. += "[src] seems empty."

/obj/machinery/atmospherics/components/unary/cryo_cell/Destroy()
	QDEL_NULL(radio)
	QDEL_NULL(beaker)
	return ..()

/obj/machinery/atmospherics/components/unary/cryo_cell/contents_explosion(severity)
	. = ..()
	if(beaker)
		beaker.ex_act(severity)

/obj/machinery/atmospherics/components/unary/cryo_cell/handle_atom_del(atom/A)
	. = ..()
	if(A == beaker)
		beaker = null

/obj/machinery/atmospherics/components/unary/cryo_cell/update_icon()
	. = ..()
	if(!on)
		set_light(0)
	else
		set_light(initial(light_range))

/obj/machinery/atmospherics/components/unary/cryo_cell/update_icon_state()
	. = ..()
	if(!on)
		icon_state = "cell_off"
	else
		icon_state = "cell_on"
	if(occupant)
		icon_state += "_occupied"

/obj/machinery/atmospherics/components/unary/cryo_cell/update_overlays()
	. = ..()
	if(!on)
		return
	. += emissive_appearance(icon, "cell_emissive", src, alpha = src.alpha)

/obj/machinery/atmospherics/components/unary/cryo_cell/proc/run_anim(anim_up, image/occupant_overlay)
	if(!on || !occupant || !is_operational())
		running_anim = FALSE
		return
	cut_overlays()
	if(occupant_overlay.pixel_y != 23) // Same effect as occupant_overlay.pixel_y == 22 || occupant_overlay.pixel_y == 24
		anim_up = occupant_overlay.pixel_y == 22 // Same effect as if(occupant_overlay.pixel_y == 22) anim_up = TRUE ; if(occupant_overlay.pixel_y == 24) anim_up = FALSE
	if(anim_up)
		occupant_overlay.pixel_y++
	else
		occupant_overlay.pixel_y--
	add_overlay(occupant_overlay)
	add_overlay("cover-on")
	addtimer(CALLBACK(src, PROC_REF(run_anim), anim_up, occupant_overlay), 7, TIMER_UNIQUE)

/obj/machinery/atmospherics/components/unary/cryo_cell/proc/go_out(auto_eject = null, dead = null)
	if(!( occupant ))
		return
	if (occupant.client)
		occupant.client.set_eye(occupant.client.mob)
		occupant.client.perspective = MOB_PERSPECTIVE
	if(occupant in contents)
		occupant.forceMove(get_step(loc, dir))
	if (occupant.bodytemperature < 261 && occupant.bodytemperature >= 70) //Patch by Aranclanos to stop people from taking burn damage after being ejected
		occupant.bodytemperature = 261									  // Changed to 70 from 140 by Zuhayr due to reoccurance of bug.
	if(auto_eject) //Turn off and announce if auto-ejected because patient is recovered or dead.
		turn_off()
		if(release_notice) //If auto-release notices are on as it should be, let the doctors know what's up
			playsound(src.loc, 'sound/machines/ping.ogg', 100, 14)
			var/reason = "Reason for release:</b> Patient recovery."
			if(dead)
				reason = "<b>Reason for release:</b> Patient death."
			radio.talk_into(src, "Patient [occupant] has been automatically released from [src] at: [get_area(occupant)]. [reason]", RADIO_CHANNEL_MEDICAL)
	occupant.record_time_in_cryo()
	occupant = null
	update_icon()

/obj/machinery/atmospherics/components/unary/cryo_cell/proc/turn_off()
	on = FALSE
	stop_processing()
	update_icon()

/obj/machinery/atmospherics/components/unary/cryo_cell/process()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		turn_off()
		return

	if(!on)
		stop_processing()
		return

	if(occupant)
		if(occupant.stat != DEAD)
			idle_ticks_until_shutdown = 60 //reset idle ticks on usage
			process_occupant()
		else
			go_out(TRUE, TRUE) //Whether auto-eject is on or not, we don't permit literal deadbeats to hang around.
	else
		idle_ticks_until_shutdown = max(idle_ticks_until_shutdown--,0) //decrement by 1 if there is no patient.
		if(!idle_ticks_until_shutdown) //shut down after all ticks elapsed to conserve on processing
			turn_off()
			idle_ticks_until_shutdown = 60 //reset idle ticks
	return TRUE

/obj/machinery/atmospherics/components/unary/cryo_cell/relaymove(mob/user)
	if(message_cooldown <= world.time)
		message_cooldown = world.time + 50
		to_chat(user, span_warning("[src]的门纹丝不动!"))

/obj/machinery/atmospherics/components/unary/cryo_cell/verb/move_eject()
	set name = "Eject occupant"
	set category = "IC.Object"
	set src in oview(1)
	if(usr == occupant) //If the user is inside the tube...
		if (usr.stat == DEAD) //and he's not dead....
			return
		to_chat(usr, span_notice("自动释放序列已激活. 当你恢复后将被释放."))
		autoeject = TRUE
		return
	if (usr.stat != CONSCIOUS)
		return
	go_out()

/obj/machinery/atmospherics/components/unary/cryo_cell/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/reagent_containers/glass))

		for(var/datum/reagent/X in I.reagents.reagent_list)
			if(X.medbayblacklist)
				to_chat(user, span_warning("低温舱的自动安全功能轻轻发出哔声, 它们一定检测到了烧杯中的有害物质."))
				return

		if(beaker)
			to_chat(user, span_warning("机器中已经装有一个烧杯."))
			return

		if(istype(I, /obj/item/reagent_containers/glass/bucket))
			to_chat(user, span_warning("那太大了, 装不进去!"))
			return

		beaker = I

		var/reagentnames = ""
		for(var/datum/reagent/R in beaker.reagents.reagent_list)
			reagentnames += ", [R.name]"

		if(!user.transferItemToLoc(I, src))
			return

		user.visible_message("[user]将\a [I]添加到\the [src]中!", "你将\a [I]添加到\the [src]中!")

	else if(istype(I, /obj/item/healthanalyzer) && occupant) //Allows us to use the analyzer on the occupant without taking him out.
		var/obj/item/healthanalyzer/J = I
		J.attack(occupant, user)

/obj/machinery/atmospherics/components/unary/cryo_cell/grab_interact(obj/item/grab/grab, mob/user, base_damage = BASE_OBJ_SLAM_DAMAGE, is_sharp = FALSE)
	. = ..()
	if(.)
		return
	if(isxeno(user))
		return
	if(machine_stat & (NOPOWER|BROKEN))
		to_chat(user, span_notice("\ [src]无法使用!"))
		return

	if(occupant)
		to_chat(user, span_notice("\ [src]已被占用!"))
		return

	var/mob/grabbed_mob

	if(ismob(grab.grabbed_thing))
		grabbed_mob = grab.grabbed_thing

	else if(istype(grab.grabbed_thing,/obj/structure/closet/bodybag/cryobag))
		var/obj/structure/closet/bodybag/cryobag/cryobag = grab.grabbed_thing
		if(!cryobag.bodybag_occupant)
			to_chat(user, span_warning("休眠袋是空的!"))
			return
		grabbed_mob = cryobag.bodybag_occupant
		cryobag.open()
		user.start_pulling(grabbed_mob)

	if(!ishuman(grabbed_mob))
		to_chat(user, span_notice("\ [src]仅兼容类人生物的解剖结构!"))
		return

	if(grabbed_mob.abiotic())
		to_chat(user, span_warning("对象不能携带非生物物品."))
		return

	put_mob(grabbed_mob, TRUE)

	return TRUE

/obj/machinery/atmospherics/components/unary/cryo_cell/proc/put_mob(mob/living/carbon/M as mob, put_in = null)
	if (machine_stat & (NOPOWER|BROKEN))
		to_chat(usr, span_warning("低温休眠舱无法运作."))
		return
	if(!ishuman(M))
		to_chat(usr, span_notice("\ [src]仅兼容类人生物的解剖结构!"))
		return
	if (occupant)
		to_chat(usr, span_danger("低温休眠舱已被占用!"))
		return
	if (M.abiotic())
		to_chat(usr, span_warning("对象不能携带非生物物品."))
		return
	if(put_in) //Select an appropriate message
		visible_message(span_notice("[usr]将[M]放入[src]."), 3)
	else
		visible_message(span_notice("[usr]爬入[src]."), 3)
	M.forceMove(src)
	if(M.health > -100 && (M.health < 0 || M.has_status_effect(STATUS_EFFECT_SLEEPING)))
		to_chat(M, span_boldnotice("你感到冰冷的液体包围了你. 你的皮肤开始冻结."))
	occupant = M
	occupant.time_entered_cryo = world.time
	update_icon()
	return TRUE

/obj/machinery/atmospherics/components/unary/cryo_cell/proc/move_in(mob/living/target, mob/user)
	if(!ishuman(target) || !ishuman(user) || user.incapacitated(TRUE))
		return

	if(occupant)
		to_chat(user, span_notice("[src]已被占用!"))
		return

	if(machine_stat & (NOPOWER|BROKEN))
		to_chat(user, span_notice("[src]无法使用!"))
		return

	target.visible_message(span_notice("[target]开始爬入\the [src]."),
	span_notice("你开始爬入\the [src]."))
	if(do_after(target, 1 SECONDS, IGNORE_HELD_ITEM, src, BUSY_ICON_GENERIC))
		if(occupant)
			to_chat(user, span_notice("[src]已被占用!"))
			return
		target.stop_pulling()
		target.forceMove(src)
		occupant = target
		update_icon()

/obj/machinery/atmospherics/components/unary/cryo_cell/MouseDrop_T(mob/M, mob/user)
	. = ..()
	move_in(M, user)

/obj/machinery/atmospherics/components/unary/cryo_cell/verb/move_inside()
	set name = "Enter Cryo-cell"
	set category = "IC.Mob"
	set src in oview(1)

	move_in(usr, usr)

/obj/machinery/atmospherics/components/unary/cryo_cell/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	ui_interact(user)

/obj/machinery/atmospherics/components/unary/cryo_cell/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)

	if(!ui)
		ui = new(user, src, "Cryo", name)
		ui.open()

/obj/machinery/atmospherics/components/unary/cryo_cell/ui_data(mob/user)
	var/list/data = list()
	data["isOperating"] = on
	data["hasOccupant"] = occupant ? TRUE : FALSE
	data["autoEject"] = autoeject
	data["notify"] = release_notice

	data["occupant"] = list()
	if(occupant)
		var/mob/living/mob_occupant = occupant
		data["occupant"]["name"] = mob_occupant.name
		switch(mob_occupant.stat)
			if(CONSCIOUS)
				data["occupant"]["stat"] = "Conscious"
				data["occupant"]["statstate"] = "good"
			if(UNCONSCIOUS)
				data["occupant"]["stat"] = "Unconscious"
				data["occupant"]["statstate"] = "average"
			if(DEAD)
				data["occupant"]["stat"] = "Dead"
				data["occupant"]["statstate"] = "bad"
		data["occupant"]["health"] = round(mob_occupant.health, 1)
		data["occupant"]["maxHealth"] = mob_occupant.maxHealth
		data["occupant"]["minHealth"] = mob_occupant.health_threshold_dead
		data["occupant"]["bruteLoss"] = round(mob_occupant.get_brute_loss(), 1)
		data["occupant"]["oxyLoss"] = round(mob_occupant.get_oxy_loss(), 1)
		data["occupant"]["toxLoss"] = round(mob_occupant.get_tox_loss(), 1)
		data["occupant"]["fireLoss"] = round(mob_occupant.get_fire_loss(), 1)
		data["occupant"]["bodyTemperature"] = round(mob_occupant.bodytemperature, 1)
		if(mob_occupant.bodytemperature < 255)
			data["occupant"]["temperaturestatus"] = "good"
		else if(mob_occupant.bodytemperature < T0C)
			data["occupant"]["temperaturestatus"] = "average"
		else
			data["occupant"]["temperaturestatus"] = "bad"

	data["cellTemperature"] = round(temperature)

	data["isBeakerLoaded"] = beaker ? TRUE : FALSE
	var/beakerContents = list()
	if(beaker?.reagents && length(beaker.reagents.reagent_list))
		for(var/datum/reagent/R in beaker.reagents.reagent_list)
			beakerContents += list(list("name" = R.name, "volume" = R.volume))
	data["beakerContents"] = beakerContents
	return data

/obj/machinery/atmospherics/components/unary/cryo_cell/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	switch(action)
		if("power")
			if(on)
				turn_off()
			else
				turn_on()
			. = TRUE
		if("eject")
			go_out()
			. = TRUE
		if("autoeject")
			autoeject = !autoeject
			. = TRUE
		if("ejectbeaker")
			if(beaker)
				beaker.forceMove(drop_location())
				if(Adjacent(usr) && !issilicon(usr))
					usr.put_in_hands(beaker)
				beaker = null
				. = TRUE
		if("notice")
			release_notice = !release_notice
			. = TRUE

/obj/machinery/atmospherics/components/unary/cryo_cell/proc/turn_on()
	if (machine_stat & (NOPOWER|BROKEN))
		to_chat(usr, span_warning("低温休眠舱无法运作."))
		return
	on = TRUE
	start_processing()
	update_icon()

/obj/machinery/atmospherics/components/unary/cryo_cell/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount, damage_type, damage_flag, effects, armor_penetration, isrightclick)
	if(!occupant)
		to_chat(xeno_attacker, span_xenowarning("里面没有任何有趣的东西."))
		return
	if(xeno_attacker.status_flags & INCORPOREAL || xeno_attacker.do_actions)
		return
	visible_message(span_warning("[xeno_attacker]开始撬开[src]的盖子!"), 3)
	playsound(src,'sound/effects/metal_creaking.ogg', 25, 1)
	if(!do_after(xeno_attacker, 2 SECONDS))
		return
	playsound(loc, 'sound/effects/metal_creaking.ogg', 25, 1)
	go_out()

/obj/machinery/atmospherics/components/unary/cryo_cell/set_pipenet(datum/pipeline/reference, obj/machinery/atmospherics/A)
	return

#undef CRYOMOBS
