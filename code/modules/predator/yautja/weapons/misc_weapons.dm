/*#########################################
############## Misc Weapons ###############
#########################################*/
/obj/item/weapon/harpoon/yautja
	name = "大型鱼叉"
	desc = "一根巨大的金属尖刺,末端带有一个钩子.上面刻着神秘的异形文字."

	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "spike"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/hunter/items_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/hunter/items_righthand.dmi'
	)
	worn_icon_state = "harpoon"

	attack_verb = list("jabbed","stabbed","ripped", "skewered")
	throw_range = 4
	resistance_flags = UNACIDABLE
	edge = 1
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharp = IS_SHARP_ITEM_BIG
	force = 10
	throwforce = 30

/obj/item/weapon/wristblades
	name = "\proper 腕刃"
	desc = "一对巨大的锯齿状刀刃,从金属护手伸出."

	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "wrist"
	worn_icon_state = "wristblade"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/hunter/items_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/hunter/items_righthand.dmi'
	)

	w_class = WEIGHT_CLASS_GIGANTIC
	edge = TRUE
	sharp = IS_SHARP_ITEM_ACCURATE
	item_flags = ITEM_PREDATOR
	equip_slot_flags = NONE
	hitsound = 'sound/weapons/wristblades_hit.ogg'
	attack_speed = 6
	force = 25
	penetration = 10
	pry_capable = IS_PRY_CAPABLE_FORCE
	attack_verb = list("sliced", "slashed", "jabbed", "torn", "gored")

	var/obj/item/clothing/gloves/yautja/hunter/source
	var/has_speed_bonus = TRUE

/obj/item/weapon/wristblades/Initialize(mapload)
	. = ..()
	source = loc
	if(!istype(source))
		qdel(src)

/obj/item/weapon/wristblades/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_L_HAND || slot == SLOT_R_HAND)
		if(has_speed_bonus && istype(user.get_inactive_held_item(), /obj/item/weapon/wristblades))
			attack_speed = initial(attack_speed) - 2
	else
		forceMove(source)
		attack_speed = initial(attack_speed)
		playsound(user, 'sound/weapons/wristblades_off.ogg', 15, TRUE)
		if(source.left_wristblades.loc == source && source.right_wristblades.loc == source)
			source.wristblades_deployed = FALSE
			source.action_wristblades.set_toggle(FALSE)

/obj/item/weapon/wristblades/dropped(mob/user)
	if(source)
		forceMove(source)
		attack_speed = initial(attack_speed)
		playsound(user, 'sound/weapons/wristblades_off.ogg', 15, TRUE)
		if(source.left_wristblades.loc == source && source.right_wristblades.loc == source)
			source.wristblades_deployed = FALSE
			source.action_wristblades.set_toggle(FALSE)
		return
	..()

/obj/item/weapon/wristblades/afterattack(atom/attacked_target, mob/user, proximity)
	if(!proximity || !user)
		return FALSE

	if(istype(attacked_target, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/door = attacked_target
		if(!door.density || door.locked)
			return FALSE
		user.visible_message(span_danger("[user]把他们的[name]扎进[door],用力想把它撕开..."), span_danger("你把你的[name]扎进[door],用力想把它撕开..."))
		playsound(loc, 'sound/effects/metal_creaking.ogg', 25, TRUE)
		if(do_after(user, 3 SECONDS, NONE, door, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE) && door.density)
			user.visible_message(span_danger("[user]用[name]强行撬开了[door]!"), span_danger("你用[name]强行撬开了[door]."))
			door.open(TRUE)

	else if(istype(attacked_target, /obj/structure/mineral_door/resin))
		var/obj/structure/mineral_door/resin/door = attacked_target
		if(door.switching_states || user.a_intent == INTENT_HARM)
			return
		if(door.density)
			user.visible_message(span_danger("[user]把他们的[name]扎进[door],用力想把它撕开..."), span_danger("你把你的[name]扎进[door],用力想把它撕开..."))
			playsound(loc, 'sound/weapons/wristblades_hit.ogg', 15, TRUE)
			if(do_after(user, 1.5 SECONDS, NONE, door, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE) && door.density)
				user.visible_message(span_danger("[user]用[name]强行撬开了[door]!"), span_danger("你用你的[name]强行撬开了[door]."))
				door.toggle_state()
		else
			user.visible_message(span_danger("[user]用他们的[name]推[door],想把它强行合上..."), span_danger("你用你的[name]推[door],想把它强行合上..."))
			playsound(loc, 'sound/weapons/wristblades_hit.ogg', 15, TRUE)
			if(do_after(user, 2 SECONDS, NONE, door, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE) && !door.density)
				user.visible_message(span_danger("[user]部队使用[name]强行关闭了[door]!"), span_danger("你用你的[name]强行关闭了[door]."))
				door.toggle_state()

/obj/item/weapon/wristblades/attack_self(mob/living/carbon/human/user)
	..()
	if(istype(user))
		var/obj/item/clothing/gloves/yautja/hunter/gloves = user.gloves
		gloves.wristblades_internal(user, TRUE) // unlikely that the yaut would have gloves without blades, so if they do, runtime logs here would be handy

/obj/item/weapon/wristblades/scimitar
	name = "\proper 腕部弯刀"
	desc = "从金属护手延伸出的巨大锯齿刀刃."
	icon_state = "scim"
	worn_icon_state = "scim"
	attack_speed = 5
	penetration = 15
	attack_verb = list("sliced", "slashed", "jabbed", "torn", "gored")
	force = 32
