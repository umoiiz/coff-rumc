/obj/item/ammo_magazine/sentry
	name = "\improper TUR-B弹匣 (10x28mm)"
	desc = "用于\"基点\"炮塔的200发10x28mm无壳弹弹箱. 在弹药耗尽时插入炮塔的弹药端口."
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "sentry"
	magazine_flags = NONE //can't be refilled or emptied by hand
	caliber = CALIBER_10X28
	max_rounds = 200
	default_ammo = /datum/ammo/bullet/turret

/obj/item/ammo_magazine/minisentry
	name = "\improper TUR-M弹匣 (10x20mm)"
	desc = "用于\"侏儒\"炮塔的300发10x20mm无壳弹弹箱. 在弹药耗尽时插入炮塔的弹药端口."
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "minisentry"
	magazine_flags = NONE //can't be refilled or emptied by hand
	caliber = CALIBER_10X20
	max_rounds = 300
	default_ammo = /datum/ammo/bullet/turret/mini

/obj/item/ammo_magazine/sentry_premade/dumb
	name = "M30弹箱 (10x28mm无壳弹)"
	desc = "装有50发10x28mm无壳弹的弹箱, 用于ST-571哨戒炮. 在弹药耗尽时将其送入哨戒炮的弹药端口."
	w_class = WEIGHT_CLASS_NORMAL
	magazine_flags = NONE //can't be refilled or emptied by hand
	caliber = CALIBER_10X28
	max_rounds = 500
	default_ammo = /datum/ammo/bullet/turret/dumb

/obj/item/ammo_magazine/sentry/fob_sentry
	max_rounds = INFINITY

// Sniper Sentry

/obj/item/ammo_magazine/sentry/sniper
	name = "\improper TUR-SN弹匣 (9x39mm)"
	desc = "用于\"黄蜂\"炮塔的50发9x39mm无壳弹弹箱. 在弹药耗尽时插入炮塔的弹药端口."
	icon_state = "sentry_sniper"
	max_rounds = 50
	default_ammo = /datum/ammo/bullet/turret/sniper

/obj/item/ammo_magazine/sentry/sniper/pea
	name = "\improper PE-A弹匣 (GOROH)"
	desc = "装满豌豆的盒子. 在弹药耗尽时插入豌豆枪."
	icon_state = "sentry_pea"
	max_rounds = 60
	default_ammo = /datum/ammo/bullet/turret/sniper/pea

/obj/item/ammo_magazine/sentry/shotgun
	name = "\improper TUR-SH弹匣 (12G)"
	desc = "用于\"公牛\"炮塔的75发12号特种弹弹箱. 在弹药耗尽时插入炮塔的弹药端口."
	caliber = CALIBER_12G
	icon_state = "sentry_shotgun"
	max_rounds = 75
	default_ammo = /datum/ammo/bullet/turret/buckshot

// Flamer Sentry

/obj/item/ammo_magazine/flamer_tank/large/sentry
	name = "\improper TUR-F小型燃料箱 (燃料)"
	desc = "用于\"凤凰\"炮塔的5升小型燃料箱. 在燃料耗尽时插入炮塔的燃料端口."
	icon_state = "sentry_flamer"
	icon = 'icons/obj/items/ammo/stationary.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	max_rounds = 75
	current_rounds = 75
	reload_delay = 3 SECONDS

	default_ammo = /datum/ammo/flamethrower/turret
