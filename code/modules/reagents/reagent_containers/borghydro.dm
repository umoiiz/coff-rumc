
/obj/item/reagent_containers/borghypo
	name = "机器人高压注射器"
	desc = "一种先进的化学合成与注射系统,专为重型医疗设备设计."
	icon = 'icons/obj/items/syringe.dmi'
	worn_icon_state = "hypo"
	icon_state = "borghypo"
	amount_per_transfer_from_this = 5
	volume = 30
	possible_transfer_amounts = null
	var/mode = 1
	var/charge_cost = 50
	var/charge_tick = 0
	var/recharge_time = 2 //Time it takes for shots to recharge (in seconds)

	var/list/reagent_ids = list(/datum/reagent/medicine/tricordrazine, /datum/reagent/medicine/bicaridine, /datum/reagent/medicine/kelotane, /datum/reagent/medicine/dexalinplus, /datum/reagent/medicine/dylovene, /datum/reagent/medicine/inaprovaline, /datum/reagent/medicine/tramadol, /datum/reagent/medicine/imidazoline, /datum/reagent/medicine/spaceacillin, /datum/reagent/medicine/quickclot)
	var/list/reagent_volumes = list()
	var/list/reagent_names = list()

/obj/item/reagent_containers/borghypo/Initialize(mapload)
	. = ..()

	for(var/T in reagent_ids)
		reagent_volumes[T] = volume
		var/datum/reagent/R = GLOB.chemical_reagents_list[T]
		reagent_names += R.name

	START_PROCESSING(SSobj, src)


/obj/item/reagent_containers/borghypo/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/reagent_containers/borghypo/process() //Every [recharge_time] seconds, recharge some reagents for the cyborg+
	if(++charge_tick < recharge_time)
		return 0
	charge_tick = 0

	return 1

/obj/item/reagent_containers/borghypo/attack(mob/living/M as mob, mob/user as mob)
	if(!istype(M))
		return

	if(!reagent_volumes[reagent_ids[mode]])
		to_chat(user, span_warning("注射器是空的."))
		return

	to_chat(user, span_notice("你使用注射器注射了[M]."))
	to_chat(M, span_notice("[user]使用注射器注射了你."))
	playsound(loc, 'sound/items/hypospray.ogg', 50, 1)

	reagents.reaction(M, INJECT)
	if(M.reagents)
		var/t = min(amount_per_transfer_from_this, reagent_volumes[reagent_ids[mode]])
		M.reagents.add_reagent(reagent_ids[mode], t)
		reagent_volumes[reagent_ids[mode]] -= t
		// to_chat(user, span_notice("[t] units injected. [reagent_volumes[reagent_ids[mode]]] units remaining."))
		to_chat(user, span_notice("[t]单位的<span class='warning'>[reagent_ids[mode]]<span class='notice'>已注射,总计<span class='warning'>[round(M.reagents.get_reagent_amount(reagent_ids[mode]))]<span class='notice'>. 剩余[reagent_volumes[reagent_ids[mode]]]单位."))

/obj/item/reagent_containers/borghypo/attack_self(mob/user)
	var/selection = tgui_input_list(user, "请选择一种试剂:", "试剂", reagent_ids)
	if(!selection)
		return
	var/datum/reagent/R = GLOB.chemical_reagents_list[selection]
	to_chat(user, span_notice("合成器现在正在生产'[R.name]'."))
	mode = reagent_ids.Find(selection)
	playsound(src.loc, 'sound/effects/pop.ogg', 15, 0)


/obj/item/reagent_containers/borghypo/examine(mob/user)
	. = ..()
	if (user != loc)
		return

	var/datum/reagent/R = GLOB.chemical_reagents_list[reagent_ids[mode]]

	. += span_notice("它当前正在生产[R.name],剩余[reagent_volumes[reagent_ids[mode]]]单位,共[volume]单位.")
