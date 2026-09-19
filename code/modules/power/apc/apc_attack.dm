/obj/machinery/power/apc/attack_alien(mob/living/carbon/xenomorph/X, damage_amount = X.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = "", effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(X.status_flags & INCORPOREAL)
		return FALSE

	if(effects)
		X.do_attack_animation(src, ATTACK_EFFECT_CLAW)
		X.visible_message(span_danger("[X]劈砍\the [src]!"), \
		span_danger("我们劈砍\the [src]!"), null, 5)
		playsound(loc, SFX_ALIEN_CLAW_METAL, 25, 1)

	var/allcut = wires.is_all_cut()

	if(beenhit >= pick(3, 4) && !CHECK_BITFIELD(machine_stat, PANEL_OPEN))
		ENABLE_BITFIELD(machine_stat, PANEL_OPEN)
		update_appearance()
		visible_message(span_danger("\The [src]的盖板弹开,露出了电线!"), null, null, 5)

	else if(CHECK_BITFIELD(machine_stat, PANEL_OPEN) && !allcut)
		wires.cut_all()
		update_appearance()
		visible_message(span_danger("\The [src]的电线在火花中崩断!"), null, null, 5)
		if(X.client)
			var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[X.ckey]
			personal_statistics.apcs_slashed++
	else
		beenhit += 1

//Attack with an item - open/close cover, insert cell, or (un)lock interface //todo please clean this up
/obj/machinery/power/apc/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/cell) && opened) //Trying to put a cell inside
		var/obj/item/cell/C = I
		if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
			user.visible_message(span_notice("[user]笨手笨脚地摸索着如何将[C]装入[src]."),
			span_notice("你笨手笨脚地摸索着如何将[C]装入[src]."))
			var/fumbling_time = 5 SECONDS * ( SKILL_ENGINEER_ENGI - user.skills.getRating(SKILL_ENGINEER) )
			if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
				return

		if(cell)
			balloon_alert(user, "已安装")
			return

		if(machine_stat & MAINT)
			balloon_alert(user, "无连接器")
			return

		if(!(C.apc_compatible))
			balloon_alert(user, "[C]无法装入[src].")
			return

		if(!user.transferItemToLoc(C, src))
			return

		set_cell(C)
		user.visible_message(span_notice("[user]将[C]插入[src]!"),
		span_notice("你将[C]插入[src]!"))
		chargecount = 0
		update_appearance()

	else if(istype(I, /obj/item/card/id)) //Trying to unlock the interface with an ID card
		if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
			user.visible_message(span_notice("[user]笨手笨脚地摸索着该在哪里刷[I]到[src]上."),
			span_notice("你笨手笨脚地摸索着该在哪里刷[I]到[src]上."))
			var/fumbling_time = 3 SECONDS * ( SKILL_ENGINEER_ENGI - user.skills.getRating(SKILL_ENGINEER) )
			if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
				return

		if(opened)
			balloon_alert(user, "先关闭盖板")
			return

		if(CHECK_BITFIELD(machine_stat, PANEL_OPEN))
			balloon_alert(user, "先关闭面板")
			return

		if(machine_stat & (BROKEN|MAINT))
			balloon_alert(user, "什么也没发生")
			return

		if(!allowed(user))
			balloon_alert(user, "访问被拒绝")
			return

		locked = !locked
		balloon_alert_to_viewers("[locked ? "locked" : "unlocked"]")
		update_appearance()

	else if(iscablecoil(I) && !terminal && opened && has_electronics != APC_ELECTRONICS_SECURED)
		var/obj/item/stack/cable_coil/C = I

		if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
			balloon_alert_to_viewers("笨手笨脚地摸索")
			var/fumbling_time = 5 SECONDS * ( SKILL_ENGINEER_ENGI - user.skills.getRating(SKILL_ENGINEER) )
			if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
				return

		var/turf/T = get_turf(src)
		if(T.intact_tile)
			balloon_alert(user, "移除地板")
			return

		if(C.get_amount() < 10)
			balloon_alert(user, "电线不足")
			return

		balloon_alert_to_viewers("开始给[src]接线")
		playsound(loc, 'sound/items/deconstruct.ogg', 25, 1)

		if(!do_after(user, 20, NONE, src, BUSY_ICON_BUILD) || terminal || !opened || has_electronics == APC_ELECTRONICS_SECURED)
			return

		var/obj/structure/cable/N = T.get_cable_node()
		if(prob(50) && electrocute_mob(user, N, N))
			var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
			s.set_up(5, 1, src)
			s.start()
			return

		if(!C.use(10))
			return

		balloon_alert_to_viewers("已接线\]")
		make_terminal()
		terminal.connect_to_network()

	else if(istype(I, /obj/item/circuitboard/apc) && opened && has_electronics == APC_ELECTRONICS_MISSING && !(machine_stat & BROKEN))
		if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
			balloon_alert_to_viewers("笨手笨脚地摸索")
			var/fumbling_time = 5 SECONDS * ( SKILL_ENGINEER_ENGI - user.skills.getRating(SKILL_ENGINEER) )
			if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
				return

		balloon_alert_to_viewers("尝试将APC电路板插入[src]")
		playsound(loc, 'sound/items/deconstruct.ogg', 25, 1)

		if(!do_after(user, 15, NONE, src, BUSY_ICON_BUILD))
			return

		has_electronics = APC_ELECTRONICS_INSTALLED
		balloon_alert_to_viewers("将APC电路板插入[src]")
		qdel(I)

	else if(istype(I, /obj/item/circuitboard/apc) && opened && has_electronics == APC_ELECTRONICS_MISSING && (machine_stat & BROKEN))
		if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
			balloon_alert_to_viewers("笨手笨脚地摸索")
			var/fumbling_time = 5 SECONDS * ( SKILL_ENGINEER_ENGI - user.skills.getRating(SKILL_ENGINEER) )
			if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
				return

		balloon_alert(user, "不行,框架已损坏")

	else if(istype(I, /obj/item/frame/apc) && opened && (machine_stat & BROKEN))
		if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
			balloon_alert_to_viewers("笨手笨脚地摸索")
			var/fumbling_time = 5 SECONDS * ( SKILL_ENGINEER_ENGI - user.skills.getRating(SKILL_ENGINEER) )
			if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
				return

		if(has_electronics)
			balloon_alert(user, "不行,电子元件还在里面")
			return

		balloon_alert_to_viewers("开始更换前面板")

		if(!do_after(user, 50, NONE, src, BUSY_ICON_BUILD))
			return

		balloon_alert_to_viewers("更换前面板")
		qdel(I)
		DISABLE_BITFIELD(machine_stat, BROKEN)
		if(opened == APC_COVER_REMOVED)
			opened = APC_COVER_OPENED
		update_appearance()

	else if(istype(I, /obj/item/frame/apc) && opened)
		if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
			balloon_alert_to_viewers("笨手笨脚地摸索")
			var/fumbling_time = 5 SECONDS * ( SKILL_ENGINEER_ENGI - user.skills.getRating(SKILL_ENGINEER) )
			if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
				return

		if(opened == APC_COVER_REMOVED)
			opened = APC_COVER_OPENED
		balloon_alert_to_viewers("更换[src]的前面板")
		qdel(I)
		update_appearance()

	else
		if(((machine_stat & BROKEN)) && !opened && I.force >= 5)
			opened = APC_COVER_REMOVED
			balloon_alert_to_viewers("击落[src]的面板")
			update_appearance()
		else
			if(issilicon(user))
				return attack_hand(user)

			if(!opened && CHECK_BITFIELD(machine_stat, PANEL_OPEN) && (ismultitool(I) || iswirecutter(I)))
				return attack_hand(user)
			balloon_alert_to_viewers("用[I]击打[src]")

//Attack with hand - remove cell (if cover open) or interact with the APC
/obj/machinery/power/apc/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	if(opened && cell && !issilicon(user))
		if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
			balloon_alert_to_viewers("笨手笨脚地摸索")
			var/fumbling_time = 5 SECONDS * ( SKILL_ENGINEER_ENGI - user.skills.getRating(SKILL_ENGINEER) )
			if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
				return
		balloon_alert_to_viewers("从[src]中取出[src]")
		user.put_in_hands(cell)
		cell.update_appearance()
		set_cell(null)
		charging = APC_NOT_CHARGING
		update_appearance()
		return

	if(machine_stat & (BROKEN|MAINT))
		return

	interact(user)
