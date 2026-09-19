/obj/item/explosive/grenade/sticky
	name = "\improper M40粘性炸药榴弹"
	desc = "为对抗各种高速移动的无人机而设计，这种榴弹会在引爆前粘附到目标上。其引信被设定为5秒。"
	icon_state = "grenade_sticky"
	worn_icon_state = "grenade_sticky"
	det_time = 5 SECONDS
	icon_state_mini = "grenade_sticky"
	power = 90
	falloff = 40
	overlay_type = "yellow"
	///Current atom this grenade is attached to, used to remove the overlay.
	var/atom/stuck_to
	///Current image overlay applied to stuck_to, used to remove the overlay after detonation.
	var/image/saved_overlay
	///if this specific grenade should be allowed to self sticky
	var/self_sticky = FALSE

/obj/item/explosive/grenade/sticky/throw_impact(atom/hit_atom, speed)
	. = ..()
	if(!.)
		return
	if(!active || stuck_to || isturf(hit_atom))
		return
	stuck_to(hit_atom)

/obj/item/explosive/grenade/sticky/afterattack(atom/target, mob/user, has_proximity, click_parameters)
	. = ..()
	if(target != user)
		return
	if(!self_sticky)
		return
	user.drop_held_item()
	activate()
	stuck_to(target)

/obj/item/explosive/grenade/sticky/prime()
	if(stuck_to)
		clean_refs()
	return ..()

/obj/item/explosive/grenade/sticky/launched_det_time()
	det_time -= 1 SECONDS

///Cleans references to prevent hard deletes.
/obj/item/explosive/grenade/sticky/proc/clean_refs()
	SIGNAL_HANDLER
	stuck_to.cut_overlay(saved_overlay)
	UnregisterSignal(stuck_to, COMSIG_QDELETING)
	stuck_to = null
	saved_overlay = null

///handles sticky overlay and attaching the grenade itself to the target
/obj/item/explosive/grenade/sticky/proc/stuck_to(atom/hit_atom)
	var/image/stuck_overlay = image(icon, hit_atom, initial(icon_state) + "_stuck")
	stuck_overlay.pixel_x = rand(-5, 5)
	stuck_overlay.pixel_y = rand(-7, 7)
	hit_atom.add_overlay(stuck_overlay)
	forceMove(hit_atom)
	saved_overlay = stuck_overlay
	stuck_to = hit_atom
	RegisterSignal(stuck_to, COMSIG_QDELETING, PROC_REF(clean_refs))

/obj/item/explosive/grenade/sticky/trailblazer
	name = "\improper M45开拓者榴弹"
	desc = "基于胶囊的榴弹，会粘附在足够坚硬的表面上，形成一条空气可燃凝胶的轨迹。它被设定为5秒后引爆。"
	icon_state = "grenade_sticky_fire"
	worn_icon_state = "grenade_sticky_fire"
	det_time = 5 SECONDS
	self_sticky = TRUE
	icon_state_mini = "grenade_trailblazer"
	overlay_type = "orange"
	var/fire_level = 25
	var/burn_level = 25
	var/fire_color = "red"
	var/our_fire_stacks = 0
	var/our_fire_damage = 0

/obj/item/explosive/grenade/sticky/trailblazer/prime()
	flame_radius(0.5, get_turf(src))
	playsound(loc, SFX_INCENDIARY_EXPLOSION, 35)
	if(stuck_to)
		clean_refs()
	qdel(src)

/obj/item/explosive/grenade/sticky/trailblazer/stuck_to(atom/hit_atom)
	. = ..()
	RegisterSignal(stuck_to, COMSIG_MOVABLE_MOVED, PROC_REF(make_fire))
	var/turf/T = get_turf(src)
	T.ignite(fire_level, burn_level, fire_color, our_fire_stacks, our_fire_damage)

///causes fire tiles underneath target when stuck_to
/obj/item/explosive/grenade/sticky/trailblazer/proc/make_fire(datum/source, old_loc, movement_dir, forced, old_locs)
	SIGNAL_HANDLER
	var/turf/T = get_turf(src)
	T.ignite(fire_level, burn_level, fire_color, our_fire_stacks, our_fire_damage)

/obj/item/explosive/grenade/sticky/trailblazer/clean_refs()
	stuck_to.cut_overlay(saved_overlay)
	UnregisterSignal(stuck_to, COMSIG_MOVABLE_MOVED)
	return ..()

/obj/item/explosive/grenade/sticky/trailblazer/phosphorus
	name = "\improper M45磷光开拓者榴弹"
	desc = "基于胶囊的榴弹,会粘附在足够坚硬的表面上,形成一条空气可燃凝胶的轨迹.但装的是白磷.设定为5秒后引爆."
	icon_state = "grenade_sticky_phosphorus"
	worn_icon_state = "grenade_sticky_phosphorus"
	icon_state_mini = "grenade_trailblazer_phosphorus"
	fire_level = 45
	burn_level = 45
	fire_color = "blue"
	overlay_type = "blue"

/obj/item/explosive/grenade/sticky/trailblazer/phosphorus/activate(mob/user)
	. = ..()
	if(!.)
		return FALSE
	user?.record_war_crime()

/obj/item/explosive/grenade/sticky/trailblazer/phosphorus/prime()
	flame_radius(0.5, get_turf(src), colour = "blue")
	playsound(loc, SFX_INCENDIARY_EXPLOSION, 35)
	if(stuck_to)
		clean_refs()
	qdel(src)

/obj/item/explosive/grenade/sticky/cloaker
	name = "\improper M45 隐蔽榴弹"
	desc = "基于胶囊的榴弹,会粘附在足够坚硬的表面上,形成一条空气可燃凝胶的轨迹.这一枚会生成隐蔽烟雾!设定为5秒后引爆."
	icon_state = "grenade_sticky_cloak"
	worn_icon_state = "grenade_sticky_cloak"
	det_time = 5 SECONDS
	self_sticky = TRUE
	overlay_type = "green"
	/// smoke type created when the grenade is primed
	var/datum/effect_system/smoke_spread/smoketype = /datum/effect_system/smoke_spread/tactical
	///radius this smoke grenade will encompass
	var/smokeradius = 1
	///The duration of the smoke
	var/smoke_duration = 8

/obj/item/explosive/grenade/sticky/cloaker/prime()
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	playsound(loc, 'sound/effects/smoke_bomb.ogg', 35)
	smoke.set_up(smokeradius, loc, smoke_duration)
	smoke.start()
	if(stuck_to)
		clean_refs()
	qdel(src)

/obj/item/explosive/grenade/sticky/cloaker/stuck_to(atom/hit_atom)
	. = ..()
	RegisterSignal(stuck_to, COMSIG_MOVABLE_MOVED, PROC_REF(make_smoke))

///causes fire tiles underneath target when stuck_to
/obj/item/explosive/grenade/sticky/cloaker/proc/make_smoke(datum/source, old_loc, movement_dir, forced, old_locs)
	SIGNAL_HANDLER
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	smoke.set_up(smokeradius, loc, smoke_duration)
	smoke.start()

/obj/item/explosive/grenade/sticky/cloaker/clean_refs()
	stuck_to.cut_overlay(saved_overlay)
	UnregisterSignal(stuck_to, COMSIG_MOVABLE_MOVED)
	return ..()

/obj/item/explosive/grenade/sticky/cloaker/tangle
	name = "\improper M45-T 缠绕榴弹"
	desc = "基于胶囊的榴弹,会粘附在足够坚硬的表面上,形成一条空气可燃凝胶的轨迹.这一枚会生成缠绕烟雾!设定为5秒后引爆."
	icon_state = "grenade_sticky_pgas"
	worn_icon_state = "grenade_sticky_pgas"
	det_time = 5 SECONDS
	self_sticky = TRUE
	overlay_type = "purple"
	smoketype = /datum/effect_system/smoke_spread/plasmaloss
	smoke_duration = 3
