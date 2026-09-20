
//Not to be confused with /obj/item/reagent_containers/food/drinks/bottle

/obj/item/reagent_containers/glass/bottle
	name = "瓶子"
	desc = "一个小瓶子."
	icon = 'icons/obj/items/chemistry.dmi'
	icon_state = null
	worn_icon_state = "bottle"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,25,30,60,120,240)
	volume = 240
	attack_speed = 4

/obj/item/reagent_containers/glass/bottle/on_reagent_change()
	update_icon()

/obj/item/reagent_containers/glass/bottle/pickup(mob/user)
	..()
	update_icon()

/obj/item/reagent_containers/glass/bottle/dropped(mob/user)
	..()
	update_icon()

/obj/item/reagent_containers/glass/bottle/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	update_icon()

/obj/item/reagent_containers/glass/bottle/Initialize(mapload)
	. = ..()
	if(!icon_state)
		icon_state = "bottle-[rand(1, 5)]"

/obj/item/reagent_containers/glass/bottle/update_overlays()
	. = ..()

	if(reagents?.total_volume && (icon_state == "bottle-1" || icon_state == "bottle-2" || icon_state == "bottle-3" || icon_state == "bottle-4")) //only for those who have reagentfillings icons
		var/image/filling = image('icons/obj/reagentfillings.dmi', src, "[icon_state]10")

		var/percent = round((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0 to 9)
				filling.icon_state = "[icon_state]--10"
			if(10 to 24)
				filling.icon_state = "[icon_state]-10"
			if(25 to 49)
				filling.icon_state = "[icon_state]-25"
			if(50 to 74)
				filling.icon_state = "[icon_state]-50"
			if(75 to 79)
				filling.icon_state = "[icon_state]-75"
			if(80 to 90)
				filling.icon_state = "[icon_state]-80"
			if(91 to INFINITY)
				filling.icon_state = "[icon_state]-100"

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		. += filling

	if(!is_open_container())
		var/image/lid = image(icon, src, "lid_bottle")
		. += lid

/obj/item/reagent_containers/glass/bottle/empty //Because the parent has RNG icon_state
	icon_state = "bottle-1" //Same one when you make a bottle in the chem master

/obj/item/reagent_containers/glass/bottle/inaprovaline
	name = "\improper 英诺普拉文瓶"
	desc = "一个小瓶子. 含有英诺普拉文 - 用于稳定病人."
	icon_state = "bottle19"
	list_reagents = list(/datum/reagent/medicine/inaprovaline = 240)

/obj/item/reagent_containers/glass/bottle/kelotane
	name = "\improper 凯洛坦瓶"
	desc = "一个小瓶子. 含有凯洛坦 - 用于治疗烧伤部位."
	icon_state = "bottle15"
	list_reagents = list(/datum/reagent/medicine/kelotane = 240)

/obj/item/reagent_containers/glass/bottle/dexalin
	name = "\improper 地塞林瓶"
	desc = "一个小瓶子. 含有地塞林 - 用于为血液供氧."
	icon_state = "bottle10"
	list_reagents = list(/datum/reagent/medicine/dexalin = 240)

/obj/item/reagent_containers/glass/bottle/spaceacillin
	name = "\improper 太空西林瓶"
	desc = "一个小瓶子. 含有太空西林 - 用于治疗感染伤口."
	icon_state = "bottle8"
	list_reagents = list(/datum/reagent/medicine/spaceacillin = 240)

/obj/item/reagent_containers/glass/bottle/toxin
	name = "毒素瓶"
	desc = "一小瓶毒素. 不要喝, 有毒."
	icon_state = "bottle12"
	list_reagents = list(/datum/reagent/toxin = 240)

/obj/item/reagent_containers/glass/bottle/cyanide
	name = "氰化物瓶"
	desc = "一小瓶氰化物. 苦杏仁味?"
	icon_state = "bottle12"
	list_reagents = list(/datum/reagent/toxin/cyanide = 240)

/obj/item/reagent_containers/glass/bottle/sleeptoxin
	name = "安眠瓶"
	desc = "一小瓶安眠药. 光是闻气味就让你昏昏欲睡."
	icon_state = "bottle20"
	list_reagents = list(/datum/reagent/toxin/sleeptoxin = 240)

/obj/item/reagent_containers/glass/bottle/chloralhydrate
	name = "水合氯醛瓶"
	desc = "一小瓶水合氯醛. 米奇的最爱!"
	icon_state = "bottle20"
	list_reagents = list(/datum/reagent/toxin/chloralhydrate = 240)

/obj/item/reagent_containers/glass/bottle/dylovene
	name = "地洛文瓶"
	desc = "一小瓶地洛文. 用于对抗毒素. 基本上是一种抗毒剂."
	icon_state = "bottle16"
	list_reagents = list(/datum/reagent/medicine/dylovene = 240)

/obj/item/reagent_containers/glass/bottle/mutagen
	name = "不稳定诱变剂瓶"
	desc = "一小瓶不稳定诱变剂. 会随机改变接触者的DNA结构."
	icon_state = "bottle7"
	list_reagents = list(/datum/reagent/toxin/mutagen = 240)

/obj/item/reagent_containers/glass/bottle/ammonia
	name = "氨水瓶"
	desc = "一小瓶氨水. 一种无色气体, 具有刺鼻气味."
	icon_state = "bottle20"
	list_reagents = list(/datum/reagent/ammonia = 240)

/obj/item/reagent_containers/glass/bottle/diethylamine
	name = "二乙胺瓶"
	desc = "一小瓶二乙胺. 一种从氨和乙醇中获得的有机化合物."
	icon_state = "bottle17"
	list_reagents = list(/datum/reagent/diethylamine = 240)


/obj/item/reagent_containers/glass/bottle/pacid
	name = "聚三硝酸瓶"
	desc = "一个小瓶子。含有少量聚三氟乙酸"
	icon_state = "bottle17"
	list_reagents = list(/datum/reagent/toxin/acid/polyacid = 240)

/obj/item/reagent_containers/glass/bottle/adminordrazine
	name = "\improper 神之腺素瓶"
	desc = "一个小瓶子。含有众神的液体精华。"
	icon = 'icons/obj/items/drinks.dmi'
	icon_state = "holyflask"
	list_reagents = list(/datum/reagent/medicine/adminordrazine = 240)

/obj/item/reagent_containers/glass/bottle/capsaicin
	name = "\improper 辣椒素瓶"
	desc = "一个小瓶子。含有辣酱。"
	icon_state = "bottle3"
	list_reagents = list(/datum/reagent/consumable/capsaicin = 240)

/obj/item/reagent_containers/glass/bottle/frostoil
	name = "\improper 霜油瓶"
	desc = "一个小瓶子。含有冷酱。"
	icon_state = "bottle17"
	list_reagents = list(/datum/reagent/consumable/frostoil = 240)

/obj/item/reagent_containers/glass/bottle/bicaridine
	name = "\improper 比卡瑞定瓶"
	desc = "一个小瓶子。含有比卡瑞定 - 医生用于治疗钝击伤害。"
	icon_state = "bottle3"
	list_reagents = list(/datum/reagent/medicine/bicaridine = 240)

/obj/item/reagent_containers/glass/bottle/tramadol
	name = "\improper 曲马多瓶"
	desc = "一个小瓶子。含有曲马多 - 用作基础止痛药。"
	icon_state = "bottle18"
	volume = 240
	list_reagents = list(/datum/reagent/medicine/tramadol = 240)

/obj/item/reagent_containers/glass/bottle/combatmix
	name = "\improper 战斗混合瓶"
	desc = "一个小瓶子。上面有个标签写着 BKTT 80:80:40:40。"
	icon_state = "bottle14"
	volume = 240
	list_reagents = list(
		/datum/reagent/medicine/bicaridine = 80,
		/datum/reagent/medicine/kelotane = 80,
		/datum/reagent/medicine/tramadol = 40,
		/datum/reagent/medicine/tricordrazine = 40,
	)

/obj/item/reagent_containers/glass/bottle/oxycodone
	name = "\improper 羟考酮瓶"
	desc = "一个非常小的瓶子。含有羟考酮 - 用作极端止痛药。"
	icon_state = "bottle2"
	volume = 240
	list_reagents = list(/datum/reagent/medicine/oxycodone = 240)

/obj/item/reagent_containers/glass/bottle/hypervene
	name = "\improper 海波维恩瓶"
	desc = "一个非常小的瓶子。含有海波维恩 - 一种用于冲刷毒素的净化化学物质。会引起疼痛和呕吐。"
	icon_state = "bottle3"
	volume = 120
	list_reagents = list(/datum/reagent/hypervene = 120)

/obj/item/reagent_containers/glass/bottle/tricordrazine
	name = "\improper 三科德拉嗪瓶"
	desc = "一个小瓶子。含有三科德拉嗪 - 用作通用的伤势治疗药物。"
	icon_state = "bottle-5"
	list_reagents = list(/datum/reagent/medicine/tricordrazine = 240)

/obj/item/reagent_containers/glass/bottle/paracetamol
	name = "\improper 对乙酰氨基酚瓶"
	desc = "一个小瓶子。含有对乙酰氨基酚 - 一种温和、简单的止痛药,适合忍受繁重劳动。"
	icon_state = "bottle-1"
	list_reagents = list(/datum/reagent/medicine/paracetamol = 240)

/obj/item/reagent_containers/glass/bottle/isotonic
	name = "\improper 生理盐水-葡萄糖瓶"
	desc = "一个小瓶子。含有生理盐水-葡萄糖,也称为等渗液 - 用于帮助身体恢复血液。"
	icon_state = "bottle-1"
	list_reagents = list(/datum/reagent/medicine/saline_glucose = 240)

/obj/item/reagent_containers/glass/bottle/meralyne
	name = "\improper 梅拉林瓶"
	desc = "一个小瓶子。含有梅拉林 - 用作对抗钝击伤害的强效治疗药物。"
	icon_state = "bottle14"
	list_reagents = list(/datum/reagent/medicine/meralyne = 240)

/obj/item/reagent_containers/glass/bottle/dermaline
	name = "\improper 德玛林瓶"
	desc = "一个小瓶子。含有德玛林 - 用作对抗烧伤的强效治疗药物。"
	icon_state = "bottle15"
	list_reagents = list(/datum/reagent/medicine/dermaline = 240)

/obj/item/reagent_containers/glass/bottle/meraderm
	name = "\improper 梅拉德姆瓶"
	desc = "一个小瓶子。含有梅拉林和德玛林 - 用作对抗物理伤害的强效治疗药物。"
	icon_state = "bottle19"
	volume = 60
	list_reagents = list(/datum/reagent/medicine/dermaline = 30, /datum/reagent/medicine/meralyne = 30)

/obj/item/reagent_containers/glass/bottle/nanoblood
	name = "\improper 纳米血瓶"
	desc = "一个小瓶子。含有纳米血 - 用于治疗大量失血。"
	icon_state = "bottle3"
	volume = 60
	list_reagents = list(/datum/reagent/medicine/nanoblood = 60)

/obj/item/reagent_containers/glass/bottle/polyhexanide
	name = "\improper 聚六亚甲基双胍瓶"
	desc = "一个小瓶子。含有聚六亚甲基双胍 - 用作内部手术使用的强力消毒剂。"
	icon_state = "bottle2"
	list_reagents = list(/datum/reagent/medicine/polyhexanide = 240)

/obj/item/reagent_containers/glass/bottle/lemoline
	name = "\improper 柠檬素瓶"
	desc = "一个小瓶子。含有10单位柠檬素,一种用于制造高级药物的试剂。"
	icon_state = "bottle-5"
	list_reagents = list(/datum/reagent/medicine/lemoline = 10)

/obj/item/reagent_containers/glass/bottle/lemoline/doctor
	desc = "一个小瓶子。含有30单位柠檬素,一种用于制造高级药物的试剂。"
	list_reagents = list(/datum/reagent/medicine/lemoline = 30)

/obj/item/reagent_containers/glass/bottle/doctor_delight
	name = "\improper 医生的喜悦瓶"
	desc = "一个小瓶子。含有医生的喜悦。"
	icon_state = "bottle3"
	volume = 120
	list_reagents = list(/datum/reagent/consumable/doctor_delight = 120)

/obj/item/reagent_containers/glass/bottle/medicalnanites
	name = "\improper 纳米机器瓶"
	desc = "一个小瓶子。含有为医疗用途改造的纳米机器,一种利用受试者血液进行繁殖的强效新型治疗方法,具有短暂但可能危险的激活期!"
	icon_state = "bottle7"
	volume = 30
	list_reagents = list(/datum/reagent/medicalnanites = 30)
