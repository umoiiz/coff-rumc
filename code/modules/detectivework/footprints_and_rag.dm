/obj/item/clothing/gloves
	var/transfer_blood = 0

/obj/item/clothing/shoes/
	var/track_blood = 0
	///Whether these shoes have laces that can be tied/untied
	var/can_be_tied = TRUE
	///Are we currently tied? Can either be SHOES_TIED or SHOES_KNOTTED
	var/tied = SHOES_TIED

/obj/item/reagent_containers/glass/rag
	name = "湿抹布"
	desc = "用来清理污渍的, 你想."
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/janitor.dmi'
	icon_state = "rag"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(5)
	volume = 5
	item_flags = NOBLUDGEON

/obj/item/reagent_containers/glass/rag/attack_self(mob/user as mob)
	return

/obj/item/reagent_containers/glass/rag/attack(atom/target as obj|turf|area, mob/user as mob , flag)
	if(ismob(target) && target.reagents && reagents.total_volume)
		user.visible_message(span_warning("\The [target]被\the [user]用\the [src]闷住了!"), span_warning("你用\the [src]闷住了\the [target]!"), "你听到一些挣扎声和含糊的惊叫声")
		src.reagents.reaction(target, TOUCH)
		addtimer(CALLBACK(reagents, TYPE_PROC_REF(/datum/reagents, clear_reagents)), 5)
		return
	return ..()

/obj/item/reagent_containers/glass/rag/afterattack(atom/A as obj|turf|area, mob/user as mob, proximity)
	if(!proximity)
		return
	if(istype(A) && (src in user))
		user.visible_message("[user]开始用[src]擦拭[A]!")
		if(do_after(user, 3 SECONDS, NONE, A, , BUSY_ICON_GENERIC))
			user.visible_message("[user]擦完了[A]!")
			A.clean_blood()

