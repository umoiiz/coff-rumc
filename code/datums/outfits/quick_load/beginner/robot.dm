/datum/outfit/quick/beginner/robot
	jobtype = SQUAD_ROBOT

	w_uniform = /obj/item/clothing/under/marine/robotic/black_vest
	shoes = null
	wear_suit = /obj/item/clothing/suit/modular/robot
	gloves = null
	mask = null
	head = /obj/item/clothing/head/modular/robot
	r_pocket = /obj/item/storage/pouch/tools/full

	webbing_contents = list(
		/obj/item/tool/surgery/solderingtool = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/tool/weldingtool = 1,
		/obj/item/storage/box/m94 = 2,
	)
	head_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline = 2,
	)
	shoe_contents = null

/datum/outfit/quick/beginner/robot/laser_rifle
	name = "Laser Rifleman"
	desc = "典型的机器人步枪兵. 使用激光步枪, 常被海军陆战队员称为TE-M. 具有多种射击模式以实现战术灵活性. 使用标准的泰拉实验型(缩写为TE)能量电池. \
	与所有TE激光武器一样, 它们使用轻质合金制造, 不再需要子弹, 这使其重量和瞄准速度相比弹道武器有了相当大的提升."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_rifle/medic
	belt = /obj/item/storage/belt/marine
	head = /obj/item/clothing/head/modular/robot/motion_detector
	wear_suit = /obj/item/clothing/suit/modular/robot/svalinn
	l_hand = /obj/item/paper/tutorial/robot_laser_rifleman

	belt_contents = list(
		/obj/item/cell/lasgun/lasrifle = 6,
	)

	backpack_contents = list(
		/obj/item/ammo_magazine/flamer_tank/mini = 6,
		/obj/item/weapon/powerfist/full = 1,
	)

	suit_contents = list(
		/obj/item/cell/lasgun/volkite/powerpack/marine = 1,
	)

/datum/outfit/quick/beginner/robot/laser_machinegunner
	name = "Laser Machinegunner"
	desc = "压制火力之王. 使用激光机枪, 常被海军陆战队员称为TE-M. 高效调制器确保TE-M具有极高的射击计数, 多种射击模式使其成为灵活的步兵支援枪. 使用标准的泰拉实验型(缩写为TE)能量电池. \
	与所有TE激光武器一样, 它们使用轻质合金制造, 不再需要子弹, 这使其重量和瞄准速度相比弹道武器有了相当大的提升."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_mlaser/beginner
	back = /obj/item/cell/lasgun/volkite/powerpack/marine_back
	belt = /obj/item/belt_harness/marine
	head = /obj/item/clothing/head/modular/robot/heavy/tyr
	wear_suit = /obj/item/clothing/suit/modular/robot/heavy/tyr_onegeneral
	l_hand = /obj/item/paper/tutorial/robot_laser_machinegunner

	suit_contents = list(
		/obj/item/cell/lasgun/lasrifle = 1,
		/obj/item/weapon/powerfist/full = 1,
	)

/datum/outfit/quick/beginner/robot/laser_sniper
	name = "Laser Sniper"
	desc = "压制火力之王. 使用激光狙击步枪, 它具有集成的充能选择器, 可设置普通, 加热和过载模式. 使用标准的泰拉实验型(缩写为TE)能量电池. \
	与所有TE激光武器一样, 它们使用轻质合金制造, 不再需要子弹, 这使其重量和瞄准速度相比弹道武器有了相当大的提升."

	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_sniper/beginner
	back = /obj/item/cell/lasgun/volkite/powerpack/marine_back
	belt = /obj/item/storage/holster/belt/pistol/laser
	head = /obj/item/clothing/head/modular/robot/light/motion_detector
	wear_suit = /obj/item/clothing/suit/modular/robot/light/baldur_general
	l_hand = /obj/item/paper/tutorial/robot_laser_sniper

	suit_contents = list(
		/obj/item/cell/lasgun/lasrifle = 1,
		/obj/item/weapon/powerfist/full = 1,
	)
