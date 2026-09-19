/obj/machinery/vending/cigarette
	name = "香烟机" //OCD had to be uppercase to look nice with the new formating
	desc = "一台专门的自动售货机, 旨在助你缓慢而不适地死去."
	product_slogans = "没有比现在更好的时机开始抽烟了.;\
		现在就抽, 赢得同伴的崇拜.;\
		他们几个世纪前就战胜了癌症, 所以尽管抽吧.;\
		如果你不抽烟, 你一定是在开玩笑.;\
		大概对你没坏处!;\
		别信科学家!;\
		对你有好处!;\
		别戒, 多买!;\
		抽!;\
		尼古丁天堂.;\
		自2150年以来最好的香烟.;\
		别对自己太苛刻, 孩子. 抽根幸运星!;\
		专业人士. 更好的香烟给更好的人. 是的, 更好的人."
	icon_state = "cigs"
	icon_vend = "cigs-vend"
	icon_deny = "cigs-deny"
	wrenchable = FALSE
	isshared = TRUE
	products = list(
		/obj/item/storage/fancy/cigarettes/luckystars = -1,
		/obj/item/storage/fancy/cigarettes/dromedaryco = -1,
		/obj/item/storage/fancy/cigarettes/kpack = -1,
		/obj/item/storage/fancy/cigarettes/lady_finger = -1,
		/obj/item/storage/fancy/cigarettes = -1,
		/obj/item/storage/fancy/chemrettes = -1,
		/obj/item/storage/box/matches = -1,
		/obj/item/tool/lighter/random = -1,
		/obj/item/tool/lighter/zippo = -1,
		/obj/item/clothing/mask/cigarette/cigar/havana = 5
	)

	premium = list(/obj/item/storage/fancy/cigar = 25)
	seasonal_items = list()

/obj/machinery/vending/cigarette/colony
	product_slogans = "库兰德金装, 为精致味蕾.;淑女指, 为优雅的吸烟者.;淑女指, 用粉色款待你的味蕾!;大蓝K意味着凉爽清新的一天!;为了冷却你心情的味道, 寻找大蓝K!;精致的吸烟者选择金装!;淑女指是欣赏凉爽烟雾的女性首选.;淑女指是盖特威这边排名第一的香烟!;烟草鉴赏家偏爱库兰德金装.;为了凉爽, 过滤的感觉, 淑女指香烟提供市场上任何香烟中最顺滑的吸感.;对于知道自己位置在顶端的男人, 库兰德金装向世界展示你是最好的, 没人能说别的.;殖民管理局想提醒你吸烟致命."
	product_ads = "为了冷却你心情的味道, 寻找大蓝K!;精致的吸烟者选择金装!;淑女指是欣赏凉爽烟雾的女性首选.;淑女指是盖特威这边排名第一的香烟!;烟草鉴赏家偏爱库兰德金装.;为了凉爽, 过滤的感觉, 淑女指香烟提供市场上任何香烟中最顺滑的吸感.;对于知道自己位置在顶端的男人, 库兰德金装向世界展示你是最好的, 没人能说别的.;殖民管理局想提醒你吸烟致命."
	products = list(
		/obj/item/storage/fancy/cigarettes/kpack = 15,
		/obj/item/storage/fancy/cigarettes/lady_finger = 15,
		/obj/item/storage/box/matches = 10,
		/obj/item/tool/lighter/random = 20,
	)

/obj/machinery/vending/cigarette/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/cigarette/valhalla
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
	products = list(
		/obj/item/storage/fancy/cigarettes/luckystars = -1,
		/obj/item/storage/fancy/chemrettes = -1,
		/obj/item/storage/box/matches = -1,
		/obj/item/tool/lighter/random = -1,
		/obj/item/tool/lighter/zippo = -1,
		/obj/item/clothing/mask/cigarette/cigar/havana = -1,
		/obj/item/storage/fancy/cigar = -1,
	)
