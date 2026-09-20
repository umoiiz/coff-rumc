/obj/item/reagent_containers/hypospray
	name = "注射器"
	desc = "注射器是一种无菌、无针可重复使用的自动注射器, 可为患者快速注射可自定义剂量的药物."
	icon = 'icons/obj/items/syringe.dmi'
	worn_icon_state = "hypo"
	icon_state = "hypo"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(1, 3, 5, 10, 15, 20, 30, 60, 120)
	volume = 120
	reagent_flags = OPENCONTAINER
	equip_slot_flags = ITEM_SLOT_BELT
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	var/skilllock = 1
	var/inject_mode = HYPOSPRAY_INJECT_MODE_INJECT
	var/core_name = "hypospray"
	///If we add a custom label, our name becomes "[core_name] ([label])"
	var/label = null
	/// Small description appearing as an overlay
	var/description_overlay = ""

/obj/item/reagent_containers/hypospray/proc/empty(mob/user)
	if(tgui_alert(user, "你确定要清空[src]吗?", "冲洗[src]:", list("Yes", "No")) != "Yes")
		return
	if(isturf(user.loc))
		user.balloon_alert(user, "冲洗注射器.")
		reagents.reaction(user.loc)
		reagents.clear_reagents()

/obj/item/reagent_containers/hypospray/afterattack(atom/A, mob/living/user)
	if(!istype(user))
		return FALSE
	if(!in_range(A, user) || !user.Adjacent(A))
		return FALSE

	//For drawing reagents, will check if it's possible to draw, then draws.
	if(inject_mode == HYPOSPRAY_INJECT_MODE_DRAW)
		can_draw_reagent(A, user, FALSE)
		return

	if(!reagents.total_volume)
		balloon_alert(user, "注射器是空的.")
		return
	if(!A.is_injectable() && !ismob(A))
		return
	if(skilllock && user.skills.getRating(SKILL_MEDICAL) < SKILL_MEDICAL_NOVICE)
		user.visible_message(span_notice("[user]笨手笨脚地摸索着如何使用[src]."),
		span_notice("你笨手笨脚地摸索着如何使用[src]."))
		if(!do_after(user, SKILL_TASK_EASY, NONE, A, BUSY_ICON_UNSKILLED) || (!in_range(A, user) || !user.Adjacent(A)))
			return
	if(ismob(A))
		var/mob/M = A
		if(!M.can_inject(user, TRUE, user.zone_selected, TRUE))
			return
		if(M.faction != user.faction && !M.incapacitated())
			user.visible_message(span_notice("[user]试图用[src]注射[M]."),
			span_notice("你试图用[src]注射[M]."))
			if(!do_after(user, SKILL_TASK_VERY_EASY, NONE, A, BUSY_ICON_HOSTILE) || (!in_range(A, user) || !user.Adjacent(A)))
				return

	var/list/injected = list()
	for(var/datum/reagent/R in reagents.reagent_list)
		injected += R.name
	log_combat(user, A, "injected", src, "Reagents: [english_list(injected)]")

	if(ismob(A))
		var/mob/M = A
		balloon_alert(user, "注射[M]")
		to_chat(M, span_warning("你感到一阵轻微的刺痛!")) // inject self doubleposting
		record_reagent_consumption(min(amount_per_transfer_from_this, reagents.total_volume), injected, user, M)

	// /mob/living/carbon/human/attack_hand causes
	// changeNext_move(7) which creates a delay
	// This line overrides the delay, and will absolutely break everything
	user.changeNext_move(3) // please don't break the game

	playsound(loc, 'sound/items/hypospray.ogg', 50, 1)
	reagents.reaction(A, INJECT, min(amount_per_transfer_from_this, reagents.total_volume) / reagents.total_volume)
	var/trans = reagents.trans_to(A, amount_per_transfer_from_this)
	to_chat(user, span_notice("注射了[trans]单位. [src]中剩余[reagents.total_volume]单位.")) // better to not balloon
	return TRUE

/obj/item/reagent_containers/hypospray/afterattack_alternate(atom/A, mob/living/user)
	if(!istype(user))
		return FALSE
	if(!in_range(A, user) || !user.Adjacent(A)) //So we arent drawing reagent from a container behind a window
		return FALSE
	can_draw_reagent(A, user, TRUE) //Always draws reagents on right click

///If it's possible to draw from something. Will draw_blood() when targetting a carbon, or draw_reagent() when targetting a non-carbon
/obj/item/reagent_containers/hypospray/proc/can_draw_reagent(atom/A, mob/living/user)
	if(!A.reagents)
		return FALSE
	if(reagents.holder_full())
		balloon_alert(user, "注射器是满的.")
		inject_mode = HYPOSPRAY_INJECT_MODE_INJECT
		update_icon() //So we now display as Inject
		return FALSE
	if(!A.reagents.total_volume)
		balloon_alert(user, "注射器是空的.")
		return
	if(!A.is_drawable())
		balloon_alert(user, "无法移除试剂.")
		return

	if(iscarbon(A))
		draw_blood(A, user)
		return TRUE

	if(isobj(A)) //if not mob
		draw_reagent(A, user)
		return TRUE

///Checks if the carbon has blood, then tries to draw blood from it
/obj/item/reagent_containers/hypospray/proc/draw_blood(atom/A, mob/living/user)
	var/amount = min(reagents.maximum_volume - reagents.total_volume, amount_per_transfer_from_this)
	var/mob/living/carbon/C = A
	if(C.get_blood_id() && reagents.has_reagent(C.get_blood_id()))
		balloon_alert(user, "已经有血样了.")
		return
	if(!C.blood_type)
		balloon_alert(user, "找不到血液.")
		return
	if(C.blood_volume <= BLOOD_VOLUME_SURVIVE)
		balloon_alert(user, "没有血液可抽取.")
		return
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(H.species.species_flags & NO_BLOOD)
			balloon_alert(user, "找不到血液.")
			return
		else
			C.take_blood(src,amount)
	else
		C.take_blood(src,amount)
	reagents.handle_reactions()
	user.visible_message("<span clas='warning'>[user]从[A]身上抽取了血样.</span>",
						span_notice("你从[A]身上抽取了一份血样."), null, 4)
	on_reagent_change()

///Checks if a container is drawable, then draw reagents from the container
/obj/item/reagent_containers/hypospray/proc/draw_reagent(atom/A, mob/living/user)
	var/trans = A.reagents.trans_to(src, amount_per_transfer_from_this)
	balloon_alert(user, "填充[trans]单位.")

	on_reagent_change()

/obj/item/reagent_containers/hypospray/on_reagent_change()
	if(reagents.holder_full())
		inject_mode = HYPOSPRAY_INJECT_MODE_INJECT
	update_icon()

/obj/item/reagent_containers/hypospray/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	update_icon()

/obj/item/reagent_containers/hypospray/on_enter_storage(mob/user, slot)
	. = ..()
	update_icon()

/obj/item/reagent_containers/hypospray/pickup(mob/user)
	. = ..()
	update_icon()

/obj/item/reagent_containers/hypospray/dropped(mob/user)
	. = ..()
	update_icon()

/obj/item/reagent_containers/hypospray/update_overlays()
	. = ..()
	if(isturf(loc) || !description_overlay)
		return
	var/mutable_appearance/desc = mutable_appearance('icons/misc/12x12.dmi')
	desc.pixel_w = 16
	desc.maptext = MAPTEXT(description_overlay)
	desc.maptext_width = 16
	. += desc

/obj/item/reagent_containers/hypospray/unique_action(mob/user, special_treatment)
	ui_interact(user)

/obj/item/reagent_containers/hypospray/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Hypospray", name)
		ui.open()

/obj/item/reagent_containers/hypospray/ui_data(mob/user)
	var/list/data = list()

	data["IsAdvanced"] = liquifier
	data["InjectMode"] = inject_mode
	data["CurrentLabel"] = label
	data["CurrentTag"] = description_overlay
	data["TransferAmount"] = amount_per_transfer_from_this

	return data

/obj/item/reagent_containers/hypospray/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("ActivateAutolabeler")
			var/mob/user = usr
			var/str = copytext(reject_bad_text(tgui_input_text(user,"喷雾注射器标签文本?", "设置标签", "", MAX_NAME_LEN, timeout = 0)), 1, MAX_NAME_LEN)
			if(!length(str))
				user.balloon_alert(user, "无效文本.")
				return
			balloon_alert(user, "已标记为\"[str]\".")
			name = "[core_name] ([str])"
			label = str

		if("ActivateTagger")
			var/mob/user = usr
			var/str = copytext(reject_bad_text(tgui_input_text(user,"喷雾注射器标记文本?", "设置标记", "", MAX_NAME_HYPO, timeout = 0)), 1, MAX_NAME_HYPO)
			if(!length(str))
				user.balloon_alert(user, "无效文本.")
				return
			user.balloon_alert(user, "你将[src]标记为\"[str]\".")
			description_overlay = str
			update_icon()

		if("ToggleMode")
			if(inject_mode)
				to_chat(usr, span_notice("[src]已设置为抽取模式. 现在将抽取试剂."))

			else
				to_chat(usr, span_notice("[src]已设置为注射模式. 现在将注射试剂."))
			inject_mode = !inject_mode
			update_icon()

		if("SetTransferAmount")
			var/N = tgui_input_list(usr, "每次转移量:", "[src]", possible_transfer_amounts)
			if(!N)
				return

			amount_per_transfer_from_this = N

		if("EmptyHypospray")
			empty(usr)

/obj/item/reagent_containers/hypospray/advanced
	name = "高级喷雾注射器"
	desc = "喷雾注射器是一种无菌, 无针可重复使用的自动注射器, 用于快速向患者给药, 剂量可自定义. 配备内置试剂分析仪, 数字标签器和2字母标记器. 很方便."
	core_name = "hypospray"
	icon_state = "hypo"
	reagent_flags = REFILLABLE|DRAINABLE
	liquifier = TRUE

/obj/item/reagent_containers/hypospray/advanced/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(action == "DisplayReagentContent")
		to_chat(usr, display_reagents())
		return TRUE

/obj/item/reagent_containers/hypospray/advanced/update_icon_state()
	. = ..()
	if(!reagents?.total_volume)
		icon_state = "[initial(icon_state)]_0"
		return
	var/percent = round((reagents.total_volume / volume) * 100)
	switch(percent)
		if(0 to 9)
			icon_state = initial(icon_state)
		if(10 to 24)
			icon_state = "[initial(icon_state)]_10"
		if(25 to 49)
			icon_state = "[initial(icon_state)]_25"
		if(50 to 64)
			icon_state = "[initial(icon_state)]_50"
		if(65 to 79)
			icon_state = "[initial(icon_state)]_65"
		if(80 to 90)
			icon_state = "[initial(icon_state)]_80"
		if(91 to INFINITY)
			icon_state = "[initial(icon_state)]_100"

/obj/item/reagent_containers/hypospray/advanced/update_overlays()
	. = ..()

	if(reagents?.total_volume)
		var/image/filling = image('icons/obj/reagentfillings.dmi', src, "[icon_state]10")

		var/percent = round((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0 to 9)
				filling.icon_state = "[initial(icon_state)]-10"
			if(10 to 24)
				filling.icon_state = "[initial(icon_state)]10"
			if(25 to 49)
				filling.icon_state = "[initial(icon_state)]25"
			if(50 to 64)
				filling.icon_state = "[initial(icon_state)]50"
			if(65 to 79)
				filling.icon_state = "[initial(icon_state)]65"
			if(80 to 90)
				filling.icon_state = "[initial(icon_state)]80"
			if(91 to INFINITY)
				filling.icon_state = "[initial(icon_state)]100"

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		. += filling

	if(ismob(loc))
		var/injoverlay
		switch(inject_mode)
			if(HYPOSPRAY_INJECT_MODE_DRAW)
				injoverlay = "draw"
			if(HYPOSPRAY_INJECT_MODE_INJECT)
				injoverlay = "inject"
		. += injoverlay

/obj/item/reagent_containers/hypospray/advanced/examine(mob/user as mob)
	. = ..()
	if(get_dist(user,src) > 2)
		. += span_warning("你离得太远, 看不到[src]的试剂显示!")
		return

	. += "" // for some weird reason, without this lower lines get in line with item's size line
	. += display_reagents(user)
	. += span_warning("<b>使用</b>注射到自己体内. <b>独特动作</b>来配置注射量.")

/// The proc display_reagents controls the information utilised in the hypospray menu/. Specifically how much of a chem there is, what percent that entails, and what type of chem it is if that is a known chem.
/obj/item/reagent_containers/hypospray/advanced/proc/display_reagents(mob/user)
	if(isnull(reagents))
		return
	var/list/dat = list()
	dat += "\n \t [span_notice("<b>Total Reagents:</b> [reagents.total_volume]/[volume]. <b>Dosage Size:</b> [min(reagents.total_volume, amount_per_transfer_from_this)]")]</br>"
	if(length(reagents.reagent_list) > 0)
		for (var/datum/reagent/R in reagents.reagent_list)
			var/percent = round(R.volume / max(0.01 , reagents.total_volume * 0.01),0.01)
			var/dose = round(min(reagents.total_volume, amount_per_transfer_from_this) * percent * 0.01,0.01)
			if(R.scannable)
				dat += "\n \t <b>[R]:</b> [R.volume]|[percent]% <b>Amount per dose:</b> [dose]</br>"
			else
				dat += "\n \t <b>Unknown:</b> [R.volume]|[percent]% <b>Amount per dose:</b> [dose]</br>"
	return span_notice("[src]的试剂显示如下内容: [dat.Join(" ")]")

/obj/item/reagent_containers/hypospray/advanced/bicaridine
	name = "双卡利定喷雾注射器"
	desc = "装有双卡利定的喷雾注射器. 一种治疗割伤和瘀伤的化学物质."
	list_reagents = list(
		/datum/reagent/medicine/bicaridine = 120,
	)
	description_overlay = "Bi"

/obj/item/reagent_containers/hypospray/advanced/kelotane
	name = "凯洛坦喷雾注射器"
	desc = "装有凯洛坦的喷雾注射器. 一种治疗烧伤的化学物质."
	list_reagents = list(
		/datum/reagent/medicine/kelotane = 120,
	)
	description_overlay = "Ke"

/obj/item/reagent_containers/hypospray/advanced/tramadol
	name = "曲马多喷雾注射器"
	desc = "装有曲马多的喷雾注射器. 一种缓解疼痛的化学物质."
	list_reagents = list(
		/datum/reagent/medicine/tramadol = 120,
	)
	description_overlay = "Ta"

/obj/item/reagent_containers/hypospray/advanced/tricordrazine
	name = "三科德拉嗪喷雾注射器"
	desc = "装有三科德拉嗪的喷雾注射器. 一种治疗割伤, 瘀伤, 烧伤, 中毒和缺氧的化学物质."
	list_reagents = list(
		/datum/reagent/medicine/tricordrazine = 120,
	)
	description_overlay = "Ti"

/obj/item/reagent_containers/hypospray/advanced/dylovene
	name = "地洛芬喷雾注射器"
	desc = "装有地洛芬的喷雾注射器. 一种在清除毒素的同时治疗中毒的化学物质, 但会削弱耐力."
	list_reagents = list(
		/datum/reagent/medicine/dylovene = 120,
	)
	description_overlay = "Dy"

/obj/item/reagent_containers/hypospray/advanced/inaprovaline
	name = "英诺普洛瓦林喷雾注射器"
	desc = "装有英诺普洛瓦林的喷雾注射器."
	amount_per_transfer_from_this = 15
	list_reagents = list(
		/datum/reagent/medicine/inaprovaline = 120,
	)
	description_overlay = "In"

/obj/item/reagent_containers/hypospray/advanced/meralyne
	name = "美拉林喷雾注射器"
	desc = "装有美拉林的喷雾注射器. 一种快速治疗割伤和瘀伤的高级化学物质."
	amount_per_transfer_from_this = 5
	list_reagents = list(
		/datum/reagent/medicine/meralyne = 120,
	)
	description_overlay = "Mr"

/obj/item/reagent_containers/hypospray/advanced/dermaline
	name = "德马林喷雾注射器"
	desc = "装有德马林的喷雾注射器. 一种快速治疗烧伤的高级化学物质."
	amount_per_transfer_from_this = 5
	list_reagents = list(
		/datum/reagent/medicine/dermaline = 120,
	)
	description_overlay = "Dr"

/obj/item/reagent_containers/hypospray/advanced/combat_advanced
	name = "高级战斗喷雾注射器"
	desc = "装有数剂高级治疗和止痛化学物质的喷雾注射器. 用于实战."
	list_reagents = list(
		/datum/reagent/medicine/meralyne = 40,
		/datum/reagent/medicine/dermaline = 40,
		/datum/reagent/medicine/tramadol = 40,
	)
	description_overlay = "Av"

/obj/item/reagent_containers/hypospray/advanced/meraderm
	name = "美拉德姆喷雾注射器"
	desc = "装有美拉林和德马林的喷雾注射器."
	list_reagents = list(
		/datum/reagent/medicine/meralyne = 60,
		/datum/reagent/medicine/dermaline = 60,
	)
	description_overlay = "MD"

/obj/item/reagent_containers/hypospray/advanced/oxycodone
	name = "羟考酮喷雾注射器"
	desc = "装有羟考酮的喷雾注射器. 一种高级但极易成瘾的化学物质, 几乎可以完全消除疼痛和休克."
	list_reagents = list(/datum/reagent/medicine/oxycodone = 120)
	description_overlay = "Ox"

/obj/item/reagent_containers/hypospray/advanced/hypervene
	name = "超维恩喷雾注射器"
	desc = "装有超维恩的喷雾注射器. 一种能迅速清除体内所有化学物质和毒素的化学物质."
	amount_per_transfer_from_this = 3
	list_reagents = list(
		/datum/reagent/hypervene = 120,
	)
	description_overlay = "Ht"

/obj/item/reagent_containers/hypospray/advanced/nanoblood
	name = "纳米血喷雾注射器"
	desc = "装有纳米血的喷雾注射器. 一种能迅速恢复血液的化学物质, 但代价是轻微的毒性损伤."
	amount_per_transfer_from_this = 5
	volume = 60
	list_reagents = list(
		/datum/reagent/medicine/nanoblood = 60,
	)
	description_overlay = "Na"

/obj/item/reagent_containers/hypospray/advanced/peridaxon
	name = "哌拉西酮喷雾注射器"
	desc = "装有哌拉西酮的喷雾注射器, 一种能消除器官损伤后果的化学物质! 一次不要使用超过一次!"
	amount_per_transfer_from_this = 5
	list_reagents = list(
		/datum/reagent/medicine/peridaxon = 120,
	)
	description_overlay = "Pe"

/obj/item/reagent_containers/hypospray/advanced/peridaxonplus
	name = "哌拉西酮+喷雾注射器"
	desc = "装有哌拉西酮Plus的喷雾注射器, 一种能治疗器官但会导致毒素积累的化学物质. 与抗毒素配合使用. !不要在实战中使用!"
	amount_per_transfer_from_this = 3
	list_reagents = list(
		/datum/reagent/medicine/peridaxon_plus = 40,
		/datum/reagent/medicine/hyronalin = 80,
	)
	description_overlay = "Pe+"

/obj/item/reagent_containers/hypospray/advanced/peridaxonplus_medkit
	name = "哌拉西酮+喷雾注射器"
	desc = "装有哌拉西酮Plus的喷雾注射器, 一种能治疗器官但会导致毒素积累的化学物质. 与抗毒素配合使用. !不要在实战中使用!"
	amount_per_transfer_from_this = 3
	list_reagents = list(
		/datum/reagent/medicine/peridaxon_plus = 6,
		/datum/reagent/medicine/hyronalin = 12,
	)
	description_overlay = "Pe+"

/obj/item/reagent_containers/hypospray/advanced/quickclot
	name = "速凝喷雾注射器"
	desc = "装有速凝的喷雾注射器, 一种旨在暂停所有出血的化学物质. 根据需要补充剂量."
	amount_per_transfer_from_this = 15
	list_reagents = list(
		/datum/reagent/medicine/quickclot = 120,
	)
	description_overlay = "Qk"

/obj/item/reagent_containers/hypospray/advanced/quickclotplus
	name = "速凝+喷雾注射器"
	desc = "装有速凝Plus的喷雾注射器, 一种旨在消除内出血的化学物质. 与抗毒素配合使用. !不要在实战中使用!"
	amount_per_transfer_from_this = 5
	list_reagents = list(
		/datum/reagent/medicine/quickclotplus = 120,
	)
	description_overlay = "Qk+"

/obj/item/reagent_containers/hypospray/advanced/quickclotplus_medkit
	name = "速凝+喷雾注射器"
	desc = "装有速凝Plus的喷雾注射器, 一种旨在消除内出血的化学物质. 与抗毒素配合使用. !不要在实战中使用!"
	amount_per_transfer_from_this = 5
	list_reagents = list(
		/datum/reagent/medicine/quickclotplus = 30,
	)
	description_overlay = "Qk+"

/obj/item/reagent_containers/hypospray/advanced/russian_red
	name = "俄罗斯红喷雾注射器"
	desc = "装有俄罗斯红的喷雾注射器, 一种能快速治疗所有伤害的化学物质, 但代价是少量无法治疗的伤害."
	amount_per_transfer_from_this = 10
	list_reagents = list(
		/datum/reagent/medicine/russian_red = 120,
	)
	description_overlay = "Rr"

/obj/item/reagent_containers/hypospray/advanced/big
	name = "大型喷雾注射器"
	desc = "MK2医疗喷雾注射器, 能容纳更多试剂. 配备内置试剂分析仪, 数字标签器和2字母标记器. 很方便. 这是120单位版本."
	worn_icon_state = "hypomed"
	icon_state = "hypomed"
	core_name = "hypospray"
	volume = 240
	possible_transfer_amounts = list(1, 3, 5, 10, 15, 20, 30, 60, 120, 240)

/obj/item/reagent_containers/hypospray/advanced/big/bicaridine
	name = "大型双卡利定喷雾注射器"
	desc = "装有双卡利定的喷雾注射器. 一种治疗割伤和瘀伤的化学物质."
	list_reagents = list(
		/datum/reagent/medicine/bicaridine = 240,
	)
	description_overlay = "Bi"

/obj/item/reagent_containers/hypospray/advanced/big/kelotane
	name = "大型凯洛坦喷雾注射器"
	desc = "装有凯洛坦的喷雾注射器. 一种治疗烧伤的化学物质."
	list_reagents = list(
		/datum/reagent/medicine/kelotane = 240,
	)
	description_overlay = "Ke"

/obj/item/reagent_containers/hypospray/advanced/big/tramadol
	name = "大型曲马多喷雾注射器"
	desc = "装有曲马多的喷雾注射器. 一种缓解疼痛的化学物质."
	list_reagents = list(
		/datum/reagent/medicine/tramadol = 240,
	)
	description_overlay = "Ta"

/obj/item/reagent_containers/hypospray/advanced/big/tricordrazine
	name = "大型三科德拉嗪喷雾注射器"
	desc = "装有三科德拉嗪的喷雾注射器. 一种治疗割伤, 瘀伤, 烧伤, 中毒和缺氧的化学物质."
	list_reagents = list(
		/datum/reagent/medicine/tricordrazine = 240,
	)
	description_overlay = "Ti"

/obj/item/reagent_containers/hypospray/advanced/big/combatmix
	name = "大型战斗混合喷雾注射器"
	desc = "装有战斗混合液的喷雾注射器. 有一个标签写着BKTT 80:80:40:40."
	amount_per_transfer_from_this = 15
	list_reagents = list(
		/datum/reagent/medicine/bicaridine = 80,
		/datum/reagent/medicine/kelotane = 80,
		/datum/reagent/medicine/tramadol = 40,
		/datum/reagent/medicine/tricordrazine = 40,
	)
	description_overlay = "Cm"

/obj/item/reagent_containers/hypospray/advanced/big/dylovene
	name = "大型地洛芬喷雾注射器"
	desc = "装有地洛芬的喷雾注射器. 一种在清除毒素的同时治疗中毒的化学物质, 但会削弱耐力."
	list_reagents = list(
		/datum/reagent/medicine/dylovene = 240,
	)
	description_overlay = "Dy"

/obj/item/reagent_containers/hypospray/advanced/big/inaprovaline
	name = "大型英诺普洛瓦林喷雾注射器"
	desc = "装有英诺普洛瓦林的喷雾注射器. 一种用于稳定和治疗危重病人的紧急化学物质."
	amount_per_transfer_from_this = 15
	list_reagents = list(
		/datum/reagent/medicine/inaprovaline = 240,
	)
	description_overlay = "In"

/obj/item/reagent_containers/hypospray/advanced/big/isotonic
	name = "大型等渗喷雾注射器"
	desc = "一支装有等渗液的注射器。一种有助于补充血液的化学物质。"
	list_reagents = list(
		/datum/reagent/medicine/saline_glucose = 240,
	)
	description_overlay = "Is"

/obj/item/reagent_containers/hypospray/advanced/big/spaceacillin
	name = "大型 spaceacillin 注射器"
	desc = "一支装有 spaceacillin 的注射器。一种对抗病毒和细菌感染的化学物质。"
	list_reagents = list(
		/datum/reagent/medicine/spaceacillin = 240,
	)
	description_overlay = "Sp"

/obj/item/reagent_containers/hypospray/advanced/imialky
	name = "大型 imialky 注射器"
	desc = "一支装有咪达唑仑和 alkysine 混合液的注射器。这些化学物质能治疗大脑、眼睛和耳朵。"
	amount_per_transfer_from_this = 5
	list_reagents = list(
		/datum/reagent/medicine/imidazoline = 60,
		/datum/reagent/medicine/alkysine = 60,
	)
	description_overlay = "Im"

/obj/item/reagent_containers/hypospray/advanced/big/quickclot
	name = "大型 quick-clot 注射器"
	desc = "一支装有 quick-clot 的注射器。一种能止住内出血并恢复血液的化学物质。"
	list_reagents = list(
		/datum/reagent/medicine/quickclot = 240,
	)
	description_overlay = "Qk"
