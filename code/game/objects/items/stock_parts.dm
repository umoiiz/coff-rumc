/obj/item/stock_parts
	name = "标准零件"
	desc = "什么?"
	gender = PLURAL
	icon = 'icons/obj/items/stock_parts.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/rating = 1


/obj/item/stock_parts/Initialize(mapload)
	. = ..()
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

//Rank 1

/obj/item/stock_parts/console_screen
	name = "控制台屏幕"
	desc = "用于建造计算机和其他带有交互式控制台的设备."
	icon_state = "screen"

/obj/item/stock_parts/capacitor
	name = "电容器"
	desc = "一种用于建造各种设备的基础电容器."
	icon_state = "capacitor"

/obj/item/stock_parts/scanning_module
	name = "扫描模块"
	desc = "一种用于建造某些设备的紧凑型高分辨率扫描模块."
	icon_state = "scan_module"

/obj/item/stock_parts/manipulator
	name = "微型机械手"
	desc = "一种用于建造某些设备的微型机械手."
	icon_state = "micro_mani"
/obj/item/stock_parts/micro_laser
	name = "微型激光器"
	desc = "一种用于某些设备的微型激光器."
	icon_state = "micro_laser"

/obj/item/stock_parts/matter_bin
	name = "物质箱"
	desc = "一个用于存放压缩物质以供重建的容器."
	icon_state = "matter_bin"

//Rank 2

/obj/item/stock_parts/capacitor/adv
	name = "高级电容器"
	desc = "一种用于建造各种设备的高级电容器."
	rating = 2

/obj/item/stock_parts/scanning_module/adv
	name = "高级扫描模块"
	desc = "一种用于建造某些设备的紧凑型高分辨率扫描模块."
	icon_state = "scan_module"
	rating = 2

/obj/item/stock_parts/manipulator/nano
	name = "纳米机械手"
	desc = "一种用于建造某些设备的微型机械手."
	icon_state = "nano_mani"
	rating = 2

/obj/item/stock_parts/micro_laser/high
	name = "高功率微型激光器"
	desc = "一种用于某些设备的微型激光器."
	icon_state = "high_micro_laser"
	rating = 2

/obj/item/stock_parts/matter_bin/adv
	name = "高级物质箱"
	desc = "一个用于存放压缩物质以供重建的容器."
	icon_state = "advanced_matter_bin"
	rating = 2

//Rating 3

/obj/item/stock_parts/capacitor/super
	name = "超级电容器"
	desc = "一种用于建造各种设备超高容量电容器."
	rating = 3

/obj/item/stock_parts/scanning_module/phasic
	name = "相位扫描模块"
	desc = "一种紧凑的高分辨率相位扫描模块,用于建造某些设备."
	rating = 3

/obj/item/stock_parts/manipulator/pico
	name = "皮米操纵器"
	desc = "一种用于建造某些设备的微型操纵器."
	icon_state = "pico_mani"
	rating = 3

/obj/item/stock_parts/micro_laser/ultra
	name = "超高功率微型激光器"
	icon_state = "ultra_high_micro_laser"
	desc = "一种用于某些设备的微型激光器."
	rating = 3

/obj/item/stock_parts/matter_bin/super
	name = "超级物质箱"
	desc = "一种用于存放压缩物质以待重建的容器."
	icon_state = "super_matter_bin"
	rating = 3

// Subspace stock parts

/obj/item/stock_parts/subspace/ansible
	name = "亚空间安塞波"
	icon_state = "subspace_ansible"
	desc = "一种能够感知超维度活动的紧凑模块."

/obj/item/stock_parts/subspace/filter
	name = "超波滤波器"
	icon_state = "hyperwave_filter"
	desc = "一种能够过滤和转换超强无线电波的微型设备."

/obj/item/stock_parts/subspace/amplifier
	name = "亚空间放大器"
	icon_state = "subspace_amplifier"
	desc = "一种能够放大微弱亚空间传输的紧凑微型机械."

/obj/item/stock_parts/subspace/treatment
	name = "亚空间处理盘"
	icon_state = "treatment_disk"
	desc = "一种能够延展超压缩无线电波的紧凑微型机械."

/obj/item/stock_parts/subspace/analyzer
	name = "亚空间波长分析仪"
	icon_state = "wavelength_analyzer"
	desc = "一种能够分析神秘亚空间波长的精密分析仪."

/obj/item/stock_parts/subspace/crystal
	name = "安塞波晶体"
	icon_state = "ansible_crystal"
	desc = "一种由纯玻璃制成的晶体,用于将激光数据脉冲传输至亚空间."

/obj/item/stock_parts/subspace/transmitter
	name = "亚空间发射器"
	icon_state = "subspace_transmitter"
	desc = "一种用于打开通往亚空间维度窗口的大型设备."



//Construction Item for the SMES
/obj/item/stock_parts/smes_coil
	name = "超导磁线圈"
	desc = "重型超导磁线圈,主要用于建造超导磁储能单元."
	icon_state = "smes_coil"			// Just few icons patched together. If someone wants to make better icon, feel free to do so!
	w_class = WEIGHT_CLASS_BULKY 						// It's LARGE (backpack size)
	var/ChargeCapacity = 5000000
	var/IOCapacity = 250000

