/obj/item/armor_module/storage/uniform
	slot = ATTACHMENT_SLOT_UNIFORM
	w_class = WEIGHT_CLASS_BULKY
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_APPLY_ON_MOB|ATTACH_SEPERATE_MOB_OVERLAY|ATTACH_NO_HANDS
	icon = 'icons/obj/clothing/ties.dmi'
	attach_icon = 'icons/obj/clothing/ties_overlay.dmi'
	mob_overlay_icon = 'icons/mob/ties.dmi'

/obj/item/armor_module/storage/uniform/webbing
	name = "织带"
	desc = "由合成棉腰带和扣环组成的坚固织带，准备好分担你的负担。"
	icon_state = "webbing"
	storage_type = /datum/storage/internal/webbing

/obj/item/armor_module/storage/uniform/webbing/erp
	storage_type = /datum/storage/internal/vest

/obj/item/armor_module/storage/uniform/black_vest
	name = "黑色织带背心"
	desc = "坚固的黑色合成棉背心，有许多口袋，可存放你需要但无法拿在手中的任何东西。"
	icon_state = "vest_black"
	storage_type = /datum/storage/internal/vest

/obj/item/armor_module/storage/uniform/brown_vest
	name = "棕色织带背心"
	desc = "破旧的棕色合成棉背心，有许多口袋来解放你的双手。"
	icon_state = "vest_brown"
	storage_type = /datum/storage/internal/vest

/obj/item/armor_module/storage/uniform/white_vest
	name = "白色织带背心"
	desc = "干净的白色尼龙背心，带有专为医疗用品设计的大口袋"
	icon_state = "vest_white"
	storage_type = /datum/storage/internal/white_vest

/obj/item/armor_module/storage/uniform/surgery_webbing
	name = "手术织带"
	desc = "干净的白色尼龙织带，由许多带子和口袋组成，用于存放手术工具。"
	icon_state = "webbing_white"
	storage_type = /datum/storage/internal/surgery_webbing

/obj/item/armor_module/storage/uniform/surgery_webbing/PopulateContents()
	new /obj/item/tool/surgery/scalpel/manager(src)
	new /obj/item/tool/surgery/hemostat(src)
	new /obj/item/tool/surgery/retractor(src)
	new /obj/item/tool/surgery/cautery(src)
	new /obj/item/tool/surgery/circular_saw(src)
	new /obj/item/tool/surgery/surgical_membrane(src)
	new /obj/item/tool/surgery/bonegel(src)
	new /obj/item/tool/surgery/bonesetter(src)
	new /obj/item/tool/surgery/FixOVein(src)
	new /obj/item/tool/surgery/suture(src)

/obj/item/armor_module/storage/uniform/holster
	name = "肩式枪套"
	desc = "手枪枪套"
	icon_state = "holster"
	storage_type = /datum/storage/internal/holster

/obj/item/armor_module/storage/uniform/holster/Initialize(mapload, ...)
	. = ..()
	AddComponent(/datum/component/tac_reload_storage)

/obj/item/armor_module/storage/uniform/holster/freelancer/PopulateContents()
	new /obj/item/ammo_magazine/pistol/g22(src)
	new /obj/item/ammo_magazine/pistol/g22(src)
	new /obj/item/ammo_magazine/pistol/g22(src)
	new /obj/item/weapon/gun/pistol/g22(src)

/obj/item/armor_module/storage/uniform/holster/vp/PopulateContents()
	new /obj/item/ammo_magazine/pistol/vp70(src)
	new /obj/item/ammo_magazine/pistol/vp70(src)
	new /obj/item/ammo_magazine/pistol/vp70(src)
	new /obj/item/weapon/gun/pistol/vp70(src)

/obj/item/armor_module/storage/uniform/holster/highpower/PopulateContents()
	new /obj/item/ammo_magazine/pistol/highpower(src)
	new /obj/item/ammo_magazine/pistol/highpower(src)
	new /obj/item/ammo_magazine/pistol/highpower(src)
	new /obj/item/weapon/gun/pistol/highpower(src)

/obj/item/armor_module/storage/uniform/holster/deathsquad/PopulateContents()
	new /obj/item/ammo_magazine/revolver/mateba(src)
	new /obj/item/ammo_magazine/revolver/mateba(src)
	new /obj/item/ammo_magazine/revolver/mateba(src)
	new /obj/item/weapon/gun/revolver/mateba(src)

/obj/item/armor_module/storage/uniform/holster/armpit
	name = "肩式枪套"
	desc = "破旧的手枪枪套。非常适合隐蔽携带"
	icon_state = "holster"

/obj/item/armor_module/storage/uniform/holster/waist
	name = "肩式枪套"
	desc = "手枪枪套。由昂贵皮革制成。"
	icon_state = "holster"
	worn_icon_state = "holster_low"
