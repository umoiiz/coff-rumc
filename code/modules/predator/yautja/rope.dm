/obj/item/stack/yautja_rope
	name = "奇怪的绳子"
	singular_name = "rope meter"
	desc = "这根不起眼的绳子似乎布满了描绘着奇怪人形图案的标记."
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "brutepack"
	worn_icon_state = "coil"
	force = 2
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("whipped", "lashed", "disciplined", "flogged")
	color = "#D2B48C"
	attack_speed = 1.4 SECONDS //stop spam
	amount = 8
	max_amount = 8

/obj/item/stack/yautja_rope/attack(mob/living/mob_victim, mob/living/carbon/human/user)
	if(mob_victim.stat != DEAD)
		return ..()

	if(mob_victim.mob_size != MOB_SIZE_HUMAN)
		to_chat(user, span_warning("[mob_victim]的身体结构不适合吊起来."))
		return TRUE

	if(!HAS_TRAIT(user, TRAIT_SUPER_STRONG))
		to_chat(user, span_warning("你不够强壮,无法用绳子把[mob_victim]吊起来.而且,这也有点太变态了."))
		return TRUE

	var/mob/living/carbon/human/victim = mob_victim

	if(!do_after(user, 1 SECONDS, NONE, victim, BUSY_ICON_HOSTILE))
		return TRUE

	user.visible_message(span_notice("[user]开始把\his 绳子固定到天花板上..."),
		span_notice("你开始把绳子固定到天花板上..."))

	if(do_after(user, 4 SECONDS, NONE, victim, BUSY_ICON_HOSTILE))
		var/turf/rturf = get_turf(victim)
		var/area/rarea = get_area(victim)
		if(rturf.density)
			to_chat(user, span_warning("他们在墙里!"))
			return TRUE
		if(rarea.ceiling == CEILING_NONE)
			to_chat(user, span_warning("没有天花板可以吊他们!"))
			return TRUE
		user.visible_message(span_notice("[user]固定好了绳子."),
			span_notice("你固定好了绳子."))
		if(!do_after(user, 1 SECONDS, NONE, victim, BUSY_ICON_HOSTILE))
			return
		user.visible_message(span_warning("[user]开始用绳子把[victim]吊起来..."),
			span_notice("你开始用绳子把[victim]吊起来..."))
		if(!do_after(user, 3 SECONDS, NONE, victim, BUSY_ICON_HOSTILE))
			return
		user.visible_message(span_warning("[user]把[victim]吊在了天花板上!"), span_notice("你完成了对[victim]的吊挂."))
		playsound(loc, 'sound/effects/noosed.ogg', 15, 1)
		user.stop_pulling()
		victim.get_hung()
		use(1)
	return TRUE

/mob/living/carbon/human/proc/get_hung()
	animate(src, pixel_y = 9, time = 0.5 SECONDS, easing = SINE_EASING|EASE_OUT)
	setDir(SOUTH)
	var/matrix/A = matrix()
	A.Turn(180)
	status_flags |= INCORPOREAL
	initial_transform = transform
	transform = A
	var/rand_swing = rand(6, 3)
	//-6, -3
	animate(src, pixel_x = (rand_swing * -1), time = 3 SECONDS, loop = -1, easing = SINE_EASING|EASE_OUT)
	animate(pixel_x = rand_swing, time = 3 SECONDS,  easing = SINE_EASING|EASE_OUT)

	anchored = TRUE
	RegisterSignal(src, COMSIG_ATTEMPT_MOB_PULL, PROC_REF(deny_pull))
	RegisterSignals(src, list(
		COMSIG_ITEM_ATTEMPT_ATTACK,
		COMSIG_LIVING_POST_FULLY_HEAL
		), PROC_REF(cut_down))

/mob/living/carbon/human/proc/deny_pull()
	return COMPONENT_CANCEL_MOB_PULL

/mob/living/carbon/human/proc/cut_down(mob/living/carbon/human/target, mob/living/user, obj/item/source)
	//source = item, target = src
	SIGNAL_HANDLER
	if(source && !source.sharp)
		return

	if(user)
		if(user.a_intent != INTENT_HELP)
			return
		user.visible_message(span_warning("[user]用\the [source]割下了[src]."), span_warning("你用\the [source]割下了[src]."))
		user.do_attack_animation(src)
		playsound(src, 'sound/effects/vegetation_hit.ogg', 25, TRUE)
	else
		visible_message(span_danger("[src]的尸体从吊绳上掉了下来!"))
	UnregisterSignal(src, list(
			COMSIG_ATTEMPT_MOB_PULL,
			COMSIG_ITEM_ATTEMPT_ATTACK,
			COMSIG_LIVING_POST_FULLY_HEAL
		))
	animate(src) //remove the anims
	anchored = FALSE
	var/matrix/A = matrix()
	A.Turn(90)
	transform = A
	transform = initial_transform
	status_flags &= ~INCORPOREAL
	pixel_x = 0
	pixel_y = 0
	return COMPONENT_ITEM_NO_ATTACK
