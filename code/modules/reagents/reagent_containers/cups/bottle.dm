//Not to be confused with /obj/item/reagent_containers/cup/glass/bottle

/obj/item/reagent_containers/cup/bottle
	name = "瓶子"
	desc = "一个小瓶子."
	icon_state = "bottle-1"
	fill_icon_state = "bottle-1"
	worn_icon_state = "bottle-1"
	possible_transfer_amounts = list(5, 10, 15, 25, 50)
	volume = 50
	fill_icon_thresholds = list(0, 1, 20, 40, 60, 80, 100)

/obj/item/reagent_containers/cup/bottle/Initialize(mapload)
	. = ..()
	if(!icon_state)
		icon_state = "bottle-1"
	update_appearance()

/obj/item/reagent_containers/cup/bottle/toxin
	name = "毒素瓶"
	desc = "一小瓶毒素. 不要喝, 有毒."
	list_reagents = list(/datum/reagent/toxin = 30)

/obj/item/reagent_containers/cup/bottle/cyanide
	name = "氰化物瓶"
	desc = "一小瓶氰化物. 苦杏仁味?"
	list_reagents = list(/datum/reagent/toxin/cyanide = 30)

/obj/item/reagent_containers/cup/bottle/chloralhydrate
	name = "水合氯醛瓶"
	desc = "一小瓶水合氯醛. 米奇的最爱!"
	icon_state = "bottle20"
	list_reagents = list(/datum/reagent/toxin/chloralhydrate = 15)

/obj/item/reagent_containers/cup/bottle/mutagen
	name = "不稳定诱变剂瓶"
	desc = "一小瓶不稳定诱变剂. 会随机改变接触者的DNA结构."
	list_reagents = list(/datum/reagent/toxin/mutagen = 30)

/obj/item/reagent_containers/cup/bottle/synaptizine
	name = "突触嗪瓶"
	desc = "一小瓶突触嗪."
	list_reagents = list(/datum/reagent/medicine/synaptizine = 30)

/obj/item/reagent_containers/cup/bottle/ammonia
	name = "氨水瓶"
	desc = "一小瓶氨水."
	list_reagents = list(/datum/reagent/ammonia = 30)

/obj/item/reagent_containers/cup/bottle/diethylamine
	name = "二乙胺瓶"
	desc = "一小瓶二乙胺."
	list_reagents = list(/datum/reagent/diethylamine = 30)

/obj/item/reagent_containers/cup/bottle/adminordrazine
	name = "Adminordrazine瓶"
	desc = "一个小瓶子. 内含众神的液体精华."
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "holyflask"
	list_reagents = list(/datum/reagent/medicine/adminordrazine = 30)

/obj/item/reagent_containers/cup/bottle/capsaicin
	name = "辣椒素瓶"
	desc = "一个小瓶子. 内含辣酱."
	list_reagents = list(/datum/reagent/consumable/capsaicin = 30)

/obj/item/reagent_containers/cup/bottle/frostoil
	name = "霜油瓶"
	desc = "一个小瓶子. 内含冷酱."
	list_reagents = list(/datum/reagent/consumable/frostoil = 30)

//Oldstation.dmm chemical storage bottles

/obj/item/reagent_containers/cup/bottle/hydrogen
	name = "氢瓶"
	list_reagents = list(/datum/reagent/hydrogen = 30)

/obj/item/reagent_containers/cup/bottle/lithium
	name = "锂瓶"
	list_reagents = list(/datum/reagent/lithium = 30)

/obj/item/reagent_containers/cup/bottle/carbon
	name = "碳瓶"
	list_reagents = list(/datum/reagent/carbon = 30)

/obj/item/reagent_containers/cup/bottle/nitrogen
	name = "氮瓶"
	list_reagents = list(/datum/reagent/nitrogen = 30)

/obj/item/reagent_containers/cup/bottle/oxygen
	name = "氧瓶"
	list_reagents = list(/datum/reagent/oxygen = 30)

/obj/item/reagent_containers/cup/bottle/fluorine
	name = "氟瓶"
	list_reagents = list(/datum/reagent/fluorine = 30)

/obj/item/reagent_containers/cup/bottle/sodium
	name = "钠瓶"
	list_reagents = list(/datum/reagent/sodium = 30)

/obj/item/reagent_containers/cup/bottle/silicon
	name = "硅瓶"
	list_reagents = list(/datum/reagent/silicon = 30)

/obj/item/reagent_containers/cup/bottle/phosphorus
	name = "磷瓶"
	list_reagents = list(/datum/reagent/phosphorus = 30)

/obj/item/reagent_containers/cup/bottle/sulfur
	name = "硫瓶"
	list_reagents = list(/datum/reagent/sulfur = 30)

/obj/item/reagent_containers/cup/bottle/chlorine
	name = "氯瓶"
	list_reagents = list(/datum/reagent/chlorine = 30)

/obj/item/reagent_containers/cup/bottle/potassium
	name = "钾瓶"
	list_reagents = list(/datum/reagent/potassium = 30)

/obj/item/reagent_containers/cup/bottle/iron
	name = "铁瓶"
	list_reagents = list(/datum/reagent/iron = 30)

/obj/item/reagent_containers/cup/bottle/copper
	name = "铜瓶"
	list_reagents = list(/datum/reagent/copper = 30)

/obj/item/reagent_containers/cup/bottle/mercury
	name = "汞瓶"
	list_reagents = list(/datum/reagent/mercury = 30)

/obj/item/reagent_containers/cup/bottle/water
	name = "水瓶"
	list_reagents = list(/datum/reagent/water = 30)

/obj/item/reagent_containers/cup/bottle/ethanol
	name = "乙醇瓶"
	list_reagents = list(/datum/reagent/consumable/ethanol = 30)

/obj/item/reagent_containers/cup/bottle/sugar
	name = "糖瓶"
	list_reagents = list(/datum/reagent/consumable/sugar = 30)

/obj/item/reagent_containers/cup/bottle/sacid
	name = "硫酸瓶"
	list_reagents = list(/datum/reagent/toxin/acid = 30)

/obj/item/reagent_containers/cup/bottle/welding_fuel
	name = "焊接燃料瓶"
	list_reagents = list(/datum/reagent/fuel = 30)

/obj/item/reagent_containers/cup/bottle/silver
	name = "银瓶"
	list_reagents = list(/datum/reagent/silver = 30)

/obj/item/reagent_containers/cup/bottle/caramel
	name = "焦糖瓶"
	desc = "一个装有焦糖化糖的瓶子, 也称为焦糖. 不要舔."
	list_reagents = list(/datum/reagent/consumable/caramel = 30)

/*
 *	Syrup bottles, basically a unspillable cup that transfers reagents upon clicking on it with a cup
 */

/obj/item/reagent_containers/cup/bottle/syrup_bottle
	name = "糖浆瓶"
	desc = "一个带有糖浆泵的瓶子, 可将这种美味物质直接分配到你的咖啡杯中."
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "syrup"
	fill_icon_state = "syrup"
	fill_icon_thresholds = list(0, 20, 40, 60, 80, 100)
	possible_transfer_amounts = list(5, 10)
	amount_per_transfer_from_this = 5
	///variable to tell if the bottle can be refilled
	var/cap_on = TRUE

/obj/item/reagent_containers/cup/bottle/syrup_bottle/examine(mob/user)
	. = ..()
	. += span_notice("按Alt点击以切换泵盖。")
	. += span_notice("用笔点击它以重命名。")

//when you attack the syrup bottle with a container it refills it
/obj/item/reagent_containers/cup/bottle/syrup_bottle/attackby(obj/item/attacking_item, mob/user, params)

	if(!cap_on)
		return ..()

	if(!check_allowed_items(attacking_item,target_self = TRUE))
		return

	if(attacking_item.is_refillable())
		if(!reagents.total_volume)
			balloon_alert(user, "瓶子空了!")
			return TRUE

		if(attacking_item.reagents.holder_full())
			balloon_alert(user, "容器满了!")
			return TRUE

		var/transfer_amount = reagents.trans_to(attacking_item, amount_per_transfer_from_this)
		balloon_alert(user, "已转移 [transfer_amount] 单位\s")
		flick("syrup_anim",src)

	attacking_item.update_appearance()
	update_appearance()

	return TRUE

/obj/item/reagent_containers/cup/bottle/syrup_bottle/AltClick(mob/user)
	. = ..()
	cap_on = !cap_on
	if(!cap_on)
		icon_state = "syrup_open"
		balloon_alert(user, "已取下泵盖")
	else
		icon_state = "syrup"
		balloon_alert(user, "已装上泵盖")
	update_icon_state()

//types of syrups

/obj/item/reagent_containers/cup/bottle/syrup_bottle/caramel
	name = "焦糖糖浆瓶"
	desc = "一个装有焦糖化糖的按压瓶, 也称为焦糖. 请勿舔."
	list_reagents = list(/datum/reagent/consumable/caramel = 50)

/obj/item/reagent_containers/cup/bottle/syrup_bottle/liqueur
	name = "咖啡利口酒糖浆瓶"
	desc = "一个装有墨西哥咖啡味利口酒糖浆的按压瓶. 自1936年起生产, HONK."
	list_reagents = list(/datum/reagent/consumable/ethanol/kahlua = 50)

///////////////////////////////////////////////Alchohol bottles! -Agouri //////////////////////////
//Functionally identical to regular drinks. The only difference is that the default bottle size is 100. - Darem
//Bottles now weaken and break when smashed on people's heads. - Giacom
/obj/item/reagent_containers/food/drinks/bottle
	amount_per_transfer_from_this = 10
	volume = 100
	worn_icon_state = "broken_beer" //Generic held-item sprite until unique ones are made.
	var/can_shatter = 1 //Whether the 'bottle' is made of glass or not so that milk cartons dont shatter when someone gets hit by it

/obj/item/reagent_containers/food/drinks/bottle/proc/smash(mob/living/target as mob, mob/living/user as mob)

	//Creates a shattering noise and replaces the bottle with a broken_bottle
	user.temporarilyRemoveItemFromInventory(src)
	var/obj/item/weapon/broken_bottle/B = new /obj/item/weapon/broken_bottle(user.loc)
	user.put_in_active_hand(B)
	if(prob(33))
		new/obj/item/shard(target.loc) // Create a glass shard at the target's location!
	B.icon_state = icon_state

	var/icon/I = new('icons/obj/items/drinks.dmi', icon_state)
	I.Blend(B.broken_outline, ICON_OVERLAY, rand(5), 1)
	I.SwapColor(rgb(255, 0, 220, 255), rgb(0, 0, 0, 0))
	B.icon = I

	playsound(src, SFX_SHATTER, 25, 1)
	user.put_in_active_hand(B)

	qdel(src)

/obj/item/reagent_containers/food/drinks/bottle/attack(mob/living/target as mob, mob/living/user as mob)

	if(!target)
		return

	if(user.a_intent != INTENT_HARM || !can_shatter)
		return ..()

	force = 15 //Smashing bottles over someoen's head hurts.

	var/datum/limb/affecting = user.zone_selected //Find what the player is aiming at

	//apply damage
	var/paralyze_duration = target.apply_damage(force, BRUTE, affecting, MELEE, updating_health = TRUE)

	if(affecting == "head" && istype(target, /mob/living/carbon/) && !isxeno(target))

		if(target != user)
			user.visible_message(span_danger("[target]被[user]用一瓶[name]砸中了头部!"))
		else
			user.visible_message(span_danger("[user]用一瓶[name]砸中了[user.p_them()]自己的头部!"))
		if(paralyze_duration >= force) //if they have armor, no stun
			target.apply_effect(4 SECONDS, EFFECT_PARALYZE)

	else
		if(target != user)
			user.visible_message(span_danger("[target]被[user]用一瓶[name]攻击了!"))
		else
			user.visible_message(span_danger("[user]用一瓶[name]攻击了[user.p_them()]自己!"))

	UPDATEHEALTH(target)

	//Attack logs
	log_combat(user, target, "smashed", src)

	//The reagents in the bottle splash all over the target, thanks for the idea Nodrak
	if(reagents)
		visible_message(span_boldnotice("[src]里的东西溅了[target]一身!"))
		reagents.reaction(target, TOUCH)

	//Finally, smash the bottle. This kills (del) the bottle.
	smash(target, user)

/obj/item/reagent_containers/food/drinks/bottle/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(!CONFIG_GET(flag/fun_allowed))
		return FALSE
	attack_hand(xeno_attacker)

/obj/item/reagent_containers/food/drinks/bottle/gin
	name = "\improper 格里夫伊特金酒"
	desc = "一瓶高品质金酒, 产自新伦敦空间站."
	icon_state = "ginbottle"
	center_of_mass = list("x"=16, "y"=4)
	list_reagents = list(/datum/reagent/consumable/ethanol/gin = 100)

/obj/item/reagent_containers/food/drinks/bottle/whiskey
	name = "\improper 吉特叔叔特别珍藏"
	desc = "一款优质单一麦芽威士忌, 由阿拉巴马乡下的乡巴佬慢慢陈酿四年."
	icon_state = "whiskeybottle"
	center_of_mass = list("x"=16, "y"=3)
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 100)

/obj/item/reagent_containers/food/drinks/bottle/specialwhiskey
	name = "\improper Nanotrasen '太空陈酿' 60年威士忌"
	desc = "这款精致的威士忌品牌自2378年起在殖民船船体中陈酿. 它的价值超过你几个月挣的钱- 而且大胆到把这一事实写在瓶子上."
	icon_state = "specialwhiskeybottle"
	center_of_mass = list("x"=16, "y"=3)
	list_reagents = list(/datum/reagent/consumable/ethanol/specialwhiskey = 100)

/obj/item/reagent_containers/food/drinks/bottle/experimentalliquor
	name = "\improper NT-06"
	desc = "一个黑色瓶子, 上面除了一张便条和警告标签外什么都没有. '喝下这个你会死,' '600 proof,' 以及其他诸如此类令人沮丧的话写在上面."
	icon_state = "experimentalliquorbottle"
	center_of_mass = list("x"=17, "y"=5)
	list_reagents = list(/datum/reagent/consumable/ethanol/pwine = 100)

/obj/item/reagent_containers/food/drinks/bottle/sake
	name = "\improper 切腹传统风格清酒"
	desc = "甜得不能再甜, 咽下去却像火一样烧."
	icon_state = "sakebottle"
	center_of_mass = list("x"=17, "y"=7)
	list_reagents = list(/datum/reagent/consumable/ethanol/sake = 100)

/obj/item/reagent_containers/food/drinks/bottle/vodka
	name = "\improper 红星伏特加"
	desc = "瓶子上写着, 'Ra Ra 红星人: 精致事物的爱好者.' 或者至少你是这么以为的...."
	icon_state = "vodkabottle"
	center_of_mass = list("x"=17, "y"=3)
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 100)

/obj/item/reagent_containers/food/drinks/bottle/tequila
	name = "\improper Caccavo 保证品质龙舌兰酒"
	desc = "由优质石油馏分, 纯沙利度胺以及其他高品质原料制成!"
	icon_state = "tequilabottle"
	center_of_mass = list("x"=16, "y"=3)
	list_reagents = list(/datum/reagent/consumable/ethanol/tequila = 100)

/obj/item/reagent_containers/food/drinks/bottle/davenport
	name = "\improper 达文波特黑麦威士忌"
	desc = "一款风味独特的昂贵威士忌. 瓶身自豪地宣称它是, '真正的经典.'"
	icon_state = "davenportbottle"
	center_of_mass = list("x"=16, "y"=3)
	list_reagents = list(/datum/reagent/consumable/ethanol/davenport = 50)


/obj/item/reagent_containers/food/drinks/bottle/bottleofnothing
	name = "虚无之瓶"
	desc = "一个装满虚无的瓶子"
	icon_state = "bottleofnothing"
	center_of_mass = list("x"=17, "y"=5)
	list_reagents = list(/datum/reagent/consumable/nothing = 100)

/obj/item/reagent_containers/food/drinks/bottle/patron
	name = "Wrapp Artiste Patron"
	desc = "银丝龙舌兰酒, 供应于银河各地的太空夜总会."
	icon_state = "patronbottle"
	center_of_mass = list("x"=16, "y"=6)
	list_reagents = list(/datum/reagent/consumable/ethanol/patron = 100)

/obj/item/reagent_containers/food/drinks/bottle/rum
	name = "皮特船长的古巴香料朗姆酒"
	desc = "以著名的'古巴'皮特船长命名, 这款朗姆酒差不多和他最后一次任务一样不稳定."
	icon_state = "rumbottle"
	center_of_mass = list("x"=16, "y"=8)
	list_reagents = list(/datum/reagent/consumable/ethanol/rum = 100)

/obj/item/reagent_containers/food/drinks/bottle/holywater
	name = "圣水壶"
	desc = "一壶牧师的圣水."
	icon_state = "holyflask"
	center_of_mass = list("x"=17, "y"=10)
	list_reagents = list(/datum/reagent/water/holywater = 100)

/obj/item/reagent_containers/food/drinks/bottle/vermouth
	name = "金眼味美思"
	desc = "甜蜜, 甜蜜的干涩~"
	icon_state = "vermouthbottle"
	center_of_mass = list("x"=17, "y"=3)
	list_reagents = list(/datum/reagent/consumable/ethanol/vermouth = 100)

/obj/item/reagent_containers/food/drinks/bottle/kahlua
	name = "罗伯特 罗布斯特的咖啡利口酒"
	desc = "一款广为人知的墨西哥咖啡味利口酒. 自1936年起生产, HONK"
	icon_state = "kahluabottle"
	center_of_mass = list("x"=17, "y"=3)
	list_reagents = list(/datum/reagent/consumable/ethanol/kahlua = 100)

/obj/item/reagent_containers/food/drinks/bottle/goldschlager
	name = "女大学生 Goldschlager"
	desc = "因为她们是唯一会喝100 proof肉桂香酒的人."
	icon_state = "goldschlagerbottle"
	center_of_mass = list("x"=15, "y"=3)
	list_reagents = list(/datum/reagent/consumable/ethanol/goldschlager = 100)

/obj/item/reagent_containers/food/drinks/bottle/cognac
	name = "巴顿城堡高级干邑"
	desc = "一种甜美且酒精度很高的饮品, 经过多次蒸馏和多年陈酿制成. 这次你最好别喊'SHITCURITY'."
	icon_state = "cognacbottle"
	center_of_mass = list("x"=16, "y"=6)
	list_reagents = list(/datum/reagent/consumable/ethanol/cognac = 100)

/obj/item/reagent_containers/food/drinks/bottle/wine
	name = "双胡子大胡子特酿葡萄酒"
	desc = "瓶子周围环绕着一股淡淡的不安和蛋疼气息."
	icon_state = "winebottle"
	center_of_mass = list("x"=16, "y"=4)
	list_reagents = list(/datum/reagent/consumable/ethanol/wine = 100)

/obj/item/reagent_containers/food/drinks/bottle/absinthe
	name = "越狱者绿酒"
	desc = "只要喝一口, 你就知道自己会玩得很开心."
	icon_state = "absinthebottle"
	center_of_mass = list("x"=16, "y"=6)
	list_reagents = list(/datum/reagent/consumable/ethanol/absinthe = 100)

/obj/item/reagent_containers/food/drinks/bottle/melonliquor
	name = "翠绿甜瓜利口酒"
	desc = "一瓶46 proof翠绿甜瓜利口酒. 甜美清淡."
	icon_state = "alco-green" //Placeholder.
	center_of_mass = list("x"=16, "y"=6)
	list_reagents = list(/datum/reagent/consumable/ethanol/melonliquor = 100)

/obj/item/reagent_containers/food/drinks/bottle/bluecuracao
	name = "蓝库拉索小姐"
	desc = "一种果味十足, 异常蔚蓝的饮品. 不允许饮用者使用第五魔法."
	icon_state = "alco-blue" //Placeholder.
	center_of_mass = list("x"=16, "y"=6)
	list_reagents = list(/datum/reagent/consumable/ethanol/bluecuracao = 100)

/obj/item/reagent_containers/food/drinks/bottle/grenadine
	name = "野蔷薇石榴糖浆"
	desc = "酸甜可口, 一种用于为饮品增添颜色或风味的酒吧糖浆."
	icon_state = "grenadine"
	center_of_mass = list("x"=16, "y"=6)
	list_reagents = list(/datum/reagent/consumable/grenadine = 100)

/obj/item/reagent_containers/food/drinks/bottle/pwine
	name = "术士的丝绒"
	desc = "这包装多么令人愉悦, 肯定是一瓶高品质葡萄酒! 这个年份一定很棒!"
	icon_state = "pwinebottle"
	center_of_mass = list("x"=16, "y"=4)
	list_reagents = list(/datum/reagent/consumable/ethanol/pwine = 100)

//////////////////////////JUICES AND STUFF ///////////////////////

/obj/item/reagent_containers/food/drinks/bottle/orangejuice
	name = "橙汁"
	desc = "富含维生素,美味可口!"
	icon_state = "orangejuice"
	worn_icon_state = "carton"
	center_of_mass = list("x"=16, "y"=7)
	can_shatter = 0
	list_reagents = list(/datum/reagent/consumable/orangejuice = 100)

/obj/item/reagent_containers/food/drinks/bottle/cream
	name = "奶油"
	desc = "这是奶油.由牛奶制成.你以为里面还能有什么?"
	icon_state = "cream"
	worn_icon_state = "carton"
	center_of_mass = list("x"=16, "y"=8)
	can_shatter = 0
	list_reagents = list(/datum/reagent/consumable/cream = 100)

/obj/item/reagent_containers/food/drinks/bottle/tomatojuice
	name = "番茄汁"
	desc = "好吧,至少它看起来像番茄汁.那一片红色让人分辨不出."
	icon_state = "tomatojuice"
	worn_icon_state = "carton"
	center_of_mass = list("x"=16, "y"=8)
	can_shatter = 0
	list_reagents = list(/datum/reagent/consumable/tomatojuice = 100)

/obj/item/reagent_containers/food/drinks/bottle/limejuice
	name = "青柠汁"
	desc = "酸甜可口."
	icon_state = "limejuice"
	worn_icon_state = "carton"
	center_of_mass = list("x"=16, "y"=8)
	can_shatter = 0
	list_reagents = list(/datum/reagent/consumable/limejuice = 100)
