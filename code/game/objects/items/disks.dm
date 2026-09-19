/obj/item/disk
	name = "磁盘"
	icon = 'icons/obj/items/disk.dmi'
	icon_state = "datadisk0"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/id_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/id_right.dmi',
	)
	worn_icon_state = "card-id"


/obj/item/disk/nuclear
	name = "核认证磁盘"
	desc = "最好妥善保管."
	icon_state = "nucleardisk"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = RESIST_ALL

/obj/item/disk/nuclear/Initialize(mapload)
	. = ..()
	GLOB.nuke_disk_list += src

/obj/item/disk/nuclear/Destroy()
	GLOB.nuke_disk_list -= src
	return ..()


/obj/item/disk/nuclear/red
	name = "红色核认证磁盘"
	icon_state = "datadisk7"


/obj/item/disk/nuclear/green
	name = "绿色核认证磁盘"
	icon_state = "botanydisk"


/obj/item/disk/nuclear/blue
	name = "蓝色核认证磁盘"
	icon_state = "datadisk0"
