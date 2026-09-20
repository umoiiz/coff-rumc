/obj/item/toy
	icon = 'icons/obj/items/toy.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/toys_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/toys_right.dmi',
	)
	throw_speed = 4
	throw_range = 20
	force = 0

/obj/item/toy/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(!CONFIG_GET(flag/fun_allowed))
		return FALSE
	attack_hand(xeno_attacker)

/*
* Balloons
*/
/obj/item/toy/balloon
	name = "水气球"
	desc = "一个半透明气球。里面什么都没有。"
	icon_state = "waterballoon-e"
	worn_icon_state = "balloon-empty"

/obj/item/toy/balloon/Initialize(mapload)
	. = ..()
	var/datum/reagents/R = new/datum/reagents(10)
	reagents = R
	R.my_atom = WEAKREF(src)

/obj/item/toy/balloon/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/toy/balloon/afterattack(atom/A as mob|obj, mob/user as mob, proximity)
	if(!proximity)
		return
	if (istype(A, /obj/structure/reagent_dispensers/watertank) && get_dist(src,A) <= 1)
		A.reagents.trans_to(src, 10)
		to_chat(user, span_notice("你将[A]的内容物装入了气球。"))
		desc = "A translucent balloon with some form of liquid sloshing around in it."
		update_icon()

/obj/item/toy/balloon/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/reagent_containers/glass))
		if(!I.reagents)
			return

		if(I.reagents.total_volume < 1)
			to_chat(user, "[I]是空的。")
			return

		if(I.reagents.has_reagent(/datum/reagent/toxin/acid/polyacid, 1))
			to_chat(user, "酸液腐蚀穿了气球!")
			I.reagents.reaction(user, TOUCH)
			qdel(src)
			return

		desc = "A translucent balloon with some form of liquid sloshing around in it."
		to_chat(user, span_notice("你将[I]的内容物装入了气球。"))
		I.reagents.trans_to(src, 10)
	update_icon()

/obj/item/toy/balloon/throw_impact(atom/hit_atom)
	. = ..()
	if(!.)
		return
	if(src.reagents.total_volume >= 1)
		src.visible_message(span_warning("[src]爆裂了!"),"你听到啪的一声和溅水声.")
		src.reagents.reaction(get_turf(hit_atom), TOUCH)
		for(var/atom/A in get_turf(hit_atom))
			src.reagents.reaction(A, TOUCH)
		src.icon_state = "burst"
		QDEL_IN(src, 5)

/obj/item/toy/balloon/update_icon_state()
	. = ..()
	if(reagents.total_volume)
		icon_state = "waterballoon"
		worn_icon_state = "balloon"
	else
		icon_state = "waterballoon-e"
		worn_icon_state = "balloon-empty"

/obj/item/toy/syndicateballoon
	name = "辛迪加气球"
	desc = "背面有个标签写着\"FUK NT!11!\"."
	throw_speed = 4
	throw_range = 20
	force = 0
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "syndballoon"
	worn_icon_state = "syndballoon"
	w_class = WEIGHT_CLASS_BULKY

/*
* Fake telebeacon
*/
/obj/item/toy/blink
	name = "电子眨眼玩具游戏"
	desc = "眨眼.  眨眼.  眨眼. 适合8岁及以上."
	icon = 'icons/obj/items/radio.dmi'
	icon_state = "beacon"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/tools_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/tools_right.dmi',
	)
	worn_icon_state = "signaler"

/*
* Fake singularity
*/
/obj/item/toy/spinningtoy
	name = "引力奇点"
	desc = "\"Singulo\"品牌旋转玩具."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "singularity_s1"

/*
* Crayons
*/
/obj/item/toy/crayon
	name = "蜡笔"
	desc = "一支彩色蜡笔. 请勿食用或塞入鼻孔."
	icon = 'icons/obj/items/crayons.dmi'
	icon_state = "crayonred"
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("attacks", "colours")
	///RGB
	var/colour = "#FF0000"
	///RGB
	var/shadeColour = "#220000"
	///0 for unlimited uses
	var/uses = 30
	var/instant = 0
	///for updateIcon purposes
	var/colourName = "red"

/*
* Snap pops
*/
/obj/item/toy/snappop
	name = "摔炮"
	desc = "哇!"
	icon_state = "snappop"
	w_class = WEIGHT_CLASS_TINY

/obj/item/toy/snappop/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_cross),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/item/toy/snappop/throw_impact(atom/hit_atom)
	. = ..()
	if(!.)
		return
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	new /obj/effect/decal/cleanable/ash(src.loc)
	src.visible_message(span_warning("[src.name]爆炸了!"),span_warning("你听到啪的一声!"))
	playsound(src, 'sound/effects/snap.ogg', 25, 1)
	qdel(src)

/obj/item/toy/snappop/proc/on_cross(datum/source, atom/movable/H, oldloc, oldlocs)
	SIGNAL_HANDLER
	if(!ishuman(H)) //i guess carp and shit shouldn't set them off
		return
	var/mob/living/carbon/M = H
	if(M.m_intent != MOVE_INTENT_RUN)
		return
	to_chat(M, span_warning("你踩到了摔炮!"))

	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(2, 0, src)
	s.start()
	new /obj/effect/decal/cleanable/ash(src.loc)
	visible_message(span_warning("[src.name]爆炸了!"),span_warning("你听到啪的一声!"))
	playsound(src, 'sound/effects/snap.ogg', 25, 1)
	qdel(src)

/*
* Water flower
*/
/obj/item/toy/waterflower
	name = "水花"
	desc = "一朵看似无害的向日葵...暗藏玄机."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "sunflower"
	worn_icon_state = "sunflower"
	var/empty = 0
	flags

/obj/item/toy/waterflower/Initialize(mapload)
	. = ..()
	var/datum/reagents/R = new/datum/reagents(10)
	reagents = R
	R.my_atom = WEAKREF(src)
	R.add_reagent(/datum/reagent/water, 10)

/obj/item/toy/waterflower/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/toy/waterflower/afterattack(atom/A as mob|obj, mob/user as mob)

	if (istype(A, /obj/item/storage/backpack ))
		return

	else if (locate (/obj/structure/table, loc))
		return

	else if (istype(A, /obj/structure/reagent_dispensers/watertank) && get_dist(src,A) <= 1)
		A.reagents.trans_to(src, 10)
		to_chat(user, span_notice("你给花补充了水!"))
		return

	else if (src.reagents.total_volume < 1)
		empty = 1
		to_chat(user, span_notice("你的花没水了!"))
		return

	else
		empty = 0

		var/obj/effect/decal/D = new/obj/effect/decal/(get_turf(src))
		D.name = "water"
		D.icon = 'icons/obj/items/chemistry.dmi'
		D.icon_state = "chempuff"
		D.create_reagents(5)
		reagents.trans_to(D, 1)
		playsound(loc, 'sound/effects/spray3.ogg', 15, 1, 3)

		INVOKE_ASYNC(src, PROC_REF(spray_water), A, D, user)
		return

/obj/item/toy/waterflower/proc/spray_water(atom/our_atom, obj/effect/decal/our_decal, mob/user)
	for(var/i = 0, i < 1, i++)
		step_towards(our_decal, our_atom)
		our_decal.reagents.reaction(get_turf(our_decal))
		for(var/atom/T in get_turf(our_decal))
			our_decal.reagents.reaction(T)
			if(ismob(T) && T:client)
				to_chat(T:client, span_warning("[user]朝你喷了水!"))
		sleep(0.4 SECONDS)
	qdel(our_decal)

/obj/item/toy/waterflower/examine(mob/user)
	. = ..()
	. += "[reagents.total_volume] units of water left!"

/*
* Mech prizes
*/
/obj/item/toy/prize
	icon_state = "ripleytoy"
	var/cooldown = 0

//all credit to skasi for toy mech fun ideas
/obj/item/toy/prize/attack_self(mob/user as mob)
	if(cooldown < world.time - 8)
		to_chat(user, span_notice("你玩弄[src]."))
		playsound(user, 'sound/mecha/mechstep.ogg', 15, 1)
		cooldown = world.time

/obj/item/toy/prize/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(loc == user)
		if(cooldown < world.time - 8)
			to_chat(user, span_notice("你玩弄[src]."))
			playsound(user, 'sound/mecha/mechturn.ogg', 15, 1)
			cooldown = world.time
			return

/obj/item/toy/prize/ripley
	name = "玩具雷普利"
	desc = "迷你机甲可动人偶! 集齐全套! 1/11."

/obj/item/toy/prize/fireripley
	name = "玩具消防雷普利"
	desc = "迷你机甲可动人偶! 集齐全套! 2/11."
	icon_state = "fireripleytoy"

/obj/item/toy/prize/deathripley
	name = "玩具死队雷普利"
	desc = "迷你机甲可动人偶! 集齐全套! 3/11."
	icon_state = "deathripleytoy"

/obj/item/toy/prize/gygax
	name = "玩具盖革克斯"
	desc = "迷你机甲可动人偶! 集齐全套! 4/11."
	icon_state = "gygaxtoy"

/obj/item/toy/prize/durand
	name = "玩具杜兰德"
	desc = "迷你机甲可动人偶! 集齐全套! 5/11."
	icon_state = "durandprize"

/obj/item/toy/prize/honk
	name = "玩具H.O.N.K."
	desc = "迷你机甲可动人偶! 集齐全套! 6/11."
	icon_state = "honkprize"

/obj/item/toy/prize/marauder
	name = "玩具掠夺者"
	desc = "迷你机甲可动人偶! 集齐全套! 7/11."
	icon_state = "marauderprize"

/obj/item/toy/prize/seraph
	name = "玩具炽天使"
	desc = "迷你机甲可动人偶! 集齐全套! 8/11."
	icon_state = "seraphprize"

/obj/item/toy/prize/mauler
	name = "玩具重击者"
	desc = "迷你机甲可动人偶! 集齐全套! 9/11."
	icon_state = "maulerprize"

/obj/item/toy/prize/odysseus
	name = "玩具奥德修斯"
	desc = "迷你机甲可动人偶! 集齐全套! 10/11."
	icon_state = "odysseusprize"

/obj/item/toy/prize/phazon
	name = "玩具相位"
	desc = "迷你机甲可动人偶! 集齐全套! 11/11."
	icon_state = "phazonprize"

/obj/item/toy/inflatable_duck
	name = "充气鸭"
	desc = "能漂着就漂着, 沉浮无忧!"
	icon_state = "inflatable"
	worn_icon_state = "inflatable"
	icon = 'icons/obj/clothing/belts.dmi'
	equip_slot_flags = ITEM_SLOT_BELT

/obj/item/toy/beach_ball
	name = "沙滩球"
	icon_state = "beachball"
	worn_icon_state = "beachball"
	density = FALSE
	anchored = FALSE
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 1
	throw_range = 20

/obj/item/toy/beach_ball/afterattack(atom/target, mob/user)
	user.drop_held_item()
	throw_at(target, throw_range, throw_speed, user)

/obj/item/toy/dice
	name = "d6"
	desc = "一颗六面骰子."
	icon = 'icons/obj/items/dice.dmi'
	icon_state = "d66"
	w_class = WEIGHT_CLASS_TINY
	var/sides = 6
	attack_verb = list("dices")

/obj/item/toy/dice/Initialize(mapload)
	. = ..()
	icon_state = "[name][rand(sides)]"

/obj/item/toy/dice/d20
	name = "d20"
	desc = "一颗二十面骰子."
	icon_state = "d2020"
	sides = 20

/obj/item/toy/dice/attack_self(mob/user as mob)
	var/result = rand(1, sides)
	var/comment = ""
	if(sides == 20 && result == 20)
		comment = "Nat 20!"
	else if(sides == 20 && result == 1)
		comment = "Ouch, bad luck."
	icon_state = "[name][result]"
	user.visible_message(span_notice("[user]投掷了[src]. 结果是[result]. [comment]"), \
						span_notice("你投掷了[src]. 结果是[result]. [comment]"), \
						span_notice("你听到[src]落在[result]上. [comment]"))

/obj/item/toy/bikehorn
	name = "自行车喇叭"
	desc = "自行车上拆下来的喇叭."
	icon = 'icons/obj/items/items.dmi'
	icon_state = "bike_horn"
	worn_icon_state = "bike_horn"
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 15
	attack_verb = list("HONKS")

/obj/item/toy/bikehorn/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, 'sound/items/bikehorn.ogg', 50)

/obj/item/toy/plush
	name = "普通玩偶"
	desc = "一个长相古怪的玩偶, 上面有个标签写着: '若拾获请归还给编码员.'"
	w_class = WEIGHT_CLASS_TINY
	icon_state = "debug"
	attack_verb = list("thumps", "whomps", "bumps")
	/// What was the last time we touch it?
	var/last_hug_time
	/// What sound should we play as squeak?
	var/squeak_sound = 'sound/items/dollsqueak.ogg'
	/// How loud is the squeak?
	var/squeak_volume = 50

/obj/item/toy/plush/attack_self(mob/user)
	if(world.time > last_hug_time)
		user.visible_message(span_notice("[user]拥抱了[src]! 好可爱!"), \
			span_notice("你拥抱了[src]. 哎呀www..."))
		last_hug_time = world.time + 5 SECONDS
		playsound(src, squeak_sound, 50)

/obj/item/toy/plush/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, squeak_sound, squeak_volume)

/obj/item/toy/plush/farwa
	name = "法尔瓦毛绒玩偶"
	desc = "一个法尔瓦毛绒玩偶. 柔软又舒适!"
	icon_state = "farwaplush"

/obj/item/toy/plush/therapy_red
	name = "红色治疗玩偶"
	desc = "用于治疗和娱乐目的的玩具. 这个是红色的."
	icon_state = "therapyred"

/obj/item/toy/plush/therapy_purple
	name = "紫色治疗玩偶"
	desc = "用于治疗和娱乐目的的玩具. 这个是紫色的."
	icon_state = "therapypurple"

/obj/item/toy/plush/therapy_blue
	name = "蓝色治疗玩偶"
	desc = "用于治疗和娱乐目的的玩具. 这个是蓝色的."
	icon_state = "therapyblue"

/obj/item/toy/plush/therapy_yellow
	name = "黄色治疗玩偶"
	desc = "用于治疗和娱乐目的的玩具. 这个是黄色的."
	icon_state = "therapyyellow"

/obj/item/toy/plush/therapy_orange
	name = "橙色治疗玩偶"
	desc = "用于治疗和娱乐目的的玩具. 这个是橙色的."
	icon_state = "therapyorange"

/obj/item/toy/plush/therapy_green
	name = "绿色治疗玩偶"
	desc = "用于治疗和娱乐目的的玩具. 这个是绿色的."
	icon_state = "therapygreen"

/obj/item/toy/plush/carp
	name = "鲤鱼毛绒玩具"
	desc = "一个可爱的毛绒玩具,外形像一条鲤鱼."
	icon_state = "carpplush"
	worn_icon_state = "carp_plushie"
	attack_verb = list("bites", "eats", "fin slaps")

/obj/item/toy/plush/lizard
	name = "蜥蜴毛绒玩具"
	desc = "一个可爱的毛绒玩具,外形像一只蜥蜴."
	icon_state = "lizplush"
	worn_icon_state = "lizplush"
	attack_verb = list("claws", "hisses", "tail slaps")

/obj/item/toy/plush/snake
	name = "蛇毛绒玩具"
	desc = "一个可爱的毛绒玩具,外形像一条蛇.别把它当成真的."
	icon_state = "snakeplush"
	worn_icon_state = "snakeplush"
	attack_verb = list("bites", "hisses", "tail slaps")

/obj/item/toy/plush/slime
	name = "史莱姆毛绒玩具"
	desc = "一个可爱的毛绒玩具,外形像一只史莱姆.实际上就是个沙包."
	icon_state = "slimeplush"
	worn_icon_state = "slimeplush"
	attack_verb = list("blorbles", "slimes", "absorbs")

/obj/item/toy/plush/moth
	name = "飞蛾毛绒玩具"
	desc = "一个描绘可爱蛾人的毛绒玩具.是个可以抱的虫子!"
	icon_state = "moffplush"
	worn_icon_state = "moffplush"
	attack_verb = list("flutters", "flaps")

/obj/item/toy/plush/rouny
	name = "rouny毛绒玩具"
	desc = "一个描绘rouny的毛绒玩具,为纪念LV-426战役一百周年而制作.比真家伙柔软可爱多了."
	icon_state = "rounyplush"
	worn_icon_state = "rounyplush"
	attack_verb = list("slashes", "bites", "pounces")

/obj/item/toy/plush/witch
	name = "女巫毛绒玩具"
	desc = "一个描绘可爱女巫的毛绒玩具.它喜欢偷书."
	icon_state = "marisa"
	worn_icon_state = "marisa"

/obj/item/toy/plush/fairy
	name = "妖精毛绒玩具"
	desc = "一个描绘可爱妖精的毛绒玩具.摸起来冰冰凉."
	icon_state = "cirno"
	worn_icon_state = "cirno"

/obj/item/toy/plush/royalqueen
	name = "皇家女王毛绒玩具"
	desc = "一个描绘皇家异形女王的毛绒玩具.隐约有星尘和法棍的气味,标签上写着\"Wee!\"."
	icon_state = "queenplushie"
	worn_icon_state = "queenplushie"
	attack_verb = list("nuzzles", "bops", "pats")
	squeak_sound = 'sound/items/wee.ogg'
	squeak_volume = 20

/obj/item/toy/plush/dragon
	name = "龙毛绒玩具"
	desc = "一个摸起来暖暖的毛绒龙玩偶."
	icon_state = "dragon"
	worn_icon_state = "dragon"
	attack_verb = list("bites", "tail slaps", "pats")

/obj/item/toy/plush/gnome
	name = "地精"
	desc = "一种神话生物,曾守护泰拉的花园.你纳闷它怎么会在这儿."
	icon_state = "gnome"
	worn_icon_state = "gnome"
	attack_verb = list("kickes", "punches", "pounces")
	squeak_sound = 'sound/items/gnome.ogg'

/obj/item/toy/plush/pig
	name = "猪玩具"
	desc = "杰缅季上尉!把猪带来!陆战队员要猪!."
	icon_state = "pig"
	worn_icon_state = "pig"
	attack_verb = list("oinks", "grunts")
	squeak_sound = 'sound/items/khryu.ogg'

/obj/item/toy/plush/pig/attack_self(mob/user)
	if(world.time > last_hug_time)
		user.visible_message(span_notice("[user]按下了[src]! 哼哼!"), \
			span_notice("你按下了[src]. 哼哼!")) // should be a way to decrease copypaste, but no idea how
		last_hug_time = world.time + 5 SECONDS
		playsound(src, squeak_sound, 50)

/obj/item/toy/beach_ball/basketball
	name = "篮球"
	icon_state = "basketball"
	worn_icon_state = "basketball"
	desc = "这是你的机会,在太空大灌篮里跳舞吧."
	w_class = WEIGHT_CLASS_BULKY

/obj/structure/hoop
	name = "篮球框"
	desc = "砰,沙卡拉卡!"
	icon = 'icons/obj/structures/misc.dmi'
	icon_state = "hoop"
	anchored = TRUE
	density = TRUE
	resistance_flags = XENO_DAMAGEABLE
	var/side = ""
	var/id = ""

/obj/structure/hoop/grab_interact(obj/item/grab/grab, mob/user, base_damage = BASE_OBJ_SLAM_DAMAGE, is_sharp = FALSE)
	. = ..()
	if(.)
		return
	if(!isliving(grab.grabbed_thing))
		return
	if(user.a_intent == INTENT_HARM)
		return
	var/mob/living/grabbed_mob = grab.grabbed_thing
	if(user.grab_state <= GRAB_AGGRESSIVE)
		to_chat(user, span_warning("你需要更好的抓握力才能那样做!"))
		return
	grabbed_mob.forceMove(loc)
	grabbed_mob.Paralyze(4 SECONDS)
	for(var/obj/machinery/scoreboard/X in GLOB.machines)
		if(X.id == id)
			X.score(side, 3)// 3 points for dunking a mob
	visible_message(span_danger("[user]把[grabbed_mob]扣进了[src]!"))

/obj/structure/hoop/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(get_dist(src, user) < 2)
		user.transferItemToLoc(I, loc)
		for(var/obj/machinery/scoreboard/X in GLOB.machines)
			if(X.id == id)
				X.score(side)
		visible_message(span_notice("[user]把[I]扣进了[src]!"))

/obj/structure/hoop/CanAllowThrough(atom/movable/mover, turf/target)
	if(istype(mover,/obj/item) && mover.throwing)
		var/obj/item/I = mover
		if(prob(50))
			I.forceMove(loc)
			for(var/obj/machinery/scoreboard/X in GLOB.machines)
				if(X.id == id)
					X.score(side)
					// no break, to update multiple scoreboards
			visible_message(span_notice("唰! \the [I]落入了\the [src]."), 3)
			return TRUE
		visible_message(span_warning("\the [I]从\the [src]的篮筐上弹开了!"), 3)
		return FALSE
	return ..()
