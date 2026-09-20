/mob/living/carbon/xenomorph/predalien
	caste_base_type = /datum/xeno_caste/predalien
	name = "Abomination" //snowflake name
	desc = "一种奇怪的生物,头部有肉质的条状物.它看起来像是护甲与血肉的混合体,光滑,但甲壳坚固."
	icon = 'icons/Xeno/castes/predalien/praetorian.dmi'
	icon_state = "Predalien Walking"
	effects_icon = 'icons/Xeno/castes/predalien/praetorian_effects.dmi'
	wall_smash = TRUE
	pixel_x = -16
	bubble_icon = "alienroyal"
	talk_sound = SFX_PREDALIEN_TALK
	mob_size = MOB_SIZE_BIG

	tier = XENO_TIER_FOUR
	upgrade = XENO_UPGRADE_NORMAL

	footstep_type = FOOTSTEP_PREDALIEN_STOMPY

	skins = list(
		/datum/xenomorph_skin/predalien,
		/datum/xenomorph_skin/predalien/warrior,
	)

	max_bonus_life_kills = 10

/mob/living/carbon/xenomorph/predalien/Initialize(mapload, mob/living/carbon/xenomorph/oldxeno, h_number)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(announce_spawn)), 3 SECONDS)
	hunter_data.dishonored = TRUE
	hunter_data.dishonored_reason = "An abomination upon the honor of us all!"
	hunter_data.dishonored_set = src
	hud_set_hunter()

/mob/living/carbon/xenomorph/predalien/Stat()
	. = ..()
	if(statpanel("Game"))
		stat("Life Kills Bonus:", "[min(life_kills_total, max_bonus_life_kills)] / [max_bonus_life_kills]")

/mob/living/carbon/xenomorph/predalien/proc/announce_spawn()
	if(!loc)
		return FALSE

	to_chat(src, {"
		<span class='role_body'>|______________________|</span>
		<span class='role_header'>你是一个掠食者-异形混种!</span>
		<span class='role_body'>你是一个非常强大的异形生物,诞生自一个亚乌查战士的身体.
		你比普通异形更强壮,更快速,更聪明,但你仍然必须听从巢穴统治者的命令.
		你拥有一定程度的自由,可以去狩猎并夺取巢穴敌人的首级,所以查看你的指令.
		你的生命值不会正常再生,所以为巢穴杀戮和赴死吧!</span>
		<span class='role_body'>|______________________|</span>
	"})
	emote("roar")

/mob/living/carbon/xenomorph/predalien/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/predalien/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/predalien/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/predalien/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/predalien/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/predalien/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
