// Tools used for research
/obj/item/tool/research
	///Skill type needed to use the tool
	var/skill_type = SKILL_MEDICAL
	///Skill level needed to use the tool
	var/skill_threshold = SKILL_MEDICAL_EXPERT

/obj/item/tool/research/xeno_analyzer
	name = "异形分析仪"
	desc = "一种用于分析异形以获取研究材料的工具. 只需点击异形即可. 可用于与纽特交朋友."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_bonesaw"
	///List of rewards for each xeno tier
	var/static/list/xeno_tier_rewards = list(
		XENO_TIER_ZERO = list(
			/obj/item/research_resource/xeno/tier_one,
		),
		XENO_TIER_ONE = list(
			/obj/item/research_resource/xeno/tier_one,
		),
		XENO_TIER_TWO = list(
			/obj/item/research_resource/xeno/tier_two,
		),
		XENO_TIER_THREE = list(
			/obj/item/research_resource/xeno/tier_three,
		),
		XENO_TIER_FOUR = list(
			/obj/item/research_resource/xeno/tier_four,
		),
	)

/obj/item/tool/research/xeno_analyzer/attack(mob/living/M, mob/living/user)
	if(!isxeno(M))
		return ..()

	var/mob/living/carbon/xenomorph/target_xeno = M

	var/list/xeno_rewards = xeno_tier_rewards[target_xeno.tier]
	if(!xeno_rewards)
		balloon_alert(user, "无法研究")
		return ..()

	if(HAS_TRAIT(target_xeno, TRAIT_RESEARCHED))
		balloon_alert(user, "已探测过")
		return ..()

	if(user.skills.getRating(SKILL_MEDICAL) < SKILL_MEDICAL_EXPERT)
		user.balloon_alert_to_viewers("试图在[target_xeno]身上寻找弱点")
		var/fumbling_time = 15 SECONDS - 2 SECONDS * user.skills.getRating(SKILL_MEDICAL)
		if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED))
			return ..()
	user.balloon_alert_to_viewers("开始切割[target_xeno]")
	if(!do_after(user, 5 SECONDS, NONE, src, BUSY_ICON_FRIENDLY))
		return ..()

	if(HAS_TRAIT(target_xeno, TRAIT_RESEARCHED))
		balloon_alert(user, "已探测过")
		return ..()

	var/reward_typepath = pick(xeno_rewards)
	var/obj/reward = new reward_typepath
	reward.forceMove(get_turf(user))
	ADD_TRAIT(target_xeno, TRAIT_RESEARCHED, TRAIT_RESEARCHED)
	return ..()

/obj/item/tool/research/excavation_tool
	name = "地下扫描仪与挖掘机"
	desc = "一种用于定位和发掘地下资源的工具."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "alien_drill"

/obj/item/tool/research/excavation_tool/examine(mob/user)
	. = ..()
	. += span_danger("在挖掘点附近时在手中使用以开始挖掘.")

/obj/item/tool/research/excavation_tool/attack_self(mob/user)
	. = ..()
	if(user.skills.getRating(skill_type) < skill_threshold)
		balloon_alert(user, "技能不足")
		return
	balloon_alert_to_viewers("挖掘中...")
	if(!do_after(user, 10 SECONDS, NONE, user.loc, BUSY_ICON_GENERIC, BUSY_ICON_GENERIC, PROGRESS_BRASS))
		return

	for(var/obj/effect/landmark/excavation_site_spawner/spawner_to_check in urange(2, user.loc)) // doesn't work with range() for some reason?
		if(!spawner_to_check.rewards_typepath) // excavate only those that are set up
			continue
		spawner_to_check.excavate_site()
		balloon_alert(user, "找到了!")
		return

	balloon_alert(user, "没有可挖掘的东西!")
