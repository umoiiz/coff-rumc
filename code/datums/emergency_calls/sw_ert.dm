////////////////////////////////////////////////////////////////////////////////
// ЕРТ звёздных войн
////////////////////////////////////////////////////////////////////////////////

/// Shared helper: mind transfer + backstory print used by all SW ERTs
/datum/emergency_call/sw/proc/finish_spawn(datum/mind/M, mob/living/carbon/human/H)
	var/mob/original = M.current
	M.transfer_to(H, TRUE)
	H.fully_replace_character_name(M.name, H.real_name)
	if(original)
		qdel(original)
	print_backstory(H)

////////////////////////////////////////////////////////////////////////////////
// 1) Повстанцы - CLF но в обёртке ЗВ
////////////////////////////////////////////////////////////////////////////////

/datum/emergency_call/sw/rebels
	name = "Rebel Alliance Squad"
	base_probability = 10
	alignement_factor = 1 // hostile like CLF
	mob_min = 3
	mob_max = 10

/datum/emergency_call/sw/rebels/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是反抗联盟的一名士兵,是非正规部队的成员,在暴政出现的任何地方与之战斗.</B>")
	to_chat(H, "<B>来自[SSmapping.configs[SHIP_MAP].map_name]的求救信号已传达到你的小队. 消灭帝国的盟友.</B>")

/datum/emergency_call/sw/rebels/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = .
	finish_spawn(M, H)
	if(!leader)
		leader = H
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/rebel/officer))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты командуешь этой группой повстанцев. За Альянс! За свободу!")]</p>")
		return
	if(medics < max_medics)
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/rebel/medic))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты медик повстанцев, прикрепленный к этой группе.")]</p>")
		medics++
		return
	H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/rebel))
	to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты солдат повстанцев, откликнувшийся на сигнал бедствия.")]</p>")

////////////////////////////////////////////////////////////////////////////////
// 2) Клоны фазы 1 времён Республики
////////////////////////////////////////////////////////////////////////////////

/datum/emergency_call/sw/clone_basic
	name = "Clone Basic Squad"
	base_probability = 8
	alignement_factor = -1 // TerraGov-aligned
	mob_min = 9
	mob_max = 15
	var/engineers = 0
	var/max_engineers = 1
	var/mps = 0
	var/max_mps = 2
	var/pilots = 0
	var/max_pilots = 1

/datum/emergency_call/sw/clone_basic/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是共和国大军团的克隆人士兵.</B>")
	to_chat(H, "<B>你的指挥部收到了来自[SSmapping.configs[SHIP_MAP].map_name]的求救信号. 帮助共和国的盟友.</B>")
	to_chat(H, "<B>好士兵服从命令.</B>")

/datum/emergency_call/sw/clone_basic/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = .
	finish_spawn(M, H)
	if(!leader)
		leader = H
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/clone/lieutenant))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты лейтенант этой группы клонов.")]</p>")
		return
	if(engineers < max_engineers)
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/clone/engineer))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты инженер этой группы.")]</p>")
		engineers++
		return
	if(pilots < max_pilots)
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/clone/pilot))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты пилот этой группы с навыками медицинской помощи.")]</p>")
		pilots++
		return
	if(mps < max_mps)
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/clone/mp))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты ветеран этой группы.")]</p>")
		mps++
		return
	H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/clone/trooper))
	to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты солдат этой группы и самой Республики.")]</p>")

////////////////////////////////////////////////////////////////////////////////
// 3) Клоны фазы 2 времён Республики
////////////////////////////////////////////////////////////////////////////////

/datum/emergency_call/sw/clone_mk2
	name = "Clone Basic Mk.II Squad"
	base_probability = 7
	alignement_factor = -1
	mob_min = 8
	mob_max = 14
	var/artillery = 0
	var/max_artillery = 1
	var/mps = 0
	var/max_mps = 2
	var/sgts = 0
	var/max_sgts = 1

/datum/emergency_call/sw/clone_mk2/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是第二阶段克隆人士兵.</B>")
	to_chat(H, "<B>登陆[SSmapping.configs[SHIP_MAP].map_name]并保护共和国的盟友免受敌人侵害.</B>")

/datum/emergency_call/sw/clone_mk2/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = .
	finish_spawn(M, H)
	if(!leader)
		leader = H
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/clone_mk2/captain))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты капитан этой группы клонов.")]</p>")
		return
	if(artillery < max_artillery)
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/clone_mk2/artillery))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты артиллерист-инженер этой группы.")]</p>")
		artillery++
		return
	if(sgts < max_sgts)
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/clone_mk2/sgt))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты сержант этой группы с навыками медицинской помощи.")]</p>")
		sgts++
		return
	if(mps < max_mps)
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/clone_mk2/mp))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты ветеран этой группы.")]</p>")
		mps++
		return
	H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/clone_mk2/trooper))
	to_chat(H, span_notice("你是该小组和共和国的第二阶段士兵."))

////////////////////////////////////////////////////////////////////////////////
// 4) 501 легион
////////////////////////////////////////////////////////////////////////////////

/datum/emergency_call/sw/legion501
	name = "501st Legion Detachment"
	base_probability = 5
	alignement_factor = -1
	mob_min = 7
	mob_max = 12
	var/radiotechs = 0
	var/max_radiotechs = 1

/datum/emergency_call/sw/legion501/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是501军团的士兵 - 最高指挥官之拳.</B>")
	to_chat(H, "<B>你的指挥部收到了来自[SSmapping.configs[SHIP_MAP].map_name]的求救信号. 帮助共和国的盟友.</B>")

/datum/emergency_call/sw/legion501/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = .
	finish_spawn(M, H)
	if(!leader)
		leader = H
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/legion501/commander))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты командир 501 легиона.")]</p>")
		return
	if(radiotechs < max_radiotechs)
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/legion501/radiotech))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты радиотехник 501 легиона. У себя в сумке есть дрон на радиоуправлении. Используй его для помощи отряду.")]</p>")
		radiotechs++
		return
	H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/legion501/trooper))
	to_chat(H, span_notice("你是501军团的士兵."))

////////////////////////////////////////////////////////////////////////////////
// 5) 212 батальон
////////////////////////////////////////////////////////////////////////////////

/datum/emergency_call/sw/battalion212
	name = "212th Battalion Detachment"
	base_probability = 5
	alignement_factor = -1
	mob_min = 6
	mob_max = 12

/datum/emergency_call/sw/battalion212/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是212营的士兵 - 由伟大的指挥官科迪创立的部队.</B>")
	to_chat(H, "<B>你的营收到了来自[SSmapping.configs[SHIP_MAP].map_name]的求救信号.</B>")
	to_chat(H, "<B>指挥官已批准派遣营的一部分去帮助共和国的盟友.</B>")

/datum/emergency_call/sw/battalion212/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = .
	finish_spawn(M, H)
	if(!leader)
		leader = H
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/battalion212/commando))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты командир этой части 212 батальона.")]</p>")
		return
	H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/battalion212/trooper))
	to_chat(H, span_notice("你是212营的士兵."))

////////////////////////////////////////////////////////////////////////////////
// 6) 442 батальон
////////////////////////////////////////////////////////////////////////////////

/datum/emergency_call/sw/battalion442
	name = "442nd Siege Battalion Detachment"
	base_probability = 4
	alignement_factor = -1
	mob_min = 6
	mob_max = 12

/datum/emergency_call/sw/battalion442/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你服役于442营 - 围攻专家.</B>")
	to_chat(H, "<B>指挥部收到了来自飞船[SSmapping.configs[SHIP_MAP].map_name]的求救信号. 保护共和国的盟友.</B>")

/datum/emergency_call/sw/battalion442/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = .
	finish_spawn(M, H)
	if(!leader)
		leader = H
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/battalion442/commando))
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты командир 442 батальона.")]</p>")
		return
	H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/battalion442/trooper))
	to_chat(H, span_notice("你是442营的士兵."))

////////////////////////////////////////////////////////////////////////////////
// 7) Гвардия Сената
////////////////////////////////////////////////////////////////////////////////

/datum/emergency_call/sw/senateguard
	name = "Senate Guard Detachment"
	base_probability = 3
	alignement_factor = -1
	mob_min = 2
	mob_max = 6

/datum/emergency_call/sw/senateguard/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是议会卫队 - 共和国要员的精英护卫.</B>")
	to_chat(H, "<B>撤离或确保[SSmapping.configs[SHIP_MAP].map_name]上VIP人员的安全. 没人能阻挡你.</B>")

/datum/emergency_call/sw/senateguard/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = .
	finish_spawn(M, H)
	if(!leader)
		leader = H
	H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/senateguard))
	to_chat(H, "<p style='font-size:1.5em'>[span_notice("Ты Гвардеец Сената.")]</p>")

////////////////////////////////////////////////////////////////////////////////
// 8) Штурмовики времён Империи
////////////////////////////////////////////////////////////////////////////////

/datum/emergency_call/sw/stormtroopers
	name = "Imperial Stormtrooper Squad"
	base_probability = 8
	alignement_factor = 1 // VSD / hostile to TGMC
	mob_min = 10
	mob_max = 16
	var/airborne = 0
	var/max_airborne = 2
	var/radiomen = 0
	var/max_radiomen = 1

/datum/emergency_call/sw/stormtroopers/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你为银河帝国效力. 秩序将得到维持. 必要时以武力维持.</B>")
	to_chat(H, "<B>抵达[SSmapping.configs[SHIP_MAP].map_name]并消灭帝国的敌人.</B>")

/datum/emergency_call/sw/stormtroopers/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = .
	finish_spawn(M, H)
	if(!leader)
		leader = H
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/stormtrooper/officer))
		to_chat(H, "<p style='font-size:1.5em'>[span_danger("Ты командир этого отряда. Да здравствует Империя!")]</p>")
		return
	if(medics < max_medics)
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/stormtrooper/surgeon))
		to_chat(H, "<p style='font-size:1.5em'>[span_danger("Ты полевой имперский медик.")]</p>")
		medics++
		return
	if(radiomen < max_radiomen)
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/stormtrooper/radio))
		to_chat(H, "<p style='font-size:1.5em'>[span_danger("Ты имперский инженер.")]</p>")
		radiomen++
		return
	if(airborne < max_airborne)
		H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/stormtrooper/airborne))
		to_chat(H, "<p style='font-size:1.5em'>[span_danger("Ты элитный имперский штурмовик.")]</p>")
		airborne++
		return
	H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/stormtrooper/standard))
	to_chat(H, span_danger("你是帝国冲锋队员."))

////////////////////////////////////////////////////////////////////////////////
// 9) Красная (Алая) Гвардия
////////////////////////////////////////////////////////////////////////////////

/datum/emergency_call/sw/redguard
	name = "Imperial Royal Guard Detachment"
	base_probability = 3
	alignement_factor = 1
	mob_min = 2
	mob_max = 6

/datum/emergency_call/sw/redguard/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你是猩红卫队, 皇帝意志的绯红之影.</B>")
	to_chat(H, "<B>在[SSmapping.configs[SHIP_MAP].map_name]上俘获VIP人员并撤离他们. 不留活口.</B>")

/datum/emergency_call/sw/redguard/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = .
	finish_spawn(M, H)
	if(!leader)
		leader = H
	H.apply_assigned_role_to_spawn(SSjob.GetJobType(/datum/job/sw/ert/redguard))
	to_chat(H, "<p style='font-size:1.5em'>[span_danger("Ты - член Алой Стражи.")]</p>")
