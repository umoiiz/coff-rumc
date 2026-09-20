GLOBAL_VAR_INIT(deployed_cameras, 0)

/obj/machinery/camera/deployable
	name = "\"Huginn\" ROC-58 Observer"
	desc = "ROC-58可部署摄像头, 专为战场使用而设计, 以提高监视的战术实用性."
	network = list("marinesl", "marine")
	icon_state = "deployable"
	layer = ABOVE_ALL_MOB_LAYER//it flies after all

/obj/machinery/camera/deployable/update_icon_state()
	. = ..()
	if(obj_integrity <= 0)
		icon_state = "deployableoff"
	else
		icon_state = "deployable"


/obj/item/deployable_camera
	name = "未部署的\"Huginn\" ROC-58观察者"
	desc = "一种用于监视系统的可部署摄像头."
	icon = 'icons/obj/machines/monitors.dmi'
	icon_state = "deployableitem"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/deployable_camera/attack_self(mob/user)
	user.visible_message(span_notice("[user]将[src]抛向空中!"),
		span_notice("你将[src]抛向空中!"))

	for(var/mob/living/silicon/ai/AI AS in GLOB.ai_list)
		to_chat(AI, span_notice("注意 - \"Huginn\" ROC-58观察者已部署在[AREACOORD_NO_Z(user)]."))
	var/obj/machinery/camera/deployable/newcam = new(get_turf(user))
	var/dat
	if(ishuman(user))
		var/mob/living/carbon/human/squaddie = user
		var/datum/squad/squad = squaddie.assigned_squad
		if(squad)
			newcam.network += list("[lowertext(squad.name)]")
			dat += squad.name
			dat += " "
	dat += newcam.name
	GLOB.deployed_cameras++
	dat += " [GLOB.deployed_cameras]"
	newcam.name = dat
	newcam.c_tag = newcam.name
	newcam.setDir(user.dir)
	qdel(src)
