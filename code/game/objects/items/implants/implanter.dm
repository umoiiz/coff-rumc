/obj/item/implanter
	name = "植入器"
	desc = "一个无菌植入注射器."
	icon = 'icons/obj/items/implants.dmi'
	icon_state = "implanter0"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_right.dmi',
	)
	worn_icon_state = "syringe_0"
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	///The implant itself
	var/obj/item/implant/internal_implant = null

/obj/item/implanter/Initialize(mapload, ...)
	. = ..()
	if(internal_implant)
		internal_implant = new internal_implant(src)
		update_icon()

/obj/item/implanter/Destroy()
	QDEL_NULL(internal_implant)
	return ..()

/obj/item/implanter/update_icon_state()
	. = ..()
	icon_state = "implanter[internal_implant?"1":"0"]"

/obj/item/implanter/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += "it contains [internal_implant ? "a [internal_implant.name]" : "no implant"]!"

/obj/item/implanter/attack(mob/target, mob/user)
	. = ..()
	if(!can_implant(target, user))
		return

	user.visible_message(span_warning("[user] 正在尝试植入 [target]."), span_notice("你正在尝试植入 [target]."))

	if(!do_after(user, 5 SECONDS, NONE, target, BUSY_ICON_GENERIC) || !internal_implant)
		to_chat(user, span_notice("你未能植入 [target]."))
		return FALSE

	if(!internal_implant.implant(target, user))
		to_chat(user, span_notice("你未能植入 [target]."))
		return FALSE

	target.visible_message(span_warning("[target] 已被 [user] 植入."))
	log_combat(user, target, "implanted", src)
	internal_implant = null
	update_icon()
	return TRUE

/obj/item/implanter/proc/can_implant(mob/target, mob/user)
	if(!ishuman(target))
		return FALSE
	if(!internal_implant)
		to_chat(user, span_warning("[src] 中没有植入物!"))
		return FALSE
	return TRUE

/obj/item/implanter/neurostim
	name = "神经刺激植入器"
	internal_implant = /obj/item/implant/neurostim

/obj/item/implanter/chem
	name = "化学植入物植入器"
	internal_implant = /obj/item/implant/chem

/obj/item/implanter/chem/blood
	name = "血液回收植入物植入器"
	internal_implant = /obj/item/implant/chem/blood

/obj/item/implanter/cloak
	name = "隐形植入物植入器"
	internal_implant = /obj/item/implant/cloak

/obj/item/implanter/blade
	name = "刀刃植入物植入器"
	internal_implant = /obj/item/implant/deployitem/blade

/obj/item/implanter/suicide_dust
	name = "自爆植入物"
	internal_implant = /obj/item/implant/suicide_dust

/obj/item/implanter/sandevistan
	name = "斯安威斯坦植入器"
	icon_state = "internal_implant_spinal"
	w_class = WEIGHT_CLASS_NORMAL
	internal_implant = /obj/item/implant/sandevistan

/obj/item/implanter/sandevistan/update_icon_state()
	. = ..()
	icon_state = initial(icon_state)

/obj/item/implanter/sandevistan/attack(mob/target, mob/user)
	. = ..()
	if(!.)
		return
	qdel(src)

/obj/item/implanter/jump_mod
	name = "强化脚踝植入物"
	internal_implant = /obj/item/implant/jump_mod
