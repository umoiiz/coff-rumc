/obj/item/reagent_containers/food/drinks/cans
	name = "汽水罐"
	reagent_flags = NONE
	var/canopened = FALSE

/obj/item/reagent_containers/food/drinks/cans/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(!CONFIG_GET(flag/fun_allowed))
		return FALSE
	attack_hand(xeno_attacker)

/obj/item/reagent_containers/food/drinks/cans/attack_self(mob/user as mob)
	if(canopened == FALSE)
		playsound(src,'sound/effects/canopen.ogg', 15, 1)
		to_chat(user, span_notice("你随着[pick("an audible", "a satisfying")]的一声打开了饮料!"))
		canopened = TRUE
		ENABLE_BITFIELD(reagents.reagent_flags, OPENCONTAINER_NOUNIT)
		return
	var/obj/item/reagent_containers/H = usr.get_active_held_item()
	var/N = tgui_input_list(user, "每次转移的量:","[H]", possible_transfer_amounts)
	if (N)
		H.amount_per_transfer_from_this = N

/obj/item/reagent_containers/food/drinks/cans/attack(mob/M as mob, mob/user as mob, def_zone)
	if (canopened == FALSE)
		to_chat(user, span_notice("你需要先打开饮料!"))
		return
	..()

//DRINKS

/obj/item/reagent_containers/food/drinks/cans/cola
	name = "\improper TGM可乐"
	desc = "一罐人工香料、甜味剂和色素,至少它是碳酸的.由Nanotrasen罐装."
	icon_state = "tgm_cola"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/space_cola = 30)

/obj/item/reagent_containers/food/drinks/cans/waterbottle
	name = "\improper Nanotrasen瓶装泉水"
	desc = "价格过高的'泉'水.由Nanotrasen瓶装."
	icon_state = "bottled_water"
	center_of_mass = list("x"=15, "y"=8)
	list_reagents = list(/datum/reagent/water = 30)

/obj/item/reagent_containers/food/drinks/cans/beer
	name = "一罐啤酒"
	desc = "啤酒.你已经锁定了目标.是时候进行效力射击了."
	icon_state = "beercan"
	center_of_mass = list("x"=16, "y"=12)
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 30)

/obj/item/reagent_containers/food/drinks/cans/ale
	name = "一罐麦酒"
	desc = "啤酒被误解的表亲."
	icon_state = "alecan"
	worn_icon_state = "beer"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/ethanol/ale = 30)

/obj/item/reagent_containers/food/drinks/cans/space_mountain_wind
	name = "\improper 太空山风"
	desc = "像一阵太空风一样直接穿过你."
	icon_state = "space_mountain_wind"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/spacemountainwind = 30)

/obj/item/reagent_containers/food/drinks/cans/thirteenloko
	name = "\improper 十三号Loko"
	desc = "首席医疗官已告知船员,饮用十三号Loko可能导致癫痫发作、失明、醉酒,甚至死亡.请理性饮酒."
	icon_state = "thirteen_loko"
	center_of_mass = list("x"=16, "y"=8)
	list_reagents = list(/datum/reagent/consumable/ethanol/thirteenloko = 30)

/obj/item/reagent_containers/food/drinks/cans/dr_gibb
	name = "\improper 吉布博士"
	desc = "42种不同口味化学物质的 delicious 混合物,你根本念不出来."
	icon_state = "dr_gibb"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/dr_gibb = 30)

/obj/item/reagent_containers/food/drinks/cans/starkist
	name = "\improper 星奇"
	desc = "液体形式的星星的味道.还有,一点金枪鱼...?"
	icon_state = "starkist"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/space_cola = 15, /datum/reagent/consumable/orangejuice = 15)

/obj/item/reagent_containers/food/drinks/cans/space_up
	name = "\improper 太空起"
	desc = "尝起来就像你嘴里发生了船体破裂."
	icon_state = "space-up"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/space_up = 30)

/obj/item/reagent_containers/food/drinks/cans/lemon_lime
	name = "柠檬青柠"
	desc = "你想要的是橙子味.它却给了你柠檬青柠."
	icon_state = "lemon-lime"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/lemon_lime = 30)

/obj/item/reagent_containers/food/drinks/cans/iced_tea
	name = "冰茶罐"
	desc = "就像小队里那个乡巴佬的奶奶以前会买的那种."
	icon_state = "ice_tea_can"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/ = 30)

/obj/item/reagent_containers/food/drinks/cans/grape_juice
	name = "葡萄汁"
	desc = "一罐大概不是葡萄汁的东西."
	icon_state = "purple_can"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/grapejuice = 30)

/obj/item/reagent_containers/food/drinks/cans/tonic
	name = "汤力水"
	desc = "第一步:汤力水.完成.第二步:金酒."
	icon_state = "tonic"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/tonic = 50)

/obj/item/reagent_containers/food/drinks/cans/sodawater
	name = "苏打水"
	desc = "一罐苏打水.自来水更清爽的表亲...据那些欧洲佬说."
	icon_state = "sodawater"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/sodawater = 50)

/obj/item/reagent_containers/food/drinks/cans/souto
	name = "\improper Souto经典"
	desc = "罐子大胆地宣称它是橘子味的.你忍不住觉得那是骗人的.在哈瓦那罐装."
	icon_state = "souto_classic"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/suoto = 50)

/obj/item/reagent_containers/food/drinks/cans/souto/diet
	name = "\improper 低卡Souto"
	desc = "现在含有0%果汁!在哈瓦那罐装"
	icon_state = "souto_diet_classic"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/suoto = 25, /datum/reagent/water = 25)

/obj/item/reagent_containers/food/drinks/cans/souto/cherry
	name = "\improper 樱桃Souto"
	desc = "现在含有更多人工香料!在哈瓦那罐装"
	icon_state = "souto_cherry"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/suoto/cherry = 50)

/obj/item/reagent_containers/food/drinks/cans/souto/cherry/diet
	name = "\improper 低卡樱桃Souto"
	desc = "它既不是低卡的也不是樱桃味的.在哈瓦那罐装."
	icon_state = "souto_diet_cherry"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/suoto/cherry = 25, /datum/reagent/consumable/ethanol = 25)

/obj/item/reagent_containers/food/drinks/cans/aspen
	name = "\improper Nanotrasen白杨啤酒"
	desc = "克服了它尝起来像尿这个事实之后,其实还不错.由Nanotrasen罐装."
	icon_state = "6_pack_1"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/ethanol/nt_beer = 50)

/obj/item/reagent_containers/food/drinks/cans/souto/lime
	name = "\improper 青柠苏托"
	desc = "不算差.也不算好,但不算差.在哈瓦那罐装."
	icon_state = "souto_lime"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/lemon_lime = 50)

/obj/item/reagent_containers/food/drinks/cans/souto/lime/diet
	name = "\improper 无糖青柠苏托"
	desc = "十种酸,两杯假糖,几乎满满一罐二氧化碳,还有大约210千帕全塞进一个铝罐里.有什么理由不爱呢?在哈瓦那罐装."
	icon_state = "souto_diet_lime"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/lemon_lime = 25, /datum/reagent/water = 25)

/obj/item/reagent_containers/food/drinks/cans/souto/grape
	name = "\improper 葡萄苏托"
	desc = "汽水口味里的老牌经典.不过这个尝起来像葡萄味止咳糖浆.在哈瓦那罐装."
	icon_state = "souto_grape"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/grapejuice = 50)

/obj/item/reagent_containers/food/drinks/cans/souto/grape/diet
	name = "\improper 无糖葡萄苏托"
	desc = "你相当确定这就是葡萄止咳糖浆加苏打水.在哈瓦那罐装."
	icon_state = "souto_diet_grape"
	center_of_mass = list("x"=16, "y"=10)
	list_reagents = list(/datum/reagent/consumable/grapejuice = 25, /datum/reagent/water = 25)
