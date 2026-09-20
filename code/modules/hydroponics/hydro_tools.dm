//Analyzer, pestkillers, weedkillers, nutrients, hatchets, cutters.

/obj/item/tool/wirecutters/clippers
	name = "植物剪"
	desc = "用于从植物上取样的工具."

/obj/item/tool/analyzer/plant_analyzer
	name = "植物分析仪"
	icon_state = "hydro"
	worn_icon_state = "analyzer"

// *************************************
// Nutrient defines for hydroponics
// *************************************

/obj/item/reagent_containers/glass/fertilizer
	name = "肥料瓶"
	desc = "一个小玻璃瓶. 最多可容纳10单位."
	icon = 'icons/obj/items/chemistry.dmi'
	icon_state = "bottle16"
	possible_transfer_amounts = null
	w_class = WEIGHT_CLASS_SMALL

	var/fertilizer //Reagent contained, if any.

	//Like a shot glass!
	amount_per_transfer_from_this = 10
	volume = 10

/obj/item/reagent_containers/glass/fertilizer/Initialize(mapload)
	. = ..()

	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

	if(fertilizer)
		reagents.add_reagent(fertilizer,10)

/obj/item/reagent_containers/glass/fertilizer/ez
	name = "E-Z营养液瓶"
	icon_state = "bottle16"
	fertilizer = /datum/reagent/toxin/fertilizer/eznutrient

/obj/item/reagent_containers/glass/fertilizer/l4z
	name = "Left 4 Zed瓶"
	icon_state = "bottle18"
	fertilizer = /datum/reagent/toxin/fertilizer/left4zed

/obj/item/reagent_containers/glass/fertilizer/rh
	name = "强效丰收瓶"
	icon_state = "bottle15"
	fertilizer = /datum/reagent/toxin/fertilizer/robustharvest
