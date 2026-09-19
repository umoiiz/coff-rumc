/datum/job/survivor
	title = "Generic Survivor"
	supervisors = "anyone who might rescue you"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS)
	minimal_access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS)
	display_order = JOB_DISPLAY_ORDER_SURVIVOR
	skills_type = /datum/skills/civilian/survivor
	faction = FACTION_TERRAGOV
	job_category = JOB_CAT_CIVILIAN
	selection_color = "#ffeedd"

/datum/job/survivor/after_spawn(mob/living/carbon/C, mob/M, latejoin = FALSE)
	. = ..()

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		C.equip_to_slot_or_del(new /obj/item/clothing/head/ushanka(C), SLOT_HEAD)
		C.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit(C), SLOT_WEAR_SUIT)
		C.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather(C), SLOT_WEAR_MASK)
		C.equip_to_slot_or_del(new /obj/item/clothing/shoes/snow(C), SLOT_SHOES)
		C.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(C), SLOT_GLOVES)

	var/weapons = pick(list(
		list(/obj/item/weapon/gun/smg/mp7, /obj/item/ammo_magazine/smg/mp7),
		list(/obj/item/weapon/gun/shotgun/double/sawn, /obj/item/ammo_magazine/handful/buckshot),
		list(/obj/item/weapon/gun/smg/uzi, /obj/item/ammo_magazine/smg/uzi),
		list(/obj/item/weapon/gun/smg/m25, /obj/item/ammo_magazine/smg/m25),
		list(/obj/item/weapon/gun/rifle/m16, /obj/item/ammo_magazine/rifle/m16),
		list(/obj/item/weapon/gun/shotgun/pump/bolt, /obj/item/ammo_magazine/rifle/bolt),
		list(/obj/item/weapon/gun/shotgun/pump/lever, /obj/item/ammo_magazine/packet/magnum),
	))
	var/obj/item/weapon/W = weapons[1]
	var/obj/item/ammo_magazine/A = weapons[2]
	C.equip_to_slot_or_del(new /obj/item/belt_harness(C), SLOT_BELT)
	C.put_in_hands(new W(C))
	C.equip_to_slot_or_del(new A(C), SLOT_IN_BACKPACK)
	C.equip_to_slot_or_del(new A(C), SLOT_IN_BACKPACK)
	C.equip_to_slot_or_del(new A(C), SLOT_IN_BACKPACK)
	C.equip_to_slot_or_del(new /obj/item/storage/ai2(C), SLOT_IN_BACKPACK)

	C.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding(C), SLOT_GLASSES)
	C.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/full(C), SLOT_R_STORE)
	C.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/full(C), SLOT_L_STORE)
	C.equip_to_slot_or_del(new /obj/item/weapon/combat_knife(C), SLOT_IN_BACKPACK)
	C.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/rugged(C), SLOT_HEAD)

	switch(SSmapping.configs[GROUND_MAP].map_name)
		if(MAP_PRISON_STATION)
			to_chat(M, span_notice("你是Fiorina轨道监狱袭击事件的幸存者. 你在监狱站工作或生活, 并设法避开了异形袭击...直到现在."))
		if(MAP_ICE_COLONY)
			to_chat(M, span_notice("你是冰封栖息地袭击事件的幸存者. 你在殖民地工作或生活, 并设法避开了异形袭击...直到现在."))
		if(MAP_BIG_RED)
			to_chat(M, span_notice("你是殖民地袭击事件的幸存者. 你在考古殖民地工作或生活, 并设法避开了异形袭击...直到现在."))
		if(MAP_LV_624)
			to_chat(M, span_notice("你是殖民地袭击事件的幸存者. 你怀疑出了什么问题并试图警告他人, 但为时已晚..."))
		if(MAP_ICY_CAVES)
			to_chat(M, span_notice("你是冰洞系统袭击事件的幸存者. 你在该地点工作或生活, 并设法避开了异形袭击...直到现在."))
		if(MAP_RESEARCH_OUTPOST)
			to_chat(M, span_notice("你是前哨站袭击事件的幸存者. 但你问自己: 你现在真的安全吗?"))
		if(MAP_MAGMOOR_DIGSITE)
			to_chat(M, span_notice("你是Magmoor挖掘场IV袭击事件的幸存者. 你在挖掘场工作或生活, 并设法避开了异形袭击...直到现在."))
		else
			to_chat(M, span_notice("凭借奇迹, 你设法在袭击中幸存下来. 但你现在真的安全吗?"))

/datum/job/survivor/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"无论你经历了什么, 你来到这里是为了生存并让自己获救.
如果你获救, 你会感激TerraGov和Nanotrasen的支援.
你对TGMC没有敌意, 也不应反对或破坏他们的目标, 除非管理员另有说明.
如果你在该地区发现任何其他幸存者, 与他们合作以提高你的生存机会.
根据你所从事的工作, 你可能拥有额外技能, 在需要时帮助他人.
祝你好运, 但不要指望能活下来."})

/datum/job/survivor/scientist
	title = "Scientist Survivor"
	skills_type = /datum/skills/civilian/survivor/scientist
	outfit = /datum/outfit/job/survivor/scientist

/datum/job/survivor/doctor
	title = "Doctor's Assistant Survivor"
	skills_type = /datum/skills/civilian/survivor/doctor
	outfit = /datum/outfit/job/survivor/doctor

/datum/job/survivor/liaison
	title = "Liaison Survivor"
	outfit = /datum/outfit/job/survivor/liaison

/datum/job/survivor/security
	title = "Security Guard Survivor"
	skills_type = /datum/skills/civilian/survivor/marshal
	outfit = /datum/outfit/job/survivor/security

/datum/job/survivor/civilian
	title = "Civilian Survivor"
	outfit = /datum/outfit/job/survivor/civilian

/datum/job/survivor/chef
	title = "Chef Survivor"
	skills_type = /datum/skills/civilian/survivor/chef
	outfit = /datum/outfit/job/survivor/chef

/datum/job/survivor/botanist
	title = "Botanist Survivor"
	outfit = /datum/outfit/job/survivor/botanist

/datum/job/survivor/atmos
	title = "Atmos Technician Survivor"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/survivor/atmos

/datum/job/survivor/chaplain
	title = "Chaplain Survivor"
	outfit = /datum/outfit/job/survivor/chaplain

/datum/job/survivor/miner
	title = "Miner Survivor"
	skills_type = /datum/skills/civilian/survivor/miner
	outfit = /datum/outfit/job/survivor/miner

/datum/job/survivor/salesman
	title = "Salesman Survivor"
	outfit = /datum/outfit/job/survivor/salesman

/datum/job/survivor/marshal
	title = "Colonial Marshal Survivor"
	skills_type = /datum/skills/civilian/survivor/marshal
	outfit = /datum/outfit/job/survivor/marshal

/datum/job/survivor/bartender
	title = "Bartender Survivor"
	outfit = /datum/outfit/job/survivor/bartender

/datum/job/survivor/chemist
	title = "Pharmacy Technician Survivor"
	skills_type = /datum/skills/civilian/survivor/scientist
	outfit = /datum/outfit/job/survivor/chemist

/datum/job/survivor/roboticist
	title = "Roboticist Survivor"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/survivor/roboticist

// Rambo Survivor - pretty overpowered, pls spawn with caution
/datum/job/survivor/rambo
	title = SURVIVOR
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/survivor/rambo
	job_flags = JOB_FLAG_ROUNDSTARTJOINABLE
	html_description = {"
		<b>Difficulty</b>: Astonishing<br /><br />
		<b>Gamemode Availability</b>: Distress Signal, Nuclear War<br /><br /><br />
		<b>Duty</b>: Survive with the resources you have against the swarms of xenomorphs intil help arrives.
	"}
	job_desc = "Выживайте теми ресурсами что у вас есть, пока не подоспеет помощь."
