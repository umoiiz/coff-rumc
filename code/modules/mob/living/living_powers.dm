/mob/living/proc/ventcrawl()
	set name = "Crawl through Vent"
	set desc = "Enter an air vent and crawl through the pipe system."
	set category = "Abilities"
	handle_ventcrawl()


/mob/living/proc/hide()
	set name = "Hide"
	set desc = "Allows to hide beneath tables or certain items. Toggled on or off."
	set category = "Abilities"

	if (layer != BELOW_TABLE_LAYER)
		layer = BELOW_TABLE_LAYER
		to_chat(src, span_notice("你现在正在躲藏."))
		return
	layer = MOB_LAYER
	to_chat(src, span_notice("你已经停止躲藏."))
