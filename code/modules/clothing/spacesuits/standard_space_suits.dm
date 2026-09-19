/obj/item/clothing/head/helmet/space/tgmc
	name = "\improper TGMC压缩头盔"
	desc = "一种高科技, TGMC设计的暗红色太空服头盔. 用于太空维护."
	icon_state = "void_helm"
	anti_hug = 3

/obj/item/clothing/suit/space/tgmc
	name = "\improper TGMC压缩服"
	icon_state = "void"
	desc = "一种高科技, TGMC设计的暗红色太空服. 用于太空维护."
	slowdown = 1

//space santa
/obj/item/clothing/head/helmet/space/santahat
	name = "圣诞帽"
	desc = "吼吼吼. 圣诞快乐!"
	icon_state = "santahat"
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = HIDEEYES
	armor_protection_flags = HEAD

/obj/item/clothing/suit/space/santa
	name = "圣诞服"
	desc = "节日快乐!"
	icon_state = "santa"
	slowdown = 0
	allowed = list(/obj/item) //for stuffing exta special presents
