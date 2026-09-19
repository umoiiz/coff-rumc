//No relation to slugcat

/mob/living/simple_animal/catslug
	name = "catslug"
	desc = "这是一只猫... 也许是来自另一个星球,另一个世界的东西. 你觉得它不危险,但你不能确定. 研究员应该对这种生物了解更多."
	icon = 'icons/mob/pets.dmi'
	icon_state = "catslug"
	icon_living = "catslug"
	icon_dead = "catslug_dead"
	gender = MALE
	emote_see = list("stares at the ceiling.", "shivers.", "looks at the marines.", "looks at the research paper.")
	speak_chance = 1
	turns_per_move = 5
	pass_flags = PASS_LOW_STRUCTURE
	response_help = "hugs"
	response_disarm = "rudely paps"
	response_harm = "kicks"

/mob/living/simple_animal/catslug/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/companion)

/mob/living/simple_animal/catslug/newt
	name = "Newt"
	real_name = "Newt"
	desc = "你回想起在另一个幻灯片演示中,军方喜欢用那个纽特是当前异形威胁的幸存者. 研究人员在它的同类中发现了这个可怜的东西,可能是被异形开膛破肚的. 谁知道纽特是不是她种族中最后一个."
	icon_state = "catslug"
	icon_living = "catslug"
	icon_dead = "catslug_dead"
	gender = FEMALE
