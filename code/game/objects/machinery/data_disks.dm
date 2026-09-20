//The return of data disks?? Just for transferring between genetics machine/cloning machine.
//TO-DO: Make the genetics machine accept them.
/obj/item/disk/data
	name = "克隆数据磁盘"
	icon_state = "datadisk0" //Gosh I hope syndies don't mistake them for the nuke disk.
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/id_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/id_right.dmi',
	)
	worn_icon_state = "card-id"
	w_class = WEIGHT_CLASS_TINY
	var/read_only = 0 //Well,it's still a floppy disk

//Disk stuff.
/obj/item/disk/data/Initialize(mapload)
	. = ..()
	icon_state = "datadisk[rand(0, 2)]"

/obj/item/disk/data/attack_self(mob/user as mob)
	src.read_only = !src.read_only
	to_chat(user, "你把写保护标签拨到[src.read_only ? "protected" : "unprotected"].")

/obj/item/disk/data/examine(mob/user)
	. = ..()
	. += "The write-protect tab is set to [read_only ? "protected" : "unprotected"]."


//Health Tracker Implant

/obj/item/implant/health
	name = "健康植入体"
	var/healthstring = ""

/obj/item/implant/health/proc/sensehealth()
	if (!src.implanted)
		return "ERROR"
	else
		if(isliving(src.implanted))
			var/mob/living/L = src.implanted
			src.healthstring = "[round(L.get_oxy_loss())] - [round(L.get_fire_loss())] - [round(L.get_tox_loss())] - [round(L.get_brute_loss())]"
		if (!src.healthstring)
			src.healthstring = "ERROR"
		return src.healthstring

/*
*	Diskette Box
*/

/obj/item/storage/box/disks
	name = "软盘盒"
	icon_state = "disk_kit"
	spawn_type = /obj/item/disk/data
	spawn_number = 7
