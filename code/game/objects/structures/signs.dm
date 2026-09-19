/obj/structure/sign
	icon = 'icons/obj/decals_arrow.dmi'
	anchored = TRUE
	opacity = FALSE
	density = FALSE
	layer = WALL_OBJ_LAYER
	plane = WALL_PLANE
	///if true init to a given x/y offset on a wall, if not leave floating in space. used for multiple signs on a wall to prevent them all from moving to the same offset and overlapping/becoming unreadable.
	var/directional = TRUE
	///The icon sign will change on Initialize.
	var/base_icon = 'icons/obj/decals.dmi'

/obj/structure/sign/Initialize(mapload)
	. = ..()
	if(base_icon)
		icon = base_icon
	if(!directional) //if not directional do not initialize to a x or y offset
		return
	switch(dir)
		if(NORTH)
			pixel_y = 32
		if(SOUTH)
			pixel_y = -32
		if(EAST)
			pixel_x = 30
		if(WEST)
			pixel_x = -30

/obj/structure/sign/ex_act(severity)
	if(severity < EXPLODE_WEAK)
		return
	qdel(src)

/obj/structure/sign/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()

	if(istype(src, /obj/structure/sign/double))
		return
	to_chat(user, "你用你的[I]解开了标牌.")
	var/obj/item/sign/S = new(loc)
	S.name = name
	S.desc = desc
	S.icon_state = icon_state
	S.sign_state = icon_state
	qdel(src)

/obj/item/sign
	name = "标牌"
	desc = ""
	icon = 'icons/obj/decals.dmi'
	w_class = WEIGHT_CLASS_NORMAL		//big
	var/sign_state = ""

/obj/item/sign/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()

	if(!isturf(user.loc))
		return
	var/direction = tgui_input_list(user, "朝哪个方向?", "选择方向.", list("North", "East", "South", "West"))
	if(!direction)
		return
	var/obj/structure/sign/S = new(user.loc)
	switch(direction)
		if("North")
			S.pixel_y = 32
		if("East")
			S.pixel_x = 32
		if("South")
			S.pixel_y = -32
		if("West")
			S.pixel_x = -32
		else
			return
	S.name = name
	S.desc = desc
	S.icon_state = sign_state
	to_chat(user, "你用你的[I]将\the 固定到[S].")
	qdel(src)

/obj/structure/sign/double/map
	name = "空间站地图"
	desc = "一幅装裱好的空间站图片."

/obj/structure/sign/double/map/left
	icon_state = "map-left"

/obj/structure/sign/double/map/right
	icon_state = "map-right"

/obj/structure/sign/securearea
	name = "\improper 安全区域"
	desc = "一个警告标志,上面写着\"安全区域\"."
	icon_state = "securearea"

/obj/structure/sign/securearea/firingrange
	name = "\improper 射击场"
	desc = "一个警告标志,上面写着\"实弹射击场\"."
	icon_state = "firingrange"

/obj/structure/sign/biohazard
	name = "\improper 生物危害"
	desc = "一个警告标志,上面写着\"生物危害\"."
	icon_state = "bio"

/obj/structure/sign/electricshock
	name = "\improper 高压"
	desc = "一个警告标志,上面写着\"高压\"."
	icon_state = "shock"

/obj/structure/sign/cold
	name = "\improper 低温"
	desc = "一个警告标志,上面写着\"低温\"."
	icon_state = "cold"

/obj/structure/sign/heat
	name = "\improper 高温"
	desc = "一个警告标志,上面写着\"高温\"."
	icon_state = "heat"

/obj/structure/sign/gas
	name = "\improper 气体警告"
	desc = "一个警告标志,上面写着\"必须佩戴防毒面具\"."
	icon_state = "gasmask"

/obj/structure/sign/examroom
	name = "\improper 检查"
	desc = "一个指示标志,上面写着\"检查室\"."
	icon_state = "examroom"

/obj/structure/sign/vacuum
	name = "\improper 前方高真空"
	desc = "一个警告标志,上面写着\"前方高真空\"."
	icon_state = "space"

/obj/structure/sign/deathsposal
	name = "\improper 垃圾处理通向太空"
	desc = "一个警告标志,上面写着\"垃圾处理通向太空\"."
	icon_state = "deathsposal"

/obj/structure/sign/pods
	name = "\improper 逃生舱"
	desc = "一个警告标志,上面写着\"逃生舱\"."
	icon_state = "pods"

/obj/structure/sign/fire
	name = "\improper 危险:火灾"
	desc = "一个警告标志,上面写着\"危险:火灾\"."
	icon_state = "fire"

/obj/structure/sign/nosmoking_1
	name = "\improper 禁止吸烟"
	desc = "一个警告标志,上面写着\"禁止吸烟\"."
	icon_state = "nosmoking"

/obj/structure/sign/nosmoking_2
	name = "\improper 禁止吸烟"
	desc = "一个警告标志,上面写着\"禁止吸烟\"."
	icon_state = "nosmoking2"

/obj/structure/sign/redcross
	name = "医疗舱"
	desc = "银河系医疗机构的标志.你可能会在这里得到帮助."
	icon_state = "redcross"

/obj/structure/sign/greencross
	name = "医疗舱"
	desc = "银河系医疗机构的标志.你可能会在这里得到帮助."
	icon_state = "greencross"

/obj/structure/sign/greencross/star
	icon_state = "lifestar"

/obj/structure/sign/goldenplaque
	name = "最强壮男人奖"
	desc = "强壮不是一种行为或生活方式,而是一种精神状态.只有那些意志力足够强大,能在危机中采取行动,从敌人手中拯救朋友的人,才是真正的强壮.保持强壮,我的朋友们."
	icon_state = "goldenplaque"

/obj/structure/sign/kiddieplaque
	name = "AI开发者铭牌"
	desc = "在极长的姓名和职位列表旁边,有一幅小孩的图画.这个孩子似乎有残疾.在图像下方,有人刻上了\"PACKETS\"这个词"
	icon_state = "kiddieplaque"

/obj/structure/sign/atmosplaque
	name = "\improper FEA大气部门铭牌"
	desc = "这块铭牌纪念大气FEA部门的陨落.献给所有在它手中被烧焦、眩晕和脆弱死去的人们."
	icon_state = "atmosplaque"

/obj/structure/sign/double/maltesefalcon	//The sign is 64x32, so it needs two tiles. ;3
	name = "马耳他之鹰"
	desc = "马耳他之鹰,太空酒吧和烧烤店."

/obj/structure/sign/double/maltesefalcon/left
	icon_state = "maltesefalcon-left"

/obj/structure/sign/double/maltesefalcon/right
	icon_state = "maltesefalcon-right"

/obj/structure/sign/science
	name = "\improper 科学!"
	desc = "一个警告标志,上面写着\"科学!\"."
	icon_state = "science1"

/obj/structure/sign/science/two
	icon_state = "science2"

/obj/structure/sign/xenobio
	name = "\improper 科学!"
	desc = "一个警告标志,上面写着\"科学!\"."
	icon_state = "xenobio4"

/obj/structure/sign/xenobio/two
	icon_state = "xenobio"

/obj/structure/sign/chemistry
	name = "\improper 化学"
	desc = "一个警告标志,上面写着\"化学\"."
	icon_state = "chemistry1"

/obj/structure/sign/chemistry2
	icon_state = "chemistry2"

/obj/structure/sign/pharmacy
	name = "\improper 药房"
	desc = "一个指示标志,上面写着\"药房\"."
	icon_state = "pharmacy"

/obj/structure/sign/botany
	name = "\improper 水培"
	desc = "一个指示标志,上面写着\"水培\"."
	icon_state = "hydro1"

/obj/structure/sign/holy
	name = "\improper 礼拜堂标志"
	desc = "一个标示宗教区域的标志."
	icon_state = "holy"

/obj/structure/sign/custodian
	name = "\improper 清洁工标志"
	desc = "一个标示清洁工工作区域的标志."
	icon_state = "custodian"

/obj/structure/sign/mait
	name = "\improper 维护隧道标志"
	desc = "一个标示各部门相互连接区域的标志."
	icon_state = "mait1"

/obj/structure/sign/mait/alt
	name = "\improper 维护隧道标志"
	desc = "一个标示各部门相互连接区域的标志."
	icon_state = "mait2"

/obj/structure/sign/botany
	name = "\improper 尸体处理"
	desc = "一个指示标志,上面写着\"尸体处理\"."
	icon_state = "bodysposal"

/obj/structure/sign/doors
	name = "\improper 门"
	desc = "一块写着\"门\"的指示牌."
	icon_state = "doors"

/obj/structure/sign/engie
	name = "\improper 工程部"
	desc = "一块写着\"工程部\"的指示牌."
	icon_state = "engine"

/obj/structure/sign/evac
	name = "\improper 撤离区"
	desc = "一块写着\"撤离区\"的指示牌."
	icon_state = "evac"

/obj/structure/sign/hydro
	name = "\improper 水培部"
	desc = "一块写着\"水培部\"的指示牌."
	icon_state = "hydro1"

/obj/structure/sign/hydro/two
	icon_state = "hydro2"

/obj/structure/sign/hydro/three
	icon_state = "hydro3"

/obj/structure/sign/restroom
	name = "\improper 洗手间"
	desc = "一块写着\"洗手间\"的指示牌."
	icon_state = "restroom"

/obj/structure/sign/security
	name = "\improper 安保部"
	desc = "一块写着\"安保部\"的指示牌."
	icon_state = "security"

/obj/structure/sign/testchamber
	name = "\improper 测试舱"
	desc = "一块写着\"测试舱\"的指示牌."
	icon_state = "testchamber"


/obj/structure/sign/directions/science
	name = "\improper 科学部"
	desc = "一块指示牌,指出科学部的方向."
	icon_state = "direction_sci"

/obj/structure/sign/directions/engineering
	name = "\improper 工程部"
	desc = "一块指示牌,指出工程部的方向."
	icon_state = "direction_eng"

/obj/structure/sign/directions/security
	name = "\improper 安保部"
	desc = "一块指示牌,指出安保部的方向."
	icon_state = "direction_sec"

/obj/structure/sign/directions/medical
	name = "\improper 医疗舱"
	desc = "一块指示牌,指出医疗舱的方向."
	icon_state = "direction_med"

/obj/structure/sign/directions/supply
	name = "货物指示牌"
	desc = "一块指示牌,指出货舱的方向."
	icon_state = "direction_supply"

/obj/structure/sign/directions/evac
	name = "\improper 逃生舱段"
	desc = "一块指示牌,指出逃生穿梭机停靠点的方向."
	icon_state = "direction_evac"

/obj/structure/sign/directions/command
	name = "指挥部门指示牌"
	desc = "一块指示牌,指出指挥部门的方向."
	icon_state = "direction_bridge"

/obj/structure/sign/directions/mining
	name = "采矿部门指示牌"
	desc = "一块指示牌,指出采矿部门的方向."
	icon_state = "direction_mining"

/obj/structure/sign/fixedinplace //direction signs that do not init to a position, handy for when we have to fit 4 signs on a wall at once
	directional = FALSE

/obj/structure/sign/fixedinplace/science
	name = "\improper 科学部"
	desc = "一块指示牌,指出科学部的方向."
	icon_state = "direction_sci"

/obj/structure/sign/fixedinplace/engineering
	name = "\improper 工程部"
	desc = "一块指示牌,指出工程部的方向."
	icon_state = "direction_eng"

/obj/structure/sign/fixedinplace/security
	name = "\improper 安保部"
	desc = "一块指示牌,指出安保部的方向."
	icon_state = "direction_sec"

/obj/structure/sign/fixedinplace/medical
	name = "\improper 医疗舱"
	desc = "一块指示牌,指出医疗舱的方向."
	icon_state = "direction_med"

/obj/structure/sign/fixedinplace/supply
	name = "货物指示牌"
	desc = "一块指示牌,指出货舱的方向."
	icon_state = "direction_supply"

/obj/structure/sign/fixedinplace/evac
	name = "\improper 逃生舱段"
	desc = "一块指示牌,指出逃生穿梭机停靠点的方向."
	icon_state = "direction_evac"

/obj/structure/sign/fixedinplace/command
	name = "指挥部门指示牌"
	desc = "一块指示牌,指出指挥部门的方向."
	icon_state = "direction_bridge"

/obj/structure/sign/fixedinplace/mining
	name = "采矿部门指示牌"
	desc = "一块指示牌,指出采矿部门的方向."
	icon_state = "direction_mining"

//end nondirectional signs

/obj/structure/sign/safety/
	name = "指示牌"
	icon = 'icons/obj/safety_signs_arrow.dmi'
	base_icon = 'icons/obj/safety_signs.dmi'
	desc = "一块警告特定危险的指示牌"
	anchored = TRUE
	opacity = FALSE
	density = FALSE

/obj/structure/sign/safety/airlock
	name = "\improper 气闸"
	desc = "一块表示附近有气闸的指示牌."
	icon_state = "sign_airlock"

/obj/structure/sign/safety/rad_shield
	name = "\improper 辐射屏蔽区"
	desc = "一块表示有铅制辐射屏蔽的指示牌."
	icon_state = "sign_rad_shield"

/obj/structure/sign/safety/no_grav
	name = "\improper 警告:零重力区域"
	desc = "一块警告零重力区域的警示牌"
	icon_state = "sign_nograv"

/obj/structure/sign/safety/grav_suit
	name = "\improper 警告:需要人工重力服"
	desc = "一块建议使用人工重力服的警示牌"
	icon_state = "sign_artgrav_suit"

/obj/structure/sign/safety/electronics
	name = "\improper 警告:电力系统"
	desc = "一块警告电力系统的警示牌"
	icon_state = "sign_electronics"

/obj/structure/sign/safety/autodoc
	name = "\improper 自动医生"
	desc = "一块表示附近有自动医生的指示牌"
	icon_state = "sign_autodoc"

/obj/structure/sign/safety/bridge
	name = "\improper 舰桥"
	desc = "标示舰桥位置的标牌"
	icon_state = "sign_bridge"

/obj/structure/sign/safety/blast_door
	name = "\improper 注意: 舱壁"
	desc = "警告附近有舱壁门的标牌"
	icon_state = "sign_blastdoor"

/obj/structure/sign/safety/breakroom
	name = "\improper 休息室"
	desc = "标示附近有休息室的标牌"
	icon_state = "sign_coffee"

/obj/structure/sign/safety/medical
	name = "\improper 医疗舱"
	desc = "标示附近有医疗设施的标牌"
	icon_state = "sign_medical"

/obj/structure/sign/safety/maintenance
	name = "\improper 维修通道"
	desc = "警告附近有维修通道的标牌."
	icon_state = "sign_maint"

/obj/structure/sign/safety/galley
	name = "\improper 厨房"
	desc = "标示附近有食物的标牌."
	icon_state = "sign_galley"

/obj/structure/sign/safety/atmospherics
	name = "\improper 生命维持系统"
	desc = "标示附近有生命维持系统的标牌."
	icon_state = "sign_life_support"

/obj/structure/sign/safety/vent
	name = "\improper 警告: 排气口"
	desc = "指示附近有危险排气口的警告标牌"
	icon_state = "sign_exhaust"

/obj/structure/sign/safety/storage
	name = "\improper 储藏区"
	desc = "标示附近有储藏设施的标牌."
	icon_state = "sign_storage"

/obj/structure/sign/safety/medical_supplies
	name = "\improper 急救"
	desc = "标示附近有急救设施的标牌"
	icon_state = "sign_medical_life_support"

/obj/structure/sign/safety/EVA
	name = "\improper EVA宇航服储物柜"
	desc = "标示有EVA宇航服储物柜的标牌"
	icon_state = "sign_space_suit_locker"

/obj/structure/sign/safety/laser
	name = "\improper 警告: 高能激光"
	desc = "警告附近有致命能量激光的警告标牌"
	icon_state = "sign_laser"

/obj/structure/sign/safety/vacuum
	name = "\improper 警告: 真空"
	desc = "指示附近有无压区域的警告标牌"
	icon_state = "sign_vacuum"

/obj/structure/sign/safety/ladder
	name = "\improper 警告: 梯子"
	desc = "标示附近有梯子的标牌"
	icon_state = "sign_ladder"

/obj/structure/sign/safety/pressure
	name = "\improper 警告: 前方加压区域"
	desc = "警告附近有加压区域的标牌"
	icon_state = "sign_pressurised_area"

/obj/structure/sign/safety/high_radiation
	name = "\improper 警告:高辐射水平"
	desc = "警告附近有危险辐射的标牌"
	icon_state = "sign_high_rad"

/obj/structure/sign/safety/rad_hazard
	name = "\improper 警告: 辐射危害"
	desc = "警告附近有辐射的标牌"
	icon_state = "sign_rad_hazard"

/obj/structure/sign/safety/cryogenic
	name = "\improper 低温库"
	desc = "标示有低温库的标牌"
	icon_state = "sign_cryo_vault"

/obj/structure/sign/safety/hazard
	name = "\improper 警告: 危险材料"
	desc = "警告附近有危险材料的标牌"
	icon_state = "sign_hazard"

/obj/structure/sign/safety/computer
	name = "\improper 警告: 关键系统"
	desc = "警告设施关键计算机系统的警告标牌"
	icon_state = "sign_computer"

/obj/structure/sign/safety/hydro
	name = "\improper 水培设施"
	desc = "标示有水培设施的标牌"
	icon_state = "sign_food_fridge"

/obj/structure/sign/safety/fridge
	name = "\improper 冷藏库"
	desc = "标示有冷藏设施的标牌"
	icon_state = "sign_cold_storage"

/obj/structure/sign/safety/radio
	name = "\improper 内部通讯系统"
	desc = "通知有内部通讯系统的标牌."
	icon_state = "sign_intercomm"

//Marine signs

/obj/structure/sign/ROsign
	name = "\improper TGMC军需处办公室守则"
	desc = " 1. 你无权获得服务或装备. 配件是特权, 不是权利.\n 2. 你必须着装整齐才能获得服务. 低温休眠内衣是不允许的.\n 3. 军需官拥有最终决定权和拒绝服务的权利. 只有代理舰长可以推翻他的决定.\n 4. 请尊重你的军需处工作人员. 他们工作很辛苦."
	icon_state = "roplaque"

/obj/structure/sign/prop1
	name = "\improper 地球政府海报"
	desc = "地球政府的标志."
	icon_state = "prop1"

/obj/structure/sign/prop1/Initialize(mapload)
	. = ..()
	icon = 'icons/obj/decals.dmi'

/obj/structure/sign/prop2
	name = "\improper TGMC海报"
	desc = "一张严重褪色的海报, 上面是一群身穿制服、魅力十足的地球政府陆战队员. 可能是Alpha测试前拍的."
	icon_state = "prop2"

/obj/structure/sign/prop3
	name = "\improper TGMC海报"
	desc = "一张旧的TGMC招募海报. 看着它, 你心中涌起自豪与真诚的遗憾交织的复杂情感."
	icon_state = "prop3"

/obj/structure/sign/prop4
	name = "地球政府: 为人类团结一致"
	desc = "一张描绘地球政府标志和座右铭的海报, 提醒陆战队员们是谁在对抗异形威胁、守护人类."
	icon_state = "prop4"

/obj/structure/sign/sanford
	name = "月度最佳员工奖"
	desc = "此证书授予<b>Sanford Stephano</b>. 表彰你对NT的杰出服务以及随意向随机个体注射轮盘素."
	icon_state = "sanford_month"
	dir = NORTH

/obj/structure/sign/sanford/year
	name = "年度最佳员工奖"
	icon_state = "sanford_year"

//=====================//
// SEMIOTIC STANDARD  //
//===================//

/obj/structure/sign/semiotic
	name = "标牌"
	icon = 'icons/obj/semiotic_standard.dmi'
	base_icon = null
	desc = "表示符号标准标志.星际商业委员会要求将这些符号放置在几乎所有地方以确保你的安全."
	anchored = TRUE
	opacity = FALSE
	density = FALSE
	directional = FALSE

/obj/structure/sign/semiotic/airlock
	name = "气闸符号"
	desc = "表示附近存在气闸的符号标准."
	icon_state = "airlock"

/obj/structure/sign/semiotic/ammunition
	name = "弹药储存符号"
	desc = "表示附近存在弹药储存的符号标准."
	icon_state = "ammo"

/obj/structure/sign/semiotic/analysis_lab
	name = "分析实验室符号"
	desc = "表示附近存在分析实验室的符号标准."
	icon_state = "analysislab"

/obj/structure/sign/semiotic/autodoc
	name = "自动医疗舱符号"
	desc = "表示附近存在自动医疗舱的符号标准."
	icon_state = "autodoc"

/obj/structure/sign/semiotic/autoopenclose
	name = "自动开关阀符号"
	desc = "表示附近存在自动关闭阀的符号标准."
	icon_state = "autoopenclose"

/obj/structure/sign/semiotic/bathmens
	name = "男卫生间符号"
	desc = "表示附近存在男卫生间的符号标准."
	icon_state = "bathmens"

/obj/structure/sign/semiotic/bathunisex
	name = "男女通用卫生间符号"
	desc = "表示附近存在男女通用卫生间的符号标准."
	icon_state = "bathunisex"

/obj/structure/sign/semiotic/bathwomens
	name = "女卫生间符号"
	desc = "表示附近存在女卫生间的符号标准."
	icon_state = "bathwomens"

/obj/structure/sign/semiotic/biohazard
	name = "生物危害符号"
	desc = "表示附近存在生物危害的符号标准."
	icon_state = "biohazard"

/obj/structure/sign/semiotic/biolab
	name = "生物实验室符号"
	desc = "表示附近存在生物实验室的符号标准."
	icon_state = "biolab"

/obj/structure/sign/semiotic/bridge
	name = "舰桥符号"
	desc = "表示附近存在星舰舰桥的符号标准."
	icon_state = "bridge"

/obj/structure/sign/semiotic/bulkhead_door
	name = "舱壁门符号"
	desc = "表示附近存在舱壁门的符号标准."
	icon_state = "bulkheaddoor"

/obj/structure/sign/semiotic/chem_lab
	name = "化学实验室符号"
	desc = "表示附近存在化学实验室的符号标准."
	icon_state = "chemlab"

/obj/structure/sign/semiotic/coffee
	name = "咖啡符号"
	desc = "表示附近存在咖啡的符号标准:任何星舰船员的生命线."
	icon_state = "coffee"

/obj/structure/sign/semiotic/commline_connection
	name = "通信线路连接点符号"
	desc = "表示附近存在通信线路连接的符号标准."
	icon_state = "commlineconnection"

/obj/structure/sign/semiotic/conference_room
	name = "会议室符号"
	desc = "表示附近存在会议室的符号标准."
	icon_state = "confroom"

/obj/structure/sign/semiotic/cryo
	name = "低温储存库符号"
	desc = "表示附近存在低温储存库的符号标准."
	icon_state = "cryo"

/obj/structure/sign/semiotic/debark_lounge
	name = "下船休息室符号"
	desc = "表示附近存在下船休息室的符号标准."
	icon_state = "debarkationlounge"

/obj/structure/sign/semiotic/distribution_pipes
	name = "分配管道符号"
	desc = "表示附近存在分配管道的符号标准."
	icon_state = "distpipe"

/obj/structure/sign/semiotic/east
	name = "\improper 东符号"
	desc = "表示东侧附近存在某物的符号标准."
	icon_state = "east"

/obj/structure/sign/semiotic/electronics
	name = "电子系统符号"
	desc = "表示附近存在电子系统的符号标准.这是电气系统的花哨说法."
	icon_state = "astronics"

/obj/structure/sign/semiotic/elevator
	name = "电梯符号"
	desc = "表示附近存在电梯的符号标准."
	icon_state = "elevator"

/obj/structure/sign/semiotic/escapepod
	name = "逃生舱符号"
	desc = "表示逃生舱的符号标准."
	icon_state = "escapepod"

/obj/structure/sign/semiotic/exhaust
	name = "排气符号"
	desc = "表示附近存在引擎或发电机排气的符号标准."
	icon_state = "exhaust"

/obj/structure/sign/semiotic/fire_haz
	name = "火灾隐患符号"
	desc = "表示附近存在火灾隐患的符号标准."
	icon_state = "firehaz"

/obj/structure/sign/semiotic/firingrange
	name = "射击场符号"
	desc = "表示附近存在实弹射击场的符号标准."
	icon_state = "firingrange"

/obj/structure/sign/semiotic/food_storage
	name = "有机物储存(食品)符号"
	desc = "表示附近存在未冷藏食品储存的符号标准."
	icon_state = "foodstorage"

/obj/structure/sign/semiotic/galley
	name = "厨房符号"
	desc = "表示附近存在厨房的符号标准."
	icon_state = "galley"

/obj/structure/sign/semiotic/hazard
	name = "危险符号"
	desc = "表示附近存在危险的符号标准.小心!"
	icon_state = "hazard"

/obj/structure/sign/semiotic/high_rad
	name = "高放射性符号"
	desc = "符号标准,表示附近存在高辐射区域."
	icon_state = "highrad"

/obj/structure/sign/semiotic/high_voltage
	name = "高压符号"
	desc = "符号标准,表示附近存在高压电流."
	icon_state = "highvoltage"

/obj/structure/sign/semiotic/hvac
	name = "\improper 暖通空调符号"
	desc = "符号标准,表示附近存在...暖通空调系统.此标志必定已更新至新标准."
	icon_state = "hvac"

/obj/structure/sign/semiotic/hvac_old
	name = "\improper 暖通空调符号"
	desc = "符号标准,表示附近存在暖通空调系统.此标志仍在使用旧标准."
	icon_state = "hvacold"

/obj/structure/sign/semiotic/intercom
	name = "对讲机符号"
	desc = "符号标准,表示附近存在对讲机."
	icon_state = "comm"

/obj/structure/sign/semiotic/ladder
	name = "梯子符号"
	desc = "符号标准,表示附近存在梯子."
	icon_state = "ladder"

/obj/structure/sign/semiotic/laser
	name = "激光符号"
	desc = "符号标准,表示附近存在激光.通常没有听起来那么酷."
	icon_state = "laser"

/obj/structure/sign/semiotic/life_support
	name = "生命维持系统符号"
	desc = "符号标准,表示附近存在生命维持系统."
	icon_state = "lifesupport"

/obj/structure/sign/semiotic/maint
	name = "维护符号"
	desc = "符号标准,表示附近存在维护通道."
	icon_state = "maint"

/obj/structure/sign/semiotic/manualopenclose
	name = "手动开关阀符号"
	desc = "符号标准,表示附近存在手动截止阀."
	icon_state = "manualopenclose"

/obj/structure/sign/semiotic/med_cryo
	name = "医疗低温休眠舱符号"
	desc = "符号标准,表示附近存在医疗低温休眠舱."
	icon_state = "medcryo"

/obj/structure/sign/semiotic/med_life_support
	name = "医疗生命维持符号"
	desc = "符号标准,表示附近存在医疗舱的生命维持系统."
	icon_state = "medlifesupport"

/obj/structure/sign/semiotic/medical
	name = "医疗符号"
	desc = "符号标准,表示附近存在医疗舱."
	icon_state = "medical"

/obj/structure/sign/semiotic/nonpress
	name = "前方非加压区域符号"
	desc = "符号标准,表示前方区域未加压."
	icon_state = "nonpressarea"

/obj/structure/sign/semiotic/nonpress_ag
	name = "人工重力区域,非加压,需穿防护服符号"
	desc = "符号标准,表示附近存在有人工重力但未加压的区域."
	icon_state = "nonpressag"

/obj/structure/sign/semiotic/nonpress_0g
	name = "非加压区域,无重力,需穿防护服符号"
	desc = "符号标准,表示前方区域未加压且无人工重力."
	icon_state = "nonpresszerog"

/obj/structure/sign/semiotic/north
	name = "\improper 北向符号"
	desc = "符号标准,表示附近北侧存在某物."
	icon_state = "north"

/obj/structure/sign/semiotic/opens_up
	name = "向上开启符号"
	desc = "符号标准,表示附近的门向上开启."
	icon_state = "opensup"

/obj/structure/sign/semiotic/outpatient
	name = "门诊诊所符号"
	desc = "符号标准,表示附近存在门诊诊所."
	icon_state = "outpatient"

/obj/structure/sign/semiotic/fibre_optics
	name = "光子学系统(光纤)符号"
	desc = "符号标准,表示附近存在光纤线路."
	icon_state = "fibreoptic"

/obj/structure/sign/semiotic/press_area_ag
	name = "加压且有人工重力符号"
	desc = "符号标准,表示附近存在无人工重力的加压区域."
	icon_state = "pressareaag"

/obj/structure/sign/semiotic/press_area
	name = "加压区域符号"
	desc = "符号标准,表示附近存在加压区域."
	icon_state = "pressarea"

/obj/structure/sign/semiotic/rad_haz
	name = "辐射危害符号"
	desc = "符号标准,表示附近存在辐射危害."
	icon_state = "radhaz"

/obj/structure/sign/semiotic/rad_shield
	name = "辐射屏蔽区域符号"
	desc = "符号标准,表示附近存在辐射屏蔽区域."
	icon_state = "radshield"

/obj/structure/sign/semiotic/radio_rad
	name = "无线电波辐射符号"
	desc = "符号标准,表示附近存在来自无线电塔的辐射."
	icon_state = "radiorad"

/obj/structure/sign/semiotic/reception
	name = "接待处符号"
	desc = "符号标准,表示附近存在接待区域."
	icon_state = "reception"

/obj/structure/sign/semiotic/reduction
	name = "区域缩减符号"
	desc = "符号标准,表示前方区域变小."
	icon_state = "reduction"

/obj/structure/sign/semiotic/ref_bio_storage
	name = "冷藏生物储存符号"
	desc = "符号标准,表示附近存在冷藏生物储存."
	icon_state = "refbiostorage"

/obj/structure/sign/semiotic/ref_chem_storage
	name = "冷藏化学储存符号"
	desc = "符号标准,表示附近存在冷藏化学储存."
	icon_state = "refchemstorage"

/obj/structure/sign/semiotic/restrictedarea
	name = "限制区域符号"
	desc = "符号标准,表示附近存在限制区域."
	icon_state = "restrictedarea"

/obj/structure/sign/semiotic/fridge
	name = "冷藏储存(有机食品)符号"
	desc = "表示附近有冰箱的符号标准."
	icon_state = "fridge"

/obj/structure/sign/semiotic/refridgeration
	name = "冷藏符号"
	desc = "表示附近有非食品冷藏设施的符号标准."
	icon_state = "refridgeration"

/obj/structure/sign/semiotic/rewire
	name = "重接线系统符号"
	desc = "表示附近有重接线系统的符号标准."
	icon_state = "rewire"

/obj/structure/sign/semiotic/security
	name = "安保符号"
	desc = "表示附近有执法机构或安保力量的符号标准."
	icon_state = "security"

/obj/structure/sign/semiotic/south
	name = "\improper 南向符号"
	desc = "表示附近南侧有某物的符号标准."
	icon_state = "south"

/obj/structure/sign/semiotic/stairs
	name = "楼梯符号"
	desc = "表示附近有楼梯的符号标准."
	icon_state = "stairs"

/obj/structure/sign/semiotic/storage
	name = "储藏符号"
	desc = "表示附近有普通干燥储藏室的符号标准."
	icon_state = "storage"

/obj/structure/sign/semiotic/suit_storage
	name = "压力服储物柜符号"
	desc = "表示附近有压力服储物柜的符号标准."
	icon_state = "suitstorage"

/obj/structure/sign/semiotic/synth_storage
	name = "合成体储藏符号"
	desc = "表示附近有合成体储藏室的符号标准."
	icon_state = "synthstorage"

/obj/structure/sign/semiotic/terminal
	name = "计算机终端符号"
	desc = "表示附近有计算机终端的符号标准."
	icon_state = "terminal"

/obj/structure/sign/semiotic/tram
	name = "缆车线路符号"
	desc = "表示附近有缆车线路的符号标准."
	icon_state = "tramline"

/obj/structure/sign/semiotic/twilight_zone_terminator
	name = "暮光区分界线符号"
	desc = "表示附近有暮光区分界线的符号标准. 它远没有听起来那么酷."
	icon_state = "twilightzoneterminator"

/obj/structure/sign/semiotic/water
	name = "水符号"
	desc = "表示附近有水的符号标准."
	icon_state = "water"

/obj/structure/sign/semiotic/waterhazard
	name = "水危险符号"
	desc = "表示有水危险的符号标准. 让电子设备远离."
	icon_state = "waterhaz"

/obj/structure/sign/semiotic/west
	name = "\improper 西向符号"
	desc = "表示附近西侧有某物的符号标准."
	icon_state = "west"

/obj/structure/sign/semiotic/zero_g
	name = "人工重力缺失符号"
	desc = "表示附近缺乏人工重力的符号标准."
	icon_state = "zerog"

/obj/structure/sign/semiotic/flightcontrol
	name = "\improper 飞行控制符号"
	desc = "表示用于飞行控制系统或由其使用的区域的符号标准."
	icon_state = "flightcontrol"

/obj/structure/sign/semiotic/airtraffictower
	name = "\improper 空中交通塔符号"
	desc = "表示附近有空中交通塔的符号标准."
	icon_state = "airtraffictower"

/obj/structure/sign/semiotic/luggageclaim
	name = "\improper 行李提取符号"
	desc = "表示附近有行李提取区域的符号标准."
	icon_state = "luggageclaim"

/obj/structure/sign/semiotic/landingzone
	name = "\improper 着陆区符号"
	desc = "表示附近有着陆区的符号标准."
	icon_state = "landingzone"

/obj/structure/sign/semiotic/zero
	name = "零符号"
	desc = "表示数字零的符号标准."
	icon_state = "0"

/obj/structure/sign/semiotic/one
	name = "一符号"
	desc = "表示数字一的符号标准."
	icon_state = "1"

/obj/structure/sign/semiotic/two
	name = "二符号"
	desc = "表示数字二的符号标准."
	icon_state = "2"

/obj/structure/sign/semiotic/three
	name = "三符号"
	desc = "表示数字三的符号标准."
	icon_state = "3"

/obj/structure/sign/semiotic/four
	name = "四符号"
	desc = "表示数字四的符号标准."
	icon_state = "4"

/obj/structure/sign/semiotic/five
	name = "五符号"
	desc = "表示数字五的符号标准."
	icon_state = "5"

/obj/structure/sign/semiotic/six
	name = "六符号"
	desc = "表示数字六的符号标准."
	icon_state = "6"

/obj/structure/sign/semiotic/seven
	name = "七符号"
	desc = "表示数字七的符号标准."
	icon_state = "7"

/obj/structure/sign/semiotic/eight
	name = "八符号"
	desc = "表示数字八的符号标准."
	icon_state = "8"

/obj/structure/sign/semiotic/nine
	name = "九符号"
	desc = "表示数字九的符号标准."
	icon_state = "9"
