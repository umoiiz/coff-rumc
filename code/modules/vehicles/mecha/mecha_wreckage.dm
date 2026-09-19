/obj/structure/mecha_wreckage
	name = "外骨骼残骸"
	desc = "某台不幸机甲的残骸. 完全无法修复, 但也许有些东西可以回收."
	icon = 'icons/mecha/mecha.dmi'
	hit_sound = 'sound/effects/metal_crash.ogg'
	density = TRUE
	anchored = FALSE
	opacity = FALSE
	resistance_flags = XENO_DAMAGEABLE
	///list of welder-salvaged items that it can output
	var/list/welder_salvage = list(/obj/item/stack/sheet/plasteel)
	/// times we can salvage this mech
	var/salvage_num = 5
	///list of crowbar-salvaged items that it can output
	var/list/crowbar_salvage = list()
	/// if the wires got pulled yet
	var/wires_removed = FALSE
	///AIs to be salvaged
	var/mob/living/silicon/ai/AI
	/// parts of the mechs that can be taken out
	var/list/parts

/obj/structure/mecha_wreckage/Initialize(mapload, mob/living/silicon/ai/AI_pilot)
	. = ..()
	if(parts)
		for(var/i in 1 to 2)
			if(!length(parts))
				break
			if(prob(60))
				continue
			var/part = pick(parts)
			welder_salvage += part
		parts = null

/obj/structure/mecha_wreckage/Destroy()
	if(AI)
		QDEL_NULL(AI)
	QDEL_LIST(crowbar_salvage)
	return ..()

/obj/structure/mecha_wreckage/examine(mob/user)
	. = ..()
	if(!AI)
		return
	. += span_notice("AI回收信标已激活.")

/obj/structure/mecha_wreckage/welder_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(salvage_num <= 0 || !length(welder_salvage))
		to_chat(user, span_notice("你看不到任何可以用[I]切割的东西!"))
		return
	if(!I.use_tool(src, user, 0, volume=50))
		return
	if(prob(30))
		to_chat(user, span_notice("你未能从[src]中回收任何有价值的东西!"))
		return
	var/type = pick(welder_salvage)
	var/N = new type(get_turf(user))
	user.visible_message(span_notice("[user]从[src]上切下了[N]."), span_notice("你从[src]上切下了[N]."))
	if(!istype(N, /obj/item/stack))
		welder_salvage -= type
	salvage_num--

/obj/structure/mecha_wreckage/wirecutter_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(wires_removed)
		to_chat(user, span_notice("你看不到任何可以用[I]切割的东西!"))
		return
	var/N = new /obj/item/stack/cable_coil(get_turf(user), rand(1,3))
	user.visible_message(span_notice("[user]从[src]上切下了[N]."), span_notice("你从[src]上切下了[N]."))
	wires_removed = TRUE

/obj/structure/mecha_wreckage/crowbar_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(length(crowbar_salvage))
		var/obj/S = pick(crowbar_salvage)
		S.forceMove(user.drop_location())
		user.visible_message(span_notice("[user]从[src]上撬下了[S]."), span_notice("你从[src]上撬下了[S]."))
		crowbar_salvage -= S
		return
	to_chat(user, span_notice("你看不到任何可以用[I]切割的东西!"))

/obj/structure/mecha_wreckage/gygax
	name = "\improper Gygax残骸"
	icon_state = "gygax-broken"
	parts = list(
		/obj/item/mecha_parts/part/gygax_torso,
		/obj/item/mecha_parts/part/gygax_head,
		/obj/item/mecha_parts/part/gygax_left_arm,
		/obj/item/mecha_parts/part/gygax_right_arm,
		/obj/item/mecha_parts/part/gygax_left_leg,
		/obj/item/mecha_parts/part/gygax_right_leg,
	)

/obj/structure/mecha_wreckage/gygax/dark
	name = "\improper 暗黑Gygax残骸"
	icon_state = "darkgygax-broken"

/obj/structure/mecha_wreckage/marauder
	name = "\improper 掠夺者残骸"
	icon_state = "marauder-broken"

/obj/structure/mecha_wreckage/mauler
	name = "\improper 撕裂者残骸"
	icon_state = "mauler-broken"
	desc = "辛迪加对此不会很高兴的..."

/obj/structure/mecha_wreckage/seraph
	name = "\improper 炽天使残骸"
	icon_state = "seraph-broken"

/obj/structure/mecha_wreckage/reticence
	name = "\improper 缄默残骸"
	icon_state = "reticence-broken"
	color = "#87878715"
	desc = "..."

/obj/structure/mecha_wreckage/ripley
	name = "\improper 雷普利残骸"
	icon_state = "ripley-broken"
	parts = list(
		/obj/item/mecha_parts/part/ripley_torso,
		/obj/item/mecha_parts/part/ripley_left_arm,
		/obj/item/mecha_parts/part/ripley_right_arm,
		/obj/item/mecha_parts/part/ripley_left_leg,
		/obj/item/mecha_parts/part/ripley_right_leg,
	)

/obj/structure/mecha_wreckage/ripley/mk2
	name = "\improper 雷普利MK-II残骸"
	icon_state = "ripleymkii-broken"

/obj/structure/mecha_wreckage/ripley/lv624
	name = "MkIV动力装载机残骸"
	anchored = TRUE

/obj/structure/mecha_wreckage/ripley/firefighter
	name = "消防员残骸"
	icon_state = "firefighter-broken"

/obj/structure/mecha_wreckage/clarke
	name = "\improper 克拉克残骸"
	icon_state = "clarke-broken"
	parts = list(
		/obj/item/mecha_parts/part/clarke_torso,
		/obj/item/mecha_parts/part/clarke_head,
		/obj/item/mecha_parts/part/clarke_left_arm,
		/obj/item/mecha_parts/part/clarke_right_arm,
		/obj/item/stack/conveyor,
	)

/obj/structure/mecha_wreckage/ripley/deathripley
	name = "\improper 死亡-雷普利残骸"
	icon_state = "deathripley-broken"
	parts = null

/obj/structure/mecha_wreckage/honker
	name = "\improper H.O.N.K残骸"
	icon_state = "honker-broken"
	desc = "宇宙万物一切正常."
	parts = list(
		/obj/item/mecha_parts/part/honker_torso,
		/obj/item/mecha_parts/part/honker_head,
		/obj/item/mecha_parts/part/honker_left_arm,
		/obj/item/mecha_parts/part/honker_right_arm,
		/obj/item/mecha_parts/part/honker_left_leg,
		/obj/item/mecha_parts/part/honker_right_leg,
	)

/obj/structure/mecha_wreckage/durand
	name = "\improper 杜兰德残骸"
	icon_state = "durand-broken"
	parts = list(
		/obj/item/mecha_parts/part/durand_torso,
		/obj/item/mecha_parts/part/durand_head,
		/obj/item/mecha_parts/part/durand_left_arm,
		/obj/item/mecha_parts/part/durand_right_arm,
		/obj/item/mecha_parts/part/durand_left_leg,
		/obj/item/mecha_parts/part/durand_right_leg,
	)

/obj/structure/mecha_wreckage/phazon
	name = "\improper 法赞残骸"
	icon_state = "phazon-broken"
	parts = list(
		/obj/item/mecha_parts/part/phazon_torso,
		/obj/item/mecha_parts/part/phazon_head,
		/obj/item/mecha_parts/part/phazon_left_arm,
		/obj/item/mecha_parts/part/phazon_right_arm,
		/obj/item/mecha_parts/part/phazon_left_leg,
		/obj/item/mecha_parts/part/phazon_right_leg,
	)

/obj/structure/mecha_wreckage/savannah_ivanov
	name = "\improper 萨凡纳-伊万诺夫残骸"
	icon = 'icons/mecha/coop_mech.dmi'
	icon_state = "savannah_ivanov-broken"
	parts = list(
		/obj/item/mecha_parts/part/savannah_ivanov_torso,
		/obj/item/mecha_parts/part/savannah_ivanov_head,
		/obj/item/mecha_parts/part/savannah_ivanov_left_arm,
		/obj/item/mecha_parts/part/savannah_ivanov_right_arm,
		/obj/item/mecha_parts/part/savannah_ivanov_left_leg,
		/obj/item/mecha_parts/part/savannah_ivanov_right_leg,
	)

/obj/structure/mecha_wreckage/odysseus
	name = "\improper 奥德修斯残骸"
	icon_state = "odysseus-broken"
	parts = list(
		/obj/item/mecha_parts/part/odysseus_torso,
		/obj/item/mecha_parts/part/odysseus_head,
		/obj/item/mecha_parts/part/odysseus_left_arm,
		/obj/item/mecha_parts/part/odysseus_right_arm,
		/obj/item/mecha_parts/part/odysseus_left_leg,
		/obj/item/mecha_parts/part/odysseus_right_leg,
	)
