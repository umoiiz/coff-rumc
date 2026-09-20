/datum/element/scalping/Attach(datum/target, _result)
	. = ..()
	RegisterSignal(target, COMSIG_ITEM_ATTACK, PROC_REF(_on_attack))

/datum/element/scalping/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, COMSIG_ITEM_ATTACK)

/datum/element/scalping/proc/_on_attack(datum/source, mob/living/M, mob/living/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(on_attack), source, M, user)

/datum/element/scalping/proc/on_attack(datum/source, mob/living/M, mob/living/user)
	if(!isxeno(M) || (M.stat != DEAD))
		return NONE
	if(M.a_intent == INTENT_HARM)
		return NONE
	M.visible_message(span_notice("[user]开始用\the [source]撕扯[M]") ,span_notice("你开始用\the [source]劈砍[M]"))
	if(!do_after(user, 2 SECONDS, NONE, M))
		return NONE
	M.visible_message(span_danger("[user]残忍地剥下了[M]的头皮!"), span_danger("你用\the [source]残忍地剥下了[M]的头皮!"))
	var/obj/item/scalp/scalp = new(get_turf(M))
	scalp.name = M.name + "'s " + initial(scalp.name)
	return COMPONENT_ITEM_NO_ATTACK

/obj/item/scalp
	name = "头皮"
	desc = "被击杀异形的残缺头皮,伟大胜利的证明!"
	icon = 'icons/Xeno/xeno_materials.dmi'
	icon_state = "chitin-chunk"
	w_class = WEIGHT_CLASS_TINY
