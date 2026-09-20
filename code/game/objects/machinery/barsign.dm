/obj/machinery/barsign
	name = "bar sign"
	desc = "一个不知何故未被初始化的酒吧招牌.去找程序员抱怨吧!"
	icon = 'icons/obj/structures/barsigns.dmi'
	icon_state = "off"
	/// Selected barsign being used
	var/datum/barsign/chosen_sign

/obj/machinery/barsign/Initialize(mapload)
	. = ..()

	switch(dir)
		if(NORTH)
			pixel_y = 32
		if(SOUTH)
			pixel_y = -32
		if(EAST)
			pixel_x = 30
		if(WEST)
			pixel_x = -30

	if(!chosen_sign)
		var/random_sign = pick(subtypesof(/datum/barsign))
		chosen_sign = new random_sign
	update_appearance()

/obj/machinery/barsign/update_name()
	. = ..()
	name = chosen_sign.name

/obj/machinery/barsign/update_desc()
	. = ..()
	desc = chosen_sign.desc

/obj/machinery/barsign/update_icon_state()
	if(!(machine_stat & BROKEN) && (!(machine_stat & NOPOWER) || machine_stat & EMPED) && chosen_sign && chosen_sign.icon_state)
		icon_state = chosen_sign.icon_state
	else
		icon_state = "off"

	return ..()

/obj/machinery/barsign/update_overlays()
	. = ..()

	if(((machine_stat & NOPOWER) && !(machine_stat & EMPED)) || (machine_stat & BROKEN))
		return

	if(chosen_sign && chosen_sign.light_mask)
		. += emissive_appearance(icon, "[chosen_sign.icon_state]-light-mask", src)

/obj/machinery/barsign/update_appearance(updates=ALL)
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		set_light(0)
		return
	if(chosen_sign && chosen_sign.neon_color)
		set_light(MINIMUM_USEFUL_LIGHT_RANGE, 0.7, chosen_sign.neon_color)

/datum/barsign
	/// User-visible name of the sign.
	var/name
	/// Icon state associated with this sign
	var/icon_state
	/// Description shown in the sign's examine text.
	var/desc
	/// If a barsign has a light mask for emission effects
	var/light_mask = TRUE
	/// The emission color of the neon light
	var/neon_color

/datum/barsign/signoff
	name = "Off"
	icon_state = "off"
	desc = "这个招牌似乎没有开启."
	light_mask = FALSE

/datum/barsign/maltesefalcon
	name = "Maltese Falcon"
	icon_state = "maltesefalcon"
	desc = "马耳他之鹰太空酒吧烧烤店."
	neon_color = COLOR_BLUE_GRAY

/datum/barsign/thebark
	name = "The Bark"
	icon_state = "thebark"
	desc = "伊恩的首选酒吧."
	neon_color = COLOR_ORANGE

/datum/barsign/harmbaton
	name = "The Harmbaton"
	icon_state = "theharmbaton"
	desc = "对安保人员和助理来说都是绝佳的用餐体验."
	neon_color = COLOR_TAN_ORANGE

/datum/barsign/thesingulo
	name = "The Singulo"
	icon_state = "thesingulo"
	desc = "那些不愿被人直呼其名的人的去处."
	neon_color = COLOR_VIOLET

/datum/barsign/thedrunkcarp
	name = "The Drunk Carp"
	icon_state = "thedrunkcarp"
	desc = "别酒后游泳."
	neon_color = COLOR_DEEP_MAGENTA

/datum/barsign/scotchservinwillys
	name = "Scotch Servin Willy's"
	icon_state = "scotchservinwillys"
	desc = "威利确实飞黄腾达了,从一个小丑变成了酒保."
	neon_color = COLOR_PALE_ORANGE

/datum/barsign/officerbeersky
	name = "Officer Beersky's"
	icon_state = "officerbeersky"
	desc = "天哪,这酒真好喝."
	neon_color = COLOR_EMERALD_GREEN

/datum/barsign/thecavern
	name = "The Cavern"
	icon_state = "thecavern"
	desc = "好酒配好曲."
	neon_color = COLOR_VIBRANT_LIME

/datum/barsign/theouterspess
	name = "The Outer Spess"
	icon_state = "theouterspess"
	desc = "这家酒吧其实并不在外太空."
	neon_color = COLOR_CYAN

/datum/barsign/slipperyshots
	name = "Slippery Shots"
	icon_state = "slipperyshots"
	desc = "一杯接一杯,滑向醉酒的深渊!"
	neon_color = COLOR_MOSSY_GREEN

/datum/barsign/thegreytide
	name = "The Grey Tide"
	icon_state = "thegreytide"
	desc = "放下你的工具箱,来享受一杯悠闲的啤酒吧!"
	neon_color = COLOR_CYAN

/datum/barsign/honkednloaded
	name = "Honked 'n' Loaded"
	icon_state = "honkednloaded"
	desc = "哔."
	neon_color = COLOR_SOFT_RED

/datum/barsign/thenest
	name = "The Nest"
	icon_state = "thenest"
	desc = "在漫长的一夜打击犯罪之后,这里是个喝酒养老的好地方."
	neon_color = COLOR_DUSKY_BLUE

/datum/barsign/thecoderbus
	name = "The Coderbus"
	icon_state = "thecoderbus"
	desc = "一家颇具争议的酒吧,以其种类繁多、不断变化的饮品而闻名."
	neon_color = COLOR_WHITE

/datum/barsign/theadminbus
	name = "The Adminbus"
	icon_state = "theadminbus"
	desc = "一家主要接待太空法官的场所.它被炸的次数远不及法庭听证会那么多."
	neon_color = COLOR_WHITE

/datum/barsign/oldcockinn
	name = "The Old Cock Inn"
	icon_state = "oldcockinn"
	desc = "这块招牌让你莫名感到一阵绝望."
	neon_color = COLOR_LOBBY_RED

/datum/barsign/thewretchedhive
	name = "The Wretched Hive"
	icon_state = "thewretchedhive"
	desc = "法律要求我们必须提醒您在饮用前检查饮品中是否含有酸液."
	neon_color = COLOR_LIME

/datum/barsign/robustacafe
	name = "The Robusta Cafe"
	icon_state = "robustacafe"
	desc = "\"最致命酒吧斗殴\"纪录保持者,五年无人挑战."
	neon_color = COLOR_RED_GRAY

/datum/barsign/emergencyrumparty
	name = "The Emergency Rum Party"
	icon_state = "emergencyrumparty"
	desc = "在长期关闭后最近重新获得执照."
	neon_color = COLOR_RED

/datum/barsign/combocafe
	name = "The Combo Cafe"
	icon_state = "combocafe"
	desc = "因其毫无创意的调酒组合而闻名全星系."
	neon_color = COLOR_LIME

/datum/barsign/vladssaladbar
	name = "Vlad's Salad Bar"
	icon_state = "vladssaladbar"
	desc = "新管理层接手.弗拉德以前用那把霰弹枪总是太容易走火了."
	neon_color = COLOR_DEEP_MOSS_GREEN

/datum/barsign/theshaken
	name = "The Shaken"
	icon_state = "theshaken"
	desc = "本店不提供搅拌饮品."
	neon_color = COLOR_VERY_SOFT_YELLOW

/datum/barsign/thealenath
	name = "The Ale' Nath"
	icon_state = "thealenath"
	desc = "好了,伙计.我觉得你已经 EI NATH 了.该叫辆出租车了."
	neon_color = COLOR_RED

/datum/barsign/thenet
	name = "The Net"
	icon_state = "thenet"
	desc = "你似乎总是深陷其中好几个小时."
	neon_color = COLOR_GREEN

/datum/barsign/maidcafe
	name = "Maid Cafe"
	icon_state = "maidcafe"
	desc = "欢迎回来,主人!"
	neon_color = COLOR_MOSTLY_PURE_PINK

/datum/barsign/thelightbulb
	name = "The Lightbulb"
	icon_state = "thelightbulb"
	desc = "一家深受飞蛾和蛾人欢迎的咖啡馆.曾因酒保用樟脑丸保护她的备用制服而停业一周."
	neon_color = COLOR_VERY_SOFT_YELLOW

/datum/barsign/orangejuice
	name = "Oranges' Juicery"
	icon_state = "orangejuice"
	desc = "献给那些希望对非酒精饮品人群保持最佳得体态度的人."
	neon_color = COLOR_ORANGE

/datum/barsign/neon_flamingo
	name = "Neon Flamingo"
	icon_state = "neon-flamingo"
	desc = "一辆面向所有人的巴士,除了那些花哨到有障碍的人."
	neon_color = COLOR_PINK

/obj/machinery/barsign/thedrunkcarp
	chosen_sign = new /datum/barsign/thedrunkcarp
