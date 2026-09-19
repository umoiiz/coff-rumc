///bullet grenade: shoots bullets out from itself in a ring
/obj/item/explosive/grenade/bullet
	name = "\improper M90铅爆手榴弹"
	desc = "铅爆手榴弹在引爆后会释放一小阵弹丸.远离友军.或者不远离.我只是个标签."
	icon_state = "grenade_rad"
	worn_icon_state = "grenade_rad"
	icon_state_mini = "grenade_red"
	det_time = 40
	arm_sound = 'sound/weapons/armbomb.ogg'
	hud_state = "grenade_he"
	/// amount of rotations that we will do with these bullets
	var/rotations = 2
	///whether we randomly emit or in equal intervals
	var/randomized = FALSE
	///sound to play while shooting
	var/fire_sound = 'sound/weapons/burst_phaser2.ogg'
	/// total amount of bullets to fire, split evenly between rotations
	var/projectile_count = 30
	/// range of the bullets
	var/range = 7
	/// speed of the bullets
	var/speed = 2
	/// ammo type to shoot out: can be ANY ammo type
	var/datum/ammo/ammo_type = /datum/ammo/energy/lasgun/marine/heavy_laser

/obj/item/explosive/grenade/bullet/prime()
	var/list/bullets = list()
	var/proj_type = /atom/movable/projectile
	if(initial(ammo_type.ammo_behavior_flags) & AMMO_HITSCAN)
		proj_type = /atom/movable/projectile/hitscan
	for(var/i = 1 to projectile_count)
		var/atom/movable/projectile/proj = new proj_type(src, initial(ammo_type.hitscan_effect_icon))
		proj.generate_bullet(ammo_type)
		bullets += proj

	bullet_burst(loc, bullets, null, fire_sound, range, speed, randomized, rotations)
	qdel(src)

/obj/item/explosive/grenade/bullet/laser
	name = "\improper M80激光爆裂手榴弹"
	desc = "激光爆裂手榴弹经过超载充能,引爆时会向四周散射一道光束.远离友军.或者不远离.我只是个标签."
	icon_state = "grenade_lasburster"
	worn_icon_state = "grenade_lasburster"
	icon_state_mini = "grenade_lasburster"
	det_time = 40
	hud_state = "grenade_lasburster"

	rotations = -1
	fire_sound = 'sound/weapons/burst_phaser2.ogg'
	projectile_count = 20
	ammo_type = /datum/ammo/energy/lasburster

/obj/item/explosive/grenade/bullet/hefa
	name = "\improper M25高爆碎片手榴弹"
	desc = "高爆碎片手榴弹会产生一次威力强大但范围极小的爆炸,并伴随一圈散射的鹿弹破片,请扔得非常、非常、非常远."
	icon_state = "grenade_hefa"
	worn_icon_state = "grenade_hefa"
	icon_state_mini = "grenade_hefa"
	hud_state = "grenade_hefa"
	rotations = -1
	fire_sound = null
	projectile_count = 50
	ammo_type = /datum/ammo/bullet/hefa_buckshot

/obj/item/explosive/grenade/bullet/hefa/prime()
	cell_explosion(loc, 35, 20)
	return ..()
