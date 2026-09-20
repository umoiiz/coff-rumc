/obj/item/storage/lockbox
	name = "锁箱"
	desc = "一个上锁的箱子."
	icon_state = "lockbox+l"
	worn_icon_state = "syringe_kit"
	icon = 'icons/obj/items/storage/briefcase.dmi'
	w_class = WEIGHT_CLASS_BULKY
	req_access = list(ACCESS_MARINE_CAPTAIN)
	storage_type = /datum/storage/lockbox
	var/locked = 1
	var/broken = 0
	var/icon_locked = "lockbox+l"
	var/icon_closed = "lockbox"
	var/icon_broken = "lockbox+b"

/obj/item/storage/lockbox/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/card/id))
		if(broken)
			to_chat(user, span_warning("它似乎是坏的."))
			return

		if(!allowed(user))
			to_chat(user, span_warning("拒绝访问"))
			return

		locked = !locked
		if(locked)
			icon_state = icon_locked
			to_chat(user, span_warning("你锁上了[src]!"))
		else
			icon_state = icon_closed
			to_chat(user, span_warning("你解锁了[src]!"))

	if(locked)
		to_chat(user, span_warning("它锁着!"))
		return
	return ..()

/obj/item/storage/lockbox/vials
	name = "安全药瓶储存箱"
	desc = "一个上锁的箱子,用于让物品远离儿童."
	icon = 'icons/obj/items/storage/vialbox.dmi'
	icon_state = "vialbox0"
	worn_icon_state = "syringe_kit"
	storage_type = /datum/storage/lockbox
	req_access = list(ACCESS_MARINE_MEDBAY)

/obj/item/storage/lockbox/vials/update_icon_state()
	. = ..()
	icon_state = "vialbox[length(contents)]"

/obj/item/storage/lockbox/vials/update_overlays()
	. = ..()
	if(!broken)
		. += image(icon, src, "led[locked]")
		if(locked)
			. += image(icon, src, "cover")
	else
		. += image(icon, src, "ledb")

/obj/item/storage/lockbox/vials/attackby(obj/item/I, mob/user, params)
	. = ..()
	update_icon()
