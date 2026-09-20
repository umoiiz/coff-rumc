/obj/structure/lamarr
	name = "实验室笼子"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "labcage1"
	desc = "一个用于存放有趣生物的玻璃实验室容器."
	density = TRUE
	anchored = TRUE
	resistance_flags = UNACIDABLE
	max_integrity = 30
	var/occupied = FALSE

/obj/structure/lamarr/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	new /obj/item/shard(loc)
	if(occupied)
		new /obj/item/clothing/mask/facehugger/lamarr(loc)
		occupied = FALSE
		icon_state = "labcageb0"
	if(disassembled)
		return ..()

/obj/structure/lamarr/destroyed
	icon_state = "labcageb0"
	density = FALSE
	occupied = FALSE

/obj/structure/lamarr/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.visible_message(span_warning("[user]踢了实验室笼子."), span_notice("你踢了实验室笼子."))
	take_damage(2, BRUTE, MELEE)

/obj/item/clothing/mask/facehugger/lamarr
	name = "拉玛"
	desc = "她最坏也不过是试图...和你的脑袋交配."//hope we don't get sued over a harmless reference, rite?
	sterile = TRUE
	gender = FEMALE

/obj/item/clothing/mask/facehugger/lamarr/check_lifecycle()
	return TRUE
