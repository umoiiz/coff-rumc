/mob/living/carbon/xenomorph/mantis
	caste_base_type = /datum/xeno_caste/mantis
	name = "Mantis"
	desc = "一种红色,暴力的异形,有四条腿和两把致命的镰刀.它的眼睛锐利地锁定猎物..."
	icon = 'icons/Xeno/castes/mantis/basic.dmi'
	icon_state = "Mantis Walking"
	effects_icon = 'icons/Xeno/castes/mantis/effects.dmi'
	health = 150
	maxHealth = 150
	plasma_stored = 50
	pixel_x = -16
	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE
	pull_speed = -2
	life_value = 0
	default_honor_value = 0

/mob/living/carbon/xenomorph/mantis/Corrupted
	hivenumber = XENO_HIVE_CORRUPTED

/mob/living/carbon/xenomorph/mantis/Alpha
	hivenumber = XENO_HIVE_ALPHA

/mob/living/carbon/xenomorph/mantis/Beta
	hivenumber = XENO_HIVE_BETA

/mob/living/carbon/xenomorph/mantis/Zeta
	hivenumber = XENO_HIVE_ZETA

/mob/living/carbon/xenomorph/mantis/admeme
	hivenumber = XENO_HIVE_ADMEME

/mob/living/carbon/xenomorph/mantis/Corrupted/fallen
	hivenumber = XENO_HIVE_FALLEN
