#define DROPSHIP_CHAIR_UNBUCKLED ""
#define DROPSHIP_CHAIR_FOLDED 0
#define DROPSHIP_CHAIR_BUCKLED "_buckled"
#define DROPSHIP_CHAIR_BROKEN "_broken"

#define LEADER_CHAIR 0

#define NO_CHAIR_COLOR ""
#define ALPHA_CHAIR "_alpha"
#define BRAVO_CHAIR "_bravo"
#define CHARLIE_CHAIR "_charlie"
#define DELTA_CHAIR "_delta"
#define FC_CHAIR "_fc"

/obj/structure/bed/chair //YES, chairs are a type of bed, which are a type of stool. This works, believe me.	-Pete
	name = "椅子"
	desc = "一个坐在四条腿上并带有靠背板的矩形金属框架.设计上或多或少能舒适地适应坐姿."
	icon_state = "chair"
	buckle_lying = 0
	buckling_y = 0
	max_integrity = 20
	///Check for fire-extinguisher-driven chairs
	var/propelled = 0

//directional variants mostly used for random spawners
/obj/structure/bed/chair/east
	dir = EAST

/obj/structure/bed/chair/west
	dir = WEST

/obj/structure/bed/chair/north
	dir = NORTH

/obj/structure/bed/chair/alt
	icon = 'icons/obj/structures/mainship_props.dmi'
	icon_state = "chair_alt"

/obj/structure/bed/chair/nometal
	dropmetal = FALSE

/obj/structure/bed/chair/proc/handle_rotation(direction) //Making this into a seperate proc so office chairs can call it on Move()
	handle_layer()
	for(var/m in buckled_mobs)
		var/mob/living/buckled_mob = m
		buckled_mob.setDir(direction)

/obj/structure/bed/chair/proc/handle_layer()
	if(LAZYLEN(buckled_mobs) && dir == NORTH)
		layer = FLY_LAYER
	else
		layer = OBJ_LAYER

/obj/structure/bed/chair/post_buckle_mob(mob/buckling_mob)
	. = ..()
	if(isliving(buckling_mob)) //Properly update whether we're lying or not; no more people lying on chairs; ridiculous
		var/mob/living/buckled_target = buckling_mob
		buckled_target.set_lying_angle(0)

	handle_layer()

/obj/structure/bed/chair/post_unbuckle_mob(mob/buckled_mob)
	. = ..()
	handle_layer()

/obj/structure/bed/chair/setDir(newdir)
	. = ..()
	handle_rotation(newdir)

/obj/structure/bed/chair/verb/rotate()
	set name = "Rotate Chair"
	set category = "IC.Rotate"
	set src in view(0)

	var/mob/living/carbon/user = usr

	if(!istype(user) || !isturf(user.loc) || user.incapacitated())
		return FALSE

	if(world.time <= user.next_move)
		return FALSE
	user.next_move = world.time + 3

	setDir(turn(dir, 90))

//Chair types
/obj/structure/bed/chair/reinforced
	name = "加固椅子"
	desc = "有人说TGMC不该在加固椅子上花这么多钱,但简报室暴动的文件证明了事实并非如此."
	buildstackamount = 2

/obj/structure/bed/chair/reinforced/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	to_chat(user, span_warning("你只能通过将其焊接固定来拆解它!"))

/obj/structure/bed/chair/reinforced/welder_act(mob/living/user, obj/item/I)
	. = ..()
	if(user.do_actions)
		return
	var/obj/item/tool/weldingtool/WT = I

	if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_METAL)
		user.visible_message(span_notice("[user]手忙脚乱地琢磨如何焊接固定\the [src]."),
		span_notice("你笨手笨脚地摸索着如何将\the [src]焊接固定。"))
		var/fumbling_time = 5 SECONDS * (SKILL_ENGINEER_METAL - user.skills.getRating(SKILL_ENGINEER))
		if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED, extra_checks = CALLBACK(WT, TYPE_PROC_REF(/obj/item/tool/weldingtool, isOn))))
			return

	if(!WT.remove_fuel(0, user))
		return

	user.visible_message(span_notice("[user]开始将\the [src]焊接固定。"),
	span_notice("你开始将\the [src]焊接固定。"))
	if(!I.use_tool(src, user, 5 SECONDS, 1, 25, null, BUSY_ICON_FRIENDLY))
		return
	user.visible_message(span_notice("[user]将\the [src]焊接固定。"),
	span_notice("你将\the [src]焊接固定。"))
	if(buildstacktype && dropmetal)
		new buildstacktype(loc, buildstackamount)
	qdel(src)

/obj/structure/bed/chair/wood
	buildstacktype = /obj/item/stack/sheet/wood
	hit_sound = 'sound/effects/woodhit.ogg'

/obj/structure/bed/chair/wood/normal
	icon_state = "wooden_chair"
	name = "木椅"
	desc = "老归老, 时尚永不老。"

/obj/structure/bed/chair/wood/wings
	icon_state = "wooden_chair_wings"
	name = "木椅"
	desc = "老归老, 时尚永不老。"

/obj/structure/bed/chair/comfy
	name = "舒适椅子"
	desc = "看起来很舒服。"
	icon_state = "comfychair"
	color = rgb(255,255,255)
	hit_sound = 'sound/weapons/bladeslice.ogg'

/obj/structure/bed/chair/comfy/brown
	color = rgb(255,113,0)

/obj/structure/bed/chair/comfy/beige
	color = rgb(255,253,195)

/obj/structure/bed/chair/comfy/teal
	color = rgb(0,255,255)

/obj/structure/bed/chair/comfy/black
	color = rgb(167,164,153)

/obj/structure/bed/chair/comfy/black/pred
	icon = 'icons/obj/machines/yautja_machines.dmi'
	icon_state = "comfychair"

/obj/structure/bed/chair/comfy/lime
	color = rgb(255,251,0)

/obj/structure/bed/chair/comfy/alpha
	name = "阿尔法小队椅子"
	desc = "一把永久固定在地板上的简易椅子。覆盖着吱吱作响且硬得离谱的仿皮, 不均匀地涂着阿尔法小队红色。只供最勇敢最新鲜的USCM新兵使用。"
	icon_state = "comfychair_alpha"
	icon = 'icons/obj/objects.dmi'

/obj/structure/bed/chair/comfy/bravo
	name = "布拉沃小队椅子"
	desc = "一把永久固定在地板上的简易椅子。覆盖着吱吱作响且硬得离谱的仿皮, 不均匀地涂着布拉沃小队棕色。经认证可从各方抵御敌人入侵。"
	icon_state = "comfychair_bravo"
	icon = 'icons/obj/objects.dmi'

/obj/structure/bed/chair/comfy/charlie
	name = "查理小队椅子"
	desc = "一把永久固定在地板上的简易椅子。覆盖着吱吱作响且硬得离谱的仿皮, 不均匀地涂着查理小队紫色。没有一顿丰盛早餐相伴的话感觉格格不入。"
	icon_state = "comfychair_charlie"
	icon = 'icons/obj/objects.dmi'

/obj/structure/bed/chair/comfy/delta
	name = "德尔塔小队椅子"
	desc = "一把永久固定在地板上的简易椅子。覆盖着吱吱作响且硬得离谱的仿皮, 不均匀地涂着德尔塔小队蓝色。这把椅子最有可能第一个投入战斗, 也第一个阵亡。"
	icon_state = "comfychair_delta"
	icon = 'icons/obj/objects.dmi'

/obj/structure/bed/chair/sofa
	name = "舒适沙发"
	desc = "看起来很舒服。"
	icon_state = "sofamiddle"
	resistance_flags = XENO_DAMAGEABLE

/obj/structure/bed/chair/sofa/left
	icon_state = "sofaend_left"

/obj/structure/bed/chair/sofa/right
	icon_state = "sofaend_right"

/obj/structure/bed/chair/sofa/corner
	icon_state = "sofacorner"

/obj/structure/bed/chair/sofa/corsat
	name = "舒适沙发"
	desc = "看起来很舒服。"
	icon_state = "couch_hori2"

/obj/structure/bed/chair/sofa/corsat/left
	icon_state = "couch_hori1"

/obj/structure/bed/chair/sofa/corsat/right
	icon_state = "couch_hori3"

/obj/structure/bed/chair/sofa/corsat/verticaltop
	icon_state = "couch_vet3"

/obj/structure/bed/chair/sofa/corsat/verticalmiddle
	icon_state = "couch_vet2"

/obj/structure/bed/chair/sofa/corsat/verticalsouth
	icon_state = "couch_vet1"

//cm benches do not have corners

/obj/structure/bed/chair/pew
	name = "教堂长椅"
	desc = "一条老式木制长椅。"
	icon_state = "pews"

/obj/structure/bed/chair/office
	name = "办公椅"
	desc = "一种带底部轮子的旋转椅的新奇创意, 仅供办公使用。"
	anchored = FALSE
	buckle_flags = CAN_BUCKLE
	drag_delay = 1 //Pulling something on wheels is easy

//directional chairs for random spawners
/obj/structure/bed/chair/office/light/north
	dir = 1

/obj/structure/bed/chair/office/light/east
	dir = 4

/obj/structure/bed/chair/office/light/west
	dir = 8

/obj/structure/bed/chair/office/dark/north
	dir = 1

/obj/structure/bed/chair/office/dark/east
	dir = 4

/obj/structure/bed/chair/office/dark/west
	dir = 8

/obj/structure/bed/chair/office/Bump(atom/A)
	. = ..()
	if(!LAZYLEN(buckled_mobs))
		return

	if(!propelled)
		return
	var/mob/living/occupant = buckled_mobs[1]
	unbuckle_mob(occupant)

	var/def_zone = ran_zone()
	var/armor_modifier = occupant.modify_by_armor(1, MELEE, 0, def_zone)
	occupant.throw_at(A, 3, propelled)
	occupant.apply_effect(6 SECONDS * armor_modifier, EFFECT_STUN)
	occupant.apply_effect(6 SECONDS * armor_modifier, EFFECT_PARALYZE)
	occupant.apply_effect(6 SECONDS * armor_modifier, EFFECT_STUTTER)
	occupant.apply_damage(10 * armor_modifier, BRUTE, def_zone)
	UPDATEHEALTH(occupant)
	playsound(src.loc, 'sound/weapons/punch1.ogg', 25, 1)
	if(isliving(A))
		var/mob/living/victim = A
		def_zone = ran_zone()
		armor_modifier = victim.modify_by_armor(1, MELEE, 0, def_zone)
		victim.apply_effect(6 SECONDS * armor_modifier, EFFECT_STUN)
		victim.apply_effect(6 SECONDS * armor_modifier, EFFECT_PARALYZE)
		victim.apply_effect(6 SECONDS * armor_modifier, EFFECT_STUTTER)
		victim.apply_damage(10 * armor_modifier, BRUTE, def_zone)
		UPDATEHEALTH(victim)
	occupant.visible_message(span_danger("[occupant]撞上了\the [A]!"))

/obj/structure/bed/chair/office/light
	icon_state = "officechair_white"
	anchored = FALSE

/obj/structure/bed/chair/office/dark
	icon_state = "officechair_dark"
	anchored = FALSE

/obj/structure/bed/chair/dropship
	name = "运输机座椅"
	desc = "在高空空投时固定住你。"
	icon_state = "shuttle_chair"
	/// Handles the chair buckle bars overlay
	var/image/chairbar = null
	buildstacktype = 0
	/// Handles the current state of the chair (buckled, unbuckled, folded, broke)
	var/chair_state = DROPSHIP_CHAIR_UNBUCKLED

/obj/structure/bed/chair/dropship/update_overlays()
	. = ..()
	if(chair_state == DROPSHIP_CHAIR_BUCKLED)
		. += image('icons/obj/objects.dmi', icon_state = "shuttle_bars", layer = ABOVE_MOB_LAYER)
		return

/obj/structure/bed/chair/dropship/doublewide/post_buckle_mob(mob/buckling_mob)
	chair_state = DROPSHIP_CHAIR_BUCKLED
	update_icon()
	return ..()

/obj/structure/bed/chair/dropship/doublewide/post_unbuckle_mob(mob/buckled_mob)
	chair_state = DROPSHIP_CHAIR_UNBUCKLED
	update_icon()
	return ..()

/obj/structure/bed/chair/dropship/pilot
	icon_state = "pilot_chair"
	name = "飞行员座椅"
	desc = "专为飞行员乘坐而设计的座椅。"

/obj/structure/bed/chair/dropship/pilot/rotate()
	return // no

/obj/structure/bed/chair/dropship/passenger
	name = "乘客座椅"
	resistance_flags = RESIST_ALL
	var/is_animating = 0

/obj/structure/bed/chair/dropship/passenger/CanAllowThrough(atom/movable/mover, turf/target, height = 0, air_group = 0)
	if(chair_state == DROPSHIP_CHAIR_UNBUCKLED && istype(mover, /obj/vehicle/sealed) && !is_animating)
		visible_message(span_danger("[mover]猛撞[src]并将其撞坏!"))
		INVOKE_ASYNC(src, PROC_REF(fold_down), TRUE)
		return FALSE
	return ..()

/obj/structure/bed/chair/dropship/passenger/Initialize(mapload)
	. = ..()
	chairbar = image("icons/obj/objects.dmi", "shuttle_bars")
	chairbar.layer = ABOVE_MOB_LAYER

/obj/structure/bed/chair/dropship/passenger/post_buckle_mob(mob/buckling_mob)
	icon_state = "shuttle_chair_buckled"
	overlays += chairbar
	return ..()

/obj/structure/bed/chair/dropship/passenger/post_unbuckle_mob(mob/buckled_mob)
	icon_state = "shuttle_chair"
	overlays -= chairbar
	return ..()

/obj/structure/bed/chair/dropship/passenger/buckle_mob(mob/living/buckling_mob, force = FALSE, check_loc = TRUE, lying_buckle = FALSE, hands_needed = 0, target_hands_needed = 0, silent)
	if(chair_state != DROPSHIP_CHAIR_UNBUCKLED)
		return FALSE
	return ..()

/obj/structure/bed/chair/dropship/passenger/proc/fold_down(break_it = FALSE)
	if(chair_state == DROPSHIP_CHAIR_UNBUCKLED)
		is_animating = 1
		flick("shuttle_chair_new_folding", src)
		is_animating = 0
		if(LAZYLEN(buckled_mobs))
			unbuckle_mob(buckled_mobs[1])
		if(break_it)
			chair_state = DROPSHIP_CHAIR_BROKEN
		else
			chair_state = DROPSHIP_CHAIR_FOLDED
		sleep(0.5 SECONDS) // animation length
		icon_state = "shuttle_chair_new_folded"

/obj/structure/bed/chair/dropship/passenger/proc/unfold_up()
	if(chair_state == DROPSHIP_CHAIR_BROKEN)
		return
	is_animating = 1
	flick("shuttle_chair_new_unfolding", src)
	is_animating = 0
	chair_state = DROPSHIP_CHAIR_UNBUCKLED
	sleep(0.5 SECONDS)
	icon_state = "shuttle_chair"

/obj/structure/bed/chair/dropship/passenger/rotate()
	return // no

/obj/structure/bed/chair/dropship/passenger/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(xeno_attacker.status_flags & INCORPOREAL)
		return FALSE
	if(chair_state != DROPSHIP_CHAIR_BROKEN)
		xeno_attacker.visible_message(span_warning("[xeno_attacker]砸碎\the [src], 剪断了螺栓!"),
		span_warning("我们砸碎\the [src], 剪断了螺栓!"))
		fold_down(1)

/obj/structure/bed/chair/dropship/passenger/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	switch(chair_state)
		if(DROPSHIP_CHAIR_UNBUCKLED)
			user.visible_message(span_warning("[user]开始拧松\the [src]上的螺栓。"),
			span_warning("你开始拧松\the [src]上的螺栓。"))
			playsound(loc, 'sound/items/ratchet.ogg', 25, 1)

			if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_BUILD))
				return

			user.visible_message(span_warning("[user]拧松\the [src]上的螺栓, 将其折叠进地板。"),
			span_warning("你拧松\the [src]上的螺栓, 将其折叠进地板。"))
			fold_down()

		if(DROPSHIP_CHAIR_FOLDED)
			user.visible_message(span_warning("[user]开始展开\the [src]。"),
			span_warning("你开始展开\the [src]。"))
			playsound(loc, 'sound/items/ratchet.ogg', 25, 1)

			if(!do_after(user, 2 SECONDS, NONE, src, BUSY_ICON_BUILD))
				return

			user.visible_message(span_warning("[user]从地板展开\the [src]并拧紧螺栓。"),
			span_warning("你从地板展开\the [src]并拧紧螺栓。"))
			unfold_up()

		if(DROPSHIP_CHAIR_BROKEN)
			to_chat(user, span_warning("\The [src]似乎损坏了, 需要焊接。"))
			return

/obj/structure/bed/chair/dropship/passenger/welder_act(mob/living/user, obj/item/I)
	. = ..()
	if(chair_state != DROPSHIP_CHAIR_BROKEN)
		return
	user.visible_message(span_warning("[user]开始修理\the [src]。"),
	span_warning("你开始修理\the [src]。"))
	if(!I.use_tool(src, user, 2 SECONDS, 1, 25, null, BUSY_ICON_FRIENDLY))
		return
	user.visible_message(span_warning("[user]修理\the [src]。"),
	span_warning("你修理\the [src]。"))
	chair_state = DROPSHIP_CHAIR_FOLDED

/obj/structure/bed/chair/dropship/doublewide
	name = "双人宽座椅"
	icon_state = "doublewide_chair" //only facing south cause the rest are ugly
	max_integrity = 130
	/// Handles the color of the chair
	var/chair_color = NO_CHAIR_COLOR
	/// If the chair can only be sat in by a leader or not
	var/leader_chair = FALSE

/obj/structure/bed/chair/dropship/doublewide/attack_alien(mob/living/carbon/xenomorph/X, damage_amount = X.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = "", effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(X.status_flags & INCORPOREAL)
		return FALSE
	if(LAZYLEN(buckled_mobs))
		unbuckle_all_mobs(TRUE)
	return ..()

/obj/structure/bed/chair/dropship/doublewide/welder_act(mob/living/user, obj/item/I)
	if(LAZYLEN(buckled_mobs))
		balloon_alert_to_viewers("有人坐在上面时你无法修理这把椅子")
		return
	welder_repair_act(user, I, 130, 1 SECONDS, 0, SKILL_ENGINEER_METAL, 1)
	chair_state = DROPSHIP_CHAIR_UNBUCKLED
	update_icon()
	return

/obj/structure/bed/chair/dropship/doublewide/update_icon_state()
	. = ..()
	var/percentage = (obj_integrity / max_integrity) * 100
	switch(percentage)
		if(-INFINITY to 65)
			chair_state = DROPSHIP_CHAIR_BROKEN
	icon_state = "doublewide_chair[chair_color][chair_state]"

/obj/structure/bed/chair/dropship/doublewide/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(LAZYLEN(buckled_mobs) && chair_state == DROPSHIP_CHAIR_BROKEN)
		unbuckle_mob(buckled_mobs[1])
		balloon_alert_to_viewers("这把椅子损坏太严重, 无法继续坐在上面")

/obj/structure/bed/chair/dropship/doublewide/buckle_mob(mob/living/buckling_mob, force = FALSE, check_loc = TRUE, lying_buckle = FALSE, hands_needed = 0, target_hands_needed = 0, silent)
	if(chair_state == DROPSHIP_CHAIR_BROKEN)
		balloon_alert_to_viewers("这把椅子损坏太严重, 无法坐在上面")
		return FALSE
	if(leader_chair && buckling_mob.skills.getRating(SKILL_LEADERSHIP) < SKILL_LEAD_TRAINED)
		balloon_alert(buckling_mob, "你觉得自己不配坐在这把椅子上")
		return FALSE
	if(buckling_x)
		src.pixel_x = buckling_x
	return ..()

/obj/structure/bed/chair/dropship/doublewide/post_buckle_mob(mob/buckling_mob)
	doublewide_mob_density(buckling_mob, TRUE)
	return ..()

/obj/structure/bed/chair/dropship/doublewide/post_unbuckle_mob(mob/buckled_mob)
	doublewide_mob_density(buckled_mob, FALSE)
	return ..()

/// Handles checking the changing density for the person buckling or unbuckling and the person next to the buckling/unbuckling person
/obj/structure/bed/chair/dropship/doublewide/proc/doublewide_mob_density(mob/interactionmob, buckling)
	var/obj/structure/bed/chair/dropship/doublewide/other_doublewide = locate(/obj/structure/bed/chair/dropship/doublewide) in interactionmob.loc
	var/mob/living/other_chair_buckled_mob
	if(other_doublewide) //if there is another doublewide
		if(LAZYLEN(other_doublewide.buckled_mobs) && (other_doublewide.buckled_mobs[1] != interactionmob))
			other_chair_buckled_mob = other_doublewide.buckled_mobs[1]
			if(buckling)
				other_chair_buckled_mob.density = TRUE
				interactionmob.density = TRUE
				return
			//if theyre unbuckling with and there is another buckled mob
			other_chair_buckled_mob.density = FALSE
			interactionmob.density = TRUE
			return
		if(buckling) //if theyre buckling with no other chairs
			interactionmob.density = FALSE
			return
	//if there is no other doublewide or theyre unbuckling
	interactionmob.density = TRUE

/obj/structure/bed/chair/dropship/doublewide/left
	pixel_x = -8
	buckling_x = -8

/obj/structure/bed/chair/dropship/doublewide/right
	pixel_x = 9
	buckling_x = 9

/obj/structure/bed/chair/dropship/doublewide/left/alpha
	name = "阿尔法小队队长之椅"
	desc = "专为阿尔法小队队长保留的椅子。"
	icon_state = "doublewide_chair_alpha"
	chair_color = ALPHA_CHAIR
	leader_chair = TRUE
	max_integrity = 200

/obj/structure/bed/chair/dropship/doublewide/right/bravo
	name = "布拉沃小队队长之椅"
	desc = "专为布拉沃小队队长保留的椅子。"
	icon_state = "doublewide_chair_bravo"
	chair_color = BRAVO_CHAIR
	leader_chair = TRUE
	max_integrity = 200

/obj/structure/bed/chair/dropship/doublewide/left/charlie
	name = "查理小队队长之椅"
	desc = "专为查理小队队长保留的椅子。"
	icon_state = "doublewide_chair_charlie"
	chair_color = CHARLIE_CHAIR
	leader_chair = TRUE
	max_integrity = 200

/obj/structure/bed/chair/dropship/doublewide/right/delta
	name = "德尔塔小队队长的椅子"
	desc = "专为德尔塔小队队长保留的椅子."
	icon_state = "doublewide_chair_delta"
	chair_color = DELTA_CHAIR
	leader_chair = TRUE
	max_integrity = 200

/obj/structure/bed/chair/dropship/doublewide/fieldcommander
	name = "战地指挥官的椅子"
	desc = "专为战地指挥官保留的椅子."
	icon_state = "doublewide_chair_fc"
	chair_color = FC_CHAIR
	leader_chair = TRUE
	max_integrity = 200

/obj/structure/bed/chair/ob_chair
	name = "座位"
	desc = "一个舒适的座位."
	icon_state = "ob_chair"
	buildstacktype = null
	resistance_flags = UNACIDABLE
	dir = WEST
