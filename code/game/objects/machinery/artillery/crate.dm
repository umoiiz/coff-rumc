/obj/structure/closet/crate/mortar_ammo
	name = "\improper T-50S迫击炮弹药箱"
	desc = "一个装有各种弹头迫击炮弹的箱子. 请勿掉落. 远离火源."
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
	desc = "一个装有迫击炮基础套装和若干炮弹的箱子,让工程师可以开始使用."

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
	name = "\improper TA-40L多管火箭系统套装"
	desc = "一个装有基础套装的箱子,不知怎么压缩了一整套多管火箭系统和若干火箭弹,让炮兵可以开始使用."

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
	desc = "一个装有TA-40L多管火箭系统压缩火箭弹的大箱子.将此精灵拖到你身上即可打开!\nNOTE: 你无法将物品放回此箱子内."

/obj/item/storage/box/mlrs_rockets/Initialize(mapload)
	. = ..()
	storage_datum.storage_slots = 16

/obj/item/storage/box/mlrs_rockets/PopulateContents()
	for(var/i in 1 to 16)
		new /obj/item/mortal_shell/rocket/mlrs(src)

/obj/item/storage/box/mlrs_rockets_gas
	name = "\improper TA-40L X-50火箭弹箱"
	desc = "一个装有TA-40L多管火箭系统压缩火箭弹的大箱子.将此精灵拖到你身上即可打开!\nNOTE: 你无法将物品放回此箱子内."

/obj/item/storage/box/mlrs_rockets_gas/PopulateContents()
	for(var/i in 1 to 16)
		new /obj/item/mortal_shell/rocket/mlrs/gas(src)

/obj/item/storage/box/mlrs_rockets_tangle
	name = "\improper TA-40L T-33火箭弹箱"
	desc = "一个装有TA-40L多管火箭系统压缩火箭弹的大箱子.将此精灵拖到你身上即可打开!\nNOTE: 你无法将物品放回此箱子内."

/obj/item/storage/box/mlrs_rockets_tangle/PopulateContents()
	for(var/i in 1 to 16)
		new /obj/item/mortal_shell/rocket/mlrs/tangle(src)

/obj/structure/closet/crate/mortar_ammo/howitzer_kit
	name = "\improper TA-100Y榴弹炮套装"
	desc = "一个装有基础套装的箱子,不知怎么压缩了一整门榴弹炮和若干炮弹,让炮兵可以开始使用."

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
