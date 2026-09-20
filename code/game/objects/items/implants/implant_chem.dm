/obj/item/implant/chem
	name = "化学植入体"
	desc = "一种化学植入体,内含一次性化学混合剂,可通过注射器注入."
	allow_reagents = TRUE
	implant_flags = ACTIVATE_ON_HEAR|GRANT_ACTIVATION_ACTION|BENEFICIAL_IMPLANT
	var/used = FALSE
	var/activation_phrase = "aaaaaa help i dying help maint"

/obj/item/implant/chem/get_data()
	var/list/chems = list()
	for(var/datum/reagent/R AS in reagents.reagent_list)
		chems += "[R.volume] units of [R.name]<BR>"
	return {"
	<b>Implant Specifications:</b><BR>
	<b>Name:</b> Nanotrasen NX-44 ChemBoost Implant<BR>
	<HR>
	<b>Implant Details:</b><BR>
	<b>Function:</b> Upon activation injects a custom chemical mix into the user.<BR>
	<b>Current Chemical composition:</b>
	[length(chems) ? jointext(chems, ""): "None!"]
	<b>Integrity:</b> Implant is [used ? "used" : "unused"]."}


/obj/item/implant/chem/on_hear(datum/source, message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode)
	if(findtext(message, activation_phrase))
		activate()

/obj/item/implant/chem/activate(accidental = FALSE)
	. = ..()
	if(!.)
		return
	if(malfunction == MALFUNCTION_PERMANENT)
		return FALSE
	if(used)
		to_chat(implant_owner, span_warning("警告. 植入体激活失败; 错误代码345: 植入体已耗尽."))
		return FALSE
	playsound(implant_owner, 'sound/machines/buzz-two.ogg', 60, 1)
	reagents.trans_to(implant_owner, reagents.total_volume)
	used = TRUE

/obj/item/implant/chem/implant(mob/living/carbon/human/target, mob/living/user)
	activation_phrase = stripped_input(user, "Choose activation phrase:")
	if(!activation_phrase)
		return FALSE
	user.mind.store_memory("[src] in [target] will now activate by saying something containing the phrase ''[activation_phrase]'', <B>say [activation_phrase]</B> to attempt to activate.", 0, 0)
	to_chat(user, span_notice("[target]中的[src]现在可以通过说出包含短语''[activation_phrase]''的内容来激活,<B>说[activation_phrase]</B>以尝试激活."))
	return ..()

/obj/item/implant/chem/blood
	name = "血液恢复植入体"
	desc = "一种能够加速血液恢复的化学植入体,可恢复失去的血液."
	///Amount of blood added
	var/blood_amount = 200

/obj/item/implant/chem/blood/activate(accidental)
	. = ..()
	if(!.)
		return FALSE
	if(!iscarbon(implant_owner))
		return FALSE

	var/mob/living/carbon/carb_mob = implant_owner
	carb_mob.adjust_blood_volume(blood_amount)
