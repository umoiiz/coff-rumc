/obj/item/folder
	name = "文件夹"
	desc = "一个文件夹."
	icon = 'icons/obj/items/paper.dmi'
	icon_state = "folder"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/folder/blue
	desc = "一个蓝色文件夹."
	icon_state = "folder_blue"

/obj/item/folder/grape
	desc = "一个紫色文件夹."
	icon_state = "folder_grape"

/obj/item/folder/red
	desc = "一个红色文件夹."
	icon_state = "folder_red"

/obj/item/folder/yellow
	desc = "一个黄色文件夹."
	icon_state = "folder_yellow"

/obj/item/folder/white
	desc = "一个白色文件夹."
	icon_state = "folder_white"

/obj/item/folder/black
	desc = "一个黑色文件夹."
	icon_state = "folder_black"

/obj/item/folder/update_overlays()
	. = ..()
	if(length(contents))
		. += "folder_paper"

/obj/item/folder/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(istype(I, /obj/item/paper) || istype(I, /obj/item/photo) || istype(I, /obj/item/paper_bundle))
		if(!user.transferItemToLoc(I, src))
			return

		to_chat(user, span_notice("你将[I]放入\the [src]."))
		update_icon()

	else if(istype(I, /obj/item/tool/pen))
		var/n_name = stripped_input(user, "What would you like to label the folder?", "Folder Labelling")
		if(loc != user || user.stat != CONSCIOUS)
			return

		name = "folder[(n_name ? "- '[n_name]'" : "")]"

/obj/item/folder/interact(mob/user)
	. = ..()
	if(.)
		return
	var/dat

	for(var/obj/item/paper/P in src)
		dat += "<A href='byond://?src=[text_ref(src)];remove=[text_ref(P)]'>Remove</A> - <A href='byond://?src=[text_ref(src)];read=[text_ref(P)]'>[P.name]</A><BR>"
	for(var/obj/item/photo/Ph in src)
		dat += "<A href='byond://?src=[text_ref(src)];remove=[text_ref(Ph)]'>Remove</A> - <A href='byond://?src=[text_ref(src)];look=[text_ref(Ph)]'>[Ph.name]</A><BR>"
	for(var/obj/item/paper_bundle/Pb in src)
		dat += "<A href='byond://?src=[text_ref(src)];remove=[text_ref(Pb)]'>Remove</A> - <A href='byond://?src=[text_ref(src)];browse=[text_ref(Pb)]'>[Pb.name]</A><BR>"
	var/datum/browser/popup = new(user, "folder", "<div align='center'>[src]</div>")
	popup.set_content(dat)
	popup.open()

/obj/item/folder/Topic(href, href_list)
	. = ..()
	if(.)
		return

	if(src.loc == usr)

		if(href_list["remove"])
			var/obj/item/P = locate(href_list["remove"])
			if(P && (P.loc == src) && istype(P))
				P.loc = usr.loc
				usr.put_in_hands(P)

		else if(href_list["read"])
			var/obj/item/paper/P = locate(href_list["read"])
			if(P && (P.loc == src) && istype(P))
				if(!(ishuman(usr) || isobserver(usr) || issilicon(usr)))
					usr << browse(HTML_SKELETON_TITLE(P.name, stars(P.info)+P.stamps), "window=[P.name]")
					onclose(usr, "[P.name]")
				else
					usr << browse(HTML_SKELETON_TITLE(P.name, P.info+P.stamps), "window=[P.name]")
					onclose(usr, "[P.name]")
		else if(href_list["look"])
			var/obj/item/photo/P = locate(href_list["look"])
			if(P && (P.loc == src) && istype(P))
				P.show(usr)
		else if(href_list["browse"])
			var/obj/item/paper_bundle/P = locate(href_list["browse"])
			if(P && (P.loc == src) && istype(P))
				P.attack_self(usr)
				onclose(usr, "[P.name]")

		//Update everything
		updateUsrDialog()
		update_icon()
