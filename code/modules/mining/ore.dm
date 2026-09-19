/obj/item/ore
	name = "岩石"
	icon = 'icons/obj/mining.dmi'
	icon_state = "ore2"
	var/oretag

/obj/item/ore/uranium
	name = "沥青铀矿"
	icon_state = "Uranium ore"
	oretag = "uranium"

/obj/item/ore/iron
	name = "赤铁矿"
	icon_state = "Iron ore"
	oretag = "hematite"

/obj/item/ore/coal
	name = "碳质岩"
	icon_state = "Coal ore"
	oretag = "coal"

/obj/item/ore/glass
	name = "不纯硅酸盐"
	icon_state = "Glass ore"
	oretag = "sand"

/obj/item/ore/phoron
	name = "福龙晶体"
	icon_state = "Phoron ore"
	oretag = "phoron"

/obj/item/ore/silver
	name = "天然银矿石"
	icon_state = "Silver ore"
	oretag = "silver"

/obj/item/ore/gold
	name = "天然金矿石"
	icon_state = "Gold ore"
	oretag = "gold"

/obj/item/ore/diamond
	name = "钻石"
	icon_state = "Diamond ore"
	oretag = "diamond"

/obj/item/ore/osmium
	name = "粗铂"
	icon_state = "Platinum ore"
	oretag = "platinum"

/obj/item/ore/hydrogen
	name = "粗氢"
	icon_state = "Phazon"
	oretag = "hydrogen"

/obj/item/ore/slag
	name = "矿渣"
	desc = "完全无用"
	icon_state = "slag"
	oretag = "slag"

/obj/item/ore/Initialize(mapload)
	. = ..()
	pixel_x = rand(-8, 8)
	pixel_y = rand(-4, 4)
