/obj/item/phone
	name = "红色电话"
	desc = "万一出了什么事..."
	icon = 'icons/obj/items/items.dmi'
	icon_state = "red_phone"
	force = 3
	throwforce = 2
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("calls", "rings")
	hitsound = 'sound/weapons/ring.ogg'

/obj/item/clock
	name = "数字时钟"
	desc = "一个电池供电的时钟,计时误差大约在5秒内...它从来就没那么准过."
	icon = 'icons/obj/device.dmi'
	icon_state = "digital_clock"
	force = 3
	throwforce = 2
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clock/examine(mob/user, distance, infix, suffix)
	. = ..()
	. += "The [src] reads: [GLOB.current_date_string] - [stationTimestamp()]"

/obj/item/bananapeel
	name = "香蕉皮"
	desc = "一块香蕉皮."
	icon = 'icons/obj/items/harvest.dmi'
	icon_state = "banana_peel"
	worn_icon_state = "banana_peel"
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 4
	throw_range = 20

/obj/item/bananapeel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, 0.4 SECONDS, 0.2 SECONDS)

/obj/item/gift
	name = "礼物"
	desc = "一件包装好的物品."
	icon = 'icons/obj/items/items.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/containers_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/containers_right.dmi',
	)
	icon_state = "gift3"
	var/size = 3
	var/obj/item/gift = null
	worn_icon_state = "gift"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/staff
	name = "巫师法杖"
	desc = "显然是巫师使用的法杖."
	icon = 'icons/obj/wizard.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/toys_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/toys_right.dmi',
	)
	icon_state = "staff"
	force = 3
	throwforce = 5
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("bludgeons", "whacks", "disciplines")

/obj/item/staff/broom
	name = "扫帚"
	desc = "用于打扫,以及一边咯咯笑一边飞入夜空.不包含黑猫."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "broom"

/obj/item/skub
	desc = "这是skub."
	name = "skub"
	icon = 'icons/obj/items/items.dmi'
	icon_state = "skub"
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("skubs")

/obj/item/ectoplasm
	name = "灵质"
	desc = "阴森"
	gender = PLURAL
	icon = 'icons/obj/wizard.dmi'
	icon_state = "ectoplasm"

/obj/item/minerupgrade
	name = "矿工升级"
	desc = "子类型物品,不应存在."
	icon = 'icons/obj/mining_drill.dmi'
	icon_state = "mining_drill_reinforceddisplay"
	w_class = WEIGHT_CLASS_NORMAL
	/// Used to determine the type of upgrade the miner is going to receive. Has to be a string which is defined in miner.dm or it won't work.
	var/uptype

/obj/item/minerupgrade/reinforcement
	name = "强化组件箱"
	desc = "一个折叠得很整齐的强化组件箱,用于替换普通采矿井中使用的脆弱组件."
	icon_state = "mining_drill_reinforceddisplay"
	uptype = "reinforced components"

/obj/item/minerupgrade/overclock
	name = "高效钻头"
	desc = "一个带有几个泵和大型钻头的箱子,用于替换普通采矿井中使用的标准钻头,以实现更快的开采."
	icon_state = "mining_drill_overclockeddisplay"
	uptype = "high-efficiency drill"

/obj/item/minerupgrade/automatic
	name = "采矿电脑"
	desc = "一台可以自动化采矿井的小型电脑,减少了对人工监管的需求."
	icon_state = "mining_drill_automaticdisplay"
	uptype = "mining computer"

/obj/item/ai_target_beacon
	name = "AI链接远程瞄准器"
	desc = "一组小型伺服机构和齿轮,连接着电池、天线和电路.将其安装到迫击炮上,可让舰载AI远程瞄准它."
	icon = 'icons/obj/items/items.dmi'
	icon_state = "modkit"

/obj/structure/bed/namaz
	name = "祈祷毯"
	desc = "非常清真的祈祷毯."
	icon = 'icons/obj/items/priest.dmi'
	icon_state = "namaz"
	buckle_flags = CAN_BUCKLE|BUCKLE_PREVENTS_PULL
	buckle_lying = 0
	buckling_y = 6
	dir = NORTH
	foldabletype = /obj/item/namaz
	accepts_bodybag = FALSE
	base_bed_icon = "namaz"

/obj/item/namaz
	name = "祈祷毯"
	desc = "非常清真的祈祷毯."
	icon = 'icons/obj/items/priest.dmi'
	icon_state = "rolled_namaz"
	w_class = WEIGHT_CLASS_SMALL
	var/rollertype = /obj/structure/bed/namaz

/obj/item/namaz/attack_self(mob/user)
	deploy_roller(user, user.loc)

/obj/item/namaz/afterattack(obj/target, mob/user , proximity)
	if(!proximity)
		return
	if(isturf(target))
		var/turf/T = target
		if(!T.density)
			deploy_roller(user, target)

/obj/item/namaz/proc/deploy_roller(mob/user, atom/location)
	var/obj/structure/bed/namaz/R = new rollertype(location)
	user.temporarilyRemoveItemFromInventory(src)
	user.visible_message(span_notice("[user]放下了[R]."), span_notice("你放下了[R]."))
	qdel(src)

/obj/item/storage/bible/koran
	name = "古兰经"
	icon = 'icons/obj/items/priest.dmi'
	icon_state = "Koran"
	deity_name = "Allah"
	actions_types = list(/datum/action/item_action)

/obj/item/storage/bible/koran/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_w_class = 3
	storage_datum.storage_slots = 1

/obj/item/storage/bible/koran/attack_self(mob/living/carbon/human/activator)
	TIMER_COOLDOWN_START(activator, "KoranSpam", 5 SECONDS)
	if(TIMER_COOLDOWN_RUNNING(activator, "Koran"))
		activator.balloon_alert(activator, "真主已经帮助了你")
		if(TIMER_COOLDOWN_RUNNING(activator, "KoranSpam"))
			activator.adjust_brain_loss(1, TRUE)
			return
		return
	if(!((activator.religion == "Islam (Shia)") || (activator.religion == "Islam (Sunni)")))
		activator.balloon_alert(activator, "异教徒无法使用此物")
		return
	if(locate(/obj/structure/bed/namaz, activator.loc))
		activator.say("أَشْهَدُ أَنْ لَا إِلَٰهَ إِلَّا ٱللَّهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا رَسُولُ ٱللَّهِ")
		TIMER_COOLDOWN_START(activator, "Koran", 10 MINUTES)
		if(prob(10))
			cell_explosion(activator, 150, 150)
		if(prob(80))
			activator.heal_limb_damage(50, 50, TRUE)
			activator.adjust_clone_loss(-10)
			activator.playsound_local(loc, 'sound/hallucinations/im_here1.ogg', 50)
	else
		activator.balloon_alert(activator, "此地并非圣地")

/obj/item/storage/bible/koran/afterattack(mob/M, mob/living/carbon/human/user, proximity)
	. = ..()
	if(!proximity)
		return

	if(TIMER_COOLDOWN_RUNNING(user, "KoranSpam"))
		user.adjust_brain_loss(1, TRUE)
		return
	TIMER_COOLDOWN_START(user, "KoranSpam", 5 SECONDS)

	if(!((user.religion == "Islam (Shia)") || (user.religion == "Islam (Sunni)")))
		user.balloon_alert(user, "异教徒无法使用此物")
		return

	var/client/C = M.client
	if(GLOB.admins.Find(C, 1, 0))
		if(TIMER_COOLDOWN_RUNNING(user, "Koran"))
			user.balloon_alert(user, "真主已经帮助了你")
			return
		TIMER_COOLDOWN_START(user, "Koran", 10 MINUTES)
		if(prob(10))
			cell_explosion(M, 1984, 1714, EXPLOSION_FALLOFF_SHAPE_LINEAR)
			playsound(M, 'sound/misc/Dying.ogg', 15, 1)

/obj/item/rosary
	name = "念珠"
	desc = "一串赤铁矿珠银念珠"
	icon = 'icons/obj/items/items.dmi'
	icon_state = "rosary"
	worn_icon_state = "rosary"
	w_class = WEIGHT_CLASS_TINY
