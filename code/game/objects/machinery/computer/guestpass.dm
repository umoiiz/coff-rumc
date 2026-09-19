/////////////////////////////////////////////
//Guest pass ////////////////////////////////
/////////////////////////////////////////////
/obj/item/card/id/guest
	name = "访客通行证"
	desc = "允许临时进入站点区域.它看起来已经坏了."
	icon_state = "guest"

	var/reason = "NOT SPECIFIED"

/obj/item/card/id/guest/examine(mob/user)
	. = ..()
	. += "This card looks like its been sitting here for some time."

/obj/item/card/id/guest/read()
	return

/////////////////////////////////////////////
//Guest pass terminal////////////////////////
/////////////////////////////////////////////

/obj/machinery/computer/guestpass
	name = "guest pass terminal"
	icon_state = "computer_small"
	screen_overlay = "guest"
	density = FALSE
