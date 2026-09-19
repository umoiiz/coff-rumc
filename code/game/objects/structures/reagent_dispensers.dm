/obj/structure/reagent_dispensers
	name = "分配器"
	desc = "..."
	icon = 'icons/obj/objects.dmi'
	icon_state = "watertank"
	density = TRUE
	anchored = FALSE
	resistance_flags = XENO_DAMAGEABLE
	interaction_flags = INTERACT_OBJ_DEFAULT|INTERACT_POWERLOADER_PICKUP_ALLOWED
	allow_pass_flags = PASS_LOW_STRUCTURE|PASSABLE|PASS_WALKOVER
	max_integrity = 100
	///high chance to block bullets, offset by being unanchored
	coverage = 80
	///maximum tank capacity used to set reagents in initialize
	var/tank_volume = 1000
	///Current amount we will transfer every time we click on this
	var/amount_per_transfer_from_this = 10
	///list of possible transer amounts for this reagent dispenser
	var/possible_transfer_amounts = list(10,25,50,100)
	///List of reagents this dispenser will start with
	var/list/list_reagents

/obj/structure/reagent_dispensers/attackby(obj/item/I, mob/user, params)
	if(I.is_refillable())
		return FALSE //Handled in reagent code, which refills the item
	return ..()

/obj/structure/reagent_dispensers/attack_hand_alternate(mob/living/user)
	. = ..()
	if(!possible_transfer_amounts)
		return
	var/result = tgui_input_list(user, "每次转移的数量:","[src]", possible_transfer_amounts)
	if(result)
		amount_per_transfer_from_this = result

/obj/structure/reagent_dispensers/Initialize(mapload)
	. = ..()

	var/static/list/connections = list(
		COMSIG_OBJ_TRY_ALLOW_THROUGH = PROC_REF(can_climb_over),
		COMSIG_FIND_FOOTSTEP_SOUND = TYPE_PROC_REF(/atom/movable, footstep_override),
		COMSIG_TURF_CHECK_COVERED = TYPE_PROC_REF(/atom/movable, turf_cover_check),
	)
	AddElement(/datum/element/connect_loc, connections)

	create_reagents(tank_volume, AMOUNT_VISIBLE|DRAINABLE, list_reagents)

/obj/structure/reagent_dispensers/obj_destruction(damage_amount, damage_type, damage_flag)
	. = ..()
	if(damage_amount)
		new /obj/effect/particle_effect/water(loc)

//Dispensers
/obj/structure/reagent_dispensers/watertank
	name = "水箱"
	desc = "一个水箱"
	icon = 'icons/obj/objects.dmi'
	icon_state = "watertank"
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/water = 1000)

/obj/structure/reagent_dispensers/watertank/pred
	icon = 'icons/obj/machines/yautja_machines.dmi'
	icon_state = "watertank"

/obj/structure/reagent_dispensers/fueltank
	name = "燃料箱"
	desc = "一个燃料箱"
	icon = 'icons/obj/objects.dmi'
	icon_state = "weldtank"
	list_reagents = list(/datum/reagent/fuel = 1000)
	///Whether this tank is modded to drip fuel when its moved
	var/modded = FALSE
	///Rig we attached to this fuel tank
	var/obj/item/assembly_holder/rig
	//Whether the tank is already exploding to prevent chain explosions
	var/exploding = FALSE

/obj/structure/reagent_dispensers/fueltank/pred
	icon = 'icons/obj/machines/yautja_machines.dmi'
	icon_state = "weldtank"

/obj/structure/reagent_dispensers/fueltank/Destroy()
	QDEL_NULL(rig)
	return ..()

/obj/structure/reagent_dispensers/fueltank/examine(mob/user)
	. = ..()
	if(user != loc)
		return
	if(modded)
		. += span_warning("燃料龙头被扳开了, 燃料正在泄漏!")
	if(rig)
		. += span_notice("有某种装置被安装在了燃料箱上.")

/obj/structure/reagent_dispensers/fueltank/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!rig)
		return
	user.visible_message("[user]开始从\the [src]上卸下[rig].", "你开始从\the [src]上卸下[rig]...")
	if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_GENERIC))
		return
	user.visible_message(span_notice("[user]从\the [src]上卸下了[rig]."), span_notice("你从\the [src]上卸下了[rig]."))
	rig.forceMove(get_turf(user))
	rig = null
	cut_overlays()

/obj/structure/reagent_dispensers/fueltank/wrench_act(mob/living/user, obj/item/I)
	user.visible_message("[user]扳开了[src]的龙头[modded ? "closed" : "open"].", \
	"You wrench [src]'s faucet [modded ? "closed" : "open"]")
	modded = !modded
	log_attack("[key_name(user)] has wrenched [src] [modded ? "closed" : "open"] in [AREACOORD(user)]")
	playsound(src, 'sound/items/ratchet.ogg', 25, 1)
	if(modded)
		leak_fuel(amount_per_transfer_from_this)
	return TRUE

/obj/structure/reagent_dispensers/fueltank/welder_act(mob/living/user, obj/item/I)
	var/obj/item/tool/weldingtool/W = I
	if(!W.welding)
		if(W.reagents.has_reagent(/datum/reagent/fuel, W.max_fuel))
			balloon_alert(user, "已经满了!")
			return
		if(!reagents.has_reagent(/datum/reagent/fuel, 1))
			balloon_alert(user, "没有有效的燃料")
			return
		reagents.trans_to(W, W.max_fuel)
		W.weld_tick = 0
		user.visible_message(span_notice("[user]重新装满了[W]."), span_notice("你重新装满了[W]."))
		playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
		return
	log_bomber(user, "triggered a fueltank explosion with", src, "using a welder")
	var/self_message = user.a_intent != INTENT_HARM ? span_danger("你开始在燃料箱上焊接, 在最后一丝清醒中意识到这可能不是你做过的最聪明的事.") : span_danger("当你开始焊接时, [src]伴随着一片火焰灾难性地爆炸了.")
	user.visible_message(span_warning("[user]在重新填充\his [W.name]时灾难性地失败了!"), self_message)
	explode()
	return TRUE

/obj/structure/reagent_dispensers/fueltank/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(!istype(I, /obj/item/assembly_holder))
		return
	if(rig)
		to_chat(user, span_warning("有另一个装置挡住了."))
		return

	user.visible_message("[user]开始将[I]安装到\the [src]上.", "你开始将[I]安装到\the [src]上")
	if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_HOSTILE) || rig)
		return

	user.visible_message(span_notice("[user]将[I]安装到了\the [src]上."), span_notice("你将[I]安装到了\the [src]上."))
	rig = I
	user.transferItemToLoc(I, src)

	var/mutable_appearance/overlay = new()
	overlay.appearance = I.appearance
	overlay.pixel_x = 1
	overlay.pixel_y = 6
	add_overlay(overlay)

/obj/structure/reagent_dispensers/fueltank/bullet_act(atom/movable/projectile/proj)
	if(exploding)
		return FALSE
	. = ..()
	if(QDELETED(src))
		return
	if(proj.damage > 10 && prob(60) && (proj.ammo.damage_type in list(BRUTE, BURN)))
		log_attack("[key_name(proj.firer)] detonated a fuel tank with a projectile at [AREACOORD(src)].")
		explode()

/obj/structure/reagent_dispensers/fueltank/ex_act()
	explode()

///Does what it says on the tin, blows up the fueltank with radius depending on fuel left
/obj/structure/reagent_dispensers/fueltank/proc/explode()
	if(exploding)
		return
	exploding = TRUE
	var/turf/explosion_turf = get_turf(src)
	cell_explosion(explosion_turf || loc, reagents.total_volume * 0.2, reagents.total_volume * 0.1)
	if(explosion_turf)
		flame_radius(round(reagents.total_volume * 0.005), explosion_turf)
	qdel(src)

/obj/structure/reagent_dispensers/fueltank/fire_act(burn_level, flame_color)
	explode()

/obj/structure/reagent_dispensers/fueltank/Moved(atom/old_loc, movement_dir, forced, list/old_locs)
	. = ..()
	if(modded)
		leak_fuel(rand(3, amount_per_transfer_from_this))

///Leaks fuel when the valve is opened, leaving behind burnable splotches
/obj/structure/reagent_dispensers/fueltank/proc/leak_fuel(amount)
	if(reagents.total_volume <= 0)
		return

	amount = min(amount, reagents.total_volume)

	for(var/datum/reagent/leaked_reagent AS in reagents.reagent_list)
		if(leaked_reagent.volume < amount)
			continue
		leaked_reagent.reaction_turf(loc, amount)
		reagents.remove_reagent(leaked_reagent.type, amount)

	playsound(src, 'sound/effects/glob.ogg', 25, 1)

/obj/structure/reagent_dispensers/fueltank/barrel
	name = "红色油桶"
	desc = "一个红色燃料桶"
	icon = 'icons/obj/structures/crates.dmi'
	icon_state = "barrel_red"

/obj/structure/reagent_dispensers/fueltank/xfuel
	name = "X型燃料箱"
	desc = "一个装满了极其危险的X型燃料的箱子. 箱子的每一面都有许多禁止吸烟的标志."
	icon_state = "xweldtank"
	list_reagents = list(/datum/reagent/fuel/xfuel = 1000)

/obj/structure/reagent_dispensers/fueltank/xfuel/explode()
	log_bomber(usr, "triggered a fueltank explosion with", src)
	if(exploding)
		return
	exploding = TRUE

	var/turf/explosion_turf = get_turf(src)
	cell_explosion(explosion_turf || loc, reagents.total_volume * 0.4, reagents.total_volume * 0.2)
	if(explosion_turf)
		flame_radius(round(reagents.total_volume * 0.005), explosion_turf, 40, 46, 31, 30, colour = FLAME_COLOR_BLUE )
	qdel(src)

/obj/structure/reagent_dispensers/fueltank/gfuel
	name = "G型燃料箱"
	desc = "一个装满了极其危险的等离子燃料的箱子. 箱子的每一面都有许多禁止吸烟的标志."
	icon_state = "gweldtank"
	list_reagents = list(/datum/reagent/fuel/gfuel = 1000)

/obj/structure/reagent_dispensers/fueltank/gfuel/explode()
	log_bomber(usr, "triggered a fueltank explosion with", src)
	if(exploding)
		return
	exploding = TRUE

	var/turf/explosion_turf = get_turf(src)
	cell_explosion(explosion_turf || loc, reagents.total_volume * 0.4, reagents.total_volume * 0.2)
	if(explosion_turf)
		flame_radius(round(reagents.total_volume * 0.005), explosion_turf, 46, 40, 31, 30, colour = FLAME_COLOR_LIME)
	qdel(src)

/obj/structure/reagent_dispensers/water_cooler
	name = "饮水机"
	desc = "一台分配饮用水的机器."
	amount_per_transfer_from_this = 5
	icon = 'icons/obj/machines/vending.dmi'
	icon_state = "water_cooler"
	possible_transfer_amounts = null
	anchored = TRUE
	tank_volume = 500
	list_reagents = list(/datum/reagent/water = 500)
	coverage = 20

/obj/structure/reagent_dispensers/beerkeg
	name = "啤酒桶"
	desc = "一个啤酒桶"
	icon = 'icons/obj/objects.dmi'
	icon_state = "beertankTEMP"
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 1000)
	coverage = 30

/obj/structure/reagent_dispensers/wallmounted
	icon = 'icons/obj/wallframes.dmi'
	icon_state = "generic_tank"
	pixel_x = -16
	pixel_y = -16
	anchored = TRUE
	density = FALSE

/obj/structure/reagent_dispensers/wallmounted/Initialize(mapload, ndir)
	. = ..()
	if(ndir)
		setDir(ndir)
	switch(dir)
		if(NORTH)
			pixel_y -= 32
		if(SOUTH)
			pixel_y += 32
		if(EAST)
			pixel_x -= 32
		if(WEST)
			pixel_x += 32

/obj/structure/reagent_dispensers/wallmounted/peppertank
	name = "胡椒喷雾补充器"
	desc = "补充胡椒喷雾罐."
	icon_state = "peppertank"
	amount_per_transfer_from_this = 45
	list_reagents = list(/datum/reagent/consumable/capsaicin/condensed = 1000)

/obj/structure/reagent_dispensers/wallmounted/virusfood
	name = "病毒食物分配器"
	desc = "一个病毒食物分配器."
	icon_state = "virusfoodtank"
	list_reagents = list(/datum/reagent/consumable/virus_food = 1000)
