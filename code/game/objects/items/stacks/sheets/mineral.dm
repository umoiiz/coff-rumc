/obj/item/stack/sheet/mineral
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 3
	throw_range = 3

/obj/item/stack/sheet/mineral/Initialize(mapload)
	. = ..()
	pixel_x = rand(-2, 2)
	pixel_y = rand(-2, 2)

/obj/item/stack/sheet/mineral/iron
	name = "铁"
	desc = "铁是太空中最基本的建筑材料,一种在室温下呈固态的金属,易于塑形且储量巨大."
	singular_name = "iron sheet"
	icon_state = "sheet-silver"
	sheettype = "iron"
	color = "#333333"
	perunit = 3750

/obj/item/stack/sheet/mineral/iron/get_main_recipes()
	. = ..()
	. += GLOB.iron_recipes

GLOBAL_LIST_INIT(iron_recipes, list ( \
	new/datum/stack_recipe("iron door", /obj/structure/mineral_door/iron, 20, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND), \
	null, \
	))

/obj/item/stack/sheet/mineral/sandstone
	name = "砂岩砖"
	desc = "砂岩是沙子和石头的结合物.一种原始文明的常见建筑材料,仍然可以造出足够好的墙"
	singular_name = "sandstone brick"
	icon_state = "sheet-sandstone"
	throw_speed = 4
	throw_range = 5
	sheettype = "sandstone"

GLOBAL_LIST_INIT(sandstone_recipes, list ( \
	new/datum/stack_recipe("pile of dirt", /obj/prop/hydroponics/soil, 3, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("sandstone door", /obj/structure/mineral_door/sandstone, 10, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND), \
	))

/obj/item/stack/sheet/mineral/sandstone/get_main_recipes()
	. = ..()
	. += GLOB.sandstone_recipes

/obj/item/stack/sheet/mineral/sandstone/runed
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "sheet-runedsandstone"

GLOBAL_LIST_INIT(runedsandstone_recipes, list ( \
	new/datum/stack_recipe("brazier frame", /obj/structure/prop/brazier/frame, req_amount = 5, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION | CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_EXPERT), \
	new/datum/stack_recipe("torch frame", /obj/item/frame/torch_frame, req_amount = 3, time = 2 SECONDS, skill_req = SKILL_CONSTRUCTION_EXPERT), \
	new/datum/stack_recipe("sandstone floor tile", /obj/item/stack/tile/plasteel/sandstone/runed, req_amount = 1, res_amount = 4, time = 2 SECONDS), \
	new/datum/stack_recipe("sandstone wall", /turf/closed/wall/mineral/sandstone/runed, req_amount = 15, time = 10 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION | CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_EXPERT),
))

/obj/item/stack/sheet/mineral/sandstone/runed/get_main_recipes()
	. = ..()
	. += GLOB.runedsandstone_recipes

/obj/item/stack/sheet/mineral/diamond
	name = "钻石"
	desc = "钻石是在极端压力和高温下形成的特定碳排列.尽管可以人工制造,它仍因其外观和特性而受到重视."
	singular_name = "diamond gem"
	icon_state = "sheet-diamond"
	perunit = 3750
	sheettype = "diamond"
	merge_type = /obj/item/stack/sheet/mineral/diamond

GLOBAL_LIST_INIT(diamond_recipes, list ( \
	new/datum/stack_recipe("diamond door", /obj/structure/mineral_door/transparent/diamond, 10, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND), \
	))

/obj/item/stack/sheet/mineral/diamond/get_main_recipes()
	. = ..()
	. += GLOB.diamond_recipes

/obj/item/stack/sheet/mineral/diamond/large_stack
	amount = 50

/obj/item/stack/sheet/mineral/uranium
	name = "铀"
	desc = "铀是锕系元素中的一种放射性金属.作为裂变型发电机的反应堆燃料,以及作为聚变炸弹的起爆剂而受到重视."
	singular_name = "uranium rod"
	icon_state = "sheet-uranium"
	perunit = 2000
	sheettype = "uranium"
	merge_type = /obj/item/stack/sheet/mineral/uranium

GLOBAL_LIST_INIT(uranium_recipes, list ( \
	new/datum/stack_recipe("uranium door", /obj/structure/mineral_door/uranium, 10, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND), \
	))

/obj/item/stack/sheet/mineral/uranium/get_main_recipes()
	. = ..()
	. += GLOB.uranium_recipes

/obj/item/stack/sheet/mineral/uranium/large_stack
	amount = 50

/obj/item/stack/sheet/mineral/phoron
	name = "固态phoron"
	desc = "Phoron是一种极其稀有且具有奇特性质的矿物,常用于尖端研究.仅仅将其转化为稳定的固态形式就已经足够困难了."
	singular_name = "phoron ingot"
	icon_state = "sheet-phoron"
	perunit = 2000
	sheettype = "phoron"
	merge_type = /obj/item/stack/sheet/mineral/phoron

GLOBAL_LIST_INIT(phoron_recipes, list ( \
	new/datum/stack_recipe("phoron door", /obj/structure/mineral_door/transparent/phoron, 10, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND), \
	))

/obj/item/stack/sheet/mineral/phoron/get_main_recipes()
	. = ..()
	. += GLOB.phoron_recipes

/obj/item/stack/sheet/mineral/phoron/small_stack
	amount = 10

/obj/item/stack/sheet/mineral/phoron/medium_stack
	amount = 30

/obj/item/stack/sheet/mineral/plastic
	name = "塑料"
	desc = "塑料是一种合成聚合物,由有机和无机成分制成,是一种可塑且轻便的材料.它可用于制造各种各样的物品."
	singular_name = "plastic sheet"
	icon_state = "sheet-plastic"
	merge_type = /obj/item/stack/sheet/mineral/plastic
	perunit = 2000

GLOBAL_LIST_INIT(plastic_recipes, list ( \
	new/datum/stack_recipe("plastic crate", /obj/structure/closet/crate/plastic, 10, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("plastic ashtray", /obj/item/ashtray/plastic, 2, crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("plastic fork", /obj/item/tool/kitchen/utensil/pfork, 1, crafting_flags = CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("plastic spoon", /obj/item/tool/kitchen/utensil/pspoon, 1, crafting_flags = CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("plastic knife", /obj/item/tool/kitchen/utensil/pknife, 1, crafting_flags = CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("plastic bag", /obj/item/storage/bag/plasticbag, 3, crafting_flags = CRAFT_ON_SOLID_GROUND), \
	))

/obj/item/stack/sheet/mineral/plastic/get_main_recipes()
	. = ..()
	. += GLOB.plastic_recipes

/obj/item/stack/sheet/mineral/plastic/large_stack
	amount = 50

/obj/item/stack/sheet/mineral/gold
	name = "金"
	desc = "金是一种过渡金属.一种相对稀有的金属,以其颜色、光泽、化学和电学性质而闻名,在美容、工程和科学用途上都备受追捧."
	singular_name = "gold ingot"
	icon_state = "sheet-gold"
	perunit = 2000
	sheettype = "gold"
	number_of_extra_variants = 2
	merge_type = /obj/item/stack/sheet/mineral/gold

GLOBAL_LIST_INIT(gold_recipes, list ( \
	new/datum/stack_recipe("golden door", /obj/structure/mineral_door/gold, 10, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND), \
	))

/obj/item/stack/sheet/mineral/gold/get_main_recipes()
	. = ..()
	. += GLOB.gold_recipes

/obj/item/stack/sheet/mineral/gold/large_stack
	amount = 50

/obj/item/stack/sheet/mineral/silver
	name = "银"
	desc = "银是一种过渡金属.它以其同名的银灰色而闻名.它既可用于美容,作为金的廉价替代品,也可用于工程."
	singular_name = "silver ingot"
	icon_state = "sheet-silver"
	perunit = 2000
	sheettype = "silver"
	merge_type = /obj/item/stack/sheet/mineral/silver
	number_of_extra_variants = 2

GLOBAL_LIST_INIT(silver_recipes, list ( \
	new/datum/stack_recipe("silver door", /obj/structure/mineral_door/silver, 10, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND), \
	))

/obj/item/stack/sheet/mineral/silver/get_main_recipes()
	. = ..()
	. += GLOB.silver_recipes

/obj/item/stack/sheet/mineral/silver/large_stack
	amount = 50

//Valuable resource, cargo can sell it.
/obj/item/stack/sheet/mineral/platinum
	name = "铂"
	desc = "铂是一种过渡金属.相对稀有且美观,因其美容价值和作为催化剂的化学性质而被使用.它也用于电极."
	singular_name = "platinum ingot"
	icon_state = "sheet-platinum"
	sheettype = "platinum"
	perunit = 2000
	merge_type = /obj/item/stack/sheet/mineral/platinum
	number_of_extra_variants = 2

/obj/item/stack/sheet/mineral/platinum/large_stack
	amount = 50

//Extremely valuable to Research.
/obj/item/stack/sheet/mineral/mhydrogen
	name = "金属氢"
	desc = "金属氢是处于近固态的普通氢,在巨大压力下被制成锭.制造和稳定这种锭的确切方法仍然是商业机密."
	singular_name = "hydrogen ingot"
	icon_state = "sheet-mythril"
	sheettype = "mhydrogen"
	perunit = 2000


//Fuel for MRSPACMAN generator.
/obj/item/stack/sheet/mineral/tritium
	name = "氚"
	desc = "氚是氢的同位素,H-3,在巨大压力下被制成锭.制造和稳定这种锭的确切方法仍然是商业机密."
	singular_name = "tritium ingot"
	icon_state = "sheet-silver"
	sheettype = "tritium"
	color = "#777777"
	perunit = 2000


/obj/item/stack/sheet/mineral/osmium
	name = "锇"
	desc = "锇是一种过渡金属.人类已知密度最大的天然存在元素,它显然以其极高的硬度和耐用性而闻名,并因此被使用."
	singular_name = "osmium ingot"
	icon_state = "sheet-osmium"
	sheettype = "osmium"
	merge_type = /obj/item/stack/sheet/mineral/osmium
	perunit = 2000

/obj/item/stack/sheet/mineral/osmium/large_stack
	amount = 50

/obj/item/stack/sheet/mineral/copper
	name = "铜"
	desc = "铜是一种用作导热和导电体以及各种金属合金成分的金属"
	singular_name = "osmcopperium ingot"
	icon_state = "sheet-copper"
	sheettype = "copper"
	merge_type = /obj/item/stack/sheet/mineral/copper
	perunit = 2000

/obj/item/stack/sheet/mineral/copper/large_stack
	amount = 50

/obj/item/stack/sheet/mineral/junk
	name = "废料"
	desc = "一堆不同的金属"
	singular_name = "junk slab"
	icon_state = "compressed_junk"
	sheettype = "junk"
	merge_type = /obj/item/stack/sheet/mineral/junk
	perunit = 2000

/obj/item/stack/sheet/mineral/junk/large_stack
	amount = 50
