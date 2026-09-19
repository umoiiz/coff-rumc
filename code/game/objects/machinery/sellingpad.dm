/obj/machinery/exportpad
	name = "ASRS Bluespace Export Point"
	desc = "一个蓝空间传送垫,用于运送贵重资产,例如贵重矿物和异形尸体. 它需要在有电的区域用扳手固定才能运作."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "broadcaster_off"
	density = FALSE
	anchored = FALSE
	use_power = IDLE_POWER_USE
	wrenchable = TRUE
	idle_power_usage = 50
	active_power_usage = 3000
	COOLDOWN_DECLARE(selling_cooldown)

/obj/machinery/exportpad/attack_hand(mob/living/user)
	. = ..()

	if (!anchored)
		to_chat(user, span_warning("什么也没发生. [src]必须先用地脚螺栓固定在地面上."))
		return

	if (!powered())
		to_chat(user, span_warning("[src]上闪烁着一盏红灯. 它似乎电力不足."))
		playsound(loc,'sound/machines/buzz-two.ogg', 25, FALSE)
		return

	if(!COOLDOWN_FINISHED(src, selling_cooldown))
		to_chat(user, span_warning("[src]仍在充电! 它将在[round(COOLDOWN_TIMELEFT(src, selling_cooldown) * 0.1)]秒后就绪."))
		return
	var/can_sell = FALSE
	for(var/i in get_turf(src))
		var/atom/movable/onpad = i
		can_sell = FALSE
		if(isxeno(onpad))
			var/mob/living/carbon/xenomorph/sellxeno = onpad
			if(sellxeno.stat != DEAD)
				to_chat(user, span_warning("[src]发出蜂鸣声: 活体动物无法出售."))
				continue
			can_sell = TRUE
		if(ishuman(onpad))
			var/mob/living/carbon/human/sellhuman = onpad
			if(!can_sell_human_body(sellhuman, user.faction))
				to_chat(user, span_warning("[src]发出蜂鸣声: 最高指挥部对此悬赏不感兴趣."))
				continue
			if(sellhuman.stat != DEAD)
				to_chat(user, span_warning("[src]发出蜂鸣声: 此悬赏目标未死亡,无法出售."))
				continue
			can_sell = TRUE
		if(!can_sell)
			continue
		var/datum/export_report/export_report = onpad.supply_export(user.faction)
		if(export_report)
			SSpoints.export_history += export_report
		visible_message(span_notice("[src]发出蜂鸣声: [onpad]已以[export_report.points ? export_report.points : "no"]点[export_report.points == 1 ? "" : "s"]售出."))
		qdel(onpad)

	do_sparks(5, TRUE, src)
	playsound(loc,'sound/effects/phasein.ogg', 50, FALSE)
	COOLDOWN_START(src, selling_cooldown, 30 SECONDS)
	use_power = ACTIVE_POWER_USE//takes a lot more power while cooling down
	addtimer(VARSET_CALLBACK(src, use_power, IDLE_POWER_USE), 30 SECONDS)


/obj/machinery/exportpad/wrench_act(mob/living/user, obj/item/I)
	anchored = !anchored
	if(anchored)
		to_chat(user, "你把[src]用螺栓固定在地上,将其激活.")
		playsound(loc, 'sound/items/ratchet.ogg', 25, TRUE)
		icon_state = "broadcaster"
		SSminimaps.add_marker(src, MINIMAP_FLAG_MARINE, image('icons/UI_icons/map_blips.dmi', null, "asrs", MINIMAP_BLIPS_LAYER))
	else
		to_chat(user, "你松开[src]在地上的螺栓,将其停用.")
		playsound(loc, 'sound/items/ratchet.ogg', 25, TRUE)
		icon_state = "broadcaster_off"
		SSminimaps.remove_marker(src)
