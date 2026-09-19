/obj/structure/closet/crate
	name = "板条箱"
	desc = "一个长方形的钢制板条箱。"
	icon = 'icons/obj/structures/crates.dmi'
	icon_state = "closed_basic"
	icon_opened = "open_basic"
	icon_closed = "closed_basic"
	overlay_welded = "welded_basic"
	anchored = FALSE
	mob_storage_capacity = 0
	storage_capacity = 100
	closet_flags = CLOSET_ALLOW_OBJS|CLOSET_ALLOW_DENSE_OBJ
	allow_pass_flags = PASS_LOW_STRUCTURE|PASSABLE|PASS_WALKOVER
	open_sound = 'sound/machines/click.ogg'
	close_sound = 'sound/machines/click.ogg'

/obj/structure/closet/crate/Initialize(mapload, ...)
	. = ..()
	var/static/list/connections = list(
		COMSIG_OBJ_TRY_ALLOW_THROUGH = PROC_REF(can_climb_over),
		COMSIG_FIND_FOOTSTEP_SOUND = TYPE_PROC_REF(/atom/movable, footstep_override),
		COMSIG_TURF_CHECK_COVERED = TYPE_PROC_REF(/atom/movable, turf_cover_check),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/closet/crate/can_close()
	. = ..()
	if(!.)
		return
	for(var/mob/living/L in get_turf(src)) //Can't close if someone is standing inside it. This is to prevent "crate traps" (let someone step in, close, open for 30 damage)
		return FALSE
	return TRUE

/obj/structure/closet/crate/open(mob/living/user)
	. = ..()
	if(!.)
		return

	if(climbable)
		INVOKE_ASYNC(src, PROC_REF(structure_shaken))
		climbable = FALSE //Open crate is not a surface that works when climbing around

/obj/structure/closet/crate/close()
	. = ..()
	if(!.)
		return
	climbable = TRUE

/obj/structure/closet/crate/alpha
	name = "阿尔法小队板条箱"
	desc = "一个印有阿尔法小队标志的板条箱。"
	icon_state = "closed_alpha"
	icon_opened = "open_alpha"
	icon_closed = "closed_alpha"

/obj/structure/closet/crate/ammo
	name = "弹药箱"
	desc = "一个弹药箱"
	icon_state = "closed_ammo"
	icon_opened = "open_ammo"
	icon_closed = "closed_ammo"

/obj/structure/closet/crate/bravo
	name = "布拉沃小队板条箱"
	desc = "一个印有布拉沃小队标志的板条箱。"
	icon_state = "closed_bravo"
	icon_opened = "open_bravo"
	icon_closed = "closed_bravo"

/obj/structure/closet/crate/charlie
	name = "查理小队板条箱"
	desc = "一个印有查理小队标志的板条箱。"
	icon_state = "closed_charlie"
	icon_opened = "open_charlie"
	icon_closed = "closed_charlie"

/obj/structure/closet/crate/construction
	name = "建筑板条箱"
	desc = "一个建筑板条箱"
	icon_state = "closed_construction"
	icon_opened = "open_construction"
	icon_closed = "closed_construction"

/obj/structure/closet/crate/delta
	name = "德尔塔小队板条箱"
	desc = "一个印有德尔塔小队标志的板条箱。"
	icon_state = "closed_delta"
	icon_opened = "open_delta"
	icon_closed = "closed_delta"

/obj/structure/closet/crate/explosives
	name = "炸药箱"
	desc = "一个炸药箱"
	icon_state = "closed_explosives"
	icon_opened = "open_explosives"
	icon_closed = "closed_explosives"

/obj/structure/closet/crate/explosives/whiskeyoutpost/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/explosive/grenade/stick(src)
	new /obj/item/explosive/grenade/upp(src)
	new /obj/item/explosive/grenade/upp(src)
	new /obj/item/explosive/grenade/upp(src)
	new /obj/item/explosive/grenade/phosphorus/upp(src)
	new /obj/item/explosive/grenade/phosphorus/upp(src)
	new /obj/item/explosive/grenade/phosphorus/upp(src)
	new /obj/item/explosive/grenade/phosphorus/upp(src)

/obj/structure/closet/crate/explosives/whiskeyoutposttwo/PopulateContents()
	new /obj/structure/closet/crate/explosives(src)
	new /obj/item/storage/box/visual/grenade/razorburn(src)
	new /obj/item/storage/box/visual/grenade/razorburn(src)
	new /obj/item/storage/box/visual/grenade/m15(src)
	new /obj/item/storage/box/visual/grenade/phosphorus(src)
	new /obj/item/explosive/grenade/incendiary/molotov(src)
	new /obj/item/explosive/grenade/incendiary/molotov(src)

/obj/structure/closet/crate/freezer
	name = "冷冻箱"
	desc = "一个冷冻箱。"
	icon_state = "closed_freezer"
	icon_opened = "open_freezer"
	icon_closed = "closed_freezer"
	var/target_temp = T0C - 40
	var/cooling_power = 40

/obj/structure/closet/crate/hydroponics
	name = "水培箱"
	desc = "你需要的所有东西,用来消灭那些讨厌的杂草和害虫。"
	icon_state = "closed_hydro"
	icon_opened = "open_hydro"
	icon_closed = "closed_hydro"

/obj/structure/closet/crate/hydroponics/prespawned/PopulateContents()
	new /obj/item/reagent_containers/spray/plantbgone(src)
	new /obj/item/reagent_containers/spray/plantbgone(src)
	new /obj/item/tool/minihoe(src)

/obj/structure/closet/crate/internals
	name = "内部装备箱"
	desc = "一个内部装备箱。"
	icon_state = "closed_oxygen"
	icon_opened = "open_oxygen"
	icon_closed = "closed_oxygen"

/obj/structure/closet/crate/medical
	name = "医疗箱"
	desc = "一个医疗箱。"
	icon_state = "closed_medical"
	icon_opened = "open_medical"
	icon_closed = "closed_medical"

/obj/structure/closet/crate/mounted
	name = "固定武器箱"
	desc = "一个结实的板条箱,装有固定式武器。"
	icon_state = "closed_mounted_weapon"
	icon_opened = "open_mounted_weapon"
	icon_closed = "closed_mounted_weapon"

/obj/structure/closet/crate/smart
	name = "智能武器箱"
	desc = "一个结实的板条箱,装有高科技智能枪武器和弹药。"
	icon_state = "closed_smart"
	overlay_welded = "welded_smart"
	icon_opened = "open_smart"
	icon_closed = "closed_smart"

/obj/structure/closet/crate/operations
	name = "作战物资箱"
	desc = "一个结实的板条箱,装有支援物资。"
	icon_state = "close_operate"
	icon_opened = "open_operate"
	icon_closed = "close_operate"

/obj/structure/closet/crate/plastic
	name = "塑料板条箱"
	desc = "一个长方形的塑料板条箱。"
	icon_state = "closed_plastic"
	icon_opened = "open_plastic"
	icon_closed = "closed_plastic"

/obj/structure/closet/crate/rcd
	name = "RCD箱"
	desc = "一个用于存放RCD的板条箱。"

/obj/structure/closet/crate/rcd/PopulateContents()
	new /obj/item/ammo_rcd(src)
	new /obj/item/ammo_rcd(src)
	new /obj/item/ammo_rcd(src)
	new /obj/item/tool/rcd(src)

/obj/structure/closet/crate/solar
	name = "太阳能包箱"

/obj/structure/closet/crate/freezer/rations //Fpr use in the escape shuttle
	desc = "一箱应急口粮。"
	name = "应急口粮"

/obj/structure/closet/crate/freezer/rations/PopulateContents()
	new /obj/item/storage/box/donkpockets(src)
	new /obj/item/storage/box/donkpockets(src)

/obj/structure/closet/crate/radiation
	name = "放射性装备箱"
	desc = "一个带有辐射标志的箱子."
	icon_state = "closed_radioactive"
	icon_opened = "open_radioactive"
	icon_closed = "closed_radioactive"

/obj/structure/closet/crate/radiation/PopulateContents()
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)

/obj/structure/closet/crate/science
	name = "科学箱"
	desc = "一个科学箱."
	icon_state = "closed_science"
	icon_opened = "open_science"
	icon_closed = "closed_science"

/obj/structure/closet/crate/supply
	name = "补给箱"
	desc = "一个补给箱."
	icon_state = "closed_supply"
	icon_opened = "open_supply"
	icon_closed = "closed_supply"

/obj/structure/closet/crate/trashcart
	name = "垃圾车"
	desc = "一辆沉重的金属垃圾车, 带有轮子."
	icon_state = "closed_trashcart"
	icon_opened = "open_trashcart"
	icon_closed = "closed_trashcart"
	overlay_welded = "welded_trashcart"

/obj/structure/closet/crate/wayland
	name = "韦兰德箱"
	desc = "一个带有韦兰德标志的箱子."
	icon_state = "closed_wayland"
	icon_opened = "open_wayland"
	icon_closed = "closed_wayland"

/obj/structure/closet/crate/weapon
	name = "武器箱"
	desc = "一个武器箱."
	icon_state = "closed_weapons"
	icon_opened = "open_weapons"
	icon_closed = "closed_weapons"

/obj/structure/closet/crate/miningcar
	desc = "一辆矿车. 这辆不在轨道上运行, 但需要拖拽."
	name = "矿车 (非轨道用)"
	icon_state = "closed_mcart"
	density = TRUE
	icon_opened = "open_mcart"
	icon_closed = "closed_mcart"

/obj/structure/closet/crate/miningcar/stripe
	icon_state = "closed_mcart_y"
	icon_opened = "open_mcart_y"
	icon_closed = "closed_mcart_y"

/obj/structure/closet/crate/mass_produced_crate
	name = "量产箱"
	desc = "一个矩形钢箱. 无法焊接为金属."
	icon_state = "closed_basic"
	icon_opened = "open_basic"
	icon_closed = "closed_basic"
	max_integrity = 5 //hopefully makes it so req crate spam can easily be destroyed
	drop_material = null

/obj/structure/closet/crate/mass_produced_crate/alpha
	name = "量产阿尔法小队箱"
	desc = "一个带有阿尔法小队标志的箱子. 无法焊接为金属."
	icon_state = "closed_alpha"
	icon_opened = "open_alpha"
	icon_closed = "closed_alpha"

/obj/structure/closet/crate/mass_produced_crate/ammo
	name = "量产弹药箱"
	desc = "一个弹药箱. 无法焊接为金属."
	icon_state = "closed_ammo"
	icon_opened = "open_ammo"
	icon_closed = "closed_ammo"

/obj/structure/closet/crate/mass_produced_crate/bravo
	name = "量产布拉沃小队箱"
	desc = "一个带有布拉沃小队标志的箱子. 无法焊接为金属."
	icon_state = "closed_bravo"
	icon_opened = "open_bravo"
	icon_closed = "closed_bravo"

/obj/structure/closet/crate/mass_produced_crate/charlie
	name = "量产查理小队箱"
	desc = "一个带有查理小队标志的箱子. 无法焊接为金属."
	icon_state = "closed_charlie"
	icon_opened = "open_charlie"
	icon_closed = "closed_charlie"

/obj/structure/closet/crate/mass_produced_crate/construction
	name = "量产建筑箱"
	desc = "一个建筑箱. 无法焊接为金属."
	icon_state = "closed_construction"
	icon_opened = "open_construction"
	icon_closed = "closed_construction"

/obj/structure/closet/crate/mass_produced_crate/delta
	name = "量产德尔塔小队箱"
	desc = "一个带有德尔塔小队标志的箱子. 无法焊接为金属."
	icon_state = "closed_delta"
	icon_opened = "open_delta"
	icon_closed = "closed_delta"

/obj/structure/closet/crate/mass_produced_crate/explosives
	name = "量产爆炸物箱"
	desc = "一个爆炸物箱. 无法焊接为金属."
	icon_state = "closed_explosives"
	icon_opened = "open_explosives"
	icon_closed = "closed_explosives"

/obj/structure/closet/crate/mass_produced_crate/medical
	name = "量产医疗箱"
	desc = "一个医疗箱. 无法焊接为金属."
	icon_state = "closed_medical"
	icon_opened = "open_medical"
	icon_closed = "closed_medical"

/obj/structure/closet/crate/mass_produced_crate/supply
	name = "量产补给箱"
	desc = "一个补给箱. 无法焊接为金属."
	icon_state = "closed_supply"
	icon_opened = "open_supply"
	icon_closed = "closed_supply"

/obj/structure/closet/crate/mass_produced_crate/weapon
	name = "量产武器箱"
	desc = "一个武器箱. 无法焊接为金属."
	icon_state = "closed_weapons"
	icon_opened = "open_weapons"
	icon_closed = "closed_weapons"
