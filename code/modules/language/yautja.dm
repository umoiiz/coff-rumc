/datum/language/yautja
	name = "塞恩加语"
	desc = "亚乌贾掠食者深沉、隆隆作响、喉音浓重的声音.对于没有面部下颚的人来说很难发出."
	speech_verb = "隆隆道"
	ask_verb = "隆隆道"
	exclaim_verb = "咆哮道"
	icon_state = "pred"
	key = "s"
	space_chance = 20
	default_priority = 90
	syllables = list("!", "?", ".", "@", "$", "%", "^", "&", "*", "-", "=", "+", "e", "b", "y", "p", "|", "z", "~", ">")

/datum/language_holder/yautja
	languages = list(/datum/language/yautja)
	only_speaks_language = /datum/language/yautja

/datum/language_holder/yautja/New()
	. = ..()
	for(var/la in GLOB.all_languages - /datum/language/yautja)
		grant_language(la, TRUE)
