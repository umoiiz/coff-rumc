/obj/item/attachable/suppressor
	name = "消音器"
	desc = "一个带有排气孔的小管,用于排出噪音和气体。\nDoes不能完全使武器静音,但确实能让它安静得多,并且稍微提高精准度和稳定性。"
	icon_state = "suppressor"
	slot = ATTACHMENT_SLOT_MUZZLE
	silence_mod = TRUE
	pixel_shift_y = 16
	attach_shell_speed_mod = -0.5
	accuracy_mod = 0.1
	recoil_mod = -2
	scatter_mod = -2
	recoil_unwielded_mod = -3
	scatter_unwielded_mod = -2
	damage_falloff_mod = 0

/obj/item/attachable/suppressor/unremovable
	attach_features_flags = NONE

/obj/item/attachable/suppressor/unremovable/invisible
	icon_state = ""

/obj/item/attachable/suppressor/unremovable/invisible/Initialize(mapload, ...)
	. = ..()

/obj/item/attachable/bayonet
	name = "刺刀"
	desc = "用于安装在武器上的锋利刀刃。它可以用于手动刺击任何东西,但不能在伤害意图下使用。安装后会略微降低枪的精准度。"
	icon_state = "bayonet"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/melee_right.dmi',
	)
	force = 20
	throwforce = 10
	attach_delay = 10 //Bayonets attach/detach quickly.
	detach_delay = 10
	attack_verb = list("slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")
	melee_mod = 25
	slot = ATTACHMENT_SLOT_MUZZLE
	pixel_shift_x = 14 //Below the muzzle.
	pixel_shift_y = 18
	accuracy_mod = -0.05
	accuracy_unwielded_mod = -0.1
	size_mod = 1
	sharp = IS_SHARP_ITEM_ACCURATE
	variants_by_parent_type = list(/obj/item/weapon/gun/shotgun/pump/t35 = "bayonet_t35")

/obj/item/attachable/bayonet/screwdriver_act(mob/living/user, obj/item/I)
	to_chat(user, span_notice("你将刺刀改回战斗刀。"))
	if(loc == user)
		user.dropItemToGround(src)
	var/obj/item/weapon/combat_knife/knife = new(loc)
	user.put_in_hands(knife) //This proc tries right, left, then drops it all-in-one.
	if(knife.loc != user) //It ended up on the floor, put it whereever the old flashlight is.
		knife.forceMove(loc)
	qdel(src) //Delete da old bayonet

/obj/item/attachable/bayonetknife //todo: why the flying dicks is this not a subtype of above?
	name = "M-22刺刀"
	desc = "一把锋利的刀,是TerraGov陆战队的标准配发战斗刀,可以随意安装在各种武器上或作为标准刀具使用。"
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "bayonetknife"
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/melee_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/melee_right.dmi',
	)
	force = 25
	throwforce = 20
	throw_speed = 3
	throw_range = 6
	attack_speed = 8
	attach_delay = 10 //Bayonets attach/detach quickly.
	detach_delay = 10
	attack_verb = list("slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")
	melee_mod = 25
	slot = ATTACHMENT_SLOT_MUZZLE
	pixel_shift_x = 14 //Below the muzzle.
	pixel_shift_y = 18
	accuracy_mod = -0.05
	accuracy_unwielded_mod = -0.1
	size_mod = 1
	sharp = IS_SHARP_ITEM_ACCURATE
	variants_by_parent_type = list(/obj/item/weapon/gun/shotgun/pump/t35 = "bayonetknife_t35")

/obj/item/attachable/bayonetknife/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/scalping)
	AddElement(/datum/element/shrapnel_removal, 12 SECONDS, 12 SECONDS, 10)

/obj/item/attachable/melee_attack_chain(mob/user, atom/target, params, rightclick)
	if(target == user && !user.do_self_harm)
		return
	return ..()

/obj/item/attachable/bayonetknife/som
	name = "\improper S20 SOM刺刀"
	desc = "一把大型刀具,是SOM的标准配发战斗刀。可以随意安装在各种武器上或作为标准刀具使用。"
	icon_state = "bayonetknife_som"
	worn_icon_state = "bayonetknife"
	force = 30

/obj/item/attachable/extended_barrel
	name = "加长枪管"
	desc = "加长的枪管由于增加了稳定性和冲击波暴露,能够减少散布、提高精准度和枪口初速。"
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "ebarrel"
	attach_shell_speed_mod = 1
	accuracy_mod = 0.15
	accuracy_unwielded_mod = 0.1
	scatter_mod = -1
	size_mod = 1
	variants_by_parent_type = list(
		/obj/item/weapon/gun/rifle/som = "ebarrel_big",
		/obj/item/weapon/gun/rifle/som_big = "ebarrel_big",
		/obj/item/weapon/gun/smg/som = "ebarrel_big",
		/obj/item/weapon/gun/shotgun/pump/t35 = "ebarrel_big",
	)

/obj/item/attachable/heavy_barrel
	name = "枪管加速器"
	desc = "一个安装在枪口上的枪管延长器,带有小型成型装药,能以更快的速度推动子弹。\nGreatly提高弹速并减少伤害衰减。"
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "hbarrel"
	attach_shell_speed_mod = 2
	accuracy_mod = -0.05
	damage_falloff_mod = -0.2

/obj/item/attachable/compensator
	name = "后坐力补偿器"
	desc = "一种枪口配件,通过将排出的气体向上导引来减少后坐力和散布。\nSignificantly减少后坐力和散布,无论武器是否双手持握。"
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "comp"
	pixel_shift_x = 17
	scatter_mod = -3
	recoil_mod = -2
	scatter_unwielded_mod = -3
	recoil_unwielded_mod = -2
	variants_by_parent_type = list(
		/obj/item/weapon/gun/rifle/som = "comp_big",
		/obj/item/weapon/gun/rifle/som_big = "comp_big",
		/obj/item/weapon/gun/smg/som = "comp_big",
		/obj/item/weapon/gun/shotgun/som = "comp_big",
		/obj/item/weapon/gun/shotgun/pump/t35 = "comp_big",
		/obj/item/weapon/gun/revolver/standard_magnum = "t76comp"
	)

/obj/item/attachable/sniperbarrel
	name = "狙击枪管"
	icon_state = "sniperbarrel"
	desc = "一根重型枪管。无法移除。"
	slot = ATTACHMENT_SLOT_MUZZLE
	attach_features_flags = NONE
	accuracy_mod = 0.15
	scatter_mod = -3

/obj/item/attachable/sr81
	name = "自动狙击枪管"
	icon_state = "t81barrel"
	desc = "一根重型枪管。无法移除。"
	slot = ATTACHMENT_SLOT_UNDER
	attach_features_flags = NONE
	pixel_shift_x = 7
	pixel_shift_y = 14
	accuracy_mod = 0
	scatter_mod = -1

/obj/item/attachable/smartbarrel
	name = "智能枪枪管"
	icon_state = "smartbarrel"
	desc = "一根重型旋转枪管。无法移除。"
	slot = ATTACHMENT_SLOT_MUZZLE
	attach_features_flags = NONE

/obj/item/attachable/focuslens
	name = "M43聚焦透镜"
	desc = "将光束导入一个专用透镜,使激光枪在过载时能使用致命的聚焦光束,使其更像一把高伤害狙击枪。"
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "focus"
	pixel_shift_x = 17
	pixel_shift_y = 13
	ammo_mod = /datum/ammo/energy/lasgun/m43/overcharge
	damage_mod = -0.15

/obj/item/attachable/widelens
	name = "M43宽幅透镜"
	desc = "将透镜分成三个,使激光枪在过载时能使用致命的近距离爆发,类似于传统的弹丸式霰弹枪射击。"
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "wide"
	pixel_shift_x = 18
	pixel_shift_y = 15
	ammo_mod = /datum/ammo/energy/lasgun/m43/blast
	damage_mod = -0.15

/obj/item/attachable/heatlens
	name = "M43热效透镜"
	desc = "改变激光的强度和频率。这会使你的目标着火,但代价是降低直接伤害和穿透力。"
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "heat"
	pixel_shift_x = 18
	pixel_shift_y = 16
	ammo_mod = /datum/ammo/energy/lasgun/m43/heat
	damage_mod = -0.15

/obj/item/attachable/efflens
	name = "M43高效透镜"
	desc = "使透镜更小更轻便,让激光枪能更高效地使用其能量。\nDecreases激光枪的能量输出。"
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "efficient"
	pixel_shift_x = 18
	pixel_shift_y = 14
	charge_mod = -5

/obj/item/attachable/sx16barrel
	name = "SX-16枪管"
	desc = "SX-16的标准枪管。无法移除。"
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "sx16barrel"
	attach_features_flags = NONE

/obj/item/attachable/pulselens
	name = "M43脉冲透镜"
	desc = "激发透镜,使激光枪能以高速率放电。\nAllows武器自动射击。"
	slot = ATTACHMENT_SLOT_MUZZLE
	icon_state = "pulse"
	pixel_shift_x = 18
	pixel_shift_y = 15
	damage_mod = -0.15
	gun_firemode_list_mod = list(GUN_FIREMODE_AUTOMATIC)

/obj/item/attachable/sgbarrel
	name = "SG-29枪管"
	icon_state = "sg29barrel"
	desc = "一根重型枪管。无法移除。"
	slot = ATTACHMENT_SLOT_MUZZLE
	attach_features_flags = NONE

/obj/item/attachable/t500_barrel
	name = "R-500加长枪管"
	desc = "给酷炫左轮手枪用的酷炫枪管。"
	slot = ATTACHMENT_SLOT_MUZZLE
	delay_mod = -0.4 SECONDS
	icon = 'icons/obj/items/attachments/attachments_64.dmi'
	icon_state = "barrel"
	attach_shell_speed_mod = 1
	accuracy_mod = 0.15
	accuracy_unwielded_mod = 0.1
	scatter_mod = -3
	scatter_unwielded_mod = 3
	recoil_unwielded_mod = 1
	pixel_shift_x = 0
	pixel_shift_y = 0

/obj/item/attachable/t500_barrel/short
	name = "R-500补偿器"
	desc = "给酷炫左轮手枪用的酷炫补偿器。"
	delay_mod = -0.2 SECONDS
	icon_state = "shortbarrel"
	attach_shell_speed_mod = 0
	scatter_mod = -2
	recoil_mod = -0.5
	scatter_unwielded_mod = -5
	recoil_unwielded_mod = -1
	accuracy_mod = 0
	accuracy_unwielded_mod = 0.15
