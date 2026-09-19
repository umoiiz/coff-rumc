/obj/item/stack/barbed_wire
	name = "带刺铁丝网"
	desc = "一段带刺的铁丝."
	icon_state = "barbed_wire"
	item_flags = NOBLUDGEON
	singular_name = "length"
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 5
	throw_speed = 5
	throw_range = 20
	attack_verb = list("hits", "whacks", "slices")
	max_amount = 20
	merge_type = /obj/item/stack/barbed_wire

//small stack
/obj/item/stack/barbed_wire/small_stack
	amount = 5

//half stack
/obj/item/stack/barbed_wire/half_stack
	amount = 10

//full stack
/obj/item/stack/barbed_wire/full
	amount = 20

/obj/item/stack/barbed_wire/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(!istype(I, /obj/item/stack/rods))
		return

	var/obj/item/stack/rods/R = I
	if(R.amount < 8)
		to_chat(user, span_warning("你还需要[8 - R.amount]个[R]才能制作刀片铁丝网障碍!"))
		return
	if(amount < 2)
		to_chat(user, span_warning("你至少还需要[2 - amount]个[src]才能制作刀片铁丝网障碍!"))
		return

	R.use(8)
	use(2)

	var/obj/structure/razorwire/M = new /obj/item/stack/razorwire(user.loc, 2)
	to_chat(user, span_notice("你将金属杆和带刺铁丝网组合成了[M]!"))

/obj/item/stack/razorwire
	name = "刀片铁丝网组件"
	desc = "一捆由金属杆支撑的带刺铁丝网.用于以缠绕和受伤为代价阻止进入区域.自1900年代以来就是一种经典的防御工事."
	icon = 'icons/obj/structures/barbedwire.dmi'
	icon_state = "barbedwire_assembly"
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	throwforce = 10
	throw_range = 5
	attack_verb = list("hits", "whacks", "slices")
	singular_name = "bundle"
	max_amount = 10
	merge_type = /obj/item/stack/razorwire

//small stack
/obj/item/stack/razorwire/small_stack
	amount = 5

//medium stack
/obj/item/stack/razorwire/half_stack
	amount = 10

//full stack
/obj/item/stack/razorwire/full
	amount = 20

/obj/item/stack/razorwire/attack_self(mob/user) //use barbed wire to deploy it
	if(!ishuman(usr))
		return

	var/turf/mystery_turf = get_step(user.loc,user.dir)
	if(!isopenturf(mystery_turf))
		to_chat(user, span_warning("我们不能在这里建造!"))
		return

	var/turf/open/target = mystery_turf

	if(!check_blocked_turf(target)) //check if blocked
		to_chat(user, span_warning("没有足够的空间来部署[src]!"))
		return

	if(!target.allow_construction) //We shouldn't be building here.
		to_chat(user, span_warning("我们不能在这里建造!"))
		return

	user.visible_message(span_notice("[user]开始组装[src]."),
	span_notice("你开始组装[src]."))
	var/delay_assembly = SKILL_TASK_EASY
	if(user.skills.getRating(SKILL_ENGINEER)) //Higher skill lowers the delay.
		delay_assembly -= 0.5 SECONDS + user.skills.getRating(SKILL_ENGINEER) * 2

	if(do_after(user, delay_assembly, NONE, src, BUSY_ICON_BUILD))
		var/obj/structure/razorwire/M = new /obj/structure/razorwire(target)
		M.setDir(user.dir)
		user.visible_message(span_notice("[user]组装了一个[M]."),
		span_notice("你组装了一个[M]."))
		playsound(src, 'sound/effects/barbed_wire_movement.ogg', 25, 1)
		M.update_icon()
		use(1)
	user.record_structures_built()
