/obj/item/reagent_containers/spray
	name = "喷雾瓶"
	desc = "一个喷雾瓶, 瓶盖可以拧开."
	icon = 'icons/obj/items/spray.dmi'
	icon_state = "cleaner"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/spray_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/spray_right.dmi',
	)
	worn_icon_state = "cleaner"
	reagent_flags = OPENCONTAINER_NOUNIT
	item_flags = NOBLUDGEON
	equip_slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 2
	throw_range = 10
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10) //Set to null instead of list, if there is only one.
	var/spray_size = 3
	var/list/spray_sizes = list(1,3)
	var/safety = FALSE
	volume = 250


/obj/item/reagent_containers/spray/afterattack(atom/A as mob|obj, mob/user)
	//this is what you get for using afterattack() TODO: make is so this is only called if attackby() returns 0 or something
	if(istype(A, /obj/item/storage) || istype(A, /obj/structure/table) || istype(A, /obj/structure/rack) || istype(A, /obj/structure/closet) \
	|| istype(A, /obj/item/reagent_containers) || istype(A, /obj/structure/sink) || istype(A, /obj/structure/janitorialcart || istype(A, /obj/structure/ladder)))
		return

	if((A.is_drainable() && !A.is_refillable()) && get_dist(src,A) <= 1)
		if(!A.reagents.total_volume)
			to_chat(user, span_warning("[A]是空的."))
			return

		if(reagents.holder_full())
			to_chat(user, span_warning("[src]是满的."))
			return

		var/trans = A.reagents.trans_to(src, A:amount_per_transfer_from_this)
		to_chat(user, span_notice("你把\the [src]装入了\the [A]中[trans]单位的内容物."))
		return

	if(reagents.total_volume < amount_per_transfer_from_this)
		to_chat(user, span_notice("[src]是空的!"))
		return

	if(safety)
		to_chat(user, span_warning("保险开着!"))
		return

	Spray_at(A)

	playsound(src.loc, 'sound/effects/spray2.ogg', 25, 1, 3)


/obj/item/reagent_containers/spray/proc/Spray_at(atom/A)
	var/obj/effect/decal/chempuff/D = new/obj/effect/decal/chempuff(get_turf(src))
	D.create_reagents(amount_per_transfer_from_this)
	reagents.trans_to(D, amount_per_transfer_from_this, 1 / spray_size)
	D.color = mix_color_from_reagents(D.reagents.reagent_list)

	INVOKE_ASYNC(src, PROC_REF(spray_step), A, D)

/obj/item/reagent_containers/spray/proc/spray_step(atom/our_atom, obj/effect/decal/chempuff/our_decal)
	var/turf/A_turf = get_turf(our_atom)//BS12
	var/spray_dist = spray_size
	for(var/i = 0, i < spray_dist, i++)
		step_towards(our_decal, our_atom)
		our_decal.reagents.reaction(get_turf(our_decal))
		for(var/atom/T in get_turf(our_decal))
			our_decal.reagents.reaction(T, VAPOR)
			// When spraying against the wall, also react with the wall, but
			// not its contents. BS12
			if(get_dist(our_decal, A_turf) == 1 && A_turf.density)
				our_decal.reagents.reaction(A_turf)
			sleep(0.2 SECONDS)
		sleep(0.3 SECONDS)
	qdel(our_decal)

/obj/item/reagent_containers/spray/attack_self(mob/user)
	if(!possible_transfer_amounts)
		return
	amount_per_transfer_from_this = next_in_list(amount_per_transfer_from_this, possible_transfer_amounts)
	spray_size = next_in_list(spray_size, spray_sizes)
	to_chat(user, span_notice("你调整了压力喷嘴. 你现在每次喷雾使用[amount_per_transfer_from_this]单位."))

/obj/item/reagent_containers/spray/verb/empty()

	set name = "Empty Spray Bottle"
	set category = "IC.Object"
	set src in usr

	if (tgui_alert(usr, "你确定要清空它吗?", "空瓶:", list("Yes", "No")) != "Yes")
		return
	if(isturf(usr.loc))
		to_chat(usr, span_notice("你把\the [src]倒在了地上."))
		reagents.reaction(usr.loc)
		addtimer(CALLBACK(reagents, TYPE_PROC_REF(/datum/reagents, clear_reagents)), 5)

//space cleaner
/obj/item/reagent_containers/spray/cleaner
	name = "太空清洁剂"
	desc = "BLAM!牌无泡沫太空清洁剂!"

/obj/item/reagent_containers/spray/cleaner/drone
	name = "太空清洁剂"
	desc = "BLAM!牌无泡沫太空清洁剂!"
	volume = 50


/obj/item/reagent_containers/spray/cleaner/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/space_cleaner, volume)


/obj/item/reagent_containers/spray/surgery
	name = "消毒喷雾"
	desc = "感染和坏死已成过去!"
	volume = 100
	list_reagents = list(/datum/reagent/space_cleaner = 50, /datum/reagent/sterilizine = 50)


//pepperspray
/obj/item/reagent_containers/spray/pepper
	name = "胡椒喷雾"
	desc = "由UhangInc制造, 用于快速致盲和击倒对手."
	icon_state = "pepperspray"
	worn_icon_state = "pepperspray"
	possible_transfer_amounts = null
	volume = 40
	safety = TRUE
	list_reagents = list(/datum/reagent/consumable/capsaicin/condensed = 40)

/obj/item/reagent_containers/spray/pepper/examine(mob/user)
	. = ..()
	if(get_dist(user,src) <= 1)
		. += "The safety is [safety ? "on" : "off"]."

/obj/item/reagent_containers/spray/pepper/attack_self(mob/user)
	safety = !safety
	to_chat(user, span_notice("你把保险[safety ? "on" : "off"]."))

//water flower
/obj/item/reagent_containers/spray/waterflower
	name = "水花"
	desc = "一朵看似无辜的向日葵...却暗藏玄机."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "sunflower"
	worn_icon_state = "sunflower"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = null
	volume = 10
	list_reagents = list(/datum/reagent/water = 10)

//chemsprayer
/obj/item/reagent_containers/spray/chemsprayer
	name = "化学喷雾器"
	desc = "一种用于在特定区域喷洒大量试剂的工具."
	icon_state = "chemsprayer"
	worn_icon_state = "chemsprayer"
	throwforce = 3
	w_class = WEIGHT_CLASS_NORMAL
	possible_transfer_amounts = null
	volume = 600


//this is a big copypasta clusterfuck, but it's still better than it used to be!
/obj/item/reagent_containers/spray/chemsprayer/Spray_at(atom/A as mob|obj)
	var/Sprays[3]
	for(var/i = 1, i <= 3, i++) // intialize sprays
		if(src.reagents.total_volume < 1) break
		var/obj/effect/decal/chempuff/D = new/obj/effect/decal/chempuff(get_turf(src))
		D.create_reagents(amount_per_transfer_from_this)
		src.reagents.trans_to(D, amount_per_transfer_from_this)

		D.color = mix_color_from_reagents(D.reagents.reagent_list)

		Sprays[i] = D

	INVOKE_ASYNC(src, PROC_REF(spray_step), A, null, Sprays)

/obj/item/reagent_containers/spray/chemspray/spray_step(atom/our_atom, obj/effect/decal/chempuff/our_decal, Sprays)
	var/direction = get_dir(src, our_atom)
	var/turf/T = get_turf(our_atom)
	var/turf/T1 = get_step(T,turn(direction, 90))
	var/turf/T2 = get_step(T,turn(direction, -90))
	var/list/the_targets = list(T, T1, T2)

	for(var/i = 1, length(i <= Sprays), i++)
		var/obj/effect/decal/chempuff/D = Sprays[i]
		if(!D)
			continue
		// Spreads the sprays a little bit
		var/turf/my_target = pick(the_targets)
		the_targets -= my_target

		for(var/j = 1, j <= rand(6, 8), j++)
			step_towards(D, my_target)
			D.reagents.reaction(get_turf(D))
			for(var/atom/t in get_turf(D))
				D.reagents.reaction(t, VAPOR)
			sleep(0.2 SECONDS)
		qdel(D)

// Plant-B-Gone
/obj/item/reagent_containers/spray/plantbgone // -- Skie
	name = "除草剂"
	desc = "杀死那些烦人的杂草!"
	icon_state = "plantbgone"
	worn_icon_state = "plantbgone"
	volume = 100
	list_reagents = list(/datum/reagent/toxin/plantbgone = 100)


/obj/item/reagent_containers/spray/plantbgone/afterattack(atom/A, mob/user, proximity)
	if(!proximity)
		return
	..()
