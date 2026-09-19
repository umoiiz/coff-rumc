//////Kitchen Spike

/obj/structure/kitchenspike
	name = "一根肉刺"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "spike"
	desc = "用于从动物身上收集肉类的尖刺"
	density = TRUE
	anchored = TRUE
	coverage = 5
	var/meat = 0
	var/occupied = 0
	var/meattype = 0 // 0 - Nothing, 1 - Monkey, 2 - Xeno

/obj/structure/kitchenspike/attackby(obj/item/grab/G, mob/user)
	if(!istype(G, /obj/item/grab))
		return
	if(ismonkey(G.grabbed_thing))
		var/mob/living/carbon/human/species/monkey/M = G.grabbed_thing
		if(!occupied)
			icon_state = "spikebloody"
			occupied = 1
			meat = 5
			meattype = 1
			visible_message(span_warning("[user]将[M]强行按到尖刺上,瞬间杀死了[M.p_them()]!"))
			M.death(TRUE)
			G.grabbed_thing = null
			qdel(G)

		else
			to_chat(user, span_warning("尖刺上已经有东西了,先把它上面的肉收集完!"))
	else
		to_chat(user, span_warning("它们对尖刺来说太大了,试试小一点的!"))
		return

/obj/structure/kitchenspike/attack_hand(mob/user as mob)
	if(..())
		return
	if(src.occupied)
		if(src.meattype == 1)
			if(src.meat > 1)
				src.meat--
				new /obj/item/reagent_containers/food/snacks/meat/monkey( src.loc )
				to_chat(usr, "你从猴子身上取下一些肉。")
			else if(src.meat == 1)
				src.meat--
				new /obj/item/reagent_containers/food/snacks/meat/monkey(src.loc)
				to_chat(usr, "你从猴子身上取下了最后一块肉!")
				src.icon_state = "spike"
				src.occupied = 0
		else if(src.meattype == 2)
			if(src.meat > 1)
				src.meat--
				new /obj/item/reagent_containers/food/snacks/meat/xeno( src.loc )
				to_chat(usr, "你从异形身上取下一些肉。")
			else if(src.meat == 1)
				src.meat--
				new /obj/item/reagent_containers/food/snacks/meat/xeno(src.loc)
				to_chat(usr, "你从异形身上取下了最后一块肉!")
				src.icon_state = "spike"
				src.occupied = 0
