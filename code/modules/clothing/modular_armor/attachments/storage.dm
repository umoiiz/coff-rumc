/*!
	Modular armor storage storage attachments
	These are storage attachments that equip into storage slots on modular armor
*/

/** Storage modules */
/obj/item/armor_module/storage
	icon = 'icons/mob/modular/modular_armor_modules.dmi'
	icon_state = "mod_is_bag"
	slot = ATTACHMENT_SLOT_STORAGE
	w_class = WEIGHT_CLASS_BULKY
	variants_by_parent_type = list(/obj/item/clothing/suit/modular/style = "")
	///Determines what subtype of storage is on our item, see datums\storage\subtypes
	var/datum/storage/storage_type = /datum/storage
	///If TRUE it will add extra overlays for the items within.
	var/show_storage = FALSE
	///Icon for the extra storage overlays.
	var/show_storage_icon = 'icons/mob/modular/modular_helmet_storage.dmi'

/obj/item/armor_module/storage/Initialize(mapload)
	. = ..()
	create_storage(storage_type)
	PopulateContents()

/obj/item/armor_module/storage/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	equip_delay_self = parent.equip_delay_self
	strip_delay = parent.strip_delay

	storage_datum.register_storage_signals(attaching_to)

/obj/item/armor_module/storage/on_detach(obj/item/detaching_from, mob/user)
	equip_delay_self = initial(equip_delay_self)
	strip_delay = initial(strip_delay)
	storage_datum.unregister_storage_signals(detaching_from)
	return ..()

///Use this to fill your storage with items. USE THIS INSTEAD OF NEW/INIT
/obj/item/armor_module/storage/proc/PopulateContents()
	return

/obj/item/storage/internal/modular
	storage_type = /datum/storage/internal/modular

/* Pockets */
/obj/item/armor_module/storage/pocket
	icon_state = ""
	worn_icon_state = ""
	attach_features_flags = ATTACH_APPLY_ON_MOB
	storage_type = /datum/storage/internal/pocket

/obj/item/armor_module/storage/pocket/medical
	storage_type = /datum/storage/internal/pocket/medical

/** General storage */
/obj/item/armor_module/storage/general
	name = "通用存储模块"
	desc = "设计用于安装在TGMC的模块化护甲系统上。当然不如其他存储模块那么专业化,但绝对能装下一些较大的东西,比如双筒望远镜、地图和运动探测器。"
	icon_state = "mod_general_bag"
	storage_type = /datum/storage/internal/general

/obj/item/armor_module/storage/general/som
	name = "通用存储模块"
	desc = "设计用于安装在SOM战斗护甲上。当然不如其他存储模块那么专业化,但绝对能装下一些较大的东西,比如手枪或弹匣。"
	icon = 'icons/mob/modular/som_armor_modules.dmi'
	icon_state = "mod_general_bag_som"
	worn_icon_state = "mod_general_bag_som_a"

/obj/item/armor_module/storage/ammo_mag
	name = "弹匣存储模块"
	desc = "设计用于安装在TGMC的模块化护甲系统上。能装下一些弹匣。别指望能装下特种弹药或轻机枪弹鼓,但也能派上不少用场。看起来可能会让你稍微慢一点。"
	icon_state = "mod_mag_bag"
	storage_type = /datum/storage/internal/ammo_mag
	slowdown = 0.1

/obj/item/armor_module/storage/ammo_mag/freelancer/PopulateContents()
	new /obj/item/ammo_magazine/rifle/m16(src)
	new /obj/item/ammo_magazine/rifle/m16(src)
	new /obj/item/ammo_magazine/rifle/m16(src)
	new /obj/item/ammo_magazine/rifle/m16(src)

/obj/item/armor_module/storage/ammo_mag/freelancer_two/PopulateContents()
	new /obj/item/ammo_magazine/rifle/ar11(src)
	new /obj/item/ammo_magazine/rifle/ar11(src)
	new /obj/item/ammo_magazine/rifle/ar11(src)
	new /obj/item/ammo_magazine/rifle/ar11(src)

/obj/item/armor_module/storage/ammo_mag/freelancer_three/PopulateContents()
	new /obj/item/ammo_magazine/rifle/tx54(src)
	new /obj/item/ammo_magazine/rifle/tx54(src)
	new /obj/item/ammo_magazine/rifle/tx54/incendiary(src)
	new /obj/item/ammo_magazine/rifle/tx54/incendiary(src)

/obj/item/armor_module/storage/engineering
	name = "工程存储模块"
	desc = "设计用于安装在TGMC的模块化护甲系统上。容量大约相当于一个工具袋,有时还能装下小卷的铁丝网或一把挖壕工具。"
	icon_state = "mod_engineer_bag"
	storage_type = /datum/storage/internal/engineering

/obj/item/armor_module/storage/engineering/som
	name = "工程存储模块"
	desc = "设计用于安装在SOM战斗护甲上。容量大约相当于一个工具袋,有时还能装下小卷的铁丝网或一把挖壕工具。"
	icon = 'icons/mob/modular/som_armor_modules.dmi'
	icon_state = "mod_engineer_bag_som"
	worn_icon_state = "mod_engineer_bag_som_a"

/obj/item/armor_module/storage/medical
	name = "医疗存储模块"
	desc = "设计用于安装在TGMC的模块化护甲系统上。能装下相当多种类的医疗用品和器械,但容量不如医疗包。"
	icon_state = "mod_medic_bag"
	storage_type = /datum/storage/internal/medical

/obj/item/armor_module/storage/medical/freelancer/PopulateContents()
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/storage/pill_bottle/meralyne(src)
	new /obj/item/storage/pill_bottle/dermaline(src)
	new /obj/item/storage/pill_bottle/tramadol(src)

/obj/item/armor_module/storage/medical/som
	name = "医疗存储模块"
	desc = "设计用于安装在SOM战斗护甲上。能装下相当多种类的医疗用品和器械,但容量不如医疗包。"
	icon = 'icons/mob/modular/som_armor_modules.dmi'
	icon_state = "mod_medic_bag_som"
	worn_icon_state = "mod_medic_bag_som_a"

/obj/item/armor_module/storage/injector
	name = "注射器存储模块"
	desc = "设计用于安装在TGMC的模块化护甲系统上。能装下相当多种类的注射器。"
	icon_state = "mod_injector_bag"
	storage_type = /datum/storage/internal/injector

/obj/item/armor_module/storage/integrated
	name = "IS型存储模块"
	desc = "设计用于安装在TGMC的模块化护甲系统上。略微影响移动速度,但容量大约相当于一个挎包。"
	icon_state = "mod_is_bag"
	storage_type = /datum/storage/internal/integrated
	slowdown = 0.2

/obj/item/armor_module/storage/grenade
	name = "手榴弹存储模块"
	desc = "设计用于安装在TGMC的模块化护甲系统上。能装下数量可观的手榴弹。"
	icon_state = "mod_grenade_harness"
	storage_type = /datum/storage/internal/grenade

/obj/item/armor_module/storage/helmet
	name = "Jaeger型头盔存储"
	desc = "一套小型的束带和绑带,方便存放小物品。"
	icon_state = ""
	storage_type = /datum/storage/internal/marinehelmet
	show_storage = TRUE
	attach_features_flags = NONE
