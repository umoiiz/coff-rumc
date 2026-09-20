/obj/item/mortar_kit/mlrs
	name = "\improper TA-40L多管火箭发射系统"
	desc = "一种由地球政府陆战队使用的手动、需要乘员操作且可拖曳的多管火箭发射系统,其设计目的是用弹药覆盖一片区域以汇聚成大量火力,因此开火时散布较大以实现这一目标.仅能以最多16发火箭弹的齐射方式开火,总共可容纳32发火箭弹.使用60毫米火箭弹."
	icon_state = "mlrs"
	icon = 'icons/obj/artillery/mlrs.dmi'
	max_integrity = 400
	item_flags = TWOHANDED
	deploy_flags = IS_DEPLOYABLE|DEPLOYED_NO_PICKUP|DEPLOY_ON_INITIALIZE
	w_class = WEIGHT_CLASS_HUGE
	deployable_item = /obj/machinery/deployable/mortar/howitzer/mlrs

/obj/machinery/deployable/mortar/howitzer/mlrs/perform_firing_visuals()
	return

/obj/machinery/deployable/mortar/howitzer/mlrs //TODO why in the seven hells is this a howitzer child??????
	pixel_x = 0
	anchored = FALSE // You can move this.
	fire_sound = 'sound/weapons/guns/fire/rocket_arty.ogg'
	reload_sound = 'sound/weapons/guns/interact/tat36_reload.ogg'
	fall_sound = 'sound/weapons/guns/misc/rocket_whistle.ogg'
	minimum_range = 20
	allowed_shells = list(
		/obj/item/mortal_shell/rocket/mlrs,
		/obj/item/mortal_shell/rocket/mlrs/gas,
		/obj/item/mortal_shell/rocket/mlrs/tangle,
	)
	cool_off_time = 60 SECONDS
	fire_delay = 0.15 SECONDS
	fire_amount = 16
	reload_time = 0.25 SECONDS
	max_rounds = 32
	offset_per_turfs = 25
	spread = 3.5
	max_spread = 6.5

//this checks for box of rockets, otherwise will go to normal attackby for mortars
/obj/machinery/deployable/mortar/howitzer/mlrs/attackby(obj/item/I, mob/user, params)
	if(firing)
		user.balloon_alert(user, "炮管滚烫冒烟.等它冷却下来")
		return

	if(!istype(I, /obj/item/storage/box/mlrs_rockets) && !istype(I, /obj/item/storage/box/mlrs_rockets_gas) && !istype(I, /obj/item/storage/box/mlrs_rockets_tangle))
		return ..()

	var/obj/item/storage/box/rocket_box = I

	//prompt user and ask how many rockets to load
	var/numrockets = tgui_input_number(user, "你想装填多少发火箭弹?)", "装填数量", 0, 16, 0)
	if(numrockets < 1 || !can_interact(user))
		return

	//loop that continues loading until a invalid condition is met
	var/rocketsloaded = 0
	while(rocketsloaded < numrockets)
		//verify it has rockets
		if(!istype(rocket_box.contents[1], /obj/item/mortal_shell/rocket/mlrs))
			user.balloon_alert(user, "没有火箭弹了")
			return
		var/obj/item/mortal_shell/mortar_shell = rocket_box.contents[1]

		if(length(chamber_items) >= max_rounds)
			user.balloon_alert(user, "你无法装填更多")
			return

		if(!(mortar_shell.type in allowed_shells))
			user.balloon_alert(user, "这种炮弹不匹配")
			return

		if(busy)
			user.balloon_alert(user, "其他人正在使用这个")
			return

		user.visible_message(span_notice("[user]开始将\a [mortar_shell.name]装填进[src]."),
		span_notice("你开始将\a [mortar_shell.name]装填进[src]."))
		playsound(loc, reload_sound, 50, 1)
		busy = TRUE
		if(!do_after(user, reload_time, NONE, src, BUSY_ICON_HOSTILE))
			busy = FALSE
			return

		busy = FALSE

		user.visible_message(span_notice("[user]将\a [mortar_shell.name]装填进[src]."),
		span_notice("你将\a [mortar_shell.name]装填进[src]."))
		chamber_items += mortar_shell

		rocket_box.storage_datum.remove_from_storage(mortar_shell, null, user)
		rocketsloaded++
	user.balloon_alert(user, "右键点击开火")

/obj/machinery/deployable/mortar/howitzer/mlrs/record_shell_fired()
	GLOB.round_statistics.rocket_shells_fired++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "rocket_shells_fired")
