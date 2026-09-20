//Deployable shotgun ammo box
/obj/item/shotgunbox
	name = "独头弹弹药箱"
	desc = "一个大型可部署弹药箱."
	icon = 'icons/obj/items/ammo/box.dmi'
	icon_state = "ammoboxslug"
	worn_icon_state = "ammoboxslug"
	base_icon_state = "ammoboxslug"
	w_class = WEIGHT_CLASS_HUGE
	equip_slot_flags = ITEM_SLOT_BACK
	///Current stored rounds
	var/current_rounds = 200
	///Maximum stored rounds
	var/max_rounds = 200
	///Ammunition type
	var/datum/ammo/ammo_type = /datum/ammo/bullet/shotgun/slug
	///Whether the box is deployed or not.
	var/deployed = FALSE
	///Caliber of the rounds stored.
	var/caliber = CALIBER_12G

/obj/item/shotgunbox/update_icon_state()
	. = ..()
	if(!deployed)
		icon_state = "[initial(icon_state)]"
	else if(current_rounds > 0)
		icon_state = "[initial(icon_state)]_deployed"
	else
		icon_state = "[initial(icon_state)]_empty"

/obj/item/shotgunbox/attack_self(mob/user)
	deployed = TRUE
	update_icon()
	user.dropItemToGround(src)

/obj/item/shotgunbox/MouseDrop(atom/over_object)
	if(!deployed)
		return

	if(!ishuman(over_object))
		return

	var/mob/living/carbon/human/H = over_object
	if(H == usr && !H.incapacitated() && Adjacent(H) && H.put_in_hands(src))
		deployed = FALSE
		update_icon()

/obj/item/shotgunbox/examine(mob/user)
	. = ..()
	. += "It contains [current_rounds] out of [max_rounds] shotgun shells."

/obj/item/shotgunbox/attack_hand(mob/living/user)
	if(loc == user)
		return ..()

	if(!deployed)
		user.put_in_hands(src)
		return

	if(current_rounds < 1)
		to_chat(user, ("The [src] is empty."))
		return

	var/obj/item/ammo_magazine/handful/H = new
	var/rounds = min(current_rounds, 5)

	H.generate_handful(ammo_type, caliber, rounds, initial(ammo_type.handful_amount))
	current_rounds -= rounds

	user.put_in_hands(H)
	to_chat(user, span_notice("你从[src]中取出<b>[rounds]</b>发\s 弹药."))
	update_icon()

/obj/item/shotgunbox/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(!istype(I, /obj/item/ammo_magazine/handful))
		return

	var/obj/item/ammo_magazine/handful/H = I

	if(!deployed)
		to_chat(user, span_warning("[src]必须部署在地面上才能补充."))
		return

	if(H.default_ammo != ammo_type)
		to_chat(user, span_warning("那不是正确的弹药类型."))
		return

	if(current_rounds == max_rounds)
		to_chat(user, span_warning("[src]已经满了."))
		return

	current_rounds = min(current_rounds + H.current_rounds, max_rounds)
	qdel(H)
	update_icon()

/obj/item/shotgunbox/buckshot
	name = "鹿弹弹药箱"
	icon_state = "ammoboxbuckshot"
	worn_icon_state = "ammoboxbuckshot"
	base_icon_state = "ammoboxbuckshot"
	ammo_type = /datum/ammo/bullet/shotgun/buckshot

/obj/item/shotgunbox/flechette
	name = "飞镖弹弹药箱"
	icon_state = "ammoboxflechette"
	worn_icon_state = "ammoboxflechette"
	base_icon_state = "ammoboxflechette"
	ammo_type = /datum/ammo/bullet/shotgun/flechette

/obj/item/shotgunbox/clf_heavyrifle
	name = "大型弹药箱(14.5mm穿甲燃烧弹)"
	caliber = CALIBER_14X5
	icon_state = "ammobox_145"
	worn_icon_state = "ammobox_145"
	base_icon_state = "ammobox_145"
	ammo_type = /datum/ammo/bullet/sniper/clf_heavyrifle

/obj/item/shotgunbox/tracker
	name = "追踪弹药箱"
	icon_state = "ammoboxtracking"
	worn_icon_state = "ammoboxtracking"
	base_icon_state = "ammoboxtracking"
	ammo_type = /datum/ammo/bullet/shotgun/tracker

/obj/item/shotgunbox/blank
	name = "空包弹弹药箱"
	icon_state = "ammoboxblank"
	worn_icon_state = "ammoboxblank"
	base_icon_state = "ammoboxblank"
	ammo_type = /datum/ammo/bullet/shotgun/blank
