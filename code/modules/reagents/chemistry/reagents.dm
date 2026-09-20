GLOBAL_LIST_INIT(name2reagent, build_name2reagent())

/// Maps stable type IDs and pre-localization dispenser macro IDs to reagents.
/// The legacy keys below are saved-data identifiers, not display text. Do not
/// translate or regenerate them from reagent.name: ckey() discards CJK text.
/proc/build_name2reagent()
	. = list(
		"aluminum" = /datum/reagent/aluminum,
		"carbon" = /datum/reagent/carbon,
		"chlorine" = /datum/reagent/chlorine,
		"capsaicinoil" = /datum/reagent/consumable/capsaicin,
		"coffee" = /datum/reagent/consumable/coffee,
		"cream" = /datum/reagent/consumable/cream,
		"drgibb" = /datum/reagent/consumable/dr_gibb,
		"universalenzyme" = /datum/reagent/consumable/enzyme,
		"ethanol" = /datum/reagent/consumable/ethanol,
		"absinthe" = /datum/reagent/consumable/ethanol/absinthe,
		"ale" = /datum/reagent/consumable/ethanol/ale,
		"applejack" = /datum/reagent/consumable/ethanol/applejack,
		"atomicbomb" = /datum/reagent/consumable/ethanol/atomicbomb,
		"beer" = /datum/reagent/consumable/ethanol/beer,
		"maltliquor" = /datum/reagent/consumable/ethanol/beer/maltliquor,
		"coconutrum" = /datum/reagent/consumable/ethanol/coconut_rum,
		"cognac" = /datum/reagent/consumable/ethanol/cognac,
		"cremedecacao" = /datum/reagent/consumable/ethanol/creme_de_cacao,
		"cremedecoconut" = /datum/reagent/consumable/ethanol/creme_de_coconut,
		"cremedementhe" = /datum/reagent/consumable/ethanol/creme_de_menthe,
		"curaao" = /datum/reagent/consumable/ethanol/curacao,
		"fernet" = /datum/reagent/consumable/ethanol/fernet,
		"gin" = /datum/reagent/consumable/ethanol/gin,
		"hardcider" = /datum/reagent/consumable/ethanol/hcider,
		"kahlua" = /datum/reagent/consumable/ethanol/kahlua,
		"navyrum" = /datum/reagent/consumable/ethanol/navy_rum,
		"ricebeer" = /datum/reagent/consumable/ethanol/rice_beer,
		"rum" = /datum/reagent/consumable/ethanol/rum,
		"sake" = /datum/reagent/consumable/ethanol/sake,
		"tequila" = /datum/reagent/consumable/ethanol/tequila,
		"thirteenloko" = /datum/reagent/consumable/ethanol/thirteenloko,
		"triplesec" = /datum/reagent/consumable/ethanol/triple_sec,
		"vermouth" = /datum/reagent/consumable/ethanol/vermouth,
		"vodka" = /datum/reagent/consumable/ethanol/vodka,
		"whiskey" = /datum/reagent/consumable/ethanol/whiskey,
		"whiskeycola" = /datum/reagent/consumable/ethanol/whiskey_cola,
		"wine" = /datum/reagent/consumable/ethanol/wine,
		"yyake" = /datum/reagent/consumable/ethanol/yuyake,
		"grenadine" = /datum/reagent/consumable/grenadine,
		"ice" = /datum/reagent/consumable/ice,
		"lemonlime" = /datum/reagent/consumable/lemon_lime,
		"lemonjuice" = /datum/reagent/consumable/lemonjuice,
		"limejuice" = /datum/reagent/consumable/limejuice,
		"melonsoda" = /datum/reagent/consumable/melon_soda,
		"menthol" = /datum/reagent/consumable/menthol,
		"orangejuice" = /datum/reagent/consumable/orangejuice,
		"pineapplejuice" = /datum/reagent/consumable/pineapplejuice,
		"pwrgame" = /datum/reagent/consumable/pwr_game,
		"shamblersjuice" = /datum/reagent/consumable/shamblers,
		"sodawater" = /datum/reagent/consumable/sodawater,
		"soldry" = /datum/reagent/consumable/sol_dry,
		"cola" = /datum/reagent/consumable/space_cola,
		"spaceup" = /datum/reagent/consumable/space_up,
		"smwind" = /datum/reagent/consumable/spacemountainwind,
		"sugar" = /datum/reagent/consumable/sugar,
		"tea" = /datum/reagent/consumable/tea,
		"icedtea" = /datum/reagent/consumable/tea/icetea,
		"tomatojuice" = /datum/reagent/consumable/tomatojuice,
		"tonicwater" = /datum/reagent/consumable/tonic,
		"copper" = /datum/reagent/copper,
		"fluorine" = /datum/reagent/fluorine,
		"hydrogen" = /datum/reagent/hydrogen,
		"iron" = /datum/reagent/iron,
		"lithium" = /datum/reagent/lithium,
		"mercury" = /datum/reagent/mercury,
		"nitrogen" = /datum/reagent/nitrogen,
		"oxygen" = /datum/reagent/oxygen,
		"phosphorus" = /datum/reagent/phosphorus,
		"potassium" = /datum/reagent/potassium,
		"radium" = /datum/reagent/radium,
		"silicon" = /datum/reagent/silicon,
		"sodium" = /datum/reagent/sodium,
		"sulfur" = /datum/reagent/sulfur,
		"sulphuricacid" = /datum/reagent/toxin/acid,
		"mindbreakertoxin" = /datum/reagent/toxin/mindbreaker,
		"uranium" = /datum/reagent/uranium,
		"water" = /datum/reagent/water,
	)
	for(var/reagent_type in subtypesof(/datum/reagent))
		.["[reagent_type]"] = reagent_type

/// A single reagent
/datum/reagent
	/// datums don't have names by default
	var/name = "Reagent"
	/// nor do they have descriptions
	var/description = ""
	///J/(K*mol)
	var/specific_heat = SPECIFIC_HEAT_DEFAULT
	/// used by taste messages
	var/taste_description = "metaphorical salt"
	///how this taste compares to others. Higher values means it is more noticable
	var/taste_multi = 1
	/// reagent holder this belongs to
	var/datum/reagents/holder = null
	/// LIQUID, SOLID, GAS
	var/reagent_state = LIQUID
	/// special data associated with this like viruses etc
	var/list/data
	/// increments everytime on_mob_life is called
	var/current_cycle = 0
	///pretend this is moles
	var/volume = 0
	/// color it looks in containers etc
	var/color = "#000000" // rgb: 0, 0, 0
	/// can this reagent be synthesized? (for example: odysseus syringe gun)
	var/can_synth = TRUE
	///how fast the reagent is metabolized by the mob
	var/custom_metabolism = REAGENTS_METABOLISM //how fast the reagent is metabolized by the mob
	/// You fucked up and this is now triggering its overdose effects, purge that shit quick.
	var/overdosed = FALSE
	/// You really fucked up and now getting the worst of the worse.
	var/overdosed_crit = FALSE
	/// above this overdoses happen
	var/overdose_threshold = 0
	/// above this the big bad overdoses happen
	var/overdose_crit_threshold = 0
	/// above this amount addictions start
	var/addiction_threshold = 0
	/// increases as addiction gets worse
	var/addiction_stage = 0
	/// does this show up on health analyzers
	var/scannable = TRUE
	/// Reagent priority in UI, lower value is higher priority
	var/reagent_ui_priority = REAGENT_UI_BASE
	/// if false stops metab in liverless mobs
	var/self_consuming = FALSE
	/// List of reagents removed by this chemical
	var/list/datum/reagent/purge_list
	/// rate at which it purges specific chems
	var/purge_rate = 0
	/// Specific trait flags, like HEARTSTOPPER CHESTSTOPPER BRADYCARDICS TACHYCARDIC
	var/trait_flags = NONE
	///Affects the strength of reagent effects
	var/effect_str = 1
	///Used for certain chems we don't want being extracted via dialysis or being used in cryo, makes all important medical machines (dispenser, cryo etc...) refuse to interact with the reagent
	var/medbayblacklist = FALSE
	///If true allow foam and smoke to transfer reagent into dead mobs
	var/reactindeadmob = TRUE

	///The default reagent container for the reagent, used for icon generation
	var/obj/item/reagent_containers/default_container = /obj/item/reagent_containers/cup/bottle

/datum/reagent/New()
	. = ..()
	if(LAZYLEN(purge_list))
		purge_list = typecacheof(purge_list)

/datum/reagent/Destroy() // This should only be called by the holder, so it's already handled clearing its references
	holder = null
	return ..()

/// Applies this reagent to a [/mob/living]
/datum/reagent/proc/reaction_mob(mob/living/L, method = TOUCH, volume, show_message = TRUE, touch_protection = 0)
	if(!istype(L))
		return FALSE
	if(method == VAPOR && L.reagents) //foam, spray
		var/amount = round(volume * touch_protection, 0.1)
		L.reagents.add_reagent(type, amount)

	return TRUE

/// Applies this reagent to an [/obj]
/datum/reagent/proc/reaction_obj(obj/O, volume)
	return

/// Applies this reagent to a [/turf]
/datum/reagent/proc/reaction_turf(turf/T, volume)
	return

/// Called from [/datum/reagents/proc/metabolize]
/datum/reagent/proc/on_mob_life(mob/living/L, metabolism)
	purge(L)
	current_cycle++
	holder.remove_reagent(type, custom_metabolism * L.metabolism_efficiency) //By default it slowly disappears.
	return TRUE

/// Called when this reagent is first added to a mob
/datum/reagent/proc/on_mob_add(mob/living/L, metabolism)
	return

/// Called when this reagent is removed while inside a mob
/datum/reagent/proc/on_mob_delete(mob/living/L, metabolism)
	return

/// Called if the reagent has passed the overdose threshold and is set to be triggering overdose effects
/datum/reagent/proc/overdose_process(mob/living/L, metabolism)
	return

/// Called when an overdose starts
/datum/reagent/proc/on_overdose_start(mob/living/L, metabolism)
	if(prob(30)) //placeholder vague feedback
		to_chat(L, span_notice("你感到有点恶心..."))
	log_combat(L, L, "has been overdosed on [name].")

/// Called when an overdose stops
/datum/reagent/proc/on_overdose_stop(mob/living/L, metabolism)
	return

/// Called when a CRITICAL overdose threshold and is trigger effects.
/datum/reagent/proc/overdose_crit_process(mob/living/L, metabolism)
	return

/// Called when a CRITICAL overdose starts.
/datum/reagent/proc/on_overdose_crit_start(mob/living/L, metabolism)
	log_combat(L, L, "has been critically overdosed on [name].")
	to_chat(L, span_danger("你感觉你摄入了太多[name]!"))


/// Called by [/datum/reagents/proc/conditional_update_move]
/datum/reagent/proc/on_move(atom/A)
	return

/// Called after add_reagents creates a new reagent.
/datum/reagent/proc/on_new(data)
	return

/// Called when two reagents of the same are mixing.
/datum/reagent/proc/on_merge(data)
	return

/// Called by [/datum/reagents/proc/conditional_update]
/datum/reagent/proc/on_update(atom/A)
	return

/// Called when the reagent container is hit by an explosion
/datum/reagent/proc/on_ex_act(severity)
	return

/// Called when addiction hits stage1, see [/datum/reagents/proc/metabolize]
/datum/reagent/proc/addiction_act_stage1(mob/living/L, metabolism)
	if(prob(30))
		to_chat(L, span_notice("你现在感觉想来点[name]."))


/// Called when addiction hits stage2, see [/datum/reagents/proc/metabolize]
/datum/reagent/proc/addiction_act_stage2(mob/living/L, metabolism)
	if(prob(30))
		to_chat(L, span_notice("你感觉你需要[name]. 你就是欲罢不能."))


/// Called when addiction hits stage3, see [/datum/reagents/proc/metabolize]
/datum/reagent/proc/addiction_act_stage3(mob/living/L, metabolism)
	if(prob(30))
		to_chat(L, span_danger("你对[name]有强烈的渴望."))


/// Called when addiction hits stage4, see [/datum/reagents/proc/metabolize]
/datum/reagent/proc/addiction_act_stage4(mob/living/L, metabolism)
	if(prob(30))
		to_chat(L, span_danger("你感觉一点都不好! 你真的需要一些[name]."))


///Convert reagent list to a printable string for logging etc
/proc/pretty_string_from_reagent_list(list/reagent_list)
	var/list/rs = list()
	for (var/datum/reagent/R in reagent_list)
		rs += "[R.name], [R.volume]"

	return rs.Join(" | ")

/// Called during metablism, checks to see if any chemicals need to purge other chemicals.
/datum/reagent/proc/purge(mob/living/L, metabolism)
	if(!LAZYLEN(purge_list))
		return
	var/count = LAZYLEN(purge_list)
	for(var/datum/reagent/R in L.reagents.reagent_list)
		if(count < 1)
			break
		if(is_type_in_typecache(R, purge_list))
			count--
			L.reagents.remove_reagent(R.type,purge_rate)

/datum/reagent/proc/ai_should_use(mob/living/target, inject_vol)
	if(target.stat == DEAD)
		return FALSE
	if(overdose_threshold < inject_vol + target.reagents.get_reagent_amount(type))
		return FALSE
	return TRUE
