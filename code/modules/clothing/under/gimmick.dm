/obj/item/clothing/under/gimmick
	has_sensor = 0
	displays_id = 0

//JASON
/obj/item/clothing/under/gimmick/jason
	name = "脏工作服"
	desc = "挖坟墓时的完美穿着."
	icon_state = "jason_suit"

/obj/item/clothing/mask/gimmick/jason
	name = "曲棍球面具"
	desc = "闻起来有少年心气."
	icon_state = "jason_mask"
	anti_hug = 100

/obj/item/clothing/suit/gimmick/jason
	name = "发霉的夹克"
	desc = "杀手级的时尚宣言."
	icon_state = "jason_jacket"
	worn_icon_state = "jason_jacket"
	soft_armor = list(MELEE = 13, BULLET = 13, LASER = 13, ENERGY = 13, BOMB = 13, BIO = 13, FIRE = 13, ACID = 13)

//RAMBO
/obj/item/clothing/under/gimmick/rambo
	name = "作战裤"
	desc = "当一个男人对抗全世界时唯一需要的东西."
	icon_state = "rambo_suit"
	armor_protection_flags = LEGS|GROIN
	cold_protection_flags = LEGS|GROIN
	heat_protection_flags = LEGS|GROIN

/obj/item/clothing/suit/gimmick/rambo
	name = "吊坠"
	desc = "这是一块宝石, 也算是一种护身符."
	armor_protection_flags = CHEST
	cold_protection_flags = CHEST
	heat_protection_flags = CHEST
	icon_state = "rambo_pendant"

//MCCLANE
/obj/item/clothing/under/gimmick/mcclane
	name = "节日装束"
	desc = "和家人共度圣诞假期的完美装扮. 不包含鞋子."
	icon_state = "mcclane_suit"
	armor_protection_flags = CHEST|GROIN|LEGS
	cold_protection_flags = CHEST|GROIN|LEGS
	heat_protection_flags = CHEST|GROIN|LEGS

//DUTCH
/obj/item/clothing/under/gimmick/dutch
	name = "作战 fatigues"
	desc = "又一套用于丛林艰苦巡逻的军用 fatigues."
	icon_state = "dutch_suit"
	armor_protection_flags = LEGS|GROIN
	cold_protection_flags = LEGS|GROIN
	heat_protection_flags = LEGS|GROIN

/obj/item/clothing/suit/armor/gimmick/dutch
	name = "装甲夹克"
	desc = "丛林里很热. 有时又热又闷, 有时则是人间地狱."
	icon_state = "dutch_armor"
	armor_protection_flags = CHEST
	cold_protection_flags = CHEST
	heat_protection_flags = CHEST
	soft_armor = list(MELEE = 45, BULLET = 45, LASER = 35, ENERGY = 25, BOMB = 25, BIO = 0, FIRE = 25, ACID = 25)
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/flashlight,
		/obj/item/ammo_magazine/,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/explosive/grenade,
		/obj/item/binoculars,
		/obj/item/weapon/combat_knife,
		/obj/item/attachable/bayonetknife,
		/obj/item/storage/belt/sparepouch,
		/obj/item/storage/holster/blade,
	)

//ROBOCOP
/obj/item/clothing/under/gimmick/robocop
	name = "金属身体"
	desc = "它或许是金属的, 但其中蕴含着 Alex J. Murphy 的心与灵魂."
	icon_state = "robocop_suit"
	atom_flags = CONDUCT

/obj/item/clothing/shoes/gimmick/robocop
	name = "抛光金属靴"
	desc = "完美尺寸, 用来踩踏底特律的人渣."
	icon_state = "robocop_shoes"
	soft_armor = list(MELEE = 87, BULLET = 87, LASER = 87, ENERGY = 87, BOMB = 87, BIO = 50, FIRE = 87, ACID = 87)
	inventory_flags = CONDUCT|NOSLIPPING

/obj/item/clothing/gloves/gimmick/robocop
	name = "金属手"
	desc = "法律那冰冷无情的双手."
	icon_state = "black"
	atom_flags = CONDUCT
	soft_armor = list(MELEE = 87, BULLET = 87, LASER = 87, ENERGY = 87, BOMB = 87, BIO = 50, FIRE = 87, ACID = 87)

/obj/item/clothing/head/helmet/gimmick/robocop
	name = "抛光金属头盔"
	desc = "法律那不带个人感情的面孔. 由钛制成并层压凯夫拉."
	icon_state = "robocop_helmet"
	worn_icon_state = "robocop_helmet"
	soft_armor = list(MELEE = 87, BULLET = 87, LASER = 87, ENERGY = 87, BOMB = 87, BIO = 50, FIRE = 87, ACID = 87)
	inventory_flags = COVEREYES|BLOCKSHARPOBJ
	inv_hide_flags = HIDEEARS|HIDEEYES|HIDETOPHAIR
	anti_hug = 100

/obj/item/clothing/suit/armor/gimmick/robocop
	name = "抛光金属护甲"
	desc = "干净且维护良好, 不像底特律那些丑陋的街道. 由钛制成并层压凯夫拉."
	icon_state = "robocop_armor"
	worn_icon_state = "robocop_armor"
	slowdown = 1
	atom_flags = CONDUCT
	inventory_flags = BLOCKSHARPOBJ
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS
	cold_protection_flags = CHEST|GROIN|ARMS|LEGS
	heat_protection_flags = CHEST|GROIN|ARMS|LEGS
	allowed = list(/obj/item/weapon/gun/pistol/auto9)
	soft_armor = list(MELEE = 87, BULLET = 87, LASER = 87, ENERGY = 87, BOMB = 87, BIO = 50, FIRE = 87, ACID = 87)

//LUKE
/obj/item/clothing/under/gimmick/skywalker
	name = "黑色连体服"
	desc = "一件简单实用的连体服, 由一位掌握原力的人穿着."
	icon_state = "skywalker_suit"

/obj/item/clothing/shoes/gimmick/skywalker
	name = "黑色靴子"
	desc = "功能完美, 这双靴子曾踩踏过许多星球和星舰."
	icon_state = "skywalker_shoes"
	inventory_flags = NOSLIPPING

/obj/item/clothing/gloves/gimmick/skywalker
	name = "黑色手套"
	desc = "用来遮住那只人造手的东西... 谁说英雄就不能有自我意识呢?"
	icon_state = "skywalker_gloves"

/obj/item/clothing/under/gimmick/rank/captain/suit
	name = "舰长制服"
	desc = "一套绿色西装和黄色领带. 彰显权威."
	icon_state = "green_suit"
	worn_icon_state = "dg_suit"

/obj/item/clothing/under/gimmick/rank/head_of_personnel/suit
	name = "人事主管制服"
	desc = "一套青色西装和黄色领带. 既有权威又俗气的搭配."
	icon_state = "teal_suit"
	worn_icon_state = "g_suit"
