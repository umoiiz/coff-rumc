/obj/structure/shuttle
	name = "穿梭机"
	icon = 'icons/turf/shuttle.dmi'
	allow_pass_flags = PASS_PROJECTILE|PASS_AIR

/obj/structure/shuttle/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_SPARKS, -40, 8, 1)

/obj/structure/shuttle/window
	name = "穿梭机窗户"
	icon = 'icons/obj/podwindows.dmi'
	icon_state = "1"
	density = TRUE
	opacity = FALSE
	anchored = TRUE
	resistance_flags = RESIST_ALL
	layer = ABOVE_WINDOW_LAYER

/obj/structure/shuttle/engine
	name = "引擎"
	density = TRUE
	anchored = TRUE
	resistance_flags = RESIST_ALL

/obj/structure/shuttle/engine/heater
	name = "加热引擎"
	icon_state = "heater"

/obj/structure/shuttle/engine/platform
	name = "平台"
	icon_state = "platform"

/obj/structure/shuttle/engine/propulsion
	name = "推进引擎"
	icon_state = "propulsion"
	opacity = TRUE

/obj/structure/shuttle/engine/propulsion/burst
	name = "爆发推进引擎"

/obj/structure/shuttle/engine/propulsion/burst/left
	name = "左推进引擎"
	icon_state = "burst_l"

/obj/structure/shuttle/engine/propulsion/burst/right
	name = "右推进引擎"
	icon_state = "burst_r"

/obj/structure/shuttle/engine/router
	name = "路由引擎"
	icon_state = "router"
