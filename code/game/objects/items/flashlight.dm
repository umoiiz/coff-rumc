/obj/item/flashlight
	name = "手电筒"
	desc = "一种手持应急灯."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "flashlight"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/lights_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/lights_right.dmi',
	)
	worn_icon_state = "flashlight"
	w_class = WEIGHT_CLASS_SMALL
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	actions_types = list(/datum/action/item_action)
	light_range = 5
	light_power = 3 //luminosity when on
	///Can this be turned into a rail light ?
	var/raillight_compatible = TRUE
	var/activation_sound = 'sound/items/flashlight.ogg'
	///If this flashlight affected by nightfall
	var/nightfall_immune = FALSE

/obj/item/flashlight/Initialize(mapload)
	. = ..()
	GLOB.nightfall_toggleable_lights += src

/obj/item/flashlight/Destroy()
	GLOB.nightfall_toggleable_lights -= src
	return ..()

/obj/item/flashlight/turn_light(mob/user, toggle_on, cooldown = 1 SECONDS, sparks = FALSE, forced = FALSE)
	if(forced && nightfall_immune)
		return NIGHTFALL_IMMUNE
	. = ..()
	if(. != CHECKS_PASSED)
		return
	if(!user && ismob(loc))
		user = loc
	set_light_on(toggle_on)
	update_action_button_icons()
	update_icon()

/obj/item/flashlight/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, isrightclick = FALSE)
	if(turn_light(xeno_attacker, FALSE) != CHECKS_PASSED)
		return
	playsound(loc, SFX_ALIEN_CLAW_METAL, 25, 1)
	xeno_attacker.do_attack_animation(src, ATTACK_EFFECT_CLAW)
	to_chat(xeno_attacker, span_warning("我们破坏那金属玩意儿的灯.") )

/obj/item/flashlight/update_icon_state()
	. = ..()
	if(light_on)
		icon_state = "[initial(icon_state)]-on"
		worn_icon_state = "[initial(worn_icon_state)]_on"

	else
		icon_state = initial(icon_state)
		worn_icon_state = initial(worn_icon_state)

/obj/item/flashlight/attack_self(mob/user)
	if(!isturf(user.loc))
		to_chat(user, "你在[user.loc]中无法打开灯.")
		return FALSE
	if(activation_sound && (turn_light(user, !light_on) != STILL_ON_COOLDOWN))
		playsound(get_turf(src), activation_sound, 15, 1)
	return TRUE

/obj/item/flashlight/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(!raillight_compatible) //No fancy messages, just no
		return
	if(light_on)
		to_chat(user, span_warning("先关掉[src]."))
		return
	if(loc == user)
		user.dropItemToGround(src) //This part is important to make sure our light sources update, as it calls dropped()
	var/obj/item/attachable/flashlight/F = new(loc)
	user.put_in_hands(F) //This proc tries right, left, then drops it all-in-one.
	to_chat(user, span_notice("你改装了[src].它现在可以安装在武器上."))
	to_chat(user, span_notice("用螺丝刀在[F]上操作可以改回来."))
	qdel(src) //Delete da old flashlight

/obj/item/flashlight/attack(mob/living/M, mob/living/user)
	if(light_on && user.zone_selected == BODY_ZONE_PRECISE_EYES)

		if((user.get_brain_loss() >= 60) && prob(50))	//too dumb to use flashlight properly
			return ..()	//just hit them in the head

		var/mob/living/carbon/human/H = M	//mob has protective eyewear
		if(ishuman(M) && ((H.head && H.head.inventory_flags & COVEREYES) || (H.wear_mask && H.wear_mask.inventory_flags & COVEREYES) || (H.glasses && H.glasses.inventory_flags & COVEREYES)))
			to_chat(user, span_notice("你需要先移除那个[(H.head && H.head.inventory_flags & COVEREYES) ? "helmet" : (H.wear_mask && H.wear_mask.inventory_flags & COVEREYES) ? "mask": "glasses"]."))
			return

		if(M == user)	//they're using it on themselves
			M.flash_act()
			M.visible_message(span_notice("[M]将[src]照向[M.p_their()]的眼睛."), \
								span_notice("你在自己眼前晃动灯光!真迷幻!"))
			return

		user.visible_message(span_notice("[user]将[src]照向[M]的眼睛."), \
							span_notice("你将[src]照向[M]的眼睛."))

		if(ishuman(M))	//robots and aliens are unaffected
			var/mob/living/carbon/C = M
			if(C.stat == DEAD || C.disabilities & BLIND)	//mob is dead or fully blind
				to_chat(user, span_notice("[C]的瞳孔对光线没有反应!"))
			else	//they're okay!
				C.flash_act()
				to_chat(user, span_notice("[C]的瞳孔收缩了."))
	else
		return ..()

/obj/item/flashlight/pen
	name = "笔灯"
	desc = "一种笔大小的灯,供医疗人员使用."
	icon_state = "penlight"
	worn_icon_state = ""
	atom_flags = CONDUCT
	light_range = 2
	w_class = WEIGHT_CLASS_TINY
	raillight_compatible = FALSE

/obj/item/flashlight/drone
	name = "低功率手电筒"
	desc = "一种微型灯,可能供小型机器人使用."
	icon_state = "penlight"
	worn_icon_state = ""
	light_range = 2
	w_class = WEIGHT_CLASS_TINY
	raillight_compatible = FALSE

//The desk lamps are a bit special
/obj/item/flashlight/lamp
	name = "台灯"
	desc = "一种带有可调节支架的台灯."
	icon_state = "lamp"
	worn_icon_state = "lamp"
	light_range = 5
	w_class = WEIGHT_CLASS_BULKY
	light_on = FALSE
	raillight_compatible = FALSE

//Menorah!
/obj/item/flashlight/lamp/menorah
	name = "烛台"
	desc = "用于庆祝光明节."
	icon_state = "menorah"
	worn_icon_state = "menorah"
	light_range = 2
	w_class = WEIGHT_CLASS_BULKY

//Green-shaded desk lamp
/obj/item/flashlight/lamp/green
	desc = "一种经典的绿色灯罩台灯."
	icon_state = "lampgreen"
	worn_icon_state = "lampgreen"
	light_range = 5

/obj/item/flashlight/lamp/verb/toggle_light()
	set name = "Toggle light"
	set category = "IC.Object"
	set src in oview(1)

	if(istype(usr, /mob/living/carbon/xenomorph)) //Sneaky xenos turning off the lights
		attack_alien(usr)
		return

	if(!usr.stat)
		attack_self(usr)

/obj/item/flashlight/lamp/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(xeno_attacker.status_flags & INCORPOREAL)
		return FALSE
	xeno_attacker.do_attack_animation(src, ATTACK_EFFECT_SMASH)
	playsound(loc, 'sound/effects/metalhit.ogg', 20, TRUE)
	xeno_attacker.visible_message(span_danger("\The [xeno_attacker]砸碎了[src]!"), \
	span_danger("我们砸碎了[src]!"), null, 5)
	deconstruct(FALSE)

/obj/item/flashlight/slime
	gender = PLURAL
	name = "发光的黏液"
	desc = "一个发光的球体,看起来像是琥珀."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "floor1" //not a slime extract sprite but... something close enough!
	worn_icon_state = "slime"
	w_class = WEIGHT_CLASS_TINY
	light_range = 6
	light_on = TRUE //Bio-luminesence has one setting, on.
	raillight_compatible = FALSE

/obj/item/flashlight/slime/attack_self(mob/user)
	return //Bio-luminescence does not toggle.

/******************************Lantern*******************************/

/obj/item/flashlight/lantern
	name = "提灯"
	icon_state = "lantern"
	worn_icon_state = "lantern"
	desc = "一种采矿提灯."
	light_range = 6			// luminosity when on
	raillight_compatible = FALSE

/obj/item/flashlight/lantern/on/Initialize(mapload)
	. = ..()
	turn_light(null, TRUE)
