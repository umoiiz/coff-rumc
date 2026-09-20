/datum/buildmode_mode/delete
	key = "delete"

/datum/buildmode_mode/delete/show_help(client/user)
	to_chat(user, custom_boxed_message("purple_box",\
		"[span_bold("Delete an object")] -> Left Mouse Button on obj/turf/mob\n\
		[span_bold("Delete all objects of a type")] -> Right Mouse Button on obj/turf/mob"))

/datum/buildmode_mode/delete/handle_click(client/user, params, object)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		if(isturf(object))
			var/turf/T = object
			T.ScrapeAway()
			return
		if(isatom(object))
			qdel(object)
		return

	if(!LAZYACCESS(modifiers, RIGHT_CLICK))
		return

	if(!check_rights(R_DEBUG|R_SERVER))	//Prevents buildmoded non-admins from breaking everything.
		return

	if(isturf(object))
		return

	var/atom/deleting = object
	var/action_type = tgui_alert(user,"严格类型 ([deleting.type]) 还是类型及所有子类型?",,list("Strict type","Type and subtypes","Cancel"))
	if(action_type == "Cancel" || !action_type)
		return

	if(tgui_alert(user,"你真的确定要删除类型[deleting.type]的所有实例吗?",,list("Yes","No")) != "Yes")
		return

	if(tgui_alert(user,"需要二次确认. 删除?",,list("Yes","No")) != "Yes")
		return

	switch(action_type)
		if("Strict type")
			var/i = 0
			for(var/atom/found_atom in world)
				if(found_atom.type == deleting.type)
					i++
					qdel(found_atom)
				CHECK_TICK
			if(!i)
				to_chat(usr, "此类型不存在任何实例")
				return
			log_admin("[key_name(usr)] deleted all instances of type [deleting.type] ([i] instances deleted) ")
			message_admins(span_notice("[key_name(usr)]删除了类型[deleting.type]的所有实例 (已删除[i]个实例)"))
		if("Type and subtypes")
			var/i = 0
			for(var/atom/found_atom in world)
				if(istype(found_atom, deleting.type))
					i++
					qdel(found_atom)
				CHECK_TICK
			if(!i)
				to_chat(usr, "此类型不存在任何实例")
				return
			log_admin("[key_name(usr)] deleted all instances of type or subtype of [deleting.type] ([i] instances deleted) ")
			message_admins(span_notice("[key_name(usr)]删除了类型或子类型[deleting.type]的所有实例 (已删除[i]个实例)"))
