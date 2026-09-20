/obj/structure/rock
	name = "岩石"
	desc = "一块岩石.你不应该看到这个."
	icon = 'icons/obj/flora/rocks2.dmi'
	icon_state = "basalt"
	max_integrity = 250
	coverage = 100
	soft_armor = list(MELEE = 75, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 30, BIO = 100, FIRE = 100, ACID = 25)
	density = TRUE
	anchored = TRUE
	layer = ABOVE_NORMAL_TURF_LAYER
	allow_pass_flags = PASSABLE|PASS_DEFENSIVE_STRUCTURE

/obj/structure/rock/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_ROCK, -40, 5, 1)

/obj/structure/rock/basalt
	name = "火山岩"
	desc = "一块火山岩.先驱者们曾骑着这些宝贝驰骋数英里."
	icon = 'icons/obj/flora/rocks2.dmi'
	icon_state = "basalt_1"

/obj/structure/rock/basalt/alt
	name = "火山岩"
	icon_state = "basalt_2"

/obj/structure/rock/basalt/alt2
	name = "火山岩"
	icon_state = "basalt_3"

/obj/structure/rock/basalt/alt3
	name = "火山岩"
	icon_state = "basalt_4"

/obj/structure/rock/basalt/alt4
	name = "火山岩"
	icon_state = "basalt_5"
	color = "#c7bdbd"

/obj/structure/rock/basalt/alt5
	name = "火山岩"
	icon_state = "basalt_6"
	color = "#c7bdbd"

/obj/structure/rock/basalt/alt6
	name = "火山岩"
	icon_state = "basalt_7"
	color = "#c7bdbd"

/obj/structure/rock/basalt/alt7
	name = "火山岩"
	icon_state = "basalt_8"
	color = "#c7bdbd"

/obj/structure/rock/basalt/alt8
	name = "火山岩"
	icon_state = "basalt_9"
	color = "#c7bdbd"

/obj/structure/rock/basalt/alt9
	name = "火山岩"
	icon_state = "basalt_10"
	color = "#c7bdbd"

/obj/structure/rock/basalt/alt10
	name = "火山岩"
	icon_state = "basalt_11"
	color = "#c7bdbd"

/obj/structure/rock/basalt/alt11
	name = "火山岩"
	icon_state = "basalt_12"
	color = "#c7bdbd"

/obj/structure/rock/basalt/alt12
	name = "火山岩"
	icon_state = "basalt_13"
	color = "#c7bdbd"

/obj/structure/rock/basalt/alt13
	name = "火山岩"
	icon_state = "basalt_14"
	color = "#c7bdbd"

/obj/structure/rock/basalt/large_boulder
	name = "巨型火山岩"
	icon = 'icons/obj/flora/rock_large.dmi'
	icon_state = "boulder_1"
	color = "#c7bdbd"
	bound_height = 64
	bound_width = 64
	max_integrity = 1200

/obj/structure/rock/basalt/large_boulder/altone
	icon_state = "boulder_2"

/obj/structure/rock/basalt/large_boulder/alttwo
	icon_state = "boulder_3"
	bound_height = 32
	bound_width = 64

/obj/structure/rock/basalt/pile
	name = "石堆"
	desc = "一堆火山岩."
	density = FALSE
	icon_state = "lavarocks"

/obj/structure/rock/basalt/pile/alt
	name = "石堆"
	icon_state = "lavarocks1"

/obj/structure/rock/basalt/pile/alt2
	name = "石堆"
	icon_state = "lavarocks2"

/obj/structure/rock/basalt/pile/alt3
	name = "化石"
	desc = "一堆古老的化石.这里面有一些形状奇特的头骨..."
	icon_state = "lavarocks3"

//randomised icons
/obj/structure/rock/variable
	///number of icon variants this object has
	var/icon_variants = 1

/obj/structure/rock/variable/Initialize(mapload)
	. = ..()
	icon_state = "[initial(icon_state)]_[rand(1, icon_variants)]"

/obj/structure/rock/variable/basalt
	name = "岩石"
	desc = "一块巨大的岩石."
	icon_state = "basalt"
	icon_variants = 4

/obj/structure/rock/variable/tinyrock
	name = "小石堆"
	desc = "一堆小鹅卵石..."
	icon_state = "tinyrock"
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	max_integrity = 100
	icon_variants = 8

/obj/structure/rock/variable/stalagmite
	name = "石笋"
	desc = "一座古老的矿物沉积堆,通常出现在洞穴中."
	icon = 'icons/obj/structures/cave_decor.dmi'
	icon_state = "stalagmite"
	icon_variants = 6

/obj/structure/rock/variable/jungle
	name = "岩石"
	desc = "一大堆看起来很滑的岩石."
	icon = 'icons/obj/flora/jungleflora.dmi'
	icon_state = "rock"
	density = FALSE
	icon_variants = 5

/obj/structure/rock/variable/jungle/big
	desc = "一块巨大的岩石."
	icon_state = "big_rock"
	density = TRUE
	icon_variants = 4

/obj/structure/rock/variable/jungle_large
	name = "岩石"
	desc = "一大堆看起来很滑的岩石."
	icon = 'icons/obj/flora/largejungleflora.dmi'
	icon_state = "rocks"
	max_integrity = 350
	coverage = 75
	bound_height = 64
	bound_width = 64
	icon_variants = 4
	allow_pass_flags = PASS_LOW_STRUCTURE|PASSABLE|PASS_WALKOVER

/obj/structure/rock/variable/jungle_large/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_OBJ_TRY_ALLOW_THROUGH = PROC_REF(can_climb_over),
		COMSIG_FIND_FOOTSTEP_SOUND = TYPE_PROC_REF(/atom/movable, footstep_override),
		COMSIG_TURF_CHECK_COVERED = TYPE_PROC_REF(/atom/movable, turf_cover_check),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/rock/variable/jungle_large/footstep_override(atom/movable/source, list/footstep_overrides)
	footstep_overrides[FOOTSTEP_CONCRETE] = layer

//drought rocks
/obj/structure/rock/variable/drought
	name = "岩石"
	desc = "一些布满灰尘的岩石."
	icon = 'icons/obj/flora/desert_flora.dmi'
	icon_state = "drought"
	density = FALSE
	icon_variants = 32

//crystal
/obj/structure/rock/crystal
	name = "奇异水晶"
	desc = "一块奇异的发光水晶.不确定你是否应该碰它."
	icon = 'icons/obj/flora/crystals.dmi'
	icon_state = "big_crystal"
	light_range = 2
	light_power = 0.5
	light_color = LIGHT_COLOR_EMISSIVE_GREEN

/obj/structure/rock/crystal/Initialize(mapload)
	. = ..()
	update_icon()

/obj/structure/rock/crystal/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "[icon_state]_emissive", src, alpha = src.alpha)

/obj/structure/rock/crystal/small
	icon_state = "small_crystal"
	light_range = 1

/obj/structure/rock/variable/crystal_mound
	name = "奇怪的水晶"
	desc = "这里似乎有一些奇怪的水晶正从地下冒出来..."
	icon = 'icons/obj/flora/crystals.dmi'
	icon_state = "crystal_mound"
	icon_variants = 3
	light_range = 0.5
	light_power = 0.5
	light_color = LIGHT_COLOR_EMISSIVE_GREEN
	density = FALSE

/obj/structure/rock/variable/crystal_mound/Initialize(mapload)
	. = ..()
	update_icon()

/obj/structure/rock/variable/crystal_mound/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "[icon_state]_emissive", src, alpha = src.alpha)
