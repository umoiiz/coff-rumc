
/*
* Vending machine types
*/

/*

/obj/machinery/vending/[vendors name here]   // --vending machine template   :)
	name = ""
	desc = ""
	icon = ''
	icon_state = ""
	vend_delay = 15
	products = list()
	premium = list()

*/

/*
/obj/machinery/vending/atmospherics //Commenting this out until someone ponies up some actual working, broken, and unpowered sprites - Quarxink
	name = "Tank Vendor"
	desc = "A vendor with a wide variety of masks and gas tanks."
	icon = 'icons/obj/objects.dmi'
	icon_state = "dispenser"
	product_paths = "/obj/item/tank/oxygen;/obj/item/tank/phoron;/obj/item/tank/emergency_oxygen;/obj/item/tank/emergency_oxygen/engi;/obj/item/clothing/mask/breath"
	product_amounts = "10;10;10;5;25"
	vend_delay = 0
*/

/obj/machinery/vending/boozeomat
	name = "\improper 酒保机"
	desc = "一项技术奇迹,据说能在你点单的瞬间调配出你想要的混合饮品。"
	icon_state = "boozeomat"        //////////////18 drink entities below, plus the glasses, in case someone wants to edit the number of bottles
	icon_deny = "boozeomat-deny"
	icon_vend = "boozeomat-vend"
	product_slogans = "希望没人问我要一杯该死的茶...;酒精是人类的朋友。你会抛弃朋友吗?;很乐意为您服务!;这空间站上没人渴吗?喝起来!;酒对你有好处!;酒精是人类最好的朋友。;很乐意为您服务!;想来杯不错的冰啤酒吗?;没什么比酒更能治愈你了!;喝一口!;喝一杯!;来杯啤酒!;啤酒对你有好处!;只有最好的酒!;自2053年以来最优质的酒!;获奖葡萄酒!;最大酒精量!;男人爱啤酒。;为进步干杯!"
	products = list(
		/obj/item/reagent_containers/food/drinks/bottle/gin = -1,
		/obj/item/reagent_containers/food/drinks/bottle/whiskey = -1,
		/obj/item/reagent_containers/food/drinks/bottle/tequila = -1,
		/obj/item/reagent_containers/food/drinks/bottle/vodka = -1,
		/obj/item/reagent_containers/food/drinks/bottle/vermouth = -1,
		/obj/item/reagent_containers/food/drinks/bottle/rum = -1,
		/obj/item/reagent_containers/food/drinks/bottle/wine = -1,
		/obj/item/reagent_containers/food/drinks/bottle/cognac = -1,
		/obj/item/reagent_containers/food/drinks/bottle/kahlua = -1,
		/obj/item/reagent_containers/food/drinks/cans/beer = -1,
		/obj/item/reagent_containers/food/drinks/cans/ale = -1,
		/obj/item/reagent_containers/food/drinks/bottle/orangejuice = -1,
		/obj/item/reagent_containers/food/drinks/bottle/tomatojuice = -1,
		/obj/item/reagent_containers/food/drinks/bottle/limejuice = -1,
		/obj/item/reagent_containers/food/drinks/bottle/cream = -1,
		/obj/item/reagent_containers/food/drinks/cans/tonic = -1,
		/obj/item/reagent_containers/food/drinks/cans/cola = -1,
		/obj/item/reagent_containers/food/drinks/cans/sodawater = -1,
		/obj/item/reagent_containers/food/drinks/flask/barflask = -1,
		/obj/item/reagent_containers/food/drinks/flask/vacuumflask = -1,
		/obj/item/reagent_containers/cup/glass/drinking_glass = -1,
		/obj/item/reagent_containers/food/drinks/ice = -1,
		/obj/item/reagent_containers/food/drinks/bottle/melonliquor = -1,
		/obj/item/reagent_containers/food/drinks/bottle/bluecuracao = -1,
		/obj/item/reagent_containers/food/drinks/bottle/absinthe = -1,
		/obj/item/reagent_containers/food/drinks/bottle/grenadine = -1,
		/obj/item/reagent_containers/food/drinks/cans/aspen = -1,
		/obj/item/reagent_containers/food/drinks/bottle/davenport = -1,
		/obj/item/reagent_containers/food/drinks/tea = -1,
	)
	idle_power_usage = 211

/obj/machinery/vending/boozeomat/gold
	name = "黄金酒保机"
	desc = "这台啤酒机带有Bravo小队属性,由队伍'SKIBIDI_LORDS_1337_BRAVO_GOYDA'赢得,成员包括Timur Livs、Max Bobinchik、Martin Barrett。Robust锦标赛于2024年11月15日举行(2524?)"
	icon_state = "gold-boozeomat"
	icon_deny = "gold-boozeomat-deny"
	icon_vend = "gold-boozeomat-vend"
	product_slogans = "Bravo冲啊!!;历史由胜利者书写!;除了我们无人能及!"

/obj/machinery/vending/assist
	product_ads = "只有最好的!;拿些工具吧。;最强健的装备。;太空中最精良的装备!"
	icon_vend = "generic-vend"
	icon_deny = "generic-deny"
	products = list(
		/obj/item/assembly/prox_sensor = 5,
		/obj/item/assembly/igniter = 3,
		/obj/item/assembly/signaler = 4,
		/obj/item/tool/wirecutters = 1,
		/obj/item/flashlight = 5,
		/obj/item/assembly/timer = 2,
	)

/obj/machinery/vending/coffee
	name = "\improper 热饮机"
	desc = "一台分发热饮的自动售货机。"
	//product_ads = "Have a drink!;Drink up!;It's good for you!;Would you like a hot joe?;I'd kill for some coffee!;The best beans in the galaxy.;Only the finest brew for you.;Mmmm. Nothing like a coffee.;I like coffee, don't you?;Coffee helps you work!;Try some tea.;We hope you like the best!;Try our new chocolate!;Admin conspiracies"
	icon_state = "coffee"
	icon_vend = "coffee-vend"
	icon_deny = "coffee-deny"
	vending_sound = 'sound/machines/vending_coffee.ogg'
	vend_delay = 34
	products = list(
		/obj/item/reagent_containers/food/drinks/coffee = -1,
		/obj/item/reagent_containers/food/drinks/coffee/cafe_latte = -1,
		/obj/item/reagent_containers/food/drinks/tea = -1,
		/obj/item/reagent_containers/food/drinks/h_chocolate = -1,
		/obj/item/reagent_containers/food/drinks/ice = -1,
	)

/obj/machinery/vending/snack
	name = "\improper 热食机"
	desc = "一台装满即食餐的自动售货机,嗯嗯嗯,尝尝这营养美味!"
	product_slogans = "开普勒薯片!尝尝这超凡脱俗的零食!;吃个EAT!;吃个Nanotrasen品牌包装汉堡。;吃个Nanotrasen品牌包装热狗。;吃个Nanotrasen品牌包装卷饼。;"
	icon_state = "snack"
	icon_vend = "snack-vend"
	icon_deny = "snack-deny"
	products = list(
		/obj/item/reagent_containers/food/snacks/burger/packaged_burger = -1,
		/obj/item/reagent_containers/food/snacks/packaged_burrito = -1,
		/obj/item/reagent_containers/food/snacks/packaged_hdogs = -1,
		/obj/item/reagent_containers/food/snacks/kepler_crisps = -1,
		/obj/item/reagent_containers/food/snacks/enrg_bar = -1,
		/obj/item/reagent_containers/food/snacks/wrapped/booniebars = -1,
		/obj/item/reagent_containers/food/snacks/wrapped/chunk = -1,
		/obj/item/reagent_containers/food/snacks/wrapped/barcaridine = -1,
		/obj/item/reagent_containers/food/snacks/lollipop = -1,
		/obj/item/reagent_containers/food/snacks/wrapped/berrybar = -1,
	)

/obj/machinery/vending/cola
	name = "\improper Souto软饮料"
	desc = "由哈瓦那Souto苏打公司提供的软饮料售货机。"
	icon_state = "Cola_Machine"
	product_slogans = "Souto苏打:来瓶Souto,带你前往热带天堂!;Souto经典款。那橘子美味无可匹敌!;Souto樱桃味。清凉冬日早晨的甜美风味!;Souto青柠味。为你熟知且热爱的酸甜风味!;Souto葡萄味。没什么比葡萄苏打更棒了。;Nanotrasen果啤。那场官司啥也没得到!;Nanotrasen泉水。它来自泉水!"
	icon_deny = "Cola_Machine-deny"
	icon_vend = "Cola_Machine-vend"
	products = list(
		/obj/item/reagent_containers/food/drinks/cans/souto = -1,
		/obj/item/reagent_containers/food/drinks/cans/souto/diet = -1,
		/obj/item/reagent_containers/food/drinks/cans/souto/cherry = -1,
		/obj/item/reagent_containers/food/drinks/cans/souto/cherry/diet = -1,
		/obj/item/reagent_containers/food/drinks/cans/souto/lime = -1,
		/obj/item/reagent_containers/food/drinks/cans/souto/lime/diet = -1,
		/obj/item/reagent_containers/food/drinks/cans/souto/grape = -1,
		/obj/item/reagent_containers/food/drinks/cans/souto/grape/diet = -1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = -1,
		/obj/item/reagent_containers/food/drinks/cans/cola = -1,
	)
	idle_power_usage = 200

/obj/machinery/vending/medical
	name = "\improper NanotrasenMed Plus"
	desc = "医疗药品分发机。由Nanotrasen制药部门(TM)提供。"
	icon_state = "med"
	icon_deny = "med-deny"
	icon_vend = "med-vend"
	//product_ads = "Go save some lives!;The best stuff for your medbay.;Only the finest tools.;Natural chemicals!;This stuff saves lives.;Don't you want some?;Ping!"
	products = list(
		"药瓶" = list(
			/obj/item/storage/pill_bottle/inaprovaline = -1,
			/obj/item/storage/pill_bottle/dexalin = -1,
			/obj/item/storage/pill_bottle/spaceacillin = -1,
			/obj/item/storage/pill_bottle/alkysine = -1,
			/obj/item/storage/pill_bottle/imidazoline = -1,
			/obj/item/storage/pill_bottle/imialky = -1,
			/obj/item/storage/pill_bottle/hypervene = 6,
			/obj/item/storage/pill_bottle/quickclot = 4,
			/obj/item/storage/pill_bottle/russian_red = 4,
		),
		"注射器" = list (
			/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus = 10,
			/obj/item/reagent_containers/hypospray/advanced = 5,
			/obj/item/reagent_containers/hypospray/advanced/bicaridine = 5,
			/obj/item/reagent_containers/hypospray/advanced/kelotane = 5,
			/obj/item/reagent_containers/hypospray/advanced/tramadol = 5,
			/obj/item/reagent_containers/hypospray/advanced/tricordrazine = 5,
			/obj/item/reagent_containers/hypospray/advanced/dylovene = 5,
		),
		"试剂瓶" = list(
			/obj/item/reagent_containers/glass/bottle/bicaridine = -1,
			/obj/item/reagent_containers/glass/bottle/kelotane = -1,
			/obj/item/reagent_containers/glass/bottle/tramadol = -1,
			/obj/item/reagent_containers/glass/bottle/tricordrazine = -1,
			/obj/item/reagent_containers/glass/bottle/combatmix = -1,
			/obj/item/reagent_containers/glass/bottle/dylovene = -1,
			/obj/item/reagent_containers/glass/bottle/inaprovaline = -1,
			/obj/item/reagent_containers/glass/bottle/paracetamol = -1,
			/obj/item/reagent_containers/glass/bottle/isotonic = -1,
			/obj/item/reagent_containers/glass/bottle/dexalin = -1,
			/obj/item/reagent_containers/glass/bottle/spaceacillin = 6,
			/obj/item/reagent_containers/glass/bottle/sleeptoxin = 6,
			/obj/item/reagent_containers/glass/bottle/polyhexanide = 6,
		),
		"化学设备" = list(
			/obj/item/reagent_containers/syringe = -1,
			/obj/item/reagent_containers/glass/beaker = -1,
			/obj/item/reagent_containers/glass/beaker/large = -1,
			/obj/item/reagent_containers/glass/beaker/vial = -1,
			/obj/item/reagent_containers/dropper = -1,
			/obj/item/storage/reagent_tank = 5,
			/obj/item/storage/reagent_tank/bicaridine = 1,
			/obj/item/storage/reagent_tank/kelotane = 1,
			/obj/item/storage/reagent_tank/tramadol = 1,
			/obj/item/storage/reagent_tank/tricordrazine = 1,
			/obj/item/storage/reagent_tank/bktt = 1,
		),
		"手术设备" = list(
			/obj/item/storage/pouch/surgery = -1,
			/obj/item/armor_module/storage/uniform/surgery_webbing = -1,
			/obj/item/reagent_containers/spray/surgery = -1,
			/obj/item/tool/soap = 6,
			/obj/item/tool/surgery/scalpel/manager = -1,
			/obj/item/tool/surgery/hemostat = -1,
			/obj/item/tool/surgery/retractor = -1,
			/obj/item/tool/surgery/cautery = -1,
			/obj/item/tool/surgery/circular_saw = -1,
			/obj/item/tool/surgery/surgical_membrane = -1,
			/obj/item/tool/surgery/bonegel = -1,
			/obj/item/tool/surgery/bonesetter = -1,
			/obj/item/tool/surgery/FixOVein = -1,
			/obj/item/tool/surgery/suture = -1,
		),
		"杂项" = list(
			/obj/item/tool/research/xeno_analyzer = -1,
			/obj/item/tool/research/excavation_tool = -1,
			/obj/item/clothing/glasses/hud/health = 15,
			/obj/item/roller = 15,
		),
	)
	idle_power_usage = 211

/obj/machinery/vending/medical/shipside
	isshared = TRUE
	wrenchable = FALSE

/obj/machinery/vending/medical/valhalla
	use_power = NO_POWER_USE
	req_access = null
	resistance_flags = INDESTRUCTIBLE
	products = list(
		"注射器" = list (
			/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus = -1,
			/obj/item/reagent_containers/hypospray/advanced = -1,
			/obj/item/reagent_containers/hypospray/advanced/bicaridine = -1,
			/obj/item/reagent_containers/hypospray/advanced/kelotane = -1,
			/obj/item/reagent_containers/hypospray/advanced/tramadol = -1,
			/obj/item/reagent_containers/hypospray/advanced/tricordrazine = -1,
			/obj/item/reagent_containers/hypospray/advanced/dylovene = -1,
		),
		"试剂瓶" = list(
			/obj/item/reagent_containers/glass/bottle/bicaridine = -1,
			/obj/item/reagent_containers/glass/bottle/kelotane = -1,
			/obj/item/reagent_containers/glass/bottle/tramadol = -1,
			/obj/item/reagent_containers/glass/bottle/tricordrazine = -1,
			/obj/item/reagent_containers/glass/bottle/dylovene = -1,
			/obj/item/reagent_containers/glass/bottle/inaprovaline = -1,
			/obj/item/reagent_containers/glass/bottle/paracetamol = -1,
			/obj/item/reagent_containers/glass/bottle/isotonic = -1,
			/obj/item/reagent_containers/glass/bottle/sleeptoxin = -1,
			/obj/item/reagent_containers/glass/bottle/spaceacillin = -1,
			/obj/item/reagent_containers/glass/bottle/dexalin = -1,
			/obj/item/reagent_containers/glass/bottle/oxycodone = -1,
			/obj/item/reagent_containers/glass/bottle/polyhexanide = -1,
			/obj/item/reagent_containers/glass/bottle/adminordrazine = -1,
			/obj/item/reagent_containers/glass/bottle/lemoline = -1,
			/obj/item/reagent_containers/glass/bottle/nanoblood = -1,
			/obj/item/reagent_containers/glass/bottle/doctor_delight = -1,
			/obj/item/reagent_containers/glass/bottle/medicalnanites = -1,
		),
		"药瓶" = list(
			/obj/item/storage/pill_bottle/inaprovaline = -1,
			/obj/item/storage/pill_bottle/isotonic = -1,
			/obj/item/storage/pill_bottle/spaceacillin = -1,
			/obj/item/storage/pill_bottle/alkysine = -1,
			/obj/item/storage/pill_bottle/imidazoline = -1,
			/obj/item/storage/pill_bottle/imialky = -1,
			/obj/item/storage/pill_bottle/quickclot = -1,
			/obj/item/storage/pill_bottle/hypervene = -1,
			/obj/item/storage/pill_bottle/russian_red = -1,
		),
		"医疗包" = list(
			/obj/item/stack/medical/heal_pack/advanced/bruise_pack = -1,
			/obj/item/stack/medical/heal_pack/advanced/burn_pack = -1,
			/obj/item/stack/medical/heal_pack/ointment = -1,
			/obj/item/stack/medical/heal_pack/gauze = -1,
			/obj/item/stack/medical/splint = -1,
		),
		"手术设备" = list(
			/obj/item/storage/pouch/surgery = -1,
			/obj/item/armor_module/storage/uniform/surgery_webbing = -1,
			/obj/item/reagent_containers/spray/surgery = -1,
			/obj/item/tool/soap = -1,
			/obj/item/tool/surgery/scalpel/manager = -1,
			/obj/item/tool/surgery/hemostat = -1,
			/obj/item/tool/surgery/retractor = -1,
			/obj/item/tool/surgery/cautery = -1,
			/obj/item/tool/surgery/circular_saw = -1,
			/obj/item/tool/surgery/surgical_membrane = -1,
			/obj/item/tool/surgery/bonegel = -1,
			/obj/item/tool/surgery/bonesetter = -1,
			/obj/item/tool/surgery/FixOVein = -1,
			/obj/item/tool/surgery/suture = -1,
		),
		"杂项" = list(
			/obj/item/tool/research/xeno_analyzer = -1,
			/obj/item/tool/research/excavation_tool = -1,
			/obj/item/clothing/glasses/hud/health = -1,
			/obj/item/roller = -1,
		),
		"化学设备" = list(
			/obj/item/reagent_containers/syringe = -1,
			/obj/item/storage/syringe_case/empty = -1,
			/obj/item/reagent_containers/glass/beaker/bluespace = -1,
			/obj/item/reagent_containers/glass/beaker = -1,
			/obj/item/reagent_containers/glass/beaker/large = -1,
			/obj/item/reagent_containers/glass/beaker/vial = -1,
			/obj/item/reagent_containers/dropper = -1,
			/obj/item/storage/reagent_tank = -1,
			/obj/item/storage/reagent_tank/bicaridine = -1,
			/obj/item/storage/reagent_tank/kelotane = -1,
			/obj/item/storage/reagent_tank/tramadol = -1,
			/obj/item/storage/reagent_tank/tricordrazine = -1,
			/obj/item/storage/reagent_tank/bktt = -1,
		),
		"瓦尔哈拉" = list(
			/obj/item/reagent_containers/glass/beaker/bluespace = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/rezadone = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/virilyth = -1,
			/obj/item/reagent_containers/hypospray/autoinjector/roulettium = -1,
			/obj/item/reagent_containers/glass/bottle/toxin = -1,
			/obj/item/reagent_containers/glass/bottle/doctor_delight = -1,
			/obj/item/alien_embryo = -1,
		),
	)

//This one's from bay12
/obj/machinery/vending/phoronresearch
	name = "\improper Toximate 3000"
	desc = "你需要的所有精良部件都在这一台售货机里!"
	icon_vend = "generic-vend"
	icon_deny = "generic-deny"
	products = list(
		/obj/item/clothing/under/rank/scientist = 6,
		/obj/item/clothing/suit/bio_suit = 6,
		/obj/item/clothing/head/bio_hood = 6,
		/obj/item/transfer_valve = 6,
		/obj/item/assembly/timer = 6,
		/obj/item/assembly/signaler = 6,
		/obj/item/assembly/prox_sensor = 6,
		/obj/item/assembly/igniter = 6,
	)

/obj/machinery/vending/nanomed
	name = "\improper NanoMed"
	desc = "壁挂式医疗设备分发机。"
	product_ads = "去救几条命吧!;给你医疗舱最好的东西。;只有最精良的工具。;天然化学品!;这东西能救命。;你不想要点吗?"
	icon_state = "wallmed"
	icon_deny = "wallmed-deny"
	icon_vend = "wallmed-vend"
	density = FALSE
	wrenchable = FALSE
	products = list(
		/obj/item/reagent_containers/hypospray/autoinjector/bicaridine = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/kelotane = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/tramadol = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/tricordrazine = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/combat = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/hypervene = 1,
		/obj/item/stack/medical/heal_pack/gauze = 2,
		/obj/item/stack/medical/heal_pack/ointment = 2,
		/obj/item/healthanalyzer = 1,
		/obj/item/stack/medical/splint = 1,
	)
	mouse_over_pointer = MOUSE_HAND_POINTER


/obj/machinery/vending/nanomed/Initialize(mapload, ...)
	. = ..()
	switch(dir)
		if(NORTH)
			pixel_y = -14
		if(SOUTH)
			pixel_y = 26
		if(EAST)
			pixel_x = -19
		if(WEST)
			pixel_x = 21

/obj/machinery/vending/nanomed/tadpolemed
	name = "\improper 飞行外科医生医疗设备分发机"
	desc = "专为有翅膀的外科医生打造,这个不起眼的小盒子相对于它的尺寸来说装了很多东西。"
	layer = ABOVE_OBJ_LAYER
	products = list(
		"自动注射器" = list(
			/obj/item/reagent_containers/hypospray/autoinjector/bicaridine = 1,
			/obj/item/reagent_containers/hypospray/autoinjector/kelotane = 1,
			/obj/item/reagent_containers/hypospray/autoinjector/dylovene = 1,
			/obj/item/reagent_containers/hypospray/autoinjector/tricordrazine = 1,
			/obj/item/reagent_containers/hypospray/autoinjector/tramadol = 1,
			/obj/item/reagent_containers/hypospray/autoinjector/combat = 1,
			/obj/item/reagent_containers/hypospray/autoinjector/hypervene = 1,
			/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline = 1,
			/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus = 1,
		),
		"试剂瓶" = list(
			/obj/item/reagent_containers/syringe = 10,
			/obj/item/reagent_containers/glass/bottle/dylovene = 1,
			/obj/item/reagent_containers/glass/bottle/bicaridine = 1,
			/obj/item/reagent_containers/glass/bottle/inaprovaline = 1,
			/obj/item/reagent_containers/glass/bottle/spaceacillin = 1,
			/obj/item/reagent_containers/glass/bottle/kelotane = 1,
			/obj/item/reagent_containers/glass/bottle/dexalin = 1,
			/obj/item/reagent_containers/glass/bottle/tramadol = 1,
			/obj/item/reagent_containers/glass/bottle/polyhexanide = 1,
		),
		"医疗包" = list(
			/obj/item/stack/medical/heal_pack/gauze = 2,
			/obj/item/stack/medical/heal_pack/ointment = 2,
			/obj/item/stack/medical/heal_pack/advanced/bruise_pack = 5,
			/obj/item/stack/medical/heal_pack/advanced/burn_pack = 5,
			/obj/item/healthanalyzer = 1,
			/obj/item/stack/medical/splint = 1,
		),
	)

/obj/machinery/vending/security
	name = "\improper SecTech"
	desc = "安保设备售货机。"
	product_ads = "砸碎资本主义者的脑袋!;揍几个脑袋!;别忘了 - 伤害是好事!;你的武器就在这儿。;手铐!;不许动,混蛋!;别电我,兄弟!;电他们,兄弟。;何不来个甜甜圈?"
	icon_state = "sec"
	icon_deny = "sec-deny"
	icon_vend = "sec-vend"
	req_access = list(ACCESS_MARINE_BRIG)
	products = list(
		/obj/item/restraints/handcuffs = 8,
		/obj/item/restraints/handcuffs/zip = 10,
		/obj/item/flash = 5,
		/obj/item/reagent_containers/food/snacks/donut/normal = 12,
		/obj/item/storage/box/evidence = 6,
		/obj/item/clothing/glasses/sunglasses/sechud = 3,
		/obj/item/radio/headset = 6,
		/obj/item/clothing/glasses/sunglasses = 2,
		/obj/item/storage/donut_box = 2,
	)

/obj/machinery/vending/hydronutrients
	name = "\improper NutriMax"
	desc = "植物营养剂售货机。"
	//product_slogans = "Aren't you glad you don't have to fertilize the natural way?;Now with 50% less stink!;Plants are people too!"
	//product_ads = "We like plants!;Don't you want some?;The greenest thumbs ever.;We like big plants.;Soft soil..."
	icon_state = "nutri"
	icon_deny = "nutri-deny"
	icon_vend = "nutri-vend"
	products = list(
		/obj/item/reagent_containers/glass/fertilizer/ez = 35,
		/obj/item/reagent_containers/glass/fertilizer/l4z = 25,
		/obj/item/reagent_containers/glass/fertilizer/rh = 15,
		/obj/item/tool/plantspray/pests = 20,
		/obj/item/reagent_containers/syringe = 5,
		/obj/item/storage/bag/plants = 5,
		/obj/item/reagent_containers/glass/bottle/ammonia = 10,
		/obj/item/reagent_containers/glass/bottle/diethylamine = 5,
	)
	idle_power_usage = 211 //refrigerator - believe it or not, this is actually the average power consumption of a refrigerated vending machine according to NRCan.

/obj/machinery/vending/hydroseeds
	name = "\improper 超级种子服务器"
	desc = "当你需要种子时快速获取!"
	//product_slogans = "THIS'S WHERE TH' SEEDS LIVE! GIT YOU SOME!;Hands down the best seed selection on the station!;Also certain mushroom varieties available, more for experts! Get certified today!"
	//product_ads = "We like plants!;Grow some crops!;Grow, baby, growww!;Aw h'yeah son!"
	icon_state = "seeds"
	icon_deny = "seeds-deny"
	icon_vend = "seeds-vend"

	products = list(
		/obj/item/seeds/bananaseed = 10,
		/obj/item/seeds/berryseed = 10,
		/obj/item/seeds/carrotseed = 10,
		/obj/item/seeds/chantermycelium = 10,
		/obj/item/seeds/chiliseed = 10,
		/obj/item/seeds/cornseed = 10,
		/obj/item/seeds/eggplantseed = 10,
		/obj/item/seeds/potatoseed = 10,
		/obj/item/seeds/soyaseed = 10,
		/obj/item/seeds/sunflowerseed = 10,
		/obj/item/seeds/tomatoseed = 10,
		/obj/item/seeds/towermycelium = 10,
		/obj/item/seeds/wheatseed = 10,
		/obj/item/seeds/appleseed = 10,
		/obj/item/seeds/poppyseed = 10,
		/obj/item/seeds/sugarcaneseed = 10,
		/obj/item/seeds/ambrosiavulgarisseed = 10,
		/obj/item/seeds/peanutseed = 10,
		/obj/item/seeds/whitebeetseed = 10,
		/obj/item/seeds/watermelonseed = 10,
		/obj/item/seeds/limeseed = 10,
		/obj/item/seeds/lemonseed = 10,
		/obj/item/seeds/orangeseed = 10,
		/obj/item/seeds/grassseed = 10,
		/obj/item/seeds/cocoapodseed = 10,
		/obj/item/seeds/plumpmycelium = 10,
		/obj/item/seeds/cabbageseed = 10,
		/obj/item/seeds/grapeseed = 10,
		/obj/item/seeds/pumpkinseed = 10,
		/obj/item/seeds/cherryseed = 10,
		/obj/item/seeds/plastiseed = 10,
		/obj/item/seeds/riceseed = 10,
		/obj/item/seeds/amanitamycelium = 10,
		/obj/item/seeds/glowshroom = 10,
		/obj/item/seeds/libertymycelium = 10,
		/obj/item/seeds/nettleseed = 10,
		/obj/item/seeds/reishimycelium = 10,
		/obj/item/seeds/reishimycelium = 10,
		/obj/item/toy/waterflower = 10,
	)

/obj/machinery/vending/magivend
	name = "\improper MagiVend"
	desc = "一台魔法自动售货机。"
	icon_state = "MagiVend"
	//product_slogans = "Sling spells the proper way with MagiVend!;Be your own Houdini! Use MagiVend!"
	vend_reply = "Have an enchanted evening!"
	product_ads = "FJKLFJSD;AJKFLBJAKL;1234 疯子们哈哈!;>MFW;杀了那些混蛋!;拿到那该死的磁盘;HONK!;EI NATH;摧毁空间站!;管理员阴谋自古有之!;时空弯曲硬件!"
	products = list(
		/obj/item/clothing/head/wizard = 1,
		/obj/item/clothing/suit/wizrobe = 1,
		/obj/item/clothing/head/wizard/red = 1,
		/obj/item/clothing/suit/wizrobe/red = 1,
		/obj/item/clothing/shoes/sandal = 1,
		/obj/item/staff = 2,
	)

/obj/machinery/vending/dinnerware
	name = "\improper 餐具"
	desc = "厨房和餐厅设备售货机。"
	product_ads = "嗯,食物!;食物和食物配件。;拿你的盘子!;你喜欢叉子吗?;我喜欢叉子。;哇,餐具。;你其实不需要这些..."
	icon_state = "dinnerware"
	icon_vend = "dinnerware-vend"
	icon_deny = "dinnerware-deny"
	products = list(
		/obj/item/storage/kitchen_tray = 8,
		/obj/item/tool/kitchen/utensil/fork = 6,
		/obj/item/tool/kitchen/knife = 3,
		/obj/item/reagent_containers/cup/glass/drinking_glass = 8,
		/obj/item/clothing/suit/storage/chef/classic = 2,
		/obj/item/tool/kitchen/utensil/spoon = 2,
		/obj/item/tool/kitchen/utensil/knife = 2,
		/obj/item/tool/kitchen/rollingpin = 2,
		/obj/item/tool/kitchen/knife/butcher = 2,
		/obj/item/tool/kitchen/knife = -1,
	)

/obj/machinery/vending/dinnerware/yautja
	name = "餐盘分发机"
	icon = 'icons/obj/machines/yautja_machines.dmi'

/obj/machinery/vending/sovietsoda
	name = "BODA"
	desc = "一台老式甜水自动售货机,它怎么会出现在这里?"
	icon_state = "sovietsoda"
	product_ads = "为了沙皇和祖国。;你今天完成营养配额了吗?;非常好!;我们是简朴的人,这就是我们吃的全部。;如果有人,就有问题。如果没有人,就没有问题。"
	products = list(
		/obj/item/reagent_containers/cup/glass/drinking_glass/filled/soda = 30,
		/obj/item/reagent_containers/cup/glass/drinking_glass/filled/cola = 20,
	)
	idle_power_usage = 211

/obj/machinery/vending/engivend
	name = "\improper Engi-Vend"
	desc = "备用工程师售货机。什么?你还指望有什么俏皮的描述吗?"
	icon_state = "engivend"
	icon_vend = "engivend-vend"
	icon_deny = "engivend-deny"
	products = list(
		/obj/item/tool/multitool = -1,
		/obj/item/tool/analyzer = -1,
		/obj/item/t_scanner = -1,
		/obj/item/circuitboard/apc = -1,
		/obj/item/circuitboard/airlock = -1,
		/obj/item/cell/high = 10,
		/obj/item/clothing/head/hardhat = 4,
		/obj/item/clothing/head/welding = 4,
		/obj/item/clothing/glasses/welding = 4,
		/obj/item/radio = -1,
		/obj/item/taperecorder = -1,
		/obj/item/assembly/igniter = -1,
		/obj/item/assembly/signaler = -1,
		/obj/item/assembly/infra = -1,
		/obj/item/assembly/timer = -1,
		/obj/item/assembly/prox_sensor = -1,
		/obj/item/light_bulb/tube = -1,
		/obj/item/light_bulb/bulb = -1,
		/obj/item/ashtray/glass = -1,
		/obj/item/frame/camera = -1,
		/obj/item/reagent_containers/glass/bucket = -1,
	)

/obj/machinery/vending/engivend/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/engivend/nopower/valhalla
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/vending/engivend/yautja
	name = "yautja自动车床"
	desc = "奇怪的外星工业制造机。"
	icon = 'icons/obj/machines/yautja_machines.dmi'
	icon_state = "autolathe"
	icon_vend = "autholate_n"
	products = list(
		/obj/item/tool/multitool/yautja = -1,
		/obj/item/tool/analyzer = -1,
		/obj/item/t_scanner = -1,
		/obj/item/taperecorder = -1,
		/obj/item/assembly/igniter = -1,
		/obj/item/assembly/signaler = -1,
		/obj/item/assembly/infra = -1,
		/obj/item/assembly/timer = -1,
		/obj/item/assembly/prox_sensor = -1,
		/obj/item/light_bulb/tube = -1,
		/obj/item/light_bulb/bulb = -1,
		/obj/item/ashtray/glass = -1,
		/obj/item/frame/camera = -1,
		/obj/item/frame/table/reinforced = 10,
		/obj/item/frame/table = 10,
		/obj/item/reagent_containers/glass/bucket = -1,
	)

//This one's from bay12
/obj/machinery/vending/robotics
	name = "\improper Robotech Deluxe"
	desc = "创建你自己的机器人军队所需的所有工具。"
	icon_state = "robotics"
	icon_deny = "robotics-deny"
	icon_vend = "robotics-vend"
	req_access = list(ACCESS_MARINE_RESEARCH)
	products = list(
		/obj/item/clothing/suit/storage/labcoat = 4,
		/obj/item/clothing/under/rank/roboticist = 4,
		/obj/item/stack/cable_coil = 4,
		/obj/item/flash = 4,
		/obj/item/cell/high = 12,
		/obj/item/assembly/prox_sensor = 3,
		/obj/item/assembly/signaler = 3,
		/obj/item/healthanalyzer = 3,
		/obj/item/tool/surgery/scalpel = 2,
		/obj/item/tool/surgery/circular_saw = 2,
		/obj/item/tank/anesthetic = 2,
		/obj/item/clothing/mask/breath/medical = 5,
		/obj/item/tool/screwdriver = 5,
		/obj/item/tool/crowbar = 5,
	)


// All instances of this vendor will share a single inventory for items in the shared list.
// Meaning, if an item is taken from one vendor, it will not be available in any others as well.
/obj/machinery/vending/shared_vending
	isshared = TRUE

/obj/machinery/vending/boozeomat/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/boozeomat/gold/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/assist/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/coffee/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/snack/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/cola/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/medical/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/nanomed/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/security/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/hydronutrients/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/hydroseeds/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/dinnerware/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/sovietsoda/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/engineering/nopower
	use_power = NO_POWER_USE
