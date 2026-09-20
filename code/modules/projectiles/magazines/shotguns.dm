//-------------------------------------------------------
//Generic shotgun magazines. Only three of them, since all shotguns can use the same ammo unless we add other gauges.

/*
Shotguns don't really use unique "ammo" like other guns. They just load from a pool of ammo and generate the projectile
on the go. There's also buffering involved. But, we do need the ammo to check handfuls type, and it's nice to have when
you're looking back on the different shotgun projectiles available. In short of it, it's not needed to have more than
one type of shotgun ammo, but I think it helps in referencing it. ~N
*/
/obj/item/ammo_magazine/shotgun
	name = "12号霰弹独头弹弹药盒"
	desc = "装有重型霰弹的弹药盒. 永恒的经典. 12号霰弹."
	icon = 'icons/obj/items/ammo/packet.dmi'
	icon_state = "slugs"
	default_ammo = /datum/ammo/bullet/shotgun/slug
	caliber = CALIBER_12G //All shotgun rounds are 12g right now.
	max_rounds = 25 // Real shotgun boxes are usually 5 or 25 rounds. This works with the new system, five handfuls.
	w_class = WEIGHT_CLASS_NORMAL // Can't throw it in your pocket, friend.
	icon_state_mini = "slugs"

/obj/item/ammo_magazine/shotgun/incendiary
	name = "12号燃烧独头弹弹药盒"
	desc = "装有自爆燃烧霰弹的弹药盒. 12号霰弹."
	icon_state = "incendiary"
	default_ammo = /datum/ammo/bullet/shotgun/incendiary
	icon_state_mini = "incendiary"

/obj/item/ammo_magazine/shotgun/buckshot
	name = "12号鹿弹弹药盒"
	desc = "一盒装满鹿弹扩散霰弹的弹药盒. 12号口径."
	icon_state = "buckshot"
	default_ammo = /datum/ammo/bullet/shotgun/buckshot
	icon_state_mini = "buckshot"

/obj/item/ammo_magazine/shotgun/flechette
	name = "一盒12号口径箭形弹"
	desc = "一盒装满箭形弹霰弹的弹药盒. 12号口径."
	icon_state = "flechette"
	default_ammo = /datum/ammo/bullet/shotgun/flechette
	icon_state_mini = "flechette"

/obj/item/ammo_magazine/shotgun/beanbag
	name = "一盒12号口径豆袋弹"
	desc = "一盒装满用于非致命人群控制的豆袋弹霰弹的弹药盒. 12号口径."
	icon_state = "beanbag"
	default_ammo = /datum/ammo/bullet/shotgun/beanbag
	icon_state_mini = "beanbag"

/obj/item/ammo_magazine/shotgun/tracker
	name = "一盒12号口径追踪弹"
	desc = "一盒装满追踪弹霰弹的弹药盒. 12号口径."
	icon_state = "tracking"
	default_ammo = /datum/ammo/bullet/shotgun/tracker
	icon_state_mini = "tracking"

/obj/item/ammo_magazine/shotgun/blank
	name = "一盒12号口径空包弹"
	desc = "一盒装满空包弹霰弹的弹药盒. 12号口径."
	icon_state = "blank"
	default_ammo = /datum/ammo/bullet/shotgun/blank
	icon_state_mini = "blank"

/obj/item/ammo_magazine/rifle/bolt
	name = "一盒7.62x54mmR步枪弹"
	desc = "一盒装满步枪子弹的弹药盒."
	icon = 'icons/obj/items/ammo/packet.dmi'
	icon_state = "7.62" //Thank you Alterist
	default_ammo = /datum/ammo/bullet/sniper/svd
	caliber = CALIBER_762X54 //Cyka Blyat
	max_rounds = 20 // Real rifle boxes are usually 20 rounds. This works with the new system, four handfuls.
	w_class = WEIGHT_CLASS_SMALL // CAN throw it in your pocket, friend.
	icon_state_mini = "mosin"

/obj/item/ammo_magazine/rifle/boltclip //Nearly 1:1 copy of above
	name = "一夹7.62x54mmR步枪弹"
	desc = "一个装满步枪子弹的一次性桥夹."
	icon_state = "clip"
	default_ammo = /datum/ammo/bullet/sniper/svd
	caliber = CALIBER_762X54
	max_rounds = 4
	w_class = WEIGHT_CLASS_SMALL
	icon_state_mini = "clips"

/obj/item/ammo_magazine/rifle/martini
	name = "一盒.557/440步枪弹"
	desc = "一盒装满步枪子弹的弹药盒."
	icon = 'icons/obj/items/ammo/packet.dmi'
	icon_state = ".557"
	default_ammo = /datum/ammo/bullet/sniper/martini
	caliber = CALIBER_557
	max_rounds = 20
	w_class = WEIGHT_CLASS_SMALL
	icon_state_mini = "martini"

/obj/item/ammo_magazine/rifle/martini/white
	name = "一盒.557/440白色步枪弹"
	icon_state = ".557_white"
	default_ammo = /datum/ammo/bullet/sniper/martini/white

/obj/item/ammo_magazine/pistol/derringer
	name = "一盒.40边缘发火手枪弹"
	desc = "一盒装满手枪子弹的弹药盒."
	icon = 'icons/obj/items/ammo/packet.dmi'
	icon_state = "derringer_box"
	default_ammo = /datum/ammo/bullet/pistol/superheavy/derringer
	caliber = CALIBER_41RIM
	max_rounds = 10
	w_class = WEIGHT_CLASS_SMALL
	icon_state_mini = "ammo_packet"

/obj/item/ammo_magazine/shotgun/mbx900
	name = "一盒.410脱壳弹"
	desc = "一盒装满.410脱壳弹的弹药盒."
	icon_state = "mbx900_sabot"
	default_ammo = /datum/ammo/bullet/shotgun/mbx900_sabot
	caliber = CALIBER_410
	max_rounds = 25
	w_class = WEIGHT_CLASS_NORMAL
	icon_state_mini = "mbx900_sabot"

/obj/item/ammo_magazine/shotgun/mbx900/buckshot
	name = "一盒.410鹿弹"
	desc = "一盒装满.410鹿弹的弹药盒."
	icon_state = "mbx900_buckshot"
	default_ammo = /datum/ammo/bullet/shotgun/mbx900_buckshot
	icon_state_mini = "mbx900_buckshot"

/obj/item/ammo_magazine/shotgun/mbx900/tracking
	name = "一盒.410追踪弹"
	desc = "一盒装满.410追踪弹的弹药盒."
	icon_state = "mbx900_tracker"
	default_ammo = /datum/ammo/bullet/shotgun/mbx900_tracker
	icon_state_mini = "mbx900_tracker"

/obj/item/ammo_magazine/shotgun/heavy_buckshot
	name = "一盒6号口径鹿弹"
	desc = "一盒装满鹿弹扩散霰弹的弹药盒. 6号口径."
	caliber = CALIBER_6G
	icon_state = "heavy_shotgun_buckshot"
	default_ammo = /datum/ammo/bullet/shotgun/heavy_buckshot
	icon_state_mini = "buckshot"

/obj/item/ammo_magazine/shotgun/barrikada
	name = "一盒6号口径'街垒'弹"
	desc = "一盒装满绰号'街垒'的高速霰弹独头弹的弹药盒. 评级可击穿基本上一切,包括坦克引擎. 6号口径."
	caliber = CALIBER_6G
	icon_state = "heavy_shotgun_barrikada"
	default_ammo = /datum/ammo/bullet/shotgun/barrikada_slug
	icon_state_mini = "buckshot"
