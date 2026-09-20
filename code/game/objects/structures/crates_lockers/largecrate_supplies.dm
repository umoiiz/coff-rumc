/*SPAWNING LANDMARKS*/
//Check below to see what the crates contain, these landmarks will spawn in a bunch of crates at once, to make it easy to spawn in supplies.
/obj/effect/landmark/supplyspawner
	name = "supply spawner"
	var/list/supply = list()

/obj/effect/landmark/supplyspawner/Initialize(mapload)
	. = ..()
	if(/turf/open in range(1))
		var/list/T = list()
		for(var/turf/open/O in range(1))
			T += O
		if(length(supply))
			for(var/s in supply)
				var/amount = supply[s]
				for(var/i = 1, i <= amount, i++)
					new s (pick(T))
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/supplyspawner/weapons
	name = "weapon supplies"
	supply = list(
		/obj/structure/largecrate/supply/weapons/ar18 = 2,
		/obj/structure/largecrate/supply/weapons/shotgun = 2,
		/obj/structure/largecrate/supply/weapons/smg90 = 2,
		/obj/structure/largecrate/supply/weapons/pistols = 2,
		/obj/structure/largecrate/supply/weapons/flamers = 2,
		/obj/structure/largecrate/supply/weapons/hpr = 2,
		/obj/structure/closet/crate/mortar_ammo/mortar_kit = 1,
		/obj/structure/largecrate/supply/explosives/mines = 2,
		/obj/structure/largecrate/supply/explosives/grenades = 2,
	)

/obj/effect/landmark/supplyspawner/ammo
	name = "ammunition supplies"
	supply = list(
		/obj/structure/largecrate/supply/ammo/m41a = 4,
		/obj/structure/largecrate/supply/ammo/shotgun = 4,
		/obj/structure/largecrate/supply/ammo/smg90 = 4,
		/obj/structure/largecrate/supply/ammo/pistol = 4,
	)

/obj/effect/landmark/supplyspawner/engineering
	name = "engineering supplies"
	supply = list(
		/obj/structure/largecrate/supply/supplies/metal = 5,
		/obj/structure/largecrate/supply/supplies/plasteel = 3,
		/obj/structure/largecrate/supply/supplies/sandbags = 5,
		/obj/structure/largecrate/supply/generator = 1,
		/obj/structure/largecrate/supply/floodlights = 2,
		/obj/structure/largecrate/supply/supplies/flares = 3,
		/obj/structure/largecrate/supply/powerloader = 1,
	)

/obj/effect/landmark/supplyspawner/turrets
	name = "defensive gun emplacement supplies"
	supply = list(
		/obj/structure/largecrate/supply/weapons/sentries = 2,
		/obj/structure/largecrate/supply/weapons/standard_hmg = 2,
		/obj/structure/largecrate/supply/ammo/sentry = 1,
		/obj/structure/largecrate/supply/ammo/standard_hmg = 1,
	)

/obj/effect/landmark/supplyspawner/food
	name = "food crate supplies"
	supply = list(/obj/structure/largecrate/supply/supplies/mre = 3, /obj/structure/largecrate/supply/supplies/water = 2)

/obj/effect/landmark/supplyspawner/medical
	name = "medical supplies"
	supply = list(
		/obj/structure/largecrate/supply/medicine/medkits = 2,
		/obj/structure/largecrate/supply/medicine/blood = 2,
		/obj/structure/largecrate/supply/medicine/iv = 2,
		/obj/structure/largecrate/supply/medicine/medivend = 2,
		/obj/structure/largecrate/machine/autodoc = 3,
		/obj/structure/largecrate/machine/bodyscanner = 1,
		/obj/structure/largecrate/machine/sleeper = 2,
		/obj/structure/largecrate/supply/medicine/optable = 1,
		/obj/structure/largecrate/supply/supplies/tables_racks = 1,
	)
/*NEW SUPPLY CRATES*/
//Lotsocrates for lotsosupplies for events, meaning less setup time.
//Wooden crates and not metal ones so we don't have a ton of metal crates laying around
//SHOULD contain everything needed for events. Should.

/obj/structure/largecrate/supply
	name = "补给箱"
	var/list/supplies = list()

/obj/structure/largecrate/supply/Initialize(mapload)
	. = ..()
	if(length(supplies))
		for(var/s in supplies)
			var/amount = supplies[s]
			for(var/i = 1, i <= amount, i++)
				new s (src)

/obj/structure/largecrate/supply/weapons
	name = "武器柜"
	icon_state = "chest"

/obj/structure/largecrate/supply/weapons/ar18
	name = "\improper AR-18卡宾枪武器柜 (x10)"
	desc = "一个装有十把AR-18卡宾枪的武器柜."
	supplies = list(/obj/item/weapon/gun/rifle/ar18 = 10)

/obj/structure/largecrate/supply/weapons/shotgun
	name = "\improper SH-35泵动霰弹枪武器柜 (x10)"
	desc = "一个装有十把SH-35泵动霰弹枪的武器柜."
	supplies = list(/obj/item/weapon/gun/shotgun/pump/t35 = 10)

/obj/structure/largecrate/supply/weapons/smg90
	name = "\improper SMG-90冲锋枪武器柜 (x8)"
	desc = "一个装有八把SMG-90冲锋枪的武器柜."
	supplies = list(/obj/item/weapon/gun/smg/smg90 = 8)

/obj/structure/largecrate/supply/weapons/pistols
	name = "副武器柜 (x20)"
	desc = "一个装有八把R-44左轮手枪和十二把P-14制式手枪的武器柜."
	supplies = list(/obj/item/weapon/gun/revolver/r44 = 6, /obj/item/weapon/gun/pistol/p14 = 12)

/obj/structure/largecrate/supply/weapons/flamers
	name = "\improper FL-240焚烧器武器柜 (x4)"
	desc = "一个装有四台FL-240焚烧器装置的武器柜."
	supplies = list(/obj/item/weapon/gun/flamer/big_flamer = 4)

/obj/structure/largecrate/supply/weapons/hpr
	name = "\improper MG-42轻机枪武器柜 (x2)"
	desc = "一个装有两挺MG-42轻机枪的武器柜."
	supplies = list(/obj/item/weapon/gun/rifle/mg42 = 2)

/obj/structure/largecrate/supply/weapons/sentries
	name = "\improper ST-571哨戒炮箱 (x2)"
	desc = "一个装有两只盒装ST-571哨戒炮的补给箱."
	supplies = list(/obj/item/storage/box/crate/sentry = 2)

/obj/structure/largecrate/supply/weapons/standard_hmg
	name = "\improper HSG-102固定式重型智能枪箱 (x2)"
	desc = "一个装有两只盒装HSG-102固定式重型智能枪的补给箱."
	supplies = list(/obj/item/storage/box/hsg102 = 2)

/obj/structure/largecrate/supply/weapons/at36
	name = "\improper AT-36反坦克炮及弹药箱 (x1, x10)"
	desc = "一个装有AT-36和全套弹药以装填至侧炮位的补给箱."
	supplies = list(
		/obj/item/weapon/gun/at36 = 1,
		/obj/item/ammo_magazine/at36 = 4,
		/obj/item/ammo_magazine/at36/apcr = 3,
		/obj/item/ammo_magazine/at36/he = 3,
	)

/obj/structure/largecrate/supply/weapons/atr22
	name = "\improper ATR-22高射炮及弹药箱 (x1, x6)"
	desc = "一个装有ATR-22和全套弹药以装填至侧炮位的补给箱."
	supplies = list(
		/obj/item/weapon/gun/atr22 = 1,
		/obj/item/ammo_magazine/atr22 = 3,
		/obj/item/ammo_magazine/atr22/flak = 3,
	)

/obj/structure/largecrate/supply/weapons/fk88
	name = "\improper FK-88 安装式高射炮 (x1)"
	desc = "装有 FK-88 安装式高射炮的补给箱. 弹药另售."
	supplies = list(/obj/item/weapon/gun/fk88 = 1)

/obj/structure/largecrate/supply/ammo
	name = "弹药箱"
	icon_state = "case"

/obj/structure/largecrate/supply/ammo/m41a
	name = "\improper PR-412 弹匣箱 (x20)"
	desc = "装有 20 个 PR-412 弹匣的弹药箱."
	supplies = list(/obj/item/ammo_magazine/rifle = 20)

/obj/structure/largecrate/supply/ammo/shotgun
	name = "12 号口径弹药箱 (x20)"
	desc = "装有八盒独头弹, 八盒鹿弹和八盒箭形弹的弹药箱."
	supplies = list(/obj/item/ammo_magazine/shotgun = 8, /obj/item/ammo_magazine/shotgun/buckshot = 8, /obj/item/ammo_magazine/shotgun/flechette = 8)

/obj/structure/largecrate/supply/ammo/smg90
	name = "\improper SMG-90 弹匣箱 (x16)"
	desc = "装有十六个 SMG-90 弹匣的弹药箱."
	supplies = list(/obj/item/ammo_magazine/smg/smg90 = 16)

/obj/structure/largecrate/supply/ammo/pistol
	name = "副武器弹药箱 (x40)"
	desc = "装有十六个 R-44 快速装弹器和二十四个 P-14 弹匣的弹药箱."
	supplies = list(/obj/item/ammo_magazine/revolver/r44 = 16, /obj/item/ammo_magazine/pistol/p14 = 24)

/obj/structure/largecrate/supply/ammo/sentry
	name = "\improper ST-571 弹药鼓箱 (x6)"
	desc = "装有六个 ST-571 哨戒炮弹药鼓的弹药箱."
	supplies = list(/obj/item/ammo_magazine/sentry = 6)

/obj/structure/largecrate/supply/ammo/standard_hmg
	name = "\improper HSG-102 弹药盒箱 (x6)"
	desc = "装有六个 HSG-102 弹药盒的弹药箱."
	supplies = list(/obj/item/ammo_magazine/hsg102 = 6)

/obj/structure/largecrate/supply/ammo/standard_ammo
	name = "大型盈余弹药箱"
	desc = "装有每种 TGMC 品牌弹药各一盒的弹药箱."
	icon_state = "chest"
	supplies = list(
		/obj/item/shotgunbox = 1,
		/obj/item/shotgunbox/buckshot = 1,
		/obj/item/shotgunbox/flechette = 1,
		/obj/item/shotgunbox/tracker = 1,
		/obj/item/shotgunbox/blank = -1,
		/obj/item/storage/box/visual/magazine/compact/p14/full = 1,
		/obj/item/storage/box/visual/magazine/compact/p23/full = 1,
		/obj/item/storage/box/visual/magazine/compact/r44/full = 1,
		/obj/item/storage/box/visual/magazine/compact/p17/full = 1,
		/obj/item/storage/box/visual/magazine/compact/vp70/full = 1,
		/obj/item/storage/box/visual/magazine/compact/plasma_pistol/full = 1,
		/obj/item/storage/box/visual/magazine/compact/ar12/full = 1,
		/obj/item/storage/box/visual/magazine/compact/lasrifle/marine/full = 1,
		/obj/item/storage/box/visual/magazine/compact/sh15/flechette/full = 1,
		/obj/item/storage/box/visual/magazine/compact/sh15/slug/full = 1,
		/obj/item/storage/box/visual/magazine/compact/dmr37/full = 1,
		/obj/item/storage/box/visual/magazine/compact/br64/full = 1,
		/obj/item/storage/box/visual/magazine/compact/sr127/full = 1,
		/obj/item/storage/box/visual/magazine/compact/mg42/full = 1,
		/obj/item/storage/box/visual/magazine/compact/mg60/full = 1,
		/obj/item/storage/box/visual/magazine/compact/mg27/full = 1,
	)

/obj/structure/largecrate/supply/explosives
	name = "爆炸物补给箱"
	desc = "装有爆炸物的箱子."
	icon_state = "case_double"

/obj/structure/largecrate/supply/explosives/mines
	name = "\improper M20 阔剑地雷箱 (x20)"
	desc = "装有五盒四枚装 M20 阔剑地雷的箱子."
	supplies = list(/obj/item/storage/box/explosive_mines = 5)

/obj/structure/largecrate/supply/explosives/grenades
	name = "\improper M40 HEDP 手榴弹箱 (x50)"
	desc = "装有两盒二十五枚装 M40 HDEP 手榴弹的箱子."
	supplies = list(/obj/item/storage/box/visual/grenade/frag = 2)

/obj/structure/largecrate/supply/explosives/mortar_he
	name = "80mm 高爆迫击炮弹箱 (x25)"
	desc = "装有二十五枚 80mm 高爆迫击炮弹的箱子."
	supplies = list(/obj/item/mortal_shell/he = 25)

/obj/structure/largecrate/supply/explosives/mortar_incend
	name = "80mm 燃烧迫击炮弹箱 (x25)"
	desc = "装有二十五枚 80mm 燃烧迫击炮弹的箱子."
	supplies = list(/obj/item/mortal_shell/incendiary = 25)

/obj/structure/largecrate/supply/explosives/mortar_flare
	name = "80mm 照明迫击炮弹箱 (x25)"
	desc = "装有二十五枚 80mm 照明迫击炮弹的箱子."
	supplies = list(/obj/item/mortal_shell/flare = 25)

/obj/structure/largecrate/supply/explosives/disposable
	name = "\improper RL-72 一次性火箭筒箱 (x8)"
	desc = "装有八具 RL-72 一次性火箭筒的箱子."
	supplies = list(/obj/item/weapon/gun/launcher/rocket/oneuse = 8)

/obj/structure/largecrate/supply/supplies
	name = "补给箱"
	icon_state = "secure_crate"

/obj/structure/largecrate/supply/supplies/flares
	name = "照明弹补给箱 (x100)"
	desc = "装有二十盒五枚装照明弹的补给箱."
	supplies = list(/obj/item/storage/box/m94 = 10)

/obj/structure/largecrate/supply/supplies/coifs
	name = "吸热头巾补给箱 (x25)"
	desc = "装有二十五条吸热头巾的补给箱."
	supplies = list(/obj/item/clothing/mask/rebreather/scarf = 25)

/obj/structure/largecrate/supply/supplies/metal
	name = "金属板补给箱 (x200)"
	desc = "装有四堆五十张金属板的补给箱."
	supplies = list(/obj/item/stack/sheet/metal/large_stack = 4)

/obj/structure/largecrate/supply/supplies/plasteel
	name = "塑钢补给箱 (x60)"
	desc = "装有两堆三十张塑钢板的补给箱."
	supplies = list(/obj/item/stack/sheet/plasteel/medium_stack = 2)

/obj/structure/largecrate/supply/supplies/sandbags
	name = "沙袋补给箱 (x100)"
	desc = "装有四堆二十五只沙袋的补给箱."
	supplies = list(/obj/item/stack/sandbags/large_stack = 4)

/obj/structure/largecrate/supply/supplies/tables_racks
	name = "储物方案箱 (x10, x10)"
	desc = "装有十个桌子部件和十个货架部件, 便于快速搭建储物的箱子."
	supplies = list(/obj/item/frame/table = 10, /obj/item/frame/rack = 10)

/obj/structure/largecrate/supply/supplies/mre
	name = "\improper TGMC 口粮箱 (x50)"
	desc = "装有五十包 TGMC 口粮的补给箱."
	supplies = list(/obj/item/storage/box/mre = 50)

/obj/structure/largecrate/supply/supplies/water
	name = "\improper NT 瓶装水箱 (x50)"
	desc = "装有五十瓶 Nanotrasen 瓶装泉水的箱子."
	supplies = list(/obj/item/reagent_containers/food/drinks/cans/waterbottle = 50)

/obj/structure/largecrate/supply/powerloader
	name = "\improper 卡特彼勒 P-5000 动力装载机箱"
	desc = "装有一台折叠但已完全组装好的卡特彼勒 P-5000 动力装载机的箱子."
	supplies = list(/obj/vehicle/ridden/powerloader = 1)

/obj/structure/largecrate/supply/floodlights
	name = "泛光灯箱 (x4)"
	desc = "装有四盏泛光灯的箱子."
	supplies = list(/obj/machinery/floodlight = 4)

/obj/structure/largecrate/supply/generator
	name = "\improper P.A.C.M.A.N. 箱"
	desc = "装有一台 P.A.C.M.A.N. 发电机, 一些燃料和一些电缆线圈, 让你的电力运转起来的箱子."
	supplies = list(/obj/machinery/power/port_gen/pacman = 1, /obj/item/stack/sheet/mineral/phoron/medium_stack = 1, /obj/item/stack/cable_coil = 3)

/obj/structure/largecrate/supply/medicine
	name = "医疗箱"
	desc = "装有医疗用品的箱子."
	icon_state = "chest_white"

/obj/structure/largecrate/supply/medicine/medkits
	name = "急救补给箱 (x20)"
	desc = "装有六个高级, 三个标准, 三个烧伤, 两个毒素, 两个氧气和两个辐射急救包的医疗补给箱."
	supplies = list(
		/obj/item/storage/firstaid/regular = 3,
		/obj/item/storage/firstaid/fire = 3,
		/obj/item/storage/firstaid/adv = 6,
		/obj/item/storage/firstaid/toxin = 2,
		/obj/item/storage/firstaid/o2 = 2,
		/obj/item/storage/firstaid/rad = 2,
	)

/obj/structure/largecrate/supply/medicine/blood
	name = "血液补给箱 (x12)"
	desc = "装有十二袋 O 型阴性血的医疗补给箱."
	supplies = list(/obj/item/reagent_containers/blood/OMinus = 12)

/obj/structure/largecrate/supply/medicine/iv
	name = "\improper 输液架箱 (x3)"
	desc = "装有三个输液器的医疗补给箱."
	supplies = list(/obj/machinery/iv_drip = 3)

/obj/structure/largecrate/supply/medicine/optable
	name = "医疗手术箱 (x1)"
	desc = "装有一张手术台, 两罐麻醉剂, 一套手术工具, 一些麻醉注射器和一些空间清洁剂的箱子."
	supplies = list(/obj/machinery/optable = 1, /obj/item/storage/surgical_tray = 1, /obj/item/tank/anesthetic = 2, /obj/item/reagent_containers/spray/cleaner = 1)

/obj/structure/largecrate/supply/medicine/medivend
	name = "\improper NanotrasenMed Plus 箱 (x1)"
	desc = "装有一台 Nanotrasen Plus 医疗售货机的箱子."
	supplies = list(/obj/machinery/vending/medical = 1)

/obj/structure/largecrate/machine
	name = "机器箱"
	desc = "装有预组装机器的箱子."
	icon_state = "secure_crate_strapped"
	/// If set to anything but 0, will check that space before spawning in.
	var/dir_needed = EAST
	/// If set to 1, then on examine, the user will see a warning that states the contents cannot be moved after opened.
	var/unmovable = 1

/obj/structure/largecrate/machine/examine(mob/user)
	. = ..()
	if(unmovable)
		. += "<b>!!WARNING!! CONTENTS OF CRATE UNABLE TO BE MOVED ONCE UNPACKAGED!</b>"

/obj/structure/largecrate/machine/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(!dir_needed)
		return
	var/turf/next_turf = get_step(src, dir_needed)
	if(next_turf.density)
		to_chat(user, span_warning("你不能在这里打开箱子, 空间不够!"))
		return
	for(var/atom/movable/AM in next_turf.contents)
		if(AM.density)
			to_chat(user, span_warning("你不能在这里打开箱子, [AM] 挡住了去路."))

/obj/structure/largecrate/machine/autodoc
	name = "自动医生机器箱 (x1)"
	desc = "装有一台自动医生的箱子."

/obj/structure/largecrate/machine/autodoc/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	var/turf/T = get_turf(loc)
	if(!isopenturf(T))
		return
	var/obj/machinery/autodoc/event/E = new (T)
	var/obj/machinery/computer/autodoc_console/C = new (T)
	C.loc = get_step(T, EAST)
	E.connected = C
	C.connected = E

/obj/structure/largecrate/machine/bodyscanner
	name = "身体扫描仪机器箱 (x1)"
	desc = "装有一台医疗身体扫描仪的箱子."

/obj/structure/largecrate/supply/machine/bodyscanner/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	var/turf/T = get_turf(loc)
	if(!isopenturf(T))
		return
	var/obj/machinery/bodyscanner/E = new (T)
	var/obj/machinery/computer/body_scanconsole/C = new (T)
	C.loc = get_step(T, EAST)
	C.connected = E

/obj/structure/largecrate/machine/sleeper
	name = "睡眠舱机器箱 (x1)"
	desc = "一个装有医疗休眠舱的箱子."

/obj/structure/largecrate/machine/sleeper/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	var/turf/T = get_turf(loc)
	if(!isopenturf(T))
		return
	var/obj/machinery/sleeper/E = new (T)
	var/obj/machinery/computer/sleep_console/C = new (T)
	C.loc = get_step(T, EAST)
	E.connected = C
	C.connected = E
