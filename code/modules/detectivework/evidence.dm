//CONTAINS: Evidence bags and fingerprint cards

/obj/item/evidencebag
	name = "证物袋"
	desc = "一个空的证物袋。"
	icon = 'icons/obj/items/storage/misc.dmi'
	icon_state = "evidenceobj"
	worn_icon_state = ""
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/stored_item = null

/obj/item/evidencebag/MouseDrop(obj/item/I as obj)
	if (!ishuman(usr))
		return

	var/mob/living/carbon/human/user = usr

	if (!(user.l_hand == src || user.r_hand == src))
		return //bag must be in your hands to use

	if (isturf(I.loc))
		if (!user.Adjacent(I))
			return
	else
		//If it isn't on the floor. Do some checks to see if it's in our hands or a box. Otherwise give up.
		if(I.item_flags & IN_STORAGE) //in a container.
			var/sdepth = I.storage_datum.storage_depth(user)
			if (sdepth == -1 || sdepth > 1)
				return	//too deeply nested to access

			var/obj/item/storage/U = I.loc
			user.client.screen -= I
			U.contents.Remove(I)
		else if(user.l_hand == I)					//in a hand
			user.drop_l_hand()
		else if(user.r_hand == I)					//in a hand
			user.drop_r_hand()
		else
			return

	if(!istype(I) || I.anchored)
		return

	if(istype(I, /obj/item/evidencebag))
		to_chat(user, span_notice("你觉得把证物袋放进另一个证物袋里有点荒谬。"))
		return

	if(I.w_class > 3)
		to_chat(user, span_notice("[I]放不进[src]。"))
		return

	if(length(contents))
		to_chat(user, span_notice("[src]里面已经有东西了。"))
		return

	user.visible_message("[user]把[I]放进[src]", "你把[I]放进[src]。",\
	"You hear a rustle as someone puts something into a plastic bag.")

	icon_state = "evidence"

	var/xx = I.pixel_x	//save the offset of the item
	var/yy = I.pixel_y
	I.pixel_x = 0		//then remove it so it'll stay within the evidence bag
	I.pixel_y = 0
	var/image/img = image("icon"=I, "layer"=FLOAT_LAYER)	//take a snapshot. (necessary to stop the underlays appearing under our inventory-HUD slots ~Carn
	I.pixel_x = xx		//and then return it
	I.pixel_y = yy
	overlays += img
	overlays += "evidence"	//should look nicer for transparent stuff. not really that important, but hey.

	desc = "An evidence bag containing [I]."
	I.loc = src
	stored_item = I
	w_class = I.w_class



/obj/item/evidencebag/attack_self(mob/user as mob)
	if(length(contents))
		var/obj/item/I = contents[1]
		user.visible_message("[user]从[src]中取出[I]", "你从[src]中取出[I]。",\
		"You hear someone rustle around in a plastic bag, and remove something.")
		overlays.Cut()	//remove the overlays

		user.put_in_hands(I)
		stored_item = null

		w_class = initial(w_class)
		icon_state = "evidenceobj"
		desc = "An empty evidence bag."
	else
		to_chat(user, "[src]是空的。")
		icon_state = "evidenceobj"


/obj/item/evidencebag/examine(mob/user)
	. = ..()
	. += stored_item?.examine(user)

/obj/item/storage/box/evidence
	name = "证物袋盒"
	desc = "一个声称装有证物袋的盒子。"
	spawn_type = /obj/item/evidencebag
	spawn_number = 6

/obj/item/f_card
	name = "指纹卡"
	desc = "用于采集指纹。"
	icon = 'icons/obj/items/card.dmi'
	icon_state = "fingerprint0"
	var/amount = 10
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/civilian_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/civilian_right.dmi',
	)
	worn_icon_state = "paper"
	throwforce = 1
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 5


/obj/item/fcardholder
	name = "指纹卡盒"
	desc = "使用指纹卡。"
	icon = 'icons/obj/items/items.dmi'
	icon_state = "fcardholder0"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/civilian_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/civilian_right.dmi',
	)
	worn_icon_state = "clipboard"
