/obj/structure/platform
	name = "平台"
	desc = "一个由四条腿支撑的方形金属表面."
	icon = 'icons/obj/structures/platforms.dmi'
	icon_state = "platform"
	coverage = 10
	density = TRUE
	layer = BELOW_OBJ_LAYER
	atom_flags = ON_BORDER
	resistance_flags = RESIST_ALL
	interaction_flags = INTERACT_CHECK_INCAPACITATED
	allow_pass_flags = PASS_LOW_STRUCTURE|PASSABLE|PASS_WALKOVER
	climbable = TRUE
	resistance_flags = XENO_DAMAGEABLE

/obj/structure/platform/Initialize(mapload)
	. = ..()
	update_icon()
	icon_state = null

	var/static/list/connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_try_exit),
		COMSIG_OBJ_TRY_ALLOW_THROUGH = PROC_REF(can_climb_over),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/platform/update_overlays()
	. = ..()
	var/image/new_overlay

	if(dir & EAST)
		new_overlay = image(icon, src, "[initial(icon_state)]_overlay", layer, EAST)
		new_overlay.pixel_x = 32
		. += new_overlay

	if(dir & WEST)
		new_overlay = image(icon, src, "[initial(icon_state)]_overlay", layer, WEST)
		new_overlay.pixel_x = -32
		. += new_overlay

	if(dir & NORTH)
		new_overlay = image(icon, src, "[initial(icon_state)]_overlay", layer, NORTH)
		new_overlay.pixel_y = 32
		new_overlay.layer = ABOVE_MOB_LAYER //perspective
		. += new_overlay

	if(dir & SOUTH)
		new_overlay = image(icon, src, "[initial(icon_state)]_overlay", layer, SOUTH)
		new_overlay.pixel_y = -32
		. += new_overlay

	if(CHECK_MULTIPLE_BITFIELDS(dir, NORTHEAST))
		new_overlay = image(icon, src, "[initial(icon_state)]_overlay", layer, NORTHEAST)
		new_overlay.pixel_y = 32
		new_overlay.pixel_x = 32
		new_overlay.layer = ABOVE_MOB_PLATFORM_LAYER
		. += new_overlay

	if(CHECK_MULTIPLE_BITFIELDS(dir, NORTHWEST))
		new_overlay = image(icon, src, "[initial(icon_state)]_overlay", layer, NORTHWEST)
		new_overlay.pixel_y = 32
		new_overlay.pixel_x = -32
		new_overlay.layer = ABOVE_MOB_PLATFORM_LAYER
		. += new_overlay

	if(CHECK_MULTIPLE_BITFIELDS(dir, SOUTHEAST))
		new_overlay = image(icon, src, "[initial(icon_state)]_overlay", layer, SOUTHEAST)
		new_overlay.pixel_y = -32
		new_overlay.pixel_x = 32
		. += new_overlay

	if(CHECK_MULTIPLE_BITFIELDS(dir, SOUTHWEST))
		new_overlay = image(icon, src, "[initial(icon_state)]_overlay", layer, SOUTHWEST)
		new_overlay.pixel_y = -32
		new_overlay.pixel_x = -32
		. += new_overlay

/obj/structure/platform/nondense
	density = FALSE
	climbable = FALSE
	coverage = 0

/obj/structure/platform/rockcliff
	icon_state = "rockcliff"
	name = "岩崖"
	desc = "一堆石头和岩石形成的陡峭悬崖,看起来可以攀爬."

/obj/structure/platform/rockcliff/orange
	icon_state = "rockcliff_orange"

/obj/structure/platform/rockcliff/red
	icon_state = "rockcliff_red"

/obj/structure/platform/rockcliff/icycliff
	icon_state = "icerock"

/obj/structure/platform/rockcliff/icycliff/nondense
	density = FALSE
	climbable = FALSE
	coverage = 0

/obj/structure/platform/metalplatform
	icon_state = "metalplatform"

/obj/structure/platform/metalplatform/nondense
	density = FALSE
	climbable = FALSE
	coverage = 0

/obj/structure/platform/trench
	icon_state = "platformtrench"
	name = "战壕壁"
	desc = "一组粗略切割的木板,构成挖好的战壕的侧壁."

/obj/structure/platform/trench/nondense
	density = FALSE
	climbable = FALSE
	coverage = 0

/obj/structure/platform/adobe
	name = "砖墙"
	desc = "一堵低矮的土坯砖墙."
	icon_state = "adobe"

/obj/structure/platform/adobe/nondense
	density = FALSE
	climbable = FALSE
	coverage = 0

//decorative corner platform bits
/obj/structure/platform_decoration
	name = "平台"
	desc = "一个由四条腿支撑的方形金属表面."
	icon = 'icons/obj/structures/platforms.dmi'
	icon_state = "platform_deco"
	atom_flags = ON_BORDER
	resistance_flags = RESIST_ALL
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/platform_decoration/Initialize(mapload)
	. = ..()
	switch(dir)
		if(NORTH)
			layer = ABOVE_MOB_PLATFORM_LAYER
		if(SOUTH)
			layer = ABOVE_MOB_PLATFORM_LAYER
		if(SOUTHEAST)
			layer = ABOVE_MOB_PLATFORM_LAYER
		if(SOUTHWEST)
			layer = ABOVE_MOB_PLATFORM_LAYER

/obj/structure/platform_decoration/rockcliff_deco
	icon_state = "rockcliff_deco"
	name = "岩崖"
	desc = "一堆石头和岩石形成的陡峭悬崖,看起来可以攀爬."

/obj/structure/platform_decoration/rockcliff_deco/orange
	icon_state = "rockcliff_orange_deco"

/obj/structure/platform_decoration/rockcliff_deco/red
	icon_state = "rockcliff_red_deco"

/obj/structure/platform_decoration/rockcliff_deco/icycliff_deco
	icon_state = "icerock_deco"

/obj/structure/platform_decoration/metalplatform_deco
	icon_state = "metalplatform_deco"

/obj/structure/platform_decoration/adobe_deco
	icon_state = "adobe_deco"
