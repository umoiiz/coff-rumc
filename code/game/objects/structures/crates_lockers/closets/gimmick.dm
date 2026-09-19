/obj/structure/closet/cabinet
	name = "橱柜"
	desc = "旧物永不过时."
	icon_state = "cabinet_closed"
	icon_closed = "cabinet_closed"
	icon_opened = "cabinet_open"

/obj/structure/closet/cabinet/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_WOOD, -40, 5)

/obj/structure/closet/cabinet/update_icon_state()
	. = ..()
	if(!opened)
		icon_state = icon_closed
	else
		icon_state = icon_opened

/obj/structure/closet/acloset
	name = "奇怪的衣柜"
	desc = "它看起来像外星人的!"
	icon_state = "acloset"
	icon_closed = "acloset"
	icon_opened = "aclosetopen"


/obj/structure/closet/gimmick
	name = "行政用品储物柜"
	desc = "这是一个存放不该出现在这里的东西的储物柜."
	icon_state = "syndicate1"
	icon_closed = "syndicate1"
	icon_opened = "syndicate1open"
	anchored = FALSE

/obj/structure/closet/gimmick/russian
	name = "俄罗斯剩余物资储物柜"
	desc = "这是一个存放俄罗斯标准配发剩余物资的储物柜."
	icon_state = "syndicate1"
	icon_closed = "syndicate1"
	icon_opened = "syndicate1open"

/obj/structure/closet/gimmick/russian/PopulateContents()
	new /obj/item/clothing/head/ushanka(src)
	new /obj/item/clothing/head/ushanka(src)
	new /obj/item/clothing/head/ushanka(src)
	new /obj/item/clothing/head/ushanka(src)
	new /obj/item/clothing/head/ushanka(src)
	new /obj/item/clothing/under/soviet(src)
	new /obj/item/clothing/under/soviet(src)
	new /obj/item/clothing/under/soviet(src)
	new /obj/item/clothing/under/soviet(src)
	new /obj/item/clothing/under/soviet(src)


/obj/structure/closet/gimmick/tacticool
	name = "战术装备储物柜"
	desc = "这是一个存放战术装备的储物柜."
	icon_state = "syndicate1"
	icon_closed = "syndicate1"
	icon_opened = "syndicate1open"

/obj/structure/closet/gimmick/tacticool/PopulateContents()
	new /obj/item/clothing/glasses/eyepatch(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/gloves/swat(src)
	new /obj/item/clothing/gloves/swat(src)
	new /obj/item/clothing/head/helmet/swat(src)
	new /obj/item/clothing/head/helmet/swat(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/shoes/swat(src)
	new /obj/item/clothing/shoes/swat(src)
	new /obj/item/clothing/suit/armor/swat(src)
	new /obj/item/clothing/suit/armor/swat(src)
	new /obj/item/clothing/under/syndicate/tacticool(src)
	new /obj/item/clothing/under/syndicate/tacticool(src)


/obj/structure/closet/thunderdome
	name = "\improper 雷霆穹顶储物柜"
	desc = "你所需的一切!"
	icon_state = "syndicate"
	icon_closed = "syndicate"
	icon_opened = "syndicateopen"
	anchored = TRUE


/obj/structure/closet/thunderdome/tdred
	name = "红队雷霆穹顶储物柜"

/obj/structure/closet/thunderdome/tdred/PopulateContents()
	new /obj/item/clothing/suit/armor/tdome/red(src)
	new /obj/item/clothing/suit/armor/tdome/red(src)
	new /obj/item/clothing/suit/armor/tdome/red(src)
	new /obj/item/weapon/energy/sword(src)
	new /obj/item/weapon/energy/sword(src)
	new /obj/item/weapon/energy/sword(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/clothing/head/helmet/thunderdome(src)
	new /obj/item/clothing/head/helmet/thunderdome(src)
	new /obj/item/clothing/head/helmet/thunderdome(src)

/obj/structure/closet/thunderdome/tdgreen
	name = "绿队雷霆穹顶储物柜"
	icon_state = "syndicate1"
	icon_closed = "syndicate1"
	icon_opened = "syndicate1open"

/obj/structure/closet/thunderdome/tdgreen/PopulateContents()
	new /obj/item/clothing/suit/armor/tdome/green(src)
	new /obj/item/clothing/suit/armor/tdome/green(src)
	new /obj/item/clothing/suit/armor/tdome/green(src)
	new /obj/item/weapon/energy/sword(src)
	new /obj/item/weapon/energy/sword(src)
	new /obj/item/weapon/energy/sword(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/clothing/head/helmet/thunderdome(src)
	new /obj/item/clothing/head/helmet/thunderdome(src)
	new /obj/item/clothing/head/helmet/thunderdome(src)

