/obj/item/ashtray
	icon = 'icons/obj/items/ashtray.dmi'
	var/max_butts = 0
	var/empty_desc = ""
	var/icon_empty = ""
	var/icon_half = ""
	var/icon_full = ""


/obj/item/ashtray/Initialize(mapload)
	. = ..()
	pixel_y = rand(-5, 5)
	pixel_x = rand(-6, 6)

/obj/item/ashtray/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
		
	if(istype(I, /obj/item/trash/cigbutt) || istype(I, /obj/item/clothing/mask/cigarette) || istype(I, /obj/item/tool/match))
		if(length(contents) >= max_butts)
			to_chat(user, "这个烟灰缸满了.")
			return

		user.transferItemToLoc(I, src)

		if(istype(I, /obj/item/clothing/mask/cigarette))
			var/obj/item/clothing/mask/cigarette/cig = I
			if(!cig.heat)
				to_chat(user, "你甚至都没抽,就不能把[cig]放进[src]里.你为什么要那样做?")
				return

			visible_message("[user]在[src]中碾碎了[cig],把它熄灭了.")
			STOP_PROCESSING(SSobj, cig)
			new cig.type_butt(src)
			qdel(cig)

		visible_message("[user]把[I]放进了[src].")


/obj/item/ashtray/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	visible_message(span_warning("[src]碎了,内容物洒了出来!"))
	for(var/i in contents)
		var/atom/movable/AM = i
		AM.forceMove(loc)
	return ..()

/obj/item/ashtray/update_desc(updates)
	. = ..()
	if(length(contents) >= max_butts)
		desc = empty_desc + " It's stuffed full."
		return

	if(length(contents) >= max_butts * 0.5)
		desc = empty_desc + " It's half-filled."
		return

	desc = empty_desc

/obj/item/ashtray/update_icon_state()
	. = ..()
	if(length(contents) >= max_butts)
		icon_state = icon_full
		return

	if(length(contents) >= max_butts * 0.5)
		icon_state = icon_half
		return

	icon_state = icon_empty

/obj/item/ashtray/plastic
	name = "塑料烟灰缸"
	desc = "廉价的塑料烟灰缸."
	icon_state = "ashtray_bl"
	icon_empty = "ashtray_bl"
	icon_half = "ashtray_half_bl"
	icon_full = "ashtray_full_bl"
	max_butts = 14
	max_integrity = 24
	empty_desc = "Cheap plastic ashtray."
	throwforce = 3


/obj/item/ashtray/bronze
	name = "青铜烟灰缸"
	desc = "巨大的青铜烟灰缸."
	icon_state = "ashtray_br"
	icon_empty = "ashtray_br"
	icon_half = "ashtray_half_br"
	icon_full = "ashtray_full_br"
	max_butts = 10
	max_integrity = 72
	empty_desc = "Massive bronze ashtray."
	throwforce = 10


/obj/item/ashtray/glass
	name = "玻璃烟灰缸"
	desc = "玻璃烟灰缸.看起来很脆弱."
	icon_state = "ashtray_gl"
	icon_empty = "ashtray_gl"
	icon_half = "ashtray_half_gl"
	icon_full = "ashtray_full_gl"
	max_butts = 12
	max_integrity = 12
	empty_desc = "Glass ashtray. Looks fragile."
	throwforce = 6
