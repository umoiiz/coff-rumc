// Notify all preds with the bracer icon
/proc/message_all_yautja(msg, soundeffect = TRUE)
	for(var/mob/living/carbon/human/Y in GLOB.yautja_mob_list)
		// Send message to the bracer; appear multiple times if we have more bracers
		for(var/obj/item/clothing/gloves/yautja/hunter/G in Y.contents)
			to_chat(Y, span_yautjabold("[icon2html(G)]\The <b>[G]</b>发出哔哔声:[msg]"))
			if(G.notification_sound)
				playsound(Y.loc, 'sound/items/pred_bracer.ogg', 75, 1)

/mob/living/carbon/human/proc/message_thrall(msg)
	if(!hunter_data.thrall)
		return

	var/mob/living/carbon/T = hunter_data.thrall

	for(var/obj/item/clothing/gloves/yautja/hunter/G in T.contents)
		to_chat(T, span_yautjabold("[icon2html(G)]\The <b>[G]</b>发出哔哔声:[msg]"))
		if(G.notification_sound)
			playsound(T.loc, 'sound/items/pred_bracer.ogg', 75, 1)

//Update the power display thing. This is called in Life()
/mob/living/carbon/human/proc/update_power_display(perc)
	if(hud_used?.pred_power_icon)
		switch(perc)
			if(91 to INFINITY)
				hud_used.pred_power_icon.icon_state = "powerbar100"
			if(81 to 91)
				hud_used.pred_power_icon.icon_state = "powerbar90"
			if(71 to 81)
				hud_used.pred_power_icon.icon_state = "powerbar80"
			if(61 to 71)
				hud_used.pred_power_icon.icon_state = "powerbar70"
			if(51 to 61)
				hud_used.pred_power_icon.icon_state = "powerbar60"
			if(41 to 51)
				hud_used.pred_power_icon.icon_state = "powerbar50"
			if(31 to 41)
				hud_used.pred_power_icon.icon_state = "powerbar40"
			if(21 to 31)
				hud_used.pred_power_icon.icon_state = "powerbar30"
			if(11 to 21)
				hud_used.pred_power_icon.icon_state = "powerbar20"
			else
				hud_used.pred_power_icon.icon_state = "powerbar10"

/mob/living/carbon/human/proc/butcher()
	set category = "Yautja"
	set name = "Butcher"
	set desc = "Butcher a corpse you're standing on for its tasty meats."

	if(stat || (lying_angle && !resting && !has_status_effect(STATUS_EFFECT_SLEEPING)) || (has_status_effect(STATUS_EFFECT_PARALYZED) || has_status_effect(STATUS_EFFECT_UNCONSCIOUS)) || lying_angle || buckled)
		return

	var/list/choices = list()
	for(var/mob/living/carbon/M in view(1, src) - src)
		if(Adjacent(M) && M.stat == DEAD)
			if(ishuman(M))
				var/mob/living/carbon/human/Q = M
				if(Q.species && species && Q.species.name == species.name)
					continue
			choices += M

	var/mob/living/carbon/T = tgui_input_list(src, "你想肢解什么?", "肢解", choices)

	var/mob/living/carbon/xenomorph/xeno_victim
	var/mob/living/carbon/human/victim

	if(!T || !src || !T.stat)
		to_chat(src, span_warning("不."))
		return

	if(!Adjacent(T))
		to_chat(src, span_warning("你必须靠近你的目标."))
		return

	if(isxenolarva(T) || isxenofacehugger(T))
		to_chat(src, span_warning("这条小虫子甚至不值得你使用工具."))
		return

	if(stat || (lying_angle && !resting && !has_status_effect(STATUS_EFFECT_SLEEPING)) || (has_status_effect(STATUS_EFFECT_PARALYZED) || has_status_effect(STATUS_EFFECT_UNCONSCIOUS)) || lying_angle || buckled)
		return

	if(isxeno(T))
		xeno_victim = T

	else if(ishuman(T))
		victim = T

		if(issynth(T) || isrobot(T) || victim.species.species_flags & ROBOTIC_LIMBS)
			to_chat(src, span_warning("如果你这么做会弄坏你的工具!"))
			return

	var/static/list/procedure_choices = list(
		"Skin" = null,
		"Behead" = "head",
		"Delimb - Right Hand" = "r_hand",
		"Delimb - Left Hand" = "l_hand",
		"Delimb - Right Arm" = "r_arm",
		"Delimb - Left Arm" = "l_arm",
		"Delimb - Right Foot" = "r_foot",
		"Delimb - Left Foot" = "l_foot",
		"Delimb - Right Leg" = "r_leg",
		"Delimb - Left Leg" = "l_leg",
	)

	var/procedure = ""

	if(victim)
		procedure = tgui_input_list(src, "你想切下哪一块?", "切下肉块", procedure_choices)
		if(!procedure)
			return

	if(isxeno(T) || procedure == "Skin")
		if(T.butchery_progress)
			playsound(loc, 'sound/weapons/pierce.ogg', 25)
			visible_message(span_danger("[src]回去继续肢解\the [T]."), span_notice("你回去继续肢解\the [T]."))
		else
			playsound(loc, 'sound/weapons/pierce.ogg', 25)
			visible_message(span_danger("[src]开始砍剁并残害\the [T]."), span_notice("你拿出你的工具,开始对\the [T]进行你那令人毛骨悚然的工作.别动."))
			T.butchery_progress = 1

		if(T.butchery_progress == 1)
			if(do_after(src, 7 SECONDS, NONE, src, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
				visible_message(span_danger("[src]仔细地切开并扯出\the [T]腹腔中的内脏."), span_notice("你仔细地活体解剖\the [T],扯出肠子和无用的器官.真臭!"))
				T.butchery_progress = 2
				playsound(loc, 'sound/weapons/slash.ogg', 25)
			else
				to_chat(src, span_notice("你暂停肢解,留待稍后继续."))

		if(T.butchery_progress == 2)
			if(do_after(src, 6.5 SECONDS, NONE, src, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
				visible_message(span_danger("[src]砍下\the [T]的四肢,并切下一片片滴血的肉."), span_notice("你切下\the [T]的几块肢体,确保切下最好的部分."))
				if(xeno_victim && isturf(xeno_victim.loc))
					var/obj/item/reagent_containers/food/snacks/meat/xenomeat = new /obj/item/reagent_containers/food/snacks/meat/xenomeat(T.loc)
					xenomeat.name = "raw [xeno_victim.xeno_caste.upgrade_name][xeno_victim.xeno_caste.display_name] steak"
				else if(victim && isturf(victim.loc))
					victim.apply_damage(100, BRUTE, pick("r_leg", "l_leg", "r_arm", "l_arm"), FALSE, TRUE) //Basically just rips off a random limb.
					var/obj/item/reagent_containers/food/snacks/meat/meat = new /obj/item/reagent_containers/food/snacks/meat(victim.loc)
					meat.name = "raw [victim.name] steak"
				T.butchery_progress = 3
				playsound(loc, 'sound/weapons/bladeslice.ogg', 25)
			else
				to_chat(src, span_notice("你暂停肢解,留待稍后继续."))

		if(T.butchery_progress == 3)
			if(do_after(src, 7 SECONDS, NONE, src, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
				visible_message(span_danger("[src]撕开\the [T]的胸腔,开始一块块砍下."), span_notice("你撕开\the [T]的胸腔,开始扯出最美味的部分."))
				if(xeno_victim && isturf(xeno_victim.loc))
					var/obj/item/reagent_containers/food/snacks/meat/xenomeat = new /obj/item/reagent_containers/food/snacks/meat/xenomeat(T.loc)
					xenomeat.name = "raw [xeno_victim.xeno_caste.upgrade_name][xeno_victim.xeno_caste.display_name] tenderloin"
				else if(victim && isturf(T.loc))
					var/obj/item/reagent_containers/food/snacks/meat/meat = new /obj/item/reagent_containers/food/snacks/meat(victim.loc)
					meat.name = "raw [victim.name] tenderloin"
					victim.apply_damage(100, BRUTE,"chest", FALSE, FALSE)
				T.butchery_progress = 4
				playsound(loc, 'sound/weapons/wristblades_hit.ogg', 25)
			else
				to_chat(src, span_notice("你暂停肢解,留待稍后继续."))

		if(T.butchery_progress == 4)
			if(do_after(src, 9 SECONDS, NONE, src, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
				if(xeno_victim && isturf(T.loc))
					visible_message(span_danger("[src]剥下[victim]最后的外骨骼,只露出骨头!"), span_notice("你剥下[victim]最后的外骨骼,清理干净!"))
					new /obj/effect/decal/remains/xeno(xeno_victim.loc)
					var/obj/item/stack/sheet/animalhide/xeno/xenohide = new /obj/item/stack/sheet/animalhide/xeno(xeno_victim.loc)
					xenohide.name = "[xeno_victim.xeno_caste.upgrade_name][xeno_victim.xeno_caste.display_name]-hide"
					xenohide.singular_name = "[xeno_victim.xeno_caste.upgrade_name][xeno_victim.xeno_caste.display_name]-hide"
					xenohide.merge_type = "[xeno_victim.xeno_caste.upgrade_name][xeno_victim.xeno_caste.display_name]-hide"
				else if(victim && isturf(T.loc))
					visible_message(span_danger("[src]伸手扯出\the [T]的脊髓和头骨!"), span_notice("你紧紧抓住露出的脊柱,扯下[T]的头!"))
					var/datum/limb/head_limb = victim.get_limb("head")
					if(!(head_limb.limb_status & LIMB_DESTROYED))
						victim.apply_damage(150, BRUTE, "head", FALSE, TRUE)
						var/obj/item/armor_module/limb/skeleton/head/spine/new_spine = new /obj/item/armor_module/limb/skeleton/head/spine(victim.loc)
						new_spine.name = "[victim]'s spine"
					else
						var/obj/item/reagent_containers/food/snacks/meat/meat = new /obj/item/reagent_containers/food/snacks/meat(victim.loc)
						meat.name = "raw [victim.real_name] steak"
						new /obj/item/armor_module/limb/skeleton/torso(victim.loc)
					var/obj/item/stack/sheet/animalhide/human/hide = new /obj/item/stack/sheet/animalhide/human(victim.loc)
					hide.name = "[victim.name]-hide"
					hide.singular_name = "[victim.name]-hide"
					new /obj/effect/decal/remains/human(T.loc)
				T.butchery_progress = 5 //Won't really matter.
				playsound(loc, 'sound/weapons/slice.ogg', 25)
				if(hunter_data.prey == T)
					to_chat(src, span_yautjabold("你已将[T]据为你的战利品."))
					emote("roar2")
					message_all_yautja("[src.real_name] has claimed [T] as their trophy.")
					hunter_data.prey = null
				else
					to_chat(src, span_notice("你完成了肢解!"))
				qdel(T)
			else
				to_chat(src, span_notice("你暂停肢解,留待稍后继续."))
	else
		var/limb = procedure_choices[procedure]
		var/limbName = parse_zone(limb)
		var/datum/limb/limb_datum = victim.get_limb(limb)
		if(limb_datum.limb_status & LIMB_DESTROYED)
			to_chat(src, span_warning("受害者缺少[limbName]."))
			return
		if(limb_datum.name == "head")
			visible_message("<b>[src]伸手开始斩首[T].</b>","<b>你伸手开始斩首[T].</b>")
		else
			visible_message("<b>[src]伸手开始摘除[T]的[limbName].</b>","<b>你伸手开始摘除[T]的[limbName].</b>")
		if(do_after(src, 9 SECONDS, NONE, src, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
			if(limb_datum.limb_status & LIMB_DESTROYED)
				to_chat(src, span_warning("受害者缺少[limbName]."))
				return
			limb_datum.drop_limb(TRUE, FALSE, "butchering")
			playsound(loc, 'sound/weapons/slice.ogg', 25)
			if(hunter_data.prey == T)
				to_chat(src, span_yautjabold("你已将[T]据为你的战利品."))
				emote("roar2")
				message_all_yautja("[src.real_name] has claimed [T] as their trophy.")
				hunter_data.prey = null
			else
				to_chat(src, span_notice("你完成了肢解!"))

/area/yautja
	name = "\improper Yautja Ship"
	icon_state = "teleporter"
	ceiling = CEILING_METAL
	requires_power = FALSE
	static_lighting = FALSE
	base_lighting_alpha = 255
