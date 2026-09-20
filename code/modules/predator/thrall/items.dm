/obj/item/clothing/suit/armor/yautja/thrall
	name = "异形护甲"
	desc = "由碎布片和一种奇异合金制成的护甲. 它摸起来冰冷, 带着一种异形的重量感. 它已被改装以携带人类和异形的近战武器."

	icon = 'icons/obj/hunter/thrall_gear.dmi'
	icon_state = "chest1_cloth"
	worn_icon_state = "chest1_cloth"
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/hunter/thrall_gear.dmi'
	)
	thrall = TRUE

	allowed = list(
		/obj/item/weapon/gun/energy/yautja,
		/obj/item/weapon,
	)

/obj/item/clothing/suit/armor/yautja/thrall/Initialize(mapload, armor_area = pick("shoulders", "chest", "mix"), armor_number = rand(1,3), armor_material = pick("cloth", "bare"))
	if(armor_number > 3)
		armor_number = 1
	if(armor_number)
		icon_state = "[armor_area][armor_number]_[armor_material]"
		LAZYSET(worn_worn_icon_state_slots, slot_wear_suit_str, "[armor_area][armor_number]_[armor_material]")
	return ..()

/obj/item/clothing/shoes/marine/yautja/thrall
	name = "异形护胫"
	desc = "由碎布片和一种奇异合金制成的护胫. 它们摸起来冰冷, 带着一种异形的重量感. 它们已被改装以兼容人类装备."

	icon = 'icons/obj/hunter/thrall_gear.dmi'
	icon_state = "greaves1_cloth"
	worn_icon_list = list(
		slot_shoes_str = 'icons/mob/hunter/thrall_gear.dmi'
	)
	thrall = TRUE

/obj/item/clothing/shoes/marine/yautja/thrall/Initialize(mapload, greaves_number = 1, armor_material = pick("cloth", "bare"))
	if(greaves_number > 1)
		greaves_number = 1
	if(greaves_number)
		icon_state = "greaves[greaves_number]_[armor_material]"
		LAZYSET(worn_worn_icon_state_slots, slot_wear_suit_str, "greaves[greaves_number]_[armor_material]")
	return ..()

/obj/item/clothing/under/chainshirt/thrall
	name = "异形网衣"
	color = "#b85440"
	desc = "一种以背心形式存在的奇异合金织物. 它摸起来冰冷, 带着一种异形的重量感. 它已被改装以适应人类生理结构."

/obj/item/storage/box/bracer
	name = "异形盒子"
	desc = "一个奇怪的、带有符文的盒子."
	color = "#68423b"
	icon = 'icons/obj/structures/closet.dmi'
	icon_state = "pred_coffin"

/obj/item/storage/box/bracer/Initialize(mapload)
	. = ..()
	new /obj/item/clothing/gloves/yautja/thrall(src)
	storage_datum.foldable = FALSE
