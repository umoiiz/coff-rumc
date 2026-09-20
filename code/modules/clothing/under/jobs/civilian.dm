/obj/item/clothing/under/rank/bartender
	desc = "看起来它还能再花哨一点."
	name = "酒保制服"
	icon_state = "barman"
	adjustment_variants = list()

/obj/item/clothing/under/rank/captain //Alright, technically not a 'civilian' but its better then giving a .dm file for a single define.
	desc = "这是一件带有金色标记的蓝色连体服,标记代表\"上尉\"的军衔."
	name = "上尉连体服"
	icon_state = "captain"

/obj/item/clothing/under/rank/cargo
	name = "军需官连体服"
	desc = "这是军需官穿的连体服.它经过特殊设计,可以防止因推文件而导致的背部损伤."
	icon_state = "qm"
	worn_icon_state = "lb_suit"

/obj/item/clothing/under/rank/cargotech
	name = "货物技术员连体服"
	desc = "短裤裤裤!穿着舒适,方便活动!"
	icon_state = "cargotech"
	worn_icon_state = "lb_suit"
	armor_protection_flags = CHEST|GROIN|ARMS

/obj/item/clothing/under/rank/chaplain
	desc = "这是一件黑色连体服,通常由宗教人士穿着."
	name = "随军牧师连体服"
	icon_state = "chaplain"
	worn_icon_state = "bl_suit"
	adjustment_variants = list()

/obj/item/clothing/under/rank/chef
	desc = "这是一条围裙,只发给最<b>硬核</b>的厨师."
	name = "厨师制服"
	icon_state = "chef"

/obj/item/clothing/under/rank/chef/altchef
	name = "红色厨师服"
	desc = "一件更花哨的厨师服,虽然有点不实用."
	icon_state = "altchef"

/obj/item/clothing/under/rank/clown
	name = "小丑服"
	desc = "<i>'HONK!'</i>"
	icon_state = "clown"
	adjustment_variants = list()

/obj/item/clothing/under/rank/clown/erp
	name = "强化小丑服"
	desc = "<b><i>'HONK!'</i></b>"
	has_sensor = 2
	siemens_coefficient = 0.9
	attachments_allowed = list(/obj/item/armor_module/storage/uniform/webbing/erp)
	starting_attachments = list(/obj/item/armor_module/storage/uniform/webbing/erp)

/obj/item/clothing/under/rank/head_of_personnel
	desc = "这是一件连体服,由担任\"人事主管\"职位的人穿着."
	name = "人事主管连体服"
	icon_state = "hop"
	worn_icon_state = "b_suit"

/obj/item/clothing/under/rank/head_of_personnel_whimsy
	desc = "一件蓝色夹克配红色领带,还有相配的红色袖口!时髦.穿上它让你感觉比你的职位头衔更重要."
	name = "人事主管套装"
	icon_state = "hopwhimsy"
	adjustment_variants = list()

/obj/item/clothing/under/rank/hydroponics
	desc = "这是一件连体服,旨在防护轻微的植物相关危害."
	name = "植物学家连体服"
	icon_state = "hydroponics"
	worn_icon_state = "g_suit"
	permeability_coefficient = 0.50

/obj/item/clothing/under/rank/internalaffairs
	desc = "内部事务特工的朴素专业着装.衣领浆得<i>一丝不苟</i>."
	name = "内部事务制服"
	icon_state = "internalaffairs"
	adjustment_variants = list()

/obj/item/clothing/under/rank/janitor
	desc = "这是空间站清洁工的官方制服.它对生物危害有轻微防护."
	name = "清洁工连体服"
	icon_state = "janitor"

/obj/item/clothing/under/lawyer
	desc = "时髦的衣服."
	name = "律师套装"
	adjustment_variants = list()

/obj/item/clothing/under/lawyer/black
	name = "黑色律师套装"
	icon_state = "lawyer_black"

/obj/item/clothing/under/lawyer/female
	name = "黑色律师套装"
	icon_state = "black_suit_fem"

/obj/item/clothing/under/lawyer/red
	name = "红色律师套装"
	icon_state = "lawyer_red"

/obj/item/clothing/under/lawyer/blue
	name = "蓝色律师套装"
	icon_state = "lawyer_blue"

/obj/item/clothing/under/lawyer/bluesuit
	name = "蓝色套装"
	desc = "一套优雅的西装和领带"
	icon_state = "bluesuit"

/obj/item/clothing/under/lawyer/purpsuit
	name = "紫色套装"
	icon_state = "lawyer_purp"
	adjustment_variants = list()

/obj/item/clothing/under/lawyer/oldman
	name = "老人套装"
	desc = "一套经典西装,适合年长绅士,内置背部支撑."
	icon_state = "oldman"

/obj/item/clothing/under/librarian
	name = "得体套装"
	desc = "它非常...得体."
	icon_state = "red_suit"
	adjustment_variants = list()

/obj/item/clothing/under/mime
	name = "哑剧演员服装"
	desc = "它不太鲜艳."
	icon_state = "mime"
	adjustment_variants = list()

/obj/item/clothing/under/rank/miner
	desc = "这是一件利落的连体服,配有一套结实的工装裤.它非常脏."
	name = "矿工连体服"
	icon_state = "miner"
