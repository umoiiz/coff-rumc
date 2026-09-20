// Every cycle, the pump uses the air in air_in to try and make air_out the perfect pressure.
//
// node1, air1, network1 correspond to input
// node2, air2, network2 correspond to output
//
// Thus, the two variables affect pump operation are set in New():
//   air1.volume
//     This is the volume of gas available to the pump that may be transfered to the output
//   air2.volume
//     Higher quantities of this cause more air to be perfected later
//     but overall network volume is also increased as this increases...

/obj/machinery/atmospherics/components/binary/pumpv
	name = "gas pump"
	desc = "一个通过压力移动气体的泵."
	icon_state = "pump_map-2"
	can_unwrench = FALSE
	shift_underlay_only = FALSE
	construction_type = /obj/item/pipe/directional
	pipe_state = "pump"

/obj/machinery/atmospherics/components/binary/pump/update_icon_nopipes()
	icon_state = (on && is_operational()) ? "pump_on" : "pump_off"


/obj/machinery/atmospherics/components/binary/pump/can_unwrench(mob/user)
	. = ..()
	if(. && on && is_operational())
		to_chat(user, span_warning("你无法松开[src], 先把它关掉!"))
		return FALSE


/obj/machinery/atmospherics/components/binary/pump/layer1
	piping_layer = 1
	icon_state= "pump_map-1"

/obj/machinery/atmospherics/components/binary/pump/layer3
	piping_layer = 3
	icon_state= "pump_map-3"

/obj/machinery/atmospherics/components/binary/pump/on
	on = TRUE
	icon_state = "pump_on_map-2"

/obj/machinery/atmospherics/components/binary/pump/on/layer1
	piping_layer = 1
	icon_state= "pump_on_map-1"

/obj/machinery/atmospherics/components/binary/pump/on/layer3
	piping_layer = 3
	icon_state= "pump_on_map-3"
