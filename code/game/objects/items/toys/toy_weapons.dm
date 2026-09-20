/*
*		Toy gun
*		Toy crossbow
*		Toy swords
*/



/*
* Toy gun: Why isnt this an /obj/item/weapon/gun?
*/
/obj/item/toy/gun
	name = "玩具枪"
	desc = "看起来几乎和真的一样!适合8岁及以上。用完后请回收进自动车床!"
	icon_state = "capgun"
	worn_icon_state = "gun"
	equip_slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL

	attack_verb = list("strikes", "pistol whips", "hits", "bashes")
	var/bullets = 7

/obj/item/toy/gun/examine(mob/user)
	. = ..()
	to_chat(user, "[src]里还剩[bullets]发\s 。")

/obj/item/toy/gun/attackby(obj/item/toy/gun_ammo/A as obj, mob/user as mob)

	if (istype(A, /obj/item/toy/gun_ammo))
		if (src.bullets >= 7)
			to_chat(user, span_notice("它已经装满弹药了!"))
			return 1
		if (A.amount_left <= 0)
			to_chat(user, span_warning("没有更多弹药了!"))
			return 1
		if (A.amount_left < (7 - bullets))
			src.bullets += A.amount_left
			to_chat(user, span_warning("你装填了[A.amount_left]发\s !"))
			A.amount_left = 0
		else
			to_chat(user, span_warning("你装填了[7 - bullets]发\s !"))
			A.amount_left -= 7 - bullets
			bullets = 7
		A.update_icon()
		A.desc = "There are [A.amount_left] caps\s left! Make sure to recycle the box in an autolathe when it gets empty."
		return 1
	return

/obj/item/toy/gun/afterattack(atom/target, mob/user, flag)
	if (flag)
		return
	if (src.bullets < 1)
		user.show_message(span_warning("*咔哒* *咔哒*"), 2)
		playsound(user, 'sound/weapons/guns/fire/empty.ogg', 15, 1)
		return
	playsound(user, 'sound/weapons/guns/fire/gunshot.ogg', 15, 1)
	src.bullets--
	visible_message(span_danger("[user]朝[target]开了一枪玩具枪!"), null, span_warning("你听到一声枪响"))

/obj/item/toy/gun_ammo
	name = "弹药帽"
	desc = "还剩7发弹药帽!用完后请务必把盒子回收进自动车床。"
	icon_state = "cap_ammo"
	w_class = WEIGHT_CLASS_TINY

	var/amount_left = 7

/obj/item/toy/gun_ammo/update_icon_state()
	. = ..()
	if(amount_left)
		icon_state = "cap_ammo"
	else
		icon_state = "cap_ammo_e"


/*
* Toy crossbow
*/

/obj/item/toy/crossbow
	name = "泡沫飞镖弩"
	desc = "许多好动孩子青睐的武器。适合8岁及以上。"
	icon_state = "foamcrossbow"
	worn_icon_state = "crossbow"
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("attacks", "strikes", "hits")
	var/bullets = 5

/obj/item/toy/crossbow/examine(mob/user)
	. = ..()
	if (bullets)
		. += span_notice("它装填了[bullets]支泡沫飞镖!")

/obj/item/toy/crossbow/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/toy/crossbow_ammo))
		if(bullets <= 4)
			if(user.drop_held_item())
				qdel(I)
				bullets++
				to_chat(user, span_notice("你将泡沫飞镖装入了弩中。"))
		else
			to_chat(usr, span_warning("它已经装满弹药了。"))

/obj/item/toy/crossbow/afterattack(atom/target, mob/user, flag)
	if(!isturf(target.loc) || target == user) return
	if(flag) return

	if(locate (/obj/structure/table, src.loc))
		return
	else if (bullets)
		var/turf/trg = get_turf(target)
		var/obj/effect/foam_dart_dummy/D = new/obj/effect/foam_dart_dummy(get_turf(src))
		bullets--
		D.icon_state = "foamdart"
		D.name = "foam dart"
		playsound(user.loc, 'sound/items/syringeproj.ogg', 15, 1)

		for(var/i = 0, i < 6, i++)
			if(D)
				if(D.loc == trg)
					break
				step_towards(D, trg)

				for(var/mob/living/M in D.loc)
					if(!istype(M, /mob/living))
						continue
					if(M == user)
						continue
					visible_message(span_warning("[M]被泡沫飞镖击中了!"), visible_message_flags = COMBAT_MESSAGE)
					new /obj/item/toy/crossbow_ammo(M.loc)
					qdel(D)
					return

				for(var/atom/A in D.loc)
					if(A == user) continue
					if(A.density)
						new /obj/item/toy/crossbow_ammo(A.loc)
						qdel(D)

			sleep(0.1 SECONDS)

		addtimer(CALLBACK(src, PROC_REF(convert_proj_to_item), D), 1 SECONDS)

		return
	else if(!bullets && isliving(user))
		var/mob/living/L = user
		L.Paralyze(10 SECONDS)
		visible_message(span_warning("[user]意识到自己没弹药了,开始四处搜寻!"))

/obj/item/toy/crossbow/proc/convert_proj_to_item(obj/effect/foam_dart_dummy/dart)
	if(!dart)
		return
	new /obj/item/toy/crossbow_ammo(dart.loc)
	qdel(dart)


/obj/item/toy/crossbow/attack(mob/M as mob, mob/user as mob)

// ******* Check

	if (bullets > 0 && M.lying_angle)
		visible_message(span_danger("[user]随意地瞄准了[M]的头部并扣下了扳机!"), null, span_warning("你听到泡沫撞击头骨的声音"))
		visible_message(span_warning("[M]的头部被泡沫飞镖击中了!"))

		playsound(user.loc, 'sound/items/syringeproj.ogg', 15, 1)
		new /obj/item/toy/crossbow_ammo(M.loc)
		src.bullets--
	else if(M.lying_angle && !bullets && isliving(M))
		var/mob/living/L = M
		L.visible_message(span_danger("[user]随意地瞄准了[L]的头部,扣下扳机,然后意识到自己没弹药了,便趴到地上搜寻起来!"))
		L.Paralyze(10 SECONDS)
	return

/obj/item/toy/crossbow_ammo
	name = "泡沫飞镖"
	desc = "要么玩Nerf要么别玩!适合8岁及以上。"
	icon = 'icons/obj/items/toy.dmi'
	icon_state = "foamdart"
	w_class = WEIGHT_CLASS_TINY

/obj/effect/foam_dart_dummy
	name = ""
	desc = ""
	icon = 'icons/obj/items/toy.dmi'
	icon_state = "null"
	anchored = TRUE
	density = FALSE


/*
* Toy swords
*/
/obj/item/toy/sword
	name = "玩具剑"
	desc = "一把廉价的能量剑塑料复制品。逼真的音效!适合8岁及以上。"
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "sword0"
	worn_icon_state = "sword0"
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("attacks", "strikes", "hits")

/obj/item/toy/sword/attack_self(mob/user as mob)
	src.active = !( src.active )
	if (src.active)
		to_chat(user, span_notice("你手腕一抖,迅速弹出了塑料剑刃。"))
		playsound(user, 'sound/weapons/saberon.ogg', 15, 1)
		src.icon_state = "swordblue"
		src.worn_icon_state = "swordblue"
		src.w_class = WEIGHT_CLASS_BULKY
	else
		to_chat(user, span_notice("你将塑料剑刃按回了剑柄中。"))
		playsound(user, 'sound/weapons/saberoff.ogg', 15, 1)
		src.icon_state = "sword0"
		src.worn_icon_state = "sword0"
		src.w_class = WEIGHT_CLASS_SMALL

	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		H.update_inv_l_hand(0)
		H.update_inv_r_hand()

	return

/obj/item/toy/katana
	name = "武士刀复制品"
	desc = "在D20里弱得可怜。"
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "katana"
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_BACK
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("attacks", "slashes", "stabs", "slices")


