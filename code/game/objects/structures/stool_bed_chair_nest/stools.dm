/obj/structure/bed/stool
	name = "凳子"
	desc = "把屁股放上去."
	icon_state = "stool"
	anchored = TRUE
	buckle_flags = NONE
	foldabletype = /obj/item/stool

/obj/item/stool
	name = "凳子"
	desc = "呃呵,酒吧开始热闹起来了."
	icon = 'icons/obj/objects.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/melee_right.dmi',
	)
	icon_state = "stool"
	force = 15
	throwforce = 12
	w_class = WEIGHT_CLASS_HUGE
	var/obj/structure/bed/stool/origin = null

/obj/item/stool/alt
	icon_state = "stool_alt"

/obj/item/stool/proc/deploy(mob/user)

	if(!origin)
		user.temporarilyRemoveItemFromInventory(src)
		qdel(src)
		return

	if(user)
		origin.loc = get_turf(user)
		user.temporarilyRemoveItemFromInventory(src)
		user.visible_message(span_notice("[user]把[src]放下."), span_notice("你把[src]放下."))
		qdel(src)

/obj/item/stool/attack_self(mob/user as mob)
	. = ..()
	deploy(user)

/obj/item/stool/attack(mob/M as mob, mob/user as mob)
	if(prob(25) && istype(M, /mob/living))
		user.visible_message(span_warning("[user]把[src]砸在[M]的背上!"))
		user.temporarilyRemoveItemFromInventory(src)
		var/obj/item/stack/sheet/metal/m = new/obj/item/stack/sheet/metal
		m.loc = get_turf(src)
		var/mob/living/T = M
		if(istype(T) && !isxeno(T))
			T.Paralyze(20 SECONDS)
		T.apply_damage(20, blocked = MELEE)
		UPDATEHEALTH(T)
		qdel(src)
		return
	return ..()
