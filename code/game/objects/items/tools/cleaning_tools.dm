/obj/item/tool/mop
	desc = "没有拖把, janitalia的世界就不完整."
	name = "拖把"
	icon = 'icons/obj/janitor.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/janitor_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/janitor_right.dmi',
	)
	icon_state = "mop"
	force = 3
	throwforce = 10
	throw_speed = 5
	throw_range = 10
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("mops", "bashes", "bludgeons", "whacks")
	var/mopping = 0
	var/mopcount = 0


/obj/item/tool/mop/Initialize(mapload)
	. = ..()
	create_reagents(5)

/turf/proc/clean(atom/source)
	if(source.reagents.has_reagent(/datum/reagent/water, 1))
		clean_blood()
		for(var/obj/effect/O in src)
			if(istype(O,/obj/effect/rune) || istype(O,/obj/effect/decal/cleanable) || istype(O,/obj/effect/overlay))
				qdel(O)
	source.reagents.reaction(src, TOUCH, 10)	//10 is the multiplier for the reaction effect. probably needed to wet the floor properly.
	source.reagents.remove_any(1)				//reaction() doesn't use up the reagents


/obj/item/tool/mop/afterattack(atom/A, mob/user, proximity)
	if(!proximity) return
	if(istype(A, /turf) || istype(A, /obj/effect/decal/cleanable) || istype(A, /obj/effect/overlay) || istype(A, /obj/effect/rune))
		if(reagents.total_volume < 1)
			balloon_alert(user, "拖把是干的")
			return

		var/turf/T = get_turf(A)
		user.visible_message(span_warning("[user]开始清理\the [T]。"))

		if(do_after(user, 40, NONE, T, BUSY_ICON_GENERIC))
			T.clean(src)
			balloon_alert(user, "拖地完毕")


/obj/item/tool/wet_sign
	name = "小心地滑标志"
	desc = "小心! 地滑!"
	icon_state = "caution"
	icon = 'icons/obj/janitor.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/janitor_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/janitor_right.dmi',
	)
	force = 1
	throwforce = 3
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("warns", "cautions", "smashes")

/obj/item/clothing/head/warning_cone
	name = "警示锥"
	desc = "这个锥桶正试图警告你什么!"
	icon_state = "cone"
	icon = 'icons/obj/janitor.dmi'
	worn_icon_list = list(slot_head_str = 'icons/mob/clothing/headwear/head_0.dmi')
	force = 1
	throwforce = 3
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("warns", "cautions", "smashes")
	soft_armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 15, BIO = 10, FIRE = 20, ACID = 20)
	species_exception = list(/datum/species/robot)


/obj/item/tool/soap
	name = "肥皂"
	desc = "一块廉价的肥皂。没什么味道。"
	gender = PLURAL
	icon = 'icons/obj/janitor.dmi'
	icon_state = "soap"
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 4
	throw_range = 20
	var/stun_time = 0.3 SECONDS
	var/paralyze_time = 0.2 SECONDS
	var/slip_xeno = FALSE

/obj/item/tool/soap/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, stun_time, paralyze_time, slip_xeno = slip_xeno)


/obj/item/tool/soap/afterattack(atom/target, mob/user as mob, proximity)
	if(!proximity)
		return
	//I couldn't feasibly  fix the overlay bugs caused by cleaning items we are wearing.
	//So this is a workaround. This also makes more sense from an IC standpoint. ~Carn
	if(user.client && (target in user.client.screen))
		balloon_alert(user, "先取下[target.name]")
	else if(isturf(target))
		balloon_alert(user, "擦洗\the [target.name]")
		var/turf/target_turf = target
		target_turf.wash()
	else if(istype(target,/obj/effect/decal/cleanable))
		balloon_alert(user, "擦洗掉\the [target.name]")
		qdel(target)
	else
		balloon_alert(user, "清洁\the [target.name]")
		target.wash()

/obj/item/tool/soap/attack(mob/target, mob/user)
	if(target && user && ishuman(target) && ishuman(user) && !target.stat && !user.stat && user.zone_selected == "mouth" )
		balloon_alert_to_viewers("用肥皂洗嘴")
		return

/obj/item/tool/soap/nanotrasen
	desc = "一块纳米传讯品牌的肥皂。闻起来有phoron的味道。"
	icon_state = "soapnt"

/obj/item/tool/soap/deluxe
	icon_state = "soapdeluxe"

/obj/item/tool/soap/deluxe/Initialize(mapload)
	. = ..()
	desc = "A deluxe Waffle Co. brand bar of soap. Smells of [pick("lavender", "vanilla", "strawberry", "chocolate" ,"space")]."

/obj/item/tool/soap/syndie
	desc = "一块不可信的肥皂。闻起来有恐惧的味道。"
	icon_state = "soapsyndie"

/obj/item/tool/soap/clown
	desc = "一块粉色的肥皂。闻起来有honk的味道。"
	icon_state = "soapclown"
	stun_time = 1.2 SECONDS
	paralyze_time = 1 SECONDS
	slip_xeno = TRUE
