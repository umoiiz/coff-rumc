/obj/item/stack/tile
	name = "地砖"
	singular_name = "floor tile"
	desc = "这些可以作为相当不错的投掷武器"
	icon_state = "tile"
	w_class = WEIGHT_CLASS_NORMAL
	force = 1
	throwforce = 1
	throw_speed = 5
	throw_range = 9
	max_amount = 60
	///The turf type this tile creates
	var/turf/open/floor/turf_type

/obj/item/stack/tile/Initialize(mapload)
	. = ..()
	pixel_x = rand(1, 14)
	pixel_y = rand(1, 14)

/obj/item/stack/tile/attack_turf(turf/T, mob/living/user)
	if(!turf_type)
		return
	if(!istype(T, /turf/open/floor/plating))
		return
	if(!use(1))
		return
	playsound(T, 'sound/weapons/genhit.ogg', 25, 1)
	T.PlaceOnTop(turf_type)

/obj/item/stack/tile/plasteel
	force = 6
	throwforce = 8
	throw_speed = 3
	throw_range = 6
	atom_flags = CONDUCT
	turf_type = /turf/open/floor

///Creates plating, used for space turfs only
/obj/item/stack/tile/plasteel/proc/build(turf/space_turf)
	if(isspaceturf(space_turf))
		space_turf.ChangeTurf(/turf/open/floor/plating/airless)
	else
		space_turf.ChangeTurf(/turf/open/floor/plating)

/obj/item/stack/tile/plasteel/sandstone/runed
	icon_state = "tile_runedsandstone"
	icon = 'icons/obj/stack_objects.dmi'
	force = 6
	throwforce = 8
	throw_speed = 3
	throw_range = 6
	atom_flags = CONDUCT
	turf_type = /turf/open/floor/sandstone/runed

/obj/item/stack/tile/grass
	name = "草皮"
	singular_name = "grass floor tile"
	desc = "一块像高尔夫球场上常用的草皮."
	icon_state = "tile_grass"
	turf_type = /turf/open/floor/grass

/obj/item/stack/tile/wood
	name = "木地板砖"
	singular_name = "wood floor tile"
	desc = "一块易于安装的木地板砖."
	icon_state = "tile-wood"
	turf_type = /turf/open/floor/wood

/obj/item/stack/tile/carpet
	name = "地毯"
	singular_name = "carpet"
	desc = "一块地毯.它和普通地砖一样大!"
	icon_state = "tile-carpet"
	turf_type = /turf/open/floor/carpet

/obj/item/stack/tile/light
	name = "发光地砖"
	singular_name = "light floor tile"
	desc = "一块由玻璃制成的地砖.它会发光."
	icon_state = "tile_e"
	force = 3
	throwforce = 5
	attack_verb = list("bashes", "batters", "bludgeons", "thrashes", "smashes")
	turf_type = /turf/open/floor/light
	var/on = 1
	var/state = LIGHT_TILE_OK

/obj/item/stack/tile/light/Initialize(mapload, amount)
	. = ..()
	if(prob(5))
		state = LIGHT_TILE_BROKEN
	else if(prob(5))
		state = LIGHT_TILE_BREAKING
	else if(prob(10))
		state = LIGHT_TILE_FLICKERING

/obj/item/stack/tile/light/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	new /obj/item/stack/sheet/metal(user.loc)
	amount--
	new /obj/item/stack/light_w(user.loc)
	if(amount <= 0)
		user.temporarilyRemoveItemFromInventory(src)
		qdel(src)
