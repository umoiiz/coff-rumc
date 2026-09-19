/obj/item/reagent_containers/cup
	name = "打开的容器"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50)
	volume = 50
	reagent_flags = OPENCONTAINER
	resistance_flags = UNACIDABLE
	icon_state = "bottle"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/drinks_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/drinks_righthand.dmi',
	)

	///Like Edible's food type, what kind of drink is this?
	var/drink_type = NONE
	///The last time we have checked for taste.
	var/last_check_time
	///How much we drink at once, shot glasses drink more.
	var/gulp_size = 5
	///Whether the 'bottle' is made of glass or not so that milk cartons dont shatter when someone gets hit by it.
	var/can_shatter = FALSE

/obj/item/reagent_containers/cup/examine(mob/user)
	. = ..()
	if(drink_type)
		var/list/types = bitfield_to_list(drink_type, FOOD_FLAGS)
		. += span_notice("它是[LOWER_TEXT(english_list(types))].")

/obj/item/reagent_containers/cup/attack(mob/living/target_mob, mob/living/user, obj/target)
	if(!reagents || !reagents.total_volume)
		to_chat(user, span_warning("[src]是空的!"))
		return

	if(!istype(target_mob))
		return

	if(target_mob != user)
		target_mob.visible_message(span_danger("[user]试图从[src]中喂[target_mob]一些东西."), \
					span_userdanger("[user]试图从[src]中喂你一些东西."))
		if(!do_after(user, 3 SECONDS, target = target_mob))
			return
		if(!reagents || !reagents.total_volume)
			return // The drink might be empty after the delay, such as by spam-feeding
		target_mob.visible_message(span_danger("[user]从[src]中喂了[target_mob]一些东西."), \
					span_userdanger("[user]从[src]中喂了你一些东西."))
	else
		to_chat(user, span_notice("你吞下了一口[src]."))

	SEND_SIGNAL(src, COMSIG_GLASS_DRANK, target_mob, user)
	reagents.trans_to(target_mob, gulp_size)
	playsound(target_mob.loc,'sound/items/drink.ogg', rand(10,50), TRUE)

/obj/item/reagent_containers/cup/afterattack(atom/target, mob/user, has_proximity, click_parameters)
	. = ..()
	if(!has_proximity)
		return ..()

	if(!check_allowed_items(target, target_self = TRUE))
		return

	if(target.is_refillable()) //Something like a glass. Player probably wants to transfer TO it.
		if(!reagents.total_volume)
			to_chat(user, span_warning("[src]是空的!"))
			return

		if(target.reagents.holder_full())
			to_chat(user, span_warning("[target]是满的."))
			return

		var/trans = reagents.trans_to(target, amount_per_transfer_from_this)
		to_chat(user, span_notice("你将[trans]单位\s 的溶液转移到[target]中."))
		SEND_SIGNAL(src, COMSIG_REAGENTS_CUP_TRANSFER_TO, target)
		target.update_appearance()

	else if(target.is_drainable()) //A dispenser. Transfer FROM it TO us.
		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target]是空的,无法重新填充!"))
			return

		if(reagents.holder_full())
			to_chat(user, span_warning("[src]已满."))
			return

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this)
		to_chat(user, span_notice("你将[target]中的[trans]单位\s 内容物装入[src]."))
		SEND_SIGNAL(src, COMSIG_REAGENTS_CUP_TRANSFER_FROM, target)
		target.update_appearance()

/obj/item/reagent_containers/cup/afterattack_alternate(atom/target, mob/user, has_proximity, click_parameters)
	if((!has_proximity) || !check_allowed_items(target, target_self = TRUE))
		return FALSE

	if(!target.is_drainable()) //A dispenser. Transfer FROM it TO us.
		return FALSE

	if(!target.reagents.total_volume)
		to_chat(user, span_warning("[target]是空的!"))
		return FALSE

	if(reagents.holder_full())
		to_chat(user, span_warning("[src]已满."))
		return FALSE

	var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this)
	to_chat(user, span_notice("你将[target]中的[trans]单位\s 内容物装入[src]."))

	target.update_appearance()

/obj/item/reagent_containers/cup/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/reagent_containers/food/snacks/egg)) //breaking eggs // TG FOOD PORT -> Turn this into real eggs
		var/obj/item/reagent_containers/food/snacks/egg/attacking_egg = attacking_item
		if(!reagents)
			return TRUE
		if(reagents.holder_full())
			to_chat(user, span_notice("[src]已满."))
		else
			to_chat(user, span_notice("你在[src]中打碎了[attacking_egg]."))
			attacking_egg.reagents.trans_to(src, attacking_egg.reagents.total_volume)
			qdel(attacking_egg)
		return TRUE

	return ..()

/// Callback for [datum/component/takes_reagent_appearance] to inherent style footypes
/obj/item/reagent_containers/cup/proc/on_cup_change(datum/glass_style/has_foodtype/style)
	if(!istype(style))
		return
	drink_type = style.drink_type

/// Callback for [datum/component/takes_reagent_appearance] to reset to no foodtypes
/obj/item/reagent_containers/cup/proc/on_cup_reset()
	drink_type = NONE

//Coffeepots: for reference, a standard cup is 30u, to allow 20u for sugar/sweetener/milk/creamer
/obj/item/reagent_containers/cup/coffeepot
	name = "咖啡壶"
	desc = "一个用于分发凡人只知道叫咖啡的公司生活甘露的大壶. 可装4标准杯."
	volume = 120
	icon_state = "coffeepot"
	fill_icon_state = "coffeepot"
	fill_icon_thresholds = list(0, 1, 30, 60, 100)

/obj/item/reagent_containers/cup/coffeepot/bluespace
	name = "蓝空间咖啡壶"
	desc = "书呆子们能搞出的最先进咖啡壶: 流线型设计; 刻度线; 连接到一个用于容纳咖啡的口袋维度; 没错, 它全都有. 可装8标准杯."
	volume = 240
	icon_state = "coffeepot_bluespace"
	fill_icon_thresholds = list(0)
