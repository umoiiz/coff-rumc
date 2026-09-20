/obj/item/storage/backpack
	name = "背包"
	desc = "你把它背在背上, 然后把物品放进去."
	icon_state = "backpack"
	icon = 'icons/obj/items/storage/backpack.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/backpacks_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/backpacks_right.dmi',
	)
	worn_icon_state = "backpack"
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		)
	w_class = WEIGHT_CLASS_BULKY
	equip_slot_flags = ITEM_SLOT_BACK	//ERROOOOO
	storage_type = /datum/storage/backpack

/obj/item/storage/backpack/attackby(obj/item/I, mob/user, params)
	. = ..()

	if(storage_datum.use_sound)
		playsound(loc, storage_datum.use_sound, 15, 1, 6)

/obj/item/storage/backpack/equipped(mob/user, slot)
	if(slot == SLOT_BACK)
		mouse_opacity = 2 //so it's easier to click when properly equipped.
		if(storage_datum.use_sound)
			playsound(loc, storage_datum.use_sound, 15, 1, 6)
	return ..()

/obj/item/storage/backpack/dropped(mob/user)
	mouse_opacity = initial(mouse_opacity)
	return ..()

/obj/item/storage/backpack/vendor_equip(mob/user)
	. = ..()
	return user.equip_to_appropriate_slot(src)

/*
* Backpack Types
*/

/obj/item/storage/backpack/holding
	name = "次元袋"
	desc = "一个能打开通往局部蓝空间口袋的背包."
	icon_state = "holdingpack"
	storage_type = /datum/storage/backpack/holding

/obj/item/storage/backpack/holding/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/storage/backpack/holding))
		return ..()
	to_chat(user, span_warning("两个设备的蓝空间接口相互冲突并发生故障."))
	qdel(I)

/obj/item/storage/backpack/santabag
	name = "圣诞老人的礼物袋"
	desc = "太空圣诞老人用它来在圣诞节给太空中所有乖孩子送玩具! 哇, 它可真大!"
	icon_state = "giftbag0"
	worn_icon_state = "giftbag"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/backpack/santabag

/obj/item/storage/backpack/cultpack
	name = "奖杯架"
	desc = "它既可用于携带额外装备, 也可用于自豪地宣告你的疯狂."
	icon_state = "cultpack"

/obj/item/storage/backpack/clown
	name = "Giggles von Honkerton"
	desc = "这是由Honk! Co. 制造的背包."
	icon_state = "clownpack"

/obj/item/storage/backpack/corpsman
	name = "医疗背包"
	desc = "这是一个专为无菌环境使用而设计的背包."
	icon_state = "medicalpack"

/obj/item/storage/backpack/security
	name = "安保背包"
	desc = "这是一个非常坚固的背包."
	icon_state = "securitypack"

/obj/item/storage/backpack/captain
	name = "队长的背包"
	desc = "这是一个专为军官制作的特别背包."
	icon_state = "captainpack"

/obj/item/storage/backpack/industrial
	name = "工业背包"
	desc = "这是一个适合空间站日常苦工的耐用背包."
	icon_state = "engiepack"
	worn_icon_state = "engiepack"

/obj/item/storage/backpack/toxins
	name = "实验室背包"
	desc = "这是一个为实验室和其他科研机构使用而设计的轻型背包."
	icon_state = "toxpack"

/obj/item/storage/backpack/hydroponics
	name = "草药师背包"
	desc = "这是一个有许多口袋的绿色背包, 用来存放植物和工具."
	icon_state = "hydpack"

/obj/item/storage/backpack/genetics
	name = "基因学家背包"
	desc = "这是一个配有磁盘和其他工作场所工具插槽的背包."
	icon_state = "genpack"

/obj/item/storage/backpack/virology
	name = "无菌背包"
	desc = "这是一个无菌背包, 能够抵御不同病原体进入其织物."
	icon_state = "viropack"

/obj/item/storage/backpack/chemistry
	name = "化学背包"
	desc = "这是一个橙色的背包,设计用于存放烧杯、药瓶和瓶子."
	icon_state = "chempack"

/*
* Satchel Types
*/

/obj/item/storage/backpack/satchel
	name = "皮革挎包"
	desc = "一个非常精致的挎包,由优质皮革制成."
	icon_state = "satchel"
	storage_type = /datum/storage/backpack/satchel

/obj/item/storage/backpack/satchel/withwallet/PopulateContents()
	new /obj/item/storage/wallet/random( src )

/obj/item/storage/backpack/satchel/som
	name = "采矿挎包"
	desc = "一个起源可追溯到采矿殖民地的挎包."
	icon_state = "som_satchel"
	worn_icon_state = "som_satchel"

/obj/item/storage/backpack/satchel/norm
	name = "挎包"
	desc = "一个看起来很时髦的挎包."
	icon_state = "satchel-norm"

/obj/item/storage/backpack/satchel/rugged
	name = "挎包"
	desc = "一个适合各类工人的坚固挎包."
	icon_state = "satchel-norm"

/obj/item/storage/backpack/satchel/eng
	name = "工业挎包"
	desc = "一个带有额外口袋的坚固挎包."
	icon_state = "satchel-eng"

/obj/item/storage/backpack/satchel/med
	name = "医疗挎包"
	desc = "一个用于医疗部门的无菌挎包."
	icon_state = "satchel-med"

/obj/item/storage/backpack/satchel/vir
	name = "病毒学家挎包"
	desc = "一个带有病毒学家配色的无菌挎包."
	icon_state = "satchel-vir"

/obj/item/storage/backpack/satchel/chem
	name = "化学家挎包"
	desc = "一个带有化学家配色的无菌挎包."
	icon_state = "satchel-chem"

/obj/item/storage/backpack/satchel/gen
	name = "遗传学家挎包"
	desc = "一个带有遗传学家配色的无菌挎包."
	icon_state = "satchel-gen"

/obj/item/storage/backpack/satchel/tox
	name = "科学家挎包"
	desc = "用于存放研究材料."
	icon_state = "satchel-tox"

/obj/item/storage/backpack/satchel/sec
	name = "安保挎包"
	desc = "一个用于安保相关需求的坚固挎包."
	icon_state = "satchel-sec"

/obj/item/storage/backpack/satchel/hyd
	name = "水培挎包"
	desc = "一个用于植物相关工作的绿色挎包."
	icon_state = "satchel_hyd"

/obj/item/storage/backpack/satchel/cap
	name = "队长的挎包"
	desc = "一个军官专属的挎包."
	icon_state = "satchel-cap"

//ERT backpacks.
/obj/item/storage/backpack/ert
	name = "应急响应小组背包"
	desc = "一个带有许多口袋的宽敞背包,供应急响应小组成员使用."
	icon_state = "ert_commander"

//Commander
/obj/item/storage/backpack/ert/commander
	name = "应急响应小组指挥官背包"
	desc = "一个带有许多口袋的宽敞背包,由应急响应小组指挥官佩戴."

//Security
/obj/item/storage/backpack/ert/security
	name = "应急响应小组安保背包"
	desc = "一个带有许多口袋的宽敞背包,由应急响应小组安保成员佩戴."
	icon_state = "ert_security"

//Engineering
/obj/item/storage/backpack/ert/engineer
	name = "应急响应小组工程师背包"
	desc = "一个带有许多口袋的宽敞背包,由应急响应小组工程成员佩戴."
	icon_state = "ert_engineering"

//Medical
/obj/item/storage/backpack/ert/medical
	name = "应急响应小组医疗背包"
	desc = "一个带有许多口袋的宽敞背包,由应急响应小组医疗成员佩戴."
	icon_state = "ert_medical"

/*========================== MARINE BACKPACKS ================================
==========================================================================*/

/obj/item/storage/backpack/marine
	name = "\improper 轻型IMP背包"
	desc = "TGMC部队的标准配发背包.设计用于将装备投入战场."
	icon_state = "marinepack"
	worn_icon_state = "marinepack"

/obj/item/storage/backpack/marine/standard
	name = "\improper 轻型IMP背包"
	desc = "TGMC部队的标准配发背包.设计用于将装备投入战场."

/obj/item/storage/backpack/marine/standard/molle
	name = "\improper T16 MOLLE背包"
	desc = "Crowford Armory Union根据TGMC的军事订单开发的最新背包.得益于新MOLLE固定系统的引入,它制造出的腰包和背包在容量和便携重量上毫不逊色,同时还减小了原本挂在背后腰带上的背包尺寸."
	worn_icon_list = list(
		slot_back_str = 'icons/mob/clothing/back.dmi',
		slot_l_hand_str = 'icons/mob/inhands/equipment/backpacks_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/backpacks_right.dmi',
	)
	icon_state = "MOLLEbackpack"
	worn_icon_state = "MOLLEbackpack"

/obj/item/storage/backpack/marine/satchel/molle
	name = "\improper T13 MOLLE挎包"
	desc = "Crowford Armory Union根据TGMC的军事订单开发的最新挎包.得益于新MOLLE固定系统的引入,它制造出的腰包和背包在容量和便携重量上毫不逊色,同时还减小了原本挂在背后腰带上的背包尺寸."
	worn_icon_list = list(
		slot_back_str = 'icons/mob/clothing/back.dmi',
		slot_l_hand_str = 'icons/mob/inhands/equipment/backpacks_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/backpacks_right.dmi',
	)
	icon_state = "MOLLEbeltbag"
	worn_icon_state = "MOLLEbeltbag"

/obj/item/storage/backpack/marine/standard/scav
	name = "拾荒者背包"
	desc = "相当酷炫的背包."
	worn_icon_list = list(
		slot_back_str = 'icons/mob/clothing/back.dmi')
	icon_state = "scavpack"
	worn_icon_state = "scavpack"

/obj/item/storage/backpack/marine/corpsman
	name = "\improper TGMC医护兵背包"
	desc = "TGMC医护兵佩戴的标准配发背包.你可以通过插入除颤器为其充电."
	icon_state = "marinepackm"
	worn_icon_state = "marinepackm"
	//. Starts with a high capacity energy cell.
	var/obj/item/cell/high/cell
	var/icon_skin

/obj/item/storage/backpack/marine/corpsman/Initialize(mapload, ...)
	. = ..()
	cell = new
	icon_skin = icon_state
	update_icon()

/obj/item/storage/backpack/marine/corpsman/proc/use_charge(mob/user, amount = 0, mention_charge = TRUE)
	var/warning = ""
	if(amount > cell.charge)
		playsound(src, 'sound/machines/buzz-two.ogg', 25, 1)
		if(cell.charge)
			warning = span_warning("[src]的除颤器充电单元发出警告蜂鸣,其电池仅有足够电量将除颤器部分充电[cell.charge]量.")
		else
			warning = span_warning("[src]的除颤器充电单元发出警告蜂鸣,因为其电池电量已完全耗尽.")
	else
		playsound(src, 'sound/machines/ping.ogg', 25, 1)
		warning = span_notice("[src]的除颤器充电单元愉快地发出提示音,成功为除颤器充能.")
	cell.charge -= min(cell.charge, amount)
	if(mention_charge)
		to_chat(user, span_notice("[warning]<b>剩余电量: [cell.charge]/[cell.maxcharge]</b>"))
	update_icon()

/obj/item/storage/backpack/marine/corpsman/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("其除颤器充电单元装有已充电的电池,读数计数器处于活动状态. <b>剩余电量: [cell.charge]/[cell.maxcharge]</b>")
	else
		. += span_warning("其除颤器充电单元未安装电池!")

/obj/item/storage/backpack/marine/corpsman/update_icon_state()
	. = ..()
	icon_state = icon_skin
	if(cell?.charge >= 0)
		switch(PERCENT(cell.charge/cell.maxcharge))
			if(75 to INFINITY)
				icon_state += "_100"
			if(50 to 74.9)
				icon_state += "_75"
			if(25 to 49.9)
				icon_state += "_50"
			if(0.1 to 24.9)
				icon_state += "_25"
	else
		icon_state += "_0"

/obj/item/storage/backpack/marine/corpsman/MouseDrop_T(obj/item/W, mob/living/user) //Dragging the defib/power cell onto the backpack will trigger its special functionality.
	var/obj/item/defibrillator/defib
	if(istype(W, /obj/item/defibrillator))
		defib = W
	else if(istype(W, /obj/item/clothing/gloves/defibrillator))
		var/obj/item/clothing/gloves/defibrillator/defib_gloves = W
		defib = defib_gloves.internal_defib
	if(defib)
		if(cell)
			var/charge_difference = defib.dcell.maxcharge - defib.dcell.charge
			if(charge_difference) //If the defib has less than max charge, recharge it.
				use_charge(user, charge_difference) //consume an appropriate amount of charge
				defib.dcell.charge += min(charge_difference, cell.charge) //Recharge the defibrillator battery with the lower of the difference between its present and max cap, or the remaining charge
				defib.update_icon()
			else
				to_chat(user, span_warning("该除颤器已处于最大电量!"))
		else
			to_chat(user, span_warning("[src]的除颤器充电单元未安装电池!"))
	else if(istype(W, /obj/item/cell))
		if(user.drop_held_item())
			W.loc = null
			var/replace_install = "You replace the cell in [src]'s defibrillator recharge unit."
			if(!cell)
				replace_install = "You install a cell in [src]'s defibrillator recharge unit."
			else
				cell.update_icon()
				user.put_in_hands(cell)
			cell = W
			to_chat(user, span_notice("[replace_install] <b>剩余电量: [cell.charge]/[cell.maxcharge]</b>"))
			playsound(user, 'sound/weapons/guns/interact/rifle_reload.ogg', 25, 1, 5)
			update_icon()
	return ..()

/obj/item/storage/backpack/marine/corpsman/satchel
	name = "\improper TGMC医护兵挎包"
	desc = "一些TGMC医护兵携带的重型挎包.你可以通过插入除颤器为其充电."
	icon_state = "marinesatm"
	worn_icon_state = "marinesatm"
	cell = /obj/item/cell/apc
	storage_type = /datum/storage/backpack/satchel

/obj/item/storage/backpack/marine/tech
	name = "\improper TGMC技术员背包"
	desc = "TGMC技术员佩戴的标准配发背包.经过特殊装备,可存放哨戒炮和HSG-102炮台部件."
	icon_state = "marinepackt"
	worn_icon_state = "marinepackt"
	storage_type = /datum/storage/backpack/tech

/obj/item/storage/backpack/marine/satchel
	name = "\improper TGMC挎包"
	desc = "一些TGMC士兵和支援人员携带的重型挎包."
	icon_state = "marinesat"
	worn_icon_state = "marinesat"
	storage_type = /datum/storage/backpack/satchel

/obj/item/storage/backpack/marine/satchel/green
	name = "\improper 绿色TGMC挎包"
	icon_state = "marinesat_green"

/obj/item/storage/backpack/marine/satchel/tech
	name = "\improper TGMC技术员挎包"
	desc = "一些TGMC技术员携带的重型挎包.可存放ST-580点防御哨戒炮和弹药."
	icon_state = "marinesatt"
	worn_icon_state = "marinesatt"
	storage_type = /datum/storage/backpack/satchel/tech

/obj/item/storage/backpack/marine/smock
	name = "\improper M3狙击手罩衣"
	desc = "一件经过特殊设计的罩衣,带有满足你所有狙击需求的口袋."
	icon_state = "smock"
	storage_type = /datum/storage/backpack/no_delay

/obj/item/storage/backpack/marine/duffelbag
	name = "\improper TGMC行李袋"
	desc = "一个难以够到的背包,没有取出延迟但难以取用. \
	任何小队成员都可以通过右键轻松访问其存储空间."
	icon = 'icons/obj/items/storage/duffelbag.dmi'
	icon_state = "duffel"
	worn_icon_state = "duffel"
	storage_type = /datum/storage/backpack/duffelbag

/obj/item/storage/backpack/marine/duffelbag/equipped(mob/equipper, slot)
	. = ..()
	if(slot == SLOT_BACK)
		RegisterSignal(equipper, COMSIG_CLICK_RIGHT, PROC_REF(on_rclick_duffel_wearer))
		RegisterSignal(equipper, COMSIG_MOVABLE_MOVED, PROC_REF(on_wearer_move))
		for(var/mob/M AS in storage_datum.content_watchers)
			storage_datum.close(M)

/obj/item/storage/backpack/marine/duffelbag/unequipped(mob/unequipper, slot)
	. = ..()
	UnregisterSignal(unequipper, list(COMSIG_CLICK_RIGHT, COMSIG_MOVABLE_MOVED))

///Allows non-wearers to access this inventory
/obj/item/storage/backpack/marine/duffelbag/proc/on_rclick_duffel_wearer(datum/source, mob/clicker)
	SIGNAL_HANDLER
	if(clicker == loc || !source.Adjacent(clicker)) //Wearer can't use this to bypass restrictions
		return
	storage_datum.open(clicker)

///Closes the duffelbag when our wearer moves if it's worn on user's back
/obj/item/storage/backpack/marine/duffelbag/proc/on_wearer_move(datum/source)
	SIGNAL_HANDLER
	if(!iscarbon(source))
		return
	var/mob/living/carbon/carbon_user = source
	if(carbon_user.back == src && carbon_user.active_storage == storage_datum)
		storage_datum.close(carbon_user)

//CLOAKS

/obj/item/storage/backpack/marine/satchel/officer_cloak
	name = "军官斗篷 - 蓝色"
	desc = "一件与军官相称的潇洒斗篷."
	icon_state = "officer_cloak" //with thanks to Baystation12
	worn_icon_state = "officer_cloak" //with thanks to Baystation12

/obj/item/storage/backpack/marine/satchel/captain_cloak
	name = "队长的斗篷 - 蓝色"
	desc = "一件华丽的斗篷,上面详细记录着你的诸多功绩."
	icon_state = "commander_cloak" //with thanks to Baystation12
	worn_icon_state = "commander_cloak" //with thanks to Baystation12

/obj/item/storage/backpack/marine/satchel/officer_cloak_red
	name = "军官斗篷 - 红色"
	desc = "一件与军官身份相称的潇洒斗篷,带有精致的红色镶边."
	icon_state = "officer_cloak_red" //with thanks to Baystation12
	worn_icon_state = "officer_cloak_red" //with thanks to Baystation12

/obj/item/storage/backpack/marine/satchel/officer_cloak_red/alt
	name = "高级军官斗篷"
	worn_icon_list = list(
		slot_back_str = 'icons/mob/clothing/back.dmi')
	icon_state = "officer_cloak_red_alt"

/obj/item/storage/backpack/marine/satchel/captain_cloak_red
	name = "上尉斗篷 - 红色"
	desc = "一件华丽的斗篷,上面详细记录着你的诸多功绩,带有精致的红色镶边."
	icon_state = "commander_cloak_red" //with thanks to Baystation12
	worn_icon_state = "commander_cloak_red" //with thanks to Baystation12

/obj/item/storage/backpack/marine/satchel/captain_cloak_red/white
	icon_state = "white_com"
	worn_icon_list = list(
		slot_back_str = 'icons/mob/clothing/back.dmi')

// Scout Cloak
/obj/item/storage/backpack/marine/satchel/scout_cloak
	name = "\improper M68 热光学斗篷"
	desc = "这件斗篷提供的轻型热抑制和光学伪装效果弱于标准TGMC吉利服.作为交换,这件斗篷可以穿在战斗装甲外,为穿戴者提供高机动性和对多种环境的适应性.可作为挎包使用."
	icon_state = "scout_cloak"
	actions_types = list(/datum/action/item_action/toggle)
	var/camo_active = 0
	var/camo_active_timer = 0
	var/camo_cooldown_timer = null
	var/camo_last_stealth = null
	var/camo_last_shimmer = null
	var/camo_energy = 100
	var/mob/living/carbon/human/wearer = null
	var/shimmer_alpha = SCOUT_CLOAK_RUN_ALPHA
	var/stealth_delay = null

/obj/item/storage/backpack/marine/satchel/scout_cloak/Destroy()
	camo_off()
	return ..()

/obj/item/storage/backpack/marine/satchel/scout_cloak/dropped(mob/user)
	camo_off(user)
	wearer = null
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/item/storage/backpack/marine/satchel/scout_cloak/attack_self(mob/user)
	. = ..()
	camouflage()

/obj/item/storage/backpack/marine/satchel/scout_cloak/process()
	if(!wearer)
		camo_off()
		return
	else if(wearer.stat != CONSCIOUS)
		camo_off(wearer)
		return
	stealth_delay = world.time - SCOUT_CLOAK_STEALTH_DELAY
	if(camo_last_shimmer > stealth_delay) //Shimmer after taking aggressive actions; no energy regeneration
		wearer.alpha = shimmer_alpha //50% invisible
	else if(camo_last_stealth > stealth_delay ) //We have an initial reprieve at max invisibility allowing us to reposition; no energy recovery during this time
		wearer.alpha = SCOUT_CLOAK_STILL_ALPHA
		return
	//Stationary stealth
	else if( wearer.last_move_intent < stealth_delay ) //If we're standing still and haven't shimmed in the past 3 seconds we become almost completely invisible
		wearer.alpha = SCOUT_CLOAK_STILL_ALPHA //95% invisible
		camo_adjust_energy(wearer, SCOUT_CLOAK_ACTIVE_RECOVERY)

///Handles the wearer moving with the cloak active
/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/handle_movement(mob/living/carbon/human/source, atom/old_loc, movement_dir, forced, list/old_locs)
	SIGNAL_HANDLER
	if(!camo_active)
		return
	if(camo_last_shimmer > world.time - SCOUT_CLOAK_STEALTH_DELAY) //Shimmer after taking aggressive actions
		source.alpha = SCOUT_CLOAK_RUN_ALPHA
		camo_adjust_energy(source, SCOUT_CLOAK_RUN_DRAIN)
	else if(camo_last_stealth > world.time - SCOUT_CLOAK_STEALTH_DELAY) //We have an initial reprieve at max invisibility allowing us to reposition, albeit at a high drain rate
		source.alpha = SCOUT_CLOAK_STILL_ALPHA
		camo_adjust_energy(source, SCOUT_CLOAK_RUN_DRAIN)
	else if(source.m_intent == MOVE_INTENT_WALK)
		source.alpha = SCOUT_CLOAK_WALK_ALPHA
		camo_adjust_energy(source, SCOUT_CLOAK_WALK_DRAIN)
	else
		source.alpha = SCOUT_CLOAK_RUN_ALPHA
		camo_adjust_energy(source, SCOUT_CLOAK_RUN_DRAIN)

///Activates the cloak
/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/camouflage()
	if(usr.incapacitated(TRUE))
		return

	var/mob/living/carbon/human/M = usr
	if(!istype(M))
		return

	if(M.back != src)
		to_chat(M, span_warning("你必须穿着斗篷才能激活它!"))
		return

	if(camo_active)
		camo_off(usr)
		return

	//other sources of cloaking
	if(HAS_TRAIT(M, TRAIT_STEALTH))
		to_chat(M, span_warning("你已经处于隐身状态!"))
		return FALSE

	if(camo_cooldown_timer)
		to_chat(M, span_warning("你的热光学斗篷仍在重新校准中!它将在[(camo_cooldown_timer - world.time) * 0.1]秒后准备就绪."))
		return

	camo_active = TRUE
	camo_last_stealth = world.time
	wearer = M

	M.visible_message("[M]消失在空气中!", span_notice("你激活了斗篷的伪装."))
	playsound(M.loc,'sound/effects/cloak_scout_on.ogg', 15, 1)

	stealth_delay = world.time - SCOUT_CLOAK_STEALTH_DELAY
	if(camo_last_shimmer > stealth_delay) //Shimmer after taking aggressive actions
		wearer.alpha = shimmer_alpha //50% invisible
	else
		wearer.alpha = SCOUT_CLOAK_STILL_ALPHA

	if (M.smokecloaked)
		M.smokecloaked = FALSE
	else
		GLOB.huds[DATA_HUD_BASIC].remove_from_hud(M)
		GLOB.huds[DATA_HUD_XENO_INFECTION].remove_from_hud(M)
		GLOB.huds[DATA_HUD_XENO_HEART].remove_from_hud(M)

	addtimer(CALLBACK(src, PROC_REF(on_cloak)), 1)
	RegisterSignal(M, COMSIG_HUMAN_DAMAGE_TAKEN, PROC_REF(damage_taken))
	RegisterSignals(M, list(
		COMSIG_MOB_GUN_FIRED,
		COMSIG_MOB_GUN_AUTOFIRED,
		COMSIG_MOB_ATTACHMENT_FIRED,
		COMSIG_MOB_THROW,
		COMSIG_MOB_ITEM_ATTACK), PROC_REF(action_taken))
	ADD_TRAIT(M, TRAIT_STEALTH, TRAIT_STEALTH)
	START_PROCESSING(SSprocessing, src)
	RegisterSignal(wearer, COMSIG_MOVABLE_MOVED, PROC_REF(handle_movement))
	return TRUE

/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/on_cloak()
	if(wearer)
		anim(wearer.loc, wearer, 'icons/mob/mob.dmi', flick_anim = "cloak", direction = wearer.dir)

/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/on_decloak()
	if(wearer)
		anim(wearer.loc,wearer, 'icons/mob/mob.dmi', flick_anim = "uncloak", direction = wearer.dir)

/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/camo_off(mob/user)
	if(!user)
		camo_active = FALSE
		wearer = null
		STOP_PROCESSING(SSprocessing, src)
		return FALSE

	if(!camo_active)
		return FALSE

	camo_active = FALSE
	user.visible_message(span_warning("[user.name]闪烁着现出身形!"), span_danger("你的斗篷伪装已解除!"))
	playsound(user.loc,'sound/effects/cloak_scout_off.ogg', 15, 1)
	user.alpha = initial(user.alpha)

	GLOB.huds[DATA_HUD_BASIC].add_to_hud(user)
	GLOB.huds[DATA_HUD_XENO_INFECTION].add_to_hud(user)
	GLOB.huds[DATA_HUD_XENO_HEART].add_to_hud(user)

	addtimer(CALLBACK(src, PROC_REF(on_decloak)), 1)

	var/cooldown = round( (initial(camo_energy) - camo_energy) / SCOUT_CLOAK_INACTIVE_RECOVERY * 10) //Should be 20 seconds after a full depletion with inactive recovery at 5
	if(cooldown)
		camo_cooldown_timer = world.time + cooldown //recalibration and recharge time scales inversely with charge remaining
		to_chat(user, span_warning("你的热光学斗篷正在重新校准!它将在[(camo_cooldown_timer - world.time) * 0.1]秒后准备就绪."))
		process_camo_cooldown(user, cooldown)

	UnregisterSignal(user, list(
		COMSIG_HUMAN_DAMAGE_TAKEN,
		COMSIG_MOB_GUN_FIRED,
		COMSIG_MOB_GUN_AUTOFIRED,
		COMSIG_MOB_ATTACHMENT_FIRED,
		COMSIG_MOB_THROW,
		COMSIG_MOB_ITEM_ATTACK,
		COMSIG_MOVABLE_MOVED,
	))
	REMOVE_TRAIT(user, TRAIT_STEALTH, TRAIT_STEALTH)
	STOP_PROCESSING(SSprocessing, src)

/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/process_camo_cooldown(mob/living/user, cooldown)
	if(!camo_cooldown_timer)
		return
	addtimer(CALLBACK(src, PROC_REF(cooldown_finished)), cooldown)

/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/cooldown_finished()
	camo_cooldown_timer = null
	camo_energy = initial(camo_energy)
	playsound(loc,'sound/effects/EMPulse.ogg', 25, 0, 1)
	if(wearer)
		to_chat(wearer, span_danger("你的热光学斗篷已重新校准,可以再次隐身了."))

/obj/item/storage/backpack/marine/satchel/scout_cloak/examine(mob/user)
	. = ..()
	if(user != wearer) //Only the wearer can see these details.
		return
	var/list/details = list()
	details +=("It has [camo_energy]/[initial(camo_energy)] charge. </br>")

	if(camo_cooldown_timer)
		details +=("It will be ready in [(camo_cooldown_timer - world.time) * 0.1] seconds. </br>")

	if(camo_active)
		details +=("It's currently active.</br>")

	. += span_warning("[details.Join(" ")]")

/obj/item/storage/backpack/marine/satchel/scout_cloak/item_action_slot_check(mob/user, slot)
	if(!ishuman(user))
		return FALSE
	if(slot != SLOT_BACK)
		return FALSE
	return TRUE

/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/camo_adjust_energy(mob/user, drain = SCOUT_CLOAK_WALK_DRAIN)
	camo_energy = clamp(camo_energy - drain,0,initial(camo_energy))

	if(!camo_energy) //Turn off the camo if we run out of energy.
		to_chat(user, span_danger("你的热光学斗篷能量不足,无法维持激活状态."))
		camo_off(user)

/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/damage_taken(datum/source, damage)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/wearer = source
	if(damage >= 15)
		to_chat(wearer, span_danger("你的斗篷因受到伤害而闪烁不定!"))
		apply_shimmer()

/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/action_taken() //This is used by multiple signals passing different parameters.
	SIGNAL_HANDLER
	to_chat(wearer, span_danger("你的斗篷因你的动作而闪烁不定!"))
	apply_shimmer()

/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/apply_shimmer()
	camo_last_shimmer = world.time //Reduces transparency to 50%
	wearer.alpha = max(wearer.alpha,shimmer_alpha)

/obj/item/storage/backpack/marine/satchel/scout_cloak/sniper
	name = "\improper M68-B 热光学斗篷"
	icon_state = "smock"
	desc = "M68-B热光学斗篷是为狙击手定制用途的变体,以牺牲移动隐蔽性为代价,实现更快,更优秀的静止隐蔽.它被设计为与轻型M3侦察战斗装甲搭配使用.可作为挎包使用."
	shimmer_alpha = SCOUT_CLOAK_RUN_ALPHA * 0.5 //Half the normal shimmer transparency.

/obj/item/storage/backpack/marine/satchel/scout_cloak/sniper/handle_movement(mob/living/carbon/human/source, atom/old_loc, movement_dir, forced, list/old_locs)
	if(!camo_active)
		return
	source.alpha = initial(source.alpha) //Sniper variant has *no* mobility stealth, but no drain on movement either

/obj/item/storage/backpack/marine/satchel/scout_cloak/sniper/process()
	if(!wearer)
		camo_off()
		return
	else if(wearer.stat == DEAD)
		camo_off(wearer)
		return

	stealth_delay = world.time - SCOUT_CLOAK_STEALTH_DELAY * 0.5
	if(camo_last_shimmer > stealth_delay) //Shimmer after taking aggressive actions; no energy regeneration
		wearer.alpha = max(wearer.alpha, shimmer_alpha) //50% invisible
	//Stationary stealth
	else if( wearer.last_move_intent < stealth_delay ) //If we're standing still and haven't shimmed in the past 2 seconds we become almost completely invisible
		wearer.alpha = SCOUT_CLOAK_STILL_ALPHA //95% invisible
		camo_adjust_energy(wearer, SCOUT_CLOAK_ACTIVE_RECOVERY)

// Welder Backpacks //

/obj/item/storage/backpack/marine/engineerpack
	name = "\improper TGMC 技术员焊接背包"
	desc = "TGMC技术员穿戴的专用背包.它携带一个燃料罐,用于快速为焊接器补充燃料并使用,"
	icon_state = "engineerpack"
	worn_icon_state = "engineerpack"
	storage_type = /datum/storage/backpack/satchel
	var/max_fuel = 260

/obj/item/storage/backpack/marine/engineerpack/Initialize(mapload, ...)
	. = ..()
	var/datum/reagents/R = new/datum/reagents(max_fuel) //Lotsa refills
	reagents = R
	R.my_atom = WEAKREF(src)
	R.add_reagent(/datum/reagent/fuel, max_fuel)

/obj/item/storage/backpack/marine/engineerpack/attackby(obj/item/I, mob/user, params)
	if(iswelder(I))
		var/obj/item/tool/weldingtool/T = I
		if(T.welding)
			to_chat(user, span_warning("好险!不过你意识到自己还开着焊接器,从而避免了灾难."))
			return
		if(T.get_fuel() == T.max_fuel || !reagents.total_volume)
			return ..()

		reagents.trans_to(I, T.max_fuel)
		to_chat(user, span_notice("焊接器已补充燃料!"))
		playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)

	else if(istype(I, /obj/item/ammo_magazine/flamer_tank))
		var/obj/item/ammo_magazine/flamer_tank/FT = I
		if(FT.default_ammo != /datum/ammo/flamethrower)
			return ..()
		if(FT.current_rounds == FT.max_rounds || !reagents.total_volume)
			return ..()

		//Reworked and much simpler equation; fuel capacity minus the current amount, with a check for insufficient fuel
		var/fuel_transfer_amount = min(reagents.total_volume, (FT.max_rounds - FT.current_rounds))
		reagents.remove_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		FT.current_rounds += fuel_transfer_amount
		playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
		FT.caliber = CALIBER_FUEL
		to_chat(user, span_notice("你用[lowertext(FT.caliber)]为[FT]补充燃料."))
		FT.update_icon()

	else if(istype(I, /obj/item/weapon/twohanded/sledgehammer/rocketsledge))
		var/obj/item/weapon/twohanded/sledgehammer/rocketsledge/RS = I
		if(RS.reagents.get_reagent_amount(/datum/reagent/fuel) == RS.max_fuel || !reagents.total_volume)
			return ..()

		var/fuel_transfer_amount = min(reagents.total_volume, (RS.max_fuel - RS.reagents.get_reagent_amount(/datum/reagent/fuel)))
		reagents.remove_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		RS.reagents.add_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
		to_chat(user, span_notice("你为[RS]补充燃料."))
		RS.update_icon()

	else if(istype(I, /obj/item/weapon/twohanded/chainsaw))
		var/obj/item/weapon/twohanded/chainsaw/saw = I
		if(saw.reagents.get_reagent_amount(/datum/reagent/fuel) == saw.max_fuel || !reagents.total_volume)
			return ..()

		var/fuel_transfer_amount = min(reagents.total_volume, (saw.max_fuel - saw.reagents.get_reagent_amount(/datum/reagent/fuel)))
		reagents.remove_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		saw.reagents.add_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
		to_chat(user, span_notice("你为[saw]补充燃料."))
		saw.update_icon()

	else
		return ..()

/obj/item/storage/backpack/marine/engineerpack/afterattack(obj/O as obj, mob/user as mob, proximity)
	if(!proximity) // this replaces and improves the get_dist(src,O) <= 1 checks used previously
		return
	if (istype(O, /obj/structure/reagent_dispensers/fueltank) && src.reagents.total_volume < max_fuel)
		O.reagents.trans_to(src, max_fuel)
		to_chat(user, span_notice("你撬开背包顶部的盖子,再次从燃料罐中将其加满."))
		playsound(src.loc, 'sound/effects/refill.ogg', 25, 1, 3)
		return
	else if (istype(O, /obj/structure/reagent_dispensers/fueltank) && src.reagents.total_volume == max_fuel)
		to_chat(user, span_notice("背包已经满了!"))
		return
	return ..()

/obj/item/storage/backpack/marine/engineerpack/examine(mob/user)
	. = ..()
	. += span_notice("剩余[reagents.total_volume]单位燃料!")

/obj/item/storage/backpack/marine/engineerpack/som
	name = "\improper SOM 技术员焊接背包"
	desc = "SOM技术员穿戴的专用背包.它携带一个燃料罐,用于快速为焊接器补充燃料."
	icon_state = "som_engineer_pack"
	worn_icon_state = "som_engineer_pack"

/obj/item/storage/backpack/lightpack
	name = "\improper 轻型战斗背包"
	desc = "用于远征和短程行动的小型轻量背包."
	icon_state = "ERT_satchel"
	storage_type = /datum/storage/backpack/no_delay

/obj/item/storage/backpack/commando
	name = "突击队包"
	desc = "纳米传讯突击队员携带的重型包."
	icon_state = "commandopack"
	storage_type = /datum/storage/backpack/commando

/obj/item/storage/backpack/captain
	name = "陆战队上尉背包"
	desc = "这个背包的内容是最高机密."
	icon_state = "marinepack"
	storage_type = /datum/storage/backpack/captain

/obj/item/storage/backpack/lightpack/som
	name = "采矿帆布背包"
	desc = "一个起源可追溯到采矿殖民地的帆布背包."
	icon_state = "som_lightpack"
	worn_icon_state = "som_lightpack"

/obj/item/storage/backpack/lightpack/icc
	name = "\improper Modello/190"
	desc = "一款为多种行动使用而制造的小型轻量臀包,采用合成棕褐色纤维制成."
	icon_state = "icc_bag"

/obj/item/storage/backpack/lightpack/icc/guard
	name = "\improper Modello/190"
	desc = "一款为多种行动使用而制造的小型轻量臀包,采用合成黑色纤维制成."
	icon_state = "icc_bag_guard"

/obj/item/storage/backpack/marine/radiopack
	name = "\improper TGMC 无线电操作员背包"
	desc = "一个类似旧时代无线电操作员陆战队员会使用的背包.它上面安装了一个补给订购控制台,以及一根可伸缩天线用于接收补给空投."
	icon_state = "radiopack"
	worn_icon_state = "radiopack"
	///Var for the window pop-up
	var/datum/supply_ui/requests/supply_interface

/obj/item/storage/backpack/marine/radiopack/Initialize(mapload, ...)
	. = ..()
	AddComponent(/datum/component/beacon)
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED_TO_SLOT, PROC_REF(on_equip))
	RegisterSignal(src, COMSIG_ITEM_UNEQUIPPED, PROC_REF(on_unequip))

/obj/item/storage/backpack/marine/radiopack/Destroy()
	UnregisterSignal(src, list(COMSIG_ITEM_EQUIPPED_TO_SLOT, COMSIG_ITEM_UNEQUIPPED))
	return ..()

/obj/item/storage/backpack/marine/radiopack/examine(mob/user)
	. = ..()
	. += span_notice("空手右键点击以打开军需界面.")

/obj/item/storage/backpack/marine/radiopack/attack_hand_alternate(mob/living/user)
	if(!allowed(user))
		return ..()
	if(!supply_interface)
		supply_interface = new(src)
	return supply_interface.interact(user)

/obj/item/storage/backpack/marine/radiopack/proc/on_equip(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER
	RegisterSignal(equipper, COMSIG_CAVE_INTERFERENCE_CHECK, PROC_REF(on_interference_check))

/obj/item/storage/backpack/marine/radiopack/proc/on_unequip(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER
	UnregisterSignal(equipper, COMSIG_CAVE_INTERFERENCE_CHECK)

/// Handles interacting with caves checking for if anything is reducing (or increasing) interference.
/obj/item/storage/backpack/marine/radiopack/proc/on_interference_check(datum/source, list/inplace_interference)
	SIGNAL_HANDLER
	inplace_interference[1] = max(0, inplace_interference[1] - 1)

/obj/item/storage/backpack/lightpack/vsd
	name = "\improper Crasher 品牌战斗背包"
	desc = "源自21世纪的设计在25世纪依然被证明是一个好设计."
	icon_state = "vsd_bag0"
