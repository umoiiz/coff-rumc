/datum/emote/living/carbon/human/yautja
	mob_type_allowed_typecache = /mob/living/carbon/human/species/yautja

/datum/emote/living/carbon/human/yautja/anytime
	key = "anytime"
	sound = 'sound/voice/predator/anytime.ogg'
	key_third_person = "anytime"
	message = "任意时间"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/click
	key = "click"
	key_third_person = "click"
	message = "咔嗒声"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/click/get_sound(mob/living/user)
	if(prob(50))
		return 'sound/voice/predator/click1.ogg'
	else
		return 'sound/voice/predator/click2.ogg'

/datum/emote/living/carbon/human/yautja/helpme
	key = "helpme"
	sound = 'sound/voice/predator/helpme.ogg'
	key_third_person = "helpme"
	message = "救救我!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/iseeyou
	key = "iseeyou"
	sound = 'sound/hallucinations/i_see_you2.ogg'
	key_third_person = "iseeyou"
	message = "我看到你了!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/itsatrap
	key = "itsatrap"
	sound = 'sound/voice/predator/itsatrap.ogg'
	key_third_person = "itsatrap"
	message = "这是个陷阱!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/laugh1
	key = "laugh1"
	sound = 'sound/voice/predator/laugh1.ogg'
	key_third_person = "laugh1"
	message = "大笑"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/laugh2
	key = "laugh2"
	sound = 'sound/voice/predator/laugh2.ogg'
	key_third_person = "laugh2"
	message = "大笑"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/laugh3
	key = "laugh3"
	sound = 'sound/voice/predator/laugh3.ogg'
	key_third_person = "laugh3"
	message = "大笑"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/laugh4
	key = "laugh4"
	sound = 'sound/voice/predator/laugh4.ogg'
	key_third_person = "laugh4"
	message = "大笑"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/overhere
	key = "overhere"
	sound = 'sound/voice/predator/overhere.ogg'
	key_third_person = "overhere"
	message = "这边!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/predroar
	key = "predroar"
	key_third_person = "predroars"
	message = "咆哮!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/predroar/get_sound(mob/living/user)
	return pick('sound/voice/predator/roar1.ogg', 'sound/voice/predator/roar2.ogg')

/datum/emote/living/carbon/human/yautja/predroar2
	key = "predroar2"
	key_third_person = "predroars2"
	sound = 'sound/voice/predator/roar3.ogg'
	message = "咆哮!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/loudroar
	key = "loudroar"
	key_third_person = "loudroar"
	message = "大声咆哮!"
	cooldown = 120 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/loudroar/get_sound(mob/living/user)
	return pick('sound/voice/predator/roar4.ogg', 'sound/voice/predator/roar5.ogg')

/datum/emote/living/carbon/human/yautja/loudroar/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return

	for(var/mob/current_mob in GLOB.mob_list)
		if(!current_mob.z != user.z || !get_dist(get_turf(current_mob), get_turf(user)) <= 18)
			continue
		var/relative_dir = get_dir(current_mob, user)
		var/final_dir = dir2text(relative_dir)
		to_chat(current_mob, span_userdanger("你听到从[final_dir ? "the [final_dir]" : "nearby"]传来一声响亮的咆哮!"))

/datum/emote/living/carbon/human/yautja/turnaround
	key = "turnaround"
	key_third_person = "turnaround"
	message = "转身!"
	sound = 'sound/voice/predator/turnaround.ogg'
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/click2
	key = "click2"
	key_third_person = "click2"
	message = "咔嗒声"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/click2/get_sound(mob/living/user)
	return pick('sound/voice/predator/click3.ogg', 'sound/voice/predator/click4.ogg')

/datum/emote/living/carbon/human/yautja/aliengrowl
	key = "aliengrowl"
	key_third_person = "aliengrowl"
	message = "低吼!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/aliengrowl/get_sound(mob/living/user)
	return pick('sound/voice/alien/growl1.ogg', 'sound/voice/alien/growl2.ogg')

/datum/emote/living/carbon/human/yautja/alienhelp
	key = "alienhelp"
	key_third_person = "alienhelp"
	message = "需要帮助!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/alienhelp/get_sound(mob/living/user)
	return pick('sound/voice/alien/help1.ogg', 'sound/voice/alien/help2.ogg')

/datum/emote/living/carbon/human/yautja/comeonout
	key = "comeonout"
	key_third_person = "comeonout"
	message = "出来吧!"
	sound = 'sound/voice/predator/come_on_out.ogg'
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/overthere
	key = "overthere"
	key_third_person = "overthere"
	message = "那边!"
	sound = 'sound/voice/predator/over_there.ogg'
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/yautja/uglyfreak
	key = "uglyfreak"
	key_third_person = "uglyfreak"
	message = "丑陋的怪物!"
	sound = 'sound/voice/predator/ugly_freak.ogg'
	emote_type = EMOTE_AUDIBLE
