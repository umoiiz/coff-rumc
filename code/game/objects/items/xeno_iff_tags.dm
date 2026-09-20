
//These small little things allow you to give xenos an IFF signature. No more crying because your corrupted keep dying to smartgunners!
/obj/item/xeno_iff_tag
	name = "地球政府异形敌我识别标签"
	desc = "一张小型金属卡片,可以夹在异形身上,让敌我识别系统将该目标识别为友方."
	icon = 'icons/obj/items/card.dmi'
	icon_state = "guest" //Better I reuse this unused sprite for something that you'll see for ten seconds pre-attach than use my spriting "skills".
	///The IFF signal this tag will create a component with
	var/carried_iff = TGMC_LOYALIST_IFF

/obj/item/xeno_iff_tag/attack(mob/living/M, mob/living/user)
	if(!isxeno(M))
		return ..()
	. = TRUE
	var/mob/living/carbon/xenomorph/xeno = M
	if(xeno.stat == DEAD)
		to_chat(user, span_warning("[xeno]已经死了,你为什么要浪费一个标签在它身上?"))
		return
	if(xeno.GetComponent(/datum/component/xeno_iff))
		to_chat(user, span_warning("[xeno]已经附有一个敌我识别标签,再附上一个可能会干扰它的信号!"))
		return
	user.visible_message(span_notice("[user]开始将[src]附着到[xeno]上."), span_notice("你开始将[src]附着到[xeno]上."), ignored_mob = xeno)
	if(xeno.client)
		to_chat(xeno, span_xenowarning("[user]开始将[src]附着到我们身上!"))
	if(!do_after(user, 5 SECONDS, IGNORE_HELD_ITEM, xeno, BUSY_ICON_FRIENDLY, BUSY_ICON_DANGER))
		return
	if(xeno.GetComponent(/datum/component/xeno_iff))
		to_chat(user, span_warning("你忙碌时已经有人将标签附着到[xeno]上了!"))
		return
	user.balloon_alert_to_viewers("已附着敌我识别标签")
	to_chat(xeno, span_xenonotice("[user]把[src]装到了我们身上!"))
	xeno.AddComponent(/datum/component/xeno_iff, carried_iff)
	qdel(src)

//Eventmins are fun so I'll make your job a tiny bit easier.

/obj/item/xeno_iff_tag/som
	name = "火星之子异形敌我识别标签"
	carried_iff = SOM_IFF

/obj/item/xeno_iff_tag/deathsquad
	name = "\[已涂黑\]异形敌我识别标签"
	carried_iff = DEATHSQUAD_IFF

/obj/item/xeno_iff_tag/sectoid
	name = "泽塔异形敌我识别标签"
	carried_iff = SECTOIDS_IFF

//Adding more options should be super easy anyways just varedit the carried IFF (or manually add the component if you know how!)
