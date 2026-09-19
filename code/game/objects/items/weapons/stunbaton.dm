/obj/item/weapon/baton
	name = "电击棍"
	desc = "一根用于制服人员的电击棍."
	icon_state = "stunbaton"
	worn_icon_state = "baton"
	equip_slot_flags = ITEM_SLOT_BELT
	force = 15
	sharp = 0
	edge = 0
	throwforce = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("beats")
	req_one_access = list(ACCESS_MARINE_BRIG, ACCESS_MARINE_ARMORY, ACCESS_MARINE_CAPTAIN, ACCESS_NT_CORPORATE, ACCESS_NT_PMC_GREEN)
	var/stunforce = 10
	var/agonyforce = 80
	///whether the thing is on or not
	var/status = 0
	var/obj/item/cell/bcell = null
	///oh god why do power cells carry so much charge? We probably need to make a distinction between "industrial" sized power cells for APCs and power cells for everything else.
	var/hitcost = 1000
	///whether the baton prevents people without correct access from using it.
	var/has_user_lock = TRUE

/obj/item/weapon/baton/Initialize(mapload)
	. = ..()
	bcell = new/obj/item/cell/high(src)
	update_icon()

/obj/item/weapon/baton/proc/deductcharge(chrgdeductamt)
	if(!bcell)
		return
	if(bcell.use(chrgdeductamt))
		return TRUE
	status = 0
	update_icon()
	return FALSE

/obj/item/weapon/baton/update_icon_state()
	. = ..()
	if(status)
		icon_state = "[initial(name)]_active"
	else if(!bcell)
		icon_state = "[initial(name)]_nocell"
	else
		icon_state = "[initial(name)]"

/obj/item/weapon/baton/examine(mob/user)
	. = ..()
	if(bcell)
		. += span_notice("电击棍已充能[round(bcell.percent())]%.")
	else
		. += span_warning("电击棍没有安装电源.")

/obj/item/weapon/baton/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	check_user_auth(user)

/obj/item/weapon/baton/equipped(mob/user, slot)
	. = ..()
	check_user_auth(user)

//checks if the mob touching the baton has proper access
/obj/item/weapon/baton/proc/check_user_auth(mob/user)
	if(!has_user_lock)
		return TRUE
	var/mob/living/carbon/human/H = user
	if(istype(H))
		var/obj/item/card/id/I = H.wear_id
		if(!istype(I) || !check_access(I))
			H.visible_message(span_notice("[src]发出哔哔声，[H]将它捡起"), span_danger("警告：检测到未授权用户。拒绝访问..."))
			H.Paralyze(40 SECONDS)
			H.visible_message(span_warning("[src]发出哔哔声并向[H]的身体发送电击！"))
			deductcharge(hitcost)
			return FALSE
	return TRUE

/obj/item/weapon/baton/pull_response(mob/puller)
	return check_user_auth(puller)

/obj/item/weapon/baton/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/cell))
		if(bcell)
			to_chat(user, span_notice("[src]已经装有电池。"))
			return

		if(!user.drop_held_item())
			return

		I.forceMove(src)
		bcell = I
		to_chat(user, span_notice("你在[src]中安装了一块电池。"))

	else if(isscrewdriver(I))
		if(!bcell)
			return

		bcell.forceMove(get_turf(src))
		bcell.update_icon()
		bcell = null
		to_chat(user, span_notice("你从[src]中取出了电池。"))
		status = 0

	update_icon()

/obj/item/weapon/baton/attack_self(mob/user)
	if(has_user_lock && user.skills.getRating(SKILL_POLICE) < SKILL_POLICE_MP)
		to_chat(user, span_warning("你似乎不知道如何使用[src]..."))
		return
	if(bcell?.charge > hitcost)
		status = !status
		to_chat(user, span_notice("[src]现在是[status ? "on" : "off"]。"))
		playsound(loc, SFX_SPARKS, 25, 1, 6)
		update_icon()
	else
		status = 0
		if(!bcell)
			to_chat(user, span_warning("[src]没有电源！"))
		else
			to_chat(user, span_warning("[src]电量耗尽。"))

/obj/item/weapon/baton/attack(mob/M, mob/user)
	if(M.status_flags & INCORPOREAL || user.status_flags & INCORPOREAL) //Incorporeal beings cannot attack or be attacked
		return

	if(has_user_lock && user.skills.getRating(SKILL_POLICE) < SKILL_POLICE_MP)
		to_chat(user, span_warning("你似乎不知道如何使用[src]..."))
		return

	var/stamloss_applied = agonyforce
	var/stun_applied = stunforce
	var/mob/living/L = M

	var/target_zone = check_zone(user.zone_selected)
	if(user.a_intent == INTENT_HARM)
		if (!..())	//item/attack() does it's own messaging and logs
			return 0	// item/attack() will return 1 if they hit, 0 if they missed.
		stamloss_applied *= 0.5	//whacking someone causes a much poorer contact than prodding them.
		stun_applied *= 0.5
		//we can't really extract the actual hit zone from ..(), unfortunately. Just act like they attacked the area they intended to.
	else
		//copied from human_defense.dm - human defence code should really be refactored some time.
		if (ishuman(L))

			if (user != L) // Attacking yourself can't miss
				target_zone = get_zone_with_miss_chance(user.zone_selected, L)

			if(!target_zone)
				L.visible_message(span_danger("[user]用\the [src]攻击[L]但未命中！"))
				return 0

			var/mob/living/carbon/human/H = L
			var/datum/limb/affecting = H.get_limb(target_zone)
			if (affecting)
				if(!status)
					L.visible_message(span_warning("[L]被[user]用[src]戳中了[affecting.display_name]。幸运的是它是关闭的。"))
					return 1
				else
					H.visible_message(span_danger("[L]被[user]用[src]戳中了[affecting.display_name]！"))
		else
			if(!status)
				L.visible_message(span_warning("[L]被[user]用[src]戳中了。幸运的是它是关闭的。"))
				return 1
			else
				L.visible_message(span_danger("[L]被[user]用[src]戳中了！"))

	//stun effects
	if(!HAS_TRAIT(L, TRAIT_BATONIMMUNE))
		L.apply_effects(stun = stun_applied, stutter = stamloss_applied * 0.1, eye_blur = stamloss_applied * 0.1, stamloss = stamloss_applied)
		L.ParalyzeNoChain(8 SECONDS)

	playsound(loc, 'sound/weapons/egloves.ogg', 25, 1, 6)
	log_combat(user, L, "stunned", src)

	deductcharge(hitcost)

	return TRUE

/obj/item/weapon/baton/emp_act(severity)
	. = ..()
	if(bcell)
		bcell.emp_act(severity)	//let's not duplicate code everywhere if we don't have to please.

//Makeshift stun baton. Replacement for stun gloves.
/obj/item/weapon/baton/cattleprod
	name = "电击棒"
	desc = "一种简易的电击棍。"
	icon_state = "stunprod_nocell"
	worn_icon_state = "prod"
	force = 3
	throwforce = 5
	stunforce = 0
	agonyforce = 60	//same force as a stunbaton, but uses way more charge.
	hitcost = 2500
	attack_verb = list("pokes")
	equip_slot_flags = NONE
	has_user_lock = FALSE

/obj/item/weapon/stunprod
	name = "电击赶牛棒"
	desc = "一种专门设计用于使异形生命体丧失行动能力的赶牛棒。"
	icon_state = "stunbaton"
	worn_icon_state = "baton"
	equip_slot_flags = ITEM_SLOT_BELT
	force = 12
	throwforce = 7
	w_class = WEIGHT_CLASS_NORMAL
	var/charges = 12
	var/status = 0

/obj/item/weapon/stunprod/update_icon_state()
	. = ..()
	if(status)
		icon_state = "stunbaton_active"
	else
		icon_state = "stunbaton"

/obj/item/weapon/stunprod/attack_self(mob/user)
	if(charges > 0)
		status = !status
		to_chat(user, span_notice("\The [src]现在是[status ? "on" : "off"]。"))
		playsound(loc, SFX_SPARKS, 15, 1)
		update_icon()
	else
		status = 0
		to_chat(user, span_warning("\The [src]电量耗尽。"))

/obj/item/weapon/stunprod/attack(mob/M, mob/user)
	if(user.a_intent == INTENT_HARM)
		return

	else if(!status)
		M.visible_message(span_warning("[M]在关闭状态下被[user]用[src]戳了一下。"))
		return

	if(status && isliving(M))
		var/mob/living/L = M
		L.Paralyze(12 SECONDS)
		charges -= 2
		L.visible_message(span_danger("[L]被[user]用[src]戳中了！"))

		log_combat(user, L, "stunned", src)

		playsound(loc, 'sound/weapons/egloves.ogg', 25, 1)
		if(charges < 1)
			status = 0
			update_icon()

/obj/item/weapon/stunprod/emp_act(severity)
	. = ..()
	if(severity == EMP_DEVASTATE)
		charges = 0
	else
		charges = max(0, charges - (6 - severity))
	if(charges < 1)
		status = 0
		update_icon()

/obj/item/weapon/stunprod/improved
	charges = 30
	name = "改进型电击赶牛棒"
	desc = "一种专门设计用于使异形生命体丧失行动能力的赶牛棒。这一把似乎比前代有效得多。"
	color = "#FF6666"

/obj/item/weapon/stunprod/improved/attack(mob/M, mob/user)
	. = ..()
	if(!isliving(M))
		return
	var/mob/living/L = M
	L.Paralyze(28 SECONDS)

/obj/item/weapon/stunprod/improved/examine(mob/user)
	. = ..()
	. += span_notice("它还剩[charges]次充能。")
