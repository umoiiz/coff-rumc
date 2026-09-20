/*
*	Everything derived from the common cardboard box.
*	Basically everything except the original is a kit (starts full).
*
*	Contains:
*		Empty box, starter boxes (survival/engineer),
*		Latex glove and sterile mask boxes,
*		Syringe, beaker, dna injector boxes,
*		Blanks, flashbangs, and EMP grenade boxes,
*		Tracking and chemical implant boxes,
*		Prescription glasses and drinking glass boxes,
*		Condiment bottle and silly cup boxes,
*		Donkpocket and monkeycube boxes,
*		ID and security PDA cart boxes,
*		Handcuff, mousetrap, and pillbottle boxes,
*		Snap-pops and matchboxes,
*		Replacement light boxes.
*/

/obj/item/storage/box
	name = "盒子"
	desc = "只是一个普通的盒子."
	icon = 'icons/obj/items/storage/box.dmi'
	icon_state = "box"
	worn_icon_state = "syringe_kit"
	storage_type = /datum/storage/box
	w_class = WEIGHT_CLASS_BULKY //Changed becuase of in-game abuse
	var/obj/item/spawn_type
	var/spawn_number

/obj/item/storage/box/Initialize(mapload, ...)
	. = ..()
	if(!spawn_type)
		return
	if(!(spawn_type in storage_datum.can_hold))
		// must be set before parent init for typecacheof
		var/list/new_hold_list = storage_datum.can_hold + spawn_type
		storage_datum.set_holdable(can_hold_list = list(new_hold_list))
	for(var/i in 1 to spawn_number)
		new spawn_type(src)

/obj/item/storage/box/survival
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/survival/PopulateContents()
	new /obj/item/clothing/mask/breath( src )
	new /obj/item/tank/emergency_oxygen( src )

/obj/item/storage/box/engineer/PopulateContents()
	new /obj/item/clothing/mask/breath( src )
	new /obj/item/tank/emergency_oxygen/engi( src )

/obj/item/storage/box/MRE
	name = "\improper TGMC 单兵口粮"
	desc = "即食口粮,供野外食用,其保质期比陆战队员的平均战斗预期寿命还要长二十年."
	icon_state = "mealpack"
	w_class = WEIGHT_CLASS_SMALL
	storage_type = /datum/storage/box/mre
	var/isopened = FALSE

/obj/item/storage/box/MRE/PopulateContents()
	var/entree = pick("boneless pork ribs", "grilled chicken", "pizza square", "spaghetti", "chicken tenders")
	var/side = pick("meatballs", "cheese spread", "beef turnover", "mashed potatoes")
	var/snack = pick("biscuit", "pretzels", "peanuts", "cracker")
	var/desert = pick("spiced apples", "chocolate brownie", "sugar cookie", "choco bar", "crayon")
	name = "[initial(name)] ([entree])"
	new /obj/item/reagent_containers/food/snacks/packaged_meal(src, entree)
	new /obj/item/reagent_containers/food/snacks/packaged_meal(src, side)
	new /obj/item/reagent_containers/food/snacks/packaged_meal(src, snack)
	new /obj/item/reagent_containers/food/snacks/packaged_meal(src, desert)

/obj/item/storage/box/MRE/update_icon_state()
	. = ..()
	if(!isopened)
		isopened = TRUE
		icon_state += "opened"

/obj/item/storage/box/MRE/som
	name = "\improper SOM 火星野战口粮"
	desc = "火星野战口粮,保证每一口都带有火星的味道."
	icon_state = "som_mealpack"
	storage_type = /datum/storage/box/mre/som

/obj/item/storage/box/gloves
	name = "一盒乳胶手套"
	desc = "内含白色手套."
	icon_state = "latex"
	spawn_type = /obj/item/clothing/gloves/latex
	spawn_number = 7
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/box/masks
	name = "一盒无菌口罩"
	desc = "此盒内含无菌口罩."
	icon_state = "sterile"
	spawn_type = /obj/item/clothing/mask/surgical
	spawn_number = 7
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/box/syringes
	name = "一盒注射器"
	desc = "一盒装满注射器的盒子."
	desc = "盒子上印有生物危害警告"
	spawn_type = /obj/item/reagent_containers/syringe
	spawn_number = 7
	icon_state = "syringe"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/box/beakers
	name = "一盒烧杯"
	icon_state = "beaker"
	spawn_type = /obj/item/reagent_containers/glass/beaker
	spawn_number = 7
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/flashbangs
	name = "一盒闪光弹 (警告)"
	desc = "<B>警告: 这些装置极其危险,重复使用可能导致失明或失聪.</B>"
	icon_state = "flashbang"
	spawn_type = /obj/item/explosive/grenade/flashbang
	spawn_number = 7
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/emps
	name = "一盒电磁脉冲手榴弹"
	desc = "一盒装有 5 枚电磁脉冲手榴弹."
	icon_state = "flashbang"
	spawn_type = /obj/item/explosive/grenade/emp
	spawn_number = 5

/obj/item/storage/box/rxglasses
	name = "一盒处方眼镜"
	desc = "此盒内含书呆子眼镜."
	icon_state = "glasses"
	spawn_type = /obj/item/clothing/glasses/regular
	spawn_number = 7
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/drinkingglasses
	name = "一箱玻璃杯"
	desc = "上面印有玻璃杯的图案."
	spawn_type = /obj/item/reagent_containers/cup/glass/drinking_glass
	spawn_number = 6

/obj/item/storage/box/condimentbottles
	name = "一箱调味瓶"
	desc = "上面有一大块番茄酱污渍."
	spawn_type = /obj/item/reagent_containers/food/condiment
	spawn_number = 6

/obj/item/storage/box/cups
	name = "一箱纸杯"
	desc = "正面印有纸杯的图案."
	spawn_type = /obj/item/reagent_containers/food/drinks/sillycup
	spawn_number = 7

/obj/item/storage/box/donkpockets
	name = "一箱炸馅饼"
	desc = "<B>说明:</B> <I>用微波炉加热. 若在七分钟内未食用,产品将会变凉.</I>"
	icon_state = "donk_kit"
	spawn_type = /obj/item/reagent_containers/food/snacks/donkpocket
	spawn_number = 6
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/monkeycubes
	name = "猴子立方体盒"
	desc = "Drymate牌猴子立方体. 只需加水!"
	icon = 'icons/obj/items/food/packaged.dmi'
	icon_state = "monkeycubebox"
	spawn_type = /obj/item/reagent_containers/food/snacks/monkeycube/wrapped
	spawn_number = 5

/obj/item/storage/box/monkeycubes/farwacubes
	name = "法瓦立方体盒"
	desc = "Drymate牌法瓦立方体, 从Ahdomai发货. 只需加水!"
	spawn_type = /obj/item/reagent_containers/food/snacks/monkeycube/wrapped/farwacube

/obj/item/storage/box/monkeycubes/stokcubes
	name = "斯托克立方体盒"
	desc = "Drymate牌斯托克立方体, 从Moghes发货. 只需加水!"
	spawn_type = /obj/item/reagent_containers/food/snacks/monkeycube/wrapped/stokcube

/obj/item/storage/box/monkeycubes/neaeracubes
	name = "尼埃拉立方体盒"
	desc = "Drymate牌尼埃拉立方体, 从Jargon 4发货. 只需加水!"
	spawn_type = /obj/item/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube

/obj/item/storage/box/ids
	name = "一箱备用ID卡"
	desc = "有好多空白ID卡."
	icon_state = "id"
	spawn_type = /obj/item/card/id
	spawn_number = 7

/obj/item/storage/box/ids/dogtag
	name = "一箱备用狗牌"
	desc = "有好多空白狗牌."
	icon_state = "id"
	spawn_type = /obj/item/card/id/dogtag
	spawn_number = 7

/obj/item/storage/box/handcuffs
	name = "一箱手铐"
	desc = "满满一箱手铐."
	icon_state = "handcuff"
	spawn_type = /obj/item/restraints/handcuffs
	spawn_number = 7

/obj/item/storage/box/zipcuffs
	name = "一箱扎带"
	desc = "满满一箱扎带."
	icon_state = "handcuff"
	spawn_type = /obj/item/restraints/handcuffs/zip
	spawn_number = 14

/obj/item/storage/box/mousetraps
	name = "一箱灭鼠先锋捕鼠器"
	desc = "<B><FONT color='red'>警告:</FONT></B> <I>请置于儿童接触不到的地方</I>."
	icon_state = "mousetraps"
	spawn_type = /obj/item/assembly/mousetrap
	spawn_number = 6

/obj/item/storage/box/pillbottles
	name = "一箱药瓶"
	desc = "正面印有药瓶的图案."
	spawn_type = /obj/item/storage/pill_bottle
	spawn_number = 7

/obj/item/storage/box/snappops
	name = "一盒摔炮"
	desc = "八包装的乐趣! 适合8岁及以上. 不适合儿童."
	icon = 'icons/obj/items/toy.dmi'
	icon_state = "spbox"
	spawn_type = /obj/item/toy/snappop
	spawn_number = 8

/obj/item/storage/box/snappops/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_storage_space = 8

/obj/item/storage/box/matches
	name = "火柴盒"
	desc = "一小盒'太空级'高级火柴."
	icon = 'icons/obj/items/cigarettes.dmi'
	icon_state = "matchbox"
	worn_icon_state = "zippo"
	w_class = WEIGHT_CLASS_TINY
	equip_slot_flags = ITEM_SLOT_BELT
	spawn_type = /obj/item/tool/match
	spawn_number = 14

/obj/item/storage/box/matches/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/tool/match))
		var/obj/item/tool/match/M = I

		if(M.heat || M.burnt)
			return ..()

		if(prob(50))
			playsound(loc, 'sound/items/matchstick_lit.ogg', 15, 1)
			M.light_match()
		else
			playsound(loc, 'sound/items/matchstick_hit.ogg', 15, 1)
		return TRUE
	return ..()

/obj/item/storage/box/autoinjectors
	name = "一箱注射器"
	desc = "内含自动注射器."
	icon_state = "syringe"
	spawn_type = /obj/item/reagent_containers/hypospray/autoinjector/tricordrazine
	spawn_number = 7

/obj/item/storage/box/quickclot
	name = "一箱速凝注射器"
	desc = "内含速凝自动注射器."
	icon_state = "syringe"
	spawn_type = /obj/item/reagent_containers/hypospray/autoinjector/quickclot
	spawn_number = 7

/obj/item/storage/box/lights
	name = "一箱替换灯泡"
	icon_state = "light"
	desc = "这个盒子内部有特定形状, 因此只能装入灯管和灯泡."
	worn_icon_state = "syringe_kit"
	storage_type = /datum/storage/box/lights
	spawn_type = /obj/item/light_bulb/bulb
	spawn_number = 21

/obj/item/storage/box/lights/bulbs // mapping placeholder

/obj/item/storage/box/lights/tubes
	name = "一箱替换灯管"
	icon_state = "lighttube"
	w_class = WEIGHT_CLASS_NORMAL
	spawn_type = /obj/item/light_bulb/tube/large
	spawn_number = 21

/obj/item/storage/box/lights/mixed
	name = "一箱替换灯具"
	icon_state = "lightmixed"

/obj/item/storage/box/lights/mixed/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/light_bulb/tube/large,
		/obj/item/light_bulb/bulb,
	))
	for(var/i in 1 to 14)
		new /obj/item/light_bulb/tube/large(src)
	for(var/i in 1 to 7)
		new /obj/item/light_bulb/bulb(src)

/obj/item/storage/box/trampop
	name = "一箱曲马多棒棒糖"
	desc = "也许你表现好的话, 医生会奖励你一根."
	icon_state = "trampop"
	spawn_type = /obj/item/reagent_containers/food/snacks/lollipop/tramadol
	spawn_number = 14
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/box/combat_lolipop
	name = "一箱复方药棒棒糖"
	desc = "一小盒棒棒糖, 含有能缓慢治疗你的混合试剂. 建议含着吃, 而不是嚼着吃."
	icon_state = "lolipop_box_generic"
	spawn_type = /obj/item/reagent_containers/food/snacks/lollipop/combat
	spawn_number = 10
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/box/combat_lolipop/Initialize(mapload, ...)
	. = ..()
	storage_datum.draw_mode = TRUE

/obj/item/storage/box/combat_lolipop/tricord
	name = "一箱三可定棒棒糖"
	desc = "一小盒棒棒糖, 里面掺有三可定来缓慢治疗你. 建议含着吃, 而不是嚼着吃."
	icon_state = "lolipop_box_tricord"
	spawn_type = /obj/item/reagent_containers/food/snacks/lollipop/tricord

/obj/item/storage/box/combat_lolipop/tramadol
	name = "一箱曲马多棒棒糖"
	desc = "一小盒棒棒糖, 里面掺有曲马多来帮助止痛, 建议含着吃, 而不是嚼着吃."
	icon_state = "lolipop_box_tramadol"
	spawn_type = /obj/item/reagent_containers/food/snacks/lollipop/tramadol/combat

////////// MARINES BOXES //////////////////////////

/obj/item/storage/box/explosive_mines
	name = "\improper M20地雷箱"
	desc = "一个安全箱, 装有反人员近炸地雷."
	icon_state = "minebox"
	w_class = WEIGHT_CLASS_NORMAL
	spawn_type = /obj/item/explosive/mine
	spawn_number = 5

/obj/item/storage/box/explosive_mines/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_storage_space = 10

/obj/item/storage/box/explosive_mines/update_icon_state()
	. = ..()
	icon_state = initial(icon_state)
	if(!length(contents))
		icon_state += "_e"

/obj/item/storage/box/explosive_mines/large
	name = "\improper M20地雷箱"
	desc = "一个大型安全箱, 装有反人员近炸地雷."
	icon_state = "minebox"
	spawn_type = /obj/item/explosive/mine
	spawn_number = 10

/obj/item/storage/box/explosive_mines/large/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_storage_space = 20

/obj/item/storage/box/explosive_mines/pmc
	name = "\improper M20P地雷箱"
	spawn_type = /obj/item/explosive/mine/pmc

/obj/item/storage/box/explosive_mines/antitank
	name = "\improper M92地雷箱"
	desc = "一个安全箱, 装有反坦克近炸地雷."
	icon_state = "atminebox"
	spawn_type = /obj/item/explosive/mine/anti_tank
	spawn_number = 5

/obj/item/storage/box/m94
	name = "\improper M40 FLDP照明弹包"
	desc = "一包七枚M40 FLDP照明弹. 由TGMC陆战队员携带, 用于照亮普通TNR肩灯无法到达的黑暗区域. 可从下挂式榴弹发射器发射."
	icon_state = "m40"
	w_class = WEIGHT_CLASS_SMALL
	spawn_type = /obj/item/explosive/grenade/flare
	spawn_number = 14

/obj/item/storage/box/m94/update_icon_state()
	. = ..()
	icon_state = initial(icon_state)
	if(!length(contents))
		icon_state += "_e"

/obj/item/storage/box/m94/cas
	name = "\improper M50 CFDP信号弹包"
	desc = "一包七枚M40 CFPD信号弹. 用于标记火力支援位置. 可从下挂式榴弹发射器发射."
	icon_state = "m50"
	spawn_type = /obj/item/explosive/grenade/flare/cas

//ITEMS-----------------------------------//
/obj/item/storage/box/lightstick
	name = "一箱荧光棒"
	desc = "内含蓝色荧光棒."
	icon_state = "lightstick"
	spawn_type = /obj/item/lightstick
	spawn_number = 7

/obj/item/storage/box/lightstick/red
	desc = "内含红色荧光棒."
	icon_state = "lightstick2"
	spawn_type = /obj/item/lightstick/red
	spawn_number = 7

/obj/item/storage/box/mre
	name = "\improper TGMC单兵口粮"
	desc = "即食口粮, 供野外食用, 其保质期比陆战队员的平均战斗预期寿命还要长二十年."
	icon_state = "mealpack"
	w_class = WEIGHT_CLASS_SMALL
	storage_type = /datum/storage/box/mre
	///If our MRE is opened, it gets a new icon
	var/isopened = 0

/obj/item/storage/box/mre/PopulateContents()
	var/entree = pick("boneless pork ribs", "grilled chicken", "pizza square", "spaghetti", "chicken tenders")
	var/side = pick("meatballs", "cheese spread", "beef turnover", "mashed potatoes")
	var/snack = pick("biscuit", "pretzels", "peanuts", "cracker")
	var/desert = pick("spiced apples", "chocolate brownie", "sugar cookie", "choco bar", "crayon")
	name = "[initial(name)] ([entree])"
	new /obj/item/reagent_containers/food/snacks/packaged_meal(src, entree)
	new /obj/item/reagent_containers/food/snacks/packaged_meal(src, side)
	new /obj/item/reagent_containers/food/snacks/packaged_meal(src, snack)
	new /obj/item/reagent_containers/food/snacks/packaged_meal(src, desert)

/obj/item/storage/box/mre/update_icon_state()
	. = ..()
	if(!isopened)
		isopened = 1
		icon_state += "opened"

/obj/item/storage/box/mre/som
	name = "\improper SOM火星野战口粮"
	desc = "火星野战口粮, 保证每一口都带有火星的味道."
	icon_state = "som_mealpack"
	storage_type = /datum/storage/box/mre/som

/obj/item/storage/box/holobadge
	name = "全息徽章盒"
	desc = "一个声称装有全息徽章的盒子."

/obj/item/storage/box/holobadge/PopulateContents()
	. = ..()
	new /obj/item/clothing/tie/holobadge(src)
	new /obj/item/clothing/tie/holobadge(src)
	new /obj/item/clothing/tie/holobadge(src)
	new /obj/item/clothing/tie/holobadge(src)
	new /obj/item/clothing/tie/holobadge/cord(src)
	new /obj/item/clothing/tie/holobadge/cord(src)
