/obj/structure/periscope
	name = "坦克潜望镜"
	desc = "用于观察载具外部的潜望镜.抵抗或移动以停止通过它观察."
	icon = 'icons/obj/armored/3x3/tank_interior.dmi'
	icon_state = "periscope"
	density = FALSE
	resistance_flags = RESIST_ALL
	///owner of this object, assigned during interior linkage
	var/obj/vehicle/sealed/armored/owner

/obj/structure/periscope/Destroy()
	owner = null
	return ..()

/obj/structure/periscope/link_interior(datum/interior/link)
	owner = link.container

/obj/structure/periscope/can_interact(mob/user)
	. = ..()
	if(user.client?.eye != user) // e.g someone looking outside already
		return FALSE

/obj/structure/periscope/interact(mob/user)
	. = ..()
	user.reset_perspective(owner)
	ADD_TRAIT(user, TRAIT_SEE_IN_DARK, VEHICLE_TRAIT)
	user.update_sight()
	user.client.view_size.set_view_radius_to(5.5)
	RegisterSignals(user, list(COMSIG_MOVABLE_MOVED, COMSIG_LIVING_DO_RESIST, COMSIG_MOB_LOGOUT), PROC_REF(stop_looking))

///signal handler for canceling the looking
/obj/structure/periscope/proc/stop_looking(mob/source)
	SIGNAL_HANDLER
	source.unset_interaction()

/obj/structure/periscope/on_unset_interaction(mob/user)
	. = ..()
	UnregisterSignal(user, list(COMSIG_MOVABLE_MOVED, COMSIG_LIVING_DO_RESIST, COMSIG_MOB_LOGOUT))
	user.reset_perspective()
	REMOVE_TRAIT(user, TRAIT_SEE_IN_DARK, VEHICLE_TRAIT)
	user.client?.view_size.reset_to_default()
	user.update_sight()

/obj/structure/periscope/apc
	name = "装甲运兵车潜望镜"

/obj/structure/periscope/som
	icon = 'icons/obj/armored/3x4/som_interior_small_props.dmi'
	icon_state = "periscope"
	layer = MOB_BELOW_PIGGYBACK_LAYER
	pixel_x = -5

/obj/structure/periscope/som/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/structure/periscope/som/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "[icon_state]_emissive", src)

// Окошко для просмотра чё снаружи машины творится
// Текст взят с кумов, код взят с тгмс
/obj/structure/periscope/interior_viewport
	name = "外部摄像机终端"
	desc = "一个连接到载具外部摄像机的小型终端,可360度观察载具周围环境."
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "viewport"
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	resistance_flags = RESIST_ALL

// Окошко поменьше
/obj/structure/periscope/interior_viewport/simple
	name = "观察窗"
	desc = "嘿,我从这里能看到我的基地!"
	icon_state = "viewport_simple"

// Для VAN машины
/obj/structure/periscope/interior_viewport/simple/windshield
	name = "挡风玻璃"
	desc = "上次是什么时候清理的?角落里有一只被压扁的虫子."
	icon = 'icons/obj/vehicles/interiors/van.dmi'
	icon_state = "windshield_viewport_top"
	alpha = 80
