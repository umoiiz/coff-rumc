/obj/vehicle/sealed/armored/multitile/medium //Its a smaller tank, we had sprites for it so whoo
	name = "THV - Hades"
	desc = "一辆金属巨兽,旨在撕裂敌方阵线.它预装了能发射重型弹药的主战坦克炮,以及能快速连续撕裂多个目标的加特林机枪."
	icon = 'icons/obj/armored/2x2/medium_vehicles.dmi'
	turret_icon = 'icons/obj/armored/2x2/medium_vehicles.dmi'
	turret_icon_state = "tank_turret"
	hitbox = /obj/hitbox/medium
	damage_icon_path = null
	interior = null
	icon_state = "tank"
	armored_flags = ARMORED_HAS_PRIMARY_WEAPON|ARMORED_HAS_UNDERLAY
	pixel_w = -16
	pixel_z = -32
	obj_integrity = 1300
	max_integrity = 1300
	max_occupants = 3

/obj/vehicle/sealed/armored/multitile/medium/enter_locations(atom/movable/entering_thing)
	return list(get_step(src, REVERSE_DIR(dir)))
