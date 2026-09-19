/obj/item/explosive/plastique/detpack
	name = "引爆包"
	desc = "可通过信号器远程触发的可编程\"智能\"炸药, 用于爆破和临时诡雷. 可设置为破门或爆破起爆模式."
	gender = PLURAL
	icon = 'icons/obj/det.dmi'
	icon_state = "detpack_off"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/explosives_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/explosives_right.dmi',
		)
	worn_icon_state = "plasticx"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	layer = MOB_LAYER - 0.1
	var/frequency = 1457
	var/on = FALSE
	var/code = 2
	///FALSE for breach, TRUE for demolition.
	var/det_mode = FALSE
	///store this for restoration later
	var/target_drag_delay = null
	///confirms whether we actually detted.
	var/boom = FALSE
	var/sound_timer
	var/datum/radio_frequency/radio_connection

/obj/item/explosive/plastique/detpack/Initialize(mapload)
	. = ..()
	set_frequency(frequency)
	code = rand(1, 100)

/obj/item/explosive/plastique/detpack/examine(mob/user)
	. = ..()
	. += span_info("<b>独特动作</b> (默认为空格键) 进行布设.")
	. += span_info("用信号器对其<b>左键</b>以复制信号代码.")
	if(on)
		. += span_warning("它已开启.")
	if(timer)
		. += span_warning("它的计时器还剩[timer]秒.")
	if(det_mode)
		. += span_warning("它似乎设置为爆破模式, 提供更广的爆炸范围, 对墙壁伤害很小.")
	else
		. += span_warning("它似乎设置为破门模式, 提供集中的爆炸, 可炸穿墙壁.")

	if(armed)
		. += span_warning("<b>它已布设!</b>")

/obj/item/explosive/plastique/detpack/Destroy()
	if(sound_timer)
		deltimer(sound_timer)
		sound_timer = null
	if(detonation_pending)
		deltimer(detonation_pending)
		detonation_pending = null
	if(plant_target && !boom) //whatever name you give it
		loc = get_turf(src)
		nullvars()
	else
		nullvars()
	return ..()

/obj/item/explosive/plastique/detpack/ex_act()
	return

/obj/item/explosive/plastique/detpack/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = SSradio.add_object(src, frequency, RADIO_SIGNALER)

/obj/item/explosive/plastique/detpack/update_icon_state()
	. = ..()
	icon_state = "detpack_[plant_target ? "set_" : ""]"
	if(on)
		icon_state = "[icon_state][armed ? "armed" : "on"]"
	else
		icon_state = "[icon_state]off"

/obj/item/explosive/plastique/detpack/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(issignaler(I))
		var/obj/item/assembly/signaler/signaler = I
		code = signaler.code
		set_frequency(signaler.frequency)
		balloon_alert(user, "频率已复制")

/obj/item/explosive/plastique/detpack/unique_action(mob/user, special_treatment)
	. = ..()
	on = !on
	update_icon()

/obj/item/explosive/plastique/detpack/attack_hand(mob/living/user)
	if(armed)
		balloon_alert(user, "先解除布设!")
		return
	if(plant_target)
		user.visible_message(span_notice("[user]开始从[plant_target]上卸下[src]."),
		span_notice("你开始从[plant_target]上卸下[src]."))
		if(!do_after(user, 3 SECONDS, NONE, src, BUSY_ICON_BUILD))
			return
		user.visible_message(span_notice("[user]从[plant_target]上卸下了[src]."),
		span_notice("你从[plant_target]上卸下了[src]."))
		nullvars()
	return ..()

/obj/item/explosive/plastique/detpack/multitool_act(mob/living/user, obj/item/I)
	if(!armed && !on)
		balloon_alert(user, "未激活")
		return
	if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_METAL)
		user.visible_message(span_notice("[user]笨拙地摸索着如何使用[src]."),
		span_notice("你笨拙地摸索着如何使用[src]."))
		var/fumbling_time = 3 SECONDS
		if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
			return

		if(prob((SKILL_ENGINEER_METAL - user.skills.getRating(SKILL_ENGINEER)) * 20))
			to_chat(user, span_userdanger("在你笨拙地摆弄了几秒后,[src]愤怒地嗡嗡作响,仿佛被冒犯了.你有一种<b>非常</b>不好的预感."))
			timer = 0 //Oops. Now you fucked up. Immediate detonation.

	user.visible_message(span_notice("[user]开始用[I]解除[src]的保险."),
	span_notice("你开始用[I]解除[src]的保险."))

	if(!do_after(user, 3 SECONDS, NONE, src, BUSY_ICON_FRIENDLY))
		return

	balloon_alert_to_viewers("已解除保险")
	disarm()

/obj/item/explosive/plastique/detpack/proc/nullvars()
	if(ismovableatom(plant_target) && plant_target.loc)
		var/atom/movable/T = plant_target
		if(T.drag_delay == 3)
			T.drag_delay = target_drag_delay //reset the drag delay of whatever we attached the detpack to
		T.vis_contents -= src
	plant_target = null //null everything out now
	target_drag_delay = null
	armed = FALSE
	boom = FALSE
	SSradio.remove_object(src, frequency)
	radio_connection = null
	update_icon()

/obj/item/explosive/plastique/detpack/receive_signal(datum/signal/signal)
	if(!signal || !on)
		return

	if(signal.data["code"] != code)
		return

	if(armed)
		disarm(FALSE)
		return
	if(!plant_target) //has to be planted on something to begin detonating.
		return
	armed = TRUE
	log_bomber(usr, "triggered", src)
	detonation_pending = addtimer(CALLBACK(src, PROC_REF(detonate)), timer SECONDS, TIMER_STOPPABLE)
	if(timer > 10)
		sound_timer = addtimer(CALLBACK(src, PROC_REF(do_play_sound_normal)), 1 SECONDS, TIMER_LOOP|TIMER_STOPPABLE)
		addtimer(CALLBACK(src, PROC_REF(change_to_loud_sound)), timer-10)
	else
		sound_timer = addtimer(CALLBACK(src, PROC_REF(do_play_sound_loud)), 1 SECONDS, TIMER_LOOP|TIMER_STOPPABLE)
	update_icon()

/obj/item/explosive/plastique/detpack/Topic(href, href_list)
	. = ..()
	if(.)
		return

	if(href_list["freq"])
		var/new_frequency = (frequency + text2num(href_list["freq"]))
		set_frequency(new_frequency)

	else if(href_list["code"])
		code += text2num(href_list["code"])
		code = clamp(round(code), 1, 100)

	else if(href_list["det_mode"])
		det_mode = !det_mode
		update_icon()

	else if(href_list["power"])
		on = !on
		update_icon()

	else if(href_list["timer"])
		timer += text2num(href_list["timer"])
		timer = clamp(round(timer), DETPACK_TIMER_MIN, DETPACK_TIMER_MAX)

	updateUsrDialog()

/obj/item/explosive/plastique/detpack/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE

	if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_METAL)
		if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_UNSKILLED))
			return FALSE

	return TRUE

/obj/item/explosive/plastique/detpack/interact(mob/user)
	. = ..()
	if(.)
		return

	var/dat = {"
		<A href='byond://?src=[text_ref(src)];power=1'>Turn [on ? "Off" : "On"]</A><BR>
		<B>Current Detonation Mode:</B> [det_mode ? "Demolition" : "Breach"]<BR>
		<A href='byond://?src=[text_ref(src)];det_mode=1'><B>Set Detonation Mode:</B> [det_mode ? "Breach" : "Demolition"]</A><BR>
		<B>Frequency/Code for Detpack:</B><BR>
		<A href='byond://?src=[text_ref(src)];freq=-10'>-</A>
		<A href='byond://?src=[text_ref(src)];freq=-2'>-</A>
		[format_frequency(src.frequency)]
		<A href='byond://?src=[text_ref(src)];freq=2'>+</A>
		<A href='byond://?src=[text_ref(src)];freq=10'>+</A><BR>
		<B>Signal Code:</B><BR>
		<A href='byond://?src=[text_ref(src)];code=-5'>-</A>
		<A href='byond://?src=[text_ref(src)];code=-1'>-</A> [code]
		<A href='byond://?src=[text_ref(src)];code=1'>+</A>
		<A href='byond://?src=[text_ref(src)];code=5'>+</A><BR>
		<B>Timer (Max 300 seconds, Min 5 seconds):</B><BR>
		<A href='byond://?src=[text_ref(src)];timer=-50'>-</A>
		<A href='byond://?src=[text_ref(src)];timer=-10'>-</A>
		<A href='byond://?src=[text_ref(src)];timer=-5'>-</A>
		<A href='byond://?src=[text_ref(src)];timer=-1'>-</A> [timer]
		<A href='byond://?src=[text_ref(src)];timer=1'>+</A>
		<A href='byond://?src=[text_ref(src)];timer=5'>+</A>
		<A href='byond://?src=[text_ref(src)];timer=10'>+</A>
		<A href='byond://?src=[text_ref(src)];timer=50'>+</A><BR>"}

	var/datum/browser/popup = new(user, "detpack")
	popup.set_content(dat)
	popup.open()

/obj/item/explosive/plastique/detpack/afterattack(atom/target, mob/user, flag)
	if(!flag)
		return FALSE
	if(issignaler(target))
		var/obj/item/assembly/signaler/signaler = target
		code = signaler.code
		set_frequency(signaler.frequency)
		to_chat(user, "你将[signaler]的频率和代码传输到[src].")
		return
	if(istype(target, /obj/item))
		return FALSE
	if(target.resistance_flags & INDESTRUCTIBLE)
		return FALSE
	if(istype(target, /obj/vehicle/unmanned))
		var/obj/vehicle/unmanned/unmanned_target = target
		if(!unmanned_target.allow_explosives)
			to_chat(user, "[span_warning("[src] doesnt fit on [unmanned_target]")]!")
			return FALSE
	if(istype(target, /obj/structure/window))
		var/obj/structure/window/W = target
		if(!W.damageable)
			to_chat(user, "[span_warning("[W] is much too tough for you to do anything to it with [src]")].")
			return FALSE

	if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_METAL)
		user.visible_message(span_notice("[user]笨手笨脚地摸索着如何使用[src]."),
		span_notice("你笨手笨脚地摸索着如何使用[src]."))
		if(!do_after(user, 5 SECONDS, NONE, target, BUSY_ICON_UNSKILLED))
			return

	user.visible_message(span_warning("[user]正试图将[name]安放在[target]上!"),
	span_warning("你正试图将[name]安放在[target]上!"))

	if(do_after(user, 3 SECONDS, NONE, target, BUSY_ICON_HOSTILE))
		user.drop_held_item()
		playsound(src.loc, 'sound/weapons/mine_armed.ogg', 25, 1)
		var/location
		location = target
		forceMove(location)

		log_game("[key_name(user)] planted [src.name] on [target.name] at [AREACOORD(target.loc)] with [timer] second fuse.")
		message_admins("[ADMIN_TPMONTY(user)] planted [src.name] on [target.name] at [ADMIN_VERBOSEJMP(target.loc)] with [timer] second fuse.")

		notify_ghosts("<b>[user]</b> has planted \a <b>[name]</b> on <b>[target.name]</b> with a <b>[timer]</b> second fuse!", source = user, action = NOTIFY_ORBIT)

		//target.overlays += image('icons/obj/items/assemblies.dmi', "plastic-explosive2")
		balloon_alert(user, "计时器设定为[timer]秒")

		plant_target = target
		if(ismovableatom(plant_target))
			var/atom/movable/T = plant_target
			T.vis_contents += src
			if(T.drag_delay < 3) //Anything with a fast drag delay we need to modify to avoid kamikazi tactics
				target_drag_delay = T.drag_delay
				T.drag_delay = 3
		if(radio_connection == null)
			set_frequency(frequency)
		update_icon()

/obj/item/explosive/plastique/detpack/proc/change_to_loud_sound()
	if(sound_timer)
		deltimer(sound_timer)
		sound_timer = addtimer(CALLBACK(src, PROC_REF(do_play_sound_loud)), 1 SECONDS, TIMER_LOOP|TIMER_STOPPABLE)

/obj/item/explosive/plastique/detpack/proc/do_play_sound_normal()
	timer--
	playsound(loc, 'sound/weapons/mine_tripped.ogg', 50, FALSE)

/obj/item/explosive/plastique/detpack/proc/do_play_sound_loud()
	timer--
	playsound(loc, 'sound/weapons/mine_tripped.ogg', 160 + (timer-timer*2)*10, FALSE) //Gets louder as we count down to armaggedon

/obj/item/explosive/plastique/detpack/proc/disarm(turn_off = TRUE)
	if(timer < DETPACK_TIMER_MIN) //reset to minimum 5 seconds; no 'cooking' with aborted detonations.
		timer = DETPACK_TIMER_MIN
	if(sound_timer)
		deltimer(sound_timer)
		sound_timer = null
	if(detonation_pending)
		deltimer(detonation_pending)
		detonation_pending = null
	armed = FALSE
	if(turn_off)
		on = FALSE
	update_icon()

/obj/item/explosive/plastique/detpack/detonate()
	detonation_pending = null
	if(plant_target == null || !plant_target.loc) //need a target to be attached to
		if(timer < DETPACK_TIMER_MIN) //reset to minimum 5 seconds; no 'cooking' with aborted detonations.
			timer = DETPACK_TIMER_MIN
		deltimer(sound_timer)
		sound_timer = null
		nullvars()
		return
	if(!on) //need to be active and armed.
		armed = FALSE
		if(timer < DETPACK_TIMER_MIN) //reset to minimum 5 seconds; no 'cooking' with aborted detonations.
			timer = DETPACK_TIMER_MIN
		deltimer(sound_timer)
		sound_timer = null
		update_icon()
		return
	if(!armed)
		disarm()

	//Time to go boom
	playsound(src.loc, 'sound/weapons/ring.ogg', 200, FALSE)
	boom = TRUE
	if(det_mode == TRUE) //If we're on demolition mode, big boom.
		cell_explosion(plant_target, 315, 55)
	else //if we're not, focused boom.
		cell_explosion(plant_target, 450, 200, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL)
	plant_target.plastique_act()
	qdel(src)

/obj/item/explosive/plastique/detpack/attack(mob/M as mob, mob/user as mob, def_zone)
	return

/obj/item/explosive/plastique/detpack/attack_self(mob/user)
	interact(user)
	return

////////////////////////////////////////////////
////////////////////////////////////////////////

/obj/item/explosive/plastique/detpack/trench
	name = "更好的战壕炸药"
	desc = "用于快速挖掘战壕.由于你根本不知道战壕是什么,你大概可以用这东西在石头上挖个洞."
	/// Cardinal direction from the planter toward the target wall at plant time.
	var/plant_direction

/obj/item/explosive/plastique/detpack/trench/nullvars()
	plant_direction = null
	return ..()

/obj/item/explosive/plastique/detpack/trench/detonate()
	detonation_pending = null
	if(plant_target == null || !plant_target.loc) //need a target to be attached to
		if(timer < DETPACK_TIMER_MIN) //reset to minimum 5 seconds; no 'cooking' with aborted detonations.
			timer = DETPACK_TIMER_MIN
		deltimer(sound_timer)
		sound_timer = null
		nullvars()
		return
	if(!on) //need to be active and armed.
		armed = FALSE
		if(timer < DETPACK_TIMER_MIN) //reset to minimum 5 seconds; no 'cooking' with aborted detonations.
			timer = DETPACK_TIMER_MIN
		deltimer(sound_timer)
		sound_timer = null
		update_icon()
		return
	if(!armed)
		disarm()

	//Time to go boom
	playsound(src.loc, 'sound/weapons/ring.ogg', 200, FALSE)
	boom = TRUE
	if(det_mode == TRUE) //If we're on demolition mode, big boom.
		cell_explosion(plant_target, 315, 55)
	else //if we're not, focused boom.
		cell_explosion(plant_target, 450, 200, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL)
	plant_target.plastique_act()

	var/turf/origin = get_turf(plant_target)
	if(origin && plant_direction)
		var/list/affected
		if(det_mode)
			var/list/perpendicular_dirs = get_perpen_dir(plant_direction)
			affected = list(
				origin,
				get_step(origin, perpendicular_dirs[1]),
				get_step(origin, perpendicular_dirs[2]),
			)
		else
			var/turf/ahead_one = get_step(origin, plant_direction)
			affected = list(
				origin,
				ahead_one,
				get_step(ahead_one, plant_direction),
			)
		for(var/turf/closed/T as anything in affected)
			if(!istype(T, /turf/closed)) //undefined variable /turf/open/floor/plating/var/open_turf_type
				continue
			if(CHECK_BITFIELD(T.resistance_flags, PLASMACUTTER_IMMUNE) || CHECK_BITFIELD(T.resistance_flags, INDESTRUCTIBLE))
				continue
			T.ChangeTurf(T.open_turf_type)

	qdel(src)

/obj/item/explosive/plastique/detpack/trench/afterattack(atom/target, mob/user, flag)
	if(!istype(target, /turf/closed) && !issignaler(target))
		return
	if(istype(target, /turf/closed))
		plant_direction = get_cardinal_dir(user, target)
	..()
