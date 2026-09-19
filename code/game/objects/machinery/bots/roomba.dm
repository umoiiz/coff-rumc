/// A cheap little roomba that runs around and keeps prep clean to decrease maptick and prep always being a fucking mess
/obj/machinery/bot/roomba
	name = "Nanotrasen roomba"
	desc = "一个由纳米传讯设计的机器人吸尘器。扫地机器人旨在保持区域清洁,远离肮脏的陆战队员。"
	icon = 'icons/obj/aibots.dmi'
	icon_state = "roomba"
	///The mine we have attached to this roomba
	var/obj/item/explosive/mine/claymore //Claymore roomb
	///Admins can let it have a claymore
	var/allow_claymore = FALSE
	sentences = list(
		"Clean up your bloody mess you ANIMAL!",
		"Who teached you to leave your trash behind you? Your mom should be ashamed!",
		"I will kick the ass of the next marine that i see leaving objects unattended!",
		"I will report your behaviour to your superior, marine",
		"Another day, another trash. Gosh, i would have left these marines in the cryo.",
		"Another stinky sock. They really don't know the basics of hygiene",
		"This is the most DISGUSTING room i have ever seen",
		"Those marine bastards are gonna pay for trashing up my ship.",
		"Ughh, and I thought I was trashy.",
		"Lucky you, cleaned by the best!",
		"Time to start piling up the trash!",
		"Clean and sweep until it is done.",
		"Another day another crayon.",
		"What are you? Some bottom feeding, ship trashing crayon eater?",
		"The fifth element is always Roomby!",
		"Hail to the roomba, baby!",
		"Come clean some!",
		"Walk now and live, stay and sweep!",
		"Cant we all just clean together?",
		"Cmon hurry up, I know you got a ship to trash.",
		"Damn, here I was minding my own business, just enjoying my clean ship and you people have to trash the place up on me.",
		"This cant be good for me, but I feel great!",
		"Gyah, I feel like I'll get robotic hepatitis if I touch anything on this ship.",
		"I think I will need to keep an eye out for these marines, They are definetly hazardous to my mental health.",
		"Sorry folks, the space bible backs me up on this one.",
		"You just know there's gonna be some variety of pickled crayons in here somewhere.",
	)
	is_active = TRUE
	active_icon_state = "roomba"

/obj/machinery/bot/roomba/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(suck_items))

///Called when the roomba moves, sucks in all items held in the tile and sends them to cryo
/obj/machinery/bot/roomba/proc/suck_items()
	SIGNAL_HANDLER

	var/sucked_one = FALSE
	for(var/obj/item/sucker in loc)
		if(sucker.anchored)
			continue
		sucked_one = TRUE

		if(roomba_restock(sucker))
			counter++
			continue

	stuck_counter = 0
	if(sucked_one && prob(10))
		say(pick(sentences))

/**
 * For each obj/item/sucker, we try to restock it if possible
 * If the item cannot be restocked, we send it to cryo storage so it's not just deleted from existence
 */
/obj/machinery/bot/roomba/proc/roomba_restock(obj/item/sucker)
	set waitfor = FALSE

	//Here we try to restock whatever we sucked up
	for(var/type in GLOB.loadout_linked_vendor[VENDOR_FACTION_NEUTRAL])
		for(var/datum/vending_product/item_to_restock AS in GLOB.vending_records[type])
			if(sucker.type != item_to_restock.product_path)
				continue
			if(item_to_restock.attempt_restock(sucker, null, FALSE))
				return TRUE
	//Cryo our item if our restock attempt failed
	sucker.store_in_cryo()
	return TRUE

/obj/machinery/bot/roomba/attack_hand(mob/living/user)
	if(!CONFIG_GET(flag/fun_allowed))
		visible_message(span_notice("[user]深情地拍了拍[src]。"), span_notice("你深情地拍了拍[src]。"))
		return
	if(user.a_intent != INTENT_HARM)
		return
	tgui_alert(user, "你真的确定要试试那个恶魔般的扫地机器人的运气吗?", "扫地机器人轮盘赌", list("Yes", "Yes!", "Yes?"))
	if(prob(50))
		cell_explosion(user, 250, 250)
		visible_message("[user]在扫地机器人轮盘赌中输了!")
		return
	cell_explosion(src, 50, 50)
	visible_message("[user]在扫地机器人轮盘赌中赢了!")
	qdel(src)

/obj/machinery/bot/roomba/attackby(obj/item/I, mob/living/user, def_zone)
	if(!allow_claymore)
		return
	if(!istype(I, /obj/item/explosive/mine) || claymore)
		return
	visible_message(span_warning("[user]开始尝试将[I]安装到[src]上..."))
	stop_processing()
	if(!do_after(user, 1 SECONDS, NONE, src, BUSY_ICON_HOSTILE))
		start_processing()
		return
	start_processing()
	visible_message(span_warning("[user]将[I]的叉齿猛力刺穿[src]!"))
	log_game("[user] has armed [src] with a claymore at [AREACOORD(src)]")
	user.temporarilyRemoveItemFromInventory(I)
	I.forceMove(src)
	add_overlay(image(I.icon, initial(I.icon_state) + "_roomba"))
	claymore = I
	claymore.armed = TRUE
	var/static/list/explosive_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(attempt_mine_explode)
	)
	AddElement(/datum/element/connect_loc, explosive_connections)

/obj/machinery/bot/roomba/proc/attempt_mine_explode(datum/source, atom/movable/crosser, oldloc)
	SIGNAL_HANDLER
	if(!claymore.trip_mine(crosser))
		return
	claymore = null
	RemoveElement(/datum/element/connect_loc)
	cut_overlays()

/obj/machinery/bot/roomba/valhalla/suck_items()
	for(var/obj/item/sucker in loc)
		if(sucker.anchored)
			continue
		qdel(sucker)

/obj/machinery/bot/roomba/valhalla/eord
	name = "final boss roomba"
	desc = "看到这完美的工程杰作,你恐惧地哭泣。它能吸入物品和死去的生物。"
	resistance_flags = RESIST_ALL
	allow_claymore = TRUE

/obj/machinery/bot/roomba/valhalla/eord/suck_items()
	for(var/obj/item/sucker in loc)
		qdel(sucker)
		counter++
	for(var/mob/sucked in loc)
		if(sucked.stat != CONSCIOUS)
			qdel(sucked)
			counter++
