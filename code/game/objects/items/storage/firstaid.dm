/obj/item/storage/firstaid
	name = "急救包"
	desc = "用于处理严重小伤口的紧急医疗包."
	icon = 'icons/obj/items/storage/firstaid.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medkits_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medkits_right.dmi',
	)
	icon_state = "firstaid"
	base_icon_state = "firstaid"
	w_class = WEIGHT_CLASS_BULKY
	throw_speed = 2
	throw_range = 8
	/// Whether the kit starts empty
	var/empty = FALSE

/obj/item/storage/firstaid/Initialize(mapload, ...)
	. = ..()
	storage_datum.use_sound = 'sound/effects/toolbox.ogg'
	storage_datum.set_holdable(cant_hold_list = list(
		/obj/item/ammo_magazine,
		/obj/item/explosive/grenade,
	))

/obj/item/storage/firstaid/update_icon_state()
	. = ..()
	if(!length(contents))
		icon_state = icon_state += "_empty"
	else
		icon_state = base_icon_state

/obj/item/storage/firstaid/PopulateContents()
	if(empty)
		return
	new /obj/item/healthanalyzer(src)

/obj/item/storage/firstaid/fire
	name = "防火急救包"
	desc = "用于当毒素实验室<i>-自发-</i>烧毁时的紧急医疗包."
	icon_state = "firefirstaid"
	base_icon_state = "firefirstaid"
	worn_icon_state = "firefirstaid"

/obj/item/storage/firstaid/fire/PopulateContents()
	. = ..()
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/storage/pill_bottle/packet/leporazine(src)
	new /obj/item/storage/syringe_case/burn(src)

/obj/item/storage/firstaid/regular
	icon_state = "firstaid"
	base_icon_state = "firstaid"
	worn_icon_state = "firstaid"

/obj/item/storage/firstaid/regular/PopulateContents()
	. = ..()
	new /obj/item/stack/medical/heal_pack/gauze(src)
	new /obj/item/stack/medical/heal_pack/ointment(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/combat(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/tricordrazine(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/tramadol(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/firstaid/toxin
	name = "毒素急救"
	desc = "用于治疗体内毒素含量过高时使用."
	icon_state = "antitoxfirstaid"
	base_icon_state = "antitoxfirstaid"
	worn_icon_state = "antitoxfirstaid"

/obj/item/storage/firstaid/toxin/PopulateContents()
	. = ..()
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/hypervene(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/hypervene(src)
	new /obj/item/storage/syringe_case/tox(src)

/obj/item/storage/firstaid/o2
	name = "缺氧急救"
	desc = "一盒装满氧气好物的盒子."
	icon_state = "o2firstaid"
	base_icon_state = "o2firstaid"
	worn_icon_state = "o2firstaid"

/obj/item/storage/firstaid/o2/PopulateContents()
	. = ..()
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/dexalinplus(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/dexalinplus(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/dexalinplus(src)
	new /obj/item/storage/syringe_case/oxy(src)

/obj/item/storage/firstaid/adv
	name = "高级急救包"
	desc = "包含高级医疗处理用品."
	icon_state = "advfirstaid"
	base_icon_state = "advfirstaid"
	worn_icon_state = "advfirstaid"

/obj/item/storage/firstaid/adv/PopulateContents()
	. = ..()
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/firstaid/rad
	name = "辐射急救包"
	desc = "包含辐射暴露治疗用品"
	icon_state = "purplefirstaid"
	base_icon_state = "purplefirstaid"
	worn_icon_state = "purplefirstaid"

/obj/item/storage/firstaid/rad/PopulateContents()
	. = ..()
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/combat(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/tricordrazine(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/tricordrazine(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/bicaridine(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/bicaridine(src)

/*
* Syringe Case
*/

/obj/item/storage/syringe_case
	name = "注射器盒"
	desc = "用于存放注射器和药瓶的医疗盒."
	icon_state = "syringe_case"
	icon = 'icons/obj/items/storage/firstaid.dmi'
	throw_speed = 2
	throw_range = 8
	w_class = WEIGHT_CLASS_SMALL
	/// The type of bottles we spawn in amount of 2
	var/bottles_to_spawn

/obj/item/storage/syringe_case/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 3
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/syringe,
	))

/obj/item/storage/syringe_case/PopulateContents()
	new /obj/item/reagent_containers/syringe(src)
	if(!isnull(bottles_to_spawn))
		new bottles_to_spawn(src)
		new bottles_to_spawn(src)

/obj/item/storage/syringe_case/empty
	bottles_to_spawn = /obj/item/reagent_containers/glass/bottle/empty

/obj/item/storage/syringe_case/regular
	name = "基础注射器盒"
	desc = "用于存放注射器和药瓶的医疗盒.这个装有基础药物."

/obj/item/storage/syringe_case/regular/PopulateContents()
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/reagent_containers/glass/bottle/inaprovaline(src)
	new /obj/item/reagent_containers/glass/bottle/tricordrazine(src)

/obj/item/storage/syringe_case/burn
	name = "烧伤注射器盒"
	desc = "用于存放注射器和药瓶的医疗盒.这个装有用于治疗烧伤的药物."

/obj/item/storage/syringe_case/burn/PopulateContents()
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/reagent_containers/glass/bottle/kelotane(src)
	new /obj/item/reagent_containers/glass/bottle/oxycodone(src)

/obj/item/storage/syringe_case/tox
	name = "毒素注射器盒"
	desc = "用于存放注射器和药瓶的医疗盒.这个装有用于治疗毒素的药物."

/obj/item/storage/syringe_case/tox/PopulateContents()
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/reagent_containers/glass/bottle/dylovene(src)
	new /obj/item/reagent_containers/glass/bottle/hypervene(src)

/obj/item/storage/syringe_case/oxy
	name = "缺氧注射器盒"
	desc = "用于存放注射器和药瓶的医疗盒.这个装有用于治疗缺氧的药物."

/obj/item/storage/syringe_case/oxy/PopulateContents()
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/reagent_containers/glass/bottle/inaprovaline(src)
	new /obj/item/reagent_containers/glass/bottle/dexalin(src)

/obj/item/storage/syringe_case/meralyne
	name = "注射器盒(meralyne)"
	desc = "用于存放注射器和药瓶的医疗盒.这个装有Meralyne."
	bottles_to_spawn = /obj/item/reagent_containers/glass/bottle/meralyne

/obj/item/storage/syringe_case/dermaline
	name = "注射器盒(dermaline)"
	desc = "用于存放注射器和药瓶的医疗盒.这个装有Dermaline."
	bottles_to_spawn = /obj/item/reagent_containers/glass/bottle/dermaline

/obj/item/storage/syringe_case/meraderm
	name = "注射器盒(meraderm)"
	desc = "用于存放注射器和药瓶的医疗盒.这个装有Meraderm."
	bottles_to_spawn = /obj/item/reagent_containers/glass/bottle/meraderm

/obj/item/storage/syringe_case/nanoblood
	name = "注射器盒(nanoblood)"
	desc = "用于存放注射器和药瓶的医疗盒.这个装有nanoblood."
	bottles_to_spawn = /obj/item/reagent_containers/glass/bottle/nanoblood

/obj/item/storage/syringe_case/tricordrazine
	name = "注射器盒(tricordrazine)"
	desc = "用于存放注射器和药瓶的医疗盒.这个装有Tricordrazine."
	bottles_to_spawn = /obj/item/reagent_containers/glass/bottle/tricordrazine

/*
* Pill Bottles
*/

/obj/item/storage/pill_bottle
	name = "药瓶"
	desc = "用于存放药物的密封容器."
	icon_state = "pill_canister"
	icon = 'icons/obj/items/chemistry.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/medical_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/medical_right.dmi',
	)
	worn_icon_state = "contsolid"
	w_class = WEIGHT_CLASS_SMALL
	storage_type = /datum/storage/pill_bottle
	greyscale_config = /datum/greyscale_config/pillbottle
	greyscale_colors = "#d9cd07#f2cdbb" //default colors
	/// Type of pill to use to fill in the bottle in New()
	var/pill_type_to_fill
	/// Short description in overlay
	var/description_overlay = ""

/obj/item/storage/pill_bottle/PopulateContents()
	if(!pill_type_to_fill)
		return
	for(var/i in 1 to storage_datum.max_storage_space)
		new pill_type_to_fill(src)
	update_icon(UPDATE_OVERLAYS)

/obj/item/storage/pill_bottle/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/hypospray))
		var/obj/item/reagent_containers/hypospray/hypospray = I
		if(hypospray.reagents.total_volume >= hypospray.volume)
			balloon_alert(user, "Hypospray已满.")
			return FALSE //early returning if its full

		if(!length(contents))
			return FALSE//early returning if its empty
		var/obj/item/pill = contents[1]

		if((pill.reagents.total_volume + hypospray.reagents.total_volume) > hypospray.volume)
			balloon_alert(user, "装不下那么多.")
			return FALSE// so it doesnt let people have hypos more filled than their volume
		pill.reagents.trans_to(I, pill.reagents.total_volume)

		to_chat(user, span_notice("你将[pill]从[src]溶解到[I]中."))
		storage_datum.remove_from_storage(pill, null, user)
		qdel(pill)
		return TRUE

	. = ..()
	if(.)
		return
	if(!istype(I, /obj/item/facepaint) || isnull(greyscale_config))
		return

	var/obj/item/facepaint/paint = I
	if(paint.uses < 1)
		to_chat(user, span_warning("\the [paint]没有颜色了!"))
		return
	var/bottle_color = input(user, "Pick a color", "Pick color") as null|color
	var/label_color = input(user, "Pick a color", "Pick color") as null|color

	if(isnull(bottle_color) || isnull(label_color) || !do_after(user, 1 SECONDS, NONE, src, BUSY_ICON_GENERIC))
		return

	set_greyscale_colors(list(bottle_color,label_color))
	paint.uses--
	update_icon()

/obj/item/storage/pill_bottle/attack_self(mob/living/user)
	if(user.get_inactive_held_item())
		user.balloon_alert(user, "需要空手")
		return
	if(length(contents))
		var/obj/item/I = contents[1]
		if(!storage_datum.remove_from_storage(I,user,user))
			return
		if(user.put_in_inactive_hand(I))
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.swap_hand()
		else
			user.dropItemToGround(I)
			to_chat(user, span_notice("你笨拙地摆弄\the [src],把一颗药丸掉在了地上."))
		return

/obj/item/storage/pill_bottle/update_overlays()
	. = ..()
	if(isturf(loc))
		return
	var/mutable_appearance/number = mutable_appearance()
	number.maptext = MAPTEXT(length(contents))
	. += number
	if(!description_overlay)
		return
	var/mutable_appearance/desc = mutable_appearance('icons/misc/12x12.dmi')
	desc.pixel_w = 16
	desc.maptext = MAPTEXT(description_overlay)
	desc.maptext_width = 16
	. += desc

/obj/item/storage/pill_bottle/equipped(mob/user, slot)
	. = ..()
	update_icon()

/obj/item/storage/pill_bottle/on_enter_storage(mob/user, slot)
	. = ..()
	update_icon()

/obj/item/storage/pill_bottle/removed_from_inventory()
	. = ..()
	update_icon()

/obj/item/storage/pill_bottle/kelotane
	name = "kelotane药瓶"
	desc = "含有治疗烧伤的药丸,但会造成轻微疼痛.吃两颗好得更快,但疼痛会稍重一些."
	pill_type_to_fill = /obj/item/reagent_containers/pill/kelotane
	greyscale_colors = "#CC9900#FFFFFF"
	description_overlay = "Ke"

/obj/item/storage/pill_bottle/dermaline
	name = "dermaline药瓶"
	desc = "含有治疗烧伤的药丸,但会造成轻微疼痛.吃两颗好得更快,但疼痛会稍重一些."
	pill_type_to_fill = /obj/item/reagent_containers/pill/dermaline
	greyscale_config = /datum/greyscale_config/pillbottleround
	greyscale_colors = "#ffef00#FFFFFF"
	description_overlay = "De"

/obj/item/storage/pill_bottle/dylovene
	name = "二乙烯三胺药瓶"
	desc = "含有可治疗毒素伤害并清除各类毒素和神经毒素的药丸."
	pill_type_to_fill = /obj/item/reagent_containers/pill/dylovene
	greyscale_colors = "#669900#ffffff"
	description_overlay = "Dy"

/obj/item/storage/pill_bottle/isotonic
	name = "等渗药瓶"
	desc = "含有可促进失去血液再生的药丸."
	pill_type_to_fill = /obj/item/reagent_containers/pill/isotonic
	greyscale_colors = "#5c0e0e#ffffff"
	description_overlay = "Is"

/obj/item/storage/pill_bottle/inaprovaline
	name = "英纳普拉瓦林药瓶"
	desc = "含有可防止伤口自行恶化的药丸."
	pill_type_to_fill = /obj/item/reagent_containers/pill/inaprovaline
	greyscale_config = /datum/greyscale_config/pillbottlebox
	greyscale_colors = "#9966CC#ffffff"
	description_overlay = "In"

/obj/item/storage/pill_bottle/tramadol
	name = "曲马多药瓶"
	desc = "含有可麻痹疼痛的药丸. 服用两片效果更强, 但会产生毒性效果."
	pill_type_to_fill = /obj/item/reagent_containers/pill/tramadol
	greyscale_colors = "#8a8686#ffffff"
	description_overlay = "Ta"

/obj/item/storage/pill_bottle/paracetamol
	name = "扑热息痛药瓶"
	desc = "含有可轻微麻痹疼痛的药丸. 服用两片效果略强."
	pill_type_to_fill = /obj/item/reagent_containers/pill/paracetamol
	greyscale_colors = "#cac5c5#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottlebox
	greyscale_colors = "#f8f4f8#ffffff"
	description_overlay = "Pa"

/obj/item/storage/pill_bottle/spaceacillin
	name = "spaceacillin药瓶"
	desc = "含有可处理轻度病毒和细菌感染的药丸. 效果随剂量增加."
	pill_type_to_fill = /obj/item/reagent_containers/pill/spaceacillin
	greyscale_config = /datum/greyscale_config/pillbottlebox
	greyscale_colors = "#90F7DeF5#ffffff"
	description_overlay = "Sp"

/obj/item/storage/pill_bottle/bicaridine
	name = "比卡瑞定药瓶"
	desc = "含有可治疗割伤和瘀伤的药丸, 但会引起轻微疼痛. 服用两片可加快治疗, 但疼痛会略微加重."
	pill_type_to_fill = /obj/item/reagent_containers/pill/bicaridine
	greyscale_colors = "#DA0000#ffffff"
	description_overlay = "Bi"

/obj/item/storage/pill_bottle/meralyne
	name = "梅拉林药瓶"
	desc = "含有可治疗割伤和瘀伤的药丸, 但会引起轻微疼痛. 服用两片可加快治疗, 但疼痛会略微加重."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/meralyne
	greyscale_config = /datum/greyscale_config/pillbottleround
	greyscale_colors = "#FD5964#ffffff"
	description_overlay = "Me"

/obj/item/storage/pill_bottle/dexalin
	name = "右旋糖酐药瓶"
	desc = "含有可治疗缺氧伤害的药丸. 它们也能抑制失血症状."
	pill_type_to_fill = /obj/item/reagent_containers/pill/dexalin
	greyscale_colors = "#5972FD#ffffff"
	description_overlay = "Dx"

/obj/item/storage/pill_bottle/alkysine
	name = "阿尔基辛药瓶"
	desc = "含有可治疗大脑和耳部伤害的药丸."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/alkysine
	greyscale_config = /datum/greyscale_config/pillbottlebubble
	greyscale_colors = "#0292AC#ffffff"
	description_overlay = "Al"

/obj/item/storage/pill_bottle/imidazoline
	name = "咪达唑仑药瓶"
	desc = "含有可治疗眼部伤害的药丸."
	pill_type_to_fill = /obj/item/reagent_containers/pill/imidazoline
	greyscale_config = /datum/greyscale_config/pillbottlebubble
	greyscale_colors = "#F7A151#ffffff" //orange like carrots
	description_overlay = "Im"

/obj/item/storage/pill_bottle/russian_red
	name = "\improper 俄罗斯红药瓶"
	desc = "含有可快速治疗所有伤害的药丸, 代价是造成少量无法治疗的伤害."
	icon_state = "pill_canister"
	pill_type_to_fill = /obj/item/reagent_containers/pill/russian_red
	greyscale_colors = "#3d0000#ffffff"
	description_overlay = "Rr"

/obj/item/storage/pill_bottle/quickclot
	name = "速凝药瓶"
	desc = "含有可在等待完整治疗期间抑制内出血的药丸."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/quickclot
	greyscale_config = /datum/greyscale_config/pillbottleround
	greyscale_colors = "#E07BAD#ffffff"
	description_overlay = "Qk"

/obj/item/storage/pill_bottle/peridaxon
	name = "哌拉西酮药瓶"
	desc = "含有可抑制内脏伤害的药丸."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/peridaxon
	greyscale_config = /datum/greyscale_config/pillbottleround
	greyscale_colors = "#460750#ffffff"
	description_overlay = "Pe"

/obj/item/storage/pill_bottle/hypervene
	name = "hypervene药瓶"
	desc = "一种用于治疗用药过量和快速清除毒素的净化药物. 会引起疼痛和呕吐."
	icon_state = "pill_canister"
	pill_type_to_fill = /obj/item/reagent_containers/pill/hypervene
	greyscale_config = /datum/greyscale_config/pillbottlebubble
	greyscale_colors = "#AC6D32#ffffff"
	description_overlay = "Hy"

/obj/item/storage/pill_bottle/tricordrazine
	name = "三可曲嗪药瓶"
	desc = "含有可轻微治疗所有主要伤害类型的药丸."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/tricordrazine
	greyscale_colors = "#f8f8f8#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "Ti"

/obj/item/storage/pill_bottle/imialky
	name = "伊米阿尔基药瓶"
	desc = "含有用于修复大脑, 耳部和眼部伤害的药丸"
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/imialky
	greyscale_colors = "#E467B3#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "IA"

/obj/item/storage/pill_bottle/combatmix
	name = "战斗混合药瓶"
	desc = "含有BKTT药丸. 战斗混合"
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/combatmix
	greyscale_colors = "#FF2600#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "Cm"

/obj/item/storage/pill_bottle/doctor_delight
	name = "医生之喜药瓶"
	desc = "含有用于缓慢治疗的药丸."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/doctor_delight
	greyscale_colors = "#A3295C#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "Dd"

/obj/item/storage/pill_bottle/sugar
	name = "糖丸药瓶"
	desc = "含有用于防止饥饿的药丸, 好吃!"
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/sugar
	greyscale_colors = "#ECFC00#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "Su"

/obj/item/storage/pill_bottle/ifosfamide
	name = "异环磷酰胺药瓶"
	desc = "含有细胞抑制性抗肿瘤急救药物的药丸."
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/ifosfamide
	greyscale_colors = "#9ACD32#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "If"

/obj/item/storage/pill_bottle/happy
	name = "快乐药瓶"
	desc = "含有高度非法的药物. 当你想看到彩虹时."
	pill_type_to_fill = /obj/item/reagent_containers/pill/happy
	greyscale_colors = "#6C52BF#ffffff"

/obj/item/storage/pill_bottle/happy/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_storage_space = 7

/obj/item/storage/pill_bottle/zoom
	name = "急速药瓶"
	desc = "含有高度非法的药物. 用心脏换取速度."
	pill_type_to_fill = /obj/item/reagent_containers/pill/zoom
	greyscale_colors = "#ef3ad4#ffffff"

/obj/item/storage/pill_bottle/zoom/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_storage_space = 7

//АИ-2

/obj/item/storage/ai2
	name = "\"АИ-2\"急救包"
	desc = "这是一个装有稀有且有用试剂的个人医疗包."
	icon = 'icons/obj/items/storage/firstaid.dmi'
	icon_state = "ai2"
	equip_slot_flags = ITEM_SLOT_POCKET
	w_class = WEIGHT_CLASS_NORMAL
	storage_type = /datum/storage/ai2
	var/is_open = FALSE

/obj/item/storage/ai2/PopulateContents()
	new /obj/item/storage/pill_bottle/penal/meralyne(src)
	new /obj/item/storage/pill_bottle/penal/dermaline(src)
	new /obj/item/storage/pill_bottle/penal/hyronalin(src)
	new /obj/item/storage/pill_bottle/penal/dexalin(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/pen/tramadol(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/pen/neuraline(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/pen/inaprovaline(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/pen/hypervene(src)

/obj/item/storage/ai2/update_icon_state()
	cut_overlays()

	var/list/types_and_overlays = list(
		/obj/item/storage/pill_bottle/penal/meralyne = "ai2_meralyne_open",
		/obj/item/storage/pill_bottle/penal/dermaline = "ai2_dermaline_open",
		/obj/item/storage/pill_bottle/penal/hyronalin = "ai2_hyronalin_open",
		/obj/item/storage/pill_bottle/penal/dexalin = "ai2_dexalin_open",
		/obj/item/reagent_containers/hypospray/autoinjector/pen/tramadol = "ai2_tramadol_open",
		/obj/item/reagent_containers/hypospray/autoinjector/pen/neuraline = "ai2_neuraline_open",
		/obj/item/reagent_containers/hypospray/autoinjector/pen/inaprovaline = "ai2_inaprovaline_open",
		/obj/item/reagent_containers/hypospray/autoinjector/pen/hypervene = "ai2_hypervene_open",
	)

	if(!is_open)
		return
	for(var/obj/item/W in contents)
		if(!types_and_overlays[W.type])
			continue
		add_overlay(types_and_overlays[W.type])
		types_and_overlays -= W.type

/obj/item/storage/pill_bottle/penal
	icon = 'icons/obj/items/storage/firstaid.dmi'
	w_class = WEIGHT_CLASS_TINY
	greyscale_config = null
	greyscale_colors = null

/obj/item/storage/pill_bottle/penal/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_storage_space = 6

/obj/item/storage/pill_bottle/penal/meralyne
	name = "梅拉林\"Пенал\"盒"
	desc = "含有几片梅拉林药丸, 古老而精致."
	icon_state = "meralyne_agent"
	pill_type_to_fill = /obj/item/reagent_containers/pill/meralyne

/obj/item/storage/pill_bottle/penal/dermaline
	name = "德玛林\"Пенал\"盒"
	desc = "含有几片德玛林药丸, 古老而精致."
	icon_state = "dermaline_agent"
	pill_type_to_fill = /obj/item/reagent_containers/pill/dermaline

/obj/item/storage/pill_bottle/penal/hyronalin
	name = "海罗纳林\"Пенал\"盒"
	desc = "含有几片海罗纳林药丸, 古老而精致."
	icon_state = "hyronalin_agent"
	pill_type_to_fill = /obj/item/reagent_containers/pill/hyronalin

/obj/item/storage/pill_bottle/penal/dexalin
	name = "右旋糖酐\"Пенал\"盒"
	desc = "含有几片右旋糖酐药丸, 古老而精致."
	icon_state = "dexalin_agent"
	pill_type_to_fill = /obj/item/reagent_containers/pill/dexalin

/obj/item/reagent_containers/hypospray/autoinjector/pen
	icon = 'icons/obj/items/storage/firstaid.dmi'
	volume = 30
	reagent_flags = null

/obj/item/reagent_containers/hypospray/autoinjector/pen/tramadol
	name = "曲马多笔"
	desc = "一支装有2剂重剂量曲马多的笔, 使用两次效果更佳."
	icon_state = "tramadol_pen"
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/tramadol = 30)

/obj/item/reagent_containers/hypospray/autoinjector/pen/neuraline
	name = "神经林笔"
	desc = "一支装有强效兴奋剂的笔. 会引起严重中毒!"
	icon_state = "neuraline_pen"
	amount_per_transfer_from_this = 4
	list_reagents = list(/datum/reagent/medicine/neuraline = 4)

/obj/item/reagent_containers/hypospray/autoinjector/pen/inaprovaline
	name = "异丙肾上腺素笔"
	desc = "一支装有兴奋剂的笔. 用于急救濒危人员!"
	icon_state = "inaprovaline_pen"
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/inaprovaline = 30)

/obj/item/reagent_containers/hypospray/autoinjector/pen/hypervene
	name = "净体素笔"
	desc = "一支装有净化剂的笔. 小心, 它会造成剧烈疼痛并清除一切."
	icon_state = "hypervene_pen"
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/hypervene = 30)

/obj/item/storage/pill_bottle/oxycodone
	name = "羟考酮药瓶"
	desc = "装有可缓解剧痛的药片."
	pill_type_to_fill = /obj/item/reagent_containers/pill/oxycodone
	greyscale_colors = "#360570#ffffff"
	description_overlay = "Ox"

/obj/item/storage/pill_bottle/meraderm
	name = "美拉皮肤药瓶"
	desc = "装有用于治疗割伤和烧伤的药片, 真好吃!"
	icon_state = "pill_canistercomplete"
	pill_type_to_fill = /obj/item/reagent_containers/pill/meraderm
	greyscale_colors = "#ECFC00#ffffff"
	greyscale_config = /datum/greyscale_config/pillbottleround
	description_overlay = "MD"
