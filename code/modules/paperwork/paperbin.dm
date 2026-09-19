/obj/structure/paper_bin
	name = "纸篓"
	icon = 'icons/obj/items/paper.dmi'
	density = FALSE
	anchored = FALSE
	icon_state = "paper_bin1"
	layer = LOW_ITEM_LAYER
	/// How much paper is in the bin.
	var/amount = 30
	/// List of papers put in the bin for reference.
	var/list/papers = list()

/obj/structure/paper_bin/MouseDrop(atom/over_object)
	if(over_object == usr && ishuman(usr) && !usr.restrained() && !usr.stat && (loc == usr || in_range(src, usr)))
		if(!usr.get_active_held_item())		//if active hand is empty
			attack_hand(usr, 1, 1)

/obj/structure/paper_bin/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	var/response = ""
	if(!length(papers))
		response = tgui_alert(user, "你要普通纸,还是复写纸?", "纸张类型请求", list("Regular", "Carbon-Copy", "Cancel"))
		if(response != "Regular" && response != "Carbon-Copy")
			return

	if(amount < 1)
		to_chat(user, span_notice("[src]是空的!"))
		return

	amount--
	update_icon()

	var/obj/item/paper/P
	if(length(papers))	//If there's any custom paper on the stack, use that instead of creating a new paper.
		P = papers[length(papers)]
		papers -= P
	else if(response == "Regular")
		P = new /obj/item/paper
	else if(response == "Carbon-Copy")
		P = new /obj/item/paper/carbon

	P.forceMove(user.loc)
	user.put_in_hands(P)
	to_chat(user, span_notice("你从[src]中取出了[P]."))

/obj/structure/paper_bin/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/paper))
		if(!user.transferItemToLoc(I, src))
			return

		to_chat(user, span_notice("你将[I]放入了[src]."))
		LAZYADD(papers, I)
		amount++

/obj/structure/paper_bin/examine(mob/user)
	. = ..()
	if(amount)
		. += span_notice("There " + (amount > 1 ? "are [amount] papers" : "is one paper") + " in the bin.")
	else
		. += span_notice("纸篓里没有纸张.")

/obj/structure/paper_bin/update_icon_state()
	. = ..()
	if(amount < 1)
		icon_state = "paper_bin0"
	else
		icon_state = "paper_bin1"
