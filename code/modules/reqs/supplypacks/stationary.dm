/datum/supply_packs/stationary
	group = "固定式"
	containertype = /obj/structure/closet/crate/mounted

/datum/supply_packs/stationary/sentry
	name = "TUR-B炮塔\"基础型\""
	contains = list(/obj/item/weapon/gun/sentry/basic)
	cost = 200

/datum/supply_packs/stationary/sentry_upgrade
	name = "TUR-B炮塔升级套件"
	contains = list(/obj/item/sentry_upgrade_kit,)
	cost = 150

/datum/supply_packs/stationary/sentry/ammo
	name = "TUR-B炮塔弹匣\"基础型\""
	contains = list(/obj/item/ammo_magazine/sentry)
	cost = 50

/datum/supply_packs/stationary/sentry/ammo/mini
	name = "TUR-M炮塔弹匣\"侏儒\""
	contains = list(/obj/item/ammo_magazine/minisentry)

/datum/supply_packs/stationary/sentry/ammo/sniper
	name = "TUR-SN炮塔弹匣\"黄蜂\""
	contains = list(/obj/item/ammo_magazine/sentry/sniper)

/datum/supply_packs/stationary/sentry/ammo/shotgun
	name = "TUR-SH炮塔弹匣\"公牛\""
	contains = list(/obj/item/ammo_magazine/sentry/shotgun)

/datum/supply_packs/stationary/sentry/ammo/flamer
	name = "TUR-F炮塔燃料罐\"凤凰\""
	contains = list(/obj/item/ammo_magazine/flamer_tank/large/sentry)

/datum/supply_packs/stationary/buildasentry
	name = "哨戒炮组装附件系统"
	contains = list(/obj/item/attachable/buildasentry)
	cost = 250

/datum/supply_packs/stationary/m56d_emplacement
	name = "HSG-102重型智能机枪架"
	contains = list(/obj/item/storage/box/hsg102)
	cost = 600

/datum/supply_packs/stationary/m56d
	name = "HSG-102重型智能机枪架弹药"
	contains = list(/obj/item/ammo_magazine/hsg102)
	cost = 60

/datum/supply_packs/stationary/minigun_emplacement
	name = "MG-2005自动转轮机枪"
	contains = list(/obj/item/weapon/gun/standard_minigun)
	cost = 600

/datum/supply_packs/stationary/minigun_ammo
	name = "MG-2005转轮机枪架弹药"
	contains = list(/obj/item/ammo_magazine/heavy_minigun)
	cost = 30

/datum/supply_packs/stationary/autocannon_emplacement
	name = "ATR-22防空炮架"
	contains = list(/obj/item/weapon/gun/atr22)
	cost = 700

/datum/supply_packs/stationary/ac_hv
	name = "ATR-22高速弹药"
	contains = list(/obj/item/ammo_magazine/atr22)
	cost = 40

/datum/supply_packs/stationary/ac_flak
	name = "ATR-22智能引爆弹药"
	contains = list(/obj/item/ammo_magazine/atr22/flak)
	cost = 40

/datum/supply_packs/stationary/ags_emplacement
	name = "AGLS-37自动榴弹发射器架"
	contains = list(/obj/item/weapon/gun/agls37)
	cost = 300

/datum/supply_packs/stationary/ags_highexplo
	name = "AGLS-37自动榴弹发射器高爆榴弹"
	contains = list(/obj/item/ammo_magazine/agls37)
	cost = 65

/datum/supply_packs/stationary/ags_frag
	name = "AGLS-37自动榴弹发射器破片榴弹"
	contains = list(/obj/item/ammo_magazine/agls37/fragmentation)
	cost = 55

/datum/supply_packs/stationary/ags_incendiary
	name = "AGLS-37自动榴弹发射器白磷榴弹"
	contains = list(/obj/item/ammo_magazine/agls37/incendiary)
	cost = 55

/datum/supply_packs/stationary/ags_flare
	name = "AGLS-37自动榴弹发射器照明榴弹"
	contains = list(/obj/item/ammo_magazine/agls37/flare)
	cost = 35

/datum/supply_packs/stationary/ags_cloak
	name = "AGLS-37自动榴弹发射器隐形榴弹"
	contains = list(/obj/item/ammo_magazine/agls37/cloak)
	cost = 45

/datum/supply_packs/stationary/ags_tanglefoot
	name = "AGLS-37自动榴弹发射器绊足榴弹"
	contains = list(/obj/item/ammo_magazine/agls37/tanglefoot)
	cost = 85

/datum/supply_packs/stationary/antitankgun
	name = "AT-36反坦克炮"
	contains = list(/obj/item/weapon/gun/at36)
	cost = 800

/datum/supply_packs/stationary/antitankgunammo
	name = "AT-36反坦克炮穿甲高爆弹 (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36,
		/obj/item/ammo_magazine/at36,
		/obj/item/ammo_magazine/at36,
	)
	cost = 20

/datum/supply_packs/stationary/antitankgunammo/apcr
	name = "AT-36反坦克炮硬芯穿甲弹 (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/apcr,
		/obj/item/ammo_magazine/at36/apcr,
		/obj/item/ammo_magazine/at36/apcr,
	)
	cost = 20

/datum/supply_packs/stationary/antitankgunammo/he
	name = "AT-36反坦克炮高爆弹 (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/he,
		/obj/item/ammo_magazine/at36/he,
		/obj/item/ammo_magazine/at36/he,
	)
	cost = 20

/datum/supply_packs/stationary/antitankgunammo/beehive
	name = "AT-36反坦克炮蜂巢弹 (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/beehive,
		/obj/item/ammo_magazine/at36/beehive,
		/obj/item/ammo_magazine/at36/beehive,
	)
	cost = 20

/datum/supply_packs/stationary/antitankgunammo/incendiary
	name = "AT-36反坦克炮凝固汽油弹 (x3)"
	contains = list(
		/obj/item/ammo_magazine/at36/incend,
		/obj/item/ammo_magazine/at36/incend,
		/obj/item/ammo_magazine/at36/incend,
	)
	cost = 20

/datum/supply_packs/stationary/fk88
	name = "FK-88防空炮"
	contains = list(/obj/item/weapon/gun/fk88)
	cost = 1000

/datum/supply_packs/stationary/fk88_he
	name = "FK-88防空炮高爆弹"
	contains = list(/obj/item/ammo_magazine/fk88/he)
	cost = 50

/datum/supply_packs/stationary/fk88_he_unguided
	name = "FK-88防空炮无制导高爆弹"
	contains = list(/obj/item/ammo_magazine/fk88/he/unguided)
	cost = 50

/datum/supply_packs/stationary/fk88_sabot
	name = "FK-88防空炮尾翼稳定脱壳穿甲弹"
	contains = list(/obj/item/ammo_magazine/fk88/sabot)
	cost = 60

/datum/supply_packs/stationary/heayvlaser_emplacement
	name = "TE-9001重型激光炮架"
	contains = list(/obj/item/weapon/gun/energy/lasgun/lasrifle/heavy_laser/deployable)
	cost = 800

/datum/supply_packs/stationary/heayvlaser_ammo
	name = "TE-9001 车载重型激光弹药 (x1)"
	contains = list(/obj/item/cell/lasgun/heavy_laser)
	cost = 15

/datum/supply_packs/stationary/mg27
	name = "MG-27 中型机枪"
	contains = list(/obj/item/weapon/gun/mg27)
	cost = 100

/datum/supply_packs/stationary/hmg08
	name = "HMG-08 重型机枪"
	contains = list(/obj/item/weapon/gun/hmg08)
	cost = 400

/datum/supply_packs/stationary/hmg08_ammo
	name = "HMG-08 重型机枪弹鼓"
	contains = list(/obj/item/ammo_magazine/hmg08)
	cost = 70

/datum/supply_packs/stationary/hmg08_ammo_small
	name = "HMG-08 重型机枪弹匣"
	contains = list(/obj/item/ammo_magazine/hmg08/small)
	cost = 40
