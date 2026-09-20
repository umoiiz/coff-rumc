// This file contains legacy mapped in objects that should be replaced where possible.

/obj/machinery/computer3
	name = "computer"
	icon = 'icons/obj/machines/computer3.dmi'
	icon_state = "frame"
	density = TRUE
	anchored = TRUE

/obj/machinery/computer3/powermonitor
	icon_state = "frame-eng"

/obj/machinery/computer3/laptop
	name = "Laptop Computer"
	desc = "一台翻盖式便携计算机.它是打开的."

	icon_state = "laptop"

/obj/machinery/computer3/laptop/secure_data
	icon_state = "laptop"

/obj/machinery/computer3/server
	name = "server"
	icon = 'icons/obj/machines/computer3.dmi'
	icon_state = "serverframe"

/obj/machinery/computer3/server/rack
	name = "server rack"
	icon_state = "rackframe"

/obj/item/laptop
	name = "笔记本电脑"
	desc = "一台翻盖式便携计算机.它是合上的."
	icon = 'icons/obj/machines/computer3.dmi'
	icon_state =  "laptop-closed"
	worn_icon_state =  "laptop-inhand"
	pixel_x = 2
	pixel_y = -3
	w_class = WEIGHT_CLASS_NORMAL

/obj/machinery/lapvend
	name = "Laptop Vendor"
	desc = "一台通用自动售货机."
	icon = 'icons/obj/machines/vending.dmi'
	icon_state = "robotics"
	layer = BELOW_OBJ_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/computer3frame
	density = TRUE
	anchored = FALSE
	name = "计算机框架"
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "0"

/obj/machinery/computer/atmoscontrol
	name = "\improper Central Atmospherics Computer"
	icon_state = "computer"
	screen_overlay = "computer_generic"
	density = TRUE
	anchored = TRUE

/obj/item/computer3_part
	name = "计算机部件"
	desc = "我的老天爷,你这下可搞定了"
	gender = PLURAL
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "hdd1"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/computer3_part/storage
	name = "存储设备"
	desc = "一种用于存储和检索数字信息的设备."

/obj/item/computer3_part/storage/hdd
	name = "硬盘"
	icon_state = "hdd1"

/obj/item/computer3_part/storage/hdd/big
	name = "大硬盘"
	icon_state = "hdd2"

/obj/item/clothing/shoes/centcom
	name = "礼服鞋"
	desc = "它们看起来擦得无可挑剔."
	icon_state = "laceups"
