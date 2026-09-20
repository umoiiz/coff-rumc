
// *************************************
// Hydroponics Tools
// *************************************

/obj/item/tool/plantspray
	icon = 'icons/obj/items/spray.dmi'
	worn_icon_state = "spray"
	item_flags = NOBLUDGEON
	equip_slot_flags = ITEM_SLOT_BELT
	throwforce = 4
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 2
	throw_range = 10
	var/toxicity = 4
	var/pest_kill_str = 0
	var/weed_kill_str = 0

/obj/item/tool/plantspray/weeds // -- Skie

	name = "除草喷雾"
	desc = "一种有毒的喷雾混合物, 用来杀死小杂草."
	icon_state = "weedspray"
	weed_kill_str = 6

/obj/item/tool/plantspray/pests
	name = "杀虫喷雾"
	desc = "这是一些杀虫喷雾! <I>请勿吸入!</I>"
	icon_state = "pestspray"
	pest_kill_str = 6

/obj/item/tool/plantspray/pests/old
	name = "一瓶杀虫剂"
	icon = 'icons/obj/items/chemistry.dmi'
	icon_state = "bottle16"

/obj/item/tool/plantspray/pests/old/carbaryl
	name = "一瓶甲萘威"
	icon_state = "bottle16"
	toxicity = 4
	pest_kill_str = 2

/obj/item/tool/plantspray/pests/old/lindane
	name = "一瓶林丹"
	icon_state = "bottle18"
	toxicity = 6
	pest_kill_str = 4

/obj/item/tool/plantspray/pests/old/phosmet
	name = "一瓶亚胺硫磷"
	icon_state = "bottle15"
	toxicity = 8
	pest_kill_str = 7



/obj/item/tool/weedkiller
	name = "一瓶除草剂"
	icon = 'icons/obj/items/chemistry.dmi'
	icon_state = "bottle16"
	var/toxicity = 0
	var/weed_kill_str = 0

/obj/item/tool/weedkiller/triclopyr
	name = "一瓶草甘膦"
	icon_state = "bottle16"
	toxicity = 4
	weed_kill_str = 2

/obj/item/tool/weedkiller/lindane
	name = "一瓶绿草定"
	icon_state = "bottle18"
	toxicity = 6
	weed_kill_str = 4

/obj/item/tool/weedkiller/D24
	name = "一瓶2,4-D"
	icon_state = "bottle15"
	toxicity = 8
	weed_kill_str = 7




/obj/item/tool/minihoe // -- Numbers
	name = "迷你锄头"
	desc = "用来除草, 或者挠背."
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "hoe"
	worn_icon_state = "hoe"
	atom_flags = CONDUCT
	item_flags = NOBLUDGEON
	force = 5
	throwforce = 7
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("slashes", "slices", "cuts", "claws")




//Hatchets and things to kill kudzu
/obj/item/tool/hatchet
	name = "手斧"
	desc = "一把锋利的手斧, 通常用来劈开东西, 无论是木材还是其他物件. 常出现在伐木工, 侦察兵和拾荒者手中."
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "hatchet"
	atom_flags = CONDUCT
	force = 35
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 25
	throw_speed = 4
	throw_range = 4
	sharp = IS_SHARP_ITEM_BIG
	edge = 1
	attack_verb = list("chops", "tears", "cuts")

/obj/item/tool/hatchet/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 25, 1)
	return ..()


/obj/item/tool/scythe
	name = "镰刀"
	desc = "长纤维金属柄上装着锋利弯曲的刀刃, 这件工具让你轻松收割你所播种的."
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "scythe"
	force = 35
	throwforce = 5
	throw_speed = 1
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BACK
	attack_verb = list("chops", "slices", "cuts", "reaps")

/obj/item/tool/scythe/afterattack(atom/A, mob/user as mob, proximity)
	if(!proximity) return
	if(istype(A, /obj/effect/plantsegment))
		for(var/obj/effect/plantsegment/B in orange(A,1))
			qdel(B)
		qdel(A)
