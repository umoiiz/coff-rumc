/**
 * TODO: не забыть создать подходящее описание на русском языке для измененных модулей. Англ версия не соответствует действительности.
 *
 *
 ** Modules
 *	These include the helmet and regular armor modules. Basically these are the subtypes of any armor 'system'.
 */
/obj/item/armor_module/module
	name = "损坏的装甲模块"
	desc = "你最好是在调试."

/**
 * PT belt
 */

/obj/item/armor_module/module/pt_belt
	name = "\improper 体能训练反光腰带"
	desc = "军士长命令陆战队员佩戴反光腰带以确保陆战队员的安全. 你可以自行推测体能训练腰带会带来什么危险."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "pt_belt"
	worn_icon_state = "pt_belt_a"
	slot = ATTACHMENT_SLOT_BELT
	attach_features_flags = ATTACH_NO_HANDS

/**
 * Shoulder lamp strength module
 */
/obj/item/armor_module/module/better_shoulder_lamp
	name = "\improper 巴德尔光增强系统"
	desc = "设计用于安装在模块化装甲上. 大幅提升模块化装甲所安装手电筒的功率输出. 成为黑暗中的光芒."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_lamp"
	worn_icon_state = "mod_lamp_a"
	slowdown = 0
	light_mod = 6 /// The boost to armor shoulder light
	slot = ATTACHMENT_SLOT_MODULE

/**
 * Mini autodoc module
 */
/obj/item/armor_module/module/valkyrie_autodoc
	name = "\improper 瓦尔基里自动医疗系统"
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	desc = "设计用于安装在模块化装甲上. 该模块拥有先进的医疗系统, 可根据使用者的需求注射三可拉嗪和曲马多, 并自动固定穿戴者的骨骼和身体, 有效地进行夹板固定, 直到能够接受专业医疗救治. 必定会影响机动性."
	icon_state = "mod_autodoc"
	worn_icon_state = "mod_autodoc_a"
	slowdown = 0
	slot = ATTACHMENT_SLOT_MODULE

/obj/item/armor_module/module/valkyrie_autodoc/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	var/list/our_brute_chems = list(/datum/reagent/medicine/bicaridine, /datum/reagent/medicine/tricordrazine)
	var/list/our_burn_chems = list(/datum/reagent/medicine/kelotane, /datum/reagent/medicine/tricordrazine)
	var/list/our_tox_chems = list(/datum/reagent/medicine/hyronalin, /datum/reagent/medicine/tricordrazine)
	var/list/our_oxy_chems = list(/datum/reagent/medicine/inaprovaline)
	var/list/our_pain_chems = list(/datum/reagent/medicine/tramadol)
	/// This will do nothing without the autodoc update
	parent.AddComponent(/datum/component/suit_autodoc, 4 MINUTES, our_brute_chems, our_burn_chems, our_tox_chems, our_oxy_chems, our_pain_chems, 0.5)
	parent.AddElement(/datum/element/limb_support)

/obj/item/armor_module/module/valkyrie_autodoc/on_detach(obj/item/detaching_from, mob/user)
	qdel(parent.GetComponent(/datum/component/suit_autodoc))
	parent.RemoveElement(/datum/element/limb_support)
	return ..()

/obj/item/armor_module/module/valkyrie_autodoc/som
	name = "\improper 阿波罗自动医疗系统"
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	desc = "设计用于安装在SOM战斗装甲上, 或安装在戈尔贡突击装甲内部. 该模块拥有先进的医疗系统, 可根据使用者的需求注射三可拉嗪和曲马多, 并自动固定穿戴者的骨骼和身体, 有效地进行夹板固定, 直到能够接受专业医疗救治. 必定会影响机动性."
	icon_state = "mod_autodoc_som"
	worn_icon_state = "mod_autodoc_som_a"
	variants_by_parent_type = list(/obj/item/clothing/suit/modular/som/heavy/leader = "")

/**
 * Fire poof module
*/
/obj/item/armor_module/module/fire_proof
	name = "\improper 苏尔特隔热系统"
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	desc = "设计用于安装在模块化装甲上. 它保护你免受火焰效果的影响, 并防止你被任何方式点燃. 将此与相应的头盔模块搭配穿戴将使你完全免疫火焰. 必定会影响机动性."
	icon_state = "mod_fire"
	worn_icon_state = "mod_fire_a"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 100, ACID = 0)
	hard_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 100, ACID = 0)
	slowdown = 0.4
	slot = ATTACHMENT_SLOT_MODULE

/obj/item/armor_module/module/fire_proof/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	parent.max_heat_protection_temperature += FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	parent.armor_features_flags |= ARMOR_FIRE_RESISTANT

/obj/item/armor_module/module/fire_proof/on_detach(obj/item/detaching_from, mob/user)
	parent.max_heat_protection_temperature -= FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	parent.armor_features_flags &= ~ARMOR_FIRE_RESISTANT
	return ..()

/obj/item/armor_module/module/fire_proof_helmet
	name = "\improper 苏尔特隔热系统头盔模块"
	desc = "设计用于安装在模块化头盔上. 它保护你免受火焰效果的影响, 并防止你被任何方式点燃. 将此与相应的头盔模块搭配穿戴将使你完全免疫火焰. 必定会影响机动性."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_fire_head"
	worn_icon_state = "mod_fire_head_a"
	variants_by_parent_type = list(/obj/item/clothing/head/modular/m10x = "mod_fire_head_xn")
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 100, ACID = 0)
	hard_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 100, ACID = 0)
	slot = ATTACHMENT_SLOT_HEAD_MODULE

/obj/item/armor_module/module/fire_proof/som
	name = "\improper 哈迪斯燃烧隔绝系统"
	desc = "设计用于安装在模块化SOM装甲上. 它提供对火焰效果的近乎免疫, 并防止你被任何方式点燃. 将此与相应的头盔模块搭配穿戴将使你完全免疫火焰. 实际上不会提供任何对沃尔凯特武器的抗性. 会影响机动性."
	icon_state = "mod_fire_som"
	worn_icon_state = "mod_fire_som_a"

/**
 * Extra armor module
*/

/obj/item/armor_module/module/tyr_extra_armor
	name = "\improper 提尔Mk.2装甲强化系统"
	desc = "设计用于安装在模块化装甲上. 大量的额外装甲板, 旨在为用户提供额外防护, 抵御从异形爪击到友军误伤事件的各种威胁. 这个较新版本具有更好的防护. 必定会影响机动性."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_armor"
	worn_icon_state = "mod_armor_a"
	attachment_layer = COLLAR_LAYER
	soft_armor = list(MELEE = 10, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 15, BIO = 0, FIRE = 10, ACID = 0)
	slowdown = 0.15
	slot = ATTACHMENT_SLOT_MODULE

/obj/item/armor_module/module/tyr_extra_armor/mark1
	name = "\improper 提尔Mk.1装甲强化系统"
	desc = "设计用于安装在模块化装甲上. 相当数量的额外全方位装甲板, 旨在为用户提供额外防护, 抵御任何类型的威胁. 这个较旧版本防护较差. 会极大地影响机动性."
	icon_state = "mod_armor_lower"
	worn_icon_state = "mod_armor_lower_a"
	soft_armor = list(MELEE = 5, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 0, FIRE = 5, ACID = 0)
	slowdown = 0.15

/obj/item/armor_module/module/tyr_extra_armor/som
	name = "\improper 洛里卡装甲强化系统"
	desc = "设计用于安装在模块化SOM装甲上. 大量的额外装甲板, 旨在为用户提供额外防护, 抵御所有形式的伤害. 必定会影响机动性."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "lorica_armor"
	worn_icon_state = "lorica_armor_a"
	attachment_layer = null
	soft_armor = list(MELEE = 10, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 15, BIO = 5, FIRE = 15, ACID = 5)
	slowdown = 0.2
	slot = ATTACHMENT_SLOT_MODULE

/obj/item/armor_module/module/tyr_head
	name = "\improper 提尔Mk.1装甲强化系统头盔模块"
	desc = "设计用于安装在模块化头盔上. 大量的全方位装甲板, 旨在为用户提供额外防护, 抵御任何类型的威胁."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	variants_by_parent_type = list(/obj/item/clothing/head/modular/m10x = "tyr_head_xn")
	icon_state = "tyr_head"
	worn_icon_state = "tyr_head_a"
	soft_armor = list(MELEE = 5, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 0, FIRE = 5, ACID = 0)
	slot = ATTACHMENT_SLOT_HEAD_MODULE

/obj/item/armor_module/module/tyr_head/mark2
	name = "\improper 提尔Mk.2装甲强化系统头盔模块"
	desc = "设计用于安装在模块化头盔上. 安装后, 该系统提供对大多数伤害性危险的强大抗性, 从异形爪击到友军误伤事件."
	soft_armor = list(MELEE = 10, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 15, BIO = 0, FIRE = 10, ACID = 0)

/obj/item/armor_module/module/tyr_extra_armor/som
	name = "\improper 洛里卡装甲强化系统"
	desc = "设计用于安装在模块化SOM装甲上. 大量的额外装甲板旨在为用户提供针对所有形式伤害的额外保护. 肯定会影响机动性."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "lorica_armor"
	worn_icon_state = "lorica_armor_a"
	attachment_layer = null
	soft_armor = list(MELEE = 10, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 15, BIO = 5, FIRE = 10, ACID = 5)

/*
	Friendly fire module
*/

/obj/item/armor_module/module/ballistic_armor
	name = "\improper 霍德弹道偏转系统"
	desc = "设计用于安装在模块化装甲上. 包含大量弹道装甲板, 以及能量反射和热耗散材料, 使其对子弹和激光都具有高水平的防御能力. 会影响机动性."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_ff"
	worn_icon_state = "mod_ff_a"
	soft_armor = list(MELEE = 0, BULLET = 40, LASER = 40, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	slowdown = 0.2
	slot = ATTACHMENT_SLOT_MODULE

/obj/item/armor_module/module/hod_head
	name = "\improper 霍德弹道偏转系统头盔模块"
	desc = "设计用于安装在模块化头盔上. 包含大量弹道装甲板, 以及能量反射和热耗散材料, 使其对子弹和激光都具有高水平的防御能力. 会影响机动性."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_ff_head"
	worn_icon_state = "mod_ff_head_a"
	soft_armor = list(MELEE = 0, BULLET = 40, LASER = 40, ENERGY = 0, BOMB = 40, BIO = 0, FIRE = 0, ACID = 0)
	slot = ATTACHMENT_SLOT_HEAD_MODULE

/**
 * Environment protection module
*/
/obj/item/armor_module/module/mimir_environment_protection
	name = "\improper 密米尔Mk.2环境抵抗系统"
	desc = "设计用于安装在模块化装甲上. 这款较新的型号对酸液, 生物和放射性攻击提供强大的抵抗力. 将其与密米尔头盔模块和面罩搭配使用, 将使使用者对任何气体云免疫. 会影响机动性."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_biohazard"
	worn_icon_state = "mod_biohazard_a"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 40, FIRE = 0, ACID = 30)
	slowdown = 0.3
	slot = ATTACHMENT_SLOT_MODULE
	///siemens (electro resist) coefficient mod for gas protection.
	var/siemens_coefficient_mod = -0.9
	///permeability coefficient mod for gas protection.
	var/permeability_coefficient_mod = -1
	///gas transfer coefficient mod for gas protection.
	var/gas_transfer_coefficient_mod = -1

/obj/item/armor_module/module/mimir_environment_protection/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	parent.siemens_coefficient += siemens_coefficient_mod
	parent.permeability_coefficient += permeability_coefficient_mod
	parent.gas_transfer_coefficient += siemens_coefficient_mod

/obj/item/armor_module/module/mimir_environment_protection/on_detach(obj/item/detaching_from, mob/user)
	parent.siemens_coefficient -= siemens_coefficient_mod
	parent.permeability_coefficient -= permeability_coefficient_mod
	parent.gas_transfer_coefficient -= siemens_coefficient_mod
	return ..()

/obj/item/armor_module/module/mimir_environment_protection/mark1
	name = "\improper 密米尔Mk.1环境抵抗系统"
	desc = "设计用于安装在模块化装甲上. 这款较旧的型号对酸液, 生物和放射性攻击提供轻微的抵抗力. 将其与密米尔头盔模块和面罩搭配使用, 将使使用者几乎对任何气体云免疫. 会影响机动性."
	icon_state = "mod_biohazard"
	worn_icon_state = "mod_biohazard_a"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 15, FIRE = 0, ACID = 15)
	slowdown = 0.3
	permeability_coefficient_mod = -0.5
	gas_transfer_coefficient_mod = -0.5

//SOM version
/obj/item/armor_module/module/mimir_environment_protection/som
	name = "\improper 米特里达提乌斯环境抵抗系统"
	desc = "设计用于安装在模块化SOM装甲上. 此模块似乎旨在保护使用者免受放射性攻击的影响, 但也提供对酸液和气体等其他环境威胁的改进抵抗力. 将其与米特里达提乌斯头盔模块和面罩搭配使用, 将使使用者对气体云免疫. 会影响机动性."
	icon_state = "mithridatius"
	worn_icon_state = "mithridatius_a"

/obj/item/armor_module/module/mimir_environment_protection/mimir_helmet
	name = "\improper 密米尔Mk.2环境抵抗系统头盔模块"
	desc = "设计用于安装在模块化头盔上. 对异形气体云提供良好的抵抗力. 这款较新的型号对酸液, 生物甚至放射性攻击提供强大的抵抗力."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mimir_head"
	worn_icon_state = "mimir_head_a"
	variants_by_parent_type = list(/obj/item/clothing/head/modular/m10x = "mimir_head_xn")
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 40, FIRE = 0, ACID = 30)
	slowdown = 0
	slot = ATTACHMENT_SLOT_HEAD_MODULE

/obj/item/armor_module/module/mimir_environment_protection/mimir_helmet/mark1
	name = "\improper 密米尔Mk.1环境抵抗系统头盔模块"
	desc = "设计用于安装在模块化头盔上. 这款较旧的型号对酸液和生物攻击提供轻微的抵抗力."
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 15, FIRE = 0, ACID = 15)

//SOM version
/obj/item/armor_module/module/mimir_environment_protection/som
	name = "\improper 米特里达提乌斯恶劣环境保护系统"
	desc = "设计用于安装在模块化SOM装甲上. 此模块似乎旨在保护使用者免受放射性攻击的影响, 但也提供对酸液和气体等其他环境威胁的改进抵抗力. 将其与米特里达提乌斯头盔模块和面罩搭配使用, 将使使用者对气体云免疫. 会影响机动性."
	icon_state = "mithridatius"
	worn_icon_state = "mithridatius_a"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 25, FIRE = 0, ACID = 20)

/*
	Explosive defense armor
*/

/obj/item/armor_module/module/hlin_explosive_armor
	name = "\improper 赫林爆炸补偿系统"
	desc = "设计用于安装在模块化装甲上. 使用一套复杂的装甲板和补偿来减轻爆炸的影响. 会影响机动性"
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_boomimmune"
	worn_icon_state = "mod_boomimmune_a"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 40, BIO = 0, FIRE = 0, ACID = 0)
	slowdown = 0.2
	slot = ATTACHMENT_SLOT_MODULE

/*
	chemical enhancement module
*/
/obj/item/armor_module/module/ballistic_armor
	name = "\improper 霍德事故预防装甲板"
	desc = "设计用于安装在模块化装甲上. 大量的额外反射弹道装甲板旨在减少友军误伤事件的影响, 将减轻子弹和激光的影响. 会影响机动性."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_ff"
	worn_icon_state = "mod_ff_a"
	soft_armor = list(MELEE = 0, BULLET = 40, LASER = 40, ENERGY = 0, BOMB = 40, BIO = 0, FIRE = 0, ACID = 0)
	slowdown = 0.2
	slot = ATTACHMENT_SLOT_MODULE

/obj/item/armor_module/module/chemsystem
	name = "\improper 瓦利化学增强模块"
	desc = "设计用于安装在模块化装甲上. 此实验性模块使用从异形身上用采集者级武器取得的绿色血液运行; 绿色血液治疗使用者并增强装甲注射系统中的任何化学物质. \nUse装甲菜单以连接采集者级武器, 控制注射系统, 查找化学增强信息等."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_chemsystem"
	worn_icon_state = "mod_chemsystem_a"
	slot = ATTACHMENT_SLOT_MODULE
	///Lets us keep track of what icon state we're in
	var/chemsystem_is_active = FALSE

/obj/item/armor_module/module/chemsystem/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	var/datum/component/chem_booster/chemsystem = parent.AddComponent(/datum/component/chem_booster)
	RegisterSignal(chemsystem, COMSIG_CHEMSYSTEM_TOGGLED, PROC_REF(update_module_icon))

/obj/item/armor_module/module/chemsystem/on_detach(obj/item/detaching_from, mob/user)
	var/datum/component/chem_booster/chemsystem = parent.GetComponent(/datum/component/chem_booster)
	UnregisterSignal(chemsystem, COMSIG_CHEMSYSTEM_TOGGLED)
	chemsystem.RemoveComponent()
	return ..()

///Updates the module on the armor to glow or not
/obj/item/armor_module/module/chemsystem/proc/update_module_icon(datum/source, toggle)
	SIGNAL_HANDLER
	chemsystem_is_active = toggle
	update_icon()
	parent.update_icon()

/obj/item/armor_module/module/chemsystem/update_icon_state()
	. = ..()
	if(chemsystem_is_active)
		icon_state = "mod_chemsystem_active"
		return
	icon_state = initial(icon_state)

/*////////////////////////
	energy shield module
*/////////////////////////

/obj/item/armor_module/module/eshield
	name = "\improper 斯瓦林能量护盾系统"
	desc = "装甲系统中的一项全新创新, 此模块在使用者周围创建一个护盾, 能够抵消所有伤害, 但代价是更容易受到近战, 生物和酸液攻击. 如果它承受过多伤害, 它将停用, 并使用户处于脆弱状态, 直到它重新充能."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_eshield"
	worn_icon_state = "mod_eshield_a"
	slot = ATTACHMENT_SLOT_MODULE
	soft_armor = list(MELEE = -5, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = -5, FIRE = 0, ACID = -5)

	///Current shield Health
	var/shield_health = 0
	///Maximum shield Health
	var/max_shield_health = 40
	///Amount to recharge per tick, processes once every two seconds.
	var/recharge_rate = 10

	///Spark system used to generate sparks when the armor takes damage
	var/datum/effect_system/spark_spread/spark_system

	///Shield color when the shield is 0 - 33% full
	var/shield_color_low = COLOR_MAROON
	///Shield color when the shield is 33 - 66% full
	var/shield_color_mid = COLOR_MOSTLY_PURE_RED
	///Shield color when the shield is 66% to full
	var/shield_color_full = COLOR_BLUE_LIGHT
	///Current shield color
	var/current_color
	///Delay it takes to start recharging again after the shield has been damaged.
	var/damaged_shield_cooldown = 15 SECONDS
	///Holds id for a timer which triggers recharge start. Null if not currently delayed.
	var/recharge_timer


/obj/item/armor_module/module/eshield/Initialize(mapload)
	. = ..()
	spark_system = new()
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

/obj/item/armor_module/module/eshield/Destroy()
	QDEL_NULL(spark_system)
	return ..()

/obj/item/armor_module/module/eshield/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(handle_equip))
	RegisterSignal(parent, COMSIG_ITEM_UNEQUIPPED, PROC_REF(handle_unequip))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(parent_examine))


/obj/item/armor_module/module/eshield/on_detach(obj/item/detaching_from, mob/user)
	UnregisterSignal(parent, list(COMSIG_ITEM_UNEQUIPPED, COMSIG_ITEM_EQUIPPED, COMSIG_ATOM_EXAMINE))
	return ..()

/obj/item/armor_module/module/eshield/emp_act(severity)
	. = ..()
	if(!isliving(parent.loc))
		return
	var/mob/living/affected = parent.loc
	affected.remove_filter("eshield")

	playsound(src, 'sound/magic/lightningshock.ogg', 50, FALSE)
	spark_system.start()
	shield_health = 0

	STOP_PROCESSING(SSobj, src)
	deltimer(recharge_timer)
	recharge_timer = addtimer(CALLBACK(src, PROC_REF(begin_recharge)), damaged_shield_cooldown * 3 / severity, TIMER_STOPPABLE)

///Called to give extra info on parent examine.
/obj/item/armor_module/module/eshield/proc/parent_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_notice("充能速率: 每秒[recharge_rate/2]点生命值")
	examine_list += span_notice("当前护盾生命值: [shield_health]")
	examine_list += span_notice("最大护盾生命值: [max_shield_health]")
	if(!recharge_timer)
		return
	examine_list += span_warning("充能延迟! 它将在[timeleft(recharge_timer) * 0.1]秒后再次开始充能!")

///Handles starting the shield when the parent is equiped to the correct slot.
/obj/item/armor_module/module/eshield/proc/handle_equip(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER
	if(slot != SLOT_WEAR_SUIT || !isliving(equipper))
		return
	if(!recharge_timer)
		START_PROCESSING(SSobj, src)
		playsound(equipper, 'sound/items/eshield_recharge.ogg', 40)

	RegisterSignal(equipper, COMSIG_LIVING_SHIELDCALL, PROC_REF(handle_shield))

///Handles removing the shield when the parent is unequipped
/obj/item/armor_module/module/eshield/proc/handle_unequip(datum/source, mob/unequipper, slot)
	SIGNAL_HANDLER
	if(slot != SLOT_WEAR_SUIT || !isliving(unequipper))
		return
	UnregisterSignal(unequipper, COMSIG_LIVING_SHIELDCALL)
	STOP_PROCESSING(SSobj, src)
	unequipper.remove_filter("eshield")
	shield_health = 0

///Adds the correct proc callback to the shield list for intercepting damage.
/obj/item/armor_module/module/eshield/proc/handle_shield(datum/source, list/affecting_shields, dam_type)
	SIGNAL_HANDLER
	if(!shield_health)
		return
	affecting_shields += CALLBACK(src, PROC_REF(intercept_damage))

///Handles the interception of damage.
/obj/item/armor_module/module/eshield/proc/intercept_damage(attack_type, incoming_damage, damage_type, silent)
	if(attack_type == COMBAT_TOUCH_ATTACK) //Touch attack so runners can pounce
		return incoming_damage
	STOP_PROCESSING(SSobj, src)
	deltimer(recharge_timer)
	var/shield_left = shield_health - incoming_damage
	var/mob/living/affected = parent.loc
	affected.remove_filter("eshield")
	if(shield_left > 0)
		shield_health = shield_left
		switch(shield_left / max_shield_health)
			if(0 to 0.33)
				affected.add_filter("eshield", 2, outline_filter(1, shield_color_low))
			if(0.33 to 0.66)
				affected.add_filter("eshield", 2, outline_filter(1, shield_color_mid))
			if(0.66 to 1)
				affected.add_filter("eshield", 2, outline_filter(1, shield_color_full))
		spark_system.start()
	else
		shield_health = 0
		recharge_timer = addtimer(CALLBACK(src, PROC_REF(begin_recharge)), damaged_shield_cooldown + 1, TIMER_STOPPABLE) //Gives it a little extra time for the cooldown.
		return -shield_left
	recharge_timer = addtimer(CALLBACK(src, PROC_REF(begin_recharge)), damaged_shield_cooldown, TIMER_STOPPABLE)
	return 0

///Starts the shield recharging after it has been broken.
/obj/item/armor_module/module/eshield/proc/begin_recharge()
	recharge_timer = null
	if(!ishuman(parent.loc))
		return
	var/mob/living/carbon/human/wearer = parent.loc
	if(wearer.wear_suit != parent)
		return
	playsound(wearer, 'sound/items/eshield_recharge.ogg', 40)
	START_PROCESSING(SSobj, src)


/obj/item/armor_module/module/eshield/process()
	shield_health = min(shield_health + recharge_rate, max_shield_health)
	if(shield_health == max_shield_health) //Once health is full, we don't need to process until the next time we take damage.
		STOP_PROCESSING(SSobj, src)
		return
	var/new_color
	switch(shield_health/max_shield_health)
		if(0 to 0.2)
			playsound(parent.loc, 'sound/items/eshield_down.ogg', 40)
			new_color = (shield_color_low != current_color) ? shield_color_low : null
		if(0.2 to 0.6)
			new_color = (shield_color_mid != current_color) ? shield_color_mid : null
		if(0.6 to 1)
			new_color = (shield_color_full != current_color) ? shield_color_full : null
	if(!new_color)
		return
	var/mob/living/affected = parent.loc
	affected.remove_filter("eshield")
	affected.add_filter("eshield", 2, outline_filter(1, new_color))

//original Martian design, donutsteel
/obj/item/armor_module/module/eshield/som
	name = "\improper 埃癸斯能量分散系统"
	desc = "一个精密的护盾单元, 旨在分散来袭冲击的能量, 使其对使用者无害. 如果它承受过多伤害, 它将停用, 并使用户处于脆弱状态. 目前尚不清楚这是纯粹的SOM设计模块, 还是从TGMC大约同时开发的\"斯瓦林\"护盾系统逆向工程而来."

/obj/item/armor_module/module/mirage
	name = "\improper 洛基幻象投影系统"
	desc = "设计用于安装在模块化装甲上. 此模块在使用者周围创建一个全息投影, 同时使其在短时间内隐形, 可用于分散敌人注意力并吸引他们的火力."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_illusion"
	worn_icon_state = "mod_illusion_a"
	slowdown = 0
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_APPLY_ON_MOB
	slot = ATTACHMENT_SLOT_MODULE
	toggle_signal = COMSIG_KB_ARMORMODULE
	COOLDOWN_DECLARE(mirage_cooldown)

/obj/item/armor_module/module/mirage/activate(mob/living/user)
	if(!COOLDOWN_FINISHED(src, mirage_cooldown))
		balloon_alert(user, "[COOLDOWN_TIMELEFT(src, mirage_cooldown)*0.1]秒")
		return
	var/alpha_mod = user.alpha * 0.95
	user.alpha -= alpha_mod
	ADD_TRAIT(user, TRAIT_STEALTH, TRAIT_STEALTH)
	var/mob/illusion/mirage_nade/fake = new(get_turf(user), user, null, 15 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(end_mirage), user, alpha_mod, fake), 1.5 SECONDS)
	COOLDOWN_START(src, mirage_cooldown, 30 SECONDS)

/// just cleans up the alpha on both the user and the fake
/obj/item/armor_module/module/mirage/proc/end_mirage(mob/user, alpha_mod, mob/illusion/mirage_nade/fake)
	user.alpha += alpha_mod
	fake.alpha = user.alpha
	REMOVE_TRAIT(user, TRAIT_STEALTH, TRAIT_STEALTH)

#define ARMORLOCK_DURATION 6 SECONDS
#define ARMORLOCK_SIEMENS_COEFF -0.9
#define ARMORLOCK_PERMEABILITY_COEFF -1
#define ARMORLOCK_GAS_TRANSFER_COEFF -1

/obj/item/armor_module/module/armorlock
	name = "\improper 托尔装甲锁定系统"
	desc = "设计用于安装在模块化装甲上. 此模块在激活时密封装甲的缝隙, 使使用者无法进行任何动作, 但增加其装甲."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_armorlock"
	worn_icon_state = "mod_armorlock_a"
	slowdown = 0.1
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_APPLY_ON_MOB
	slot = ATTACHMENT_SLOT_MODULE
	toggle_signal = COMSIG_KB_ARMORMODULE
	COOLDOWN_DECLARE(armorlock_cooldown)
	///This is the armor amounts we will be adding and removing when armor lock is activated
	var/datum/armor/locked_armor_mod = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 50, FIRE = 50, ACID = 50)

/obj/item/armor_module/module/armorlock/Initialize(mapload)
	. = ..()
	locked_armor_mod = getArmor(arglist(locked_armor_mod))

/obj/item/armor_module/module/armorlock/Destroy()
	. = ..()
	locked_armor_mod = null

/obj/item/armor_module/module/armorlock/activate(mob/living/user)
	if(!COOLDOWN_FINISHED(src, armorlock_cooldown))
		balloon_alert(user, "[COOLDOWN_TIMELEFT(src, armorlock_cooldown)*0.1]秒")
		return

	user.add_traits(list(TRAIT_HANDS_BLOCKED, TRAIT_STOPS_TANK_COLLISION, TRAIT_IMMOBILE, TRAIT_INCAPACITATED), REF(src))
	user.move_resist = MOVE_FORCE_OVERPOWERING
	user.log_message("has been armor locked for [ARMORLOCK_DURATION] ticks", LOG_ATTACK, color="pink")

	var/image/shield_overlay = image('icons/effects/effects.dmi', null, "armorlock")
	user.overlays += shield_overlay
	user.status_flags |= GODMODE
	playsound(user, 'sound/items/armorlock.ogg', 50)

	addtimer(CALLBACK(src, PROC_REF(end_armorlock), user, shield_overlay), ARMORLOCK_DURATION)
	COOLDOWN_START(src, armorlock_cooldown, 45 SECONDS)

///handles cleanup after the lock is finished
/obj/item/armor_module/module/armorlock/proc/end_armorlock(mob/living/user, image/shield_overlay)
	user.overlays -= shield_overlay
	user.remove_traits(list(TRAIT_HANDS_BLOCKED, TRAIT_STOPS_TANK_COLLISION, TRAIT_IMMOBILE, TRAIT_INCAPACITATED), REF(src))
	user.move_resist = initial(user.move_resist)
	user.status_flags &= ~GODMODE

/obj/item/armor_module/module/style
	name = "\improper 装甲均衡器"
	desc = "设计用于安装在常规服装上, 这为其提供了一定程度的防御强化."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_armor"
	slot = ATTACHMENT_SLOT_CHESTPLATE

	var/codex_info = {"<BR>This item is part of the <b>Style Line.</b><BR>
	<BR>The <b>Style Line</b> is a line of equipment designed to provide as much style as possible without compromising the user's protection.
	This line of equipment accepts <b>Equalizer modules</b>, which allow the user to alter any given piece of equipment's protection according to their preferences.<BR>
	<BR>This is an <b>Equalizer module</b>. Equalizer modules create an invisible mesh over the user's body that grants protection against many dangers, adjusting itself in such a way that their movements remain unimpeded."}

/obj/item/armor_module/module/style/get_mechanics_info()
	. = ..()
	. += jointext(codex_info, "<br>")

/obj/item/armor_module/module/style/light_armor
	name = "\improper 轻型装甲均衡器"
	icon_state = "style_light"
	worn_icon_state = "style_light_a"
	soft_armor = MARINE_ARMOR_LIGHT
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT

/obj/item/armor_module/module/style/medium_armor
	name = "\improper 中型装甲均衡器"
	icon_state = "style_medium"
	worn_icon_state = "style_medium_a"
	soft_armor = MARINE_ARMOR_MEDIUM
	slowdown = SLOWDOWN_ARMOR_MEDIUM

/obj/item/armor_module/module/style/heavy_armor
	name = "\improper 重型装甲均衡器"
	icon_state = "style_heavy"
	worn_icon_state = "style_heavy_a"
	soft_armor = MARINE_ARMOR_HEAVY
	slowdown = SLOWDOWN_ARMOR_HEAVY

/**
 *   Helmet Modules
*/
/obj/item/armor_module/module/welding
	name = "\improper HM-3焊接面罩头盔模块"
	desc = "设计用于安装在模块化头盔上. 此模块可以开启或关闭, 作为保护您脆弱眼睛的焊接防护."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "welding_head"
	worn_icon_state = "welding_head_a"
	slot = ATTACHMENT_SLOT_HEAD_MODULE
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_APPLY_ON_MOB
	active = FALSE
	prefered_slot = SLOT_HEAD
	toggle_signal = COMSIG_KB_HELMETMODULE
	///Mod for extra eye protection when activated.
	var/eye_protection_mod = 2
	///What variant of tint are we adding with the component?
	var/tint_mode = TINT_5

/obj/item/armor_module/module/welding/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	parent.AddComponent(/datum/component/clothing_tint, tint_mode, active)
	if(active)
		parent.eye_protection += eye_protection_mod // reset to the users base eye

/obj/item/armor_module/module/welding/on_detach(obj/item/detaching_from, mob/user)
	parent.GetComponent(/datum/component/clothing_tint)
	var/datum/component/clothing_tint/tints = parent?.GetComponent(/datum/component/clothing_tint)
	tints.RemoveComponent()
	if(active)
		parent.eye_protection -= eye_protection_mod // reset to the users base eye
	return ..()

/obj/item/armor_module/module/welding/activate(mob/living/user)
	if(active)
		DISABLE_BITFIELD(parent.inventory_flags, COVEREYES)
		DISABLE_BITFIELD(parent.inv_hide_flags, HIDEEYES)
		DISABLE_BITFIELD(parent.armor_protection_flags, EYES)
		parent.eye_protection -= eye_protection_mod // reset to the users base eye
	else
		ENABLE_BITFIELD(parent.inventory_flags, COVEREYES)
		ENABLE_BITFIELD(parent.inv_hide_flags, HIDEEYES)
		ENABLE_BITFIELD(parent.armor_protection_flags, EYES)
		parent.eye_protection += eye_protection_mod

	active = !active
	SEND_SIGNAL(parent, COMSIG_ITEM_TOGGLE_ACTION, user)
	to_chat(user, span_notice("你[active ? "enabling" : "disabling"]\the [src]."))
	icon_state = base_icon + "[active ? "_active" : ""]"
	worn_icon_state = icon_state + "_a"
	parent.update_icon()
	user.update_inv_head()

/obj/item/armor_module/module/welding/som
	name = "集成焊接面罩头盔模块"
	desc = "SOM工程头盔的内置焊接模块. 此模块可以开启或关闭, 作为保护您脆弱眼睛的焊接防护."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "welding_head_som"
	worn_icon_state = "welding_head_som_a"
	attach_features_flags = ATTACH_ACTIVATION|ATTACH_APPLY_ON_MOB

/obj/item/armor_module/module/welding/superior
	name = "\improper HM-33高级焊接面罩头盔模块"
	desc = "设计用于安装在模块化头盔上. 这款更昂贵的模块可以开启或关闭, 作为保护您脆弱眼睛的焊接防护, 奇怪的是闻起来像土豆."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "welding_head"
	worn_icon_state = "welding_head_a"
	slot = ATTACHMENT_SLOT_HEAD_MODULE
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_APPLY_ON_MOB
	active = FALSE
	prefered_slot = SLOT_HEAD
	tint_mode = TINT_4

/obj/item/armor_module/module/binoculars
	name = "\improper HM-6双筒望远镜头盔模块"
	desc = "设计用于安装在模块化头盔上. 可以翻下来观察远处."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "binocular_head"
	worn_icon_state = "binocular_head_a"
	active = FALSE
	item_flags = DOES_NOT_NEED_HANDS
	zoom_tile_offset = 11
	zoom_viewsize = 12
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_APPLY_ON_MOB
	slot = ATTACHMENT_SLOT_HEAD_MODULE
	prefered_slot = SLOT_HEAD
	toggle_signal = COMSIG_KB_HELMETMODULE

/obj/item/armor_module/module/binoculars/activate(mob/living/user)
	if(!(user.client.eye == user) && !(user.client.eye == user.loc))
		to_chat(user, span_warning("你现在正在通过其他东西观察."))
		return
	zoom(user)
	if(active == zoom) //Zooming failed for some reason and didn't change
		return
	active = zoom
	to_chat(user, span_notice("你[active ? "enabling" : "disabling"]\the [src]."))
	icon_state = base_icon + "[active ? "_active" : ""]"
	worn_icon_state = icon_state + "_a"
	parent.update_icon()
	user.update_inv_head()
	if(active)
		RegisterSignal(user, COMSIG_MOB_MOUSEDOWN, PROC_REF(zoom_item_turnoff))
		return
	UnregisterSignal(user, COMSIG_MOB_MOUSEDOWN)

/obj/item/armor_module/module/binoculars/zoom_item_turnoff(datum/source, mob/living/user)
	if(isliving(source))
		activate(source)
	else
		activate(user)
	return COMSIG_MOB_CLICK_CANCELED

/obj/item/armor_module/module/binoculars/artemis_mark_two // a little cheating with subtypes
	name = "\improper 弗雷Mk.2视觉辅助头盔系统"
	desc = "设计用于安装在模块化头盔上. 弗雷模块设计有一个覆盖面罩, 可以澄清使用者的视野, 使他们即使在最恶劣的环境下也能看清. 此版本经过增强, 允许陆战队员透过面罩观察, 类似于双筒望远镜."
	icon_state = "artemis_head_mk2"
	worn_icon_state = "artemis_head_mk2_a"
	variants_by_parent_type = list(/obj/item/clothing/head/modular/m10x = "artemis_head_mk2_xn")
	var/eye_protection_mod = 1

/obj/item/armor_module/module/binoculars/artemis_mark_two/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	parent.eye_protection += eye_protection_mod
	parent.AddComponent(/datum/component/blur_protection)

/obj/item/armor_module/module/binoculars/artemis_mark_two/on_detach(obj/item/detaching_from, mob/user)
	parent.eye_protection -= eye_protection_mod
	var/datum/component/blur_protection/blur_p = parent?.GetComponent(/datum/component/blur_protection)
	blur_p?.RemoveComponent()
	return ..()

/obj/item/armor_module/module/artemis
	name = "\improper 弗雷Mk.1视觉辅助头盔系统"
	desc = "设计用于安装在模块化头盔上. 弗雷模块设计有一个覆盖面罩, 可以澄清使用者的视野, 使他们即使在最恶劣的环境下也能看清."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	variants_by_parent_type = list(/obj/item/clothing/head/modular/m10x = "artemis_head_xn")
	icon_state = "artemis_head"
	worn_icon_state = "artemis_head_a"
	slot = ATTACHMENT_SLOT_HEAD_MODULE
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_APPLY_ON_MOB
	prefered_slot = SLOT_HEAD

/obj/item/armor_module/module/artemis/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	parent.AddComponent(/datum/component/blur_protection)

/obj/item/armor_module/module/artemis/on_detach(obj/item/detaching_from, mob/user)
	. = ..()
	var/datum/component/blur_protection/blur_p = parent?.GetComponent(/datum/component/blur_protection)
	blur_p?.RemoveComponent()

/obj/item/armor_module/module/antenna
	name = "\improper HM-9天线头盔模块"
	desc = "设计用于安装在模块化头盔上. 此模块能够提供使用者坐标的读数, 并连接到船上的补给控制台, 并屏蔽洞穴的干扰, 允许在浅洞穴中进行正常通讯, 在深处时只有轻微的干扰."
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "antenna_head"
	worn_icon_state = "antenna_head_a"
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_APPLY_ON_MOB
	slot = ATTACHMENT_SLOT_HEAD_MODULE
	prefered_slot = SLOT_HEAD
	toggle_signal = COMSIG_KB_HELMETMODULE

/obj/item/armor_module/module/antenna/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	parent.AddComponent(/datum/component/beacon/antenna)
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED_TO_SLOT, PROC_REF(on_parent_equip))
	RegisterSignal(parent, COMSIG_ITEM_UNEQUIPPED, PROC_REF(on_parent_unequip))

/obj/item/armor_module/module/antenna/on_detach(obj/item/detaching_from, mob/user)
	var/datum/component/beacon/beacon = parent?.GetComponent(/datum/component/beacon)
	beacon?.RemoveComponent()
	UnregisterSignal(user, list(COMSIG_ITEM_EQUIPPED_TO_SLOT, COMSIG_ITEM_UNEQUIPPED))
	return ..()

/obj/item/armor_module/module/antenna/proc/on_parent_equip(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER
	RegisterSignal(equipper, COMSIG_CAVE_INTERFERENCE_CHECK, PROC_REF(on_interference_check))

/obj/item/armor_module/module/antenna/proc/on_parent_unequip(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER
	UnregisterSignal(equipper, COMSIG_CAVE_INTERFERENCE_CHECK)

/// Handles interacting with caves checking for if anything is reducing (or increasing) interference.
/obj/item/armor_module/module/antenna/proc/on_interference_check(datum/source, list/inplace_interference)
	SIGNAL_HANDLER
	inplace_interference[1] = max(0, inplace_interference[1] - 1)

/obj/item/armor_module/module/antenna/activate(mob/living/user)
	var/datum/component/beacon/beacon = parent?.GetComponent(/datum/component/beacon)
	beacon?.toggle_activation(parent, user)

/obj/item/armor_module/module/night_vision
	name = "\improper BE-35夜视套件"
	desc = "用于BE-35夜视系统的安装套件。略微影响移动。"
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "night_vision"
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_NO_HANDS
	slot = ATTACHMENT_SLOT_HEAD_MODULE
	prefered_slot = SLOT_HEAD
	slowdown = 0.1
	toggle_signal = COMSIG_KB_HELMETMODULE
	/// The goggles this module deploys
	var/obj/item/clothing/glasses/night_vision/mounted/attached_goggles

/obj/item/armor_module/module/night_vision/Initialize(mapload)
	. = ..()
	attached_goggles = new /obj/item/clothing/glasses/night_vision/mounted(src)

/obj/item/armor_module/module/night_vision/examine(mob/user)
	. = ..()
	. += attached_goggles.battery_status()
	. += "To eject the battery, [span_bold("click")] [src] with an empty hand. To insert a battery, [span_bold("click")] [src] with a compatible cell."

///Called when the parent is examined; relays battery info
/obj/item/armor_module/module/night_vision/proc/on_examine(datum/source, mob/user, list/examine_text)
	SIGNAL_HANDLER
	examine_text += attached_goggles.battery_status()
	examine_text += "To eject the battery, [span_bold("CTRL + SHIFT + left-click")] [src] with an empty hand. To insert a battery, [span_bold("click")] [src] with a compatible cell."

/obj/item/armor_module/module/night_vision/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(on_click))
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(deploy))
	RegisterSignal(parent, COMSIG_ITEM_UNEQUIPPED, PROC_REF(undeploy))

/obj/item/armor_module/module/night_vision/on_detach(obj/item/detaching_from, mob/user)
	UnregisterSignal(parent, list(COMSIG_ATOM_EXAMINE, COMSIG_CLICK_CTRL_SHIFT, COMSIG_ATOM_ATTACKBY, COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_UNEQUIPPED))
	return ..()

///Called when the parent is clicked on with an open hand; to take out the battery
/obj/item/armor_module/module/night_vision/proc/on_click(datum/source, mob/user)
	SIGNAL_HANDLER
	attached_goggles.eject_battery(user)

///Called when the parent is hit by object; to insert a battery
/obj/item/armor_module/module/night_vision/proc/on_attackby(datum/source, obj/item/I, mob/user)
	SIGNAL_HANDLER
	if(attached_goggles.insert_battery(I, user))
		return COMPONENT_NO_AFTERATTACK

/obj/item/armor_module/module/night_vision/attack_hand(mob/living/user)
	if(user.get_inactive_held_item() == src && attached_goggles.eject_battery(user))
		return
	return ..()

/obj/item/armor_module/module/night_vision/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(attached_goggles.insert_battery(I, user))
		return COMPONENT_NO_AFTERATTACK

///Called when the parent is equipped; deploys the goggles
/obj/item/armor_module/module/night_vision/proc/deploy(datum/source, mob/user, slot)
	SIGNAL_HANDLER
	if(!ishuman(user) || prefered_slot != slot)	//Must be human for the following procs to work
		return

	var/mob/living/carbon/human/wearer = user
	if(wearer.glasses && !wearer.dropItemToGround(wearer.glasses))
		//This only happens if the wearer has a head item that can't be dropped
		to_chat(wearer, span_warning("由于[wearer.head]，无法部署夜视系统!"))
		return

	INVOKE_ASYNC(wearer, TYPE_PROC_REF(/mob/living/carbon/human, equip_to_slot), attached_goggles, SLOT_GLASSES)

///Called when the parent is unequipped; undeploys the goggles
/obj/item/armor_module/module/night_vision/proc/undeploy(datum/source, mob/user, slot)
	SIGNAL_HANDLER
	//See if goggles are deployed
	if(attached_goggles.loc == src)
		return

	//The goggles should not be anywhere but on the wearer's face; but if it's not, just yoink it back to the module
	if(attached_goggles.loc == user)
		user.temporarilyRemoveItemFromInventory(attached_goggles, TRUE)
	attached_goggles.forceMove(src)

/obj/item/armor_module/module/night_vision/Destroy()
	QDEL_NULL(attached_goggles)
	return ..()

/obj/item/armor_module/module/motion_detector
	name = "战术传感器头盔模块"
	desc = "帮助你在黑暗中探测异形。"
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_head_scanner"
	worn_icon_state = "mod_head_scanner_a"
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION|ATTACH_APPLY_ON_MOB
	slot = ATTACHMENT_SLOT_HEAD_MODULE
	prefered_slot = SLOT_HEAD
	toggle_signal = COMSIG_KB_HELMETMODULE
	/// Who's using this item
	var/mob/living/carbon/human/operator
	///The range of this motion detector
	var/range = 16
	///таймер для работы модуля
	var/motion_timer = null
	///время через которое будет срабатывать модуль
	var/scan_time = 2 SECONDS
	///The time needed after the last move to not be detected by this motion detector
	var/move_sensitivity = 1 SECONDS
	///The list of all the blips
	var/list/obj/effect/blip/blips_list = list()

/obj/item/armor_module/module/motion_detector/Destroy()
	stop_and_clean()
	return ..()

/obj/item/armor_module/module/motion_detector/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_UNEQUIPPED, PROC_REF(stop_and_clean))

/obj/item/armor_module/module/motion_detector/on_detach(obj/item/detaching_from, mob/user)
	UnregisterSignal(parent, COMSIG_ITEM_UNEQUIPPED, PROC_REF(stop_and_clean))
	stop_and_clean()
	return ..()

//убираем графическую хуйню и останавливает сканирование.
/obj/item/armor_module/module/motion_detector/proc/stop_and_clean()
	SIGNAL_HANDLER

	active = FALSE
	clean_blips()
	operator = null
	if(motion_timer)
		deltimer(motion_timer)
		motion_timer = null

//вкл-выкл модуль
/obj/item/armor_module/module/motion_detector/activate(mob/living/user)
	active = !active
	to_chat(user, span_notice("你切换了\the [src] [active ? "enabling" : "disabling"]它。"))
	if(active)
		operator = user
		if(!motion_timer)
			motion_timer = addtimer(CALLBACK(src, PROC_REF(do_scan)), scan_time, TIMER_LOOP|TIMER_STOPPABLE)
	else
		stop_and_clean()

/obj/item/armor_module/module/motion_detector/proc/do_scan()
	if(!operator?.client || operator?.stat != CONSCIOUS)
		stop_and_clean()
		return
	var/hostile_detected = FALSE
	for(var/mob/living/carbon/human/nearby_human AS in cheap_get_humans_near(operator, range))
		if(nearby_human == operator)
			continue
		if(nearby_human.last_move_time + move_sensitivity < world.time)
			continue
		if(HAS_TRAIT(nearby_human, TRAIT_LIGHT_STEP))
			continue
		if(!hostile_detected && (!operator.wear_id || !nearby_human.wear_id || nearby_human.wear_id.iff_signal != operator.wear_id.iff_signal))
			hostile_detected = TRUE
		prepare_blip(nearby_human, nearby_human.wear_id?.iff_signal & operator.wear_id?.iff_signal ? MOTION_DETECTOR_FRIENDLY : MOTION_DETECTOR_HOSTILE)
	for(var/mob/living/carbon/xenomorph/nearby_xeno AS in cheap_get_xenos_near(operator, range))
		if(HAS_TRAIT(nearby_xeno, TRAIT_STEALTH))
			continue
		if(nearby_xeno.last_move_time + move_sensitivity < world.time )
			continue
		if(!hostile_detected)
			hostile_detected = TRUE
		prepare_blip(nearby_xeno, MOTION_DETECTOR_HOSTILE)
	for(var/mob/illusion/nearby_illusion AS in cheap_get_illusions_near(operator, range))
		prepare_blip(nearby_illusion, MOTION_DETECTOR_HOSTILE)
	if(hostile_detected)
		playsound(loc, 'sound/items/tick.ogg', 100, 0, 1)
	addtimer(CALLBACK(src, PROC_REF(clean_blips)), scan_time * 0.5)

///Clean all blips from operator screen
/obj/item/armor_module/module/motion_detector/proc/clean_blips()
	if(!operator)//We already cleaned
		return
	for(var/obj/effect/blip/blip AS in blips_list)
		blip.remove_blip(operator)
	blips_list.Cut()

///Prepare the blip to be print on the operator screen
/obj/item/armor_module/module/motion_detector/proc/prepare_blip(mob/target, status)
	if(!operator || !operator.client)
		return
	if(!target)
		return

	var/list/actualview = getviewsize(operator.client.view)
	var/viewX = actualview[1]
	var/viewY = actualview[2]
	var/turf/center_view = get_view_center(operator) ? get_view_center(operator) : get_turf(src)
	var/screen_pos_y = target.y - center_view.y + round(viewY * 0.5) + 1
	var/dir
	if(screen_pos_y < 1)
		dir = SOUTH
		screen_pos_y = 1
	else if (screen_pos_y > viewY)
		dir = NORTH
		screen_pos_y = viewY
	var/screen_pos_x = target.x - center_view.x + round(viewX * 0.5) + 1
	if(screen_pos_x < 1)
		dir = (dir ? dir == SOUTH ? SOUTHWEST : NORTHWEST : WEST)
		screen_pos_x = 1
	else if (screen_pos_x > viewX)
		dir = (dir ? dir == SOUTH ? SOUTHEAST : NORTHEAST : EAST)
		screen_pos_x = viewX
	if(dir)
		blips_list += new /obj/effect/blip/edge_blip(null, status, operator, screen_pos_x, screen_pos_y, dir)
		return
	blips_list += new /obj/effect/blip/close_blip(get_turf(target), status, operator)

/**
 * pluto
 */
/obj/item/armor_module/module/pluto
	name = "\improper Pluto隐匿模块"
	desc = "一种特殊系统，有助于向异形隐藏气味和温度，对它们隐藏你的状态。还包含一个集成健康分析仪。"
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_pluto"
	worn_icon_state = "mod_pluto_a"
	slowdown = 0.1
	slot = ATTACHMENT_SLOT_MODULE

/obj/item/armor_module/module/pluto/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	parent.AddComponent(/datum/component/health_stealth)

/obj/item/armor_module/module/pluto/on_detach(obj/item/detaching_from, mob/user)
	var/datum/component/health_stealth/health_stealth = parent?.GetComponent(/datum/component/health_stealth)
	health_stealth?.RemoveComponent()
	return ..()
