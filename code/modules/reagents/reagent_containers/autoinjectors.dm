/obj/item/reagent_containers/hypospray/autoinjector
	name = "通用自动注射器"
	desc = "一个装有...食盐的自动注射器? <i>\"如需任何客户端协助, 请联系coderbus\"写在背面.</i>"
	icon_state = "autoinjector"
	worn_icon_state = "hypo"
	w_class = WEIGHT_CLASS_TINY
	skilllock = 0
	reagent_flags = DRAWABLE
	amount_per_transfer_from_this = 15
	volume = 45
	possible_transfer_amounts = list(1, 3, 5, 10, 15, 20, 30, 45)
	list_reagents = list(/datum/reagent/consumable/sodiumchloride = 45)
	///For keeping the initial name of the autoinjector, and not setting back to general autoinjector
	var/base_name

/obj/item/reagent_containers/hypospray/autoinjector/Initialize(mapload)
	base_icon_state = icon_state
	base_name = name
	return ..() // some incomprehensible power of shitcode makes penals first update icon_state and only then set base_icon_state, works fine for simple autoinjectors tho

/obj/item/reagent_containers/hypospray/autoinjector/update_icon_state()
	. = ..()
	if(!(reagents?.total_volume) && is_drawable())
		icon_state = "[base_icon_state]X"
		name = "expended [base_name]"
		DISABLE_BITFIELD(reagents.reagent_flags, DRAWABLE)
	else if(reagents?.total_volume && !CHECK_BITFIELD(reagents.reagent_flags, DRAWABLE)) // refilling it somehow
		icon_state = base_icon_state
		name = base_name
		ENABLE_BITFIELD(reagents.reagent_flags, DRAWABLE)

/obj/item/reagent_containers/hypospray/autoinjector/examine(mob/user)
	. = ..()
	. += "" // for some weird reason, without this lower lines get in line with item's size line
	if(length(reagents.reagent_list))
		. += span_notice("当前已装填.")
	else
		. += span_notice("已用完.")
	. += span_warning("<b>使用</b>注入自己. <b>独特动作</b>来配置注射量.")

/obj/item/reagent_containers/hypospray/autoinjector/fillable
	desc = "一个装有...某种东西的自动注射器, 请咨询给你这个的医生."
	amount_per_transfer_from_this = 45
	list_reagents = null

/obj/item/reagent_containers/hypospray/autoinjector/tricordrazine
	name = "三可定自动注射器"
	desc = "一个装有3剂三可定的自动注射器, 一种用于治疗伤害的弱效通用药物."
	icon_state = "autoinjector-4"
	list_reagents = list(/datum/reagent/medicine/tricordrazine = 45)
	description_overlay = "Ti"

/obj/item/reagent_containers/hypospray/autoinjector/combat
	name = "战斗自动注射器"
	desc = "一个装有3剂治疗和止痛化学品的自动注射器. 用于实战."
	icon_state = "RedGreen"
	amount_per_transfer_from_this = 15
	list_reagents = list(
		/datum/reagent/medicine/bicaridine = 15,
		/datum/reagent/medicine/kelotane = 15,
		/datum/reagent/medicine/tricordrazine = 7.5,
		/datum/reagent/medicine/tramadol = 7.5,
	)
	description_overlay = "Cb"

/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced
	name = "高级战斗自动注射器"
	desc = "一个装有3剂高级治疗和止痛化学品的自动注射器. 用于实战."
	icon_state = "Lilac"
	amount_per_transfer_from_this = 15
	list_reagents = list(
		/datum/reagent/medicine/meralyne = 15,
		/datum/reagent/medicine/dermaline = 15,
		/datum/reagent/medicine/oxycodone = 15,
	)
	description_overlay = "Ca"

/obj/item/reagent_containers/hypospray/autoinjector/quickclot
	name = "速凝自动注射器"
	desc = "一个装有3剂速凝的自动注射器, 一种旨在暂停所有出血的化学品. 按需续用."
	icon_state = "autoinjector-7"
	list_reagents = list(/datum/reagent/medicine/quickclot = 45)
	description_overlay = "Qk"

/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus
	name = "速凝加自动注射器"
	desc = "一个装有3次速凝加的自动注射器, 一种旨在消除内出血的化学品. 配合抗毒素使用. !切勿在实战中使用!"
	icon_state = "autoinjector-7"
	amount_per_transfer_from_this = 5
	volume = 15
	list_reagents = list(/datum/reagent/medicine/quickclotplus = 15)
	description_overlay = "Qk+"

/obj/item/reagent_containers/hypospray/autoinjector/dexalinplus
	name = "右旋糖酐加自动注射器"
	desc = "一个装有3次右旋糖酐加的自动注射器, 旨在立即为全身供氧."
	icon_state = "autoinjector-2"
	amount_per_transfer_from_this = 1
	volume = 3
	list_reagents = list(/datum/reagent/medicine/dexalinplus = 3)
	description_overlay = "Dx+"

/obj/item/reagent_containers/hypospray/autoinjector/sleeptoxin
	name = "麻醉自动注射器"
	desc = "一个装有10单位催眠剂的自动注射器. 适合快速镇静某人, 当然是为了手术."
	icon_state = "autoinjector-8"
	amount_per_transfer_from_this = 10
	volume = 10
	list_reagents = list(
		/datum/reagent/toxin/sleeptoxin = 8,
		/datum/reagent/toxin/chloralhydrate = 2,
	)

/obj/item/reagent_containers/hypospray/autoinjector/dylovene
	name = "地洛芬自动注射器"
	desc = "一个装有3剂地洛芬的自动注射器, 一种抗毒素剂, 用于中毒, 过量用药和毒素积聚的情况."
	icon_state = "autoinjector-1"
	list_reagents = list(/datum/reagent/medicine/dylovene = 45)
	description_overlay = "Dy"

/obj/item/reagent_containers/hypospray/autoinjector/tramadol
	name = "曲马多自动注射器"
	desc = "一个装有3剂曲马多的自动注射器, 一种用于普通创伤的有效止痛药."
	icon_state = "autoinjector-10"
	list_reagents = list(/datum/reagent/medicine/tramadol = 45)
	description_overlay = "Ta"

/obj/item/reagent_containers/hypospray/autoinjector/oxycodone
	name = "羟考酮自动注射器"
	desc = "一个装有2剂羟考酮的自动注射器, 一种用于危及生命情况的强效止痛药."
	icon_state = "autoinjector-6"
	volume = 20
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/medicine/oxycodone = 20)
	description_overlay = "Ox"

/obj/item/reagent_containers/hypospray/autoinjector/kelotane
	name = "凯洛坦自动注射器"
	desc = "一个装有3剂凯洛坦的自动注射器, 一种常见的烧伤药物."
	icon_state = "autoinjector-5"
	list_reagents = list(/datum/reagent/medicine/kelotane = 45)
	description_overlay = "Ke"

/obj/item/reagent_containers/hypospray/autoinjector/bicaridine
	name = "比卡利定自动注射器"
	desc = "一个装有3剂比卡利定的自动注射器, 一种常见的钝击和循环系统损伤药物."
	icon_state = "autoinjector-3"
	list_reagents = list(/datum/reagent/medicine/bicaridine = 45)
	description_overlay = "Bi"

/obj/item/reagent_containers/hypospray/autoinjector/inaprovaline
	name = "英诺普洛林自动注射器"
	desc = "一个装有3剂英诺普洛林的自动注射器, 一种用于危重病人的紧急稳定药物."
	icon_state = "autoinjector-9"
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/inaprovaline = 45)
	description_overlay = "In"

/obj/item/reagent_containers/hypospray/autoinjector/dexalin
	name = "右旋糖酐自动注射器"
	desc = "一个装有3剂右旋糖酐的自动注射器, 一种为身体供氧的药物, 帮助有呼吸问题或低血量的人."
	icon_state = "autoinjector-2"
	volume = 15
	amount_per_transfer_from_this = 5
	list_reagents = list(/datum/reagent/medicine/dexalin = 15)
	description_overlay = "Dx"

/obj/item/reagent_containers/hypospray/autoinjector/spaceacillin
	name = "太空青霉素自动注射器"
	desc = "一个装有9剂太空青霉素的自动注射器, 一种帮助对抗感染和坏死组织的抗生素药物."
	icon_state = "autoinjector-1"
	amount_per_transfer_from_this = 5
	list_reagents = list(/datum/reagent/medicine/spaceacillin = 45)
	description_overlay = "Sp"

/obj/item/reagent_containers/hypospray/autoinjector/alkysine
	name = "阿尔基辛自动注射器"
	desc = "一个装有9剂阿尔基辛的自动注射器, 一种用于修复脑部和耳部损伤的长效药物."
	icon_state = "autoinjector-12"
	amount_per_transfer_from_this = 5
	list_reagents = list(/datum/reagent/medicine/alkysine = 45)
	description_overlay = "Al"

/obj/item/reagent_containers/hypospray/autoinjector/imidazoline
	name = "咪达唑仑自动注射器"
	desc = "一个装有6剂咪达唑仑的自动注射器, 用于修复视力的药物."
	icon_state = "autoinjector-5"
	amount_per_transfer_from_this = 7.5
	list_reagents = list(/datum/reagent/medicine/imidazoline = 45)
	description_overlay = "Im"

/obj/item/reagent_containers/hypospray/autoinjector/hypervene
	name = "超维恩自动注射器"
	desc = "一个装有15次超维恩的自动注射器, 一种能迅速清除化学物质的紧急药物. 会引起疼痛和呕吐."
	icon_state = "Toxic"
	amount_per_transfer_from_this = 3
	list_reagents = list(/datum/reagent/hypervene = 45)
	description_overlay = "Hy"

/obj/item/reagent_containers/hypospray/autoinjector/virilyth //not accessible during normal play, only for valhalla
	name = "维利林斯自动注射器"
	desc = "一个刚装填了维利林斯的大型自动注射器."
	icon_state = "autoinjector-8"
	amount_per_transfer_from_this = 10
	volume = 50
	list_reagents = list(
		/datum/reagent/virilyth = 50,
	)

/obj/item/reagent_containers/hypospray/autoinjector/rezadone //not accessible during normal play, only for valhalla
	name = "雷扎酮自动注射器"
	desc = "一个刚装填了雷扎酮的大型自动注射器."
	icon_state = "autoinjector-8"
	amount_per_transfer_from_this = 10
	volume = 50
	list_reagents = list(
		/datum/reagent/medicine/rezadone = 50,
	)

/obj/item/reagent_containers/hypospray/autoinjector/synaptizine
	name = "突触嗪自动注射器"
	desc = "一个刚装填了可安全使用的突触嗪混合剂的大型自动注射器."
	icon_state = "Mystery"
	amount_per_transfer_from_this = 3
	volume = 18
	list_reagents = list(
		/datum/reagent/medicine/synaptizine = 6,
		/datum/reagent/medicine/hyronalin = 12,
	)
	description_overlay = "Sy"

/obj/item/reagent_containers/hypospray/autoinjector/synaptizine_expired
	name = "过期的突触净自动注射器"
	desc = "一种自动注射器,据说装有无害的突触净混合液,已过期3个月."
	icon_state = "autoinjector-1"
	amount_per_transfer_from_this = 2
	volume = 6
	list_reagents = list(
		/datum/reagent/medicine/synaptizine = 3,
		/datum/reagent/medicine/hyronalin = 3,
	)
	description_overlay = "Sy-"

/obj/item/reagent_containers/hypospray/autoinjector/neuraline
	name = "神经碱自动注射器"
	desc = "一种装有3剂神经碱的自动注射器,一种极其强效的兴奋剂. !切勿一次使用超过一剂!"
	icon_state = "RedWhite"
	amount_per_transfer_from_this = 4
	volume = 12
	list_reagents = list(/datum/reagent/medicine/neuraline = 12)
	description_overlay = "Ne"

/obj/item/reagent_containers/hypospray/autoinjector/peridaxon
	name = "派立克松自动注射器"
	desc = "一种装有3剂派立克松的自动注射器,一种能消除器官损伤后果的化学物质 !切勿一次使用超过一剂!"
	amount_per_transfer_from_this = 5
	volume = 15
	icon_state = "VioWhite"
	list_reagents = list(/datum/reagent/medicine/peridaxon = 15)
	description_overlay = "Pe"

/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus
	name = "派立克松加强型自动注射器"
	desc = "一种装有3剂派立克松加强型的自动注射器,一种能治疗器官同时导致毒素积累的化学物质. 与抗毒素配合使用. !切勿在战斗中主动使用!"
	icon_state = "VioWhite"
	amount_per_transfer_from_this = 3
	volume = 9
	list_reagents = list(
		/datum/reagent/medicine/peridaxon_plus = 3,
		/datum/reagent/medicine/hyronalin = 6,
	)
	description_overlay = "Pe+"

/obj/item/reagent_containers/hypospray/autoinjector/antitox_mix
	name = "抗毒素混合液4"
	desc = "一种装有旨在快速治疗严重毒素伤害的化学混合物的自动注射器. 请勿在无适当医疗监督下使用."
	icon_state = "Toxic"
	amount_per_transfer_from_this = 15
	list_reagents = list(
		/datum/reagent/medicine/hyronalin = 7.5,
		/datum/reagent/medicine/dylovene = 7.5,
		/datum/reagent/medicine/tricordrazine = 7.5,
		/datum/reagent/medicine/arithrazine = 7.5,
	)
	description_overlay = "Tx4"

/obj/item/reagent_containers/hypospray/autoinjector/russian_red
	name = "紧急自动注射器"
	desc = "一种装有3剂俄罗斯红的自动注射器. 恢复大量耐力并治疗大量伤害,但会造成轻微的永久性损伤."
	icon_state = "Redwood"
	amount_per_transfer_from_this = 10
	list_reagents = list(
		/datum/reagent/medicine/russian_red = 30,
	)
	description_overlay = "Rr"
	free_refills = FALSE

/obj/item/reagent_containers/hypospray/autoinjector/polyhexanide
	name = "聚六亚甲基双胍自动注射器"
	desc = "一种装有1剂聚六亚甲基双胍的自动注射器,一种用于内部手术的消毒剂."
	icon_state = "autoinjector-10"
	amount_per_transfer_from_this = 5
	volume = 20
	list_reagents = list(/datum/reagent/medicine/polyhexanide = 20)

/obj/item/reagent_containers/hypospray/autoinjector/isotonic
	name = "等渗溶液自动注射器"
	desc = "一种装有3剂等渗溶液的自动注射器,配方用于在失血或创伤后快速恢复体液量."
	icon_state = "autoinjector-8"
	amount_per_transfer_from_this = 15
	list_reagents = list(
		/datum/reagent/medicine/saline_glucose = 45,
	)
	description_overlay = "Is"

/obj/item/reagent_containers/hypospray/autoinjector/roulettium
	name = "轮盘碱自动注射器"
	desc = "一种装有1剂轮盘碱的自动注射器,一种极其强效的万灵药. !这有不可恢复死亡的风险!"
	icon_state = "autoinjector-6"
	amount_per_transfer_from_this = 1
	volume = 1
	list_reagents = list(/datum/reagent/medicine/roulettium = 1)

/obj/item/reagent_containers/hypospray/autoinjector/elite //only deathsquad should be able to get this
	name = "精英自动注射器"
	desc = "一种精英自动注射器,装有强效且多功能的化学混合物,能治疗大多数类型的伤害. 几乎只发放给臭名昭著的纳米传绪死亡小队"
	icon_state = "autoinjector-7"
	volume = 37.5
	amount_per_transfer_from_this = 12.4
	list_reagents = list(
		/datum/reagent/medicine/russian_red = 30,
		/datum/reagent/medicine/rezadone = 7.2,
	)

/obj/item/reagent_containers/hypospray/autoinjector/medicalnanites
	name = "纳米机器自动注射器"
	desc = "一种装有医疗纳米机器的自动注射器. 一种利用受试者血液繁殖的强效新型治疗方法,具有短暂但可能危险的激活期! 当心神经毒素!"
	icon_state = "autoinjector-6"
	amount_per_transfer_from_this = 1
	volume = 1
	list_reagents = list(/datum/reagent/medicalnanites = 1)
	free_refills = FALSE

/obj/item/reagent_containers/hypospray/autoinjector/sulfasalazine
	name = "柳氮磺吡啶自动注射器"
	desc = "一种装有柳氮磺吡啶的自动注射器,一种以消耗其他试剂并清除它们为代价自我恢复的药剂,但具有极佳的治疗效果. 警告: 它会嵌入身体最深的组织中,使得给药后无法从使用者体内取出"
	amount_per_transfer_from_this = 1
	volume = 1
	reagent_flags = NONE
	list_reagents = list(/datum/reagent/medicine/sulfasalazine = 1)
	free_refills = FALSE

/obj/item/reagent_containers/hypospray/autoinjector/sulfasalazine/afterattack(atom/A, mob/living/user)
	if(!ishuman(A))
		balloon_alert(user, "只能注射人类.")
		return
	. = ..()
	update_icon()

/obj/item/reagent_containers/hypospray/autoinjector/sulfasalazine/is_drawable()
	return FALSE

/obj/item/reagent_containers/hypospray/autoinjector/sulfasalazine/update_icon_state()
	if(!reagents?.total_volume)
		icon_state = "autoinjector-6X"
	else
		icon_state = "autoinjector-6"

/obj/item/reagent_containers/hypospray/autoinjector/pain //made for debugging
	name = "液态痛苦自动注射器"
	desc = "一种装有液态痛苦的自动注射器. 哎哟."
	icon_state = "autoinjector-6"
	amount_per_transfer_from_this = 20
	volume = 100
	list_reagents = list(/datum/reagent/toxin/pain = 100)

/obj/item/reagent_containers/hypospray/autoinjector/spacedrugs //CL goodie
	name = "太空毒品自动注射器"
	desc = "一种装有甜甜的,甜甜的太空毒品的自动注射器... 作为陆战队员很难搞到."
	icon_state = "autoinjector-1"
	amount_per_transfer_from_this = 25
	volume = 25
	list_reagents = list(/datum/reagent/space_drugs = 25)

/obj/item/reagent_containers/hypospray/autoinjector/mindbreaker //made for debugging
	name = "碎心毒素自动注射器"
	desc = "一种装有最烈,最致命毒品的自动注射器. 可能治愈创伤后应激障碍. 也可能导致它."
	icon_state = "Toxic"
	amount_per_transfer_from_this = 30
	volume = 30
	list_reagents = list(/datum/reagent/toxin/mindbreaker = 30)

/obj/item/reagent_containers/hypospray/autoinjector/yautja
	name = "不寻常的晶体"
	desc = "一种奇怪的发光晶体,一端带有尖刺."
	icon = 'icons/obj/hunter/pred_gear.dmi'
	icon_state = "crystal"
	worn_icon_state = ""
	amount_per_transfer_from_this = REAGENTS_OVERDOSE
	volume = REAGENTS_OVERDOSE
	list_reagents = list(/datum/reagent/thwei = REAGENTS_OVERDOSE)

/obj/item/reagent_containers/hypospray/autoinjector/yautja/attack(mob/M, mob/user)
	if(HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		..()
	else
		to_chat(user, span_danger("你不知道该往[src]哪里注射."))

/obj/item/reagent_containers/hypospray/autoinjector/yautja/interact(mob/user)
	return

/obj/item/reagent_containers/hypospray/autoinjector/regrow
	name = "再生自动注射器"
	desc = "一种装有再生的自动注射器 - 能够快速再生缺失的肢体."
	icon_state = "AngelLight"
	amount_per_transfer_from_this = 5
	list_reagents = list(
		/datum/reagent/medicine/regrow = 30,
	)
	description_overlay = "Grw"
