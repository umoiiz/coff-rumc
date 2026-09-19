/mob/living/simple_animal/hostile/bear
	name = "space bear"
	desc = "你不需要跑得比太空熊快,你只需要跑得比你的船员快."
	icon_state = "bear"
	icon_living = "bear"
	icon_dead = "bear_dead"
	icon_gib = "bear_gib"
	speak = list("RAWR!","Rawr!","GRR!","Growl!")
	speak_emote = list("growls", "roars")
	emote_hear = list("rawrs.","grumbles.","grawls.")
	emote_taunt = list("stares ferociously", "stomps")
	speak_chance = 1
	taunt_chance = 25
	turns_per_move = 5
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "hits"
	maxHealth = 60
	health = 60

	obj_damage = 60
	melee_damage = 25
	attacktext = "claws"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	friendly = "bear hugs"


/mob/living/simple_animal/hostile/bear/Hudson
	name = "Hudson"
	gender = MALE
	desc = "令人恐惧的不法之徒,这家伙是个坏消息熊."


/mob/living/simple_animal/hostile/bear/snow
	name = "space polar bear"
	icon_state = "snowbear"
	icon_living = "snowbear"
	icon_dead = "snowbear_dead"
	desc = "这是一只北极熊,在太空中,但实际上并不在太空中."


/mob/living/simple_animal/hostile/bear/russian
	name = "combat bear"
	desc = "一只凶猛的棕熊,身披装甲板,肩甲上有一颗带黄色描边的红星."
	icon_state = "combatbear"
	icon_living = "combatbear"
	icon_dead = "combatbear_dead"
	melee_damage = 35
	armour_penetration = 20
	health = 120
	maxHealth = 120
