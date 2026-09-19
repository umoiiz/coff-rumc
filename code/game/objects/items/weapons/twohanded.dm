/obj/item/weapon/twohanded
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/twohanded_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/twohanded_right.dmi',
	)
	item_flags = TWOHANDED
	/// What sound do we make when we wield the weapon
	var/wieldsound
	/// What sound do we make when we unwield the weapon
	var/unwieldsound

/obj/item/weapon/twohanded/mob_can_equip(mob/user, slot, warning = TRUE, override_nodrop = FALSE, bitslot = FALSE)
	unwield(user)
	return ..()

/obj/item/weapon/twohanded/dropped(mob/user)
	. = ..()
	unwield(user)

/obj/item/weapon/twohanded/pickup(mob/user)
	. = ..()
	unwield(user)

/obj/item/proc/wield(mob/user)
	if(!(item_flags & TWOHANDED) || item_flags & WIELDED)
		return FALSE

	var/obj/item/offhand = user.get_inactive_held_item()
	if(offhand)
		if(offhand == user.r_hand)
			user.drop_r_hand()
		else if(offhand == user.l_hand)
			user.drop_l_hand()
		if(user.get_inactive_held_item()) //Failsafe; if there's somehow still something in the off-hand (undroppable), bail.
			to_chat(user, span_warning("你需要空出另一只手!"))
			return FALSE

	if(ishuman(user))
		var/check_hand = user.r_hand == src ? "l_hand" : "r_hand"
		var/mob/living/carbon/human/wielder = user
		var/datum/limb/hand = wielder.get_limb(check_hand)
		if(!istype(hand) || !hand.is_usable())
			to_chat(user, span_warning("你的另一只手无法握住[src]!"))
			return FALSE

	if(!place_offhand(user))
		to_chat(user, span_warning("你现在无法使用[src]."))
		return FALSE

	toggle_wielded(user, TRUE)
	SEND_SIGNAL(src, COMSIG_ITEM_WIELD, user)
	name = "[name] (Wielded)"
	update_worn_icon_state()
	user.update_inv_l_hand()
	user.update_inv_r_hand()
	return TRUE

/obj/item/proc/unwield(mob/user)
	if(!CHECK_MULTIPLE_BITFIELDS(item_flags, TWOHANDED|WIELDED))
		return FALSE

	toggle_wielded(user, FALSE)
	SEND_SIGNAL(src, COMSIG_ITEM_UNWIELD, user)
	var/sf = findtext(name, " (Wielded)", -10) // 10 == length(" (Wielded)")
	if(sf)
		name = copytext(name, 1, sf)
	else
		name = "[initial(name)]"
	update_worn_icon_state()
	remove_offhand(user)
	return TRUE

/obj/item/proc/place_offhand(mob/user)
	var/obj/item/weapon/twohanded/offhand/offhand = new /obj/item/weapon/twohanded/offhand(user)
	if(!user.put_in_inactive_hand(offhand))
		qdel(offhand)
		return FALSE
	to_chat(user, span_notice("你用双手握住了[src]."))
	offhand.name = "[name] - offhand"
	offhand.desc = "Your second grip on [src]."
	return TRUE

/obj/item/proc/remove_offhand(mob/user)
	to_chat(user, span_notice("你现在单手拿着[src]."))
	var/obj/item/weapon/twohanded/offhand/offhand = user.get_inactive_held_item()
	if(istype(offhand) && !QDELETED(offhand))
		qdel(offhand)
	user.update_inv_l_hand()
	user.update_inv_r_hand()

/obj/item/proc/toggle_wielded(user, wielded)
	if(wielded)
		item_flags |= WIELDED
	else
		item_flags &= ~WIELDED

/obj/item/weapon/twohanded/wield(mob/user)
	. = ..()
	if(!.)
		return
	toggle_active(TRUE)

	if(wieldsound)
		playsound(user, wieldsound, 15, 1)

	force = force_activated

/obj/item/weapon/twohanded/unwield(mob/user)
	. = ..()
	if(!.)
		return
	toggle_active(FALSE)

	if(unwieldsound)
		playsound(user, unwieldsound, 15, 1)

	force = initial(force)

// TODO port tg wielding component
/obj/item/weapon/twohanded/attack_self(mob/user)
	. = ..()

	if(item_flags & WIELDED)
		unwield(user)
	else
		wield(user)

///////////OFFHAND///////////////
/obj/item/weapon/twohanded/offhand
	name = "副手"
	icon_state = "offhand"
	w_class = WEIGHT_CLASS_HUGE
	item_flags = DELONDROP|TWOHANDED|WIELDED
	resistance_flags = RESIST_ALL

/obj/item/weapon/twohanded/offhand/Destroy()
	if(ismob(loc))
		var/mob/user = loc
		var/obj/item/main_hand = user.get_active_held_item()
		if(main_hand)
			main_hand.unwield(user)
	return ..()

/obj/item/weapon/twohanded/offhand/unwield(mob/user)
	return

/obj/item/weapon/twohanded/offhand/dropped(mob/user)
	return ..()

/obj/item/weapon/twohanded/offhand/forceMove(atom/destination)
	if(!ismob(destination))
		qdel(src)
	return ..()

/*
* Fireaxe
*/
/obj/item/weapon/twohanded/fireaxe
	name = "消防斧"
	desc = "确实,这是疯子的武器.谁会想到用斧头来救火呢?"
	icon_state = "fireaxe"
	worn_icon_state = "fireaxe"
	force = 20
	sharp = IS_SHARP_ITEM_BIG
	edge = TRUE
	w_class = WEIGHT_CLASS_BULKY
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_BACK
	atom_flags = CONDUCT
	item_flags = TWOHANDED
	force_activated = 75
	attack_verb = list("attacks", "chops", "cleaves", "tears", "cuts")

/obj/item/weapon/twohanded/fireaxe/wield(mob/user)
	. = ..()
	if(!.)
		return
	pry_capable = IS_PRY_CAPABLE_SIMPLE

/obj/item/weapon/twohanded/fireaxe/unwield(mob/user)
	. = ..()
	if(!.)
		return
	pry_capable = 0

/obj/item/weapon/twohanded/fireaxe/som
	name = "登舰斧"
	desc = "一把SOM登舰斧,能有效劈开门和头骨.持握时可以用来格挡和攻击."
	icon = 'icons/obj/items/weapons64.dmi'
	icon_state = "som_axe"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/weapon64_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/weapon64_right.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	worn_icon_state = "som_axe"
	force = 40
	force_activated = 80
	penetration = 35
	equip_slot_flags = ITEM_SLOT_BACK
	attack_speed = 15
	///Special attack action granted to users with the right trait
	var/datum/action/ability/activable/weapon_skill/axe_sweep/special_attack

/obj/item/weapon/twohanded/fireaxe/som/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/shield, SHIELD_TOGGLE|SHIELD_PURE_BLOCKING, list(MELEE = 45, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0))
	AddComponent(/datum/component/stun_mitigation, SHIELD_TOGGLE, shield_cover = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 60, BIO = 60, FIRE = 60, ACID = 60))
	AddElement(/datum/element/strappable)
	special_attack = new(src, force_activated, penetration)

/obj/item/weapon/twohanded/fireaxe/som/Destroy()
	QDEL_NULL(special_attack)
	return ..()

/obj/item/weapon/twohanded/fireaxe/som/wield(mob/user)
	. = ..()
	if(!.)
		return
	toggle_item_bump_attack(user, TRUE)
	if(user.skills.getRating(SKILL_MELEE_WEAPONS) > SKILL_MELEE_DEFAULT)
		special_attack.give_action(user)

/obj/item/weapon/twohanded/fireaxe/som/unwield(mob/user)
	. = ..()
	if(!.)
		return
	toggle_item_bump_attack(user, FALSE)
	special_attack?.remove_action(user)

//Special attack
/datum/action/ability/activable/weapon_skill/axe_sweep
	name = "Sweeping blow"
	action_icon_state = "axe_sweep"
	desc = "一次强力的横扫打击,会击中你面向方向的敌人.无法击晕."
	ability_cost = 10
	cooldown_duration = 6 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_WEAPONABILITY_AXESWEEP,
	)
	/// Used for particles. Holds the particles instead of the mob. See particle_holder for documentation.
	var/obj/effect/abstract/particle_holder/particle_holder

/datum/action/ability/activable/weapon_skill/axe_sweep/ai_should_use(atom/target)
	if(get_dist(owner, target) > 2)
		return FALSE
	return ..()

/datum/action/ability/activable/weapon_skill/axe_sweep/use_ability(atom/A)
	succeed_activate()
	add_cooldown()
	var/mob/living/carbon/carbon_owner = owner
	carbon_owner.Move(get_step(carbon_owner, angle_to_dir(Get_Angle(carbon_owner, A))), get_dir(carbon_owner, A))
	carbon_owner.face_atom(A)
	activate_particles(owner.dir)
	playsound(owner, 'sound/effects/alien/tail_swipe3.ogg', 50, 0, 5)
	owner.visible_message(span_danger("[owner]以致命的弧线挥舞武器!"))

	var/list/atom/movable/atoms_to_ravage = get_step(owner, owner.dir).contents.Copy()
	atoms_to_ravage += get_step(owner, turn(owner.dir, -45)).contents
	atoms_to_ravage += get_step(owner, turn(owner.dir, 45)).contents
	for(var/atom/movable/victim AS in atoms_to_ravage)
		if((victim.resistance_flags & INDESTRUCTIBLE))
			continue
		if(!ishuman(victim))
			var/obj/obj_victim = victim
			obj_victim.take_damage(damage, BRUTE, MELEE, TRUE, TRUE, get_dir(obj_victim, carbon_owner), penetration, carbon_owner)
			obj_victim.knockback(owner, 1, 2, knockback_force = MOVE_FORCE_VERY_STRONG)
			continue
		var/mob/living/carbon/human/human_victim = victim
		if(human_victim.lying_angle)
			continue
		human_victim.apply_damage(damage, BRUTE, BODY_ZONE_CHEST, MELEE, TRUE, TRUE, TRUE, penetration)
		human_victim.knockback(owner, 1, 2, knockback_force = MOVE_FORCE_VERY_STRONG)
		human_victim.adjust_stagger(1 SECONDS)
		playsound(human_victim, 'sound/weapons/wristblades_hit.ogg', 25, 0, 5)
		shake_camera(human_victim, 2, 1)

/// Handles the activation and deactivation of particles, as well as their appearance.
/datum/action/ability/activable/weapon_skill/axe_sweep/proc/activate_particles(direction)
	particle_holder = new(get_turf(owner), /particles/ravager_slash)
	QDEL_NULL_IN(src, particle_holder, 5)
	particle_holder.particles.rotation += dir2angle(direction)
	switch(direction) // There's no shared logic here because sprites are magical.
		if(NORTH) // Gotta define stuff for each angle so it looks good.
			particle_holder.particles.position = list(8, 4)
			particle_holder.particles.velocity = list(0, 20)
		if(EAST)
			particle_holder.particles.position = list(3, -8)
			particle_holder.particles.velocity = list(20, 0)
		if(SOUTH)
			particle_holder.particles.position = list(-9, -3)
			particle_holder.particles.velocity = list(0, -20)
		if(WEST)
			particle_holder.particles.position = list(-4, 9)
			particle_holder.particles.velocity = list(-20, 0)

/*
* Double-Bladed Energy Swords - Cheridan
*/
/obj/item/weapon/twohanded/dualsaber
	name = "双刃能量剑"
	desc = "小心轻放."
	icon_state = "dualsaber"
	worn_icon_state = "dualsaber"
	force = 3
	throwforce = 5
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	force_activated = 150
	wieldsound = 'sound/weapons/saberon.ogg'
	unwieldsound = 'sound/weapons/saberoff.ogg'
	atom_flags = NOBLOODY
	attack_verb = list("attacks", "slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")
	sharp = IS_SHARP_ITEM_BIG
	edge = 1

/obj/item/weapon/twohanded/dualsaber/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/shield, SHIELD_TOGGLE|SHIELD_PURE_BLOCKING)

/obj/item/weapon/twohanded/spear
	name = "长矛"
	desc = "一种胡乱拼凑但依然致命的古代设计武器."
	icon_state = "spearglass"
	worn_icon_state = "spearglass"
	force = 40
	w_class = WEIGHT_CLASS_BULKY
	equip_slot_flags = ITEM_SLOT_BACK
	force_activated = 75
	throwforce = 75
	throw_speed = 3
	reach = 2
	edge = 1
	sharp = IS_SHARP_ITEM_SIMPLE
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacks", "stabs", "jabs", "tears", "gores")
	///Based on what direction the tip of the spear is pointed at in the sprite; maybe someone makes a spear that points northwest
	var/current_angle = 45

/obj/item/weapon/twohanded/spear/throw_at(atom/target, range, speed, thrower, spin, flying = FALSE, targetted_throw = TRUE)
	spin = FALSE
	//Find the angle the spear is to be thrown at, then rotate it based on that angle
	var/rotation_value = Get_Angle(thrower, get_turf(target)) - current_angle
	current_angle += rotation_value
	var/matrix/rotate_me = matrix()
	rotate_me.Turn(rotation_value)
	transform = rotate_me
	return ..()

/obj/item/weapon/twohanded/spear/pickup(mob/user)
	. = ..()
	if(initial(current_angle) == current_angle)
		return
	//Reset the angle of the spear when picked up off the ground so it doesn't stay lopsided
	var/matrix/rotate_me = matrix()
	rotate_me.Turn(initial(current_angle) - current_angle)
	//Rotate the object in the opposite direction because for some unfathomable reason, the above Turn() is applied twice; it just works
	rotate_me.Turn(-(initial(current_angle) - current_angle))
	transform = rotate_me
	current_angle = initial(current_angle)	//Reset the angle

/obj/item/weapon/twohanded/spear/tactical
	name = "M-23长矛"
	desc = "一把战术长矛.用于'战术'战斗."
	icon_state = "spear"
	worn_icon_state = "spear"

/obj/item/weapon/twohanded/spear/tactical/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/strappable)

/obj/item/weapon/twohanded/spear/tactical/tacticool
	name = "M-23战术酷炫长矛"
	desc = "一把战术酷炫长矛.用于战斗中的战术酷炫."
	icon = 'icons/obj/items/weapons64.dmi'

/obj/item/weapon/twohanded/spear/tactical/tacticool/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/attachment_handler, \
	list(ATTACHMENT_SLOT_RAIL, ATTACHMENT_SLOT_UNDER, ATTACHMENT_SLOT_MUZZLE), \
	list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonetknife,
		/obj/item/attachable/bayonetknife/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/angledgrip,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
	), \
	attachment_offsets = list("muzzle_x" = 59, "muzzle_y" = 16, "rail_x" = 26, "rail_y" = 18, "under_x" = 40, "under_y" = 12))

/obj/item/weapon/twohanded/glaive
	name = "战争长刃"
	icon_state = "glaive"
	worn_icon_state = "glaive"
	desc = "金属长杆上的一把巨大而强力的刀刃.武器上刻有神秘的文字."
	force = 28
	w_class = WEIGHT_CLASS_BULKY
	equip_slot_flags = ITEM_SLOT_BACK
	force_activated = 90
	throwforce = 65
	throw_speed = 3
	edge = 1
	sharp = IS_SHARP_ITEM_BIG
	atom_flags = CONDUCT
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("slices", "slashes", "jabs", "tears", "gores")
	resistance_flags = UNACIDABLE
	attack_speed = 12 //Default is 7.

/obj/item/weapon/twohanded/glaive/damaged
	name = "战争长刃"
	desc = "金属长杆上的一把巨大而强力的刀刃.武器上刻有神秘的文字.这一把年代久远,并遭受了严重的酸蚀,几乎无法使用."
	force = 18
	force_activated = 28

/obj/item/weapon/twohanded/sledgehammer/rocketsledge
	name = "火箭大锤"
	desc = "头部装有火箭助推器,火箭大锤能造成极其强大的冲击,轻松碾碎你的敌人.使用燃料驱动自身."
	icon_state = "rocketsledge"
	worn_icon_state = "rocketsledge"
	force = 30
	w_class = WEIGHT_CLASS_BULKY
	equip_slot_flags = ITEM_SLOT_BACK
	force_activated = 75
	throwforce = 50
	throw_speed = 2
	edge = 1
	sharp = IS_SHARP_ITEM_BIG
	atom_flags = CONDUCT | TWOHANDED
	attack_verb = list("smashes", "hammers")
	attack_speed = 20

	///amount of fuel stored inside
	var/max_fuel = 50
	///amount of fuel used per hit
	var/fuel_used = 5
	///additional damage when weapon is active
	var/additional_damage = 75
	///stun value in crush mode
	var/crush_stun_amount = 2 SECONDS
	///paralyze value in crush mode
	var/crush_paralyze_amount = 4 SECONDS
	///stun value in knockback mode
	var/knockback_stun_amount = 2 SECONDS
	///paralyze value in knockback mode
	var/knockback_paralyze_amount = 2 SECONDS
	///stun value
	var/stun
	///paralyze value
	var/paralyze
	///knockback value; 0 = crush mode, 1 = knockback mode
	var/knockback

/obj/item/weapon/twohanded/sledgehammer/rocketsledge/Initialize(mapload)
	. = ..()
	stun = crush_stun_amount
	paralyze = crush_paralyze_amount
	knockback = 0
	create_reagents(max_fuel, null, list(/datum/reagent/fuel = max_fuel))
	AddElement(/datum/element/strappable)

/obj/item/weapon/twohanded/sledgehammer/rocketsledge/equipped(mob/user, slot)
	. = ..()
	toggle_item_bump_attack(user, TRUE)

/obj/item/weapon/twohanded/sledgehammer/rocketsledge/dropped(mob/user)
	. = ..()
	toggle_item_bump_attack(user, FALSE)

/obj/item/weapon/twohanded/sledgehammer/rocketsledge/examine(mob/user)
	. = ..()
	. += span_notice("按<b>独特动作</b>来切换模式.")
	. += span_notice("它含有<b>[reagents.get_reagent_amount(/datum/reagent/fuel)]/[max_fuel]</b>单位燃料!")

/obj/item/weapon/twohanded/sledgehammer/rocketsledge/wield(mob/user)
	. = ..()
	if((reagents.get_reagent_amount(/datum/reagent/fuel) < fuel_used))
		playsound(loc, 'sound/items/weldingtool_off.ogg', 25)
		return
	update_icon()

/obj/item/weapon/twohanded/sledgehammer/rocketsledge/unwield(mob/user)
	. = ..()
	update_icon()

/obj/item/weapon/twohanded/sledgehammer/rocketsledge/update_icon_state()
	. = ..()
	if ((reagents.get_reagent_amount(/datum/reagent/fuel) > fuel_used) && (CHECK_BITFIELD(item_flags, WIELDED)))
		icon_state = "rocketsledge_w"
	else
		icon_state = "rocketsledge"

/obj/item/weapon/twohanded/sledgehammer/rocketsledge/afterattack(obj/target, mob/user, flag)
	if(istype(target, /obj/structure/reagent_dispensers/fueltank) && get_dist(user,target) <= 1)
		var/obj/structure/reagent_dispensers/fueltank/RS = target
		if(RS.reagents.total_volume == 0)
			to_chat(user, span_warning("燃料耗尽!"))
			return ..()

		var/fuel_transfer_amount = min(RS.reagents.total_volume, (max_fuel - reagents.get_reagent_amount(/datum/reagent/fuel)))
		RS.reagents.remove_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		reagents.add_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
		to_chat(user, span_notice("你为[src]补充了燃料."))
		update_icon()

	return ..()

/obj/item/weapon/twohanded/sledgehammer/rocketsledge/unique_action(mob/user)
	. = ..()
	if (knockback)
		stun = crush_stun_amount
		paralyze = crush_paralyze_amount
		knockback = 0
		balloon_alert(user, "已选择模式:碾碎.")
		playsound(loc, 'sound/machines/switch.ogg', 25)
		return

	stun = knockback_stun_amount
	paralyze = knockback_paralyze_amount
	knockback = 1
	balloon_alert(user, "已选择模式:击退.")
	playsound(loc, 'sound/machines/switch.ogg', 25)

/obj/item/weapon/twohanded/sledgehammer/rocketsledge/attack(mob/living/carbon/M, mob/living/carbon/user as mob)
	if(!CHECK_BITFIELD(item_flags, WIELDED))
		to_chat(user, span_warning("你需要更牢固地握住[src]才能使用!"))
		return

	if(M.status_flags & INCORPOREAL || user.status_flags & INCORPOREAL)
		return

	if(reagents.get_reagent_amount(/datum/reagent/fuel) < fuel_used)
		to_chat(user, span_warning("\The [src]没有足够的燃料!"))
		return ..()

	M.apply_damage(additional_damage, BRUTE, user.zone_selected, updating_health = TRUE)
	M.visible_message(span_danger("[user]的火箭大锤击中了[M.name],将他们砸碎!"), span_userdanger("你[user]的火箭大锤把你砸碎了!"))

	if(reagents.get_reagent_amount(/datum/reagent/fuel) < fuel_used * 2)
		playsound(loc, 'sound/items/weldingtool_off.ogg', 50)
		to_chat(user, span_warning("\The [src]用尽最后一点燃料后关闭了!"))
		update_icon()
	else
		playsound(loc, 'sound/weapons/rocket_sledge.ogg', 50, TRUE)

	reagents.remove_reagent(/datum/reagent/fuel, fuel_used)

	if(knockback)
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		var/throw_distance = knockback * LERP(5 , 2, M.mob_size / MOB_SIZE_BIG)
		M.throw_at(throw_target, throw_distance, 0.5 + (knockback * 0.5))

	if(isxeno(M))
		var/mob/living/carbon/xenomorph/xeno_victim = M
		if(xeno_victim.fortify || xeno_victim.endure || HAS_TRAIT_FROM(xeno_victim, TRAIT_IMMOBILE, BOILER_ROOTED_TRAIT)) //If we're fortified or use endure we don't give a shit about staggerstun.
			return

		if(xeno_victim.crest_defense) //Crest defense protects us from the stun.
			stun = 0
		else
			stun = knockback ? knockback_stun_amount : crush_stun_amount

	if(!M.has_status_effect(STATUS_EFFECT_STUN) && !M.has_status_effect(STATUS_EFFECT_PARALYZED) && !isxenoqueen(M) && !isxenoking(M)) //Prevent chain stunning. Queen and King are protected.
		M.apply_effects(stun,paralyze)

	return ..()

/obj/item/weapon/twohanded/sledgehammer
	name = "大锤"
	desc = "一把重锤,擅长砸碎岩石,但在这种情况下大概也能当把好武器."
	icon_state = "sledgehammer"
	worn_icon_state = "sledgehammer"
	force = 20
	equip_slot_flags = ITEM_SLOT_BACK
	atom_flags = CONDUCT
	item_flags = TWOHANDED
	force_activated = 85
	penetration = 10
	attack_speed = 20
	attack_verb = list("attacks", "wallops", "smashes", "shatters", "bashes")

/obj/item/weapon/twohanded/sledgehammer/wield(mob/user)
	. = ..()
	if(!.)
		return
	toggle_item_bump_attack(user, TRUE)

/obj/item/weapon/twohanded/sledgehammer/unwield(mob/user)
	. = ..()
	if(!.)
		return
	toggle_item_bump_attack(user, FALSE)

/// Chainsword & Chainsaw
/obj/item/weapon/twohanded/chainsaw
	name = "链锯"
	desc = "一把链锯.适合把大东西变成小东西."
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/melee_right.dmi',
	)
	icon_state = "chainsaw_off"
	worn_icon_state = "chainsaw"
	atom_flags = TWOHANDED
	attack_verb = list("gores", "tears", "rips", "shreds", "slashes", "cuts")
	force = 20
	force_activated = 75
	throwforce = 30
	attack_speed = 20
	///icon when on
	var/icon_state_on = "chainsaw_on"
	///sprite on the mob when off but wielded
	var/worn_icon_state_w = "chainsaw_w"
	///sprite on the mob when on
	var/worn_icon_state_on = "chainsaw_on"
	///amount of fuel stored inside
	var/max_fuel = 50
	///amount of fuel used per hit
	var/fuel_used = 5
	///additional damage when weapon is active
	var/additional_damage = 75

/obj/item/weapon/twohanded/chainsaw/Initialize(mapload)
	. = ..()
	create_reagents(max_fuel, null, list(/datum/reagent/fuel = max_fuel))
	AddElement(/datum/element/strappable)

///handle icon change
/obj/item/weapon/twohanded/chainsaw/update_icon_state()
	. = ..()
	if(active)
		icon_state = icon_state_on
		return
	icon_state = initial(icon_state)

///handle worn_icon change
/obj/item/weapon/twohanded/chainsaw/update_worn_icon_state(mob/user)
	. = ..()
	if(active)
		worn_icon_state = worn_icon_state_on
		return
	if(CHECK_BITFIELD(item_flags, WIELDED)) //weapon is wielded but off
		worn_icon_state = worn_icon_state_w
		return
	worn_icon_state = initial(worn_icon_state)

///Proc to turn the chainsaw on or off
/obj/item/weapon/twohanded/chainsaw/proc/toggle_motor(mob/user)
	if(!active)
		force = initial(force)
		hitsound = initial(hitsound)
		balloon_alert(user, "引擎熄灭了!")
		update_icon()
		update_worn_icon_state()
		return
	if(reagents.get_reagent_amount(/datum/reagent/fuel) < fuel_used)
		balloon_alert(user, "燃料不足!")
		return
	force += additional_damage
	playsound(loc, 'sound/weapons/chainsawhit.ogg', 100, 1)
	hitsound = 'sound/weapons/chainsawhit.ogg'
	balloon_alert(user, "引擎嗡嗡地启动了!")
	update_icon()
	update_worn_icon_state()

///Proc for the fuel cost and check and chainsaw noises
/obj/item/weapon/twohanded/chainsaw/proc/rip_apart(mob/user)
	if(!active)
		return
	reagents.remove_reagent(/datum/reagent/fuel, fuel_used)
	user.changeNext_move(attack_speed) //this is here because attacking object for some reason doesn't respect weapon attack speed
	if(reagents.get_reagent_amount(/datum/reagent/fuel) < fuel_used && active) //turn off the chainsaw after one last attack when fuel ran out
		playsound(loc, 'sound/items/weldingtool_off.ogg', 50)
		to_chat(user, span_warning("\The [src]用尽最后一点燃料后关闭了!"))
		active = FALSE
		toggle_motor(user)
		return
	if(prob(0.1)) // small chance for an easter egg of simpson chainsaw noises
		playsound(loc, 'sound/weapons/chainsaw_simpson.ogg', 60)
	else
		playsound(loc, 'sound/weapons/chainsawhit.ogg', 100, 1)

///Chainsaw give bump attack when picked up
/obj/item/weapon/twohanded/chainsaw/equipped(mob/user, slot)
	. = ..()
	toggle_item_bump_attack(user, TRUE)

///Chainsaw turned off when dropped, and also lose bump attack
/obj/item/weapon/twohanded/chainsaw/dropped(mob/user)
	. = ..()
	toggle_item_bump_attack(user, FALSE)
	if(!active)
		return
	active = FALSE
	toggle_motor(user)

///Chainsaw turn on when wielded
/obj/item/weapon/twohanded/chainsaw/wield(mob/user)
	. = ..()
	if(!.)
		return
	playsound(loc, 'sound/weapons/chainsawstart.ogg', 100, 1)
	toggle_active(FALSE)
	if(!do_after(user, SKILL_TASK_TRIVIAL, NONE, src, BUSY_ICON_DANGER, null,PROGRESS_BRASS))
		return
	toggle_active(TRUE)
	toggle_motor(user)

///Chainsaw turn off when unwielded
/obj/item/weapon/twohanded/chainsaw/unwield(mob/user)
	. = ..()
	if(!.)
		return
	toggle_motor(user)

/obj/item/weapon/twohanded/chainsaw/examine(mob/user)
	. = ..()
	. += "It contains [reagents.get_reagent_amount(/datum/reagent/fuel)]/[max_fuel] units of fuel!"

///Refueling with fueltank
/obj/item/weapon/twohanded/chainsaw/afterattack(obj/target, mob/user, flag)
	if(!istype(target, /obj/structure/reagent_dispensers/fueltank) || get_dist(user,target) > 1)
		return
	var/obj/structure/reagent_dispensers/fueltank/saw = target
	if(saw.reagents.total_volume == 0)
		balloon_alert(user, "燃料耗尽!")
		return ..()
	var/fuel_transfer_amount = min(saw.reagents.total_volume, (max_fuel - reagents.get_reagent_amount(/datum/reagent/fuel)))
	saw.reagents.remove_reagent(/datum/reagent/fuel, fuel_transfer_amount)
	reagents.add_reagent(/datum/reagent/fuel, fuel_transfer_amount)
	playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
	balloon_alert(user, "你为它补充了燃料.")
	update_icon()

	return ..()

/obj/item/weapon/twohanded/chainsaw/attack(mob/living/carbon/M, mob/living/carbon/user)
	rip_apart(user)
	return ..()

///Handle chainsaw attack loop on object
/obj/item/weapon/twohanded/chainsaw/attack_obj(obj/target_object, mob/living/user)
	. = ..()
	if(!active)
		return

	if(user.do_actions)
		target_object.balloon_alert(user, "已经忙碌")
		return TRUE

	if(user.incapacitated() || get_dist(user, target_object) > 1 || user.resting)  // loop attacking an adjacent object while user is not incapacitated nor resting, mostly here for the one handed chainsword
		return TRUE

	rip_apart(user)

	if(!do_after(user, src.attack_speed, NONE, target_object, BUSY_ICON_DANGER, null,PROGRESS_BRASS) || !active) //attack channel to loop attack, and second active check in case fuel ran out.
		return

	attack_obj(target_object, user)

/obj/item/weapon/twohanded/chainsaw/sword
	name = "链锯剑"
	desc = "切割异端和异形从未如此简单"
	icon_state = "chainsword_off"
	icon_state_on = "chainsword_on"
	worn_icon_state = "chainsword"
	worn_icon_state_w = "chainsword_w"
	worn_icon_state_on = "chainsword_w"
	attack_speed = 12
	max_fuel = 150
	force = 60
	force_activated = 90
	additional_damage = 60

/// Allow the chainsword variant to be activated without being wielded
/obj/item/weapon/twohanded/chainsaw/sword/unique_action(mob/user)
	. = ..()
	if(CHECK_BITFIELD(item_flags, WIELDED))
		return
	playsound(loc, 'sound/machines/switch.ogg', 25)
	toggle_active()
	toggle_motor(user)
