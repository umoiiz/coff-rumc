/obj/item/clothing/suit/storage/labcoat
	name = "实验服"
	desc = "一件能防护轻微化学溅射的服装."
	icon_state = "labcoat"
	blood_overlay_type = "coat"
	armor_protection_flags = CHEST|ARMS
	permeability_coefficient = 0.6
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 50, FIRE = 0, ACID = 25)
	allowed = list(
		/obj/item/stack/medical,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/healthanalyzer,
		/obj/item/flashlight,
		/obj/item/radio,
		/obj/item/tank/emergency_oxygen,
	)
	attachments_allowed = list(
		/obj/item/armor_module/storage/pocket/medical,
		/obj/item/armor_module/armor/badge,
	)
	starting_attachments = list(/obj/item/armor_module/storage/pocket/medical)
	///If the coat is buttoned or not
	var/open = FALSE

/obj/item/clothing/suit/storage/labcoat/Initialize(mapload)
	. = ..()
	toggle_open()

/obj/item/clothing/suit/storage/labcoat/verb/toggle()
	set name = "Toggle Labcoat Buttons"
	set category = "IC.Clothing"
	set src in usr

	if(!isliving(usr))
		return
	if(usr.stat)
		return
	if(usr.restrained())
		return

	toggle_open()

	if(open)
		to_chat(usr, "你解开了实验服.")
	else
		to_chat(usr, "你扣上了实验服.")

///Actually toggles the coat open or closed
/obj/item/clothing/suit/storage/labcoat/proc/toggle_open()
	open = !open

	if(open)
		icon_state = "[initial(icon_state)]_open"
	else
		icon_state = initial(icon_state)

	update_clothing_icon()

/obj/item/clothing/suit/storage/labcoat/cmo
	name = "首席医疗官实验服"
	desc = "比标准型号更蓝."
	icon_state = "labcoat_cmo"
/obj/item/clothing/suit/storage/labcoat/mad
	name = "疯狂科学家的实验服"
	desc = "它让你看起来有能力敲晕某人并把他们射入太空."
	icon_state = "labgreen"

/obj/item/clothing/suit/storage/labcoat/paramedic
	name = "护理人员实验服"
	desc = "一件装有小型医疗物品的服装,用于应对和处理紧急情况."
	icon_state = "labcoat_paramedic"

/obj/item/clothing/suit/storage/labcoat/chemist
	name = "化学家实验服"
	desc = "一件能防护轻微化学溅射的服装.肩部有橙色条纹."
	icon_state = "labcoat_chem"

/obj/item/clothing/suit/storage/labcoat/virologist
	name = "病毒学家实验服"
	desc = "一件能防护轻微化学溅射的服装.比标准型号提供稍多的生物危害防护.肩部有绿色条纹."
	icon_state = "labcoat_viro"

/obj/item/clothing/suit/storage/labcoat/genetics
	name = "遗传学家实验服"
	desc = "一件能防护轻微化学溅射的服装.肩部有蓝色条纹."
	icon_state = "labcoat_gen"

/obj/item/clothing/suit/storage/labcoat/science
	name = "科学家实验服"
	desc = "一件能防护轻微化学溅射的服装.肩部有紫色条纹."
	icon_state = "labcoat_sci"

/obj/item/clothing/suit/storage/labcoat/researcher
	name = "研究员的实验服"
	desc = "一件高质量实验服,似乎被学者和研究员们穿着.它有一种独特的粗糙感,并激励你走向冒险."
	icon_state = "labcoat_researcher"
	slowdown = SLOWDOWN_ARMOR_LIGHT
	soft_armor = MARINE_ARMOR_MEDIUM
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/instrument,
		/obj/item/storage/belt/sparepouch,
		/obj/item/storage/holster/blade,
		/obj/item/weapon/sword/harvester,
		/obj/item/storage/holster/belt,
		/obj/item/storage/belt/knifepouch,
		/obj/item/weapon/twohanded,
		/obj/item/tool/pickaxe/plasmacutter,
		/obj/item/tool/shovel/etool,
		/obj/item/weapon/energy/sword,
	)
