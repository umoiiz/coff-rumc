/obj/item/clothing/under/rank/bartender
	desc = "它看起来还能再添点风采."
	name = "调酒师制服"
	icon_state = "barman"
	adjustment_variants = list()

/obj/item/clothing/under/rank/captain //Alright, technically not a 'civilian' but its better then giving a .dm file for a single define.
	desc = "这是一件蓝色连体服,上面带有一些金色标记,表示\"舰长\"的军衔."
	name = "舰长连体服"
	icon_state = "captain"

/obj/item/clothing/under/rank/cargo
	name = "军需官连体服"
	desc = "这是军需官穿的连体服.它经过特殊设计,可防止推纸造成的背部损伤."
	icon_state = "qm"
	worn_icon_state = "lb_suit"

/obj/item/clothing/under/rank/cargotech
	name = "货物技术员连体服"
	desc = "短裤!它们舒适又易穿!"
	icon_state = "cargotech"
	worn_icon_state = "lb_suit"
	armor_protection_flags = CHEST|GROIN|ARMS

/obj/item/clothing/under/rank/chaplain
	desc = "这是一件黑色连体服,常为宗教人士所穿."
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
	desc = "一件更花哨的厨师服,虽然有点不太实用."
	icon_state = "altchef"

/obj/item/clothing/under/rank/clown
	name = "小丑服"
	desc = "<i>砰!</i>"
	icon_state = "clown"
	adjustment_variants = list()

/obj/item/clothing/under/rank/clown/erp
	name = "强化小丑服"
	desc = "<b><i>砰!</i></b>"
	has_sensor = 2
	siemens_coefficient = 0.9
	attachments_allowed = list(/obj/item/armor_module/storage/uniform/webbing/erp)
	starting_attachments = list(/obj/item/armor_module/storage/uniform/webbing/erp)

/obj/item/clothing/under/rank/head_of_personnel
	desc = "这是一件连体服,由担任\"人事主管\"职位的人所穿."
	name = "人事主管连体服"
	icon_state = "hop"
	worn_icon_state = "b_suit"

/obj/item/clothing/under/rank/head_of_personnel_whimsy
	desc = "一件蓝色夹克配红色领带,还有相配的红色袖口!真时髦.穿上它让你感觉比你的职位头衔更重要."
	name = "人事主管制服"
	icon_state = "hopwhimsy"
	adjustment_variants = list()

/obj/item/clothing/under/rank/hydroponics
	desc = "这是一件连体服,旨在防护轻微的植物相关危害."
	name = "植物学家连体服"
	icon_state = "hydroponics"
	worn_icon_state = "g_suit"
	permeability_coefficient = 0.50

/obj/item/clothing/under/rank/internalaffairs
	desc = "内务特工朴素而专业的着装.衣领<i>一尘不染</i>地浆洗过."
	name = "内务制服"
	icon_state = "internalaffairs"
	adjustment_variants = list()

/obj/item/clothing/under/rank/janitor
	desc = "这是空间站清洁工的官方制服.它对生物危害有轻微防护."
	name = "清洁工连体服"
	icon_state = "janitor"

/obj/item/clothing/under/lawyer
	desc = "时髦的衣服."
	name = "律师西装"
	adjustment_variants = list()

/obj/item/clothing/under/lawyer/black
	name = "黑色律师西装"
	icon_state = "lawyer_black"

/obj/item/clothing/under/lawyer/female
	name = "黑色律师西装"
	icon_state = "black_suit_fem"

/obj/item/clothing/under/lawyer/red
	name = "红色律师西装"
	icon_state = "lawyer_red"

/obj/item/clothing/under/lawyer/blue
	name = "蓝色律师西装"
	icon_state = "lawyer_blue"

/obj/item/clothing/under/lawyer/bluesuit
	name = "蓝色西装"
	desc = "一套优雅的西装和领带"
	icon_state = "bluesuit"

/obj/item/clothing/under/lawyer/purpsuit
	name = "紫色西装"
	icon_state = "lawyer_purp"
	adjustment_variants = list()

/obj/item/clothing/under/lawyer/oldman
	name = "老人西装"
	desc = "一套经典的老派绅士西装,内置背部支撑."
	icon_state = "oldman"

/obj/item/clothing/under/librarian
	name = "得体西装"
	desc = "它非常...得体."
	icon_state = "red_suit"
	adjustment_variants = list()

/obj/item/clothing/under/mime
	name = "哑剧演员服装"
	desc = "它不是很鲜艳."
	icon_state = "mime"
	adjustment_variants = list()

/obj/item/clothing/under/rank/miner
	desc = "这是一件利落的连体服,配有一套结实的背带裤.它非常脏."
	name = "矿工连体服"
	icon_state = "miner"
