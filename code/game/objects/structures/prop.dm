#define VENDOR_BROKEN "vendor_broken"
#define VENDOR_BLANK "vendor_blank"
//----- Marine ship machinery file -----//
// Put any new machines in here before map is released and everything moved to their proper positions.

//----- Marine ship props -----//
//Put any props that don't function properly, they could function in the future but for now are for looks. This system could be expanded for other maps too. ~Art

/obj/item/prop/mainship
	name = "通用舰船道具"
	desc = "这不应可见,若在回合中看到请用AHELP报告'ART-P03'"
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "hangarbox"

/obj/machinery/prop/mainship
	name = "GENERIC SHIP PROP"
	desc = "这不应可见,若在回合中看到请用AHELP报告'ART-P01'"
	coverage = 15

/obj/machinery/prop/mainship/hangar/dropship_part_fabricator

/obj/machinery/prop/computer
	name = "systems computer"
	desc = "一台接入舰船系统的小型计算机."

	density = FALSE
	anchored = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 20

	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer_small"
	light_range = 1
	light_power = 0.5
	light_color = LIGHT_COLOR_BLUE
	///The actual screen sprite for this computer
	var/screen_overlay = "terminal_misc"
	///The destroyed computer sprite. Defaults based on the icon_state if not specified
	var/broken_icon

/obj/machinery/prop/computer/Initialize(mapload)
	. = ..()
	if(!broken_icon)
		broken_icon = "[initial(icon_state)]_broken"
	update_icon()

/obj/machinery/prop/computer/ex_act(severity)
	if(severity >= EXPLODE_MEDIUM)
		qdel(src)
		return
	if(prob(severity * 0.3))
		set_broken()

/obj/machinery/prop/computer/proc/set_broken()
	machine_stat |= BROKEN
	update_icon()

/obj/machinery/prop/computer/update_icon()
	. = ..()
	if(machine_stat & (BROKEN|DISABLED|NOPOWER))
		set_light(0)
	else
		set_light(initial(light_range))

/obj/machinery/prop/computer/update_icon_state()
	. = ..()
	if(machine_stat & (BROKEN|DISABLED))
		icon_state = "[initial(icon_state)]_broken"
	else
		icon_state = initial(icon_state)

/obj/machinery/prop/computer/update_overlays()
	. = ..()
	if(!screen_overlay)
		return
	if(machine_stat & (BROKEN|DISABLED|NOPOWER))
		return
	. += emissive_appearance(icon, screen_overlay, src, alpha = src.alpha)
	. += mutable_appearance(icon, screen_overlay, alpha = src.alpha)

/obj/machinery/prop/computer/PC
	name = "personal desktop"
	desc = "一台接入舰船计算机网络的小型计算机."
	icon_state = "terminal"
	screen_overlay = "terminal1"

/obj/machinery/prop/computer/aiupload
	name = "\improper AI upload console"
	desc = "用于向AI上传法则."

	icon_state = "computer"
	screen_overlay = "aiupload"
	broken_icon = "computer_blue_broken"

/obj/machinery/prop/computer/dna
	icon_state = "computer"
	screen_overlay = "dna"
	broken_icon = "computer_blue_broken"

/obj/structure/prop/mainship/massdiver
	name = "质量驱动器"
	desc = "最精良的弹簧活塞玩具技术,现在就在你附近的太空站上."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "mass_driver"

/obj/structure/prop/mainship/shieldwall
	name = "护盾墙发生器"
	desc = "一台护盾发生器."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "shield_wall_gen"

/obj/structure/prop/mainship/dnascanner
	name = "\improper DNA扫描仪"
	desc = "它扫描DNA结构."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "scanner"

/obj/structure/prop/mainship/gateway
	name = "星门"
	desc = "一座由未知之手建造的神秘星门,它允许超光速旅行至遥远的地点."
	icon = 'icons/obj/gateway.dmi'
	icon_state = "portal_frame"

/obj/structure/prop/mainship/gravitygenerator
	name = "引力发生器"
	desc = "一种设置后能产生引力子场的装置."
	icon = 'icons/obj/gravity_generator.dmi'
	icon_state = "on_8"

/obj/structure/prop/mainship/holobarrier
	name = "\improper 工程全息屏障"
	desc = "企业补贴设计的奇迹,这种全息屏障几乎完全抵抗大气泄漏以及近战或弹道伤害造成的损耗.它还是由太空石棉制成的,根据新的日内瓦公约属于非法."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "holosign_engi"
	density = TRUE
	resistance_flags = RESIST_ALL

/obj/structure/prop/mainship/holobarrier/passthrough
	name = "\improper 压力密封全息屏障"
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield-blue"
	density = FALSE

/obj/structure/prop/mainship/deadai
	name = "\improper 已停用的AI"
	desc = "一个标准硅基单元,被指派管理NT站的研究任务.这一个已完全停用."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "ai_dead"
	density = TRUE
	resistance_flags = RESIST_ALL


/obj/structure/prop/mainship/deadai/Initialize(mapload)
	. = ..()
	icon_state = pick(
		"ai_dead",
		"ai-alien_dead",
		"ai-banned_dead",
		"ai-clown_dead",
		"ai-database_dead",
		"ai-glitchman_dead",
		"ai-goon_dead",
		"ai-house_dead",
		"ai-monochrome_dead",
		"ai-red_dead",
		"ai-red october_dead",
		"ai-static_dead",
		"ai-hades_dead",
	)

/obj/structure/prop/mainship/weapon_recharger
	name = "充电器"
	desc = "用于能量武器,PDA和其他设备的充电座.一盏闪烁的小灯表明此充电器无法使用."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "weapon_recharger"
	density = FALSE

//RND Props
/obj/machinery/prop/r_n_d/protolathe
	name = "protolathe"
	icon = 'icons/obj/machines/research.dmi'
	desc = "原型车床,曾用于打印工具等物品."
	icon_state = "protolathe"

/obj/machinery/prop/computer/rdconsole
	name = "\improper R&D console"
	icon = 'icons/obj/machines/computer.dmi'
	desc = "一台研究控制台."
	icon_state = "computer"
	screen_overlay = "rdcomp"
	broken_icon = "computer_blue_broken"

/obj/machinery/prop/r_n_d/server
	name = "\improper R&D server"
	icon = 'icons/obj/machines/research.dmi'
	desc = "一个研究服务器."
	icon_state = "server"

/obj/machinery/prop/computer/rdservercontrol
	name = "\improper R&D server controller"
	icon = 'icons/obj/machines/computer.dmi'
	desc = "监管所有研究."
	icon_state = "computer"
	screen_overlay = "rdcomp"
	broken_icon = "computer_blue_broken"

/obj/machinery/prop/computer/communications
	name = "communications console"
	desc = "可用于各种重要功能."
	screen_overlay = "comm"
	icon = 'icons/obj/machines/computer.dmi'

/obj/machinery/prop/computer/crew
	name = "crew monitoring computer"
	desc = "用于监控大多数船员制服内置的活跃生命体征传感器."
	icon_state = "computer"
	screen_overlay = "crew"
	icon = 'icons/obj/machines/computer.dmi'

/obj/machinery/prop/r_n_d/server/alt
	name = "alternate R&D server"
	icon = 'icons/obj/machines/research.dmi'
	desc = "一个研究服务器."
	icon_state = "server_alt"
//End RND props

//Nonpower using props

/obj/structure/prop/mainship
	name = "通用舰船道具"
	desc = "这不应该可见,如果在本局游戏中看到请使用AHELP报告'ART-P02'及位置"
	density = TRUE
	coverage = 15

/obj/machinery/prop/autolathe
	name = "\improper autolathe"
	desc = "它曾用于使用金属和玻璃生产物品."
	icon_state = "autolathe"
	coverage = 30
	density = TRUE
	anchored = TRUE

/obj/structure/prop/mainship/minigun_crate
	name = "30毫米弹药箱"
	desc = "一个装满30毫米子弹的箱子,用于某种型号的运输机武器吊舱.移动它需要某种起重设备."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "30mm_crate"


/obj/structure/prop/mainship/mission_planning_system
	name = "\improper MPS IV计算机"
	desc = "任务规划系统IV(MPS IV),为全UPP的运输机飞行员提供任务规划和制图的增强功能.完全能够自定义他们的飞行路径和装备配置以满足其作战需求."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "mps"

/obj/structure/prop/mainship/mapping_computer
	name = "\improper CMPS II计算机"
	desc = "通用制图生产系统第二版允许来自卫星和舰船系统的传感输入,以标准化方式为所有UPP飞行员生成行星地图."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "mapping_comp"

/obj/structure/prop/mainship/sensor_computer1
	name = "传感器计算机"
	desc = "IBM 10系列计算机,经改装用作舰船的传感器计算机.虽然有些过时,但仍能发挥作用."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "sensor_comp1"

/obj/structure/prop/mainship/sensor_computer1/sd
	name = "自毁状态计算机"

/obj/structure/prop/mainship/sensor_computer2
	name = "传感器计算机"
	desc = "IBM 10系列计算机,经改装用作舰船的传感器计算机.虽然有些过时,但仍能发挥作用."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "sensor_comp2"

/obj/structure/prop/mainship/sensor_computer2/sd
	name = "自毁调节器"

/obj/structure/prop/mainship/sensor_computer3
	name = "传感器计算机"
	desc = "IBM 10系列计算机,经改装用作舰船的传感器计算机.虽然有些过时,但仍能发挥作用."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "sensor_comp3"

/obj/structure/prop/mainship/sensor_computer3/sd
	name = "温度调节器"

/obj/structure/prop/mainship/missile_tube
	name = "\improper Mk 33反卫星发射系统"
	desc = "冷发射管,可发射多种类型的导弹,最常见的是用于对付卫星和其他航天器的ASAAR-21'刺剑IV'导弹,以及用于对地攻击的BGM-227'大锤'导弹."
	icon = 'icons/obj/structures/mainship_props96.dmi'
	icon_state = "missiletubenorth"
	bound_width = 32
	bound_height = 96
	resistance_flags = UNACIDABLE
	allow_pass_flags = PASSABLE|PASS_LOW_STRUCTURE

/obj/structure/prop/mainship/missile_tube/south
	icon_state = "missiletubesouth"

/obj/structure/prop/mainship/ship_memorial
	name = "胜利石板"
	desc = "一座舰船纪念碑,献给UPP的胜利以及本舰阵亡的陆战队员.左侧刻着辉煌的胜利故事.右侧列着在战斗中为UPP服役而阵亡的著名陆战队员名单."
	icon = 'icons/obj/structures/mainship_props64.dmi'
	icon_state = "ship_memorial"
	bound_width = 64
	bound_height = 32
	resistance_flags = UNACIDABLE
	allow_pass_flags = NONE
	var/list/fallen_list

/obj/structure/prop/mainship/ship_memorial/attackby(obj/item/I, mob/user)
	if(!istype(I, /obj/item/card/id/dogtag))
		return ..()
	var/obj/item/card/id/dogtag/D = I
	if(D.registered_name)
		to_chat(user, span_notice("你将[D]添加到[src]."))
		LAZYADD(fallen_list, D.registered_name)
		qdel(D)
	return TRUE

/obj/structure/prop/mainship/ship_memorial/examine(mob/user)
	. = ..()
	if((isobserver(user) || ishuman(user)) && fallen_list)
		var/faltext = ""
		for(var/i = 1 to length(fallen_list))
			if(i != length(fallen_list))
				faltext += "[fallen_list[i]], "
			else
				faltext += fallen_list[i]
		. += "[span_notice("To our fallen marines:")] <b>[faltext]</b>."

/obj/structure/prop/mainship/particle_cannon
	name = "\improper 75厘米/140 Mark 74通用原子公司轨道炮"
	desc = "Mark 74轨道炮是太空武器的顶尖之作.能够以每秒24公里的速度发射直径四分之三米的炮弹.它还能使用多种类型的炮弹,通过其新设计的供弹系统可随时更换."
	icon = 'icons/obj/machines/artillery.dmi'
	icon_state = "1"
	resistance_flags = UNACIDABLE

/obj/structure/prop/mainship/name_stencil
	name = "\improper UPP,UPP级陆战航母武库舰"
	desc = "船体上印着的舰船名称."
	icon = 'icons/obj/structures/mainship_props64.dmi'
	icon_state = "UPP1"
	density = FALSE
	plane = FLOOR_PLANE
	layer = LOWER_RUNE_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	resistance_flags = UNACIDABLE

/obj/structure/prop/mainship/name_stencil/U
	icon_state = "UPP1"

/obj/structure/prop/mainship/name_stencil/P
	icon_state = "UPP2"

/obj/structure/prop/mainship/name_stencil/Initialize(mapload)
	. = ..()
	name = SSmapping.configs[SHIP_MAP].map_name

/obj/structure/prop/mainship/hangar_stencil
	name = "地板"
	desc = "机库地板上印着的大数字,用于标示是哪架运输机."
	icon = 'icons/obj/structures/mainship_props96.dmi'
	icon_state = "dropship1"
	density = FALSE
	plane = FLOOR_PLANE
	layer = LOWER_RUNE_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/mainship/hangar_stencil/two
	icon_state = "dropship2"

/obj/structure/prop/mainship/brokengen //all the aesthetics of having a generator without any of the function
	name = "\improper G-11地热发电机"
	desc = "一台热电发电机,坐落在一个充满等离子体的钻孔上方.能量电池不见了,状态面板上滚动着奇怪的文字,你感觉这东西修不好了."
	icon = 'icons/turf/geothermal.dmi'
	icon_state = "destroyedgen"
	resistance_flags = RESIST_ALL //normal generators can't be destroyed, so for appearances our fake ones can't be destroyed either.

/obj/structure/prop/mainship/cannon_cables
	name = "\improper 加农炮电缆"
	desc = "一些粗大的电缆."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "cannon_cables"
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = BELOW_OBJ_LAYER

/obj/structure/prop/mainship/supermatter //functionally inert, but will consume mobs and objects
	name = "超物质晶体"
	desc = "一块奇异的半透明虹彩晶体."
	icon = 'icons/obj/structures/mainship_props64.dmi'
	icon_state = "darkmatter"
	layer = BELOW_OBJ_LAYER
	light_range = 4
	resistance_flags = RESIST_ALL //no delaminations here

/obj/structure/prop/mainship/supermatter/proc/consume(atom/movable/consumed_object) //dust() and destroy living mobs, qdel thrown objects
	if(isliving(consumed_object))
		var/mob/living/consumed_mob = consumed_object
		consumed_mob.dust() //dust() plays a dusting animation and sets the mob to dead
	else if(isobj(consumed_object))
		qdel(consumed_object) //we cannot dust() objects so we just delete them

/obj/structure/prop/mainship/supermatter/Bumped(atom/movable/hit_object)
	if(isliving(hit_object)) //living objects get a nifty message about heat
		hit_object.visible_message(span_danger("\The [hit_object]猛撞进\the [src],引发了一场共振...[hit_object.p_their()]身体开始发光并燃烧起来,随后化为尘埃!"),
			span_userdanger("你猛撞进\the [src],耳边充满了诡异的鸣响.你最后的念头是\"哦,操.\""),
			span_hear("你听到一阵诡异的噪音,一股热浪席卷了你."))
	else if(isobj(hit_object) && !iseffect(hit_object))
		hit_object.visible_message(span_danger("\The [hit_object]猛击进\the [src]并迅速化为灰烬."), null,
			span_hear("你听到一声巨响,一股热浪席卷了你."))
	else
		return

	playsound(get_turf(src), 'sound/effects/supermatter.ogg', 50, TRUE)
	consume(hit_object) //all bumped objects get consume() called on them

/obj/structure/prop/mainship/radiationcollector
	name = "辐射收集阵列"
	desc = "一种利用辐射和等离子体产生能量的装置."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "radcollector"
	layer = BELOW_OBJ_LAYER
	resistance_flags = RESIST_ALL

/obj/structure/prop/mainship/invincibleshutter
	name = "\improper 重型百叶窗"
	desc = "一组重型防爆百叶窗."
	icon = 'icons/obj/doors/mainship/blastdoors_shutters.dmi'
	icon_state = "shutter1"
	density = TRUE
	layer = BELOW_OBJ_LAYER
	light_range = 4
	resistance_flags = RESIST_ALL //no delaminations here
	allow_pass_flags = NONE
	opacity = TRUE

/obj/structure/prop/mainship/doorblocker //doors that exist only to block access, used mostly for valhalla omegastation
	name = "\improper 栅栏气闸"
	icon = 'icons/obj/structures/mainship_props.dmi'
	resistance_flags = RESIST_ALL
	allow_pass_flags = NONE
	desc = "它会打开和关闭."
	opacity = TRUE

/obj/structure/prop/mainship/doorblocker/maint
	name = "\improper 维护舱口"
	icon_state = "maint_locked"

/obj/structure/prop/mainship/doorblocker/external
	name = "\improper 外部气闸"
	icon_state = "exit_locked"

/obj/structure/prop/mainship/doorblocker/engi
	name = "\improper 外部气闸"
	icon_state = "engi_locked"

/obj/structure/prop/mainship/doorblocker/evac
	name = "\improper 撤离气闸"
	icon_state = "secure_locked"

/obj/structure/prop/mainship/doorblocker/command
	name = "\improper 指挥气闸"
	icon_state = "command_locked"

/obj/structure/prop/mainship/doorblocker/patrol_base
	name = "\improper 主气闸"
	icon_state = "command_locked"

/obj/structure/prop/mainship/doorblocker/patrol_base/som
	icon_state = "security_locked"

/obj/structure/prop/mainship/doorblocker/patrol_base/wide_left
	icon_state = "secure_wide_left_locked"

/obj/structure/prop/mainship/doorblocker/patrol_base/wide_right
	icon_state = "secure_wide_right_locked"

/obj/structure/prop/mainship/telecomms
	name = "子空间广播器"
	desc = "一台强大的硬件设备,用于广播处理过的子空间信号."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "broadcaster_send"

/obj/structure/prop/mainship/telecomms/hub
	name = "子空间广播器"
	desc = "一台强大的硬件设备,用于发送/接收大量数据."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "hub"

/obj/structure/prop/mainship/telecomms/processor
	name = "处理器单元"
	desc = "这台机器用于处理大量信息."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "processor"

/obj/structure/prop/mainship/telecomms/bus
	name = "总线主机"
	desc = "一台强大的硬件设备,用于快速发送大量数据."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "bus"

/obj/structure/prop/mainship/telecomms/broadcaster
	name = "子空间广播器"
	desc = "这台机器呈碟形,带有绿色指示灯.它被设计用于探测和处理子空间无线电活动."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "broadcaster"

/obj/structure/prop/mainship/telecomms/receiver
	name = "子空间接收器"
	desc = "一台碟形机器,用于广播处理过的子空间信号."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "broadcast receiver"

/obj/structure/prop/mainship/telecomms/relay
	name = "电信中继器"
	desc = "一台强大的硬件设备,用于将大量数据发送到很远的地方."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "relay"

/obj/structure/prop/mainship/suit_storage_prop
	name = "宇航服储存单元"
	desc = "一个工业级U-Stor-It储存单元,设计用于容纳各种宇航服.其内置设备还允许用户通过紫外线净化循环对内容物进行消毒.控制面板上悬挂着一个警告标签,上面写着\"严禁在单元范围内放置生物制品\".这个似乎被磁力锁住了."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "suitstorageclose"

/obj/structure/prop/mainship/protolathe
	name = "宇航服储存单元"
	desc = "一台用于处理数据和生产部门专用工具的巨型机器.一个标有'服务器连接'的小警告灯正在闪烁红光"
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "protolathe"

/obj/structure/prop/mainship/protolathe/engi
	name = "工程原型机"

/obj/structure/prop/mainship/protolathe/sci
	name = "研究原型机"

/obj/structure/prop/mainship/protolathe/medical
	name = "医疗原型机"

/obj/structure/prop/mainship/protolathe/security
	name = "安保原型机"

/obj/structure/prop/mainship/protolathe/service
	name = "服务原型机"

/obj/structure/prop/mainship/protolathe/cargo
	name = "货运原型机"

/obj/structure/prop/mainship/cannon_cables/ex_act()
	return

/obj/structure/prop/mainship/research
	icon = 'icons/obj/machines/research.dmi'

/obj/structure/prop/mainship/research/circuit_imprinter
	name = "电路印刷机"
	icon_state = "circuit_imprinter"
	desc = "制造用于建造机器的电路板."

/obj/structure/prop/mainship/research/mechafab
	icon_state = "mechfab1"
	name = "外骨骼制造机"
	desc = "未在建造任何东西."

/obj/structure/prop/mainship/research/destructive_analyzer
	name = "破坏性分析仪"
	desc = "通过摧毁东西来学习科学!"
	icon_state = "d_analyzer"

/obj/structure/prop/mainship/research/tdoppler
	name = "快子多普勒阵列"
	desc = "一种高精度定向传感器阵列,用于测量衰变快子释放的量子.这些量子形成的镜像的多普勒频移可以揭示阵列前方大范围内能量扰动的大小,位置和时间影响.\n"
	icon_state = "tdoppler"

/obj/structure/prop/mainship/research/explosivecompressor
	name = "异常精炼机"
	desc = "一种先进的机器,能够将原始异常核心内爆压缩为成品神器.还配备了最先进的炸弹预测软件."
	icon_state = "explosive_compressor"

/obj/structure/prop/mainship/research/tankcompressor
	name = "储罐压缩机"
	desc = "重型屏蔽空气压缩机,设计用于将储罐加压至安全限值以上."
	icon_state = "tank_compressor-open"

/obj/structure/prop/mainship/generator
	name = "力场发生器"
	desc = "一种大型热能电池,通电时能投射大量能量."
	icon = 'icons/obj/machines/field_generator.dmi'
	icon_state = "Field_Gen"
	anchored = FALSE
	density = TRUE
	//100% immune to lasers and energy projectiles since it absorbs their energy.
	soft_armor = list(MELEE = 25, BULLET = 10, LASER = 100, ENERGY = 100, BOMB = 0, BIO = 0, FIRE = 50, ACID = 70)
	resistance_flags = RESIST_ALL

/obj/structure/prop/mainship/generator/shieldgen
	name = "防破口护盾投射器"
	desc = "用于封堵小型船体破口."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "shieldoff"

/obj/structure/prop/mainship/generator/tesla_coil
	name = "特斯拉线圈"
	desc = "为了联盟!"
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "coil_open0"

/obj/structure/prop/mainship/generator/ground_rod
	name = "接地棒"
	desc = "防止区域被爱迪生之祸烤焦,对准军事组织常配发的便携式特斯拉炮无效."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "grounding_rod_open0"

/obj/structure/prop/mainship/cannon_cable_connector
	name = "\improper 加农炮电缆连接器"
	desc = "大型加农炮电缆的连接器."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "cannon_cable_connector"
	density = TRUE

/obj/structure/prop/mainship/reflector
	name = "\improper 反射镜"
	desc = "用于反射激光束的斜角镜."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "reflector_prop"
	density = TRUE
	anchored = FALSE
	resistance_flags = XENO_DAMAGEABLE

/obj/structure/prop/mainship/cannon_cable_connector/ex_act()
	return

/obj/structure/prop/mainship/prop_sec
	name = "安保军官"
	desc = "一名守卫周边的NT安保军官.他们看起来相当忙碌,没有注意到你."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "secprop"
	resistance_flags = RESIST_ALL
	density = TRUE

/obj/structure/prop/mainship/prop_so
	name = "军官"
	desc = "一名负责当前行动的参谋军官,要么忙于操作观察控制台,要么只是看着你和你的战友,希望你们能成功,话虽如此,最好还是别打扰他们."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "officerprop"
	resistance_flags = RESIST_ALL
	density = TRUE

/obj/structure/prop/mainship/prop_so/som
	icon_state = "officersomprop"

/obj/structure/prop/mainship/prop_tech
	name = "技术员"
	desc = "一名辛勤工作的技术员,负责维护基地的载具以及基地本身.他们现在似乎正忙着调查什么."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "techieprop"
	resistance_flags = RESIST_ALL
	density = TRUE

/obj/structure/prop/mainship/prop_tech/som
	name = "SOM技术员"
	desc = "一名辛勤工作的SOM技术员,负责维护基地的载具以及基地本身.他们现在似乎正忙着调查什么."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "SOM_technician"

/obj/structure/prop/mainship/prop_tech/som/alt
	icon_state = "SOM_technician_2"

/obj/structure/prop/mainship/prop_sominf
	name = "SOM步兵"
	desc = "标准火星之子步兵,手持V-31突击步枪.虽然他们的脸被面罩遮住,但感觉你应该继续前进而不是闲逛."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "som_inf"
	resistance_flags = RESIST_ALL
	density = TRUE

/obj/structure/prop/mainship/prop_sominf/heavy
	name = "SOM重装步兵"
	desc = "火星之子重装步兵,手持VX-32充能枪.虽然他们的脸被面罩遮住,但感觉你应该继续前进而不是闲逛."
	icon_state = "SOM_heavy_armed"

/obj/structure/prop/mainship/prop_sominf/heavy/unarmed
	name = "SOM重装步兵"
	desc = "火星之子重装步兵.最好别管他们在做什么."
	icon_state = "SOM_heavy"

/obj/structure/prop/mainship/prop_sominf/lorica
	name = "SOM重装步兵"
	desc = "身穿重型洛里卡装甲的火星之子步兵,手持VX-32充能枪.他们看起来可不是在闹着玩."
	icon_state = "lorica_armed"

/obj/structure/prop/mainship/prop_sominf/lorica/unarmed
	name = "SOM重装步兵"
	desc = "身穿重型洛里卡装甲的火星之子步兵.他们看起来相当强悍."
	icon_state = "lorica"

/obj/structure/prop/mainship/som_scientist
	name = "SOM科学家"
	desc = "一名辛勤工作的SOM科学家.他们看起来正在做重要的事情."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "SOM_scientist"
	resistance_flags = RESIST_ALL
	density = TRUE

/obj/structure/prop/mainship/som_scientist/alt
	icon_state = "SOM_scientist_2"

/obj/structure/prop/templedoor
	name = "奇异神殿"
	icon = 'icons/obj/doors/Doorsand.dmi'
	icon_state = "door_open"
	density = FALSE

/obj/structure/prop/oresilo
	name = "矿石筒仓"
	desc = "一种一体化蓝空间存储与传输系统,满足殖民地的矿物分配需求.这个似乎已停用."
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "silo"
	density = TRUE

/obj/structure/prop/mainship/propcarp
	name = "太空鲤鱼"
	desc = "一种凶猛的,长着尖牙的生物,外形类似鱼."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "carpprop"
	density = TRUE

/obj/structure/prop/mainship/propcarp/Initialize(mapload) //slightly randomize carp to simulate life
	. = ..()
	var/pickedrotate = pick(0,1,2,4,8,10)
	switch(pickedrotate) //prop carp can randomly move two tiles in any direction
		if(0) //1/6th chance of not moving in a random direction
			return
		if(1)
			dir = NORTH
			pixel_y = 64
		if(2)
			dir = SOUTH
			pixel_y = -64
		if(4)
			dir = EAST
			pixel_x = 64
		if(8)
			dir = WEST
			pixel_x = -64
		if(10)
			qdel(src)
		//remember that each carp must have at least 2 free spaces around them per carp, or they'll glitch into walls and/or each other

/obj/structure/prop/mainship/aislipprop
	name = "泡沫喷射器"
	desc = "一种可远程激活的喷射器,用于喷射人群控制泡沫."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "aislipper"
	density = FALSE
	resistance_flags = RESIST_ALL

/obj/structure/prop/mainship/turretprop
	name = "激光炮塔"
	desc = "一种由纳米传讯提供的点防御激光炮塔.这个看起来未激活."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "turretprop"
	resistance_flags = RESIST_ALL

/obj/structure/prop/mainship/tubeprop
	name = "气动管道"
	desc = "一种常用于纳米传讯研究站运输的气动管道."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "tubepropstraight"
	resistance_flags = RESIST_ALL
	layer = ABOVE_OBJ_LAYER //so our fake prop can visually pass under glass panels

/obj/structure/prop/mainship/tubeprop/decorative
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "decorative"
	resistance_flags = RESIST_ALL
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/mainship/tubeprop/end
	icon_state = "tubepropend"

/obj/structure/prop/mainship/tubeprop/diagonal
	icon_state = "tubepropdiagonal"

/obj/structure/prop/mainship/tubeprop/decorativediagonal
	icon_state = "decorative_diag"

/obj/structure/prop/mainship/tubeprop/tubejunction
	icon_state = "tubejunction"

/obj/structure/prop/mainship/tubeprop/tubecurved
	icon_state = "tubecurved"

/obj/structure/prop/mainship/meterprop/
	name = "流量计"
	desc = "那是个气体流量计.它测量某种东西."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "propmeterempty"
	resistance_flags = RESIST_ALL
	density = FALSE

/obj/structure/prop/mainship/meterprop/empty
	icon_state = "propmeterempty"

/obj/structure/prop/mainship/meterprop/random
	icon_state = "propmeter"
	var/kpa //fake temperatures and pressures for our meter
	var/kelvin

/obj/structure/prop/mainship/meterprop/random/examine(mob/user)
	. = ..()
	. += span_notice("压力表读数为[kpa] kPa; [kelvin] K ([kelvin - 273.15]°C)") //output fake kelvin and celsius on examine

/obj/structure/prop/mainship/meterprop/empty/examine(mob/user)
	. = ..()
	. += span_notice("压力表读数为0 kPa; 0 K (-273.15°C)") //output fake kelvin and celsius on examine

/obj/structure/prop/mainship/meterprop/random/Initialize(mapload)
	. = ..()
	kpa = randfloat(9.3, 21.4)
	kelvin = randfloat(10.3, 28.4)

/obj/structure/prop/mainship/pipeprop //does not init and so doesn't generate lag at all
	name = "管道"
	desc = "一米长的常规管道."
	icon = 'icons/obj/atmospherics/pipes/simple.dmi'
	icon_state = "pipe11-2"
	density = FALSE
	layer = GAS_PIPE_VISIBLE_LAYER

/obj/structure/prop/mainship/pipeprop/manifold
	name = "管道歧管"
	desc = "由常规管道组成的歧管."
	icon = 'icons/obj/atmospherics/pipes/manifold.dmi'
	icon_state = "manifold-2"

/obj/structure/prop/mainship/pipeprop/pump
	name = "管道歧管"
	desc = "一种通过压力输送气体的泵."
	icon = 'icons/obj/atmospherics/components/binary_devices.dmi'
	icon_state = "pump_map-2"

/obj/structure/prop/mainship/pipeprop/pump/on
	icon_state = "pump_on"
	layer = GAS_PUMP_LAYER

/obj/structure/prop/mainship/halfbuilt_mech
	name = "半组装的机甲"
	desc = "一台半组装的机甲.它缺少肢体,维护端口敞开着.你最好别乱动它."
	icon_state = ""
	pixel_x = -16
	/// selected parts you want displayed. remove parts if you dont want them
	var/selected_parts = list(
		MECH_GREY_TORSO = MECH_ASSAULT,
		MECH_GREY_LEGS = MECH_ASSAULT,
		MECH_GREY_L_ARM = MECH_ASSAULT,
	)

/obj/structure/prop/mainship/halfbuilt_mech/Initialize(mapload)
	. = ..()
	var/default_colors = MECH_GREY_PRIMARY_DEFAULT + MECH_GREY_SECONDARY_DEFAULT
	var/default_visor = MECH_GREY_VISOR_DEFAULT
	var/new_overlays = list()
	for(var/slot in selected_parts)
		var/datum/mech_limb/head/typepath = get_mech_limb(slot, selected_parts[slot])
		if(slot == MECH_GREY_L_ARM || slot == MECH_GREY_R_ARM)
			var/iconstate = "left"
			if(slot == MECH_GREY_R_ARM)
				iconstate = "right"
			new_overlays += iconstate2appearance(SSgreyscale.GetColoredIconByType(initial(typepath.greyscale_type), default_colors), iconstate)
			continue
		new_overlays += icon2appearance(SSgreyscale.GetColoredIconByType(initial(typepath.greyscale_type), default_colors))
		if(slot == MECH_GREY_HEAD)
			new_overlays += icon2appearance(SSgreyscale.GetColoredIconByType(initial(typepath.visor_config), default_visor))
	overlays = new_overlays

/obj/structure/prop/mainship/halfbuilt_mech/legs
	desc = "腿部."
	selected_parts = list(
		MECH_GREY_LEGS = MECH_RECON,
	)

/obj/structure/prop/mainship/halfbuilt_mech/vanguard
	selected_parts = list(
		MECH_GREY_TORSO = MECH_VANGUARD,
		MECH_GREY_HEAD = MECH_VANGUARD,
		MECH_GREY_LEGS = MECH_VANGUARD,
		MECH_GREY_L_ARM = MECH_VANGUARD,
	)

/obj/structure/prop/mainship/halfbuilt_mech/vanguard_finished
	name = "先锋机甲"
	desc = "一种先进的前卫底盘机甲.这是军事硬件领域的最新进展,服役时间尚短,尚未投入量产."
	selected_parts = list(
		MECH_GREY_TORSO = MECH_VANGUARD,
		MECH_GREY_HEAD = MECH_VANGUARD,
		MECH_GREY_LEGS = MECH_VANGUARD,
		MECH_GREY_L_ARM = MECH_VANGUARD,
		MECH_GREY_R_ARM = MECH_VANGUARD,
	)

/obj/structure/prop/mainship/chimney
	name = "壁炉"
	desc = "一座大型石砖壁炉."
	icon = 'icons/obj/structures/mainship_props64.dmi'
	icon_state = "fireplace"

//items props

/obj/item/prop
	name = "通用飞船道具"
	desc = "这不应可见,若在回合中看到请报告位置并输入AHELP 'ART-P03'"
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "hangarbox"

/obj/item/prop/aimodule
	name = "AI模块"
	desc = "用于为AI编写法则的AI模块."
	icon_state = "std_mod"

/obj/item/prop/aimodule/Initialize(mapload)
	. = ..()
	name = pick("'Safeguard' AI Module'",
				"'OneHuman' AI Module",
				"'ProtectStation' AI Module",
				"'Quarantine' AI Module",
				"'OxygenIsToxicToHumans' AI Module",
				"'Freeform' AI Module",
				"\improper 'Remove Law' AI module",
				"\improper 'Reset' AI module",
				"'Purge' AI Module",
				"'Asimov' Core AI Module",
				"'Asimov++' Core AI Module",
				"'Corporate' Core AI Module",
				"'P.A.L.A.D.I.N. version 3.5e' Core AI Module",
				"'T.Y.R.A.N.T.' Core AI Module",
				"'Robo-Officer' Core AI Module",
				"'Antimov' Core AI Module",
				"'Freeform' Core AI Module",
				"'Mother Drone' Core AI Module",
				"'Robodoctor' Core AI Module",
				"'Reportertron' Core AI Module",
				"'Thermodynamic' Core AI Module",
				"'Live And Let Live' Core AI Module",
				"'Guardian of Balance' Core AI Module",
				"'Station Efficiency' Core AI Module",
				"'Peacekeeper' Core AI Module",
				"'H.O.G.A.N.' Core AI Module",
	)

/obj/item/prop/aicard
	name = "智能卡"
	desc = "用于存储AI的存储设备.专利申请中."
	icon_state = "aicard"

/obj/item/prop/aicard/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "aicard-404"

/obj/item/prop/dogtag
	name = "无名氏" //generic name
	desc = "一名早已死去的陆战队员的遗骸,你希望他们已得到安息."
	icon = 'icons/obj/items/card.dmi'
	icon_state = "dogtag"

/obj/item/prop/dogtag/pfcjim
	name = "一等兵吉姆的狗牌"
	desc = "无论一等兵吉姆是谁,你希望他活着逃了出来."
	icon = 'icons/obj/items/card.dmi'
	icon_state = "dogtag"

/obj/item/prop/dogtag/random/Initialize(mapload)
	. = ..()
	name = GLOB.namepool[/datum/namepool].get_random_name(pick(MALE, FEMALE))

///BROKEN MARINE VENDOR PROPS

/obj/structure/prop/brokenvendor
	name = "\improper 损坏的售货机"
	icon = 'icons/obj/structures/mainship_props.dmi'
	desc = "这台售货机的内部裸露在外且锈迹斑斑,你感觉这台机器已经无法修复了."
	density = TRUE
	resistance_flags = XENO_DAMAGEABLE

/obj/structure/prop/brokenvendor/brokenweaponsrack
	icon_state = "marinearmory-broken"

/obj/structure/prop/brokenvendor/brokenuniformvendor
	name = "\improper 损坏的自动制服柜"
	icon_state = "marineuniform-broken"

/obj/structure/prop/brokenvendor/brokenuniformvendor/specialist
	name = "\improper 损坏的专家装备架"
	icon_state = "specialist-broken"
	desc = "你徒劳地研究着这具锈蚀的残骸,试图辨认这台售货机原本是什么,最终意识到这毫无希望."

/obj/structure/prop/brokenvendor/brokenspecialistvendor/sg
	name = "\improper 损坏的自动智能枪手柜"
	icon_state = "marineuniform-broken"

/obj/structure/prop/brokenvendor/brokenspecialistvendor/leader
	name = "\improper 损坏的自动队长柜"
	icon_state = "marineuniform-broken"

/obj/structure/prop/brokenvendor/brokenspecialistvendor/corpsman
	name = "\improper 损坏的自动医护兵柜"
	icon_state = "marineuniform-broken"

/obj/structure/prop/brokenvendor/brokenspecialistvendor/engineer
	name = "\improper 损坏的自动工程师柜"
	icon_state = "marineuniform-broken"

/obj/structure/prop/brokenvendor/brokenmarinemedvendor
	icon_state = "marinemed-broken"

/obj/structure/prop/brokenvendor/brokennanomedvendor
	icon_state = "med-broken"

/obj/structure/prop/brokenvendor/brokencorpsmanvendor
	icon_state = "corpsmanvendor-broken"

/obj/structure/prop/brokenvendor/engivend
	icon_state = "engivend-broken"

/obj/structure/prop/brokenvendor/surplusclothes
	name = "\improper 损坏的剩余衣物售货机"
	icon_state = "surplus_clothes-broken"

/obj/structure/prop/brokenvendor/surplusarmor
	name = "\improper 损坏的护甲衣物售货机"
	icon_state = "surplus_armor-broken"

///BROKEN VEHICLE PROPS
/obj/structure/prop/vehicle
	icon = 'icons/obj/vehicles/64x64.dmi'
	layer = ABOVE_MOB_LAYER
	density = TRUE
	resistance_flags = XENO_DAMAGEABLE
	max_integrity = 300
	coverage = 80
	soft_armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 65, BOMB = 30, BIO = 100, FIRE = 75, ACID = 0)

/obj/structure/prop/vehicle/van
	name = "厢式货车"
	desc = "一辆旧厢式货车,似乎已经抛锚了."
	icon_state = "van"
	bound_height = 32
	bound_width = 64

/obj/structure/prop/vehicle/van/Initialize(mapload)
	. = ..()
	if(dir & (NORTH|SOUTH))
		bound_height = 64
		bound_width = 32

/obj/structure/prop/vehicle/van/wreck
	icon_state = "van_wrecked"

/obj/structure/prop/vehicle/truck
	name = "卡车"
	desc = "一辆旧卡车,似乎已经抛锚了."
	icon_state = "truck"
	bound_height = 32
	bound_width = 64

/obj/structure/prop/vehicle/truck/Initialize(mapload)
	. = ..()
	setDir(dir)

/obj/structure/prop/vehicle/truck/setDir(newdir)
	. = ..()
	if(dir & (WEST|EAST))
		bound_height = 32
		bound_width = 64
		pixel_x = 0
	else
		bound_height = 64
		bound_width = 32
		pixel_x = -16

/obj/structure/prop/vehicle/truck/damaged
	icon_state = "truck_damaged"

/obj/structure/prop/vehicle/truck/snow
	icon_state = "truck_snow"

/obj/structure/prop/vehicle/truck/truckcargo
	icon_state = "truck_cargo"
	max_integrity = 400

/obj/structure/prop/vehicle/truck/truckcargo/snow
	icon_state = "truck_cargo_snow"

/obj/structure/prop/vehicle/crane
	name = "起重机"
	desc = "一台旧起重机,似乎已经抛锚了."
	icon_state = "crane"
	bound_height = 64
	bound_width = 64
	max_integrity = 400

/obj/structure/prop/vehicle/crane/damaged
	icon_state = "crane_damaged"

/obj/structure/prop/vehicle/crane/wreck
	icon_state = "crane_wreck"

/obj/structure/prop/vehicle/crane/snow
	icon_state = "crane_snow"

/obj/structure/prop/vehicle/crane/cranecargo
	icon_state = "crane_cargo"
	max_integrity = 400

/obj/structure/prop/vehicle/crawler
	name = "履带车"
	desc = "一辆旧履带车,似乎已经抛锚了."
	icon_state = "crawler"
	bound_height = 32
	bound_width = 64
	max_integrity = 400

/obj/structure/prop/vehicle/crawler/crawler_blue
	icon_state = "crawler_crate_b"

/obj/structure/prop/vehicle/crawler/crawler_red
	icon_state = "crawler_crate_r"

/obj/structure/prop/vehicle/crawler/crawler_green
	icon_state = "crawler_crate_g"

/obj/structure/prop/vehicle/crawler/crawler_fuel
	icon_state = "crawler_fuel"

/obj/structure/prop/vehicle/crawler/crawler_cargo
	icon_state = "crawler_cargo"

/obj/structure/prop/vehicle/big_truck
	name = "军用卡车"
	desc = "一辆军用卡车,用于批量运输装备或人员."
	icon = 'icons/obj/vehicles/large_truck.dmi'
	icon_state = "truck"
	bound_height = 128
	bound_width = 128
	max_integrity = 700

/obj/structure/prop/vehicle/big_truck/Initialize(mapload)
	. = ..()
	setDir(dir)

/obj/structure/prop/vehicle/big_truck/setDir(dir)
	. = ..()
	if(dir & (NORTH|SOUTH))
		bound_height = 96
		bound_width = 32
		bound_x = 0
		bound_y = -32
		pixel_x = -32
		pixel_y = -32
	else
		bound_height = 32
		bound_width = 96
		bound_x = -32
		bound_y = 0
		pixel_x = -32
		pixel_y = -22

/obj/structure/prop/vehicle/big_truck/flat
	icon_state = "truck_flat"

/obj/structure/prop/vehicle/big_truck/enclosed
	icon_state = "truck_enclosed"

/obj/structure/prop/vehicle/big_truck/wrecked
	icon_state = "truck_wrecked"

/obj/structure/prop/vehicle/big_truck/flat_wrecked
	icon_state = "truck_flat_wrecked"

/obj/structure/prop/vehicle/big_truck/enclosed_wrecked
	icon_state = "truck_enclosed_wrecked"

/obj/structure/prop/vehicle/big_truck/tread
	icon_state = "truck_treads"

/obj/structure/prop/vehicle/big_truck/flat_tread
	icon_state = "truck_flat_treads"

/obj/structure/prop/vehicle/big_truck/enclosed_tread
	icon_state = "truck_enclosed_treads"

/obj/structure/prop/vehicle/big_truck/wrecked_tread
	icon_state = "truck_treads_wrecked"

/obj/structure/prop/vehicle/big_truck/flat_wrecked_tread
	icon_state = "truck_flat_treads_wrecked"

/obj/structure/prop/vehicle/big_truck/enclosed_wrecked_tread
	icon_state = "truck_enclosed_treads_wrecked"


/obj/structure/prop/vehicle/tank
	name = "退役TAV - 犀牛"
	desc = "一辆退役坦克,所有推进方式均已禁用,入口已封闭."
	icon = 'icons/obj/structures/tank_prop_north_south.dmi'
	icon_state = "tank_complete"
	bound_height = 128
	bound_width = 128
	resistance_flags = RESIST_ALL

/obj/structure/prop/vehicle/tank/north
	icon = 'icons/obj/structures/tank_prop_north_south.dmi'
	icon_state = "tank_complete"
	bound_height = 128
	bound_width = 96

/obj/structure/prop/vehicle/tank/north/base
	name = "退役TAV - 犀牛"
	desc = "一辆退役坦克的底座."
	icon_state = "tank_base"

/obj/structure/prop/vehicle/tank/north/altnorth
	icon_state = "tank_complete_alt"

/obj/structure/prop/vehicle/tank/east
	icon = 'icons/obj/structures/tank_prop_east_west.dmi'
	icon_state = "tank_complete"
	bound_height = 96
	bound_width = 128

/obj/structure/prop/vehicle/tank/east/base
	name = "退役TAV - 犀牛"
	desc = "一辆退役坦克的底座."
	icon_state = "tank_base"

/obj/structure/prop/vehicle/tank/east/turret
	icon_state = "turret_viper"
	layer = TANK_TURRET_LAYER
	desc = "一辆退役坦克的炮塔."

/obj/structure/prop/vehicle/tank/east/turret/complete
	icon_state = "turret_complete"

/obj/structure/prop/vehicle/tank/east/turretalt
	icon_state = "turret_cobra"
	layer = TANK_TURRET_LAYER
	desc = "一辆退役坦克的炮塔."

/obj/structure/prop/vehicle/tank/east/barrel
	icon_state = "ltb_cannon_0"
	layer = ABOVE_MOB_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/vehicle/tank/east/barrel/broken
	icon_state = "ltb_cannon_1"

/obj/structure/prop/vehicle/tank/east/barrel/minigun
	icon_state = "ltaaap_minigun_0"

/obj/structure/prop/vehicle/tank/east/barrel/minigunbroken
	icon_state = "ltaaap_minigun_1"

/obj/structure/prop/vehicle/tank/east/alteast
	icon_state = "tank_complete_alt"

/obj/structure/prop/vehicle/tank/east/decoration
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = TANK_DECORATION_LAYER

/obj/structure/prop/vehicle/tank/east/decoration/treads
	icon_state = "treads_stationary"

/obj/structure/prop/vehicle/tank/east/decoration/damagedtreads
	icon_state = "damaged_hardpt_treads"

/obj/structure/prop/vehicle/tank/east/decoration/armor
	icon_state = "caustic_armor"

/obj/structure/prop/vehicle/tank/east/decoration/armor/causticarmor
	icon_state = "caustic_armor"

/obj/structure/prop/vehicle/tank/east/decoration/armor/concussivearmor
	icon_state = "concussive_armor"

/obj/structure/prop/vehicle/tank/east/decoration/armor/ballisticarmor
	icon_state = "ballistic_armor"

/obj/structure/prop/vehicle/tank/east/decoration/armor/paladinarmor
	icon_state = "paladin_armor"

/obj/structure/prop/vehicle/tank/east/decoration/damagedhardpoint
	icon_state = "damaged_hardpt_armor"

/obj/structure/prop/vehicle/tank/east/decoration/damagedhardpointframe
	icon_state = "damaged_hardpt_frame"

/obj/structure/prop/vehicle/tank/east/decoration/damagedhardpointturret
	icon_state = "damaged_hardpt_turret"

/obj/structure/prop/vehicle/tank/east/decoration/damagedhardpointone
	icon_state = "damaged_hardpt_primary"

/obj/structure/prop/vehicle/tank/east/decoration/damagedhardpointtwo
	icon_state = "damaged_hardpt_secondary"

/obj/structure/prop/vehicle/tank/east/decoration/damagedhardpointthree
	icon_state = "damaged_hardpt_support"

/obj/structure/prop/vehicle/tank/east/decoration/slaunchone
	icon_state = "slauncher_0"

/obj/structure/prop/vehicle/tank/east/decoration/slaunchtwo
	icon_state = "slauncher_1"

/obj/structure/prop/vehicle/tank/east/decoration/slaunchthree
	icon_state = "slauncher_2"

/obj/structure/prop/vehicle/tank/east/decoration/driveenhancerone
	icon_state = "odrive_enhancer_1"

/obj/structure/prop/vehicle/tank/east/decoration/driveenhancerzero
	icon_state = "odrive_enhancer_0"

/obj/structure/prop/vehicle/tank/east/decoration/flamer
	icon_state = "flamer_1"

/obj/structure/prop/vehicle/tank/east/decoration/glauncherone
	icon_state = "glauncher_1"

/obj/structure/prop/vehicle/tank/east/decoration/glauncherzero
	icon_state = "glauncher_0"

/obj/structure/prop/vehicle/tank/east/decoration/cupolaone
	icon_state = "hsg102cupola_1"

/obj/structure/prop/vehicle/tank/east/decoration/cupolazero
	icon_state = "hsg102cupola_0"

/obj/structure/prop/vehicle/tank/east/decoration/towlauncherone
	icon_state = "towlauncher_1"

/obj/structure/prop/vehicle/tank/east/decoration/towlauncherzero
	icon_state = "towlauncher_0"

/obj/structure/prop/vehicle/tank/east/decoration/warrayone
	icon_state = "warray_1"

/obj/structure/prop/vehicle/tank/east/decoration/warrayzero
	icon_state = "warray_0"

/obj/structure/prop/vehicle/tank/east/decoration/artmodone
	icon_state = "artillerymod_1"

/obj/structure/prop/vehicle/tank/east/decoration/artmodzero
	icon_state = "artillerymod_0"

/obj/structure/prop/vehicle/tank/east/armor/snowplow
	icon_state = "snowplow_0"

/obj/structure/prop/vehicle/tank/east/armor/snowplowone
	icon_state = "snowplow_1"

/obj/structure/prop/vehicle/tank/north/turret
	icon_state = "turret_viper"
	layer = TANK_TURRET_LAYER
	desc = "一辆退役坦克的炮塔."

/obj/structure/prop/vehicle/tank/north/turret/complete
	icon_state = "turret_complete"

/obj/structure/prop/vehicle/tank/north/turretalt
	icon_state = "turret_cobra"
	layer = TANK_TURRET_LAYER
	desc = "一辆退役坦克的炮塔."

/obj/structure/prop/vehicle/tank/north/barrel
	icon_state = "ltb_cannon_0"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/vehicle/tank/north/barrel/broken
	icon_state = "ltb_cannon_1"

/obj/structure/prop/vehicle/tank/north/barrel/minigun
	icon_state = "ltaaap_minigun_0"

/obj/structure/prop/vehicle/tank/north/barrel/minigunbroken
	icon_state = "ltaaap_minigun_1"

/obj/structure/prop/vehicle/tank/north/altnorth
	icon_state = "tank_complete_alt"

/obj/structure/prop/vehicle/tank/north/decoration
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = TANK_DECORATION_LAYER

/obj/structure/prop/vehicle/tank/north/decoration/treads
	icon_state = "treads_stationary"

/obj/structure/prop/vehicle/tank/north/decoration/damagedtreads
	icon_state = "damaged_hardpt_treads"

/obj/structure/prop/vehicle/tank/north/decoration/armor
	icon_state = "caustic_armor"

/obj/structure/prop/vehicle/tank/north/decoration/armor/causticarmor
	icon_state = "caustic_armor"

/obj/structure/prop/vehicle/tank/north/decoration/armor/concussivearmor
	icon_state = "concussive_armor"

/obj/structure/prop/vehicle/tank/north/decoration/armor/ballisticarmor
	icon_state = "ballistic_armor"

/obj/structure/prop/vehicle/tank/north/decoration/armor/paladinarmor
	icon_state = "paladin_armor"

/obj/structure/prop/vehicle/tank/north/decoration/damagedhardpoint
	icon_state = "damaged_hardpt_armor"

/obj/structure/prop/vehicle/tank/north/decoration/damagedhardpointframe
	icon_state = "damaged_hardpt_frame"

/obj/structure/prop/vehicle/tank/north/decoration/damagedhardpointturret
	icon_state = "damaged_hardpt_turret"

/obj/structure/prop/vehicle/tank/north/decoration/damagedhardpointone
	icon_state = "damaged_hardpt_primary"

/obj/structure/prop/vehicle/tank/north/decoration/damagedhardpointtwo
	icon_state = "damaged_hardpt_secondary"

/obj/structure/prop/vehicle/tank/north/decoration/damagedhardpointthree
	icon_state = "damaged_hardpt_support"

/obj/structure/prop/vehicle/tank/north/decoration/slaunchone
	icon_state = "slauncher_0"

/obj/structure/prop/vehicle/tank/north/decoration/slaunchtwo
	icon_state = "slauncher_1"

/obj/structure/prop/vehicle/tank/north/decoration/slaunchthree
	icon_state = "slauncher_2"

/obj/structure/prop/vehicle/tank/north/decoration/driveenhancerone
	icon_state = "odrive_enhancer_1"

/obj/structure/prop/vehicle/tank/north/decoration/driveenhancerzero
	icon_state = "odrive_enhancer_0"

/obj/structure/prop/vehicle/tank/north/decoration/flamer
	icon_state = "flamer_1"

/obj/structure/prop/vehicle/tank/north/decoration/glauncherone
	icon_state = "glauncher_1"

/obj/structure/prop/vehicle/tank/north/decoration/glauncherzero
	icon_state = "glauncher_0"

/obj/structure/prop/vehicle/tank/north/decoration/cupolaone
	icon_state = "hsg102cupola_1"

/obj/structure/prop/vehicle/tank/north/decoration/cupolazero
	icon_state = "hsg102cupola_0"

/obj/structure/prop/vehicle/tank/north/decoration/towlauncherone
	icon_state = "towlauncher_1"

/obj/structure/prop/vehicle/tank/north/decoration/towlauncherzero
	icon_state = "towlauncher_0"

/obj/structure/prop/vehicle/tank/north/decoration/warrayone
	icon_state = "warray_1"

/obj/structure/prop/vehicle/tank/north/decoration/warrayzero
	icon_state = "warray_0"

/obj/structure/prop/vehicle/tank/north/decoration/artmodone
	icon_state = "artillerymod_1"

/obj/structure/prop/vehicle/tank/north/decoration/artmodzero
	icon_state = "artillerymod_0"

/obj/structure/prop/vehicle/tank/north/armor/snowplow
	icon_state = "snowplow_0"

/obj/structure/prop/vehicle/tank/north/armor/snowplowone
	icon_state = "snowplow_1"

/obj/structure/prop/vehicle/apc
	name = "退役TAV - 雅典娜"
	desc = "一辆退役装甲运兵车,所有推进方式均已禁用,入口已封闭."
	icon = 'icons/obj/structures/apc_prop.dmi'
	icon_state = "apc_base"
	bound_height = 128
	bound_width = 128
	resistance_flags = RESIST_ALL

/obj/structure/prop/vehicle/apc/Initialize(mapload)
	. = ..()
	if(dir == EAST || dir == WEST)
		bound_height = 64
		pixel_y = -20
	else
		bound_width = 64
		pixel_x = -34

/obj/structure/prop/vehicle/apc/med
	icon_state = "apc_base_med"

/obj/structure/prop/vehicle/apc/com
	icon_state = "apc_base_com"

/obj/structure/prop/vehicle/apc/wheelszero
	icon_state = "wheels_0"
	layer = TANK_TURRET_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/vehicle/apc/wheelsone
	icon_state = "wheels_1"
	layer = TANK_TURRET_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/vehicle/apc/damagedframe
	icon_state = "damaged_frame"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/vehicle/apc/damagedhptone
	icon_state = "damaged_hdpt_primary"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/vehicle/apc/damagedhpttwo
	icon_state = "damaged_hdpt_secondary"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/vehicle/apc/damagedhpthree
	icon_state = "damaged_hdpt_support"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/vehicle/apc/dualcannonzero
	icon_state = "dualcannon_0"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/vehicle/apc/dualcannonone
	icon_state = "dualcannon_1"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/vehicle/apc/decoration
	icon_state = "frontalcannon_0"
	density = FALSE
	layer = TANK_DECORATION_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/prop/vehicle/apc/decoration/frontturretzero
	icon_state = "frontalcannon_0"

/obj/structure/prop/vehicle/apc/decoration/frontturretone
	icon_state = "frontalcannon_1"

/obj/structure/prop/vehicle/apc/decoration/freightzero
	icon_state = "freight_0"

/obj/structure/prop/vehicle/apc/decoration/freightone
	icon_state = "freight_1"

/obj/structure/prop/vehicle/apc/decoration/freighttwo
	icon_state = "freight_2"

/obj/structure/prop/vehicle/apc/decoration/freighttwo
	icon_state = "freight_2"

/obj/structure/prop/vehicle/apc/decoration/commsrelayzero
	icon_state = "comms_relay_0"

/obj/structure/prop/vehicle/apc/decoration/commsrelayone
	icon_state = "comms_relay_1"

/obj/structure/prop/vehicle/apc/decoration/flarelauncherzero
	icon_state = "flare_launcher_0"

/obj/structure/prop/vehicle/apc/decoration/flarelauncherone
	icon_state = "flare_launcher_1"

/obj/structure/prop/vehicle/apc/decoration/flarelaunchertwo
	icon_state = "flare_launcher_2"

/obj/structure/prop/vehicle/apc/decoration/emptyfuelcell
	icon_state = "emptyfuelcell"

/obj/structure/prop/mainship/gelida/propplaceholder
	name = "道具占位符"
	desc = "有人搞砸了,请在Discord上联系地图作者并告知此物件的位置."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "placeholderprop"

/obj/structure/prop/mainship/gelida/smallwire
	name = "细铁丝"
	desc = "一小段用于封锁区域的铁丝."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "small_wire"
	density = FALSE

/obj/structure/prop/mainship/gelida/lightstick
	name = "灯柱"
	desc = "一根顶部带有空灯泡的柱子,用于照亮积雪密集的区域."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "lightstick_spoke1"
	density = FALSE

/obj/structure/prop/mainship/gelida/planterbox
	name = "种植箱"
	desc = "一个用于盛放生长植物的金属箱,这个是空的."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "planter_box_empty"
	layer = BELOW_OBJ_LAYER

/obj/structure/prop/mainship/gelida/planterboxsoil
	name = "种植箱"
	desc = "一个用于盛放生长植物的金属箱,这个装满了土壤."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "planter_box_soil"
	layer = BELOW_OBJ_LAYER

/obj/structure/prop/mainship/gelida/planterboxsoil/nondense
	density = FALSE
	name = "栈桥"
	desc = "一种可以行走的地板.这种带有间隙,可以看到下方的空间."

/obj/structure/prop/mainship/gelida/planterboxsoilgrid
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "soil_grid"
	layer = BELOW_OBJ_LAYER

/obj/structure/prop/mainship/gelida/planterboxsoilgrid/nondense
	density = FALSE
	name = "栈桥"
	desc = "一种可以行走的地板.这种带有间隙,可以看到下方的空间."

/obj/structure/prop/mainship/gelida/propserver
	name = "殖民地研究服务器"
	desc = "这台机器静静地立着,你可以看到其诊断面板上有一盏警示灯微弱地闪烁着."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "comm_server_off"

/obj/structure/prop/mainship/gelida/propserveralt
	name = "殖民地研究服务器"
	desc = "这台机器静静地立着,你可以看到其诊断面板上有一盏警示灯微弱地闪烁着."
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "server_alt"

/obj/structure/prop/mainship/gelida/barrier
	name = "安保屏障"
	desc = "一种可部署的屏障,由安保部队用于封锁区域."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "barrier0"

/obj/structure/prop/mainship/gelida/heavycablenode
	name = "重型电缆节点"
	desc = "一种重型电缆节点,用于在建筑之间连接高性能电缆."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "node"
	density = FALSE

/obj/structure/prop/mainship/gelida/powerconnector
	name = "重型电缆电源连接器"
	desc = "一种重型电缆节点,用于在建筑之间连接高性能电缆."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "powerconnector"
	layer = RUNE_LAYER
	plane = FLOOR_PLANE
	density = FALSE

/obj/structure/prop/mainship/gelida/powerccable
	name = "重型电缆线路"
	desc = "一种重型电缆线,用于在建筑之间进行快速数据传输."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "powercableheavy"
	layer = RUNE_LAYER
	plane = FLOOR_PLANE
	density = FALSE

/obj/structure/prop/mainship/gelida/powercconnectortwoside
	name = "重型电缆线路"
	desc = "一种重型电缆线,用于在建筑之间进行快速数据传输."
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "powerconnectortwoside"
	layer = RUNE_LAYER
	plane = FLOOR_PLANE
	density = FALSE

/obj/structure/prop/mainship/gelida/powercconnectortwosidealt
	name = "重型电缆线路"
	desc = "一根用于建筑间快速数据传输的重型线缆。"
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "powerconnectortwosidealt"
	layer = RUNE_LAYER
	plane = FLOOR_PLANE
	density = FALSE

/obj/structure/prop/mainship/gelida/powercconnectorthreeside
	name = "重型线缆"
	desc = "一根用于建筑间快速数据传输的重型线缆。"
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "powerconnectorthreeside"
	layer = RUNE_LAYER
	plane = FLOOR_PLANE
	density = FALSE

/obj/structure/prop/mainship/gelida/powercconnectorfourside
	name = "重型线缆"
	desc = "一根用于建筑间快速数据传输的重型线缆。"
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "powerconnectorfourside"
	layer = RUNE_LAYER
	plane = FLOOR_PLANE
	density = FALSE

/obj/structure/prop/mainship/gelida/rails
	name = "矿车轨道"
	desc = "用于引导矿车的金属轨道。"
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "rail"
	layer = BELOW_TABLE_LAYER
	density = FALSE

/obj/structure/prop/mainship/gelida/railbumper
	name = "矿车轨道缓冲器"
	desc = "一个用于拦截失控矿车的金属缓冲器。"
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "rail_bumpers"
	layer = BELOW_TABLE_LAYER
	density = FALSE

/obj/structure/prop/mainship/gelida/register
	name = "收银机"
	desc = "一台古董收银机,它只接受硬通货,不接受太空信用点。"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "register_static"
	density = FALSE

/obj/structure/prop/mainship/gelida/propladder
	name = "梯子"
	desc = "梯子摇摇欲坠,它与上层的连接被一大块锋利的金属切断了。"
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "ladder11"

/obj/structure/prop/mainship/gelida/miner
	name = "采矿机"
	desc = "机器静止不动,等待指令开始从地下开采自然资源。"
	icon = 'icons/obj/structures/mainship_props96.dmi'
	icon_state = "thumper"

/obj/structure/prop/radio_prop
	name = "无线电"
	desc = "一台标准军用无线电。"
	icon = 'icons/obj/items/radio.dmi'
	icon_state = "beacon"
	var/datum/looping_sound/radio/chatter_loop

/obj/structure/prop/radio_prop/Initialize(mapload, ...)
	. = ..()
	chatter_loop = new(null, FALSE)
	chatter_loop.start(src)

/obj/structure/prop/radio_prop/Destroy()
	QDEL_NULL(chatter_loop)
	return ..()

/obj/structure/prop/mainship/railing
	name = "栏杆"
	desc = "用于保护像你这样的白痴免于坠落的普通栏杆。"
	icon = 'icons/obj/structures/mainship_props.dmi'
	max_integrity = 50
	resistance_flags = XENO_DAMAGEABLE
	atom_flags = ON_BORDER
	climbable = TRUE
	climb_delay = 2 SECONDS
	allow_pass_flags = PASS_LOW_STRUCTURE|PASSABLE|PASS_WALKOVER
	icon_state = "railing"

/obj/structure/prop/mainship/railing/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_try_exit),
		COMSIG_OBJ_TRY_ALLOW_THROUGH = PROC_REF(can_climb_over),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/prop/mainship/railing/corner
	name = "栏杆"
	desc = "用于保护像你这样的白痴免于坠落的普通栏杆。"
	density = FALSE
	icon_state = "railing_corner"

/obj/structure/prop/mainship/solar
	name = "太阳能阵列"
	desc = "一块太阳能板。接触阳光时发电。"
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "sp_base"

/obj/structure/prop/mainship/solar/tracker
	name = "太阳追踪器"
	desc = "一个太阳能方向追踪器。"
	icon_state = "tracker_base"

/obj/structure/prop/vehicle/som_mech
	name = "掠夺者突击机甲"
	desc = "一种由SOM使用的重装武装机甲,用于带头突击,这台似乎已经无法运作。"
	icon = 'icons/obj/structures/mech_prop.dmi'
	icon_state = "som_mech"
	coverage = 70
	bound_width = 32
	pixel_x = -15
	pixel_y = -15
	resistance_flags = RESIST_ALL
	layer = ABOVE_MOB_LAYER

/obj/structure/prop/machine_frame3
	name = "机器框架"
	desc = "那是一个可建造的机器框架。"
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "box_2"

/obj/structure/prop/keycardauth
	name = "钥匙卡认证装置"
	desc = "该装置用于触发需要不止一张ID卡认证的空间站功能。"
	icon = 'icons/obj/monitors.dmi'
	icon_state = "auth_off"

/obj/structure/prop/turbine
	name = "动力涡轮机"
	desc = "一台靠谁知道什么东西运转的巨型涡轮机。大概懂行的人能把它启动起来。"
	icon = 'icons/obj/structures/mainship_props96.dmi'
	icon_state = "biomass_turbine"
	density = TRUE


//TG BROKEN VENDOR PROPS
//USE THESE SPARINGLY OUTSIDE OF TG THEMED MAPS OR I'LL BREAK YOUR KNEECAPS

/obj/structure/prop/tgbrokenvendor
	name = "\improper 损坏的售货机"
	icon = 'icons/obj/tg_vending_props.dmi'
	desc = "这台售货机的内部暴露在外且锈穿了,你感觉这台机器已经没救了。"
	density = TRUE
	///var to control vendor appearance, can be vendor_broken, vendor_working or vendor_blank
	var/vendorstate = VENDOR_BROKEN

/obj/structure/prop/tgbrokenvendor/Initialize(mapload)
	. = ..()
	vendorstate = pick(VENDOR_BROKEN, VENDOR_BLANK)
	if(vendorstate == VENDOR_BROKEN)
		icon_state += "-broken"
	else
		icon_state += "-off"

/obj/structure/prop/tgbrokenvendor/snackbrokebed
	icon_state = "snack"

/obj/structure/prop/tgbrokenvendor/snackbrokeblue
	icon_state = "snackblue"

/obj/structure/prop/tgbrokenvendor/snackbrokeorange
	icon_state = "snackorange"

/obj/structure/prop/tgbrokenvendor/snackbrokegreen
	icon_state = "snackgreen"

/obj/structure/prop/tgbrokenvendor/snackbroketeal
	icon_state = "snackteal"

/obj/structure/prop/tgbrokenvendor/smartfridge
	icon_state = "smartfridge"

/obj/structure/prop/tgbrokenvendor/dinnerware
	icon_state = "dinnerware"

/obj/structure/prop/tgbrokenvendor/cigs
	icon_state = "cigs"

/obj/structure/prop/tgbrokenvendor/generic
	icon_state = "generic"

/obj/structure/prop/tgbrokenvendor/sec
	icon_state = "sec"

/obj/structure/prop/tgbrokenvendor/nutri
	icon_state = "nutri"

/obj/structure/prop/tgbrokenvendor/seeds
	icon_state = "seeds"

/obj/structure/prop/tgbrokenvendor/cola
	icon_state = "cola-machine"

/obj/structure/prop/tgbrokenvendor/colablack
	icon_state = "cola_black"

/obj/structure/prop/tgbrokenvendor/colared
	icon_state = "cola_red"

/obj/structure/prop/tgbrokenvendor/spaceup
	icon_state = "space_up"

/obj/structure/prop/tgbrokenvendor/pwrgame
	icon_state = "starkist"

/obj/structure/prop/tgbrokenvendor/starkist
	icon_state = "pwr_game"

/obj/structure/prop/tgbrokenvendor/soda
	icon_state = "starkist"

/obj/structure/prop/tgbrokenvendor/sovietsoda
	icon_state = "sovietsoda"

/obj/structure/prop/tgbrokenvendor/coffee
	icon_state = "coffee"

/obj/structure/prop/tgbrokenvendor/boozeomat
	icon_state = "boozeomat"

/obj/structure/prop/tgbrokenvendor/magivend
	icon_state = "MagiVend"

/obj/structure/prop/tgbrokenvendor/med
	icon_state = "med"

/obj/structure/prop/tgbrokenvendor/drug
	icon_state = "drug"

/obj/structure/prop/tgbrokenvendor/engi
	icon_state = "engi"

/obj/structure/prop/tgbrokenvendor/robotics
	icon_state = "robotics"

/obj/structure/prop/tgbrokenvendor/cart
	icon_state = "cart"

/obj/structure/prop/tgbrokenvendor/theater
	icon_state = "theater"

/obj/structure/prop/tgbrokenvendor/clothes
	icon_state = "clothes"

/obj/structure/prop/tgbrokenvendor/liberationstation
	icon_state = "liberationstation"

/obj/structure/prop/tgbrokenvendor/syndi
	icon_state = "syndi"

/obj/structure/prop/tgbrokenvendor/ntdonk
	icon_state = "nt-donk"

/obj/structure/prop/tgbrokenvendor/games
	icon_state = "games"

/obj/structure/prop/tgbrokenvendor/bardrobe
	icon_state = "bardrobe"

/obj/structure/prop/tgbrokenvendor/secdrobe
	icon_state = "secdrobe"

/obj/structure/prop/tgbrokenvendor/chefdrobe
	icon_state = "chefdrobe"

/obj/structure/prop/tgbrokenvendor/medidrobe
	icon_state = "medidrobe"

/obj/structure/prop/tgbrokenvendor/chemdrobe
	icon_state = "chemdrobe"

/obj/structure/prop/tgbrokenvendor/genedrobe
	icon_state = "genedrobe"

/obj/structure/prop/tgbrokenvendor/virodrobe
	icon_state = "virodrobe"

/obj/structure/prop/tgbrokenvendor/scidrobe
	icon_state = "scidrobe"

/obj/structure/prop/tgbrokenvendor/robodrobe
	icon_state = "robodrobe"

/obj/structure/prop/tgbrokenvendor/chapdrobe
	icon_state = "chapdrobe"

/obj/structure/prop/tgbrokenvendor/engidrobe
	icon_state = "engidrobe"

/obj/structure/prop/tgbrokenvendor/atmosdrobe
	icon_state = "atmosdrobe"

/obj/structure/prop/tgbrokenvendor/hydrodrobe
	icon_state = "hydrobe"

/obj/structure/prop/tgbrokenvendor/cargodrobe
	icon_state = "cargodrobe"

/obj/structure/prop/tgbrokenvendor/curadrobe
	icon_state = "curadrobe"

/obj/structure/prop/tgbrokenvendor/janidrobe
	icon_state = "janidrobe"

/obj/structure/prop/tgbrokenvendor/lawdrobe
	icon_state = "lawdrobe"

/obj/structure/prop/tgbrokenvendor/detdrobe
	icon_state = "detdrobe"

/obj/structure/prop/tgbrokenvendor/parts
	icon_state = "parts"

/obj/structure/prop/tgbrokenvendor/custom
	icon_state = "custom"

/obj/structure/prop/tgbrokenvendor/greed
	icon_state = "greed"

/obj/structure/prop/tgbrokenvendor/centdrobe
	icon_state = "centdrobe"

/obj/structure/prop/tgbrokenvendor/shamblersjuice
	icon_state = "shamblers_juice"

/obj/structure/prop/tgbrokenvendor/modularpc
	icon_state = "modularpc"

/obj/structure/prop/camera
	name = "损坏的监控摄像头"
	desc = "它用于监视房间。"
	icon = 'icons/obj/machines/monitors.dmi'
	icon_state = "camera_icon"
	layer = WALL_OBJ_LAYER
	anchored = TRUE

/obj/structure/prop/camera/Initialize(mapload, newDir)
	. = ..()
	icon_state = "camera1"

/obj/machinery/prop/computer/tadpole
	name = "Tadpole navigation computer"
	desc = "用于为蝌蚪号指定精确的运输地点。"
	icon_state = "shuttlecomputer"
	screen_overlay = "shuttlecomputer_screen"
	resistance_flags = RESIST_ALL

/obj/structure/prop/computer
	icon = 'icons/obj/machines/computer.dmi'

/obj/structure/prop/computer/broken
	name = "损坏的电脑"
	desc = "一台坏掉的PC,内部看起来烧毁了,这台已经没救了。"
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "broken_computer1"
	resistance_flags = XENO_DAMAGEABLE
	density = TRUE
	max_integrity = 120

/obj/structure/prop/computer/broken/two
	icon_state = "broken_computer2"

/obj/structure/prop/computer/broken/three
	icon_state = "broken_computer3"

/obj/structure/prop/computer/broken/four
	icon_state = "broken_computer4"

/obj/structure/prop/computer/broken/five
	icon_state = "broken_computer5"

/obj/structure/prop/computer/broken/six
	icon_state = "broken_computer6"

/obj/structure/prop/computer/broken/seven
	icon_state = "broken_computer7"

/obj/structure/prop/computer/broken/eight
	icon_state = "broken_computer8"

/obj/structure/prop/computer/broken/nine
	icon_state = "broken_computer9"

/obj/structure/prop/computer/broken/ten
	icon_state = "broken_computer10"

/obj/structure/prop/computer/broken/eleven
	icon_state = "broken_computer11"

/obj/structure/prop/computer/broken/twelve
	icon_state = "broken_computer12"

/obj/structure/prop/computer/broken/thirteen
	icon_state = "broken_computer13"

/obj/structure/prop/computer/broken/fourteen
	icon_state = "broken_computer14"

/obj/structure/prop/computer/broken/fifteen
	icon_state = "broken_computer15"

/obj/structure/prop/computer/broken/sixteen
	icon_state = "broken_computer16"

/obj/structure/prop/computer/broken/seventeen
	icon_state = "broken_computer17"

/obj/structure/prop/computer/broken/eighteen
	icon_state = "broken_computer18"

/obj/structure/prop/computer/broken/nineteen
	icon_state = "broken_computer19"

/obj/machinery/computer/solars
	name = "Port Quarter Solar Control"
	desc = "一个太阳能板阵列的控制器。"
	icon_state = "computer"
	screen_overlay = "solar"
	broken_icon = "computer_blue_broken"

/obj/machinery/filtration_pipes
	name = "Disinfection Filter"
	desc = "一种专为从水中分离微生物,如病毒和细菌,而设计的水过滤器。"
	icon = 'icons/obj/structures/pipe_multiple.dmi'
	icon_state = "solo_tank_water"
	layer = ABOVE_TREE_LAYER
	density = TRUE

/obj/machinery/filtration_pipes/Initialize(mapload)
	. = ..()
	add_large_transparency()

/// We add the largetransparency component in here, but we need different parameters
/obj/machinery/filtration_pipes/proc/add_large_transparency()
	AddComponent(/datum/component/largetransparency)

/obj/machinery/filtration_pipes/empty
	icon_state = "solo_tank_empty"

/obj/machinery/filtration_pipes/waste
	icon_state = "solo_tank_waste"

/obj/machinery/filtration_pipes/multiple
	icon_state = "disinfection"
	bound_width = 96
	bound_height = 64

/obj/machinery/filtration_pipes/multiple/add_large_transparency()
	AddComponent(/datum/component/largetransparency, 0, 1, 3, 2)

/obj/machinery/filtration_pipes/multiple/update_overlays()
	. = ..()
	. += image(icon, src, "disinfectiontop", layer = ABOVE_TREE_LAYER, pixel_y = 63)

/obj/structure/prop/mainship/errorprop
	name = "错误"
	desc = "如果你在游戏中看到这个物体,你应该ahelp,有东西出故障了。"
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "error"

/obj/prop/mainship/prop/news_tv
	name = "TV"
	desc = "令人惊讶的是仍然有用,这台设定为新闻频道。"
	icon = 'icons/obj/status_display.dmi'
	icon_state = "news"
	density = FALSE
	///List for the news stories
	var/list/news_list = list()
	///News stories
	var/news_stories = ""
/obj/prop/mainship/prop/news_tv/Initialize(mapload)
	. = ..()
	news_list = splittext(news_stories, ";")
	addtimer(CALLBACK(src, PROC_REF(start_send)), SSticker.round_start_time + 1 MINUTES)

/obj/prop/mainship/prop/news_tv/proc/start_send()
	for(var/i = 1 to length(news_list))
		addtimer(CALLBACK(src, PROC_REF(send_story), i), 45 SECONDS * i)

/obj/prop/mainship/prop/news_tv/proc/send_story(story)
	var/selected_story = news_list[story]
	say(selected_story)

/obj/prop/mainship/prop/news_tv/tg
	news_stories = "The peace of the Persatuan system was broken as missiles, lasers and coilguns are fired in a fierce naval battle with TerraGov and the SOM, the navy was able to secure the jump points being used by the SOM cutting off the remaining SOM ships left in the system.;\
		TDF releases headcam footage being nicknamed 'Martian Bushcutting' showing an infantryman wiping a squad of MMC using only a machete. Nanotrasen pharmaceutical division used the video as a showcase of their advanced combat cocktail mix.;\
		In a recent press conference Terrabound Mechanics CEO Korol Smith broke down after a question regarding the recently finished mech program 'Mech program is 154 billion overbudget and should have been canned since the start!', shouted Korol Smith. This is after the Rhino light tank program got cancelled over the more advanced mech program.;\
		A recent skirmish against the ICCN and the TGN results in a TGN victory. Both sides with 5 ships each are head on in a brachistochrone trajectory TG fires first firing a salvo of 200 torch missiles, the ICCN being primarily a laser star focused fleet makes them very effective in point defense allows them to intercept most, 3 missiles impact killing 2 ships and disabling 1. ICC ships fire off their lasers and a beam is able to focus enough to melt through the armor of a TG ship disabling them then being completely melted down with focused fire before counter fire from the remaining TG ships is able to vaporize the remaining ships.;\
		Nano-toys, releases the rouny plush line based off the runner xenomorph, some concerned parents criticizes the toy saying, 'Its outrageous that it's ok to sell a plush depicting a killer alien that has killed hundreds of colonists as a toy for children!'.;\
		Viral footage shows a mech racing against the colonists of LV-235, with the mech making extensive use of its boosters to outpace the other vehicles to the point of overheating. We ask mech freelancer John Sauter what his story is, 'We had a contract here but it was over pretty fast, so me and my comrades decided to see what kinda activities the locals have, apparently they have a racing event. One of the guys joked about bringing the mech to the race and i said fuck it, lets do it and man what a ride it was, won an entire basket of oranges for getting 1st place, not the best prize but ill take it, im pretty sure im a pioneer in this field too. John Sauter first mech racer, thats a good title.'.;\
		TG Transportation Safety Board has recently released a new list of locations marked as quarantine which includes LV-462, Big Red, and Chigusa. UPP have been sent to enforce the quarantine and clear the infestation of the recent xenomorph outbreaks, a statement is also included stating the situation is currently under control.;\
		Tadpole class dropships land dropping off more rescue teams to rescue the civilians out of the Hope-3 O'Neill cylinder colony situated on lagrange 1 of Lakota as yesterday a cargo liner collision suspected to be manned by CLF operatives crashed into the colony. Death tolls are currently 45k+ dead and 15k+ injured. This is likely a reprisal attack after the navy began to clamp down on the CLF, more combat ships are being sent to protect especially high value targets.;\
		War correspondent Tim Sholk on the ground in Lolokal station, take it away 'It's a very tense situation here, as you can see most of the stations population have taken refuge near the medical wing caught in the middle of battle against MMC forces and the UPP, while TG controls the station for now and preparing for evacuation of the-' 'BREACHING CHARGE ON ENGINEERING MARINES MOVE IN AND REEINFORCE, CUT THE FEED NOW!'.;\
		Famous photographer Will Navidson goes missing after going on a short break with his family on the planet of New Vingrina, local authorities ask for any information on whereabouts. Was last seen buying camping supplies in a Leafes Outdoor Equipment store.;\
		3rd generation bluespace drive. 1500kN of thrust. 200km+ Delta V. Liquid Droplet Radiators. Protection. Luxury. Luna Shipworks proudly presents the Marik Class Yacht with 4 large hardpoints for any of your needs whether it be transport or light cargo hauling or even racing.;\
		Mars, a place that has been completely devastated by the independence war. Mine fields and rows of trenches litter the landscape with colonies wiped off the map completely, you can stop this tragedy from happening again, join the marine corps today.;\
		'This material will change the course of our species and its time to rise from the rubble, look upon the stars and grasp them!' DIRECTED BY ALEXANDER BREEN 'It's a race against time we have Onmark Fusion stating that they will get their bluespace drive test on the 15th, we have to rush this prototype Paul.' 'Paul me and the kids haven't seen you in 5 months! You have to take a break sometime.' THIS REMEMBRANCE DAY 'This is Armstrong-1 we have reached jump point anomaly. Begin ignition in 5 4 3 2 1' BLUESPACE In theaters 15th of July.;\
		'Hey Alex, got you the coffee you asked for' 'This doesn't seem like the usual' 'It's a new chain they got a classic pre strife era France vibe in their cafe, was founded by the Rushin Engines band' 'This is nice, wakes you up instantly and it's got a really rich flavour i haven't felt before' 'Yup that would be the special Java organically grown coffee beans, they also use the newest tech in chemistry, i swear it looked more like a lab back there than a cafe' Baron Cafe. 'Taste the future of coffee, today. No gimmicks. Pure quality'.;\
		UPP enforces the peace here in the recently liberated Tiberius from the ICC, as you can see it has been very peacefu- 'FUCK YOU IMPERIALISTS! YOU AND THE CORPOS HAVE TAKEN EVERYTHING FROM ME, WHAT ELSE DO YOU WANT!' 'Shut that man up! Alec, escort that camera crew out of here things are about to get heated here'."

/obj/prop/mainship/prop/news_tv/som
	news_stories = "Our navy makes a foothold on the Persatuan system as we destroy the imperialists holds in the system, using a mass amount of drones and carrier ships allows us to easily project force everywhere in the system in a matter of a few hours.;\
		Shang-12 Research Station has had constant fighting for the past 2 days and only has recently ended now thanks to the bravery of Shokk Platoon marine Ming, bodycam footage shows him fearlessly charging enemy holdouts with his boarding axe putting full faith in his equipment allowing for a breakthrough, we can all aspire to go to these lengths of bravery.;\
		We recently encountered a full squad of TG mechs, although it was no match for our mech boys, a single volkite lance and a good hit is all it takes to take down their mechs, they may have a lot of it but it doesn't match the quality of our equipment.;\
		New Malay Shipyards advanced casaba drone gets put to the test in it's first real combat engagement against two TG frigates and 3 cargo freighters, MNV Tex class frigate launches 24 drones and the AI sets a course to rendezvous with the targets, with its high amount of thrust they are able to close in to an effective range fast and use their casaba howitzers to intercept incoming missiles, 6 drones are able to get through quickly dispatching the enemy ships as they get in effective casaba range, they use their advanced RCS thrusters to dodge enemy coilgun fire and as they pass the destroyed ships they turn on their engines to irradiate the area leaving no survivors.;\
		Are you ready to take your Verf warfare to the next level? Introducing the Verf Volkite Caliver toy, simply connect it with the battery backpack and start releasing the full rapid fire of the Verf Volkite Caliver, everything you need to mow down your friends. Helmet sold seperately, batteries not included. VERF.;\
		The Independent Colonies Trade Admin would like to remind you that moving alien animals and plants without a permit to another star system is illegal and may land you up to 2 years in jail and a 1 million kreto fine, recently we have had issues with cartels trying to ship exotic animals by using unsuspecting passangers, do not accept any offers from anyone for help with carrying.;\
		TerraGov suffers a massive disaster as a cargo liner goes out of control and collides into an O'Neill cylinder colony with many casualties and billions of dollars in cargo lost, a few ship analysts say that the TerraGov claim that it was a terrorist attack is false, the maint logs of the ship suggested instead it was a mechanical failure.;\
		We have here Boris Kilo on the frontline of an armed rebellion against TG on the moon of Harvest 'These rebels are sick and tired of the horrible working conditions Nanotrasen has set and the tariff increases TG has done' 'With our wages were just working from meal to meal with no prospect of advancing and they want to increase the damn import tariffs? No enough is enough!' 'Look at this footage we captured so called TDF peacekeepers executing suspected collaborators and shooting into protestors, show it to the whole damn galaxy that they rule this place with fear'.;\
		Insmoth ocean planet colony population mysteriously vanishes. Colony Newport-212 known for its export of exotic fish has completely vanished with no conclusive evidence of what happened to the colonists, according to flight logs no shuttle was ever nearby the colony, a few leads are possible cultist activity on the planet as investigators and crews who often carry cargo to the planet report odd behaviour and gold statues of unknown idols littering the colonies.;\
		Today we remember the battle of Olympus Mons, a day to remind ourselves of the sacrifice our forefathers made to escape from the tyranny and imperialist ambitions of Terra and on that day 25152 brave Martians died to secure our future to assault and capture a prototype bluespace drive leading us to our destiny among the stars and preserving Mars, even if Terra holds our holy land. Mars shall not be forgotten.;\
		Tonight's execution! A TerraGov spy has been caught and tried today deemed guilty, it shall be a special execution showcasing the MMC's new radiation grenades if everything goes as planned this spy will meet a very painful demise! Execution tonight at 6 on all channels.;\
		An extinct alien civilization found? An exploratory team had set down on Lakita-984, a very hot Terra like planet with bizzare weather patterns. Scans indicate high amounts of greenhouse gasses and areas with high amounts of radiation perhaps a small scale nuclear conflict along with global warming had been their end? A lot of debris was found in orbit that have damage similar to laser fire, they also found wildly varied technological level and design of machinery seemingly as they were from entirely different worlds. Destroyed and decaying buildings are scattered across the planet with only a few major clusters of them, showing an isolationist culture. The more gruesome discovery was of bones of corpses found in massive piles like a massacre had happened, some say it was a religious ritual.;\
		Mariner Aerospace M350 SSTO family, the most widely used civilian SSTO family in SOM space. The latest generation hybrid engines, air-breathing hypersonic turbines into a radiation free NTR in a vacuum. 800 carrying capacity with flexible cargo capacity. M350 the technical benchmark in its field.;\
		Orbital ring construction on Catakan continues smoothly with no major incidents, Phobos Manufacturing plays the biggest part of construction with its massive mobile construction platform able to produce any parts needed locally and housing a good amount of the construction workers, the orbital ring is expected to be finished in 3 years with 9 space elevators and 12 stations connecting to it along with dome gardens and cities along the skyhooks.;\
		Shipyard work more attractive to young adults than office work? More and more young adults are flocking to shipyard and space related work as they want an escape from the monotony and rat race of the office world, here we are at New Malay Shipyards with Austin Li a 20 year old who gave up his managerial position for shipyard work 'I wanted to just escape from the boredom, feel challenged and accomplished from the work i do and i found that in shipyard work, it's a tough job and the pay is not as good but nothing beats the view from up here and the feeling of freedom from zero g, atleast thats my perspective. Sorry i gotta get to my EVA mech now, work calls."

/obj/structure/prop/coagulation_arm
	name = "混凝臂"
	desc = "一根四面轴,用于旋转以帮助过滤水。"
	icon = 'icons/obj/structures/coagulation_arm.dmi'
	icon_state = "arm"
	anchored = TRUE
	resistance_flags = XENO_DAMAGEABLE
	bound_height = 96
	bound_width = 96
	max_integrity = 1000

/obj/structure/prop/filtration_exit
	name = "废物排出管"
	desc = "这台机器将净化过程中剩余的废物分离出来,以便丢弃到太空、回收为补给品或用于研究。"
	icon = 'icons/obj/structures/waste_pipe.dmi'
	icon_state = "pipe"
	anchored = TRUE
	bound_height = 96
	bound_width = 96
	density = TRUE
	resistance_flags = RESIST_ALL

/obj/structure/prop/golden_sclupture
	name = "金色雕塑"
	desc = "一座由黄金制成的大型雕塑,描绘了Bravo小队的三个成员。刻上的铭文写着'SKIBIDI LORDS 15.11'"
	icon = 'icons/obj/structures/goldensculpture.dmi'
	icon_state = "golden"
	anchored = TRUE
	bound_height = 64
	bound_width = 64
	density = TRUE
	resistance_flags = RESIST_ALL

#undef VENDOR_BROKEN
#undef VENDOR_BLANK
