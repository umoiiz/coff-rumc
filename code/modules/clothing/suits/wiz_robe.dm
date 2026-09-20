/obj/item/clothing/head/wizard
	name = "巫师帽"
	desc = "造型奇特的帽子,绝对属于一位真正的魔法使用者。"
	icon_state = "wizard"
	//Not given any special protective value since the magic robes are full-body protection --NEO
	siemens_coefficient = 0.8
	armor_protection_flags = NONE

/obj/item/clothing/head/wizard/red
	name = "红色巫师帽"
	desc = "造型奇特的红帽子,绝对属于一位真正的魔法使用者。"
	icon_state = "redwizard"

/obj/item/clothing/head/wizard/fake
	name = "巫师帽"
	desc = "上面用亮片拼着WIZZARD字样。附带一把酷炫的胡子。"
	icon_state = "wizard-fake"
	armor_protection_flags = HEAD|FACE

/obj/item/clothing/head/wizard/marisa
	name = "女巫帽"
	desc = "造型奇特的帽子,让你想扔火球。"
	icon_state = "marisa"

/obj/item/clothing/head/wizard/cap
	name = "绅士帽"
	desc = "一顶用最稀有丝线编织的灰色格纹鸭舌帽。"
	icon_state = "gentcap"

/obj/item/clothing/suit/wizrobe
	name = "巫师袍"
	desc = "一件华丽的镶宝石长袍,似乎散发着力量。"
	icon_state = "wizard"
	worn_icon_state = "wizrobe"
	gas_transfer_coefficient = 0.01 // IT'S MAGICAL OKAY JEEZ +1 TO NOT DIE
	permeability_coefficient = 0.01
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 20, BIO = 20, FIRE = 20, ACID = 20)
	inv_hide_flags = HIDEJUMPSUIT
	siemens_coefficient = 0.8

/obj/item/clothing/suit/wizrobe/red
	name = "红色巫师袍"
	desc = "一件华丽的红色镶宝石长袍,似乎散发着力量。"
	icon_state = "redwizard"
	worn_icon_state = "redwizrobe"

/obj/item/clothing/suit/wizrobe/marisa
	name = "女巫袍"
	desc = "魔法全靠法术强度,ZE!"
	icon_state = "marisa"
	worn_icon_state = "marisarobe"

/obj/item/clothing/suit/storage/wizrobe/gentlecoat
	name = "绅士外套"
	desc = "一件厚重的灰色粗花呢夹克。适合另一种绅士。"
	icon_state = "gentlecoat"
	worn_icon_state = "gentlecoat"
	armor_protection_flags = CHEST|GROIN|ARMS
	inv_hide_flags = NONE

/obj/item/clothing/suit/wizrobe/fake
	name = "巫师袍"
	desc = "一件相当朴素的蓝色长袍,用来模仿真正的巫师袍。"
	icon_state = "wizard-fake"
	worn_icon_state = "wizrobe"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	siemens_coefficient = 1

/obj/item/clothing/head/wizard/marisa/fake
	name = "女巫帽"
	desc = "造型奇特的帽子,让你想扔火球。"
	icon_state = "marisa"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	siemens_coefficient = 1

/obj/item/clothing/suit/wizrobe/marisa/fake
	name = "女巫袍"
	desc = "魔法全靠法术强度,ZE!"
	icon_state = "marisa"
	worn_icon_state = "marisarobe"
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	siemens_coefficient = 1

