/obj/item/attachable/foldable
	name = "可折叠枪托"
	desc = "一个可折叠枪托。你不应该看到这个。"
	icon_state = ""
	slot = ATTACHMENT_SLOT_STOCK
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle
	///How long it takes to fold or unfold
	var/deploy_time
	///whether the attachment is currently folded or not
	var/folded = TRUE

/obj/item/attachable/foldable/on_attach(attaching_item, mob/user)
	if(!istype(attaching_item, /obj/item/weapon/gun))
		return //Guns only

	master_gun = attaching_item

	if(attachment_action_type)
		var/datum/action/action_to_update = new attachment_action_type(src, master_gun)
		if(isliving(master_gun.loc))
			var/mob/living/living_user = master_gun.loc
			if(master_gun == living_user.l_hand || master_gun == living_user.r_hand)
				action_to_update.give_action(living_user)

	//custom attachment icons for specific guns
	if(length(variants_by_parent_type))
		for(var/selection in variants_by_parent_type)
			if(istype(master_gun, selection))
				icon_state = variants_by_parent_type[selection]

	update_icon()

/obj/item/attachable/foldable/on_detach(detaching_item, mob/user)
	if(!isgun(detaching_item))
		return

	if(!folded)
		activate()

	for(var/datum/action/action_to_update AS in master_gun.actions)
		if(action_to_update.target != src)
			continue
		qdel(action_to_update)
		break

	master_gun = null
	icon_state = initial(icon_state)
	update_icon()
	if(!greyscale_config || !greyscale_colors)
		return
	UnregisterSignal(master_gun, COMSIG_ITEM_SECONDARY_COLOR)

/obj/item/attachable/foldable/activate(mob/living/user, turn_off)
	if(user && deploy_time && !do_after(user, deploy_time, NONE, src, BUSY_ICON_BAR))
		return FALSE

	folded = !folded
	playsound(src, 'sound/machines/click.ogg', 20, FALSE, 4)
	update_icon()

	if(master_gun)
		apply_modifiers(master_gun, user, !folded)

	return TRUE

/obj/item/attachable/foldable/update_icon_state()
	. = ..()
	if(folded)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_open"

/obj/item/attachable/foldable/skorpion_stock
	name = "\improper Skorpion冲锋枪木质枪托"
	desc = "用于Skorpion冲锋枪的可折叠钢丝枪托"
	icon = 'icons/obj/items/attachments/attachments_64.dmi'
	icon_state = "skorpion"
	attach_features_flags = ATTACH_ACTIVATION
	pixel_shift_x = 0
	pixel_shift_y = 0
	size_mod = 2
	wield_delay_mod = 0.1 SECONDS
	accuracy_mod = 0.25
	recoil_mod = -2
	scatter_mod = -6
	scatter_unwielded_mod = 4
	accuracy_unwielded_mod = -0.1

/obj/item/attachable/foldable/mp19stock
	name = "\improper MP-19冲锋手枪枪托"
	desc = "一种少量配发给TGMC部队的冲锋枪枪托。与MP-19兼容,这种枪托能减少后坐力并提高精准度,但会降低操控性和敏捷性。在近身搏斗中似乎更有效一些。"
	attach_features_flags = ATTACH_ACTIVATION
	wield_delay_mod = 0.1 SECONDS
	melee_mod = 5
	size_mod = 1
	icon_state = "t19stock"
	accuracy_mod = 0.3
	recoil_mod = -2
	scatter_mod = -8
	accuracy_unwielded_mod = -0.1
	scatter_unwielded_mod = 4

/obj/item/attachable/foldable/som_carbine
	name = "\improper V-34卡宾枪枪托"
	desc = "内置于V-34卡宾枪的侧折叠枪托。该枪设计为在枪托展开时射击,但也可以在不展开的情况下射击,只是会有些困难。"
	attach_features_flags = ATTACH_ACTIVATION
	wield_delay_mod = 0.1 SECONDS
	melee_mod = 5
	size_mod = 1
	icon_state = "v34stock"
	accuracy_mod = 0.2
	recoil_mod = -2
	scatter_mod = -8
	aim_speed_mod = 0.05

/obj/item/attachable/foldable/icc_machinepistol
	name = "\improper PL-38冲锋手枪枪托"
	desc = "一种在ICC冲锋枪上使用的冲锋枪枪托,这种枪托能减少后坐力并提高精准度,但会降低操控性和敏捷性。在近身搏斗中似乎更有效一些。"
	attach_features_flags = ATTACH_ACTIVATION
	icon = 'icons/obj/items/attachments/attachments_64.dmi'
	wield_delay_mod = 0.1 SECONDS
	melee_mod = 5
	size_mod = 1
	icon_state = "pl38stock"
	accuracy_mod = 0.3
	recoil_mod = -2
	scatter_mod = -8
	accuracy_unwielded_mod = -0.1
	scatter_unwielded_mod = 4

/obj/item/attachable/foldable/t35stock
	name = "\improper SH-35枪托"
	desc = "用于SH-35霰弹枪的非标准重型枪托。比标准配发的短管型更慢且更笨重,但能减少后坐力并提高精准度。据称在战斗中也能当作相当不错的棍棒使用。"
	icon = 'icons/obj/items/attachments/attachments_64.dmi'
	icon_state = "t35stock"
	attach_features_flags = ATTACH_ACTIVATION
	wield_delay_mod = 0.2 SECONDS
	accuracy_mod = 0.15
	recoil_mod = -3
	scatter_mod = -2

/obj/item/attachable/foldable/bipod
	name = "两脚架"
	desc = "一组简单的伸缩杆,用于在射击时保持武器稳定。\nGreatly在正确架设时提高精准度并减少后坐力和散布,但也会增加武器体积。"
	icon_state = "bipod"
	slot = ATTACHMENT_SLOT_UNDER
	size_mod = 2
	deploy_time = 1 SECONDS
	accuracy_mod = 0.3
	recoil_mod = -2
	scatter_mod = -10
	burst_scatter_mod = -3
	aim_mode_delay_mod = -0.5
	var/user_old_move_resist

/obj/item/attachable/foldable/bipod/activate(mob/living/user, turn_off)
	if(folded && !(master_gun.item_flags & WIELDED)) //no one handed bipod use
		if(user)
			balloon_alert(user, "未双手持握")
		return

	. = ..()

	if(folded)
		UnregisterSignal(master_gun, list(COMSIG_ITEM_DROPPED, COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_UNWIELD))
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		to_chat(user, span_notice("你收起[src]。"))
		user.move_resist = user_old_move_resist
		return

	if(user)
		RegisterSignals(master_gun, list(COMSIG_ITEM_DROPPED, COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_UNWIELD), PROC_REF(retract_bipod))
		RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(retract_bipod))
		to_chat(user, span_notice("你展开[src]。"))
		user_old_move_resist = user.move_resist
		user.move_resist = MOVE_FORCE_STRONG


///Signal handler for forced undeployment
/obj/item/attachable/foldable/bipod/proc/retract_bipod(datum/source, mob/living/user)
	SIGNAL_HANDLER
	deploy_time = 0
	INVOKE_ASYNC(src, PROC_REF(activate), (istype(user) ? user : source), TRUE)
	deploy_time = initial(deploy_time)
	to_chat(user, span_warning("失去支撑,两脚架收起了!"))
