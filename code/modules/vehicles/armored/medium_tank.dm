/obj/vehicle/sealed/armored/multitile/medium //Its a smaller tank, we had sprites for it so whoo
	name = "THV - Hades"
	desc = "一种金属巨兽, 专为撕裂敌方阵线而设计. 它预装有一门能够部署重型载荷的主战坦克炮, 以及一挺能够快速连续撕裂多个目标的机枪."
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
