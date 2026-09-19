/// Breaks the targets bones
/datum/smite/boneless
	name = "Boneless"

/datum/smite/boneless/effect(client/user, mob/living/carbon/human/target)
	. = ..()

	if (!ishuman(target))
		to_chat(user, span_warning("这必须对人类使用."), confidential = TRUE)
		return
	
	var/timer = 2 SECONDS
	to_chat(target,span_userdanger("你的骨骼在血雾中碎裂, 骨片四散飞溅!"))
	for(var/datum/limb/limb_to_break AS in target.limbs)
		if(limb_to_break.limb_status & (LIMB_BROKEN | LIMB_DESTROYED | LIMB_AMPUTATED))
			continue
		timer += 2 SECONDS
		addtimer(CALLBACK(limb_to_break, TYPE_PROC_REF(/datum/limb, fracture)), timer)
