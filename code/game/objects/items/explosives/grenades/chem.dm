#define CG_EMPTY 1
#define CG_WIRED 2
#define CG_READY 3

/obj/item/explosive/grenade/chem_grenade
	name = "化学手雷"
	desc = "一枚定制手雷."
	icon_state = "chemg"
	worn_icon_state = "flashbang"
	w_class = WEIGHT_CLASS_SMALL
	force = 2
	overlay_type = null
	var/stage = CG_EMPTY
	var/display_timer = FALSE
	var/list/obj/item/reagent_containers/glass/beakers = list()
	var/list/allowed_containers = list(/obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/glass/bottle)
	var/list/banned_containers = list(/obj/item/reagent_containers/glass/beaker/bluespace) //Containers to exclude from specific grenade subtypes
	var/affected_area = 3
	var/obj/item/assembly_holder/nadeassembly = null
	var/assemblyattacher
	var/ignition_temp = 10 // The amount of heat added to the reagents when this grenade goes off.
	var/threatscale = 1 // Used by advanced grenades to make them slightly more worthy.
	var/no_splash = FALSE //If the grenade deletes even if it has no reagents to splash with. Used for slime core reactions.
	var/casedesc = "This basic model accepts both beakers and bottles. It heats contents by 10°K upon ignition." // Appears when examining empty casings.


/obj/item/explosive/grenade/chem_grenade/Initialize(mapload)
	. = ..()
	create_reagents(1000)
	stage_change() // If no argument is set, it will change the stage to the current stage, useful for stock grenades that start READY.

/obj/item/explosive/grenade/chem_grenade/Destroy()
	QDEL_LIST(beakers)
	QDEL_NULL(nadeassembly)
	return ..()

/obj/item/explosive/grenade/chem_grenade/attack_self(mob/user)
	if(stage == CG_READY && !active)
		if(nadeassembly)
			nadeassembly.attack_self(user)
		else
			return ..()

/obj/item/explosive/grenade/chem_grenade/razorburn_small/attackby(obj/item/I, mob/user, params)
	to_chat(user, span_notice("[initial(name)]是密封的,无法打开."))
	return

/obj/item/explosive/grenade/chem_grenade/razorburn_large/attackby(obj/item/I, mob/user, params)
	to_chat(user, span_notice("[initial(name)]是密封的,无法打开."))
	return

/obj/item/explosive/grenade/chem_grenade/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(stage == CG_WIRED)
			if(!length(beakers))
				to_chat(user, span_warning("在锁定[initial(name)]组件之前,你至少需要添加一个烧杯!"))
			else
				stage_change(CG_READY)
				to_chat(user, span_notice("你锁定了[initial(name)]组件."))
				I.play_tool_sound(src, 25)

		else if(stage == CG_READY && !nadeassembly)
			det_time = det_time == 50 ? 30 : 50	//toggle between 30 and 50
			to_chat(user, span_notice("你修改了时间延迟.它被设定为[DisplayTimeText(det_time)]."))
		else if(stage == CG_EMPTY)
			to_chat(user, span_warning("你需要添加一个激活机制!"))

	else if(stage == CG_WIRED && is_type_in_list(I, allowed_containers))
		. = TRUE //no afterattack
		if(is_type_in_list(I, banned_containers))
			to_chat(user, span_warning("[src]太小了,装不下[I]!")) // this one hits home huh anon?
			return
		if(length(beakers) == 2)
			to_chat(user, span_warning("[src]无法容纳更多容器!"))
			return
		else
			if(I.reagents.total_volume)
				if(!user.transferItemToLoc(I, src))
					return
				to_chat(user, span_notice("你将[I]添加到[initial(name)]组件中."))
				beakers += I
				var/reagent_list = pretty_string_from_reagent_list(I.reagents)
				user.log_message("inserted [I] ([reagent_list]) into [src]",LOG_GAME)
			else
				to_chat(user, span_warning("[I]是空的!"))

	else if(stage == CG_EMPTY && istype(I, /obj/item/assembly_holder))
		. = 1 // no afterattack
		var/obj/item/assembly_holder/A = I
		if(isigniter(A.a_left) == isigniter(A.a_right))	//Check if either part of the assembly has an igniter, but if both parts are igniters, then fuck it
			return
		if(!user.transferItemToLoc(I, src))
			return

		nadeassembly = A
		A.master = src
		assemblyattacher = user.ckey

		stage_change(CG_WIRED)
		to_chat(user, span_notice("你将[A]添加到[initial(name)]组件中."))

	else if(stage == CG_EMPTY && istype(I, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/C = I
		if (C.use(1))
			det_time = 50 // In case the cable_coil was removed and readded.
			stage_change(CG_WIRED)
			to_chat(user, span_notice("你组装好了[initial(name)]组件."))
		else
			to_chat(user, span_warning("你需要一段线圈来给组件接线!"))
			return

	else if(stage == CG_READY && I.tool_behaviour == TOOL_WIRECUTTER && !active)
		to_chat(user, span_notice("获得专利的防陆战队员Dura-Cable电缆阻止你拆解这枚手雷."))
		return

	else if(stage == CG_WIRED && I.tool_behaviour == TOOL_WRENCH)
		if(length(beakers))
			for(var/obj/O in beakers)
				O.forceMove(drop_location())
				if(!O.reagents)
					continue
				var/reagent_list = pretty_string_from_reagent_list(O.reagents)
				user.log_message("removed [O] ([reagent_list]) from [src]", LOG_GAME)
			beakers = list()
			to_chat(user, span_notice("你打开[initial(name)]组件并取出装填物."))
			return // First use of the wrench remove beakers, then use the wrench to remove the activation mechanism.
		if(nadeassembly)
			nadeassembly.forceMove(drop_location())
			nadeassembly.master = null
			nadeassembly = null
		else // If "nadeassembly = null && stage == CG_WIRED", then it most have been cable_coil that was used.
			new /obj/item/stack/cable_coil(get_turf(src),1)
		stage_change(CG_EMPTY)
		to_chat(user, span_notice("你从[initial(name)]组件中移除了激活机制."))
	else
		return ..()


/obj/item/explosive/grenade/chem_grenade/examine(mob/user)
	display_timer = (stage == CG_READY && !nadeassembly)	//show/hide the timer based on assembly state
	. = ..()
	if((user.skills.getRating(SKILL_MEDICAL) > SKILL_MEDICAL_NOVICE) || isobserver(usr))
		if(length(beakers))
			. += span_notice("你扫描了手雷,检测到以下试剂:")
			for(var/obj/item/reagent_containers/glass/G in beakers)
				for(var/datum/reagent/R in G.reagents.reagent_list)
					. += span_notice("[G.name]中有[R.volume]单位的[R.name].")
			if(length(beakers) == 1)
				. += span_notice("你在手雷中没有检测到第二个烧杯.")
		else
			. += span_notice("你扫描了手雷,但什么也没检测到.")
	else if(stage != CG_READY && length(beakers))
		if(length(beakers) == 2 && beakers[1].name == beakers[2].name)
			. += span_notice("你看到手雷内有两个[beakers[1].name].")
		else
			for(var/obj/item/reagent_containers/glass/G in beakers)
				. += span_notice("你看到手雷内有一个[G.name].")


/obj/item/explosive/grenade/chem_grenade/proc/stage_change(N)
	if(N)
		stage = N
	if(stage == CG_EMPTY)
		name = "[initial(name)] casing"
		desc = "A do it yourself [initial(name)]! [initial(casedesc)]"
		icon_state = initial(icon_state)
	else if(stage == CG_WIRED)
		name = "unsecured [initial(name)]"
		desc = "An unsecured [initial(name)] assembly."
		icon_state = "[initial(icon_state)]_ass"
	else if(stage == CG_READY)
		name = initial(name)
		desc = initial(desc)
		icon_state = "[initial(icon_state)]_locked"


/obj/item/explosive/grenade/chem_grenade/receive_signal()
	prime()


/obj/item/explosive/grenade/chem_grenade/prime()
	if(stage != CG_READY)
		return

	var/list/datum/reagents/reactants = list()
	for(var/obj/item/reagent_containers/glass/G in beakers)
		reactants += G.reagents

	var/turf/detonation_turf = get_turf(src)

	if(!chem_splash(detonation_turf, affected_area, reactants, ignition_temp, threatscale) && !no_splash)
		playsound(src, 'sound/items/screwdriver2.ogg', 50, 1)
		if(length(beakers))
			for(var/obj/O in beakers)
				O.forceMove(drop_location())
			beakers = list()
		stage_change(CG_EMPTY)
		return

	if(nadeassembly)
		var/mob/M = get_mob_by_ckey(assemblyattacher)

		log_bomber(M, "primed", src)

	if(ismob(loc))
		var/mob/M = loc
		M.dropItemToGround(src)

	qdel(src)


/obj/item/explosive/grenade/chem_grenade/large
	name = "大型化学手雷"
	desc = "一枚超大尺寸的手雷,影响范围更大."
	icon_state = "large_grenade"
	allowed_containers = list(/obj/item/reagent_containers/glass)
	affected_area = 4


/obj/item/explosive/grenade/chem_grenade/metalfoam
	name = "金属泡沫手雷"
	desc = "用于紧急封堵漏气口."
	dangerous = FALSE
	stage = CG_READY


/obj/item/explosive/grenade/chem_grenade/metalfoam/Initialize(mapload, ...)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(/datum/reagent/aluminum, 30)
	B2.reagents.add_reagent(/datum/reagent/foaming_agent, 10)
	B2.reagents.add_reagent(/datum/reagent/toxin/acid/polyacid, 10)

	beakers += B1
	beakers += B2
	icon_state = initial(icon_state) +"_locked"


/obj/item/explosive/grenade/chem_grenade/razorburn_small
	name = "剃刀燃烧手雷"
	desc = "内含建筑纳米机器人,准备在几秒后将一小片区域变成剃刀铁丝网.激活期间请勿进入该区域."
	icon_state = "grenade_razorburn"
	worn_icon_state = "grenade_razorburn"
	hud_state = "grenade_razor"
	stage = CG_READY
	icon_state_mini = "grenade_chem_yellow"
	overlay_type = "yellow"


/obj/item/explosive/grenade/chem_grenade/razorburn_small/Initialize(mapload, ...)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(/datum/reagent/toxin/nanites, 10) // 1 tile radius
	B2.reagents.add_reagent(/datum/reagent/foaming_agent, 5)

	beakers += B1
	beakers += B2
	icon_state = initial(icon_state) +"_locked"

/obj/item/explosive/grenade/chem_grenade/razorburn_large
	name = "剃刀燃烧罐"
	desc = "内含建筑纳米机器人,准备在几秒后将一大片区域变成剃刀铁丝网.激活期间请勿进入该区域."
	icon_state = "grenade_large_razorburn"
	stage = CG_READY
	icon_state_mini = "grenade_chem_yellow"
	overlay_type = "yellow"


/obj/item/explosive/grenade/chem_grenade/razorburn_large/Initialize(mapload, ...)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(/datum/reagent/toxin/nanites, 40) // 3 tile radius
	B2.reagents.add_reagent(/datum/reagent/foaming_agent, 30)

	beakers += B1
	beakers += B2
	icon_state = initial(icon_state) +"_locked"





/obj/item/explosive/grenade/chem_grenade/incendiary
	name = "燃烧手雷"
	desc = "用于清空房间内的活物."
	stage = CG_READY


/obj/item/explosive/grenade/chem_grenade/incendiary/Initialize(mapload, ...)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(/datum/reagent/aluminum, 30)
	B1.reagents.add_reagent(/datum/reagent/toxin/acid,30)
	B2.reagents.add_reagent(/datum/reagent/toxin/phoron, 60)

	beakers += B1
	beakers += B2
	icon_state = initial(icon_state) +"_locked"


/obj/item/explosive/grenade/chem_grenade/antiweed
	name = "除草手雷"
	desc = "用于清除大片区域的入侵植物物种.内含压力物质.请勿直接吸入内容物."
	dangerous = FALSE
	stage = CG_READY


/obj/item/explosive/grenade/chem_grenade/antiweed/Initialize(mapload, ...)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(/datum/reagent/toxin/plantbgone, 25)
	B1.reagents.add_reagent(/datum/reagent/potassium, 25)
	B2.reagents.add_reagent(/datum/reagent/phosphorus, 25)
	B2.reagents.add_reagent(/datum/reagent/consumable/sugar, 25)

	beakers += B1
	beakers += B2
	icon_state = initial(icon_state) +"_locked"


/obj/item/explosive/grenade/chem_grenade/cleaner
	name = "清洁手雷"
	desc = "BLAM!品牌泡沫太空清洁剂.装在特殊喷洒器中,用于快速清洁大片区域."
	dangerous = FALSE
	stage = CG_READY


/obj/item/explosive/grenade/chem_grenade/cleaner/Initialize(mapload, ...)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(/datum/reagent/fluorosurfactant, 40)
	B2.reagents.add_reagent(/datum/reagent/water, 40)
	B2.reagents.add_reagent(/datum/reagent/space_cleaner, 10)

	beakers += B1
	beakers += B2
	icon_state = initial(icon_state) +"_locked"


/obj/item/explosive/grenade/chem_grenade/teargas
	name = "\improper M66催泪瓦斯手雷"
	desc = "用于非致命防暴控制的催泪瓦斯手雷.请佩戴足够的气体防护装备."
	stage = CG_READY


/obj/item/explosive/grenade/chem_grenade/teargas/Initialize(mapload, ...)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(/datum/reagent/consumable/capsaicin/condensed, 25)
	B1.reagents.add_reagent(/datum/reagent/potassium, 25)
	B2.reagents.add_reagent(/datum/reagent/phosphorus, 25)
	B2.reagents.add_reagent(/datum/reagent/consumable/sugar, 25)

	beakers += B1
	beakers += B2

	icon_state = initial(icon_state) +"_locked"


/obj/item/explosive/grenade/chem_grenade/teargas/attack_self(mob/user)
	if(user.skills.getRating(SKILL_POLICE) < SKILL_POLICE_MP)
		to_chat(user, span_warning("你似乎不知道怎么使用[src]..."))
		return
	return ..()

/obj/item/explosive/grenade/chem_grenade/healing_foam
	name = "\improper EMS-02治疗泡沫手雷"
	desc = "由BioCourse Pharmaceuticals设计的一种先进泡沫手雷.会释放一种泡沫,迅速治愈其中的目标."
	stage = CG_READY
	dangerous = FALSE
	icon_state = "grenade_healfoam"
	worn_icon_state = "grenade_healfoam"

/obj/item/explosive/grenade/chem_grenade/healing_foam/Initialize(mapload, ...)
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(/datum/reagent/fluorosurfactant, 30)
	B1.reagents.add_reagent(/datum/reagent/medicine/experimental_medical_salve, 15)
	B2.reagents.add_reagent(/datum/reagent/water, 30)
	B2.reagents.add_reagent(/datum/reagent/medicine/experimental_medical_salve, 15)

	beakers += B1
	beakers += B2

	icon_state = initial(icon_state) +"_locked"

/obj/item/explosive/grenade/chem_grenade/healing_foam/attackby(obj/item/I, mob/user, params)
	to_chat(user, span_notice("[initial(name)]是密封的,无法打开."))
	return

#undef CG_READY
#undef CG_WIRED
#undef CG_EMPTY
