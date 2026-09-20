/obj/machinery/power/apc/crowbar_act(mob/user, obj/item/I)
	. = TRUE
	if(opened)
		if(has_electronics == APC_ELECTRONICS_INSTALLED)
			if(terminal)
				balloon_alert(user, "断开线路")
				return
			if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
				balloon_alert_to_viewers("笨拙地摸索着从[src]中取出电池")
				var/fumbling_time = 5 SECONDS * ( SKILL_ENGINEER_ENGI - user.skills.getRating(SKILL_ENGINEER) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return
			I.play_tool_sound(src)
			balloon_alert(user, "正在移除APC电路板")
			if(I.use_tool(src, user, 50))
				if(has_electronics == APC_ELECTRONICS_INSTALLED)
					has_electronics = APC_ELECTRONICS_MISSING
					if(machine_stat & BROKEN)
						balloon_alert_to_viewers("移除烧焦的控制板")
						return
					else
						balloon_alert_to_viewers("移除控制板")
						new /obj/item/circuitboard/apc(loc)
						return
		else if(opened != APC_COVER_REMOVED)
			opened = APC_COVER_CLOSED
			coverlocked = TRUE //closing cover relocks it
			update_appearance()
			return
	else if(!(machine_stat & BROKEN))
		if(coverlocked && !(machine_stat & MAINT)) // locked...
			balloon_alert(user, "已锁定")
			return
		else if(machine_stat & PANEL_OPEN)
			balloon_alert(user, "无法,线路挡路")
			return
		else
			opened = APC_COVER_OPENED
			update_appearance()
			return


/obj/machinery/power/apc/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return TRUE
	. = TRUE
	if(opened)
		if(cell)
			if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
				balloon_alert_to_viewers("笨拙地摸索")
				var/fumbling_time = 5 SECONDS * ( SKILL_ENGINEER_ENGI - user.skills.getRating(SKILL_ENGINEER) )
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return
			balloon_alert_to_viewers("移除电池")
			var/turf/T = get_turf(user)
			cell.forceMove(T)
			cell.update_appearance()
			set_cell(null)
			charging = APC_NOT_CHARGING
			update_appearance()
			return
		else
			switch(has_electronics)
				if(APC_ELECTRONICS_INSTALLED)
					has_electronics = APC_ELECTRONICS_SECURED
					machine_stat &= ~MAINT
					I.play_tool_sound(src)
					balloon_alert(user, "拧紧电路板")
				if(APC_ELECTRONICS_SECURED)
					has_electronics = APC_ELECTRONICS_INSTALLED
					machine_stat |= MAINT
					I.play_tool_sound(src)
					balloon_alert(user, "松开电子元件")
				else
					balloon_alert(user, "没有可固定的东西")
					return
			update_appearance()
	else
		TOGGLE_BITFIELD(machine_stat, PANEL_OPEN)
		balloon_alert(user, "布线 [CHECK_BITFIELD(machine_stat, PANEL_OPEN) ? "exposed" : "unexposed"]")
		update_appearance()


/obj/machinery/power/apc/wirecutter_act(mob/living/user, obj/item/I)
	if(terminal && opened)
		terminal.deconstruct(user)
		return TRUE


/obj/machinery/power/apc/welder_act(mob/living/user, obj/item/I)
	if(!opened || has_electronics || terminal)
		return

	if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
		balloon_alert_to_viewers("失手")
		var/fumbling_time = 5 SECONDS * ( SKILL_ENGINEER_ENGI - user.skills.getRating(SKILL_ENGINEER) )
		if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
			return

	if(!I.tool_start_check(user, amount = 3))
		return
	balloon_alert_to_viewers("焊接 [src]")

	if(!I.use_tool(src, user, 50, volume = 50, amount = 3))
		return

	if((machine_stat & BROKEN) || opened == APC_COVER_REMOVED)
		new /obj/item/stack/sheet/metal(loc)
		balloon_alert_to_viewers("拆开 [src]")
	else
		new /obj/item/frame/apc(loc)
		balloon_alert_to_viewers("从墙上拆下 [src]")
	qdel(src)
	return TRUE

