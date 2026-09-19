/datum/supply_packs/operations
	group = "作战"
	containertype = /obj/structure/closet/crate/operations

/datum/supply_packs/operations/standard_ammo
	name = "剩余标准弹药箱"
	notes = "Contains 22 ammo boxes of a wide variety which come prefilled. You lazy bum."
	contains = list(/obj/structure/largecrate/supply/ammo/standard_ammo)
	containertype = null
	cost = 200

/datum/supply_packs/operations/beacons_supply
	name = "补给信标"
	contains = list(/obj/item/supply_beacon)
	cost = 100

/datum/supply_packs/operations/beacons_orbital
	name = "轨道信标"
	contains = list(/obj/item/orbital_bombardment_beacon)
	cost = 30

/datum/supply_packs/operations/fulton_extraction_pack
	name = "富尔顿提取包"
	contains = list(/obj/item/fulton_extraction_pack)
	cost = 50

/datum/supply_packs/operations/autominer
	name = "自动采矿机升级"
	contains = list(/obj/item/minerupgrade/automatic)
	cost = 50

/datum/supply_packs/operations/miningwelloverclock
	name = "矿井加固升级"
	contains = list(/obj/item/minerupgrade/reinforcement)
	cost = 50

/datum/supply_packs/operations/miningwellresistance
	name = "矿井超频升级"
	contains = list(/obj/item/minerupgrade/overclock)
	cost = 50

/datum/supply_packs/operations/binoculars_tactical
	name = "战术双筒望远镜箱"
	contains = list(
		/obj/item/binoculars/tactical,
		/obj/item/encryptionkey/cas,
	)
	cost = 300
	crash_restricted = TRUE

/datum/supply_packs/operations/bincoulars_rangefinder
	name = "测距双筒望远镜"
	contains = list(
		/obj/item/binoculars/tactical/range,
		/obj/item/encryptionkey/cas,
	)
	cost = 150

/datum/supply_packs/operations/pinpointer
	name = "异形结构追踪器箱"
	contains = list(/obj/item/pinpointer)
	cost = 200
	crash_restricted = TRUE

/datum/supply_packs/operations/xeno_iff_tag
	name = "异形IFF标签箱" //Intended for corrupted or friendly rounies as rounds sometimes turn out. Avoid abuse or I'll have to admin-only it, which is no fun!
	notes = "Contains an IFF tag used to mark a xenomorph as friendly to IFF systems. Warning: Nanotrasen is not responsible for incidents related to attaching this to hostile entities."
	contains = list(/obj/item/xeno_iff_tag)
	access = ACCESS_MARINE_BRIDGE //Better be safe.
	cost = 130

/datum/supply_packs/operations/deployable_camera
	name = "3个可部署摄像头"
	contains = list(
		/obj/item/deployable_camera,
		/obj/item/deployable_camera,
		/obj/item/deployable_camera,
	)
	cost = 20

/datum/supply_packs/operations/exportpad
	name = "ASRS蓝空间出口点"
	contains = list(/obj/machinery/exportpad)
	cost = 300

/datum/supply_packs/operations/warhead
	access = ACCESS_MARINE_ENGINEERING
	containertype = /obj/structure/closet/crate/secure/explosives
	crash_restricted = TRUE

/datum/supply_packs/operations/warhead/cluster
	name = "集束轨道弹头"
	contains = list(/obj/structure/ob_ammo/warhead/cluster)
	cost = 200

/datum/supply_packs/operations/warhead/explosive
	name = "高爆轨道弹头"
	contains = list(/obj/structure/ob_ammo/warhead/explosive)
	cost = 300

/datum/supply_packs/operations/warhead/incendiary
	name = "燃烧轨道弹头"
	contains = list(/obj/structure/ob_ammo/warhead/incendiary)
	cost = 200

/datum/supply_packs/operations/warhead/plasmaloss
	name = "等离子轨道排空弹头"
	contains = list(/obj/structure/ob_ammo/warhead/plasmaloss)
	cost = 150

/datum/supply_packs/operations/ob_fuel
	name = "固体燃料"
	contains = list(/obj/structure/ob_ammo/ob_fuel)
	cost = 50
	access = ACCESS_MARINE_ENGINEERING
	containertype = /obj/structure/closet/crate/secure/explosives
	crash_restricted = TRUE

/datum/supply_packs/operations/droppod
	name = "宙斯轨道空投舱"
	contains = list(/obj/structure/droppod)
	containertype = null
	cost = 50
	crash_restricted = TRUE

/datum/supply_packs/operations/droppod_leader
	name = "宙斯指挥空投舱"
	contains = list(/obj/structure/droppod/leader)
	containertype = null
	cost = 100
	crash_restricted = TRUE

/datum/supply_packs/operations/researchcomp
	name = "研究控制台"
	contains = list(/obj/machinery/researchcomp)
	containertype = null
	cost = 200
	crash_restricted = TRUE
