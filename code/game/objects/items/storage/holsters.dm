/obj/item/storage/holster
	name = "枪套"
	desc = "用来装东西, 有时会嗖嗖作响."
	icon = 'icons/obj/items/storage/holster.dmi'
	icon_state = "backpack"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/holster
	equip_slot_flags = ITEM_SLOT_BACK
	///the sound produced when the special item is drawn
	var/draw_sound = 'sound/weapons/guns/misc/rifle_draw.ogg'
	///the sound produced when the special item is sheathed
	var/sheathe_sound = 'sound/weapons/guns/misc/rifle_draw.ogg'
	///the snowflake item(s) that will update the sprite.
	var/list/holsterable_allowed = list()
	///records the specific special item currently in the holster
	var/obj/holstered_item = null
	///Image that get's underlayed under the sprite of the holster
	var/image/holstered_item_underlay

/obj/item/storage/holster/Initialize(mapload, ...)
	. = ..()
	storage_datum.draw_sound = src.draw_sound
	storage_datum.sheathe_sound = src.sheathe_sound
	storage_datum.holsterable_allowed = src.holsterable_allowed
	storage_datum.holstered_item = src.holstered_item
	storage_datum.holstered_item_underlay = src.holstered_item_underlay

/obj/item/storage/holster/equipped(mob/user, slot)
	if (slot == SLOT_BACK || slot == SLOT_BELT || slot == SLOT_S_STORE || slot == SLOT_L_STORE || slot == SLOT_R_STORE )	//add more if needed
		mouse_opacity = MOUSE_OPACITY_OPAQUE //so it's easier to click when properly equipped.
	return ..()

/obj/item/storage/holster/dropped(mob/user)
	mouse_opacity = initial(mouse_opacity)
	return ..()

/obj/item/storage/holster/Destroy()
	if(holstered_item_underlay)
		QDEL_NULL(holstered_item_underlay)
	if(holstered_item)
		QDEL_NULL(holstered_item)
	return ..()

/obj/item/storage/holster/attack_hand(mob/living/user) //Prioritizes our snowflake item on unarmed click
	if(holstered_item && ishuman(user) && loc == user)
		holstered_item.attack_hand(user)
	else
		return ..()

/obj/item/storage/holster/update_icon_state()
	. = ..()
	if(holstered_item)
		icon_state = initial(icon_state) + "_full"
	else
		icon_state = initial(icon_state)
	worn_icon_state = icon_state

/obj/item/storage/holster/update_icon()
	. = ..()
	if(item_flags & HAS_UNDERLAY)
		update_underlays()
	var/mob/user = loc
	if(!istype(user))
		return
	user.update_inv_back()
	user.update_inv_belt()
	user.update_inv_s_store()

///Adds or removes underlay sprites, checks holstered_item to see which underlay to add
/obj/item/storage/holster/proc/update_underlays()
	if(holstered_item && !holstered_item_underlay)
		if(holstered_item.greyscale_config && holstered_item.greyscale_colors)
			holstered_item_underlay = image(SSgreyscale.GetColoredIconByType(holstered_item.greyscale_config, holstered_item.greyscale_colors), "belt")
		else
			holstered_item_underlay = image(icon, src, holstered_item.icon_state)
		underlays += holstered_item_underlay
	else if(!holstered_item) //Only delete the underlay once our actual holstered item is gone
		underlays -= holstered_item_underlay
		QDEL_NULL(holstered_item_underlay)

/obj/item/storage/holster/do_quick_equip(mob/user) //Will only draw the specific holstered item, not ammo etc.
	if(!holstered_item)
		return FALSE
	var/obj/item/W = holstered_item
	if(!storage_datum.remove_from_storage(W, null, user))
		return FALSE
	return W

/obj/item/storage/holster/vendor_equip(mob/user)
	. = ..()
	return user.equip_to_appropriate_slot(src)

//backpack type holster items
/obj/item/storage/holster/backholster
	name = "背包枪套"
	desc = "你把它背在背上并往里面放东西. 通常还能放一件特殊物品."
	icon = 'icons/obj/items/storage/backholster.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/backpacks_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/backpacks_right.dmi',
	)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		)
	storage_type = /datum/storage/holster/backholster

//only applies on storage of all items, not withdrawal
/obj/item/storage/holster/backholster/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(storage_datum.use_sound)
		playsound(loc, storage_datum.use_sound, 15, 1, 6)

/obj/item/storage/holster/backholster/equipped(mob/user, slot)
	if(slot == SLOT_BACK)
		mouse_opacity = MOUSE_OPACITY_OPAQUE //so it's easier to click when properly equipped.
		if(storage_datum.use_sound)
			playsound(loc, storage_datum.use_sound, 15, 1, 6)
	return ..()

///RR bag
/obj/item/storage/holster/backholster/rpg
	name = "\improper TGMC火箭筒背包"
	desc = "这个背包除了能装无后坐力发射器外, 还能装4发67毫米炮弹."
	icon_state = "marine_rocket"
	w_class = WEIGHT_CLASS_HUGE
	storage_type = /datum/storage/holster/backholster/rpg
	holsterable_allowed = list(
		/obj/item/weapon/gun/launcher/rocket/recoillessrifle,
		/obj/item/weapon/gun/launcher/rocket/recoillessrifle/low_impact,
	)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		)

/obj/item/storage/holster/backholster/rpg/full/PopulateContents()
	new /obj/item/ammo_magazine/rocket/recoilless/light(src)
	new /obj/item/ammo_magazine/rocket/recoilless/light(src)
	new /obj/item/ammo_magazine/rocket/recoilless(src)
	new /obj/item/ammo_magazine/rocket/recoilless(src)
	new /obj/item/weapon/gun/launcher/rocket/recoillessrifle(src)

/obj/item/storage/holster/backholster/rpg/low_impact/PopulateContents()
	new /obj/item/ammo_magazine/rocket/recoilless/low_impact(src)
	new /obj/item/ammo_magazine/rocket/recoilless/low_impact(src)
	new /obj/item/ammo_magazine/rocket/recoilless/low_impact(src)
	new /obj/item/ammo_magazine/rocket/recoilless/low_impact(src)
	new /obj/item/weapon/gun/launcher/rocket/recoillessrifle/low_impact(src)

/obj/item/storage/holster/backholster/rpg/heam/PopulateContents()
	new /obj/item/ammo_magazine/rocket/recoilless/heam(src)
	new /obj/item/ammo_magazine/rocket/recoilless/heam(src)
	new /obj/item/ammo_magazine/rocket/recoilless/heam(src)
	new /obj/item/ammo_magazine/rocket/recoilless/heam(src)
	new /obj/item/weapon/gun/launcher/rocket/recoillessrifle/heam(src)

/obj/item/storage/holster/backholster/rpg/som
	name = "\improper SOM火箭筒背包"
	desc = "这个背包除了能装RPG发射器外, 还能装4发RPG."
	icon_state = "som_rocket"
	holsterable_allowed = list(
		/obj/item/weapon/gun/launcher/rocket/som,
		/obj/item/weapon/gun/launcher/rocket/som/rad,
	)
	storage_type = /datum/storage/holster/backholster/rpg/som

/obj/item/storage/holster/backholster/rpg/som/war_crimes/PopulateContents()
	new /obj/item/ammo_magazine/rocket/som/incendiary(src)
	new /obj/item/ammo_magazine/rocket/som/incendiary(src)
	new /obj/item/ammo_magazine/rocket/som/rad(src)
	new /obj/item/ammo_magazine/rocket/som/rad(src)
	new /obj/item/weapon/gun/launcher/rocket/som/rad(src)

/obj/item/storage/holster/backholster/rpg/som/ert/PopulateContents()
	new /obj/item/ammo_magazine/rocket/som/thermobaric(src)
	new /obj/item/ammo_magazine/rocket/som/thermobaric(src)
	new /obj/item/ammo_magazine/rocket/som/heat(src)
	new /obj/item/ammo_magazine/rocket/som/rad(src)
	new /obj/item/weapon/gun/launcher/rocket/som/rad(src)

/obj/item/storage/holster/backholster/rpg/som/heat/PopulateContents()
	new /obj/item/ammo_magazine/rocket/som/heat(src)
	new /obj/item/ammo_magazine/rocket/som/heat(src)
	new /obj/item/ammo_magazine/rocket/som/heat(src)
	new /obj/item/ammo_magazine/rocket/som/heat(src)
	new /obj/item/weapon/gun/launcher/rocket/som/heat(src)

/obj/item/storage/holster/backholster/mortar
	name = "\improper TGMC迫击炮背包"
	desc = "这个背包除了能装迫击炮本身外, 还能装11发80毫米迫击炮弹."
	icon_state = "marinepackt"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/holster/backholster/mortar
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		)

/obj/item/storage/holster/backholster/mortar/full/PopulateContents()
	new /obj/item/mortar_kit(src)

/obj/item/storage/holster/backholster/flamer
	name = "\improper TGMC火焰喷射器背包"
	desc = "这个背包可以携带配套的火焰喷射器, 并具有适中的通用存储容量. 会自动为其配套的火焰喷射器补充燃料."
	icon_state = "pyro_bag"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/holster/backholster/flamer
	holsterable_allowed = list(/obj/item/weapon/gun/flamer/big_flamer/marinestandard/engineer,)
	///The internal fuel tank
	var/obj/item/ammo_magazine/flamer_tank/internal/tank

	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
	)

/obj/item/storage/holster/backholster/flamer/Initialize(mapload)
	. = ..()
	tank = new
	update_icon()

/obj/item/storage/holster/backholster/flamer/MouseDrop_T(obj/item/W, mob/living/user)
	. = ..()
	if(istype(W,/obj/item/ammo_magazine/flamer_tank))
		refuel(W, user)

/obj/item/storage/holster/backholster/flamer/afterattack(obj/O as obj, mob/user as mob, proximity)
	. = ..()
	//uses the tank's proc to refuel
	if(istype(O, /obj/structure/reagent_dispensers/fueltank))
		tank.afterattack(O, user)
	if(istype(O,/obj/item/ammo_magazine/flamer_tank))
		refuel(O, user)

/* Used to refuel the attached FL-86 flamer when it is put into the backpack
 *
 * param1 - The flamer tank, the actual tank we are refilling
 * param2 - The person wearing the backpack
*/
/obj/item/storage/holster/backholster/flamer/proc/refuel(obj/item/ammo_magazine/flamer_tank/flamer_tank, mob/living/user)
	if(!istype(flamer_tank,/obj/item/ammo_magazine/flamer_tank))
		return
	if(get_dist(user, flamer_tank) > 1)
		return
	if(flamer_tank.default_ammo != /datum/ammo/flamethrower) // hardcoded check for right fuel type
		return
	if(flamer_tank.current_rounds >= flamer_tank.max_rounds)
		to_chat(user, span_warning("[flamer_tank]已经满了."))
		return
	if(tank.current_rounds <= 0)
		to_chat(user, span_warning("[tank]是空的!"))
		return
	var/liquid_transfer_amount = min(tank.current_rounds, flamer_tank.max_rounds - flamer_tank.current_rounds)
	tank.current_rounds -= liquid_transfer_amount
	flamer_tank.current_rounds += liquid_transfer_amount
	playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
	to_chat(user, span_notice("[flamer_tank]已重新装填[lowertext(tank.caliber)]."))
	update_icon()

/obj/item/storage/holster/backholster/flamer/examine(mob/user)
	. = ..()
	. += span_notice("剩余[tank.current_rounds]单位燃料!")

/obj/item/storage/holster/backholster/flamer/full/PopulateContents()
	new /obj/item/weapon/gun/flamer/big_flamer/marinestandard/engineer(src)

//one slot holsters

///swords
/obj/item/storage/holster/blade
	///used only for storage path purposes
	name = "\improper 默认枪套"
	desc = "你不应该看到这个."
	draw_sound = 'sound/weapons/melee/knife_out.ogg'
	sheathe_sound = 'sound/weapons/melee/knife_in.ogg'

/obj/item/storage/holster/blade/machete
	name = "\improper H5型M2132砍刀刀鞘"
	desc = "一个用于携带M2132砍刀的大皮革刀鞘. 可以绑在背部, 腰部或护甲上."
	icon_state = "machete_holster"
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_BACK
	holsterable_allowed = list(
		/obj/item/weapon/sword/machete,
	)

/obj/item/storage/holster/blade/machete/Initialize(mapload)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(/obj/item/weapon/sword/machete))

/obj/item/storage/holster/blade/machete/full/PopulateContents()
	new /obj/item/weapon/sword/machete(src)

/obj/item/storage/holster/blade/harvester
	name = "H5型M2132收割者刀鞘"
	desc = "一个用于携带M2132收割者刀刃的大皮革刀鞘. 可以绑在背部, 腰部或护甲上."
	icon_state = "harvester_holster"
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_BACK
	holsterable_allowed = list(
		/obj/item/weapon/sword/harvester,
	)

/obj/item/storage/holster/blade/harvester/Initialize(mapload)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(/obj/item/weapon/sword/harvester))

/obj/item/storage/holster/blade/harvester/full/PopulateContents()
	new /obj/item/weapon/sword/harvester(src)

/obj/item/storage/holster/blade/katana
	name = "\improper 武士刀刀鞘"
	desc = "一个色彩鲜艳的大型武士刀刀鞘, 用于携带日本刀. 可以绑在背部, 腰部或护甲上. 由于刀鞘坚固的木制外壳, 在紧急情况下也可作为还不错的防御武器."
	icon_state = "katana_holster"
	force = 12
	attack_verb = list("bludgeons", "strikes", "cracks")
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_BACK
	holsterable_allowed = list(/obj/item/weapon/sword/katana)

/obj/item/storage/holster/blade/katana/Initialize(mapload)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(/obj/item/weapon/sword/katana))

/obj/item/storage/holster/blade/katana/full/PopulateContents()
	new /obj/item/weapon/sword/katana(src)

/obj/item/storage/holster/blade/officer
	name = "\improper 军官剑鞘"
	desc = "一个用于携带剑的大皮革剑鞘. 看起来是复制品, 而非原品. 可以绑在腰部或护甲上."
	icon_state = "officer_sheath"
	equip_slot_flags = ITEM_SLOT_BELT
	worn_layer = CAPE_LAYER
	holsterable_allowed = list(/obj/item/weapon/sword/officer)
	storage_type = /datum/storage/holster/blade/officer

/obj/item/storage/holster/blade/officer/full/PopulateContents()
	new /obj/item/weapon/sword/officer(src)

/obj/item/storage/holster/blade/officer/valirapier
	name = "\improper HP-C瓦利刺剑剑鞘"
	desc = "一个精致的礼仪剑鞘, 用于装一把更昂贵的刺剑."
	worn_icon_list = list(
		slot_s_store_str = 'icons/mob/suit_slot.dmi',
		slot_belt_str = 'icons/mob/clothing/belt.dmi',
	)
	icon_state = "rapier_holster"
	holsterable_allowed = list(/obj/item/weapon/sword/officer/valirapier)

/obj/item/storage/holster/blade/officer/valirapier/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(/obj/item/weapon/sword/officer/valirapier))

/obj/item/storage/holster/blade/officer/valirapier/full/PopulateContents()
	new /obj/item/weapon/sword/officer/valirapier(src)

/obj/item/storage/holster/blade/officer/sabre
	name = "\improper 军官马刀刀鞘"
	desc = "一个属于高级指挥人员的精致礼仪刀鞘."
	worn_icon_list = list(
		slot_s_store_str = 'icons/mob/suit_slot.dmi',
		slot_belt_str = 'icons/mob/clothing/belt.dmi',
	)
	icon_state = "saber_holster"
	holsterable_allowed = list(/obj/item/weapon/sword/officer/sabre)

/obj/item/storage/holster/blade/officer/sabre/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(/obj/item/weapon/sword/officer/sabre))

/obj/item/storage/holster/blade/officer/sabre/full/PopulateContents()
	new /obj/item/weapon/sword/officer/sabre(src)

// Tactical Tomahawk Holster

/obj/item/storage/holster/blade/tomahawk
	name = "\improper 战术H23战斧刀鞘"
	desc = "一个用于携带H23战斧的大皮革刀鞘. 可以绑在背部, 腰部或护甲上."
	icon_state = "tomahawk_holster"
	worn_icon_state = "tomahawk_holster"
	worn_icon_list = list(
		slot_back_str = 'icons/mob/clothing/back.dmi',
		slot_belt_str = 'icons/mob/clothing/belt.dmi',
		slot_s_store_str = 'icons/mob/suit_slot.dmi'
	)
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_BACK
	holsterable_allowed = list(/obj/item/weapon/sword/tomahawk)

/obj/item/storage/holster/blade/tomahawk/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(/obj/item/weapon/sword/tomahawk))

/obj/item/storage/holster/blade/tomahawk/full/PopulateContents()
	new /obj/item/weapon/sword/tomahawk(src)

/obj/item/storage/holster/blade/tomahawk/classic
	name = "\improper 战术H17战斧刀鞘"
	desc = "一个用于携带H17战斧的大皮革刀鞘. 可以绑在背部, 腰部或护甲上."
	icon_state = "tomahawk_classic_holster"
	worn_icon_state = "tomahawk_classic_holster"

/obj/item/storage/holster/blade/tomahawk/classic/full/PopulateContents()
	new /obj/item/weapon/sword/tomahawk/classic(src)

//guns

/obj/item/storage/holster/m37
	name = "\improper L44霰弹枪枪套"
	desc = "一个大型皮革枪套, 可存放任何霰弹枪. 它带有束带, 可以固定在背部以便于存放."
	icon_state = "m37_holster"
	holsterable_allowed = list(
		/obj/item/weapon/gun/shotgun/combat,
		/obj/item/weapon/gun/shotgun/pump,
	)

/obj/item/storage/holster/m37/Initialize(mapload)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/shotgun/combat,
		/obj/item/weapon/gun/shotgun/pump,
	))

/obj/item/storage/holster/m37/full/PopulateContents()
	new /obj/item/weapon/gun/shotgun/pump(src)

/obj/item/storage/holster/t35
	name = "\improper L44 SH-35枪套"
	desc = "一个大型皮革枪套, 可存放SH-35霰弹枪. 它带有束带, 可以固定在背部以便于存放."
	icon_state = "t35_holster"
	holsterable_allowed = list(/obj/item/weapon/gun/shotgun/pump/t35)

/obj/item/storage/holster/t35/Initialize(mapload)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/shotgun/pump/t35,
	))

/obj/item/storage/holster/t35/full/PopulateContents()
	new /obj/item/weapon/gun/shotgun/pump/t35(src)

/obj/item/storage/holster/m25
	name = "\improper M276型M25枪套挂具"
	desc = "M276是TGMC的标准负重装备. 它由带有各种卡扣的模块化腰带组成. 此版本专为M25冲锋枪设计, 并具有更大的框架以支撑枪械. 由于其非正统的设计, 并不常见, 仅特别配发."
	icon_state = "m25_holster"
	equip_slot_flags = ITEM_SLOT_BELT
	holsterable_allowed = list(
		/obj/item/weapon/gun/smg/m25,
		/obj/item/weapon/gun/smg/m25/holstered,
	)

/obj/item/storage/holster/m25/Initialize(mapload)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(/obj/item/weapon/gun/smg/m25))

/obj/item/storage/holster/m25/full/PopulateContents()
	new /obj/item/weapon/gun/smg/m25(src)

/obj/item/storage/holster/mp19
	name = "\improper M276型MP-19枪套挂具"
	desc = "M276是TGMC的标准负重装备. 它由带有各种卡扣的模块化腰带组成. 此版本专为MP-19冲锋枪设计, 并具有更大的框架以支撑枪械. 由于其非正统的设计, 并不常见, 仅特别配发."
	icon_state = "t19_holster"
	icon = 'icons/obj/clothing/belts.dmi'
	equip_slot_flags = ITEM_SLOT_BELT
	holsterable_allowed = list(
		/obj/item/weapon/gun/smg/mp19,
		/obj/item/weapon/gun/smg/mp19/compact,
		/obj/item/weapon/gun/smg/mp19/vgrip,
	)

	storage_type = /datum/storage/holster/t19

/obj/item/storage/holster/mp19/full/PopulateContents()
	new /obj/item/weapon/gun/smg/mp19(src)

/obj/item/storage/holster/flarepouch
	name = "照明弹袋"
	desc = "一个用于装照明弹和一把照明弹枪的袋子. 可用M94照明弹包重新装填."
	equip_slot_flags = ITEM_SLOT_POCKET
	storage_type = /datum/storage/holster/flarepouch
	icon = 'icons/obj/items/storage/pouches.dmi'
	icon_state = "flare"
	holsterable_allowed = list(/obj/item/weapon/gun/grenade_launcher/single_shot/flare/marine)

/obj/item/storage/holster/flarepouch/attackby_alternate(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/weapon/gun/grenade_launcher/single_shot/flare))
		return ..()
	var/obj/item/weapon/gun/grenade_launcher/single_shot/flare/flare_gun = I
	if(flare_gun.in_chamber)
		return
	for(var/obj/item/flare in contents)
		storage_datum.remove_from_storage(flare, get_turf(user), user)
		user.put_in_any_hand_if_possible(flare)
		flare_gun.reload(flare, user)
		return

/obj/item/storage/holster/flarepouch/full/PopulateContents()
	var/obj/item/weapon/gun/grenade_launcher/single_shot/flare/marine/flare_gun = new /obj/item/weapon/gun/grenade_launcher/single_shot/flare/marine(src)
	for(var/i in 1 to (storage_datum.storage_slots - flare_gun.w_class))
		new /obj/item/explosive/grenade/flare(src)

/obj/item/storage/holster/icc_mg
	name = "\improper ML-41枪套 (10x26毫米)"
	desc = "一个背包枪套, 可存放任何ML-41突击机枪, 还能为该系统的另一部分携带弹药."
	icon_state = "icc_bagmg"
	icon = 'icons/obj/items/storage/backholster.dmi'
	holsterable_allowed = list(
		/obj/item/weapon/gun/rifle/icc_mg,
	)
	storage_type = /datum/storage/holster/icc_mg

/obj/item/storage/holster/icc_mg/full/PopulateContents()
	new /obj/item/weapon/gun/rifle/icc_mg(src)
	new /obj/item/ammo_magazine/icc_mg/packet(src)
	new /obj/item/ammo_magazine/icc_mg/packet(src)
	new /obj/item/ammo_magazine/icc_mg/packet(src)
	new /obj/item/ammo_magazine/icc_mg/packet(src)

////////////////////////////// GUN BELTS /////////////////////////////////////

/obj/item/storage/holster/belt
	name = "手枪腰带"
	desc = "一个腰带枪套组合, 可容纳一把手枪和两个弹匣."
	icon_state = "m4a3_holster"
	equip_slot_flags = ITEM_SLOT_BELT
	item_flags = HAS_UNDERLAY
	storage_type = /datum/storage/holster/belt
	sheathe_sound = 'sound/weapons/guns/misc/pistol_sheathe.ogg'
	draw_sound = 'sound/weapons/guns/misc/pistol_draw.ogg'
	holsterable_allowed = list(
		/obj/item/weapon/gun,
	) //Any pistol you add to a holster should update the sprite. Ammo/Magazines dont update any sprites

//This deliniates between belt/gun/pistol and belt/gun/revolver
/obj/item/storage/holster/belt/pistol
	name = "通用手枪腰带"
	desc = "一条不是左轮手枪腰带的手枪腰带"
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_SUITSTORE

/obj/item/storage/holster/belt/pistol/Initialize(mapload, ...)
	. = ..()
	AddComponent(/datum/component/tac_reload_storage)
	AddComponent(/datum/component/magazine_catcher)
	AddComponent(/datum/component/easy_restock)

/obj/item/storage/holster/belt/pistol/m4a3
	name = "\improper M4A3枪套挂具"
	desc = "M4A3是一种常见的手枪腰带. 它由带有各种卡扣的模块化腰带组成. 此版本带有枪套组合, 可携带手枪. 它还包含可存放9毫米或.45弹匣的侧袋."

/obj/item/storage/holster/belt/pistol/m4a3/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/ammo_magazine/pistol,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol,
		/obj/item/cell/lasgun/lasrifle,
		/obj/item/cell/lasgun/plasma,
	))

/obj/item/storage/holster/belt/pistol/m4a3/full/PopulateContents()
	new /obj/item/weapon/gun/pistol/rt3(src)
	new /obj/item/ammo_magazine/pistol/ap(src)
	new /obj/item/ammo_magazine/pistol/hp(src)
	for(var/i in 1 to 4)
		new /obj/item/ammo_magazine/pistol/extended(src)

/obj/item/storage/holster/belt/pistol/m4a3/officer/PopulateContents()
	new /obj/item/weapon/gun/pistol/rt3(src)
	new /obj/item/ammo_magazine/pistol/hp(src)
	new /obj/item/ammo_magazine/pistol/hp(src)
	for(var/i in 1 to 4)
		new /obj/item/ammo_magazine/pistol/ap(src)

/obj/item/storage/holster/belt/pistol/m4a3/fieldcommander/PopulateContents()
	new /obj/item/weapon/gun/pistol/m1911/custom(src)
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/pistol/m1911(src)

/obj/item/storage/holster/belt/pistol/m4a3/vp70/PopulateContents()
	new /obj/item/weapon/gun/pistol/vp70(src)
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/pistol/vp70(src)

/obj/item/storage/holster/belt/pistol/m4a3/vp70_pmc/PopulateContents()
	new /obj/item/weapon/gun/pistol/vp70/tactical(src)
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/pistol/vp70(src)

/obj/item/storage/holster/belt/pistol/m4a3/vp78/PopulateContents()
	new /obj/item/weapon/gun/pistol/vp78(src)
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/pistol/vp78(src)

/obj/item/storage/holster/belt/pistol/m4a3/som
	name = "\improper S19 枪套挂具"
	desc = "一种腰带,其起源可追溯到旧殖民地安保枪套挂具."
	icon_state = "som_belt_pistol"

/obj/item/storage/holster/belt/pistol/m4a3/som/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/ammo_magazine/pistol,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol,
		/obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta,
		/obj/item/cell/lasgun/lasrifle,
		/obj/item/cell/lasgun/volkite/small,
		/obj/item/cell/lasgun/plasma,
	))

/obj/item/storage/holster/belt/pistol/m4a3/som/serpenta/PopulateContents()
	new /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta(src)
	for(var/i in 1 to 6)
		new /obj/item/cell/lasgun/volkite/small(src)

/obj/item/storage/holster/belt/pistol/m4a3/som/fancy
	name = "\improper S19-B 枪套挂具"
	desc = "一种高品质手枪腰带,款式常见于SOM军官佩戴.它看起来很旧,但保养得很好."
	icon_state = "som_belt_pistol_fancy"

/obj/item/storage/holster/belt/pistol/m4a3/som/fancy/fieldcommander/PopulateContents()
	new /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/serpenta/custom(src)
	for(var/i in 1 to 6)
		new /obj/item/cell/lasgun/volkite/small(src)

/obj/item/storage/holster/belt/pistol/standard
	name = "\improper M276 型 M4A3 枪套挂具"
	desc = "M276是TGMC的标准负重装备.它由一条带有各种卡扣的模块化腰带组成.此版本配有枪套组件,可舒适安全地携带M4A3.它还包含可存放9毫米或.45弹匣的侧袋."

/obj/item/storage/holster/belt/pistol/standard/Initialize(mapload, ...)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/pistol,
		/obj/item/ammo_magazine/pistol,
	))

/obj/item/storage/holster/belt/pistol/t457
	name = "\improper T457 型手枪枪套挂具"
	desc = "T457是TGMC的标准负重装备.它由一条带有各种卡扣的模块化腰带组成."
	icon_state = "tp14_holster"

/obj/item/storage/holster/belt/revolver
	name = "通用左轮手枪腰带"
	desc = "一条不是手枪腰带的左轮手枪腰带"
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_SUITSTORE

/obj/item/storage/holster/belt/revolver/Initialize(mapload, ...)
	. = ..()
	AddComponent(/datum/component/tac_reload_storage)
	AddComponent(/datum/component/magazine_catcher)
	AddComponent(/datum/component/easy_restock)

/obj/item/storage/holster/belt/revolver/t457
	name = "\improper T457 型左轮手枪枪套挂具"
	desc = "T457是TGMC的标准负重装备.它由一条带有各种卡扣的模块化腰带组成."
	icon_state = "tp44_holster"

/obj/item/storage/holster/belt/revolver/t457/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_type_limits = list(
		/obj/item/weapon/gun/revolver,
	)
	storage_datum.set_holdable(
		can_hold_list = list(
			/obj/item/weapon/gun/revolver,
			/obj/item/ammo_magazine/revolver,
		),
		cant_hold_list = list(
			/obj/item/weapon/gun/revolver/coltrifle,
		)
	)

/obj/item/storage/holster/belt/revolver/t500
	name = "\improper BM500 型 BF 左轮手枪枪套挂具"
	desc = "BM500是专为BMSS左轮手枪设计的特殊模块化腰带."
	icon_state = "t500_holster"
	storage_type = /datum/storage/holster/belt/t500

/obj/item/storage/holster/belt/revolver/m44
	name = "\improper M276 型 M44 枪套挂具"
	desc = "M276是TGMC的标准负重装备.它由一条带有各种卡扣的模块化腰带组成.此版本用于M44马格南左轮手枪,并带有三个快速装弹器袋."
	icon_state = "m44_holster"
	storage_type = /datum/storage/holster/belt/m44

/obj/item/storage/holster/belt/revolver/m44/full/PopulateContents()
	new /obj/item/weapon/gun/revolver/single_action/m44(src)
	new /obj/item/ammo_magazine/revolver/heavy(src)
	new /obj/item/ammo_magazine/revolver/marksman(src)
	for(var/i in 1 to 4)
		new /obj/item/ammo_magazine/revolver(src)

/obj/item/storage/holster/belt/revolver/mateba
	name = "\improper M276 型 Mateba 枪套挂具"
	desc = "M276是TGMC的标准负重装备.它由一条带有各种卡扣的模块化腰带组成.此版本用于强大的Mateba马格南左轮手枪,并带有三个快速装弹器袋."
	icon_state = "mateba_holster"
	storage_type = /datum/storage/holster/belt/mateba

/obj/item/storage/holster/belt/revolver/mateba/full/PopulateContents()
	new /obj/item/weapon/gun/revolver/mateba(src)
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/revolver/mateba(src)

/obj/item/storage/holster/belt/revolver/mateba/officer
	icon_state = "c_mateba_holster"

/obj/item/storage/holster/belt/revolver/mateba/officer/full/PopulateContents()
	new /obj/item/weapon/gun/revolver/mateba/custom(src)
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/revolver/mateba(src)

/obj/item/storage/holster/belt/revolver/mateba/notmarine
	icon_state = "a_mateba_holster"

/obj/item/storage/holster/belt/revolver/mateba/notmarine/PopulateContents()
	new /obj/item/weapon/gun/revolver/mateba(src)
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/revolver/mateba(src)

/obj/item/storage/holster/belt/pistol/korovin
	name = "\improper 41式手枪枪套挂具"
	desc = "UPP标准弹匣挂具的改进版,用于携带一把Korovin PK-9手枪.它还包含可存放.22弹匣的侧袋,可装空尖弹或镇静剂."
	icon_state = "korovin_holster"
	storage_type = /datum/storage/holster/belt/korovin

/obj/item/storage/holster/belt/pistol/korovin/standard/PopulateContents()
	new /obj/item/weapon/gun/pistol/c99(src)
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/pistol/c99(src)

/obj/item/storage/holster/belt/pistol/korovin/tranq/PopulateContents()
	new /obj/item/weapon/gun/pistol/c99/tranq(src)
	for(var/i in 1 to 3)
		new /obj/item/ammo_magazine/pistol/c99t(src)
	for(var/i in 1 to 3)
		new /obj/item/ammo_magazine/pistol/c99(src)

/obj/item/storage/holster/belt/ts34
	name = "\improper M276 型 SH-34 霰弹枪枪套挂具"
	desc = "一种专门设计的腰带枪套组件,可容纳一把SH-34霰弹枪和一个弹药盒或两把弹药."
	icon_state = "ts34_holster"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/holster/belt/ts34
	holsterable_allowed = list(/obj/item/weapon/gun/shotgun/double/marine)

/obj/item/storage/holster/belt/ts34/full/PopulateContents()
	new /obj/item/weapon/gun/shotgun/double/marine(src)
	new /obj/item/ammo_magazine/shotgun/buckshot(src)

/obj/item/storage/holster/belt/pistol/smart_pistol
	name = "\improper SP-13 枪套挂具"
	desc = "一种枪套腰带,可容纳SP-13智能手枪及其弹匣."

/obj/item/storage/holster/belt/pistol/smart_pistol/Initialize(mapload)
	. = ..()
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/weapon/gun/pistol/smart_pistol,
		/obj/item/ammo_magazine/pistol/p14/smart_pistol,
	))

/obj/item/storage/holster/belt/pistol/smart_pistol/full/PopulateContents()
	new /obj/item/weapon/gun/pistol/smart_pistol(src)
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/pistol/p14/smart_pistol(src)

///RL SADAR bag
/obj/item/storage/holster/backholster/rlsadar
	name = "TGMC RL-152 背包"
	desc = "这个背包除了可携带一具SADAR发射器外,还可容纳4枚40毫米弹药."
	worn_icon_list = list(
		slot_back_str = 'icons/mob/clothing/back.dmi'
	)
	icon_state = "marine_sadar"
	worn_icon_state = "marine_sadar"
	w_class = WEIGHT_CLASS_HUGE
	storage_type = /datum/storage/holster/backholster/sadar
	holsterable_allowed = list(/obj/item/weapon/gun/launcher/rocket/sadar)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Bravada Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Charlit Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Alpharii Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Deltad Combat Robot" = 'icons/mob/species/robot/backpack.dmi') //robots have their own snowflake back sprites

///RL Quad bag
/obj/item/storage/holster/backholster/rlquad
	name = "TGMC RL-57 背包"
	desc = "这个背包除了可携带一具温压发射器外,还可容纳2组火箭弹."
	worn_icon_list = list(
		slot_back_str = 'icons/mob/clothing/back.dmi'
	)
	icon_state = "marine_quad"
	worn_icon_state = "marine_quad"
	w_class = WEIGHT_CLASS_HUGE
	storage_type = /datum/storage/holster/backholster/rlquad
	holsterable_allowed = list(/obj/item/weapon/gun/launcher/rocket/m57a4/t57)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Bravada Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Charlit Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Alpharii Combat Robot" = 'icons/mob/species/robot/backpack.dmi',
		"Deltad Combat Robot" = 'icons/mob/species/robot/backpack.dmi') //robots have their own snowflake back sprites

/obj/item/storage/holster/backholster/rlquad/full/PopulateContents()
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/ammo_magazine/rocket/m57a4(src)
	new /obj/item/weapon/gun/launcher/rocket/m57a4/t57(src)

/obj/item/storage/holster/backholster/rlsadar/full/PopulateContents()
	new /obj/item/ammo_magazine/rocket/sadar(src)
	new /obj/item/ammo_magazine/rocket/sadar(src)
	new /obj/item/ammo_magazine/rocket/sadar/ap(src)
	new /obj/item/ammo_magazine/rocket/sadar/ap(src)
	new /obj/item/weapon/gun/launcher/rocket/sadar(src)

/obj/item/storage/holster/belt/pistol/laser/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/cell/lasgun/lasrifle(src)
	new /obj/item/weapon/gun/energy/lasgun/lasrifle/standard_marine_pistol/tactical(src)
