/obj/item/explosive/grenade/pmc
	desc = "为私人安保公司生产的破片手榴弹.拔掉保险销后3秒爆炸."
	icon_state = "grenade_pmc"
	worn_icon_state = "grenade_pmc"
	hud_state = "grenade_frag"
	icon_state_mini = "grenade_red_white"
	power = 125
	falloff = 40

/obj/item/explosive/grenade/pmc/prime()
	create_shrapnel(loc, 15, shrapnel_type = /datum/ammo/bullet/shrapnel/metal)
	return ..()

/obj/item/explosive/grenade/m15
	name = "\improper M15破片手榴弹"
	desc = "一种过时的TGMC破片手榴弹.在TGMC服役数十年后,老旧的M15破片手榴弹正逐渐被稍安全的M40 HEDP取代.设定为4秒后引爆."
	icon_state = "grenade_ex"
	worn_icon_state = "grenade_ex"
	hud_state = "grenade_frag"
	icon_state_mini = "grenade_yellow"
	power = 125
	falloff = 40

/obj/item/explosive/grenade/m15/prime()
	create_shrapnel(loc, 15, shrapnel_type = /datum/ammo/bullet/shrapnel/metal)
	return ..()

/obj/item/explosive/grenade/stick
	name = "\improper 韦伯利Mk15柄式手榴弹"
	desc = "一种在殖民地生产的破片手榴弹,通常使用旧式设计和图纸.拔掉保险销后3秒爆炸."
	icon_state = "grenade_stick"
	worn_icon_state = "grenade_stick"
	hud_state = "grenade_frag"
	force = 10
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 15

/obj/item/explosive/grenade/upp
	name = "\improper 5式破片手榴弹"
	desc = "一种在USL队伍中发现的破片手榴弹.设计为爆炸成破片并撕裂对手的身体.拔掉保险销后3秒爆炸."
	icon_state = "grenade_upp"
	worn_icon_state = "grenade_upp"
	hud_state = "greande_frag"
	throw_speed = 2
	throw_range = 6

/obj/item/explosive/grenade/som
	name = "\improper S30高爆手榴弹"
	desc = "一种由SOM部队使用的可靠高爆手榴弹.设计用于手投或榴弹发射器发射."
	icon_state = "grenade_som"
	worn_icon_state = "grenade_som"

/obj/item/explosive/grenade/vsd
	name = "\improper XM93 HEAP手榴弹"
	desc = "InterTech的实验性高爆反人员手榴弹.适合清理房间等."
	icon_state = "grenade_vsd"
	power = 100
	falloff = 20

/obj/item/explosive/grenade/sectoid
	name = "异形炸弹"
	desc = "一种奇怪的、黏软的、类似器官的手榴弹.挤压后3秒爆炸."
	icon_state = "alien_grenade"
	worn_icon_state = "alien_grenade"
	hud_state = "grenade_frag"
	power = 150
	falloff = 25

/obj/item/explosive/grenade/agls
	name = "\improper AGLS-37 HEDP手榴弹"
	desc = "一种小巧的智能手榴弹,它即将在你脸上爆炸,除非你发现它是惰性的.除此之外是一枚相当普通的手榴弹,只是不知为何处于可引爆状态."
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "agls_grenade"
	worn_icon_state = "agls_grenade"
	det_time = 1 SECONDS
	power = 80
	falloff = 20

/obj/item/explosive/grenade/impact
	name = "\improper M40 IMDP手榴弹"
	desc = "一种高爆接触引爆弹药,采用标准DP罐体.具有集中爆炸效果,专门用于破门以及对抗工事和轻型装甲车辆.警告:手投无法产生足够的力量触发撞击引信."
	icon_state = "grenade_impact"
	worn_icon_state = "grenade_impact"
	hud_state = "grenade_frag"
	det_time = 4 SECONDS
	dangerous = TRUE
	icon_state_mini = "grenade_blue_white"
	power = 80
	falloff = 30
	overlay_type = "cyan"

/obj/item/explosive/grenade/impact/throw_impact(atom/hit_atom, speed)
	. = ..()
	if(!.)
		return
	if(launched && active && !istype(hit_atom, /turf/open)) //Only contact det if active, we actually hit something, and we're fired from a grenade launcher.
		cell_explosion(loc, 50, 25)
		qdel(src)

/obj/item/explosive/grenade/creampie
	name = "\improper ERP4高爆香蕉奶油派手榴弹"
	desc = "一种高爆弹药,伪装成美味奶油派的样子!"
	icon = 'icons/obj/items/food/piecake.dmi'
	icon_state = "pie"
