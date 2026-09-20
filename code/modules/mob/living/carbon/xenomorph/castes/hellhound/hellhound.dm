/datum/xeno_caste/hellhound
	caste_name = "Hellhound"
	display_name = "Hellhound"
	caste_type_path = /mob/living/carbon/xenomorph/hellhound
	caste_desc = "A fast, four-legged terror, but weak in sustained combat."
	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE
	wound_type = ""
	upgrade_name = ""

	caste_flags = CASTE_INNATE_HEALING|CASTE_INNATE_PLASMA_REGEN

	// *** Melee Attacks *** //
	melee_damage = 35

	// *** Speed *** //
	speed = -1

	// *** Plasma *** //
	plasma_max = 100
	plasma_gain = 10

	soft_armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 40, BIO = 55, FIRE = 55, ACID = 55)

	// *** Health *** //
	max_health = 290

	// *** Minimap Icon *** //
	minimap_icon = "hellhound"

	// *** Abilities *** ///
	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/xenohide,
		/datum/action/ability/activable/xeno/pounce/hellhound,
		/datum/action/ability/xeno_action/toggle_long_range,
	)

/mob/living/carbon/xenomorph/hellhound
	caste_base_type = /datum/xeno_caste/hellhound
	name = "Hellhound"
	desc = "一只来自地狱的恶心野兽,头上长着四根骇人的尖刺."
	icon = 'icons/Xeno/castes/hellhound.dmi'
	icon_state = "Hellhound Walking"
	health = 290
	maxHealth = 290
	plasma_stored = 100
	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE
	bubble_icon = "alien"

	layer = MOB_LAYER
	pull_speed = -0.5

	hivenumber = XENO_HIVE_YAUTJA

/mob/living/carbon/xenomorph/hellhound/Initialize(mapload, mob/living/carbon/xenomorph/oldXeno, h_number)
	. = ..(mapload, oldXeno, h_number || XENO_HIVE_YAUTJA)

	language_holder = get_language_holder()
	language_holder.grant_language(/datum/language/hellhound)
	language_holder.only_speaks_language = /datum/language/hellhound
	language_holder.grant_language(/datum/language/yautja)

	GLOB.alive_xeno_list -= src
	GLOB.xeno_mob_list -= src
	GLOB.hellhound_list += src

/mob/living/carbon/xenomorph/hellhound/prepare_huds()
	..()
	var/image/health_holder = hud_list[HEALTH_HUD_XENO]
	health_holder.pixel_x = -12
	var/image/plasma_holder = hud_list[PLASMA_HUD]
	plasma_holder.pixel_x = -12
	var/image/banished_holder = hud_list[XENO_BANISHED_HUD]
	banished_holder.pixel_x = -12
	banished_holder.pixel_y = -6

/mob/living/carbon/xenomorph/hellhound/Login()
	. = ..()
	to_chat(src, "<span style='font-weight: bold; color: red;'>注意!! 你正在扮演一只地狱犬. 如果你乱来会被服务器封禁,所以听好了!</span>")
	to_chat(src, "<span style='color: red;'>你必须在任何时候都听从并服从掠食者的命令. 如果他们要求你去死,那就去死. 对地狱犬来说,不服从他们是不可想象的.</span>")
	to_chat(src, "<span style='color: red;'>你来这里不是为了疯狂地当兰博. 你来这里是为了参与一件罕见的事,一场掠食者的狩猎.</span>")
	to_chat(src, "<span style='color: red;'>掠食者玩家必须遵守严格的角色扮演准则,你也一样.</span>")
	to_chat(src, "<span style='color: red;'>掠食者无法理解你的语言. 他们只能给你下达命令,并期望你服从.</span>")
	to_chat(src, "<span style='color: red;'>地狱犬会凶猛地保护自己的主人,如果主人受到攻击,它们绝不会离开主人身边.</span>")
	to_chat(src, "<span style='color: red;'>注意,任何掠食者都可以给你下达命令. 如果命令互相冲突,服从最新的那一个. 如果他们不喜欢你的表现,他们可以要求换一个幽灵,所有人都会嘲笑你. 所以好好干!</span>")

/mob/living/carbon/xenomorph/hellhound/death(gibbing, deathmessage = "lets out a horrible roar as it collapses and stops moving...", silent)
	. = ..()
	if(!.)
		return
	emote("roar")
	GLOB.hellhound_list -= src
	GLOB.alive_xeno_list -= src

/mob/living/carbon/xenomorph/hellhound/Destroy()
	GLOB.hellhound_list -= src
	GLOB.alive_xeno_list -= src
	return ..()

/datum/action/ability/activable/xeno/pounce/hellhound
	cooldown_duration = 5 SECONDS
