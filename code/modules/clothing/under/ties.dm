/obj/item/clothing/tie
	name = "领带"
	desc = "一条新丝质夹式领带。"
	icon = 'icons/obj/clothing/ties.dmi'
	icon_state = "bluetie"
	equip_slot_flags = NONE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/tie/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/attachment, ATTACHMENT_SLOT_UNIFORM_TIE, 'icons/obj/clothing/ties_overlay.dmi', attach_features_flags = (ATTACH_REMOVABLE|ATTACH_APPLY_ON_MOB), attach_delay = 1.5 SECONDS, detach_delay = 1.5 SECONDS, mob_overlay_icon = 'icons/mob/ties.dmi')

/obj/item/clothing/tie/blue
	name = "蓝色领带"
	icon_state = "bluetie"

/obj/item/clothing/tie/red
	name = "红色领带"
	icon_state = "redtie"

/obj/item/clothing/tie/horrible
	name = "恶心领带"
	desc = "一条新丝质夹式领带。这条真恶心。"
	icon_state = "horribletie"

/obj/item/clothing/tie/stethoscope
	name = "听诊器"
	desc = "一种过时的医疗器具,用于聆听人体的声音。它还能让你看起来像知道自己在做什么。"
	icon_state = "stethoscope"

/obj/item/clothing/tie/stethoscope/attack(mob/living/carbon/human/M, mob/living/user)
	if(ishuman(M) && isliving(user))
		if(user.a_intent == INTENT_HELP)
			var/body_part = parse_zone(user.zone_selected)
			if(body_part)
				var/sound = "pulse"
				var/sound_strength

				if(M.stat == DEAD || HAS_TRAIT(M, TRAIT_FAKEDEATH))
					sound_strength = "cannot hear"
					sound = "anything"
				else
					sound_strength = "hear a weak"
					switch(body_part)
						if("chest")
							if(M.oxyloss < 50)
								sound_strength = "hear a healthy"
							sound = "pulse and respiration"
						if("eyes","mouth")
							sound_strength = "cannot hear"
							sound = "anything"
						else
							sound_strength = "hear a weak"

				user.visible_message("[user]将[src]贴在[M]的[body_part]上并专注地聆听。", "你将[src]贴在[M.p_their()]的[body_part]上。你[sound_strength][sound]。")
				return
	return ..(M, user)

//Medals
/obj/item/clothing/tie/medal
	name = "铜质奖章"
	desc = "一枚铜质奖章。"
	icon_state = "bronze"
	/// Name of the person this is awarded to.
	var/recipient_name
	var/recipient_rank
	var/medal_citation

/obj/item/clothing/tie/medal/examine(mob/user)
	. = ..()
	. += "Awarded to: \'[recipient_rank] [recipient_name]\'. The citation reads \'[medal_citation]\'."

/obj/item/clothing/tie/medal/conduct
	name = "杰出行为奖章"
	desc = "一枚因杰出行为而授予的铜质奖章。虽然是一项巨大的荣誉,但这是TGMC颁发的最基本的奖项。"

/obj/item/clothing/tie/medal/bronze_heart
	name = "铜心奖章"
	desc = "一枚因牺牲而授予的铜质心形奖章。它通常被追授,或因在执行任务中受重伤而授予。"
	icon_state = "bronze_heart"

/obj/item/clothing/tie/medal/silver
	name = "银质奖章"
	desc = "银质奖章."
	icon_state = "silver"

/obj/item/clothing/tie/medal/silver/valor
	name = "英勇奖章"
	desc = "授予表现异常英勇行为的银质奖章."

/obj/item/clothing/tie/medal/gold
	name = "金质奖章"
	desc = "一枚享有盛誉的金质奖章."
	icon_state = "gold"

/obj/item/clothing/tie/medal/gold/captain
	name = "舰长奖章"
	desc = "仅授予晋升至舰长军衔者的金质奖章.它象征着舰长对TGMC所肩负的成文职责,以及对其船员不容置疑的权威."

/obj/item/clothing/tie/medal/gold/heroism
	name = "杰出英雄主义奖章"
	desc = "一枚极为罕见的金质奖章,仅由TGMC颁发.获得此奖章是最高荣誉,因此存世极少."

/obj/item/clothing/tie/medal/letter/commendation
	name = "嘉奖信"
	desc = "一封印在卡纸上的信,通常写满了对收信人的赞扬."
	icon = 'icons/obj/items/paper.dmi'
	icon_state = "commendation"

//Armbands
/obj/item/clothing/tie/armband
	name = "红色臂章"
	desc = "一条华丽的红色臂章!"
	icon_state = "red"

/*
	Holobadges are worn on the belt or neck, and can be used to show that the holder is an authorized
	Security agent - the user details can be imprinted on the badge with a Security-access ID card
*/

/obj/item/clothing/tie/holobadge

	name = "全息徽章"
	desc = "这枚发光的蓝色徽章表明持有者是法律本身."
	icon_state = "holobadge"
	equip_slot_flags = ITEM_SLOT_BELT
	var/stored_name = null

/obj/item/clothing/tie/holobadge/cord
	icon_state = "holobadge-cord"
	equip_slot_flags = ITEM_SLOT_MASK

/obj/item/clothing/tie/holobadge/attack_self(mob/user as mob)
	if(!stored_name)
		to_chat(user, "在刷卡前挥舞徽章毫无意义.")
		return
	if(isliving(user))
		user.visible_message(span_warning("[user]展示了[user.p_their()]的TGMC内部安全合法授权徽章.\nIt写着:[stored_name],TGMC安全部门."),span_warning("你展示了你的TGMC内部安全合法授权徽章.\nIt写着:[stored_name],TGMC安全部门."))

/obj/item/clothing/tie/holobadge/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/card/id))
		var/obj/item/card/id/id_card = I

		if(!(ACCESS_MARINE_BRIG in id_card.access))
			to_chat(user, "[src]拒绝了你的权限不足.")
			return

		to_chat(user, "你将你的身份信息印在徽章上.")
		stored_name = id_card.registered_name
		name = "holobadge ([stored_name])"
		desc = "This glowing blue badge marks [stored_name] as THE LAW."

/obj/item/clothing/tie/holobadge/attack(mob/living/carbon/human/M, mob/living/user)
	if(isliving(user))
		user.visible_message(span_warning("[user]侵入[M]的私人空间,将[src]强行怼到[M.p_their()]脸上."), span_warning("你侵入[M]的私人空间,将[src]强行怼到[M.p_their()]脸上.你就是法律."))
