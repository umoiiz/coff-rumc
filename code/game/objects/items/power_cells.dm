/obj/item/cell
	name = "电源电池"
	desc = "一个可充电的电化学电源电池."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/tools_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/tools_right.dmi',
	)
	worn_icon_state = "cell"
	force = 5
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	/// note %age conveted to actual charge in New
	var/charge = 0
	/// maximum amount of charge the cell can hold
	var/maxcharge = 1000
	/// BOOL, true if rigged to explode
	var/rigged = FALSE
	///If not 100% reliable, it will build up faults.
	var/minor_fault = 0
	/// BOOL, If true, the cell will recharge itself.
	var/self_recharge = FALSE
	/// How much power to give, if self_recharge is true. The number is in absolute cell charge, as it gets divided by CELLRATE later.
	var/charge_amount = 25
	/// A tracker for use in self-charging
	var/last_use = 0
	/// How long it takes for the cell to start recharging after last use
	var/charge_delay = 0
	///used to track what set of overlays to use to display charge level
	var/charge_overlay = "cell"
	/// Can this cell be recharged via cell recharger or TE powerpack?
	var/rechargable = TRUE
	/// Can this cell be installed in an APC?
	var/apc_compatible = TRUE

/obj/item/cell/Initialize(mapload)
	. = ..()
	charge = maxcharge
	if(self_recharge)
		START_PROCESSING(SSobj, src)

	update_icon()

/obj/item/cell/Destroy()
	if(self_recharge)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/cell/process()
	if(self_recharge)
		if(world.time >= last_use + charge_delay)
			give(charge_amount)
			update_icon()
			SEND_SIGNAL(src, COMSIG_CELL_SELF_RECHARGE, charge_amount)
	else
		return PROCESS_KILL

/obj/item/cell/update_overlays()
	. = ..()
	if(charge < 0.01 || !charge_overlay)
		return
	var/remaining = CEILING((charge / max(maxcharge, 1)) * 100, 25)
	. += "[charge_overlay]_[remaining]"

/obj/item/cell/examine(mob/user)
	. = ..()
	if(maxcharge <= 2500)
		. += "The manufacturer's label states this cell has a power rating of [maxcharge], and that you should not swallow it.\nThe charge meter reads [round(src.percent() )]%."
	else
		. += "This power cell has an exciting chrome finish, as it is an uber-capacity cell type! It has a power rating of [maxcharge]!\nThe charge meter reads [round(src.percent() )]%."
	if(rigged)
		if(get_dist(user,src) < 3) //Have to be close to make out the *DANGEROUS* details
			. += span_danger("这个电源电池看起来被临时改装成了炸弹!")

/obj/item/cell/attack_self(mob/user as mob)
	if(!rigged)
		return ..()

	if(issynth(user) && !CONFIG_GET(flag/allow_synthetic_gun_use))
		to_chat(user, span_warning("你的程序限制使用被改装的电源电池."))
		return
	log_bomber(user, "primed a rigged", src)
	user.visible_message(span_danger("[user]使[src]失稳;它即将爆炸!"),
	span_danger("你使[src]失稳;它即将爆炸!"))
	var/datum/effect_system/spark_spread/spark_system = new /datum/effect_system/spark_spread()
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)
	spark_system.start(src)
	playsound(loc, 'sound/items/welder2.ogg', 25, 1, 6)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.throw_mode_on()
	overlays += new/obj/effect/overlay/danger
	addtimer(CALLBACK(src, PROC_REF(delayed_explosion), spark_system), rand(3, 50))

/obj/item/cell/proc/delayed_explosion(datum/effect_system/spark_spread/spark_system)
	spark_system.start(src)
	explode()

/obj/item/cell/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/reagent_containers/syringe))
		var/obj/item/reagent_containers/syringe/S = I

		if(issynth(user) && !CONFIG_GET(flag/allow_synthetic_gun_use))
			to_chat(user, span_warning("你的程序限制改装电源电池."))
			return

		to_chat(user, "你将溶液注入了电源电池.")

		if(S.reagents.has_reagent(/datum/reagent/toxin/phoron, 5))
			rigged = TRUE
		S.reagents.clear_reagents()

	else if(ismultitool(I))
		if(issynth(user) && !CONFIG_GET(flag/allow_synthetic_gun_use))
			to_chat(user, span_warning("你的程序限制改装电源电池."))
			return
		var/skill = user.skills.getRating(SKILL_ENGINEER)
		var/delay = SKILL_TASK_EASY - (5 + skill * 1.25)

		if(user.do_actions)
			return
		var/obj/effect/overlay/sparks/spark_overlay = new

		if(!rigged)
			if(skill < SKILL_ENGINEER_ENGI) //Field engi skill or better or ya fumble.
				user.visible_message(span_notice("[user]笨拙地摸索着如何操作[src]."),
				span_notice("你笨拙地摸索着,试图搞明白如何将[src]改装成爆炸物."))
				if(!do_after(user, delay, NONE, src, BUSY_ICON_UNSKILLED))
					return

			user.visible_message(span_notice("[user]开始用[I]操作[src]."),
			span_notice("你开始用[I]将[src]改装成引爆装置."))
			if(!do_after(user, delay, NONE, src, BUSY_ICON_BUILD))
				return
			rigged = TRUE
			overlays += spark_overlay
			user.visible_message(span_notice("[user]用[I]完成了对[src]的操作."),
			span_notice("你用[I]将[src]改装成使用时会爆炸的装置."))
		else
			if(skill < SKILL_ENGINEER_ENGI)
				user.visible_message(span_notice("[user]笨拙地摸索着如何操作[src]."),
				span_notice("你笨拙地摸索着,试图搞明白如何稳定[src]."))
				var/fumbling_time = SKILL_TASK_EASY
				if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
					return
				if(prob((SKILL_ENGINEER_PLASTEEL - skill) * 20))
					to_chat(user, "<font color='danger'>在你笨拙地摆弄了几秒后,[src]愤怒地嗡嗡作响,仿佛被冒犯了.你对这件事有一种<b>非常</b>不好的预感.</font>")
					rigged = TRUE
					explode() //Oops. Now you fucked up (or succeeded only too well). Immediate detonation.
			user.visible_message(span_notice("[user]开始用[I]操作[src]."),
			span_notice("你开始用[I]稳定[src],使其在使用时不会爆炸."))
			if(skill > SKILL_ENGINEER_ENGI)
				delay = max(delay - 10, 0)
			if(!do_after(user, delay, NONE, src, BUSY_ICON_BUILD))
				return
			rigged = FALSE
			overlays -= spark_overlay
			user.visible_message(span_notice("[user]用[I]完成了对[src]的操作."),
			span_notice("你用[I]稳定了[src];它使用时不会再爆炸了."))

/obj/item/cell/emp_act(severity)
	. = ..()
	charge = max(charge - ((maxcharge * 0.5) / severity), 0)
	update_appearance(UPDATE_ICON)

/obj/item/cell/ex_act(severity)
	if(!prob(severity * 0.5))
		return
	if(severity >= EXPLODE_WEAK)
		qdel(src)
	else
		corrupt()

/obj/item/cell/use(amount) // use power from a cell
	if(rigged && amount > 0)
		explode()
		return FALSE
	last_use = world.time

	if(charge < amount)
		return FALSE
	charge = (charge - amount)
	return TRUE

///Adds power to the cell
/obj/item/cell/proc/give(amount)
	if(rigged && amount > 0)
		explode()
		return FALSE

	if(maxcharge < amount)
		return FALSE
	if(!rechargable)
		return FALSE
	var/amount_used = min(maxcharge-charge,amount)
	charge += amount_used
	return amount_used

///return % charge of cell
/obj/item/cell/proc/percent()
	return 100 * (charge / maxcharge)

///Returns TRUE if charge is equal to maxcharge
/obj/item/cell/proc/is_fully_charged()
	return charge == maxcharge

/**
 * Determines explosivity based on charge, then explodes
 *
 * * 1000-cell	explosion(epicenter, 0, 0, 1, 1)
 * * 2500-cell	explosion(epicenter, 0, 0, 1, 1)
 * * 10000-cell	explosion(epicenter, 0, 1, 3, 3)
 * * 15000-cell	explosion(epicenter, 0, 2, 4, 4)
 */
/obj/item/cell/proc/explode()
	var/turf/epicenter = get_turf(loc)
	var/power = clamp(charge * 0.01, 10, 500)
	var/range = power / rand(2, 5)

	cell_explosion(epicenter, power, range)

	QDEL_IN(src, 1)

///Divides charge and maxcharge, then has a 10% chance to be rigged to explode
/obj/item/cell/proc/corrupt()
	charge /= 2
	maxcharge /= 2
	if(prob(10))
		rigged = TRUE //broken batterys are dangerous

///Returns a number based on the current charge of the power cell
/obj/item/cell/proc/get_electrocute_damage()
	switch(charge)
		if(1000000 to INFINITY)
			return min(rand(50,160),rand(50,160))
		if(200000 to 1000000-1)
			return min(rand(25,80),rand(25,80))
		if(100000 to 200000-1)//Ave powernet
			return min(rand(20,60),rand(20,60))
		if(50000 to 100000-1)
			return min(rand(15,40),rand(15,40))
		if(1000 to 50000-1)
			return min(rand(10,20),rand(10,20))
		else
			return 0

/obj/item/cell/crap
	name = "\improper Nanotrasen牌可充电AA电池"
	desc = "你无法超越等离子巅峰." //TOTALLY TRADEMARK INFRINGEMENT
	maxcharge = 500

/obj/item/cell/crap/empty/Initialize(mapload)
	. = ..()
	charge = 0

/obj/item/cell/secborg
	name = "安保机器人可充电D型电池"
	maxcharge = 600	//600 max charge / 100 charge per shot = six shots
	apc_compatible = FALSE

/obj/item/cell/secborg/empty/Initialize(mapload)
	. = ..()
	charge = 0

/obj/item/cell/apc
	name = "重型电池"
	maxcharge = 5000

/obj/item/cell/high
	name = "高容量电池"
	icon_state = "hcell"
	maxcharge = 10000

/obj/item/cell/high/empty/Initialize(mapload)
	. = ..()
	charge = 0

/obj/item/cell/super
	name = "超级容量电池"
	icon_state = "scell"
	maxcharge = 20000

/obj/item/cell/super/empty/Initialize(mapload)
	. = ..()
	charge = 0

/obj/item/cell/hyper
	name = "超强容量电池"
	icon_state = "hpcell"
	maxcharge = 30000

/obj/item/cell/hyper/empty/Initialize(mapload)
	. = ..()
	charge = 0

/obj/item/cell/infinite
	name = "无限容量电池!"
	icon_state = "icell"
	maxcharge = 30000

/obj/item/cell/infinite/use()
	return TRUE

/obj/item/cell/potato
	name = "土豆电池"
	desc = "一种可充电的淀粉基电池."
	icon = 'icons/obj/power.dmi' //'icons/obj/items/harvest.dmi'
	icon_state = "potato_cell" //"potato_battery"
	charge = 100
	maxcharge = 300
	minor_fault = 1

/obj/item/cell/rtg // todo should kill this subtype
	charge_overlay = null

/obj/item/cell/rtg/small
	name = "充电电池"
	desc = "这是一种微型放射性同位素发电机,可以装入APC,但不能用于激光武器.所需的屏蔽会显著降低最大容量."
	icon = 'icons/obj/items/stock_parts.dmi'
	icon_state = "capacitor"
	worn_icon_state = "capacitor"
	maxcharge = 2000
	self_recharge = TRUE
	charge_amount = 25
	charge_delay = 2 SECONDS //One hit on a resin thingy every 8 seconds, or one actual wall every 80 seconds.
	apc_compatible = FALSE

/obj/item/cell/rtg/plasma_cutter
	name = "等离子切割机电池"
	desc = "你不应该看到这个"
	maxcharge = 7500
	self_recharge = TRUE
	charge_amount = 25
	charge_delay = 2 SECONDS //One hit on a resin thingy every 8 seconds, or one actual wall every 80 seconds.
	apc_compatible = FALSE
	apc_compatible = FALSE

/obj/item/cell/rtg/large
	name = "大型充电电池"
	desc = "这是一种放射性同位素发电机,可以装入APC,但不能用于激光武器.它太热了,不易储存,也无法手动充电."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "trashmelt"
	worn_icon_state = "trashmelt"
	w_class = WEIGHT_CLASS_HUGE
	maxcharge = 5000
	self_recharge = TRUE
	charge_amount = 50
	charge_delay = 2 SECONDS //One hit on a resin thingy every 4 seconds, or one actual wall every 40 seconds.
	apc_compatible = FALSE

/obj/item/cell/mecha
	name = "小型放射性同位素电池"
	desc = "一块大型扭曲金属,作为机甲的能源核心.尽管它发出蓝色光芒,你大概还是不该舔它."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "trashmelt"
	worn_icon_state = "trashmelt"
	w_class = WEIGHT_CLASS_HUGE
	charge_overlay = null
	self_recharge = TRUE
	maxcharge = 1000
	charge_amount = 30
	apc_compatible = FALSE

/obj/item/cell/mecha/medium
	name = "中型放射性同位素电池"
	maxcharge = 1250
	charge_amount = 40

/obj/item/cell/mecha/large
	name = "大型放射性同位素电池"
	maxcharge = 1500
	charge_amount = 50

/obj/item/cell/night_vision_battery
	name = "夜视仪电池"
	desc = "一种小型、不可充电的夜视仪专用电池."
	icon_state = "night_vision"
	maxcharge = 500
	w_class = WEIGHT_CLASS_TINY
	charge_overlay = ""
	rechargable = FALSE
	apc_compatible = FALSE

/obj/item/cell/unmanned_vehicle
	name = "无人载具电池"
	desc = "一种致密、坚固的电池,用于为TGMC战斗无人载具供电.设计上能承受枪击、爆炸以及三轮虐待."
	icon_state = "icell"
	maxcharge = 20000
	w_class = WEIGHT_CLASS_NORMAL
	apc_compatible = FALSE
