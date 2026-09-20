/// Inflicts crippling brain damage on the target
/datum/smite/brain_damage
	name = "Brain damage"

/datum/smite/brain_damage/effect(client/user, mob/living/target)
	. = ..()

	if (!ishuman(target))
		to_chat(user, span_warning("这必须对人类使用."), confidential = TRUE)
		return

	to_chat(target, span_userdanger("你的心智在存在的重压下崩溃了, 你再也承受不住了."), confidential = TRUE)
	target.adjust_brain_loss(BRAIN_DAMAGE_DEATH - 1)
