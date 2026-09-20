/datum/emote/living/carbon/robot // isn't actually robot only
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/robot, /mob/living/carbon/human/species/synthetic)

/datum/emote/living/carbon/robot/dwoop
	key = "dwoop"
	key_third_person = "dwoops"
	message = "开心地哔哔叫!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/voice/robotic/dwoop.ogg'

/datum/emote/living/carbon/robot/yes
	key = "yes"
	message = "发出肯定的哔声。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/voice/robotic/synth_yes.ogg'

/datum/emote/living/carbon/robot/no
	key = "no"
	message = "发出否定的哔声。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/voice/robotic/synth_no.ogg'

/datum/emote/living/carbon/robot/buzz
	key = "buzz"
	key_third_person = "buzzes"
	message = "嗡嗡响。"
	message_param = "对%t嗡嗡响。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/buzz-sigh.ogg'

/datum/emote/living/carbon/robot/buzz2
	key = "buzz2"
	message = "嗡嗡响两声。"
	message_param = "对%t嗡嗡响两声。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/buzz-two.ogg'

/datum/emote/living/carbon/robot/beep
	key = "beep"
	message = "尖锐地哔哔叫。"
	message_param = "对%t尖锐地哔哔叫。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/twobeep.ogg'

/datum/emote/living/carbon/robot/chime
	key = "chime"
	key_third_person = "chimes"
	message = "鸣响。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/chime.ogg'

/datum/emote/living/carbon/robot/honk
	key = "honk"
	key_third_person = "honks"
	message = "鸣笛。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/items/bikehorn.ogg'

/datum/emote/living/carbon/robot/ping
	key = "ping"
	key_third_person = "pings"
	message = "发出叮声。"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/ping.ogg'

/datum/emote/living/carbon/robot/sad
	key = "sad"
	message = "吹奏悲伤的长号..."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/misc/sadtrombone.ogg'

/datum/emote/living/carbon/robot/warn
	key = "warn"
	key_third_person = "warns"
	message = "发出刺耳的警报!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/warning-buzzer.ogg'

/datum/emote/living/carbon/robot/laughtrack
	key = "laughtrack"
	message = "播放笑声。"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/robot/laughtrack/get_sound(mob/living/user)
	return pick('sound/voice/robotic/sitcomLaugh1.ogg', 'sound/voice/robotic/sitcomLaugh2.ogg')

/datum/emote/living/carbon/robot/sneeze/get_sound(mob/living/user)
	return
