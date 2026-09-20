///Default ammo for the HSG-102.
/obj/item/ammo_magazine/hsg102
	name = "HSG-102弹鼓(10x30mm无壳弹)"
	desc = "一盒300发10x30mm无壳钨芯弹,用于HSG-102重型智能机枪."
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "hsg102"
	magazine_flags = NONE
	caliber = CALIBER_10X30
	max_rounds = 300
	default_ammo = /datum/ammo/bullet/machinegun/smart
	reload_delay = 5 SECONDS
	icon_state_mini = "mag_hmg"

///This is the one that comes in the mapbound and dropship mounted version of the HSG-102, it has a stupid amount of ammo. Even more than the ammo counter can display.
/obj/item/ammo_magazine/hsg102/hsg_nest
	max_rounds = 500

/obj/item/ammo_magazine/hmg08
	name = "HMG-08弹鼓(10x30mm无壳弹)"
	desc = "一盒500发10x28mm无壳钨芯弹,用于HMG-08重型机枪.大概装不进你的背包.把它挂在腰带或背上吧."
	w_class = WEIGHT_CLASS_BULKY
	equip_slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "mg08"
	icon_state_mini = "mag_drum_big_green"
	magazine_flags = NONE
	caliber = CALIBER_10X28
	max_rounds = 500
	default_ammo = /datum/ammo/bullet/machinegun
	reload_delay = 10 SECONDS

/obj/item/ammo_magazine/hmg08/small
	name = "HMG-08弹匣(10x30mm无壳弹)"
	desc = "一盒250发10x28mm无壳钨芯弹,用于HMG-08重型机枪."
	w_class = WEIGHT_CLASS_NORMAL
	equip_slot_flags = ITEM_SLOT_BELT
	icon_state = "mg08_small"
	icon_state_mini = "mag_hmg"
	max_rounds = 250
	reload_delay = 5 SECONDS

/obj/item/ammo_magazine/mg27
	name = "MG-27弹匣(10x27mm无壳弹)"
	desc = "一盒150发10x27mm无壳弹,用于MG-27中型机枪."
	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "mg27"
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state_mini = "mag_drum_big_armygreen"
	magazine_flags = NONE
	caliber = CALIBER_10X27_CASELESS
	max_rounds = 150
	default_ammo = /datum/ammo/bullet/rifle/heavy
	reload_delay = 1 SECONDS

/obj/item/ammo_magazine/agls37
	name = "AGLS-37高爆弹匣(40mm无壳弹)"
	desc = "一盒装有30发40mm无壳高爆榴弹,用于AGLS-37自动榴弹发射器."
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "agls"
	magazine_flags = NONE
	caliber = CALIBER_40MM
	max_rounds = 30
	default_ammo = /datum/ammo/grenade_container/agls37
	reload_delay = 4 SECONDS

/obj/item/ammo_magazine/agls37/fragmentation
	name = "AGLS-37破片弹匣(40mm无壳弹)"
	desc = "一盒装有30发40mm无壳破片榴弹,用于AGLS-37自动榴弹发射器."
	icon_state = "agls_frag"
	default_ammo = /datum/ammo/ags_shrapnel

/obj/item/ammo_magazine/agls37/incendiary
	name = "AGLS-37白磷弹匣(40mm无壳弹)"
	desc = "一盒装有30发40mm无壳白磷榴弹,用于AGLS-37自动榴弹发射器."
	icon_state = "agls_incend"
	default_ammo = /datum/ammo/ags_shrapnel/incendiary

/obj/item/ammo_magazine/agls37/flare
	name = "AGLS-37照明弹匣(40mm无壳弹)"
	desc = "一盒装有30发40mm无壳照明榴弹,用于AGLS-37自动榴弹发射器."
	icon_state = "agls_flare"
	default_ammo = /datum/ammo/grenade_container/agls37/flare

/obj/item/ammo_magazine/agls37/cloak
	name = "AGLS-37烟幕弹匣(40mm无壳弹)"
	desc = "一盒装有30发40mm无壳烟幕榴弹,用于AGLS-37自动榴弹发射器."
	icon_state = "agls_cloak"
	default_ammo = /datum/ammo/grenade_container/agls37/cloak

/obj/item/ammo_magazine/agls37/tanglefoot
	name = "AGLS-37绊足弹匣(40mm无壳弹)"
	desc = "一盒装有30发40mm无壳绊足榴弹,用于AGLS-37自动榴弹发射器."
	icon_state = "agls_pgas"
	default_ammo = /datum/ammo/grenade_container/agls37/tanglefoot

/obj/item/ammo_magazine/at36
	name = "AT-36穿甲高爆弹(37mm炮弹)"
	desc = "一发37mm轻型反坦克炮炮弹.能穿透墙壁和工事,在击中目标后爆炸,装药量和威力低于普通弹药."
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "at36"
	worn_icon_state = "tat36"
	magazine_flags = MAGAZINE_REFUND_IN_CHAMBER
	caliber = CALIBER_37MM
	max_rounds = 1
	default_ammo = /datum/ammo/rocket/atgun_shell
	reload_delay = 2 SECONDS

/obj/item/ammo_magazine/at36/apcr
	name = "AT-36硬芯穿甲弹(37mm炮弹)"
	desc = "一发37mm钨芯轻型反坦克炮炮弹,专为穿透几乎一切而制造,但不会留下大洞."
	icon_state = "at36_apcr"
	worn_icon_state = "tat36_apcr"
	default_ammo = /datum/ammo/rocket/atgun_shell/apcr

/obj/item/ammo_magazine/at36/he
	name = "AT-36高爆弹(37mm炮弹)"
	desc = "一发37mm轻型反坦克炮炮弹,用于摧毁工事,大量装药使其速度较慢.但能炸出相当大的洞."
	icon_state = "at36_he"
	worn_icon_state = "tat36_he"
	default_ammo = /datum/ammo/rocket/atgun_shell/he

/obj/item/ammo_magazine/at36/beehive
	name = "AT-36蜂巢弹(37mm炮弹)"
	desc = "一发37mm轻型反坦克炮炮弹,用于绞杀步兵,较轻的装药使其速度适中.能把任何人打成瑞士奶酪."
	icon_state = "at36_beehive"
	worn_icon_state = "tat36_beehive"
	default_ammo = /datum/ammo/rocket/atgun_shell/beehive

/obj/item/ammo_magazine/at36/incend
	name = "AT-36凝固汽油弹(37mm炮弹)"
	desc = "一发37mm轻型反坦克炮炮弹,用于将战场化为火海,较轻的装药使其速度适中.会把任何目标烧成焦炭."
	icon_state = "at36_incend"
	worn_icon_state = "tat36_incend"
	default_ammo = /datum/ammo/rocket/atgun_shell/beehive/incend

/obj/item/ammo_magazine/heavy_minigun
	name = "MG-2005弹匣(7.62x51mm)"
	desc = "一盒1000发弹药,用于MG-2005转管机枪."
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "minigun"
	magazine_flags = NONE
	caliber = CALIBER_762X51
	max_rounds = 1000
	default_ammo = /datum/ammo/bullet/minigun
	reload_delay = 10 SECONDS

/obj/item/ammo_magazine/atr22
	name = "机炮高速弹匣(20mm)"
	desc = "一盒100发20mm高速弹,用于ATR-22机炮.能穿透人员和掩体."
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "ac"
	worn_icon_state = "ac"
	magazine_flags = NONE
	caliber = CALIBER_20
	max_rounds = 100
	default_ammo = /datum/ammo/bullet/auto_cannon
	reload_delay = 4 SECONDS

/obj/item/ammo_magazine/atr22/flak
	name = "机炮智能引爆弹匣(20mm)"
	desc = "一盒80发20mm智能引爆弹,用于ATR-22机炮.击中目标后引爆."
	icon_state = "ac_flak"
	worn_icon_state = "ac_flak"
	default_ammo = /datum/ammo/bullet/auto_cannon/flak

/obj/item/cell/lasgun/heavy_laser
	name = "重型武器激光电池"
	desc = "一块电量足以供TE-9001使用的电池.无法充电."
	w_class = WEIGHT_CLASS_BULKY
	maxcharge = 225
	reload_delay = 5 SECONDS
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "hl"
	charge_overlay = null

/obj/item/ammo_magazine/fk88
	name = "FK-88炮弹(155mm炮弹)"
	desc = "一发15cm炮弹,用于FK-88高射炮.你到底是怎么弄到这个的?"
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "fk88_he"
	w_class = WEIGHT_CLASS_BULKY
	magazine_flags = MAGAZINE_REFUND_IN_CHAMBER
	caliber = CALIBER_15CM
	max_rounds = 1
	reload_delay = 8 SECONDS
	default_ammo = /datum/ammo/rocket/fk88

/obj/item/ammo_magazine/fk88/he
	name = "FK-88高爆弹(155mm炮弹)"
	desc = "一发15cm高爆弹,用于FK-88高射炮."
	default_ammo = /datum/ammo/rocket/fk88

/obj/item/ammo_magazine/fk88/he/unguided
	name = "FK-88无制导高爆弹(155mm炮弹)"
	desc = "一发15cm无制导高爆弹,用于FK-88高射炮."
	default_ammo = /datum/ammo/rocket/fk88/unguided

/obj/item/ammo_magazine/fk88/sabot
	name = "FK-88尾翼稳定脱壳穿甲弹(155mm炮弹)"
	desc = "一发15cm尾翼稳定脱壳穿甲弹,用于FK-88高射炮,内含一枚以高超音速飞行的巨型金属飞镖,能轻松穿透几乎一切并飞到另一侧.需要一段最小距离来稳定弹道才能准确命中目标,能在几乎任何东西上撕开一个干净的洞."
	icon_state = "fk88_sabot"
	default_ammo = /datum/ammo/bullet/fk88_apfds

///Default ammo for the ML-91 and its export variants.
/obj/item/ammo_magazine/kord
	name = "KRD-61ES弹匣(10x30mm无壳弹)"
	desc = "一盒300发10x30mm无壳钨芯弹,用于KRD-61ES重型智能机枪."
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "kord"
	magazine_flags = NONE
	caliber = CALIBER_10X30
	max_rounds = 300
	default_ammo = /datum/ammo/bullet/machinegun
	reload_delay = 5 SECONDS
	icon_state_mini = "mag_hmg"
