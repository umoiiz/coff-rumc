/obj/item/explosive/grenade/smokebomb
	name = "\improper M40 HSDP烟雾弹"
	desc = "M40 HSDP是一种小巧但威力强大的烟雾弹。基于与M40 HEDP相同的平台。它被设定为2秒后引爆。"
	icon_state = "grenade_smoke"
	worn_icon_state = "grenade_smoke"
	det_time = 2 SECONDS
	hud_state = "grenade_smoke"
	dangerous = FALSE
	icon_state_mini = "grenade_blue"
	overlay_type = "blue"
	/// smoke type created when the grenade is primed
	var/datum/effect_system/smoke_spread/smoketype = /datum/effect_system/smoke_spread/bad
	///radius this smoke grenade will encompass
	var/smokeradius = 7
	///The duration of the smoke
	var/smoke_duration = 11

/obj/item/explosive/grenade/smokebomb/prime()
	var/datum/effect_system/smoke_spread/smoke = new smoketype()
	playsound(loc, 'sound/effects/smoke_bomb.ogg', 25, TRUE)
	smoke.set_up(smokeradius, loc, smoke_duration)
	smoke.start()
	qdel(src)

/obj/item/explosive/grenade/smokebomb/som
	name = "\improper S30-S烟雾弹"
	desc = "S30-S是一种小巧但威力强大的烟雾弹。基于大多数SOM榴弹共用的S30平台。它被设定为2秒后引爆。"
	icon_state = "grenade_smoke_som"
	worn_icon_state = "grenade_smoke_som"
	overlay_type = "cyan"

///chemical grenades

//neuro xeno nade
/obj/item/explosive/grenade/smokebomb/neuro
	name = "\improper M40-N神经毒素烟雾弹"
	desc = "一种含有Nanotrasen研发的浓缩神经毒素的烟雾弹，据称源自异形。在某些星区作为化学武器被禁用，但被TGMC归类为较低致命性的防暴控制工具。"
	icon_state = "grenade_neuro"
	worn_icon_state = "grenade_neuro"
	hud_state = "grenade_neuro"
	det_time = 4 SECONDS
	dangerous = TRUE
	smoketype = /datum/effect_system/smoke_spread/xeno/neuro/medium
	smokeradius = 6
	overlay_type = "orange"

/obj/item/explosive/grenade/smokebomb/acid
	name = "\improper M40-A酸液烟雾弹"
	desc = "一种被设定为释放由Nanotrasen研发的极酸性烟雾云的榴弹，据称源自异形。拥有闪亮的耐酸外壳。根据若干条约，其使用被视为战争罪，而Terra Gov并非其中任何条约的签署国。"
	icon_state = "grenade_acid"
	worn_icon_state = "grenade_acid"
	hud_state = "grenade_acid"
	det_time = 4 SECONDS
	dangerous = TRUE
	smoketype = /datum/effect_system/smoke_spread/xeno/acid
	smokeradius = 5
	overlay_type = "aqua"

/obj/item/explosive/grenade/smokebomb/satrapine
	name = "萨特拉平烟雾弹"
	desc = "一种含有神经毒剂的烟雾弹，能使受害者因剧烈疼痛而衰弱，同时清除常见的止痛药。被SOM大量使用。"
	icon_state = "grenade_nerve"
	worn_icon_state = "grenade_nerve"
	hud_state = "grenade_nerve"
	det_time = 4 SECONDS
	dangerous = TRUE
	smoketype = /datum/effect_system/smoke_spread/satrapine
	smokeradius = 6
	overlay_type = "red"

/obj/item/explosive/grenade/smokebomb/satrapine/activate(mob/user)
	. = ..()
	if(!.)
		return FALSE
	user?.record_war_crime()

/obj/item/explosive/grenade/smokebomb/cloak
	name = "\improper M40-2 SCDP烟雾弹"
	desc = "M40 HSDP的一种精密版本，烟雾弹载荷略有改进。它被设定为2秒后引爆。"
	icon_state = "grenade_cloak"
	worn_icon_state = "grenade_cloak"
	hud_state = "grenade_hide"
	icon_state_mini = "grenade_green"
	smoketype = /datum/effect_system/smoke_spread/tactical
	overlay_type = "green"

/obj/item/explosive/grenade/smokebomb/cloak/agls
	name = "\improper AGLS-37 SCDP烟雾弹"
	desc = "一种小巧的智能榴弹，它即将在你脸上爆炸，除非你发现它已失效。除此之外是一种相当普通的榴弹，只是它不知怎么处于可引爆状态。"
	icon_state = "agls_cloak"
	smokeradius = 3
	overlay_type = "green"

/obj/item/explosive/grenade/smokebomb/drain
	name = "\improper M40-T烟雾弹"
	desc = "M40-T是一种小巧但威力强大的绊足草榴弹，旨在以最小的副作用清除等离子体。基于与M40 HEDP相同的平台。它被设定为6秒后引爆。"
	icon_state = "grenade_pgas"
	worn_icon_state = "grenade_pgas"
	hud_state = "grenade_drain"
	dangerous = TRUE
	det_time = 6 SECONDS
	icon_state_mini = "grenade_purple"
	smoketype = /datum/effect_system/smoke_spread/plasmaloss
	overlay_type = "purple"

/obj/item/explosive/grenade/smokebomb/antigas
	name = "\improper M40-AG烟雾弹"
	desc = "一种最初为清洁目的而设计用于清除空气中任何污染物的毒气榴弹，现在被改用于清除有害气体。"
	icon_state = "grenade_agas"
	worn_icon_state = "grenade_agas"
	hud_state = "grenade_antigas"
	det_time = 3 SECONDS
	icon_state_mini = "grenade_antigas"
	dangerous = TRUE
	smoketype = /datum/effect_system/smoke_spread/antigas
	overlay_type = "white"

/obj/item/explosive/grenade/smokebomb/drain/agls
	name = "\improper AGLS-T烟雾弹"
	desc = "一种小巧的智能榴弹，它即将在你脸上爆炸，除非你发现它已失效。除此之外是一种相当普通的榴弹，只是它不知怎么处于可引爆状态。"
	icon_state = "agls_pgas"
	det_time = 1 SECONDS
	smokeradius = 2

/obj/item/explosive/grenade/smokebomb/drain/pellet
	name = "绊足草释放系统弹丸"
	desc = "一枚从天而降的小弹丸。在落点释放绊足草。"
	icon_state = "pellet_pgas"
	det_time = 2 SECONDS
	smokeradius = 10
	smoke_duration = 15
