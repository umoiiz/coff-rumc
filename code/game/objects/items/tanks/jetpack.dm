/obj/item/tank/jetpack
	name = "喷气背包 (空)"
	desc = "一个用于在零重力区域推进的压缩气体罐. 请谨慎使用."
	icon_state = "jetpack"
	w_class = WEIGHT_CLASS_BULKY
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/backpacks_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/backpacks_right.dmi',
	)
	worn_icon_state = "jetpack"

/obj/item/tank/jetpack/void
	name = "虚空喷气背包 (氧气)"
	desc = "它在虚空中表现良好."
	icon_state = "jetpack-void"
	worn_icon_state = "jetpack-void"

/obj/item/tank/jetpack/oxygen
	name = "喷气背包 (氧气)"
	desc = "一个用于在零重力区域推进的压缩氧气罐. 请谨慎使用."
	icon_state = "jetpack"
	worn_icon_state = "jetpack"

/obj/item/tank/jetpack/carbondioxide
	name = "喷气背包 (二氧化碳)"
	desc = "一个用于在零重力区域推进的压缩二氧化碳罐. 涂成黑色以表明它不应被用作内部气源."
	icon_state = "jetpack-black"
	worn_icon_state = "jetpack-black"
