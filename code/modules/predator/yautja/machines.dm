/obj/machinery/prop/yautja/bubbler
	name = "yautja cauldron"
	desc = "一台巨大的黑色机器, 发出不祥的嗡嗡声, 附带着一锅沸腾的液体. 可以看到里面漂浮着似乎是残留猪油和毛球的东西."
	icon = 'icons/obj/machines/yautja_machines.dmi'
	icon_state = "vat"
	density = TRUE

/obj/machinery/prop/yautja/bubbler/examine(mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		. += span_notice("你可以使用这台机器清除肢体上的皮肤, 并将它们变成用于你盔甲的骨头.")
		. += span_notice("你首先需要找到一条肢体. 然后你使用一把仪式匕首来准备它.")
		. += span_notice("准备好肢体后, 你把它放入大锅, 去除血肉, 留下骨头.")
		. += span_notice("然后你将用抛光布清洁并抛光得到的骨头, 使其准备好附着到你的盔甲上.")

/obj/machinery/prop/yautja/bubbler/attackby(obj/potential_limb, mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		to_chat(user, span_notice("你不知道这是做什么的, 你觉得现在不是弄清楚的时候."))
		return

	if(!istype(potential_limb, /obj/item/limb))
		to_chat(user, span_notice("你不能把这个放入[src]."))
		return
	var/obj/item/limb/current_limb = potential_limb

	if(!current_limb.flayed)
		to_chat(user, span_notice("这条肢体还没准备好."))
		return
	icon_state = "vat_boiling"
	to_chat(user, span_warning("你把[current_limb]放进去并启动了大锅."))
	if(!do_after(user, 15 SECONDS, NONE, current_limb, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
		to_chat(user, span_notice("你把[current_limb]从大锅里拉了出来."))
		icon_state = initial(icon_state)
		return
	icon_state = initial(icon_state)

	var/obj/item/armor_module/limb/skeleton/new_bone = new current_limb.bone_type(get_turf(src))
	if(istype(new_bone, /obj/item/armor_module/limb/skeleton/head))
		new_bone.desc = span_notice("这个头骨曾经是[current_limb.name].")
	qdel(current_limb)

/obj/machinery/microwave/yautja
	name = "alien microwave"
	desc = "加热冷食的黑暗合金邪恶机器."
	icon = 'icons/obj/machines/yautja_machines.dmi'

/obj/machinery/processor/yautja
	name = "food grinder"
	icon = 'icons/obj/machines/yautja_machines.dmi'

/obj/machinery/grill/yautja
	name = "alien grill"
	desc = "用于烧烤最美味的猎物."
	icon = 'icons/obj/machines/yautja_machines.dmi'

/obj/machinery/griddle/yautja
	icon = 'icons/obj/machines/yautja_machines.dmi'

/obj/structure/xenoautopsy/tank/hugger/yautja
	icon = 'icons/obj/machines/yautja_machines.dmi'
	broken_state = /obj/structure/xenoautopsy/tank/escaped/yautja

/obj/structure/xenoautopsy/tank/escaped/yautja
	icon = 'icons/obj/machines/yautja_machines.dmi'

//YAUTJA SHIP - CURRENTLY USES STRATA DOORS
/obj/machinery/door/airlock/yautja
	name = "\improper Airlock"
	icon = 'icons/obj/doors/strata_doors.dmi'
	openspeed = 5
	req_access = null
	req_one_access = null
	no_panel = TRUE
	not_weldable = TRUE
	resistance_flags = RESIST_ALL

/obj/machinery/door/airlock/yautja/secure
	req_one_access = list(ACCESS_YAUTJA_SECURE, ACCESS_YAUTJA_ELDER, ACCESS_YAUTJA_ANCIENT)

/obj/machinery/door/airlock/yautja/secure/elder
	req_one_access = list(ACCESS_YAUTJA_ELDER, ACCESS_YAUTJA_ANCIENT)

/obj/machinery/door/airlock/yautja/secure/ancient
	req_one_access = list(ACCESS_YAUTJA_ANCIENT)

/obj/machinery/door/airlock/sandstone/runed
	name = "\improper Runed Sandstone Airlock"
	icon = 'icons/obj/doors/doorrunedsand.dmi'
	mineral = "runed sandstone"
	openspeed = 4 SECONDS
	resistance_flags = RESIST_ALL
	color = "#b29082"

/obj/machinery/door/poddoor/shutters/almayer/yautja
	name = "Armory Shutter"
	id = "Yautja Armory"
	resistance_flags = RESIST_ALL

/obj/machinery/door/poddoor/shutters/almayer/yautja/Initialize(mapload)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_YAUTJA_ARMORY_OPENED, PROC_REF(open))

/obj/structure/closet/coffin/predator
	name = "奇怪的棺材"
	desc = "这是一个为逝去亲人准备的埋葬容器. 侧面似乎有奇怪的标记..?"
	icon = 'icons/obj/structures/closet.dmi'
	icon_state = "pred_coffin"
	icon_closed = "pred_coffin"
	icon_opened = "pred_coffin_open"

/obj/structure/bed/chair/hunter
	name = "猎手椅子"
	desc = "一把为大型类人猎手精心制作的椅子."
	icon = 'icons/obj/hunter/chair.dmi'
	icon_state = "chair"
	color = rgb(255,255,255)
	buildstacktype = null
	resistance_flags = UNACIDABLE
