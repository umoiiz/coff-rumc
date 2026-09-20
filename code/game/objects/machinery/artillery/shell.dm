/obj/item/mortal_shell
	name = "\improper 80毫米迫击炮弹"
	desc = "一枚未标记的80毫米迫击炮弹,可能只是个弹壳."
	icon = 'icons/obj/items/ammo/stationary.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/ammo_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/ammo_right.dmi',
	)
	icon_state = "mortar_cas"
	w_class = WEIGHT_CLASS_SMALL
	atom_flags = CONDUCT
	///Ammo datum typepath that the shell uses
	var/ammo_type

/obj/item/mortal_shell/he
	name = "\improper 80毫米高爆迫击炮弹"
	desc = "一枚80毫米迫击炮弹,装填有高爆炸药."
	icon_state = "mortar_he"
	ammo_type = /datum/ammo/mortar

/obj/item/mortal_shell/incendiary
	name = "\improper 80毫米燃烧迫击炮弹"
	desc = "一枚80毫米迫击炮弹,装填有凝固汽油弹."
	icon_state = "mortar_inc"
	ammo_type = /datum/ammo/mortar/incend

/obj/item/mortal_shell/smoke
	name = "\improper 80毫米烟雾迫击炮弹"
	desc = "一枚80毫米迫击炮弹,装填有烟雾散布剂.可以相对安全地向陆战队员发射.比你典型的80毫米炮弹要细得多."
	icon_state = "mortar_smk"
	ammo_type = /datum/ammo/mortar/smoke

/obj/item/mortal_shell/plasmaloss
	name = "\improper 80毫米缠绕迫击炮弹"
	desc = "一枚80毫米迫击炮弹,装填有消耗等离子体的缠绕足气体.可以相对安全地向陆战队员发射."
	icon_state = "mortar_fsh"
	ammo_type = /datum/ammo/mortar/smoke/plasmaloss

/obj/item/mortal_shell/flare
	name = "\improper 80毫米照明迫击炮弹"
	desc = "一枚80毫米迫击炮弹,装填有一枚照明弹,比你典型的80毫米炮弹要细得多.可以从更大的火炮中发射."
	icon_state = "mortar_flr"
	ammo_type = /datum/ammo/mortar/flare

/obj/item/mortal_shell/rocket
	ammo_type = /datum/ammo/mortar/rocket

/obj/item/mortal_shell/rocket/incend
	ammo_type = /datum/ammo/mortar/rocket/incend

/obj/item/mortal_shell/rocket/minelaying
	ammo_type = /datum/ammo/mortar/rocket/minelayer

/obj/item/mortal_shell/knee
	name = "\improper 50毫米高爆迫击炮弹"
	desc = "一枚50毫米迫击炮弹,装填有高爆炸药."
	icon_state = "knee_mortar_he"
	w_class = WEIGHT_CLASS_TINY
	ammo_type = /datum/ammo/mortar/knee

/obj/item/mortal_shell/rocket/mlrs
	name = "\improper 60毫米火箭弹"
	desc = "一枚装有炸药的60毫米火箭弹,用于高散布的饱和射击."
	icon_state = "mlrs_rocket"
	ammo_type = /datum/ammo/mortar/rocket/mlrs

/obj/item/mortal_shell/rocket/mlrs/gas
	name = "\improper 60毫米'X-50'火箭弹"
	desc = "一枚装有致命X-50气体的60毫米火箭弹,会抽干任何不幸身处其中者的能量和生命."
	icon_state = "mlrs_rocket_gas"
	ammo_type = /datum/ammo/mortar/rocket/smoke/mlrs

/obj/item/mortal_shell/rocket/mlrs/tangle
	name = "\improper 60毫米'T-33'火箭弹"
	desc = "一枚装有缠绕足气体的60毫米火箭弹,会抽干异形的等离子体."
	icon_state = "mlrs_rocket_gas"
	ammo_type = /datum/ammo/mortar/rocket/smoke/mlrs/tangle

/obj/item/mortal_shell/howitzer
	name = "\improper 150毫米炮弹"
	desc = "一枚未标记的150毫米炮弹,可能只是个弹壳."
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "howitzer"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/mortal_shell/howitzer/he
	name = "\improper 150毫米高爆炮弹"
	desc = "一枚150毫米炮弹,装填有高爆炸药,被这玩意击中的任何东西都会经历非常、非常糟糕的一天."
	ammo_type = /datum/ammo/mortar/howi

/obj/item/mortal_shell/howitzer/plasmaloss
	name = "\improper 150毫米'缠绕足'炮弹"
	desc = "一枚150毫米炮弹,装填有有毒的致醉气体,被这玩意击中的任何东西其能力都会被缓慢削弱.并伴随一次小型中等爆炸."
	icon_state = "howitzer_purp"
	ammo_type = /datum/ammo/mortar/smoke/howi/plasmaloss

/obj/item/mortal_shell/howitzer/incendiary
	name = "\improper 150毫米燃烧炮弹"
	desc = "一枚150毫米炮弹,装填有炸药以击穿轻型结构,然后烧尽另一侧的任何东西.会毁掉他们的一天和皮肤."
	icon_state = "howitzer_incend"
	ammo_type = /datum/ammo/mortar/howi/incend

/obj/item/mortal_shell/howitzer/white_phos
	name = "\improper 150毫米白磷'标记'炮弹"
	desc = "一枚150毫米炮弹,装填有'标记'气体,会点燃它击中的任何东西,被这玩意击中的任何东西其一天、皮肤和未来都会被毁掉,还会招来战争罪法庭的审判."
	icon_state = "howitzer_wp"
	ammo_type = /datum/ammo/mortar/smoke/howi/wp
