/obj/structure/table/holotable
	name = "桌子"
	desc = "一块方形金属板,由四条金属腿支撑.它无法移动."
	density = TRUE
	anchored = TRUE

/obj/structure/table/holotable/attack_animal(mob/living/user as mob) //Removed code for larva since it doesn't work. Previous code is now a larva ability. /N
	return attack_hand(user)

/obj/structure/table/holotable/attack_hand(mob/living/user)
	return TRUE

/obj/structure/table/holotable/attackby(obj/item/I, mob/user, params)
	if(iswrench(I))
		to_chat(user, "这是一张全息桌! 上面没有螺栓!")
		return
	return ..()

/obj/structure/table/holotable/wood
	name = "桌子"
	desc = "一块方形木板,由四条木腿支撑.它无法移动."
	icon = 'icons/obj/smooth_objects/wood_table_reinforced.dmi'
	base_icon_state = "wood_table_reinforced"
	icon_state = "wood_table_reinforced-0"

/obj/structure/holowindow
	name = "加固窗"
	icon = 'icons/obj/structures/windows.dmi'
	icon_state = "rwindow"
	desc = "一扇窗户."
	density = TRUE
	layer = ABOVE_WINDOW_LAYER
	anchored = TRUE
	atom_flags = ON_BORDER

//BASKETBALL OBJECTS

/obj/item/toy/beach_ball/holoball
	name = "篮球"
	icon_state = "basketball"
	worn_icon_state = "basketball"
	desc = "这是你的机会,在太空大灌篮上大展身手吧."
	w_class = WEIGHT_CLASS_BULKY //Stops people from hiding it in their bags/pockets

/obj/item/toy/beach_ball/holoball/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(!CONFIG_GET(flag/fun_allowed))
		return FALSE
	attack_hand(xeno_attacker)
