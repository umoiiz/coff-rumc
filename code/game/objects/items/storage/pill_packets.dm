// Pill packets, basically pill bottles you can't put pills back into.
/obj/item/storage/pill_bottle/packet
	name = "药片包"
	desc = "内含药片. 一旦取出就无法放回."
	icon_state = "packet_canister"
	storage_type = /datum/storage/pill_bottle/packet
	greyscale_config = null //So that we get packets and not pill bottles.
	///Color of the pips on top of the pill packet
	var/pip_color = "#0066ff" //default color because I like this color
	///the item left behind when this is used up

/obj/item/storage/pill_bottle/packet/update_overlays()
	. = ..()
	var/image/overlay = image('icons/obj/items/chemistry.dmi', src, "packet_canister[length(contents)]")
	overlay.color = pip_color
	. += overlay

/obj/item/storage/pill_bottle/packet/bicaridine
	name = "双环己哌啶药片包"
	desc = "此药片包含双环己哌啶药片. 用于治疗轻微撕裂伤. 一旦取出就无法放回. 一次最多服用2片."
	pill_type_to_fill = /obj/item/reagent_containers/pill/bicaridine
	pip_color = COLOR_PACKET_BICARIDINE

/obj/item/storage/pill_bottle/packet/kelotane
	name = "凯洛坦药片包"
	desc = "此药片包含凯洛坦药片. 用于治疗表面烧伤. 一旦取出就无法放回. 一次最多服用2片."
	pill_type_to_fill = /obj/item/reagent_containers/pill/kelotane
	pip_color = COLOR_PACKET_KELOTANE

/obj/item/storage/pill_bottle/packet/tramadol
	name = "曲马多药片包"
	desc = "此药片包含曲马多药片. 用作中等强度止痛药. 一旦取出就无法放回. 一次最多服用2片."
	pill_type_to_fill = /obj/item/reagent_containers/pill/tramadol
	pip_color = COLOR_PACKET_TRAMADOL

/obj/item/storage/pill_bottle/packet/tricordrazine
	name = "三可定药片包"
	desc = "此药片包含三可定药片. 轻微治疗所有类型的伤害. 一旦取出就无法放回. 一次最多服用2片."
	pill_type_to_fill = /obj/item/reagent_containers/pill/tricordrazine
	pip_color = COLOR_PACKET_TRICORDRAZINE

/obj/item/storage/pill_bottle/packet/dylovene
	name = "二乙烯药片包"
	desc = "此药片包含二乙烯药片. 用于清除毒素并治疗毒素伤害. 一旦取出就无法放回. 一次最多服用2片."
	pill_type_to_fill = /obj/item/reagent_containers/pill/dylovene
	pip_color = COLOR_PACKET_DYLOVENE

/obj/item/storage/pill_bottle/packet/paracetamol
	name = "对乙酰氨基酚药片包"
	desc = "此药片包含对乙酰氨基酚药片, 也称为泰诺. 一种长效但轻微的止痛药. 一旦取出就无法放回. 长时间内最多服用4片."
	pill_type_to_fill = /obj/item/reagent_containers/pill/paracetamol
	pip_color = COLOR_PACKET_PARACETAMOL

/obj/item/storage/pill_bottle/packet/isotonic
	name = "等渗药片包"
	desc = "内含等渗溶液的药片. 用于刺激血液再生. 一旦取出就无法放回."
	pill_type_to_fill = /obj/item/reagent_containers/pill/isotonic
	pip_color = COLOR_PACKET_ISOTONIC

/obj/item/storage/pill_bottle/packet/leporazine
	name = "来普拉嗪药片包"
	desc = "此药片包含来普拉嗪药片. 快速稳定患者的内部温度. 一旦取出就无法放回.."
	pill_type_to_fill = /obj/item/reagent_containers/pill/leporazine
	pip_color = COLOR_PACKET_LEPORAZINE

/obj/item/storage/pill_bottle/packet/russian_red
	name = "俄罗斯红药片包"
	desc = "此药片包含俄罗斯红药片. 用于在没有医疗兵的情况下对危急情况进行现场治疗. 一旦取出就无法放回.."
	pill_type_to_fill = /obj/item/reagent_containers/pill/russian_red
	pip_color = COLOR_PACKET_RUSSIAN_RED

/obj/item/storage/pill_bottle/packet/ryetalyn
	name = "利他林药片包"
	desc = "此药片包含利他林药片. 用于提供对血流毒素的防护. 一旦取出就无法放回. 一次最多服用2片."
	pill_type_to_fill = /obj/item/reagent_containers/pill/ryetalyn
	pip_color = COLOR_PACKET_RYETALYN
