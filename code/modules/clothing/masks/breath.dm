/obj/item/clothing/mask/breath
	desc = "一种可连接到供气装置的贴合面罩."
	name = "呼吸面罩"
	icon_state = "breath"
	worn_icon_state = "breath"
	inventory_flags = COVERMOUTH
	armor_protection_flags = NONE
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.10
	permeability_coefficient = 0.50

	var/hanging = 0

/obj/item/clothing/mask/breath/verb/toggle()
	set category = "IC.Clothing"
	set name = "Adjust mask"
	set src in usr

	if(usr.canmove && !usr.stat && !usr.restrained())
		if(!src.hanging)
			src.hanging = !src.hanging
			gas_transfer_coefficient = 1 //gas is now escaping to the turf and vice versa
			inventory_flags &= ~(COVERMOUTH)
			icon_state = "breathdown"
			to_chat(usr, "你的面罩现在挂在脖子上.")

		else
			src.hanging = !src.hanging
			gas_transfer_coefficient = 0.10
			inventory_flags |= COVERMOUTH
			icon_state = "breath"
			to_chat(usr, "你将面罩拉上遮住面部.")
		update_clothing_icon()

/obj/item/clothing/mask/breath/medical
	desc = "一种可连接到供气装置的贴合无菌面罩."
	name = "医疗面罩"
	icon_state = "medical"
	worn_icon_state = "medical"
	permeability_coefficient = 0.01

//REBREATHER

/obj/item/clothing/mask/rebreather
	name = "循环呼吸器"
	desc = "一种贴合装置, 吸气时能立即加热或冷却空气, 以免损伤肺部."
	icon_state = "rebreather"
	worn_icon_state = "rebreather"
	armor_protection_flags = NONE
	inventory_flags = COVERMOUTH|COVEREYES|BLOCKGASEFFECT
	inv_hide_flags = HIDELOWHAIR
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01

/obj/item/clothing/mask/rebreather/scarf
	name = "吸热头巾"
	desc = "一种贴合帽子, 覆盖头顶, 后脑和两侧. 也可调整以遮住下半面部, 在恶劣环境中为使用者保暖."
	icon_state = "coif"
	worn_icon_state = "coif"
	inv_hide_flags = HIDEALLHAIR|HIDEEARS
	cold_protection_flags = HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/mask/rebreather/scarf/freelancer
	worn_icon_state = "coif_fl"

/obj/item/clothing/mask/bandanna
	name = "棕褐色头巾"
	desc = "一种有色, 坚韧且隔热的布料, 用于遮挡面部免受恶劣环境影响. 这条是沙漠棕褐色"
	icon_state = "bandanna"
	worn_icon_state = "bandanna"
	armor_protection_flags = FACE
	inv_hide_flags = HIDEFACE
	inventory_flags = COVERMOUTH|BLOCKGASEFFECT
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01

/obj/item/clothing/mask/bandanna/verb/toggle()
	set category = "IC.Clothing"
	set name = "Adjust bandanna"
	set src in usr

	if(usr.incapacitated())
		return

	active = !active
	icon_state = "[initial(icon_state)][!active ? "_down" : ""]"
	armor_protection_flags ^= initial(armor_protection_flags)
	inv_hide_flags ^= initial(inv_hide_flags)
	inventory_flags ^= initial(inventory_flags)
	to_chat(usr, "你[active ? "pull [src] up to cover your face" : "pull [src] off your face"].")

	update_clothing_icon()

	update_action_button_icons()

/obj/item/clothing/mask/bandanna/green
	name = "绿色头巾"
	desc = "一块有色、坚韧且隔热的布,用来遮挡面部免受环境侵害.这条是丛林绿"
	icon_state = "m_bandanna"
	worn_icon_state = "m_bandanna"

/obj/item/clothing/mask/bandanna/white
	name = "白色头巾"
	desc = "一块有色、坚韧且隔热的布,用来遮挡面部免受环境侵害.这条是雪白色"
	icon_state = "s_bandanna"
	worn_icon_state = "s_bandanna"

/obj/item/clothing/mask/bandanna/black
	name = "黑色头巾"
	desc = "一块有色、坚韧且隔热的布,用来遮挡面部免受环境侵害.这条是特种作战黑"
	icon_state = "k_bandanna"
	worn_icon_state = "k_bandanna"

/obj/item/clothing/mask/bandanna/skull
	name = "骷髅头巾"
	desc = "一块有色、坚韧且隔热的布,用来遮挡面部免受环境侵害.这条是黑色,上面有一个白色骷髅图案."
	icon_state = "skull_bandanna"
	worn_icon_state = "skull_bandanna"

/obj/item/clothing/mask/bandanna/alpha
	name = "红色头巾"
	desc = "一块有色、坚韧且隔热的布,用来遮挡面部免受环境侵害.这条是樱桃红色."
	icon_state = "alpha_bandanna"
	worn_icon_state = "alpha_bandanna"

/obj/item/clothing/mask/bandanna/bravo
	name = "黄色头巾"
	desc = "一块有色、坚韧且隔热的布,用来遮挡面部免受环境侵害.这条是香蕉黄色."
	icon_state = "bravo_bandanna"
	worn_icon_state = "bravo_bandanna"

/obj/item/clothing/mask/bandanna/charlie
	name = "紫色头巾"
	desc = "一块有色、坚韧且隔热的布,用来遮挡面部免受环境侵害.这条是葡萄紫色."
	icon_state = "charlie_bandanna"
	worn_icon_state = "charlie_bandanna"

/obj/item/clothing/mask/bandanna/delta
	name = "蓝色头巾"
	desc = "一块有色、坚韧且隔热的布,用来遮挡面部免受环境侵害.这条是蓝莓蓝色."
	icon_state = "delta_bandanna"
	worn_icon_state = "delta_bandanna"
