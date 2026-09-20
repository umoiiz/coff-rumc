/obj/machinery/vending/tool
	name = "你工具"
	desc = "给工具用的工具."
	icon_state = "tool"
	icon_deny = "tool-deny"
	icon_vend = "tool-vend"
	isshared = TRUE
	wrenchable = FALSE
	products = list(
		/obj/item/stack/cable_coil = -1,
		/obj/item/tool/crowbar = -1,
		/obj/item/tool/weldingtool = -1,
		/obj/item/tool/wirecutters = -1,
		/obj/item/tool/wrench = -1,
		/obj/item/tool/screwdriver = -1,
		/obj/item/tool/multitool = -1,
	)

/obj/machinery/vending/tool/nopower
	use_power = NO_POWER_USE

/obj/machinery/vending/tool/nopower/valhalla
	resistance_flags = INDESTRUCTIBLE
