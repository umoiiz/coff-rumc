
//////////////////////////soda_cans//
//These are in their own group to be used as IED's in /obj/item/grenade/ghettobomb.dm
/// How much fizziness is added to the can of soda by throwing it, in percentage points
#define SODA_FIZZINESS_THROWN 15
/// How much fizziness is added to the can of soda by shaking it, in percentage points
#define SODA_FIZZINESS_SHAKE 5

/obj/item/reagent_containers/cup/soda_cans
	name = "汽水罐"
	icon = 'icons/obj/drinks/soda.dmi'
	icon_state = "cola"
	icon_state_preview = "cola"
	reagent_flags = NONE
	obj_flags = CAN_BE_HIT
	possible_transfer_amounts = list(5, 10, 15, 25, 30)
	volume = 30
	throwforce = 12 // set to 0 upon being opened. Have you ever been domed by a soda can? Those things fucking hurt
	/// If the can hasn't been opened yet, this is the measure of how fizzed up it is from being shaken or thrown around. When opened, this is rolled as a percentage chance to burst
	var/fizziness = 0

/obj/item/reagent_containers/cup/soda_cans/random/Initialize(mapload)
	..()
	var/T = pick(subtypesof(/obj/item/reagent_containers/cup/soda_cans) - /obj/item/reagent_containers/cup/soda_cans/random)
	new T(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/reagent_containers/cup/soda_cans/attack(mob/target_mob, mob/living/user)
	if(iscarbon(target_mob) && !reagents.total_volume && (user.a_intent == INTENT_HARM) && user.zone_selected == BODY_ZONE_HEAD)
		if(target_mob == user)
			user.visible_message(span_warning("[user]把[src]罐砸在[user.p_their()]的额头上!"), span_notice("你把[src]罐砸在自己的额头上."))
		else
			user.visible_message(span_warning("[user]把[src]罐砸在[target_mob]的额头上!"), span_notice("你把[src]罐砸在[target_mob]的额头上."))
		playsound(target_mob,'sound/weapons/pierce.ogg', rand(10,50), TRUE)
		var/obj/item/trash/can/crushed_can = new /obj/item/trash/can(target_mob.loc)
		crushed_can.icon_state = icon_state
		qdel(src)
		return TRUE
	return ..()

/obj/item/reagent_containers/cup/soda_cans/proc/open_soda(mob/user)
	if(prob(fizziness))
		user.visible_message(span_danger("[user]打开[src],突然被冒泡的内容物喷了一身!"), span_danger("你拉开[src]的拉环,突然被一股液体喷了一脸!啊啊!!"))
		burst_soda(user)
		return

	to_chat(user, "你拉开[src]的拉环,伴随着一声令人满足的噗嗤声.") //Ahhhhhhhh
	reagents.reagent_flags |= OPENCONTAINER
	playsound(src, "can_open", 50, TRUE)
	throwforce = 0

/**
 * Burst the soda open on someone. Fun! Opens and empties the soda can, but does not crush it.
 *
 * Arguments:
 * * target - Who's getting covered in soda
 * * hide_message - Stops the generic fizzing message, so you can do your own
 */
/obj/item/reagent_containers/cup/soda_cans/proc/burst_soda(atom/target, hide_message = FALSE)
	if(!target)
		return

	playsound(src, 'sound/effects/can_pop.ogg', 80, TRUE)
	if(!hide_message)
		visible_message(span_danger("[src]洒了出来,冒泡的内容物溅了[target]一身!"))
	reagents.reagent_flags |= OPENCONTAINER
	reagents.clear_reagents()
	throwforce = 0

/obj/item/reagent_containers/cup/soda_cans/throw_impact(atom/hit_atom, speed, bounce)
	. = ..()
	if(. || !reagents.total_volume) // if it was caught, already opened, or has nothing in it
		return

	fizziness += SODA_FIZZINESS_THROWN
	if(!prob(fizziness))
		return

	burst_soda(hit_atom, hide_message = TRUE)
	visible_message(span_danger("[src]撞到[hit_atom]导致其破裂,洒得到处都是!"))
	var/obj/item/trash/can/crushed_can = new /obj/item/trash/can(src.loc)
	crushed_can.icon_state = icon_state
	moveToNullspace()
	QDEL_IN(src, 1 SECONDS) // give it a second so it can still be logged for the throw impact

/obj/item/reagent_containers/cup/soda_cans/attack_self(mob/user)
	if(!is_drainable())
		open_soda(user)
		return
	return ..()

/obj/item/reagent_containers/cup/soda_cans/attack_self_alternate(mob/living/user)
	if(!is_drainable())
		playsound(src, 'sound/effects/can_shake.ogg', 50, TRUE)
		user.visible_message(span_danger("[user]摇晃[src]!"), span_danger("你摇晃[src]!"), vision_distance=2)
		fizziness += SODA_FIZZINESS_SHAKE
		return
	return ..()

/obj/item/reagent_containers/cup/soda_cans/examine(mob/user)
	. = ..()
	if(!in_range(user, src))
		return
	if(fizziness > 30 && prob(fizziness * 2))
		. += span_notice("<i>你仔细检查[src],注意到以下内容...</i>")
		. += "\t[span_warning("You get a menacing aura of fizziness from it...")]"

#undef SODA_FIZZINESS_THROWN
#undef SODA_FIZZINESS_SHAKE

/obj/item/reagent_containers/cup/soda_cans/cola
	name = "太空可乐"
	desc = "可乐.在太空里."
	icon_state = "cola"
	list_reagents = list(/datum/reagent/consumable/space_cola = 30)
	drink_type = SUGAR

/obj/item/reagent_containers/cup/soda_cans/tonic
	name = "T-Borg的汤力水"
	desc = "奎宁味道怪怪的,但至少能帮你远离太空疟疾."
	icon_state = "tonic"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/tonic = 50)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/soda_cans/sodawater
	name = "苏打水"
	desc = "一罐苏打水.何不调一杯苏格兰威士忌加苏打呢?"
	icon_state = "sodawater"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/sodawater = 50)

/obj/item/reagent_containers/cup/soda_cans/lemon_lime
	name = "橙子汽水"
	desc = "你想要橙子味.它却给了你柠檬青柠味."
	icon_state = "lemon-lime"
	list_reagents = list(/datum/reagent/consumable/lemon_lime = 30)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/soda_cans/lemon_lime/Initialize(mapload)
	. = ..()
	name = "lemon-lime soda"

/obj/item/reagent_containers/cup/soda_cans/sol_dry
	name = "Sol干姜水"
	desc = "也许这能让你的肚子舒服点.也许不能."
	icon_state = "sol_dry"
	list_reagents = list(/datum/reagent/consumable/sol_dry = 30)
	drink_type = SUGAR

/obj/item/reagent_containers/cup/soda_cans/space_up
	name = "Space-Up!"
	desc = "尝起来就像嘴里发生了船体破裂."
	icon_state = "space-up"
	list_reagents = list(/datum/reagent/consumable/space_up = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/starkist
	name = "Star-kist"
	desc = "液体形态的星星的味道.还有,一点金枪鱼...?"
	icon_state = "starkist"
	list_reagents = list(/datum/reagent/consumable/space_cola = 15, /datum/reagent/consumable/orangejuice = 15)
	drink_type = SUGAR | FRUIT | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/space_mountain_wind
	name = "太空山风"
	desc = "像太空风一样直接穿过你."
	icon_state = "space_mountain_wind"
	list_reagents = list(/datum/reagent/consumable/spacemountainwind = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/thirteenloko
	name = "Thirteen Loko"
	desc = "首席医疗官已告知船员,饮用Thirteen Loko可能导致癫痫发作、失明、醉酒,甚至死亡.请理性饮酒."
	icon_state = "thirteen_loko"
	list_reagents = list(/datum/reagent/consumable/ethanol/thirteenloko = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/dr_gibb
	name = "Gibb博士"
	desc = "42种不同口味的绝妙混合."
	icon_state = "dr_gibb"
	list_reagents = list(/datum/reagent/consumable/dr_gibb = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/pwr_game
	name = "Pwr Game"
	desc = "唯一一款拥有真正玩家所渴望的PWR的饮料.当玩家谈论玩家燃料时,他们指的就是这个."
	icon_state = "purple_can"
	list_reagents = list(/datum/reagent/consumable/pwr_game = 30)

/obj/item/reagent_containers/cup/soda_cans/shamblers
	name = "蹒跚者果汁"
	desc = "~给我摇一杯蹒跚者果汁!~"
	icon_state = "shamblers"
	list_reagents = list(/datum/reagent/consumable/shamblers = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/wellcheers
	name = "Wellcheers果汁"
	desc = "一种奇怪的紫色饮料,闻起来有海水的味道.在远处的某个地方,你听到了海鸥的叫声."
	icon_state = "wellcheers"
	list_reagents = list(/datum/reagent/consumable/wellcheers = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/grey_bull
	name = "灰牛"
	desc = "灰牛,它给你手套!"
	icon_state = "energy_drink"
	list_reagents = list(/datum/reagent/consumable/grey_bull = 20)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/monkey_energy
	name = "猴子能量"
	desc = "释放猿猴之力!"
	icon_state = "monkey_energy"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/monkey_energy = 50)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/volt_energy
	name = "24伏特能量"
	desc = "充电,用24伏特能量!"
	icon_state = "volt_energy"
	list_reagents = list(/datum/reagent/consumable/volt_energy = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/melon_soda
	name = "Kansumi蜜瓜汽水"
	desc = "日本最受欢迎的蜜瓜汽水,现在有罐装啦!"
	icon_state = "melon_soda"
	list_reagents = list(/datum/reagent/consumable/melon_soda = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/soda_cans/air
	name = "罐装空气"
	desc = "空气并不短缺.请勿饮用."
	icon_state = "air"
	list_reagents = list(/datum/reagent/nitrogen = 24, /datum/reagent/oxygen = 6)

/obj/item/reagent_containers/cup/soda_cans/beer
	name = "太空啤酒"
	desc = "罐装啤酒.在太空里."
	icon_state = "space_beer"
	volume = 40
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 40)
	drink_type = GRAIN

/obj/item/reagent_containers/cup/soda_cans/beer/rice
	name = "米啤酒"
	desc = "一种清淡的、以大米为原料的拉格啤酒,在火星上很受欢迎.根据1516年《纯净法》,这被视为对巴伐利亚人的仇恨犯罪."
	icon_state = "ebisu"
	list_reagents = list(/datum/reagent/consumable/ethanol/rice_beer = 40)

/obj/item/reagent_containers/cup/soda_cans/beer/rice/Initialize(mapload)
	. = ..()
	var/brand = pick("Ebisu Super Dry", "Shimauma Ichiban", "Moonlabor Malt's")
	name = "[brand]"
	switch(brand)
		if("Ebisu Super Dry")
			icon_state = "ebisu"
			desc = "Mars' favourite rice beer brand, 200 years running."
		if("Shimauma Ichiban")
			icon_state = "shimauma"
			desc = "Mars' most middling rice beer brand. Not as popular as Ebisu, but it's comfortable in second place."
		if("Moonlabor Malt's")
			icon_state = "moonlabor"
			desc = "Mars' underdog rice beer brand. Popular amongst the Yakuza, for reasons unknown."
