
/*
CONTAINS:
CANDLES
MATCHES
CIGARETTES
CIGARS
SMOKING PIPES
CHEAP LIGHTERS
ZIPPO

CIGARETTE PACKETS ARE IN FANCY.DM
*/




/*
	candle, match, lighter
*/


/obj/item/tool/candle
	name = "红色蜡烛"
	desc = "一根蜡烛"
	icon = 'icons/obj/items/candle.dmi'
	icon_state = "candle1"
	worn_icon_state = "candle1"
	w_class = WEIGHT_CLASS_TINY
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 0.6
	light_color = LIGHT_COLOR_FIRE
	var/wax = 800

/obj/item/tool/candle/update_icon_state()
	. = ..()
	if(wax > 150)
		icon_state = "candle[1][heat ? "_lit" : ""]"
	else if(wax > 80)
		icon_state = "candle[2][heat ? "_lit" : ""]"
	else
		icon_state = "candle[3][heat ? "_lit" : ""]"

/obj/item/tool/candle/Destroy()
	if(heat)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/tool/candle/attackby(obj/item/W as obj, mob/user as mob)
	if(iswelder(W))
		var/obj/item/tool/weldingtool/WT = W
		if(WT.isOn()) //Badasses dont get blinded by lighting their candle with a blowtorch
			light(span_notice("[user]随意地用[W]点燃了[src]。</span>"))
	else if(W.heat > 400)
		light()
	else
		return ..()

/obj/item/tool/candle/proc/light(flavor_text)
	if(!heat)
		heat = 1000
		if(!flavor_text)
			flavor_text = span_notice("[usr]点燃了[src]。")
		visible_message(flavor_text)
		set_light_on(TRUE)
		update_icon()
		START_PROCESSING(SSobj, src)

/obj/item/tool/candle/process()
	if(!heat)
		STOP_PROCESSING(SSobj, src)
		return
	wax--
	if(!wax)
		new/obj/item/trash/candle(src.loc)
		qdel(src)
		return
	update_icon()



/obj/item/tool/candle/attack_self(mob/user as mob)
	if(heat)
		heat = 0
		update_icon()
		set_light(0)
		STOP_PROCESSING(SSobj, src)


///////////
//MATCHES//
///////////
/obj/item/tool/match
	name = "火柴"
	desc = "一根简单的火柴棍,用于点燃上好的烟叶。"
	icon = 'icons/obj/items/cigarettes.dmi'
	icon_state = "match_unlit"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/smoking_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/smoking_right.dmi',
	)
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 0.6
	light_color = LIGHT_COLOR_FIRE
	var/burnt = FALSE
	var/smoketime = 5
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("burns", "singes")

/obj/item/tool/match/process()
	smoketime--
	if(smoketime < 1)
		burn_out()
		return



/obj/item/tool/match/Destroy()
	if(heat)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/tool/match/dropped(mob/user)
	if(heat)
		burn_out(user)
	return ..()

/obj/item/tool/match/proc/light_match()
	if(heat)
		return
	heat = 1000
	damtype = BURN
	icon_state = "match_lit"
	set_light_on(TRUE)

	START_PROCESSING(SSobj, src)
	update_icon()

/obj/item/tool/match/proc/burn_out(mob/user)
	heat = 0
	burnt = TRUE
	damtype = BRUTE
	icon_state = "match_burnt"
	worn_icon_state = "cigoff"
	set_light_on(FALSE)
	name = "burnt match"
	desc = "A match. This one has seen better days."
	STOP_PROCESSING(SSobj, src)


//////////////////
//FINE SMOKABLES//
//////////////////
/obj/item/clothing/mask/cigarette
	name = "香烟"
	desc = "一卷烟草和尼古丁。"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/clothing/lefthand_cigs.dmi',
		slot_r_hand_str = 'icons/mob/inhands/clothing/righthand_cigs.dmi',
	)
	icon_state = "cigoff"
	throw_speed = 0.5
	worn_icon_state = "cigoff"
	w_class = WEIGHT_CLASS_TINY
	armor_protection_flags = NONE
	light_range = 0.1
	light_power = 0.1
	light_color = LIGHT_COLOR_ORANGE
	var/lit = FALSE
	var/icon_on = "cigon"  //Note - these are in masks.dmi not in cigarette.dmi
	var/icon_off = "cigoff"
	var/type_butt = /obj/item/trash/cigbutt
	var/lastHolder = null
	var/smoketime = 300
	var/chem_volume = 30
	var/list/list_reagents = list(/datum/reagent/nicotine = 15)
	/// the quantity that will be transmited each 2 seconds
	var/transquantity = 1
	///Icon_state for mob sprite emissive
	var/emissive_state = "cigon_emissive"

/obj/item/clothing/mask/cigarette/Initialize(mapload)
	. = ..()
	create_reagents(chem_volume, INJECTABLE|NO_REACT, list_reagents) // making the cigarrete a chemical holder with a maximum volume of 30

/obj/item/clothing/mask/cigarette/apply_custom(mutable_appearance/standing, inhands, icon_used, state_used)
	. = ..()
	var/mutable_appearance/emissive_overlay = emissive_appearance(icon_used, emissive_state, src)
	standing.overlays.Add(emissive_overlay)

/obj/item/clothing/mask/cigarette/turn_light(mob/user, toggle_on)
	. = ..()
	if(. != CHECKS_PASSED)
		return
	set_light_on(toggle_on)

/obj/item/clothing/mask/cigarette/attackby(obj/item/W, mob/user, params)
	if(lit || smoketime <= 0)
		return

	if(iswelder(W))
		var/obj/item/tool/weldingtool/WT = W
		if(WT.isOn())//Badasses dont get blinded while lighting their cig with a blowtorch
			light(span_notice("[user]随意地用[W]点燃了[name]。"))

	else if(istype(W, /obj/item/tool/lighter/zippo))
		var/obj/item/tool/lighter/zippo/Z = W
		if(Z.heat)
			light(span_rose("[user.p_their()]手腕一抖,[user]用[W]点燃了他们的[name]。"))

	else if(istype(W, /obj/item/explosive/grenade/flare/civilian))
		var/obj/item/explosive/grenade/flare/civilian/FL = W
		if(FL.heat)
			light(span_notice("[user]用[W]点燃了[user.p_their()][name]。"))

	else if(istype(W, /obj/item/explosive/grenade/flare))
		var/obj/item/explosive/grenade/flare/FL2 = W
		if(FL2.heat)
			light(span_notice("[user]用[W]点燃了[user.p_their()][name]。"))

	else if(istype(W, /obj/item/tool/lighter))
		var/obj/item/tool/lighter/L = W
		if(L.heat)
			light(span_notice("[user]设法用[W]点燃了[user.p_their()][name]。"))

	else if(istype(W, /obj/item/tool/match))
		var/obj/item/tool/match/M = W
		if(M.heat)
			light(span_notice("[user]用他们的[W]点燃了[user.p_their()][name]。"))

	else if(istype(W, /obj/item/weapon/energy/sword))
		var/obj/item/weapon/energy/sword/S = W
		if(S.active)
			light(span_warning("[user]挥舞[user.p_their()][W],险些擦过[user.p_their()]的鼻子。[user.p_they()]在这个过程中点燃了[user.p_their()][name]。"))

	else if(istype(W, /obj/item/assembly/igniter))
		light(span_notice("[user]摆弄着[W],设法点燃了[user.p_their()][name]。"))

	else if(istype(W, /obj/item/weapon/gun/flamer))
		light(span_notice("[user]用[W]的引燃火焰点燃了[user.p_their()][src]。"))

	else if(istype(W, /obj/item/weapon/gun))
		var/obj/item/weapon/gun/G = W
		if(istype(G, /obj/item/weapon/gun/energy/lasgun))
			var/obj/item/weapon/gun/energy/lasgun/L = G
			if(L.rounds)
				light(span_notice("[user]熟练地用[L]的低功率档点燃了[user.p_their()][src]。"))
			else
				to_chat(user, span_warning("你试图用[L]点燃你的[src],但你的电池没有电了!"))
		else if(istype(LAZYACCESS(G.attachments_by_slot, ATTACHMENT_SLOT_UNDER), /obj/item/weapon/gun/flamer))
			light(span_notice("[user]用下挂式[LAZYACCESS(G.attachments_by_slot, ATTACHMENT_SLOT_UNDER)]点燃了[user.p_their()][src]。"))

	else if(istype(W, /obj/item/tool/surgery/cautery))
		light(span_notice("[user]用[W]点燃了[user.p_their()][src]。"))

	else if(istype(W, /obj/item/clothing/mask/cigarette))
		var/obj/item/clothing/mask/cigarette/C = W
		if(C.lit)
			light(span_notice("[user]尝试了几次后用[C]点燃了[user.p_their()][src]。"))

	else if(istype(W, /obj/item/tool/candle))
		if(W.heat > 200)
			light(span_notice("[user]尝试了几次后用[W]点燃了[user.p_their()][src]。"))

	else
		return ..()


/obj/item/clothing/mask/cigarette/afterattack(obj/item/reagent_containers/glass/glass, mob/living/user, proximity)
	. = ..()
	if(!proximity || lit) //can't dip if cigarette is lit
		return
	if(istype(glass))	//you can dip cigarettes into beakers
		if(glass.reagents.trans_to(src, chem_volume))	//if reagents were transfered, show the message
			to_chat(user, span_notice("你将\the [src]浸入\the [glass]中。"))
		else			//if not, either the beaker was empty, or the cigarette was full
			if(!glass.reagents.total_volume)
				to_chat(user, span_notice("[glass]是空的。"))
			else
				to_chat(user, span_notice("[src]是满的。"))

/obj/item/clothing/mask/cigarette/proc/light(flavor_text = null)
	if(lit)
		return

	lit = TRUE
	turn_light(null, TRUE)
	heat = 1000
	name = "lit [name]"
	attack_verb = list("burns", "singes")
	damtype = BURN
	if(reagents.get_reagent_amount(/datum/reagent/toxin/phoron)) // the phoron explodes when exposed to fire
		var/datum/effect_system/reagents_explosion/e = new()
		e.set_up(round(reagents.get_reagent_amount(/datum/reagent/toxin/phoron) * 0.4, 1), get_turf(src))
		e.start()
		qdel(src)
		return
	if(reagents.get_reagent_amount(/datum/reagent/fuel)) // the fuel explodes, too, but much less violently
		var/datum/effect_system/reagents_explosion/e = new()
		e.set_up(round(reagents.get_reagent_amount(/datum/reagent/fuel) * 0.2, 1), get_turf(src))
		e.start()
		qdel(src)
		return
	DISABLE_BITFIELD(reagents.reagent_flags, NO_REACT)
	reagents.handle_reactions()
	icon_state = icon_on
	worn_icon_state = icon_on
	if(flavor_text)
		var/turf/T = get_turf(src)
		T.visible_message(flavor_text)
	if(iscarbon(loc))
		var/mob/living/carbon/C = loc
		if(C.r_hand == src)
			C.update_inv_r_hand()
		else if(C.l_hand == src)
			C.update_inv_l_hand()
		else if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			if(H.wear_mask == src)
				H.update_inv_wear_mask()
	playsound(src, 'sound/items/cig_light.ogg', 15, 1)
	START_PROCESSING(SSobj, src)

/obj/item/clothing/mask/cigarette/process()
	var/mob/living/M = loc
	if(isliving(loc))
		M.IgniteMob()
	smoketime--
	if(smoketime < 1)
		if(ismob(loc))
			to_chat(M, span_notice("你的[name]熄灭了。"))
			playsound(src, 'sound/items/cig_snuff.ogg', 15, 1)
		die()
		return

	if(reagents?.total_volume)	//	check if it has any reagents at all
		if(iscarbon(loc) && (src == loc:wear_mask)) // if it's in the human/monkey mouth, transfer reagents to the mob //TODO WHAT BAYCODER USED A : UNIRONICALLY
			if(ishuman(loc))
				var/mob/living/carbon/human/H = loc
				if(H.species.species_flags & ROBOTIC_LIMBS)
					return
			var/mob/living/carbon/C = loc

			if(prob(15)) // so it's not an instarape in case of acid
				reagents.reaction(C, INGEST)
			reagents.trans_to(C, transquantity)
		else // else just remove some of the reagents
			reagents.remove_any(REAGENTS_METABOLISM)



/obj/item/clothing/mask/cigarette/attack_self(mob/user)
	if(lit)
		user.visible_message(span_notice("[user]平静地丢下并踩灭了点燃的[src],瞬间将其熄灭。"))
		playsound(src, 'sound/items/cig_snuff.ogg', 15, 1)
		die()
	return ..()

/obj/item/clothing/mask/cigarette/attack_obj(obj/target_object, mob/living/user)
	if(lit)
		return ..()
	if(!istype(target_object, /obj/machinery/light))
		return ..()
	var/obj/machinery/light/fixture = target_object
	if(fixture.status != LIGHT_BROKEN || !fixture.has_power())
		return ..()
	light(span_notice("[user]从破损的灯上点燃了[user.p_their()][src]。"))
	return TRUE

/obj/item/clothing/mask/cigarette/attack(mob/living/living_target, mob/living/user)
	if(lit)
		return ..()
	if(!living_target.on_fire)
		return ..()
	if(user == living_target)
		light(span_notice("[user]从自己燃烧的身体上点燃了[user.p_their()][src],这太疯狂了!"))
	else
		light(span_notice("[user]从[living_target]燃烧的身体上点燃了[user.p_their()][src],真是冷酷无情。"))
	return TRUE

/obj/item/clothing/mask/cigarette/attack_turf(turf/target_turf, mob/living/user)
	if(!lit && locate(/obj/fire/flamer) in target_turf.contents)
		light(span_notice("[user]用燃烧的地面点燃了[user.p_their()][src]。"))
		return TRUE
	return ..()

/obj/item/clothing/mask/cigarette/proc/die()
	var/turf/T = get_turf(src)
	new type_butt(T)
	if(ismob(loc))
		var/mob/living/M = loc
		M.temporarilyRemoveItemFromInventory(src)	//un-equip it so the overlays can update
		M.update_inv_wear_mask()
	STOP_PROCESSING(SSobj, src)
	qdel(src)

/obj/item/clothing/mask/cigarette/antitox
	name = "神经杀手香烟"
	desc = "一种新型香烟,旨在抵御有毒气体,但可能仍会让你感到疲倦。"
	icon_state = "anticigoff"
	worn_icon_state = "anticigoff"
	icon_on = "anticigon"
	smoketime = 30
	chem_volume = 60
	transquantity = 2 // one of each for the whole duration
	list_reagents = list(/datum/reagent/medicine/hyronalin = 30, /datum/reagent/water = 30)  //some water so it purges the rye too

/obj/item/clothing/mask/cigarette/emergency
	name = "红色同志"
	desc = "一根亮红色的香烟,上面似乎有俄罗斯品牌标识。然而,\"RUSSIAN RED\"这几个字是绝不会认错的。"
	icon_state = "rrcigoff"
	worn_icon_state = "rrcigoff"
	icon_on = "rrcigon"
	smoketime = 10
	transquantity = 1
	list_reagents = list(/datum/reagent/medicine/russian_red = 10)  //same ammount as a pill

/obj/item/clothing/mask/cigarette/bica
	name = "草莓味香烟"
	desc = "红色滤嘴。侧面印有一个词:\"(Bicaridine)\"。"
	icon_state = "bicacigoff"
	worn_icon_state = "bicacigoff"
	icon_on = "bicacigon"
	smoketime = 30
	transquantity = 5 // one of each for the whole duration
	list_reagents = list(/datum/reagent/medicine/bicaridine = 15)

/obj/item/clothing/mask/cigarette/kelo
	name = "柠檬味香烟"
	desc = "黄色滤嘴。侧面印有一个词:\"(KELOTANE)\"。"
	icon_state = "kelocigoff"
	worn_icon_state = "kelocigoff"
	icon_on = "kelocigon"
	smoketime = 30
	transquantity = 5 // one of each for the whole duration
	list_reagents = list(/datum/reagent/medicine/kelotane = 15)

/obj/item/clothing/mask/cigarette/tram
	name = "罂粟味香烟"
	desc = "地球政府阿片类药物替代品,经水稀释以规避2112年阿片类药物管制法案。"
	icon_state = "tramcigoff"
	worn_icon_state = "tramcigoff"
	icon_on = "tramcigon"
	smoketime = 15  //so half a minute
	chem_volume = 60
	transquantity = 2 // one of each for the whole duration
	list_reagents = list(/datum/reagent/medicine/tramadol = 30, /datum/reagent/water = 30)

////////////
// CIGARS //
////////////
/obj/item/clothing/mask/cigarette/cigar
	name = "高级雪茄"
	desc = "一卷棕色的烟草和...嗯,你不太确定。这东西可真大!"
	icon_state = "cigaroff"
	icon_on = "cigaron"
	icon_off = "cigaroff"
	type_butt = /obj/item/trash/cigbutt/cigarbutt
	throw_speed = 0.5
	worn_icon_state = "cigaroff"
	smoketime = 1500
	chem_volume = 40
	list_reagents = list(/datum/reagent/nicotine = 10)
	emissive_state = "cigaron_emissive"

/obj/item/clothing/mask/cigarette/cigar/cohiba
	name = "\improper Cohiba Robusto雪茄"
	desc = "对于一支雪茄,你几乎别无所求。"
	smoketime = 2000
	chem_volume = 80
	list_reagents = list(/datum/reagent/nicotine = 15)

/obj/item/clothing/mask/cigarette/cigar/havana
	name = "高级哈瓦那雪茄"
	desc = "一支只适合最顶尖之人的雪茄。"
	smoketime = 7200
	chem_volume = 50
	list_reagents = list(/datum/reagent/nicotine = 20)

/////////////////
//SMOKING PIPES//
/////////////////
/obj/item/clothing/mask/cigarette/pipe
	name = "烟斗"
	desc = "一个用于吸烟的烟斗。可能是海泡石之类的材质。"
	icon_state = "pipeoff"
	worn_icon_state = "pipeoff"
	icon_on = "pipeon"  //Note - these are in masks.dmi
	icon_off = "pipeoff"
	smoketime = 400

/obj/item/clothing/mask/cigarette/pipe/process()
	var/turf/location = get_turf(src)
	smoketime--
	if(smoketime < 1)
		new /obj/effect/decal/cleanable/ash(location)
		if(ismob(loc))
			var/mob/living/M = loc
			to_chat(M, span_notice("你的[name]熄灭了,你倒空了烟灰。"))
			heat = 0
			lit = FALSE
			turn_light(null, FALSE)
			icon_state = icon_off
			worn_icon_state = icon_off
			M.update_inv_wear_mask(0)
		STOP_PROCESSING(SSobj, src)
		return

/obj/item/clothing/mask/cigarette/pipe/attack_self(mob/user as mob) //Refills the pipe. Can be changed to an attackby later, if loose tobacco is added to vendors or something.
	if(lit)
		user.visible_message(span_notice("[user]熄灭了[src]。"))
		heat = 0
		lit = FALSE
		turn_light(user, FALSE)
		icon_state = icon_off
		worn_icon_state = icon_off
		STOP_PROCESSING(SSobj, src)
		return
	if(smoketime <= 0)
		to_chat(user, span_notice("你重新装填了烟斗里的烟草。"))
		smoketime = initial(smoketime)


/obj/item/clothing/mask/cigarette/pipe/cobpipe
	name = "玉米芯烟斗"
	desc = "一种由乡野林间人推广开来的尼古丁摄取装置, 在现代乃至未来仍被太空潮人们所钟爱."
	icon_state = "cobpipeoff"
	worn_icon_state = "cobpipeoff"
	icon_on = "cobpipeon"  //Note - these are in masks.dmi
	icon_off = "cobpipeoff"

/obj/item/clothing/mask/cigarette/pipe/cobpipe/curved
	name = "弯曲玉米芯烟斗"
	desc = "通常见于将军, 或是毫无理智嗜血成性的突击队员... 但很有格调!"
	icon_state = "curvedcoboff"
	worn_icon_state = "curvedcoboff"
	icon_on = "curvedcobon"  //Note - these are in masks.dmi
	icon_off = "curvedcoboff"

/obj/item/clothing/mask/cigarette/pipe/bonepipe
	name = "欧罗巴骨烟斗"
	desc = "用欧罗巴骨鲸的骨头制成的烟斗."
	icon_state = "bonepipeoff"
	worn_icon_state = "bonepipeoff"
	icon_on = "bonepipeon"  //Note - these are in masks.dmi
	icon_off = "bonepipeoff"

/////////
//ZIPPO//
/////////
/obj/item/tool/lighter
	name = "廉价打火机"
	desc = "一个廉价得跟白送似的打火机."
	icon = 'icons/obj/items/cigarettes.dmi'
	icon_state = "lighter-g"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/smoking_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/smoking_right.dmi',
	)
	worn_icon_state = "lighter-g"
	var/icon_on = "lighter-g-on"
	var/icon_off = "lighter-g"
	var/clr = "g"
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 0.6
	light_color = LIGHT_COLOR_FIRE
	w_class = WEIGHT_CLASS_TINY
	throwforce = 4
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	attack_verb = list("burns", "singes")

/obj/item/tool/lighter/zippo
	name = "\improper Zippo打火机"
	desc = "芝宝."
	icon_state = "zippo"
	worn_icon_state = "zippo"
	icon_on = "zippoon"
	icon_off = "zippo"

/obj/item/tool/lighter/random/Initialize(mapload)
	. = ..()
	clr = pick("r","c","y","g")
	icon_on = "lighter-[clr]-on"
	icon_off = "lighter-[clr]"
	icon_state = icon_off

/obj/item/tool/lighter/attack_self(mob/living/user)
	if(user.r_hand == src || user.l_hand == src)
		if(!heat)
			heat = 1500
			icon_state = icon_on
			worn_icon_state = icon_on
			if(istype(src, /obj/item/tool/lighter/zippo) )
				user.visible_message(span_rose("[user]连脚步都没停, 就流畅地翻开并点燃了[src]."))
				playsound(loc, 'sound/items/zippo_on.ogg', 15, 1)
			else
				if(prob(95))
					user.visible_message(span_notice("试了几次后, [user]总算点燃了[src]."))
				else
					to_chat(user, span_warning("你在点打火机时烧到了自己."))
					if (user.l_hand == src)
						user.apply_damage(2,BURN,"l_hand")
					else
						user.apply_damage(2,BURN,"r_hand")
					user.visible_message(span_notice("试了几次后, [user]总算点燃了[src], 不过[user.p_they()]在过程中烧到了[user.p_their()]手指."))
				playsound(loc, 'sound/items/lighter_on.ogg', 15, 1)
			set_light_on(TRUE)
		else
			turn_off(user, FALSE)
	else
		return ..()

/obj/item/tool/lighter/proc/turn_off(mob/living/bearer, silent = TRUE)
	if(heat)
		heat = 0
		icon_state = icon_off
		worn_icon_state = icon_off
		if(!silent)
			if(istype(src, /obj/item/tool/lighter/zippo) )
				bearer.visible_message(span_rose(">你听到一声轻响, [bearer]连看都没看自己在做什么就关掉了[src]."))
				playsound(loc, 'sound/items/zippo_off.ogg', 15, 1)
			else
				bearer.visible_message(span_notice("[bearer]悄悄关掉了[src]."))
				playsound(loc, 'sound/items/lighter_off.ogg', 15, 1)
		set_light_on(FALSE)
		return TRUE
	return FALSE

/obj/item/tool/lighter/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!isliving(M))
		return
	M.IgniteMob()
	if(!istype(M, /mob))
		return

	if(istype(M.wear_mask, /obj/item/clothing/mask/cigarette) && user.zone_selected == "mouth" && heat)
		var/obj/item/clothing/mask/cigarette/cig = M.wear_mask
		if(M == user)
			cig.attackby(src, user)
		else
			if(istype(src, /obj/item/tool/lighter/zippo))
				cig.light(span_rose("[user]猛地掏出[name]并把它递给[M]."))
			else
				cig.light(span_notice("[user]把[name]递给[M], 并点燃了[cig.name]."))
	else
		return ..()
