/obj/structure/displaycase
	name = "展示柜"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "glassbox1"
	desc = "用来存放珍贵物品的展示柜. 它挑衅着你去踢它一脚."
	density = TRUE
	anchored = TRUE
	resistance_flags = UNACIDABLE
	max_integrity = 30
	var/occupied = 1
	var/destroyed = 0

/obj/structure/displaycase/update_icon_state()
	. = ..()
	if(destroyed)
		icon_state = "glassboxb[occupied]"
	else
		icon_state = "glassbox[occupied]"

/obj/structure/displaycase/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	if(destroyed && occupied)
		to_chat(user, span_notice("你关闭了展示柜内置的悬浮场."))
		occupied = FALSE
		update_icon()
		return

	visible_message(span_warning("[user]踢了展示柜."), span_notice("你踢了展示柜."))
	take_damage(2, BRUTE, MELEE)

//Quick destroyed case.
/obj/structure/displaycase/destroyed
	icon_state = "glassboxb0"
	max_integrity = 0
	occupied = FALSE
	destroyed = TRUE
	coverage = 0
