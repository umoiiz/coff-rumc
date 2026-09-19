/obj/item/circuitboard
	w_class = WEIGHT_CLASS_TINY
	name = "电路板"
	icon = 'icons/obj/items/circuitboards.dmi'
	icon_state = "id_mod"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/engineering_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/engineering_right.dmi',
	)
	worn_icon_state = "electronic"
	atom_flags = CONDUCT
	var/build_path = null

//Called when the circuitboard is used to contruct a new machine.
/obj/item/circuitboard/proc/construct(obj/machinery/M)
	if (istype(M, build_path))
		return 1
	return 0


//Called when a computer is deconstructed to produce a circuitboard.
//Only used by computers, as other machines store their circuitboard instance.
/obj/item/circuitboard/proc/decon(obj/machinery/M)
	if (istype(M, build_path))
		return 1
	return 0


/obj/item/circuitboard/aicore
	name = "电路板 (AI核心)"


/obj/item/circuitboard/firealarm
	name = "火警电子元件"
	icon_state = "door_electronics"
	desc = "一块电路. 上面有个标签, 写着\"可承受高达40摄氏度的温度!\""


/obj/item/circuitboard/apc
	name = "电源控制模块"
	icon_state = "power_mod"
	desc = "用于APC建造的重型电源控制电路."


// Tracker Electronic
/obj/item/circuitboard/solar_tracker
	name = "追踪器电子元件"
	icon_state = "door_electronics"


/obj/item/circuitboard/airlock
	name = "气闸电子元件"
	desc = "建造气闸所需."
	icon_state = "door_electronics"
	req_access = list(ACCESS_CIVILIAN_ENGINEERING)
	var/list/conf_access = null
	var/one_access = 0 //if set to 1, door would receive req_one_access instead of req_access
	var/last_configurator = null
	var/locked = 1


/obj/item/circuitboard/airlock/interact(mob/user)
	. = ..()
	if(.)
		return

	var/t1
	if (last_configurator)
		t1 += "Operator: [last_configurator]<br>"

	if (locked)
		t1 += "<a href='byond://?src=[text_ref(src)];login=1'>Swipe ID</a><hr>"
	else
		t1 += "<a href='byond://?src=[text_ref(src)];logout=1'>Block</a><hr>"

		t1 += "Access requirement is set to "
		t1 += one_access ? "<a style='color: green' href='byond://?src=[text_ref(src)];one_access=1'>ONE</a><hr>" : "<a style='color: red' href='byond://?src=[text_ref(src)];one_access=1'>ALL</a><hr>"

		t1 += conf_access == null ? "<font color=red>All</font><br>" : "<a href='byond://?src=[text_ref(src)];access=all'>All</a><br>"

		t1 += "<br>"

		var/list/accesses = ALL_ACCESS
		for (var/acc in accesses)
			var/aname = get_access_desc(acc)

			if (!conf_access || !length(conf_access) || !(acc in conf_access))
				t1 += "<a href='byond://?src=[text_ref(src)];access=[acc]'>[aname]</a><br>"
			else if(one_access)
				t1 += "<a style='color: green' href='byond://?src=[text_ref(src)];access=[acc]'>[aname]</a><br>"
			else
				t1 += "<a style='color: red' href='byond://?src=[text_ref(src)];access=[acc]'>[aname]</a><br>"

	var/datum/browser/popup = new(user, "airlock_electronics", "<div align='center'>Access Control</div>")
	popup.set_content(t1)
	popup.open()


/obj/item/circuitboard/airlock/Topic(href, href_list)
	. = ..()
	if(.)
		return

	if(href_list["login"])
		if(istype(usr, /mob/living/silicon))
			locked = 0
			last_configurator = usr.name
		else
			var/obj/item/I = usr.get_active_held_item()
			if(I && check_access(I))
				locked = FALSE
				last_configurator = I:registered_name

	if(locked)
		return

	if(href_list["logout"])
		locked = TRUE

	if(href_list["one_access"])
		one_access = !one_access

	if(href_list["access"])
		toggle_access(href_list["access"])

	updateUsrDialog()


/obj/item/circuitboard/airlock/proc/toggle_access(acc)
	if (acc == "all")
		conf_access = null
	else
		var/req = text2num(acc)

		if (conf_access == null)
			conf_access = list()

		if (!(req in conf_access))
			conf_access += req
		else
			conf_access -= req
			if (!length(conf_access))
				conf_access = null


/obj/item/circuitboard/airlock/secure
	name = "安全气闸电子元件"
	desc = "设计上比标准电子元件更难以被黑客入侵."
