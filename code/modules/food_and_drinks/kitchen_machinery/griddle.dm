/obj/machinery/griddle
	name = "griddle"
	desc = "因为用平底锅的都是娘娘腔。"
	icon = 'icons/obj/machines/kitchenmachines.dmi'
	icon_state = "griddle1_off"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 5
	layer = BELOW_OBJ_LAYER
	///Things that are being griddled right now
	var/list/griddled_objects = list()
	///Looping sound for the grill
	var/datum/looping_sound/grill/grill_loop
	///Whether or not the machine is turned on right now
	var/on = FALSE
	///What variant of griddle is this?
	var/variant = 1
	///How many shit fits on the griddle?
	var/max_items = 8

/obj/machinery/griddle/Initialize(mapload)
	. = ..()
	grill_loop = new(src, FALSE)
	if(isnum(variant))
		variant = rand(1,3)

/obj/machinery/griddle/Destroy()
	QDEL_NULL(grill_loop)
	. = ..()

/obj/machinery/griddle/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(atom_flags & NODECONSTRUCT)
		return
	if(default_deconstruction_crowbar(I, ignore_panel = TRUE))
		return
	variant = rand(1,3)

/obj/machinery/griddle/attackby(obj/item/I, mob/user, params)
	if(length(griddled_objects) >= max_items)
		to_chat(user, span_notice("[src]装不下更多物品了!"))
		return
	var/list/modifiers = params2list(params)
	//Center the icon where the user clicked.
	if(!LAZYACCESS(modifiers, "icon-x") || !LAZYACCESS(modifiers, "icon-y"))
		return
	if(user.transferItemToLoc(I, src))
		//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
		I.pixel_x = clamp(text2num(LAZYACCESS(modifiers, "icon-x")) - 16, -(world.icon_size * 0.5), world.icon_size * 0.5)
		I.pixel_y = clamp(text2num(LAZYACCESS(modifiers, "icon-y")) - 16, -(world.icon_size * 0.5), world.icon_size * 0.5)
		to_chat(user, span_notice("您将[I]放在[src]上。"))
		AddToGrill(I, user)
		update_icon()
		return
	return ..()

/obj/machinery/griddle/attack_hand(mob/user, list/modifiers)
	. = ..()
	on = !on
	if(on)
		START_PROCESSING(SSmachines, src)
	else
		STOP_PROCESSING(SSmachines, src)
	update_icon()
	update_grill_audio()

/obj/machinery/griddle/proc/AddToGrill(obj/item/item_to_grill, mob/user)
	vis_contents += item_to_grill
	griddled_objects += item_to_grill
	RegisterSignal(item_to_grill, COMSIG_MOVABLE_MOVED, PROC_REF(ItemMoved))
	RegisterSignal(item_to_grill, COMSIG_GRILL_COMPLETED, PROC_REF(GrillCompleted))
	RegisterSignal(item_to_grill, COMSIG_QDELETING, PROC_REF(ItemRemovedFromGrill))
	update_grill_audio()

/obj/machinery/griddle/proc/ItemRemovedFromGrill(obj/item/I)
	SIGNAL_HANDLER
	griddled_objects -= I
	vis_contents -= I
	UnregisterSignal(I, list(COMSIG_GRILL_COMPLETED, COMSIG_MOVABLE_MOVED, COMSIG_QDELETING))
	update_grill_audio()

/obj/machinery/griddle/proc/ItemMoved(obj/item/I, atom/OldLoc, Dir, Forced)
	SIGNAL_HANDLER
	ItemRemovedFromGrill(I)

/obj/machinery/griddle/proc/GrillCompleted(obj/item/source, atom/grilled_result)
	SIGNAL_HANDLER
	AddToGrill(grilled_result)

/obj/machinery/griddle/proc/update_grill_audio()
	if(on && length(griddled_objects))
		grill_loop.start()
	else
		grill_loop.stop()

/obj/machinery/griddle/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	balloon_alert(user, "您开始[anchored ? "un" : ""]固定...")
	I.play_tool_sound(src, 50)
	if(!I.use_tool(src, user, 2 SECONDS))
		return FALSE
	balloon_alert(user, "您[anchored ? "un" : ""]固定完毕。")
	anchored = !anchored
	playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
	return TRUE

/obj/machinery/griddle/process(delta_time)
	. = ..()
	for(var/obj/item/griddled_item AS in griddled_objects)
		if(SEND_SIGNAL(griddled_item, COMSIG_ITEM_GRILLED, src, delta_time) & COMPONENT_HANDLED_GRILLING)
			continue
		griddled_item.fire_act(40)
		if(prob(10))
			visible_message(span_danger("[griddled_item]在[src]上似乎表现得不怎么样!"))

/obj/machinery/griddle/update_icon_state()
	icon_state = "griddle[variant]_[on ? "on" : "off"]"
	return ..()

/obj/machinery/griddle/stand
	name = "griddle stand"
	desc = "传统煎锅的商业化版本。过去人们满怀热情地用煎锅烹饪的美好时光都去哪了?"
	variant = "stand"

/obj/machinery/griddle/stand/update_overlays()
	. = ..()
	. += "front_bar"

/obj/machinery/griddle/nopower
	use_power = NO_POWER_USE
