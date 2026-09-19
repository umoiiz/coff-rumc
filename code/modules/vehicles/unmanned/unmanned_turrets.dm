/obj/item/uav_turret
	name = "轻型无人载具炮塔"
	desc = "无人载具的炮塔部分."
	icon = 'icons/obj/unmanned_vehicles.dmi'
	icon_state = "light_cannon_obj"
	///Turret type, used for assigning what we do on clicks
	var/turret_type = TURRET_TYPE_LIGHT
	///Ammo typepath we use when attached
	var/ammo_type = /datum/ammo/bullet/smg
	/// Amount of projectiles in this turret
	var/current_rounds = 150
	/// The max amount of projectiles in this turret
	var/max_rounds = 150
	///This var must match the unmanned vehicles turret_pattern then be added
	var/turret_pattern = PATTERN_TRACKED
	/// The fire rate of this turret in byond tick
	var/fire_delay = 0.1 SECONDS
	///Typepath of the ammo to reload it.
	var/magazine_type = /obj/item/ammo_magazine/box11x35mm


/obj/item/uav_turret/heavy
	name = "重型无人载具炮塔"
	icon_state = "heavy_cannon_obj"
	turret_type = TURRET_TYPE_HEAVY
	ammo_type = /datum/ammo/bullet/machinegun
	fire_delay = 0.2 SECONDS
	current_rounds = 50
	max_rounds = 50
	magazine_type = /obj/item/ammo_magazine/box12x40mm //I think this is the correct one?

/obj/item/uav_turret/droid
	name = "机器人能量炮"
	icon_state = "droidlaser_obj"
	turret_pattern = PATTERN_DROID
	turret_type = TURRET_TYPE_DROIDLASER
	ammo_type = /datum/ammo/energy/lasgun/marine/overcharge
	fire_delay = 0.25 SECONDS
	current_rounds = 300
	max_rounds = 300

/obj/item/uav_turret/claw
	name = "无人载具爪"
	desc = "小巧但坚固, 这个爪模块可扣装到无人载具上. 非常适合抓取那些违抗命令者的尸体, 携带一次性爆炸载荷, 或补给品."
	icon_state = "claw_obj"
	turret_type = TURRET_TYPE_CLAW
	turret_pattern = PATTERN_TRACKED
	fire_delay = 1 SECONDS
