/obj/structure/prop/som_fighter
	name = "\improper 先驱者"
	desc = "一架最先进的先驱者级战斗机. SOM部队在太空和大气层中的首选战斗机, 装备了高科技系统和武器."
	icon = 'icons/obj/structures/mainship_props96.dmi'
	icon_state = "SOM_fighter"
	pixel_x = -33
	pixel_y = -10
	density = TRUE
	allow_pass_flags = PASS_AIR

/obj/structure/prop/som_fighter/empty
	icon_state = "SOM_fighter_empty"
	desc = "一架最先进的先驱者级战斗机. SOM部队在太空和大气层中的首选战斗机, 这架目前似乎没有武装."

/obj/structure/prop/train
	name = "机车"
	desc = "一台重型磁悬浮机车. 专为将大量货物从A点运送到B点而设计."
	icon = 'icons/obj/structures/train.dmi'
	icon_state = "maglev"
	density = TRUE
	allow_pass_flags = PASS_AIR
	bound_width = 128

/obj/structure/prop/train/Initialize(mapload)
	. = ..()
	update_icon()

/obj/structure/prop/train/update_overlays()
	. = ..()
	var/image/new_overlay = image(icon, src, "[icon_state]_overlay", ABOVE_ALL_MOB_LAYER, dir)
	. += new_overlay

/obj/structure/prop/train/carriage
	name = "轨道车厢"
	desc = "一节重型磁悬浮车厢. 不知道里面装了什么?"
	icon_state = "carriage"

/obj/structure/prop/train/carriage_lit
	name = "轨道车厢"
	desc = "一节重型磁悬浮车厢. 不知道里面装了什么?"
	icon_state = "carriage_lit"

/obj/structure/prop/train/cargo_nt
	name = "轨道车"
	desc = "一辆重型磁悬浮轨道车. 这辆上面有一个大型货运集装箱."
	icon_state = "nt"

/obj/structure/prop/train/cargo_sat
	name = "轨道车"
	desc = "一辆重型磁悬浮轨道车. 这辆上面有一个大型货运集装箱."
	icon_state = "sat"

/obj/structure/prop/train/cargo_hyperdyne
	name = "轨道车"
	desc = "一辆重型磁悬浮轨道车. 这辆上面有一个大型货运集装箱."
	icon_state = "hyperdyne"

/obj/structure/prop/train/construction
	name = "轨道车"
	desc = "一辆重型磁悬浮轨道车. 这辆运载着各种建筑材料."
	icon_state = "construction"
	allow_pass_flags = PASSABLE

/obj/structure/prop/train/crates
	name = "轨道车"
	desc = "一辆重型磁悬浮轨道车. 这辆上面有各种板条箱."
	icon_state = "crates"
	allow_pass_flags = PASSABLE

/obj/structure/prop/train/weapons
	name = "轨道车"
	desc = "一辆重型磁悬浮轨道车. 这辆运载着一批武器."
	icon_state = "weapons"
	allow_pass_flags = PASSABLE

/obj/structure/prop/train/mech
	name = "轨道车"
	desc = "一辆重型磁悬浮轨道车. 这辆上面有各种机甲设备."
	icon_state = "mech"
	allow_pass_flags = PASSABLE

/obj/structure/prop/train/empty
	name = "轨道车"
	desc = "一辆重型磁悬浮轨道车. 这辆目前是空的."
	icon_state = "empty"
	allow_pass_flags = PASS_LOW_STRUCTURE|PASSABLE|PASS_WALKOVER

/obj/structure/prop/nt_computer
	name = "服务器机架"
	desc = "一个服务器机架. 谁知道上面有什么?"
	icon = 'icons/obj/structures/campaign/tall_structures.dmi'
	icon_state = "serverrack_on"
	layer = ABOVE_MOB_LAYER
	density = TRUE
	light_range = 1
	light_power = 0.5
	light_color = LIGHT_COLOR_FLARE
	var/use_emissive = TRUE

/obj/structure/prop/nt_computer/Initialize(mapload)
	. = ..()
	update_icon()

/obj/structure/prop/nt_computer/update_overlays()
	. = ..()
	if(use_emissive)
		. += emissive_appearance(icon, "[icon_state]_emissive", src, alpha = src.alpha)

/obj/structure/prop/nt_computer/rack
	name = "控制机架"
	desc = "一个系统控制机架. 谁知道上面有什么?"
	icon_state = "recorder_on"
	use_emissive = FALSE

/obj/structure/prop/nt_computer/recorder
	name = "备份记录器"
	desc = "一个备份数据记录器. 谁知道上面有什么?"
	icon_state = "rack_on"
	light_range = 0
	light_power = 0

/obj/structure/gauss_cannon
	name = "\improper 高斯炮"
	desc = "一门强大的高斯炮. 旨在击穿敌方航天器."
	icon = 'icons/obj/machines/artillery.dmi'
	icon_state = "gauss_cannon"
	density = TRUE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	bound_width = 128
	bound_height = 64
	bound_y = 64
	resistance_flags = RESIST_ALL
	allow_pass_flags = NONE
	light_range = 4
	light_power = 0.5
	light_color = LIGHT_COLOR_BLUEGREEN

/obj/structure/gauss_cannon/Initialize(mapload)
	. = ..()
	update_icon()

/obj/structure/gauss_cannon/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "[icon_state]_emissive", src, alpha = src.alpha)
