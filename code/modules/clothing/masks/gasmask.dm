/obj/item/clothing/mask/gas
	name = "透明防毒面具"
	desc = "一种可连接到供气装置的面部覆盖面具.可过滤空气中的有害气体."
	icon_state = "gas_alt"
	worn_icon_state = "gas_alt"
	inventory_flags = COVERMOUTH | COVEREYES | BLOCKGASEFFECT
	inv_hide_flags = HIDEEARS|HIDEFACE|HIDELOWHAIR
	cold_protection_flags = HEAD
	min_cold_protection_temperature = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	siemens_coefficient = 0.9
	var/gas_filter_strength = 1			//For gas mask filters
	var/list/filtered_gases = list(/datum/reagent/toxin/phoron, "sleeping_agent", "carbon_dioxide")
	///Does this particular mask have breath noises
	var/breathy = TRUE
	///This covers most of the screen
	var/hearing_range = 5

/obj/item/clothing/mask/gas/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!breathy)
		return
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_GAS_BREATH))
		return
	if(slot != SLOT_WEAR_MASK)
		return
	for(var/M in get_hearers_in_view(hearing_range, src))
		if(ismob(M))
			var/mob/HM = M
			HM.playsound_local(user, SFX_GASBREATH, 20, 1)
			TIMER_COOLDOWN_START(src, COOLDOWN_GAS_BREATH, 10 SECONDS)

/obj/item/clothing/mask/gas/tactical
	name = "战术防毒面具"
	icon_state = "gas_alt_tactical"

/obj/item/clothing/mask/gas/tactical/coif
	name = "战术头巾式防毒面具"
	desc = "一种可连接到供气装置的面部覆盖头巾式面具.可过滤空气中的有害气体."
	icon_state = "gascoif"
	inv_hide_flags = HIDEEARS|HIDEFACE|HIDEALLHAIR

/obj/item/clothing/mask/gas/pmc
	name = "\improper M8型装甲巴拉克拉瓦头套"
	desc = "一种装甲巴拉克拉瓦头套,旨在隐藏操作员的身份并充当空气过滤器."
	icon_state = "pmc_mask"
	worn_icon_state = "helmet"
	anti_hug = 3
	inventory_flags = COVERMOUTH|BLOCKGASEFFECT
	inv_hide_flags = HIDEEARS|HIDEFACE|HIDEALLHAIR
	breathy = FALSE

/obj/item/clothing/mask/gas/pmc/damaged
	name = "损坏的M8型装甲巴拉克拉瓦头套"
	anti_hug = 0

/obj/item/clothing/mask/gas/pmc/upp
	name = "\improper UPP装甲突击队巴拉克拉瓦头套"
	icon_state = "upp_mask"

/obj/item/clothing/mask/gas/pmc/leader
	name = "\improper M8型装甲巴拉克拉瓦头套"
	desc = "一种装甲巴拉克拉瓦头套,旨在隐藏操作员的身份并充当空气过滤器.这套装备看起来属于一名高级军官."
	icon_state = "officer_mask"

/obj/item/clothing/mask/gas/icc
	name = "\improper Modelle/60防毒面具"
	desc = "ICC人员佩戴的防毒面具."
	icon_state = "icc"

/obj/item/clothing/mask/gas/vsd
	name = "\improper 维亚切斯拉夫装甲突击队巴拉克拉瓦头套"
	desc = "传给V.S.D.的旧巴拉克拉瓦头套."
	inv_hide_flags = HIDEEARS|HIDEFACE|HIDEALLHAIR
	icon_state = "upp_mask"

//Plague Dr suit can be found in clothing/suits/bio.dm
/obj/item/clothing/mask/gas/plaguedoctor
	name = "瘟疫医生面具"
	desc = "经典设计的现代化版本,这个面具不仅能过滤phoron,还能连接到供气装置."
	icon_state = "plaguedoctor"
	worn_icon_state = "gas_mask"
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 2, ENERGY = 2, BOMB = 0, BIO = 75, FIRE = 2, ACID = 2)
	armor_protection_flags = HEAD|FACE

/obj/item/clothing/mask/gas/swat
	name = "\improper 特警面具"
	desc = "一种可连接到供气装置的贴身战术面具."
	icon_state = "swat"
	anti_hug = 1
	siemens_coefficient = 0.7
	armor_protection_flags = FACE|EYES

/obj/item/clothing/mask/gas/swat/on_hugger_damage()
	name = "\improper torn SWAT mask"
	icon_state = "swat_torn"
	update_clothing_icon()
	playsound(src, 'sound/items/velpro_rip.ogg', 25)

/obj/item/clothing/mask/gas/specops
	name = "特种作战防毒面具"
	desc = "一种可连接到供气装置的贴身战术面具.基于旧式防毒面具设计."
	icon = 'icons/mob/clothing/mask.dmi'
	worn_icon_list = list(
		slot_wear_suit_str = 'icons/mob/clothing/mask.dmi'
	)
	icon_state = "specop"
	worn_icon_state = "specop"
	siemens_coefficient = 0.7

/obj/item/clothing/mask/gas/syndicate
	name = "辛迪加面具"
	desc = "一种可连接到供气装置的贴身战术面具."
	icon_state = "swat"
	siemens_coefficient = 0.7

/obj/item/clothing/mask/gas/space_ninja
	name = "忍者面具"
	desc = "一种贴身面具,既可作为空气过滤器,又是一种后现代时尚宣言."
	icon_state = "s-ninja"
	worn_icon_state = "s-ninja_mask"
	siemens_coefficient = 0.2

/obj/item/clothing/mask/gas/clown_hat
	name = "小丑假发和面具"
	desc = "真正的恶作剧者的面部装束.没有假发和面具的小丑是不完整的."
	icon_state = "clown"
	worn_icon_state = "clown_hat"
	breathy = FALSE

/obj/item/clothing/mask/gas/sexyclown
	name = "性感小丑假发和面具"
	desc = "为涉猎变装者或女性表演者设计的女性小丑面具."
	icon_state = "sexyclown"
	worn_icon_state = "sexyclown"
	breathy = FALSE

/obj/item/clothing/mask/gas/mime
	name = "哑剧演员面具"
	desc = "传统的哑剧演员面具.有着诡异的面部姿态."
	icon_state = "mime"
	worn_icon_state = "mime"
	breathy = FALSE

/obj/item/clothing/mask/gas/monkeymask
	name = "猴子面具"
	desc = "扮演猴子时使用的面具."
	icon_state = "monkeymask"
	worn_icon_state = "monkeymask"
	armor_protection_flags = HEAD|FACE|EYES
	breathy = FALSE

/obj/item/clothing/mask/gas/sexymime
	name = "性感哑剧演员面具"
	desc = "传统的女性哑剧演员面具."
	icon_state = "sexymime"
	worn_icon_state = "sexymime"
	breathy = FALSE

/obj/item/clothing/mask/gas/cyborg
	name = "赛博格护目镜"
	desc = "哔哔啵啵"
	icon_state = "death"
	breathy = FALSE

/obj/item/clothing/mask/gas/owl_mask
	name = "猫头鹰面具"
	desc = "呼呜呜呜!"
	icon_state = "owl"

/obj/item/clothing/mask/gas/separatist
	name = "常规防护防毒面具TM-58"
	desc = "最初是民用型号,正面用一块金属板加固.不太方便,但极其可靠.它曾被称为\"抵抗部队的脸面\"."
	icon_state = "separatist"
	inv_hide_flags = HIDEEARS|HIDEFACE|HIDEALLHAIR

/obj/item/clothing/mask/gas/veteran
	name = "老兵呼吸面具"
	desc = "这款面具的加固迷彩剪裁能很好地保护面部免受碎片和有害气体的伤害.漂亮的手工活,士兵!"
	icon_state = "veteran"
	inv_hide_flags = HIDEEARS|HIDEFACE|HIDEALLHAIR

/obj/item/clothing/mask/gas/fullgas
	name = "古代防毒面具"
	desc = "一种可连接到供气装置的古老面部覆盖面具.可过滤空气中的有害气体."
	icon_state = "fullgas"
	inv_hide_flags = HIDEEARS|HIDEFACE|HIDEALLHAIR

/obj/item/clothing/mask/gas/sgmask
	name = "军用级防毒面具"
	desc = "一种可连接到供气装置的军用级防毒面具.可过滤空气中的有害气体."
	icon_state = "sgmask"

/obj/item/clothing/mask/gas/redmask
	name = "头巾式防毒面具"
	desc = "一种头巾式防毒面具,覆盖使用者的大部分头部,可连接到供气装置.可过滤空气中的有害气体."
	icon_state = "redmask"
	inv_hide_flags = HIDEEARS|HIDEFACE|HIDEALLHAIR

