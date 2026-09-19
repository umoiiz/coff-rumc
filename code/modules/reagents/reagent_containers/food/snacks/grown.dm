// ***********************************************************
// Foods that are produced from hydroponics ~~~~~~~~~~
// Data from the seeds carry over to these grown foods
// ***********************************************************

//Grown foods
//Subclass so we can pass on values
/obj/item/reagent_containers/food/snacks/grown
	icon = 'icons/obj/items/harvest.dmi'
	var/plantname
	var/potency = -1

/obj/item/reagent_containers/food/snacks/grown/Initialize(mapload, newpotency)
	. = ..()

	if(!tastes)
		tastes = list("[name]" = 1)
	if (!isnull(newpotency))
		potency = newpotency

	if(!isnull(plantname))
		var/datum/seed/S = GLOB.seed_types[plantname]
		if(!S || !S.chems)
			return

		potency = S.potency

		for(var/rid in S.chems)
			var/list/reagent_data = S.chems[rid]
			var/rtotal = reagent_data[1]
			if(length(reagent_data) > 1 && potency > 0)
				rtotal += round(potency/reagent_data[2])
			if(reagents)
				reagents.add_reagent(rid, max(1, rtotal))

	if(reagents.total_volume > 0)
		bitesize = 1 + round(reagents.total_volume * 0.5, 1)

/obj/item/reagent_containers/food/snacks/grown/corn
	name = "玉米棒"
	desc = "需要加点黄油!"
	plantname = "corn"
	icon_state = "corn"
	potency = 40
	filling_color = "#FFEE00"
	trash = /obj/item/corncob

/obj/item/reagent_containers/food/snacks/grown/cherries
	name = "樱桃"
	desc = "非常适合做配料!"
	icon_state = "cherry"
	filling_color = "#FF0000"
	gender = PLURAL
	plantname = "cherry"

/obj/item/reagent_containers/food/snacks/grown/poppy
	name = "罂粟"
	desc = "长期以来被用作休息、和平与死亡的象征."
	icon_state = "poppy"
	potency = 30
	filling_color = "#CC6464"
	plantname = "poppies"

/obj/item/reagent_containers/food/snacks/grown/harebell
	name = "蓝铃花"
	desc = "\"我会让你的坟墓变得甜美:你不会缺少像你脸庞一样的花朵,苍白的樱草花,也不会缺少像你血管一样蔚蓝的蓝铃花;不,还有野蔷薇的叶子,不诋毁它,它的芬芳也比不上你的气息.\""
	icon_state = "harebell"
	potency = 1
	filling_color = "#D4B2C9"
	plantname = "harebells"

/obj/item/reagent_containers/food/snacks/grown/potato
	name = "土豆"
	desc = "煮了它们!捣碎它们!把它们扔进炖菜里!"
	icon_state = "potato"
	potency = 25
	filling_color = "#E6E8DA"
	plantname = "potato"

/obj/item/reagent_containers/food/snacks/grown/potato/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(iscablecoil(I))
		var/obj/item/stack/cable_coil/C = I
		if(!C.use(5))
			return

		to_chat(user, span_notice("你在土豆上接了一些电线,然后把它滑入电池外壳内."))
		var/obj/item/cell/potato/pocell = new /obj/item/cell/potato(user.loc)
		pocell.maxcharge = potency * 10
		pocell.charge = pocell.maxcharge
		qdel(src)

	else if(istype(I, /obj/item/tool/kitchen/utensil/knife))
		new /obj/item/reagent_containers/food/snacks/rawsticks(src)
		to_chat(user, "你切开了土豆.")
		qdel(src)

/obj/item/reagent_containers/food/snacks/grown/grapes
	name = "一串葡萄"
	desc = "营养丰富!"
	icon_state = "grapes"
	filling_color = "#A332AD"
	plantname = "grapes"

/obj/item/reagent_containers/food/snacks/grown/greengrapes
	name = "一串绿葡萄"
	desc = "营养丰富!"
	icon_state = "greengrapes"
	potency = 25
	filling_color = "#A6FFA3"
	plantname = "greengrapes"

/obj/item/reagent_containers/food/snacks/grown/peanut
	name = "花生"
	desc = "坚果!"
	icon_state = "peanut"
	filling_color = "857e27"
	potency = 25
	plantname = "peanut"

/obj/item/reagent_containers/food/snacks/grown/cabbage
	name = "卷心菜"
	desc = "呕呕呕呕呕呕呕呕呕呕.卷心菜."
	icon_state = "cabbage"
	potency = 25
	filling_color = "#A2B5A1"
	plantname = "cabbage"

/obj/item/reagent_containers/food/snacks/grown/berries
	name = "一串浆果"
	desc = "营养丰富!"
	icon_state = "berrypile"
	filling_color = "#C2C9FF"
	plantname = "berries"

/obj/item/reagent_containers/food/snacks/grown/plastellium
	name = "一团塑胶质"
	desc = "嗯,需要加工一下"
	icon_state = "plastellium"
	filling_color = "#C4C4C4"
	plantname = "plastic"

/obj/item/reagent_containers/food/snacks/grown/glowberries
	name = "一串荧光浆果"
	desc = "营养丰富!"
	var/brightness_on = 2 //luminosity when on
	filling_color = "#D3FF9E"
	icon_state = "glowberrypile"
	plantname = "glowberries"

/obj/item/reagent_containers/food/snacks/grown/cocoapod
	name = "可可荚"
	desc = "可以磨成可可粉."
	icon_state = "cocoapod"
	potency = 50
	filling_color = "#9C8E54"
	plantname = "cocoa"

/obj/item/reagent_containers/food/snacks/grown/sugarcane
	name = "甘蔗"
	desc = "甜得发腻."
	icon_state = "sugarcane"
	potency = 50
	filling_color = "#C0C9AD"
	plantname = "sugarcane"

/obj/item/reagent_containers/food/snacks/grown/poisonberries
	name = "一串毒浆果"
	desc = "味道太好了,吃了可能会死!"
	icon_state = "poisonberrypile"
	gender = PLURAL
	potency = 15
	filling_color = "#B422C7"
	plantname = "poisonberries"

/obj/item/reagent_containers/food/snacks/grown/deathberries
	name = "一串死亡浆果"
	desc = "味道太好了,吃了可能会死!"
	icon_state = "deathberrypile"
	gender = PLURAL
	potency = 50
	filling_color = "#4E0957"
	plantname = "deathberries"

/obj/item/reagent_containers/food/snacks/grown/ambrosiavulgaris
	name = "普通仙草枝"
	desc = "这是一种轻度有毒的植物,含有多种治疗性化学物质."
	icon_state = "ambrosiavulgaris"
	potency = 10
	filling_color = "#125709"
	plantname = "ambrosia"

/obj/item/reagent_containers/food/snacks/grown/ambrosiadeus
	name = "神性仙草枝"
	desc = "这种植物既能刺激你,又能让你入睡.请谨慎使用."
	icon_state = "ambrosiadeus"
	potency = 10
	filling_color = "#229E11"
	plantname = "ambrosiadeus"

/obj/item/reagent_containers/food/snacks/grown/apple
	name = "苹果"
	desc = "它是伊甸园的一小片."
	icon_state = "apple"
	potency = 15
	filling_color = "#DFE88B"
	plantname = "apple"

/obj/item/reagent_containers/food/snacks/grown/apple/poisoned
	name = "苹果"
	desc = "这是伊甸园的一小块。"
	icon_state = "apple"
	potency = 15
	filling_color = "#B3BD5E"
	plantname = "poisonapple"

/obj/item/reagent_containers/food/snacks/grown/goldapple
	name = "金苹果"
	desc = "苹果上刻着'Kallisti'这个词。"
	icon_state = "goldapple"
	potency = 15
	filling_color = "#F5CB42"
	plantname = "goldapple"

/obj/item/reagent_containers/food/snacks/grown/watermelon
	name = "西瓜"
	desc = "它充满了水润的美味。"
	icon_state = "watermelon"
	potency = 10
	filling_color = "#FA2863"
	slice_path = /obj/item/reagent_containers/food/snacks/watermelonslice
	slices_num = 5
	plantname = "watermelon"

/obj/item/reagent_containers/food/snacks/grown/pumpkin
	name = "南瓜"
	desc = "它又大又吓人。"
	icon_state = "pumpkin"
	potency = 10
	filling_color = "#FAB728"
	plantname = "pumpkin"

/obj/item/reagent_containers/food/snacks/grown/pumpkin/attackby(obj/item/I, mob/user, param)
	. = ..()
	if(.)
		return

	if(I.sharp == IS_SHARP_ITEM_ACCURATE || I.sharp == IS_SHARP_ITEM_BIG)
		to_chat(user, span_notice("你在[src]上刻了一张脸！"))
		new /obj/item/clothing/head/pumpkinhead(user.loc)
		qdel(src)

/obj/item/reagent_containers/food/snacks/grown/lime
	name = "青柠"
	desc = "它太酸了,你的脸都会扭曲。"
	icon_state = "lime"
	potency = 20
	filling_color = "#28FA59"
	plantname = "lime"

/obj/item/reagent_containers/food/snacks/grown/lemon
	name = "柠檬"
	desc = "当生活给你柠檬时,庆幸它们不是青柠。"
	icon_state = "lemon"
	potency = 20
	filling_color = "#FAF328"
	plantname = "lemon"

/obj/item/reagent_containers/food/snacks/grown/orange
	name = "橙子"
	desc = "它是一种酸甜的水果。"
	icon_state = "orange"
	potency = 20
	filling_color = "#FAAD28"
	plantname = "orange"

/obj/item/reagent_containers/food/snacks/grown/whitebeet
	name = "白甜菜"
	desc = "你打不败白甜菜。"
	icon_state = "whitebeet"
	potency = 15
	filling_color = "#FFFCCC"
	plantname = "whitebeet"

/obj/item/reagent_containers/food/snacks/grown/banana
	name = "香蕉"
	desc = "它是喜剧的绝佳道具。"
	icon_state = "banana"
	worn_icon_state = "banana"
	filling_color = "#FCF695"
	trash = /obj/item/bananapeel
	plantname = "banana"

/obj/item/reagent_containers/food/snacks/grown/chili
	name = "辣椒"
	desc = "它好辣！等等...它烧到我了！！"
	icon_state = "chilipepper"
	filling_color = "#FF0000"
	plantname = "chili"

/obj/item/reagent_containers/food/snacks/grown/eggplant
	name = "茄子"
	desc = "也许里面有一只鸡？"
	icon_state = "eggplant"
	filling_color = "#550F5C"
	plantname = "eggplant"

/obj/item/reagent_containers/food/snacks/grown/soybeans
	name = "大豆"
	desc = "它相当平淡,但哦,可能性无限..."
	gender = PLURAL
	filling_color = "#E6E8B7"
	icon_state = "soybeans"
	plantname = "soybean"

/obj/item/reagent_containers/food/snacks/grown/tomato
	name = "番茄"
	desc = "我说to-mah-to,你说tom-mae-to。"
	icon_state = "tomato"
	filling_color = "#FF0000"
	potency = 10
	plantname = "tomato"

/obj/item/reagent_containers/food/snacks/grown/tomato/throw_impact(atom/hit_atom)
	. = ..()
	if(!.)
		return
	new/obj/effect/decal/cleanable/tomato_smudge(src.loc)
	src.visible_message(span_notice("[src.name]被压扁了。"),span_moderate("你听到一声拍击。"))
	qdel(src)

/obj/item/reagent_containers/food/snacks/grown/killertomato
	name = "杀手番茄"
	desc = "我说to-mah-to,你说tom-mae-to...天啊它在吃我的腿！！"
	icon_state = "killertomato"
	potency = 10
	filling_color = "#FF0000"
	potency = 30
	plantname = "killertomato"

/obj/item/reagent_containers/food/snacks/grown/bloodtomato
	name = "血番茄"
	desc = "好血腥...好...非常...血腥....啊啊啊！！！！"
	icon_state = "bloodtomato"
	potency = 10
	filling_color = "#FF0000"
	plantname = "bloodtomato"

/obj/item/reagent_containers/food/snacks/grown/bloodtomato/throw_impact(atom/hit_atom)
	. = ..()
	if(!.)
		return
	new/obj/effect/decal/cleanable/blood/splatter(src.loc)
	src.visible_message(span_notice("[src.name]被压扁了。"),span_moderate("你听到一声拍击。"))
	src.reagents.reaction(get_turf(hit_atom))
	for(var/atom/A in get_turf(hit_atom))
		src.reagents.reaction(A)
	qdel(src)

/obj/item/reagent_containers/food/snacks/grown/bluetomato
	name = "蓝番茄"
	desc = "我说blue-mah-to,你说blue-mae-to。"
	icon_state = "bluetomato"
	potency = 10
	filling_color = "#586CFC"
	plantname = "bluetomato"

/obj/item/reagent_containers/food/snacks/grown/bluetomato/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, 0.8 SECONDS, 0.5 SECONDS)

/obj/item/reagent_containers/food/snacks/grown/bluetomato/throw_impact(atom/hit_atom)
	. = ..()
	if(!.)
		return
	new/obj/effect/decal/cleanable/blood/oil(src.loc)
	src.visible_message(span_notice("[src.name]被压扁了。"),span_moderate("你听到一声拍击。"))
	src.reagents.reaction(get_turf(hit_atom))
	for(var/atom/A in get_turf(hit_atom))
		src.reagents.reaction(A)
	qdel(src)

/obj/item/reagent_containers/food/snacks/grown/wheat
	name = "小麦"
	desc = "唉...小麦...一粒谷？"
	gender = PLURAL
	icon_state = "wheat"
	filling_color = "#F7E186"
	plantname = "wheat"

/obj/item/reagent_containers/food/snacks/grown/ricestalk
	name = "稻秆"
	desc = "很高兴见到你。"
	gender = PLURAL
	icon_state = "rice"
	filling_color = "#FFF8DB"
	plantname = "rice"

/obj/item/reagent_containers/food/snacks/grown/kudzupod
	name = "葛藤荚"
	desc = "<I>Pueraria Virallis</I>:一种入侵物种,其藤蔓会迅速蔓延并缠绕任何接触到的物体。"
	icon_state = "kudzupod"
	filling_color = "#59691B"
	plantname = "kudzu"

/obj/item/reagent_containers/food/snacks/grown/icepepper
	name = "冰辣椒"
	desc = "它是辣椒的突变品种"
	icon_state = "icepepper"
	potency = 20
	filling_color = "#66CEED"
	plantname = "icechili"

/obj/item/reagent_containers/food/snacks/grown/carrot
	name = "胡萝卜"
	desc = "它对眼睛有好处！"
	icon_state = "carrot"
	potency = 10
	filling_color = "#FFC400"
	plantname = "carrot"

/obj/item/reagent_containers/food/snacks/grown/mushroom/reishi
	name = "灵芝"
	desc = "<I>Ganoderma lucidum</I>:一种被认为有助于缓解压力的特殊真菌。"
	icon_state = "reishi"
	potency = 10
	filling_color = "#FF4800"
	plantname = "reishi"

/obj/item/reagent_containers/food/snacks/grown/mushroom/amanita
	name = "毒蝇伞"
	desc = "<I>Amanita Muscaria</I>:用心记住毒蘑菇。只采摘你认识的蘑菇。"
	icon_state = "amanita"
	potency = 10
	filling_color = "#FF0000"
	plantname = "amanita"

/obj/item/reagent_containers/food/snacks/grown/mushroom/angel
	name = "毁灭天使"
	desc = "<I>Amanita Virosa</I>:充满α鹅膏毒肽的致命毒担子菌真菌。"
	icon_state = "angel"
	potency = 35
	filling_color = "#FFDEDE"
	plantname = "destroyingangel"

/obj/item/reagent_containers/food/snacks/grown/mushroom/libertycap
	name = " Liberty帽"
	desc = "<I>Psilocybe Semilanceata</I>:解放你自己！"
	icon_state = "libertycap"
	potency = 15
	filling_color = "#F714BE"
	plantname = "libertycap"

/obj/item/reagent_containers/food/snacks/grown/mushroom/plumphelmet
	name = "肥硕头盔"
	desc = "<I>Plumus Hellmus</I>:肥硕、柔软且如此诱人~"
	icon_state = "plumphelmet"
	filling_color = "#F714BE"
	plantname = "plumphelmet"

/obj/item/reagent_containers/food/snacks/grown/mushroom/walkingmushroom
	name = "行走蘑菇"
	desc = "<I>Plumus Locomotus</I>:伟大行走的开端。"
	icon_state = "walkingmushroom"
	filling_color = "#FFBFEF"
	potency = 30
	plantname = "walkingmushroom"

/obj/item/reagent_containers/food/snacks/grown/mushroom/chanterelle
	name = "鸡油菌簇"
	desc = "<I>鸡油菌</I>: 这些快活的黄色小蘑菇看起来真美味!"
	icon_state = "chanterelle"
	filling_color = "#FFE991"
	plantname = "mushrooms"

/obj/item/reagent_containers/food/snacks/grown/mushroom/glowshroom
	name = "发光蘑菇簇"
	desc = "<I>发光小菇</I>: 这种蘑菇在黑暗中会发光. 真的吗?"
	icon_state = "glowshroom"
	filling_color = "#DAFF91"
	potency = 30
	plantname = "glowshroom"

/obj/item/reagent_containers/food/snacks/grown/mushroom/glowshroom/attack_self(mob/user as mob)
	if(isspaceturf(user.loc))
		return
	var/obj/structure/glowshroom/planted = new /obj/structure/glowshroom(user.loc)

	planted.delay = 50
	planted.endurance = 100
	planted.potency = potency
	qdel(src)

	to_chat(user, span_notice("你种下了发光蘑菇."))

// *************************************
// Complex Grown Object Defines -
// Putting these at the bottom so they don't clutter the list up. -Cheridan
// *************************************

/obj/item/reagent_containers/food/snacks/grown/bluespacetomato
	name = "蓝空间番茄"
	desc = "如此润滑, 你可能会滑过时空."
	icon_state = "bluespacetomato"
	potency = 20
	filling_color = "#91F8FF"
	plantname = "bluespacetomato"

/obj/item/reagent_containers/food/snacks/grown/bluespacetomato/throw_impact(atom/hit_atom)
	. = ..()
	if(!.)
		return
	var/mob/M = usr
	var/outer_teleport_radius = potency / 10 //Plant potency determines radius of teleport.
	var/inner_teleport_radius = potency / 15
	var/list/turfs = list()
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	if(inner_teleport_radius < 1) //Wasn't potent enough, it just splats.
		new/obj/effect/decal/cleanable/blood/oil(loc)
		visible_message(span_notice("[name]被压扁了."), span_moderate("你听到啪的一声."))
		qdel(src)
		return
	for(var/turf/T in orange(M,outer_teleport_radius))
		if(T in orange(M,inner_teleport_radius)) continue
		if(istype(T,/turf/open/space)) continue
		if(T.density) continue
		if(T.x > world.maxx-outer_teleport_radius || T.x < outer_teleport_radius)	continue
		if(T.y > world.maxy-outer_teleport_radius || T.y < outer_teleport_radius)	continue
		turfs += T
	if(!length(turfs))
		var/list/turfs_to_pick_from = list()
		for(var/turf/T in orange(M,outer_teleport_radius))
			if(!(T in orange(M,inner_teleport_radius)))
				turfs_to_pick_from += T
		turfs += pick(/turf in turfs_to_pick_from)
	var/turf/picked = pick(turfs)
	if(!isturf(picked)) return
	switch(rand(1,2))//Decides randomly to teleport the thrower or the throwee.
		if(1) // Teleports the person who threw the tomato.
			s.set_up(3, 1, M)
			s.start()
			new/obj/effect/decal/cleanable/molten_item(M.loc) //Leaves a pile of goo behind for dramatic effect.
			M.loc = picked //
			s.set_up(3, 1, M)
			s.start() //Two set of sparks, one before the teleport and one after.
		if(2) //Teleports mob the tomato hit instead.
			for(var/mob/A in get_turf(hit_atom))//For the mobs in the tile that was hit...
				s.set_up(3, 1, A)
				s.start()
				new/obj/effect/decal/cleanable/molten_item(A.loc) //Leave a pile of goo behind for dramatic effect...
				A.loc = picked//And teleport them to the chosen location.
				s.set_up(3, 1, A)
				s.start()
	new/obj/effect/decal/cleanable/blood/oil(loc)
	visible_message(span_notice("[name]被压扁了, 造成了时空扭曲."), span_moderate("你听到啪叽一声和噼啪声."))
	qdel(src)

