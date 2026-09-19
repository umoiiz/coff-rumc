/obj/item/attachable/verticalgrip
	name = "垂直握把"
	desc = "定制的改进型前握把, 可提高精准度, 适度加快瞄准时的移动速度, 减少后坐力, 并减少持握时的散布, 尤其是在点射时. \nHowever, 它还会增加武器体积, 略微增加持握延迟, 并使未持握射击更加笨拙."
	icon_state = "verticalgrip"
	wield_delay_mod = 0.2 SECONDS
	size_mod = 1
	slot = ATTACHMENT_SLOT_UNDER
	pixel_shift_x = 20
	accuracy_mod = 0.1
	recoil_mod = -2
	scatter_mod = -3
	burst_scatter_mod = -1
	accuracy_unwielded_mod = -0.05
	scatter_unwielded_mod = 3
	aim_speed_mod = -0.1
	aim_mode_movement_mult = -0.2

/obj/item/attachable/angledgrip
	name = "斜角握把"
	desc = "定制的改进型前握把, 可减少后坐力并加快持握速度. \nHowever, 它还会增加武器体积, 并略微妨碍未持握射击."
	icon_state = "angledgrip"
	wield_delay_mod = -0.3 SECONDS
	size_mod = 1
	slot = ATTACHMENT_SLOT_UNDER
	pixel_shift_x = 20
	recoil_mod = -1
	scatter_mod = 2
	accuracy_unwielded_mod = -0.1
	scatter_unwielded_mod = 1

/obj/item/attachable/gyro
	name = "陀螺稳定器"
	desc = "一套配重和平衡装置, 用于在点射或移动时稳定武器, 尤其是在单手射击时. 大幅减少移动对精准度的惩罚. 显著减少点射散布, 后坐力和一般散布. 通过提高移动时的精准度, 它让你在瞄准时能移动得更快."
	icon_state = "gyro"
	slot = ATTACHMENT_SLOT_UNDER
	scatter_mod = -1
	recoil_mod = -2
	movement_acc_penalty_mod = -2
	accuracy_unwielded_mod = 0.1
	scatter_unwielded_mod = -2
	recoil_unwielded_mod = -1
	aim_mode_movement_mult = -0.5

/obj/item/attachable/lasersight
	name = "激光瞄准器"
	desc = "安装在枪管下方的激光瞄准器. 显著提高单手精准度, 并显著减少未持握时对精准度的惩罚."
	icon_state = "lasersight"
	slot = ATTACHMENT_SLOT_UNDER
	pixel_shift_x = 17
	pixel_shift_y = 17
	accuracy_mod = 0.1
	accuracy_unwielded_mod = 0.15

/obj/item/attachable/lace
	name = "手枪挂绳"
	desc = "一条简单的挂绳, 可以缠绕在手腕上."
	icon_state = "lace"
	slot = ATTACHMENT_SLOT_MUZZLE //so you cannot have this and RC at once aka balance
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle

/obj/item/attachable/lace/activate(mob/living/user, turn_off)
	if(lace_deployed)
		REMOVE_TRAIT(master_gun, TRAIT_NODROP, PISTOL_LACE_TRAIT)
		to_chat(user, span_notice("你感觉[src]在手腕上松开了!"))
		playsound(user, 'sound/weapons/fistunclamp.ogg', 25, 1, 7)
		icon_state = "lace"
	else if(turn_off)
		return
	else
		if(user.do_actions)
			return
		to_chat(user, span_notice("你展开[src]."))
		ADD_TRAIT(master_gun, TRAIT_NODROP, PISTOL_LACE_TRAIT)
		to_chat(user, span_warning("你感觉[src]在手腕上收紧了!"))
		playsound(user, 'sound/weapons/fistclamp.ogg', 25, 1, 7)
		icon_state = "lace-on"

	lace_deployed = !lace_deployed

	update_icon()
	return TRUE

/obj/item/attachable/lace/t500
	name = "R-500 蕾丝"
	icon = 'icons/obj/items/attachments/attachments_64.dmi'
	slot = ATTACHMENT_SLOT_STOCK
	pixel_shift_x = 0
	pixel_shift_y = 0

/obj/item/attachable/burstfire_assembly
	name = "连发组件"
	desc = "一套机构重组套件,可实现自动射击,若武器已具备该能力则可增加每次点射的射弹数."
	icon_state = "rapidfire"
	slot = ATTACHMENT_SLOT_UNDER
	burst_mod = 2
	gun_firemode_list_mod = list(GUN_FIREMODE_AUTOMATIC)
	var/list/saved_firemode_list

/obj/item/attachable/burstfire_assembly/on_attach(attaching_item, mob/user)
	if(istype(attaching_item, /obj/item/weapon/gun))
		var/obj/item/weapon/gun/G = attaching_item
		saved_firemode_list = G.gun_firemode_list.Copy()
	return ..()

/obj/item/attachable/burstfire_assembly/on_detach(detaching_item, mob/user)
	var/obj/item/weapon/gun/G = detaching_item
	if(!istype(G)) return
	. = ..()
	for(var/mode in G.gun_firemode_list - saved_firemode_list)
		G.gun_firemode_list -= mode
	if(!(G.gun_firemode in G.gun_firemode_list))
		G.gun_firemode = G.gun_firemode_list[1]
	if(length(G.gun_firemode_list) == 1)
		var/datum/action/A = locate(/datum/action/item_action/firemode) in G.actions
		if(A)
			A.remove_action(user)
			qdel(A)
