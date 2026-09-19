/obj/item/restraints/handcuffs
	name = "手铐"
	desc = "用这个来让囚犯守规矩."
	gender = PLURAL
	icon = 'icons/obj/items/items.dmi'
	icon_state = "handcuff"
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 2
	throw_range = 5
	breakouttime = 2 MINUTES
	var/single_use = 0 //determines if handcuffs will be deleted on removal
	var/cuff_sound = 'sound/weapons/handcuffs.ogg'
	var/cuff_delay = 40 //how many deciseconds it takes to cuff someone

/obj/item/restraints/handcuffs/attack(mob/living/carbon/C, mob/user)
	if(!istype(C))
		return ..()
	if (!ishuman(user))
		to_chat(user, span_warning("你没有足够的灵巧度来做这个!"))
		return
	if(!C.handcuffed)
		place_handcuffs(C, user)

/obj/item/restraints/handcuffs/proc/place_handcuffs(mob/living/carbon/target, mob/user)
	playsound(src.loc, cuff_sound, 25, 1, 4)

	if(user.do_actions)
		return

	if(!ishuman(target))
		return
	var/mob/living/carbon/human/H = target

	if (!H.has_limb_for_slot(SLOT_HANDCUFFED))
		to_chat(user, span_warning("\The [H]至少需要两只手腕才能把它们铐在一起!"))
		return

	log_combat(user, H, "handcuffed", src, addition="(attempt)")

	user.visible_message(span_notice("[user]试图把[src]戴到[H]上."))
	if(do_after(user, cuff_delay, NONE, H, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE, extra_checks = CALLBACK(user, TYPE_PROC_REF(/datum, Adjacent), H)) && !H.handcuffed)
		if(H.has_limb_for_slot(SLOT_HANDCUFFED))
			user.dropItemToGround(src)
			H.equip_to_slot_if_possible(src, SLOT_HANDCUFFED, 1, 0, 1, 1)
			return TRUE

/obj/item/restraints/handcuffs/zip
	name = "扎带手铐"
	desc = "一次性塑料扎带手铐."
	w_class = WEIGHT_CLASS_TINY
	icon_state = "cuff_zip"
	breakouttime = 1 MINUTES
	cuff_sound = 'sound/weapons/cablecuff.ogg'
	cuff_delay = 2 SECONDS

/obj/item/restraints/handcuffs/zip/place_handcuffs(mob/living/carbon/target, mob/user)
	. = ..()
	if(!.)
		return
	item_flags |= DELONDROP

/obj/item/restraints/handcuffs/cable
	name = "线缆束缚具"
	desc = "看起来像是几根绑在一起的线缆.可以用来绑住什么东西."
	icon_state = "cuff_white"
	breakouttime = 30 SECONDS
	cuff_sound = 'sound/weapons/cablecuff.ogg'

/obj/item/restraints/handcuffs/cable/red
	color = "#DD0000"

/obj/item/restraints/handcuffs/cable/yellow
	color = "#DDDD00"

/obj/item/restraints/handcuffs/cable/blue
	color = "#0000DD"

/obj/item/restraints/handcuffs/cable/green
	color = "#00DD00"

/obj/item/restraints/handcuffs/cable/pink
	color = "#DD00DD"

/obj/item/restraints/handcuffs/cable/orange
	color = "#DD8800"

/obj/item/restraints/handcuffs/cable/cyan
	color = "#00DDDD"

/obj/item/restraints/handcuffs/cable/white
	color = "#FFFFFF"

/obj/item/restraints/handcuffs/cable/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = I
		if(!R.use(1))
			return

		var/obj/item/weapon/wirerod/W = new
		user.put_in_hands(W)
		to_chat(user, span_notice("你把线缆束缚具缠绕在杆子的顶部."))
		qdel(src)
		update_icon()
