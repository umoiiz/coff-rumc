/turf/closed/wall
	name = "wall"
	desc = "一大块用于分隔房间的金属."
	icon = 'icons/turf/walls/regular_wall.dmi'
	icon_state = "metal-0"
	base_icon_state = "metal"
	baseturfs = /turf/open/floor/plating
	opacity = TRUE
	explosion_block = 2
	walltype = "metal"
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 100, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(
		SMOOTH_GROUP_CLOSED_TURFS,
		SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS,
	)
	canSmoothWith = list(
		SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS,
		SMOOTH_GROUP_AIRLOCK,
		SMOOTH_GROUP_WINDOW_FRAME,
		SMOOTH_GROUP_WINDOW_FULLTILE,
		SMOOTH_GROUP_SHUTTERS,
		SMOOTH_GROUP_GIRDER,
	)
	var/wall_integrity
	/// Wall will break down to girders if damage reaches this point
	var/max_integrity = 1000
	var/global/damage_overlays[8]
	/// Walls will take damage if they're next to a fire hotter than this
	var/max_temperature = 1800
	/// Normal walls are now as difficult to remove as reinforced walls
	var/d_state = 0
	/// The acid hole inside the wall
	var/obj/effect/acid_hole/acided_hole
	/// The current number of bulletholes in this turf
	var/current_bulletholes = 0
	/// A reference to the current bullethole overlay image, this is added and deleted as needed
	var/image/bullethole_overlay
	/**
	 * The variation set we're using
	 * There are 10 sets and it gets picked randomly the first time a wall is shot
	 * It corresponds to the first number in the icon_state (bhole_[**bullethole_variation**]_[current_bulletholes])
	 * Gets reset to 0 if the wall reaches maximum health, so a new variation is picked when the wall gets shot again
	 */
	var/bullethole_variation = 0

/turf/closed/wall/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_SPARKS, -40, 8, 1)

/turf/closed/wall/Initialize(mapload, ...)
	. = ..()

	if(isnull(wall_integrity))
		wall_integrity = max_integrity

	for(var/obj/item/explosive/mine/M in src)
		if(M)
			visible_message(span_warning("\The [M]在墙壁建成时被封在了里面"))
			qdel(M)

/turf/closed/wall/Destroy(force)
	QDEL_NULL(acided_hole)
	QDEL_NULL(bullethole_overlay)
	return ..()

/turf/closed/wall/ChangeTurf(newtype)
	if(acided_hole)
		qdel(acided_hole)
		acided_hole = null

	. = ..()
	if(.) //successful turf change

		var/turf/T
		for(var/i in GLOB.cardinals)
			T = get_step(src, i)

			//update junction type of nearby walls
			if(smoothing_flags)
				QUEUE_SMOOTH(T)

			//nearby glowshrooms updated
			for(var/obj/structure/glowshroom/shroom in T)
				if(!shroom.floor) //shrooms drop to the floor
					shroom.floor = 1
					shroom.icon_state = "glowshroomf"
					shroom.pixel_x = 0
					shroom.pixel_y = 0

		for(var/obj/O in src) //Eject contents!
			if(istype(O, /obj/structure/sign/poster))
				var/obj/structure/sign/poster/P = O
				P.roll_and_drop(src)
			if(istype(O, /obj/alien/weeds))
				qdel(O)

/turf/closed/wall/MouseDrop_T(mob/M, mob/user)
	if(acided_hole)
		if(M == user && isxeno(user))
			acided_hole.use_wall_hole(user)
			return
	return ..()

/turf/closed/wall/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(xeno_attacker.status_flags & INCORPOREAL)
		return
	if(acided_hole && (xeno_attacker.mob_size == MOB_SIZE_BIG || xeno_attacker.xeno_caste.caste_flags & CASTE_IS_STRONG)) //Strong and/or big xenos can tear open acided walls
		acided_hole.expand_hole(xeno_attacker)
	else
		return ..()

//Appearance
/turf/closed/wall/examine(mob/user)
	. = ..()

	if(wall_integrity == max_integrity)
		if (acided_hole)
			. += span_warning("它看起来完好无损,只是有一个大洞,可能是由某种酸造成的.")
		else
			. += span_notice("看起来完好无损.")
	else
		var/integ = wall_integrity / max_integrity
		if(integ >= 0.6)
			. += span_warning("看起来有轻微损伤.")
		else if(integ >= 0.3)
			. += span_warning("看起来有中度损伤.")
		else
			. += span_danger("看起来有严重损伤.")

		if(acided_hole)
			. += span_warning("墙上有一个大洞,可能是某种酸液造成的.")

	// todo why does this not use defines?
	switch(d_state)
		if(1)
			. += span_info("外层装甲板被切开了. 螺丝刀应该可以拆下支撑线.")
		if(2)
			. += span_info("支撑线已被拆除. 喷灯应该可以切开金属盖.")
		if(3)
			. += span_info("金属盖已被切开. 撬棍应该可以把它撬开.")
		if(4)
			. += span_info("金属盖已被拆除. 扳手可以拆下锚栓.")
		if(5)
			. += span_info("锚栓已被拆除. 剪线钳可以处理液压管线.")
		if(6)
			. += span_info("液压管线已拆除. 撬棍可以撬开内护套.")
		if(7)
			. += span_info("内护套已拆除. 喷灯应该可以彻底摧毁这面墙.")

/turf/closed/wall/update_overlays()
	. = ..()
	if(wall_integrity == max_integrity)
		current_bulletholes = 0
		bullethole_variation = 0
		QDEL_NULL(bullethole_overlay)
		return

	if(!damage_overlays[1]) //list hasn't been populated
		var/alpha_inc = 256 / length(damage_overlays)

		for(var/i = 1; i <= length(damage_overlays); i++)
			var/image/img = image(icon = 'icons/turf/walls.dmi', icon_state = "overlay_damage")
			img.blend_mode = BLEND_MULTIPLY
			img.alpha = (i * alpha_inc) - 1
			damage_overlays[i] = img

	var/overlay = round((max_integrity - wall_integrity) / max_integrity * length(damage_overlays)) + 1
	if(overlay > length(damage_overlays))
		overlay = length(damage_overlays)

	. += damage_overlays[overlay]

	if(current_bulletholes && current_bulletholes <= BULLETHOLE_MAX)
		if(!bullethole_variation)
			bullethole_variation = rand(1, BULLETHOLE_STATES)
		bullethole_overlay = image('icons/effects/bulletholes.dmi', src, "bhole_[bullethole_variation]_[current_bulletholes]")
	. += bullethole_overlay

/turf/closed/wall/do_acid_melt()
	. = ..()
	if(acided_hole)
		ScrapeAway()
		return
	new /obj/effect/acid_hole(src)

///Applies damage to the wall
/turf/closed/wall/proc/take_damage(damage_amount, damage_type = BRUTE, damage_flag = null, armour_penetration = 0)
	if(resistance_flags & INDESTRUCTIBLE) //Hull is literally invincible
		return

	if(!damage_amount)
		return

	if(damage_flag)
		damage_amount = modify_by_armor(damage_amount, damage_flag, armour_penetration)

	if(!damage_amount)
		return

	wall_integrity = max(0, wall_integrity - damage_amount)

	if(wall_integrity > 0)
		update_icon()
		return

	// Xenos used to be able to crawl through the wall, should suggest some structural damage to the girder
	if(acided_hole)
		dismantle_wall(TRUE)
		return
	dismantle_wall()

///Repairs the wall by an amount
/turf/closed/wall/proc/repair_damage(repair_amount, mob/user)
	if(resistance_flags & INDESTRUCTIBLE) //Hull is literally invincible
		return

	if(!repair_amount)
		return

	repair_amount = min(repair_amount, max_integrity - wall_integrity)
	if(user?.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
		personal_statistics.integrity_repaired += repair_amount
		personal_statistics.times_repaired++
	wall_integrity += repair_amount
	update_icon()

/turf/closed/wall/proc/make_girder(destroyed_girder = FALSE)
	var/obj/structure/girder/G = new /obj/structure/girder(src)
	G.update_icon()

	if(destroyed_girder)
		G.deconstruct(FALSE)

// Devastated and Explode causes the wall to spawn a damaged girder
// Walls no longer spawn a metal sheet when destroyed to reduce clutter and
// improve visual readability.
/turf/closed/wall/proc/dismantle_wall(devastated = FALSE, explode = FALSE)
	if(resistance_flags & INDESTRUCTIBLE) //Hull is literally invincible
		return
	if(devastated || explode)
		make_girder(TRUE)
	else
		make_girder(FALSE)
	ScrapeAway()

/turf/closed/wall/ex_act(severity, explosion_direction)
	if(resistance_flags & INDESTRUCTIBLE)
		return
	take_damage(severity * EXPLOSION_DAMAGE_MULTIPLIER_WALL, BRUTE, BOMB)

/turf/closed/wall/get_explosion_resistance()
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return EXPLOSION_MAX_POWER
	return (max_integrity - (max_integrity - wall_integrity)) / EXPLOSION_DAMAGE_MULTIPLIER_WALL

/turf/closed/wall/plastique_act()
	ex_act(5000)

/turf/closed/wall/attack_animal(mob/living/M as mob)
	if(M.wall_smash)
		if((isrwallturf(src)) || (resistance_flags & INDESTRUCTIBLE))
			to_chat(M, span_warning("这个[name]对你来说太坚固了,无法摧毁."))
			return
		else
			if((prob(40)))
				M.visible_message(span_danger("[M]砸穿了[src]."),
				span_danger("你砸穿了墙壁."))
				dismantle_wall(1)
				return
			else
				M.visible_message(span_warning("[M]砸在[src]上."),
				span_warning("你砸在墙壁上."))
				take_damage(rand(25, 75))
				return

/turf/closed/wall/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(!ishuman(user))
		to_chat(user, span_warning("你没有足够的灵巧度来做这个!"))
		return

	else if(istype(I, /obj/item/frame/torch_frame))
		var/obj/item/frame/torch_frame/AH = I
		AH.try_build(src)

	else if(istype(I, /obj/item/frame/apc))
		var/obj/item/frame/apc/AH = I
		AH.try_build(src, user)

	else if(istype(I, /obj/item/frame/fire_alarm))
		var/obj/item/frame/fire_alarm/AH = I
		AH.try_build(src, user)

	else if(istype(I, /obj/item/frame/light_fixture))
		var/obj/item/frame/light_fixture/AH = I
		AH.try_build(src, user)

	else if(istype(I, /obj/item/frame/light_fixture/small))
		var/obj/item/frame/light_fixture/small/AH = I
		AH.try_build(src, user)

	else if(istype(I, /obj/item/frame/camera))
		var/obj/item/frame/camera/AH = I
		AH.try_build(src, user)

	//Poster stuff
	else if(istype(I, /obj/item/contraband/poster))
		place_poster(I, user)

	else if(resistance_flags & INDESTRUCTIBLE)
		to_chat(user, "[span_warning("[src] is much too tough for you to do anything to it with [I]")].")

	else if(istype(I, /obj/item/tool/pickaxe/plasmacutter) && !user.do_actions)
		return // the fuck does that even supposed to mean?
	else
		return attack_hand(user)

/turf/closed/wall/welder_act(mob/living/user, obj/item/tool/weldingtool/WT)
	. = ..()
	if(resistance_flags & INDESTRUCTIBLE)
		to_chat(user, span_warning("这面墙似乎太坚固了,你无法对它做什么!"))
		return
	if(!ishuman(user))
		to_chat(user, span_warning("你没有足够的灵巧度来做这个!"))
		return

	if(wall_integrity < max_integrity)
		if(!WT.remove_fuel(0, user))
			to_chat(user, span_warning("你需要更多焊接燃料来完成这个任务."))
			return

		user.visible_message(span_notice("[user]开始修复[src]的损伤."),
		span_notice("你开始修复[src]的损伤."))
		if(!WT.use_tool(src, user, 5 SECONDS, 1, 25, null, BUSY_ICON_FRIENDLY) || !iswallturf(src))
			return

		user.visible_message(span_notice("[user]完成了对[src]的损伤修复."),
		span_notice("你完成了对[src]的损伤修复."))
		repair_damage(250, user)
		return

	//DECONSTRUCTION
	switch(d_state)
		if(0)
			user.visible_message(span_notice("[user]开始切开外层装甲板."),
			span_notice("你开始切开外层装甲板."))
			if(!WT.use_tool(src, user, 6 SECONDS, 1, 25, null, BUSY_ICON_BUILD))
				return
			if(!iswallturf(src) || !WT?.isOn())
				return
			d_state = 1
			user.visible_message(span_notice("[user]切开了外层装甲板."),
			span_notice("你切开了外层装甲板."))

		if(2)
			user.visible_message(span_notice("[user]开始切开金属盖."),
			span_notice("你开始切开金属盖."))
			if(!WT.use_tool(src, user, 6 SECONDS, 1, 25, null, BUSY_ICON_BUILD))
				return
			if(!iswallturf(src) || !WT?.isOn())
				return
			d_state = 3
			user.visible_message(span_notice("[user]用力按压盖子,将其移开."),
			span_notice("你用力按压盖子,将其移开."))
		if(7)
			user.visible_message(span_notice("[user]开始切开最后一层."),
			span_notice("你开始切开最后一层."))
			if(!WT.use_tool(src, user, 6 SECONDS, 1, 25, null, BUSY_ICON_BUILD))
				return
			if(!iswallturf(src) || !WT?.isOn())
				return
			new /obj/item/stack/rods(src)
			user.visible_message(span_notice("当[user]切开最后一层时,支撑杆掉落了出来."),
			span_notice("当你切开最后一层时,支撑杆掉落了出来."))
			dismantle_wall()

/turf/closed/wall/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(resistance_flags & INDESTRUCTIBLE)
		to_chat(user, span_warning("这面墙似乎太坚固了,你无法对它做什么!"))
		return
	if(!ishuman(user))
		to_chat(user, span_warning("你没有足够的灵巧度来做这个!"))
		return
	if(d_state != 1)
		return
	user.visible_message(span_notice("[user]开始拆除支撑线."),
	span_notice("你开始拆除支撑线."))
	playsound(src, 'sound/items/screwdriver.ogg', 25, 1)

	if(!do_after(user, 6 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return

	if(!iswallturf(src))
		return

	d_state = 2
	user.visible_message(span_notice("[user]拆除了支撑线."),
	span_notice("你拆除了支撑线."))

/turf/closed/wall/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(resistance_flags & INDESTRUCTIBLE)
		to_chat(user, span_warning("这面墙似乎太坚固了,你无法对它做什么!"))
		return
	if(!ishuman(user))
		to_chat(user, span_warning("你没有足够的灵巧度来做这个!"))
		return
	switch(d_state)
		if(3)
			user.visible_message(span_notice("[user]费力地撬开盖子."),
			span_notice("你费力地撬开盖子."))
			playsound(src, 'sound/items/crowbar.ogg', 25, 1)

			if(!do_after(user, 6 SECONDS, NONE, src, BUSY_ICON_BUILD))
				return

			if(!iswallturf(src))
				return

			d_state = 4
			user.visible_message(span_notice("[user]撬开了盖子."),
			span_notice("你撬开了盖子."))
		if(6)
			user.visible_message(span_notice("[user]费力地撬开内护套."),
			span_notice("你费力地撬开内护套."))
			playsound(src, 'sound/items/crowbar.ogg', 25, 1)

			if(!do_after(user, 6 SECONDS, NONE, src, BUSY_ICON_BUILD))
				return

			if(!iswallturf(src))
				return

			d_state = 7
			user.visible_message(span_notice("[user]撬开了内护套."),
			span_notice("你撬开了内护套."))

/turf/closed/wall/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(resistance_flags & INDESTRUCTIBLE)
		to_chat(user, span_warning("这面墙似乎太坚固了,你无法对它做什么!"))
		return
	if(!ishuman(user))
		to_chat(user, span_warning("你没有足够的灵巧度来做这个!"))
		return
	if(d_state != 4)
		return
	user.visible_message(span_notice("[user]开始拧松固定支撑杆的锚栓."),
	span_notice("你开始拧松固定支撑杆的锚栓."))
	playsound(src, 'sound/items/ratchet.ogg', 25, 1)

	if(!do_after(user, 6 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return

	if(!iswallturf(src))
		return

	d_state = 5
	user.visible_message(span_notice("[user]拆下了固定支撑杆的螺栓."),
	span_notice("你拆下了固定支撑杆的螺栓."))

/turf/closed/wall/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	if(resistance_flags & INDESTRUCTIBLE)
		to_chat(user, span_warning("这面墙似乎太坚固了,你无法对它做什么!"))
		return
	if(!ishuman(user))
		to_chat(user, span_warning("你没有足够的灵巧来完成这个!"))
		return
	if(d_state != 5)
		return
	user.visible_message(span_notice("[user]开始松开液压管线."),
	span_notice("你开始松开液压管线."))
	playsound(src, 'sound/items/wirecutter.ogg', 25, 1)

	if(!do_after(user, 6 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return

	if(!iswallturf(src))
		return

	d_state = 6
	user.visible_message(span_notice("[user]完成了松开液压管线."),
	span_notice("你完成了松开液压管线."))

/turf/closed/wall/get_acid_delay()
	return 5 SECONDS

/turf/closed/wall/dissolvability(acid_strength)
	return 0.5

/turf/closed/wall/pre_crush_act(mob/living/carbon/xenomorph/charger, datum/action/ability/xeno_action/ready_charge/charge_datum)
	if((resistance_flags & (INDESTRUCTIBLE|CRUSHER_IMMUNE)) || charger.is_charging < CHARGE_ON)
		charge_datum.do_stop_momentum()
		return PRECRUSH_STOPPED
	. = (CHARGE_SPEED(charge_datum) * 400)
	charge_datum.speed_down(1)

/turf/closed/wall/grab_interact(obj/item/grab/grab, mob/user, base_damage = BASE_WALL_SLAM_DAMAGE, is_sharp = FALSE)
	if(!isliving(grab.grabbed_thing))
		return

	var/mob/living/grabbed_mob = grab.grabbed_thing
	step_towards(grabbed_mob, src)
	var/damage = (user.skills.getRating(SKILL_CQC) * CQC_SKILL_DAMAGE_MOD)
	var/state = user.grab_state
	switch(state)
		if(GRAB_PASSIVE)
			damage += base_damage
			grabbed_mob.visible_message(span_warning("[user]将[grabbed_mob]猛撞向[src]!"))
			log_combat(user, grabbed_mob, "slammed", "", "against [src]")
		if(GRAB_AGGRESSIVE)
			damage += base_damage * 1.5
			grabbed_mob.visible_message(span_danger("[user]将[grabbed_mob]猛击向[src]!"))
			log_combat(user, grabbed_mob, "bashed", "", "against [src]")
			if(prob(50))
				grabbed_mob.Paralyze(2 SECONDS)
				user.drop_held_item()
		if(GRAB_NECK)
			damage += base_damage * 2
			grabbed_mob.visible_message(span_danger("<big>[user]将[grabbed_mob]挤压向[src]!</big>"))
			log_combat(user, grabbed_mob, "crushed", "", "against [src]")
			grabbed_mob.Paralyze(2 SECONDS)
			user.drop_held_item()
	grabbed_mob.apply_damage(damage, blocked = MELEE, updating_health = TRUE)
	take_damage(damage, BRUTE, MELEE)
	playsound(src, get_sfx("slam"), 40)
	return TRUE

/turf/closed/wall/get_dumping_location()
	return null
