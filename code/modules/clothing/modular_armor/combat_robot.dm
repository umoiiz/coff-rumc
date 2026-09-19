//Robot armour
/obj/item/clothing/suit/modular/robot
	name = "XR-1装甲板"
	desc = "中型装甲板,设计用于自行安装到TerraGov战斗机器人上.它带有自密封螺栓,用于安装到机器人内部."

	worn_icon_list = list(slot_wear_suit_str = 'icons/mob/modular/robot_armor.dmi')
	icon_state = "chest"
	worn_icon_state = "chest"
	species_exception = list(/datum/species/robot)
	soft_armor = MARINE_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_MEDIUM

	colorable_colors = ARMOR_PALETTES_LIST
	colorable_allowed = PRESET_COLORS_ALLOWED
	greyscale_config = /datum/greyscale_config/robot
	greyscale_colors = ARMOR_PALETTE_DRAB

	allowed_uniform_type = /obj/item/clothing/under/marine/robotic

	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT

/obj/item/clothing/suit/modular/robot/generate_attachments_allowed()
	attachments_allowed = general_list_of_marine_modules.Copy()
	attachments_allowed -= list( // useless for robots modules
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/module/mimir_environment_protection,
		/obj/item/armor_module/module/mimir_environment_protection/mark1,
		/obj/item/armor_module/module/chemsystem,
	)

/obj/item/clothing/suit/modular/robot/mob_can_equip(mob/user, slot, warning = TRUE, override_nodrop = FALSE, bitslot = FALSE)
	. = ..()
	if(!isrobot(user))
		to_chat(user, span_warning("你无法装备这个,因为它需要在你身体上安装螺栓!"))
		return FALSE

//---- Medium armor with attachments
/obj/item/clothing/suit/modular/robot/hodgrenades
	starting_attachments = list(
		/obj/item/armor_module/module/ballistic_armor,
		/obj/item/armor_module/storage/grenade,
	)

/obj/item/clothing/suit/modular/robot/lightgeneral
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/robot/lightengineer
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/engineering,
	)

/obj/item/clothing/suit/modular/robot/lightinjector
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/injector,
	)

/obj/item/clothing/suit/modular/robot/svalinn
	starting_attachments = list(
		/obj/item/armor_module/module/eshield,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/robot/light
	name = "XR-1-L装甲板"
	desc = "轻型装甲板,设计用于自行安装到TerraGov战斗机器人上.它带有自密封螺栓,用于安装到机器人内部."
	soft_armor = MARINE_ARMOR_LIGHT
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	greyscale_config = /datum/greyscale_config/robot/light

//---- Light armor with attachments
/obj/item/clothing/suit/modular/robot/light/baldur_medical
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/medical,
	)

/obj/item/clothing/suit/modular/robot/light/baldur_general
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/robot/heavy
	name = "XR-1-H装甲板"
	desc = "重型装甲板,设计用于自行安装到TerraGov战斗机器人上.它带有自密封螺栓,用于安装到机器人内部."
	soft_armor = MARINE_ARMOR_HEAVY
	slowdown = SLOWDOWN_ARMOR_HEAVY
	greyscale_config = /datum/greyscale_config/robot/heavy

//---- Heavy armor with attachments
/obj/item/clothing/suit/modular/robot/heavy/tyr_onegeneral
	starting_attachments = list(
		/obj/item/armor_module/module/tyr_extra_armor/mark1,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/modular/robot/heavy/lightengineer
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/engineering,
	)

/obj/item/clothing/suit/modular/robot/heavy/tyr
	starting_attachments = list(
		/obj/item/armor_module/module/tyr_extra_armor,
		/obj/item/armor_module/storage/engineering,
	)

/obj/item/clothing/suit/modular/robot/heavy/shield
	starting_attachments = list(
		/obj/item/armor_module/module/eshield,
		/obj/item/armor_module/storage/engineering,
	)

//robot hats
/obj/item/clothing/head/modular/robot
	name = "XN-1上部装甲板"
	desc = "中型装甲板,设计用于自行安装到TerraGov战斗机器人的上半部分.它带有自密封螺栓,用于安装到机器人内部."
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	icon_state = "helmet"
	worn_icon_state = "helmet"
	species_exception = list(/datum/species/robot)
	item_map_variant_flags = (ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_PRISON_VARIANT)
	soft_armor = MARINE_ARMOR_HEAVY

	colorable_colors = ARMOR_PALETTES_LIST
	colorable_allowed = PRESET_COLORS_ALLOWED
	greyscale_config = /datum/greyscale_config/robot
	greyscale_colors = ARMOR_PALETTE_DRAB

	attachments_allowed = list(
		/obj/item/armor_module/module/tyr_head,
		/obj/item/armor_module/module/tyr_head/mark2,
		/obj/item/armor_module/module/fire_proof_helmet,
		/obj/item/armor_module/module/hod_head,
		/obj/item/armor_module/module/binoculars,
		/obj/item/armor_module/module/binoculars/artemis_mark_two,
		/obj/item/armor_module/module/artemis,
		/obj/item/armor_module/module/antenna,
		/obj/item/armor_module/module/night_vision,
		/obj/item/armor_module/module/motion_detector,
		/obj/item/armor_module/storage/helmet,
		/obj/item/armor_module/armor/badge,
		/obj/item/armor_module/armor/visor/marine/robot,
		/obj/item/armor_module/armor/visor/marine/robot/light,
		/obj/item/armor_module/armor/visor/marine/robot/heavy,
	)
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot)
	item_map_variant_flags = ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_DESERT_VARIANT

/obj/item/clothing/head/modular/robot/mob_can_equip(mob/user, slot, warning = TRUE, override_nodrop = FALSE, bitslot = FALSE)
	. = ..()
	if(!isrobot(user))
		to_chat(user, span_warning("你无法装备这个,因为它需要在你身体上安装螺栓!"))
		return FALSE

//---- Medium helmets with attachments
/obj/item/clothing/head/modular/robot/hod
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot, /obj/item/armor_module/module/hod_head)

/obj/item/clothing/head/modular/robot/antenna
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/heavy, /obj/item/armor_module/module/antenna)

/obj/item/clothing/head/modular/robot/motion_detector
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/heavy, /obj/item/armor_module/module/motion_detector)

/obj/item/clothing/head/modular/robot/light
	name = "XN-1-L上部装甲板"
	desc = "轻型装甲板,设计用于自行安装到TerraGov战斗机器人的上半部分.它带有自密封螺栓,用于安装到机器人内部."
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/light)
	soft_armor = MARINE_ARMOR_HEAVY
	greyscale_config = /datum/greyscale_config/robot/light

/obj/item/clothing/head/modular/robot/light/motion_detector
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/light, /obj/item/armor_module/module/motion_detector)

/obj/item/clothing/head/modular/robot/heavy
	name = "XN-1-H上部装甲板"
	desc = "重型装甲板,设计用于自行安装到TerraGov战斗机器人的上半部分.它带有自密封螺栓,用于安装到机器人内部."
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/heavy)
	soft_armor = MARINE_ARMOR_HEAVY
	greyscale_config = /datum/greyscale_config/robot/heavy

/obj/item/clothing/head/modular/robot/heavy/tyr
	starting_attachments = list(/obj/item/armor_module/storage/helmet, /obj/item/armor_module/armor/visor/marine/robot/heavy, /obj/item/armor_module/module/tyr_head)

/obj/item/clothing/head/helmet/marine/robot/advanced
	item_map_variant_flags = NONE
	icon = 'icons/obj/clothing/headwear/marine_helmets.dmi'
	worn_icon_list = list(
		slot_head_str = 'icons/mob/clothing/headwear/robot_helmets.dmi',
	)
	species_exception = list(/datum/species/robot)

/obj/item/clothing/head/helmet/marine/robot/advanced/mob_can_equip(mob/user, slot, warning = TRUE, override_nodrop = FALSE, bitslot = FALSE)
	. = ..()
	if(!isrobot(user))
		to_chat(user, span_warning("你无法装备这个,因为它需要在你身体上安装螺栓!"))
		return FALSE

/obj/item/clothing/suit/storage/marine/robot/advanced
	item_map_variant_flags = NONE
	icon = 'icons/obj/clothing/suits/marine_armor.dmi'
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/robot_armor.dmi',
	)
	species_exception = list(/datum/species/robot)

/obj/item/clothing/suit/storage/marine/robot/advanced/mob_can_equip(mob/user, slot, warning = TRUE, override_nodrop = FALSE, bitslot = FALSE)
	. = ..()
	if(!isrobot(user))
		to_chat(user, span_warning("你无法装备这个,因为它需要在你身体上安装螺栓!"))
		return FALSE

/obj/item/clothing/head/helmet/marine/robot/advanced/acid
	name = "\improper 耐酸上部装甲板"
	desc = "重型装甲板,设计用于自行安装到TerraGov战斗机器人的上半部分.它带有自密封螺栓,用于安装到机器人内部.它是为了让机器人在高酸浓度环境中生存而创造的.使用已知的镍金板技术来保护机器人上部的重要模块"
	soft_armor = list(MELEE = 50, BULLET = 60, LASER = 65, ENERGY = 65, BOMB = 50, BIO = 65, FIRE = 40, ACID = 75)
	icon_state = "robo_helm_acid"
	worn_icon_state = "robo_helm_acid"

/obj/item/clothing/suit/storage/marine/robot/advanced/acid
	name = "\improper 耐酸装甲板"
	desc = "重型装甲板,设计用于自行安装到TerraGov战斗机器人上.它带有自密封螺栓,用于安装到机器人内部.它是为了让机器人在高酸浓度环境中生存而创造的.装甲采用镍和金板技术,可完美抵御酸液."
	soft_armor = list(MELEE = 50, BULLET = 70, LASER = 80, ENERGY = 80, BOMB = 50, BIO = 80, FIRE = 60, ACID = 75)
	slowdown = 0.7

	icon_state = "robo_armor_acid"
	worn_icon_state = "robo_armor_acid"

/obj/item/clothing/head/helmet/marine/robot/advanced/physical
	name = "\improper 卷甲虫上部装甲板"
	desc = "重型装甲板,设计用于自行安装到TerraGov战斗机器人的上半部分.它带有自密封螺栓,用于安装到机器人内部.它以殖民地警察特种部队头盔为基础,由工程师为机器人重新设计.头盔获得了加固内衬以及底座,增加了对凶猛动物和枪械的防护."
	soft_armor = list(MELEE = 75, BULLET = 80, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 50, FIRE = 20, ACID = 50)

	icon_state = "robo_helm_physical"
	worn_icon_state = "robo_helm_physical"

/obj/item/clothing/suit/storage/marine/robot/advanced/physical
	name = "\improper 卷甲虫装甲板"
	desc = "重型装甲板,设计用于自行安装到TerraGov战斗机器人上.它带有自密封螺栓,用于安装到机器人内部.它最初是作为机器人反恐行动用的警察板甲而创造的,但后来首席工程师们为TGMC的需求对其进行了改造.装甲获得了额外的板甲,以抵御凶猛动物和枪械."
	soft_armor = list(MELEE = 75, BULLET = 85, LASER = 70, ENERGY = 70, BOMB = 50, BIO = 50, FIRE = 50, ACID = 60)
	slowdown = 0.7

	icon_state = "robo_armor_physical"
	worn_icon_state = "robo_armor_physical"

/obj/item/clothing/head/helmet/marine/robot/advanced/bomb
	name = "\improper 缓步动物上部装甲板"
	desc = "重型装甲板,设计用于自行安装到TerraGov战斗机器人的上半部分.它带有自密封螺栓,用于安装到机器人内部.装甲的上部是专为机器人设计的,因为机器人因地雷和手榴弹爆炸而丢失头部的情况变得越来越频繁.头盔与主体部分有加固连接,据科学家称,这将减少重要模块丢失的情况.它增强了对冲击波和爆炸的防护."
	soft_armor = list(MELEE = 60, BULLET = 60, LASER = 50, ENERGY = 50, BOMB = 90, BIO = 50, FIRE = 20, ACID = 50)

	icon_state = "robo_helm_bomb"
	worn_icon_state = "robo_helm_bomb"

/obj/item/clothing/suit/storage/marine/robot/advanced/bomb
	name = "\improper 缓步动物装甲板"
	desc = "为自动安装到TerraGov战斗机器人上而设计的重型装甲板。内部带有用于安装到机器人主体上的自密封螺栓。这种装甲专为抵御爆炸物和地雷而设计。它通常被安装在工兵和工程师的老旧机器人上以提高其存活率。该装甲配备了针对冲击波和爆炸的强化防护。"
	soft_armor = list(MELEE = 60, BULLET = 70, LASER = 70, ENERGY = 70, BOMB = 90, BIO = 50, FIRE = 50, ACID = 60)
	slowdown = 0.7

	icon_state = "robo_armor_bomb"
	worn_icon_state = "robo_armor_bomb"

/obj/item/clothing/head/helmet/marine/robot/advanced/fire
	name = "\improper 蝾螈上部装甲板"
	desc = "为安装到TerraGov战斗机器人上半部分而设计的重型装甲板。内部带有用于安装到机器人主体上的自密封螺栓。顶部装甲由防火玻璃状材料制成。这样做是为了不降低机器人追踪模块的效率。玻璃本身能够承受高温和短时间浸泡在岩浆中。"
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 80, ENERGY = 50, BOMB = 50, BIO = 50, FIRE = 100, ACID = 50)
	hard_armor = list(FIRE = 200)

	icon_state = "robo_helm_fire"
	worn_icon_state = "robo_helm_fire"

/obj/item/clothing/suit/storage/marine/robot/advanced/fire
	name = "\improper 蝾螈装甲板"
	desc = "为自动安装到TerraGov战斗机器人上而设计的重型装甲板。内部带有用于安装到机器人主体上的自密封螺栓。该装甲的灵感来自岩浆行星上使用的采矿外骨骼。由TeraGova工程师为使用火焰喷射器并在高温环境中工作的机器人进行了升级。装甲保护重要模块和线路免受火焰和岩浆的侵害,这使机器人在火焰中具有高存活率。"
	soft_armor = list(MELEE = 50, BULLET = 60, LASER = 80, ENERGY = 70, BOMB = 50, BIO = 50, FIRE = 100, ACID = 60)
	hard_armor = list(FIRE = 200)
	slowdown = 0.5

	icon_state = "robo_armor_fire"
	worn_icon_state = "robo_armor_fire"
