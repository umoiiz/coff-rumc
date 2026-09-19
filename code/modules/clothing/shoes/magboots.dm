/obj/item/clothing/shoes/magboots
	desc = "磁力靴,常用于舱外活动,以确保使用者安全附着在载具上."
	name = "磁力靴"
	icon_state = "magboots0"
	var/magpulse = 0
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/shoes/magboots/attack_self(mob/user)
	if(magpulse)
		inventory_flags &= ~NOSLIPPING
		slowdown = SHOES_SLOWDOWN
		magpulse = 0
		icon_state = "magboots0"
		to_chat(user, "你关闭了磁脉冲牵引系统.")
	else
		inventory_flags |= NOSLIPPING
		slowdown = 2
		magpulse = 1
		icon_state = "magboots1"
		to_chat(user, "你启用了磁脉冲牵引系统.")
	user.update_inv_shoes()	//so our mob-overlays update

	update_action_button_icons()

/obj/item/clothing/shoes/magboots/examine(mob/user)
	. = ..()
	var/state = "disabled"
	if(inventory_flags&NOSLIPPING)
		state = "enabled"
	. += "Its mag-pulse traction system appears to be [state]."
