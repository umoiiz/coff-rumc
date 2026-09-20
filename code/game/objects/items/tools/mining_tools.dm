


/*****************************Pickaxe********************************/

/obj/item/tool/pickaxe
	name = "镐"
	icon = 'icons/obj/mining.dmi'
	icon_state = "pickaxe"
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	force = 15
	throwforce = 4
	worn_icon_state = "pickaxe"
	w_class = WEIGHT_CLASS_BULKY
	var/digspeed = 40 //moving the delay to an item var so R&D can make improved picks. --NEO
	attack_verb = list("hits", "pierces", "slices", "attacks")
	var/drill_sound = 'sound/weapons/genhit.ogg'
	var/drill_verb = "picking"
	sharp = IS_SHARP_ITEM_SIMPLE
	var/excavation_amount = 100

/obj/item/tool/pickaxe/hammer
	name = "大锤"
	//icon_state = "sledgehammer" Waiting on sprite
	desc = "一把由强化金属制成的采矿锤.你感觉想用它砸你老板的脸."

/obj/item/tool/pickaxe/silver
	name = "银镐"
	icon_state = "spickaxe"
	worn_icon_state = "spickaxe"
	digspeed = 30
	desc = "这毫无冶金学道理."

/obj/item/tool/pickaxe/drill
	name = "采矿钻机" // Can dig sand as well!
	icon_state = "handdrill"
	worn_icon_state = "drill"
	digspeed = 30
	desc = "你的钻头将穿透岩壁."
	drill_verb = "drilling"

/obj/item/tool/pickaxe/jackhammer
	name = "声波凿岩机"
	icon_state = "jackhammer"
	worn_icon_state = "jackhammer"
	digspeed = 20 //faster than drill, but cannot dig
	desc = "用声波爆破击碎岩石,非常适合杀死洞穴蜥蜴."
	drill_verb = "hammering"

/obj/item/tool/pickaxe/gold
	name = "金镐"
	icon_state = "gpickaxe"
	worn_icon_state = "gpickaxe"
	digspeed = 20
	desc = "这毫无冶金学道理."

/obj/item/tool/pickaxe/diamond
	name = "钻石镐"
	icon_state = "dpickaxe"
	worn_icon_state = "dpickaxe"
	digspeed = 10
	desc = "一把带有钻石镐头的镐,这就像我的世界一样."

/obj/item/tool/pickaxe/diamonddrill //When people ask about the badass leader of the mining tools, they are talking about ME!
	name = "钻石采矿钻机"
	icon_state = "diamonddrill"
	worn_icon_state = "jackhammer"
	digspeed = 5 //Digs through walls, girders, and can dig up sand
	desc = "你的钻头将穿透天堂!"
	drill_verb = "drilling"

/obj/item/tool/pickaxe/plasmacutter
	name = "等离子切割器"
	desc = "一种用致命高温等离子体切割的工具.你可以用它切下异形的肢体!或者,你知道的,切开墙壁或挖穿石头.强烈建议佩戴护目镜."
	icon = 'icons/obj/items/tools.dmi'
	icon_state = "plasma_cutter_off"
	worn_icon_state = "plasmacutter"
	w_class = WEIGHT_CLASS_BULKY
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_BACK
	force = 70
	damtype = BURN
	digspeed = 20 //Can slice though normal walls, all girders, or be used in reinforced wall deconstruction
	drill_verb = "cutting"
	attack_verb = list("dissolves", "disintegrates", "liquefies", "subliminates", "vaporizes") //See PC did the verbs correctly the first time around.
	heat = 3800
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 0.6
	light_color = LIGHT_COLOR_PURPLE
	tool_behaviour = TOOL_PLASMACUTTER
	var/cutting_sound = 'sound/items/welder2.ogg'
	var/powered = FALSE
	var/dirt_amt_per_dig = 5
	var/obj/item/cell/rtg/large/cell //The plasma cutter cell is unremovable and recharges over time

/obj/item/tool/pickaxe/plasmacutter/Initialize(mapload)
	. = ..()
	cell = new /obj/item/cell/rtg/plasma_cutter()


/obj/item/tool/pickaxe/plasmacutter/examine(mob/user)
	. = ..()
	if(cell)
		. += "The internal battery readout counter is active. <b>Charge Remaining: [cell.charge]/[cell.maxcharge]</b>"
	else
		. += span_warning("它没有安装电源!")

/obj/item/tool/pickaxe/plasmacutter/attack_self(mob/user)
	toggle(user)
	user.changeNext_move(CLICK_CD_LONG)


//Toggles the cutter off and on
/obj/item/tool/pickaxe/plasmacutter/proc/toggle(mob/user, silent)
	if(powered)
		playsound(loc, 'sound/weapons/saberoff.ogg', 15)
		powered = FALSE
		if(!silent && user)
			user.visible_message(span_notice("[user]关闭了[src]."),
		span_notice("你关闭了[src]. <b>剩余电量: [cell.charge]/[cell.maxcharge]</b>"))
		update_plasmacutter()
		return

	if(!cell || cell.charge <= 0)
		fizzle_message(user)
		return
	playsound(loc, 'sound/weapons/saberon.ogg', 15)
	powered = TRUE
	if(!silent && user)
		user.visible_message(span_notice("[user]开启了[src]."),
		span_notice("你开启了[src]. <b>剩余电量: [cell.charge]/[cell.maxcharge]</b>"))

	update_plasmacutter()


/obj/item/tool/pickaxe/plasmacutter/proc/fizzle_message(mob/user)
	playsound(src, 'sound/machines/buzz-two.ogg', 25, 1)
	if(!cell)
		balloon_alert(user, "未安装电池")
	else if(!powered)
		balloon_alert(user, "已关闭")
	else
		balloon_alert(user, "电量不足")
		to_chat(user, span_warning("等离子切割器剩余电量不足!给内部电池一些时间充电,或者攻击一个活物! <b>剩余电量: [cell.charge]/[cell.maxcharge]</b>"))

/obj/item/tool/pickaxe/plasmacutter/proc/start_cut(mob/user, name = "", atom/source, charge_amount = PLASMACUTTER_BASE_COST, custom_string, no_string, SFX = TRUE)
	if(!(cell.charge >= charge_amount) || !powered)
		fizzle_message(user)
		return FALSE
	eyecheck(user)
	if(SFX)
		playsound(source, cutting_sound, 25, 1)
		var/datum/effect_system/spark_spread/spark_system
		spark_system = new /datum/effect_system/spark_spread()
		spark_system.set_up(5, 0, source)
		spark_system.attach(source)
		spark_system.start(source)
	if(!no_string)
		if(custom_string)
			to_chat(user, span_notice(custom_string))
		else
			balloon_alert(user, "开始切割")
	return TRUE

/obj/item/tool/pickaxe/plasmacutter/proc/cut_apart(mob/user, name = "", atom/source, charge_amount = PLASMACUTTER_BASE_COST, custom_string)
	eyecheck(user)
	playsound(source, cutting_sound, 25, 1)
	var/datum/effect_system/spark_spread/spark_system
	spark_system = new /datum/effect_system/spark_spread()
	spark_system.set_up(5, 0, source)
	spark_system.attach(source)
	spark_system.start(source)
	use_charge(user, charge_amount, TRUE)
	if(custom_string)
		to_chat(user, span_notice(custom_string))
	else
		to_chat(user, span_notice("你切开了\the [source]."))

/obj/item/tool/pickaxe/plasmacutter/proc/debris(location, metal = 0, rods = 0, wood = 0, wires = 0, shards = 0, plasteel = 0)
	if(metal)
		new /obj/item/stack/sheet/metal (location, metal)
	if(rods)
		new /obj/item/stack/rods (location, rods)
	if(wood)
		new /obj/item/stack/sheet/wood (location, wood)
	if(wires)
		new /obj/item/stack/cable_coil (location, wires)
	if(shards)
		while(shards > 0)
			new /obj/item/shard (location)
			shards--
	if(plasteel)
		new /obj/item/stack/sheet/plasteel (location, plasteel)

/obj/item/tool/pickaxe/plasmacutter/proc/use_charge(mob/user, amount = PLASMACUTTER_BASE_COST, mention_charge = TRUE)
	cell.charge -= min(cell.charge, amount)
	if(mention_charge && amount > 0)
		balloon_alert(user, "剩余充能: [cell.charge]/[cell.maxcharge]")
	update_plasmacutter()

/obj/item/tool/pickaxe/plasmacutter/proc/calc_delay(mob/user)
	. = PLASMACUTTER_CUT_DELAY
	var/skill = user.skills.getRating(SKILL_ENGINEER)
	if(skill < SKILL_ENGINEER_ENGI) //We don't have proper skills; time to fumble and bumble.
		user.visible_message(span_notice("[user]笨手笨脚地摸索着如何使用[src]."),
		span_notice("你笨手笨脚地摸索着如何使用[src]."))
		return . *= max(1, 4 - skill) //Takes twice to four times as long depending on your skill.
	. -= min(PLASMACUTTER_CUT_DELAY, (skill - 3) * 5) //We have proper skills; delay lowered by 0.5 per skill point in excess of a field engineer's.

/obj/item/tool/pickaxe/plasmacutter/proc/update_plasmacutter(mob/user, silent=FALSE) //Updates the icon and power on/off status of the plasma cutter
	if(!user && ismob(loc) )
		user = loc
	if(!cell || cell.charge <= 0 || powered == FALSE)
		icon_state = "plasma_cutter_off"
		if(powered)
			powered = FALSE
			if(!silent)
				playsound(loc, 'sound/weapons/saberoff.ogg', 25)
				balloon_alert(user, "充能不足")
				to_chat(user, span_warning("等离子切割机因电力不足而突然关闭!"))
		force = 5
		damtype = BRUTE
		heat = 0
		set_light_on(FALSE)
	else
		icon_state = "plasma_cutter_on"
		powered = TRUE
		force = 70
		damtype = BURN
		heat = 3800
		set_light_on(TRUE)


/obj/item/tool/pickaxe/plasmacutter/attack(mob/living/M, mob/living/user)
	if(!powered)
		fizzle_message(user)
	else
		playsound(M, cutting_sound, 25, 1)
		eyecheck(user)
		update_plasmacutter()
		var/datum/effect_system/spark_spread/spark_system
		spark_system = new /datum/effect_system/spark_spread()
		spark_system.set_up(5, 0, M)
		spark_system.attach(M)
		spark_system.start(M)
		if(isxeno(M) && M.stat != DEAD)
			cell.charge += 200
			var/mob/living/carbon/xenomorph/xeno = M
			if(!CHECK_BITFIELD(xeno.xeno_caste.caste_flags, CASTE_PLASMADRAIN_IMMUNE))
				xeno.use_plasma(round(xeno.xeno_caste.plasma_regen_limit * xeno.xeno_caste.plasma_max * 0.2)) //One fifth of the xeno's regeneratable plasma per hit.
	return ..()


/obj/item/tool/pickaxe/plasmacutter/afterattack(atom/target, mob/user, proximity)
	if(!proximity || user.do_actions)
		return

	if(isturf(target))//Melting snow with the plasma cutter.
		var/turf/T = target
		var/turfdirt = T.get_dirt_type()
		if(!turfdirt == DIRT_TYPE_SNOW)
			return
		if(!istype(T, /turf/open/floor/plating/ground/snow))
			return
		var/turf/open/floor/plating/ground/snow/ST = T
		if(!ST.slayer)
			return
		if(!start_cut(user, target.name, target, 0, span_notice("你开始用[src]熔化[target.name].")))
			return
		playsound(user.loc, 'sound/items/welder.ogg', 25, 1)
		if(!do_after(user, calc_delay(user) * PLASMACUTTER_VLOW_MOD, NONE, T, BUSY_ICON_BUILD))
			return
		if(!powered)
			fizzle_message(user)
			return
		if(!turfdirt == DIRT_TYPE_SNOW)
			return
		if(!ST.slayer)
			return
		ST.slayer = max(0 , ST.slayer - dirt_amt_per_dig)
		ST.update_appearance()
		ST.update_sides()
		cut_apart(user, target.name, target, 0, "You melt the snow with [src]. ") //costs nothing
