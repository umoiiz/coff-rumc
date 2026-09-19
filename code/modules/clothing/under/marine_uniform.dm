/obj/item/clothing/under/marine
	name = "\improper TGMC 制服"
	desc = "标准配发的, 凯夫拉编织, 经过危险品测试, EMF 增强的陆战队制服. 你怀疑它并不像宣传的那样防弹."
	siemens_coefficient = 0.9
	icon = 'icons/obj/clothing/uniforms/marine_uniforms.dmi'
	icon_state = "marine_jumpsuit"
	worn_icon_list = list(
		slot_w_uniform_str = 'icons/mob/clothing/uniforms/marine_uniforms.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	has_sensor = 2
	adjustment_variants = list(
		"Rolled Sleeves" = "_h",
		"No Sleeves" = "_d",
		"No Top" = "_r",
	)

/obj/item/clothing/under/marine/hyperscale
	name = "\improper 8E 变色龙 TGMC 制服"
	desc = "标准配发的, 凯夫拉编织, 经过危险品测试, EMF 增强的陆战队制服, 但可以用面部涂料染色! 你怀疑它并不像宣传的那样防弹."
	icon_state = "hyperscale_marine_jumpsuit"
	greyscale_colors = ARMOR_PALETTE_BLACK
	greyscale_config = /datum/greyscale_config/marine_uniform
	colorable_colors = ARMOR_PALETTES_LIST
	colorable_allowed = ICON_STATE_VARIANTS_ALLOWED|PRESET_COLORS_ALLOWED

/obj/item/clothing/under/marine/black_vest
	starting_attachments = list(/obj/item/armor_module/storage/uniform/black_vest)

/obj/item/clothing/under/marine/brown_vest
	starting_attachments = list(/obj/item/armor_module/storage/uniform/brown_vest)

/obj/item/clothing/under/marine/corpman_vest
	starting_attachments = list(/obj/item/armor_module/storage/uniform/white_vest)

/obj/item/clothing/under/marine/holster
	starting_attachments = list(/obj/item/armor_module/storage/uniform/holster)

//Squad colored turtlenecks
/obj/item/clothing/under/marine/squad/neck
	name = "\improper TGMC Delta 高领衫"
	desc = "标准配发的 TGMC 高领衫, 蓝色."
	icon_state = "delta_merc"
	adjustment_variants = list(
		"Rolled Sleeves" = "_d",
	)

/obj/item/clothing/under/marine/squad/neck/delta
	name = "\improper TGMC Delta 高领衫"
	desc = "标准配发的 TGMC 高领衫, 蓝色, 带有一丝勇敢的气息."
	icon_state = "delta_merc"

/obj/item/clothing/under/marine/squad/neck/charile
	name = "\improper TGMC Charile 高领衫"
	desc = "标准配发的 TGMC 高领衫, 紫色, 让你想起适当的班组凝聚力如何决定任务的成败."
	icon_state = "charlie_merc"

/obj/item/clothing/under/marine/squad/neck/bravo
	name = "\improper TGMC Bravo 高领衫"
	desc = "标准配发的 TGMC 高领衫, 黄色, 你突然想到如何改进前线作战基地, 哪怕只是一点点."
	icon_state = "bravo_merc"

/obj/item/clothing/under/marine/squad/neck/alpha
	name = "\improper TGMC Alpha 高领衫"
	desc = "标准配发的 TGMC 高领衫, 红色, 你感觉自己仿佛能面对整个世界及其带来的一切挑战."
	icon_state = "alpha_merc"

// camo things stuff yeah!

/obj/item/clothing/under/marine/camo
	name = "\improper TGMC 迷彩 fatigues (丛林)"
	icon_state = "m_marine_jumpsuit"

/obj/item/clothing/under/marine/camo/snow
	name = "\improper TGMC 迷彩 fatigues (雪地)"
	icon_state = "s_marine_jumpsuit"

/obj/item/clothing/under/marine/camo/desert
	name = "\improper TGMC 迷彩 fatigues (沙漠)"
	icon_state = "d_marine_jumpsuit"

/obj/item/clothing/under/marine/corpsman
	name = "\improper TGMC 医护兵 fatigues"
	desc = "标准配发的, 凯夫拉编织, 经过危险品测试, EMF 增强的战斗医护兵 fatigues. 你怀疑它并不像宣传的那样防弹."
	icon_state = "marine_medic"

/obj/item/clothing/under/marine/corpsman/corpman_vest
	starting_attachments = list(/obj/item/armor_module/storage/uniform/white_vest)

/obj/item/clothing/under/marine/engineer
	name = "\improper TGMC 工程师 fatigues"
	desc = "标准配发的, 凯夫拉编织, 经过危险品测试, EMF 增强的战斗工程师 fatigues. 你怀疑它并不像宣传的那样防弹."
	icon_state = "marine_engineer"

/obj/item/clothing/under/marine/engineer/black_vest
	starting_attachments = list(/obj/item/armor_module/storage/uniform/black_vest)

/obj/item/clothing/under/marine/jaeger
	name = "\improper TGMC 猎兵内衬服"
	desc = "标准配发的, 凯夫拉编织, 经过危险品测试, EMF 增强的陆战队制服. 你怀疑它并不像宣传的那样防弹."
	siemens_coefficient = 0.9
	icon_state = "marine_undersuit"
	adjustment_variants = list()
	has_sensor = 2
	item_map_variant_flags = null

/obj/item/clothing/under/marine/mp
	name = "宪兵制服"
	desc = "标准配发的, 凯夫拉编织, 经过危险品测试, EMF 增强的宪兵制服. 你怀疑它并不像宣传的那样防弹."
	icon_state = "MP_jumpsuit"
	adjustment_variants = list()

/obj/item/clothing/under/marine/orion_fatigue
	name = "\improper Orion fatigues"
	desc = "源自 Orion 军事前哨站. 专为舰船和城市环境设计, 用于侦察, 潜行和撤离行动. 内置一台只有使用者能听到的磁带播放器, 以便在任何可能的长久等待中打发时间. 它们是过度投资理念的典范, 至少看起来挺整洁. 很可能有个刚从新兵训练营出来的新兵用他 E-1 的薪水在基地商店买了这个, 就因为它看起来太战术酷了."
	icon_state = "orion_fatigues"
	worn_icon_state = "orion_fatigues"
	adjustment_variants = list(
		"Down" = "_d",
	)

/obj/item/clothing/under/marine/red_fatigue
	name = "\improper Big Red fatigues"
	desc = "源自 Big Red. 专为干燥, 低湿度和火星式环境设计, 用于侦察, 潜行和撤离行动. 内置一台只有使用者能听到的磁带播放器, 以便在任何可能的长久等待中打发时间. 它们让你感觉自己与沙漠融为一体, 由炙烤的太阳锻造而成. 有传言说它能回收你的汗水和尿液变成可饮用的水!"
	icon_state = "red_fatigues"
	worn_icon_state = "red_fatigues"
	adjustment_variants = list(
		"Down" = "_d",
	)

/obj/item/clothing/under/marine/lv_fatigue
	name = "\improper LV-624 fatigues"
	desc = "源自 LV-624. 专为潮湿, 高湿度和丛林环境设计, 用于侦察, 潜行和撤离行动. 内置一台只有使用者能听到的磁带播放器, 以便在任何可能的长久等待中打发时间. 在某个地方, 有人正在背景中播放 'Fortunate Sons', 你能闻到空气中凝固汽油和橙剂的味道..."
	icon_state = "lv_fatigues"
	worn_icon_state = "lv_fatigues"
	adjustment_variants = list(
		"Down" = "_d",
	)

/obj/item/clothing/under/marine/striped
	name = "\improper 条纹 fatigues"
	desc = "一套简单的迷彩裤和条纹衬衫."
	icon_state = "marine_striped"
	worn_icon_state = "marine_striped"
	adjustment_variants = list()

/obj/item/clothing/under/marine/black_suit
	name = "\improper 陆战队黑色西装"
	desc = "一套合身的黑色西装, 不知怎么的正好是你的尺码."
	icon_state = "marine_suit"
	worn_icon_state = "marine_suit"
	adjustment_variants = list()
/obj/item/clothing/under/marine/officer
	name = "陆战队军官制服"
	desc = "一件凯夫拉编织、经过防化测试、电磁场强化,却又格外柔软轻便的军官制服.你怀疑它并没有宣传的那么格外高级."
	icon_state = "officertanclothes"
	worn_icon_state = "officertanclothes"
	adjustment_variants = list()

/obj/item/clothing/under/marine/officer/warden
	name = "陆战队军官制服"
	desc = "一件凯夫拉编织、经过防化测试、电磁场强化,却又格外柔软轻便的军官制服.你怀疑它并没有宣传的那么格外高级."
	icon_state = "wardentanclothes"
	worn_icon_state = "wardentanclothes"

/obj/item/clothing/under/marine/officer/hos
	name = "陆战队军官制服"
	desc = "一件凯夫拉编织、经过防化测试、电磁场强化,却又格外柔软轻便的军官制服.你怀疑它并没有宣传的那么格外高级."
	icon_state = "hostanclothes"
	worn_icon_state = "hostanclothes"

/obj/item/clothing/under/marine/officer/warrant
	name = "宪兵司令制服"
	desc = "一件标准配发的凯夫拉编织、经过防化测试、电磁场强化制服,由守序善良的准尉们穿着.你怀疑它并没有宣传的那么防弹."
	icon_state = "WO_jumpsuit"
	worn_icon_state = "WO_jumpsuit"

/obj/item/clothing/under/marine/officer/logistics
	name = "陆战队军官制服"
	desc = "一件标准配发的凯夫拉编织、经过防化测试、电磁场强化制服,由TGMC的后勤军官们穿着.为部队争光吧."
	icon_state = "BO_jumpsuit"
	item_map_variant_flags = (ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT)

/obj/item/clothing/under/marine/officer/ro_suit
	name = "军需官制服"
	desc = "一件合身的凯夫拉编织、经过防化测试、电磁场强化军需官制服.你怀疑它并没有宣传的那么防弹."
	icon_state = "RO_jumpsuit"
	adjustment_variants = list()

/obj/item/clothing/under/marine/officer/pilot
	name = "飞行员飞行服"
	desc = "一件标准配发的凯夫拉编织、经过防化测试、电磁场强化、适合生存的飞行员飞行服.载着陆战队员们飞向荣耀吧."
	icon_state = "pilot_flightsuit"
	cold_protection_flags = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	item_map_variant_flags = null
	adjustment_variants = list(
		"Half" = "_h",
	)

/obj/item/clothing/under/marine/officer/mech
	name = "机甲驾驶员制服"
	desc = "一件标准配发的凯夫拉编织、经过防化测试、电磁场强化制服,由机甲驾驶员们穿着.虽然不如钛合金机器人那么威风,但也够用了."
	icon_state = "marine_mech_pilot"

/obj/item/clothing/under/marine/officer/assault_crewman
	name = "突击乘员制服"
	desc = "一件标准配发的碳纤维制服,为操作重型装备而优化.感觉像是上个十年传下来的旧货."
	icon_state = "marine_assault_crewman"

/obj/item/clothing/under/marine/officer/transport_crewman
	name = "运输乘员制服"
	desc = "一件标准配发的舒适制服,专为整天坐着而设计."
	icon_state = "marine_transport_crewman"

/obj/item/clothing/under/marine/officer/bridge
	name = "参谋军官制服"
	desc = "一件标准配发的凯夫拉编织、经过防化测试、电磁场强化参谋军官制服.为海军争光吧."
	icon_state = "BO_jumpsuit"
	item_map_variant_flags = (ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT)

/obj/item/clothing/under/marine/officer/exec
	name = "战地指挥官制服"
	desc = "一件特别配发的凯夫拉编织、经过防化测试、电磁场强化制服,由TGMC的校官穿着.你怀疑它并没有宣传的那么防弹."
	icon_state = "XO_jumpsuit"
	item_map_variant_flags = (ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT)

/obj/item/clothing/under/marine/officer/exec/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/black_vest)

/obj/item/clothing/under/marine/officer/command
	name = "舰长制服"
	desc = "一件特别配发的、熨烫平整的凯夫拉编织、经过防化测试、电磁场强化制服,配得上一位地球政府海军舰长.哪怕只是看它的眼神不对,都可能让你被送上军事法庭."
	icon_state = "CO_jumpsuit"
	item_map_variant_flags = (ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT)

/obj/item/clothing/under/marine/officer/admiral
	name = "上将制服"
	desc = "一件由舰队上将穿着的制服.它呈深黑色调,带有淡淡的光泽.其编织看起来足够坚固,能提供一些轻微的保护."
	worn_icon_state = "admiral_jumpsuit"

/obj/item/clothing/under/marine/officer/ce
	name = "首席舰船工程师制服"
	desc = "一件适合引擎作业的凯夫拉编织、经过防化测试、电磁场强化舰船工程师制服.你怀疑它并没有宣传的那么防弹."
	icon_state = "EC_jumpsuit"
	adjustment_variants = list(
		"Half" = "_h",
	)

/obj/item/clothing/under/marine/officer/engi
	name = "工程师制服"
	desc = "一件适合引擎作业的凯夫拉编织、经过防化测试、电磁场强化首席舰船工程师制服.你怀疑它并没有宣传的那么防弹."
	icon_state = "E_jumpsuit"
	adjustment_variants = list(
		"Half" = "_h",
	)

/obj/item/clothing/under/marine/officer/researcher
	name = "研究员服装"
	desc = "一套正式却又舒适的服装,为学者和研究员们所穿着."
	icon_state = "research_jumpsuit"

/obj/item/clothing/under/marine/whites
	name = "\improper TGMC白色礼服"
	desc = "一件标准配发的地球政府陆战队白色礼服.布料上的浆粉会带来些许摩擦感,但与你在新兵训练营毕业时第一次穿上它时感到的骄傲相比,这根本不值一提.不过腰部似乎不太合身."
	siemens_coefficient = 0.9
	icon_state = "marine_whites" //with thanks to Manezinho
	worn_icon_state = "marine_whites" //with thanks to Manezinho
	adjustment_variants = list()

/obj/item/clothing/under/marine/service
	name = "\improper TGMC常服"
	desc = "一件标准配发的地球政府陆战队礼服.有时,你讨厌穿这件衣服,因为你还记得在步兵学校时穿过它,而且面见委任军官时也得穿它.这是你在未部署、在办公室工作时的穿着.不过腰部似乎不太合身."
	siemens_coefficient = 0.9
	icon_state = "marine_service" //with thanks to Fitz 'Pancake' Sholl
	worn_icon_state = "marine_service" //with thanks to Fitz 'Pancake' Sholl
	adjustment_variants = list(
		"Down" = "_d",
	)

/*=========================RESPONDERS================================*/


/*=========================Imperium=================================*/

/obj/item/clothing/under/marine/imperial
	name = "\improper 帝国制服"
	desc = "这件制服几乎配发给帝国中的每一名士兵."
	adjustment_variants = list() // don't disrespect the EMPEROR!
	icon = 'icons/obj/clothing/uniforms/ert_uniforms.dmi'
	icon_state = "guardjumpsuit"
	worn_icon_list = list(
		slot_w_uniform_str = 'icons/mob/clothing/uniforms/ert_uniforms.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	worn_icon_state = "guardjumpsuit"
	soft_armor = list(MELEE = 10, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 10, FIRE = 10, ACID = 10)

/obj/item/clothing/under/marine/imperial/commissar
	name = "\improper 政委制服"
	desc = "一件政委的高贵制服."
	adjustment_variants = list() // don't disrespect the EMPEROR!
	icon_state = "commissar_uniform"
	worn_icon_state = "commissar_uniform"
	soft_armor = list(MELEE = 10, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 10, FIRE = 10, ACID = 10)

/obj/item/clothing/under/marine/veteran //none of these are actual used by marines
	icon = 'icons/obj/clothing/uniforms/ert_uniforms.dmi'
	worn_icon_list = list(
		slot_w_uniform_str = 'icons/mob/clothing/uniforms/ert_uniforms.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	adjustment_variants = list()

/obj/item/clothing/under/marine/veteran/pmc
	name = "\improper PMC作战服"
	desc = "一套白色的作战服,为私人安保操作员设计.纳米传思公司的标志印在衣服上."
	icon_state = "pmc_jumpsuit"
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/under/marine/veteran/pmc/holster
	starting_attachments = list(/obj/item/armor_module/storage/uniform/holster)

/obj/item/clothing/under/marine/veteran/pmc/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/black_vest)
/obj/item/clothing/under/marine/veteran/pmc/leader
	name = "\improper PMC指挥作战服"
	desc = "一套白色的作战服,为私人安保操作员设计.纳米传思公司的标志印在衣服上.这套特别的作战服看起来属于一位高级军官."
	icon_state = "officer_jumpsuit"

/obj/item/clothing/under/marine/veteran/pmc/leader/holster
	starting_attachments = list(/obj/item/armor_module/storage/uniform/holster)

/obj/item/clothing/under/marine/veteran/pmc/commando
	name = "\improper PMC突击队制服"
	desc = "一件由纳米传思精英突击队员穿着的装甲制服.它防护良好,同时保持轻便舒适."
	icon_state = "commando_jumpsuit"
	soft_armor = list(MELEE = 10, BULLET = 10, LASER = 10, ENERGY = 20, BOMB = 10, BIO = 10, FIRE = 20, ACID = 20)
	has_sensor = 0
	starting_attachments = list(/obj/item/armor_module/storage/uniform/holster/deathsquad)

/obj/item/clothing/under/marine/veteran/upp
	name = "\improper USL作战服"
	desc = "一套用得很旧的USL作战服,为鳞翅目海盗们批量生产."
	icon_state = "upp_uniform"
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	has_sensor = 0

/obj/item/clothing/under/marine/veteran/upp/medic
	name = "\improper USL医疗兵作战服"
	icon_state = "upp_uniform_medic"

//Freelancers

/obj/item/clothing/under/marine/veteran/freelancer
	name = "自由佣兵作战服"
	desc = "一套宽松的作战服,非常适合非正式的雇佣兵.闻起来有火药味、苹果派味,还沾满了油污和清酒渍."
	icon_state = "freelancer_uniform"
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	has_sensor = 0
	starting_attachments = list(/obj/item/armor_module/storage/uniform/holster/freelancer)

/obj/item/clothing/under/marine/veteran/freelancer/veteran
	starting_attachments = list(/obj/item/armor_module/storage/uniform/holster/vp)

/*===========================HELGHAST - MERCENARY================================*/

/obj/item/clothing/under/marine/veteran/mercenary
	name = "雇佣兵作战服"
	desc = "一套米色制服,配有红色臂章.结实厚重,尽显威严.上面印着一个神秘的徽记."
	icon_state = "mercenary_heavy_uniform"
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/under/marine/veteran/mercenary/miner
	name = "雇佣兵矿工作战服"
	desc = "一套米色制服,配有红色臂章.其丝滑轻薄的编织几乎让人误判了它的用途.上面印着一个神秘的徽记."
	icon_state = "mercenary_miner_uniform"

/obj/item/clothing/under/marine/veteran/mercenary/engineer
	name = "雇佣兵工程师作战服"
	desc = "一套蓝色制服,带有黄色点缀.这种剪裁工艺在作战服上难得一见.上面印着一个神秘的徽记."
	icon_state = "mercenary_engineer_uniform"

////// Civilians /////////

/obj/item/clothing/under/pizza
	name = "披萨外卖制服"
	desc = "一件不合身且略有污渍的披萨外卖飞行员制服。闻起来有奶酪味。"
	icon_state = "redshirt2"
	worn_icon_state = "r_suit"
	has_sensor = 0

/obj/item/clothing/under/colonist
	name = "殖民者制服"
	desc = "一件时尚的灰绿色连体服 - 殖民者的标准配发装备。"
	icon_state = "colonist"
	has_sensor = 2

/obj/item/clothing/under/colonist/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/black_vest)

/obj/item/clothing/under/CM_uniform
	name = "殖民地执法官制服"
	desc = "一件蓝色衬衫和棕褐色长裤 - 殖民地执法官的官方制服。"
	icon_state = "marshal"
	has_sensor = 2

/obj/item/clothing/under/liaison_suit
	name = "联络官的棕褐色西装"
	desc = "一套僵硬而时尚的棕褐色西装,通常由Nanotrasen公司的商人穿着。精心制作,让你看起来像个混蛋。"
	icon_state = "liaison_regular"

/obj/item/clothing/under/liaison_suit/outing
	name = "联络官的服装"
	desc = "一套休闲装,包括一件有领衬衫和一件马甲。看起来像是你周末会穿的,或者去废弃殖民地拜访时穿的。"
	icon_state = "liaison_outing"

/obj/item/clothing/under/liaison_suit/formal
	name = "联络官的白色西装"
	desc = "一套正式的白色西装,你会在葬礼、公司晚宴或两者兼有时穿的那种。硬得像块木板,但让你感觉像是从劳斯莱斯里滚出来一样。"
	icon_state = "liaison_formal"

/obj/item/clothing/under/liaison_suit/suspenders
	name = "联络官的装束"
	desc = "一件有领衬衫,搭配一条背带。由那些提出尖锐问题的Nanotrasen员工穿着。隐约有雪茄和糟糕演技的味道。"
	icon_state = "liaison_suspenders"

/obj/item/clothing/under/liaison_suit/galaxy_blue
	name = "\improper 虚空无魂"
	desc = "一套星辰与高压气体的制服。一套呐喊着宇宙与不可名状之浩瀚的制服。只有最顶尖中的最顶尖才能获得。"
	icon_state = "liaison_galaxy_blue" // Thanks to Manezinho

/obj/item/clothing/under/liaison_suit/galaxy_red
	name = "\improper 脉冲星炮"
	desc = "一套星辰与高压气体的制服。一套呐喊着恒星聚变与再入燃烧的制服。只有最顶尖中的最顶尖才能获得。"
	icon_state = "liaison_galaxy_red" // Thanks to Manezinho

/obj/item/clothing/under/rank/synthetic
	name = "\improper TGMC支援制服"
	desc = "为合成人船员制作的简单制服。"
	icon_state = "rdalt"
	adjustment_variants = list()

/obj/item/clothing/under/som
	name = "\improper SOM军官制服"
	desc = "SOM军事人员的标准制服。其设计显示出与旧采矿殖民地所使用的采矿制服有着清晰的传承关系。"
	icon = 'icons/obj/clothing/uniforms/ert_uniforms.dmi'
	icon_state = "som_uniform"
	worn_icon_list = list(
		slot_w_uniform_str = 'icons/mob/clothing/uniforms/ert_uniforms.dmi',
		slot_l_hand_str = 'icons/mob/inhands/clothing/uniforms_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/clothing/uniforms_right.dmi',
	)
	worn_icon_state = "som_uniform"
	has_sensor = FALSE

/obj/item/clothing/under/som/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/brown_vest)

/obj/item/clothing/under/som/medic
	name = "\improper SOM医疗制服"
	desc = "SOM军事人员的标准制服。其设计显示出与旧采矿殖民地所使用的采矿制服有着清晰的传承关系。这一件带有医疗标记。"
	icon_state = "som_uniform_medic"
	worn_icon_state = "som_uniform_medic"

/obj/item/clothing/under/som/medic/vest
	starting_attachments = list(/obj/item/armor_module/storage/uniform/white_vest)

/obj/item/clothing/under/som/medic/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/brown_vest)

/obj/item/clothing/under/som/veteran
	name = "\improper SOM老兵制服"
	desc = "SOM军事人员的标准制服。其设计显示出与旧采矿殖民地所使用的采矿制服有着清晰的传承关系。这一件带有表明专家身份的标记。"
	icon_state = "som_uniform_veteran"
	worn_icon_state = "som_uniform_veteran"

/obj/item/clothing/under/som/veteran/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/brown_vest)

/obj/item/clothing/under/som/leader
	name = "\improper SOM领袖制服"
	desc = "SOM军事人员的标准制服。其设计显示出与旧采矿殖民地所使用的采矿制服有着清晰的传承关系。这一件带有领导层标记。"
	icon_state = "som_uniform_leader"
	worn_icon_state = "som_uniform_leader"

/obj/item/clothing/under/som/leader/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/brown_vest)

/obj/item/clothing/under/som/officer
	name = "\improper SOM军官制服"
	desc = "SOM军官特有的黑色制服。通常由初级军官穿着"
	icon_state = "som_officer_uniform"
	worn_icon_state = "som_officer_uniform"
	adjustment_variants = list()

/obj/item/clothing/under/som/officer/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/black_vest)

/obj/item/clothing/under/som/officer/senior
	name = "\improper SOM军官制服"
	desc = "SOM军官特有的带夹克黑色制服。通常由高级军官穿着"
	icon_state = "som_senior_officer_uniform"
	worn_icon_state = "som_senior_officer_uniform"

/obj/item/clothing/under/icc
	name = "\improper Modelle/30制服"
	desc = "ICC军事人员的标准制服。其设计明显具有双重用途,既可作为战斗制服,也适合在舰船上执行日常任务。"
	icon = 'icons/obj/clothing/uniforms/ert_uniforms.dmi'
	icon_state = "icc"
	worn_icon_list = list(
		slot_w_uniform_str = 'icons/mob/clothing/uniforms/ert_uniforms.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	worn_icon_state = "icc"
	has_sensor = FALSE

/obj/item/clothing/under/icc/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/brown_vest)

/obj/item/clothing/under/sectoid
	name = "灵能场"
	desc = "一片无形的能量场,它保护穿戴者,但阻止穿戴任何衣物。"
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield-blue"
	item_flags = DELONDROP

/obj/item/clothing/under/sectoid/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SECTOID_TRAIT)

/obj/item/clothing/under/marine/robotic
	name = "机器人装甲挂载"
	desc = "用于在战斗机器人上安装设备的附加结构装甲板。"
	worn_icon_state = "chest_rig"
	icon_state = "chest_rig"
	adjustment_variants = list()
	species_exception = list(/datum/species/robot)

/obj/item/clothing/under/marine/robotic/mob_can_equip(mob/user, slot, warning = TRUE, override_nodrop = FALSE, bitslot = FALSE)
	. = ..()
	if(!isrobot(user))
		to_chat(user, span_warning("你无法装备这个,因为它需要在你身体上拧入安装螺丝!"))
		return FALSE

/obj/item/clothing/under/marine/robotic/black_vest
	starting_attachments = list(/obj/item/armor_module/storage/uniform/black_vest)

/obj/item/clothing/under/marine/robotic/brown_vest
	starting_attachments = list(/obj/item/armor_module/storage/uniform/brown_vest)

/obj/item/clothing/under/marine/robotic/corpman_vest
	starting_attachments = list(/obj/item/armor_module/storage/uniform/white_vest)

/obj/item/clothing/under/marine/robotic/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/webbing)

/obj/item/clothing/under/marine/robotic/holster
	starting_attachments = list(/obj/item/armor_module/storage/uniform/holster)

/obj/item/clothing/under/marine/squad/neck/foreign
	name = "\improper TGMC外籍军团高领衫"
	desc = "看起来很有战术范儿的、小队配发制服。这一件属于外籍军团,闻起来像快餐。"
	icon_state = "foreign_merc"
	worn_icon_state = "foreign_merc"

/obj/item/clothing/under/marine/slav
	name = "\improper 旧斯拉夫制服"
	desc = "这是一套运动服。哦等等,这是斯拉夫军装。"
	icon_state = "slav"
	worn_icon_state = "slav"
	adjustment_variants = list()

/obj/item/clothing/under/marine/gorka_eng
	name = "\improper 工程师戈尔卡"
	desc = "戈尔卡。工程师戈尔卡。"
	icon_state = "gorka_eng"
	worn_icon_state = "gorka_eng"
	adjustment_variants = list()

/obj/item/clothing/under/marine/gorka_med
	name = "\improper 医疗兵戈尔卡"
	desc = "戈尔卡。医疗兵戈尔卡。"
	icon_state = "gorka_med"
	worn_icon_state = "gorka_med"
	adjustment_variants = list()

/obj/item/clothing/under/marine/camo
	name = "\improper 旧迷彩制服"
	desc = "这是老头钓鱼穿的衣服,现在你可以穿着这件非常隐蔽的迷彩为TerraGov去死了。"
	icon_state = "camo"
	worn_icon_state = "camo"
	adjustment_variants = list(
		"Down" = "_d",
	)

/obj/item/clothing/under/marine/bravo_hawaii
	name = "\improper Bravo夏威夷衬衫"
	desc = "一件在LV海滩上喝啤酒时穿的舒适衬衫,背面的标签上写着:'Bravo专属,由中国殖民地儿童制造'"
	icon_state = "bhavai"
	worn_icon_state = "bhavai"
	adjustment_variants = list(
		"Rolled Sleeves" = "_h",
		"No Sleeves" = "_d",
	)

/obj/item/clothing/under/marine/whites/blacks
	name = "\improper TGMC黑色礼服制服"
	desc = "一套标准配发的TerraGov陆战队黑色礼服制服。布料上的浆粉会轻微摩擦皮肤,但与你在新兵训练营毕业时第一次穿上它感到的自豪相比,这根本不算什么。不过腰部似乎不太合身。"
	icon_state = "marine_blacks"

/obj/item/clothing/under/marine/veteran/marine
	name = "\improper 老兵制服"
	desc = "一套为陆战队定制的、使用寿命长的防护制服。它用附加防护板、凯夫拉内衬、缝制金属网进行了加固,并浸渍了耐火混合物。反正,腿上的标签是这么说的。信不信由你,毕竟,如果你真的在陆战队服役够久,你就知道答案了。"
	icon = 'icons/obj/clothing/uniforms/marine_uniforms.dmi'
	icon_state = "veteran"
	worn_icon_list = list(
		slot_w_uniform_str = 'icons/mob/clothing/uniforms/marine_uniforms.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	adjustment_variants = list()

/obj/item/clothing/under/marine/separatist
	name = "\improper TU-32战斗制服"
	desc = "这套'分离主义者'战斗装备具有防护性,用凯夫拉纤维加固并带有橡胶化金属插片,在Terra殖民地被占领后许多平民骚乱的情况下证明了其可靠性。为了纪念民兵的受害者,这套装备被运送到了TerraGov陆战队舰船上。"
	icon_state = "separatist"
	adjustment_variants = list()

/obj/item/clothing/under/marine/specops
	name = "战术高领衫"
	desc = "配发给特种作战单位的TGMC高领衫"
	icon = 'icons/mob/clothing/uniforms/ert_uniforms.dmi'
	icon_state = "specops_uniform"
	worn_icon_list = list(
		slot_w_uniform_str = 'icons/mob/clothing/uniforms/ert_uniforms.dmi',
	)
	starting_attachments = list(/obj/item/armor_module/storage/uniform/holster)
	worn_icon_state = "specops_uniform"
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	has_sensor = 0

/obj/item/clothing/under/vsd
	name = "V.S.D连体服"
	desc = "Vyacheslav的标准制服。既可用于技术工作也可用于战斗!"
	icon = 'icons/mob/clothing/uniforms/ert_uniforms.dmi'
	icon_state = "vsd_uniform_main"
	worn_icon_state = "vsd_uniform_main"
	worn_icon_list = list(
		slot_w_uniform_str = 'icons/mob/clothing/uniforms/ert_uniforms.dmi',
	)
	has_sensor = FALSE

/obj/item/clothing/under/vsd/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/black_vest)

/obj/item/clothing/under/vsd/medic
	starting_attachments = list(/obj/item/armor_module/storage/uniform/white_vest)

/obj/item/clothing/under/vsd/secondary
	name = "V.S.D连体服"
	icon_state = "vsd_uniform_secondary"
	worn_icon_state = "vsd_uniform_secondary"

/obj/item/clothing/under/vsd/secondary/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/black_vest)

/obj/item/clothing/under/vsd/upp
	name = "V.S.D连体服"
	icon_state = "upp_retired"
	worn_icon_state = "upp_retired"

/obj/item/clothing/under/vsd/upp/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/black_vest)

/obj/item/clothing/under/vsd/shirt
	name = "V.S.D衬衫"
	icon_state = "vsd_shirt"
	worn_icon_state = "vsd_shirt"

/obj/item/clothing/under/vsd/shirt/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/black_vest)

/obj/item/clothing/under/vsd/sleeveless
	name = "V.S.D衬衫"
	icon_state = "vsd_shirt_sleeveless"
	worn_icon_state = "vsd_shirt_sleeveless"

/obj/item/clothing/under/vsd/sleeveless/webbing
	starting_attachments = list(/obj/item/armor_module/storage/uniform/black_vest)
