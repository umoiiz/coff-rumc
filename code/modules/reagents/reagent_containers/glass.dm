/obj/item/reagent_containers/glass
	name = " "
	desc = " "
	icon = 'icons/obj/items/chemistry.dmi'
	icon_state = "null"
	worn_icon_state = "null"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,30,60)
	volume = 60
	reagent_flags = OPENCONTAINER
	var/base_name = " "
	var/label_text = ""

/obj/item/reagent_containers/glass/Initialize(mapload)
	. = ..()
	base_name = name

/obj/item/reagent_containers/glass/examine(mob/user)
	. = ..()
	if(get_dist(user, src) > 2 && user != loc)
		if(!is_open_container())
			. += span_info("密封盖将其完全密封.")

/obj/item/reagent_containers/glass/verb/attach_lid()
	set name = "Attach/Detach lid"
	set category = "IC.Object"
	if(is_open_container())
		to_chat(usr, span_notice("你把盖子盖在了\the [src]上."))
		DISABLE_BITFIELD(reagents.reagent_flags, OPENCONTAINER)
		ENABLE_BITFIELD(reagents.reagent_flags, TRANSPARENT)
	else
		to_chat(usr, span_notice("你把盖子从\the [src]上取了下来."))
		DISABLE_BITFIELD(reagents.reagent_flags, TRANSPARENT)
		ENABLE_BITFIELD(reagents.reagent_flags, OPENCONTAINER)
	update_icon()

/obj/item/reagent_containers/glass/afterattack(obj/target, mob/user , proximity)
	if(!proximity)
		return

	user.changeNext_move(CLICK_CD_RAPID)

	if(target.is_refillable()) //Something like a glass. Player probably wants to transfer TO it.
		if(!is_drainable())
			to_chat(user, span_warning("先取下[src]的盖子!"))
			return
		if(!reagents.total_volume)
			to_chat(user, span_warning("[src]是空的!"))
			return
		if(target.reagents.holder_full())
			to_chat(user, span_warning("[target]是满的."))
			return

		var/trans = reagents.trans_to(target, amount_per_transfer_from_this)
		to_chat(user, span_notice("你将[trans]单位\s 的溶液转移到了[target]中."))

	else if(target.is_drainable()) //A dispenser. Transfer FROM it TO us.
		if(!is_refillable())
			to_chat(user, span_warning("先取下[src]的盖子!"))
			return
		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target]是空的, 无法重新填充!"))
			return
		if(reagents.holder_full())
			to_chat(user, span_warning("[src]是满的."))
			return

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this)
		to_chat(user, span_notice("你用[target]中的[trans]单位\s 填充了[src]."))

	if(user.a_intent == INTENT_HARM)
		try_splash(user, target)

/obj/item/reagent_containers/glass/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/tool/pen) || istype(I, /obj/item/flashlight/pen))
		var/tmp_label = stripped_input(user, "Enter a label for [name]", "Label", label_text)
		if(length(tmp_label) > MAX_NAME_LEN)
			to_chat(user, span_warning("标签最多只能有[MAX_NAME_LEN]个字符长."))
			return

		user.visible_message(span_notice("[user]将[src]标记为\"[tmp_label]\"."), \
			span_notice("你将[src]标记为\"[tmp_label]\"."))

		label_text = tmp_label
		update_name_label()

/obj/item/reagent_containers/glass/proc/update_name_label()
	if(label_text == "")
		name = base_name
	else
		name = "[base_name] ([label_text])"

/obj/item/reagent_containers/glass/beaker
	name = "烧杯"
	desc = "一个烧杯. 最多可容纳60单位."
	icon = 'icons/obj/items/chemistry.dmi'
	icon_state = "beaker"
	worn_icon_state = "beaker"
	attack_speed = 4

/obj/item/reagent_containers/glass/beaker/on_reagent_change()
	update_icon()

/obj/item/reagent_containers/glass/beaker/pickup(mob/user)
	..()
	update_icon()

/obj/item/reagent_containers/glass/beaker/dropped(mob/user)
	..()
	update_icon()

/obj/item/reagent_containers/glass/beaker/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	update_icon()

/obj/item/reagent_containers/glass/beaker/update_overlays()
	. = ..()

	if(reagents.total_volume)
		var/image/filling = image('icons/obj/reagentfillings.dmi', src, "[icon_state]10")

		var/percent = round((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0 to 9)
				filling.icon_state = "[icon_state]-10"
			if(10 to 24)
				filling.icon_state = "[icon_state]10"
			if(25 to 49)
				filling.icon_state = "[icon_state]25"
			if(50 to 74)
				filling.icon_state = "[icon_state]50"
			if(75 to 79)
				filling.icon_state = "[icon_state]75"
			if(80 to 90)
				filling.icon_state = "[icon_state]80"
			if(91 to INFINITY)
				filling.icon_state = "[icon_state]100"

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		. += filling

	if(!is_open_container())
		var/image/lid = image(icon, src, "lid_[initial(icon_state)]")
		. += lid

/obj/item/reagent_containers/glass/beaker/large
	name = "大烧杯"
	desc = "一个大烧杯. 最多可容纳120单位."
	icon_state = "beakerlarge"
	volume = 120
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,30,40,60,120)

/obj/item/reagent_containers/glass/beaker/noreact
	name = "低温烧杯"
	desc = "一个低温烧杯, 可在不发生反应的情况下储存化学品. 最多可容纳60单位."
	icon_state = "beakernoreact"
	volume = 60
	reagent_flags = OPENCONTAINER|NO_REACT
	amount_per_transfer_from_this = 10

/obj/item/reagent_containers/glass/beaker/bluespace
	name = "蓝空间烧杯"
	desc = "一个蓝空间烧杯, 由实验性蓝空间技术驱动. 最多可容纳300单位."
	icon_state = "beakerbluespace"
	volume = 300
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 30, 50, 60, 100, 120, 150, 300)

/obj/item/reagent_containers/glass/beaker/vial
	name = "小瓶"
	desc = "一个小玻璃瓶. 最多可容纳30单位."
	icon_state = "vial"
	volume = 30
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 30)

/obj/item/reagent_containers/glass/beaker/cryoxadone
	list_reagents = list(
		/datum/reagent/medicine/cryoxadone = 10,
		/datum/reagent/medicine/clonexadone = 10,
		/datum/reagent/medicine/saline_glucose = 5,
		/datum/reagent/medicine/tricordrazine = 10,
		/datum/reagent/medicine/quickclot = 5,
		/datum/reagent/medicine/dexalinplus = 5,
		/datum/reagent/medicine/spaceacillin = 5,
		/datum/reagent/medicine/bihexajuline = 5,
		/datum/reagent/medicine/peridaxon = 5,
		)
//Такой же микс как и снизу, но чтобы не менять спавн этих баночек на корабле или планете

/obj/item/reagent_containers/glass/beaker/cryoxadone/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/reagent_containers/glass/beaker/cryomix
	list_reagents = list(
		/datum/reagent/medicine/cryoxadone = 10,
		/datum/reagent/medicine/clonexadone = 10,
		/datum/reagent/medicine/saline_glucose = 5,
		/datum/reagent/medicine/tricordrazine = 10,
		/datum/reagent/medicine/quickclot = 5,
		/datum/reagent/medicine/dexalinplus = 5,
		/datum/reagent/medicine/spaceacillin = 5,
		/datum/reagent/medicine/bihexajuline = 5,
		/datum/reagent/medicine/peridaxon = 5,
	)

/obj/item/reagent_containers/glass/beaker/cryomix/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/reagent_containers/glass/beaker/sulphuric
	list_reagents = list(/datum/reagent/toxin/acid = 60)

/obj/item/reagent_containers/glass/beaker/sulphuric/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/reagent_containers/glass/bucket
	desc = "这是个水桶."
	name = "水桶"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "bucket"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/janitor_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/janitor_right.dmi',
	)
	worn_icon_state = "bucket"
	w_class = WEIGHT_CLASS_NORMAL
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = list(10,20,30,60,120)
	volume = 120

/obj/item/reagent_containers/glass/bucket/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(!istype(I, /obj/item/tool/mop))
		return
	if(reagents.total_volume < 1)
		to_chat(user, "[src]没水了!</span>")
		return
	reagents.trans_to(I, 5)
	to_chat(user, span_notice("你在[src]中弄湿了[I]."))
	playsound(loc, 'sound/effects/slosh.ogg', 25, 1)

/obj/item/reagent_containers/glass/bucket/update_overlays()
	. = ..()

	if(!is_open_container())
		var/image/lid = image(icon, src, "lid_[initial(icon_state)]")
		. += lid

/obj/item/reagent_containers/glass/bucket/janibucket
	name = "清洁工水桶"
	desc = "这是个可以放进清洁工推车的大水桶."
	icon_state = "janibucket"

/obj/item/reagent_containers/glass/bucket/janibucket/on_reagent_change()
	update_icon()

/obj/item/reagent_containers/glass/bucket/janibucket/update_icon_state()
	. = ..()
	if(reagents.total_volume)
		var/percent = round((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0 to 9)
				icon_state = "janibucket"
			if(10 to 65)
				icon_state = "janibucket_half"
			if(66 to INFINITY)
				icon_state = "janibucket_full"
	else
		icon_state = "janibucket"
