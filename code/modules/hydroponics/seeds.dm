//Seed packet object/procs.
/obj/item/seeds
	name = "一包种子"
	icon = 'icons/obj/items/seeds.dmi'
	icon_state = "seed"
	atom_flags = NONE
	w_class = WEIGHT_CLASS_TINY

	var/seed_type
	var/datum/seed/seed
	var/modified = FALSE

/obj/item/seeds/Initialize(mapload, update = TRUE)
	. = ..()
	if(update)
		update_seed()

//Grabs the appropriate seed datum from the global list.
/obj/item/seeds/proc/update_seed()
	seed = GLOB.seed_types[seed_type]
	update_appearance()

/obj/item/seeds/update_appearance()
	. = ..()
	icon_state = seed.packet_icon

/obj/item/seeds/update_name(updates)
	. = ..()
	name = "packet of [seed.seed_name] [seed.seed_noun]"

/obj/item/seeds/update_desc(updates)
	. = ..()
	desc = "It has a picture of [seed.display_name] on the front."

/obj/item/seeds/poppyseed
	name = "罂粟种子"
	seed_type = "poppies"

/obj/item/seeds/chiliseed
	name = "辣椒种子"
	seed_type = "chili"

/obj/item/seeds/plastiseed
	name = "塑料种子"
	seed_type = "plastic"

/obj/item/seeds/grapeseed
	name = "葡萄种子"
	seed_type = "grapes"

/obj/item/seeds/greengrapeseed
	name = "绿葡萄种子"
	seed_type = "greengrapes"

/obj/item/seeds/peanutseed
	name = "花生种子"
	seed_type = "peanut"

/obj/item/seeds/cabbageseed
	name = "卷心菜种子"
	seed_type = "cabbage"

/obj/item/seeds/berryseed
	name = "浆果种子"
	seed_type = "berries"

/obj/item/seeds/glowberryseed
	name = "发光浆果种子"
	seed_type = "glowberries"

/obj/item/seeds/bananaseed
	name = "香蕉种子"
	seed_type = "banana"

/obj/item/seeds/eggplantseed
	name = "茄子种子"
	seed_type = "eggplant"

/obj/item/seeds/eggyseed
	name = "茄子种子"
	seed_type = "realeggplant"

/obj/item/seeds/bloodtomatoseed
	name = "血番茄种子"
	seed_type = "bloodtomato"

/obj/item/seeds/tomatoseed
	name = "番茄种子"
	seed_type = "tomato"

/obj/item/seeds/killertomatoseed
	name = "番茄种子"
	seed_type = "killertomato"

/obj/item/seeds/bluetomatoseed
	name = "蓝番茄种子"
	seed_type = "bluetomato"

/obj/item/seeds/bluespacetomatoseed
	name = "蓝空间番茄种子"
	seed_type = "bluespacetomato"

/obj/item/seeds/cornseed
	name = "玉米种子"
	seed_type = "corn"

/obj/item/seeds/potatoseed
	name = "土豆种子"
	seed_type = "potato"

/obj/item/seeds/icepepperseed
	name = "冰辣椒种子"
	seed_type = "icechili"

/obj/item/seeds/soyaseed
	name = "大豆种子"
	seed_type = "soybean"

/obj/item/seeds/wheatseed
	name = "小麦种子"
	seed_type = "wheat"

/obj/item/seeds/riceseed
	name = "水稻种子"
	seed_type = "rice"

/obj/item/seeds/carrotseed
	name = "胡萝卜种子"
	seed_type = "carrot"

/obj/item/seeds/reishimycelium
	name = "灵芝菌种"
	seed_type = "reishi"

/obj/item/seeds/amanitamycelium
	name = "毒蝇伞种子"
	seed_type = "amanita"

/obj/item/seeds/angelmycelium
	name = "天使菌种"
	seed_type = "destroyingangel"

/obj/item/seeds/libertymycelium
	name = "自由帽种子"
	seed_type = "libertycap"

/obj/item/seeds/chantermycelium
	name = "蘑菇种子"
	seed_type = "mushrooms"

/obj/item/seeds/towermycelium
	name = "高塔菇种子"
	seed_type = "towercap"

/obj/item/seeds/glowshroom
	name = "发光菇种子"
	seed_type = "glowshroom"

/obj/item/seeds/plumpmycelium
	name = "丰帽菇种子"
	seed_type = "plumphelmet"

/obj/item/seeds/walkingmushroommycelium
	name = "行走蘑菇种子"
	seed_type = "walkingmushroom"

/obj/item/seeds/nettleseed
	name = "荨麻种子"
	seed_type = "nettle"

/obj/item/seeds/deathnettleseed
	name = "死亡荨麻种子"
	seed_type = "deathnettle"

/obj/item/seeds/weeds
	seed_type = "weeds"

/obj/item/seeds/harebell
	seed_type = "harebells"

/obj/item/seeds/sunflowerseed
	name = "向日葵种子"
	seed_type = "sunflowers"

/obj/item/seeds/brownmold
	name = "褐霉种子"
	seed_type = "mold"

/obj/item/seeds/appleseed
	name = "苹果种子"
	seed_type = "apple"

/obj/item/seeds/poisonedappleseed
	seed_type = "poisonapple"

/obj/item/seeds/goldappleseed
	name = "金苹果种子"
	seed_type = "goldapple"

/obj/item/seeds/ambrosiavulgarisseed
	seed_type = "ambrosia"

/obj/item/seeds/ambrosiadeusseed
	seed_type = "ambrosiadeus"

/obj/item/seeds/whitebeetseed
	name = "白甜菜种子"
	seed_type = "whitebeet"

/obj/item/seeds/sugarcaneseed
	name = "甘蔗种子"
	seed_type = "sugarcane"

/obj/item/seeds/watermelonseed
	name = "西瓜种子"
	seed_type = "watermelon"

/obj/item/seeds/pumpkinseed
	name = "南瓜种子"
	seed_type = "pumpkin"

/obj/item/seeds/limeseed
	name = "青柠种子"
	seed_type = "lime"

/obj/item/seeds/lemonseed
	name = "柠檬种子"
	seed_type = "lemon"

/obj/item/seeds/orangeseed
	name = "橙子种子"
	seed_type = "orange"

/obj/item/seeds/poisonberryseed
	seed_type = "poisonberries"

/obj/item/seeds/deathberryseed
	seed_type = "deathberries"

/obj/item/seeds/grassseed
	name = "草种子"
	seed_type = "grass"

/obj/item/seeds/cocoapodseed
	name = "可可种子"
	seed_type = "cocoa"

/obj/item/seeds/cherryseed
	name = "樱桃种子"
	seed_type = "cherry"

/obj/item/seeds/kudzuseed
	seed_type = "kudzu"
