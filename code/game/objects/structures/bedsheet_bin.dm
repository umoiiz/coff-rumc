/obj/item/bedsheet
	name = "床单"
	desc = "一条出奇柔软的亚麻床单."
	icon = 'icons/obj/items/bedsheets.dmi'
	icon_state = "sheet"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/civilian_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/civilian_right.dmi',
	)
	worn_icon_state = "bedsheet"
	layer = MOB_LAYER
	throwforce = 1
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_SMALL

/obj/item/bedsheet/attack_self(mob/user as mob)
	user.drop_held_item()
	if(layer == initial(layer))
		layer = ABOVE_MOB_LAYER
	else
		layer = initial(layer)

/obj/item/bedsheet/blue
	icon_state = "sheetblue"

/obj/item/bedsheet/green
	icon_state = "sheetgreen"

/obj/item/bedsheet/orange
	icon_state = "sheetorange"

/obj/item/bedsheet/purple
	icon_state = "sheetpurple"

/obj/item/bedsheet/rainbow
	icon_state = "sheetrainbow"

/obj/item/bedsheet/red
	icon_state = "sheetred"

/obj/item/bedsheet/yellow
	icon_state = "sheetyellow"

/obj/item/bedsheet/mime
	icon_state = "sheetmime"

/obj/item/bedsheet/clown
	icon_state = "sheetclown"

/obj/item/bedsheet/captain
	icon_state = "sheetcaptain"

/obj/item/bedsheet/rd
	icon_state = "sheetrd"

/obj/item/bedsheet/medical
	icon_state = "sheetmedical"

/obj/item/bedsheet/hos
	icon_state = "sheethos"

/obj/item/bedsheet/hop
	icon_state = "sheethop"

/obj/item/bedsheet/ce
	icon_state = "sheetce"

/obj/item/bedsheet/brown
	icon_state = "sheetbrown"

/obj/item/bedsheet/pred
	name = "猎人导航控制台"
	desc = "猎人用于导航的控制台."
	icon = 'icons/obj/machines/yautja_machines.dmi'
	icon_state = "cameras"

/obj/structure/bedsheetbin
	name = "亚麻布箱"
	desc = "一个亚麻布箱.看起来很舒适."
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "linenbin-full"
	anchored = TRUE
	var/amount = 20
	var/list/sheets = list()
	var/obj/item/hidden = null

/obj/structure/bedsheetbin/examine(mob/user)
	. = ..()
	if(amount < 1)
		. += "There are no bed sheets in the bin."
	else if(amount == 1)
		. += "There is one bed sheet in the bin."
	else
		. += "There are [amount] bed sheets in the bin."

/obj/structure/bedsheetbin/update_icon_state()
	. = ..()
	switch(amount)
		if(0)
			icon_state = "linenbin-empty"
		if(1 to 10)
			icon_state = "linenbin-half"
		else
			icon_state = "linenbin-full"

/obj/structure/bedsheetbin/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/bedsheet))
		if(!user.drop_held_item())
			return
		if(amount+1 > 20) //no more than 20 per bin
			to_chat(user, span_notice("[src]太满了!"))
			return

		I.forceMove(src)
		sheets += I
		amount++
		to_chat(user, span_notice("你把[I]放进了[src]。"))

	else if(amount && !hidden && I.w_class < 4)	//make sure there's sheets to hide it among, make sure nothing else is hidden in there.
		if(!user.drop_held_item())
			return

		I.forceMove(src)
		hidden = I
		to_chat(user, span_notice("你把[I]藏在了床单之间。"))

/obj/structure/bedsheetbin/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(amount >= 1)
		amount--

		var/obj/item/bedsheet/B
		if(length(sheets) > 0)
			B = sheets[length(sheets)]
			sheets.Remove(B)

		else
			B = new /obj/item/bedsheet(loc)

		B.loc = user.loc
		user.put_in_hands(B)
		to_chat(user, span_notice("你把[B]从[src]里拿了出来。"))

		if(hidden)
			hidden.loc = user.loc
			to_chat(user, span_notice("[hidden]从[B]里掉了出来！"))
			hidden = null
