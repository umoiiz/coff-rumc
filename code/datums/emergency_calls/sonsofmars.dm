//Sons of Mars
/datum/emergency_call/som
	name = "Sons of Mars Squad"
	base_probability = 26
	alignement_factor = 1
	///number of available special weapon dudes
	var/max_specialists = 1


/datum/emergency_call/som/print_backstory(mob/living/carbon/human/H)
	to_chat(H, "<B>你[pick("grew up in the mines working in horrible conditions until signing up to", "were part of a poor family until you decided to leave to join", "were born on a colony on Mars to a family of several brothers and sisters before leaving to", "worked at horrible conditions in the mines until deciding to leave to join")]火星之子(SoM)。</b>")
	to_chat(H, "<B>作为独立殖民地邦联(ICC)的成员国,成立于2180年的SoM是一个高度工业化的团体,拥有约200,000名现役或受训成员的常备军。</b>")
	to_chat(H, "<B>尽管ICC拥有独立于其成员国的自己的常备军,但大多数较大的成员国仍保留着自己的常备舰队和陆军,并拥有自己的装备和条令。</b>")
	to_chat(H, "")
	to_chat(H, "<B>今天,一艘TerraGov舰船[SSmapping.configs[SHIP_MAP].map_name]在[SSmapping.configs[GROUND_MAP].map_name]的轨道上发出了求救信号。这是我们不被拦截就发动攻击的机会!</b>")
	to_chat(H, "<B>消灭舰上的TerraGov人员,夺取这艘船。如果有ICC同僚部队,例如ICCAF,就与他们合作实现这一目标。不留俘虏。夺回曾经失去之物。</B>")

/datum/emergency_call/som/do_activate(announce = TRUE)
	max_specialists = round(mob_max * 0.2)
	return ..()

/datum/emergency_call/som/create_member(datum/mind/M)
	. = ..()
	if(!.)
		return

	var/mob/original = M.current
	var/mob/living/carbon/human/H = .

	M.transfer_to(H, TRUE)

	if(original)
		qdel(original)

	print_backstory(H)

	if(!leader)
		leader = H
		var/datum/job/J = SSjob.GetJobType(/datum/job/som/ert/leader)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a member of the Sons of Mars assigned to lead this fireteam to the TGMC distress signal sent out nearby. Lead your fireteam to top-working conidition!")]</p>")
		return
	if(medics < max_medics)
		var/datum/job/J = SSjob.GetJobType(/datum/job/som/ert/medic)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a Sons of Mars medic assigned to this fireteam to respond to the TGMC distress signal sent out nearby. Keep your squad alive in this fight!")]</p>")
		medics++
		return
	if(max_specialists > 0)
		var/datum/job/J = SSjob.GetJobType(/datum/job/som/ert/specialist)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a veteran of the Sons of Mars trusted with specialised weaponry. You are assigned to this fireteam to respond to the TGMC distress signal sent out nearby. Do them proud and kill all who stand in your teams way!")]</p>")
		max_specialists --
		return
	if(prob(65))
		var/datum/job/J = SSjob.GetJobType(/datum/job/som/ert/veteran)
		H.apply_assigned_role_to_spawn(J)
		to_chat(H, "<p style='font-size:1.5em'>[span_notice("You are a veteran of the Sons of Mars and are assigned to this fireteam to respond to the TGMC distress signal sent out nearby. Do them proud and kill all who stand in your teams way!")]</p>")
		return

	var/datum/job/J = SSjob.GetJobType(/datum/job/som/ert/standard)
	H.apply_assigned_role_to_spawn(J)
	to_chat(H, span_notice("你是火星之子的一员,被分配来组成这支火力小队,前去响应附近发出的TGMC求救信号。保护你自己和你的其他队员,杀死所有挡在你小队路上的人!"))
