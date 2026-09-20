/obj/item/implant/skill/combat
	name = "战斗植入物"
	desc = "一系列提升战斗技能的植入物之一"
	icon_state = "combat_implant"
	allowed_limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)

/obj/item/implant/skill/combat/firearms
	name = "瞄准辅助植入系统"
	desc = "集成瞄准辅助系统! 更新武器技能!"
	firearms = 1
	pistols = 1
	shotguns = 1
	rifles = 1
	smgs = 1
	heavy_weapons = 1
	max_skills = list(
		SKILL_FIREARMS = SKILL_FIREARMS_TRAINED,
		SKILL_PISTOLS = SKILL_PISTOLS_TRAINED,
		SKILL_SMGS = SKILL_SMGS_TRAINED,
		SKILL_RIFLES = SKILL_RIFLES_TRAINED,
		SKILL_SHOTGUNS = SKILL_SHOTGUNS_TRAINED,
		SKILL_HEAVY_WEAPONS = SKILL_HEAVY_WEAPONS_TRAINED
	)

/obj/item/implant/skill/combat/melee
	name = "近战格斗法典植入系统"
	desc = "集成打击辅助系统! 更新近战技能!"
	melee_weapons = 1
	max_skills = list(SKILL_MELEE_WEAPONS = SKILL_MELEE_TRAINED)

/obj/item/implant/skill/codex
	name = "CODEX植入物"
	desc = "一系列增加基础知识的植入物之一"
	icon_state = "support_implant"
	allowed_limbs = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)

/obj/item/implant/skill/codex/medical
	name = "医疗技术植入系统"
	desc = "一个紧凑的装置, 每次你逆时针缠绷带时都会在你心脏旁边电击你! 更新医疗技能!"
	medical = 1
	max_skills = list(SKILL_MEDICAL = SKILL_MEDICAL_COMPETENT)

/obj/item/implant/skill/codex/surgery
	name = "手术辅助系统"
	desc = "得益于可靠的肩关节悬吊, 补偿帕金森综合征引起的手部颤抖! 更新手术技能!"
	surgery = 1
	max_skills = list(SKILL_SURGERY = SKILL_SURGERY_PROFESSIONAL)

/obj/item/implant/skill/codex/engineer
	name = "工程植入系统"
	desc = "焊接工作变得容易多了! 更新工程技能!"
	engineer = 1
	max_skills = list(SKILL_ENGINEER = SKILL_ENGINEER_EXPERT)

/obj/item/implant/skill/codex/construct
	name = "建造植入系统"
	desc = "焊接工作变得容易多了! 更新建造技能!"
	construction = 1
	max_skills = list(SKILL_CONSTRUCTION = SKILL_CONSTRUCTION_EXPERT)

/obj/item/implant/skill/tactical
	name = "战术植入物"
	desc = "一系列增加战斗战术知识的植入物之一"
	icon_state = "skill_implant"
	allowed_limbs = list(BODY_ZONE_HEAD)

/obj/item/implant/skill/tactical/leadership
	name = "指挥协议 'Graiyor' 法典"
	desc = "将高级激励和说服助记术的知识上传至大脑, 让周围的人更加心甘情愿地挡子弹! 更新领导技能!"
	icon_state = "leadership_implant"
	leadership = 1
	max_skills = list(SKILL_LEADERSHIP = SKILL_LEAD_SUPER)

/obj/item/implant/hud/medical
	name = "医疗HUD植入物"
	desc = "一种专用微芯片, 连接到视神经并将医疗扫描仪HUD直接投射到使用者的视野中."
	icon_state = "skill_implant"
	allowed_limbs = list(BODY_ZONE_HEAD)

	hud_type = DATA_HUD_MEDICAL_ADVANCED
	hud_active = TRUE
