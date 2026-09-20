/obj/structure/bed/chair/janicart
	name = "清洁车"
	icon = 'icons/obj/vehicles.dmi'
	desc = "一位勇敢的清洁工赛博为了制造出这种速度与实用性的惊人结合体献出了生命."
	icon_state = "pussywagon"
	anchored = FALSE
	density = TRUE
	buildstacktype = null ///can't be disassembled and doesn't drop anything when destroyed
	buckle_flags = CAN_BUCKLE
	//copypaste sorry
	/// Shit I dunno, adding this so syringes stop runtime erroring. --NeoFite
	var/amount_per_transfer_from_this = 5
	var/obj/item/storage/bag/trash/mybag = null
	/// How do people refer to it?
	var/callme = "pimpin' ride"
	var/move_delay = 2

/obj/structure/bed/chair/janicart/Initialize(mapload)
	. = ..()
	create_reagents(100, OPENCONTAINER)

/obj/structure/bed/chair/janicart/examine(mob/user)
	. = ..()
	. += "This [callme] contains [reagents.total_volume] unit\s of water!"
	if(mybag)
		. += "\A [mybag] is hanging on the [callme]."

/obj/structure/bed/chair/janicart/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/tool/mop))
		if(reagents.total_volume <= 1)
			to_chat(user, span_notice("这个[callme]没水了!"))
			return

		reagents.trans_to(I, 2)
		to_chat(user, span_notice("你把[I]浸入[callme]中."))
		playsound(loc, 'sound/effects/slosh.ogg', 25, 1)

	else if(istype(I, /obj/item/key))
		to_chat(user, "驾驶这个[callme]时,你需要用一只手握住[I].")

	else if(istype(I, /obj/item/storage/bag/trash))
		to_chat(user, span_notice("你把垃圾袋挂到[callme]上."))
		user.drop_held_item()
		I.forceMove(src)
		mybag = I

/obj/structure/bed/chair/janicart/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(mybag)
		mybag.loc = get_turf(user)
		user.put_in_hands(mybag)
		mybag = null

/obj/structure/bed/chair/janicart/relaymove(mob/user, direction)
	if(world.time <= last_move_time + move_delay)
		return
	if(user.incapacitated(TRUE))
		unbuckle_mob(user)
	if(istype(user.l_hand, /obj/item/key) || istype(user.r_hand, /obj/item/key))
		step(src, direction)
	else
		to_chat(user, span_notice("驾驶这个[callme]时,你需要用一只手握住钥匙."))

/obj/item/key
	name = "钥匙"
	desc = "一个钥匙圈,上面有一把小钢钥匙,和一个粉色挂饰,写着\"Pussy Wagon\"."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "keys"
	w_class = WEIGHT_CLASS_TINY
