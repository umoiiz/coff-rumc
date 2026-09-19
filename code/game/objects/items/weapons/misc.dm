/obj/item/weapon/chainofcommand
	name = "指挥链"
	desc = "伟人们用来安抚沸腾民众的工具."
	icon_state = "chain"
	worn_icon_state = "chain"
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	force = 10
	throwforce = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("flogs", "whips", "lashes", "disciplines")

/obj/item/weapon/cane
	name = "手杖"
	desc = "一根真正绅士使用的手杖. 或者小丑用的."
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "cane"
	worn_icon_state = "cane"
	atom_flags = CONDUCT
	force = 5
	throwforce = 7
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("bludgeons", "whacks", "disciplines", "thrashes")

/obj/item/weapon/broken_bottle
	name = "碎瓶子"
	desc = "一个底部破碎锋利的瓶子."
	icon = 'icons/obj/items/drinks.dmi'
	icon_state = "broken_bottle"
	force = 9
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	worn_icon_state = "broken_beer"
	attack_verb = list("stabs", "slashes", "attacks")
	sharp = IS_SHARP_ITEM_SIMPLE
	edge = 0
	var/icon/broken_outline = icon('icons/obj/items/drinks.dmi', "broken")

/obj/item/weapon/broken_bottle/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 25, 1)
	return ..()

/obj/item/weapon/powerfist
	name = "动力拳套"
	desc = "一只装有能量驱动拳头的金属护手, 可以将敌人击退."
	icon_state = "powerfist"
	worn_icon_state = "powerfist"
	equip_slot_flags = ITEM_SLOT_BELT
	force = 10
	attack_verb = list("smashes", "rams", "power-fists")
	///Our inner cell
	var/obj/item/cell/cell
	///the higher the power level the harder it hits
	var/setting = 1

/obj/item/weapon/powerfist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/strappable)
	update_icon()

/obj/item/weapon/powerfist/Destroy()
	if(cell)
		QDEL_NULL(cell)
	return ..()

/obj/item/weapon/powerfist/update_icon_state()
	. = ..()
	icon_state = cell ? "powerfist" : "powerfist_e"

/obj/item/weapon/powerfist/examine(user)
	. = ..()
	. += span_notice("使用<b>手持</b>来更改功率设置. 当前功率设置为<b>[setting]</b>.")
	if(cell)
		. += span_notice("<b>点击</b>护手弹出电池.")
		. += span_notice("它还剩余<b>[round(cell.charge / (setting * 20), 1)]</b>级<b>[setting]</b>拳击.")
	else
		. += span_notice("没有安装<b>电池</b>!")

/obj/item/weapon/powerfist/attack_self(mob/user)
	. = ..()
	if(setting >= 3)
		setting = 1
	else
		setting++
	balloon_alert(user, "功率等级[setting].")

/obj/item/weapon/powerfist/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(!cell)
		to_chat(user, span_warning("\The [src]没有能量来源就无法运作!"))
		return

	if(M.status_flags & INCORPOREAL || user.status_flags & INCORPOREAL) //Incorporeal beings cannot attack or be attacked
		return

	var/powerused = setting * 20
	if(powerused > cell.charge)
		to_chat(user, span_warning("\The [src]的电池电量不足!"))
		M.apply_damage((force * 0.2), BRUTE, user.zone_selected, MELEE)
		hitsound = 'sound/weapons/punch1.ogg'
		if(M == user)
			to_chat(user, span_userdanger("你打了自己一拳!"))
		else
			M.visible_message(span_danger("[user]的动力拳套在击中[M.name]时发出沉闷的响声!"), \
				span_userdanger("[user]打了你一拳!"))
		return ..()
	if(M == user)
		user.apply_damage(force * setting, BRUTE, user.zone_selected, MELEE)
		to_chat(user, span_userdanger("你打了自己一拳!"))
		playsound(loc, 'sound/weapons/energy_blast.ogg', 50, TRUE)
		playsound(loc, 'sound/weapons/genhit2.ogg', 50, TRUE)
		cell.charge -= powerused
		return ..()
	M.apply_damage(force * setting, BRUTE, user.zone_selected, MELEE)
	M.visible_message(span_danger("[user]的动力拳套在击中[M.name]时剧烈震动, 将他们击飞!"), \
		span_userdanger("[user]的一拳将你击飞!"))
	playsound(loc, 'sound/weapons/energy_blast.ogg', 50, TRUE)
	playsound(loc, 'sound/weapons/genhit2.ogg', 50, TRUE)
	var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
	var/throw_distance = setting * LERP(5, 3, M.mob_size / MOB_SIZE_BIG)
	M.throw_at(throw_target, throw_distance, 0.5 + (setting * 0.5))
	cell.charge -= powerused
	return ..()

/obj/item/weapon/powerfist/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/cell))
		return ..()
	if(!islascell(I))
		to_chat(user, span_warning("动力拳套只接受激光枪电池!"))
		return
	if(I.w_class >= WEIGHT_CLASS_BULKY)
		to_chat(user, span_warning("太大了装不进去!"))
		return
	if(cell)
		unload(user)
	user.transferItemToLoc(I, src)
	cell = I
	update_icon()
	user.balloon_alert(user, "电池已插入")

/obj/item/weapon/powerfist/attack_hand(mob/living/user)
	if(!(user.get_inactive_held_item() == src))
		return ..()
	if(!cell)
		user.balloon_alert(user, "无电池")
		return
	unload(user)
	user.balloon_alert(user, "电池已取出")
	return

/obj/item/weapon/powerfist/attack_hand_alternate(mob/living/user)
	if(!cell)
		user.balloon_alert(user, "无电池")
		return
	unload(user)
	user.balloon_alert(user, "电池已取出")
	return

/// Remove the cell from the powerfist
/obj/item/weapon/powerfist/proc/unload(mob/user)
	if(!user.put_in_active_hand(cell))
		user.dropItemToGround(cell)
	cell = null
	update_icon()
	playsound(user, 'sound/weapons/guns/interact/rifle_reload.ogg', 25, TRUE)

/obj/item/weapon/powerfist/full
	setting = 3

/obj/item/weapon/powerfist/full/Initialize(mapload)
	var/obj/item/cell/lasgun/lasrifle/future_cell = new(src) // snowflaky, but we don't use it often, so it's fine?
	future_cell.forceMove(src)
	cell = future_cell
	return ..()

/obj/item/weapon/brick
	name = "砖块"
	desc = "这是一块砖. 通常用来砸东西, 偶尔也用来盖东西."
	icon_state = "brick"
	force = 30
	throwforce = 40
	attack_verb = list("smacks", "whacks", "bonks", "bricks", "thwacks", "socks", "donks")
	hitsound = 'sound/weapons/heavyhit.ogg'

/obj/item/stack/throwing_knife/stone
	name = "石头"
	desc = "能造成少量伤害, 这些石头会让被砸中的人烦得要命."
	icon_state = "stone"
	force = 15
	throwforce = 15
	max_amount = 12
	amount = 12
	throw_delay = 0.3 SECONDS
	attack_verb = list("smacks", "whacks", "bonks", "pelts", "thwacks", "cracks")
	hitsound = 'sound/weapons/heavyhit.ogg'
	singular_name = "stone"
	atom_flags = DIRLOCK
	sharp = IS_NOT_SHARP_ITEM
