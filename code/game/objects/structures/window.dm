/obj/structure/window
	name = "窗户"
	desc = "一扇玻璃窗.它看起来又薄又脆.随便敲几下应该就能打碎它."
	icon = 'icons/obj/structures/windows.dmi'
	icon_state = "window"
	hit_sound = 'sound/effects/Glasshit.ogg'
	density = TRUE
	anchored = TRUE
	layer = ABOVE_WINDOW_LAYER
	obj_flags = CAN_BE_HIT | BLOCKS_CONSTRUCTION_DIR | IGNORE_DENSITY
	atom_flags = ON_BORDER|DIRLOCK
	allow_pass_flags = PASS_GLASS
	resistance_flags = XENO_DAMAGEABLE | DROPSHIP_IMMUNE
	coverage = 20
	max_integrity = 15
	/// If we're dismantling the window properly no smashy smashy
	var/dismantle = FALSE
	///Optimization for dynamic explosion block values, for things whose explosion block is dependent on certain conditions.
	var/real_explosion_block = 0
	var/state = 2
	var/reinf = FALSE
	var/basestate = "window"
	var/shardtype = /obj/item/shard
	var/windowknock_cooldown = 0
	/// If true, can't move the window
	var/static_frame = FALSE
	/// Because everything is terrible, I'm making this a window-level var
	var/junction = 0
	var/damageable = TRUE
	var/deconstructable = TRUE

/obj/structure/window/ex_act(severity, direction)
	take_damage(severity * EXPLOSION_DAMAGE_MULTIPLIER_WINDOW, BRUTE, BOMB, attack_dir = direction)

/obj/structure/window/on_explosion_destruction(severity, direction)
	if(severity < 2000)
		return

	playsound(src, "windowshatter", 50, 1)
	create_shrapnel(loc, rand(1, 5), direction, shrapnel_type = /datum/ammo/bullet/shrapnel/light/glass)

/obj/structure/window/get_explosion_resistance(direction)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return EXPLOSION_MAX_POWER

	if(atom_flags & ON_BORDER && (direction == turn(dir, 90) || direction == turn(dir, -90)))
		return 0
	return obj_integrity / EXPLOSION_DAMAGE_MULTIPLIER_WINDOW

/obj/structure/window/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_GLASS, -40, 5)

//I hate this as much as you do
/obj/structure/window/full
	dir = 10
	atom_flags = DIRLOCK

/obj/structure/window/Initialize(mapload, start_dir, constructed)
	. = ..()

	//player-constructed windows
	if(constructed)
		anchored = FALSE
		state = 0

	if(start_dir)
		setDir(start_dir)

	var/static/list/connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_try_exit)
	)
	AddElement(/datum/element/connect_loc, connections)

	return INITIALIZE_HINT_LATELOAD

/obj/structure/window/LateInitialize()
	. = ..()
	update_nearby_icons()

/obj/structure/window/Destroy()
	density = FALSE
	update_nearby_icons()
	return ..()

/obj/structure/window/hitby(atom/movable/AM, speed = 5)
	var/throw_damage = speed
	var/mob/living/thrown_mob
	if(isobj(AM))
		var/obj/thrown_obj = AM
		throw_damage = thrown_obj.throwforce
	else if(isliving(AM))
		thrown_mob = AM
		throw_damage *= thrown_mob.mob_size * 8
	take_damage(throw_damage)
	AM.stop_throw()
	. = TRUE
	if(thrown_mob)
		thrown_mob.take_overall_damage(speed * 5, BRUTE, MELEE, !., FALSE, TRUE, 0, 4) //done here for dramatic effect, and to make the damage sharp if we broke the window
	return TRUE

//TODO: Make full windows a separate type of window.
//Once a full window, it will always be a full window, so there's no point
//having the same type for both.
/obj/structure/window/proc/is_full_window()
	if(!(atom_flags & ON_BORDER) || ISDIAGONALDIR(dir))
		return TRUE
	return FALSE

/obj/structure/window/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_HARM)

		if(istype(user,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = user
			if(H.species.can_shred(H))
				attack_generic(H, 25)
				return

		if(windowknock_cooldown > world.time)
			return
		playsound(loc, 'sound/effects/glassknock.ogg', 25, 1)
		user.visible_message(span_warning("[user]猛撞[src]!"),
		span_warning("你猛撞[src]!"),
		span_warning("你听到一声猛撞声."))
		windowknock_cooldown = world.time + 100
	else
		if(windowknock_cooldown > world.time)
			return
		playsound(loc, 'sound/effects/glassknock.ogg', 15, 1)
		user.visible_message(span_notice("[user]敲击[src]."),
		span_notice("你敲击[src]."),
		span_notice("你听到一声敲击声."))
		windowknock_cooldown = world.time + 100

/obj/structure/window/grab_interact(obj/item/grab/grab, mob/user, base_damage = BASE_OBJ_SLAM_DAMAGE, is_sharp = FALSE)
	if(!isliving(grab.grabbed_thing))
		return

	var/mob/living/grabbed_mob = grab.grabbed_thing
	var/state = user.grab_state
	user.drop_held_item()
	step_towards(grabbed_mob, src)
	var/damage = (user.skills.getRating(SKILL_CQC) * CQC_SKILL_DAMAGE_MOD)
	switch(state)
		if(GRAB_PASSIVE)
			damage += base_damage
			grabbed_mob.visible_message(span_warning("[user]将[grabbed_mob]猛摔向\the [src]!"))
			log_combat(user, grabbed_mob, "slammed", "", "against \the [src]")
		if(GRAB_AGGRESSIVE)
			damage += base_damage * 1.5
			grabbed_mob.visible_message(span_danger("[user]将[grabbed_mob]猛击向\the [src]!"))
			log_combat(user, grabbed_mob, "bashed", "", "against \the [src]")
			if(prob(50))
				grabbed_mob.Paralyze(2 SECONDS)
		if(GRAB_NECK)
			damage += base_damage * 2
			grabbed_mob.visible_message(span_danger("<big>[user]将[grabbed_mob]碾碎在\the [src]上!</big>"))
			log_combat(user, grabbed_mob, "crushed", "", "against \the [src]")
			grabbed_mob.Paralyze(2 SECONDS)
	grabbed_mob.apply_damage(damage, blocked = MELEE, updating_health = TRUE)
	take_damage(damage * 2, BRUTE, MELEE)
	return TRUE

/obj/structure/window/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(!deconstructable)
		return
	dismantle = TRUE
	if(reinf && state >= 1)
		state = 3 - state
		playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
		to_chat(user, (state == 1 ? span_notice("你已经将窗户从框架上松开.") : span_notice("你已经将窗户固定到框架上.")))
	else if(reinf && state == 0 && !static_frame)
		anchored = !anchored
		update_nearby_icons()
		playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
		to_chat(user, (anchored ? span_notice("你已经将框架固定到地板上.") : span_notice("你已经将框架从地板上松开.")))
	else if(!reinf && !static_frame)
		anchored = !anchored
		update_nearby_icons()
		playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
		to_chat(user, (anchored ? span_notice("你已经将窗户固定到地板上.") : span_notice("你已经将窗户松开.")))
	else if(!reinf || (static_frame && state == 0))
		deconstruct(TRUE)

/obj/structure/window/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(!reinf)
		return
	if(state > 1)
		return
	if(!deconstructable)
		return
	dismantle = TRUE
	state = 1 - state
	playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
	to_chat(user, (state ? span_notice("你已经将窗户撬入框架中.") : span_notice("你已经将窗户从框架中撬出.")))

/obj/structure/window/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(disassembled)
		if(reinf)
			new /obj/item/stack/sheet/glass/reinforced(loc, 2)
		else
			new /obj/item/stack/sheet/glass/glass(loc, 2)
	else
		new shardtype(loc)
		if(is_full_window())
			new shardtype(loc)
		if(reinf)
			new /obj/item/stack/rods(loc)
	return ..()

/obj/structure/window/verb/rotate()
	set name = "Rotate Window Counter-Clockwise"
	set category = "IC.Rotate"
	set src in oview(1)

	if(static_frame)
		return FALSE
	if(!deconstructable)
		return FALSE
	if(anchored)
		to_chat(usr, span_warning("它被固定在地板上,你无法旋转它!"))
		return FALSE

	setDir(turn(dir, 90))

/obj/structure/window/verb/revrotate()
	set name = "Rotate Window Clockwise"
	set category = "IC.Rotate"
	set src in oview(1)

	if(static_frame)
		return FALSE
	if(!deconstructable)
		return FALSE
	if(anchored)
		to_chat(usr, span_warning("它被固定在地板上,你无法旋转它!"))
		return FALSE

	setDir(turn(dir, 270))

//This proc is used to update the icons of nearby windows.
/obj/structure/window/proc/update_nearby_icons()
	update_icon()
	for(var/direction in GLOB.cardinals)
		for(var/obj/structure/window/W in get_step(src, direction))
			INVOKE_NEXT_TICK(W, TYPE_PROC_REF(/atom/movable, update_icon))

//merges adjacent full-tile windows into one (blatant ripoff from game/smoothwall.dm)
/obj/structure/window/update_icon_state()
	. = ..()
	if(!src)
		return
	if(!is_full_window())
		icon_state = "[basestate]"
		return
	if(anchored)
		for(var/obj/structure/window/W in orange(src, 1))
			if(W.anchored && W.density	&& W.is_full_window()) //Only counts anchored, not-destroyed fill-tile windows.
				if(abs(x - W.x) - abs(y - W.y)) //Doesn't count windows, placed diagonally to src
					junction |= get_dir(src, W)
	if(opacity)
		icon_state = "[basestate][junction]"
	else
		if(reinf)
			icon_state = "[basestate][junction]"
		else
			icon_state = "[basestate][junction]"

/obj/structure/window/fire_act(burn_level, flame_color)
	if(burn_level > 25)
		take_damage(burn_level, BURN, FIRE)

/obj/structure/window/GetExplosionBlock(explosion_dir)
	return (!explosion_dir || ISDIAGONALDIR(dir) || dir & explosion_dir || REVERSE_DIR(dir) & explosion_dir) ? real_explosion_block : 0

/obj/structure/window/effect_smoke(obj/effect/particle_effect/smoke/S)
	. = ..()
	if(CHECK_BITFIELD(S.smoke_traits, SMOKE_XENO_ACID))
		take_damage(1 * S.strength, BURN, ACID) // glass doesn't care about acid

/obj/structure/window/get_dumping_location()
	return null

/obj/structure/window/phoronbasic
	name = "磷光窗户"
	desc = "一扇磷光玻璃合金窗.它看起来极其坚固,难以打破.似乎也极其难以烧穿."
	basestate = "phoronwindow"
	icon_state = "phoronwindow"
	shardtype = /obj/item/shard/phoron
	max_integrity = 120
	explosion_block = EXPLOSION_BLOCK_PROC
	real_explosion_block = 2

/obj/structure/window/phoronbasic/fire_act(burn_level, flame_color)
	if(burn_level > 30)
		take_damage(burn_level * 0.5, BURN, FIRE)

/obj/structure/window/phoronreinforced
	name = "强化福龙窗"
	desc = "一扇带有棒状矩阵的福龙玻璃合金窗. 它看起来坚不可摧. 考虑到普通福龙窗本身就极其防火, 它看起来也完全防火."
	basestate = "phoronrwindow"
	icon_state = "phoronrwindow"
	shardtype = /obj/item/shard/phoron
	reinf = TRUE
	max_integrity = 160
	explosion_block = EXPLOSION_BLOCK_PROC
	real_explosion_block = 4

/obj/structure/window/phoronreinforced/fire_act(burn_level, flame_color)
	return

/obj/structure/window/reinforced
	name = "强化窗"
	desc = "一扇带有棒状矩阵的玻璃窗. 它看起来相当坚固. 可能需要几下重击才能打碎."
	icon_state = "rwindow"
	basestate = "rwindow"
	max_integrity = 40
	reinf = TRUE
	explosion_block = EXPLOSION_BLOCK_PROC
	real_explosion_block = 2
	layer = ABOVE_MOB_LAYER
	///are we tinted or not
	var/tinted = FALSE

/obj/structure/window/reinforced/north
	dir = NORTH

/obj/structure/window/reinforced/west
	dir = WEST

/obj/structure/window/reinforced/east
	dir = EAST

/obj/structure/window/reinforced/Initialize(mapload)
	. = ..()
	if(dir == NORTH)
		add_overlay(image(icon, "rwindow_overlay", layer = ABOVE_WINDOW_LAYER))
		layer = TABLE_LAYER
	if(dir == WEST || dir == EAST)
		var/turf/adj = get_step(src, SOUTH)
		if(isclosedturf(adj))
			return
		if(locate(/obj/structure) in adj)
			return
		if(locate(/obj/machinery) in adj)
			return
		if(tinted)
			add_overlay(image(icon, "twindowstake", layer = ABOVE_ALL_MOB_LAYER))
			return
		add_overlay(image(icon, "windowstake", layer = ABOVE_ALL_MOB_LAYER))

/obj/structure/window/reinforced/windowstake/Initialize(mapload)
	. = ..()
	add_overlay(image(icon, "windowstake", layer = ABOVE_ALL_MOB_LAYER))

/obj/structure/window/reinforced/toughened
	name = "安全玻璃"
	desc = "一扇看起来非常坚固的玻璃窗, 带有特殊的棒状矩阵, 可能是防弹的."
	icon_state = "rwindow"
	basestate = "rwindow"
	max_integrity = 300
	reinf = TRUE

//For the sulaco and POS AI core.
/obj/structure/window/reinforced/extratoughened
	name = "防护型AI玻璃"
	desc = "带有许多层棒状矩阵的重度强化玻璃. 除了最重要的窗户之外, 很少用于其他用途"
	icon_state = "rwindow"
	basestate = "rwindow"
	max_integrity = 1500
	reinf = TRUE
	resistance_flags = UNACIDABLE|XENO_DAMAGEABLE

/obj/structure/window/reinforced/tinted
	name = "有色窗"
	desc = "一扇带有棒状矩阵的玻璃窗. 它看起来相当坚固且不透明. 可能需要几下重击才能打碎."
	icon_state = "twindow"
	basestate = "twindow"
	opacity = TRUE
	tinted = TRUE

/obj/structure/window/reinforced/tinted/frosted
	name = "磨砂窗"
	desc = "一扇带有棒状矩阵的玻璃窗. 它看起来相当坚固且结了霜. 看起来可能比普通强化窗少挨几下就会碎."
	icon_state = "fwindow"
	basestate = "fwindow"
	max_integrity = 30

/obj/structure/window/shuttle
	name = "穿梭机窗"
	desc = "一扇带有棒状矩阵的穿梭机玻璃窗, 专为耐热而设计. 它看起来相当坚固. 可能需要几下重击才能打碎."
	icon = 'icons/obj/podwindows.dmi'
	icon_state = "window"
	basestate = "window"
	max_integrity = 40
	reinf = TRUE
	atom_flags = NONE

/obj/structure/window/shuttle/update_icon_state()
	return

//Framed windows

/obj/structure/window/framed
	name = "理论窗"
	layer = TABLE_LAYER
	plane = WALL_PLANE
	static_frame = TRUE
	atom_flags = NONE //This is not a border object; it takes up the entire tile.
	explosion_block = 2
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(
		SMOOTH_GROUP_WINDOW_FULLTILE,
		SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS,
	)
	canSmoothWith = list(
		SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS,
		SMOOTH_GROUP_WINDOW_FULLTILE,
		SMOOTH_GROUP_AIRLOCK,
		SMOOTH_GROUP_WINDOW_FRAME,
		SMOOTH_GROUP_ESCAPESHUTTLE,
	)
	///For perspective windows,so the window frame doesn't magically disappear.
	var/window_frame

/obj/structure/window/framed/update_nearby_icons()
	QUEUE_SMOOTH_NEIGHBORS(src)

/obj/structure/window/framed/update_icon_state()
	QUEUE_SMOOTH(src) //we update icon state through the smoothing system exclusively

/obj/structure/window/framed/deconstruct(disassembled = TRUE, leave_frame = TRUE)
	if(window_frame && leave_frame)
		var/obj/structure/window_frame/WF = new window_frame(loc, TRUE)
		WF.icon_state = "[WF.basestate][junction]_frame"
		WF.setDir(dir)
	return ..()

/obj/structure/window/framed/crushed_special_behavior()
	if(window_frame)
		return STOP_CRUSHER_ON_DEL
	else
		return ..()

/obj/structure/window/framed/mainship
	name = "强化窗"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 它看起来相当坚固. 可能需要几下重击才能打碎."
	icon = 'icons/obj/smooth_objects/ship_window.dmi'
	icon_state = "ship_window-0"
	basestate = "ship_window"
	base_icon_state = "ship_window"
	max_integrity = 100 //Was 600
	reinf = TRUE
	dir = 5
	window_frame = /obj/structure/window_frame/mainship

/obj/structure/window/framed/mainship/talos
	icon = 'icons/obj/smooth_objects/alt_ship_window.dmi'
	icon_state = "alt_ship_window-0"
	base_icon_state = "alt_ship_window"
	window_frame = /obj/structure/window_frame/mainship/talos

/obj/structure/window/framed/mainship/canterbury //So we can wallsmooth properly.

/obj/structure/window/framed/mainship/escapeshuttle
	smoothing_groups = list(SMOOTH_GROUP_ESCAPESHUTTLE)
	canSmoothWith = list(
		SMOOTH_GROUP_ESCAPESHUTTLE,
		SMOOTH_GROUP_WINDOW_FULLTILE,
	)

/obj/structure/window/framed/mainship/escapeshuttle/prison
	resistance_flags = RESIST_ALL
	icon_state = "window-invincible"

/obj/structure/window/framed/mainship/toughened
	name = "安全玻璃"
	desc = "一扇看起来非常坚固的玻璃窗, 带有特殊的棒状矩阵, 可能是防弹的."
	max_integrity = 300

/obj/structure/window/framed/mainship/spaceworthy
	name = "驾驶舱窗"
	desc = "一扇看起来非常坚固的玻璃窗, 带有特殊的棒状矩阵, 为适应太空环境而制造."
	max_integrity = 500
	icon_state = "ship_window-0"
	basestate = "ship_window"

/obj/structure/window/framed/mainship/spaceworthy/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/windowshutter/cokpitshutters)

/obj/structure/window/framed/mainship/hull
	name = "船体窗"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 这一扇由特殊材料制成, 以防止船体破裂. 无法从这里通过."
	icon_state = "ship_window_invincible"
	damageable = FALSE
	deconstructable = FALSE
	resistance_flags = RESIST_ALL
	max_integrity = 1000000 //Failsafe, shouldn't matter

/obj/structure/window/framed/mainship/hull/canterbury //So we can wallsmooth properly.
	smoothing_groups = list(SMOOTH_GROUP_CANTERBURY)
	canSmoothWith = list(
		SMOOTH_GROUP_AIRLOCK,
		SMOOTH_GROUP_WINDOW_FRAME,
		SMOOTH_GROUP_WINDOW_FULLTILE,
		SMOOTH_GROUP_SHUTTERS,
		SMOOTH_GROUP_CANTERBURY,
	)

/obj/structure/window/framed/mainship/requisitions
	name = "凯夫拉编织防弹窗"
	desc = "一扇注入了凯夫拉纤维并安装在特殊减震框架内的硼硅酸盐玻璃窗, 这会非常难以打破."
	max_integrity = 1000
	deconstructable = FALSE

/obj/structure/window/framed/mainship/white
	icon = 'icons/obj/smooth_objects/wwindow.dmi'
	icon_state = "white_rwindow-0"
	base_icon_state = "white_rwindow"
	window_frame = /obj/structure/window_frame/mainship/white

/obj/structure/window/framed/mainship/white/canterbury //So we can wallsmooth properly.
	smoothing_groups = list(SMOOTH_GROUP_CANTERBURY)
	canSmoothWith = list(
		SMOOTH_GROUP_CANTERBURY,
		SMOOTH_GROUP_AIRLOCK,
	)

/obj/structure/window/framed/mainship/gray
	icon = 'icons/obj/smooth_objects/ship_gray_window.dmi'
	icon_state = "ship_gray_window-0"
	basestate = "ship_gray_window"
	base_icon_state = "ship_gray_window"
	window_frame = /obj/structure/window_frame/mainship/gray
	reinf = FALSE
	smoothing_groups = list(SMOOTH_GROUP_WINDOW_FULLTILE)
	canSmoothWith = list(
		SMOOTH_GROUP_WINDOW_FULLTILE,
		SMOOTH_GROUP_AIRLOCK,
		SMOOTH_GROUP_WINDOW_FRAME,
		SMOOTH_GROUP_ESCAPESHUTTLE,
		SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS,
	)

/obj/structure/window/framed/mainship/gray/toughened
	name = "安全玻璃"
	desc = "一扇看起来非常坚固的玻璃窗, 带有特殊的棒状矩阵, 可能是防弹的."
	max_integrity = 300
	reinf = TRUE
	icon_state = "window-reinforced"
	basestate = "ship_gray_window"

/obj/structure/window/framed/mainship/gray/toughened/hull
	name = "船体窗"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 这一扇由特殊材料制成, 以防止船体破裂. 无法从这里通过."
	damageable = FALSE
	deconstructable = FALSE
	resistance_flags = RESIST_ALL
	icon_state = "window-invincible"

/obj/structure/window/framed/mainship/gray/toughened/hull/talos
	icon = 'icons/obj/smooth_objects/alt_ship_rwindow.dmi'
	icon_state = "alt_ship_rwindow-0"
	base_icon_state = "alt_ship_rwindow"

/obj/structure/window/framed/mainship/white/toughened/hull
	name = "船体窗"
	icon_state = "window-invincible"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 这一扇由特殊材料制成, 以防止船体破裂. 无法从这里通过."
	damageable = FALSE
	deconstructable = FALSE
	resistance_flags = RESIST_ALL

/obj/structure/window/framed/colony
	name = "窗"
	icon = 'icons/obj/smooth_objects/col_window.dmi'
	icon_state = "col_window0"
	base_icon_state = "col_window"
	window_frame = /obj/structure/window_frame/colony

/obj/structure/window/framed/colony/reinforced
	name = "强化窗"
	icon = 'icons/obj/smooth_objects/col_rwindow.dmi'
	icon_state = "window-reinforced"
	base_icon_state = "col_rwindow"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 它看起来相当坚固. 可能需要几下重击才能打碎."
	max_integrity = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/colony/reinforced

/obj/structure/window/framed/colony/reinforced/tinted
	name = "有色强化窗"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 它看起来相当坚固. 可能需要几下重击才能打碎. 这一扇是不透明的. 你有一种不安的感觉, 可能有人正在另一侧看着."
	opacity = TRUE

/obj/structure/window/framed/colony/reinforced/hull
	name = "船体窗"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 这一扇由特殊材料制成, 以防止船体破裂. 无法从这里通过."
	//icon_state = "rwindow0_debug" //Uncomment to check hull in the map editor
	damageable = FALSE
	deconstructable = FALSE
	resistance_flags = RESIST_ALL
	max_integrity = 1000000 //Failsafe, shouldn't matter
	icon_state = "window-invincible"

//Chigusa windows

/obj/structure/window/framed/chigusa
	name = "强化窗"
	icon = 'icons/obj/smooth_objects/chigusa_window.dmi'
	icon_state = "window-reinforced"
	basestate = "chigusa_wall"
	base_icon_state = "chigusa_wall"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 它看起来相当坚固. 可能需要几下重击才能打碎."
	max_integrity = 100
	reinf = TRUE
	window_frame = /obj/structure/window_frame/chigusa

/obj/structure/window/framed/wood
	name = "窗"
	icon = 'icons/obj/smooth_objects/wood_regular.dmi'
	icon_state = "wood_regular-0"
	basestate = "wood_regular"
	base_icon_state = "wood_regular"
	window_frame = /obj/structure/window_frame/wood

/obj/structure/window/framed/wood/reinforced
	name = "强化窗"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 它看起来相当坚固. 可能需要几下重击才能打碎."
	max_integrity = 100
	reinf = TRUE
	icon = 'icons/obj/smooth_objects/wood_reinforced.dmi'
	icon_state = "wood_reinforced-0"
	basestate = "wood_reinforced"
	base_icon_state = "wood_reinforced"
	window_frame = /obj/structure/window_frame/wood

//Prison windows

/obj/structure/window/framed/prison
	name = "窗"
	icon = 'icons/obj/smooth_objects/wood_reinforced.dmi'
	icon_state = "wood_reinforced-0"
	basestate = "wood_reinforced"
	base_icon_state = "wood_reinforced"
	window_frame = /obj/structure/window_frame/prison

/obj/structure/window/framed/prison/reinforced
	name = "强化窗"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 它看起来相当坚固. 可能需要几下重击才能打碎."
	max_integrity = 100
	reinf = TRUE
	icon = 'icons/obj/smooth_objects/prison_rwindow.dmi'
	icon_state = "window-reinforced"
	base_icon_state = "prison_rwindow"
	basestate = "prison_rwindow"
	window_frame = /obj/structure/window_frame/prison/reinforced

/obj/structure/window/framed/prison/reinforced/hull
	name = "船体窗"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 这一扇带有自动百叶窗系统, 以防止任何大气泄漏."
	max_integrity = 200
	//icon_state = "rwindow0_debug" //Uncomment to check hull in the map editor
	icon_state = "window-invincible"

/obj/structure/window/framed/prison/reinforced/hull/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/windowshutter)

/obj/structure/window/framed/prison/reinforced/nonshutter_hull
	name = "船体窗"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 这一扇由特殊材料制成, 以防止船体破裂. 无法从这里通过."
	damageable = FALSE
	deconstructable = FALSE
	resistance_flags = RESIST_ALL

// dont even ask
/obj/structure/window/framed/prison/reinforced/hull/tyson
	icon_state = "col_window0"
	basestate = "col_window"
	window_frame = /obj/structure/window_frame/colony

// no really
/obj/structure/window/framed/prison/reinforced/hull/tyson/reinforced
	icon_state = "col_rwindow0"
	basestate = "col_rwindow"
	window_frame = /obj/structure/window_frame/colony/reinforced

/obj/structure/window/framed/prison/cell
	name = "牢房窗"
	icon = 'icons/obj/smooth_objects/cell_rwindow.dmi'
	icon_state = "prison_rwindow-0"
	base_icon_state = "prison_rwindow"
	basestate = "prison_rwindow"
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 没有可触及的螺丝, 以防止有进取心的囚犯将其拆解."
	//icon_state = "rwindow0_debug" //Uncomment to check hull in the map editor
	deconstructable = FALSE
	max_integrity = 300

/obj/structure/window/framed/mainship/canterbury/dropship
	name = "轨道插入安全窗"
	desc = "一扇带有强化棒状矩阵并嵌在墙框内的玻璃窗, 强度是普通窗的3倍, 以适应太空环境."
	max_integrity = 300 // 13 hunter slashes
	smoothing_groups = list(SMOOTH_GROUP_CANTERBURY)
	canSmoothWith = list(
		SMOOTH_GROUP_AIRLOCK,
		SMOOTH_GROUP_WINDOW_FRAME,
		SMOOTH_GROUP_WINDOW_FULLTILE,
		SMOOTH_GROUP_SHUTTERS,
		SMOOTH_GROUP_CANTERBURY,
	)
	window_frame = /obj/structure/window_frame/mainship/dropship

/obj/structure/window/framed/mainship/canterbury/dropship/reinforced
	name = "强化轨道插入安全窗"
	desc = "一扇带有专门强化棒状矩阵并嵌在墙框内的耐用玻璃窗, 强度是普通窗的6倍, 以适应太空环境并承受冲击."
	max_integrity = 600 // 25 hunter slashes

/obj/structure/window/framed/kutjevo
	name = "窗"
	icon = 'icons/obj/smooth_objects/kutjevo_window_blue.dmi'
	icon_state = "chigusa_wall-0"
	base_icon_state = "chigusa_wall"
	window_frame = /obj/structure/window_frame/kutjevo

/obj/structure/window/framed/kutjevo/orange
	icon = 'icons/obj/smooth_objects/kutjevo_window_orange.dmi'

/obj/structure/window/framed/kutjevo/reinforced
	name = "强化窗"
	icon = 'icons/obj/smooth_objects/kutjevo_window_blue_reinforced.dmi'
	icon_state = "window-reinforced"
	max_integrity = 100
	reinf = TRUE
	window_frame = /obj/structure/window_frame/kutjevo/reinforced

/obj/structure/window/framed/kutjevo/reinforced/orange
	icon = 'icons/obj/smooth_objects/kutjevo_window_orange_reinforced.dmi'

/obj/structure/window/framed/kutjevo/reinforced/hull
	name = "船体窗"
	icon = 'icons/obj/smooth_objects/kutjevo_window_orange_reinforced.dmi'
	desc = "一扇带有特殊棒状矩阵并嵌在墙框内的玻璃窗. 这一扇由特殊材料制成, 以防止船体破裂. 无法从这里通过."
	icon_state = "window-invincible"
	resistance_flags = RESIST_ALL

//pred
/obj/structure/window/framed/colony/reinforced/hull/pred
	basestate = "pred_window"
	icon_state = "pred_window-0"
	icon = 'icons/obj/smooth_objects/pred_window.dmi'
	base_icon_state = "pred_window"

/obj/structure/window/phoronreinforced/pred
	icon_state = "phoronrwindow"
	resistance_flags = INDESTRUCTIBLE
