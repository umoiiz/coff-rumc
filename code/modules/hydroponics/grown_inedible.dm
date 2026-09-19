// **********************
// Other harvested materials from plants (that are not food)
// **********************

/obj/item/grown // Grown things that are not edible
	name = "种植武器"
	icon = 'icons/obj/items/weapons.dmi'
	var/plantname
	var/potency = 1

/obj/item/grown/Initialize(mapload)
	. = ..()

	var/datum/reagents/R = new/datum/reagents(50)
	reagents = R
	R.my_atom = WEAKREF(src)

/obj/item/grown/LateInitialize()
	. = ..()
	// Fill the object up with the appropriate reagents.
	if(isnull(plantname))
		return
	var/datum/seed/S = GLOB.seed_types[plantname]
	if(!S || !S.chems)
		return

	potency = S.potency

	for(var/rid in S.chems)
		var/list/reagent_data = S.chems[rid]
		var/rtotal = reagent_data[1]
		if(length(reagent_data) > 1 && potency > 0)
			rtotal += round(potency/reagent_data[2])
		reagents.add_reagent(rid,max(1,rtotal))

/obj/item/grown/log
	name = "高塔帽"
	name = "高塔帽原木"
	desc = "它比坏更好,它很棒!"
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "logs"
	force = 5
	atom_flags = NONE
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 3
	throw_range = 3
	attack_verb = list("bashes", "batters", "bludgeons", "whacks")

/obj/item/grown/log/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(I.sharp != IS_SHARP_ITEM_BIG)
		return

	user.show_message(span_notice("你用\the [src]制作木板!"), 1)
	var/obj/item/stack/sheet/wood/NG = new(user.loc, 2)
	NG.add_to_stacks(user)
	qdel(src)

/obj/item/grown/sunflower // FLOWER POWER!
	plantname = "sunflowers"
	name = "向日葵"
	desc = "真美!如果你踩到这些,某人可能会把你打死."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "sunflower"
	damtype = BURN
	force = 0
	atom_flags = NONE
	throwforce = 1
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 3

/obj/item/grown/sunflower/attack(mob/M as mob, mob/user as mob)
	to_chat(M, "<font color='green'><b>[user]用向日葵猛击你!</font><font color='yellow'><b>花朵之力<b></font>")
	to_chat(user, "<font color='green'>你的向日葵的</font><font color='yellow'><b>花朵之力</b></font><font color='green'>击中了[M]</font>")

/obj/item/grown/nettle // -- Skie
	plantname = "nettle"
	desc = "徒手触摸它可能<B>不</B>太明智..."
	icon = 'icons/obj/items/weapons.dmi'
	name = "荨麻"
	icon_state = "nettle"
	damtype = BURN
	force = 15
	atom_flags = NONE
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 1
	throw_range = 3
	attack_verb = list("stings")
	hitsound = ""
	var/potency_divisior = 5

/obj/item/grown/nettle/Initialize(mapload)
	. = ..()
	force = round(5 + potency / potency_divisior)

/obj/item/grown/nettle/pickup(mob/living/carbon/human/user as mob)
	if(istype(user) && !user.gloves)
		to_chat(user, span_warning("荨麻灼伤了你的裸手!"))
		if(ishuman(user))
			var/organ = ((user.hand ? "l_":"r_") + "arm")
			var/datum/limb/affecting = user.get_limb(organ)
			if(affecting.take_damage_limb(0, force))
				user.UpdateDamageIcon()
		else
			user.take_limb_damage(0, force)
			UPDATEHEALTH(user)
		return TRUE
	return FALSE

/obj/item/grown/nettle/proc/lose_leaves(mob/user)
	if(force > 0)
		playsound(loc, 'sound/weapons/bladeslice.ogg', 25, 1)
		force -= rand(1,(force/3)+1) // When you whack someone with it, leaves fall off

	sleep(0.1 SECONDS)

	if(force <= 0)
		if(user)
			to_chat(user, "由于猛烈拍打,\the [src]的所有叶子都掉光了.")
			user.temporarilyRemoveItemFromInventory(src)
		qdel(src)

/obj/item/grown/nettle/death // -- Skie
	plantname = "deathnettle"
	desc = "<span class='warning'>发光的\black 荨麻仅仅看着就让<span class='warning'><B>愤怒</B>\black 涌上你的心头!</span>"
	name = "死亡荨麻"
	icon_state = "deathnettle"
	potency_divisior = 2.5

/obj/item/grown/nettle/death/pickup(mob/living/carbon/human/user as mob)
	if(..() && prob(50))
		user.Unconscious(10 SECONDS)
		to_chat(user, span_warning("当你试图捡起死亡荨麻时,你被它击晕了!"))

/obj/item/grown/nettle/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(!..())
		return
	lose_leaves(user)

/obj/item/grown/nettle/death/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(!..())
		return
	if(isliving(M))
		to_chat(M, span_warning("你被死亡荨麻的强力酸液击晕了!"))

		log_combat(user, M, "hit", src)

		M.adjust_blurriness(force/7)
		if(prob(20))
			M.Unconscious(force/3 SECONDS)
			M.Paralyze(force/7.5 SECONDS)
		M.drop_held_item()

/obj/item/corncob
	name = "玉米棒"
	desc = "往昔餐食的回忆."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "corncob"
	worn_icon_state = "corncob"
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 4
	throw_range = 20

/obj/item/corncob/attackby(obj/item/I, mob/user, params)
	. = ..()

	if(I.sharp == IS_SHARP_ITEM_ACCURATE)
		to_chat(user, span_notice("你用[I]从玉米棒上制作了一个烟斗!"))
		new /obj/item/clothing/mask/cigarette/pipe/cobpipe(user.loc)
		qdel(src)
