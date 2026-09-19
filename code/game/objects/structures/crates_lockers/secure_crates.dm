/obj/structure/closet/crate/secure
	desc = "一个安全箱."
	name = "安全箱"
	icon_state = "secure_locked_basic"
	icon_opened = "secure_open_basic"
	icon_closed = "secure_locked_basic"
	closet_flags = CLOSET_ALLOW_OBJS|CLOSET_ALLOW_DENSE_OBJ|CLOSET_IS_SECURE
	var/icon_locked = "secure_locked_basic"
	var/icon_unlocked = "secure_unlocked_basic"
	var/sparks = "securecratesparks"
	locked = TRUE
	max_integrity = 500
	soft_armor = list(MELEE = 30, BULLET = 50, LASER = 50, ENERGY = 100, BOMB = 0, BIO = 0, FIRE = 80, ACID = 80)


/obj/structure/closet/crate/secure/Initialize(mapload, ...)
	. = ..()
	update_icon()

/obj/structure/closet/crate/secure/update_icon_state()
	. = ..()
	if(opened)
		icon_state = icon_opened
	else
		icon_state = locked ? icon_locked : icon_unlocked

/obj/structure/closet/crate/secure/update_overlays()
	. = ..()
	if(welded)
		. += overlay_welded

/obj/structure/closet/crate/secure/can_open()
	return !locked

/obj/structure/closet/crate/secure/verb/verb_togglelock()
	set src in oview(1) // One square distance
	set category = "IC.Object"
	set name = "Toggle Lock"

	if(usr.incapacitated())
		return
	togglelock(usr)

/obj/structure/closet/crate/secure/emp_act(severity)
	. = ..()
	for(var/obj/O in src)
		O.emp_act(severity)
	if(!broken && !opened  && prob(50 / severity))
		if(!locked)
			locked = 1
		else
			overlays.Cut()
			overlays += sparks
			addtimer(CALLBACK(src, PROC_REF(clear_sparks)), 0.6 SECONDS)
			playsound(src.loc, 'sound/effects/sparks4.ogg', 25, 1)
			locked = 0
		update_icon()
	if(!opened && prob(20 / severity))
		if(!locked)
			open()
		else
			req_access = list()
			req_access += pick(ALL_ACCESS)
			
/// Used in emp_act to clear sparks with delay
/obj/structure/closet/crate/secure/proc/clear_sparks()
	overlays -= sparks

//------------------------------------
//			Secure Crates
//------------------------------------

/obj/structure/closet/crate/secure/ammo
	name = "安全弹药箱"
	desc = "一个安全弹药箱"
	icon_state = "secure_locked_ammo"
	icon_opened = "secure_open_ammo"
	icon_locked = "secure_locked_ammo"
	icon_unlocked = "secure_unlocked_ammo"

/obj/structure/closet/crate/secure/explosives
	name = "爆炸物箱"
	desc = "爆炸物箱"
	icon_state = "secure_locked_explosives"
	icon_opened = "secure_open_explosives"
	icon_locked = "secure_locked_explosives"
	icon_unlocked = "secure_unlocked_explosives"

// Needs to be converted to new system that does not use overlays
// using default secure crate for now
/obj/structure/closet/crate/secure/phoron
	name = "phoron箱"
	desc = "一个安全的phoron箱."

// Needs to be converted to new system that does not use overlays
// using Wayland crate for now
/obj/structure/closet/crate/secure/gear
	name = "装备箱"
	desc = "一个安全的装备箱."
	icon_state = "secure_locked_nanotrasen"
	icon_opened = "secure_open_nanotrasen"
	icon_locked = "secure_locked_nanotrasen"
	icon_unlocked = "secure_unlocked_nanotrasen"

/obj/structure/closet/crate/secure/hydrosec
	name = "安全水培箱"
	desc = "一个带锁的箱子, 涂有空间站植物学家的配色."
	icon_state = "secure_locked_hydro"
	icon_opened = "secure_open_hydro"
	icon_locked = "secure_locked_hydro"
	icon_unlocked = "secure_unlocked_hydro"

/obj/structure/closet/crate/secure/surgery
	name = "手术箱"
	desc = "一个手术箱."
	icon_state = "secure_locked_surgery"
	icon_opened = "secure_open_surgery"
	icon_locked = "secure_locked_surgery"
	icon_unlocked = "secure_unlocked_surgery"

/obj/structure/closet/crate/secure/weapon
	name = "武器箱"
	desc = "一个安全的武器箱."
	icon_state = "secure_locked_weapons"
	icon_opened = "secure_open_weapons"
	icon_locked = "secure_locked_weapons"
	icon_unlocked = "secure_unlocked_weapons"

/obj/structure/closet/crate/secure/nanotrasen
	name = "安全Nanotrasen箱"
	desc = "一个带有Nanotrasen标志的安全箱."
	icon_state = "secure_locked_nanotrasen"
	icon_opened = "secure_open_nanotrasen"
	icon_locked = "secure_locked_nanotrasen"
	icon_unlocked = "secure_unlocked_nanotrasen"
