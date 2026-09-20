/datum/emote/living/carbon/human
	mob_type_allowed_typecache = /mob/living/carbon/human

/datum/emote/living/carbon/human/run_emote(mob/living/carbon/human/user, params, type_override, intentional = FALSE, prefix)
	var/paygrade = user.get_paygrade()
	if(paygrade)
		prefix = "<b>[paygrade]</b> "
	return ..()

/datum/emote/living/carbon/human/blush
	key = "blush"
	key_third_person = "blushes"
	message = "脸红了。"

/datum/emote/living/carbon/human/blink
	key = "blink"
	key_third_person = "blinks"
	message = "眨了眨眼。"

/datum/emote/living/carbon/human/blink_r
	key = "blinkr"
	message = "快速眨眼。"

/datum/emote/living/carbon/human/bow
	key = "bow"
	key_third_person = "bows"
	message = "鞠躬。"
	message_param = "向%t鞠躬。"
	emote_flags = EMOTE_RESTRAINT_CHECK

/datum/emote/living/carbon/human/chuckle
	key = "chuckle"
	key_third_person = "chuckles"
	message = "轻笑。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/cross
	key = "cross"
	key_third_person = "crosses"
	message = "双臂交叉。"
	emote_flags = EMOTE_RESTRAINT_CHECK

/datum/emote/living/carbon/human/clap
	key = "clap"
	key_third_person = "claps"
	message = "鼓掌。"
	emote_flags = EMOTE_RESTRAINT_CHECK|EMOTE_VARY|EMOTE_MUZZLE_IGNORE
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/misc/clap.ogg'

/datum/emote/living/carbon/human/collapse
	key = "collapse"
	key_third_person = "collapses"
	message = "倒下了!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/collapse/run_emote(mob/living/carbon/human/user, params, type_override, intentional = FALSE, prefix)
	. = ..()
	if(!.)
		return
	user.Unconscious(4 SECONDS)

/datum/emote/living/carbon/human/cough
	key = "cough"
	key_third_person = "coughs"
	message = "咳嗽!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/cough/get_sound(mob/living/carbon/human/user)
	if(!user.species)
		return
	if(user.species.coughs[user.gender])
		return user.species.coughs[user.gender]
	if(user.species.coughs[NEUTER])
		return user.species.coughs[NEUTER]

/datum/emote/living/carbon/human/cry
	key = "cry"
	key_third_person = "cries"
	message = "哭泣。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/drool
	key = "drool"
	key_third_person = "drools"
	message = "流口水。"

/datum/emote/living/carbon/human/eyebrow
	key = "eyebrow"
	message = "挑起眉毛。"

/datum/emote/living/carbon/human/faint
	key = "faint"
	key_third_person = "faints"
	message = "晕倒。"

/datum/emote/living/carbon/human/faint/run_emote(mob/living/carbon/human/user, params, type_override, intentional = FALSE, prefix)
	. = ..()
	if(!.)
		return
	user.AdjustSleeping(1 SECONDS)

/datum/emote/living/carbon/human/frown
	key = "frown"
	key_third_person = "frowns"
	message = "皱眉。"

/datum/emote/living/carbon/human/gasp
	key = "gasp"
	key_third_person = "gasps"
	message = "倒吸一口气!"
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS

/datum/emote/living/carbon/human/gasp/get_sound(mob/living/carbon/human/user)
	if(!user.species)
		return
	if(user.species.gasps[user.gender])
		return user.species.gasps[user.gender]
	if(user.species.gasps[NEUTER])
		return user.species.gasps[NEUTER]

/datum/emote/living/carbon/human/giggle
	key = "giggle"
	key_third_person = "giggles"
	message = "咯咯笑。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/glare
	key = "glare"
	key_third_person = "glares"
	message = "怒视。"
	message_param = "怒视%t。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yawn
	key = "yawn"
	key_third_person = "yawns"
	message = "打哈欠。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/wave
	key = "wave"
	key_third_person = "waves"
	message = "挥手。"

/datum/emote/living/carbon/human/twitch
	key = "twitch"
	key_third_person = "twitches"
	message = "抽搐。"

/datum/emote/living/carbon/human/snore
	key = "snore"
	key_third_person = "snores"
	message = "打鼾。"
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS

/datum/emote/living/carbon/human/smile
	key = "smile"
	key_third_person = "smiles"
	message = "微笑。"

/datum/emote/living/carbon/human/smug
	key = "smug"
	key_third_person = "smugs"
	message = "得意地咧嘴笑。"

/datum/emote/living/carbon/human/stare
	key = "stare"
	key_third_person = "stares"
	message = "凝视。"
	message_param = "凝视%t。"

/datum/emote/living/carbon/human/strech
	key = "stretch"
	key_third_person = "stretches"
	message = "伸展手臂。"

/datum/emote/living/carbon/human/sulk
	key = "sulk"
	key_third_person = "sulks"
	message = "沮丧地闷闷不乐。"

/datum/emote/living/carbon/human/surrender
	key = "surrender"
	key_third_person = "surrenders"
	message = "双手抱头倒在地上,他们投降了!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/surrender/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return
	if(!isliving(user))
		return
	var/mob/living/L = user
	L.Paralyze(20 SECONDS)

/datum/emote/living/carbon/human/sneeze
	key = "sneeze"
	key_third_person = "sneezes"
	message = "打喷嚏。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/sniff
	key = "sniff"
	key_third_person = "sniffs"
	message = "抽鼻子。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/shiver
	key = "shiver"
	key_third_person = "shiver"
	message = "颤抖。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/scowl
	key = "scowl"
	key_third_person = "scowls"
	message = "怒容满面。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/sigh
	key = "sigh"
	key_third_person = "sighs"
	message = "叹气。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/sit
	key = "sit"
	key_third_person = "sits"
	message = "坐下。"

/datum/emote/living/carbon/human/shrug
	key = "shrug"
	key_third_person = "shrugs"
	message = "耸肩。"

/datum/emote/living/carbon/human/shakehead
	key = "shakehead"
	key_third_person = "shakeheads"
	message = "摇头。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/nod
	key = "nod"
	key_third_person = "nods"
	message = "点头。"
	message_param = "向%t点头。"

/datum/emote/living/carbon/human/gag
	key = "gag"
	key_third_person = "gags"
	message = "作呕。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/glare
	key = "glare"
	key_third_person = "glares"
	message = "怒视。"
	message_param = "怒视%t。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/grin
	key = "grin"
	key_third_person = "grins"
	message = "咧嘴笑。"

/datum/emote/living/carbon/human/grimace
	key = "grimace"
	key_third_person = "grimaces"
	message = "做鬼脸。"

/datum/emote/living/carbon/human/grumble
	key = "grumble"
	key_third_person = "grumbles"
	message = "嘟囔!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/kiss
	key = "kiss"
	key_third_person = "kisses"
	message = "飞吻。"
	message_param = "向%t飞吻。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/signal
	key = "signal"
	key_third_person = "signals"
	message_param = "竖起%t根手指。"
	emote_flags = EMOTE_RESTRAINT_CHECK

/datum/emote/living/carbon/human/signal/select_param(mob/user, params)
	params = text2num(params)
	if(params == 1 || !isnum(params))
		return "raises one finger."
	params = num2text(clamp(params, 2, 10))
	return ..()

/datum/emote/living/carbon/human/mumble
	key = "mumble"
	key_third_person = "mumbles"
	message = "含糊嘟囔!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/moan
	key = "moan"
	key_third_person = "moans"
	message = "呻吟!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/laugh
	key = "laugh"
	key_third_person = "laughs"
	message = "大笑。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/laugh/get_sound(mob/living/carbon/human/user)
	if(!user?.species?.laughs)
		return
	if(user.species.laughs[user.gender])
		return user.species.laughs[user.gender]
	if(user.species.laughs[NEUTER])
		return user.species.laughs[NEUTER]

/datum/emote/living/carbon/human/warcry
	key = "warcry"
	key_third_person = "warcries"
	message = "发出鼓舞人心的呐喊!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/warcry/get_sound(mob/living/carbon/human/user)
	if(!user.species)
		return
	if(user.species.warcries[user.gender])
		return user.species.warcries[user.gender]
	if(user.species.warcries[NEUTER])
		return user.species.warcries[NEUTER]

/datum/emote/living/carbon/human/warcry/run_emote(mob/user, params, type_override, intentional = FALSE, prefix)
	. = ..()
	if(!.)
		return
	var/image/warcry = image('icons/mob/talk.dmi', user, icon_state = "warcry")
	user.add_emote_overlay(warcry)

/datum/emote/living/carbon/human/snap
	key = "snap"
	key_third_person = "snaps"
	message = "打响指"
	emote_type = EMOTE_AUDIBLE
	emote_flags = EMOTE_RESTRAINT_CHECK|EMOTE_MUZZLE_IGNORE|EMOTE_ARMS_CHECK
	sound = 'sound/misc/fingersnap.ogg'

/datum/emote/living/carbon/human/hug
	key = "hug"
	key_third_person = "hugs"
	message = "抱住自己"
	message_param = "拥抱%t。"
	emote_flags = EMOTE_RESTRAINT_CHECK
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/look
	key = "look"
	key_third_person = "looks"
	message = "看。"
	message_param = "看向%t。"

/datum/emote/living/carbon/human/handshake
	key = "handshake"
	message = "握自己的手。"
	message_param = "与%t握手。"
	emote_flags = EMOTE_RESTRAINT_CHECK
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/salute
	key = "salute"
	key_third_person = "salutes"
	message = "敬礼。"
	message_param = "向%t敬礼。"
	emote_flags = EMOTE_RESTRAINT_CHECK
	sound = 'sound/misc/salute.ogg'

/datum/emote/living/carbon/human/golfclap
	key = "golfclap"
	key_third_person = "golfclaps"
	message = "鼓掌,显然不为所动。"
	emote_flags = EMOTE_RESTRAINT_CHECK
	sound = 'sound/misc/golfclap.ogg'

/datum/emote/living/carbon/human/pout
	key = "pout"
	key_third_person = "pouts"
	message = "撅嘴。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/scream
	key = "scream"
	key_third_person = "screams"
	message = "尖叫!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/scream/get_sound(mob/living/carbon/human/user)
	if(!user.species)
		return
	if(user.species.screams[user.gender])
		return user.species.screams[user.gender]
	if(user.species.screams[NEUTER])
		return user.species.screams[NEUTER]

/datum/emote/living/carbon/human/scream/run_emote(mob/user, params, type_override, intentional = FALSE, prefix)
	. = ..()
	if(!.)
		return
	var/image/scream = image('icons/mob/talk.dmi', user, icon_state = "scream")
	user.add_emote_overlay(scream)

/datum/emote/living/carbon/human/medic
	key = "medic"
	message = "呼叫医疗兵!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/medic/get_sound(mob/living/carbon/human/user)
	if(isrobot(user))
		if(user.gender == MALE)
			if(prob(95))
				return 'sound/voice/robotic/male_medic.ogg'
			else
				return 'sound/voice/robotic/male_medic2.ogg'
		else
			return 'sound/voice/robotic/female_medic.ogg'
	if(user.gender == MALE)
		if(prob(95))
			return 'sound/voice/human/male/medic.ogg'
		else if(prob(95))
			return 'sound/voice/human/male/medic2.ogg'
		else
			return 'sound/voice/human/male/medic_bag.ogg'
	else
		return 'sound/voice/human/female/medic.ogg'

/datum/emote/living/carbon/human/medic/run_emote(mob/user, params, type_override, intentional = FALSE, prefix)
	. = ..()
	if(!.)
		return
	var/image/medic = image('icons/mob/talk.dmi', user, icon_state = "medic")
	user.add_emote_overlay(medic)
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_MOB_CALL_MEDIC, user)

/datum/emote/living/carbon/human/pain
	key = "pain"
	message = "痛苦地哭喊!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/pain/get_sound(mob/living/carbon/human/user)
	if(!user.species)
		return
	if(user.species.paincries[user.gender])
		return user.species.paincries[user.gender]
	if(user.species.paincries[NEUTER])
		return user.species.paincries[NEUTER]

/datum/emote/living/carbon/human/pain/run_emote(mob/user, params, type_override, intentional = FALSE, prefix)
	. = ..()
	if(!.)
		return
	var/image/pain = image('icons/mob/talk.dmi', user, icon_state = "pain")
	user.add_emote_overlay(pain)

/datum/emote/living/carbon/human/gored
	key = "gored"
	message = "痛苦地干呕!"
	emote_type = EMOTE_AUDIBLE
	emote_flags = EMOTE_FORCED_AUDIO

/datum/emote/living/carbon/human/gored/get_sound(mob/living/carbon/human/user)
	if(!user.species)
		return
	if(user.species.goredcries[user.gender])
		return user.species.goredcries[user.gender]
	if(user.species.goredcries[NEUTER])
		return user.species.goredcries[NEUTER]

/datum/emote/living/carbon/human/gored/run_emote(mob/user, params, type_override, intentional = FALSE, prefix)
	. = ..()
	if(!.)
		return
	var/image/pain = image('icons/mob/talk.dmi', user, icon_state = "pain")
	user.add_emote_overlay(pain)

/datum/emote/living/carbon/human/burstscream
	key = "burstscream"
	message = "痛苦地尖叫!"
	emote_type = EMOTE_AUDIBLE
	emote_flags = EMOTE_FORCED_AUDIO
	stat_allowed = UNCONSCIOUS

/datum/emote/living/carbon/human/burstscream/get_sound(mob/living/carbon/human/user)
	if(!user.species)
		return
	if(user.species.burstscreams[user.gender])
		return user.species.burstscreams[user.gender]
	if(user.species.burstscreams[NEUTER])
		return user.species.burstscreams[NEUTER]

/datum/emote/living/carbon/human/burstscream/run_emote(mob/user, params, type_override, intentional = FALSE, prefix)
	. = ..()
	if(!.)
		return
	var/image/pain = image('icons/mob/talk.dmi', user, icon_state = "pain")
	user.add_emote_overlay(pain)

/datum/emote/living/carbon/human/sneeze/get_sound(mob/living/user)
	if(isrobot(user))
		return
	if(user.gender == FEMALE)
		return 'sound/misc/human_female_sneeze_1.ogg'
	else
		return 'sound/misc/human_male_sneeze_1.ogg'

/datum/emote/living/carbon/human/sigh/get_sound(mob/living/user)
	if(isrobot(user))
		return
	if(user.gender == FEMALE)
		return 'sound/voice/human/female/sigh_1.ogg'
	else
		return 'sound/voice/human/male/sigh_1.ogg'

/datum/emote/living/carbon/human/giggle/get_sound(mob/living/user)
	if(isrobot(user))
		if(user.gender == FEMALE)
			return 'sound/voice/robotic/female_giggle.ogg'
		else
			return 'sound/voice/robotic/male_giggle.ogg'
	if(user.gender == FEMALE)
		return 'sound/voice/human/female/giggle_1.ogg'
	else
		return 'sound/voice/human/male/giggle_1.ogg'

/datum/emote/living/carbon/human/yawn/get_sound(mob/living/user)
	if(isrobot(user))
		return
	if(user.gender == FEMALE)
		return 'sound/voice/human/female/yawn_1.ogg'
	else
		return 'sound/voice/human/male/yawn_1.ogg'

/datum/emote/living/carbon/human/moan/get_sound(mob/living/user)
	if(isrobot(user))
		return
	if(user.gender == FEMALE)
		return 'sound/voice/human/female/moan_1.ogg'
	else
		return 'sound/voice/human/male/moan_1.ogg'

/datum/emote/living/carbon/human/cry/get_sound(mob/living/user)
	if(isrobot(user))
		return
	if(user.gender == FEMALE)
		return 'sound/voice/human/female/cry_1.ogg'
	else
		return 'sound/voice/human/male/cry_1.ogg'

/datum/emote/living/carbon/human/whistle
	key = "whistle"
	key_third_person = "whistles"
	message = "口哨声"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/whistle/get_sound(mob/living/user)
	if(isrobot(user))
		return
	return 'sound/voice/human/whistle1.ogg'

/datum/emote/living/carbon/human/crack
	key = "crack"
	key_third_person = "cracks"
	message = "掰响指关节。"
	emote_type = EMOTE_AUDIBLE
	emote_flags = EMOTE_RESTRAINT_CHECK|EMOTE_MUZZLE_IGNORE|EMOTE_ARMS_CHECK
	sound = 'sound/misc/sound_misc_knuckles.ogg'

/datum/emote/living/carbon/human/trick
	key = "trick"
	key_third_person = "tricks"
	emote_flags = EMOTE_ACTIVE_ITEM|EMOTE_RESTRAINT_CHECK

/datum/emote/living/carbon/human/trick/run_emote(mob/user, params, type_override, intentional, prefix)
	. = ..()
	if(!.)
		return
	var/obj/item/I = user.get_active_held_item()
	I.do_trick(usr)

/datum/emote/living/carbon/human/circle
	key = "circle"
	key_third_person = "circles"
	emote_flags = EMOTE_RESTRAINT_CHECK|EMOTE_ARMS_CHECK

/datum/emote/living/carbon/human/circle/run_emote(mob/user, params, type_override, intentional, prefix)
	. = ..()
	var/obj/item/hand_item/circlegame/circle = new(user)
	if(user.put_in_hands(circle))
		to_chat(user, span_notice("你用手比了个圈。"))
	else
		to_chat(user, span_warning("你没有空闲的手来比圈。"))

