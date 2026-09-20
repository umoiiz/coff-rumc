/obj/item/tool/hand_labeler
	name = "手动贴标机"
	desc = "用于给物体贴标签的手动贴标机"
	icon = 'icons/obj/items/paper.dmi'
	icon_state = "labeler0"
	worn_icon_state = "flight"
	w_class = WEIGHT_CLASS_SMALL

	var/label = null
	var/labels_left = 50
	var/on = FALSE

/obj/item/tool/hand_labeler/afterattack(atom/A, mob/user as mob, proximity)
	if(!proximity)
		return
	if(!on)
		return
	if(!label)
		to_chat(user, span_notice("未设置标签."))
		return
	if(length(A.name) + length(label) > 64)
		to_chat(user, span_notice("标签太大."))
		return
	if(!labels_left)
		to_chat(user, span_notice("标签纸用完了, 往里面装些纸."))
		return
	if(isturf(A) || ismob(A))
		to_chat(user, span_notice("标签粘不到那上面."))
		return
	if(A.name == "[initial(A.name)] ([label])")
		to_chat(user, span_notice("它已经有相同的标签了."))
		return

	user.visible_message(span_notice("[user]将[A]标记为\"[label]\"."), \
						span_notice("你将[A]标记为\"[label]\"."))
	A.name = "[initial(A.name)] ([label])"
	labels_left--

/obj/item/tool/hand_labeler/attack_self(mob/user as mob)
	on = !on
	icon_state = "labeler[on]"
	if(on)
		to_chat(user, span_notice("你打开了\the [src]."))
		var/str = reject_bad_text(stripped_input(user, "Label text?", "Set label","", MAX_NAME_LEN))
		if(!str)
			to_chat(user, span_notice("无效标签."))
			on = !on
			icon_state = "labeler[on]"
			return
		label = str
		to_chat(user, span_notice("你将标签文本设置为'[str]'."))
	else
		to_chat(user, span_notice("你关闭了\the [src]."))

/obj/item/tool/hand_labeler/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(istype(I, /obj/item/paper))
		to_chat(user, span_notice("你将[I]插入[src]."))
		qdel(I)
		labels_left = min(labels_left + 5, initial(labels_left))

/obj/item/tool/hand_labeler/examine(mob/user)
	. = ..()
	. += span_notice("它还剩下[initial(labels_left)]个标签中的[labels_left]个.")

/*
* Pens
*/
/obj/item/tool/pen
	desc = "这是一支普通的黑色墨水笔."
	name = "笔"
	icon = 'icons/obj/items/paper.dmi'
	icon_state = "pen"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/civilian_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/civilian_right.dmi',
	)
	worn_icon_state = "pen"
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_EARS
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 7
	throw_range = 15
	var/colour = "black"	//what colour the ink is!

/obj/item/tool/pen/blue
	desc = "这是一支普通的蓝色墨水笔."
	icon_state = "pen_blue"
	colour = "blue"

/obj/item/tool/pen/red
	desc = "这是一支普通的红色墨水笔."
	icon_state = "pen_red"
	colour = "red"

/obj/item/tool/pen/invisible
	desc = "这是一支隐形笔."
	icon_state = "pen"
	colour = "white"

/obj/item/tool/pen/attack(mob/M as mob, mob/user as mob)
	if(!ismob(M))
		return
	to_chat(user, span_warning("你用笔刺向[M]."))
//	to_chat(M, span_warning("You feel a tiny prick!"))
	log_combat(user, M, "stabbed", src)

/*
* Sleepy Pens
*/
/obj/item/tool/pen/sleepypen
	desc = "这是一支带有尖锐笔尖的黑色墨水笔, 上面精心雕刻着\"Waffle Co.\""
	equip_slot_flags = ITEM_SLOT_BELT

/obj/item/tool/pen/sleepypen/Initialize(mapload)
	. = ..()
	create_reagents(30, OPENCONTAINER, list(/datum/reagent/toxin/chloralhydrate = 22))

/obj/item/tool/pen/sleepypen/attack(mob/M as mob, mob/user as mob)
	if(!(istype(M,/mob)))
		return
	. = ..()
	if(reagents.total_volume)
		reagents.reaction(M, INJECT)
		if(M.reagents) reagents.trans_to(M, 50) //used to be 150

/*
* Parapens
*/
/obj/item/tool/pen/paralysis
	equip_slot_flags = ITEM_SLOT_BELT

/obj/item/tool/pen/paralysis/attack(mob/living/M as mob, mob/user as mob)
	if(!(istype(M,/mob)))
		return
	..()
	if(M.can_inject(user,1))
		if(reagents.total_volume)
			reagents.reaction(M, INJECT)
			if(M.reagents) reagents.trans_to(M, 50)

/obj/item/tool/pen/paralysis/Initialize(mapload)
	. = ..()
	create_reagents(50, OPENCONTAINER, list(/datum/reagent/toxin/huskpowder = 10, /datum/reagent/cryptobiolin = 15))


/obj/item/tool/stamp
	name = "橡皮图章"
	desc = "用于给重要文件盖章的橡皮图章."
	icon = 'icons/obj/items/paper.dmi'
	icon_state = "stamp-qm"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/items/civilian_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/items/civilian_right.dmi',
	)
	worn_icon_state = "stamp"
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 7
	throw_range = 15
	attack_verb = list("stamps")

/obj/item/tool/stamp/qm
	name = "军需官的图章"

/obj/item/tool/stamp/captain
	name = "舰长的橡皮图章"
	icon_state = "stamp-cap"

/obj/item/tool/stamp/hop
	name = "人事主管的橡皮图章"
	icon_state = "stamp-hop"

/obj/item/tool/stamp/hos
	name = "安保主管的橡皮图章"
	icon_state = "stamp-hos"

/obj/item/tool/stamp/ce
	name = "总轮机长的橡皮图章"
	icon_state = "stamp-ce"

/obj/item/tool/stamp/rd
	name = "研究主管的橡皮图章"
	icon_state = "stamp-rd"

/obj/item/tool/stamp/cmo
	name = "首席医疗官的橡皮图章"
	icon_state = "stamp-cmo"

/obj/item/tool/stamp/denied
	name = "\improper 拒绝橡皮图章"
	icon_state = "stamp-deny"

/obj/item/tool/stamp/clown
	name = "小丑的橡皮图章"
	icon_state = "stamp-clown"

/obj/item/tool/stamp/internalaffairs
	name = "内务部的橡皮图章"
	icon_state = "stamp-intaff"

/obj/item/tool/stamp/centcom
	name = "中央司令部的橡皮图章"
	icon_state = "stamp-cent"
