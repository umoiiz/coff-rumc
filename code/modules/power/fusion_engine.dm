#define FUSION_ENGINE_MAX_POWER_GEN 80000 //Full capacity
#define FUSION_ENGINE_FAIL_CHECK_TICKS 1000 //Check for failure every this many ticks
#define FUSION_ENGINE_FULL_STRENGTH_FULL_RATE 0.1
#define FUSION_ENGINE_NO_DAMAGE 0
#define FUSION_ENGINE_LIGHT_DAMAGE 1
#define FUSION_ENGINE_MEDIUM_DAMAGE 2
#define FUSION_ENGINE_HEAVY_DAMAGE 3
#define MARINE_QUICKBUILD_ALLOWED (CHECK_BITFIELD(SSticker.mode?.round_type_flags, MODE_ALLOW_MARINE_QUICKBUILD) && (!SSticker.round_start_time || (world.time - SSticker.round_start_time) < 10 MINUTES))

/obj/machinery/power/fusion_engine
	name = "\improper S-52 fusion reactor"
	icon = 'icons/obj/machines/fusion_engine.dmi'
	icon_state = "off"
	desc = "一台Westingland S-52聚变反应堆.消耗燃料电池并将其转化为飞船的电力.同时会产生大量热量."
	resistance_flags = UNACIDABLE
	anchored = TRUE
	density = TRUE

	/// The % of how much of our max power we're putting out, 80,000W at full capacity
	var/power_gen_percent = 0
	//What state of damage are we on
	var/buildstate = FUSION_ENGINE_NO_DAMAGE
	/// Is the generator on?
	var/is_on = FALSE
	/// The cell inside the generator
	var/obj/item/fuel_cell/fusion_cell
	/// Rate at which fuel is used.  Based mostly on how long the generator has been running.
	var/fuel_rate = 0


/obj/machinery/power/fusion_engine/Initialize(mapload)
	. = ..()
	fusion_cell = new(src)

/obj/machinery/power/fusion_engine/should_have_node()
	return TRUE


/obj/machinery/power/fusion_engine/preset/Initialize(mapload)
	. = ..()
	fusion_cell.set_fuel_amount(100)
	is_on = TRUE
	power_gen_percent = 99//will get to 100 on first tick, updating fuel_rate in the process
	update_icon()
	start_processing()

/obj/machinery/power/fusion_engine/random/Initialize(mapload)
	. = ..()
	switch(rand(1,100))
		if(1 to 5)
			buildstate = FUSION_ENGINE_HEAVY_DAMAGE
		if(6 to 15)
			buildstate = FUSION_ENGINE_MEDIUM_DAMAGE
		if(16 to 30)
			buildstate = FUSION_ENGINE_LIGHT_DAMAGE
		else
			fusion_cell.set_fuel_amount(rand(0,30))
	update_icon()

/obj/machinery/power/fusion_engine/power_change()
	return

/obj/machinery/power/fusion_engine/process()
	if(!is_on)
		return FALSE
	if(buildstate || !anchored || !powernet || !fusion_cell) //Default logic checking
		is_on = FALSE
		power_gen_percent = 0
		update_icon()
		stop_processing()
		return FALSE
	if(fusion_cell.fuel_amount <= 0)
		balloon_alert_to_viewers("燃料耗尽")
		fuel_rate = 0
		is_on = FALSE
		power_gen_percent = 0
		update_icon()
		stop_processing()
		return FALSE

	if(power_gen_percent < 100)
		power_gen_percent++

		switch(power_gen_percent) //Flavor text!
			if(10)
				balloon_alert_to_viewers("在启动时开始嗡嗡作响")
				fuel_rate = FUSION_ENGINE_FULL_STRENGTH_FULL_RATE * 0.2
			if(50)
				balloon_alert_to_viewers("在达到半功率时发出低鸣")
				fuel_rate = FUSION_ENGINE_FULL_STRENGTH_FULL_RATE * 0.8
			if(100)
				balloon_alert_to_viewers("在达到全功率时发出轰鸣")
				fuel_rate = FUSION_ENGINE_FULL_STRENGTH_FULL_RATE


	add_avail(FUSION_ENGINE_MAX_POWER_GEN * (power_gen_percent * 0.01) ) //Nope, all good, just add the power
	fusion_cell.take(fuel_rate) //Consumes fuel
	update_icon()

/obj/machinery/power/fusion_engine/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		balloon_alert(user, "你不能使用那个")
		return FALSE
	interact_hand(user)

/obj/machinery/power/fusion_engine/attack_ai(mob/living/silicon/ai/user)
	return interact_hand(user)

//It is a bit messy to split attack_hand into this proc, but it is the easiest way to have the AI be able to toggle them.
/obj/machinery/power/fusion_engine/proc/interact_hand(mob/living/user)
	switch(buildstate)
		if(FUSION_ENGINE_HEAVY_DAMAGE)
			balloon_alert(user, "使用喷灯开始修理")
			return FALSE
		if(FUSION_ENGINE_MEDIUM_DAMAGE)
			balloon_alert(user, "使用剪线钳修复电路")
			return FALSE
		if(FUSION_ENGINE_LIGHT_DAMAGE)
			balloon_alert(user, "使用扳手完成修理")
			return FALSE
	if(is_on)
		balloon_alert_to_viewers("[usr]关闭了发电机.")
		is_on = FALSE
		power_gen_percent = 0
		update_icon()
		stop_processing()
		return TRUE

	if(!fusion_cell)
		balloon_alert(user, "不行,需要燃料电池")
		return FALSE
	if(!fusion_cell.fuel_amount)
		balloon_alert(user, "燃料电池是空的")
		return FALSE

	if(fusion_cell.fuel_amount <= 10)
		balloon_alert_to_viewers("燃料水平极低")
	balloon_alert_to_viewers("启动发电机")
	fuel_rate = FUSION_ENGINE_FULL_STRENGTH_FULL_RATE * 0.1

	is_on = TRUE
	update_icon()
	start_processing()
	return TRUE

/obj/machinery/power/fusion_engine/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/fuel_cell))
		return ..()

	if(is_on)
		balloon_alert(user, "不行,需要先关闭")
		return

	if(fusion_cell)
		balloon_alert(user, "需要先取出燃料电池")
		return

	if(user.transferItemToLoc(I, src))
		fusion_cell = I
		update_icon()
		balloon_alert(user, "你将[I]装入[src]。")

/obj/machinery/power/fusion_engine/welder_act(mob/living/user, obj/item/O)
	. = ..()
	if(!iswelder(O))
		return FALSE

	var/obj/item/tool/weldingtool/WT = O
	if(buildstate != FUSION_ENGINE_HEAVY_DAMAGE)
		balloon_alert(user, "不需要焊接")
		return FALSE

	if(!(WT.remove_fuel(1, user)))
		balloon_alert(user, "需要更多焊接燃料")
		return FALSE

	if(!MARINE_QUICKBUILD_ALLOWED && user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
		balloon_alert_to_viewers("摸索着[src]的内部结构")
		var/fumbling_time = 10 SECONDS - 2 SECONDS * user.skills.getRating(SKILL_ENGINEER)
		if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED, extra_checks = CALLBACK(WT, TYPE_PROC_REF(/obj/item/tool/weldingtool, isOn))))
			return FALSE
	balloon_alert_to_viewers("开始焊接一些损伤")
	if(!O.use_tool(src, user, 20 SECONDS - (user.skills.getRating(SKILL_ENGINEER) * 3 SECONDS), 2, 25, null, BUSY_ICON_BUILD))
		return FALSE
	if(buildstate != FUSION_ENGINE_HEAVY_DAMAGE || is_on)
		return FALSE
	buildstate = FUSION_ENGINE_MEDIUM_DAMAGE
	balloon_alert_to_viewers("[user]开始焊接一些损伤")
	update_icon()
	record_generator_repairs(user)
	return TRUE

/obj/machinery/power/fusion_engine/wirecutter_act(mob/living/user, obj/item/O)
	. = ..()

	if(!iswirecutter(O))
		return FALSE

	if(is_on)
		balloon_alert(user, "先把它关掉!")
		return FALSE

	if(buildstate != FUSION_ENGINE_MEDIUM_DAMAGE)
		balloon_alert(user, "不需要调整线路")
		return FALSE

	if(!MARINE_QUICKBUILD_ALLOWED && user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
		balloon_alert_to_viewers("摸索着[src]的线路")
		var/fumbling_time = 10 SECONDS - 2 SECONDS * user.skills.getRating(SKILL_ENGINEER)
		if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
			return FALSE

	playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)
	balloon_alert_to_viewers("开始固定[src]的线路")
	if(!do_after(user,  10 SECONDS - (user.skills.getRating(SKILL_ENGINEER) * 2 SECONDS), NONE, src, BUSY_ICON_BUILD) || buildstate != FUSION_ENGINE_MEDIUM_DAMAGE || is_on)
		return FALSE
	playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)
	buildstate = FUSION_ENGINE_LIGHT_DAMAGE
	balloon_alert_to_viewers("固定[src]的线路")
	update_icon()
	record_generator_repairs(user)
	return TRUE

/obj/machinery/power/fusion_engine/wrench_act(mob/living/user, obj/item/O)
	. = ..()
	if(!iswrench(O))
		return FALSE

	if(buildstate != FUSION_ENGINE_LIGHT_DAMAGE)
		balloon_alert(user, "不需要调整管道")
		return FALSE

	if(!MARINE_QUICKBUILD_ALLOWED && user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
		balloon_alert_to_viewers("摸索着[src]的管道")
		var/fumbling_time = 10 SECONDS - 2 SECONDS * user.skills.getRating(SKILL_ENGINEER)
		if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
			return FALSE
	playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
	balloon_alert_to_viewers("开始修理[src]的管道")
	if(!do_after(user,  15 SECONDS - (user.skills.getRating(SKILL_ENGINEER) * 3 SECONDS), NONE, src, BUSY_ICON_BUILD) && buildstate == FUSION_ENGINE_LIGHT_DAMAGE && !is_on)
		return FALSE
	playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
	buildstate = FUSION_ENGINE_NO_DAMAGE
	balloon_alert_to_viewers("修理[src]的管道")
	update_icon()
	record_generator_repairs(user)
	return TRUE

/obj/machinery/power/fusion_engine/crowbar_act(mob/living/user, obj/item/O)
	. = ..()
	if(buildstate != FUSION_ENGINE_NO_DAMAGE)
		balloon_alert(user, "你必须先修理发电机")
		return
	if(is_on)
		balloon_alert(user, "你必须先关闭发电机")
		return
	if(!fusion_cell)
		balloon_alert(user, "没有电池可以取出")
		return

	if(!MARINE_QUICKBUILD_ALLOWED && user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
		balloon_alert_to_viewers("摸索着[src]的燃料舱")
		var/fumbling_time = 10 SECONDS - 2 SECONDS * user.skills.getRating(SKILL_ENGINEER)
		if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
			return FALSE
	playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
	balloon_alert_to_viewers("开始撬开[src]的燃料舱")
	if(!do_after(user, 10 SECONDS - (user.skills.getRating(SKILL_ENGINEER) * 2 SECONDS), NONE, src, BUSY_ICON_BUILD))
		return FALSE

	if(buildstate != FUSION_ENGINE_NO_DAMAGE)
		return
	if(is_on)
		return
	if(!fusion_cell)
		return

	balloon_alert_to_viewers("撬开[src]的燃料舱并取出电池")
	fusion_cell.update_icon()
	user.put_in_hands(fusion_cell)
	fusion_cell = null
	update_icon()
	return TRUE

/obj/machinery/power/fusion_engine/examine(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	if(buildstate != FUSION_ENGINE_NO_DAMAGE)
		. += span_info("它坏了。")
		switch(buildstate)
			if(FUSION_ENGINE_HEAVY_DAMAGE)
				. += span_info("使用喷灯,然后使用剪线钳,然后使用扳手来修理它。")
			if(FUSION_ENGINE_MEDIUM_DAMAGE)
				. += span_info("使用剪线钳,然后使用扳手来修理它。")
			if(FUSION_ENGINE_LIGHT_DAMAGE)
				. += span_info("使用扳手来修理它。")
		return

	if(!is_on)
		. += span_info("它似乎处于离线状态。")
	else
		. += span_info("功率表读数为:[power_gen_percent]%")
	if(fusion_cell)
		. += span_info("你可以看到插座中有一块燃料电池。")
		if(user.skills.getRating(SKILL_ENGINEER) >= SKILL_ENGINEER_EXPERT)
			switch(fusion_cell.fuel_amount)
				if(0 to 10)
					. += span_danger("燃料电池电量极低。")
				if(11 to 25)
					. += span_warning("燃料电池电量不足。")
				if(26 to 50)
					. += span_info("燃料电池电量略低于一半。")
				if(51 to 75)
					. += span_info("燃料电池电量略高于一半。")
				if(76 to 99)
					. += span_info("燃料电池几乎充满。")
				if(100)
					. += span_info("燃料电池已充满。")
	else
		. += span_info("插座中没有燃料电池。")

/obj/machinery/power/fusion_engine/update_icon_state()
	. = ..()
	switch(buildstate)
		if(FUSION_ENGINE_NO_DAMAGE)
			if(fusion_cell?.fuel_amount > 0)
				var/pstatus = is_on ? "on" : "off"
				switch(fusion_cell.fuel_amount)
					if(1 to 10)
						icon_state = "[pstatus]-10"
					if(11 to 25)
						icon_state = "[pstatus]-25"
					if(26 to 50)
						icon_state = "[pstatus]-50"
					if(51 to 75)
						icon_state = "[pstatus]-75"
					if(76 to INFINITY)
						icon_state = "[pstatus]-100"
			else
				icon_state = "off"

		if(FUSION_ENGINE_HEAVY_DAMAGE)
			icon_state = "weld"
		if(FUSION_ENGINE_MEDIUM_DAMAGE)
			icon_state = "wire"
		if(FUSION_ENGINE_LIGHT_DAMAGE)
			icon_state = "wrench"

#undef FUSION_ENGINE_MAX_POWER_GEN
#undef FUSION_ENGINE_FAIL_CHECK_TICKS
#undef FUSION_ENGINE_NO_DAMAGE
#undef FUSION_ENGINE_LIGHT_DAMAGE
#undef FUSION_ENGINE_MEDIUM_DAMAGE
#undef FUSION_ENGINE_HEAVY_DAMAGE
#undef MARINE_QUICKBUILD_ALLOWED

//FUEL CELL
/obj/item/fuel_cell
	name = "\improper WL-6通用燃料电池"
	icon = 'icons/obj/items/fuel_cell.dmi'
	icon_state = "cell-empty"
	desc = "一种可充电燃料电池,设计用作夏延级运输机或韦斯特兰S-52反应堆的电源。"
	/// The amount of fuel currently in the cell
	var/fuel_amount = 0
	/// The maximum amount of fuel the cell holds
	var/max_fuel_amount = 100

/obj/item/fuel_cell/low
	icon_state = "cell-low"
	fuel_amount = 25

/obj/item/fuel_cell/medium
	icon_state = "cell-medium"
	fuel_amount = 50

/obj/item/fuel_cell/high
	icon_state = "cell-high"
	fuel_amount = 75

/obj/item/fuel_cell/full
	icon_state = "cell-full"
	fuel_amount = 100

/obj/item/fuel_cell/random/Initialize(mapload)
	. = ..()
	fuel_amount = rand(0,100)
	update_icon()

/obj/item/fuel_cell/update_icon_state()
	. = ..()
	switch(get_fuel_percent())
		if(-INFINITY to 0)
			icon_state = "cell-empty"
		if(0 to 25)
			icon_state = "cell-low"
		if(25 to 75)
			icon_state = "cell-medium"
		if(75 to 99)
			icon_state = "cell-high"
		else
			icon_state = "cell-full"

/obj/item/fuel_cell/examine(mob/user)
	. = ..()
	if(ishuman(user))
		. += "The fuel indicator reads: [get_fuel_percent()]%"

/obj/item/fuel_cell/proc/get_fuel_percent()
	return round(100*fuel_amount/max_fuel_amount)

/obj/item/fuel_cell/proc/is_regenerated()
	return (fuel_amount == max_fuel_amount)

/obj/item/fuel_cell/proc/give(amount)
	fuel_amount = min(fuel_amount + amount, max_fuel_amount)

/obj/item/fuel_cell/proc/take(amount)
	fuel_amount = max(fuel_amount - amount, 0)

/obj/item/fuel_cell/proc/set_fuel_amount(amount)
	if(amount < 0 || amount > max_fuel_amount)
		return
	fuel_amount = amount
