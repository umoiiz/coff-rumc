//skill modifying item
/obj/item/pamphlet
	name = "通用小册子"
	desc = "你不应该看到这个"
	icon = 'icons/obj/items/paper.dmi'
	icon_state = "paper_words"
	w_class = WEIGHT_CLASS_TINY
	var/cqc
	var/melee_weapons
	var/firearms
	var/pistols
	var/shotguns
	var/rifles
	var/smgs
	var/heavy_weapons
	var/smartgun
	var/engineer
	var/construction
	var/leadership
	var/medical
	var/surgery
	var/pilot
	var/police
	var/powerloader
	var/large_vehicle
	var/mech_pilot
	var/stamina

	///assoc list list(SKILL = MAXIMUM_INT) for when we dont want to let them read this
	var/list/max_skills

/obj/item/pamphlet/attack_self(mob/living/user)
	. = ..()
	for(var/skill in max_skills)
		if(user.skills.getRating(skill) >= max_skills[skill])
			balloon_alert(user, "没什么可学的!")
			return
	if(!do_after(user, 5 SECONDS, NONE, user))
		return
	user.set_skills(user.skills.modifyRating(cqc, melee_weapons, firearms, pistols, shotguns, rifles, smgs, heavy_weapons, smartgun,\
	engineer, construction, leadership, medical, surgery, pilot, police, powerloader, large_vehicle, mech_pilot, stamina))
	user.temporarilyRemoveItemFromInventory(src)
	qdel(src)

/obj/item/pamphlet/tank_loader
	name = "装填手操作手册"
	desc = "一幅粗糙的图画,描绘的似乎是在给坦克炮装弹.那是蜡笔画吗?"
	large_vehicle = 1
	max_skills = list(SKILL_LARGE_VEHICLE = SKILL_LARGE_VEHICLE_TRAINED)

/obj/item/pamphlet/tank_crew
	name = "坦克乘员操作手册"
	desc = "傻瓜式坦克操作指南."
	large_vehicle = 3
	max_skills = list(SKILL_LARGE_VEHICLE = SKILL_LARGE_VEHICLE_VETERAN)
