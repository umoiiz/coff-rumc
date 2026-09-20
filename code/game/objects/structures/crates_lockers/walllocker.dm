/obj/structure/closet/walllocker
	name = "壁挂储物柜"
	desc = "一个壁挂式储物柜."
	icon = 'icons/obj/wallframes.dmi'
	icon_state = "walllocker"
	pixel_x = -16
	pixel_y = -16
	density = FALSE
	anchored = TRUE
	icon_closed = "walllocker"
	icon_opened = "walllockeropen"
	mob_storage_capacity = 0
	wall_mounted = TRUE
	storage_capacity = 20
	overlay_welded = "walllockerwelded"
	layer = ABOVE_OBJ_LAYER

/obj/structure/closet/walllocker/Initialize(mapload, ndir)
	. = ..()
	if(ndir)
		dir = ndir
	switch(dir)
		if(NORTH)
			pixel_y = -48
		if(SOUTH)
			pixel_y = 16
		if(EAST)
			pixel_x = -48
		if(WEST)
			pixel_x = 16

/obj/structure/closet/walllocker/emerglocker //wall mounted emergency closet
	name = "应急储物柜"
	icon_state = "emerg"
	icon_closed = "emerg"
	icon_opened = "emergopen"
	desc = "一个装有应急物资的壁挂式储物柜."
	overlay_welded = "emergwelded"

/obj/structure/closet/walllocker/emerglocker/full // spawners

/obj/structure/closet/walllocker/emerglocker/full/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/tank/emergency_oxygen/double(src)
		new /obj/item/clothing/mask/gas(src)

/obj/structure/closet/walllocker/hydrant //wall mounted fire closet
	name = "消防安全储物柜"
	desc = "一个用于存放消防物资的壁挂式储物柜."
	icon_state = "hydrant"
	icon_closed = "hydrant"
	icon_opened = "hydrantopen"
	overlay_welded = "hydrant-medical_welded"

/obj/structure/closet/walllocker/hydrant/extinguisher

/obj/structure/closet/walllocker/hydrant/extinguisher/PopulateContents()
	new /obj/item/tool/extinguisher(src)

/obj/structure/closet/walllocker/hydrant/full // spawners

/obj/structure/closet/walllocker/hydrant/full/PopulateContents()
	new /obj/item/clothing/suit/fire(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/flashlight(src)
	new /obj/item/tank/oxygen/red(src)
	new /obj/item/tool/extinguisher(src)
	new /obj/item/clothing/head/hardhat/red(src)

/obj/structure/closet/walllocker/medical_wall //wall mounted medical closet
	name = "急救储物柜"
	desc = "一个用于存放急救物资的壁挂式储物柜."
	icon_state = "medical_wall"
	icon_closed = "medical_wall"
	icon_opened = "medical_wallopen"
	overlay_welded = "hydrant-medical_welded"

/obj/structure/closet/walllocker/medical_wall/full // spawners

/obj/structure/closet/walllocker/medical_wall/full/PopulateContents()
	new /obj/item/storage/firstaid/regular(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/dylovene(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/inaprovaline(src)

///////// SECURE WALL LOCKERS /////////

/obj/structure/closet/secure_closet/walllocker
	name = "安全壁挂储物柜"
	desc = "这是一个固定的刷卡储物柜."
	icon = 'icons/obj/wallframes.dmi'
	pixel_x = -16
	pixel_y = -16
	icon_state = "sec_locker1"
	icon_closed = "secure"
	icon_locked = "sec_locker1"
	icon_opened = "sec_locker_opened"
	icon_broken = "sec_locker_broken"
	icon_off = "sec_locker_off"
	overlay_welded = "emergwelded"
	density = FALSE
	anchored = TRUE
	mob_storage_capacity = 0
	wall_mounted = TRUE
	storage_capacity = 20

/obj/structure/closet/secure_closet/walllocker/Initialize(mapload, ndir)
	. = ..()
	if(ndir)
		dir = ndir
	switch(dir)
		if(NORTH)
			pixel_y -= 32
		if(SOUTH)
			pixel_y += 32
		if(EAST)
			pixel_x -= 32
		if(WEST)
			pixel_x += 32

/obj/structure/closet/secure_closet/walllocker/medical
	name = "急救壁橱"
	desc = "这是一个用于存放急救物资的安全壁挂式储物柜."
	icon_state = "medical_wall_sec1"
	icon_closed = "medical_wall_sec"
	icon_locked = "medical_wall_sec1"
	icon_opened = "medical_wall_sec_open"
	icon_broken = "medical_wall_sec_broken"
	icon_off = "medical_wall_sec_off"
	overlay_welded = "hydrant-medical_welded"
	req_access = list(ACCESS_MARINE_MEDBAY)

/obj/structure/closet/secure_closet/walllocker/medical/full // spawners

/obj/structure/closet/secure_closet/walllocker/medical/full/PopulateContents()
	new /obj/item/storage/syringe_case/tox(src)
	new /obj/item/storage/syringe_case/oxy(src)
	new /obj/item/storage/firstaid/adv(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/quickclot(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/dexalinplus(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/oxycodone(src)

///////////PERSONAL SECURE WALL LOCKER///////////////

/obj/structure/closet/secure_closet/personal/walllocker // different path.
	name = "个人壁挂储物柜"
	desc = "这是一个供人员使用的安全壁挂储物柜.第一张刷过的卡获得控制权."
	icon = 'icons/obj/wallframes.dmi'
	icon_state = "sec_locker1"
	pixel_x = -16
	pixel_y = -16
	icon_closed = "secure"
	icon_locked = "sec_locker1"
	icon_opened = "sec_locker_opened"
	icon_broken = "sec_locker_broken"
	icon_off = "sec_locker_off"
	overlay_welded = "emergwelded"
	density = FALSE
	anchored = TRUE
	mob_storage_capacity = 0
	wall_mounted = TRUE
	storage_capacity = 20

/obj/structure/closet/secure_closet/personal/walllocker/Initialize(mapload, ndir)
	. = ..()
	if(ndir)
		dir = ndir
	switch(dir)
		if(NORTH)
			pixel_y -= 32
		if(SOUTH)
			pixel_y += 32
		if(EAST)
			pixel_x -= 32
		if(WEST)
			pixel_x += 32
