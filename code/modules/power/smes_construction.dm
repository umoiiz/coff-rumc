// Constructable SMES version. Based on Coils. Each SMES can hold 6 Coils by default.
// Each coil adds 250kW I/O and 5M capacity.
// This is second version, now subtype of regular SMES.




// SMES itself
/obj/machinery/power/smes/buildable
	var/max_coils = 6 			//30M capacity, 1.5MW input/output when fully upgraded /w default coils
	var/cur_coils = 1 			// Current amount of installed coils
	var/safeties_enabled = TRUE	// If 0 modifications can be done without discharging the SMES, at risk of critical failure.
	var/failing = FALSE			// If 1 critical failure has occured and SMES explosion is imminent.
	resistance_flags = UNACIDABLE|CRUSHER_IMMUNE

/obj/machinery/power/smes/buildable/empty
	charge = 0

/obj/machinery/power/smes/buildable/empty/dist
	name = "colony distribution SMES"

/obj/machinery/power/smes/buildable/empty/backup
	name = "backup power SMES"

/obj/machinery/power/smes/buildable/Initialize(mapload)
	. = ..()
	component_parts = list()
	component_parts += new /obj/item/stack/cable_coil(src,30)
	component_parts += new /obj/item/circuitboard/machine/smes(src)

	// Allows for mapped-in SMESs with larger capacity/IO
	for(var/i = 1, i <= cur_coils, i++)
		component_parts += new /obj/item/stock_parts/smes_coil(src)

	recalc_coils()

/obj/machinery/power/smes/buildable/proc/recalc_coils()
	if ((cur_coils <= max_coils) && (cur_coils >= 1))
		capacity = 0
		input_level_max = 0
		output_level_max = 0
		for(var/obj/item/stock_parts/smes_coil/C in component_parts)
			capacity += C.ChargeCapacity
			input_level_max += C.IOCapacity
			output_level_max += C.IOCapacity
		charge = between(0, charge, capacity)
		return 1
	else
		return 0

	// SMESs store very large amount of power. If someone screws up (ie: Disables safeties and attempts to modify the SMES) very bad things happen.
	// Bad things are based on charge percentage.
	// Possible effects:
	// Sparks - Lets out few sparks, mostly fire hazard if phoron present. Otherwise purely aesthetic.
	// Shock - Depending on intensity harms the user. Insultated Gloves protect against weaker shocks, but strong shock bypasses them.
	// EMP Pulse - Lets out EMP pulse discharge which screws up nearby electronics.
	// Light Overload - X% chance to overload each lighting circuit in connected powernet. APC based.
	// APC Failure - X% chance to destroy APC causing very weak explosion too. Won't cause hull breach or serious harm.
	// SMES Explosion - X% chance to destroy the SMES, in moderate explosion. May cause small hull breach.
/obj/machinery/power/smes/buildable/proc/total_system_failure(intensity = 0, mob/user as mob)
	if (!intensity)
		return

	var/mob/living/carbon/human/h_user = null
	if (!ishuman(user))
		return
	else
		h_user = user


	// Preparations
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	// Check if user has protected gloves.
	var/user_protected = 0
	if(h_user.gloves)
		var/obj/item/clothing/gloves/G = h_user.gloves
		if(G.siemens_coefficient == 0)
			user_protected = 1


	switch (intensity)
		if (0 to 15)
			// Small overcharge
			// Sparks, Weak shock
			s.set_up(2, 1, src)
			s.start()
			if (user_protected && prob(80))
				to_chat(h_user, "小电弧差点烧伤你的手. 幸好你戴着手套!")
			else
				to_chat(h_user, "当你触碰[src]时,小电弧闪烁并烧伤你的手!")
				h_user.adjust_fire_loss(rand(5,10))
				h_user.Unconscious(4 SECONDS)
			charge = 0

		if (16 to 35)
			// Medium overcharge
			// Sparks, Medium shock, Weak EMP
			s.set_up(4,1,src)
			s.start()
			if (user_protected && prob(25))
				to_chat(h_user, "中等电弧闪烁并差点烧伤你的手. 幸好你戴着手套!")
			else
				to_chat(h_user, "当你触碰[src]时,中等电弧闪烁,严重烧伤你的手!")
				h_user.adjust_fire_loss(rand(10,25))
				h_user.Unconscious(10 SECONDS)
			INVOKE_ASYNC(src, PROC_REF(empulse), loc, 2, 4)
			charge = 0

		if (36 to 60)
			// Strong overcharge
			// Sparks, Strong shock, Strong EMP, 10% light overload. 1% APC failure
			s.set_up(7,1,src)
			s.start()
			if (user_protected)
				to_chat(h_user, "强电弧在你和[src]之间闪烁,无视你的手套并烧伤你的手!")
				h_user.adjust_fire_loss(rand(25,60))
				h_user.Unconscious(16 SECONDS)
			else
				to_chat(h_user, "强电弧在你和[src]之间闪烁,使你昏迷了一段时间!")
				h_user.adjust_fire_loss(rand(35,75))
				h_user.Unconscious(24 SECONDS)
			INVOKE_ASYNC(src, PROC_REF(empulse), loc, 8, 16)
			charge = 0
			apcs_overload(1, 10)
			visible_message("警告. 输出调节器故障. 检测到失控放电.")

		if (61 to INFINITY)
			// Massive overcharge
			// Sparks, Near - instantkill shock, Strong EMP, 25% light overload, 5% APC failure. 50% of SMES explosion. This is bad.
			s.set_up(10,1,src)
			s.start()
			to_chat(h_user, "巨大电弧在你和[src]之间闪烁. 你能想到的最后一件事是\"哦该死...\"")
			// Remember, we have few gigajoules of electricity here.. Turn them into crispy toast.
			h_user.adjust_fire_loss(rand(150,195))
			h_user.Unconscious(50 SECONDS)
			INVOKE_ASYNC(src, PROC_REF(empulse), loc, 32, 64)
			charge = 0
			apcs_overload(5, 25)
			visible_message("警告. 输出调节器故障. 检测到严重失控放电.")

			if (prob(50))
				visible_message("危险! 磁约束场不稳定! 约束场即将失效!")
				failing = 1
				addtimer(CALLBACK(src, PROC_REF(smes_overload)), rand(30 SECONDS, 60 SECONDS))

/obj/machinery/power/smes/buildable/proc/smes_overload()
	if(!failing) // Admin can manually set this var back to 0 to stop overload, for use when griffed.
		update_icon()
		visible_message("磁约束已稳定.")
		return
	visible_message("危险! 磁约束场将在3 ... 2 ... 1 ...后失效")
	cell_explosion(loc, 250, 50)
	// Not sure if this is necessary, but just in case the SMES *somehow* survived..
	qdel(src)

/// Gets powernet APCs and overloads lights or breaks the APC completely, depending on percentages.
/obj/machinery/power/smes/buildable/proc/apcs_overload(failure_chance, overload_chance)
	if(!src.powernet)
		return

	for(var/obj/machinery/power/terminal/T in src.powernet.nodes)
		if(!istype(T.master, /obj/machinery/power/apc))
			continue
		var/obj/machinery/power/apc/A = T.master
		if(prob(overload_chance))
			A.overload_lighting()
		if(prob(failure_chance))
			A.set_broken()

	// Failing SMES has special icon overlay.
/obj/machinery/power/smes/buildable/update_overlays()
	. = ..()
	if(failing)
		. += image('icons/obj/power.dmi', "smes_crit")

/obj/machinery/power/smes/buildable/attackby(obj/item/I, mob/user, params)
	// No more disassembling of overloaded SMESs. You broke it, now enjoy the consequences.
	if(failing)
		to_chat(user, span_warning("[src]的屏幕闪烁着警报. 它似乎过载了! 现在触碰它可能不是个好主意."))
		return
	// If parent returned 1:
	// - Hatch is open, so we can modify the SMES
	// - No action was taken in parent function (terminal de/construction atm).
	. = ..()

	if(!.)
		return

	// Charged above 1% and safeties are enabled.
	if((charge > (capacity * 0.01)) && safeties_enabled && !ismultitool(I))
		to_chat(user, span_warning("[src]的安全电路正在阻止修改,因为它已充电!"))
		return

	if(outputting || input_attempt)
		to_chat(user, span_warning("先关闭[src]!"))
		return

	// Probability of failure if safety circuit is disabled (in %)
	var/failure_probability = round((charge / capacity) * 100)

	// If failure probability is below 5% it's usually safe to do modifications
	if(failure_probability < 5)
		failure_probability = 0

	// Crowbar - Disassemble the SMES.
	if(iscrowbar(I))
		if(terminal)
			to_chat(user, span_warning("你必须先拆卸终端!"))
			return

		playsound(get_turf(src), 'sound/items/crowbar.ogg', 25, 1)
		to_chat(user, span_warning("你开始拆卸[src]!"))

		if(!do_after(user, 10 SECONDS * cur_coils, NONE, src, BUSY_ICON_BUILD)) // More coils = takes longer to disassemble. It's complex so largest one with 5 coils will take 50s
			return

		if(failure_probability && prob(failure_probability))
			total_system_failure(failure_probability, user)
			return

		to_chat(user, span_warning("你已拆卸SMES电池!"))
		var/obj/machinery/constructable_frame/machine_frame/M = new(loc)
		M.state = 2
		M.icon_state = "box_1"
		for(var/obj/O in component_parts)
			O.forceMove(loc)
		qdel(src)

	// Superconducting Magnetic Coil - Upgrade the SMES
	else if(istype(I, /obj/item/stock_parts/smes_coil))
		if(cur_coils >= max_coils)
			to_chat(user, span_warning("你无法向此SMES单元插入更多线圈!"))
			return

		if(failure_probability && prob(failure_probability))
			total_system_failure(failure_probability, user)
			return

		to_chat(user, "你将线圈安装到SMES单元中!")
		if(!user.transferItemToLoc(I, src))
			return

		cur_coils ++
		component_parts += I
		recalc_coils()

	// Multitool - Toggle the safeties.
	else if(ismultitool(I))
		safeties_enabled = !safeties_enabled
		to_chat(user, span_warning("你[safeties_enabled ? "connected" : "disconnected"]安全电路."))
		visible_message("[icon2html(src, viewers(src))] <b>[src]</b>发出哔声: \"警告. 安全电路已被: [safeties_enabled ? "re-enabled" : "disabled. Please excercise caution."]\"")
