/obj/item/weapon/shield/riot/yautja
	name = "氏族盾牌"
	desc = "一面由奇异金属合金制成的大型部落盾牌.盾面上有三个头骨,两个人类,一个异形."
	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "shield"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/hunter/items_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/hunter/items_righthand.dmi',
		slot_back_str = 'icons/mob/hunter/pred_gear.dmi'
	)
	worn_icon_state = "shield"
	item_flags = ITEM_PREDATOR
	equip_slot_flags = ITEM_SLOT_BACK
	resistance_flags = UNACIDABLE

	base_icon_state = "shield"

	max_integrity = 400
	integrity_failure = 0

	var/passive_block = 15
	var/readied_block = 45

	var/readied_slowdown = 0.5 // Walking around in a readied shield stance slows you! The armor defs are a useful existing reference point.
	var/shield_readied = FALSE

	var/last_attack = 0
	var/last_lowered = 0
	var/cooldown_time = 2.5 SECONDS

/obj/item/weapon/shield/riot/yautja/set_shield()
	return

/obj/item/weapon/shield/riot/yautja/AltClick(mob/user)
	if(!can_interact(user))
		return ..()
	if(!ishuman(user))
		return ..()
	if(!(user.l_hand == src || user.r_hand == src))
		return ..()
	if(!HAS_TRAIT(src, TRAIT_NODROP))
		ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		to_chat(user, span_warning("你收紧了你手上[src]的绑带!"))
	else
		REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		to_chat(user, span_notice("你松开了你手上[src]的绑带!"))

/obj/item/weapon/shield/riot/yautja/proc/raise_shield(mob/user as mob) // Prepare for an attack. Slows you down slightly, but increases chance to block.
	if(world.time < last_lowered + cooldown_time)
		to_chat(user, span_warning("你需要再等一会儿才能再次举起盾牌!"))
		return

	user.visible_message(span_blue("\The [user]举起了\the [src]."))
	shield_readied = TRUE
	icon_state = "[base_icon_state]_ready"
	worn_icon_state = "[base_icon_state]_ready"
	user.add_movespeed_modifier(MOVESPEED_ID_YAUTJA_SHIELD, TRUE, 0, NONE, FALSE, readied_slowdown)

	if(user.r_hand == src)
		user.update_inv_r_hand()
	if(user.l_hand == src)
		user.update_inv_l_hand()

/obj/item/weapon/shield/riot/yautja/proc/lower_shield(mob/living/carbon/human/H)
	H.visible_message(span_blue("\The [H]放下了\the [src]."))
	shield_readied = FALSE
	icon_state = base_icon_state
	worn_icon_state = base_icon_state

	H.remove_movespeed_modifier(MOVESPEED_ID_YAUTJA_SHIELD)
	var/obj/item/weapon/shield/riot/yautja/offhand_shield
	if(H.l_hand == src && istype(H.r_hand, /obj/item/weapon/shield/riot/yautja))
		offhand_shield = H.r_hand
	else if(H.r_hand == src && istype(H.l_hand, /obj/item/weapon/shield/riot/yautja))
		offhand_shield = H.l_hand
	if(offhand_shield?.shield_readied)
		H.add_movespeed_modifier(MOVESPEED_ID_YAUTJA_SHIELD, TRUE, 0, NONE, FALSE, readied_slowdown)

	last_lowered = world.time

	if(H.r_hand == src)
		H.update_inv_r_hand()
	if(H.l_hand == src)
		H.update_inv_l_hand()

/obj/item/weapon/shield/riot/yautja/proc/toggle_shield(mob/user as mob)
	if(shield_readied)
		lower_shield(user)
	else
		raise_shield(user)

// Making sure that debuffs don't stay
/obj/item/weapon/shield/riot/yautja/dropped(mob/user as mob)
	if(shield_readied)
		lower_shield(user)
	return ..()

/obj/item/weapon/shield/riot/yautja/equipped(mob/user, slot)
	if(shield_readied)
		lower_shield(user)
	return ..()

/obj/item/weapon/shield/riot/yautja/attack_self(mob/user)
	. = ..()
	toggle_shield(user)

/obj/item/weapon/shield/riot/yautja/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!.)
		return
	if(world.time <= last_attack + cooldown_time)
		return
	last_attack = world.time
	M.throw_at(get_step(M, user.dir), 1, 5, user, FALSE)
	M.apply_effect(3, EFFECT_EYE_BLUR)
	M.apply_effect(5, EFFECT_PARALYZE)

/obj/item/weapon/shield/riot/yautja/attackby(obj/item/I, mob/user)
	if(cooldown < world.time - 25)
		if(istype(I, /obj/item/weapon) && (I.item_flags & ITEM_PREDATOR))
			user.visible_message(span_warning("[user]\the 用\the [I]猛击[src]!"))
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 25, 1)
			cooldown = world.time
		return
	return ..()
