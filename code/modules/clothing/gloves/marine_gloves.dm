/obj/item/clothing/gloves/marine
	name = "陆战队战斗手套"
	desc = "标准配发的陆战队战术手套. 上面写着: \"由陆战队寡妇协会编织\"."
	icon_state = "gloves_marine"
	siemens_coefficient = 0.6
	permeability_coefficient = 0.05
	cold_protection_flags = HANDS
	heat_protection_flags = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
	armor_protection_flags = HANDS
	soft_armor = list(MELEE = 25, BULLET = 15, LASER = 10, ENERGY = 15, BOMB = 15, BIO = 5, FIRE = 15, ACID = 15)

/obj/item/clothing/gloves/marine/fingerless
	name = "露指陆战队战斗手套"
	desc = "标准配发的陆战队战术手套, 但是露指的! 上面写着: \"由陆战队寡妇协会编织\"."
	icon_state = "gloves_marine_fingerless"
	worn_icon_state = "fingerless"

/obj/item/clothing/gloves/marine/hyperscale
	name = "8E 变色龙TGMC战斗手套"
	desc = "标准配发的陆战队战术手套, 但可以用面部涂装染色! 上面写着: \"由陆战队寡妇协会编织\"."
	icon_state = "hyperscale_glove_inhand"
	worn_icon_state = "hyperscale_glove_mob"
	greyscale_colors = ARMOR_PALETTE_BLACK
	greyscale_config = /datum/greyscale_config/marine_uniform
	colorable_colors = ARMOR_PALETTES_LIST
	colorable_allowed = ICON_STATE_VARIANTS_ALLOWED|PRESET_COLORS_ALLOWED


/obj/item/clothing/gloves/marine/hyperscale/color_item(obj/item/facepaint/paint, mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human = user
	human.regenerate_icons()

/obj/item/clothing/gloves/marine/black
	name = "黑色陆战队战斗手套"
	desc = "标准配发的陆战队战术手套, 但是黑色的! 上面写着: \"由陆战队寡妇协会编织\"."
	icon_state = "gloves_marine_black"
	worn_icon_state = "black"

/obj/item/clothing/gloves/marine/insulated
	name = "绝缘陆战队战斗手套"
	desc = "绝缘的陆战队战术手套, 可抵御电击."
	icon_state = "gloves_marine_insulated"
	siemens_coefficient = 0

/obj/item/clothing/gloves/marine/officer
	name = "军官手套"
	desc = "闪亮而气派. 看起来就很昂贵."
	icon_state = "black"

/obj/item/clothing/gloves/marine/officer/chief
	name = "指挥官手套"
	desc = "金属铆钉上附着着血痂, 铆钉略有凹陷."

/obj/item/clothing/gloves/marine/officer/chief/sa
	name = "空间特工手套"
	desc = "空间特工佩戴的手套."
	siemens_coefficient = 0
	permeability_coefficient = 0
	item_flags = DELONDROP

/obj/item/clothing/gloves/marine/techofficer
	name = "技术军官手套"
	desc = "无菌且绝缘! 为什么不是每个人都配发这些呢?"
	icon_state = "yellow"
	siemens_coefficient = 0
	permeability_coefficient = 0.01

/obj/item/clothing/gloves/marine/techofficer/captain
	name = "上尉手套"
	desc = "你可能喜欢这些手套, 但\"它们\"认为你配不上."
	icon_state = "captain"

/obj/item/clothing/gloves/marine/specialist
	name = "\improper B18防御护手"
	desc = "一副重装甲手套."
	icon_state = "armored"
	item_flags = SYNTH_RESTRICTED
	soft_armor = list(MELEE = 35, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 25, BIO = 15, FIRE = 15, ACID = 20)
	resistance_flags = UNACIDABLE

/obj/item/clothing/gloves/marine/veteran/pmc
	name = "装甲手套"
	desc = "用于特种作战的装甲手套. 它们同样可以绝缘防电击."
	icon_state = "black"
	siemens_coefficient = 0
	item_flags = SYNTH_RESTRICTED
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 15)

/obj/item/clothing/gloves/marine/veteran/pmc/commando
	name = "\improper PMC突击队手套"
	desc = "一副重装甲, 绝缘, 耐酸的手套."
	icon_state = "death_squad"
	soft_armor = list(MELEE = 40, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, FIRE = 20, ACID = 25)
	resistance_flags = UNACIDABLE

/obj/item/clothing/gloves/marine/som
	name = "\improper SOM手套"
	desc = "起源可追溯到旧采矿殖民地的手套, 看起来相当结实."
	icon_state = "som"

/obj/item/clothing/gloves/marine/som/insulated
	name = "\improper 绝缘SOM手套"
	desc = "起源可追溯到旧采矿殖民地的手套. 这些似乎内置了电绝缘层."
	siemens_coefficient = 0

/obj/item/clothing/gloves/marine/som/veteran
	name = "\improper SOM老兵手套"
	desc = "起源可追溯到旧采矿殖民地的手套. 这些似乎比普通的更结实."
	icon_state = "som_veteran"
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 15, ENERGY = 20, BOMB = 15, BIO = 5, FIRE = 15, ACID = 15)

/obj/item/clothing/gloves/marine/som/officer
	name = "\improper SOM手套"
	desc = "SOM军官常戴的黑色手套."
	icon_state = "som_officer_gloves"

/obj/item/clothing/gloves/marine/icc
	name = "\improper ICC手套"
	desc = "看起来结实的工作手套."
	icon_state = "icc"

/obj/item/clothing/gloves/marine/icc/insulated
	name = "\improper ICC绝缘手套"
	desc = "看起来结实的工作手套. 这双似乎带有绝缘层, 可以防止电击."
	siemens_coefficient = 0

/obj/item/clothing/gloves/marine/icc/guard
	name = "\improper ICCGF手套"
	desc = "看起来结实的战术手套."
	icon_state = "icc_guard"
	soft_armor = list(MELEE = 30, BULLET = 20, LASER = 15, ENERGY = 20, BOMB = 15, BIO = 5, FIRE = 15, ACID = 15)

/obj/item/clothing/gloves/marine/commissar
	name = "\improper 政委手套"
	desc = "帝国陆军政委戴的手套, 这样他们的双手就不会沾上自己人的鲜血."
	icon_state = "red"
	soft_armor = list(MELEE = 35, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 15, BIO = 10, FIRE = 20, ACID = 20)

/obj/item/clothing/gloves/marine/separatist
	name = "凯夫拉手套 TG-94"
	desc = "曾几何时, 这双手套的原型在泰拉殖民地平民民兵英勇解放领土的战斗中保护了他们的双手. 底部刻着: '荣耀地佩戴它'"
	icon_state = "separatist"
	worn_icon_state = "separatist"

/obj/item/clothing/gloves/marine/veteran/marine
	name = "老兵手套"
	desc = "普通的陆战队手套, 为了个人利益而巧妙地加固过. 一块额外的钢板和一对酷炫的白色鞋带肯定能让这件物品更好看. 你确信如此. 陆战队遗孀协会对此感到愤怒."
	icon_state = "veteran_1"
	worn_icon_state = "veteran"
	var/gloves_inside_out = FALSE

/obj/item/clothing/gloves/marine/veteran/marine/examine(mob/user)
	. = ..()
	. += span_info("你可以在手中<b>使用它</b>来将其翻面并改变外观.")

/obj/item/clothing/gloves/marine/veteran/marine/attack_self(mob/user)
	. = ..()
	if(!gloves_inside_out)
		to_chat(user, span_notice("你把手套翻了过来, 改变了它们的外观."))
		gloves_inside_out = TRUE
	else
		to_chat(user, span_notice("你把手套翻了回去, 它们看起来刚刚好."))
		gloves_inside_out = initial(gloves_inside_out)
	update_icon_state()

/obj/item/clothing/gloves/marine/veteran/marine/update_icon_state()
	if(gloves_inside_out)
		icon_state = "veteran_2"
	else
		icon_state = "veteran_1"

/obj/item/clothing/gloves/marine/mp
	name = "安保战斗手套"
	desc = "标准配发的宪兵战术手套. 上面写着: '由陆战队遗孀协会编织'."
	soft_armor = list(MELEE = 15, BULLET = 80, LASER = 80, ENERGY = 0, BOMB = 0, BIO = 90, FIRE = 0, ACID = 0)
