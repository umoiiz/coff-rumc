// MARINE STORAGE ARMOR


/obj/item/clothing/suit/storage/marine
	name = "\improper M3型陆战队装甲"
	desc = "标准的TerraGov陆战队M3型胸甲. 保护胸部免受弹道弹药, 刀刃物体和事故的伤害. 上面绑着一个小皮革袋, 用于有限的存储."
	icon = 'icons/obj/clothing/suits/marine_armor.dmi'
	icon_state = ""
	worn_icon_state = "armor"
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/marine_armor.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	atom_flags = CONDUCT
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	cold_protection_flags = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	heat_protection_flags = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	blood_overlay_type = "armor"
	soft_armor = list(MELEE = 40, BULLET = 60, LASER = 60, ENERGY = 45, BOMB = 45, BIO = 45, FIRE = 45, ACID = 50)
	siemens_coefficient = 0.7
	permeability_coefficient = 0.8
	slowdown = 0.5
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/instrument,
		/obj/item/storage/belt/sparepouch,
		/obj/item/storage/holster/blade,
		/obj/item/weapon/sword/harvester,
		/obj/item/storage/holster/belt,
		/obj/item/storage/belt/knifepouch,
		/obj/item/weapon/twohanded,
		/obj/item/tool/pickaxe/plasmacutter,
	)
	actions_types = list(/datum/action/item_action/toggle/suit_toggle)
	armor_features_flags = ARMOR_LAMP_OVERLAY
	item_flags = SYNTH_RESTRICTED|IMPEDE_JETPACK
	w_class = WEIGHT_CLASS_HUGE
	equip_delay_self = 2 SECONDS
	unequip_delay_self = 2 SECONDS
	item_map_variant_flags = (ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_PRISON_VARIANT)
	var/locate_cooldown = 0 //Cooldown for SL locator
	var/list/armor_overlays

/obj/item/clothing/suit/storage/marine/Initialize(mapload)
	. = ..()
	armor_overlays = list("lamp") //Just one for now, can add more later.
	update_icon()

/obj/item/clothing/suit/storage/marine/turn_light(mob/user, toggle_on)
	. = ..()
	user?.update_inv_wear_suit()

/obj/item/clothing/suit/storage/marine/update_overlays()
	. = ..()
	if(armor_features_flags & ARMOR_LAMP_OVERLAY)
		var/image/I = image(icon, src, armor_features_flags & ARMOR_LAMP_ON? "lamp-on" : "lamp-off")
		armor_overlays["lamp"] = I
		. += I
	else
		armor_overlays["lamp"] = null

/obj/item/clothing/suit/storage/marine/apply_custom(mutable_appearance/standing, inhands, icon_used, state_used)
	if(inhands)
		return
	. = ..()
	var/mutable_appearance/new_overlay
	for(var/i in armor_overlays)
		new_overlay = armor_overlays[i]
		if(new_overlay)
			new_overlay = mutable_appearance(worn_icon_list[slot_wear_suit_str], new_overlay.icon_state)
			standing.overlays += new_overlay

/obj/item/clothing/suit/storage/marine/attack_self(mob/user)
	if(!isturf(user.loc))
		to_chat(user, span_warning("在[user.loc]中时, 你无法打开灯光."))
		return
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_ARMOR_LIGHT))
		return
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.wear_suit != src)
		return
	if(turn_light(user, !light_on) == CHECKS_PASSED)
		return TRUE

/obj/item/clothing/suit/storage/marine/item_action_slot_check(mob/user, slot)
	if(!ishuman(user))
		return FALSE
	if(slot != SLOT_WEAR_SUIT)
		return FALSE
	return TRUE //only give action button when armor is worn.

/obj/item/clothing/suit/storage/marine/mech_pilot
	name = "\improper PAS-13型机甲驾驶员装甲"
	desc = "一件装甲略显稀疏但坚固的装甲背心, 尽管外骨骼装甲已经兴起, 但由于易于使用和制造, 它仍在使用. 虽然穿着机甲驾驶员制服时这套装备略显笨重, 但它为他们在机甲外提供了原本没有的一定程度的保护."
	icon_state = "mech_pilot_suit"
	worn_icon_state = "mech_pilot_suit"
	slowdown = SLOWDOWN_ARMOR_LIGHT
	soft_armor = list(MELEE = 45, BULLET = 55, LASER = 55, ENERGY = 20, BOMB = 45, BIO = 30, FIRE = 25, ACID = 35)
	item_map_variant_flags = NONE

/obj/item/clothing/suit/storage/marine/assault_crewman
	name = "\improper PAS-73型坦克手装甲"
	desc = "一件装甲略显稀疏但坚固的装甲背心. 由坦克手使用, 主要用于在碾过敌人时吸收道路上的颠簸."
	icon_state = "assault_crewman_suit"
	worn_icon_state = "assault_crewman_suit"
	slowdown = SLOWDOWN_ARMOR_LIGHT
	soft_armor = list(MELEE = 45, BULLET = 55, LASER = 55, ENERGY = 20, BOMB = 45, BIO = 30, FIRE = 25, ACID = 35)
	item_map_variant_flags = NONE

/obj/item/clothing/suit/storage/marine/transport_crewman
	name = "\improper PAS-74型运输装甲"
	desc = "一件装甲略显稀疏但坚固的装甲背心. 由运输乘员使用, 以便在车辆被攻陷时他们可以假装自己可能幸存."
	icon_state = "transport_crewman_suit"
	worn_icon_state = "transport_crewman_suit"
	slowdown = SLOWDOWN_ARMOR_LIGHT
	soft_armor = list(MELEE = 45, BULLET = 55, LASER = 55, ENERGY = 20, BOMB = 45, BIO = 30, FIRE = 25, ACID = 35)
	item_map_variant_flags = NONE

/obj/item/clothing/suit/storage/marine/riot
	name = "\improper M5型防暴装甲"
	desc = "一套经过大量改装的M2宪兵装甲, 用于镇压桶头陆战队员及其枪支引发的暴乱. 会大大减慢你的速度."
	icon_state = "marine_riot"
	slowdown = 1.3
	soft_armor = list(MELEE = 65, BULLET = 110, LASER = 110, ENERGY = 10, BOMB = 60, BIO = 50, FIRE = 50, ACID = 30)
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/storage/belt/sparepouch,
		/obj/item/storage/holster/blade,
		/obj/item/weapon/sword/harvester,
		/obj/item/storage/holster/belt,
		/obj/item/storage/belt/knifepouch,
		/obj/item/weapon/twohanded,
	)
	item_map_variant_flags = NONE

//===========================SPECIALIST================================


/obj/item/clothing/suit/storage/marine/specialist
	name = "\improper B18防御装甲"
	desc = "一套沉重, 坚固的装甲板, 适用于当你真的, 真的需要避免惨死时. 不过会减慢你的速度.\nHas一个自动诊断和医疗系统, 用于维持穿戴者的生命."
	icon_state = "xarmor"
	soft_armor = list(MELEE = 75, BULLET = 80, LASER = 80, ENERGY = 85, BOMB = 85, BIO = 70, FIRE = 85, ACID = 70)
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	resistance_flags = UNACIDABLE
	item_flags = SYNTH_RESTRICTED|IMPEDE_JETPACK|AUTOBALANCE_CHECK

/obj/item/clothing/suit/storage/marine/specialist/Initialize(mapload, ...)
	. = ..()
	AddComponent(/datum/component/suit_autodoc)
	AddComponent(/datum/component/stun_mitigation, slot_override = SLOT_WEAR_SUIT, shield_cover = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 50, FIRE = 50, ACID = 50))
	AddElement(/datum/element/limb_support)
	if(item_flags & AUTOBALANCE_CHECK)
		SSmonitor.stats.b18_in_use += src

/obj/item/clothing/suit/storage/marine/specialist/Destroy()
	if(item_flags & AUTOBALANCE_CHECK)
		SSmonitor.stats.b18_in_use -= src
	return ..()

/obj/item/clothing/suit/storage/marine/specialist/valhalla
	item_flags = NONE

/obj/item/clothing/suit/storage/marine/B17
	name = "\improper B17防御装甲"
	desc = "B18的老大哥. 实际上是一套为近距离爆炸专家使用而制造的装甲排爆服."
	icon_state = "grenadier"
	soft_armor = list(MELEE = 75, BULLET = 75, LASER = 50, ENERGY = 55, BOMB = 100, BIO = 55, FIRE = 75, ACID = 65)
	max_heat_protection_temperature = HEAVYARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	item_flags = SYNTH_RESTRICTED|IMPEDE_JETPACK|AUTOBALANCE_CHECK

/obj/item/clothing/suit/storage/marine/B17/Initialize(mapload, ...)
	. = ..()
	if(item_flags & AUTOBALANCE_CHECK)
		SSmonitor.stats.b17_in_use += src

/obj/item/clothing/suit/storage/marine/B17/Destroy()
	if(item_flags & AUTOBALANCE_CHECK)
		SSmonitor.stats.b17_in_use -= src
	return ..()

/obj/item/clothing/suit/storage/marine/B17/valhalla
	item_flags = NONE

////////////////////////////////

/obj/item/clothing/suit/storage/marine/ship_tech
	name = "\improper PAS-09型技术员装甲"
	desc = "一件略显过时但坚固的装甲背心, 尽管外骨骼装甲已经兴起, 但由于易于使用和制造, 它仍在使用. 它为技术员面临的特殊危险提供了更多保护."
	icon_state = "tanker"
	soft_armor = list(MELEE = 40, BULLET = 55, LASER = 60, ENERGY = 45, BOMB = 60, BIO = 45, FIRE = 45, ACID = 65)
	item_map_variant_flags = NONE

/obj/item/clothing/suit/storage/marine/officer
	name = "\improper PAS-N3型军官装甲"
	desc = "一套制作精良的海军个人装甲系统, 通常出现在高级军官手中. 在上战场时, 有助于让你的手下知道谁在指挥."
	icon_state = "officer"
	soft_armor = list(MELEE = 40, BULLET = 60, LASER = 60, ENERGY = 45, BOMB = 45, BIO = 45, FIRE = 45, ACID = 50)
	slowdown = 0.5
	item_map_variant_flags = NONE
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraints/handcuffs,
		/obj/item/explosive/grenade,
		/obj/item/binoculars,
		/obj/item/weapon/combat_knife,
		/obj/item/attachable/bayonetknife,
		/obj/item/storage/belt/sparepouch,
		/obj/item/hailer,
		/obj/item/storage/holster/blade,
		/obj/item/storage/holster/belt,
	)

/obj/item/clothing/suit/storage/marine/officer/req
	name = "\improper PAS-N2型军士长装甲"
	desc = "标准的TerraGov海军N2个人装甲系统. 保护胸部免受弹道弹药, 刀刃物体和事故的伤害. 上面绑着一个小皮革袋, 用于有限的存储."
	icon_state = "mp"

/*=============================PMCS==================================*/

/obj/item/clothing/suit/storage/marine/veteran
	icon = 'icons/obj/clothing/suits/ert_suits.dmi'
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/ert_suits.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	armor_features_flags = ARMOR_LAMP_OVERLAY

/obj/item/clothing/suit/storage/marine/veteran/pmc
	name = "\improper M4型PMC装甲"
	desc = "一件常见的装甲背心, 专为高调安保操作员和企业雇佣兵设计."
	icon_state = "pmc_armor"
	soft_armor = list(MELEE = 55, BULLET = 70, LASER = 60, ENERGY = 55, BOMB = 50, BIO = 15, FIRE = 38, ACID = 45)
	slowdown = SLOWDOWN_ARMOR_LIGHT
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/weapon/baton,
		/obj/item/restraints/handcuffs,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/explosive/grenade,
		/obj/item/storage/bible,
		/obj/item/weapon/sword/machete,
		/obj/item/weapon/combat_knife,
	)
	item_map_variant_flags = NONE

/obj/item/clothing/suit/storage/marine/veteran/pmc/leader
	name = "\improper M4型PMC队长装甲"
	desc = "M4防弹装甲的改进型, 专为高调安保操作员和企业雇佣兵设计. 这套特殊的装甲看起来属于一名高级军官."
	icon_state = "officer_armor"
	soft_armor = list(MELEE = 60, BULLET = 75, LASER = 65, ENERGY = 65, BOMB = 60, BIO = 50, FIRE = 50, ACID = 45)


/obj/item/clothing/suit/storage/marine/veteran/pmc/sniper
	name = "\improper M4型PMC狙击手装甲"
	icon_state = "pmc_sniper"
	soft_armor = list(MELEE = 55, BULLET = 65, LASER = 55, ENERGY = 60, BOMB = 75, BIO = 10, FIRE = 60, ACID = 60)
	inventory_flags = BLOCKSHARPOBJ
	inv_hide_flags = HIDELOWHAIR

/obj/item/clothing/suit/storage/marine/veteran/pmc/gunner
	name = "\improper PMC机枪手装甲"
	desc = "标准M4防弹装甲的改进型. 配有背带和绑带, 允许使用者携带智能枪."
	icon_state = "pmc_heavyarmor"
	slowdown = SLOWDOWN_ARMOR_HEAVY
	soft_armor = list(MELEE = 65, BULLET = 80, LASER = 70, ENERGY = 70, BOMB = 80, BIO = 30, FIRE = 65, ACID = 65)
	item_map_variant_flags = NONE

/*===========================Death Commando============================*/
/obj/item/clothing/suit/storage/marine/veteran/pmc/commando
	name = "\improper PMC突击队装甲"
	desc = "一套由不知何人为何人制造的精英行动用重型装甲. 它是一个完全自给自足的系统, 并且具有极强的抗腐蚀性."
	icon_state = "commando_armor"
	soft_armor = list(MELEE = 90, BULLET = 120, LASER = 200, ENERGY = 100, BOMB = 100, BIO = 100, FIRE = 100, ACID = 100)
	attachments_by_slot = list(ATTACHMENT_SLOT_STORAGE)
	attachments_allowed = list(/obj/item/armor_module/storage/grenade)
	starting_attachments = list(/obj/item/armor_module/storage/grenade)
	resistance_flags = UNACIDABLE

/obj/item/clothing/suit/storage/marine/veteran/pmc/commando/Initialize(mapload, ...)
	. = ..()
	AddComponent(/datum/component/suit_autodoc)
	AddElement(/datum/element/limb_support)

/*===========================I.o.M================================*/

/obj/item/clothing/suit/storage/marine/imperial
	name = "\improper 帝国卫队防弹甲"
	desc = "一种廉价, 大规模生产的装甲, 由同样廉价且大规模生产的帝国卫队穿着. 你可以辨认出装甲上刻着似乎是<i>Cadia屹立不倒</i>的字样."
	icon = 'icons/obj/clothing/suits/ert_suits.dmi'
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/ert_suits.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	icon_state = "guardarmor"
	soft_armor = list(MELEE = 75, BULLET = 65, LASER = 60, ENERGY = 60, BOMB = 50, BIO = 0, FIRE = 60, ACID = 60)
	item_map_variant_flags = NONE

/obj/item/clothing/suit/storage/marine/imperial/sergeant
	// SL armour, better than flak, covers more
	name = "\improper 帝国卫队中士装甲"
	desc = "一种比防弹甲提供更好保护的防弹装甲."
	icon_state = "guardSLarmor"
	soft_armor = list(MELEE = 85, BULLET = 85, LASER = 85, ENERGY = 85, BOMB = 85, BIO = 25, FIRE = 85, ACID = 85)
	light_range = 6 // better light

/obj/item/clothing/suit/storage/marine/imperial/medicae
	name = "\improper 帝国卫队医疗兵装甲"
	desc = "一种由帝国卫队医疗兵穿着的装甲."
	icon_state = "guardmedicarmor"

/obj/item/clothing/suit/storage/marine/imperial/sergeant/veteran
	name = "\improper 帝国卫队甲壳装甲"
	desc = "一种重型全身装甲, 比防弹甲提供更多保护, 但也会大大减慢速度."
	icon_state = "guardvetarmor"
	slowdown = SLOWDOWN_ARMOR_HEAVY
	soft_armor = list(MELEE = 90, BULLET = 90, LASER = 90, ENERGY = 90, BOMB = 90, BIO = 30, FIRE = 90, ACID = 90)

/obj/item/clothing/suit/storage/marine/imperial/power
	// Should this maybe require recharging?
	name = "\improper 回收的星际战士动力装甲"
	desc = "一套曾经损坏的动力装甲, 现在再次可以使用. 然而这个版本不如真正的动力装甲强大."
	//icon_state
	soft_armor = list(MELEE = 75, BULLET = 60, LASER = 55, ENERGY = 40, BOMB = 45, BIO = 15, FIRE = 40, ACID = 40)
	light_range = 6

/obj/item/clothing/suit/storage/marine/imperial/commissar
	name = "\improper 政委大衣"
	desc = "一种由帝国陆军政委穿着的装甲大衣."
	icon_state = "commissar_coat"
	worn_icon_state = "commissar_coat"
	soft_armor = list(MELEE = 75, BULLET = 60, LASER = 55, ENERGY = 40, BOMB = 45, BIO = 15, FIRE = 40, ACID = 40)

/*===========================U.S.L================================*/

/obj/item/clothing/suit/storage/faction
	icon = 'icons/obj/clothing/suits/ert_suits.dmi'
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/ert_suits.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	atom_flags = CONDUCT
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	cold_protection_flags = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	heat_protection_flags =CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	blood_overlay_type = "armor"
	soft_armor = list(MELEE = 50, BULLET = 40, LASER = 35, ENERGY = 20, BOMB = 25, BIO = 10, FIRE = 20, ACID = 20)
	siemens_coefficient = 0.7
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/explosive/grenade,
		/obj/item/binoculars,
		/obj/item/weapon/combat_knife,
		/obj/item/attachable/bayonetknife,
		/obj/item/storage/belt/sparepouch,
		/obj/item/storage/holster/blade,
		/obj/item/weapon/twohanded,
	)
	armor_features_flags = ARMOR_LAMP_OVERLAY
	item_flags = SYNTH_RESTRICTED
	actions_types = list(/datum/action/item_action/toggle)
	var/locate_cooldown = 0 //Cooldown for SL locator
	var/armor_overlays["lamp"]

/obj/item/clothing/suit/storage/faction/Initialize(mapload, ...)
	. = ..()
	armor_overlays = list("lamp")
	update_icon()

/obj/item/clothing/suit/storage/faction/update_overlays()
	. = ..()
	if(armor_features_flags & ARMOR_LAMP_OVERLAY)
		var/image/I = image(icon, src, armor_features_flags & ARMOR_LAMP_ON? "lamp-on" : "lamp-off")
		armor_overlays["lamp"] = I
		. += I
	else
		armor_overlays["lamp"] = null

/obj/item/clothing/suit/storage/faction/attack_self(mob/user)
	if(!isturf(user.loc))
		to_chat(user, span_warning("在[user.loc]中时, 你无法打开灯光."))
		return

	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_ARMOR_LIGHT))
		return

	if(!ishuman(user)) return
	var/mob/living/carbon/human/H = user
	if(H.wear_suit != src) return

	if(turn_light(user, !light_on) == CHECKS_PASSED)
		return TRUE

/obj/item/clothing/suit/storage/faction/item_action_slot_check(mob/user, slot)
	if(!ishuman(user)) return FALSE
	if(slot != SLOT_WEAR_SUIT) return FALSE
	return TRUE //only give action button when armor is worn.

/obj/item/clothing/suit/storage/faction/upp
	name = "\improper UM5个人装甲"
	desc = "USL海盗的标准防弹装甲, UM5 (联合中型MK5) 是一种中型防弹装甲, 大致与TGMC服役的古老M3型防弹装甲相当."
	icon_state = "upp_armor"
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	soft_armor = list(MELEE = 55, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 55, BIO = 10, FIRE = 60, ACID = 60)

/// Modified version of the armor for HvH combat. Stats are based on medium armor, with tyr mark 2.
/obj/item/clothing/suit/storage/faction/upp/hvh
	soft_armor = list(MELEE = 55, BULLET = 75, LASER = 75, ENERGY = 60, BOMB = 60, BIO = 45, FIRE = 60, ACID = 65)


/obj/item/clothing/suit/storage/faction/upp/commando
	name = "\improper UM5CU个人装甲"
	desc = "UM5的改进型, 为潜行行动设计."
	icon_state = "upp_armor_commando"
	slowdown = SLOWDOWN_ARMOR_LIGHT

/// Modified version of the armor for HvH combat. Stats are based on medium armor, with tyr mark 2.
/obj/item/clothing/suit/storage/faction/upp/commando/hvh
	soft_armor = list(MELEE = 55, BULLET = 75, LASER = 75, ENERGY = 60, BOMB = 60, BIO = 45, FIRE = 60, ACID = 65)

/obj/item/clothing/suit/storage/faction/upp/heavy
	name = "\improper UH7重型板甲"
	desc = "一套极其重型的防弹装甲, 在USL海盗中服役, UH7 (联合重型MK7) 以坚固耐用著称, 能够承受巨大的惩罚."
	icon_state = "upp_armor_heavy"
	slowdown = SLOWDOWN_ARMOR_HEAVY
	soft_armor = list(MELEE = 65, BULLET = 65, LASER = 65, ENERGY = 60, BOMB = 60, BIO = 10, FIRE = 60, ACID = 60)

/// Modified version of the armor for HvH combat. Stats are based on heavy armor, with tyr mark 2.
/obj/item/clothing/suit/storage/faction/upp/heavy/hvh
	soft_armor = list(MELEE = 60, BULLET = 80, LASER = 80, ENERGY = 65, BOMB = 60, BIO = 60, FIRE = 60, ACID = 70)

/obj/item/clothing/suit/storage/marine/smartgunner/upp
	name = "\improper UH7重型板甲"
	desc = "一套极其重型的防弹装甲, 在USL海盗中服役, UH7 (联合重型MK7) 以坚固耐用著称, 能够承受巨大的惩罚."
	icon_state = "upp_armor_heavy"
	slowdown = SLOWDOWN_ARMOR_HEAVY
	soft_armor = list(MELEE = 65, BULLET = 65, LASER = 65, ENERGY = 60, BOMB = 60, BIO = 10, FIRE = 60, ACID = 60)

/// Modified version of the armor for HvH combat. Stats are based on heavy armor, with tyr mark 2.
/obj/item/clothing/suit/storage/marine/smartgunner/upp/hvh
	soft_armor = list(MELEE = 60, BULLET = 80, LASER = 80, ENERGY = 65, BOMB = 60, BIO = 60, FIRE = 60, ACID = 70)

//===========================FREELANCER================================

/obj/item/clothing/suit/storage/faction/freelancer
	name = "\improper 自由职业者胸甲"
	desc = "一件由各种装甲板拼凑而成的装甲防护胸甲. 它保持得非常好, 因为工艺扎实, 设计也模仿了UPP和TGMC中的此类装甲."
	icon_state = "freelancer_armor"
	slowdown = SLOWDOWN_ARMOR_LIGHT
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	cold_protection_flags = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	heat_protection_flags =CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	soft_armor = list(MELEE = 50, BULLET = 60, LASER = 50, ENERGY = 60, BOMB = 40, BIO = 10, FIRE = 60, ACID = 50)
	attachments_by_slot = list(
		ATTACHMENT_SLOT_STORAGE,
		ATTACHMENT_SLOT_MODULE,
	)
	attachments_allowed = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/general,
	)
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/general,
	)

/obj/item/clothing/suit/storage/faction/freelancer/leader
	attachments_by_slot = list(
		ATTACHMENT_SLOT_STORAGE,
		ATTACHMENT_SLOT_MODULE,
	)
	attachments_allowed = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/ammo_mag/freelancer,
	)
	starting_attachments = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/ammo_mag/freelancer,
	)

/obj/item/clothing/suit/storage/faction/freelancer/leader/two
	attachments_allowed = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/ammo_mag/freelancer_two,
	)
	starting_attachments = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/ammo_mag/freelancer_two,
	)

/obj/item/clothing/suit/storage/faction/freelancer/leader/three
	attachments_allowed = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/ammo_mag/freelancer_three,
	)
	starting_attachments = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/ammo_mag/freelancer_three,
	)

/obj/item/clothing/suit/storage/faction/freelancer/medic
	attachments_by_slot = list(
		ATTACHMENT_SLOT_STORAGE,
		ATTACHMENT_SLOT_MODULE,
	)
	attachments_allowed = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/medical/freelancer,
	)
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/medical/freelancer,
	)



//this one is for CLF
/obj/item/clothing/suit/storage/faction/militia
	name = "\improper 殖民地民兵锁子甲"
	desc = "一件殖民地民兵成员穿的锁子甲, 由煮熟的皮革和一些现代装甲板制成. 虽然与大多数现代装甲相比显得原始, 但它赋予穿戴者几乎完美的机动性, 这符合当地殖民者的需求."
	icon_state = "rebel_armor"
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	cold_protection_flags = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	heat_protection_flags =CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	item_flags = SYNTH_RESTRICTED
	soft_armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 30, BOMB = 60, BIO = 30, FIRE = 30, ACID = 30)
	allowed = list(
		/obj/item/weapon/twohanded,
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/explosive/grenade,
		/obj/item/binoculars,
		/obj/item/weapon/combat_knife,
		/obj/item/attachable/bayonetknife,
		/obj/item/storage/belt/sparepouch,
		/obj/item/storage/holster/blade,
		/obj/item/weapon/baseballbat,
	)
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/suit/storage/CMB
	name = "\improper CMB夹克"
	desc = "一件由殖民地法警船员穿着的绿色夹克."
	icon_state = "CMB_jacket"
	blood_overlay_type = "coat"
	soft_armor = list(MELEE = 10, BULLET = 10, LASER = 10, ENERGY = 20, BOMB = 10, BIO = 10, FIRE = 10, ACID = 10)
	allowed = list(
		/obj/item/weapon/gun/,
		/obj/item/tank/emergency_oxygen,
		/obj/item/storage/belt/sparepouch,
		/obj/item/storage/holster/blade,
		/obj/item/storage/holster/belt,
	)

/obj/item/clothing/suit/storage/RO
	name = "\improper RO夹克"
	desc = "一件由TGMC人员穿着的绿色夹克. 背面有TerraGov的旗帜."
	icon_state = "RO_jacket"
	blood_overlay_type = "coat"
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	cold_protection_flags = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	heat_protection_flags =CHEST|GROIN|ARMS|LEGS|FEET|HANDS

/*===========================HELGHAST - MERCENARY================================*/

/obj/item/clothing/suit/storage/marine/veteran/mercenary
	name = "\improper K12陶瓷板甲"
	desc = "一套灰色重型陶瓷护甲,带有深蓝色点缀. 这是在该星区活动的一个未知雇佣兵组织的标准制服"
	icon_state = "mercenary_heavy_armor"
	soft_armor = list(MELEE = 75, BULLET = 62, LASER = 42, ENERGY = 38, BOMB = 40, BIO = 15, FIRE = 38, ACID = 38)
	slowdown = SLOWDOWN_ARMOR_LIGHT
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/weapon/baton,
		/obj/item/restraints/handcuffs,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/explosive/grenade,
		/obj/item/storage/bible,
		/obj/item/weapon/sword/machete,
		/obj/item/weapon/combat_knife,
	)

/obj/item/clothing/suit/storage/marine/veteran/mercenary/miner
	name = "\improper Y8装甲矿工背心"
	desc = "一套米色轻型护甲,专为采矿时提供防护而打造. 这是在该星区活动的一个未知雇佣兵组织的专用制服"
	icon_state = "mercenary_miner_armor"
	soft_armor = list(MELEE = 50, BULLET = 42, LASER = 42, ENERGY = 38, BOMB = 25, BIO = 15, FIRE = 38, ACID = 38)
	slowdown = SLOWDOWN_ARMOR_LIGHT
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/weapon/baton,
		/obj/item/restraints/handcuffs,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/explosive/grenade,
		/obj/item/storage/bible,
		/obj/item/weapon/sword/machete,
		/obj/item/weapon/combat_knife,
	)

/obj/item/clothing/suit/storage/marine/veteran/mercenary/engineer
	name = "\improper Z7装甲工程师背心"
	desc = "一套带有黄色点缀的蓝色护甲,专为在高度危险环境中建造时提供防护而打造. 这是在该星区活动的一个未知雇佣兵组织的专用制服"
	icon_state = "mercenary_engineer_armor"
	soft_armor = list(MELEE = 55, BULLET = 52, LASER = 42, ENERGY = 38, BOMB = 30, BIO = 15, FIRE = 38, ACID = 38)
	slowdown = SLOWDOWN_ARMOR_LIGHT
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/flashlight,
		/obj/item/ammo_magazine,
		/obj/item/weapon/baton,
		/obj/item/restraints/handcuffs,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/explosive/grenade,
		/obj/item/storage/bible,
		/obj/item/weapon/sword/machete,
		/obj/item/weapon/combat_knife,
	)

/obj/item/clothing/suit/storage/marine/som
	name = "\improper S12锁子甲"
	desc = "一件经过大幅改造的采矿装备,被重制用于通用战斗用途. 它很轻,但几乎提供不了什么防护."
	icon = 'icons/obj/clothing/suits/ert_suits.dmi'
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/ert_suits.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	icon_state = "som_armor"
	worn_icon_state = "som_armor"
	slowdown = SLOWDOWN_ARMOR_LIGHT
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	soft_armor = list(MELEE = 50, BULLET = 55, LASER = 55, ENERGY = 55, BOMB = 55, BIO = 55, FIRE = 55, ACID = 55)
	item_map_variant_flags = NONE

/obj/item/clothing/suit/storage/marine/som/veteran
	name = "\improper S12战斗锁子甲"
	desc = "一件经过大幅改造的采矿装备,被重制用于通用战斗用途. 似乎比同类装备经过了更进一步的改造. 因此更重,但也更坚固."
	icon_state = "som_armor_veteran"
	worn_icon_state = "som_armor_veteran"
	slowdown = SLOWDOWN_ARMOR_HEAVY
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	soft_armor = list(MELEE = 65, BULLET = 70, LASER = 70, ENERGY = 55, BOMB = 55, BIO = 55, FIRE = 55, ACID = 60)

/obj/item/clothing/suit/storage/marine/som/leader
	name = "\improper S13队长锁子甲"
	desc = "一件经过大幅改造的采矿装备,被重制用于通用战斗用途. 比同类装备经过了更广泛的改造,但也因此更重."
	icon_state = "som_armor_leader"
	worn_icon_state = "som_armor_leader"
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	soft_armor = list(MELEE = 55, BULLET = 50, LASER = 40, ENERGY = 55, BOMB = 55, BIO = 55, FIRE = 55, ACID = 60)

/obj/item/clothing/suit/storage/marine/icc
	name = "\improper Modelle/16战斗护甲"
	desc = "一件ICC身体护甲,由人员在近距离登舰作战时穿着,因为人员短缺,大多数ICC人员都兼任临时陆战队员. 能很好地防护大多数来源,尤其是爆炸."
	icon = 'icons/obj/clothing/suits/ert_suits.dmi'
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/ert_suits.dmi',
		slot_l_hand_str = 'icons/mob/inhands/items_lefthand_1.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items_righthand_1.dmi',
	)
	icon_state = "icc"
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	cold_protection_flags = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	heat_protection_flags =CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	soft_armor = list(MELEE = 50, BULLET = 60, LASER = 50, ENERGY = 60, BOMB = 70, BIO = 10, FIRE = 60, ACID = 50)
	item_map_variant_flags = NONE

/obj/item/clothing/suit/storage/marine/icc/guard
	name = "\improper Modelle/19战斗护甲"
	desc = "一件ICCGF身体护甲,由专业步兵穿着. 由于人力持续短缺,ICC部队中的大多数步兵行动都由临时人员执行,不过大多数真正的步兵师都素质很高,更常被称为\"卫队\". 能很好地防护大多数来源,并能完全防护爆炸."
	icon_state = "icc_guard"
	soft_armor = list(MELEE = 60, BULLET = 65, LASER = 40, ENERGY = 60, BOMB = 85, BIO = 10, FIRE = 55, ACID = 40)

/obj/item/clothing/suit/storage/marine/icc/guard/heavy
	name = "\improper Modelle/22\"胸甲骑兵\"战斗护甲"
	desc = "一件ICCGF身体护甲,由专业步兵穿着. 由于人力持续短缺,ICC部队中的大多数步兵行动都由临时人员执行,不过大多数真正的步兵师都素质很高,更常被称为\"卫队\". 能很好地防护大多数来源,并能完全防护爆炸."
	icon_state = "icc_guard_heavy"
	soft_armor = list(MELEE = 70, BULLET = 75, LASER = 40, ENERGY = 60, BOMB = 90, BIO = 10, FIRE = 55, ACID = 40)

//===========================SPEC OPS================================

/obj/item/clothing/suit/storage/marine/specops
	name = "防弹背心"
	desc = "民用型护甲,用于对抗近战和弹射物."
	icon = 'icons/mob/clothing/suits/ert_suits.dmi'
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/ert_suits.dmi',
	)
	icon_state = "specops_vest"
	soft_armor = list(MELEE = 30, BULLET = 50, LASER = 20, ENERGY = 25, BOMB = 30, BIO = 5, FIRE = 25, ACID = 30)
	slowdown = SLOWDOWN_ARMOR_LIGHT
	armor_protection_flags = CHEST|GROIN
	armor_features_flags = NONE
	item_map_variant_flags = NONE

/obj/item/clothing/suit/storage/marine/specops/support
	name = "防弹背心"
	desc = "民用型护甲,用于对抗近战和弹射物."
	icon_state = "specops_vest_support"

/obj/item/clothing/suit/storage/marine/specops/medic
	name = "防弹背心"
	desc = "民用型护甲,用于对抗近战和弹射物."
	icon_state = "specops_vest_medic"

/obj/item/clothing/suit/storage/marine/specops/leader
	name = "防弹背心"
	desc = "民用型护甲,用于对抗近战和弹射物. 附带战术护肘."
	icon_state = "specops_vest_leader"
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 40, ENERGY = 35, BOMB = 30, BIO = 5, FIRE = 25, ACID = 30)
	slowdown = SLOWDOWN_ARMOR_MEDIUM

//===========================V.S.D================================

/obj/item/clothing/suit/storage/marine/vsd
	name = "Crasher多威胁轻型防弹护甲"
	desc = "维亚切斯拉夫安保队的主要身体护甲. 保护使用者免受大多数子弹口径的伤害."
	icon = 'icons/obj/clothing/suits/ert_suits.dmi'
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/suits/ert_suits.dmi',
	)
	icon_state = "vsd_main_larmor"
	worn_icon_state = "vsd_main_larmor"
	slowdown = SLOWDOWN_ARMOR_LIGHT
	soft_armor = list(MELEE = 35, BULLET = 50, LASER = 20, ENERGY = 15, BOMB = 30, BIO = 10, FIRE = 25, ACID = 30)
	item_map_variant_flags = NONE
	armor_features_flags = NONE

/obj/item/clothing/suit/storage/marine/vsd/desert
	name = "Crasher多威胁轻型防弹护甲"
	icon_state = "vsd_main_larmor_d"
	worn_icon_state = "vsd_main_larmor_d"

/obj/item/clothing/suit/storage/marine/vsd/secondary
	name = "Crasher多威胁轻型防弹护甲"
	icon_state = "vsd_secondary_larmor"
	worn_icon_state = "vsd_secondary_larmor"


/obj/item/clothing/suit/storage/marine/vsd/marmor
	name = "Crasher多威胁中型防弹护甲"
	desc = "维亚切斯拉夫安保队不常使用的身体护甲,通常由工程师使用. 保护使用者免受大多数子弹口径的伤害."
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	icon_state = "vsd_marmor"
	worn_icon_state = "vsd_marmor"
	soft_armor = list(MELEE = 40, BULLET = 70, LASER = 20, ENERGY = 15, BOMB = 40, BIO = 10, FIRE = 25, ACID = 30)

/obj/item/clothing/suit/storage/marine/vsd/marmor/desert
	name = "Crasher多威胁中型防弹护甲"
	icon_state = "vsd_marmor_d"
	worn_icon_state = "vsd_marmor_d"

/obj/item/clothing/suit/storage/marine/vsd/marmor/upp
	name = "Crasher多威胁中型防弹护甲"
	icon_state = "vsd_marmor_upp"
	worn_icon_state = "vsd_marmor_upp"

/obj/item/clothing/suit/storage/marine/vsd/harmor
	name = "Crasher多威胁重型防弹护甲"
	desc = "维亚切斯拉夫安保队的队长护甲,很少发给普通士兵. 保护使用者免受大多数子弹口径的伤害."
	slowdown = SLOWDOWN_ARMOR_HEAVY
	icon_state = "vsd_harmor"
	worn_icon_state = "vsd_harmor"
	soft_armor = list(MELEE = 45, BULLET = 75, LASER = 20, ENERGY = 15, BOMB = 45, BIO = 10, FIRE = 25, ACID = 30)

/obj/item/clothing/suit/storage/marine/vsd/harmor/upp
	name = "Crasher多威胁重型防弹护甲"
	icon_state = "vsd_harmor_upp"
	worn_icon_state = "vsd_harmor_upp"

/obj/item/clothing/suit/storage/marine/vsd/juggernaut
	name = "Crasher多威胁\"主宰\"防弹护甲"
	desc = "维亚切斯拉夫安保队的主宰套装,发给最优秀且值得信赖的老兵. 保护使用者免受几乎所有子弹口径的伤害."
	icon = 'icons/obj/clothing/suits/ert_suits.dmi'
	slowdown = SLOWDOWN_ARMOR_VERY_HEAVY
	icon_state = "vsd_juggernaut_one"
	worn_icon_state = "vsd_juggernaut_one"
	soft_armor = list(MELEE = 50, BULLET = 90, LASER = 20, ENERGY = 15, BOMB = 50, BIO = 10, FIRE = 25, ACID = 30)

/obj/item/clothing/suit/storage/marine/vsd/eod
	name = "Crasher多威胁\"辛迪加\"防弹护甲"
	desc = "维亚切斯拉夫安保队的辛迪加配发套装. 保护使用者免受几乎所有子弹口径的伤害. 内侧贴着一张标签,上面写着\"实验性:由辛迪加提供\"."
	icon = 'icons/obj/clothing/suits/ert_suits.dmi'
	slowdown = SLOWDOWN_ARMOR_VERY_HEAVY
	icon_state = "vsd_juggernaut_two"
	worn_icon_state = "vsd_juggernaut_two"
	soft_armor = list(MELEE = 50, BULLET = 75, LASER = 20, ENERGY = 15, BOMB = 100, BIO = 10, FIRE = 25, ACID = 30)
