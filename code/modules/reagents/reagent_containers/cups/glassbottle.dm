#define BOTTLE_KNOCKDOWN_DEFAULT_DURATION (1.3 SECONDS)

///////////////////////////////////////////////Alchohol bottles! -Agouri //////////////////////////
//Functionally identical to regular drinks. The only difference is that the default bottle size is 100. - Darem
//Bottles now knockdown and break when smashed on people's heads. - Giacom

/// Initializes GLOB.alcohol_containers, only containers that actually have reagents are added to the list.
/proc/init_alcohol_containers()
	var/list/containers = subtypesof(/obj/item/reagent_containers/cup/glass/bottle)
	for(var/typepath in containers)
		containers -= typepath
		var/obj/item/reagent_containers/cup/glass/bottle/instance = new typepath
		if(!length(instance.list_reagents))
			qdel(instance)
			continue
		containers[typepath] = instance
	return containers

/obj/item/reagent_containers/cup/glass/bottle
	name = "玻璃瓶"
	desc = "这个空瓶子固执地保持着匿名, 对其内容物不提供任何线索."
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "glassbottle"
	worn_icon_state = "beer" //Generic held-item sprite until unique ones are made.
	fill_icon_thresholds = list(0, 10, 20, 30, 40, 50, 60, 70, 80, 90)
	amount_per_transfer_from_this = 10
	volume = 100
	force = 15 //Smashing bottles over someone's head hurts.
	throwforce = 15
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/drinks_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/drinks_righthand.dmi'
		)
	drink_type = ALCOHOL
	toolspeed = 1.3 //it's a little awkward to use, but it's a cylinder alright.
	///Sprite our bottle uses when it's broken
	var/broken_worn_icon_state = "broken_beer"
	///Directly relates to the 'knockdown' duration. Lowered by armor (i.e. helmets)
	var/bottle_knockdown_duration = BOTTLE_KNOCKDOWN_DEFAULT_DURATION

/obj/item/reagent_containers/cup/glass/bottle/smash(mob/living/target, mob/thrower, ranged = FALSE, break_top)
	try_splash(thrower, target)
	var/obj/item/broken_bottle/B = new(drop_location())
	if(!ranged && thrower)
		thrower.put_in_hands(B)
	B.mimic_broken(src, target, break_top)
	B.worn_icon_state = broken_worn_icon_state

	qdel(src)
	target.Bumped(B)

/*
 * Proc to make the bottle spill some of its contents out in a froth geyser of varying intensity/height
 * Arguments:
 * * offset_x = pixel offset by x from where the froth animation will start
 * * offset_y = pixel offset by y from where the froth animation will start
 * * intensity = how strong the effect is, both visually and in the amount of reagents lost. comes in three flavours
*/
/obj/item/reagent_containers/cup/glass/bottle/proc/make_froth(offset_x, offset_y, intensity)
	if(!intensity)
		return

	if(!reagents.total_volume)
		return

	var/amount_lost = intensity * 5
	reagents.remove_all(amount_lost)

	visible_message(span_warning("[name]的一些内容物洒了出来!"))
	var/intensity_state = null
	switch(intensity)
		if(1)
			intensity_state = "low"
		if(2)
			intensity_state = "medium"
		if(3)
			intensity_state = "high"
	///The froth fountain that we are sticking onto the bottle
	var/mutable_appearance/froth = mutable_appearance('icons/obj/drinks/drink_effects.dmi', "froth_bottle_[intensity_state]")
	froth.pixel_x = offset_x
	froth.pixel_y = offset_y
	add_overlay(froth)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, cut_overlay), froth), 2 SECONDS)

/obj/item/reagent_containers/cup/glass/bottle/small
	name = "小玻璃瓶"
	desc = "这个空瓶子固执地保持着匿名, 对其内容物不提供任何线索."
	icon_state = "glassbottlesmall"
	volume = 50

/obj/item/broken_bottle
	name = "破瓶子"
	desc = "一个底部破碎锋利的瓶子."
	icon = 'icons/obj/drinks/drink_effects.dmi'
	icon_state = "broken_bottle"
	force = 9
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	worn_icon_state = "broken_beer"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/drinks_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/drinks_righthand.dmi',
		)
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("stabs", "slashes", "attacks")
	///The mask image for mimicking a broken-off bottom of the bottle
	var/static/icon/broken_outline = icon('icons/obj/drinks/drink_effects.dmi', "broken")
	///The mask image for mimicking a broken-off neck of the bottle
	var/static/icon/flipped_broken_outline = icon('icons/obj/drinks/drink_effects.dmi', "broken-flipped")

/// Mimics the appearance and properties of the passed in bottle.
/// Takes the broken bottle to mimic, and the thing the bottle was broken agaisnt as args
/obj/item/broken_bottle/proc/mimic_broken(obj/item/reagent_containers/cup/glass/to_mimic, atom/target, break_top)
	icon_state = to_mimic.icon_state
	var/icon/drink_icon = new(to_mimic.icon, icon_state)
	if(break_top) //if the bottle breaks its top off instead of the bottom
		desc = "A bottle with its neck smashed off."
		drink_icon.Blend(flipped_broken_outline, ICON_OVERLAY, rand(5), 0)
	else
		drink_icon.Blend(broken_outline, ICON_OVERLAY, rand(5), 1)
	drink_icon.SwapColor(rgb(255, 0, 220, 255), rgb(0, 0, 0, 0))
	icon = drink_icon

	if(istype(to_mimic, /obj/item/reagent_containers/cup/glass/bottle/juice))
		force = 0
		throwforce = 0
		desc = "A carton with the bottom half burst open. Might give you a papercut."
	else
		if(prob(33))
			var/obj/item/shard/stab_with = new(to_mimic.drop_location())
			target.Bumped(stab_with)
		playsound(src, SFX_SHATTER, 70, TRUE)
	name = "broken [to_mimic.name]"

/obj/item/reagent_containers/cup/glass/bottle/beer
	name = "太空啤酒"
	desc = "啤酒. 在太空里."
	icon_state = "beer"
	volume = 30
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 30)
	drink_type = GRAIN | ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/beer/almost_empty
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 1)

/obj/item/reagent_containers/cup/glass/bottle/beer/light
	name = "卡普轻啤"
	desc = "用\"纯冰小行星泉水\"酿造."
	icon_state = "litebeer"
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/light = 30)

/obj/item/reagent_containers/cup/glass/bottle/rootbeer
	name = "双倍根汁汽水"
	desc = "一个受欢迎的老式根汁汽水品牌, 以其极甜的配方闻名. 喝完后可能会让你想打个盹."
	icon_state = "twotime"
	volume = 30
	list_reagents = list(/datum/reagent/consumable/rootbeer = 30)
	drink_type = SUGAR | JUNKFOOD

/obj/item/reagent_containers/cup/glass/bottle/ale
	name = "岩浆艾尔"
	desc = "真正的矮人首选饮品."
	icon_state = "alebottle"
	volume = 30
	list_reagents = list(/datum/reagent/consumable/ethanol/ale = 30)
	drink_type = GRAIN | ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/gin
	name = "格里菲特金酒"
	desc = "一瓶高品质金酒, 产自新伦敦空间站."
	icon_state = "ginbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/gin = 100)

/obj/item/reagent_containers/cup/glass/bottle/whiskey
	name = "吉特叔叔特别珍藏"
	desc = "一款优质单一麦芽威士忌, 在核避难所的隧道内温和陈酿. 隧道威士忌最棒."
	icon_state = "whiskeybottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 100)

/obj/item/reagent_containers/cup/glass/bottle/kong
	name = "金刚"
	desc = "让你变成猿!&#174;"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey/kong = 100)

/obj/item/reagent_containers/cup/glass/bottle/candycornliquor
	name = "玉米糖利口酒"
	desc = "就像他们在2D地下酒吧喝的那样."
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey/candycorn = 100)

/obj/item/reagent_containers/cup/glass/bottle/vodka
	name = "通古斯三重蒸馏"
	desc = "啊, 伏特加. 全世界俄罗斯人的首选饮品兼燃料."
	icon_state = "vodkabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 100)

/obj/item/reagent_containers/cup/glass/bottle/vodka/badminka
	name = "巴德明卡伏特加"
	desc = "标签上写着西里尔字母. 你只能辨认出名字和一个看起来隐约像'伏特加'的词."
	icon_state = "badminka"
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 100)

/obj/item/reagent_containers/cup/glass/bottle/tequila
	name = "卡卡沃保证品质龙舌兰"
	desc = "由优质石油馏出物, 纯沙利度胺和其他优质原料制成!"
	icon_state = "tequilabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/tequila = 100)

/obj/item/reagent_containers/cup/glass/bottle/bottleofnothing
	name = "空无一物的瓶子"
	desc = "一个装满了空无一物的瓶子."
	icon_state = "bottleofnothing"
	list_reagents = list(/datum/reagent/consumable/nothing = 100)
	drink_type = NONE

/obj/item/reagent_containers/cup/glass/bottle/patron
	name = "艺术包装赞助人"
	desc = "银色蕾丝龙舌兰, 供应于全银河系的太空夜总会."
	icon_state = "patronbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/patron = 100)

/obj/item/reagent_containers/cup/glass/bottle/rum
	name = "皮特船长的古巴香料朗姆酒"
	desc = "这可不只是朗姆酒, 哦不. 这简直就是瓶装的GRIFF."
	icon_state = "rumbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/rum = 100)

/obj/item/reagent_containers/cup/glass/bottle/maltliquor
	name = "\improper 狂熊麦芽酒"
	desc = "40盎司的麦芽酒. 劲头比, 嗯, 一只狂熊还猛."
	icon_state = "maltliquorbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/maltliquor = 100)

/obj/item/reagent_containers/cup/glass/bottle/holywater
	name = "圣水瓶"
	desc = "一瓶牧师的圣水."
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "holyflask"
	worn_icon_state = "holyflask"
	broken_worn_icon_state = "broken_holyflask"
	list_reagents = list(/datum/reagent/water/holywater = 100)
	drink_type = NONE

/obj/item/reagent_containers/cup/glass/bottle/vermouth
	name = "金眼苦艾酒"
	desc = "甜美, 甜美的干爽~"
	icon_state = "vermouthbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/vermouth = 100)

/obj/item/reagent_containers/cup/glass/bottle/kahlua
	name = "罗伯特·罗布斯特咖啡利口酒"
	desc = "一款广为人知的墨西哥咖啡风味利口酒. 自1936年起生产, HONK."
	icon_state = "kahluabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/kahlua = 100)
	drink_type = VEGETABLES

/obj/item/reagent_containers/cup/glass/bottle/goldschlager
	name = "女大学生金箔酒"
	desc = "因为她们是唯一会喝100 proof肉桂 schnapps的人."
	icon_state = "goldschlagerbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/goldschlager = 100)

/obj/item/reagent_containers/cup/glass/bottle/cognac
	name = "巴顿酒庄优质干邑"
	desc = "一种甜美且烈性十足的饮品, 经过多次蒸馏和多年陈酿制成. 这次你最好别喊'SHITCURITY'."
	icon_state = "cognacbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/cognac = 100)

/obj/item/reagent_containers/cup/glass/bottle/wine
	name = "双胡须的胡须特酿葡萄酒"
	desc = "瓶子周围弥漫着一股淡淡的不安和蛋疼气息."
	icon_state = "winebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/wine = 100)
	drink_type = FRUIT | ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/wine/unlabeled
	name = "无标签葡萄酒瓶"
	desc = "这个葡萄酒瓶上没有标签."

/obj/item/reagent_containers/cup/glass/bottle/absinthe
	name = "超强苦艾酒"
	desc = "一种烈性酒精饮料, 由以下方酿造并分销"
	icon_state = "absinthebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/absinthe = 100)

/obj/item/reagent_containers/cup/glass/bottle/absinthe/Initialize(mapload)
	. = ..()
	redact()

/obj/item/reagent_containers/cup/glass/bottle/absinthe/proc/redact()
	// There was a large fight in the coderbus about a player reference
	// in absinthe. Ergo, this is why the name generation is now so
	// complicated. Judge us kindly.
	var/shortname = pick("T&T", "A&A", "Generic")
	var/fullname
	switch(shortname)
		if("T&T")
			fullname = "Teal and Tealer"
		if("A&A")
			fullname = "Ash and Asher"
		if("Generic")
			fullname = "Nanotrasen Cheap Imitations"
	var/removals = list(
		"\[REDACTED\]",
		"\[EXPLETIVE DELETED\]",
		"\[EXPUNGED\]",
		"\[INFORMATION ABOVE YOUR SECURITY CLEARANCE\]",
		"\[MOVE ALONG CITIZEN\]",
		"\[NOTHING TO SEE HERE\]",
	)
	var/chance = 50

	if(prob(chance))
		shortname = pick_n_take(removals)

	var/list/final_fullname = list()
	for(var/word in splittext(fullname, " "))
		if(prob(chance))
			word = pick_n_take(removals)
		final_fullname += word

	fullname = jointext(final_fullname, " ")

	// Actually finally setting the new name and desc
	name = "[shortname] [name]"
	desc = "[desc] [fullname] Inc."


/obj/item/reagent_containers/cup/glass/bottle/absinthe/premium
	name = "格温优质苦艾酒"
	desc = "一种烈性酒精饮料, 几乎能让你忘记肺里的灰烬."
	icon_state = "absinthepremium"

/obj/item/reagent_containers/cup/glass/bottle/absinthe/premium/redact()
	return

/obj/item/reagent_containers/cup/glass/bottle/lizardwine
	name = "蜥蜴葡萄酒瓶"
	desc = "一种来自太空中国的酒精饮料, 通过将蜥蜴尾巴浸泡在乙醇中制成. 莫名其妙地在指挥层中很受欢迎."
	icon_state = "lizardwine"
	list_reagents = list(/datum/reagent/consumable/ethanol/lizardwine = 100)
	drink_type = FRUIT | ALCOHOL

/obj/item/reagent_containers/cup/glass/bottle/hcider
	name = "简氏硬苹果酒"
	desc = "成年人的苹果汁."
	icon_state = "hcider"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/ethanol/hcider = 50)

/obj/item/reagent_containers/cup/glass/bottle/amaretto
	name = "卢伊尼阿玛雷托"
	desc = "一种温和的糖浆状饮品, 尝起来有杏仁和杏子的味道."
	icon_state = "disaronno"
	list_reagents = list(/datum/reagent/consumable/ethanol/amaretto = 100)

/obj/item/reagent_containers/cup/glass/bottle/grappa
	name = "菲利普陈年格拉帕"
	desc = "一瓶格拉帕."
	icon_state = "grappabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/grappa = 100)

/obj/item/reagent_containers/cup/glass/bottle/sake
	name = "凉的传统清酒"
	desc = "甜得不能再甜, 下喉时却像火一样烧."
	icon_state = "sakebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/sake = 100)

/obj/item/reagent_containers/cup/glass/bottle/sake/Initialize(mapload)
	. = ..()
	if(prob(10))
		name = "Fluffy Tail Sake"
		desc += " On the bottle is a picture of a kitsune with nine touchable tails."
		icon_state = "sakebottle_k"
	else if(prob(10))
		name = "Inubashiri's Home Brew"
		desc += " Awoo."
		icon_state = "sakebottle_i"

/obj/item/reagent_containers/cup/glass/bottle/fernet
	name = "费尔内特·布龙卡"
	desc = "一瓶纯费尔内特·布龙卡, 产自科尔多瓦空间站"
	icon_state = "fernetbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/fernet = 100)

/obj/item/reagent_containers/cup/glass/bottle/bitters
	name = "仙女座苦精"
	desc = "任何饮品的芳香添加剂. 产自新特立尼达, 现在如此, 永远如此."
	icon_state = "bitters_bottle"
	volume = 30
	list_reagents = list(/datum/reagent/consumable/ethanol/bitters = 30)

/obj/item/reagent_containers/cup/glass/bottle/curacao
	name = "贝克霍夫蓝库拉索"
	desc = "这么多年过去了, 仍然在库拉索岛上生产."
	icon_state = "curacao_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/curacao = 100)

/obj/item/reagent_containers/cup/glass/bottle/navy_rum
	name = "联邦海军骄傲强度朗姆酒"
	desc = "名字颇具讽刺意味, 毕竟它产自百慕大."
	icon_state = "navy_rum_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/navy_rum = 100)

/obj/item/reagent_containers/cup/glass/bottle/grenadine
	name = "杰斯特石榴糖浆"
	desc = "含有0%真正的樱桃!"
	icon_state = "grenadine"
	list_reagents = list(/datum/reagent/consumable/grenadine = 100)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/glass/bottle/applejack
	name = "巴克·布朗科的苹果杰克"
	desc = "踢起来像马,尝起来像苹果!"
	icon_state = "applejack_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/applejack = 100)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/glass/bottle/wine_voltaic
	name = "伏打黄酒"
	desc = "带电的葡萄酒!为虚体充能,可安全饮用。"
	icon_state = "wine_voltaic_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/wine_voltaic = 100)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/glass/bottle/champagne
	name = "花花公子干型香槟"
	desc = "精心采购自最装腔作势的法国葡萄园。"
	icon_state = "champagne_bottle"
	base_icon_state = "champagne_bottle"
	reagent_flags = TRANSPARENT
	list_reagents = list(/datum/reagent/consumable/ethanol/champagne = 100)

/obj/item/reagent_containers/cup/glass/bottle/champagne/attack_self(mob/user)
	balloon_alert(user, "摆弄软木塞...")
	if(do_after(user, 1 SECONDS, src))
		return pop_cork(user, sabrage = FALSE, froth_severity = pick(0, 1))

/obj/item/reagent_containers/cup/glass/bottle/champagne/update_icon_state()
	. = ..()
	if(reagent_flags & OPENCONTAINER)
		icon_state = "[base_icon_state]_popped"
	else
		icon_state = base_icon_state

/obj/item/reagent_containers/cup/glass/bottle/champagne/proc/pop_cork(mob/living/user, sabrage, froth_severity)
	user.visible_message(
		span_danger("[user]松开了[src]的软木塞,使其以巨大的力量从瓶中弹出。"),
		span_nicegreen("你优雅地松开了[src]的软木塞,使其以巨大的力量从瓶中弹出。"),
		)
	reagents.reagent_flags |= OPENCONTAINER
	playsound(src, 'sound/items/champagne_pop.ogg', 70, TRUE)
	update_appearance()
	make_froth(offset_x = 0, offset_y = 15, intensity = froth_severity)

/obj/item/trash/champagne_cork
	name = "香槟软木塞"
	icon = 'icons/obj/drinks/drink_effects.dmi'
	icon_state = "champagne_cork"

/obj/item/reagent_containers/cup/glass/bottle/blazaam
	name = "金巴德的布拉扎姆"
	desc = "你觉得在打开瓶子之前应该好好搓一搓它。"
	icon_state = "blazaambottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/blazaam = 100)

/obj/item/reagent_containers/cup/glass/bottle/trappist
	name = "鲨鱼山修道院蓝啤"
	desc = "在太空比利时酿造。高级!"
	icon_state = "trappistbottle"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/ethanol/trappist = 50)

/obj/item/reagent_containers/cup/glass/bottle/hooch
	name = "私酿酒瓶"
	desc = "一瓶劣质酒。它的主人运用了一些街头智慧,巧妙地把它伪装成了一个棕色纸袋。"
	icon_state = "hoochbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/hooch = 100)

/obj/item/reagent_containers/cup/glass/bottle/moonshine
	name = "月光酒壶"
	desc = "据说古代阿帕拉契亚人用这些粗陶壶来捕捉瓶中的闪电。"
	icon_state = "moonshinebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/moonshine = 100)

/obj/item/reagent_containers/cup/glass/bottle/mushi_kombucha
	name = "索尔扎拉酿酒公司虫草康普茶"
	desc = "最好加冰饮用,以品味蘑菇的风味。"
	icon_state = "shroomy_bottle"
	volume = 30
	list_reagents = list(/datum/reagent/consumable/ethanol/mushi_kombucha = 30)
	can_shatter = FALSE

/obj/item/reagent_containers/cup/glass/bottle/hakka_mate
	name = "客家伴侣"
	desc = "客家伴侣:这是一种需要慢慢习惯的味道。"
	icon_state = "hakka_mate_bottle"
	list_reagents = list(/datum/reagent/consumable/hakka_mate = 30)

/obj/item/reagent_containers/cup/glass/bottle/shochu
	name = "蜀口坝直饮烧酒"
	desc = "一种为调酒而设计的更烈性的烧酒。直接来自火星的尘土之城,蜀口坝。"
	icon_state = "shochu_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/shochu = 100)

/obj/item/reagent_containers/cup/glass/bottle/yuyake
	name = "月工夕烧"
	desc = "迪斯科和喇叭裤的蒸馏精华,如同瓶中的闪电般被捕捉。"
	icon_state = "yuyake_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/yuyake = 100)

/obj/item/reagent_containers/cup/glass/bottle/coconut_rum
	name = "微风浅滩椰子朗姆酒"
	desc = "与微风浅滩一起享受轻松生活,仅采用*最优质的加勒比朗姆酒酿造。"
	icon_state = "coconut_rum_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/coconut_rum = 100)

/**
 * Cartons
 * Subtype of glass that don't break, and share a common carton hand state.
 * Meant to be a subtype for use in Molotovs
 */
/obj/item/reagent_containers/cup/glass/bottle/juice
	worn_icon_state = "carton"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/drinks_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/drinks_righthand.dmi',
		)
	can_shatter = FALSE

/obj/item/reagent_containers/cup/glass/bottle/juice/orangejuice
	name = "橙汁"
	desc = "富含维生素,美味可口!"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "orangejuice"
	list_reagents = list(/datum/reagent/consumable/orangejuice = 100)
	drink_type = FRUIT | BREAKFAST

/obj/item/reagent_containers/cup/glass/bottle/juice/cream
	name = "奶油"
	desc = "这是奶油。由牛奶制成。你以为里面还能有什么?"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "cream"
	list_reagents = list(/datum/reagent/consumable/cream = 100)
	drink_type = DAIRY

/obj/item/reagent_containers/cup/glass/bottle/juice/eggnog
	name = "蛋奶酒"
	desc = "用来享受一年中最美好的时光。"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "nog2"
	list_reagents = list(/datum/reagent/consumable/ethanol/eggnog = 100)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/glass/bottle/juice/dreadnog
	name = "蛋奶酒"
	desc = "当你想在蛋奶酒里加些普通的汽水时!"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "dreadnog"
	list_reagents = list(/datum/reagent/consumable/ethanol/dreadnog = 100)
	drink_type = FRUIT | GROSS

/obj/item/reagent_containers/cup/glass/bottle/juice/tomatojuice
	name = "番茄汁"
	desc = "好吧,至少它看起来像番茄汁。在那么红的情况下你也分辨不出来。"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "tomatojuice"
	list_reagents = list(/datum/reagent/consumable/tomatojuice = 100)
	drink_type = VEGETABLES

/obj/item/reagent_containers/cup/glass/bottle/juice/limejuice
	name = "青柠汁"
	desc = "酸甜可口。"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "limejuice"
	list_reagents = list(/datum/reagent/consumable/limejuice = 100)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/glass/bottle/juice/pineapplejuice
	name = "菠萝汁"
	desc = "极其酸涩的黄色果汁。"
	icon = 'icons/obj/drinks/boxes.dmi'
	icon_state = "pineapplejuice"
	list_reagents = list(/datum/reagent/consumable/pineapplejuice = 100)
	drink_type = FRUIT | PINEAPPLE

/obj/item/reagent_containers/cup/glass/bottle/juice/menthol
	name = "薄荷醇"
	desc = "尝起来天然带有薄荷味,并带来非常轻微的麻痹感。"
	list_reagents = list(/datum/reagent/consumable/menthol = 100)

#undef BOTTLE_KNOCKDOWN_DEFAULT_DURATION
