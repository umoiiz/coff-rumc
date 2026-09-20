/datum/supply_packs/vehicles
	group = "载具"
	containertype = /obj/structure/closet/crate/weapon

/datum/supply_packs/vehicles/bfg_cannon
	name = "坦克载BFG 9500"
	contains = list(/obj/item/armored_weapon/bfg)
	cost = 1600

/datum/supply_packs/vehicles/bfg_rounds
	name = "坦克BFG反物质容器"
	contains = list(/obj/item/ammo_magazine/tank/bfg)
	cost = 200

/datum/supply_packs/vehicles/ltb_he_shell
	name = "LTB高爆坦克炮弹"
	contains = list(/obj/item/ammo_magazine/tank/ltb_cannon)
	cost = 50

/datum/supply_packs/vehicles/ltb_apfds_shell
	name = "LTB脱壳穿甲坦克炮弹"
	contains = list(/obj/item/ammo_magazine/tank/ltb_cannon/apfds)
	cost = 50

/datum/supply_packs/vehicles/ltaap_rounds
	name = "LTAAP坦克弹匣"
	contains = list(/obj/item/ammo_magazine/tank/ltaap_chaingun)
	cost = 50

/datum/supply_packs/weapons/ltb_canister_shell
	name = "LTB霰弹坦克炮弹"
	contains = list(/obj/item/ammo_magazine/tank/ltb_cannon/canister)
	cost = 50

/datum/supply_packs/vehicles/autocannon_ap_rounds
	name = "伏击者自动炮穿甲弹药箱"
	contains = list(/obj/item/ammo_magazine/tank/autocannon)
	cost = 50

/datum/supply_packs/vehicles/autocannon_he_rounds
	name = "伏击者自动炮高爆弹药箱"
	contains = list(/obj/item/ammo_magazine/tank/autocannon/high_explosive)
	cost = 50

/datum/supply_packs/vehicles/cupola_rounds
	name = "炮塔坦克弹匣"
	contains = list(/obj/item/ammo_magazine/tank/secondary_cupola)
	cost = 50

/datum/supply_packs/vehicles/secondary_flamer_tank
	name = "喷射火焰坦克"
	contains = list(/obj/item/ammo_magazine/tank/secondary_flamer_tank)
	cost = 50

/datum/supply_packs/vehicles/tank_glauncher
	name = "坦克榴弹发射器弹匣"
	contains = list(/obj/item/ammo_magazine/tank/tank_glauncher)
	cost = 50

/datum/supply_packs/vehicles/tow_rocket
	name = "TOW导弹"
	contains = list(/obj/item/ammo_magazine/tank/tow_missile)
	cost = 25 // marginally cheaper due to being a single loader

/datum/supply_packs/vehicles/microrocket_pod
	name = "微型火箭巢"
	contains = list(/obj/item/ammo_magazine/tank/microrocket_rack)
	cost = 50

/datum/supply_packs/vehicles/motorbike
	name = "全地形摩托车"
	cost = 400
	contains = list(/obj/vehicle/ridden/motorbike)
	containertype = null

/datum/supply_packs/vehicles/sidecar
	name = "边车摩托车升级"
	cost = 200
	contains = list(/obj/item/sidecar)

/datum/supply_packs/vehicles/jerrycan
	name = "汽油桶"
	cost = 100
	contains = list(/obj/item/reagent_containers/jerrycan)

/datum/supply_packs/vehicles/droid_combat
	name = "装备武器的战斗机器人"
	contains = list(/obj/vehicle/unmanned/droid)
	cost = 400
	containertype = null

/datum/supply_packs/vehicles/droid_scout
	name = "侦察机器人"
	contains = list(/obj/vehicle/unmanned/droid/scout)
	cost = 300
	containertype = null

/datum/supply_packs/vehicles/droid_powerloader
	name = "动力装载机器人"
	contains = list(/obj/vehicle/unmanned/droid/ripley)
	cost = 300
	containertype = null

/datum/supply_packs/vehicles/droid_weapon
	name = "机器人武器"
	contains = list(/obj/item/uav_turret/droid)
	cost = 200

/datum/supply_packs/vehicles/tiny_uv
	name = "微型无人载具 - 石龙子"
	contains = list(/obj/item/deployable_vehicle/tiny)
	cost = 50

/datum/supply_packs/vehicles/light_uv
	name = "轻型无人载具 - 鬣蜥"
	contains = list(/obj/vehicle/unmanned)
	cost = 250

/datum/supply_packs/vehicles/medium_uv
	name = "中型无人载具 - 壁虎"
	contains = list(/obj/vehicle/unmanned/medium)
	cost = 350

/datum/supply_packs/vehicles/heavy_uv
	name = "重型无人载具 - 科莫多龙"
	contains = list(/obj/vehicle/unmanned/heavy)
	cost = 550

/datum/supply_packs/vehicles/uv_cell
	name = "无人载具电池"
	contains = list(/obj/item/cell/unmanned_vehicle)
	cost = 150

/datum/supply_packs/vehicles/uv_light_weapon
	name = "轻型无人载具武器"
	contains = list(/obj/item/uav_turret)
	cost = 100
	containertype = /obj/structure/closet/crate/weapon

/datum/supply_packs/vehicles/uv_heavy_weapon
	name = "重型无人载具武器"
	contains = list(/obj/item/uav_turret/heavy)
	cost = 150
	containertype = /obj/structure/closet/crate/weapon

/datum/supply_packs/vehicles/uv_light_ammo
	name = "轻型无人载具弹药 - 11x35mm"
	contains = list(/obj/item/ammo_magazine/box11x35mm)
	cost = 20
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/uv_heavy_ammo
	name = "重型无人载具弹药 - 12x40mm"
	contains = list(/obj/item/ammo_magazine/box12x40mm)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/vehicle_remote
	name = "载具遥控器"
	contains = list(/obj/item/unmanned_vehicle_remote)
	cost = 10
	containertype = /obj/structure/closet/crate

/datum/supply_packs/vehicles/mounted_hsg
	name = "运输机挂载 HSG-102 重型智能枪"
	contains = list(/obj/structure/dropship_equipment/shuttle/weapon_holder/machinegun)
	cost = 500

/datum/supply_packs/vehicles/minigun_nest
	name = "运输机挂载 MG-2005 加特林机枪"
	contains = list(/obj/structure/dropship_equipment/shuttle/weapon_holder/minigun)
	cost = 750

/datum/supply_packs/vehicles/mounted_heavy_laser
	name = "运输机挂载 TE-9001 重型激光"
	contains = list(/obj/structure/dropship_equipment/shuttle/weapon_holder/heavylaser)
	cost = 900

/datum/supply_packs/vehicles/hsg_ammo
	name = "运输机挂载 HSG-102 重型智能枪弹药"
	contains = list(/obj/item/ammo_magazine/hsg102/hsg_nest)
	cost = 100
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/minigun_ammo
	name = "运输机挂载 MG-2005 加特林机枪弹药"
	contains = list(/obj/item/ammo_magazine/heavy_minigun)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/hl_ammo
	name = "运输机挂载 TE-9001 重型激光弹药 (x3)"
	contains = list(
		/obj/item/cell/lasgun/heavy_laser,
		/obj/item/cell/lasgun/heavy_laser,
		/obj/item/cell/lasgun/heavy_laser,
	)
	cost = 50
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/lvrt
	name = "LVRT 'Fallow' 侦察载具"
	contains = list(
		/obj/vehicle/sealed/armored/multitile/lvrt,
		/obj/item/pamphlet/tank_crew,
		/obj/item/pamphlet/tank_crew,
		/obj/item/pamphlet/tank_loader,
	)
	cost = 1600
	crash_restricted = TRUE
	containertype = /obj/structure/largecrate/supply

/datum/supply_packs/vehicles/lvrt_sarden
	name = "EM-2600 'SARDEN' 机炮"
	contains = list(/obj/item/armored_weapon/lvrt_sarden,)
	cost = 300
	crash_restricted = TRUE
	containertype = /obj/structure/closet/crate/weapon

/datum/supply_packs/vehicles/lvrt_cannon
	name = "EM-2500 低速炮"
	contains = list(/obj/item/armored_weapon/lvrt_cannon,)
	cost = 400
	crash_restricted = TRUE
	containertype = /obj/structure/closet/crate/weapon

/datum/supply_packs/vehicles/lvrt_flamer
	name = "EM-2400 低脉冲喷火器"
	contains = list(/obj/item/armored_weapon/lvrt_flamer,)
	cost = 350
	crash_restricted = TRUE
	containertype = /obj/structure/closet/crate/weapon

/datum/supply_packs/vehicles/lvrt_sarden_ammo
	name = "LVRT SARDEN 机炮弹药 (x2)"
	contains = list(
		/obj/item/ammo_magazine/tank/sarden_clip,
		/obj/item/ammo_magazine/tank/sarden_clip,
	)
	cost = 50
	crash_restricted = TRUE
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/lvrt_sarden_ammo_he
	name = "LVRT SARDEN 机炮高爆弹药 (x2)"
	contains = list(
		/obj/item/ammo_magazine/tank/sarden_clip/high_explosive,
		/obj/item/ammo_magazine/tank/sarden_clip/high_explosive,
	)
	cost = 50
	crash_restricted = TRUE
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/lvrt_cannon_ammo
	name = "EM-2500 破甲弹 (76mm) (x2)"
	contains = list(
		/obj/item/ammo_magazine/tank/lowvel_cannon_recon,
		/obj/item/ammo_magazine/tank/lowvel_cannon_recon,
	)
	cost = 50
	crash_restricted = TRUE
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/lvrt_cannon_ammo_he
	name = "EM-2500 高爆弹 (76mm) (x2)"
	contains = list(
		/obj/item/ammo_magazine/tank/lowvel_cannon_recon/high_explosive,
		/obj/item/ammo_magazine/tank/lowvel_cannon_recon/high_explosive,
	)
	cost = 50
	crash_restricted = TRUE
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/lvrt_cannon_ammo_hefa
	name = "EM-2500 高爆燃烧弹 (76mm) (x2)"
	contains = list(
		/obj/item/ammo_magazine/tank/lowvel_high_explosive_fragmenting_antipersonnel,
		/obj/item/ammo_magazine/tank/lowvel_high_explosive_fragmenting_antipersonnel,
	)
	cost = 50
	crash_restricted = TRUE
	containertype = /obj/structure/closet/crate/ammo

/datum/supply_packs/vehicles/lvrt_flamer_ammo
	name = "EM-2400 喷火器弹药 (x2)"
	contains = list(
		/obj/item/ammo_magazine/tank/lowvel_canister,
		/obj/item/ammo_magazine/tank/lowvel_canister,
	)
	cost = 50
	crash_restricted = TRUE
	containertype = /obj/structure/closet/crate/ammo
