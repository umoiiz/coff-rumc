//-------------------------------------------------------
//Generic shotgun magazines. Only three of them, since all shotguns can use the same ammo unless we add other gauges.

/*
Shotguns don't really use unique "ammo" like other guns. They just load from a pool of ammo and generate the projectile
on the go. There's also buffering involved. But, we do need the ammo to check handfuls type, and it's nice to have when
you're looking back on the different shotgun projectiles available. In short of it, it's not needed to have more than
one type of shotgun ammo, but I think it helps in referencing it. ~N
*/
/obj/item/ammo_magazine/shotgun
	name = "12号霰弹独头弹盒"
	desc = "装满重型霰弹的盒子. 永恒的经典. 12号."
	icon = 'icons/obj/items/ammo/packet.dmi'
	icon_state = "slugs"
	default_ammo = /datum/ammo/bullet/shotgun/slug
	caliber = CALIBER_12G //All shotgun rounds are 12g right now.
	max_rounds = 25 // Real shotgun boxes are usually 5 or 25 rounds. This works with the new system, five handfuls.
	w_class = WEIGHT_CLASS_NORMAL // Can't throw it in your pocket, friend.
	icon_state_mini = "slugs"

/obj/item/ammo_magazine/shotgun/incendiary
	name = "12号燃烧独头弹盒"
	desc = "装满自爆燃烧霰弹的盒子. 12号."
	icon_state = "incendiary"
	default_ammo = /datum/ammo/bullet/shotgun/incendiary
	icon_state_mini = "incendiary"

/obj/item/ammo_magazine/shotgun/buckshot
	name = "12号鹿弹盒"
	desc = "装满扩散鹿弹的盒子. 12号."
	icon_state = "buckshot"
	default_ammo = /datum/ammo/bullet/shotgun/buckshot
	icon_state_mini = "buckshot"

/obj/item/ammo_magazine/shotgun/flechette
	name = "12号飞镖弹盒"
	desc = "装满飞镖霰弹的盒子. 12号."
	icon_state = "flechette"
	default_ammo = /datum/ammo/bullet/shotgun/flechette
	icon_state_mini = "flechette"

/obj/item/ammo_magazine/shotgun/beanbag
	name = "12号豆袋弹盒"
	desc = "装满用于非致命人群控制的豆袋霰弹的盒子. 12号."
	icon_state = "beanbag"
	default_ammo = /datum/ammo/bullet/shotgun/beanbag
	icon_state_mini = "beanbag"

/obj/item/ammo_magazine/shotgun/tracker
	name = "12号追踪弹盒"
	desc = "装满追踪霰弹的盒子. 12号."
	icon_state = "tracking"
	default_ammo = /datum/ammo/bullet/shotgun/tracker
	icon_state_mini = "tracking"

/obj/item/ammo_magazine/shotgun/blank
	name = "12号空包弹盒"
	desc = "装满空包霰弹的盒子. 12号."
	icon_state = "blank"
	default_ammo = /datum/ammo/bullet/shotgun/blank
	icon_state_mini = "blank"

/obj/item/ammo_magazine/rifle/bolt
	name = "7.62x54mmR步枪弹盒"
	desc = "装满步枪子弹的盒子."
	icon = 'icons/obj/items/ammo/packet.dmi'
	icon_state = "7.62" //Thank you Alterist
	default_ammo = /datum/ammo/bullet/sniper/svd
	caliber = CALIBER_762X54 //Cyka Blyat
	max_rounds = 20 // Real rifle boxes are usually 20 rounds. This works with the new system, four handfuls.
	w_class = WEIGHT_CLASS_SMALL // CAN throw it in your pocket, friend.
	icon_state_mini = "mosin"

/obj/item/ammo_magazine/rifle/boltclip //Nearly 1:1 copy of above
	name = "7.62x54mmR步枪弹桥夹"
	desc = "装满步枪子弹的一次性桥夹."
	icon_state = "clip"
	default_ammo = /datum/ammo/bullet/sniper/svd
	caliber = CALIBER_762X54
	max_rounds = 4
	w_class = WEIGHT_CLASS_SMALL
	icon_state_mini = "clips"

/obj/item/ammo_magazine/rifle/martini
	name = ".557/440步枪弹盒"
	desc = "装满步枪子弹的盒子."
	icon = 'icons/obj/items/ammo/packet.dmi'
	icon_state = ".557"
	default_ammo = /datum/ammo/bullet/sniper/martini
	caliber = CALIBER_557
	max_rounds = 20
	w_class = WEIGHT_CLASS_SMALL
	icon_state_mini = "martini"

/obj/item/ammo_magazine/rifle/martini/white
	name = ".557/440白色步枪弹盒"
	icon_state = ".557_white"
	default_ammo = /datum/ammo/bullet/sniper/martini/white

/obj/item/ammo_magazine/pistol/derringer
	name = ".40边缘发火手枪弹盒"
	desc = "装满手枪子弹的盒子."
	icon = 'icons/obj/items/ammo/packet.dmi'
	icon_state = "derringer_box"
	default_ammo = /datum/ammo/bullet/pistol/superheavy/derringer
	caliber = CALIBER_41RIM
	max_rounds = 10
	w_class = WEIGHT_CLASS_SMALL
	icon_state_mini = "ammo_packet"

/obj/item/ammo_magazine/shotgun/mbx900
	name = ".410脱壳弹盒"
	desc = "装满.410脱壳弹的盒子."
	icon_state = "mbx900_sabot"
	default_ammo = /datum/ammo/bullet/shotgun/mbx900_sabot
	caliber = CALIBER_410
	max_rounds = 25
	w_class = WEIGHT_CLASS_NORMAL
	icon_state_mini = "mbx900_sabot"

/obj/item/ammo_magazine/shotgun/mbx900/buckshot
	name = ".410鹿弹盒"
	desc = "装满.410鹿弹的盒子."
	icon_state = "mbx900_buckshot"
	default_ammo = /datum/ammo/bullet/shotgun/mbx900_buckshot
	icon_state_mini = "mbx900_buckshot"

/obj/item/ammo_magazine/shotgun/mbx900/tracking
	name = ".410追踪弹盒"
	desc = "装满.410追踪弹的盒子."
	icon_state = "mbx900_tracker"
	default_ammo = /datum/ammo/bullet/shotgun/mbx900_tracker
	icon_state_mini = "mbx900_tracker"

/obj/item/ammo_magazine/shotgun/heavy_buckshot
	name = "6号鹿弹盒"
	desc = "装满扩散鹿弹的盒子. 6号."
	caliber = CALIBER_6G
	icon_state = "heavy_shotgun_buckshot"
	default_ammo = /datum/ammo/bullet/shotgun/heavy_buckshot
	icon_state_mini = "buckshot"

/obj/item/ammo_magazine/shotgun/barrikada
	name = "6号'街垒'弹盒"
	desc = "装满绰号为'街垒'的高速霰弹独头弹的盒子. 其威力足以击穿从坦克引擎到几乎所有东西. 6号."
	caliber = CALIBER_6G
	icon_state = "heavy_shotgun_barrikada"
	default_ammo = /datum/ammo/bullet/shotgun/barrikada_slug
	icon_state_mini = "buckshot"
