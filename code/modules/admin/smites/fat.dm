/// Fattens the target
/datum/smite/fat
	name = "Fatten up"

/datum/smite/fat/effect(client/user, mob/living/carbon/C)
	. = ..()

	if (!ishuman(C))
		to_chat(user, span_warning("异形仅以陆战队员的盐分为食. 中止."), confidential = TRUE)
		return

	to_chat(C, span_warning("你的呼吸变得困难, 你突然感觉自己重达1000磅..."), confidential = TRUE)
	C.set_nutrition(NUTRITION_OVERFED * 2)
