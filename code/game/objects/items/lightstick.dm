

//Lightsticks----------
//Blue
/obj/item/lightstick
	name = "蓝色荧光棒"
	desc = "你可以把它们插在地上"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "lightstick_blue0"
	var/s_color = "blue"

/obj/item/lightstick/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_cross),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/item/lightstick/proc/on_cross(datum/source, mob/living/L, oldloc, oldlocs)
	if(!anchored || !istype(L) || isxenolarva(L))
		return
	if(L.mob_size != MOB_SIZE_BIG && prob(80))
		return
	visible_message(span_danger("[L]踩碎了[src]!"))
	playsound(src, 'sound/weapons/genhit.ogg', 25, 1)
	if(isxeno(L) && prob(40))
		qdel(src)
		return
	anchored = FALSE
	icon_state = "lightstick_[s_color][anchored]"
	set_light(0,0)

	//Removing from turf
/obj/item/lightstick/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!anchored)//If planted
		return

	to_chat(user, "你开始拔出\the [src].")
	if(!do_after(user,20, NONE, src, BUSY_ICON_GENERIC))
		return

	anchored = FALSE
	user.visible_message("[user.name]从地上拔出了\the [src].","你从地上拔出了[src].")
	icon_state = "lightstick_[s_color][anchored]"
	set_light(0,0)
	playsound(user, 'sound/weapons/genhit.ogg', 25, 1)

/obj/item/lightstick/anchored
	icon_state = "lightstick_blue1"
	anchored = TRUE


/obj/item/lightstick/anchored/Initialize(mapload, ...)
	. = ..()
	set_light(2, l_color = LIGHT_COLOR_CYAN)


//Red
/obj/item/lightstick/red
	name = "红色荧光棒"
	icon_state = "lightstick_red0"
	s_color = "red"

/obj/item/lightstick/red/anchored
	icon_state = "lightstick_red1"
	anchored = TRUE


/obj/item/lightstick/red/anchored/Initialize(mapload, ...)
	. = ..()
	set_light(2, l_color = COLOR_RED)
