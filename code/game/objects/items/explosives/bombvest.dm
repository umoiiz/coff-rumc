/obj/item/clothing/suit/storage/marine/boomvest
	name = "战术爆破背心"
	desc = "显然有人只是把炸弹绑在陆战队员的背带上, 然后称之为战术装备. 灯已被移除, 其开关被用作引爆器.<br><span class='notice'>Ctrl-点击设置战吼.</span> <span class='warning'>这件背带没有灯, 切换它将会引爆背心! 防暴盾可以阻止战术爆破背心的引爆!!</span>"
	icon_state = "boom_vest"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	slowdown = 0
	item_map_variant_flags = NONE
	armor_features_flags = NONE
	species_exception = list(/datum/species/robot)
	actions_types = list(/datum/action/item_action/toggle/suit_toggle/boom)
	///Warcry to yell upon detonation
	var/bomb_message
	///List of warcries that are not allowed.
	var/bad_warcries_regex = "allahu ackbar|allah|ackbar"

/obj/item/clothing/suit/storage/marine/boomvest/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_SHIELD_DETACH, PROC_REF(shield_dropped))

/obj/item/clothing/suit/storage/marine/boomvest/unequipped(mob/unequipper, slot)
	. = ..()
	UnregisterSignal(unequipper, COMSIG_MOB_SHIELD_DETACH)

///Updates the last shield drop time when one is dropped
/obj/item/clothing/suit/storage/marine/boomvest/proc/shield_dropped()
	SIGNAL_HANDLER
	TIMER_COOLDOWN_START(src, COOLDOWN_BOMBVEST_SHIELD_DROP, 5 SECONDS)

///Overwrites the parent function for activating a light. Instead it now detonates the bomb.
/obj/item/clothing/suit/storage/marine/boomvest/attack_self(mob/living/carbon/human/activator)
	if(issynth(activator) && !CONFIG_GET(flag/allow_synthetic_gun_use))
		balloon_alert(activator, "无法穿戴")
		return TRUE
	if(HAS_TRAIT(activator, TRAIT_STEALTH))
		balloon_alert(activator, "不行, 你的披风阻止了你")
		return TRUE
	if(activator.wear_suit != src)
		balloon_alert(activator, "只能在穿戴时引爆")
		return FALSE
	if(istype(activator.l_hand, /obj/item/weapon/shield/riot) || istype(activator.r_hand, /obj/item/weapon/shield/riot) || istype(activator.back, /obj/item/weapon/shield/riot))
		balloon_alert(activator, "不行, 你的盾牌阻止了你")
		return FALSE
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_BOMBVEST_SHIELD_DROP))
		balloon_alert(activator, "不行, 盾牌掉落得太近了")
		return FALSE
	if(LAZYACCESS(activator.do_actions, src))
		return
	if(bomb_message)
		activator.say("[bomb_message]!!")
	if(!do_after(activator, 0.5 SECONDS, IGNORE_USER_LOC_CHANGE, src, BUSY_ICON_DANGER))
		return FALSE
	boom(activator)

/obj/item/clothing/suit/storage/marine/boomvest/proc/boom(mob/living/carbon/human/activator)
	var/turf/target = get_turf(loc)
	if(bomb_message) //Checks for a non null bomb message.
		message_admins("[activator] has detonated an explosive vest with the warcry \"[bomb_message]\" at [ADMIN_VERBOSEJMP(target)]") //Incase disputes show up about marines killing themselves and others.
		log_game("[activator] has detonated an explosive vest with the warcry \"[bomb_message]\" at [AREACOORD(target)]")
	else
		message_admins("[activator] has detonated an explosive vest with no warcry at [ADMIN_VERBOSEJMP(target)]")
		log_game("[activator] has detonated an explosive vest with no warcry at [AREACOORD(target)]")

	cell_explosion(target, 275, 65)
	flame_radius(5, target)

	activator.ex_act(500)
	activator.record_tactical_unalive()
	qdel(src)

/obj/item/clothing/suit/storage/marine/boomvest/attack_hand_alternate(mob/living/user)
	. = ..()
	var/new_bomb_message = stripped_input(user, "Select Warcry", "Warcry", null, 50)
	var/filter_result = CAN_BYPASS_FILTER(user) ? null : is_ic_filtered_for_bombvests(new_bomb_message)
	if(filter_result)
		to_chat(user, span_info("该战吼在IC聊天中被禁止."))
		REPORT_CHAT_FILTER_TO_USER(src, filter_result)
		log_filter("Bombvest", new_bomb_message, filter_result)
		return
	var/soft_filter_result = CAN_BYPASS_FILTER(user) ? null : is_soft_ic_filtered_for_bombvests(new_bomb_message)
	if(soft_filter_result)
		if(tgui_alert(usr,"你的消息包含\"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". \"[soft_filter_result[CHAT_FILTER_INDEX_REASON]]\", 你确定要说出来吗?", "软屏蔽词", list("Yes", "No")) != "Yes")
			SSblackbox.record_feedback(FEEDBACK_TALLY, "soft_ic_blocked_words", 1, lowertext(config.soft_ic_filter_regex.match))
			log_filter("Soft IC", new_bomb_message, filter_result)
			return FALSE
		message_admins("[ADMIN_LOOKUPFLW(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[new_bomb_message]\"")
		log_admin_private("[key_name(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[new_bomb_message]\"")
		SSblackbox.record_feedback(FEEDBACK_TALLY, "passed_soft_ic_blocked_words", 1, lowertext(config.soft_ic_filter_regex.match))
		log_filter("Soft IC (Passed)", new_bomb_message, filter_result)
	bomb_message = new_bomb_message
	to_chat(user, span_info("战吼已设置为: \"[bomb_message]\"."))

//admin only
/obj/item/clothing/suit/storage/marine/boomvest/ob_vest
	name = "轨道轰炸背心"
	desc = "这里是你的中尉在讲话, 我完全清楚那些坐标是干什么用的."

/obj/item/clothing/suit/storage/marine/boomvest/ob_vest/attack_self(mob/living/carbon/human/activator)
	if(activator.wear_suit != src)
		balloon_alert(activator, "只能在穿戴时引爆")
		return FALSE
	if(LAZYACCESS(activator.do_actions, src))
		return
	if(!do_after(activator, 1 SECONDS, IGNORE_USER_LOC_CHANGE, src, BUSY_ICON_DANGER))
		return FALSE
	boom(activator)

/obj/item/clothing/suit/storage/marine/boomvest/ob_vest/boom(mob/living/carbon/human/activator)
	var/turf/target = get_turf(loc)
	activator.say("I'M FIRING IT AS AN OB!!")
	message_admins("[activator] has detonated an Orbital Bombardment vest at [ADMIN_VERBOSEJMP(target)]")
	log_game("[activator] has detonated an Orbital Bombardment vest at [AREACOORD(target)]")

	activator.ex_act(1500)
	cell_explosion(target, 750, 50)
	flame_radius(15, target)
	qdel(src)

//AI logic
/datum/action/item_action/toggle/suit_toggle/boom/ai_should_start_consider()
	return TRUE

/datum/action/item_action/toggle/suit_toggle/boom/ai_should_use(atom/target)
	if(!target)
		return FALSE
	if(isainode(target))
		return FALSE
	if(!isliving(target) && !isarmoredvehicle(target) && !ismecha(target))
		return FALSE
	if(get_dist(owner, target) > 2)
		return FALSE
	var/atom/movable/movable_target = target
	if(movable_target.faction == owner.faction)
		return FALSE
	if(!can_use_action())
		return FALSE
	return TRUE
