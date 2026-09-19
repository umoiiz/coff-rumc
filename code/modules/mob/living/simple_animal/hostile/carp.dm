#define REGENERATION_DELAY 60  // After taking damage, how long it takes for automatic regeneration to begin for megacarps (ty robustin!)

/mob/living/simple_animal/hostile/carp
	name = "space carp"
	desc = "一只凶猛的,长着獠牙的,形似鱼的生物."
	icon_state = "carp"
	icon_living = "carp"
	icon_dead = "carp_dead"
	icon_gib = "carp_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "hits"
	emote_taunt = list("gnashes")
	taunt_chance = 30
	speed = 0
	maxHealth = 25
	health = 25
	harm_intent_damage = 8
	obj_damage = 50
	melee_damage = 15
	attacktext = "bites"
	attack_sound = 'sound/weapons/bite.ogg'
	speak_emote = list("gnashes")

/mob/living/simple_animal/hostile/carp/holocarp
	icon_state = "holocarp"
	icon_living = "holocarp"
	del_on_death = TRUE

/mob/living/simple_animal/hostile/carp/megacarp
	icon = 'icons/mob/broadMobs.dmi'
	name = "Mega Space Carp"
	desc = "一只凶猛的,长着獠牙的,形似鲨鱼的生物.这只看起来格外恼火."
	icon_state = "megacarp"
	icon_living = "megacarp"
	icon_dead = "megacarp_dead"
	icon_gib = "megacarp_gib"
	maxHealth = 20
	health = 20
	pixel_x = -16
	mob_size = MOB_SIZE_BIG
	obj_damage = 80
	melee_damage = 20
	var/regen_cooldown = 0

/mob/living/simple_animal/hostile/carp/megacarp/Initialize(mapload)
	. = ..()
	name = "[pick(SSstrings.get_list_from_file("names/megacarp_first"))] [pick(SSstrings.get_list_from_file("names/megacarp_last"))]"
	melee_damage += rand(10, 20)
	maxHealth += rand(30, 60)
	move_to_delay = rand(3, 7)

/mob/living/simple_animal/hostile/carp/megacarp/Life(seconds_per_tick, times_fired)
	. = ..()
	if(regen_cooldown < world.time)
		heal_overall_damage(4)
		regen_cooldown = world.time + REGENERATION_DELAY

/mob/living/simple_animal/hostile/carp/cayenne
	name = "Cayenne"
	desc = "一次失败的辛迪加武器化太空鲤鱼技术实验,如今它成了一个可爱的吉祥物."
	gender = FEMALE
	speak_emote = list("squeaks")
	AIStatus = AI_OFF

/mob/living/simple_animal/hostile/carp/swine
	name = "swine carp"
	desc = "NT研发部门进行的一项基因实验."
	icon =  'icons/mob/animal.dmi'
	icon_state = "swinecarp"
	icon_living = "swinecarp"
	icon_dead = "swinecarp_dead"
	icon_gib = "swinecarp_gib"
	maxHealth = 100
	health = 100
	attack_sound = 'sound/items/khryu.ogg'
	speak_emote = list("oinks")

/mob/living/simple_animal/hostile/carp/swine/franko
	name = "Franko"
	desc = "一项基因实验,结果产生了一个贪吃的怪物,但深受陆战队员们的喜爱."
	gender = MALE
	AIStatus = AI_OFF

#undef REGENERATION_DELAY
