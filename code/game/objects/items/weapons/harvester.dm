//Vali Sword
/obj/item/weapon/sword/harvester
	name = "\improper HP-S收割者刀刃"
	desc = "泰拉政府陆战队的实验性高能点-奇点\"收割者\"刀刃.一种先进武器,以纯粹的蛮力换取在装填特定试剂后施加各种削弱效果的能力.装填后激活以预备一次效果使用.当连接到瓦利系统时,它还能从击中的外星生命体上采集物质."
	icon = 'icons/obj/items/vali.dmi'
	icon_state = "vali_sword"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/vali_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/vali_right.dmi',
	)
	worn_icon_state = "vali_sword"
	force = 60
	attack_speed = 12
	w_class = WEIGHT_CLASS_BULKY

/obj/item/weapon/sword/harvester/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/harvester)

/obj/item/weapon/sword/harvester/equipped(mob/user, slot)
	. = ..()
	toggle_item_bump_attack(user, TRUE)

/obj/item/weapon/sword/harvester/dropped(mob/user)
	. = ..()
	toggle_item_bump_attack(user, FALSE)

//Vali Knife
/obj/item/weapon/combat_knife/harvester
	name = "\improper HP-S收割者匕首"
	desc = "泰拉政府陆战队的实验性高能点-奇点\"收割者\"匕首.是HP-S收割者刀刃的先进版本,缩小到标准配发靴刀的尺寸.它以收割者刀刃的尺寸和威力换取了更小的体型,副作用是极微量的化学储存,但它仍保留了向目标施加削弱效果的能力.装填后激活以预备一次效果使用.当连接到瓦利系统时,它还能从击中的外星生命体上采集物质."
	icon = 'icons/obj/items/vali.dmi'
	icon_state = "vali_knife"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/vali_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/vali_right.dmi',
	)
	worn_icon_state = "vali_knife"
	w_class = WEIGHT_CLASS_SMALL
	force = 25
	throwforce = 15
	throw_speed = 3
	throw_range = 6
	attack_speed = 8
	sharp = IS_SHARP_ITEM_ACCURATE
	hitsound = 'sound/weapons/slash.ogg'

/obj/item/weapon/combat_knife/harvester/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/harvester, 5)

/obj/item/weapon/combat_knife/harvester/equipped(mob/user, slot)
	. = ..()
	toggle_item_bump_attack(user, TRUE)

/obj/item/weapon/combat_knife/harvester/dropped(mob/user)
	. = ..()
	toggle_item_bump_attack(user, FALSE)

//Vali Claymore (That thing was too big to be called a sword. Too big, too thick, too heavy, and too rough, it was more like a large hunk of iron.)
/obj/item/weapon/twohanded/glaive/harvester
	name = "\improper HP-S收割者双手剑"
	desc = "泰拉政府陆战队的实验性高能点-奇点\"收割者\"刀刃.一种先进武器,以纯粹的蛮力换取在装填特定试剂后施加各种削弱效果的能力.装填后激活以预备一次效果使用.当连接到瓦利系统时,它还能从击中的外星生命体上采集物质.这个特定版本被放大以符合旧世界双手剑的设计.只需握紧剑柄即可激活."
	icon = 'icons/obj/items/vali.dmi'
	icon_state = "vali_claymore"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/vali_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/vali_right.dmi',
	)
	worn_icon_state = "vali_claymore"
	attack_speed = 24
	resistance_flags = NONE

/obj/item/weapon/twohanded/glaive/harvester/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/harvester, 60)

/obj/item/weapon/twohanded/glaive/harvester/wield(mob/user)
	. = ..()
	if(!.)
		return
	toggle_item_bump_attack(user, TRUE)

/obj/item/weapon/twohanded/glaive/harvester/unwield(mob/user)
	. = ..()
	if(!.)
		return
	toggle_item_bump_attack(user, FALSE)

//Vali rapier
/obj/item/weapon/sword/officer/valirapier
	name = "\improper HP-C收割者刺剑"
	desc = "一把看起来极其昂贵的刀刃,有着金色的手柄和雕纹,尽管外观华丽,在战斗中却出奇地有效,内置瓦利模块."
	icon = 'icons/obj/items/vali.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/vali_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/vali_right.dmi',
	)
	icon_state = "rapier"
	worn_icon_state = "rapier"
	force = 60
	attack_speed = 5

/obj/item/weapon/sword/officer/valirapier/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/harvester)
	RemoveElement(/datum/element/strappable)

//Vali Spear
/obj/item/weapon/twohanded/spear/tactical/harvester
	name = "\improper HP-S收割者长矛"
	desc = "泰拉政府陆战队的实验性高能点-奇点\"收割者\"长矛.一种先进武器,以纯粹的蛮力换取在装填特定试剂后施加各种削弱效果的能力.装填后激活以预备一次效果使用.当连接到瓦利系统时,它还能从击中的外星生命体上采集物质."
	icon = 'icons/obj/items/vali.dmi'
	icon_state = "vali_spear"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/vali_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/vali_right.dmi',
	)
	worn_icon_state = "vali_spear"
	force = 32
	force_activated = 60
	throwforce = 60

/obj/item/weapon/twohanded/spear/tactical/harvester/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/harvester)

///////////////////////////////////////////////////////////////////////
////////////////// VAL-HAL-A, the Vali Halberd ////////////////////////
///////////////////////////////////////////////////////////////////////
/obj/item/weapon/twohanded/glaive/halberd/harvester
	name = "\improper VAL-HAL-A戟式收割者"
	desc = "TerraGov陆战队的尖端\"收割者\"戟,配备实验性等离子调节器.这是一种先进武器,将纯粹的力量与装载特定试剂后施加多种削弱效果的能力结合在一起,但需要双手使用.装填后激活以准备一次性的效果.当连接到瓦利系统时,它还能从击中的外星生命体身上采集物质."
	icon = 'icons/obj/items/vali.dmi'
	icon_state = "VAL-HAL-A"
	worn_icon_state = "VAL-HAL-A"
	worn_icon_list = list(
		slot_back_str = 'icons/mob/clothing/back.dmi',
		slot_l_hand_str = 'icons/mob/inhands/weapons/vali_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/vali_right.dmi',
	)
	force = 40
	force_activated = 95 //Reminder: putting trama inside deals 60% additional damage
	item_flags = TWOHANDED
	resistance_flags = 0 //override glavie
	attack_speed = 10 //Default is 7, this has slower attack
	reach = 2 //like spear
	slowdown = 0 //Slowdown in back slot
	var/wielded_slowdown = 0.5 //Slowdown in hands, wielded
	var/wield_delay = 0.8 SECONDS

/obj/item/weapon/twohanded/glaive/halberd/harvester/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/harvester)

// Stuff which should ideally be in /twohanded code
/obj/item/weapon/twohanded/glaive/halberd/harvester/unwield(mob/user)
	. = ..()
	user.remove_movespeed_modifier(MOVESPEED_ID_WIELDED_SLOWDOWN)


/obj/item/weapon/twohanded/glaive/halberd/harvester/wield(mob/user)
	. = ..()

	if (!(item_flags & WIELDED))
		return

	if(wield_delay > 0)
		if (!do_after(user, wield_delay, IGNORE_LOC_CHANGE, user, BUSY_ICON_HOSTILE, null, PROGRESS_CLOCK))
			unwield(user)
			return

	user.add_movespeed_modifier(MOVESPEED_ID_WIELDED_SLOWDOWN, TRUE, 0, NONE, TRUE, wielded_slowdown)
