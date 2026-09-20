/obj/item/shard
	name = "玻璃碎片"
	icon = 'icons/obj/items/shards.dmi'
	icon_state = ""
	sharp = IS_SHARP_ITEM_SIMPLE
	edge = 1
	desc = "大概可以用作...投掷武器?"
	w_class = WEIGHT_CLASS_TINY
	force = 5
	throwforce = 8
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/civilian_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/civilian_right.dmi',
	)
	worn_icon_state = "shard-glass"
	attack_verb = list("stabs", "slashes", "slices", "cuts")
	hitsound = 'sound/weapons/bladeslice.ogg'
	var/source_sheet_type = /obj/item/stack/sheet/glass/glass
	var/shardsize = TRUE

//Override to ignore the message
/obj/item/shard/ex_act(severity, explosion_direction)
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return

	if(!prob(severity * 0.3))
		INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/movable, explosion_throw), severity, explosion_direction)
		return
	deconstruct(FALSE)

/obj/item/shard/Initialize(mapload)
	. = ..()
	if(shardsize)
		var/size_icon = pick("large", "medium", "small")
		switch(size_icon)
			if("small")
				pixel_x = rand(-12, 12)
				pixel_y = rand(-12, 12)
			if("medium")
				pixel_x = rand(-8, 8)
				pixel_y = rand(-8, 8)
			if("large")
				pixel_x = rand(-5, 5)
				pixel_y = rand(-5, 5)
		icon_state += size_icon
	else
		pixel_x = rand(-12, 12)
		pixel_y = rand(-12, 12)
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_cross),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/item/shard/welder_act(mob/living/user, obj/item/tool/weldingtool/WT)
	. = ..()

	if(!source_sheet_type) //can be melted into something
		return
	if(!WT.remove_fuel(0, user))
		return
	var/obj/item/stack/sheet/NG = new source_sheet_type(user.loc)
	for(var/obj/item/stack/sheet/G in user.loc)
		if(G == NG)
			continue
		if(!istype(G, source_sheet_type))
			continue
		if(G.amount >= G.max_amount)
			continue
		G.attackby(NG, user)
		to_chat(user, "你将新形成的玻璃加入堆中。现在它包含[NG.amount]片。")
	qdel(src)

/obj/item/shard/proc/on_cross(datum/source, atom/movable/AM, oldloc, oldlocs)
	SIGNAL_HANDLER
	if(!isliving(AM))
		return

	var/mob/living/M = AM
	if(M.status_flags & INCORPOREAL)  //Flying over shards doesn't break them
		return
	//if (CHECK_MULTIPLE_BITFIELDS(M.pass_flags, HOVERING)) // ORIGINAL
	if(CHECK_MULTIPLE_BITFIELDS(M.pass_flags, PASS_LOW_STRUCTURE)) // RUTGMC EDITION
		return

	pick(playsound(loc, 'sound/effects/shard1.ogg', 35, TRUE), playsound(loc, 'sound/effects/shard2.ogg', 35, TRUE), playsound(loc, 'sound/effects/shard3.ogg', 35, TRUE), playsound(loc, 'sound/effects/shard4.ogg', 35, TRUE), playsound(loc, 'sound/effects/shard5.ogg', 35, TRUE))
	if(prob(20))
		to_chat(M, span_danger("[isxeno(M) ? "We" : "You"]踩到了\the [src],将其踩碎!"))
		qdel(src)
		return

	if(M.buckled)
		return
	to_chat(M, span_danger("[isxeno(M) ? "We" : "You"]踩到了\the [src]!"))
	if(!ishuman(M))
		return
	var/mob/living/carbon/human/H = M

	if(H.species.species_flags & ROBOTIC_LIMBS || H.species.species_flags & IS_INSULATED)
		return

	if(!H.shoes && !(H.wear_suit?.armor_protection_flags & FEET))
		INVOKE_ASYNC(src, PROC_REF(pierce_foot), H)

/obj/item/shard/proc/pierce_foot(mob/living/carbon/human/target)
	var/datum/limb/affecting = target.get_limb(pick("l_foot", "r_foot"))
	if(affecting.limb_status & LIMB_ROBOT)
		return
	target.Paralyze(6 SECONDS)

	if(affecting.take_damage_limb(5))
		UPDATEHEALTH(target)
		target.UpdateDamageIcon()

// Shrapnel

/obj/item/shard/shrapnel
	name = "弹片"
	icon = 'icons/obj/items/shards.dmi'
	icon_state = "shrapnel"
	desc = "一堆破碎金属的细小碎片。"
	source_sheet_type = null
	embedding = list("embedded_flags" = EMBEDDED_DEL_ON_HOLDER_DEL, "embed_chance" = 0, "embedded_fall_chance" = 0)
	var/damage_on_move = 0.5

/obj/item/shard/shrapnel/Initialize(mapload, new_name, new_desc)
	. = ..()
	if(!isnull(new_name))
		name = new_name
	if(!isnull(new_desc))
		desc += new_desc

/obj/item/shard/shrapnel/bone_chips
	name = "骨制弹片碎屑"
	desc = "看起来它来自一种史前动物。"
	icon_state = "bonechips"
	gender = PLURAL
	damage_on_move = 0.6
	shardsize = FALSE

/obj/item/shard/shrapnel/bone_chips/human
	name = "人类骨骼碎片"
	desc = "天哪,他们的碎片到处都是!"
	icon_state = "humanbonechips"
	shardsize = FALSE

/obj/item/shard/shrapnel/bone_chips/xeno
	name = "异形骨骼碎片"
	desc = "尖锐、参差不齐的异形骨骼碎片。看起来之前的主人猛烈爆炸了..."
	icon_state = "alienbonechips"
	shardsize = FALSE

/obj/item/shard/phoron
	name = "phoron碎片"
	desc = "一块phoron玻璃碎片。比普通玻璃碎片坚固得多。显然还不够坚固到能当窗户。"
	force = 8
	throwforce = 15
	icon_state = "phoron"
	source_sheet_type = /obj/item/stack/sheet/glass/phoronglass
