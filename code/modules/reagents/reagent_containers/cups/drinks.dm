////////////////////////////////////////////////////////////////////////////////
/// Drinks.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/cup/glass
	name = "饮料"
	desc = "好喝"
	icon = 'icons/obj/drinks/drinks.dmi'
	icon_state = "glass_empty"
	possible_transfer_amounts = list(5,10,15,20,25,30,50)
	resistance_flags = NONE
	can_shatter = TRUE

/obj/item/reagent_containers/cup/glass/throw_impact(atom/hit_atom, speed, bounce)
	. = ..()
	smash(hit_atom, TRUE)

/obj/item/reagent_containers/cup/glass/proc/smash(atom/target, ranged = FALSE, break_top = FALSE)
	if(!can_shatter)
		return
	if(QDELING(src) || !target) //Invalid loc
		return
	var/obj/item/broken_bottle/B = new (loc)
	B.mimic_broken(src, target, break_top)
	qdel(src)
	target.Bumped(B)

///////////////////////////////////////////////Drinks
//Notes by Darem: Drinks are simply containers that start preloaded. Unlike condiments, the contents can be ingested directly
// rather then having to add it to something else first. They should only contain liquids. They have a default container size of 50.
// Formatting is the same as food.

/obj/item/reagent_containers/cup/glass/coffee
	name = "浓咖啡"
	desc = "小心,你即将享用的饮品非常烫."
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "coffee"
	base_icon_state = "coffee"
	list_reagents = list(/datum/reagent/consumable/coffee = 30)
	can_shatter = FALSE
	drink_type = BREAKFAST
	var/lid_open = FALSE

/obj/item/reagent_containers/cup/glass/coffee/no_lid
	icon_state = "coffee_empty"
	list_reagents = null

/obj/item/reagent_containers/cup/glass/coffee/examine(mob/user)
	. = ..()
	. += span_notice("Alt点击切换杯盖.")

/obj/item/reagent_containers/cup/glass/coffee/AltClick(mob/user)
	. = ..()
	lid_open = !lid_open
	update_icon_state()

/obj/item/reagent_containers/cup/glass/coffee/update_icon_state()
	. = ..()
	if(lid_open)
		icon_state = reagents.total_volume ? "[base_icon_state]_full" : "[base_icon_state]_empty"
	else
		icon_state = base_icon_state

/obj/item/reagent_containers/cup/glass/ice
	name = "冰杯"
	desc = "小心,冰很冷,不要咀嚼."
	icon_state = "icecup"
	list_reagents = list(/datum/reagent/consumable/ice = 30)
	can_shatter = FALSE

/obj/item/reagent_containers/cup/glass/mug // parent type is literally just so empty mug sprites are a thing
	name = "马克杯"
	desc = "用优雅马克杯盛装的饮品."
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "tea_empty"
	base_icon_state = "tea"

/obj/item/reagent_containers/cup/glass/mug/update_icon_state()
	icon_state = "[base_icon_state][reagents.total_volume ? null : "_empty"]"
	return ..()

/obj/item/reagent_containers/cup/glass/mug/tea
	name = "杜克紫茶"
	desc = "侮辱杜克紫就是侮辱太空女王!任何正派绅士都会因你玷污这茶而与你决斗."
	icon_state = "tea"
	list_reagents = list(/datum/reagent/consumable/tea = 30)

/obj/item/reagent_containers/cup/glass/mug/coco
	name = "荷兰热可可"
	desc = "产自太空南美洲."
	icon_state = "tea"
	list_reagents = list(/datum/reagent/consumable/hot_coco = 15, /datum/reagent/consumable/sugar = 5)
	drink_type = SUGAR

/obj/item/reagent_containers/cup/glass/mug/nanotrasen
	name = "\improper 纳米传讯马克杯"
	desc = "展示你企业自豪感的马克杯."
	icon_state = "mug_nt_empty"
	base_icon_state = "mug_nt"

/obj/item/reagent_containers/cup/glass/coffee_cup
	name = "咖啡杯"
	desc = "热成型的塑料咖啡杯.理论上也可用于其他热饮,如果你够胆的话."
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "coffee_cup_e"
	base_icon_state = "coffee_cup"
	possible_transfer_amounts = list(10)
	volume = 30
	can_shatter = FALSE

/obj/item/reagent_containers/cup/glass/coffee_cup/update_icon_state()
	icon_state = reagents.total_volume ? base_icon_state : "[base_icon_state]_e"
	return ..()

/obj/item/reagent_containers/cup/glass/dry_ramen
	name = "杯面"
	desc = "只需加入5毫升水,自热!让你想起学生时代的美味.全新咸味口味!"
	icon_state = "ramen"
	list_reagents = list(/datum/reagent/consumable/dry_ramen = 15, /datum/reagent/consumable/salt = 3)
	drink_type = GRAIN
	can_shatter = FALSE

/obj/item/reagent_containers/cup/glass/waterbottle
	name = "瓶装水"
	desc = "一瓶在旧地球装瓶厂灌装的水."
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "smallbottle"
	list_reagents = list(/datum/reagent/water = 49.5, /datum/reagent/fluorine = 0.5)//see desc, don't think about it too hard
	volume = 50
	amount_per_transfer_from_this = 10
	fill_icon_thresholds = list(0, 10, 25, 50, 75, 80, 90)
	can_shatter = FALSE
	// The 2 bottles have separate cap overlay icons because if the bottle falls over while bottle flipping the cap stays fucked on the moved overlay
	var/cap_icon = 'icons/obj/drinks/drink_effects.dmi'
	var/cap_icon_state = "bottle_cap_small"
	var/cap_on = TRUE
	var/cap_lost = FALSE
	var/mutable_appearance/cap_overlay
	var/flip_chance = 10

/obj/item/reagent_containers/cup/glass/waterbottle/Initialize(mapload)
	cap_overlay = mutable_appearance(cap_icon, cap_icon_state)
	return ..()

/obj/item/reagent_containers/cup/glass/waterbottle/update_overlays()
	. = ..()
	if(cap_on)
		. += cap_overlay

/obj/item/reagent_containers/cup/glass/waterbottle/examine(mob/user)
	. = ..()
	if(cap_lost)
		. += span_notice("瓶盖似乎不见了.")
	else if(cap_on)
		. += span_notice("瓶盖牢牢盖着以防洒出.Alt点击取下瓶盖.")
	else
		. += span_notice("瓶盖已被取下.Alt点击盖上瓶盖.")

/obj/item/reagent_containers/cup/glass/waterbottle/AltClick(mob/user)
	. = ..()
	if(cap_lost)
		to_chat(user, span_warning("瓶盖似乎不见了!它去哪了?"))
		return

	if(cap_on)
		cap_on = FALSE
		animate(src, transform = null, time = 2, loop = 0)
		to_chat(user, span_notice("你取下了[src]的瓶盖."))
		playsound(loc, 'sound/effects/can_open1.ogg', 50, TRUE)
	else
		cap_on = TRUE
		to_chat(user, span_notice("你盖上了[src]的瓶盖."))
	update_appearance()

/obj/item/reagent_containers/cup/glass/waterbottle/is_refillable()
	if(cap_on)
		return FALSE
	return ..()

/obj/item/reagent_containers/cup/glass/waterbottle/is_drainable()
	if(cap_on)
		return FALSE
	return ..()

/obj/item/reagent_containers/cup/glass/waterbottle/attack(mob/target, mob/living/user, def_zone)
	if(!target)
		return

	if(cap_on && reagents.total_volume && istype(target))
		to_chat(user, span_warning("你必须先取下瓶盖才能这么做!"))
		return

	return ..()

/obj/item/reagent_containers/cup/glass/waterbottle/afterattack(atom/target, mob/user, has_proximity, click_parameters)
	if(!has_proximity)
		return FALSE

	if(cap_on && (target.is_refillable() || target.is_drainable() || (reagents.total_volume && user.a_intent != INTENT_HARM)))
		to_chat(user, span_warning("你必须先取下瓶盖才能这么做!"))
		return

	else if(istype(target, /obj/item/reagent_containers/cup/glass/waterbottle))
		var/obj/item/reagent_containers/cup/glass/waterbottle/other_bottle = target
		if(other_bottle.cap_on)
			to_chat(user, span_warning("[other_bottle]的瓶盖被牢牢拧紧着!"))
			return

	return ..()

// heehoo bottle flipping
/obj/item/reagent_containers/cup/glass/waterbottle/throw_impact(atom/hit_atom, speed, bounce)
	. = ..()
	if(QDELETED(src))
		return
	if(!cap_on || !reagents.total_volume)
		return
	if(prob(flip_chance)) // landed upright
		visible_message(span_notice("[src]直立着地!"))
	else // landed on it's side
		animate(src, transform = matrix(prob(50)? 90 : -90, MATRIX_ROTATE), time = 3, loop = 0)

/obj/item/reagent_containers/cup/glass/waterbottle/pickup(mob/user)
	. = ..()
	animate(src, transform = null, time = 1, loop = 0)

/obj/item/reagent_containers/cup/glass/waterbottle/empty
	list_reagents = list()
	cap_on = FALSE

/obj/item/reagent_containers/cup/glass/waterbottle/large
	desc = "一瓶新鲜的商用大瓶装水."
	icon_state = "largebottle"
	list_reagents = list(/datum/reagent/water = 100)
	volume = 100
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100)
	cap_icon_state = "bottle_cap"

/obj/item/reagent_containers/cup/glass/waterbottle/large/empty
	list_reagents = list()
	cap_on = FALSE

// Admin spawn
/obj/item/reagent_containers/cup/glass/waterbottle/relic
	name = "神秘瓶子"
	desc = "一个与水瓶非常相似的瓶子,但上面用记号笔潦草地写着一些字.它似乎在散发某种能量."
	flip_chance = 100 // FLIPP

/obj/item/reagent_containers/cup/glass/waterbottle/relic/Initialize(mapload)
	var/reagent_id = get_random_reagent_id()
	var/datum/reagent/random_reagent = new reagent_id
	list_reagents = list(random_reagent.type = 50)
	. = ..()
	desc += span_notice("上面写着'[random_reagent.name]'.")
	update_appearance()


/obj/item/reagent_containers/cup/glass/sillycup
	name = "纸杯"
	desc = "一个纸质水杯."
	icon_state = "water_cup_e"
	possible_transfer_amounts = list(10)
	volume = 10
	can_shatter = FALSE

/obj/item/reagent_containers/cup/glass/sillycup/update_icon_state()
	icon_state = reagents.total_volume ? "water_cup" : "water_cup_e"
	return ..()

/obj/item/reagent_containers/cup/glass/bottle/juice/smallcarton
	name = "小纸盒"
	desc = "一个小纸盒,用于盛装饮品."
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "juicebox"
	volume = 15
	drink_type = NONE

/obj/item/reagent_containers/cup/glass/bottle/juice/smallcarton/Initialize(mapload, vol)
	. = ..()
	AddComponent( \
		/datum/component/takes_reagent_appearance, \
		on_icon_changed = CALLBACK(src, PROC_REF(on_cup_change)), \
		on_icon_reset = CALLBACK(src, PROC_REF(on_cup_reset)), \
		base_container_type = /obj/item/reagent_containers/cup/glass/bottle/juice/smallcarton, \
	)

/obj/item/reagent_containers/cup/glass/bottle/juice/smallcarton/smash(atom/target, mob/thrower, ranged = FALSE)
	try_splash(thrower, target)
	var/obj/item/broken_bottle/bottle_shard = new (loc)
	bottle_shard.mimic_broken(src, target)
	qdel(src)
	target.Bumped(bottle_shard)

/obj/item/reagent_containers/cup/glass/colocup
	name = "可乐杯"
	desc = "一种廉价、大批量生产的杯子,通常用于派对.出于某种原因,它们似乎从来都不是红色的..."
	icon = 'icons/obj/drinks/colo.dmi'
	icon_state = "colocup"
	possible_transfer_amounts = list(5, 10, 15, 20)
	volume = 20
	amount_per_transfer_from_this = 5
	can_shatter = FALSE
	/// Allows the lean sprite to display upon crafting
	var/random_sprite = TRUE

/obj/item/reagent_containers/cup/glass/colocup/Initialize(mapload)
	. = ..()
	pixel_x = rand(-4,4)
	pixel_y = rand(-4,4)
	if(!random_sprite)
		return
	icon_state = "colocup[rand(0, 6)]"
	if(icon_state == "colocup6")
		desc = "A cheap, mass produced style of cup, typically used at parties. Woah, this one is in red! What the hell?"

//////////////////////////drinkingglass and shaker//
//Note by Darem: This code handles the mixing of drinks. New drinks go in three places: In Chemistry-Reagents.dm (for the drink
// itself), in Chemistry-Recipes.dm (for the reaction that changes the components into the drink), and here (for the drinking glass
// icon states.

/obj/item/reagent_containers/cup/glass/flask
	name = "酒壶"
	desc = "每个优秀的太空人都知道,无论走到哪里,带上几品脱威士忌都是个好主意."
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "flask"
	volume = 60
	can_shatter = FALSE

/obj/item/reagent_containers/cup/glass/flask/gold
	name = "船长的酒壶"
	desc = "属于船长的一个金酒壶."
	icon_state = "flask_gold"

/obj/item/reagent_containers/cup/glass/flask/det
	name = "侦探的酒壶"
	desc = "侦探唯一真正的朋友."
	icon_state = "detflask"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 30)

/obj/item/reagent_containers/cup/glass/flask/det/minor
	list_reagents = list(/datum/reagent/consumable/applejuice = 30)

/obj/item/reagent_containers/cup/glass/mug/britcup
	name = "杯子"
	desc = "一个印有英国国旗的杯子."
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "britcup_empty"
	base_icon_state = "britcup"
	volume = 30
