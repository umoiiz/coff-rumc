/obj/item/mecha_parts
	name = "机甲部件"
	icon = 'icons/mecha/mech_construct.dmi'
	icon_state = "blank"
	w_class = WEIGHT_CLASS_GIGANTIC

/obj/item/mecha_parts/proc/try_attach_part(mob/user, obj/vehicle/sealed/mecha/M, attach_right = FALSE) //For attaching parts to a finished mech
	if(!user.transferItemToLoc(src, M))
		to_chat(user, span_warning("\The [src]卡在你手上,你无法将其放入\the [M]!"))
		return FALSE
	user.visible_message(span_notice("[user]将[src]安装到[M]."), span_notice("你将[src]安装到[M]."))
	return TRUE

/obj/item/mecha_parts/part/try_attach_part(mob/user, obj/vehicle/sealed/mecha/M, attach_right = FALSE)
	return

/obj/item/mecha_parts/chassis
	name = "机甲底盘"
	icon_state = "backbone"

/////////// Ripley

/obj/item/mecha_parts/chassis/ripley
	name = "\improper 雷普利底盘"

/obj/item/mecha_parts/part/ripley_torso
	name = "\improper 雷普利躯干"
	desc = "雷普利APLU的躯干部分. 包含动力单元,处理核心和生命维持系统."
	icon_state = "ripley_harness"

/obj/item/mecha_parts/part/ripley_left_arm
	name = "\improper 雷普利左臂"
	desc = "雷普利APLU的左臂. 数据与电源接口兼容大多数外骨骼工具."
	icon_state = "ripley_l_arm"

/obj/item/mecha_parts/part/ripley_right_arm
	name = "\improper 雷普利右臂"
	desc = "雷普利APLU的右臂. 数据与电源接口兼容大多数外骨骼工具."
	icon_state = "ripley_r_arm"

/obj/item/mecha_parts/part/ripley_left_leg
	name = "\improper 雷普利左腿"
	desc = "雷普利APLU的左腿. 包含较为复杂的伺服驱动器和平衡维持系统."
	icon_state = "ripley_l_leg"

/obj/item/mecha_parts/part/ripley_right_leg
	name = "\improper 雷普利右腿"
	desc = "雷普利APLU的右腿. 包含较为复杂的伺服驱动器和平衡维持系统."
	icon_state = "ripley_r_leg"

////////// Firefighter

/obj/item/mecha_parts/chassis/firefighter
	name = "\improper 消防员底盘"

///////// Odysseus

/obj/item/mecha_parts/chassis/odysseus
	name = "\improper 奥德修斯底盘"

/obj/item/mecha_parts/part/odysseus_head
	name = "\improper 奥德修斯头部"
	desc = "奥德修斯头部. 内置医疗HUD扫描仪."
	icon_state = "odysseus_head"

/obj/item/mecha_parts/part/odysseus_torso
	name = "\improper 奥德修斯躯干"
	desc = "奥德修斯的躯干部分. 包含动力单元, 处理核心和生命维持系统, 以及用于安装睡眠舱的挂载端口."
	icon_state = "odysseus_torso"

/obj/item/mecha_parts/part/odysseus_left_arm
	name = "\improper 奥德修斯左臂"
	desc = "奥德修斯左臂. 数据和电源接口兼容专用医疗设备."
	icon_state = "odysseus_l_arm"

/obj/item/mecha_parts/part/odysseus_right_arm
	name = "\improper 奥德修斯右臂"
	desc = "奥德修斯右臂. 数据和电源接口兼容专用医疗设备."
	icon_state = "odysseus_r_arm"

/obj/item/mecha_parts/part/odysseus_left_leg
	name = "\improper 奥德修斯左腿"
	desc = "奥德修斯左腿. 包含复杂的伺服驱动器和平衡维持系统, 为危重病人保持稳定."
	icon_state = "odysseus_l_leg"

/obj/item/mecha_parts/part/odysseus_right_leg
	name = "\improper 奥德修斯右腿"
	desc = "奥德修斯右腿. 包含复杂的伺服驱动器和平衡维持系统, 为危重病人保持稳定."
	icon_state = "odysseus_r_leg"

///////// Gygax

/obj/item/mecha_parts/chassis/gygax
	name = "\improper 盖格克斯底盘"

/obj/item/mecha_parts/part/gygax_torso
	name = "\improper 盖格克斯躯干"
	desc = "盖格克斯的躯干部分. 包含动力单元, 处理核心和生命维持系统."
	icon_state = "gygax_harness"

/obj/item/mecha_parts/part/gygax_head
	name = "\improper 盖格克斯头部"
	desc = "盖格克斯头部. 装有先进的监视和瞄准传感器."
	icon_state = "gygax_head"

/obj/item/mecha_parts/part/gygax_left_arm
	name = "\improper 盖格克斯左臂"
	desc = "盖格克斯左臂. 数据和电源接口兼容大多数外骨骼工具和武器."
	icon_state = "gygax_l_arm"

/obj/item/mecha_parts/part/gygax_right_arm
	name = "\improper 盖格克斯右臂"
	desc = "盖格克斯右臂. 数据和电源接口兼容大多数外骨骼工具和武器."
	icon_state = "gygax_r_arm"

/obj/item/mecha_parts/part/gygax_left_leg
	name = "\improper 盖格克斯左腿"
	desc = "盖格克斯左腿. 采用先进的伺服机构和致动器构造, 以实现更快的速度."
	icon_state = "gygax_l_leg"

/obj/item/mecha_parts/part/gygax_right_leg
	name = "\improper 盖格克斯右腿"
	desc = "盖格克斯右腿. 采用先进的伺服机构和致动器构造, 以实现更快的速度."
	icon_state = "gygax_r_leg"

/obj/item/mecha_parts/part/gygax_armor
	gender = PLURAL
	name = "\improper 盖格克斯装甲板"
	desc = "一套为盖格克斯设计的装甲板. 采用轻量化结构设计, 可有效偏转伤害."
	icon_state = "gygax_armor"

//////////// Durand

/obj/item/mecha_parts/chassis/durand
	name = "\improper 杜兰德底盘"

/obj/item/mecha_parts/part/durand_torso
	name = "\improper 杜兰德躯干"
	desc = "杜兰德的躯干部分. 在坚固的防护框架内包含动力单元, 处理核心和生命维持系统."
	icon_state = "durand_harness"

/obj/item/mecha_parts/part/durand_head
	name = "\improper 杜兰德头部"
	desc = "杜兰德头部. 装有先进的监视和瞄准传感器."
	icon_state = "durand_head"

/obj/item/mecha_parts/part/durand_left_arm
	name = "\improper 杜兰德左臂"
	desc = "杜兰德左臂. 数据和电源接口兼容大多数外骨骼工具和武器. 还能打出相当凶狠的一拳."
	icon_state = "durand_l_arm"

/obj/item/mecha_parts/part/durand_right_arm
	name = "\improper 杜兰德右臂"
	desc = "杜兰德右臂. 数据和电源接口兼容大多数外骨骼工具和武器. 还能打出相当凶狠的一拳."
	icon_state = "durand_r_arm"

/obj/item/mecha_parts/part/durand_left_leg
	name = "\improper 杜兰德左腿"
	desc = "杜兰德左腿. 建造得格外坚固, 以支撑杜兰德沉重的重量和防御需求."
	icon_state = "durand_l_leg"

/obj/item/mecha_parts/part/durand_right_leg
	name = "\improper 杜兰德右腿"
	desc = "杜兰德右腿. 建造得格外坚固, 以支撑杜兰德沉重的重量和防御需求."
	icon_state = "durand_r_leg"

/obj/item/mecha_parts/part/durand_armor
	gender = PLURAL
	name = "\improper 杜兰德装甲板"
	desc = "一套杜兰德装甲板. 建造厚重, 可抵御极其巨大的钝力冲击."
	icon_state = "durand_armor"

////////// Clarke

/obj/item/mecha_parts/chassis/clarke
	name = "\improper 克拉克底盘"

/obj/item/mecha_parts/part/clarke_torso
	name = "\improper 克拉克躯干"
	desc = "克拉克的躯干部分. 包含动力单元, 处理核心和生命维持系统."
	icon_state = "clarke_harness"

/obj/item/mecha_parts/part/clarke_head
	name = "\improper 克拉克头部"
	desc = "克拉克头部. 内置诊断HUD扫描仪."
	icon_state = "clarke_head"

/obj/item/mecha_parts/part/clarke_left_arm
	name = "\improper 克拉克左臂"
	desc = "克拉克左臂. 数据和电源接口兼容大多数外骨骼工具."
	icon_state = "clarke_l_arm"

/obj/item/mecha_parts/part/clarke_right_arm
	name = "\improper 克拉克右臂"
	desc = "克拉克右臂. 数据和电源接口兼容大多数外骨骼工具."
	icon_state = "clarke_r_arm"

////////// HONK

/obj/item/mecha_parts/chassis/honker
	name = "\improper H.O.N.K底盘"

/obj/item/mecha_parts/part/honker_torso
	name = "\improper H.O.N.K躯干"
	desc = "H.O.N.K的躯干部分. 包含咯咯笑单元, 香蕉矿核心和嗡鸣支持系统."
	icon_state = "honker_harness"

/obj/item/mecha_parts/part/honker_head
	name = "\improper H.O.N.K头部"
	desc = "H.O.N.K头部. 似乎缺少面板."
	icon_state = "honker_head"

/obj/item/mecha_parts/part/honker_left_arm
	name = "\improper H.O.N.K左臂"
	desc = "H.O.N.K左臂. 带有独特的接口, 可接受小丑科学家设计的古怪武器."
	icon_state = "honker_l_arm"

/obj/item/mecha_parts/part/honker_right_arm
	name = "\improper H.O.N.K右臂"
	desc = "H.O.N.K右臂. 带有独特的接口, 可接受小丑科学家设计的古怪武器."
	icon_state = "honker_r_arm"

/obj/item/mecha_parts/part/honker_left_leg
	name = "\improper H.O.N.K左腿"
	desc = "一个 H.O.N.K 左腿. 脚部看起来刚好足够容纳一只小丑鞋."
	icon_state = "honker_l_leg"

/obj/item/mecha_parts/part/honker_right_leg
	name = "\improper H.O.N.K 右腿"
	desc = "一个 H.O.N.K 右腿. 脚部看起来刚好足够容纳一只小丑鞋."
	icon_state = "honker_r_leg"

////////// Phazon

/obj/item/mecha_parts/chassis/phazon
	name = "\improper Phazon 底盘"

/obj/item/mecha_parts/part/phazon_torso
	name = "\improper Phazon 躯干"
	desc = "一个 Phazon 躯干部件. 用于为外骨骼独特的相位驱动器提供动力的蓝空间核心的插槽位于中央."
	icon_state = "phazon_harness"

/obj/item/mecha_parts/part/phazon_head
	name = "\improper Phazon 头部"
	desc = "一个 Phazon 头部. 它的传感器经过精心校准, 以便在外骨骼进行相位时也能提供视野和数据."
	icon_state = "phazon_head"

/obj/item/mecha_parts/part/phazon_left_arm
	name = "\improper Phazon 左臂"
	desc = "一个 Phazon 左臂. 数个微型工具阵列位于装甲板下, 可根据当前情况进行调整."
	icon_state = "phazon_l_arm"

/obj/item/mecha_parts/part/phazon_right_arm
	name = "\improper Phazon 右臂"
	desc = "一个 Phazon 右臂. 数个微型工具阵列位于装甲板下, 可根据当前情况进行调整."
	icon_state = "phazon_r_arm"

/obj/item/mecha_parts/part/phazon_left_leg
	name = "\improper Phazon 左腿"
	desc = "一个 Phazon 左腿. 它包含独特的相位驱动器, 使外骨骼在启动时能够相位穿越固体物质."
	icon_state = "phazon_l_leg"

/obj/item/mecha_parts/part/phazon_right_leg
	name = "\improper Phazon 右腿"
	desc = "一个 Phazon 右腿. 它包含独特的相位驱动器, 使外骨骼在启动时能够相位穿越固体物质."
	icon_state = "phazon_r_leg"

/obj/item/mecha_parts/part/phazon_armor
	name = "Phazon 装甲"
	desc = "Phazon 装甲板. 它们层叠有等离子体, 以保护驾驶员免受相位压力, 并具有不寻常的特性."
	icon_state = "phazon_armor"

// Savannah-Ivanov

/obj/item/mecha_parts/chassis/savannah_ivanov
	name = "\improper Savannah-Ivanov 底盘"

/obj/item/mecha_parts/part/savannah_ivanov_torso
	name = "\improper Savannah-Ivanov 躯干"
	desc = "一个 Savannah-Ivanov 躯干部件. 它缺少一大块空间..."
	icon_state = "savannah_ivanov_harness"

/obj/item/mecha_parts/part/savannah_ivanov_head
	name = "\improper Savannah-Ivanov 头部"
	desc = "一个 Savannah-Ivanov 头部. 它的传感器已进行调整, 以支持优雅着陆."
	icon_state = "savannah_ivanov_head"

/obj/item/mecha_parts/part/savannah_ivanov_left_arm
	name = "\improper Savannah-Ivanov 左臂"
	desc = "一个 Savannah-Ivanov 左臂. 手腕内包含隐藏的火箭制造装置."
	icon_state = "savannah_ivanov_l_arm"

/obj/item/mecha_parts/part/savannah_ivanov_right_arm
	name = "\improper Savannah-Ivanov 右臂"
	desc = "一个 Savannah-Ivanov 左臂. 手腕内包含隐藏的火箭制造装置."
	icon_state = "savannah_ivanov_r_arm"

/obj/item/mecha_parts/part/savannah_ivanov_left_leg
	name = "\improper Savannah-Ivanov 左腿"
	desc = "一个 Savannah-Ivanov 左腿. 在生产中, 它们被设计为可搭载超过两名乘客, 因此添加了跳跃功能, 以免浪费潜力."
	icon_state = "savannah_ivanov_l_leg"

/obj/item/mecha_parts/part/savannah_ivanov_right_leg
	name = "\improper Savannah-Ivanov 右腿"
	desc = "一个 Savannah-Ivanov 左腿. 在生产中, 它们被设计为可搭载超过两名乘客, 因此添加了跳跃功能, 以免浪费潜力."
	icon_state = "savannah_ivanov_r_leg"

/obj/item/mecha_parts/part/savannah_ivanov_armor
	name = "Savannah-Ivanov 装甲"
	desc = "Savannah-Ivanov 装甲板. 它们形状独特并经过加固, 以承受两名驾驶员, 宏大跳跃和导弹带来的压力."
	icon_state = "savannah_ivanov_armor"

///////// Circuitboards

/obj/item/circuitboard/mecha
	name = "外骨骼电路板"

	icon_state = "std_mod"
	force = 5
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 3
	throw_range = 7

/obj/item/circuitboard/mecha/ripley/peripherals
	name = "Ripley 外设控制模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/ripley/main
	name = "Ripley 中央控制模块 (外骨骼电路板)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/gygax/peripherals
	name = "Gygax 外设控制模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/gygax/targeting
	name = "Gygax 武器控制与瞄准模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/gygax/main
	name = "Gygax 中央控制模块 (外骨骼电路板)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/durand/peripherals
	name = "Durand 外设控制模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/durand/targeting
	name = "Durand 武器控制与瞄准模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/durand/main
	name = "Durand 中央控制模块 (外骨骼电路板)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/honker/peripherals
	name = "H.O.N.K 外设控制模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/honker/targeting
	name = "H.O.N.K 武器控制与瞄准模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/honker/main
	name = "H.O.N.K 中央控制模块 (外骨骼电路板)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/odysseus/peripherals
	name = "Odysseus 外设控制模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/odysseus/main
	name = "Odysseus 中央控制模块 (外骨骼电路板)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/phazon/peripherals
	name = "Phazon 外设控制模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/phazon/targeting
	name = "Phazon 武器控制与瞄准模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/phazon/main
	name = "Phazon 中央控制模块 (外骨骼电路板)"

/obj/item/circuitboard/mecha/clarke/peripherals
	name = "Clarke 外设控制模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/clarke/main
	name = "Clarke 中央控制模块 (外骨骼电路板)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/savannah_ivanov/peripherals
	name = "Savannah 外设控制模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/savannah_ivanov/targeting
	name = "Ivanov 武器控制与瞄准模块 (外骨骼电路板)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/savannah_ivanov/main
	name = "Savannah-Ivanov 组合控制锁模块 (外骨骼电路板)"
	icon_state = "mainboard"
