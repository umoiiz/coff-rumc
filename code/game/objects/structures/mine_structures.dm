//stuff found in mines
/obj/structure/mine_structure
	name = "杂项矿场结构"
	desc = "你不该看到这个."
	icon = 'icons/obj/structures/cave_decor.dmi'
	icon_state = ""
	max_integrity = 200
	anchored = TRUE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/structure/mine_structure/cart
	name = "矿车"
	desc = "一个带轮子的大金属桶,用于搬运重物.这个已经翻倒了."
	icon_state = "minecart_fallen"
	max_integrity = 300
	coverage = 85
	density = TRUE

/obj/structure/mine_structure/wooden/fire_act(burn_level, flame_color)
	take_damage(burn_level, BURN, FIRE)

/obj/structure/mine_structure/wooden/support_wall
	name = "木质支撑"
	desc = "一种防止洞穴坍塌的木质支撑结构"
	icon_state = "support_wall"
	pixel_y = 26

/obj/structure/mine_structure/wooden/support_wall/Initialize(mapload)
	. = ..()
	if(dir == NORTH)
		pixel_y = 0
		layer = ABOVE_MOB_LAYER
		AddComponent(/datum/component/largetransparency, 0, 0, 0, 0)

/obj/structure/mine_structure/wooden/support_wall/above
	dir = NORTH

/obj/structure/mine_structure/wooden/support_wall/broken
	desc = "一种防止洞穴坍塌的木质支撑结构.它已经风光不再了."
	icon_state = "support_wall_broken"

/obj/structure/mine_structure/wooden/support_wall/broken/above
	dir = NORTH

/obj/structure/mine_structure/wooden/support_wall/t_bar
	desc = "一根用于防止洞穴坍塌的简单木支撑梁."
	icon_state = "support"

/obj/structure/mine_structure/wooden/support_wall/t_bar/above
	dir = NORTH

/obj/structure/mine_structure/wooden/support_wall/beams
	desc = "一对用于防止洞穴坍塌的木支撑梁."
	icon_state = "support_beams"

/obj/structure/mine_structure/wooden/support_wall/beams/above
	dir = NORTH

/obj/structure/mine_structure/wooden/plank
	name = "木板"
	desc = "一块木板.踩上去不错."
	icon_state = "boards_drought_ns"
	///number of icon variants this object has
	var/icon_variants = 6

/obj/structure/mine_structure/wooden/plank/Initialize(mapload)
	. = ..()
	icon_state = "[initial(icon_state)]_[rand(1, icon_variants)]"

/obj/structure/mine_structure/wooden/plank/horizontal
	icon_state = "boards_drought_we"

/obj/structure/mine_structure/wooden/plank/alt
	icon_state = "boards_mammoth_ns"

/obj/structure/mine_structure/wooden/plank/alt/horizontal
	icon_state = "boards_mammoth_we"

/obj/structure/mine_structure/wooden/sign
	name = "木牌"
	desc = "一个木制标牌柱.它似乎指向某个方向."
	icon_state = "sign_left"

/obj/structure/mine_structure/wooden/sign/right
	icon_state = "sign_right"
