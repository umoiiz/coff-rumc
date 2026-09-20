/datum/outfit/quick/beginner/marine
	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/russian_red = 2,
	)

/datum/outfit/quick/beginner/marine/rifleman
	name = "Rifleman"
	desc = "海军陆战队的典型步枪兵. \
	手持AR-12, 一把多功能全能突击步枪, 附有强大的下挂式榴弹发射器. \
	还携带了强大的P-23副武器以及各种照明弹, 医疗设备等, 以应对各种情况."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/hodgrenades
	head = /obj/item/clothing/head/modular/m10x/hod
	w_uniform = /obj/item/clothing/under/marine/holster
	suit_store = /obj/item/weapon/gun/rifle/ar12/medic
	l_hand = /obj/item/paper/tutorial/beginner_rifleman

	backpack_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/ammo_magazine/packet/p10x24mm = 3,
	)

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/ar12 = 6,
	)

	webbing_contents = list(
		/obj/item/ammo_magazine/pistol/p23 = 3,
		/obj/item/weapon/gun/pistol/p23/beginner = 1,
	)

	suit_contents = list(
		/obj/item/explosive/grenade = 6,
	)

/datum/outfit/quick/beginner/marine/machinegunner
	name = "Machinegunner"
	desc = "压制火力之王. 使用MG-60, 一把附有双脚架的200发全自动机枪. \
	擅长封锁大片区域并消灭那些拒绝离开的敌人."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/heavy/tyr_onegeneral
	head = /obj/item/clothing/head/modular/m10x/tyr
	w_uniform = /obj/item/clothing/under/marine/black_vest
	back = /obj/item/storage/backpack/marine/standard
	belt = /obj/item/storage/belt/sparepouch
	suit_store = /obj/item/weapon/gun/rifle/mg60/beginner
	mask = /obj/item/clothing/mask/rebreather
	l_hand = /obj/item/paper/tutorial/beginner_machinegunner

	backpack_contents = list(
		/obj/item/ammo_magazine/mg60 = 8,
	)
	belt_contents = list(
		/obj/item/ammo_magazine/mg60 = 3,\
	)
	webbing_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/storage/box/m94 = 2,
	)
	suit_contents = list(
		/obj/item/weapon/gun/pistol/plasma_pistol = 1,
		/obj/item/tool/extinguisher = 1,
	)

/datum/outfit/quick/beginner/marine/marksman
	name = "Marksman"
	desc = "质量胜于数量. 配备了DMR-37, 一把附有瞄准镜的精准远程指定射手步枪. \
	虽然在近距离表现不佳, 但DMR的精准度无与伦比, 擅长从远处消灭威胁."

	wear_suit = /obj/item/clothing/suit/modular/xenonauten/lightmedical
	head = /obj/item/clothing/head/modular/m10x/tyr
	w_uniform = /obj/item/clothing/under/marine/holster
	belt = /obj/item/belt_harness/marine
	l_pocket = /obj/item/storage/pouch/magazine/large
	r_pocket = /obj/item/storage/pouch/magazine/large
	suit_store = /obj/item/weapon/gun/rifle/dmr37/beginner
	mask = /obj/item/clothing/mask/breath
	l_hand = /obj/item/paper/tutorial/beginner_marksman

	backpack_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/ammo_magazine/packet/p10x27mm = 3,
	)
	l_pocket_contents = list(
		/obj/item/ammo_magazine/rifle/dmr37 = 6,
	)

	webbing_contents = list(
		/obj/item/ammo_magazine/pistol/vp70 = 3,
		/obj/item/weapon/gun/pistol/vp70/beginner = 1,
	)

	suit_contents = list(
		/obj/item/storage/pill_bottle/bicaridine = 1,
		/obj/item/storage/pill_bottle/kelotane = 1,
		/obj/item/storage/pill_bottle/tricordrazine = 1,
		/obj/item/storage/pill_bottle/tramadol = 1,
		/obj/item/storage/pill_bottle/dylovene = 1,
	)

/datum/outfit/quick/beginner/marine/shotgunner
	name = "Shotgunner"
	desc = "近距离贴身作战. 手持SH-39, 一把装有独头弹的半自动霰弹枪. \
	在中近距离绝对是怪物, 霰弹枪会对任何被击中的目标造成大量伤害, 并短暂眩晕, 使其踉跄, 并将其击退."

	w_uniform = /obj/item/clothing/under/marine/holster
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/lightgeneral
	suit_store = /obj/item/weapon/gun/shotgun/combat/standardmarine/beginner
	belt = /obj/item/storage/belt/shotgun
	head = /obj/item/clothing/head/modular/m10x/freyr
	gloves = /obj/item/clothing/gloves/marine/fingerless
	mask = /obj/item/clothing/mask/gas/tactical/coif
	l_hand = /obj/item/paper/tutorial/beginner_shotgunner

	backpack_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/ammo_magazine/shotgun = 2,
		/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline = 1,
	)

	belt_contents = list(
		/obj/item/ammo_magazine/handful/slug = 14,
	)

	webbing_contents = list(
		/obj/item/ammo_magazine/pistol/plasma_pistol = 3,
		/obj/item/weapon/gun/pistol/plasma_pistol/beginner = 1,
	)
	suit_contents = list(
		/obj/item/storage/box/m94 = 2,
	)

/datum/outfit/quick/beginner/marine/shocktrooper
	name = "Shocktrooper"
	desc = "部队的最前沿. \
	配备了实验性电池供能激光步枪, 具有四种可自由切换的不同模式, 并附有下挂式火焰喷射器用于区域封锁和清理迷宫."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle/medic
	belt = /obj/item/storage/belt/marine/te_cells
	glasses = /obj/item/clothing/glasses/sunglasses/fake/big
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/lightgeneral
	head = /obj/item/clothing/head/modular/m10x/freyr
	mask = /obj/item/clothing/mask/gas/tactical/coif
	r_pocket = /obj/item/cell/lasgun/volkite/powerpack/marine
	w_uniform = /obj/item/clothing/under/marine/corpman_vest
	l_hand = /obj/item/paper/tutorial/beginner_shocktrooper

	backpack_contents = list(
		/obj/item/ammo_magazine/flamer_tank/mini = 5,
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
	)

	suit_contents = list(
		/obj/item/cell/lasgun/volkite/powerpack/marine = 1,
		/obj/item/storage/box/m94 = 1,
	)

	webbing_contents = list(
		/obj/item/storage/pill_bottle/bicaridine = 1,
		/obj/item/storage/pill_bottle/kelotane = 1,
		/obj/item/storage/pill_bottle/tricordrazine = 1,
		/obj/item/storage/pill_bottle/tramadol = 1,
		/obj/item/storage/pill_bottle/dylovene = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline = 1,
	)

/datum/outfit/quick/beginner/marine/hazmat
	name = "Hazmat"
	desc = "为危险而设计. \
	手持Type 71 'GROZA', 一把强大但不精准的突击步枪, 可发射自动点射. \
	穿着密米尔战斗装甲, 使用户免疫许多异形所拥有的危险毒气."

	head = /obj/item/clothing/head/modular/m10x/mimir
	suit_store = /obj/item/weapon/gun/rifle/type71/beginner
	w_uniform = /obj/item/clothing/under/marine/black_vest
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/mimir
	mask = /obj/item/clothing/mask/rebreather/scarf
	l_hand = /obj/item/paper/tutorial/beginner_hazmat

	backpack_contents = list(
		/obj/item/ammo_magazine/packet/rifle762x39 = 3,
		/obj/item/explosive/grenade/m15 = 3,
	)

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/type71 = 6,
	)

	webbing_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/storage/box/m94 = 2,
	)

	suit_contents = list(
		/obj/item/weapon/gun/pistol/plasma_pistol = 1,
		/obj/item/tool/extinguisher = 1,
	)

/datum/outfit/quick/beginner/marine/cqc
	name = "CQC"
	desc = "迅捷而致命. \
	配备了AR-18, 一把带有快速连发模式的轻型卡宾枪. 为最大机动性而设计, 士兵能够冲入, 突袭敌人, 并在他们反应过来之前撤退."

	suit_store = /obj/item/weapon/gun/rifle/ar18/beginner
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/lightgeneral
	w_uniform = /obj/item/clothing/under/marine/black_vest
	head = /obj/item/clothing/head/modular/m10x/freyr
	glasses = /obj/item/clothing/glasses/mgoggles
	l_hand = /obj/item/paper/tutorial/beginner_cqc
	belt_contents = list(
		/obj/item/ammo_magazine/rifle/ar18 = 6,
	)
	backpack_contents = list(
		/obj/item/ammo_magazine/packet/p10x24mm = 3,
		/obj/item/explosive/grenade/m15 = 3,
	)
	suit_contents = list(
		/obj/item/weapon/gun/pistol/plasma_pistol = 1,
		/obj/item/tool/extinguisher = 1,
	)
	webbing_contents = list(
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/storage/box/m94 = 2,
	)
