/obj/structure/largecrate
	name = "大木箱"
	desc = "一个沉重的木箱."
	icon = 'icons/obj/structures/crates.dmi'
	icon_state = "densecrate"
	density = TRUE
	anchored = FALSE
	resistance_flags = XENO_DAMAGEABLE
	interaction_flags = INTERACT_OBJ_DEFAULT|INTERACT_POWERLOADER_PICKUP_ALLOWED
	allow_pass_flags = PASSABLE|PASS_WALKOVER|PASS_LOW_STRUCTURE
	max_integrity = 40
	soft_armor = list(MELEE = 0, BULLET = 80, LASER = 80, ENERGY = 80, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	hit_sound = 'sound/effects/woodhit.ogg'
	var/dropmetal = TRUE
	var/spawn_type
	var/spawn_amount

/obj/structure/largecrate/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_OBJ_TRY_ALLOW_THROUGH = PROC_REF(can_climb_over),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/largecrate/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_WOOD, -40, 5)

/obj/structure/largecrate/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	spawn_stuff()
	return ..()

/obj/structure/largecrate/examine(mob/user)
	. = ..()
	. += span_notice("你需要一根撬棍才能撬开!")

/obj/structure/largecrate/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	user.visible_message(span_notice("[user]撬开了\the [src]."),
		span_notice("你撬开了\the [src]."),
		span_notice("你听到了木头裂开的声音."))
	new /obj/item/stack/sheet/wood/five(loc)
	deconstruct(TRUE)
	return TRUE

/obj/structure/largecrate/proc/spawn_stuff()
	var/turf/T = get_turf(src)
	if(spawn_type && spawn_amount)
		for(var/i in 1 to spawn_amount)
			new spawn_type(T)
	for(var/obj/O in contents)
		O.forceMove(loc)

/obj/structure/largecrate/mule
	icon_state = "mulecrate"

/obj/structure/largecrate/lisa
	icon_state = "lisacrate"
	spawn_type = /mob/living/simple_animal/corgi/lisa
	spawn_amount = 1

/obj/structure/largecrate/cow
	name = "牛箱"
	icon_state = "lisacrate"
	spawn_type = /mob/living/simple_animal/cow
	spawn_amount = 1

/obj/structure/largecrate/goat
	name = "山羊箱"
	icon_state = "lisacrate"
	spawn_type = /mob/living/simple_animal/hostile/retaliate/goat
	spawn_amount = 1

/obj/structure/largecrate/chick
	name = "鸡箱"
	icon_state = "lisacrate"
	spawn_type = /mob/living/simple_animal/chick
	spawn_amount = 4

///////////CM largecrates ///////////////////////

//Possibly the most generically named procs in history. congrats
/obj/structure/largecrate/random
	name = "补给箱"
	var/num_things = 0
	var/list/stuff = list(
		/obj/item/cell/high,
		/obj/item/storage/belt/utility/full,
		/obj/item/tool/multitool,
		/obj/item/tool/crowbar,
		/obj/item/flashlight,
		/obj/item/reagent_containers/food/snacks/donkpocket,
		/obj/item/explosive/grenade/smokebomb,
		/obj/item/circuitboard/airlock,
		/obj/item/assembly/igniter,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/analyzer,
		/obj/item/clothing/under/marine,
		/obj/item/clothing/shoes/marine
	)

/obj/structure/largecrate/random/Initialize(mapload)
	. = ..()
	if(!num_things) num_things = rand(0,3)

	while(num_things)
		if(!num_things)
			break
		num_things--
		var/obj/item/thing = pick(stuff)
		new thing(src)

/obj/structure/largecrate/random/case
	name = "储物箱"
	desc = "一个黑色储物箱."
	icon_state = "case"

/obj/structure/largecrate/random/case/double
	name = "储物箱堆"
	desc = "一堆黑色储物箱."
	icon_state = "case_double"

/obj/structure/largecrate/random/case/double/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	new /obj/structure/largecrate/random/case(loc)
	new /obj/structure/largecrate/random/case(loc)
	return ..()

/obj/structure/largecrate/random/case/small
	name = "小储物箱"
	desc = "两个黑色小储物箱."
	icon_state = "case_small"

/obj/structure/largecrate/random/case/small/mini
	icon_state = "mini_case"

/obj/structure/largecrate/random/case/small/mini/Initialize(mapload)
	. = ..()
	icon_state = pick("mini_case", "mini_case_b", "mini_case_c")

/obj/structure/largecrate/random/barrel/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(dropmetal)
		new /obj/item/stack/sheet/metal/small_stack(src)
	return ..()

/obj/structure/largecrate/random/barrel/welder_act(mob/living/user, obj/item/tool/weldingtool/welder)
	if(!welder.isOn())
		return FALSE
	if(!do_after(user, 5 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return TRUE
	if(!welder.remove_fuel(1, user))
		return TRUE
	user.visible_message(span_notice("[user]焊接打开了\the [src]."),
		span_notice("你焊接打开了\the [src]."),
		span_notice("你听到了响亮的嘶嘶声和金属倒下的声音."))
	playsound(loc, 'sound/items/welder2.ogg', 25, TRUE)
	deconstruct(TRUE)
	return TRUE

/obj/structure/largecrate/random/barrel/examine(mob/user)
	. = ..()
	. += span_notice("你需要一把喷灯才能焊接打开!")

/obj/structure/largecrate/random/barrel/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_SPARKS, -40, 8, 1)

/obj/structure/largecrate/random/barrel
	name = "蓝色桶"
	desc = "一个蓝色储物桶"
	icon_state = "barrel_blue"
	hit_sound = 'sound/effects/metalhit.ogg'
	dropmetal = FALSE

/obj/structure/largecrate/random/barrel/blue
	name = "蓝色桶"
	desc = "一个蓝色储物桶"
	icon_state = "barrel_blue"

/obj/structure/largecrate/random/barrel/red //lame non explosive version
	name = "红色桶"
	desc = "一个红色储物桶"
	icon_state = "barrel_red"

/obj/structure/largecrate/random/barrel/green
	name = "绿色桶"
	desc = "一个绿色储物桶"
	icon_state = "barrel_green"

/obj/structure/largecrate/random/barrel/yellow
	name = "黄色桶"
	desc = "一个黄色储物桶"
	icon_state = "barrel_yellow"

/obj/structure/largecrate/random/barrel/white
	name = "白色桶"
	desc = "一个白色储物桶"
	icon_state = "barrel_white"

/obj/structure/largecrate/random/secure
	name = "安全补给箱"
	desc = "一个安全箱."
	icon_state = "secure_crate_strapped"
	var/strapped = 1

/obj/structure/largecrate/random/secure/crowbar_act(mob/living/user, obj/item/I)
	if(strapped)
		return FALSE
	return ..()

/obj/structure/largecrate/random/secure/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	to_chat(user, span_notice("你开始割断\the [src]的绑带..."))
	if(!do_after(user, 1.5 SECONDS, NONE, src, BUSY_ICON_GENERIC))
		return TRUE
	playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)
	to_chat(user, span_notice("你割断了绑带."))
	icon_state = "secure_crate"
	strapped = FALSE
	return TRUE

/obj/structure/largecrate/random/secure/examine(mob/user)
	. = ..()
	. += span_notice("你需要锋利的东西来割断绑带.")

/obj/structure/largecrate/guns
	name = "\improper TGMC枪械箱 (x3)"
	var/num_guns = 3
	var/num_mags = 3
	var/list/stuff = list(
		/obj/item/weapon/gun/pistol/rt3 = /obj/item/ammo_magazine/pistol/hp,
		/obj/item/weapon/gun/pistol/rt3 = /obj/item/ammo_magazine/pistol/ap,
		/obj/item/weapon/gun/revolver/single_action/m44 = /obj/item/ammo_magazine/revolver/marksman,
		/obj/item/weapon/gun/revolver/single_action/m44 = /obj/item/ammo_magazine/revolver/heavy,
		/obj/item/weapon/gun/shotgun/pump/t35 = /obj/item/ammo_magazine/shotgun,
		/obj/item/weapon/gun/shotgun/pump/t35 = /obj/item/ammo_magazine/shotgun/incendiary,
		/obj/item/weapon/gun/shotgun/combat = /obj/item/ammo_magazine/shotgun,
		/obj/item/weapon/gun/flamer/big_flamer = /obj/item/ammo_magazine/flamer_tank,
		/obj/item/weapon/gun/pistol/rt3 = /obj/item/ammo_magazine/pistol/incendiary,
		/obj/item/weapon/gun/rifle/ar12 = /obj/item/ammo_magazine/rifle/ar12,
		/obj/item/weapon/gun/rifle/mg42 = /obj/item/ammo_magazine/mg42,
		/obj/item/weapon/gun/grenade_launcher/single_shot = /obj/item/explosive/grenade/phosphorus
	)

/obj/structure/largecrate/guns/Initialize(mapload)
	. = ..()
	var/gun_type
	var/i = 0
	while(++i <= num_guns)
		gun_type = pick(stuff)
		new gun_type(src)
		var/obj/item/ammo_magazine/new_mag = stuff[gun_type]
		var/m = 0
		while(++m <= num_mags)
			new new_mag(src)

/obj/structure/largecrate/guns/russian
	num_guns = 1
	num_mags = 1
	name = "\improper 纳甘-山崎枪械箱"
	stuff = list(
		/obj/item/weapon/gun/revolver/upp = /obj/item/ammo_magazine/revolver/upp,
		/obj/item/weapon/gun/pistol/c99 = /obj/item/ammo_magazine/pistol/c99,
		/obj/item/weapon/gun/rifle/mpi_km = /obj/item/ammo_magazine/rifle/mpi_km/plum,
		/obj/item/weapon/gun/rifle/sniper/svd = /obj/item/ammo_magazine/sniper/svd,
		/obj/item/weapon/gun/smg/ppsh = /obj/item/ammo_magazine/smg/ppsh,
		/obj/item/weapon/gun/rifle/type71 = /obj/item/ammo_magazine/rifle/type71,
		/obj/item/weapon/gun/rifle/sniper/svd = /obj/item/ammo_magazine/sniper/svd
	)

/obj/structure/largecrate/guns/merc
	num_guns = 1
	num_mags = 1
	name = "\improper 黑市枪械箱"
	stuff = list(
		/obj/item/weapon/gun/pistol/holdout = /obj/item/ammo_magazine/pistol/holdout,
		/obj/item/weapon/gun/pistol/highpower = /obj/item/ammo_magazine/pistol/highpower,
		/obj/item/weapon/gun/pistol/m1911 = /obj/item/ammo_magazine/pistol/m1911,
		/obj/item/weapon/gun/pistol/vp70 = /obj/item/ammo_magazine/pistol/vp70,
		/obj/item/weapon/gun/pistol/heavy = /obj/item/ammo_magazine/pistol/heavy,
		/obj/item/weapon/gun/revolver/small = /obj/item/ammo_magazine/revolver/small,
		/obj/item/weapon/gun/revolver/cmb = /obj/item/ammo_magazine/revolver/cmb,
		/obj/item/weapon/gun/shotgun/pump/cmb = /obj/item/ammo_magazine/shotgun/incendiary,
		/obj/item/weapon/gun/shotgun/double = /obj/item/ammo_magazine/shotgun/buckshot,
		/obj/item/weapon/gun/smg/mp7 = /obj/item/ammo_magazine/smg/mp7,
		/obj/item/weapon/gun/smg/skorpion = /obj/item/ammo_magazine/smg/skorpion,
		/obj/item/weapon/gun/smg/uzi = /obj/item/ammo_magazine/smg/uzi,
		/obj/item/weapon/gun/rifle/famas = /obj/item/ammo_magazine/rifle/famas,
		/obj/item/weapon/gun/rifle/m16 = /obj/item/ammo_magazine/rifle/m16
	)
