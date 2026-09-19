/obj/item/clothing/glasses/night
	name = "夜视护目镜"
	desc = "你现在完全可以在黑暗中看见了!"
	species_exception = list(/datum/species/robot)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/glasses.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/glasses_bravada.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/glasses_charlit.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/glasses_alpharii.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/glasses_deltad.dmi')
	icon_state = "night"
	worn_icon_state = "glasses"
	lighting_cutoff = LIGHTING_CUTOFF_MEDIUM
	toggleable = TRUE

/obj/item/clothing/glasses/night/tx8
	name = "\improper BR-8战斗瞄具"
	desc = "用于BR-8战斗步枪的头戴式夜视护目镜系统.可高亮显示周围环境影像.点击切换."
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	vision_flags = SEE_TURFS
	toggleable = TRUE
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/night/m42_night_goggles
	name = "\improper M42侦察瞄具"
	desc = "用于M42侦察步枪的头戴式夜视护目镜系统.可高亮显示周围环境影像.点击切换."
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	vision_flags = SEE_TURFS
	toggleable = TRUE
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/night/m42_night_goggles/upp
	name = "\improper 9型精英护目镜"
	desc = "USL部队使用的头戴式夜视护目镜系统.可高亮显示周围环境影像.点击切换."
	icon_state = "upp_goggles"
	deactive_state = "upp_goggles_0"

/obj/item/clothing/glasses/night/sectoid
	name = "异形晶状体"
	desc = "覆盖在异形眼睛上的厚实黑色涂层,使它们能在黑暗中视物."
	icon_state = "alien_lens"
	worn_icon_state = "alien_lens"
	lighting_cutoff = LIGHTING_CUTOFF_FULLBRIGHT
	item_flags = DELONDROP

/obj/item/clothing/glasses/night/sectoid/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SECTOID_TRAIT)

/obj/item/clothing/glasses/night/m56_goggles
	name = "\improper KTLD头戴式瞄具"
	desc = "一种头戴式护目镜系统,可与任何KTLD武器配对使用,例如SG系列武器.配有低分辨率短程成像仪,可观察地形."
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	toggleable = TRUE
	vision_flags = SEE_TURFS

/obj/item/clothing/glasses/night/sunglasses
	name = "\improper KTLD太阳镜"
	desc = "一副设计师太阳镜.这副眼镜内置了KTLD头戴式瞄具."
	icon_state = "m56sunglasses"
	worn_icon_state = "m56sunglasses"
	deactive_state = "deactivated_sunglasses"
	toggleable = TRUE
	vision_flags = SEE_TURFS
	prescription = TRUE

/obj/item/clothing/glasses/night/yautja
	name = "生化面罩夜视"
	desc = "由生化面罩生成的视觉叠加层.用于低光环境."
	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "visor_nvg"
	worn_icon_state = "visor_nvg"
	worn_icon_list = list(
		slot_glasses_str = 'icons/mob/hunter/pred_gear.dmi'
	)
	actions_types = null

/obj/item/clothing/glasses/night/yautja/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

/obj/item/clothing/glasses/night/yautja/dropped(mob/living/carbon/human/user)
	if(istype(user) && user.glasses == src)
		user.clear_fullscreen("robothalf", 5)
	return ..()

/obj/item/clothing/glasses/night/yautja/equipped(mob/living/carbon/human/user, slot)
	if(slot == SLOT_GLASSES)
		user.overlay_fullscreen("robothalf", /atom/movable/screen/fullscreen/machine/pred/night)
	return ..()

/obj/item/clothing/glasses/night/yautja/unequipped(mob/living/carbon/human/user, slot)
	if(slot == SLOT_GLASSES)
		user.clear_fullscreen("robothalf", 5)
	return ..()

/obj/item/clothing/glasses/night_vision
	name = "\improper BE-47夜视护目镜"
	desc = "用于在低光环境下更清晰地视物并保持对周围环境的观察的护目镜."
	icon_state = "night_vision"
	deactive_state = "night_vision_off"
	worn_layer = COLLAR_LAYER	//The sprites are designed to render over helmets
	worn_worn_icon_state_slots = list()
	// Red with a tint of green
	color_cutoffs = list(40, 15, 10)
	vision_flags = SEE_TURFS
	toggleable = TRUE
	tint = COLOR_RED_GRAY
	goggles_layer = TRUE
	active = FALSE
	activation_sound = 'sound/effects/nightvision.ogg'
	deactivation_sound = 'sound/machines/click.ogg'
	species_exception = list(/datum/species/robot)
	///The battery inside
	var/obj/item/cell/night_vision_battery/battery
	///How much energy this module needs when activated
	var/active_energy_cost = 4	//2 minute of use
	///Looping sound to play
	var/datum/looping_sound/active_sound = /datum/looping_sound/scan_pulse
	///How loud the looping sound should be
	var/looping_sound_volume = 5
	var/last_active_time = 0

/obj/item/clothing/glasses/night_vision/Initialize(mapload)
	. = ..()
	//Start with a charged battery
	battery = new /obj/item/cell/night_vision_battery(src)
	active_sound = new active_sound()
	active_sound.volume = looping_sound_volume
	update_worn_state()
	last_active_time = world.time

/obj/item/clothing/glasses/night_vision/examine(mob/user)
	. = ..()
	. += span_notice("此型号激活时消耗[active_energy_cost]能量.")
	. += battery_status()
	. += "To eject the battery, [span_bold("[user.get_inactive_held_item() == src ? "click" : "ALT-click"]")] [src] with an empty hand. To insert a battery, [span_bold("click")] [src] with a compatible cell."

///Info regarding battery status; separate proc so that it can be displayed when examining the parent object
/obj/item/clothing/glasses/night_vision/proc/battery_status()
	if(battery)
		return span_notice("电量:[battery.charge]/[battery.maxcharge]")
	return span_warning("未安装电池!")

/obj/item/clothing/glasses/night_vision/attack_hand(mob/living/user)
	if(user.get_inactive_held_item() == src && eject_battery(user))
		return
	return ..()

/obj/item/clothing/glasses/night_vision/AltClick(mob/user)
	if(!eject_battery(user))
		return ..()

/obj/item/clothing/glasses/night_vision/attackby(obj/item/I, mob/user, params)
	. = ..()
	insert_battery(I, user)

///Insert a battery, if checks pass
/obj/item/clothing/glasses/night_vision/proc/insert_battery(obj/item/I, mob/user)
	if(!istype(I, /obj/item/cell/night_vision_battery))
		return

	if(battery && (battery.charge > battery.maxcharge * 0.5))
		balloon_alert(user, "已安装电池")
		return
	//Hot swap!
	eject_battery()

	user.temporarilyRemoveItemFromInventory(I)
	I.forceMove(src)
	battery = I

	if(battery.charge < battery.maxcharge)
		START_PROCESSING(SSobj, src)

	return TRUE

///Eject the internal battery, if there is one
/obj/item/clothing/glasses/night_vision/proc/eject_battery(mob/user)
	if(user?.get_active_held_item() || !battery)
		return

	if(user)
		user.put_in_active_hand(battery)
	else
		battery.forceMove(get_turf(src))
	battery = null

	if(active)
		activate(user)
	else
		STOP_PROCESSING(SSobj, src)

	return TRUE

/obj/item/clothing/glasses/night_vision/activate(mob/user)
	if(active)
		active_sound.stop(src)
		last_active_time = world.time
	else
		if(!battery || battery.charge < active_energy_cost)
			if(user)
				balloon_alert(user, "无电力")
			return FALSE	//Don't activate
		START_PROCESSING(SSobj, src)
		active_sound.start(src)

	update_worn_state(!active)	//The active var has not been toggled yet, so pass the opposite value
	return ..()

/obj/item/clothing/glasses/night_vision/process()
	if(active)
		if(!battery?.use(active_energy_cost))
			if(ismob(loc))	//If it's deactivated while being worn, pass on the reference to activate() so that the user's sight is updated
				activate(loc)
			else
				activate()

	else
		if(!battery || battery.charge >= battery.maxcharge)
			return PROCESS_KILL

		if(world.time > last_active_time + 100)
			battery.charge = min(battery.charge + 2, battery.maxcharge)

///Simple proc to update the worn state of the glasses; will use the active value by default if no argument passed
/obj/item/clothing/glasses/night_vision/proc/update_worn_state(state = active)
	worn_worn_icon_state_slots[slot_glasses_str] = initial(icon_state) + (state ? "" : "_off")

/obj/item/clothing/glasses/night_vision/unequipped(mob/unequipper, slot)
	. = ..()
	if(active)
		activate(unequipper)

/obj/item/clothing/glasses/night_vision/Destroy()
	QDEL_NULL(active_sound)
	return ..()

//So that the toggle button is only given when in the eyes slot
/obj/item/clothing/glasses/night_vision/item_action_slot_check(mob/user, slot)
	return CHECK_BITFIELD(slot, ITEM_SLOT_EYES)

/obj/item/clothing/glasses/night_vision/mounted
	name = "\improper BE-35夜视护目镜"
	desc = "用于在低光环境下更清晰地视物的护目镜.必须保持附着在头盔上."
	icon_state = "night_vision_mounted"
	tint = COLOR_BLUE
	vision_flags = NONE
	active_energy_cost = 2	//4 minutes of use
	looping_sound_volume = 15

/obj/item/clothing/glasses/night_vision/mounted/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, NIGHT_VISION_GOGGLES_TRAIT)

/obj/item/clothing/glasses/night/vsd
	name = "\improper CM-12夜视护目镜"
	desc = "V.S.D的标准配发夜视护目镜!带来额外的战术酷炫感!坠毁核心和你的上级军官不对失明和灼伤负责."
	icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "vsd_nvg"
	worn_icon_state = "vsd_nvg"
	deactive_state = "vsd_nvg_off"
	toggleable = TRUE
	actions_types = list(/datum/action/item_action/toggle)
	tint = COLOR_GREEN
	worn_layer = COLLAR_LAYER
