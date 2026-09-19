/obj/item/flash
	name = "闪光弹"
	desc = "用于致盲以及当个混蛋."
	icon = 'icons/obj/device.dmi'
	icon_state = "flash"
	worn_icon_state = "flashbang"	//looks exactly like a flash (and nothing like a flashbang)
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 4
	throw_range = 10
	atom_flags = CONDUCT

	var/times_used = 0 //Number of times it's been used.
	var/broken = 0     //Is the flash burnt out?
	var/last_used = 0 //last world.time it was used.

/obj/item/flash/proc/flash_recharge()
	//capacitor recharges over time
	for(var/i=0, i<3, i++)
		if(last_used+600 > world.time)
			break
		last_used += 600
		times_used -= 2
	last_used = world.time
	times_used = max(0,round(times_used)) //sanity


/obj/item/flash/attack(mob/living/M, mob/user)
	if(!user || !M)	return	//sanity
	if(!ishuman(M)) return

	log_combat(user, M, "attempted to flash", src)

	if(user.skills.getRating(SKILL_POLICE) < SKILL_POLICE_FLASH)
		to_chat(user, span_warning("你似乎不知道怎么使用[src]..."))
		return

	if(broken)
		to_chat(user, span_warning("\The [src]坏了."))
		return

	flash_recharge()
	if(isxeno(M))
		to_chat(user, "你找不到任何眼睛!")
		return

	//spamming the flash before it's fully charged (60seconds) increases the chance of it  breaking
	//It will never break on the first use.
	switch(times_used)
		if(0 to 5)
			last_used = world.time
			if(prob(times_used))	//if you use it 5 times in a minute it has a 10% chance to break!
				broken = 1
				to_chat(user, span_warning("灯泡已经烧坏了!"))
				icon_state = "flashburnt"
				return
			times_used++
		else	//can only use it  5 times a minute
			to_chat(user, span_warning("*咔哒* *咔哒*"))
			return
	playsound(src.loc, 'sound/weapons/flash.ogg', 25, 1)
	var/flashfail = 0

	if(iscarbon(M))
		flashfail = !M.flash_act()
		if(!flashfail)
			M.Paralyze(20 SECONDS)

	else if(issilicon(M))
		M.Paralyze(rand(10 SECONDS,20 SECONDS))
	else
		flashfail = 1

	if(!flashfail)
	//	flick("flash2", src)
		if(!issilicon(M))

			user.visible_message(span_disarm("[user]用闪光灯闪瞎了[M]!"))
		else

			user.visible_message(span_notice("[user]用闪光灯过载了[M]的传感器!"))
	else

		user.visible_message(span_notice("[user]未能用闪光灯闪瞎[M]!"))




/obj/item/flash/attack_self(mob/living/carbon/user as mob, flag = 0, emp = 0)
	if(!user)
		return

	if(user.skills.getRating(SKILL_POLICE) < SKILL_POLICE_FLASH)
		to_chat(user, span_warning("你似乎不知道怎么使用[src]..."))
		return

	if(broken)
		user.show_message(span_warning("[src.name]坏了"), 2)
		return

	flash_recharge()

	//spamming the flash before it's fully charged (60seconds) increases the chance of it  breaking
	//It will never break on the first use.
	switch(times_used)
		if(0 to 5)
			if(prob(2*times_used))	//if you use it 5 times in a minute it has a 10% chance to break!
				broken = 1
				to_chat(user, span_warning("灯泡烧坏了!"))
				icon_state = "flashburnt"
				return
			times_used++
		else	//can only use it  5 times a minute
			user.show_message(span_warning("*咔哒* *咔哒*"), 2)
			return
	playsound(src.loc, 'sound/weapons/flash.ogg', 25, 1)
	user.log_message("flashed an area with [key_name(src)]", LOG_ATTACK)
	//flick("flash2", src)

	for(var/mob/living/carbon/human/M in oviewers(3, null))
		M.flash_act()


/obj/item/flash/emp_act(severity)
	. = ..()
	if(broken)
		return
	flash_recharge()
	switch(times_used)
		if(0 to 5)
			if(prob(2*times_used))
				broken = 1
				icon_state = "flashburnt"
				return
			times_used++
			if(iscarbon(loc))
				var/mob/living/carbon/M = loc
				if(M.flash_act())
					M.Paralyze(20 SECONDS)
					M.visible_message(span_disarm("[M]被闪光灯闪瞎了!"))

/obj/item/flash/synthetic
	name = "合成闪光灯"
	desc = "当问题出现时,科学就是解决方案."
	icon_state = "sflash"

/obj/item/flash/synthetic/attack(mob/living/M as mob, mob/user as mob)
	..()
	if(!broken)
		broken = 1
		to_chat(user, span_warning("灯泡烧坏了!"))
		icon_state = "flashburnt"

/obj/item/flash/synthetic/attack_self(mob/living/carbon/user as mob, flag = 0, emp = 0)
	..()
	if(!broken)
		broken = 1
		to_chat(user, span_warning("灯泡烧坏了!"))
		icon_state = "flashburnt"
