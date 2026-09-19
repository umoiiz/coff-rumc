//Food items that are eaten normally and don't leave anything behind.
/obj/item/reagent_containers/food/snacks
	name = "零食"
	desc = "好吃"
	icon = 'icons/obj/items/food/food.dmi'
	var/bitesize = 1
	var/bitecount = 0
	var/trash = null
	var/slice_path
	var/slices_num
	var/package = FALSE
	/// for example list("crisps" = 2, "salt" = 1)
	var/list/tastes

/obj/item/reagent_containers/food/snacks/create_reagents(max_vol, new_flags, list/init_reagents, data)
	. = ..()
	if(!length(tastes) || !length(init_reagents))
		return ..()
	if(reagents)
		qdel(reagents)
	reagents = new (max_vol, new_flags)
	reagents.my_atom = WEAKREF(src)
	for(var/rid in init_reagents)
		var/amount = list_reagents[rid]
		if(rid == /datum/reagent/consumable/nutriment)
			reagents.add_reagent(rid, amount, tastes.Copy())
		else
			reagents.add_reagent(rid, amount, data)

/obj/item/reagent_containers/food/snacks/proc/On_Consume(mob/M)
	if(!usr)
		return

	if(reagents.total_volume)
		return

	usr.dropItemToGround(src)	//so icons update :[

	if(trash)
		var/obj/item/T = new trash
		usr.put_in_hands(T)

	qdel(src)

/obj/item/reagent_containers/food/snacks/attack_self(mob/user as mob)
	return

/obj/item/reagant_containers/food/snacks/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(!CONFIG_GET(flag/fun_allowed))
		return FALSE
	attack_hand(xeno_attacker)

/obj/item/reagent_containers/food/snacks/attack(mob/M, mob/user, def_zone)
	if(!reagents.total_volume)						//Shouldn't be needed but it checks to see if it has anything left in it.
		balloon_alert(user, "[src]已经没了")
		M.dropItemToGround(src)	//so icons update :[
		qdel(src)
		return FALSE

	if(package)
		balloon_alert(user, "不行,包装还开着")
		return FALSE

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		var/fullness = C.nutrition + (C.reagents.get_reagent_amount(/datum/reagent/consumable/nutriment) * 25)
		if(M == user)								//If you're eating it yourself
			var/mob/living/carbon/H = M
			if(ishuman(H) && (H.species.species_flags & ROBOTIC_LIMBS))
				balloon_alert(user, "不能吃食物")
				return
			if(fullness <= 50)
				balloon_alert(user, "狼吞虎咽地咀嚼[src]")
			if(fullness > 50 && fullness <= 150)
				balloon_alert(user, "狼吞虎咽地吃[src]")
			if(fullness > 150 && fullness <= 350)
				balloon_alert(user, "咬了一口[src]")
			if(fullness > 350 && fullness <= 550)
				balloon_alert(user, "不情愿地咀嚼[src]")
			if(fullness > 550)
				balloon_alert(user, "不能再吃[src]了")
				return FALSE
		else
			var/mob/living/carbon/H = M
			if(ishuman(H) && (H.species.species_flags & ROBOTIC_LIMBS))
				balloon_alert(user, "无法进食")
				return
			if(fullness <= 550)
				balloon_alert_to_viewers("试图喂食[M]")
			else
				balloon_alert_to_viewers("试图喂食[M]但失败了")
				return FALSE

			if(!do_after(user, 3 SECONDS, NONE, M, BUSY_ICON_FRIENDLY))
				return

			var/rgt_list_text = get_reagent_list_text()
			log_combat(user, M, "fed", src, "Reagents: [rgt_list_text]")
			balloon_alert_to_viewers("强迫[M]进食")

		if(reagents)								//Handle ingestion of the reagent.
			playsound(M.loc,'sound/items/eatfood.ogg', 15, 1)
			if(reagents.total_volume)
				reagents.reaction(M, INGEST)
				if(reagents.total_volume > bitesize)
					/*
					* I totally cannot understand what this code supposed to do.
					* Right now every snack consumes in 2 bites, my popcorn does not work right, so I simplify it. -- rastaf0
					var/temp_bitesize = max(reagents.total_volume  * 0.5, bitesize)
					reagents.trans_to(M, temp_bitesize)
					*/
					//Why is bitesize used instead of an actual portion???
					record_reagent_consumption(bitesize, reagents.reagent_list, user, M)
					reagents.trans_to(M, bitesize, transfer_to_stomach = TRUE)
				else
					record_reagent_consumption(reagents.total_volume, reagents.reagent_list, user, M)
					reagents.trans_to(M, reagents.total_volume, transfer_to_stomach = TRUE)
				bitecount++
				On_Consume(M)
			return TRUE

	return FALSE

/obj/item/reagent_containers/food/snacks/examine(mob/user)
	. = ..()
	if(!(user in range(0)) && user != loc)
		return
	if(bitecount == 0)
		return
	if(bitecount == 1)
		. += span_notice("\The [src]被某人咬了!")
		return
	if(bitecount<=3)
		. += span_notice("\The [src]被咬了[bitecount]次!")
		return
	. += span_notice("\The [src]被咬了多次!")

/obj/item/reagent_containers/food/snacks/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(!istype(I, /obj/item/tool/kitchen/utensil))
		return
	var/obj/item/tool/kitchen/utensil/attacking_utensil = I

	if(attacking_utensil.reagents.total_volume > 0)
		balloon_alert(user, "[attacking_utensil]上已经有东西了!")
		return

	user.visible_message("[user]用\the [attacking_utensil]舀起了一些[src]!", \
		span_notice("你用\the [attacking_utensil]舀起了一些[src]!"))

	bitecount++
	var/image/food_image = image("icon" = icon, "icon_state" = icon_state, "layer" = attacking_utensil.layer+0.01)
	food_image.color = filling_color
	food_image.pixel_y = 5
	attacking_utensil.loaded = food_image
	attacking_utensil.update_appearance(UPDATE_OVERLAYS)

	reagents.trans_to(attacking_utensil, min(reagents.total_volume, 5))

	if(reagents.total_volume <= 0)
		qdel(src)

/obj/item/reagent_containers/food/snacks/sliceable/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(I.sharp == IS_NOT_SHARP_ITEM)
		if(I.w_class >= WEIGHT_CLASS_SMALL)
			return
		if(!user.transferItemToLoc(I, src))
			return
		if(length(contents) > max_items)
			balloon_alert(user, "已经吃饱了!")
			return
		balloon_alert(user, "将[I]滑入[src]中.")
		return

	if(!isturf(loc) || !(locate(/obj/structure/table) in loc))
		balloon_alert(user, "需要桌子或托盘才能切片!")
		return

	balloon_alert_to_viewers("[user]切开了[src].")

	var/reagents_per_slice = reagents.total_volume / slices_num

	for(var/i in 1 to slices_num)
		var/obj/slice = new slice_path(loc)
		reagents.trans_to(slice,reagents_per_slice)

	qdel(src)
	return TRUE

/obj/item/reagent_containers/food/snacks/Destroy()
	for(var/atom/movable/AM AS in contents)
		AM.forceMove(get_turf(src))
	return ..()

/obj/item/reagent_containers/food/snacks/attack_animal(mob/M)
	if(!isanimal(M))
		return

	if(iscorgi(M))
		var/mob/living/simple_animal/corgi/eating_corgi = M
		if(bitecount == 0 || prob(50))
			eating_corgi.emote("nibbles away at the [src]")
		bitecount++
		eating_corgi.taste(reagents) //why should carbons get all the fun?
		if(bitecount >= 5)
			eating_corgi.emote(pick("burps from enjoyment!", "yaps for more!", "woofs twice!", "looks at the area where the [src] was.."))
			qdel(src)
		return

	if(ismouse(M))
		var/mob/living/simple_animal/mouse/monuse = M
		monuse.taste(reagents) // ratatouilles
		if(prob(50))
			balloon_alert_to_viewers("小口啃食")
		monuse.health = min(monuse.health + 1, monuse.maxHealth)

//////////////////////////////////////////////////
///////////////////Snacks/////////////////////////
//////////////////////////////////////////////////
//Items in the "Snacks" subcategory are food items that people actually eat. The key points are that they are created
//	already filled with reagents and are destroyed when empty. Additionally, they make a "munching" noise when eaten.

//Notes by Darem: Food in the "snacks" subtype can hold a maximum of 50 units Generally speaking, you don't want to go over 40
//	total for the item because you want to leave space for extra condiments. If you want effect besides healing, add a reagent for
//	it. Try to stick to existing reagents when possible (so if you want a stronger healing effect, just use Tricordrazine). On use
//	effect (such as the old officer eating a donut code) requires a unique reagent (unless you can figure out a better way).

//The nutriment reagent and bitesize variable replace the old heal_amt and amount variables. Each unit of nutriment is equal to
//	2 of the old heal_amt variable. Bitesize is the rate at which the reagents are consumed. So if you have 6 nutriment and a
//	bitesize of 2, then it'll take 3 bites to eat. Unlike the old system, the contained reagents are evenly spread among all
//	the bites. No more contained reagents = no more bites.

//Here is an example of the new formatting for anyone who wants to add more food items.
///obj/item/reagent_containers/food/snacks/burger/xeno			//Identification path for the object.
//	 name = "Xenoburger"												//Name that displays in the UI.
//	 desc = "Smells caustic. Tastes like heresy."						//Duh
//	 icon_state = "xburger"												//Refers to an icon in food.dmi
//	 list_reagents = list(/datum/reagent/consumable/nutriment = 2)			//This is what is in the food item. you may copy/paste
//	 tastes = list("dough" = 2, "heresy" = 1)							//This is the flavour of the food
//	 bitesize = 3														//This is the amount each bite consumes.


///obj/item/reagent_containers/food/snacks/burger/xeno/Initialize(mapload)		//Absolute pathing for procs, please.
//	 . = ..()															//Calls the parent proc, don't forget to add this.

/obj/item/reagent_containers/food/snacks/honeycomb
	name = "蜂巢"
	icon_state = "honeycomb"
	desc = "滴着甜蜜的糖浆."
	list_reagents = list(/datum/reagent/consumable/honey = 10, /datum/reagent/consumable/nutriment = 0.5, /datum/reagent/consumable/sugar = 2)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/candy
	name = "糖果"
	desc = "牛轧糖,爱它还是恨它."
	icon_state = "candy"
	trash = /obj/item/trash/candy
	icon = 'icons/obj/items/food/packaged.dmi'
	filling_color = "#7D5F46"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3)
	tastes = list("candy" = 1)

/obj/item/reagent_containers/food/snacks/candy/donor
	name = "献血糖果"
	desc = "给献血者的一点小零食."
	trash = /obj/item/trash/candy
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 3, /datum/reagent/medicine/tricordrazine = 1, /datum/reagent/iron = 5) //Honk
	bitesize = 2

/obj/item/reagent_containers/food/snacks/candy_corn
	name = "玉米糖"
	desc = "这是一把玉米糖.可惜不能存放在侦探的帽子里."
	icon = 'icons/obj/items/food/candy.dmi'
	icon_state = "candy_corn"
	filling_color = "#FFFCB0"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sugar = 2)
	bitesize = 2
	tastes = list("candy corn" = 1)

/obj/item/reagent_containers/food/snacks/chips
	name = "薯片"
	desc = "赖克指挥官的惊爆脆片"
	icon = 'icons/obj/items/food/packaged.dmi'
	icon_state = "chips"
	trash = /obj/item/trash/chips
	filling_color = "#E8C31E"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sodiumchloride = 1)
	tastes = list("salt" = 1, "crisps" = 1)

/obj/item/reagent_containers/food/snacks/cookie
	name = "曲奇"
	desc = "曲奇!!!"
	icon_state = "COOKIE!!!"
	icon = 'icons/obj/items/food/confectionary.dmi'
	filling_color = "#DBC94F"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("cookie" = 1)

/obj/item/reagent_containers/food/snacks/chocolatebar
	name = "巧克力棒"
	desc = "如此甜美,令人发胖的食物."
	icon = 'icons/obj/items/food/candy.dmi'
	icon_state = "chocolatebar"
	filling_color = "#7D5F46"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/coco = 2)
	bitesize = 2
	tastes = list("chocolate" = 1)

/obj/item/reagent_containers/food/snacks/chocolateegg
	name = "巧克力蛋"
	desc = "如此甜美,令人发胖的食物."
	icon = 'icons/obj/items/food/candy.dmi'
	icon_state = "chocolateegg"
	filling_color = "#7D5F46"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/coco = 2)
	bitesize = 2
	tastes = list("chocolate" = 4, "sweetness" = 1)

/obj/item/reagent_containers/food/snacks/egg
	name = "蛋"
	desc = "一个蛋!"
	icon = 'icons/obj/items/food/packaged.dmi'
	icon_state = "egg"
	filling_color = "#FDFFD1"
	var/egg_color
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("egg" = 1)

/obj/item/reagent_containers/food/snacks/egg/throw_impact(atom/hit_atom)
	. = ..()
	if(!.)
		return
	new/obj/effect/decal/cleanable/egg_smudge(src.loc)
	src.reagents.reaction(hit_atom, TOUCH)
	src.visible_message(span_warning("[src.name]被压碎了."),span_warning("你听到啪的一声."))
	qdel(src)

/obj/item/reagent_containers/food/snacks/egg/blue
	icon_state = "egg-blue"
	egg_color = "blue"

/obj/item/reagent_containers/food/snacks/egg/green
	icon_state = "egg-green"
	egg_color = "green"

/obj/item/reagent_containers/food/snacks/egg/mime
	icon_state = "egg-mime"
	egg_color = "mime"

/obj/item/reagent_containers/food/snacks/egg/orange
	icon_state = "egg-orange"
	egg_color = "orange"

/obj/item/reagent_containers/food/snacks/egg/purple
	icon_state = "egg-purple"
	egg_color = "purple"

/obj/item/reagent_containers/food/snacks/egg/rainbow
	icon_state = "egg-rainbow"
	egg_color = "rainbow"

/obj/item/reagent_containers/food/snacks/egg/red
	icon_state = "egg-red"
	egg_color = "red"

/obj/item/reagent_containers/food/snacks/egg/yellow
	icon_state = "egg-yellow"
	egg_color = "yellow"

/obj/item/reagent_containers/food/snacks/friedegg
	name = "煎蛋"
	desc = "一个煎蛋,带点盐和胡椒."
	icon_state = "friedegg"
	filling_color = "#FFDF78"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sodiumchloride = 1, /datum/reagent/consumable/blackpepper = 1)
	tastes = list("egg" = 4, "salt" = 1, "pepper" = 1)

/obj/item/reagent_containers/food/snacks/boiledegg
	name = "水煮蛋"
	desc = "一个全熟的水煮蛋."
	icon = 'icons/obj/items/food/packaged.dmi'
	icon_state = "egg"
	filling_color = "#FFFFFF"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("egg" = 1)

/obj/item/reagent_containers/food/snacks/flour
	name = "面粉"
	desc = "一个装着面粉的小袋子."
	icon = 'icons/obj/items/food/packaged.dmi'
	icon_state = "flour"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("chalky wheat" = 1)

/obj/item/reagent_containers/food/snacks/organ
	name = "器官"
	desc = "对你有好处."
	icon = 'icons/obj/items/organs.dmi'
	icon_state = "appendix"
	filling_color = "#E00D34"
	bitesize = 3

/obj/item/reagent_containers/food/snacks/organ/Initialize(mapload)
	list_reagents = list(/datum/reagent/consumable/nutriment = rand(3,5), /datum/reagent/toxin = rand(1,3))
	return ..()

/obj/item/reagent_containers/food/snacks/worm
	name = "虫子"
	icon = 'icons/obj/items/items.dmi'
	icon_state = "worm"
	desc = "一条小虫子.看起来有点孤单."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	bitesize = 2
	tastes = list("dirt" = 1)
	attack_verb = list("touches")

/obj/item/reagent_containers/food/snacks/tofu
	name = "豆腐"
	icon_state = "tofu"
	desc = "我们都爱豆腐."
	filling_color = "#FFFEE0"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	bitesize = 3
	tastes = list("tofu" = 1)

/obj/item/reagent_containers/food/snacks/tofurkey
	name = "豆腐火鸡"
	desc = "用豆腐做的假火鸡."
	icon = 'icons/obj/items/food/mre.dmi'
	icon_state = "tofurkey"
	filling_color = "#FFFEE0"
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/toxin/sleeptoxin = 3)
	bitesize = 3
	tastes = list("tofu" = 3, "breadcrumbs" = 1)

/obj/item/reagent_containers/food/snacks/stuffing
	name = "填料"
	desc = "湿润的,带胡椒味的面包屑,用来填充死鸟的体腔.开吃吧!"
	icon = 'icons/obj/items/food/mre.dmi'
	icon_state = "stuffing"
	filling_color = "#C9AC83"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	tastes = list("breadcrumbs" = 3, "pepper" = 1)

/obj/item/reagent_containers/food/snacks/carpmeat
	name = "太空鲤鱼片"
	desc = "一片太空鲤鱼肉"
	icon = 'icons/obj/items/food/meat.dmi'
	icon_state = "fishfillet"
	filling_color = "#FFDEFE"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/toxin/carpotoxin = 3)
	bitesize = 6
	tastes = list("fish" = 1)

/obj/item/reagent_containers/food/snacks/fishfingers
	name = "鱼手指"
	desc = "一根鱼手指."
	icon = 'icons/obj/items/food/meat.dmi'
	icon_state = "fishfingers"
	filling_color = "#FFDEFE"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/toxin/carpotoxin = 3)
	bitesize = 3
	tastes = list("fish" = 1, "breadcrumbs" = 1)

/obj/item/reagent_containers/food/snacks/hugemushroomslice
	name = "巨型蘑菇片"
	desc = "一片巨型蘑菇切成的片."
	icon = 'icons/obj/items/food/meat.dmi'
	icon_state = "hugemushroomslice"
	filling_color = "#E0D7C5"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/psilocybin = 3)
	bitesize = 6
	tastes = list("mushroom" = 1)

/obj/item/reagent_containers/food/snacks/tomatomeat
	name = "番茄片"
	desc = "一片巨型番茄切成的片"
	icon = 'icons/obj/items/food/meat.dmi'
	icon_state = "tomatomeat"
	filling_color = "#DB0000"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	tastes = list("tomato" = 1)
	bitesize = 6

/obj/item/reagent_containers/food/snacks/bearmeat
	name = "熊肉"
	desc = "一块非常有男子气概的肉排."
	icon = 'icons/obj/items/food/meat.dmi'
	icon_state = "bearmeat"
	filling_color = "#DB0000"
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/toxin/sleeptoxin = 3)
	tastes = list("meat" = 1, "salmon" = 1)
	bitesize = 3

/obj/item/reagent_containers/food/snacks/raw_lizard_sausage
	name = "生蜥蜴血肠"
	desc = "一根生蜥蜴血肠, 可以在晾干架上进行腌制."
	icon = 'icons/obj/items/food/meat.dmi'
	icon_state = "raw_lizard_sausage"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 5, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/blood = 3)
	tastes = list("meat" = 1, "black pudding" = 1)

/obj/item/reagent_containers/food/snacks/lizard_sausage
	name = "\improper 蜥蜴血肠"
	desc = "一种粗制的干腌血肠, 传统上由100%有机来源的蜥蜴制成."
	icon = 'icons/obj/items/food/meat.dmi'
	icon_state = "lizard_sausage"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("meat" = 1, "black pudding" = 1)

/obj/item/reagent_containers/food/snacks/meatball
	name = "肉丸"
	desc = "一顿全面的美餐."
	icon = 'icons/obj/items/food/meat.dmi'
	icon_state = "meatball"
	filling_color = "#DB0000"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	tastes = list("meat" = 1)
	bitesize = 1

/obj/item/reagent_containers/food/snacks/sausage
	name = "香肠"
	desc = "一段混合的长条肉."
	icon = 'icons/obj/items/food/meat.dmi'
	icon_state = "sausage"
	filling_color = "#DB0000"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("meat" = 1)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/donkpocket
	name = "甜甜圈口袋"
	desc = "老练叛徒的首选食物."
	icon = 'icons/obj/items/food/confectionary.dmi'
	icon_state = "donkpocket"
	filling_color = "#DEDEAB"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("meat" = 2, "dough" = 2, "laziness" = 1)
	var/warm = FALSE

/obj/item/reagent_containers/food/snacks/donkpocket/proc/cooltime()
	if(!warm)
		return
	addtimer(CALLBACK(src, PROC_REF(cool_down)), 7 MINUTES)

/obj/item/reagent_containers/food/snacks/donkpocket/proc/cool_down()
	if(QDELETED(src))
		return
	warm = FALSE
	reagents.del_reagent(/datum/reagent/medicine/tricordrazine)
	name = "donk-pocket"

/obj/item/reagent_containers/food/snacks/human
	filling_color = "#D63C3C"
	var/hname = ""
	var/job = null

/obj/item/reagent_containers/food/snacks/omelette
	name = "奶酪煎蛋卷"
	desc = "你只会说这个!"
	icon_state = "omelette"
	trash = /obj/item/trash/plate
	filling_color = "#FFF9A8"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("egg" = 1, "cheese" = 1)


/obj/item/reagent_containers/food/snacks/muffin
	name = "松饼"
	desc = "一块美味又松软的小蛋糕"
	icon = 'icons/obj/items/food/confectionary.dmi'
	icon_state = "muffin"
	filling_color = "#E0CF9B"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	bitesize = 2
	tastes = list("muffin" = 1)

/obj/item/reagent_containers/food/snacks/waffles
	name = "华夫饼"
	desc = "嗯, 华夫饼"
	icon_state = "waffles"
	trash = /obj/item/trash/waffles
	filling_color = "#E6DEB5"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	bitesize = 2
	tastes = list("waffles" = 1)

/obj/item/reagent_containers/food/snacks/eggplantparm
	name = "帕尔马干酪茄子"
	desc = "茄子唯一的好做法."
	icon_state = "eggplantparm"
	trash = /obj/item/trash/plate
	filling_color = "#4D2F5E"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	bitesize = 2
	tastes = list("eggplant" = 3, "cheese" = 1)

/obj/item/reagent_containers/food/snacks/soylentgreen
	name = "绿色营养膏"
	desc = "不是用人做的. 真的." //Totally people.
	icon_state = "soylent_green"
	trash = /obj/item/trash/waffles
	filling_color = "#B8E6B5"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	bitesize = 2
	tastes = list("waffles" = 7, "people" = 1)

/obj/item/reagent_containers/food/snacks/soylenviridians
	name = "绿色营养膏"
	desc = "不是用人做的. 真的." //Actually honest for once.
	icon_state = "soylent_yellow"
	trash = /obj/item/trash/waffles
	filling_color = "#E6FA61"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	bitesize = 2
	tastes = list("waffles" = 7, "the colour green" = 1)

/obj/item/reagent_containers/food/snacks/human/kabob
	name = "-烤肉串"
	icon_state = "kabob"
	desc = "人肉, 串在棍子上."
	trash = /obj/item/stack/rods
	filling_color = "#A85340"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("tender meat" = 3, "metal" = 1)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/monkeykabob
	name = "肉串"
	icon_state = "kabob"
	desc = "美味的肉, 串在棍子上."
	trash = /obj/item/stack/rods
	filling_color = "#A85340"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("meat" = 3, "metal" = 1)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/tofukabob
	name = "豆腐串"
	icon_state = "kabob"
	desc = "素食肉, 串在棍子上."
	trash = /obj/item/stack/rods
	filling_color = "#FFFEE0"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("tofu" = 3, "metal" = 1)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/cubancarp
	name = "古巴鲤鱼"
	desc = "一个超棒的三明治, 会灼烧你的舌头然后让它麻木!"
	icon = 'icons/obj/items/food/meat.dmi'
	icon_state = "cubancarp"
	trash = /obj/item/trash/plate
	filling_color = "#E9ADFF"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/toxin/carpotoxin = 3, /datum/reagent/consumable/capsaicin = 3)
	tastes = list("fish" = 4, "batter" = 1, "hot peppers" = 1)
	bitesize = 3

/obj/item/reagent_containers/food/snacks/popcorn
	name = "爆米花"
	desc = "现在让我们找家电影院吧."
	icon_state = "popcorn"
	icon = 'icons/obj/items/food/packaged.dmi'
	trash = /obj/item/trash/popcorn
	filling_color = "#FFFAD4"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bitesize = 0.1  //this snack is supposed to be eating during looooong time. And this it not dinner food! --rastaf0
	tastes = list("popcorn" = 3, "butter" = 1)
	var/unpopped = 0

/obj/item/reagent_containers/food/snacks/popcorn/Initialize(mapload)
	. = ..()
	unpopped = rand(1,10)

/obj/item/reagent_containers/food/snacks/popcorn/On_Consume()
	if(prob(unpopped))	//lol ...what's the point?
		to_chat(usr, span_warning("你咬到了一颗没爆开的玉米粒!"))
		unpopped = max(0, unpopped-1)
	return ..()

/obj/item/reagent_containers/food/snacks/sosjerky
	name = "胆小鬼的私人储备牛肉干"
	icon_state = "sosjerky"
	desc = "用最优质的太空牛制成的牛肉干."
	icon = 'icons/obj/items/food/packaged.dmi'
	trash = /obj/item/trash/sosjerky
	filling_color = "#631212"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sodiumchloride = 2)
	bitesize = 2
	tastes = list("dried meat" = 1)

/obj/item/reagent_containers/food/snacks/no_raisin
	name = "4no葡萄干"
	icon_state = "4no_raisins"
	desc = "宇宙中最好的葡萄干. 不知道为什么."
	icon = 'icons/obj/items/food/packaged.dmi'
	trash = /obj/item/trash/raisins
	filling_color = "#343834"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 4)
	tastes = list("dried raisins" = 1)

/obj/item/reagent_containers/food/snacks/spacetwinkie
	name = "太空奶油蛋糕"
	icon_state = "space_twinkie"
	icon = 'icons/obj/items/food/confectionary.dmi'
	desc = "保证比你活得更久."
	filling_color = "#FFE591"
	list_reagents = list(/datum/reagent/consumable/sugar = 4)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/cheesiehonkers
	name = "芝士汉堡"
	icon_state = "cheesie_honkers"
	icon = 'icons/obj/items/food/packaged.dmi'
	desc = "一口大小的芝士零食, 会在你嘴里到处鸣叫"
	trash = /obj/item/trash/cheesie
	filling_color = "#FFA305"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3)
	bitesize = 2
	tastes = list("cheese" = 5, "crisps" = 2)

/obj/item/reagent_containers/food/snacks/syndicake
	name = "辛迪加蛋糕"
	icon = 'icons/obj/items/food/packaged.dmi'
	icon_state = "syndi_cakes"
	desc = "一种极其湿润的零食蛋糕, 被核爆后味道依然一样好."
	filling_color = "#FF5D05"

	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/doctor_delight = 5)
	trash = /obj/item/trash/syndi_cakes
	bitesize = 3
	tastes = list("sweetness" = 3, "cake" = 1)

/obj/item/reagent_containers/food/snacks/loadedbakedpotato
	name = "满载烤土豆"
	desc = "完全烤熟了."
	icon_state = "loadedbakedpotato"
	filling_color = "#9C7A68"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	bitesize = 2
	tastes = list("nutriment" = 1)

/obj/item/reagent_containers/food/snacks/fries
	name = "太空薯条"
	desc = "又名: 炸薯条, 自由薯条, 等等."
	icon = 'icons/obj/items/food/cheeseandfries.dmi'
	icon_state = "fries"
	trash = /obj/item/trash/plate
	filling_color = "#EDDD00"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	bitesize = 2
	tastes = list("fries" = 3, "salt" = 1)

/obj/item/reagent_containers/food/snacks/soydope
	name = "大豆兴奋剂"
	desc = "来自大豆的兴奋剂."
	icon_state = "soydope"
	trash = /obj/item/trash/plate
	filling_color = "#C4BF76"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bitesize = 2
	tastes = list("soy" = 1)

/obj/item/reagent_containers/food/snacks/cheesyfries
	name = "芝士薯条"
	desc = "薯条. 上面盖着芝士. 废话."
	icon = 'icons/obj/items/food/cheeseandfries.dmi'
	icon_state = "cheesyfries"
	trash = /obj/item/trash/plate
	filling_color = "#EDDD00"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	bitesize = 2
	tastes = list("fries" = 3, "cheese" = 1)

/obj/item/reagent_containers/food/snacks/fortunecookie
	name = "幸运饼干"
	desc = "每块饼干里都有一个真正的预言!"
	icon = 'icons/obj/items/food/confectionary.dmi'
	icon_state = "fortune_cookie"
	filling_color = "#E8E79E"
	trash = /obj/item/trash/fortunecookie
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	bitesize = 2
	tastes = list("cookie" = 1)

/obj/item/reagent_containers/food/snacks/badrecipe
	name = "烧焦的一团糟"
	desc = "有人应该因为这个被从厨师降职."
	icon_state = "badrecipe"
	filling_color = "#211F02"
	list_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/carbon = 3)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/meatsteak
	name = "肉排"
	desc = "一块热辣的肉."
	icon = 'icons/obj/items/food/meat.dmi'
	icon_state = "meatsteak"
	trash = /obj/item/trash/plate
	filling_color = "#7A3D11"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sodiumchloride = 1, /datum/reagent/consumable/blackpepper = 1)
	bitesize = 3
	tastes = list("meat" = 1)

/obj/item/reagent_containers/food/snacks/monkeycube
	name = "猴子方块"
	desc = "加点水就行!"
	icon = 'icons/obj/items/food/packaged.dmi'
	icon_state = "monkeycube"
	bitesize = 12
	filling_color = "#ADAC7F"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	tastes = list("the jungle" = 1, "bananas" = 1)
	var/monkey_type = /mob/living/carbon/human/species/monkey

/obj/item/reagent_containers/food/snacks/monkeycube/examine(mob/user)
	. = ..()
	if(package)
		. += "It is wrapped in waterproof cellophane. Maybe using it in your hand would tear it off?"

/obj/item/reagent_containers/food/snacks/monkeycube/afterattack(obj/O, mob/user, proximity)
	if(!proximity)
		return
	if(istype(O,/obj/structure/sink) && !package)
		to_chat(user, "你把\the [name]放到水流下...")
		user.drop_held_item()
		return Expand()
	return ..()

/obj/item/reagent_containers/food/snacks/monkeycube/attack_self(mob/user)
	if(!package)
		return
	icon_state = "monkeycube"
	balloon_alert_to_viewers("打开[src]")
	package = FALSE

/obj/item/reagent_containers/food/snacks/monkeycube/On_Consume(mob/M)
	to_chat(M, span_warning("你体内有什么东西突然膨胀了!</span>"))
	balloon_alert_to_viewers("吃掉[src]", ignored_mobs = M)
	usr.dropItemToGround(src)
	if(!ishuman(M))
		return ..()
	//Do not try to understand.
	var/obj/item/surprise = new(M)
	var/mob/ook = monkey_type
	surprise.icon = initial(ook.icon)
	surprise.icon_state = initial(ook.icon_state)
	surprise.name = "malformed [initial(ook.name)]"
	surprise.desc = "Looks like \a very deformed [initial(ook.name)], a little small for its kind. It shows no signs of life."
	surprise.transform *= 0.6
	surprise.add_mob_blood(M)
	var/mob/living/carbon/human/H = M
	var/datum/limb/E = H.get_limb("chest")
	E.fracture()
	for(var/datum/internal_organ/I in E.internal_organs)
		I.take_damage(rand(I.min_bruised_damage, I.min_broken_damage+1))
	if(!E.hidden && prob(60)) //set it snuggly
		E.hidden = surprise
		E.cavity = 0
	else //someone is having a bad day
		E.createwound(CUT, 30)
		surprise.embed_into(M, E)
	qdel(src)

/obj/item/reagent_containers/food/snacks/monkeycube/proc/Expand()
	balloon_alert_to_viewers("膨胀")
	var/turf/T = get_turf(src)
	if(T)
		new monkey_type(T)
	qdel(src)

/obj/item/reagent_containers/food/snacks/monkeycube/wrapped
	desc = "还包在纸里."
	icon_state = "monkeycubewrap"
	package = TRUE

/obj/item/reagent_containers/food/snacks/monkeycube/farwacube
	name = "法瓦方块"
	monkey_type = /mob/living/carbon/human/species/monkey/farwa

/obj/item/reagent_containers/food/snacks/monkeycube/wrapped/farwacube
	name = "法瓦方块"
	monkey_type = /mob/living/carbon/human/species/monkey/farwa

/obj/item/reagent_containers/food/snacks/monkeycube/stokcube
	name = "斯托克方块"
	monkey_type = /mob/living/carbon/human/species/monkey/stok

/obj/item/reagent_containers/food/snacks/monkeycube/wrapped/stokcube
	name = "斯托克方块"
	monkey_type = /mob/living/carbon/human/species/monkey/stok

/obj/item/reagent_containers/food/snacks/monkeycube/neaeracube
	name = "尼埃拉方块"
	monkey_type = /mob/living/carbon/human/species/monkey/naera
/obj/item/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube
	name = "尼埃拉方块"
	monkey_type = /mob/living/carbon/human/species/monkey/naera

/obj/item/reagent_containers/food/snacks/monkeysdelight
	name = "猴子的喜悦"
	desc = "咿咿咿!"
	icon_state = "monkeysdelight"
	trash = /obj/item/trash/tray
	filling_color = "#5C3C11"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/banana = 5, /datum/reagent/consumable/blackpepper = 1, /datum/reagent/consumable/sodiumchloride = 1)
	bitesize = 6
	tastes = list("the jungle" = 1, "banana" = 1)

/obj/item/reagent_containers/food/snacks/baguette
	name = "法棍面包"
	desc = "祝你好胃口!"
	icon = 'icons/obj/items/food/bread.dmi'
	icon_state = "baguette"
	filling_color = "#E3D796"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/blackpepper = 1, /datum/reagent/consumable/sodiumchloride = 1)
	bitesize = 3
	tastes = list("bread" = 1)

/obj/item/reagent_containers/food/snacks/fishandchips
	name = "炸鱼薯条"
	desc = "不是我自夸,老兄."
	icon = 'icons/obj/items/food/cheeseandfries.dmi'
	icon_state = "fishandchips"
	filling_color = "#E3D796"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/toxin/carpotoxin = 3)
	bitesize = 3
	tastes = list("fish" = 1, "chips" = 1)

/obj/item/reagent_containers/food/snacks/rofflewaffles
	name = "罗夫尔华夫饼"
	desc = "来自罗夫尔公司的华夫饼."
	icon_state = "rofflewaffles"
	trash = /obj/item/trash/waffles
	filling_color = "#FF00F7"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/psilocybin = 8)
	bitesize = 4
	tastes = list("waffle" = 1, "mushrooms" = 1)

/obj/item/reagent_containers/food/snacks/stewedsoymeat
	name = "炖大豆肉"
	desc = "连非素食者都会爱上它!"
	icon_state = "stewedsoymeat"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("soy" = 1, "vegetables" = 1)

/obj/item/reagent_containers/food/snacks/pizzapasta/boiledspaghetti
	name = "煮意大利面"
	desc = "一盘普通的面条,真难吃."
	icon_state = "spagettiboiled"
	trash = /obj/item/trash/plate
	filling_color = "#FCEE81"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bitesize = 2
	tastes = list("pasta" = 1)

/obj/item/reagent_containers/food/snacks/spesslaw
	name = "太空法式炖菜"
	desc = "律师的最爱"
	icon_state = "spesslaw"
	filling_color = "#DE4545"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	bitesize = 3
	tastes = list("pasta" = 1, "tomato" = 1, "meat" = 1)

/obj/item/reagent_containers/food/snacks/poppypretzel
	name = "罂粟椒盐卷饼"
	desc = "一个又大又软的椒盐卷饼,充满爆裂感!"
	icon = 'icons/obj/items/food/confectionary.dmi'
	icon_state = "poppypretzel"
	filling_color = "#AB7D2E"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	bitesize = 2
	tastes = list("pretzel" = 1)

/obj/item/reagent_containers/food/snacks/carrotfries
	name = "胡萝卜薯条"
	desc = "用新鲜胡萝卜做的美味薯条."
	icon = 'icons/obj/items/food/cheeseandfries.dmi'
	icon_state = "carrotfries"
	trash = /obj/item/trash/plate
	filling_color = "#FAA005"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/carrotjuice = 3)
	bitesize = 2
	tastes = list("carrots" = 3, "salt" = 1)

/obj/item/reagent_containers/food/snacks/candiedapple
	name = "糖苹果"
	desc = "一个裹满糖浆甜味的苹果."
	icon = 'icons/obj/items/food/candy.dmi'
	icon_state = "candiedapple"
	filling_color = "#F21873"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 2)
	bitesize = 3
	tastes = list("carrots" = 3, "salt" = 1)

/obj/item/reagent_containers/food/snacks/twobreadold
	name = "双层面包"
	desc = "它非常苦涩且带酒味."
	icon = 'icons/obj/items/food/bread.dmi'
	icon_state = "twobread"
	filling_color = "#DBCC9A"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bitesize = 3
	tastes = list("bread" = 2)

/obj/item/reagent_containers/food/snacks/mint
	name = "薄荷"
	desc = "它薄如蝉翼."
	icon = 'icons/obj/items/food/food.dmi'
	icon_state = "mint"
	filling_color = "#F2F2F2"
	list_reagents = list(/datum/reagent/toxin/minttoxin = 1)

/obj/item/reagent_containers/food/snacks/plumphelmetbiscuit
	name = "肥硕头盔菇饼干"
	desc = "这是一块精心制作的肥硕头盔菇饼干.原料是切得极细的肥硕头盔菇,以及切得很细的矮人小麦粉."
	icon_state = "phelmbiscuit"
	filling_color = "#CFB4C4"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	bitesize = 2
	tastes = list("mushroom" = 1, "biscuit" = 1)

/obj/item/reagent_containers/food/snacks/plumphelmetbiscuit/Initialize(mapload)
	if(prob(10))
		name = "exceptional plump helmet biscuit"
		desc = "Microwave is taken by a fey mood! It has cooked an exceptional plump helmet biscuit!"
		list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/medicine/tricordrazine = 5)
	return ..()

/obj/item/reagent_containers/food/snacks/chawanmushi
	name = "茶碗蒸"
	desc = "一道传奇的蛋羹,能让敌人变成朋友.对猫来说可能太烫了,吃不了."
	icon_state = "chawanmushi"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#F0F2E4"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("custard" = 1)

/obj/item/reagent_containers/food/snacks/tossedsalad
	name = "拌沙拉"
	desc = "一道正经的沙拉,简单朴素,夹杂着少许胡萝卜,番茄和苹果碎块.纯素!"
	icon = 'icons/obj/items/food/soupsalad.dmi'
	icon_state = "herbsalad"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#76B87F"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	bitesize = 3
	tastes = list("leaves" = 1, "vegetables" = 1, "apple" = 1)

/obj/item/reagent_containers/food/snacks/validsalad
	name = "合格沙拉"
	desc = "这只是一道用可疑的\"香草\"做成的沙拉,配有肉丸和炸土豆片.没有任何可疑之处."
	icon = 'icons/obj/items/food/soupsalad.dmi'
	icon_state = "validsalad"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#76B87F"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	bitesize = 3
	tastes = list("leaves" = 1, "nutriment" = 1, "meat" = 1, "valids" = 1)

/////////////////////////////////////////////////Sliceable////////////////////////////////////////
// All the food items that can be sliced into smaller bits like Meatbread and Cheesewheels

// sliceable is just an organization type path, it doesn't have any additional code or variables tied to it.
/obj/item/reagent_containers/food/snacks/sliceable
	name = "可切片食物"
	bitesize = 1
	slices_num = 5
	var/max_items = 4

/obj/item/reagent_containers/food/snacks/sliceable/cheesewheel
	name = "奶酪轮"
	desc = "一大轮美味的切达奶酪."
	icon = 'icons/obj/items/food/cheeseandfries.dmi'
	icon_state = "cheesewheel"
	slice_path = /obj/item/reagent_containers/food/snacks/cheesewedge
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	filling_color = "#FFF700"
	tastes = list("cheese" = 1)

/obj/item/reagent_containers/food/snacks/cheesewedge
	name = "奶酪块"
	desc = "一块美味的切达奶酪.切下它的那个奶酪轮肯定就在附近."
	icon = 'icons/obj/items/food/cheeseandfries.dmi'
	icon_state = "cheesewedge"
	filling_color = "#FFF700"
	bitesize = 2
	tastes = list("cheese" = 1)

/obj/item/reagent_containers/food/snacks/baked_cheese
	name = "烤奶酪轮"
	desc = "一个烤过的奶酪轮,融化又美味."
	icon = 'icons/obj/items/food/cheeseandfries.dmi'
	icon_state = "baked_cheese"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 10, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/nutriment = 5)
	tastes = list("cheese" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/baked_cheese_platter
	name = "烤奶酪拼盘"
	desc = "一个烤奶酪轮: 分享的最爱.通常配脆面包片蘸着吃,因为唯一比好奶酪更好的东西就是放在面包上的好奶酪."
	icon = 'icons/obj/items/food/cheeseandfries.dmi'
	icon_state = "baked_cheese_platter"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 12, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/consumable/nutriment = 8)
	tastes = list("cheese" = 1, "bread" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/watermelonslice
	name = "西瓜片"
	desc = "一片水灵灵的美味."
	icon_state = "watermelonslice"
	filling_color = "#FF3867"
	bitesize = 2
	tastes = list("watermelon" = 1)

/obj/item/reagent_containers/food/snacks/cracker
	name = "饼干"
	desc = "这是一块咸饼干."
	icon_state = "cracker"
	icon = 'icons/obj/items/food/mre.dmi'
	filling_color = "#F5DEB8"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	tastes = list("cracker" = 1)

// Flour + egg = dough
/obj/item/reagent_containers/food/snacks/flour/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/reagent_containers/food/snacks/egg))
		new /obj/item/reagent_containers/food/snacks/dough(src)
		balloon_alert(user, "制作面团")
		qdel(I)
		qdel(src)

// Egg + flour = dough
/obj/item/reagent_containers/food/snacks/egg/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/reagent_containers/food/snacks/flour))
		new /obj/item/reagent_containers/food/snacks/dough(src)
		balloon_alert(user, "制作面团")
		qdel(I)
		qdel(src)

	else if(istype(I, /obj/item/toy/crayon))
		var/obj/item/toy/crayon/C = I
		var/clr = C.colourName

		if(!(clr in list("blue", "green", "mime", "orange", "purple", "rainbow", "red", "yellow")))
			to_chat(user, span_notice("这颗蛋拒绝变成这种颜色!"))
			return

		to_chat(user, span_notice("你给\the [src][clr]上色"))
		icon_state = "egg-[clr]"
		egg_color = clr

/obj/item/reagent_containers/food/snacks/dough
	name = "面团"
	desc = "一块面团."
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "dough"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bitesize = 2
	tastes = list("dough" = 1)

// Dough + rolling pin = flat dough
/obj/item/reagent_containers/food/snacks/dough/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/tool/kitchen/rollingpin))
		new /obj/item/reagent_containers/food/snacks/sliceable/flatdough(src)
		balloon_alert(user, "压平面团")
		qdel(src)

// slicable into 3xdoughslices
/obj/item/reagent_containers/food/snacks/sliceable/flatdough
	name = "扁平的面团"
	desc = "一块压平的面团."
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "flat dough"
	slice_path = /obj/item/reagent_containers/food/snacks/doughslice
	slices_num = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	tastes = list("dough" = 1)

/obj/item/reagent_containers/food/snacks/doughslice
	name = "面团片"
	desc = "一道令人赞叹的菜肴的组成部分."
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "doughslice"
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	tastes = list("dough" = 1)

/obj/item/reagent_containers/food/snacks/meat
	name = "肉"
	desc = "一块肉"
	icon_state = "meat"
	icon = 'icons/obj/items/food/meat.dmi'
	max_integrity = 180
	filling_color = "#FF1C1C"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	bitesize = 3

/obj/item/reagent_containers/food/snacks/meat/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/tool/kitchen/knife))
		new /obj/item/reagent_containers/food/snacks/rawcutlet(src)
		new /obj/item/reagent_containers/food/snacks/rawcutlet(src)
		new /obj/item/reagent_containers/food/snacks/rawcutlet(src)
		balloon_alert(user, "把肉切成条")
		qdel(src)

/obj/item/reagent_containers/food/snacks/meat/syntiflesh
	name = "合成肉"
	desc = "一块合成肉."

/obj/item/reagent_containers/food/snacks/meat/human
	desc = "一块肉.看起来有点像猪肉..."

//Почему тут 2 мяса?

/obj/item/reagent_containers/food/snacks/meat/xeno
	icon_state = "xenomeat"
	filling_color = "#43DE18"
	tastes = list("meat" = 1, "acid" = 1)
	bitesize = 6

/obj/item/reagent_containers/food/snacks/meat/xenomeat
	name = "肉"
	desc = "一块散发着刺鼻气味的肉."
	icon_state = "xenomeat"
	filling_color = "#43DE18"

/obj/item/reagent_containers/food/snacks/meat/xenomeat/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/toxin/acid, 3)
	src.bitesize = 6

/obj/item/reagent_containers/food/snacks/meat/monkey
	//same as plain meat

/obj/item/reagent_containers/food/snacks/meat/corgi
	name = "柯基肉"
	desc = "尝起来像...嗯你知道的..."

/obj/item/reagent_containers/food/snacks/rawcutlet
	name = "生肉排"
	desc = "一片薄薄的生肉."
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "rawcutlet"
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	tastes = list("meat" = 1)

/obj/item/reagent_containers/food/snacks/rawcutlet/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/tool/kitchen/knife))
		new /obj/item/reagent_containers/food/snacks/rawmeatball(src)
		new /obj/item/reagent_containers/food/snacks/rawmeatball(src)
		new /obj/item/reagent_containers/food/snacks/rawmeatball(src)
		balloon_alert(user, "把肉条切碎并揉成丸子")
		qdel(src)

/obj/item/reagent_containers/food/snacks/cutlet
	name = "肉排"
	desc = "一片美味的肉."
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "cutlet"
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("meat" = 1)

/obj/item/reagent_containers/food/snacks/rawmeatball
	name = "生肉丸"
	desc = "一颗生肉丸."
	icon = 'icons/obj/items/food/meat.dmi'
	icon_state = "raw_meatball"
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)

/obj/item/reagent_containers/food/snacks/rawmeatball/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/grillable, /obj/item/reagent_containers/food/snacks/meatball, rand(40 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/reagent_containers/food/snacks/hotdog
	name = "热狗"
	desc = "和狗没关系,大概吧."
	icon = 'icons/obj/items/food/food.dmi'
	icon_state = "hotdog"
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("bun" = 3, "meat" = 2)

/obj/item/reagent_containers/food/snacks/flatbread
	name = "扁面包"
	desc = "平淡但管饱."
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "flatbread"
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)

/obj/item/reagent_containers/food/snacks/rawsticks
	name = "生薯条"
	desc = "生的薯条,不太好吃."
	icon = 'icons/obj/items/food/food_ingredients.dmi'
	icon_state = "rawsticks"
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	tastes = list("potatoes" = 3, "salt" = 1)

/obj/item/reagent_containers/food/snacks/packaged_burrito
	name = "包装墨西哥卷饼"
	desc = "一个硬邦邦的可微波墨西哥卷饼.包装上没有标明加热时间.由纳米传讯公司包装."
	icon = 'icons/obj/items/food/mre.dmi'
	icon_state = "burrito"
	bitesize = 2
	package = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("tortilla" = 2, "beans" = 2)

/obj/item/reagent_containers/food/snacks/packaged_burrito/attack_self(mob/user as mob)
	if(package)
		playsound(src.loc,'sound/effects/pageturn2.ogg', 15, 1)
		balloon_alert(user, "拆开卷饼")
		package = FALSE
		icon = 'icons/obj/items/food/mexican.dmi'
		icon_state = "openburrito"

/obj/item/reagent_containers/food/snacks/packaged_hdogs
	name = "包装热狗"
	desc = "一根软塌塌的、常温的热狗.包装上没有标明加热时间,所以你猜它大概可以直接吃.由纳米传讯公司包装."
	icon = 'icons/obj/items/food/mre.dmi'
	icon_state = "hot_dogs"
	bitesize = 2
	package = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sodiumchloride = 2)
	tastes = list("dough" = 1, "chicken" = 1)

/obj/item/reagent_containers/food/snacks/packaged_hdogs/attack_self(mob/user as mob)
	if(package)
		playsound(src.loc,'sound/effects/pageturn2.ogg', 15, 1)
		balloon_alert(user, "拆开热狗")
		package = FALSE
		icon = 'icons/obj/items/food/food.dmi'
		icon_state = "hotdog"

/obj/item/reagent_containers/food/snacks/upp
	name = "\improper USL口粮"
	desc = "一个密封的、冻干的、压缩的包装,内含一份食物.在USL海盗团乃至火星居民中很常见,尤其是那些驻扎在偏远殖民地的人.这一份是2415年包装的."
	icon = 'icons/obj/items/food/mre.dmi'
	icon_state = "upp_ration"
	bitesize = 2
	package = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sodiumchloride = 0.5)
	var/variation = null

/obj/item/reagent_containers/food/snacks/upp/Initialize(mapload)
	if(!variation)
		variation = pick("fish","rice")

	switch(variation)
		if("fish")
			tastes = list("dried [pick("carp", "shark", "tuna", "fish")]" = 1, "[pick("potatoes", "borsch", "borshch", "bortsch", "hardtack")]" = 1)
		if("rice")
			tastes = list("[pick("rice", "rye", "starch")]" = 1, "[pick("sawdust", "beans", "chicken")]" = 1)
	return ..()

/obj/item/reagent_containers/food/snacks/upp/attack_self(mob/user as mob)
	if(package)
		playsound(src.loc,'sound/effects/pageturn2.ogg', 15, 1)
		balloon_alert(user, "弹出包装封口")
		package = FALSE
		desc = "An extremely dried item of food, with little flavoring or coloration. Looks to be prepped for long term storage, but will expire without the packaging. Best to eat it now to avoid waste. At least things are equal."
		switch(variation)
			if("fish")
				name = "rationed fish"
				icon_state = "upp_1"
			if("rice")
				name = "rationed rice"
				icon_state = "upp_2"

/obj/item/reagent_containers/food/snacks/upp/fish
	name = "\improper UPP口粮(鱼)"
	variation = "fish"

/obj/item/reagent_containers/food/snacks/upp/rice
	name = "\improper UPP口粮(谷物)"
	variation = "rice"

/obj/item/reagent_containers/food/snacks/enrg_bar
	name = "能量棒"
	desc = "一根热量密集的棒,由名字念都念不出来的原料制成.不知怎的,连包装都能吃."
	icon = 'icons/obj/items/food/packaged.dmi'
	icon_state = "energybar"
	bitesize = 2
	w_class = WEIGHT_CLASS_TINY
	trash = /obj/item/trash/eat
	//no taste, default to "something indescribable"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)

/obj/item/reagent_containers/food/snacks/kepler_crisps
	name = "开普勒脆片"
	desc = "'它们好吃得令人不安!'现在含0%反式脂肪."
	icon_state = "kepler"
	bitesize = 2
	trash = /obj/item/trash/kepler
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sodiumchloride = 1)
	tastes = list("chips" = 2)

//Wrapped candy bars

/obj/item/reagent_containers/food/snacks/wrapped
	package = TRUE
	bitesize = 3
	icon = 'icons/obj/items/food/packaged.dmi'
	var/obj/item/trash/wrapper = null //Why this and not trash? Because it pulls the wrapper off when you unwrap it as a trash item.

/obj/item/reagent_containers/food/snacks/wrapped/attack_self(mob/user as mob)
	if(package)
		balloon_alert(user, "打开包装")
		playsound(loc,'sound/effects/pageturn2.ogg', 15, 1)

		new wrapper (user.loc)
		icon_state = "[initial(icon_state)]-o"
		package = FALSE

/obj/item/reagent_containers/food/snacks/wrapped/booniebars
	name = "布尼棒"
	desc = "两条美味的薄荷巧克力棒.<i>\"有时候东西就是...够不着.\"</i>"
	icon_state = "boonie"
	bitesize = 2 //Two bars
	wrapper = /obj/item/trash/boonie
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/coco = 4)
	tastes = list("peppermint" = 3, "falling into the sun" = 1)

/obj/item/reagent_containers/food/snacks/wrapped/chunk
	name = "大块盒"
	desc = "一条\"<b>大块</b>\"牌巧克力.<i>\"根据联邦法律,这是允许存在的最致密的巧克力.我们依法必须请求你不要把这个钝器用于营养以外的任何用途.\"</i>"
	icon_state = "chunk"
	force = 35 //LEGAL LIMIT OF CHOCOLATE
	bitesize = 3
	wrapper = /obj/item/trash/chunk
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/coco = 10)
	tastes = list("compressed matter" = 1)

/obj/item/reagent_containers/food/snacks/wrapped/barcaridine
	name = "巴卡里丁棒"
	desc = "一条巧克力棒,闻起来像医疗舱.<i>\"巧克力总能帮助消除疼痛.\"</i>"
	icon_state = "barcaridine"
	wrapper = /obj/item/trash/barcaridine
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/coco = 2, /datum/reagent/medicine/tramadol = 2)
	tastes = list ("cough syrup" = 1)

/obj/item/reagent_containers/food/snacks/wrapped/berrybar
	name = "浆果棒"
	desc = "浆果味十足的棒!这是世界卫生协会为外环殖民地发明的新产品.<i>\"来点浆果,把棒棒赶走!\"</i>"
	icon_state = "berrybar"
	wrapper = /obj/item/trash/berrybar
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/berryjuice = 1,
		/datum/reagent/medicine/tramadol = 10,
		/datum/reagent/medicine/bicaridine = 10,
		/datum/reagent/medicine/kelotane = 10,
		/datum/reagent/medicine/tricordrazine = 10,)
	tastes = list("delicious processed berries" = 1)
	bitesize = 9

/obj/item/reagent_containers/food/snacks/wrapped/proteinbar
	name = "蛋白棒"
	desc = "一条巧克力蛋白棒,由在其他食谱中找不到归宿的致密废弃食材制成."
	icon_state = "proteinbar"
	force = 10 //dense enough to hurt but less than chunk
	wrapper = /obj/item/trash/candy
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 8, /datum/reagent/consumable/coco = 2)
	tastes = list("compressed matter" = 3, "discarded rubber" = 1)

//MREs

/obj/item/reagent_containers/food/snacks/packaged_meal
	name = "\improper MRE组件"
	package = TRUE
	bitesize = 4
	icon_state = "entree"
	icon = 'icons/obj/items/food/mre.dmi'
	var/flavor = "boneless pork ribs"//default value


/obj/item/reagent_containers/food/snacks/packaged_meal/Initialize(mapload, newflavor)
	tastes = list("[pick(SSstrings.get_list_from_file("names/food_adjectives"))]" = 1) //idea, list, gimmick
	determinetype(newflavor)
	desc = "A packaged [icon_state] from a Meal Ready-to-Eat, there is a lengthy list of [pick("obscure", "arcane", "unintelligible", "revolutionary", "sophisticated", "unspellable")] ingredients and addictives printed on the back.</i>"
	return ..()

/obj/item/reagent_containers/food/snacks/packaged_meal/attack_self(mob/user as mob)
	if(package)
		balloon_alert(user, "打开包装")
		playsound(loc,'sound/effects/pageturn2.ogg', 15, 1)
		name = "\improper" + flavor
		desc = "The contents of a standard issue MRE. This one is " + flavor + "."
		icon_state = flavor
		package = FALSE

/obj/item/reagent_containers/food/snacks/packaged_meal/proc/determinetype(newflavor)
	name = "\improper MRE component" + " (" + newflavor + ")"
	flavor = newflavor

	switch(newflavor)
		if("boneless pork ribs", "grilled chicken", "pizza square", "spaghetti", "chicken tenders")
			icon_state = "entree"
			list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/sodiumchloride = 1)
		if("meatballs", "cheese spread", "beef turnover", "mashed potatoes")
			icon_state = "side"
			list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/sodiumchloride = 1)
		if("biscuit", "pretzels", "peanuts", "cracker")
			icon_state = "snack"
			list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/sodiumchloride = 1)
		if("spiced apples", "chocolate brownie", "sugar cookie", "choco bar", "crayon")
			icon_state = "dessert"
			list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/sugar = 1)

/obj/item/reagent_containers/food/snacks/lollipop
	name = "棒棒糖"
	desc = "一根美味的棒棒糖."
	icon = 'icons/obj/items/lollipop.dmi'
	icon_state = "lollipop_stick"
	worn_icon_state = "lollipop_stick"
	equip_slot_flags = ITEM_SLOT_MASK
	w_class = WEIGHT_CLASS_TINY
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 4)
	tastes = list("candy" = 1)
	var/mutable_appearance/head
	var/headcolor = rgb(0, 0, 0)
	var/succ_int = 100
	var/next_succ = 0
	var/mob/living/carbon/owner

/obj/item/reagent_containers/food/snacks/lollipop/Initialize(mapload)
	. = ..()
	head = mutable_appearance('icons/obj/items/lollipop.dmi', "lollipop_head")
	change_head_color(rgb(rand(0, 255), rand(0, 255), rand(0, 255)))

//makes lollipops actually wearable as masks and still edible the old fashioned way.
/obj/item/reagent_containers/food/snacks/lollipop/proc/handle_reagents()
	var/fraction = min(FOOD_METABOLISM/reagents.total_volume, 1)
	reagents.reaction(owner, INGEST, fraction)
	if(!reagents.trans_to(owner, FOOD_METABOLISM, transfer_to_stomach = TRUE))
		reagents.remove_any(FOOD_METABOLISM)

/obj/item/reagent_containers/food/snacks/lollipop/process()
	if(!owner)
		stack_trace("lollipop processing without an owner")
		return PROCESS_KILL
	if(!reagents)
		stack_trace("lollipop processing without a reagents datum")
		return PROCESS_KILL
	if(owner.stat == DEAD)
		return PROCESS_KILL
	if(!reagents.total_volume)
		qdel(src)
		return
	if(next_succ <= world.time)
		handle_reagents()
		next_succ = world.time + succ_int

/obj/item/reagent_containers/food/snacks/lollipop/equipped(mob/user, slot)
	. = ..()
	if(!iscarbon(user))
		return
	if(slot != SLOT_WEAR_MASK)
		owner = null
		STOP_PROCESSING(SSobj, src) //equipped is triggered when moving from hands to mouth and vice versa
		return
	owner = user
	START_PROCESSING(SSobj, src)

/obj/item/reagent_containers/food/snacks/lollipop/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/reagent_containers/food/snacks/lollipop/proc/change_head_color(C)
	headcolor = C
	cut_overlay(head)
	head.color = C
	add_overlay(head)

//med pop
/obj/item/reagent_containers/food/snacks/lollipop/tramadol
	name = "运输棒棒糖"
	desc = "你在医疗舱表现良好的奖励. 可以吃掉或放入面具槽."
	list_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/medicine/tramadol = 4)
	tastes = list("cough syrup" = 1, "artificial sweetness" = 1)

/obj/item/reagent_containers/food/snacks/lollipop/tramadol/combat
	desc = "一种在意识到大量陆战队员最终会染上严重的阿片类药物成瘾后设计的棒棒糖, 旨在对抗这一问题. 至于有没有用, 那就看你自己了. 可以吃掉或放入面具槽"
	list_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/medicine/tramadol = 10)
	tastes = list("cough syrup" = 1, "artificial sweetness" = 1)

/obj/item/reagent_containers/food/snacks/lollipop/combat
	name = "医疗棒棒糖"
	desc = "一种通过将糖与双卡因和凯洛坦混合来随时间治疗伤口的棒棒糖, 试剂消耗速度较慢. 可以吃掉或放入面具槽"
	list_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/medicine/bicaridine = 5, /datum/reagent/medicine/kelotane = 5)

/obj/item/reagent_containers/food/snacks/lollipop/tricord
	name = "三可定棒棒糖"
	desc = "一种注入了三可定嗪的棒棒糖, 一种缓慢治疗的试剂. 可以吃掉或放入面具槽."
	list_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/medicine/tricordrazine = 10)
	tastes = list("cough syrup" = 1, "artificial sweetness" = 1)

////////////////////////////////////////////DONK POCKETS////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/donkpocket
	name = "\improper 甜甜圈口袋"
	desc = "老练叛徒的首选食物."
	icon_state = "donkpocket"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("meat" = 2, "dough" = 2, "laziness" = 1)
	w_class = WEIGHT_CLASS_SMALL
/obj/item/reagent_containers/food/snacks/donkpocket/warm
	name = "热甜甜圈口袋"
	desc = "老练叛徒的首选加热食物."
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/medicine/tricordrazine = 6)
	tastes = list("meat" = 2, "dough" = 2, "laziness" = 1)

//donkpockets

/obj/item/reagent_containers/food/snacks/donkpocket/dankpocket
	name = "\improper 大麻口袋"
	desc = "老练植物学家的首选食物."
	icon_state = "dankpocket"
	list_reagents = list(/datum/reagent/space_drugs = 3, /datum/reagent/consumable/nutriment = 4)
	tastes = list("meat" = 2, "dough" = 2)

/obj/item/reagent_containers/food/snacks/donkpocket/spicy
	name = "\improper 香辣口袋"
	desc = "经典零食, 现在带有热激活的辛辣风味."
	icon_state = "donkpocketspicy"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/consumable/capsaicin = 2)
	tastes = list("meat" = 2, "dough" = 2, "spice" = 1)

/obj/item/reagent_containers/food/snacks/donkpocket/warm/spicy
	name = "热香辣口袋"
	desc = "经典零食, 现在可能有点太辣了."
	icon_state = "donkpocketspicy"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/medicine/tricordrazine = 2, /datum/reagent/consumable/capsaicin = 5)
	tastes = list("meat" = 2, "dough" = 2, "weird spices" = 2)

/obj/item/reagent_containers/food/snacks/donkpocket/teriyaki
	name = "\improper 照烧口袋"
	desc = "经典空间站零食的东亚风味版本."
	icon_state = "donkpocketteriyaki"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/consumable/soysauce = 2)
	tastes = list("meat" = 2, "dough" = 2, "soy sauce" = 2)

/obj/item/reagent_containers/food/snacks/donkpocket/warm/teriyaki
	name = "热照烧口袋"
	desc = "经典空间站零食的东亚风味版本, 现在热气腾腾."
	icon_state = "donkpocketteriyaki"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 3, /datum/reagent/medicine/tricordrazine = 2, /datum/reagent/consumable/soysauce = 2)
	tastes = list("meat" = 2, "dough" = 2, "soy sauce" = 2)

/obj/item/reagent_containers/food/snacks/donkpocket/pizza
	name = "\improper 披萨口袋"
	desc = "美味, 芝士浓郁, 而且出乎意料地管饱."
	icon_state = "donkpocketpizza"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/consumable/tomatojuice = 2)
	tastes = list("meat" = 2, "dough" = 2, "cheese"= 2)

/obj/item/reagent_containers/food/snacks/donkpocket/warm/pizza
	name = "热披萨口袋"
	desc = "美味, 芝士浓郁, 加热后更棒."
	icon_state = "donkpocketpizza"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/medicine/tricordrazine = 2, /datum/reagent/consumable/tomatojuice = 2)
	tastes = list("meat" = 2, "dough" = 2, "melty cheese"= 2)

/obj/item/reagent_containers/food/snacks/donkpocket/honk
	name = "\improper 小丑口袋"
	desc = "屡获殊荣的甜甜圈口袋, 赢得了小丑和人类的心."
	icon_state = "donkpocketbanana"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/banana = 4)
	tastes = list("banana" = 2, "dough" = 2, "children's antibiotics" = 1)

/obj/item/reagent_containers/food/snacks/donkpocket/warm/honk
	name = "热小丑口袋"
	desc = "屡获殊荣的甜甜圈口袋, 现在温暖又热乎."
	icon_state = "donkpocketbanana"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/tricordrazine = 2, /datum/reagent/consumable/banana = 4, /datum/reagent/consumable/laughter = 6)
	tastes = list("dough" = 2, "children's antibiotics" = 1)

/obj/item/reagent_containers/food/snacks/donkpocket/berry
	name = "\improper 浆果口袋"
	desc = "一种极其甜腻的甜甜圈口袋, 最初是为沙漠风暴行动而创造的."
	icon_state = "donkpocketberry"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/berryjuice = 3)
	tastes = list("dough" = 2, "jam" = 2)

/obj/item/reagent_containers/food/snacks/donkpocket/warm/berry
	name = "热浆果口袋"
	desc = "一种极其甜腻的甜甜圈口袋, 现在温暖又美味."
	icon_state = "donkpocketberry"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/tricordrazine = 2, /datum/reagent/consumable/berryjuice = 3)
	tastes = list("dough" = 2, "warm jam" = 2)

/obj/item/reagent_containers/food/snacks/donkpocket/gondola
	name = "\improper 海豚口袋"
	desc = "在配方中使用真正的海豚肉这个选择, 至少可以说是颇具争议." //Only a monster would craft this.
	icon_state = "donkpocketgondola"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("meat" = 2, "dough" = 2, "inner peace" = 1)

/obj/item/reagent_containers/food/snacks/donkpocket/warm/gondola
	name = "热海豚口袋"
	desc = "在配方中使用真正的海豚肉这个选择, 至少可以说是颇具争议."
	icon_state = "donkpocketgondola"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/medicine/tricordrazine = 2)
	tastes = list("meat" = 2, "dough" = 2, "inner peace" = 1)
