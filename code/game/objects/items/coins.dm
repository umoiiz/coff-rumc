/obj/item/coin
	icon = 'icons/obj/items/items.dmi'
	name = "硬币"
	icon_state = "coin"
	atom_flags = CONDUCT
	w_class = WEIGHT_CLASS_TINY
	var/string_attached
	var/sides = 2

/obj/item/coin/Initialize(mapload)
	. = ..()
	pixel_x = rand(-8, 16)
	pixel_y = rand(-8, 8)

/obj/item/coin/gold
	name = "金币"
	icon_state = "coin_gold"

/obj/item/coin/silver
	name = "银币"
	icon_state = "coin_silver"

/obj/item/coin/diamond
	name = "钻石币"
	icon_state = "coin_diamond"

/obj/item/coin/iron
	name = "铁币"
	icon_state = "coin_iron"

/obj/item/coin/phoron
	name = "固态佛龙币"
	icon_state = "coin_phoron"

/obj/item/coin/uranium
	name = "铀币"
	icon_state = "coin_uranium"

/obj/item/coin/platinum
	name = "铂金币"
	icon_state = "coin_adamantine"

/obj/item/coin/debugtoken
	name = "原型通用代币"
	desc = "一枚特殊的纳米纤维芯片,上面刻有几个微小的标签。在紧急维护场合之外很少见到。"
	icon_state = "coin_clown"

/obj/item/coin/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/CC = I
		if(string_attached)
			to_chat(user, span_notice("这枚硬币上已经系着一根绳子。"))
			return

		if(!CC.use(1))
			to_chat(user, span_notice("这卷线缆似乎是空的。"))
			return

		overlays += image('icons/obj/items/items.dmi',"coin_string_overlay")
		string_attached = TRUE
		to_chat(user, span_notice("你将一根绳子系在硬币上。"))

/obj/item/coin/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()

	if(!string_attached)
		return

	var/obj/item/stack/cable_coil/CC = new(user.loc)
	CC.amount = 1
	CC.update_icon()
	overlays = list()
	string_attached = FALSE
	to_chat(user, span_notice("你将绳子从硬币上解下。"))

/obj/item/coin/attack_self(mob/user as mob)
	var/result = rand(1, sides)
	var/comment = ""
	if(result == 1)
		comment = "tails"
	else if(result == 2)
		comment = "heads"
	user.visible_message(span_notice("[user]将\the 投向[src]。它落在了[comment]上!"), \
						span_notice("你投出\the [src]。它落在了[comment]上!"))
