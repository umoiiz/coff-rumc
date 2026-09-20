/obj/structure/ore_box
	icon = 'icons/obj/mining.dmi'
	icon_state = "orebox0"
	name = "矿石箱"
	desc = "一个用于储存矿石的重型箱子."
	density = TRUE
	anchored = FALSE
	resistance_flags = XENO_DAMAGEABLE
	interaction_flags = INTERACT_OBJ_DEFAULT|INTERACT_POWERLOADER_PICKUP_ALLOWED
	max_integrity = 100
	soft_armor = list(MELEE = 0, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
