/mob/living/simple_animal/corgi
	name = "\improper corgi"
	real_name = "corgi"
	desc = "这是一只柯基."
	icon = 'icons/mob/pets.dmi'
	icon_state = "corgi"
	icon_living = "corgi"
	icon_dead = "corgi_dead"
	response_help = "pets"
	response_disarm = "bops"
	response_harm = "kicks"
	speak = list("YAP", "Woof!", "Bark!", "AUUUUUU")
	speak_emote = list("barks", "woofs")
	emote_hear = list("barks!", "woofs!", "yaps.","pants.")
	emote_see = list("shakes its head.", "chases its tail.","shivers.")
	speak_chance = 1
	turns_per_move = 10

/mob/living/simple_animal/corgi/german_shepherd
	name = "\improper german shepherd"
	real_name = "german shepherd"
	desc = "这是一只德国牧羊犬."
	icon = 'icons/mob/pets.dmi'
	icon_state = "german_shep"
	icon_living = "german_shep"
	icon_dead = "german_shep_dead"


/mob/living/simple_animal/corgi/ranger
	name = "Ranger"
	real_name = "Ranger"
	gender = MALE
	desc = "那是兰杰, 你友好而凶猛的警犬. 他见过异形的恐怖, 所以最好对他好一点. <b>兰杰带路</b>!"
	icon_state = "ranger"
	icon_living = "ranger"
	icon_dead = "ranger_dead"
	health = 300
	maxHealth = 300 //Foreshadowing the health of other K9


/mob/living/simple_animal/corgi/bullterrier
	name = "\improper bull terrier"
	real_name = "bull terrier"
	desc = "这是一只牛头梗. 那是塔吉特狗吗?"
	icon = 'icons/mob/pets.dmi'
	icon_state = "bullterrier"
	icon_living = "bullterrier"
	icon_dead = "bullterrier_dead"


/mob/living/simple_animal/corgi/walten
	name = "Walten Clements"
	gender = MALE
	desc = "长官, 这是首席沃尔滕·克莱门茨. 他住在医疗舱, 因为这里也是他的领地. 他的手下穿着手术服以控制细菌, 他们用抚摸和零食来孝敬他. 不要担心他会得慢性阻塞性肺病, 因为他保持着健康的饮食, 充满黑咖啡, 还有大量的有氧运动和伸展运动. 他每天关心的是账目; 他的零食供应必须得到密切关注. 祝你愉快, 陆战队员."
	icon = 'icons/mob/pets.dmi'
	icon_state = "walten"
	icon_living = "walten"
	icon_dead = "walten_dead"
	health = 300


/mob/living/simple_animal/corgi/exoticcorgi
	name = "Exotic Corgi"
	desc = "和它多彩的外表一样可爱!"
	icon_state = "corgigrey"
	icon_living = "corgigrey"
	icon_dead = "corgigrey_dead"


/mob/living/simple_animal/corgi/exoticcorgi/Initialize(mapload)
	. = ..()
	var/newcolor = rgb(rand(0, 255), rand(0, 255), rand(0, 255))
	add_atom_colour(newcolor, FIXED_COLOR_PRIORITY)


/mob/living/simple_animal/corgi/ian
	name = "Ian"
	real_name = "Ian"
	gender = MALE
	desc = "这是HoP心爱的柯基."
	response_help = "pets"
	response_disarm = "bops"
	response_harm = "kicks"


/mob/living/simple_animal/corgi/narsie
	name = "Nars-Ian"
	desc = "咿呀! 咿呀!"
	icon_state = "narsian"
	icon_living = "narsian"
	icon_dead = "narsian_dead"


/mob/living/simple_animal/corgi/narsie/Life(seconds_per_tick, times_fired)
	. = ..()
	for(var/mob/living/simple_animal/P in range(1, src))
		if(P == src || !prob(5))
			continue

		visible_message(span_warning("[src]吞噬了[P]!"), \
		"<span class='cult big bold'>DELICIOUS SOULS</span>")
		playsound(src, 'sound/effects/phasein.ogg', 75, TRUE)
		P.gib()


/mob/living/simple_animal/corgi/puppy
	name = "\improper corgi puppy"
	real_name = "corgi"
	desc = "这是一只柯基幼犬!"
	icon_state = "puppy"
	icon_living = "puppy"
	icon_dead = "puppy_dead"
	density = FALSE
	allow_pass_flags = PASS_MOB
	pass_flags = PASS_MOB
	mob_size = MOB_SIZE_SMALL


/mob/living/simple_animal/corgi/puppy/mrwiggles
	name = "Mr. Wiggles"
	real_name = "Mr. Wiggles"
	desc = "这是扭扭先生!"


/mob/living/simple_animal/corgi/puppy/void
	name = "\improper void puppy"
	real_name = "voidy"
	desc = "一只被注入了深空能量的柯基幼犬. 它正盯着你看..."
	icon_state = "void_puppy"
	icon_living = "void_puppy"
	icon_dead = "void_puppy_dead"


/mob/living/simple_animal/corgi/lisa
	name = "Lisa"
	real_name = "Lisa"
	gender = FEMALE
	desc = "她正在把你撕碎."
	icon_state = "lisa"
	icon_living = "lisa"
	icon_dead = "lisa_dead"
	response_help = "pets"
	response_disarm = "bops"
	response_harm = "kicks"
