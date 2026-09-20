/mob/living/brain
	icon = 'icons/obj/items/organs.dmi'
	icon_state = "brain1"
	var/obj/item/container = null
	var/timeofhostdeath = 0
	var/emp_damage = 0//Handles a type of MMI damage
	var/alert = null

/mob/living/brain/Initialize(mapload)
	. = ..()
	var/datum/reagents/R = new/datum/reagents(1000)
	reagents = R
	R.my_atom = WEAKREF(src)
	ADD_TRAIT(src, TRAIT_IMMOBILE, INNATE_TRAIT)

/mob/living/brain/Destroy()
	if(key)
		if(stat != DEAD)
			death()
		ghostize()
	if(!isnull(container))
		container = null
	return ..()

/mob/living/brain/ghost()
	if(stat == DEAD)
		ghostize(TRUE)
		return

	if(tgui_alert(src, "你确定要幽灵化吗?\n(你还活着,就一颗头而言算是活着.如果你幽灵化,你回来时将无法聊天,除非有人复活你.)", "幽灵化", list("Yes", "No")) != "Yes")
		return

	death()
	ghostize(TRUE)
