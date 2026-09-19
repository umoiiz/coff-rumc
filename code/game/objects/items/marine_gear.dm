
/**********************Marine Gear**************************/

//MARINE COMBAT LIGHT

/obj/item/flashlight/combat
	name = "战斗手电筒"
	desc = "一款坚固的手电筒,设计用于手持或安装在步枪上"
	force = 10 //This is otherwise no different from a normal flashlight minus the flavour.
	throwforce = 12 //"combat" flashlight

/obj/structure/broken_apc
	name = "\improper M577装甲运兵车"
	desc = "一辆大型装甲巨兽,能够运送陆战队员. \nThis一辆已无法运作."
	anchored = TRUE
	opacity = TRUE
	density = TRUE
	icon = 'icons/obj/structures/broken_apc.dmi'
	icon_state = "apc"


/obj/item/storage/box/tgmc_mre
	name = "\improper TGMC即食口粮"
	desc = "<B>说明:</B> 使用最大火力提取食物.食用.\n\nOn 盒子上印着一个正在大喊的小队长. \n\"你会吃掉你的营养糊,而且你会享受它,蛆虫.\""
	icon_state = "mre1"

/obj/item/storage/box/tgmc_mre/Initialize(mapload, ...)
	. = ..()
	pixel_y = rand(-3,3)
	pixel_x = rand(-3,3)

/obj/item/storage/box/tgmc_mre/PopulateContents()
	var/list/randompick = list(
		/obj/item/reagent_containers/food/snacks/protein_pack,
		/obj/item/reagent_containers/food/snacks/protein_pack,
		/obj/item/reagent_containers/food/snacks/protein_pack,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal1,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal2,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal3,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal4,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal5,
		/obj/item/reagent_containers/food/snacks/mre_pack/meal6)

	for(var/i in 1 to 7)
		var/picked = pick(randompick)
		new picked(src)

/obj/item/reagent_containers/food/snacks/protein_pack
	name = "TGMC蛋白棒"
	desc = "你见过的最假的蛋白棒,有多种口味"
	icon = 'icons/obj/items/food/mre.dmi'
	icon_state = "yummers"
	filling_color = "#ED1169"
	w_class = WEIGHT_CLASS_TINY
	bitesize = 4
	greyscale_config = /datum/greyscale_config/protein
	tastes = list(("flavored protein bar") = 1)
	faction = FACTION_TERRAGOV
	///list of protein bar types
	var/static/list/flavor_list = list(
		FACTION_TERRAGOV = list(
			list("stale TGMC protein bar","The most fake looking protein bar you have ever laid eyes on, covered in the a subtitution chocolate. The powder used to make these is a subsitute of a substitute of whey substitute.","#f37d43",list("nutraloafed food" = 1)),
			list("mint TGMC protein bar","A stale old protein bar, with an almost minty freshness to it, but not fresh enough.","#61b36e",list("minty protein" = 1)),
			list("grape TGMC protein bar","Not the good type of grape flavor, tastes like medicine. Fills you up just as well as any protein bar.","#9900ff",list("artifical grape" = 1)),
			list("mystery TGMC protein bar","Some say they have tasted one of these and tasted their favorite childhood meal, especially for squad marines. Most say this tastes like crayons, though it fills like any other protein bar you've seen.","#ffffff",list("crayons" = 1)),
			list("dark chocolate TGMC protein bar","The dark chocolate flavor helps it out a bit, but its still a cheap protein bar.","#5a3b1d",list("bitter dark chocolate" = 1)),
			list("milk chocolate TGMC protein bar","A nice milky addition to a otherwise bland protein taste.","#efc296",list("off flavor milk chocolate"= 1)),
			list("raspberry lime TGMC protein bar","A flavored protein bar, some might say a bit too strongly flavored for their tastes.","#ff0066",list("sour raspberry and lime" = 1)),
			list("chicken TGMC protein bar","Protein bar covered with chicken powder one might find in ramen. Get some extra sodium with your protein.","#cccc00",list("powdered chicken" = 1)),
			list("blueberry TGMC protein bar","A nice blueberry crunch into your otherwise stale and boring protein bar.","#4e39c5",list("blueberry" = 1)),
			list("cement TGMC protein bar", "A gray bar that's allegedly made of cement. It seems to have hardened up. Perhaps it'll make you harden up, too.", "#B2B2B2", list("cement" = 1))
		),
		FACTION_SOM = list(
			list("stale SOM protein bar","The most fake looking protein bar you have ever laid eyes on, covered in the a subtitution chocolate. Its supposedly made with real Martian soil for that patriotic flavour. It has a grainy, metallic taste.","#f37d43",list("rust" = 1)),
			list("salted SOM protein bar","A satisfying protein bar, although quite salty. Made with real TGMC tears.","#86a9b8",list("salt" = 1)),
			list("grape SOM protein bar","Not the good type of grape flavor, tastes like medicine. Fills you up just as well as any protein bar.","#9900ff",list("artifical grape" = 1)),
			list("mystery SOM protein bar","Some say they have tasted one of these and tasted their favorite childhood meal, especially for squad marines. Most say this tastes like crayons, though it fills like any other protein bar you've seen.","#ffffff",list("crayons" = 1)),
			list("dark chocolate SOM protein bar","The dark chocolate flavor helps it out a bit, but its still a cheap protein bar.","#5a3b1d",list("bitter dark chocolate" = 1)),
			list("milk chocolate SOM protein bar","A nice milky addition to a otherwise bland protein taste.","#efc296",list("off flavor milk chocolate"= 1)),
			list("beef SOM protein bar","A beef flavored protein bar, doesn't taste like any cow you've ever tried.","#ff0066",list("meat substitute" = 1)),
			list("meat SOM protein bar","A surprisingly tasty protein bar made from an unspecified meat. Rumors claiming they're made from reconstituted TGMC personnel have been widely dismissed.","#a7576b",list("pork" = 1)),
			list("chicken SOM protein bar","Protein bar covered with chicken powder one might find in ramen. Get some extra sodium with your protein.","#cccc00",list("powdered chicken" = 1)),
			list("blueberry SOM protein bar","A nice blueberry crunch into your otherwise stale and boring protein bar.","#4e39c5",list("blueberry" = 1))
		),
	)

/obj/item/reagent_containers/food/snacks/protein_pack/Initialize(mapload)
	. = ..()
	//list of picked variables
	var/list/picked = pick(flavor_list[faction])
	name = picked[1]
	desc = picked[2]
	set_greyscale_colors(picked[3])
	tastes = picked[4]
	//due the way nutriment works it has to be added like this or the flavor is cached
	reagents.add_reagent(/datum/reagent/consumable/nutriment, 8, picked[4])

/obj/item/reagent_containers/food/snacks/protein_pack/som
	name = "SOM蛋白棒"
	desc = "你见过的最假的蛋白棒,有多种口味"
	icon = 'icons/obj/items/food/mre.dmi'
	faction = FACTION_SOM

/obj/item/reagent_containers/food/snacks/req_pizza
	name = "\improper TGMC一等兵吉姆披萨"
	desc = "你认为那是披萨.你绝对不该吃这个,但你可以把它卖掉赚一笔!虽然它看起来确实像披萨,但放入其中的第一个,活跃的,主要的,也是唯一的原料是一块圆形金属板.也许它在ASRS里放一段时间后会更好吃?算了,是时候把它卖给太空里某个可怜的顾客了."
	icon = 'icons/obj/items/food/pizzaspaghetti.dmi'
	icon_state = "mushroompizza"
	list_reagents = list(/datum/reagent/iron = 8)
	tastes = list("metal" = 3, "one of your teeth cracking" = 1)

/obj/item/reagent_containers/food/snacks/mre_pack
	name = "\improper 通用即食口粮包"
	//trash = /obj/item/trash/TGMCtray
	trash = null
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/items/food/mre.dmi'

/obj/item/reagent_containers/food/snacks/mre_pack/meal1
	name = "\improper TGMC预制餐(香蕉面包)"
	desc = "一片涂有奶油派酱的香蕉面包.一种滑溜溜的组合."
	icon_state = "MREa"
	filling_color = "#ED1169"
	list_reagents = list(/datum/reagent/consumable/nutriment = 9)
	bitesize = 3
	tastes = list("something funny" = 2, "bread" = 4)

/obj/item/reagent_containers/food/snacks/mre_pack/meal2
	name = "\improper TGMC预制餐(猪肉)"
	desc = "米饭配猪肉很难出错."
	icon_state = "MREb"
	list_reagents = list(/datum/reagent/consumable/nutriment = 9)
	bitesize = 2
	tastes = list("rice and pork" = 1)

/obj/item/reagent_containers/food/snacks/mre_pack/meal3
	name = "\improper TGMC预制餐(意面)"
	desc = "那-a辣肉-丸!"
	icon_state = "MREc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 9)
	tastes = list("pasta" = 3, "ground beef" = 1)
	bitesize = 3

/obj/item/reagent_containers/food/snacks/mre_pack/meal4
	name = "\improper TGMC预制餐(披萨)"
	desc = "茄子,胡萝卜和甜玉米,全部铺在奶酪和番茄酱上."
	icon_state = "MREd"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("pizza" = 3, "vegetables" = 1)
	bitesize = 1

/obj/item/reagent_containers/food/snacks/mre_pack/meal5
	name = "\improper TGMC预制餐(猴子)"
	desc = "Sopa de Macaco, Uma Delicia."
	icon_state = "MREe"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	tastes = list("meat soup" = 2, "the jungle" = 2)
	bitesize = 3

/obj/item/reagent_containers/food/snacks/mre_pack/meal6
	name = "\improper TGMC预制餐(豆腐)"
	desc = "烧烤酱汁豆腐夹在面包里,由相信银河系里有杀人的士兵而非杀动物的士兵的匈牙利儿童手工制作."
	icon_state = "MREf"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("grilled tofu" = 2, "grass" = 1)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/mre_pack/xmas1
	name = "\improper 圣诞预制餐:糖霜饼干"
	desc = "美味的糖霜饼干"
	icon_state = "mreCookies"
	list_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/sugar = 1)
	bitesize = 2
	tastes = list("cookies" = 1, "artificial flavoring" = 1)

/obj/item/reagent_containers/food/snacks/mre_pack/xmas2
	name = "\improper 圣诞预制餐:姜饼饼干"
	desc = "一块没有灵魂的饼干."
	icon_state = "mreGingerbread"
	list_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/sugar = 1)
	tastes = list("batter" = 3, "ginger" = 1)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/mre_pack/xmas3
	name = "\improper 圣诞预制餐:水果蛋糕"
	desc = "也被称为''指挥官''."
	icon_state = "mreFruitcake"
	list_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/sugar = 1)
	tastes = list("fruits" = 3, "leadership" = 1)
	bitesize = 2

/obj/item/storage/box/pizza
	name = "食物配送箱"
	desc = "一个太空时代的食物储存装置,能够保持食物格外新鲜.实际上,它只是个箱子."

/obj/item/storage/box/pizza/Initialize(mapload, ...)
	. = ..()
	pixel_y = rand(-3,3)
	pixel_x = rand(-3,3)
	new /obj/item/reagent_containers/food/snacks/donkpocket(src)
	new /obj/item/reagent_containers/food/snacks/donkpocket(src)
	var/list/randompick = list(
		/obj/item/reagent_containers/food/snacks/fries,
		/obj/item/reagent_containers/food/snacks/cheesyfries,
		/obj/item/reagent_containers/food/snacks/burger/bigbite,
		/obj/item/reagent_containers/food/snacks/mexican/taco,
		/obj/item/reagent_containers/food/snacks/hotdog)

	for(var/i in 1 to 3)
		var/picked = pick(randompick)
		new picked(src)

/obj/item/paper/janitor
	name = "揉皱的纸"
	icon_state = "pamphlet"
	info = "In loving memory of Cub Johnson."

/obj/item/storage/box/nt_mre
	name = "\improper Nanotrasen品牌即食口粮"
	desc = "一个来自Nanotrasen工业的预包装,保质期长的食品盒.\nOn 盒子上是Nanotrasen的标志,周围环绕着一句标语: \n<b>NANOTRASEN. 打造更好的午餐</b>"
	icon_state = "mre2"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/nt_mre/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(list(/obj/item/reagent_containers/food/snacks))

	pixel_y = rand(-3,3)
	pixel_x = rand(-3,3)

/obj/item/storage/box/nt_mre/PopulateContents()
	new /obj/item/reagent_containers/food/snacks/donkpocket(src)
	new /obj/item/reagent_containers/food/snacks/donkpocket(src)
	new /obj/item/reagent_containers/food/snacks/donkpocket(src)
	new /obj/item/reagent_containers/food/drinks/coffee(src)
	var/list/randompick = list(
		/obj/item/reagent_containers/food/snacks/cheesiehonkers,
		/obj/item/reagent_containers/food/snacks/no_raisin,
		/obj/item/reagent_containers/food/snacks/spacetwinkie,
		/obj/item/reagent_containers/food/snacks/cookie,
		/obj/item/reagent_containers/food/snacks/chocolatebar)

	var/picked = pick(randompick)
	new picked(src)


//Harness Belts
/obj/item/belt_harness
	name = "枪背带"
	desc = "一条带有夹子的皮革背带,用于挂载物品.希望能让你不弄丢你的武器."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "gun_sling"
	worn_icon_state = "gun_sling"
	equip_slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	equip_delay_self = 2 SECONDS
	unequip_delay_self = 1 SECONDS
	inventory_flags = NOQUICKEQUIP
	///The current attacher. Gets remade for every new item
	var/datum/component/reequip/reequip_component

/obj/item/belt_harness/examine(mob/user, distance, infix, suffix)
	. = ..()
	if(reequip_component)
		. += "There is \a [reequip_component.parent] hooked into it."

/obj/item/belt_harness/unequipped(mob/unequipper, slot)
	if(reequip_component)
		detach_item(reequip_component.parent, unequipper)
	return ..()

/obj/item/belt_harness/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(!istype(I))
		return
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/huser = user
	if(huser.belt != src)
		to_chat(user, span_notice("你需要穿着[src]才能将物品挂载到上面!"))
		return
	if(reequip_component)
		if(reequip_component.parent == I)
			detach_item(I, user)
			return
		to_chat(user, span_notice("[src] 已经挂载了 \a [reequip_component.parent]!"))
		return
	attach_item(I, user)

/obj/item/belt_harness/update_icon_state()
	. = ..()
	if(reequip_component)
		icon_state = initial(icon_state) + "_clipped"
	else
		icon_state = initial(icon_state)

///Set up the link between belt and object
/obj/item/belt_harness/proc/attach_item(obj/item/to_attach, mob/user)
	reequip_component = to_attach.AddComponent(/datum/component/reequip, list(SLOT_S_STORE, SLOT_BACK))
	RegisterSignals(reequip_component, list(COMSIG_REEQUIP_FAILURE, COMSIG_QDELETING), PROC_REF(detach_item))
	playsound(src,'sound/machines/click.ogg', 15, FALSE, 1)
	to_chat(user, span_notice("当你将 \the [to_attach] 挂入[src]时,它发出咔嗒声."))
	update_icon()

///Clean out attachment refs/signals
/obj/item/belt_harness/proc/detach_item(source)
	SIGNAL_HANDLER
	if(!reequip_component)
		return
	UnregisterSignal(reequip_component, list(COMSIG_REEQUIP_FAILURE, COMSIG_QDELETING))
	if(ishuman(loc))
		to_chat(loc, span_notice("当 \the [reequip_component.parent] 从[src]上解开[reequip_component.parent.p_s()]时,它发出咔嗒声."))
		playsound(src,'sound/machines/click.ogg', 15, FALSE, 1)
	if(!QDELING(reequip_component)) //We might've come here from parent qdeling, so we can't just qdel_null it
		qdel(reequip_component)
	reequip_component = null
	update_icon()

/obj/item/belt_harness/vendor_equip(mob/user)
	..()
	return user.equip_to_appropriate_slot(src)

/obj/item/belt_harness/marine
	name = "\improper M45型腰带背带"
	desc = "一条带有夹子的肩带,几乎可以挂载任何东西.希望能让你不弄丢你的武器."
	icon_state = "heavy_harness"
	worn_icon_state = "heavy_harness"

/obj/item/belt_harness/marine/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_BELT)
		playsound(src,'sound/machines/click.ogg', 15, FALSE, 1)
		to_chat(user, span_danger("!!记住将你的武器挂载到你的背带上,否则它不会起作用!!"))

/obj/item/compass
	name = "指南针"
	desc = "一个小指南针,使用时可告诉你你的坐标."
	icon_state = "compass"
	w_class = WEIGHT_CLASS_TINY

/obj/item/compass/attack_self(mob/living/user)
	. = ..()
	var/turf/location = get_turf(src)
	to_chat(user, span_notice("看过[src]后,你可以得知你的大致坐标.") + span_bold(" 经度 [location.x]. 纬度 [location.y]."))

/obj/item/compass/afterattack(atom/target, mob/user, has_proximity, click_parameters)
	. = ..()
	if(user.do_actions)
		return
	var/turf/target_turf = isturf(target)? target : get_turf(target)
	if(!do_after(user, 1 SECONDS))
		return
	to_chat(user, span_notice("根据你当前的位置,目标坐标为:") + span_bold(" 经度 [target_turf.x]. 纬度 [target_turf.y]."))
