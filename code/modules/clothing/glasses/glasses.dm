/obj/item/clothing/glasses
	name = "眼镜"
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/clothing/glasses_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/clothing/glasses_right.dmi',
	)
	w_class = WEIGHT_CLASS_SMALL
	active = TRUE
	inventory_flags = COVEREYES
	equip_slot_flags = ITEM_SLOT_EYES
	armor_protection_flags = EYES
	/// If TRUE it will help with near-sightness
	var/prescription = FALSE
	// If TRUE we are able to toggle the glasses and spawn with toggle action
	var/toggleable = FALSE
	/// The deactivated icon_state of our goggles
	var/deactive_state = ""
	/// Flags for stuff like mesons and thermals
	var/vision_flags = NONE
	var/invis_view = SEE_INVISIBLE_LIVING
	var/invis_override = 0 //Override to allow glasses to set higher than normal see_invis
	/// A percentage of how much rgb to "max" on the lighting plane
	/// This lets us brighten darkness without washing out bright color
	var/lighting_cutoff = null
	/// Similar to lighting_cutoff, except it has individual r g and b components in the same 0-100 scale
	var/list/color_cutoffs = null
	// If TRUE we will change our on-mob image layer to GOGGLES instead of GLASSES
	var/goggles_layer = FALSE
	///Sound played on activate() when turning on
	var/activation_sound = 'sound/items/googles_on.ogg'
	///Sound played on activate() when turning off
	var/deactivation_sound = 'sound/items/googles_off.ogg'
	///Color to use for the HUD tint; leave null if no tint
	var/tint

/obj/item/clothing/glasses/examine_descriptor(mob/user)
	return "eyewear"

/obj/item/clothing/glasses/examine_tags(mob/user)
	. = ..()
	if(prescription)
		.["prescription"] = "It will help reduce symptoms of nearsightedness when worn."

/obj/item/clothing/glasses/Initialize(mapload)
	if(toggleable)
		actions_types = list(/datum/action/item_action/toggle)
	. = ..()
	if(toggleable && active)	//For glasses that spawn active
		active = FALSE
		activate()

/obj/item/clothing/glasses/update_icon_state()
	. = ..()
	icon_state = active ? initial(icon_state) : deactive_state

/obj/item/clothing/glasses/update_clothing_icon()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_glasses()

//Glasses can still be toggled if held in the hand if the player wishes to
/obj/item/clothing/glasses/attack_self(mob/user)
	if(toggleable && can_interact(user))
		activate(user)

//Just call the activate() directly instead of needing to call attack_self()
/obj/item/clothing/glasses/ui_action_click(mob/user, datum/action/item_action/action)
	//In case someone in the future adds a non-toggle action to a child type
	if(istype(action, /datum/action/item_action/toggle))
		activate(user)
		//Always return TRUE for toggles so that the UI button icon updates
		return TRUE

	return activate(user)

///Toggle the functions of the glasses
/obj/item/clothing/glasses/proc/activate(mob/user)
	active = !active

	if(active && activation_sound)
		playsound(get_turf(src), activation_sound, 15)
	else if(!active && deactivation_sound)
		playsound(get_turf(src), deactivation_sound, 15)

	update_icon()	//Found out the hard way this has to be before update_inv_glasses()
	user?.update_inv_glasses()
	user?.update_sight()

	return active	//For the UI button update

/obj/item/clothing/glasses/science
	name = "科学护目镜"
	desc = "护目镜什么也做不了! 可用作安全护目镜."
	icon_state = "purple"
	worn_icon_state = "glasses"

/obj/item/clothing/glasses/eyepatch
	name = "眼罩"
	desc = "呀!"
	icon_state = "eyepatch"
	worn_icon_state = "eyepatch"
	armor_protection_flags = NONE

/obj/item/clothing/glasses/eyepatch/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	var/obj/item/clothing/glasses/eyepatch
	if(istype(I, /obj/item/clothing/glasses/hud/health))
		eyepatch = new /obj/item/clothing/glasses/hud/medpatch
		to_chat(user, span_notice("你将医疗HUD投影器固定在眼罩内侧."))
	else if(istype(I, /obj/item/clothing/glasses/meson))
		eyepatch = new /obj/item/clothing/glasses/meson/eyepatch
		to_chat(user, span_notice("你将介子投影器固定在眼罩内侧."))
	if(!eyepatch)
		return
	qdel(I)
	qdel(src)
	user.put_in_hands(eyepatch)
	update_icon()

/obj/item/clothing/glasses/monocle
	name = "单片眼镜"
	desc = "如此精致的镜片!"
	icon_state = "monocle"
	armor_protection_flags = NONE

/obj/item/clothing/glasses/regular
	name = "\improper 制式处方眼镜"
	desc = "陆战队可能称它们为制式处方眼镜,但你知道它们是防撸管眼镜."
	icon_state = "glasses"
	worn_icon_state = "glasses"
	prescription = TRUE

/obj/item/clothing/glasses/regular/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/clothing/glasses/hud/health))
		var/obj/item/clothing/glasses/hud/medglasses/our_glasses = new
		to_chat(user, span_notice("你将医疗HUD投影器固定在眼镜内侧."))
		qdel(I)
		qdel(src)
		user.put_in_hands(our_glasses)

		update_icon()

/obj/item/clothing/glasses/regular/hipster
	name = "处方眼镜"
	desc = "由Uncool. Co.制造."
	icon_state = "hipster_glasses"
	worn_icon_state = "hipster_glasses"

/obj/item/clothing/glasses/green
	name = "绿色眼镜"
	desc = "森林绿眼镜,就像你在策划邪恶阴谋时会戴的那种."
	icon_state = "green"
	worn_icon_state = "green"

/obj/item/clothing/glasses/mgoggles
	name = "陆战队防弹护目镜"
	desc = "标准配发的TGMC护目镜.主要用于装饰某人的头盔."
	icon_state = "mgoggles"
	worn_icon_state = "mgoggles"
	soft_armor = list(MELEE = 40, BULLET = 40, LASER = 0, ENERGY = 15, BOMB = 35, BIO = 10, FIRE = 30, ACID = 30)
	equip_slot_flags = ITEM_SLOT_EYES|ITEM_SLOT_MASK
	goggles_layer = TRUE
	w_class = WEIGHT_CLASS_TINY

/obj/item/clothing/glasses/mgoggles/attackby(obj/item/our_item, mob/user, params)
	. = ..()
	if(.)
		return
	var/obj/item/clothing/glasses/our_glasses

	if(istype(our_item, /obj/item/clothing/glasses/hud/health))
		if(prescription)
			our_glasses = new /obj/item/clothing/glasses/hud/medgoggles/prescription
		else
			our_glasses = new /obj/item/clothing/glasses/hud/medgoggles
		to_chat(user, span_notice("你将医疗HUD投影器固定在护目镜内侧."))

	else if(istype(our_item, /obj/item/clothing/glasses/meson))
		if(prescription)
			our_glasses = new /obj/item/clothing/glasses/meson/enggoggles/prescription
		else
			our_glasses = new /obj/item/clothing/glasses/meson/enggoggles
		to_chat(user, span_notice("你将光学介子扫描仪固定在护目镜内侧."))

	if(!our_glasses)
		return

	qdel(our_item)
	qdel(src)
	user.put_in_hands(our_glasses)
	update_icon()

/obj/item/clothing/glasses/mgoggles/prescription
	name = "处方陆战队防弹护目镜"
	desc = "标准配发的TGMC护目镜.主要用于装饰某人的头盔.内含处方镜片,以防你不确定它们是否很逊."
	prescription = TRUE

/obj/item/clothing/glasses/m42_goggles
	name = "\improper M42侦察瞄具"
	desc = "用于M42侦察步枪的头戴和护目镜系统.允许高亮显示周围环境.点击切换."
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	vision_flags = SEE_TURFS
	toggleable = TRUE

//welding goggles

/obj/item/clothing/glasses/welding
	name = "焊接护目镜"
	desc = "保护眼睛免受焊接伤害,经疯狂科学家协会批准."
	icon_state = "welding-g"
	worn_icon_state = "welding-g"
	toggleable = TRUE
	inventory_flags = COVEREYES
	eye_protection = 2
	activation_sound = null
	deactivation_sound = null

/obj/item/clothing/glasses/welding/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/clothing_tint, TINT_5, TRUE)

/obj/item/clothing/glasses/welding/verb/verbtoggle()
	set category = "IC.Clothing"
	set name = "Adjust welding goggles"
	set src in usr

	if(!usr.incapacitated())
		activate(usr)

/obj/item/clothing/glasses/welding/activate(mob/user)
	. = ..()
	if(active)
		flip_down(user)
	else
		flip_up(user)

	//This sends a signal that toggles the tint component's effects
	toggle_worn_icon_state(user)

///Toggle the welding goggles on
/obj/item/clothing/glasses/welding/proc/flip_up(mob/user)
	DISABLE_BITFIELD(inventory_flags, COVEREYES)
	DISABLE_BITFIELD(armor_protection_flags, EYES)
	eye_protection = 0
	update_icon()
	if(user)
		to_chat(user, "你将[src]推离面部.")

///Toggle the welding goggles off
/obj/item/clothing/glasses/welding/proc/flip_down(mob/user)
	ENABLE_BITFIELD(inventory_flags, COVEREYES)
	ENABLE_BITFIELD(armor_protection_flags, EYES)
	eye_protection = initial(eye_protection)
	update_icon()
	if(user)
		to_chat(user, "你将[src]翻下以保护眼睛.")

/obj/item/clothing/glasses/welding/update_icon_state()
	icon_state = "[initial(icon_state)][!active ? "up" : ""]"

/obj/item/clothing/glasses/welding/flipped/Initialize(mapload)	//spawn in flipped up.
	. = ..()
	activate()
	AddComponent(/datum/component/clothing_tint, TINT_5, FALSE)

/obj/item/clothing/glasses/welding/superior
	name = "高级焊接护目镜"
	desc = "由更昂贵材料制成的焊接护目镜,奇怪的是闻起来像土豆."
	icon_state = "rwelding-g"
	worn_icon_state = "rwelding-g"

/obj/item/clothing/glasses/welding/superior/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/clothing_tint, TINT_4)

//sunglasses

/obj/item/clothing/glasses/sunglasses
	name = "太阳镜"
	desc = "用于提供基本眼部防护的奇怪古老技术.增强的护盾可阻挡许多闪光."
	icon_state = "sun"
	worn_icon_state = "sunglasses"
	eye_protection = 1

/obj/item/clothing/glasses/sunglasses/Initialize(mapload)
	. = ..()
	if(eye_protection)
		AddComponent(/datum/component/clothing_tint, TINT_3)

/obj/item/clothing/glasses/sunglasses/blindfold
	name = "眼罩"
	desc = "遮住眼睛,阻止视线."
	icon_state = "blindfold"
	worn_icon_state = "blindfold"
	eye_protection = 2

/obj/item/clothing/glasses/sunglasses/blindfold/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/clothing_tint, TINT_BLIND)

/obj/item/clothing/glasses/sunglasses/big
	desc = "用于提供基本眼部防护的奇怪古老技术.比普通款更大的增强护盾可阻挡许多闪光."
	icon_state = "bigsunglasses"
	worn_icon_state = "bigsunglasses"

/obj/item/clothing/glasses/sunglasses/big/prescription
	name = "处方太阳镜"
	prescription = TRUE

/obj/item/clothing/glasses/sunglasses/fake
	desc = "一副名牌太阳镜.似乎不能阻挡闪光."
	eye_protection = 0

/obj/item/clothing/glasses/sunglasses/fake/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	var/obj/item/clothing/glasses/our_glasses
	if(istype(I, /obj/item/clothing/glasses/hud/health))
		our_glasses = new /obj/item/clothing/glasses/hud/medsunglasses
		to_chat(user, span_notice("你将医疗HUD投影器固定在眼镜内侧."))
	else if(istype(I, /obj/item/clothing/glasses/meson))
		our_glasses = new /obj/item/clothing/glasses/meson/sunglasses
		to_chat(user, span_notice("你将光学介子扫描仪固定在眼镜内侧."))
	else if(istype(I, /obj/item/clothing/glasses/night/m56_goggles))
		our_glasses = new /obj/item/clothing/glasses/night/sunglasses
		to_chat(user, span_notice("你将KTLD瞄具固定在眼镜内侧."))
	if(!our_glasses)
		return
	qdel(I)
	qdel(src)
	user.put_in_hands(our_glasses)
	update_icon()

/obj/item/clothing/glasses/sunglasses/fake/prescription
	name = "处方太阳镜"
	prescription = TRUE

/obj/item/clothing/glasses/sunglasses/fake/big
	name = "名牌太阳镜"
	desc = "一副比普通款更大的名牌太阳镜.似乎不能阻挡闪光."
	icon_state = "bigsunglasses"
	worn_icon_state = "bigsunglasses"

/obj/item/clothing/glasses/sunglasses/fake/big/prescription
	name = "处方名牌太阳镜"
	prescription = TRUE

/obj/item/clothing/glasses/sunglasses/sa
	name = "空间特工的太阳镜"
	desc = "空间特工佩戴的眼镜."
	eye_protection = 2
	vision_flags = SEE_TURFS|SEE_MOBS|SEE_OBJS
	lighting_cutoff = LIGHTING_CUTOFF_MEDIUM

/obj/item/clothing/glasses/sunglasses/sa/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/clothing_tint, TINT_NONE)

/obj/item/clothing/glasses/sunglasses/sa/nodrop
	desc = "空间特工佩戴的眼镜.无法掉落"
	item_flags = DELONDROP

/obj/item/clothing/glasses/sunglasses/sechud
	name = "HUD太阳镜"
	desc = "带有HUD的太阳镜."
	icon_state = "sunhud"

/obj/item/clothing/glasses/sunglasses/sechud/mp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/clothing_tint, TINT_NONE)

/obj/item/clothing/glasses/sunglasses/aviator
	name = "飞行员太阳镜"
	desc = "一副飞行员太阳镜."
	icon_state = "aviator"
	worn_icon_state = "aviator"

/obj/item/clothing/glasses/sunglasses/aviator/yellow
	name = "飞行员太阳镜"
	desc = "一副飞行员太阳镜.配有黄色镜片."
	icon_state = "aviator_yellow"
	worn_icon_state = "aviator_yellow"

/obj/item/clothing/glasses/orange
	name = "橙色眼镜"
	desc = "一副橙色眼镜."
	icon_state = "orange"
	worn_icon_state = "orange"
	species_exception = list(/datum/species/robot)

/obj/item/clothing/glasses/orange/attackby(obj/item/our_item, mob/user, params)
	. = ..()
	if(.)
		return
	var/obj/item/clothing/glasses/our_glasses
	if(istype(our_item, /obj/item/clothing/glasses/hud/health))
		our_glasses = new /obj/item/clothing/glasses/hud/orange_glasses
		to_chat(user, span_notice("你将医疗HUD投影器固定在眼镜内侧."))
	else if(istype(our_item, /obj/item/clothing/glasses/meson))
		our_glasses = new /obj/item/clothing/glasses/meson/orange_glasses
		to_chat(user, span_notice("你将光学介子扫描仪固定在眼镜内侧."))
	if(!our_glasses)
		return
	qdel(our_item)
	qdel(src)
	user.put_in_hands(our_glasses)
	update_icon()

/obj/item/clothing/glasses/meson/orange_glasses
	name = "橙色眼镜"
	desc = "一副橙色眼镜.这副已装配光学介子扫描仪."
	worn_icon_list = list(
		slot_glasses_str = 'icons/mob/clothing/eyes.dmi')
	icon_state = "meson_orange"
	worn_icon_state = "meson_orange"
	deactive_state = "deactivated_orange"

/obj/item/clothing/glasses/hud/orange_glasses
	name = "橙色眼镜"
	desc = "一副橙色眼镜.这副已装配内置HealthMate HUD投影器."
	worn_icon_list = list(
		slot_glasses_str = 'icons/mob/clothing/eyes.dmi')
	icon_state = "med_orange"
	worn_icon_state = "med_orange"
	deactive_state = "deactivated_orange"
	toggleable = TRUE
	hud_type = DATA_HUD_MEDICAL_ADVANCED
