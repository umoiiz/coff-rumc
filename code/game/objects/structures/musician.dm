/obj/structure/device/broken_piano
	name = "损坏的复古钢琴"
	icon = 'icons/obj/musician.dmi'
	desc = "真可惜.这架钢琴看起来再也弹不了了.永远不能了.连问都别问."
	icon_state = "pianobroken"
	anchored = TRUE
	density = TRUE
	coverage = 20

/obj/structure/device/broken_moog
	name = "损坏的复古合成器"
	icon = 'icons/obj/musician.dmi'
	desc = "这台太空穆格合成器是复古款,但已经报废了.看来有人不喜欢它那火热的旋律."
	icon_state = "minimoogbroken"
	anchored = TRUE
	density = TRUE
	coverage = 15

/obj/structure/device/piano
	name = "太空迷你穆格"
	icon = 'icons/obj/musician.dmi'
	icon_state = "minimoog"
	anchored = TRUE
	density = TRUE
	coverage = 20

/obj/structure/device/piano/full
	icon_state = "piano"

/obj/structure/device/piano/Initialize(mapload)
	. = ..()
	if(prob(50))
		name = "space minimoog"
		desc = "This is a minimoog, like a space piano, but more spacey!"
		icon_state = "minimoog"
	else
		name = "space piano"
		desc = "This is a space piano, like a regular piano, but always in tune! Even if the musician isn't."
		icon_state = "piano"
