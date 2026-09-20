/obj/machinery/vending/cigarette
	name = "香烟机" //OCD had to be uppercase to look nice with the new formating
	desc = "一台专用贩卖机,旨在助你缓慢而痛苦地死去."
	product_slogans = "没有比现在更好的开始吸烟的时机了.;\
		现在就抽,赢得同伴的崇拜.;\
		他们几个世纪前就攻克了癌症,放心抽吧.;\
		你要是不抽烟,肯定是在开玩笑.;\
		大概对你没坏处!;\
		别信科学家的话!;\
		对你有好处!;\
		别戒,多买点!;\
		抽!;\
		尼古丁天堂.;\
		自2150年以来最好的香烟.;\
		别对自己太苛刻了,孩子.抽根幸运星!;\
		专业人士.更好的香烟给更好的人.没错,更好的人."
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
	product_slogans = "库兰德金装,献给精致的味蕾.;淑女指,献给优雅的烟民.;淑女指,用粉色犒赏你的味蕾!;蓝色大K意味着清爽新鲜的一天!;想要让心情清爽的口感,就找蓝色大K!;精致的烟民都选金装!;淑女指是懂得享受清爽烟雾的女性的首选.;淑女指是盖特威这边排名第一的香烟!;烟草鉴赏家更偏爱库兰德金装.;想要清爽过滤的口感,淑女指香烟提供市场上最顺滑的吸感.;对于知道自己身处顶端的男人,库兰德金装向世界展示你是最棒的,无人能反驳.;殖民地管理局提醒您,吸烟致命."
	product_ads = "想要让心情清爽的口感,就找蓝色大K!;精致的烟民都选金装!;淑女指是懂得享受清爽烟雾的女性的首选.;淑女指是盖特威这边排名第一的香烟!;烟草鉴赏家更偏爱库兰德金装.;想要清爽过滤的口感,淑女指香烟提供市场上最顺滑的吸感.;对于知道自己身处顶端的男人,库兰德金装向世界展示你是最棒的,无人能反驳.;殖民地管理局提醒您,吸烟致命."
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
