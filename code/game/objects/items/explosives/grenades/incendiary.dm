/obj/item/explosive/grenade/incendiary
	name = "\improper M40 HIDP燃烧榴弹"
	desc = "M40 HIDP是一种小巧但威力出人意料地强的燃烧榴弹。它被设定为4秒后引爆。"
	icon_state = "grenade_fire"
	worn_icon_state = "grenade_fire"
	det_time = 4 SECONDS
	hud_state = "grenade_fire"
	icon_state_mini = "grenade_orange"
	overlay_type = "orange"

/obj/item/explosive/grenade/incendiary/prime()
	flame_radius(2, get_turf(src))
	playsound(loc, SFX_INCENDIARY_EXPLOSION, 35)
	qdel(src)

/proc/flame_radius(radius = 1, turf/epicenter, burn_intensity = 25, burn_duration = 25, burn_damage = 25, fire_stacks = 15, colour = "red", fire_type = /obj/fire/flamer) //~Art updated fire.
	if(!epicenter)
		return
	if(!isturf(epicenter))
		epicenter = get_turf(epicenter)
	if(!isturf(epicenter))
		return
	radius = clamp(radius, 1, 50) //Sanitize inputs

	for(var/t in filled_turfs(epicenter, radius, "circle", pass_flags_checked = PASS_AIR))
		var/turf/turf_to_flame = t
		turf_to_flame.ignite(randfloat(burn_duration*0.75, burn_duration), burn_intensity, colour, burn_damage, fire_stacks, fire_type)

/obj/item/explosive/grenade/incendiary/som
	name = "\improper S30-I燃烧榴弹"
	desc = "一种由SOM部队使用的可靠燃烧榴弹。基于大多数SOM榴弹共用的S30平台。设计用于手投或榴弹发射器使用。"
	icon_state = "grenade_fire_som"
	worn_icon_state = "grenade_fire_som"
	overlay_type = "orange"

/obj/item/explosive/grenade/incendiary/molotov
	name = "简易燃烧弹"
	desc = "一种强效的简易燃烧弹，掺有少量火药。廉价、非常有效，在密闭空间中致命。常见于叛军和恐怖分子手中。很难预测它还有几秒就会爆炸，所以要小心。很有可能，它会在你脸上炸开。"
	icon_state = "molotov"
	worn_icon_state = "molotov"
	arm_sound = 'sound/items/welder2.ogg'

/obj/item/explosive/grenade/incendiary/molotov/Initialize(mapload)
	. = ..()
	det_time = rand(1 SECONDS, 4 SECONDS)//Adds some risk to using this thing.

/obj/item/explosive/grenade/incendiary/molotov/prime()
	flame_radius(2, get_turf(src))
	playsound(loc, SFX_MOLOTOV, 35)
	qdel(src)

/obj/item/explosive/grenade/incendiary/molotov/throw_impact(atom/hit_atom, speed, bounce = TRUE)
	. = ..()
	if(!.)
		return
	if(!hit_atom.density || prob(35))
		return
	prime()

/obj/item/explosive/grenade/phosphorus
	name = "\improper M40 HPDP榴弹"
	desc = "M40 HPDP是一种小巧但威力强大的磷弹。它被设定为2秒后引爆。"
	icon_state = "grenade_phos"
	worn_icon_state = "grenade_phos"
	det_time = 2 SECONDS
	hud_state = "grenade_hide"
	icon_state_mini = "grenade_cyan"
	overlay_type = "aqua"
	var/datum/effect_system/smoke_spread/phosphorus/smoke

/obj/item/explosive/grenade/phosphorus/Initialize(mapload)
	. = ..()
	smoke = new(src)

/obj/item/explosive/grenade/phosphorus/Destroy()
	QDEL_NULL(smoke)
	return ..()

/obj/item/explosive/grenade/phosphorus/prime()
	playsound(loc, 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(6, loc, 7)
	smoke.start()
	flame_radius(4, get_turf(src))
	flame_radius(1, get_turf(src), burn_intensity = 75, burn_duration = 45, burn_damage = 15, fire_stacks = 75)	//The closer to the middle you are the more it hurts
	qdel(src)

/obj/item/explosive/grenade/phosphorus/activate(mob/user)
	. = ..()
	if(!.)
		return FALSE
	user?.record_war_crime()

/obj/item/explosive/grenade/phosphorus/upp
	name = "\improper 8式白磷弹"
	desc = "一种在USL队伍中发现的致命毒气榴弹。旨在向目标泼洒白磷。拔掉保险销2秒后爆炸。"
	icon_state = "grenade_upp_wp"
	worn_icon_state = "grenade_upp_wp"
	arm_sound = 'sound/weapons/armbombpin_1.ogg'
