/obj/effect/abstract/ripple
	name = "ship shadow"
	desc = "有东西正在抵达\
		当正在抵达的东西穿过时, 最好不要站在这些\
		上面."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shadow"
	anchored = TRUE
	density = FALSE
	layer = RIPPLE_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 0

/obj/effect/abstract/ripple/Initialize(mapload, time_left)
	. = ..()
	notify_ai_hazard()
	animate(src, alpha=150, time=time_left)
