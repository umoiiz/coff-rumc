/obj/structure/closet/crate/mortar_ammo
	name = "\improper T-50S迫击炮弹药箱"
	desc = "一个装有实弹迫击炮弹的箱子, 内含多种弹头. 请勿掉落. 远离火源."
	icon_state = "closed_mortar_crate"
	icon_opened = "open_mortar_crate"
	icon_closed = "closed_mortar_crate"

/obj/structure/closet/crate/mortar_ammo/full/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/he(src)
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/incendiary(src)
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/flare(src)

	new /obj/item/mortal_shell/smoke(src)
	new /obj/item/mortal_shell/smoke(src)
	new /obj/item/mortal_shell/plasmaloss(src)
	new /obj/item/mortal_shell/plasmaloss(src)

/obj/structure/closet/crate/mortar_ammo/mortar_kit
	name = "\improper TA-50S迫击炮套件"
	desc = "一个箱子, 内含一套基础迫击炮和一些炮弹, 供工程师起步使用."

/obj/structure/closet/crate/mortar_ammo/mortar_kit/PopulateContents()
	new /obj/item/storage/holster/backholster/mortar/full(src)
	for(var/i in 1 to 8)
		new /obj/item/mortal_shell/he(src)
	for(var/i in 1 to 8)
		new /obj/item/mortal_shell/incendiary(src)
	new /obj/item/mortal_shell/plasmaloss(src)
	new /obj/item/mortal_shell/plasmaloss(src)
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/smoke(src)
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/flare(src)
	new /obj/item/encryptionkey/engi(src)
	new /obj/item/encryptionkey/engi(src)
	new /obj/item/binoculars/tactical/range(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/hud_tablet/artillery(src)

/obj/structure/closet/crate/mortar_ammo/mlrs_kit
	name = "\improper TA-40L多管火箭炮套件"
	desc = "一个箱子, 内含一套基础的、不知怎么压缩过的套件, 包括一整套多管火箭炮系统和一些火箭弹, 供炮兵起步使用."

/obj/structure/closet/crate/mortar_ammo/mlrs_kit/PopulateContents()
	new /obj/item/mortar_kit/mlrs(src)
	new /obj/item/storage/box/mlrs_rockets(src)
	new /obj/item/storage/box/mlrs_rockets_gas(src)
	new /obj/item/encryptionkey/engi(src)
	new /obj/item/encryptionkey/engi(src)
	new /obj/item/binoculars/tactical/range(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/hud_tablet/artillery(src)

/obj/item/storage/box/mlrs_rockets
	name = "\improper TA-40L火箭弹箱"
	desc = "一个大箱子, 内含为TA-40L多管火箭炮压缩包装的火箭弹. 将此精灵图拖到你身上以打开它!\nNOTE: 你无法将物品放回此箱子内."

/obj/item/storage/box/mlrs_rockets/Initialize(mapload)
	. = ..()
	storage_datum.storage_slots = 16

/obj/item/storage/box/mlrs_rockets/PopulateContents()
	for(var/i in 1 to 16)
		new /obj/item/mortal_shell/rocket/mlrs(src)

/obj/item/storage/box/mlrs_rockets_gas
	name = "\improper TA-40L X-50火箭弹箱"
	desc = "一个大箱子, 内含为TA-40L多管火箭炮压缩包装的火箭弹. 将此精灵图拖到你身上以打开它!\nNOTE: 你无法将物品放回此箱子内."

/obj/item/storage/box/mlrs_rockets_gas/PopulateContents()
	for(var/i in 1 to 16)
		new /obj/item/mortal_shell/rocket/mlrs/gas(src)

/obj/item/storage/box/mlrs_rockets_tangle
	name = "\improper TA-40L T-33火箭弹箱"
	desc = "一个大箱子, 内含为TA-40L多管火箭炮压缩包装的火箭弹. 将此精灵图拖到你身上以打开它!\nNOTE: 你无法将物品放回此箱子内."

/obj/item/storage/box/mlrs_rockets_tangle/PopulateContents()
	for(var/i in 1 to 16)
		new /obj/item/mortal_shell/rocket/mlrs/tangle(src)

/obj/structure/closet/crate/mortar_ammo/howitzer_kit
	name = "\improper TA-100Y榴弹炮套件"
	desc = "一个箱子, 内含一套基础的、不知怎么压缩过的套件, 包括一整门榴弹炮和一些炮弹, 供炮兵起步使用."

/obj/structure/closet/crate/mortar_ammo/howitzer_kit/PopulateContents()
	new /obj/item/mortar_kit/howitzer(src)
	for(var/i in 1 to 8)
		new /obj/item/mortal_shell/howitzer/incendiary(src)
	for(var/i in 1 to 10)
		new /obj/item/mortal_shell/howitzer/he(src)
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/howitzer/white_phos(src)
	for(var/i in 1 to 4)
		new	/obj/item/mortal_shell/howitzer/plasmaloss(src)
	for(var/i in 1 to 4)
		new /obj/item/mortal_shell/flare(src)
	new /obj/item/encryptionkey/engi(src)
	new /obj/item/encryptionkey/engi(src)
	new /obj/item/binoculars/tactical/range(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/encryptionkey/cas(src)
	new /obj/item/hud_tablet/artillery(src)
