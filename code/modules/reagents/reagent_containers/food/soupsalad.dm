//Food items that are eaten normally and don't leave anything behind.
/obj/item/reagent_containers/food/snacks/soup
	name = "零食"
	desc = "好吃"
	icon = 'icons/obj/items/food/soupsalad.dmi'
	icon_state = null

/obj/item/reagent_containers/food/snacks/soup/wishsoup
	name = "许愿汤"
	desc = "我希望这是汤."
	icon_state = "wishsoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#D1F4FF"
	list_reagents = list(/datum/reagent/water = 10)
	bitesize = 5
	tastes = list("wishes" = 1)

/obj/item/reagent_containers/food/snacks/soup/wishsoup/Initialize(mapload)
	. = ..()
	var/wish_true = prob(25)
	if(wish_true)
		desc = "A wish come true!"
		reagents.add_reagent(/datum/reagent/consumable/nutriment, 9)
		reagents.add_reagent(/datum/reagent/consumable/nutriment/vitamin, 1)

/obj/item/reagent_containers/food/snacks/soup/meatballsoup
	name = "肉丸汤"
	desc = "你小子有胆,有胆!"
	icon_state = "meatballsoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#785210"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/tomatojuice = 3)
	bitesize = 5
	tastes = list("meat" = 1)

/obj/item/reagent_containers/food/snacks/soup/slime
	name = "史莱姆汤"
	desc = "如果没有水,你可以用眼泪代替."
	icon_state = "slimesoup"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 9, /datum/reagent/water = 5)
	tastes = list("slime" = 1)

/obj/item/reagent_containers/food/snacks/soup/bloodsoup
	name = "番茄汤"
	desc = "闻起来像铜"
	icon_state = "tomatosoup"
	filling_color = "#FF0000"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/blood = 10, /datum/reagent/water= 5)
	bitesize = 5
	tastes = list("iron" = 1)

/obj/item/reagent_containers/food/snacks/soup/wingfangchu
	name = "翼方珠"
	desc = "一道用外星翅膀肉配酱油烹制的美味佳肴."
	icon_state = "wingfangchu"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#43DE18"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("soy" = 1)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/soup/clownstears
	name = "小丑的眼泪"
	desc = "不太好笑了."
	icon_state = "clownstears"
	filling_color = "#C4FBFF"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/banana = 5, /datum/reagent/water = 10)
	bitesize = 5
	tastes = list("a bad joke" = 1)

/obj/item/reagent_containers/food/snacks/soup/vegetablesoup
	name = "蔬菜汤"
	desc = "真正的纯素餐" //TODO
	icon_state = "vegetablesoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#AFC4B5"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/water = 5)
	bitesize = 5
	tastes = list("vegetables" = 1)

/obj/item/reagent_containers/food/snacks/soup/nettlesoup
	name = "荨麻汤"
	desc = "想想看,植物学家本来可以用这玩意儿把你打死。"
	icon_state = "nettlesoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#AFC4B5"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/water = 5, /datum/reagent/medicine/tricordrazine = 5)
	bitesize = 5
	tastes = list("nettles" = 1)

/obj/item/reagent_containers/food/snacks/soup/mysterysoup
	name = "神秘汤"
	desc = "神秘之处在于,你为什么还不喝?"
	icon_state = "mysterysoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#F082FF"
	bitesize = 5
	tastes = list("chaos" = 1)

/obj/item/reagent_containers/food/snacks/soup/mysterysoup/Initialize(mapload)
	. = ..()
	var/mysteryselect = pick(1,2,3,4,5,6,7,8,9)
	switch(mysteryselect)
		if(1)
			reagents.add_reagent(/datum/reagent/consumable/nutriment, 6)
			reagents.add_reagent(/datum/reagent/consumable/capsaicin, 3)
			reagents.add_reagent(/datum/reagent/consumable/tomatojuice, 2)
		if(2)
			reagents.add_reagent(/datum/reagent/consumable/nutriment, 6)
			reagents.add_reagent(/datum/reagent/consumable/frostoil, 3)
			reagents.add_reagent(/datum/reagent/consumable/tomatojuice, 2)
		if(3)
			reagents.add_reagent(/datum/reagent/consumable/nutriment, 5)
			reagents.add_reagent(/datum/reagent/water, 5)
			reagents.add_reagent(/datum/reagent/medicine/tricordrazine, 5)
		if(4)
			reagents.add_reagent(/datum/reagent/consumable/nutriment, 5)
			reagents.add_reagent(/datum/reagent/water, 10)
		if(5)
			reagents.add_reagent(/datum/reagent/consumable/nutriment, 2)
			reagents.add_reagent(/datum/reagent/consumable/banana,, 10)
		if(6)
			reagents.add_reagent(/datum/reagent/consumable/nutriment, 6)
			reagents.add_reagent(/datum/reagent/blood, 10)
		if(7)
			reagents.add_reagent(/datum/reagent/carbon, 10)
			reagents.add_reagent(/datum/reagent/toxin, 10)
		if(8)
			reagents.add_reagent(/datum/reagent/consumable/nutriment, 5)
			reagents.add_reagent(/datum/reagent/consumable/tomatojuice, 10)
		if(9)
			reagents.add_reagent(/datum/reagent/consumable/nutriment, 6)
			reagents.add_reagent(/datum/reagent/consumable/tomatojuice, 5)
			reagents.add_reagent(/datum/reagent/medicine/imidazoline, 5)
/obj/item/reagent_containers/food/snacks/soup/hotchili
	name = "辣味辣椒"
	desc = "五级警报的德克萨斯辣椒!"
	icon_state = "hotchili"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#FF3C00"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/capsaicin = 3)
	bitesize = 5
	tastes = list("hot peppers" = 1)

/obj/item/reagent_containers/food/snacks/soup/coldchili
	name = "冷辣椒"
	desc = "这摊泥浆勉强算液体!"
	icon_state = "coldchili"
	filling_color = "#2B00FF"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/frostoil = 3)
	trash = /obj/item/trash/snack_bowl
	bitesize = 5
	tastes = list("tomato" = 1, "mint" = 1)

/obj/item/reagent_containers/food/snacks/soup/larvasoup
	name = "幼虫汤"
	desc = "液化的幼虫。"
	icon_state = "larvasoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#66801e"
	list_reagents = list(/datum/reagent/consumable/larvajellyprepared = 1, /datum/reagent/consumable/nutriment = 4)
	bitesize = 5
	tastes = list("burning" = 1)

/obj/item/reagent_containers/food/snacks/soup/clownchili
	name = "狂欢辣椒炖"
	desc = "一锅美味的炖肉,辣椒,还有咸咸的小丑眼泪。"
	icon_state = "clownchili"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/capsaicin = 1, /datum/reagent/consumable/tomatojuice = 4, /datum/reagent/consumable/nutriment/vitamin = 4, /datum/reagent/consumable/banana = 1, /datum/reagent/consumable/laughter = 1)
	tastes = list("tomato" = 1, "hot peppers" = 2, "clown feet" = 2, "kind of funny" = 2, "someone's parents" = 2)

/obj/item/reagent_containers/food/snacks/soup/monkeysdelight
	name = "猴子乐"
	desc = "一碗美味的汤,里面有饺子和炖到完美的猴肉块,汤底隐约有香蕉味。"
	icon_state = "monkeysdelight"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3,  /datum/reagent/consumable/nutriment/protein = 9, /datum/reagent/consumable/banana = 5, /datum/reagent/consumable/nutriment/vitamin = 10)
	tastes = list("the jungle" = 1, "banana" = 1)

/obj/item/reagent_containers/food/snacks/soup/tomatosoup
	name = "番茄汤"
	desc = "喝这个感觉像吸血鬼!一个番茄吸血鬼..."
	icon_state = "tomatosoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#D92929"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/tomatojuice = 10)
	bitesize = 3
	tastes = list("tomato" = 1)

/obj/item/reagent_containers/food/snacks/soup/eyeball
	name = "眼球汤"
	desc = "它正回望着你..."
	icon_state = "eyeballsoup"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/tomatojuice = 10, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("tomato" = 1, "squirming" = 1)

/obj/item/reagent_containers/food/snacks/soup/miso
	name = "味噌汤"
	desc = "宇宙最好的汤!好吃!!!"
	icon_state = "misosoup"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/protein = 8, /datum/reagent/water = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("miso" = 1)

/obj/item/reagent_containers/food/snacks/soup/mushroomsoup
	name = "鸡油菌汤"
	desc = "一碗美味又丰盛的蘑菇汤。"
	icon_state = "mushroomsoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#E386BF"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	bitesize = 3
	tastes = list("mushroom" = 1)

/obj/item/reagent_containers/food/snacks/soup/beetsoup
	name = "甜菜汤"
	desc = "等等,这词怎么拼来着..?"
	icon_state = "beetsoup"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#FAC9FF"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("tasteless soup" = 1)

/obj/item/reagent_containers/food/snacks/soup/beetsoup/Initialize(mapload)
	. = ..()
	name = pick("borsch","bortsch","borstch","borsh","borshch","borscht")
	tastes = list(name = 1)

/obj/item/reagent_containers/food/snacks/soup/spacylibertyduff
	name = "太空自由冻"
	desc = "果冻明胶,出自阿尔弗雷德·哈伯德的食谱"
	icon_state = "spacylibertyduff"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#42B873"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/psilocybin = 6)
	bitesize = 3
	tastes = list("jelly" = 1, "mushroom" = 1)

/obj/item/reagent_containers/food/snacks/soup/amanitajelly
	name = "毒蝇伞果冻"
	desc = "看起来有毒得令人好奇"
	icon_state = "amanitajelly"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#ED0758"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/toxin/amatoxin = 6, /datum/reagent/consumable/psilocybin = 3)
	bitesize = 3
	tastes = list("jelly" = 1, "mushroom" = 1)

/obj/item/reagent_containers/food/snacks/soup/stew
	name = "炖菜"
	desc = "一碗温暖的好炖菜。健康又强壮。"
	icon_state = "stew"
	filling_color = "#9E673A"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/tomatojuice = 5, /datum/reagent/consumable/carrotjuice = 5, /datum/reagent/water = 5)
	bitesize = 7
	volume = 100
	tastes = list("tomato" = 1, "carrot" = 1)

/obj/item/reagent_containers/food/snacks/soup/sweetpotato
	name = "红薯汤"
	desc = "以汤的形式呈现的美味红薯。"
	icon_state = "sweetpotatosoup"
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/water = 5, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("sweet potato" = 1)

/obj/item/reagent_containers/food/snacks/soup/beetsoup/red
	name = "红甜菜汤"
	desc = "相当的美味佳肴。"
	icon_state = "redbeetsoup"
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/water = 5, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("beet" = 1)

/obj/item/reagent_containers/food/snacks/soup/onion
	name = "法式洋葱汤"
	desc = "好喝到能让成年哑剧演员落泪。"
	icon_state = "onionsoup"
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/protein = 8, /datum/reagent/consumable/tomatojuice = 8, /datum/reagent/consumable/nutriment/vitamin = 5)

/obj/item/reagent_containers/food/snacks/soup/bisque
	name = "浓汤"
	desc = "来自太空法国的经典主菜。"
	icon_state = "bisque"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/water = 5, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("creamy texture" = 1, "crab" = 4)

/obj/item/reagent_containers/food/snacks/soup/electron
	name = "电子汤"
	desc = "一种源自以太的烹饪奇观。它以在精心烹制的汤上形成微型天气系统而闻名。"
	icon_state = "electronsoup"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	tastes = list("mushroom" = 1, "electrons" = 4)

/obj/item/reagent_containers/food/snacks/soup/bungocurry
	name = "邦戈咖喱"
	desc = "用不起眼的邦戈果制成的辣味蔬菜咖喱,异域风情!"
	icon_state = "bungocurry"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/capsaicin = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("bungo" = 2, "hot curry" = 4, "tropical sweetness" = 1)

/obj/item/reagent_containers/food/snacks/soup/mammi
	name = "玛米"
	desc = "一碗糊状的面包和牛奶。它让你不太愉快地想起排便。"
	icon_state = "mammi"
	list_reagents = list(/datum/reagent/consumable/nutriment = 11, /datum/reagent/consumable/nutriment/vitamin = 2)

/obj/item/reagent_containers/food/snacks/soup/peasoup
	name = "豌豆汤"
	desc = "一碗朴素的豌豆瓣汤。"
	icon_state = "peasoup"
	list_reagents = list (/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("creamy peas"= 2, "parsnip" = 1)

/obj/item/reagent_containers/food/snacks/soup/indian_curry
	name = "印度咖喱鸡"
	desc = "来自古老次大陆的温和奶油咖喱。太空英国人喜欢它,因为它让他们想起英属印度。"
	icon_state = "indian_curry"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/capsaicin = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("chicken" = 2, "creamy curry" = 4, "earthy heat" = 1)

/obj/item/reagent_containers/food/snacks/soup/oatmeal
	name = "燕麦粥"
	desc = "一碗美味的燕麦粥。"
	icon_state = "oatmeal"
	list_reagents = list(/datum/reagent/consumable/nutriment = 11, /datum/reagent/consumable/milk = 10, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("oats" = 1, "milk" = 1)

/obj/item/reagent_containers/food/snacks/soup/zurek
	name = "茹雷克"
	desc = "一种传统的波兰汤,由蔬菜、肉和鸡蛋组成。配面包绝佳。"
	icon_state = "zurek"
	list_reagents = list (/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("creamy vegetables"= 2, "sausage" = 1)

/obj/item/reagent_containers/food/snacks/soup/milosoup
	name = "米洛汤"
	desc = "宇宙最好的汤!好吃!!!"
	icon_state = "milosoup"
	trash = /obj/item/trash/snack_bowl
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/water = 5)
	bitesize = 4
	tastes = list("miso" = 1)

/obj/item/reagent_containers/food/snacks/soup/aesirsalad
	name = "埃西尔沙拉"
	desc = "大概太不可思议了,凡人无法完全享受。"
	icon_state = "aesirsalad"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#468C00"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/doctor_delight = 8, /datum/reagent/medicine/tricordrazine = 8)
	bitesize = 3
	tastes = list("leaves" = 1)

/obj/item/reagent_containers/food/snacks/soup/ricepudding
	name = "米布丁"
	desc = "果酱呢!"
	icon_state = "rpudding"
	icon = 'icons/obj/items/food/soupsalad.dmi'
	trash = /obj/item/trash/snack_bowl
	filling_color = "#FFFBDB"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	bitesize = 2
	tastes = list("rice" = 1, "sweetness" = 1)

/obj/item/reagent_containers/food/snacks/soup/boiledrice
	name = "白米饭"
	desc = "一盘无聊的无聊米饭。"
	icon_state = "boiledrice"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#FFFBDB"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bitesize = 2
	tastes = list("rice" = 1)

/obj/item/reagent_containers/food/snacks/soup/jellyfish
	name = "海蜇炖菜"
	desc = "一碗黏糊糊的海蜇炖菜。摇一摇它会晃。"
	icon_state = "jellyfish_stew"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 10, /datum/reagent/consumable/nutriment = 6)
	tastes = list("slime" = 1)

/obj/item/reagent_containers/food/snacks/soup/rootbread_soup
	name = "根面包汤"
	desc = "一大碗用根面包做的辣味咸香汤。调味很重,非常好吃。"
	icon_state = "rootbread_soup"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("bread" = 1, "egg" = 1, "chili" = 1, "garlic" = 1)

/obj/item/reagent_containers/food/snacks/soup/black_broth
	name = "\improper 提兹兰黑汤"
	desc = "一碗香肠、洋葱、血和醋,冰镇供应。和听起来一样粗犷。"
	icon_state = "black_broth"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 10, /datum/reagent/blood = 8)
	tastes = list("vinegar" = 1, "metal" = 1)

/obj/item/reagent_containers/food/snacks/soup/meatball_noodles
	name = "肉丸面汤"
	desc = "一碗用浓郁汤底和肉丸做成的丰盛面汤。"
	icon_state = "meatball_noodles"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/protein = 8, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/water = 5)
	tastes = list("bone broth" = 1, "meat" = 1, "gnocchi" = 1, "peanuts" = 1)

/obj/item/reagent_containers/food/snacks/soup/atrakor_dumplings
	name = "\improper 阿特拉科尔饺子汤"
	desc = "一碗浓郁的肉馅饺子汤。"
	icon_state = "atrakor_dumplings"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/protein = 10, /datum/reagent/consumable/nutriment/vitamin = 4, /datum/reagent/water = 5)
	tastes = list("bone broth" = 1, "onion" = 1, "potato" = 1)

/obj/item/reagent_containers/food/snacks/soup/shredded_lungs
	name = "香酥肺丝炒"
	desc = "香酥肺丝,配蔬菜和辣酱。如果你喜欢肺,那很美味。"
	icon_state = "lung_stirfry"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 4, /datum/reagent/consumable/capsaicin = 2)
	tastes = list("meat" = 1, "heat" = 1, "veggies" = 1)

/obj/item/reagent_containers/food/snacks/soup/lizard_escargot
	name = "沙漠蜗牛科克利亚斯"
	desc = "蜥蜴与人类文化交融的一个非常小众的例子,蜥蜴蜗牛是自然取自完全顺从的蜥蜴人."
	icon_state = "lizard_escargot"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("snails" = 1, "garlic" = 1, "oil" = 1)

/obj/item/reagent_containers/food/snacks/soup/rice_porridge
	name = "米粥"
	desc = "一盘米粥.它基本没什么味道,但确实能填饱肚子." //höllflöfmiskl = rice (höllflöf = cloud, miskl = seed), sløsk = porridge
	icon = 'icons/obj/items/food/soupsalad.dmi'
	icon_state = "rice_porridge"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 8)
	tastes = list("nothing" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/hua_mulan_congee
	name = "\improper 花木兰粥"
	desc = "没人十分确定为什么这碗放着鸡蛋和培根的笑脸米粥会以一个中国神话人物命名--它只是一直以来都这么叫而已."
	icon_state = "hua_mulan_congee"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 10, /datum/reagent/consumable/nutriment/protein = 6)
	tastes = list("bacon" = 1, "eggs" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/cornmeal_porridge
	name = "玉米粥"
	desc = "一盘玉米粥.它比大多数粥更有味道,也很适合作为其他风味的基础."
	icon_state = "cornmeal_porridge"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("cornmeal" = 1)

/obj/item/reagent_containers/food/snacks/soup/cheesy_porridge //milk, polenta, firm cheese, curd cheese, butter
	name = "芝士粥"
	desc = "一碗浓郁顺滑的芝士玉米粥."
	icon_state = "cheesy_porridge"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 8, /datum/reagent/consumable/nutriment/vitamin = 4, /datum/reagent/consumable/nutriment = 8)
	tastes = list("cornmeal" = 1, "cheese" = 1, "more cheese" = 1, "lots of cheese" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/red_porridge
	name = "红色粥"
	desc = "配酸奶的红色粥.这名字和蔬菜配料掩盖了这道菜的甜味本质,它在舰队上通常作为甜点供应."
	icon = 'icons/obj/items/food/soupsalad.dmi'
	icon_state = "red_porridge"
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 8, /datum/reagent/consumable/nutriment/protein = 8, /datum/reagent/consumable/sugar = 8)
	tastes = list("sweet beets" = 1, "sugar" = 1, "sweetened yoghurt" = 1)
