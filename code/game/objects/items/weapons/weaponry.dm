/obj/item/weapon/banhammer
	desc = "一把封禁之锤"
	name = "封禁之锤"
	icon = 'icons/obj/items/items.dmi'
	icon_state = "toyhammer"
	equip_slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 7
	throw_range = 15
	attack_verb = list("bans")

/obj/item/weapon/nullrod
	name = "黑曜石杖"
	desc = "一根纯黑曜石制成的法杖,它的存在本身就会干扰并削弱超自然现象的力量."
	icon_state = "nullrod"
	worn_icon_state = "nullrod"
	equip_slot_flags = ITEM_SLOT_BELT
	force = 15
	throw_speed = 1
	throw_range = 4
	throwforce = 10
	w_class = WEIGHT_CLASS_SMALL

/obj/item/weapon/harpoon
	name = "鱼叉"
	sharp = IS_SHARP_ITEM_SIMPLE
	edge = 0
	desc = "它喷水啦!"
	icon_state = "harpoon"
	worn_icon_state = "harpoon"
	force = 20
	throwforce = 15
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("jabs","stabs","rips")

/obj/item/weapon/baseballbat
	name = "\improper 木制棒球棍"
	desc = "一根大型木制棒球棍.常用于殖民地娱乐,但也用作自卫手段.经常被暴徒和恶棍携带."
	icon_state = "woodbat"
	worn_icon_state = "woodbat"
	sharp = 0
	edge = 0
	w_class = WEIGHT_CLASS_NORMAL
	force = 20
	throw_speed = 3
	throw_range = 7
	throwforce = 7
	attack_verb = list("smashes", "beats", "slams", "strikes", "smashes", "batters", "cracks")
	hitsound = 'sound/weapons/genhit3.ogg'

/obj/item/weapon/baseballbat/metal
	name = "\improper 金属棒球棍"
	desc = "一根大型金属棒球棍.与其木制表亲相比,金属棒球棍能提供更大的力量.经常被暴徒和恶棍携带."
	icon_state = "metalbat"
	worn_icon_state = "metalbat"
	force = 25
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/weapon/butterfly
	name = "蝴蝶刀"
	desc = "一片基础金属刀刃,隐藏在轻质塑钢握柄中.折叠后小到足以放进衣袋."
	icon_state = "butterflyknife"
	worn_icon_state = null
	hitsound = null
	w_class = WEIGHT_CLASS_TINY
	force = 8
	sharp = 0
	edge = 0
	throw_speed = 3
	throw_range = 4
	throwforce = 7
	attack_verb = list("pats", "taps")
	attack_speed = 4

/obj/item/weapon/butterfly/attack_self(mob/user)
	active = !active
	if(active)
		to_chat(user, span_notice("你甩出了你的[src]."))
		playsound(user, 'sound/weapons/flipblade.ogg', 15, 1)
		force = 15
		throwforce = 12
		edge = TRUE
		sharp = IS_SHARP_ITEM_ACCURATE
		hitsound = 'sound/weapons/bladeslice.ogg'
		icon_state += "_open"
		w_class = WEIGHT_CLASS_NORMAL
		attack_verb = list("attacks", "slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")
		return
	to_chat(user, span_notice("[src]现在可以隐藏了."))
	force = initial(force)
	edge = FALSE
	sharp = IS_NOT_SHARP_ITEM
	hitsound = initial(hitsound)
	icon_state = initial(icon_state)
	w_class = initial(w_class)
	attack_verb = initial(attack_verb)

/obj/item/weapon/butterfly/switchblade
	name = "弹簧刀"
	desc = "一把带有金色雕花的经典弹簧刀.光是握着它就让你感觉自己像个黑帮."
	icon_state = "switchblade"

/obj/item/weapon/wirerod
	name = "铁丝棍"
	desc = "一根顶部缠着一些金属丝的棍子.很容易在顶部绑上什么东西."
	icon_state = "wiredrod"
	worn_icon_state = "rods"
	atom_flags = CONDUCT
	force = 8
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("hits", "bludgeons", "whacks", "bonks")

/obj/item/weapon/wirerod/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/shard))
		var/obj/item/weapon/twohanded/spear/S = new

		user.put_in_hands(S)
		to_chat(user, span_notice("你用金属丝把玻璃碎片固定在了棍子顶部."))
		qdel(I)
		qdel(src)
		update_icon()
