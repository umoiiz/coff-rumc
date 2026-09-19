//Food items that are eaten normally and don't leave anything behind.
/obj/item/reagent_containers/food/snacks/pastries
	name = "零食"
	desc = "好吃"
	icon = 'icons/obj/items/food/piecake.dmi'
	icon_state = null

/obj/item/reagent_containers/food/snacks/sliceable/pastries
	name = "零食"
	desc = "好吃"
	icon = 'icons/obj/items/food/piecake.dmi'
	icon_state = null

/obj/item/reagent_containers/food/snacks/pastries/pie
	name = "香蕉奶油派"
	desc = "就像回到家乡一样,在克劳恩星球上! HONK!"
	icon_state = "pie"
	trash = /obj/item/trash/plate
	filling_color = "#FBFFB8"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/banana = 5)
	tastes = list("pie" = 1)
	bitesize = 3

/obj/item/reagent_containers/food/snacks/pastries/pie/throw_impact(atom/hit_atom)
	. = ..()
	if(!.)
		return
	new /obj/effect/decal/cleanable/pie_smudge(loc)
	visible_message(span_warning("[src.name] 啪的一声。"),span_warning("你听到啪的一声。"))
	qdel(src)

/obj/item/reagent_containers/food/snacks/pastries/berryclafoutis
	name = "浆果克拉芙缇"
	desc = "没有黑鸟,这是个好兆头。"
	icon_state = "berryclafoutis"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/berryjuice = 5)
	tastes = list("pie" = 1, "blackberries" = 1)
	bitesize = 3

/obj/item/reagent_containers/food/snacks/pastries/bearypie
	name = "熊莓派"
	desc = "没有棕熊,这是个好兆头。"
	icon_state = "bearypie"
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/nutriment/protein = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("pie" = 1, "meat" = 1, "salmon" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/carrotcake
	name = "胡萝卜蛋糕"
	desc = "某只狡猾兔子的最爱甜点。不是谎话。"
	icon_state = "carrotcake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/carrotcakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 25, /datum/reagent/consumable/carrotjuice = 10)
	filling_color = "#FFD675"
	tastes = list("cake" = 5, "sweetness" = 2, "carrot" = 1)

/obj/item/reagent_containers/food/snacks/pastries/carrotcakeslice
	name = "胡萝卜蛋糕切片"
	desc = "胡萝卜味的胡萝卜蛋糕切片,胡萝卜对眼睛好!也不是谎话。"
	icon_state = "carrotcake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#FFD675"
	bitesize = 2
	tastes = list("cake" = 5, "sweetness" = 2, "carrot" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/braincake
	name = "脑蛋糕"
	desc = "一个软乎乎的蛋糕状物体。"
	icon_state = "braincake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/braincakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 25, /datum/reagent/medicine/alkysine = 10)
	filling_color = "#E6AEDB"
	tastes = list("cake" = 5, "sweetness" = 2, "brains" = 1)

/obj/item/reagent_containers/food/snacks/pastries/braincakeslice
	name = "脑蛋糕切片"
	desc = "让我给你讲讲朊病毒的事。它们很好吃。"
	icon_state = "braincakeslice"
	trash = /obj/item/trash/plate
	filling_color = "#E6AEDB"
	bitesize = 2
	tastes = list("cake" = 5, "sweetness" = 2, "brains" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/cheesecake
	name = "奶酪蛋糕"
	desc = "危险地多奶酪。"
	icon_state = "cheesecake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/cheesecakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 25)
	filling_color = "#FAF7AF"
	tastes = list("cake" = 4, "cream cheese" = 3)

/obj/item/reagent_containers/food/snacks/pastries/cheesecakeslice
	name = "奶酪蛋糕切片"
	desc = "一片纯粹的奶酪满足感"
	icon_state = "cheesecake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#FAF7AF"
	bitesize = 2
	tastes = list("cake" = 4, "cream cheese" = 3)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/plaincake
	name = "香草蛋糕"
	desc = "一个普通的蛋糕,不是谎话。"
	icon_state = "plaincake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/plaincakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	filling_color = "#F7EDD5"
	tastes = list("vanilla" = 1, "sweetness" = 2,"cake" = 5)

/obj/item/reagent_containers/food/snacks/pastries/plaincakeslice
	name = "香草蛋糕切片"
	desc = "就是一片蛋糕,足够每个人吃。"
	icon_state = "plaincake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#F7EDD5"
	bitesize = 2
	tastes = list("vanilla" = 1, "sweetness" = 2,"cake" = 5)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/orangecake
	name = "橙子蛋糕"
	desc = "加了橙子的蛋糕。"
	icon_state = "orangecake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/orangecakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	filling_color = "#FADA8E"
	tastes = list("cake" = 5, "sweetness" = 2, "oranges" = 2)

/obj/item/reagent_containers/food/snacks/pastries/orangecakeslice
	name = "橙子蛋糕切片"
	desc = "就是一片蛋糕,足够每个人吃。"
	icon_state = "orangecake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#FADA8E"
	bitesize = 2
	tastes = list("cake" = 5, "sweetness" = 2, "oranges" = 2)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/limecake
	name = "青柠蛋糕"
	desc = "加了青柠的蛋糕。"
	icon_state = "limecake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/limecakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	filling_color = "#CBFA8E"
	tastes = list("cake" = 5, "sweetness" = 2, "unbearable sourness" = 2)

/obj/item/reagent_containers/food/snacks/pastries/limecakeslice
	name = "青柠蛋糕切片"
	desc = "就是一片蛋糕,足够每个人吃。"
	icon_state = "limecake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#CBFA8E"
	bitesize = 2
	tastes = list("cake" = 5, "sweetness" = 2, "unbearable sourness" = 2)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/lemoncake
	name = "柠檬蛋糕"
	desc = "加了柠檬的蛋糕。"
	icon_state = "lemoncake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/lemoncakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	filling_color = "#FAFA8E"
	tastes = list("cake" = 5, "sweetness" = 2, "sourness" = 2)

/obj/item/reagent_containers/food/snacks/pastries/lemoncakeslice
	name = "柠檬蛋糕切片"
	desc = "就是一片蛋糕,足够每个人吃。"
	icon_state = "lemoncake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#FAFA8E"
	bitesize = 2
	tastes = list("cake" = 5, "sweetness" = 2, "sourness" = 2)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/chocolatecake
	name = "巧克力蛋糕"
	desc = "加了巧克力的蛋糕"
	icon_state = "chocolatecake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/chocolatecakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	filling_color = "#805930"
	tastes = list("cake" = 5, "sweetness" = 1, "chocolate" = 4)

/obj/item/reagent_containers/food/snacks/pastries/chocolatecakeslice
	name = "巧克力蛋糕切片"
	desc = "就是一片蛋糕,足够每个人吃。"
	icon_state = "chocolatecake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#805930"
	bitesize = 2
	tastes = list("cake" = 5, "sweetness" = 1, "chocolate" = 4)


/obj/item/reagent_containers/food/snacks/sliceable/pastries/birthdaycake
	name = "生日蛋糕"
	desc = "生日快乐..."
	icon_state = "birthdaycake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/birthdaycakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/sprinkles = 10)
	filling_color = "#FFD6D6"
	tastes = list("cake" = 5, "sweetness" = 1)

/obj/item/reagent_containers/food/snacks/pastries/birthdaycakeslice
	name = "生日蛋糕切片"
	desc = "你生日的一片"
	icon_state = "birthdaycakeslice"
	trash = /obj/item/trash/plate
	filling_color = "#FFD6D6"
	bitesize = 2
	tastes = list("cake" = 5, "sweetness" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/birthdaycake/energy
	name = "能量蛋糕"
	desc = "热量刚好够一整支核特战小队。"
	icon_state = "energycake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/energycakeslice
	hitsound = 'sound/weapons/blade1.ogg'
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/sprinkles = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("cake" = 3, "a Vlad's Salad" = 1)

/obj/item/reagent_containers/food/snacks/pastries/energycakeslice
	name = "生日蛋糕切片"
	desc = "你生日的一片"
	icon_state = "energycakeslice"
	trash = /obj/item/trash/plate
	filling_color = "#FFD6D6"
	bitesize = 2
	tastes = list("cake" = 5, "sweetness" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/applecakes
	name = "苹果蛋糕"
	desc = "以苹果为中心的蛋糕。"
	icon_state = "applecake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/applecakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 10)
	tastes = list("cake" = 5, "sweetness" = 1, "apple" = 1)

/obj/item/reagent_containers/food/snacks/pastries/applecakeslice
	name = "苹果蛋糕切片"
	desc = "一片苹果蛋糕。"
	icon_state = "applecakeslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 10)
	tastes = list("cake" = 5, "sweetness" = 1, "apple" = 1)

/obj/item/reagent_containers/food/snacks/pastries/sliceableslimecake
	name = "史莱姆蛋糕"
	desc = "用史莱姆做的蛋糕。大概没通电。"
	icon_state = "slimecake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/slimecakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("cake" = 5, "sweetness" = 1, "slime" = 1)

/obj/item/reagent_containers/food/snacks/pastries/slimecakeslice
	name = "史莱姆蛋糕"
	desc = "用史莱姆做的蛋糕切片。对你的健康只是稍微好一点。"
	icon_state = "slimecake_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("cake" = 5, "sweetness" = 1, "slime" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/pumpkinspicecake
	name = "南瓜香料蛋糕"
	desc = "一个填了真南瓜的空心蛋糕。"
	icon_state = "pumpkinspicecake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/pumpkinspicecakesslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("cake" = 5, "sweetness" = 1, "pumpkin" = 1)

/obj/item/reagent_containers/food/snacks/pastries/pumpkinspicecakesslice
	name = "南瓜香料蛋糕片"
	desc = "一片香辣的南瓜美味。"
	icon_state = "pumpkinspicecakeslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("cake" = 5, "sweetness" = 1, "pumpkin" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/bsvc
	name = "黑莓草莓香草蛋糕"
	desc = "一个普通的蛋糕,里面填满了各种黑莓和草莓!"
	icon_state = "blackbarry_strawberries_cake_vanilla_cake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/pumpkinspicecakesslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("blackberry" = 2, "strawberries" = 2, "vanilla" = 2, "sweetness" = 2, "cake" = 3)

/obj/item/reagent_containers/food/snacks/pastries/bsvcslice
	name = "草莓巧克力蛋糕片"
	desc = "就是一块蛋糕,上面放着五颗草莓。不知为何,这种蛋糕的造型对SELF中的人工智能来说特别有美感。" //yes, I know the one referenced has cherries, but I'm not implementing a new cake today.
	icon_state = "liars_slice"
	tastes = list("strawberries" = 2, "chocolate" = 2, "sweetness" = 2, "cake" = 3)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/holy_cake
	name = "天使蛋糕"
	desc = "为天使和随军牧师共同制作的蛋糕!含有圣水。"
	icon_state = "holy_cake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/holy_cakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3, /datum/reagent/water/holywater = 10)
	tastes = list("cake" = 5, "sweetness" = 1, "clouds" = 1)

/obj/item/reagent_containers/food/snacks/pastries/holy_cakeslice
	name = "天使蛋糕片"
	desc = "一片天堂般的蛋糕。"
	icon_state = "holy_cake_slice"
	tastes = list("cake" = 5, "sweetness" = 1, "clouds" = 1)

/obj/item/reagent_containers/food/snacks/pastries/holy_cakeslice
	name = "天使蛋糕片"
	desc = "一片天堂般的蛋糕。"
	icon_state = "holy_cake_slice"
	tastes = list("cake" = 5, "sweetness" = 1, "clouds" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/poundcake
	name = "磅蛋糕"
	desc = "一种为快速填饱肚子而制作的浓缩蛋糕。"
	icon_state = "pound_cake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/poundcakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 60, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("cake" = 5, "sweetness" = 1, "batter" = 1)

/obj/item/reagent_containers/food/snacks/pastries/poundcakeslice
	name = "磅蛋糕片"
	desc = "一片为快速填饱肚子而制作的浓缩蛋糕。"
	icon_state = "pound_cake_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/nutriment/vitamin = 0.5)
	tastes = list("cake" = 5, "sweetness" = 5, "batter" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/hardware_cake
	name = "硬件蛋糕"
	desc = "所谓的蛋糕,是用电子板做的,还会漏酸液..."
	icon_state = "hardware_cake"
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/toxin/acid = 15)
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/hardware_cakelice
	tastes = list("acid" = 3, "metal" = 4, "glass" = 5)

/obj/item/reagent_containers/food/snacks/pastries/hardware_cakelice
	name = "硬件蛋糕片"
	desc = "一片电子板和一些酸液。"
	icon_state = "hardware_cake_slice"
	tastes = list("acid" = 3, "metal" = 4, "glass" = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/toxin/acid = 3)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/vanilla_cake
	name = "香草蛋糕"
	desc = "一个涂有香草糖霜的蛋糕。"
	icon_state = "vanillacake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/hardware_cakelice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/sugar = 15, /datum/reagent/consumable/vanilla = 15)
	tastes = list("cake" = 1, "sugar" = 1, "vanilla" = 10)

/obj/item/reagent_containers/food/snacks/pastries/cakeslicevanilla_slice
	name = "香草蛋糕片"
	desc = "一片涂有香草糖霜的蛋糕。"
	icon_state = "vanillacake_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/vanilla = 3)
	tastes = list("cake" = 1, "sugar" = 1, "vanilla" = 10)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/clown_cake
	name = "小丑蛋糕"
	desc = "一个上面有小丑脸的搞笑蛋糕。"
	icon_state = "clowncake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/cakesliceclown_slice
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/sugar = 15)
	tastes = list("cake" = 1, "sugar" = 1, "joy" = 10)

/obj/item/reagent_containers/food/snacks/pastries/cakesliceclown_slice
	name = "小丑蛋糕片"
	desc = "一片烂笑话和愚蠢道具。"
	icon_state = "clowncake_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/consumable/sugar = 3)
	tastes = list("cake" = 1, "sugar" = 1, "joy" = 10)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/trumpet
	name = "太空人的蛋糕"
	desc = "一个涂有太空人喇叭花糖霜的蛋糕。"
	icon_state = "trumpetcake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/cakeslicetrumpet
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/milk = 5, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/berryjuice = 5)
	tastes = list("cake" = 4, "violets" = 2, "jam" = 2)

/obj/item/reagent_containers/food/snacks/pastries/cakeslicetrumpet
	name = "太空人的蛋糕"
	desc = "一个涂有太空人喇叭花糖霜的蛋糕。"
	icon_state = "trumpetcakeslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/consumable/berryjuice = 1)
	tastes = list("cake" = 4, "violets" = 2, "jam" = 2)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/brioche
	name = "布里欧修蛋糕"
	desc = "一圈甜味的糖釉小圆面包。"
	icon_state = "briochecake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/cakeslicebrioche
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("cake" = 4, "butter" = 2, "cream" = 1)

/obj/item/reagent_containers/food/snacks/pastries/cakeslicebrioche
	name = "布里欧修蛋糕片"
	desc = "美味的甜面包。谁还需要别的?"
	icon_state = "briochecake_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("cake" = 4, "butter" = 2, "cream" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/pavlova
	name = "帕芙洛娃"
	desc = "一个甜美的浆果帕芙洛娃。在新西兰发明,却以一位俄罗斯芭蕾舞演员命名...而且科学证明它在晚宴上是最棒的!"
	icon_state = "pavlova"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/cakeslicepavlova
	list_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("meringue" = 5, "creaminess" = 1, "berries" = 1)

/obj/item/reagent_containers/food/snacks/pastries/cakeslicepavlova
	name = "帕芙洛娃片"
	desc = "一片裂开的帕芙洛娃,上面堆满了浆果。你甚至切得让更多浆果落到了你的那片上,真是令人愉快的狡猾。"
	icon_state = "pavlova_slice"
	tastes = list("meringue" = 5, "creaminess" = 1, "berries" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/fruitcake
	name = "英式水果蛋糕"
	desc = "一个真正的好蛋糕,对吧?"
	icon_state = "fruitcake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/cakeslicefruit
	list_reagents = list(/datum/reagent/consumable/nutriment = 15, /datum/reagent/consumable/sugar = 10, /datum/reagent/consumable/cherryjelly = 5, )
	tastes = list("dried fruit" = 5, "treacle" = 2, "christmas" = 2)

/obj/item/reagent_containers/food/snacks/pastries/fruitcake
	name = "英式水果蛋糕"
	desc = "一个真正的好蛋糕,对吧?"
	icon_state = "fruitcake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/cakeslicefruit
	list_reagents = list(/datum/reagent/consumable/nutriment = 15, /datum/reagent/consumable/sugar = 10, /datum/reagent/consumable/cherryjelly = 5, )
	tastes = list("dried fruit" = 5, "treacle" = 2, "christmas" = 2)

/obj/item/reagent_containers/food/snacks/pastries/fruitcake/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1,3)]"

/obj/item/reagent_containers/food/snacks/pastries/cakeslicefruit
	name = "英式水果蛋糕片"
	desc = "真正好的一片,对吧?"
	icon_state = "fruitcake_slice1"
	base_icon_state = "fruitcake_slice"
	tastes = list("dried fruit" = 5, "treacle" = 2, "christmas" = 2)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/dulcedebatata
	name = "红薯甜糕片"
	desc = "一片甜红薯甜糕。"
	icon_state = "dulcedebatataslice"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/dulcedebatataslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("jelly" = 1, "sweet potato" = 1)

/obj/item/reagent_containers/food/snacks/pastries/dulcedebatataslice
	name = "红薯甜糕"
	desc = "一种用红薯制成的美味果冻。"
	icon_state = "dulcedebatata"
	list_reagents = list(/datum/reagent/consumable/nutriment = 14, /datum/reagent/consumable/nutriment/vitamin = 8)
	tastes = list("jelly" = 1, "sweet potato" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/baklava
	name = "果仁蜜饼"
	desc = "一种由坚果层和薄面皮制成的令人愉悦的健康零食。"
	icon_state = "baklava"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/baklavaslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("nuts" = 1, "pie" = 1)

/obj/item/reagent_containers/food/snacks/pastries/baklavaslice
	name = "果仁蜜饼盘"
	desc = "一份由坚果层和薄面皮制成的令人愉悦的健康零食"
	icon_state = "baklavaslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 14, /datum/reagent/consumable/nutriment/vitamin = 8)
	tastes = list("nuts" = 1, "pie" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/frenchsilkpie
	name = "法式丝绸派"
	desc = "一个颓废的派,由奶油巧克力慕斯馅料制成,上面覆盖着一层鲜奶油和巧克力碎屑。可切片。"
	icon_state = "frenchsilkpie"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/frenchsilkpieslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("pie" = 1, "smooth chocolate" = 1, "whipped cream" = 1)

/obj/item/reagent_containers/food/snacks/pastries/frenchsilkpieslice
	name = "法式丝绸派片"
	desc = "一片法式丝绸派,里面填满巧克力慕斯,上面覆盖着一层鲜奶油和巧克力碎屑。美味到让你流泪。"
	icon_state = "frenchsilkpieslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("pie" = 1, "smooth chocolate" = 1, "whipped cream" = 1)

/obj/item/reagent_containers/food/snacks/pastries/applepie
	name = "苹果派"
	desc = "一个包含甜甜的爱...或苹果的派。"
	icon_state = "applepie"
	filling_color = "#E0EDC5"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	bitesize = 3
	tastes = list("pie" = 1, "apple" = 1)

/obj/item/reagent_containers/food/snacks/pastries/frostypie
	name = "霜冻派"
	desc = "尝起来又蓝又冷."
	icon_state = "frostypie"
	filling_color = "#0b8c91"
	list_reagents = list(/datum/reagent/consumable/nutriment = 14, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("mint" = 1, "pie" = 1)

/obj/item/reagent_containers/food/snacks/pastries/cherrypie
	name = "樱桃派"
	desc = "味道好极了,能让硬汉落泪."
	icon_state = "cherrypie"
	filling_color = "#FF525A"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/cherryjelly = 4)
	bitesize = 3
	tastes = list("pie" = 7, "Nicole Paige Brooks" = 2)

/obj/item/reagent_containers/food/snacks/pastries/appletart
	name = "黄金苹果酥挞"
	desc = "一道美味的甜点,但过不了金属探测器."
	icon_state = "gappletart"
	trash = /obj/item/trash/plate
	filling_color = "#FFFF00"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/gold = 5)
	bitesize = 3
	tastes = list("pie" = 1, "apple" = 1, "expensive metal" = 1)

/obj/item/reagent_containers/food/snacks/pastries/grapetart
	name = "葡萄挞"
	desc = "一道美味的甜点,让你想起你没酿成的酒."
	icon_state = "grapetart"
	trash = /obj/item/trash/plate
	filling_color = "#4e0455"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	bitesize = 3
	tastes = list("pie" = 1, "grape" = 1)

/obj/item/reagent_containers/food/snacks/pastries/mimetart
	name = "哑剧挞"
	desc = "..."
	icon_state = "mimetart"
	filling_color = "#e8e1e9"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/nothing = 10)
	tastes = list("nothing" = 3)

/obj/item/reagent_containers/food/snacks/pastries/berrytart
	name = "浆果挞"
	desc = "一道美味的甜点,薄薄的派皮上铺满各种小浆果."
	icon_state = "berrytart"
	filling_color = "#a46cac"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("pie" = 1, "berries" = 2)

/obj/item/reagent_containers/food/snacks/pastries/cocolavatart
	name = "巧克力熔岩挞"
	desc = "一道巧克力做的美味甜点,内有流心." //But it doesn't even contain chocolate...
	icon_state = "cocolavatart"
	filling_color = "#522700"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("pie" = 1, "dark chocolate" = 3)


/obj/item/reagent_containers/food/snacks/pastries/meatpie
	name = "肉派"
	icon_state = "meatpie"
	desc = "一份古老的理发师配方,非常美味!"
	trash = /obj/item/trash/plate
	filling_color = "#948051"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	tastes = list("pie" = 1, "meat" = 1)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/pastries/tofupie
	name = "豆腐派"
	icon_state = "meatpie"
	desc = "一份美味的豆腐派."
	trash = /obj/item/trash/plate
	filling_color = "#FFFEE0"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	tastes = list("pie" = 1, "tofu" = 1)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/pastries/amanita_pie
	name = "毒蝇伞派"
	desc = "甜美可口的毒派."
	icon_state = "amanita_pie"
	filling_color = "#FFCCCC"
	tastes = list("pie" = 1, "mushroom" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/toxin/amatoxin = 3, /datum/reagent/consumable/psilocybin = 1)
	bitesize = 3

/obj/item/reagent_containers/food/snacks/pastries/plump_pie
	name = "丰腴派"
	desc = "我打赌你一定喜欢用丰腴头盔做的东西!"
	icon_state = "plump_pie"
	filling_color = "#B8279B"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("pie" = 1, "mushroom" = 1)
	bitesize = 2


/obj/item/reagent_containers/food/snacks/pastries/plump_pie/Initialize(mapload)
	. = ..()
	var/fey = prob(10)
	if(fey)
		name = "exceptional plump pie"
		desc = "Microwave is taken by a fey mood! It has cooked an exceptional plump pie!"
		reagents.add_reagent(/datum/reagent/medicine/tricordrazine, 5)

/obj/item/reagent_containers/food/snacks/pastries/xemeatpie
	name = "异形派"
	icon_state = "xenomeatpie"
	desc = "一份美味的肉派.大概算是异端."
	trash = /obj/item/trash/plate
	filling_color = "#43DE18"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	tastes = list("pie" = 1, "meat" = 1, "acid" = 1)
	bitesize = 2

/obj/item/reagent_containers/food/snacks/sliceable/pastries/applecake
	name = "苹果蛋糕"
	desc = "以苹果为中心的蛋糕"
	icon_state = "applecake"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/applecakeslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	filling_color = "#EBF5B8"
	tastes = list ("cake" = 5, "sweetness" = 1, "apple" = 1)

/obj/item/reagent_containers/food/snacks/pastries/applecakeslice
	name = "苹果蛋糕切片"
	desc = "一片天堂般的蛋糕."
	icon_state = "applecakeslice"
	trash = /obj/item/trash/plate
	filling_color = "#EBF5B8"
	bitesize = 2
	tastes = list("cake" = 5, "sweetness" = 1, "apple" = 1)

/obj/item/reagent_containers/food/snacks/sliceable/pastries/pumpkinpie
	name = "南瓜派"
	desc = "秋季月份的美味点心."
	icon_state = "pumpkinpie"
	slice_path = /obj/item/reagent_containers/food/snacks/pastries/pumpkinpieslice
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	filling_color = "#F5B951"
	tastes = list("pie" = 1, "pumpkin" = 1)

/obj/item/reagent_containers/food/snacks/pastries/pumpkinpieslice
	name = "南瓜派切片"
	desc = "一片南瓜派,上面顶着打发奶油.完美."
	icon_state = "pumpkinpieslice"
	trash = /obj/item/trash/plate
	filling_color = "#F5B951"
	bitesize = 2
	tastes = list("pie" = 1, "pumpkin" = 1)
