/obj/item/clothing/head/soft
	name = "货运帽"
	desc = "一顶品味低下的黄色棒球帽."
	icon_state = "cargosoft"
	worn_icon_state = "cargosoft"
	inventory_flags = COVEREYES
	var/cap_color = "cargo"
	var/flipped = 0
	siemens_coefficient = 0.9
	armor_protection_flags = NONE
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/soft/dropped()
	icon_state = "[cap_color]soft"
	flipped=0
	..()

/obj/item/clothing/head/soft/verb/flip()
	set category = "IC.Clothing"
	set name = "Flip cap"
	set src in usr
	if(!usr.incapacitated())
		src.flipped = !src.flipped
		if(src.flipped)
			icon_state = "[cap_color]soft_flipped"
			to_chat(usr, "你把帽子反戴.")
		else
			icon_state = "[cap_color]soft"
			to_chat(usr, "你把帽子转回正常位置.")
		update_clothing_icon()	//so our mob-overlays update

/obj/item/clothing/head/soft/red
	name = "红帽"
	desc = "一顶品味低下的红色棒球帽."
	icon_state = "redsoft"
	cap_color = "red"

/obj/item/clothing/head/soft/blue
	name = "蓝帽"
	desc = "一顶品味低下的蓝色棒球帽."
	icon_state = "bluesoft"
	cap_color = "blue"

/obj/item/clothing/head/soft/grey
	name = "灰帽"
	desc = "一顶品味高雅的灰色棒球帽."
	icon_state = "greysoft"
	cap_color = "grey"

/obj/item/clothing/head/soft/mime
	name = "白帽"
	desc = "一顶品味低下的白色棒球帽."
	icon_state = "mimesoft"
	cap_color = "mime"

/obj/item/clothing/head/soft/purple
	name = "紫帽"
	desc = "一顶品味低下的紫色棒球帽."
	icon_state = "purplesoft"
	cap_color = "purple"

/obj/item/clothing/head/soft/sec
	name = "安保帽"
	desc = "一顶品味高雅的红色棒球帽."
	icon_state = "secsoft"
	cap_color = "sec"

/obj/item/clothing/head/soft/sec/corp
	name = "企业安保帽"
	desc = "一顶企业配色的棒球帽."
	icon_state = "corpsoft"
	cap_color = "corp"
