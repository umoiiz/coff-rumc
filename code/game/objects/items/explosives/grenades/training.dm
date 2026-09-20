/obj/item/explosive/grenade/training
	name = "M07训练榴弹"
	desc = "M40 HEDP的无害可重复使用版本,用于训练.可装填至任何榴弹发射器,或用手投掷."
	icon_state = "training_grenade"
	worn_icon_state = "training_grenade"
	hud_state = "grenade_dummy"
	dangerous = FALSE
	icon_state_mini = "grenade_white"
	overlay_type = "white"

/obj/item/explosive/grenade/training/prime()
	playsound(loc, 'sound/items/detector.ogg', 80, 0, 7)
	active = FALSE //so we can reuse it
	overlays.Cut()
	icon_state = initial(icon_state)
	det_time = initial(det_time) //these can be modified when fired by UGL
	throw_range = initial(throw_range)

/obj/item/explosive/grenade/training/fire_act(burn_level, flame_color)
	return
