/* Glass stack types
* Contains:
*		Glass sheets
*		Reinforced glass sheets
*		Phoron Glass Sheets
*		Reinforced Phoron Glass Sheets (AKA Holy fuck strong windows)
*/

/*
* Glass sheets
*/
GLOBAL_LIST_INIT(glass_recipes, list ( \
	new/datum/stack_recipe("directional window", /obj/structure/window, 1, time = 4 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION | CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_PLASTEEL), \
	new/datum/stack_recipe("fulltile window", /obj/structure/window/full, 4, time = 4 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION | CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_PLASTEEL), \
	new/datum/stack_recipe("windoor", /obj/structure/windoor_assembly, 5, time = 4 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION | CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_PLASTEEL) \
))

/obj/item/stack/sheet/glass
	name = "玻璃"
	desc = "玻璃是一种非晶态固体,由硅酸盐制成,硅酸盐是沙子的主要成分.它因其透明性而备受重视,尽管它不太耐损坏."
	singular_name = "glass sheet"
	icon_state = "sheet-glass"
	worn_icon_state = "sheet-glass"
	var/created_window = /obj/structure/window
	var/reinforced_type = /obj/item/stack/sheet/glass/reinforced
	var/is_reinforced = FALSE

/obj/item/stack/sheet/glass/get_main_recipes()
	. = ..()
	. += GLOB.glass_recipes

GLOBAL_LIST_INIT(glass_radial_images, list(
	"recipes" = image('icons/obj/structures/barricades/upgrades.dmi', icon_state = "plus"),
	"directional window" = image('icons/obj/structures/windows.dmi', "window"),
	"fulltile window" = image('icons/obj/structures/windows.dmi', "window0"),
	"windoor" = image('icons/obj/doors/windoor.dmi', icon_state = "left"),
))

/obj/item/stack/sheet/glass/select_radial(mob/user)
	if(user.get_active_held_item() != src)
		return
	if(!can_interact(user))
		return TRUE

	add_fingerprint(usr, "topic")

	var/choice = show_radial_menu(user, src, GLOB.glass_radial_images, require_near = TRUE)
	switch (choice)
		if("recipes")
			return TRUE
		if("directional window")
			create_object(user, new/datum/stack_recipe("directional window", created_window, 1, time = 4 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION | CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_PLASTEEL), 1)
		if("fulltile window")
			create_object(user, new/datum/stack_recipe("fulltile window", text2path("[created_window]/full"), 4, time = 4 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION | CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_PLASTEEL), 1)
		if("windoor")
			create_object(user, new/datum/stack_recipe("windoor", /obj/structure/windoor_assembly, 5, time = 4 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION | CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_PLASTEEL), 1)

	return FALSE

/obj/item/stack/sheet/glass/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(is_reinforced)
		return

	else if(istype(I, /obj/item/stack/rods))
		var/obj/item/stack/rods/V = I
		if(V.get_amount() < 1 || get_amount() < 1)
			to_chat(user, span_warning("你需要一根金属棒和一块玻璃板来制造强化玻璃."))
			return

		var/obj/item/stack/sheet/glass/RG = new reinforced_type(user.loc)
		RG.add_to_stacks(user)
		use(1)
		V.use(1)
		if(!src && !RG)
			user.put_in_hands(RG)

/obj/item/stack/sheet/glass/glass //this exists because otherwise glass can be merger into any ofthe other glass types.
	merge_type = /obj/item/stack/sheet/glass/glass

/obj/item/stack/sheet/glass/glass/large_stack
	amount = 50

/*
* Reinforced glass sheets
*/
/obj/item/stack/sheet/glass/reinforced
	name = "强化玻璃"
	desc = "强化玻璃由多层普通硅酸盐玻璃板层压在金属棒骨架上制成.这种玻璃更能抵抗直接冲击,即使它可能会开裂."
	singular_name = "reinforced glass sheet"
	icon_state = "sheet-rglass"
	worn_icon_state = "sheet-rglass"
	merge_type = /obj/item/stack/sheet/glass/reinforced
	created_window = /obj/structure/window/reinforced
	is_reinforced = TRUE

/*
* Phoron Glass sheets
*/
/obj/item/stack/sheet/glass/phoronglass
	name = "phoron玻璃"
	desc = "phoron玻璃是一种硅酸盐-phoron合金转化而成的非晶态固体.它和玻璃一样透明,即使明显带有粉色,并且非常耐损坏和耐热."
	singular_name = "phoron glass sheet"
	icon_state = "sheet-phoronglass"
	merge_type = /obj/item/stack/sheet/glass/phoronglass
	created_window = /obj/structure/window/phoronbasic
	reinforced_type = /obj/item/stack/sheet/glass/phoronrglass

/*
* Reinforced phoron glass sheets
*/
/obj/item/stack/sheet/glass/phoronrglass
	name = "强化phoron玻璃"
	desc = "强化phoron玻璃由多层硅酸盐-phoron合金玻璃板层压在金属棒骨架上制成.它对物理冲击和热量都有着极其惊人的抗性."
	singular_name = "reinforced phoron glass sheet"
	icon_state = "sheet-phoronrglass"
	merge_type = /obj/item/stack/sheet/glass/phoronrglass
	created_window = /obj/structure/window/phoronreinforced
	is_reinforced = TRUE
