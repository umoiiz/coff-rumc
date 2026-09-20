/obj/item/clothing/head/chefhat
	name = "厨师帽"
	desc = "一顶厨师用来防止头发掉进食物里的帽子. 从食堂的食物来看,它们没什么用."
	icon_state = "chefhat"
	worn_icon_state = "chefhat"
	desc = "厨师头饰中的指挥官."
	siemens_coefficient = 0.9
	species_exception = list(/datum/species/robot)

//Captain: This probably shouldn't be space-worthy
/obj/item/clothing/head/helmet/cap
	name = "舰长帽"
	desc = "你害怕戴上它,因为它会带来疏忽职守."
	icon_state = "capcap"
	inventory_flags = NONE
	inv_hide_flags = NONE
	armor_protection_flags = NONE
	cold_protection_flags = HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.9
	armor_protection_flags = NONE
	species_exception = list(/datum/species/robot)

//Chaplain
/obj/item/clothing/head/chaplain_hood
	name = "牧师兜帽"
	desc = "一顶遮盖头部的兜帽. 它能在太空寒冬中为你保暖."
	icon_state = "chaplain_hood"
	inventory_flags = COVEREYES
	inv_hide_flags = HIDEEARS|HIDEALLHAIR
	siemens_coefficient = 0.9
	armor_protection_flags = HEAD|EYES
	species_exception = list(/datum/species/robot)

//Chaplain
/obj/item/clothing/head/nun_hood
	name = "修女兜帽"
	desc = "这个星系中最虔诚的象征."
	icon_state = "nun_hood"
	inventory_flags = COVEREYES
	inv_hide_flags = HIDEEARS|HIDEALLHAIR
	siemens_coefficient = 0.9
	species_exception = list(/datum/species/robot)

//Mime
/obj/item/clothing/head/beret
	name = "贝雷帽"
	desc = "一顶贝雷帽,艺术家的最爱头饰."
	icon_state = "beret"
	siemens_coefficient = 0.9
	species_exception = list(/datum/species/robot)
	soft_armor = MARINE_HAT_ARMOR
	armor_features_flags = ARMOR_NO_DECAP

//Security
/obj/item/clothing/head/beret/sec
	name = "安保贝雷帽"
	desc = "一顶印有安保徽章的贝雷帽. 适合那些更注重风格而非安全的军官."
	icon_state = "beret_badge"
/obj/item/clothing/head/beret/sec/alt
	name = "军官贝雷帽"
	desc = "一顶带有军官军衔徽章的海军蓝贝雷帽. 适合那些更注重风格而非安全的军官."
	icon_state = "officerberet"
/obj/item/clothing/head/beret/sec/hos
	name = "军官贝雷帽"
	desc = "一顶带有指挥官军衔徽章的海军蓝贝雷帽. 适合那些更注重风格而非安全的军官."
	icon_state = "hosberet"
/obj/item/clothing/head/beret/sec/warden
	name = "典狱长贝雷帽"
	desc = "一顶带有典狱长军衔徽章的海军蓝贝雷帽. 适合那些更注重风格而非安全的军官."
	icon_state = "wardenberet"
/obj/item/clothing/head/beret/eng
	name = "工程贝雷帽"
	desc = "一顶印有工程徽章的贝雷帽. 适合那些更注重风格而非安全的工程师."
	icon_state = "e_beret_badge"

/obj/item/clothing/head/beret/jan
	name = "紫色贝雷帽"
	desc = "一顶时尚的贝雷帽,就是有点紫."
	icon_state = "purpleberet"

//Medical
/obj/item/clothing/head/surgery
	name = "手术帽"
	desc = "外科医生在手术时佩戴的帽子. 防止他们的头发挠到你的内脏."
	icon_state = "surgcap_blue"
	inv_hide_flags = HIDETOPHAIR
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/surgery/purple
	desc = "外科医生在手术时佩戴的帽子. 防止他们的头发挠到你的内脏. 这一顶是深紫色的."
	icon_state = "surgcap_purple"

/obj/item/clothing/head/surgery/blue
	desc = "外科医生在手术时佩戴的帽子. 防止他们的头发挠到你的内脏. 这一顶是浅蓝色的."
	icon_state = "surgcap_blue"

/obj/item/clothing/head/surgery/green
	desc = "外科医生在手术时佩戴的帽子. 防止他们的头发挠到你的内脏. 这一顶是深绿色的."
	icon_state = "surgcap_green"

//Detective

/obj/item/clothing/head/det_hat
	name = "帽子"
	desc = "戴上它的人会显得非常聪明."
	icon_state = "detective"
	allowed = list(/obj/item/reagent_containers/food/snacks/candy_corn, /obj/item/tool/pen)
	soft_armor = MARINE_HAT_ARMOR
	siemens_coefficient = 0.9
	armor_protection_flags = NONE
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/det_hat/black
	icon_state = "detective2"
