//Items labled as 'trash' for the trash bag.

/obj/item/trash
	icon = 'icons/obj/items/trash.dmi'
	w_class = WEIGHT_CLASS_SMALL
	desc = "这是垃圾."

/obj/item/trash/raisins
	name = "4no raisins"
	icon_state= "4no_raisins"

/obj/item/trash/pillpacket
	name = "皱巴巴的药片包装"
	desc = "在治愈了大量伤害后,空包装得以安息"
	icon = 'icons/obj/items/trash.dmi'
	icon_state = "pillpacketempty"

/obj/item/trash/candy
	name = "糖果"
	icon_state= "candy"

/obj/item/trash/cheesie
	name = "Cheesie honkers"
	icon_state = "cheesie_honkers"

/obj/item/trash/chips
	name = "薯片"
	icon_state = "chips"

/obj/item/trash/popcorn
	name = "爆米花"
	icon_state = "popcorn"

/obj/item/trash/sosjerky
	name = "Scaredy's 私人储备牛肉干"
	icon_state = "sosjerky"

/obj/item/trash/syndi_cakes
	name = "辛迪加蛋糕"
	icon_state = "syndi_cakes"

/obj/item/trash/waffles
	name = "华夫饼"
	icon_state = "waffles"

/obj/item/trash/plate
	name = "盘子"
	icon_state = "plate"

/obj/item/trash/snack_bowl
	name = "零食碗"
	icon_state = "snack_bowl"

/obj/item/trash/pistachios
	name = "开心果包"
	icon_state = "pistachios_pack"

/obj/item/trash/semki
	name = "瓜子包"
	icon_state = "semki_pack"

/obj/item/trash/tray
	name = "托盘"
	icon_state = "tray"

/obj/item/trash/candle
	name = "蜡烛"
	icon = 'icons/obj/items/candle.dmi'
	icon_state = "candle4"

/obj/item/trash/can
	name = "压扁的罐子"
	icon_state = "cola"
	resistance_flags = NONE

/obj/item/trash/liquidfood
	name = "\improper \"流质食物\"口粮"
	icon_state = "liquidfood"

/obj/item/trash/burger
	name = "汉堡包装纸"
	icon_state = "burger"
	desc = "一张油腻的塑料薄膜,曾经包裹着一个芝士汉堡.由Nanotrasen公司包装."

/obj/item/trash/buritto
	name = "墨西哥卷饼包装纸"
	icon_state = "burrito"
	desc = "一张散发着恶臭的塑料薄膜,曾经包裹着一个微波墨西哥卷饼.由Nanotrasen公司包装."

/obj/item/trash/hotdog
	name = "热狗包装纸"
	icon_state = "hotdog"
	desc = "一张发霉的塑料薄膜,曾经包裹着一个热狗.由Nanotrasen公司包装."

/obj/item/trash/kepler
	name = "Kepler包装纸"
	icon_state = "kepler"

/obj/item/trash/eat
	name = "EAT能量棒包装纸"
	icon_state = "eat"

/obj/item/trash/fortunecookie
	name = "幸运饼干签语"
	icon_state = "fortune" //Thank you Alterist

/obj/item/trash/fortunecookie/Initialize(mapload, ...)
	. = ..()
	desc = "The fortune reads. <br>[span_tip("[pick(SSstrings.get_list_from_file("tips/marine"))]")]"

/obj/item/trash/c_tube
	name = "硬纸板筒"
	desc = "一个筒...硬纸板的."
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "c_tube"
	throwforce = 1
	throw_speed = 4
	throw_range = 5


/obj/item/trash/cigbutt
	name = "烟头"
	desc = "一个肮脏的旧烟头."
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "cigbutt"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 1

/obj/item/trash/cigbutt/Initialize(mapload, ...)
	. = ..()
	pixel_x = rand(-10,10)
	pixel_y = rand(-10,10)
	transform = turn(transform,rand(0,360))

/obj/item/trash/cigbutt/cigarbutt
	name = "雪茄头"
	desc = "一个肮脏的旧雪茄头."
	icon_state = "cigarbutt"


/obj/item/trash/tgmc_tray
	name = "\improper TGMC托盘"
	desc = "已完成其执勤任务"
	icon_state = "MREtray"

/obj/item/trash/boonie
	name = "boonie能量棒包装纸"
	desc = "一张薄荷绿色的包装纸.让你想起另一个涉及薄荷绿色的糟糕决定,但你想不起来是什么..."
	icon_state = "boonie_trash"

/obj/item/trash/chunk
	name = "chunk能量棒盒"
	desc = "一个chunk能量棒的空盒子.明显轻多了."
	icon_state = "chunk_trash"

/obj/item/trash/barcaridine
	name = "barcaridine能量棒包装纸"
	desc = "一张barcaridine能量棒的空包装纸.你注意到内侧有几个医疗标签.你不确定自己是否在意这个."
	icon_state = "barcaridine_trash"

/obj/item/trash/berrybar
	name = "berry能量棒包装纸"
	desc = "一张berry能量棒的空包装纸.你注意到内侧有几个医疗标签和成分,但你不确定自己是否在意这个."
	icon_state = "berrybar_trash"

/obj/item/trash/mre
	name = "\improper 碎裂的TGMC单兵口粮"
	desc = "它已为TGMC尽了自己的职责.你呢?"
	icon = 'icons/obj/items/trash.dmi'
	icon_state = "mealpackempty"

/obj/item/trash/mre/som
	name = "\improper 碎裂的SOM单兵口粮"
	desc = "它已为SOM尽了自己的职责.你呢?"
	icon_state = "som_mealpackempty"
