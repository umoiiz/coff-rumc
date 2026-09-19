////////////////////////////////////////////////////////////////////////////////
/// Drinks.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/food/drinks
	name = "喝"
	desc = "好吃"
	icon = 'icons/obj/items/drinks.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/drinks_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/drinks_right.dmi',
	)
	icon_state = null
	reagent_flags = OPENCONTAINER_NOUNIT
	possible_transfer_amounts = list(5,10,15,20,30,60)
	volume = 50
	var/gulp_size = 5 //This is now officially broken ... need to think of a nice way to fix it.

/obj/item/reagent_containers/food/drinks/on_reagent_change()
	if (gulp_size < 5) gulp_size = 5
	else gulp_size = max(round(reagents.total_volume / 5), 5)

/obj/item/reagent_containers/food/drinks/attack(mob/M as mob, mob/user as mob, def_zone)
	var/datum/reagents/R = src.reagents

	if(!R.total_volume || !R)
		to_chat(user, span_warning("[src.name]是空的!"))
		return FALSE

	if(iscarbon(M))
		if(M == user)
			var/mob/living/carbon/H = M
			if(ishuman(H) && (H.species.species_flags & ROBOTIC_LIMBS))
				to_chat(M, span_warning("你脑袋是个显示器,你觉得你能往哪儿放?"))
				return
			to_chat(M,span_notice("你从\the [src]中吞下一大口."))
			record_reagent_consumption(min(gulp_size, reagents.total_volume), reagents.reagent_list, user)
			if(reagents.total_volume)
				reagents.reaction(M, INGEST)
				reagents.trans_to(M, gulp_size, transfer_to_stomach = TRUE)
			playsound(M.loc,'sound/items/drink.ogg', 15, 1)
			return TRUE
		else
			var/mob/living/carbon/H = M
			if(ishuman(H) && (H.species.species_flags & ROBOTIC_LIMBS))
				to_chat(user, span_warning("他们脑袋是个显示器,你觉得你能往哪儿放?"))
				return
			M.visible_message(span_warning("[user]试图喂[M]\the [src]."))
			if(!do_after(user, 3 SECONDS, NONE, M, BUSY_ICON_FRIENDLY))
				return
			M.visible_message(span_warning("[user]喂了[M]\the [src]."))

			var/rgt_list_text = get_reagent_list_text()

			log_combat(user, M, "fed", src, "Reagents: [rgt_list_text]")
			record_reagent_consumption(min(gulp_size, reagents.total_volume), reagents.reagent_list, user, M)

			if(reagents.total_volume)
				reagents.reaction(M, INGEST)
				reagents.trans_to(M, gulp_size, transfer_to_stomach = TRUE)

			playsound(M.loc,'sound/items/drink.ogg', 15, 1)
			return TRUE

	return FALSE


/obj/item/reagent_containers/food/drinks/afterattack(obj/target, mob/user, proximity)
	if(!proximity)
		return

	if(target.is_refillable())
		if(!is_drainable())
			to_chat(user, span_notice("[src]的标签页没打开!"))
			return
		if(!reagents.total_volume)
			to_chat(user, span_warning("[src]是空的."))
			return
		if(target.reagents.holder_full())
			to_chat(user, span_warning("[target]是满的."))
			return

		var/trans = src.reagents.trans_to(target, amount_per_transfer_from_this)
		to_chat(user, span_notice("你将[trans]单位的溶液转移到[target]中."))

	else if(target.is_drainable()) //A dispenser Transfer FROM it TO us.
		if(!is_refillable())
			to_chat(user, span_notice("[src]的标签页没打开!"))
			return
		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target]是空的."))
			return
		if(reagents.holder_full())
			to_chat(user, span_warning("[src]是满的."))
			return

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this)
		to_chat(user, span_notice("你用[target]中[trans]单位的内容物装满了[src]."))

	return ..()

////////////////////////////////////////////////////////////////////////////////
/// Drinks. END
////////////////////////////////////////////////////////////////////////////////

/obj/item/reagent_containers/food/drinks/golden_cup
	desc = "你是赢家!"
	name = "金杯"
	icon_state = "golden_cup"
	worn_icon_state = "" //nope :(
	w_class = WEIGHT_CLASS_BULKY
	force = 14
	throwforce = 10
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = null
	volume = 150
	atom_flags = CONDUCT

/obj/item/reagent_containers/food/drinks/golden_cup/tournament_26_06_2011
	desc = "一个金杯. 它将颁发给6月26日锦标赛的获胜者,获胜者的名字将被刻在上面."


///////////////////////////////////////////////Drinks
//Notes by Darem: Drinks are simply containers that start preloaded. Unlike condiments, the contents can be ingested directly
//	rather then having to add it to something else first. They should only contain liquids. They have a default container size of 50.
//	Formatting is the same as food.

/obj/item/reagent_containers/food/drinks/milk
	name = "太空牛奶"
	desc = "这是牛奶. 白色且营养丰富的美味!"
	icon_state = "milk"
	worn_icon_state = "carton"
	center_of_mass = list("x"=16, "y"=9)
	list_reagents = list(/datum/reagent/consumable/milk = 50)

/obj/item/reagent_containers/food/drinks/soymilk
	name = "豆奶"
	desc = "这是豆奶. 白色且营养丰富的美味!"
	icon_state = "soymilk"
	worn_icon_state = "carton"
	center_of_mass = list("x"=16, "y"=9)
	list_reagents = list(/datum/reagent/consumable/soymilk = 50)

/obj/item/reagent_containers/food/drinks/coffee
	name = "\improper 咖啡"
	desc = "小心,你即将享用的饮料非常烫."
	icon_state = "coffee"
	center_of_mass = list("x"=15, "y"=10)
	list_reagents = list(/datum/reagent/consumable/coffee = 30)

/obj/item/reagent_containers/food/drinks/coffee/cafe_latte
	name = "\improper 拿铁咖啡"
	desc = "你即将享用的饮料是热的."
	list_reagents = list(/datum/reagent/consumable/coffee/cafe_latte = 30)

/obj/item/reagent_containers/food/drinks/tea
	name = "\improper 紫公爵茶"
	desc = "对紫公爵的侮辱就是对太空女王的侮辱! 如果你玷污了这茶,任何正派的绅士都会向你发起决斗."
	icon_state = "teacup"
	worn_icon_state = "coffee"
	center_of_mass = list("x"=16, "y"=14)
	list_reagents = list(/datum/reagent/consumable/tea = 30)

/obj/item/reagent_containers/food/drinks/ice
	name = "冰杯"
	desc = "小心,冰冷的冰块,不要咀嚼."
	icon_state = "coffee"
	center_of_mass = list("x"=15, "y"=10)
	list_reagents = list(/datum/reagent/consumable/ice = 30)

/obj/item/reagent_containers/food/drinks/h_chocolate
	name = "\improper 荷兰热可可"
	desc = "产自太空南美洲."
	icon_state = "hot_coco"
	worn_icon_state = "coffee"
	center_of_mass = list("x"=15, "y"=13)
	list_reagents = list(/datum/reagent/consumable/hot_coco = 30)

/obj/item/reagent_containers/food/drinks/dry_ramen
	name = "杯面"
	desc = "只需加入10毫升水,自加热! 让你回忆起学生时代的美味."
	icon_state = "ramen"
	center_of_mass = list("x"=16, "y"=11)
	list_reagents = list(/datum/reagent/consumable/dry_ramen = 30)

/obj/item/reagent_containers/food/drinks/sillycup
	name = "纸杯"
	desc = "一个纸质水杯."
	icon_state = "water_cup_e"
	possible_transfer_amounts = null
	volume = 10
	center_of_mass = list("x"=16, "y"=12)

/obj/item/reagent_containers/food/drinks/sillycup/on_reagent_change()
	if(reagents.total_volume)
		icon_state = "water_cup"
	else
		icon_state = "water_cup_e"

/obj/item/reagent_containers/food/drinks/coconutmilk
	name = "椰子饮料"
	desc = "这是一个插着吸管的开口椰子. 美味又营养!"
	icon_state = "coconut_drink_2"
	center_of_mass = list("x"=16, "y"=9)
	list_reagents = list(/datum/reagent/consumable/milk = 50)

/obj/item/reagent_containers/food/drinks/coconutmilk/green
	desc = "这是一个插着吸管的开口椰子. 这个甚至还配了把小伞,真讲究."
	icon_state = "coconut_drink_1"

//////////////////////////drinkingglass and shaker//
//Note by Darem: This code handles the mixing of drinks. New drinks go in three places: In Chemistry-Reagents.dm (for the drink
//	itself), in Chemistry-Recipes.dm (for the reaction that changes the components into the drink), and here (for the drinking glass
//	icon states.

/obj/item/reagent_containers/food/drinks/shaker
	name = "调酒壶"
	desc = "一个用来调酒的金属调酒壶."
	icon_state = "shaker"
	amount_per_transfer_from_this = 10
	volume = 120
	center_of_mass = list("x"=17, "y"=10)

/obj/item/reagent_containers/food/drinks/flask
	name = "金属酒壶"
	desc = "一个容量不错的金属酒壶."
	icon_state = "flask"
	volume = 60
	center_of_mass = list("x"=17, "y"=8)

/obj/item/reagent_containers/food/drinks/flask/marine
	name = "\improper 战斗水壶"
	desc = "一个用金属加固的水壶,装满了水. 保持水分!"
	icon_state = "canteen"
	center_of_mass = list("x"=17, "y"=8)
	list_reagents = list(/datum/reagent/water = 60)
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/drinks/flask/detflask
	name = "侦探的酒壶"
	desc = "一个带有皮革束带和金色徽章的金属酒壶,属于侦探."
	icon_state = "detflask"
	center_of_mass = list("x"=17, "y"=8)
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 30)

/obj/item/reagent_containers/food/drinks/flask/barflask
	name = "酒壶"
	desc = "献给那些懒得去酒吧喝酒的人."
	icon_state = "barflask"
	center_of_mass = list("x"=17, "y"=7)

/obj/item/reagent_containers/food/drinks/flask/vacuumflask
	name = "保温瓶"
	desc = "自1892年以来,让你的饮料保持在完美温度."
	icon_state = "vacuumflask"
	center_of_mass = list("x"=15, "y"=4)

/obj/item/reagent_containers/food/drinks/britcup
	name = "英国茶杯"
	desc = "一个印有英国国旗的茶杯. 看到它让你充满怀旧之情."
	icon_state = "britcup"
	volume = 30
	center_of_mass = list("x"=15, "y"=13)
	list_reagents = list(/datum/reagent/consumable/tea = 30)
