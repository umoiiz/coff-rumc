/// Fattens the target
/datum/smite/ai_replacement
	name = "Replace by ai"

/datum/smite/ai_replacement/effect(client/user, mob/living/carbon/C)
	. = ..()

	if (!isxeno(C))
		to_chat(user, span_warning("陆战队没有可用的AI, 中止!"))
		return

	var/mob/living/carbon/xenomorph/skill_less_xeno = C
	skill_less_xeno.replace_by_ai()
