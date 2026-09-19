/obj/item/clothing/shoes/black
	name = "黑鞋"
	icon_state = "black"
	desc = "一双黑鞋."

	cold_protection_flags = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/shoes/brown
	name = "棕鞋"
	desc = "一双棕鞋."
	icon_state = "brown"

/obj/item/clothing/shoes/blue
	name = "蓝鞋"
	icon_state = "blue"

/obj/item/clothing/shoes/green
	name = "绿鞋"
	icon_state = "green"

/obj/item/clothing/shoes/yellow
	name = "黄鞋"
	icon_state = "yellow"

/obj/item/clothing/shoes/purple
	name = "紫鞋"
	icon_state = "purple"

/obj/item/clothing/shoes/red
	name = "红鞋"
	desc = "时尚的红鞋."
	icon_state = "red"

/obj/item/clothing/shoes/white
	name = "白鞋"
	icon_state = "white"
	permeability_coefficient = 0.01

/obj/item/clothing/shoes/leather
	name = "皮鞋"
	desc = "一双结实的皮鞋."
	icon_state = "leather"

/obj/item/clothing/shoes/rainbow
	name = "彩虹鞋"
	desc = "非常gay的鞋."
	icon_state = "rain_bow"

/obj/item/clothing/shoes/orange
	name = "橙鞋"
	icon_state = "orange"
	var/obj/item/restraints/handcuffs/chained = null

/obj/item/clothing/shoes/orange/proc/attach_cuffs(obj/item/restraints/handcuffs/cuffs, mob/user as mob)
	if(chained)
		return

	user.drop_held_item()
	cuffs.loc = src
	chained = cuffs
	slowdown = 15
	icon_state = "orange1"

/obj/item/clothing/shoes/orange/proc/remove_cuffs(mob/user as mob)
	if(!chained)
		return

	user.put_in_hands(chained)

	slowdown = initial(slowdown)
	icon_state = "orange"
	chained = null

/obj/item/clothing/shoes/orange/attack_self(mob/user as mob)
	. = ..()
	remove_cuffs(user)

/obj/item/clothing/shoes/orange/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/restraints/handcuffs))
		attach_cuffs(I, user)
	return ..()
