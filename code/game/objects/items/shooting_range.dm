#define TARGETTING_DUMMY_USE_DELAY 20
#define TARGETTING_DUMMY_WELD_DELAY 10

// Targets, the things that actually get shot!
/obj/item/target
	name = "射击靶"
	desc = "一个射击靶。"
	icon = 'icons/obj/objects.dmi'
	icon_state = "target_h"
	density = FALSE
	resistance_flags = INDESTRUCTIBLE

/obj/item/target/default
	desc = "一个具有明显人类轮廓的射击靶。"

/obj/item/target/syndicate
	icon_state = "target_s"
	desc = "一个看起来像敌对特工的射击靶。"

/obj/item/target/alien
	icon_state = "target_q"
	desc = "一个具有威胁性剪影的射击靶。"

///Basically these are for the firing range
/obj/structure/target_stake
	name = "靶架"
	desc = "一个带有负磁化轮子的薄平台。"
	icon = 'icons/obj/objects.dmi'
	icon_state = "target_stake"
	density = TRUE
	atom_flags = CONDUCT
	max_integrity = 15000 //important that what the marines are shooting at doesn't break, we don't make it invulnerable because we still need to plasma cutter it sometimes
	soft_armor = list(MELEE = 80, BULLET = 100, LASER = 100, ENERGY = 100, BOMB = 120, BIO = 100, FIRE = 100, ACID = 0)
	///ungas need to actually hit this
	coverage = 90

/obj/structure/target_stake/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(!istype(I, /obj/item/target))
		return
	var/obj/item/target/targetcushion = I
	to_chat(user, "你开始将靶子装到靶架上。")
	if(!do_after(user, TARGETTING_DUMMY_USE_DELAY, NONE, src, BUSY_ICON_FRIENDLY))
		return
	if(istype(targetcushion, /obj/item/target/default))
		new /obj/structure/target_stake/occupied(loc)
	else if(istype(targetcushion, /obj/item/target/alien))
		new /obj/structure/target_stake/occupied/alien(loc)
	else if(istype(targetcushion, /obj/item/target/syndicate))
		new /obj/structure/target_stake/occupied/syndicate(loc)
	else //default to a regular human target
		new /obj/structure/target_stake/occupied(loc)
	to_chat(user, "你将靶子滑入靶架。")
	qdel(src) //delete original target_stake
	qdel(I) //delete targetting dummy in users hand

///These are occupied variations for targetting stakes
/obj/structure/target_stake/occupied
	desc = "一个带有负磁化轮子的薄平台,上面似乎安装了一个靶子假人."
	icon_state = "target_stake_target_h"
	///what kind of target to drop when a player removes a dummy from the targetting stake
	var/cushion_type = "default"

/obj/structure/target_stake/occupied/welder_act(mob/living/user, obj/item/I)
	. = ..()
	var/obj/item/tool/weldingtool/usedwelder = I
	if(!do_after(user, TARGETTING_DUMMY_WELD_DELAY, NONE, src, BUSY_ICON_FRIENDLY))
		return
	if(usedwelder.remove_fuel(2, user))
		overlays.Cut()
		obj_integrity = max_integrity
		to_chat(usr, "你切掉[src]上不平整的铝块并修补弹孔,它看起来几乎全新.")
		return

/obj/structure/target_stake/occupied/alien
	icon_state = "target_stake_target_q"
	cushion_type = "alien"

/obj/structure/target_stake/occupied/syndicate
	icon_state = "target_stake_target_s"
	cushion_type = "syndicate"

/obj/structure/target_stake/occupied/attack_hand(mob/living/user)
	to_chat(user, "你开始从木桩上取下靶子.")
	if(!do_after(user, TARGETTING_DUMMY_USE_DELAY, NONE, src, BUSY_ICON_FRIENDLY))
		return
	///create new target stake to create the illusion of a new one
	new /obj/structure/target_stake(loc)
	if(obj_integrity < 2000) //if critically damaged we don't give the user a new target dummy after removal
		to_chat(user, "当你从木桩上取下靶子的最后碎片时,你得出结论,这堆残骸没有什么值得回收的.")
		qdel(src)
		return
	///dump new target at the foot of the user
	switch(cushion_type)
		if("default")
			new /obj/item/target/default(get_turf(user))
		if("alien")
			new /obj/item/target/alien(get_turf(user))
		if("syndicate")
			new /obj/item/target/syndicate(get_turf(user))
	to_chat(user, "你把靶子从木桩上取下来.")
	qdel(src)

/obj/structure/target_stake/occupied/examine(mob/user)
	. = ..()
	switch(obj_integrity)
		if(10000 to INFINITY)
			. += span_info("它看起来状况良好.")
		if(5000 to 10000)
			. += span_warning("它有些损坏,但仍然适合用于打靶练习.")
		if(2000 to 5000)
			. += span_warning("它布满了弹孔,并且略微下垂..")
		if(-INFINITY to 2000)
			. += span_warning("它几乎什么都不剩了,已经被撕碎了.")

#undef TARGETTING_DUMMY_USE_DELAY
#undef TARGETTING_DUMMY_WELD_DELAY
