#define BARRICADE_PLASTEEL_LOOSE 0
#define BARRICADE_PLASTEEL_ANCHORED 1
#define BARRICADE_PLASTEEL_FIRM 2
#define MARINE_QUICKBUILD_ALLOWED (CHECK_BITFIELD(SSticker.mode?.round_type_flags, MODE_ALLOW_MARINE_QUICKBUILD) && (!SSticker.round_start_time || (world.time - SSticker.round_start_time) < 10 MINUTES))

/obj/structure/barricade/folding
	name = "塑钢路障"
	desc = "由塑钢面板制成的非常坚固的路障,是据点的巅峰之作.使用喷灯修理.可以翻倒以开辟通路."
	icon_state = "plasteel_closed_0"
	icon = 'icons/obj/structures/barricades/plasteel.dmi'
	max_integrity = 500
	soft_armor = list(MELEE = 0, BULLET = 45, LASER = 45, ENERGY = 45, BOMB = 30, BIO = 100, FIRE = 80, ACID = 55)
	coverage = 128
	stack_type = /obj/item/stack/sheet/plasteel
	stack_amount = 6
	destroyed_stack_amount = 3
	hit_sound = 'sound/effects/metalhit.ogg'
	barricade_type = "plasteel"
	density = FALSE
	closed = TRUE
	can_wire = TRUE
	climbable = TRUE
	///What state is our barricade in for construction steps?
	var/build_state = BARRICADE_PLASTEEL_FIRM
	///Standard busy check
	var/busy = FALSE
	///ehther we react with other cades next to us ie when opening or so
	var/linked = FALSE
	var/base_repairing_timer = 2 SECONDS
	COOLDOWN_DECLARE(tool_cooldown) //Delay to apply tools to prevent spamming

/obj/structure/barricade/folding/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_SPARKS, -40, 8, 1)

/obj/structure/barricade/folding/handle_barrier_chance(mob/living/M)
	if(closed)
		return ..()
	return FALSE

/obj/structure/barricade/folding/examine(mob/user)
	. = ..()

	switch(build_state)
		if(BARRICADE_PLASTEEL_FIRM)
			. += span_info("防护板仍然紧紧拧在原位.")
		if(BARRICADE_PLASTEEL_ANCHORED)
			. += span_info("防护板已被移除,你可以看到锚栓.")
		if(BARRICADE_PLASTEEL_LOOSE)
			. += span_info("防护板已被移除,锚栓已松动.可以拆解了.")

/obj/structure/barricade/folding/welder_act(mob/living/user, obj/item/I)
	. = welder_repair_act(user, I, 85, 2.5 SECONDS, 0.3, SKILL_ENGINEER_PLASTEEL, 1)
	if(. == BELOW_INTEGRITY_THRESHOLD)
		var/obj/item/stack/sheet/material_sheets = stack_type
		balloon_alert(user, "损坏太严重.使用[material_sheets.name]片.")

/obj/structure/barricade/folding/screwdriver_act(mob/living/user, obj/item/I)
	if(busy || !COOLDOWN_FINISHED(src, tool_cooldown))
		return

	if(LAZYACCESS(user.do_actions, src))
		return

	COOLDOWN_START(src, tool_cooldown, 1 SECONDS)

	switch(build_state)
		if(BARRICADE_PLASTEEL_FIRM) //Fully constructed step. Use screwdriver to remove the protection panels to reveal the bolts
			if(!MARINE_QUICKBUILD_ALLOWED && user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_PLASTEEL)
				var/fumbling_time = 1 SECONDS * ( SKILL_ENGINEER_PLASTEEL - user.skills.getRating(SKILL_ENGINEER) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return

			for(var/obj/structure/barricade/B in loc)
				if(B != src && B.dir == dir)
					balloon_alert(user, "这里已经有路障了")
					return

			if(!do_after(user, 1, NONE, src, BUSY_ICON_BUILD))
				return

			balloon_alert_to_viewers("防护板螺栓已移除")
			playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
			build_state = BARRICADE_PLASTEEL_ANCHORED
		if(BARRICADE_PLASTEEL_ANCHORED) //Protection panel removed step. Screwdriver to put the panel back, wrench to unsecure the anchor bolts
			if(!MARINE_QUICKBUILD_ALLOWED && user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_PLASTEEL)
				var/fumbling_time = 1 SECONDS * ( SKILL_ENGINEER_PLASTEEL - user.skills.getRating(SKILL_ENGINEER) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return
			balloon_alert_to_viewers("防护板螺栓已更换")
			playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
			build_state = BARRICADE_PLASTEEL_FIRM

/obj/structure/barricade/folding/crowbar_act(mob/living/user, obj/item/I)
	if(busy || !COOLDOWN_FINISHED(src, tool_cooldown))
		return

	if(LAZYACCESS(user.do_actions, src))
		return

	COOLDOWN_START(src, tool_cooldown, 1 SECONDS)

	switch(build_state)
		if(BARRICADE_PLASTEEL_FIRM)
			balloon_alert_to_viewers("[linked ? "un" : "" ]已连接")
			linked = !linked
			for(var/direction in GLOB.cardinals)
				for(var/obj/structure/barricade/folding/cade in get_step(src, direction))
					cade.update_icon()
			update_icon()
		if(BARRICADE_PLASTEEL_LOOSE) //Anchor bolts loosened step. Apply crowbar to unseat the panel and take apart the whole thing.
			if(!MARINE_QUICKBUILD_ALLOWED && user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_PLASTEEL)
				var/fumbling_time = 5 SECONDS * ( SKILL_ENGINEER_PLASTEEL - user.skills.getRating(SKILL_ENGINEER) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return
			balloon_alert_to_viewers("正在拆解")
			playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
			busy = TRUE

			if(!do_after(user, 50, NONE, src, BUSY_ICON_BUILD))
				busy = FALSE
				return

			busy = FALSE
			user.visible_message(span_notice("[user]拆下了[src]的面板."),
			span_notice("你拆下了[src]的面板."))
			playsound(loc, 'sound/items/deconstruct.ogg', 25, 1)
			deconstruct(!get_self_acid())

/obj/structure/barricade/folding/wrench_act(mob/living/user, obj/item/I)
	if(busy || !COOLDOWN_FINISHED(src, tool_cooldown))
		return

	if(LAZYACCESS(user.do_actions, src))
		return

	COOLDOWN_START(src, tool_cooldown, 1 SECONDS)

	switch(build_state)
		if(BARRICADE_PLASTEEL_ANCHORED) //Protection panel removed step. Screwdriver to put the panel back, wrench to unsecure the anchor bolts
			if(!MARINE_QUICKBUILD_ALLOWED && user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_PLASTEEL)
				var/fumbling_time = 1 SECONDS * ( SKILL_ENGINEER_PLASTEEL - user.skills.getRating(SKILL_ENGINEER) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return
			balloon_alert_to_viewers("锚栓已松动")
			playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
			anchored = FALSE
			modify_max_integrity(initial(max_integrity) * 0.5)
			build_state = BARRICADE_PLASTEEL_LOOSE
			update_icon() //unanchored changes layer
		if(BARRICADE_PLASTEEL_LOOSE) //Anchor bolts loosened step. Apply crowbar to unseat the panel and take apart the whole thing. Apply wrench to rescure anchor bolts
			var/turf/mystery_turf = get_turf(src)
			if(!isopenturf(mystery_turf))
				balloon_alert(user, "无法在此固定")
				return

			var/turf/open/T = mystery_turf
			if(!T.allow_construction) //We shouldn't be able to anchor in areas we're not supposed to build; loophole closed.
				balloon_alert(user, "无法在此固定")
				return

			if(!MARINE_QUICKBUILD_ALLOWED && user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_PLASTEEL)
				var/fumbling_time = 1 SECONDS * ( SKILL_ENGINEER_PLASTEEL - user.skills.getRating(SKILL_ENGINEER) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return
			balloon_alert_to_viewers("螺栓已固定")
			playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
			anchored = TRUE
			modify_max_integrity(initial(max_integrity))
			build_state = BARRICADE_PLASTEEL_ANCHORED
			update_icon() //unanchored changes layer

/obj/structure/barricade/folding/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(!istype(I, stack_type))
		return
	var/obj/item/stack/sheet/material_sheets = I
	if(obj_integrity >= max_integrity * 0.3)
		return

	if(material_sheets.get_amount() < 2)
		balloon_alert(user, "你至少需要2片[material_sheets.name]")
		return

	if(LAZYACCESS(user.do_actions, src))
		return

	balloon_alert_to_viewers("正在修理底座...")

	if(!do_after(user, base_repairing_timer, NONE, src, BUSY_ICON_FRIENDLY) || obj_integrity >= max_integrity * 0.3)
		return

	if(get_self_acid())
		balloon_alert(user, "它正在融化!")
		return TRUE

	if(!material_sheets.use(2))
		return

	repair_damage(max_integrity * 0.3, user)
	balloon_alert_to_viewers("底座已修复")
	update_icon()

/obj/structure/barricade/folding/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	toggle_open(null, user)

/obj/structure/barricade/folding/update_overlays()
	. = ..()
	if(!linked)
		return
	for(var/direction in GLOB.cardinals)
		for(var/obj/structure/barricade/folding/cade in get_step(src, direction))
			if(cade.barricade_type != barricade_type)
				continue
			if(((dir & (NORTH|SOUTH) && get_dir(src, cade) & (EAST|WEST)) || (dir & (EAST|WEST) && get_dir(src, cade) & (NORTH|SOUTH))) && dir == cade.dir && cade.linked && cade.closed == closed)
				. += image(icon, icon_state = "[barricade_type]_[closed ? "closed" : "open"]_connection_[get_dir(src, cade)]")

/obj/structure/barricade/folding/proc/toggle_open(state, atom/user)
	if(state == closed)
		return
	playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
	closed = !closed
	density = !density

	user?.visible_message(span_notice("[user]将[src][closed ? "closed" :"open"]."),
		span_notice("你将[src][closed ? "closed" :"open"]."))

	if(!linked)
		update_icon()
		return
	for(var/direction in GLOB.cardinals)
		for(var/obj/structure/barricade/folding/cade in get_step(src, direction))
			if(cade.barricade_type != barricade_type)
				continue
			if(((dir & (NORTH|SOUTH) && get_dir(src, cade) & (EAST|WEST)) || (dir & (EAST|WEST) && get_dir(src, cade) & (NORTH|SOUTH))) && dir == cade.dir && cade.linked)
				cade.toggle_open(closed)

	update_icon()

/obj/structure/barricade/folding/metal
	name = "折叠金属路障"
	desc = "由金属制成的折叠路障,比普通金属路障稍弱.使用喷灯修理.可以翻倒以开辟通路."
	icon_state = "folding_metal_closed_0"
	icon = 'icons/obj/structures/barricades/folding_metal.dmi'
	max_integrity = 225 //6 sheets
	soft_armor = list(MELEE = 0, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 0, BIO = 100, FIRE = 80, ACID = 40)
	stack_type = /obj/item/stack/sheet/metal
	stack_amount = 6
	destroyed_stack_amount = 3
	barricade_type = "folding_metal"
	base_repairing_timer = 1.5 SECONDS

#undef BARRICADE_PLASTEEL_LOOSE
#undef BARRICADE_PLASTEEL_ANCHORED
#undef BARRICADE_PLASTEEL_FIRM
#undef MARINE_QUICKBUILD_ALLOWED
