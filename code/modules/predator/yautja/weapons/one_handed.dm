/*#########################################
########### One Handed Weapons ############
#########################################*/

/obj/item/weapon/yautja
	icon = 'icons/obj/hunter/pred_gear.dmi'
	worn_icon_list = list(
		slot_back_str = 'icons/mob/hunter/pred_gear.dmi',
		slot_l_hand_str = 'icons/mob/hunter/items_lefthand.dmi',
		slot_r_hand_str = 'icons/mob/hunter/items_righthand.dmi',
		slot_s_store_str = 'icons/mob/hunter/pred_gear.dmi'
	)

	var/human_adapted = FALSE

	var/charged = FALSE
	var/ability_primed = FALSE
	var/ability_charge = 0
	var/ability_cost = 5
	var/ability_charge_max = 5
	var/ability_charge_rate = 1

/obj/item/weapon/yautja/attack(mob/living/target as mob, mob/living/carbon/human/user as mob)
	. = ..()
	if(!.)
		return
	if(target.stat == DEAD || (!ishuman(target) && !isxeno(target)) || target == user)
		return
	if(ability_charge < ability_charge_max)
		ability_charge = min(ability_charge + ability_charge_rate, ability_charge_max)

/obj/item/weapon/yautja/AltClick(mob/user)
	if(!can_interact(user) || !ishuman(user) || !(user.l_hand == src || user.r_hand == src))
		return ..()
	if(!HAS_TRAIT(src, TRAIT_NODROP))
		ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		to_chat(user, span_warning("你握紧了[src]!"))
	else
		REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		to_chat(user, span_notice("你松开了[src]!"))

/obj/item/weapon/yautja/chain
	name = "链鞭"
	desc = "由耐用,耐酸金属制成的分段式轻型鞭子.在亚乌查猎人中不太常见,但仍然是一种能够撕碎猎物的危险武器."
	icon_state = "whip"
	worn_icon_state = "whip"
	atom_flags = CONDUCT
	item_flags = ITEM_PREDATOR
	equip_slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = UNACIDABLE
	force = 37
	throwforce = 25
	penetration = 25
	sharp = IS_SHARP_ITEM_SIMPLE
	edge = TRUE
	attack_verb = list("whipped", "slashed","sliced","diced","shredded")
	attack_speed = 0.8 SECONDS
	hitsound = 'sound/weapons/chain_whip.ogg'


/obj/item/weapon/yautja/chain/attack(mob/target, mob/living/user)
	. = ..()
	if((human_adapted || isyautja(user)) && isxeno(target))
		var/mob/living/carbon/xenomorph/xenomorph = target
		xenomorph.interference = 30
		xenomorph.use_plasma(50)

/obj/item/weapon/yautja/sword
	name = "氏族之剑"
	desc = "由猎人携带的精工亚乌查刀刃,适合近身战斗.锋利无比,能将血肉切成碎条.通常由好斗且致命的猎人携带."
	icon_state = "clansword"
	atom_flags = CONDUCT
	item_flags = ITEM_PREDATOR
	equip_slot_flags = ITEM_SLOT_BACK
	force = 40
	throwforce = 25
	penetration = 20
	can_block_xeno = TRUE
	can_block_chance = 20
	sharp = IS_SHARP_ITEM_ACCURATE
	edge = TRUE
	w_class = WEIGHT_CLASS_HUGE
	hitsound = SFX_CLAN_SWORD_HIT
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	attack_speed = 1 SECONDS
	resistance_flags = UNACIDABLE

/obj/item/weapon/yautja/sword/attack(mob/target, mob/living/user)
	. = ..()
	if((human_adapted || isyautja(user)) && isxeno(target))
		var/mob/living/carbon/xenomorph/xenomorph = target
		xenomorph.interference = 30

/obj/item/weapon/yautja/scythe
	name = "双战争镰刀"
	desc = "用于猎杀危险猎物的巨大,极其锋利的双刃.这种武器通常由希望使敌人丧失能力并将其切碎的亚乌查携带."
	icon_state = "predscythe"
	worn_icon_state = "scythe_dual"
	atom_flags = CONDUCT
	item_flags = ITEM_PREDATOR
	equip_slot_flags = ITEM_SLOT_BELT
	force = 35
	throwforce = 25
	penetration = 20
	sharp = IS_SHARP_ITEM_SIMPLE
	edge = TRUE
	w_class = WEIGHT_CLASS_HUGE
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	resistance_flags = UNACIDABLE

	ability_cost = 5
	ability_charge_max = 5
	ability_charge_rate = 1

/obj/item/weapon/yautja/scythe/verb/use_unique_action()
	set category = "IC.Weapons"
	set name = "Unique Action"
	set desc = "Activate or deactivate the scythe."
	set src in usr
	unique_action(usr)

/obj/item/weapon/yautja/scythe/attack(mob/living/target as mob, mob/living/carbon/human/user as mob)
	. = ..()
	if(!.)
		return
	if((human_adapted || isyautja(user)) && isxeno(target))
		var/mob/living/carbon/xenomorph/xenomorph = target
		xenomorph.interference = 15

	if(!charged && ability_charge >= ability_cost)
		var/color = target.get_blood_color()
		var/alpha = 70
		charged = TRUE
		color += num2text(alpha, 2, 16)
		add_filter("scythe_ready", 1, list("type" = "outline", "color" = color, "size" = 2))

/obj/item/weapon/yautja/scythe/attack_self(mob/user)
	..()
	ability_primed = !ability_primed
	var/message = "You tighten your grip on [src], preparing to whirl it in a spin."
	if(!ability_primed)
		message = "You relax your grip on [src]."
	to_chat(user, span_warning(message))

/obj/item/weapon/yautja/scythe/unique_action(mob/user)
	if(user.get_active_held_item() != src)
		return
	if(!charged)
		return
	if(!ability_primed)
		to_chat(user, span_warning("你需要更强的握力才能使用这个!"))
		return FALSE
	user.spin(15, 1)
	for(var/mob/living/carbon/target in orange(1, user))
		if(!(ishuman(target) || isxeno(target)) || isyautja(target))
			continue

		if(target.stat == DEAD)
			continue

		if(!line_of_sight(user, target))
			continue

		user.visible_message(span_userdanger("[user]切开了[target]的内脏!"), span_userdanger("你切开了[target]的内脏!"))
		target.spawn_gibs()
		playsound(get_turf(target), 'sound/effects/gibbed.ogg', 30, 1)
		target.apply_effect(1, EFFECT_PARALYZE)
		target.apply_damage(force * 3, BRUTE, "chest", MELEE, FALSE, FALSE, TRUE, 65)

		log_attack("[key_name(target)] was sliced by [key_name(user)] whirling their scythe.")

	ability_charge -= ability_cost
	remove_filter("scythe_ready")
	charged = FALSE
	return TRUE


/obj/item/weapon/yautja/scythe/alt
	name = "双战争镰刀"
	desc = "用于猎杀危险猎物的巨大,极其锋利的双刃.这种武器通常由希望使敌人丧失能力并将其切碎的亚乌查携带."
	icon_state = "predscythe_alt"
	worn_icon_state = "scythe_double"

//Combistick
/obj/item/weapon/yautja/combistick
	name = "组合棍"
	desc = "一种紧凑但致命的个人武器.折叠时可以隐藏.作为投掷武器或防御工具都很有效.由于其多功能性,在亚乌查群体中很常见."
	icon_state = "combistick"
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BACK
	item_flags = TWOHANDED|ITEM_PREDATOR
	w_class = WEIGHT_CLASS_HUGE
	throw_speed = 10
	throw_range = 4
	resistance_flags = UNACIDABLE
	force = 25
	throwforce = 32
	penetration = 30
	sharp = IS_SHARP_ITEM_SIMPLE
	edge = TRUE
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("speared", "stabbed", "impaled")

	ability_cost = 1
	ability_charge_max = 1
	ability_charge_rate = 1

	var/on = 1

	var/force_unwielded = 10
	var/force_storage = 5
	var/throwforce_base = 32
	var/throwforce_storage = 5

/obj/item/weapon/yautja/combistick/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_PRE_THROW, PROC_REF(try_to_throw))

/obj/item/weapon/yautja/combistick/afterattack(atom/A, mob/user, proximity, params)
	if(istype(A, /obj/item/clothing/gloves/yautja))
		var/obj/item/clothing/gloves/yautja/bracer = A
		if(bracer.combistick)
			if(src == bracer.combistick)
				to_chat(user, span_warning("你解除了[bracer]和[src]的连接."))
				playsound(user.loc, 'sound/items/pred_bracer.ogg', 75, 1)
				bracer.combistick = null
			else
				to_chat(user, span_warning("在此之前,你需要先解除之前连接的[bracer]."))
		else
			bracer.combistick = src
			to_chat(user, span_warning("你将[src]连接到[bracer]."))
			playsound(user.loc, 'sound/items/pred_bracer.ogg', 75, 1)
		bracer.owner.update_action_buttons()
	..()

/obj/item/weapon/yautja/combistick/dropped(mob/living/carbon/human/M)
	unwield(M)
	..()

/obj/item/weapon/yautja/combistick/proc/try_to_throw()
	SIGNAL_HANDLER

	var/mob/living/carbon/human/handler = usr
	if(!istype(handler))
		return

	if(!charged)
		to_chat(handler, span_warning("你的组合棍拒绝离开你的手.你必须在投掷前用猎物的血液为其充能."))
		unwield(handler)
		handler.put_in_hands(src)
		wield(handler)
		return COMPONENT_MOVABLE_BLOCK_PRE_THROW

	charged = FALSE
	remove_filter("combistick_charge")
	unwield(handler) //Otherwise stays wielded even when thrown

/obj/item/weapon/yautja/combistick/verb/use_unique_action()
	set category = "IC.Weapons"
	set name = "Unique Action"
	set desc = "Activate or deactivate the combistick."
	set src in usr
	unique_action(usr)

/obj/item/weapon/yautja/combistick/attack_self(mob/user)
	..()
	if(on)
		if(item_flags & WIELDED)
			unwield(user)
		else
			wield(user)
	else
		to_chat(user, span_warning("你需要先展开组合棍才能使用它."))


/obj/item/weapon/yautja/combistick/wield(mob/user)
	. = ..()
	if(!.)
		return
	force = force_activated
	update_icon()

/obj/item/weapon/yautja/combistick/unwield(mob/user)
	. = ..()
	if(!.)
		return
	force = force_unwielded
	update_icon()

/obj/item/weapon/yautja/combistick/update_icon()
	. = ..()
	if(item_flags & WIELDED)
		worn_icon_state = "combistick_w"
	else if(!on)
		worn_icon_state = "combistick_f"
	else
		worn_icon_state = "combistick"

/obj/item/weapon/yautja/combistick/unique_action(mob/living/user)
	if(user.get_active_held_item() != src)
		return
	if(!on)
		user.visible_message(span_info("[user]手腕一抖,展开了[src]."),\
		span_notice("你展开了[src]."),\
		"You hear blades extending.")
		playsound(src,'sound/items/combistick_open.ogg', 50, TRUE, 3)
		icon_state = initial(icon_state)
		equip_slot_flags = initial(equip_slot_flags)
		item_flags |= TWOHANDED
		w_class = WEIGHT_CLASS_HUGE
		force = force_unwielded
		throwforce = throwforce_base
		attack_verb = list("speared", "stabbed", "impaled")

		if(blood_overlay && blood_color)
			overlays.Cut()
			add_blood(blood_color)
		on = TRUE
		update_icon()
	else
		unwield(user)
		to_chat(user, span_notice("你收起[src]以便存放."))
		playsound(src, 'sound/items/combistick_close.ogg', 50, TRUE, 3)
		icon_state = initial(icon_state) + "_f"
		equip_slot_flags = ITEM_SLOT_BACK
		item_flags &= ~TWOHANDED
		w_class = WEIGHT_CLASS_TINY
		force = force_storage
		throwforce = throwforce_storage
		attack_verb = list("thwacked", "smacked")
		overlays.Cut()
		on = FALSE
		update_icon()

	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		H.update_inv_l_hand()
		H.update_inv_r_hand()

	add_fingerprint(user, "attack_self")

	return

/obj/item/weapon/yautja/combistick/attack(mob/living/target, mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	if((human_adapted || isyautja(user)) && isxeno(target))
		var/mob/living/carbon/xenomorph/xenomorph = target
		xenomorph.interference = 30

	if(target == user || target.stat == DEAD)
		to_chat(user, span_danger("你以为你很聪明?")) //very funny
		return
	if(isanimal(target))
		return


	if(!charged && ability_charge >= ability_cost)
		to_chat(user, span_danger("你的组合棍储液槽充满了对手的血液!你现在可以投掷它了!"))
		charged = TRUE
		var/color = target.get_blood_color()
		var/alpha = 70
		color += num2text(alpha, 2, 16)
		add_filter("combistick_charge", 1, list("type" = "outline", "color" = color, "size" = 2))

/obj/item/weapon/yautja/combistick/attack_hand(mob/user) //Prevents marines from instantly picking it up via pickup macros.
	if(!human_adapted && !HAS_TRAIT(user, TRAIT_SUPER_STRONG))
		user.visible_message(span_danger("[user]开始解开\the [src]上的链条..."), span_notice("你开始解开\the [src]上的链条..."))
		playsound(loc, 'sound/items/chain_fumble.ogg', 25)
		if(do_after(user, 3 SECONDS, NONE, src, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE, PROGRESS_BRASS))
			..()
	else ..()

/obj/item/weapon/yautja/combistick/throw_impact(atom/hit_atom)
	if(isyautja(hit_atom))
		var/mob/living/carbon/human/human = hit_atom
		if(human.put_in_hands(src))
			hit_atom.visible_message(span_notice(" [hit_atom]熟练地在空中接住了[src]. "), \
				span_notice(" 你轻松地接住了[src]. "))
			return
	..()

/obj/item/weapon/yautja/knife
	name = "仪式匕首"
	desc = "一把刻有古老亚乌查标记的锋利匕首.散发着浓重的血腥味.由一些猎人携带."
	icon_state = "predknife"
	worn_icon_state = "knife"
	atom_flags = CONDUCT
	item_flags = ITEM_PREDATOR
	equip_slot_flags = ITEM_SLOT_BACK
	sharp = IS_SHARP_ITEM_ACCURATE
	force = 20
	penetration = 10
	w_class = WEIGHT_CLASS_TINY
	throwforce = 15
	throw_speed = 10
	throw_range = 6
	hitsound = 'sound/weapons/slash.ogg'
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	resistance_flags = UNACIDABLE

/obj/item/weapon/yautja/knife/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/shrapnel_removal, 4 SECONDS, 0, TRUE)

/obj/item/weapon/yautja/knife/attack(mob/living/target, mob/living/carbon/human/user)
	if(target.stat != DEAD)
		return ..()

	if(!ishuman(target))
		to_chat(user, span_warning("你只能用这把匕首剥人形生物的皮!"))
		return

	var/mob/living/carbon/human/victim = target

	if(!HAS_TRAIT(user, TRAIT_SUPER_STRONG))
		to_chat(user, span_warning("你不够强壮,无法将整个人形生物撕开.而且,那也太变态了.")) //look at this dumbass
		return TRUE

	if(user.species.name == victim.species.name)
		to_chat(user, span_userdanger("你疯了吗!?"))
		return

	if(issynth(victim) || isrobot(victim) || victim.species.species_flags & ROBOTIC_LIMBS)
		to_chat(user, span_warning("你无法剥金属的皮...")) //look at this dumbass
		return

	if(SEND_SIGNAL(victim, COMSIG_HUMAN_FLAY_ATTEMPT, user, src) & COMPONENT_ITEM_NO_ATTACK)
		return TRUE

	if(victim.overlays_standing[FLAY_LAYER]) //Already fully flayed. Possibly the user wants to cut them down?
		return ..()

	if(!do_after(user, 1 SECONDS, NONE, victim, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
		return TRUE

	user.visible_message(span_danger("<B>[user]开始用\a [src]剥[victim]的皮...</B>"),
		span_danger("<B>你开始用你的[src.name]剥[victim]的皮...</B>"))
	playsound(loc, 'sound/weapons/pierce.ogg', 25)
	if(do_after(user, 4 SECONDS, NONE, victim, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
		if(SEND_SIGNAL(victim, COMSIG_HUMAN_FLAY_ATTEMPT, user, src) & COMPONENT_ITEM_NO_ATTACK) //In case two preds try to flay the same person at once.
			return TRUE
		user.visible_message(span_danger("<B>[user]在[victim]的皮肤上划出一系列切口.</B>"),
			span_danger("<B>你准备好皮肤,在关键部位切下血肉.</B>"))
		playsound(loc, 'sound/weapons/slash.ogg', 25)

		for(var/limb in victim.limbs)
			victim.apply_damage(15, BRUTE, limb, sharp = FALSE)
		victim.add_flay_overlay(stage = 1)

		var/datum/flaying_datum/flay_datum = new(victim)
		flay_datum.create_leftovers(victim, TRUE, 0)
		SEND_SIGNAL(victim, COMSIG_HUMAN_FLAY_ATTEMPT, user, src, TRUE)
	else
		to_chat(user, span_warning("你在完成工作之前被打断了!"))
	return TRUE

/obj/item/weapon/yautja/knife/afterattack(obj/attacked_obj, mob/living/user, proximity)
	if(!proximity)
		return

	if(!HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		return

	if(!istype(attacked_obj, /obj/item/limb))
		return
	var/obj/item/limb/current_limb = attacked_obj

	if(current_limb.flayed)
		to_chat(user, span_notice("这个肢体已经被剥皮了."))
		return

	playsound(loc, 'sound/weapons/pierce.ogg', 25)
	to_chat(user, span_warning("你开始剥[current_limb]的皮."))
	if(!do_after(user, 2 SECONDS, NONE, current_limb, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
		to_chat(user, span_notice("你决定不剥[current_limb]的皮."))
		return
	to_chat(user, span_warning("你完成了剥[current_limb]的皮."))
	current_limb.flayed = TRUE
