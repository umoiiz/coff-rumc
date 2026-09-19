/obj/item/clothing/under/rank/warden
	name = "安保西装"
	desc = "一套正式的安保西装,配有Nanotrasen皮带扣,供军官穿着."
	icon_state = "wardenred"
	worn_icon_state = "r_suit"
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/warden/white
	name = "白色安保西装"
	desc = "过去岁月的正式遗物,那时Nanotrasen还没决定把西装染成红色比洗掉血迹更便宜."
	icon_state = "wardenwhite"
	worn_icon_state = "wardenwhite"

/obj/item/clothing/under/rank/security
	name = "安保人员连体服"
	desc = "它由比标准连体服稍坚固的材料制成,以提供强力防护."
	icon_state = "securityred"
	worn_icon_state = "r_suit"
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/dispatch
	name = "调度员制服"
	desc = "一件缝有安保臂章的衬衫和卡其裤."
	icon_state = "dispatch"
	armor_protection_flags = CHEST|GROIN|LEGS
	siemens_coefficient = 0.9
	adjustment_variants = list()

/obj/item/clothing/under/rank/security2
	name = "安保军官制服"
	desc = "它由稍微坚固的材料制成,以提供强力的防护."
	icon_state = "redshirt2"
	worn_icon_state = "r_suit"
	siemens_coefficient = 0.9
	adjustment_variants = list()

/obj/item/clothing/under/rank/security/corp
	icon_state = "sec_corporate"
	adjustment_variants = list()

/*
* Detective
*/
/obj/item/clothing/under/rank/det
	name = "破旧西装"
	desc = "穿这个的人可不是好惹的."
	icon_state = "detective"
	worn_icon_state = "det"
	siemens_coefficient = 0.9
	adjustment_variants = list()

/obj/item/clothing/under/rank/det/grey
	name = "黑色侦探西装"
	desc = "一件硬汉私家侦探的灰色西装,配有领带夹."
	icon_state = "greydet"
	worn_icon_state = "greydet"
	adjustment_variants = list()

/*
* Head of Security
*/
/obj/item/clothing/under/rank/head_of_security
	desc = "这是一件连体服,由少数有奉献精神并达到\"安保主管\"职位的人穿着.它带有额外的护甲来保护穿戴者."
	name = "安保主管连体服"
	icon_state = "hosred"
	worn_icon_state = "r_suit"
	siemens_coefficient = 0.8

/obj/item/clothing/under/rank/head_of_security/alt
	name = "安保主管高领衫"
	desc = "安保主管常规连体服的时尚替代品,配有战术裤."
	icon_state = "hosalt"
	worn_icon_state = "hosalt"

/obj/item/clothing/under/rank/head_of_security/corp
	icon_state = "hos_corporate"
	adjustment_variants = list()

//Jensen cosplay gear
/obj/item/clothing/under/rank/head_of_security/jensen
	desc = "你从没要求过这么时尚的东西."
	name = "安保主管连体服"
	icon_state = "jensen"
	worn_icon_state = "jensen"
	siemens_coefficient = 0.6
	adjustment_variants = list()
