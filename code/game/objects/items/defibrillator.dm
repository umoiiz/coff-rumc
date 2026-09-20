/obj/item/defibrillator
	name = "紧急除颤器"
	desc = "一种能释放强力电击以复苏失去行动能力患者的设备."
	icon = 'icons/obj/items/defibrillator.dmi'
	icon_state = "defib"
	worn_icon_state = "defib"
	atom_flags = CONDUCT
	item_flags = NOBLUDGEON
	equip_slot_flags = ITEM_SLOT_BELT
	force = 5
	throwforce = 6
	w_class = WEIGHT_CLASS_NORMAL
	///If the defibrillator is ready to use (paddles out)
	var/ready = FALSE
	///Whether this defibrillator has to be turned on to use
	var/ready_needed = TRUE
	///Is the defibrillator advanced? Allows to ignore armor while reviving and doesn't damage the heart
	var/advanced = FALSE
	///The base healing number when someone is shocked. Uses `DEFIBRILLATOR_HEALING_TIMES_SKILL` to change based on user skill.
	var/defibrillator_healing = DEFIBRILLATOR_BASE_HEALING_VALUE
	///How much charge is used on a shock
	var/charge_cost = 66
	//the time you need to wait from the moment you click on the patient until it is revived
	var/shock_time = 7 SECONDS
	///The defibrillator's power cell
	var/obj/item/cell/dcell = null
	///Var for quickly creating sparks on shock
	var/datum/effect_system/spark_spread/sparks
	///The cooldown for using the defib, applied to shocking *and* toggling
	COOLDOWN_DECLARE(defib_cooldown)

/obj/item/defibrillator/Initialize(mapload)
	. = ..()
	sparks = new
	sparks.set_up(5, 0, src)
	sparks.attach(src)
	set_dcell(new /obj/item/cell())
	update_icon()

/obj/item/defibrillator/Destroy()
	QDEL_NULL(sparks)
	if(dcell)
		UnregisterSignal(dcell, COMSIG_QDELETING)
		QDEL_NULL(dcell)
	return ..()

/obj/item/defibrillator/update_icon_state()
	icon_state = initial(icon_state)
	if(ready)
		icon_state += "_out"

/obj/item/defibrillator/update_overlays()
	. = ..()
	if(dcell?.charge)
		switch(round(dcell.charge * 100 / dcell.maxcharge))
			if(67 to INFINITY)
				. += "_full"
			if(34 to 66)
				. += "_half"
			if(3 to 33)
				. += "_low"
			if(-INFINITY to 3)
				. += "_empty"
	else // No cell.
		. += "_empty"

/obj/item/defibrillator/examine(mob/user)
	. = ..()
	. += charge_information()

///Returns the amount of charges left and how to recharge the defibrillator.
/obj/item/defibrillator/proc/charge_information(mob/living/carbon/human/user)
	if(!dcell)
		return

	var/message
	message += span_info("其内部电池剩余[round(dcell.charge / charge_cost)]/[round(dcell.maxcharge / charge_cost)]次使用次数.\n")
	if(dcell.charge < charge_cost)
		message += span_alert("电池已耗尽.\n")
	else if(round(dcell.charge * 100 / dcell.maxcharge) <= 33)
		message += span_alert("电池电量低.\n")

	if(!message)
		return
	return "[message]You can click-drag this unit on a corpsman backpack or satchel to recharge it."

/obj/item/defibrillator/attack_self(mob/living/carbon/human/user)
	if(!ready_needed)
		return
	if(!istype(user))
		return

	//Job knowledge requirement
	var/skill = user.skills.getRating(SKILL_MEDICAL)
	if(skill < SKILL_MEDICAL_PRACTICED)
		user.visible_message(span_notice("[user]笨手笨脚地摸索着如何使用[src]."),
		span_notice("你笨手笨脚地摸索着如何使用[src]."))
		if(!do_after(user, SKILL_TASK_AVERAGE - (SKILL_TASK_VERY_EASY * skill), NONE, src, BUSY_ICON_UNSKILLED))
			return

	ready = !ready
	user.visible_message(span_notice("[user]将[src][ready? "on and opens the cover" : "off and closes the cover"]."),
	span_notice("你将[src][ready? "on and open the cover" : "off and close the cover"]."))
	playsound(get_turf(src), SFX_SPARKS, 25, TRUE, 4)
	if(ready)
		playsound(get_turf(src), 'sound/items/defib_safetyOn.ogg', 45, 0)
	else
		playsound(get_turf(src), 'sound/items/defib_safetyOff.ogg', 45, 0)
	update_icon()

///Wrapper to guarantee powercells are properly nulled and avoid hard deletes.
/obj/item/defibrillator/proc/set_dcell(obj/item/cell/new_cell)
	if(dcell)
		UnregisterSignal(dcell, COMSIG_QDELETING)
	dcell = new_cell
	if(dcell)
		RegisterSignal(dcell, COMSIG_QDELETING, PROC_REF(on_cell_deletion))

///Called by the deletion of the referenced powercell.
/obj/item/defibrillator/proc/on_cell_deletion(obj/item/cell/source, force)
	SIGNAL_HANDLER
	stack_trace("Powercell deleted while powering the defib, this isn't supposed to happen normally.")
	set_dcell(null)

/obj/item/defibrillator/attack(mob/living/carbon/human/patient, mob/living/carbon/human/user)
	defibrillate(patient,user)

///Proc for checking that the defib is ready to operate
/obj/item/defibrillator/proc/defib_ready(mob/living/carbon/human/patient, mob/living/carbon/human/user)
	if(!ready)
		balloon_alert(user, "取出电极板")
		return FALSE
	if(!ishuman(patient))
		to_chat(user, span_warning("[src]上的说明没有提到如何复苏那种东西..."))
		return FALSE
	if(patient.stat != DEAD)
		user.visible_message(span_warning("[icon2html(src, viewers(user))]\The [src]发出蜂鸣:患者不处于有效状态.操作已中止."))
		return FALSE
	if(patient.wear_suit && (patient.wear_suit.atom_flags & CONDUCT && !advanced)) // something conductive on their chest
		user.visible_message(span_warning("[icon2html(src, viewers(user))]\The [src]发出蜂鸣:电极板检测到电阻大于100,000欧姆.请移除干扰性的服装或护甲后重试."))
		return FALSE
	return TRUE

///Split proc that actually does the defibrillation. Separated to be used more easily by medical gloves
/obj/item/defibrillator/proc/defibrillate(mob/living/carbon/human/patient, mob/living/carbon/human/user)
	if(user.do_actions) //Currently doing something
		balloon_alert(user, "忙碌")
		return

	if(!COOLDOWN_FINISHED(src, defib_cooldown))
		balloon_alert(user, "充电中")
		return

	//job knowledge requirement
	var/medical_skill = user.skills.getRating(SKILL_MEDICAL)
	if(medical_skill < SKILL_MEDICAL_PRACTICED)
		user.visible_message(span_notice("[user]笨手笨脚地摸索着如何使用[src]."),
		span_notice("你笨拙地摸索着如何使用[src]。"))
		var/fumbling_time = SKILL_TASK_AVERAGE - (SKILL_TASK_VERY_EASY * medical_skill) // 3 seconds with medical skill, 5 without
		if(!do_after(user, fumbling_time, NONE, patient, BUSY_ICON_UNSKILLED))
			return

	var/defib_heal_amt = DEFIBRILLATOR_HEALING_TIMES_SKILL(medical_skill, defibrillator_healing)

	if(dcell.charge <= charge_cost)
		user.visible_message(span_warning("[icon2html(src, viewers(user))] \The [src] 嗡嗡作响:内部电池耗尽。请寻找充电器。无法分析或施加电击。"))
		to_chat(user, span_boldwarning("你可以通过将除颤器拖放到医疗兵的背包或挎包上来充电,或者将其放入充电器中。"))
		return

	if(!defib_ready(patient, user))
		return

	var/fail_reason
	switch(patient.check_defib())
		// A special bit for preventing the defib do_after if they can't come back
		// This will be ran again after shocking just in case their status changes
		if(DEFIB_FAIL_DECAPITATED)
			if(patient.species.species_flags & DETACHABLE_HEAD) // special message for synths/robots missing their head
				fail_reason = "Patient is missing their head. Reattach and try again."
			else
				fail_reason = "Patient is missing their head. Further attempts futile."
		if(DEFIB_FAIL_BRAINDEAD)
			fail_reason = "Patient's general condition does not allow revival. Further attempts futile."
	if(fail_reason)
		user.visible_message(span_warning("[icon2html(src, viewers(user))] \The [src] 嗡嗡作响:无法复苏 - [fail_reason]"))
		return

	var/mob/dead/observer/ghost = patient.get_ghost()
	// For robots, we want to use the more relaxed bitmask as we are doing this before their IMMEDIATE_DEFIB trait is handled and they might
	// still be unrevivable because of too much damage.
	var/alerting_ghost = isrobot(patient) ? (patient.check_defib() & DEFIB_REVIVABLE_STATES) : (patient.check_defib(issynth(patient) ? 0 : DEFIBRILLATOR_HEALING_TIMES_SKILL(user.skills.getRating(SKILL_MEDICAL), defibrillator_healing)) == DEFIB_POSSIBLE)
	if(ghost && alerting_ghost)
		notify_ghost(ghost, assemble_alert(
			title = "复苏!",
			message = "有人正试图复活你的身体!如果你想复活,请留在体内!",
			color_override = "purple"
		), ghost_sound = 'sound/effects/gladosmarinerevive.ogg')
		ghost.reenter_corpse()

	user.visible_message(span_notice("[user] 开始将电极板放置在 [patient] 的胸口。"),
	span_notice("你开始将电极板放置在 [patient] 的胸口。"))
	playsound(get_turf(src),'sound/items/defib_charge.ogg', 45, 0) // Don't vary this, it should be exactly 7 seconds

	if(!do_after(user, shock_time, NONE, patient, BUSY_ICON_FRIENDLY, BUSY_ICON_MEDICAL))
		to_chat(user, span_warning("你停止将电极板放置在 [patient] 的胸口。"))
		return

	if(!defib_ready(patient, user)) // we're doing this again just in case something has changed
		return

	// do the defibrillation effects now and check revive parameters in a moment
	. = TRUE
	sparks.start()
	dcell.use(charge_cost)
	update_icon()
	playsound(get_turf(src), 'sound/items/defib_release.ogg', 45, 1)
	user.visible_message(span_notice("[user] 用电极板电击了 [patient]。"),
	span_notice("你用电极板电击了 [patient]。"))
	patient.visible_message(span_warning("[patient] 的身体抽搐了一下。"))

	COOLDOWN_START(src, defib_cooldown, DEFIBRILLATOR_COOLDOWN)

	var/datum/internal_organ/heart/heart = patient.get_organ_slot(ORGAN_SLOT_HEART)
	if(!issynth(patient) && !isrobot(patient) && heart && prob(90) && !advanced)
		heart.take_damage(5) //Allow the defibrillator to possibly worsen heart damage. Still rare enough to just be the "clone damage" of the defib

	//At this point, the defibrillator is ready to work
	//this trait allows some species to be healed to one hit from death, so the defibrillator can't fail from too much damage
	if(HAS_TRAIT(patient, TRAIT_IMMEDIATE_DEFIB))
		patient.set_oxy_loss(0)
		patient.update_health()

		var/heal_target = patient.get_death_threshold() - patient.health + 1
		var/all_loss = patient.get_brute_loss() + patient.get_fire_loss() + patient.get_tox_loss()
		if(all_loss && (heal_target > 0))
			var/brute_ratio = patient.get_brute_loss() / all_loss
			var/burn_ratio = patient.get_fire_loss() / all_loss
			var/tox_ratio = patient.get_tox_loss() / all_loss
			if(tox_ratio)
				patient.adjust_tox_loss(-(tox_ratio * heal_target))
			patient.heal_overall_damage(brute_ratio*heal_target, burn_ratio * heal_target, TRUE) // explicitly also heals robot parts

	else if(!issynth(patient)) // TODO make me a trait :)
		patient.adjust_brute_loss(-defib_heal_amt)
		patient.adjust_fire_loss(-defib_heal_amt)
		patient.adjust_tox_loss(-defib_heal_amt)
		patient.set_oxy_loss(0)

	patient.update_health() // update health because it won't always update for the dead

	fail_reason = null // Clear the fail reason as we check again
	// We're keeping permadeath states from earlier here in case something changes mid revive
	switch(patient.check_defib())
		if(DEFIB_FAIL_DECAPITATED)
			if(patient.species.species_flags & DETACHABLE_HEAD) // special message for synths/robots missing their head
				fail_reason = "Patient is missing their head. Reattach and try again."
			else
				fail_reason = "Patient is missing their head. Further attempts futile."
		if(DEFIB_FAIL_BRAINDEAD)
			fail_reason = "Patient's general condition does not allow revival. Further attempts futile."
		if(DEFIB_FAIL_BAD_ORGANS)
			fail_reason = "Patient's heart is too damaged to sustain life. Surgical intervention required."
		if(DEFIB_FAIL_TOO_MUCH_DAMAGE)
			fail_reason = "Vital signs are weak. Repair damage and try again."

	if(fail_reason)
		user.visible_message(span_warning("[icon2html(src, viewers(user))] \The [src] 嗡嗡作响:复苏失败 - [fail_reason]"))
		playsound(src, 'sound/items/defib_failed.ogg', 45, FALSE)
		return

	ghost = patient.get_ghost(TRUE)
	if(ghost)
		ghost.reenter_corpse()

	if(!patient.client)
		user.visible_message(span_warning("[icon2html(src, viewers(user))] \The [src] 嗡嗡作响:未检测到灵魂。"))

	to_chat(patient, span_notice("<i><font size=4>你突然感到一阵火花,你的意识回归了,将你拖回了凡间...</font></i>"))
	user.visible_message(span_notice("[icon2html(src, viewers(user))] \The [src] 发出提示音:复苏成功。"))
	playsound(get_turf(src), 'sound/items/defib_success.ogg', 45, 0)
	patient.update_health()
	patient.resuscitate() // time for a smoke
	patient.emote("gasp")
	patient.flash_act()
	patient.apply_effect(10, EFFECT_EYE_BLUR)
	patient.apply_effect(20 SECONDS, EFFECT_UNCONSCIOUS)

	ghost = patient.get_ghost(TRUE) // just in case they re-entered their body
	if(ghost) // register a signal to bring them into their body on reconnect
		ghost.RegisterSignal(ghost, COMSIG_MOB_LOGIN, TYPE_PROC_REF(/mob/dead/observer, revived_while_away))

	//Checks if the patient is wearing a camera. Then it turns it on if it's off.
	if(istype(patient.wear_ear, /obj/item/radio/headset/mainship))
		var/obj/item/radio/headset/mainship/cam_headset = patient.wear_ear
		if(!(cam_headset?.camera?.status))
			cam_headset.camera.toggle_cam(null, FALSE)
	if(user.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
		personal_statistics.revives++
	GLOB.round_statistics.total_human_revives[patient.faction]++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "total_human_revives[patient.faction]")

	if(CHECK_BITFIELD(patient.status_flags, XENO_HOST))
		var/obj/item/alien_embryo/friend = locate() in patient
		START_PROCESSING(SSobj, friend)

	notify_ghosts("<b>[user]</b> has brought <b>[patient.name]</b> back to life!", source = patient, action = NOTIFY_ORBIT)

/obj/item/defibrillator/civi
	name = "应急除颤器"
	desc = "一种通过强力电击来复苏失去行动能力患者的设备。这个似乎是民用型号。"
	icon_state = "civ_defib"
	worn_icon_state = "defib"

///used for advanced medical (defibrillator) gloves: defibrillator_gloves.dm
/obj/item/defibrillator/internal
	icon = 'icons/obj/clothing/gloves.dmi' //even though you'll never see this directly, it shows up in the chat panel due to icon2html
	ready = TRUE
	ready_needed = FALSE
	advanced = TRUE
	///Parent item containing this defib
	var/obj/parent_obj

/obj/item/defibrillator/internal/Initialize(mapload, obj/new_parent)
	if(!istype(new_parent))
		return INITIALIZE_HINT_QDEL
	parent_obj = new_parent
	return ..()

/obj/item/defibrillator/internal/Destroy()
	parent_obj = null
	return ..()

/obj/item/defibrillator/internal/update_icon()
	. = ..()
	parent_obj.update_icon()

/obj/item/defibrillator/advanced
	name = "高级应急除颤器"
	desc = "一种通过强力电击来复苏失去行动能力患者的设备。可以忽略护甲、覆盖心脏,并且不会损坏心脏本身,代价是增加电量消耗。"
	icon_state = "civ_defib"
	charge_cost = 100
	advanced = TRUE

/obj/item/defibrillator/compact
	equip_slot_flags = ITEM_SLOT_POCKET
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "pocket_defib" //спасибо tarsonis_raff и lorddeferson за иконку
	charge_cost = 250
	defibrillator_healing = 2
	shock_time = 3 SECONDS
