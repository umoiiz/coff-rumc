#define LARVAL_HUGGER "larval hugger"
#define CLAWED_HUGGER "clawed hugger"
#define NEURO_HUGGER "neurotoxin hugger"
#define ACID_HUGGER "acid hugger"
#define RESIN_HUGGER "resin hugger"
#define OZELOMELYN_HUGGER "ozelomelyn hugger"

//List of huggie types
GLOBAL_LIST_INIT(hugger_type_list, list(
	/obj/item/clothing/mask/facehugger/larval,
	/obj/item/clothing/mask/facehugger/combat/slash,
	/obj/item/clothing/mask/facehugger/combat/chem_injector/ozelomelyn,
	/obj/item/clothing/mask/facehugger/combat/acid,
	/obj/item/clothing/mask/facehugger/combat/resin,
))

GLOBAL_LIST_INIT(hugger_to_ammo, list(
	/obj/item/clothing/mask/facehugger/larval = /datum/ammo/xeno/hugger,
	/obj/item/clothing/mask/facehugger/combat/slash = /datum/ammo/xeno/hugger/slash,
	/obj/item/clothing/mask/facehugger/combat/chem_injector/ozelomelyn = /datum/ammo/xeno/hugger/ozelomelyn,
	/obj/item/clothing/mask/facehugger/combat/acid = /datum/ammo/xeno/hugger/acid,
	/obj/item/clothing/mask/facehugger/combat/resin = /datum/ammo/xeno/hugger/resin,
))

//List of huggie images
GLOBAL_LIST_INIT(hugger_images_list,  list(
	LARVAL_HUGGER = image('icons/Xeno/actions/carrier.dmi', icon_state = LARVAL_HUGGER),
	CLAWED_HUGGER = image('icons/Xeno/actions/carrier.dmi', icon_state = CLAWED_HUGGER),
	OZELOMELYN_HUGGER = image('icons/Xeno/actions/carrier.dmi', icon_state = OZELOMELYN_HUGGER),
	ACID_HUGGER = image('icons/Xeno/actions/carrier.dmi', icon_state = ACID_HUGGER),
	RESIN_HUGGER = image('icons/Xeno/actions/carrier.dmi', icon_state = RESIN_HUGGER),
))

// ***************************************
// *********** Hugger throw
// ***************************************
/datum/action/ability/activable/xeno/throw_hugger
	name = "Use/Throw Facehugger"
	desc = "向某物投掷一只抱脸虫. 对已经在地面上的抱脸虫使用此能力会将其回收至你的储存中."
	action_icon_state = "throw_hugger"
	action_icon = 'icons/Xeno/actions/carrier.dmi'
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_THROW_HUGGER,
	)
	cooldown_duration = 2 SECONDS

/datum/action/ability/activable/xeno/throw_hugger/get_cooldown()
	return xeno_owner.xeno_caste.hugger_delay

/datum/action/ability/activable/xeno/throw_hugger/can_use_ability(atom/A, silent = FALSE, override_flags) // true
	. = ..()
	if(!.)
		return FALSE
	if(!A)
		return FALSE

/datum/action/ability/activable/xeno/throw_hugger/use_ability(atom/A)
	//target a hugger on the ground to store it directly
	if(istype(A, /obj/item/clothing/mask/facehugger))
		if(isturf(get_turf(A)) && xeno_owner.Adjacent(A))
			if(!xeno_owner.issamexenohive(A))
				to_chat(xeno_owner, span_warning("那个抱脸虫已被污染!"))
				xeno_owner.dropItemToGround(A)
				return fail_activate()
			xeno_owner.store_hugger(A)
			return succeed_activate()

	var/obj/item/clothing/mask/facehugger/F = xeno_owner.get_active_held_item()
	if(!istype(F) || F.stat == DEAD) //empty active hand
		//if no hugger in active hand, we take one from our storage
		if(!xeno_owner.huggers)
			to_chat(xeno_owner, span_warning("我们没有可用的抱脸虫!"))
			return fail_activate()

		F = new xeno_owner.selected_hugger_type(get_turf(xeno_owner), xeno_owner.hivenumber, xeno_owner)
		xeno_owner.huggers--

		xeno_owner.put_in_active_hand(F)
		to_chat(xeno_owner, span_xenonotice("我们从储存中取出一只抱脸虫. 现在庇护中: [xeno_owner.huggers] / [xeno_owner.xeno_caste.huggers_max]."))

	if(!cooldown_timer)
		xeno_owner.dropItemToGround(F)
		playsound(xeno_owner, SFX_THROW, 30, TRUE)
		F.stat = CONSCIOUS //Hugger is conscious
		F.leaping = FALSE //Hugger is not leaping
		F.facehugger_register_source(xeno_owner) //Set us as the source
		F.throw_at(A, CARRIER_HUGGER_THROW_DISTANCE, CARRIER_HUGGER_THROW_SPEED)
		xeno_owner.visible_message(span_xenowarning("\The [xeno_owner] 朝 \the [A] 扔出了什么东西!"), \
		span_xenowarning("我们朝 \the [A] 扔出了一只抱脸虫!"))
		add_cooldown()
		return succeed_activate()

/mob/living/carbon/xenomorph/proc/store_hugger(obj/item/clothing/mask/facehugger/F, message = TRUE, forced = FALSE) //todo: wrap this into ability
	if(huggers < xeno_caste.huggers_max)
		if(F.stat == DEAD && !forced)
			to_chat(src, span_notice("这只抱脸虫已经过期, 我们无法回收它."))
			return
		F.kill_hugger()
		huggers++
		if(message)
			playsound(src, 'sound/voice/alien/drool2.ogg', 50, 0, 1)
			to_chat(src, span_notice("我们回收这只抱脸虫的生物质来生产另一只. 现在庇护中: [huggers] / [xeno_caste.huggers_max]."))
	else if(message)
		to_chat(src, span_warning("我们无法携带更多抱脸虫了!"))

// ***************************************
// ********* Trap
// ***************************************
/datum/action/ability/xeno_action/place_trap
	name = "Place trap"
	desc = "在杂草上放置一个坑洞, 可以用抱脸虫、液态酸或酸气填充. 当陆战队员踩上去时激活."
	action_icon_state = "small_trap"
	action_icon = 'icons/Xeno/actions/construction.dmi'
	ability_cost = 200
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PLACE_TRAP,
	)
	use_state_flags = ABILITY_USE_LYING

/datum/action/ability/xeno_action/place_trap/can_use_action(silent = FALSE, override_flags)
	. = ..()
	var/turf/T = get_turf(owner)
	if(!T || !T.is_weedable() || T.density)
		if(!silent)
			to_chat(owner, span_warning("我们无法在这里这么做."))
		return FALSE

	if(!xeno_owner.loc_weeds_type)
		if(!silent)
			to_chat(owner, span_warning("我们只能在杂草上塑形. 在开始建造前我们必须先找到一些树脂!"))
		return FALSE

	if(!T.check_alien_construction(owner, silent, /obj/structure/xeno/trap) || !T.check_disallow_alien_fortification(owner, silent))
		return FALSE

/datum/action/ability/xeno_action/place_trap/action_activate()
	var/turf/T = get_turf(owner)

	succeed_activate()

	playsound(T, SFX_ALIEN_RESIN_BUILD, 25)
	GLOB.round_statistics.trap_holes++
	SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "carrier_traps")
	owner.record_traps_created()
	new /obj/structure/xeno/trap(T, owner.get_xeno_hivenumber())
	to_chat(owner, span_xenonotice("我们在杂草上放置了一个陷阱, 但它仍需要被填充."))

// ***************************************
// *********** Spawn hugger
// ***************************************
/datum/action/ability/xeno_action/spawn_hugger
	name = "Spawn Facehugger"
	desc = "生成一只储存在你身上的抱脸虫."
	action_icon_state = "spawn_hugger"
	action_icon = 'icons/Xeno/actions/carrier.dmi'
	ability_cost = 150
	cooldown_duration = 5 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_SPAWN_HUGGER,
	)
	use_state_flags = ABILITY_USE_LYING

/datum/action/ability/xeno_action/spawn_hugger/on_cooldown_finish()
	to_chat(owner, span_xenodanger("我们现在可以再生成一只抱脸虫."))
	owner.playsound_local(owner, 'sound/effects/alien/newlarva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/xeno_action/spawn_hugger/can_use_action(silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(xeno_owner.huggers >= xeno_owner.xeno_caste.huggers_max)
		if(!silent)
			to_chat(xeno_owner, span_xenowarning("我们无法再寄宿更多抱脸虫了!"))
		return FALSE

/datum/action/ability/xeno_action/spawn_hugger/action_activate()
	xeno_owner.huggers++
	to_chat(xeno_owner, span_xenowarning("我们通过无性体内繁殖的奇迹生成一只抱脸虫, 将其加入我们的储备. 现在庇护中: [xeno_owner.huggers] / [xeno_owner.xeno_caste.huggers_max]."))
	playsound(xeno_owner, 'sound/voice/alien/drool2.ogg', 50, 0, 1)
	succeed_activate()
	add_cooldown()
	if(owner.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
		personal_statistics.huggers_created++

// ***************************************
// *********** Set Hugger Reserve
// ***************************************
// Set hugger reserve
/datum/action/ability/xeno_action/set_hugger_reserve
	name = "Set Hugger Reserve"
	desc = "设置你想从观察者手中保留的抱脸虫数量."
	action_icon_state = "hugger_set"
	action_icon = 'icons/Xeno/actions/carrier.dmi'
	use_state_flags = ABILITY_USE_LYING

/datum/action/ability/xeno_action/set_hugger_reserve/give_action(mob/living/L)
	. = ..()
	xeno_owner.xeno_caste.huggers_reserved = xeno_owner.xeno_caste.huggers_max

/datum/action/ability/xeno_action/set_hugger_reserve/action_activate()
	var/number = tgui_input_number(usr, "你想保护多少只抱脸虫不被想要作为抱脸虫加入的观察者占用?", "保留多少只?", xeno_owner.xeno_caste.huggers_reserved, xeno_owner.xeno_caste.huggers_max)
	if(!isnull(number))
		xeno_owner.xeno_caste.huggers_reserved = number
	to_chat(xeno_owner, span_notice("你为自己保留了 [xeno_owner.xeno_caste.huggers_reserved] 只抱脸虫."))
	xeno_owner.balloon_alert(xeno_owner, "已保留 [xeno_owner.xeno_caste.huggers_reserved] 只抱脸虫")

	return succeed_activate()

// ***************************************
// *********** Drop all hugger, panic button
// ***************************************
/datum/action/ability/xeno_action/carrier_panic
	name = "Drop All Facehuggers"
	desc = "在一阵恐慌中丢下所有储存的抱脸虫. 消耗所有剩余等离子体!"
	action_icon_state = "carrier_panic"
	action_icon = 'icons/Xeno/actions/carrier.dmi'
	ability_cost = 10
	cooldown_duration = 50 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_DROP_ALL_HUGGER,
	)
	use_state_flags = ABILITY_USE_LYING

/datum/action/ability/xeno_action/carrier_panic/give_action(mob/living/L)
	. = ..()
	RegisterSignal(owner, COMSIG_MOB_DEATH, PROC_REF(do_activate))

/datum/action/ability/xeno_action/carrier_panic/remove_action(mob/living/L)
	UnregisterSignal(owner, COMSIG_MOB_DEATH)
	return ..()

/// Helper proc for action acitvation via signal
/datum/action/ability/xeno_action/carrier_panic/proc/do_activate()
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(action_activate))

/datum/action/ability/xeno_action/carrier_panic/can_use_action(silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(xeno_owner.health > (xeno_owner.maxHealth * 0.56))
		if(!silent)
			to_chat(xeno_owner, span_xenowarning("我们还没有受伤到会恐慌的程度!"))
		return FALSE
	if(xeno_owner.huggers < 1)
		if(!silent)
			to_chat(xeno_owner, span_xenowarning("我们没有任何抱脸虫可丢下!"))
		return FALSE

/datum/action/ability/xeno_action/carrier_panic/action_activate()
	if(!xeno_owner.huggers)
		return

	xeno_owner.visible_message(span_xenowarning("一团叽叽喳喳的微小异形正试图从 [xeno_owner] 中逃出!"))
	while(xeno_owner.huggers > 0)
		var/obj/item/clothing/mask/facehugger/new_hugger = new /obj/item/clothing/mask/facehugger/larval(get_turf(xeno_owner), xeno_owner.hivenumber, xeno_owner)
		step_away(new_hugger, xeno_owner, 1)
		addtimer(CALLBACK(new_hugger, TYPE_PROC_REF(/obj/item/clothing/mask/facehugger, go_active), TRUE), new_hugger.jump_cooldown)
		xeno_owner.huggers--
	succeed_activate(INFINITY) //Consume all remaining plasma
	add_cooldown()

// ***************************************
// *********** Choose Hugger Type
// ***************************************
// Choose Hugger Type
/datum/action/ability/xeno_action/choose_hugger_type
	name = "Choose Hugger Type"
	desc = "选择你在使用/投掷抱脸虫能力时将使用的抱脸虫类型."
	action_icon_state = "facehugger"
	action_icon = 'icons/Xeno/actions/carrier.dmi'
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CHOOSE_HUGGER,
		KEYBINDING_ALTERNATE = COMSIG_XENOABILITY_SWITCH_HUGGER,
	)
	use_state_flags = ABILITY_USE_LYING

/datum/action/ability/xeno_action/choose_hugger_type/give_action(mob/living/L)
	. = ..()
	xeno_owner.selected_hugger_type = GLOB.hugger_type_list[1] //Set our default
	update_button_icon() //Update immediately to get our default

/datum/action/ability/xeno_action/choose_hugger_type/update_button_icon()
	var/atom/A = xeno_owner.selected_hugger_type
	action_icon_state = initial(A.name)
	return ..()

/datum/action/ability/xeno_action/choose_hugger_type/alternate_action_activate()
	var/i = GLOB.hugger_type_list.Find(xeno_owner.selected_hugger_type)
	if(length(GLOB.hugger_type_list) == i)
		xeno_owner.selected_hugger_type = GLOB.hugger_type_list[1]
	else
		xeno_owner.selected_hugger_type = GLOB.hugger_type_list[i+1]

	var/atom/A = xeno_owner.selected_hugger_type
	to_chat(xeno_owner, span_notice("我们现在在使用生成抱脸虫能力时将生成 <b>[initial(A.name)]\s </b>."))
	xeno_owner.balloon_alert(xeno_owner,"[initial(A.name)]")
	update_button_icon()
	succeed_activate()
	return COMSIG_KB_ACTIVATED

/datum/action/ability/xeno_action/choose_hugger_type/action_activate()
	var/hugger_choice = show_radial_menu(owner, owner, GLOB.hugger_images_list, radius = 48)
	if(!hugger_choice)
		return
	for(var/obj/item/clothing/mask/facehugger/hugger_type AS in GLOB.hugger_type_list)
		if(initial(hugger_type.name) == hugger_choice)
			xeno_owner.selected_hugger_type = hugger_type
			break
	to_chat(xeno_owner, span_notice("我们现在在使用生成抱脸虫能力时将生成 <b>[hugger_choice]\s </b>."))
	xeno_owner.balloon_alert(xeno_owner, "[hugger_choice]")
	update_button_icon()
	return succeed_activate()

/datum/action/ability/xeno_action/build_hugger_turret
	name = "Build Hugger Turret"
	desc = "建造一座会向敌方陆战队员发射抱脸虫的炮塔. 建造炮塔时当前选中的抱脸虫类型将决定发射的抱脸虫类型."
	action_icon_state = "hugger_turret"
	action_icon = 'icons/Xeno/actions/carrier.dmi'
	ability_cost = 800
	cooldown_duration = 5 MINUTES
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_BUILD_HUGGER_TURRET,
	)

/datum/action/ability/xeno_action/build_hugger_turret/can_use_action(silent, override_flags)
	. = ..()
	var/turf/T = get_turf(owner)
	var/mob/living/carbon/xenomorph/blocker = locate() in T
	if(blocker && blocker != owner && blocker.stat != DEAD)
		if(!silent)
			to_chat(owner, span_xenowarning("[blocker] 挡路了, 你无法建造!"))
		return FALSE

	if(!T.is_weedable())
		return FALSE

	if(!xeno_owner.loc_weeds_type)
		if(!silent)
			to_chat(owner, span_xenowarning("这里没有杂草!"))
		return FALSE

	if(!T.check_alien_construction(owner, silent, /obj/structure/xeno/turret) || !T.check_disallow_alien_fortification(owner))
		return FALSE

	for(var/obj/structure/xeno/turret/turret AS in GLOB.xeno_resin_turrets_by_hive[blocker.hivenumber])
		if(get_dist(turret, owner) < 6)
			if(!silent)
				to_chat(owner, span_xenowarning("另一座炮塔太近了!"))
			return FALSE

/datum/action/ability/xeno_action/build_hugger_turret/action_activate()
	if(!do_after(owner, 10 SECONDS, NONE, owner, BUSY_ICON_BUILD))
		return FALSE

	if(!can_use_action())
		return FALSE

	var/obj/structure/xeno/turret/facehugger/turret = new (get_turf(owner), xeno_owner.hivenumber)
	turret.ammo = GLOB.ammo_list[GLOB.hugger_to_ammo[xeno_owner.selected_hugger_type]]
	succeed_activate()
	add_cooldown()

// ***************************************
// *********** Call of Younger
// ***************************************

/datum/action/ability/activable/xeno/call_younger
	name = "Call of Younger"
	desc = "向陆战队员体内的幼体发出呼唤. 陆战队员失去平衡, 幼体的成长进度加快."
	action_icon_state = "call_younger"
	action_icon = 'icons/Xeno/actions/carrier.dmi'
	ability_cost = 150
	cooldown_duration = 10 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CALL_YOUNGER,
	)

/datum/action/ability/activable/xeno/call_younger/can_use_ability(atom/A, silent, override_flags)
	. = ..()
	if(!.)
		return

	if(!ishuman(A))
		if(!silent)
			A.balloon_alert(owner, "非人类")
		return FALSE

	var/mob/living/carbon/human/target = A

	if(!(locate(/obj/item/alien_embryo) in target))
		if(!silent)
			target.balloon_alert(owner, "未感染")
		return FALSE

	if(target.stat == DEAD)
		if(!silent)
			target.balloon_alert(owner, "死亡")
		return FALSE

	if(!line_of_sight(owner, target, 9))
		if(!silent)
			target.balloon_alert(owner, "需要视线")
		return FALSE
	return TRUE

/datum/action/ability/activable/xeno/call_younger/use_ability(atom/A)
	var/mob/living/carbon/human/victim = A

	owner.face_atom(victim)

	if(!do_after(xeno_owner, 0.5 SECONDS, NONE, xeno_owner, BUSY_ICON_DANGER, extra_checks = CALLBACK(src, PROC_REF(can_use_ability), A, FALSE, ABILITY_USE_BUSY)))
		return fail_activate()
	if(!can_use_ability(A))
		return fail_activate()

	var/obj/item/alien_embryo/young = locate() in victim
	var/debuff = young.stage + 1
	var/stamina_dmg = (victim.maxHealth + victim.max_stamina) * (debuff + xeno_owner.xeno_caste.aura_strength) * 0.1

	xeno_owner.emote("roar5")
	victim.emote("scream")
	owner.visible_message(span_xenowarning("\the [owner] 发出了一声不寻常的咆哮!"), \
	span_xenowarning("我们向 [victim] 体内的年幼者发出了呼唤!"))
	victim.visible_message(span_xenowarning("\The [victim] 失去 [victim.p_their()] 平衡, 倒向一侧!"), \
	span_xenowarning("你感觉体内的什么东西正在撕裂而出!"))

	victim.apply_effects(2 SECONDS, 1 SECONDS)
	victim.adjust_stagger(debuff SECONDS)
	victim.adjust_slowdown(debuff)
	victim.apply_damage(stamina_dmg, STAMINA)

	var/datum/internal_organ/O
	for(var/i in list(ORGAN_SLOT_HEART, ORGAN_SLOT_LUNGS, ORGAN_SLOT_LIVER, ORGAN_SLOT_STOMACH))
		O = victim.get_organ_slot(i)
		O.take_damage(debuff, TRUE)

	young.adjust_boost_timer(20, 40)

	if(!CHECK_BITFIELD(victim.restrained_flags, RESTRAINED_XENO_NEST))
		if(young.stage <= 1)
			victim.throw_at(owner, 2, 1, owner)
		else if(young.stage > 1 && young.stage <= 5)
			victim.throw_at(owner, 3, 1, owner)
		else if(young.stage == 6)
			victim.throw_at(owner, 4, 1, owner)

	succeed_activate()
	add_cooldown()

// ***************************************
// *********** Build nest
// ***************************************

/datum/action/ability/xeno_action/build_nest
	name = "Build nest"
	desc = "为主人建造巢穴"
	action_icon_state = ALIEN_NEST
	action_icon = 'icons/Xeno/actions/construction.dmi'
	ability_cost = 200
	cooldown_duration = 20 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_SECRETE_RESIN,
	)

/datum/action/ability/xeno_action/build_nest/can_use_action(silent, override_flags)
	. = ..()
	var/turf/T = get_turf(xeno_owner)
	var/mob/living/carbon/xenomorph/blocker = locate() in T
	if(blocker && blocker != xeno_owner && blocker.stat != DEAD)
		if(!silent)
			to_chat(xeno_owner, span_xenowarning("[blocker] 挡路了, 你无法建造!"))
		return FALSE

	if(!T.is_weedable())
		return FALSE

	if(!xeno_owner.loc_weeds_type)
		if(!silent)
			to_chat(xeno_owner, span_xenowarning("这里没有杂草!"))
		return FALSE

	if(!T.check_alien_construction(xeno_owner, silent, /obj/structure/bed/nest) || !T.check_disallow_alien_fortification(xeno_owner))
		return FALSE

/datum/action/ability/xeno_action/build_nest/action_activate()
	var/turf/T = get_turf(owner)
	for(var/obj/structure/bed/nest/nest in range(2, T))
		owner.balloon_alert(owner, "另一个巢穴太近了!")
		return FALSE

	if(!do_after(owner, 2 SECONDS, NONE, owner, BUSY_ICON_BUILD))
		return FALSE

	if(!can_use_action())
		return FALSE

	new /obj/structure/bed/nest(T)
	playsound(T, SFX_ALIEN_RESIN_BUILD, 25)
	succeed_activate()
	add_cooldown()
