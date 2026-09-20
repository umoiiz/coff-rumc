/obj/item/mecha_ammo
	name = "通用弹药箱"
	desc = "一箱未知武器的弹药."
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/mecha/mecha_ammo.dmi'
	icon_state = "empty"
	///how many rounds of ammo this box has left
	var/rounds = 0
	/// For weapons where we re-load the weapon itself rather than adding to the ammo storage.
	var/direct_load
	/// sound to play when we reload
	var/load_audio = 'sound/mecha/mag_bullet_insert.ogg'
	///ammo type define that tells the user the ammo type, and lets the ammo decide what weapon types it can refill
	var/ammo_type
	/// whether to qdel this mecha_ammo when it becomes empty
	var/qdel_on_empty = FALSE

/obj/item/mecha_ammo/update_icon_state()
	icon_state = rounds ? initial(icon_state) : "[initial(icon_state)]_e"
	return ..()

/obj/item/mecha_ammo/attack_self(mob/user)
	..()
	if(rounds)
		to_chat(user, span_warning("弹药箱清空之前无法压扁!"))
		return

	to_chat(user, span_notice("你将[src]折叠平整."))
	var/trash = new /obj/item/stack/sheet/metal(user.loc)
	qdel(src)
	user.put_in_hands(trash)

/obj/item/mecha_ammo/examine(mob/user)
	. = ..()
	if(rounds)
		. += "There [rounds > 1?"are":"is"] [rounds] [ammo_type][rounds > 1?"s":""] left."
	else
		. += span_notice("在手中使用可将其折叠成一张金属板.")

/obj/item/mecha_ammo/incendiary
	name = "燃烧弹药箱"
	desc = "一箱用于外骨骼武器的燃烧弹药."
	icon_state = "incendiary"
	rounds = 24
	ammo_type = MECHA_AMMO_INCENDIARY

/obj/item/mecha_ammo/scattershot
	name = "散射弹药箱"
	desc = "一盒放大版鹿弹,用于外骨骼霰弹枪."
	icon_state = "scattershot"
	rounds = 40
	ammo_type = MECHA_AMMO_BUCKSHOT

/obj/item/mecha_ammo/lmg
	name = "机枪弹药盒"
	desc = "一盒弹链弹药,专为Ultra AC 2外骨骼武器设计."
	icon_state = "lmg"
	rounds = 300
	ammo_type = MECHA_AMMO_LMG

/obj/item/mecha_ammo/missiles_br
	name = "破障导弹"
	desc = "一盒大型导弹,可装入BRM-6外骨骼导弹架."
	icon_state = "missile_br"
	rounds = 6
	direct_load = TRUE
	load_audio = 'sound/mecha/mag_bullet_insert.ogg'
	ammo_type = MECHA_AMMO_MISSILE_HE

/obj/item/mecha_ammo/missiles_he
	name = "反装甲导弹"
	desc = "一盒大型导弹,可装入SRM-8外骨骼导弹架."
	icon_state = "missile_he"
	rounds = 8
	direct_load = TRUE
	load_audio = 'sound/mecha/mag_bullet_insert.ogg'
	ammo_type = MECHA_AMMO_MISSILE_AP


/obj/item/mecha_ammo/flashbang
	name = "可发射闪光弹"
	desc = "一盒光滑闪光弹,用于大型外骨骼发射器.无法手动拔销."
	icon_state = "flashbang"
	rounds = 6
	ammo_type = MECHA_AMMO_FLASHBANG

/obj/item/mecha_ammo/clusterbang
	name = "可发射集束闪光弹"
	desc = "一盒集束闪光弹,用于专用外骨骼集束发射器.无法手动拔销."
	icon_state = "clusterbang"
	rounds = 3
	direct_load = TRUE
	ammo_type = MECHA_AMMO_CLUSTERBANG



//greyscale mech stuff
/obj/item/mecha_ammo/vendable
	w_class = WEIGHT_CLASS_BULKY
	equip_slot_flags = ITEM_SLOT_BACK

/obj/item/mecha_ammo/vendable/lmg
	name = "轻机枪子弹盒"
	desc = "一盒相当大的轻机枪子弹."
	icon_state = "lmg_ammo"
	rounds = 300
	ammo_type = MECHA_AMMO_GREY_LMG

/obj/item/mecha_ammo/vendable/rifle
	name = "步枪子弹盒"
	desc = "一盒大型火箭助推步枪子弹.侧面写着\"请勿当作鞭炮使用\"."
	icon_state = "assaultrifle_ammo"
	rounds = 250
	ammo_type = MECHA_AMMO_RIFLE

/obj/item/mecha_ammo/vendable/burstrifle
	name = "战斗步枪子弹盒"
	desc = "一盒大型火箭助推战斗步枪子弹.侧面写着\"请勿当作鞭炮使用\"."
	icon_state = "burstrifle_ammo"
	rounds = 250
	ammo_type = MECHA_AMMO_BURSTRIFLE

/obj/item/mecha_ammo/vendable/shotgun
	name = "霰弹枪弹药盒"
	desc = "一盒大型霰弹枪弹药.遗憾的是它们只能装进机甲尺寸的武器."
	icon_state = "shotgun_ammo"
	rounds = 20
	ammo_type = MECHA_AMMO_SHOTGUN

/obj/item/mecha_ammo/vendable/lightcannon
	name = "轻型机炮炮弹盒"
	desc = "一盒轻型机炮炮弹.虽说叫轻型,这盒子还挺重."
	icon_state = "lightcannon_ammo"
	rounds = 100
	ammo_type = MECHA_AMMO_LIGHTCANNON

/obj/item/mecha_ammo/vendable/heavycannon
	name = "重型机炮炮弹"
	desc = "一枚巨大的坦克炮弹,用于装填机甲机炮."
	icon_state = "heavycannon_ammo"
	rounds = 5
	ammo_type = MECHA_AMMO_HEAVYCANNON
	direct_load = TRUE
	qdel_on_empty = TRUE

/obj/item/mecha_ammo/vendable/smg
	name = "冲锋枪子弹盒"
	desc = "一盒普通冲锋枪子弹,但更大!"
	icon_state = "smg_ammo"
	rounds = 320
	ammo_type = MECHA_AMMO_SMG

/obj/item/mecha_ammo/vendable/burstpistol
	name = "连发手枪子弹盒"
	desc = "一盒连发手枪子弹."
	icon_state = "burstpistol_ammo"
	rounds = 200
	ammo_type = MECHA_AMMO_BURSTPISTOL

/obj/item/mecha_ammo/vendable/pistol
	name = "手枪子弹盒"
	desc = "大多数陆战队员所用小型手枪子弹的放大版."
	icon_state = "pistol_ammo"
	rounds = 200
	ammo_type = MECHA_AMMO_PISTOL

/obj/item/mecha_ammo/vendable/rpg
	name = "高爆导弹"
	desc = "一枚TGMC机甲导弹.你最好别用任何东西去撞尖的那头."
	icon_state = "rpg_ammo"
	rounds = 1
	ammo_type = MECHA_AMMO_RPG
	direct_load = TRUE
	qdel_on_empty = TRUE

/obj/item/mecha_ammo/vendable/minigun
	name = "火神炮炮弹盒"
	desc = "对你来说不幸的是,火神炮射出的每一发炮弹也都必须装填进去."
	icon_state = "minigun_ammo"
	rounds = 200
	ammo_type = MECHA_AMMO_MINIGUN

/obj/item/mecha_ammo/vendable/sniper
	name = "狙击枪子弹盒"
	desc = "一盒反坦克子弹,用于射击小型装甲车辆和小型装甲生物."
	icon_state = "sniper_ammo"
	rounds = 30
	ammo_type = MECHA_AMMO_SNIPER

/obj/item/mecha_ammo/vendable/grenade
	name = "手榴弹架"
	desc = "一个装满成排手榴弹的架子,用塑料固定."
	icon_state = "grenadelauncher_ammo"
	rounds = 20
	direct_load = TRUE
	ammo_type = MECHA_AMMO_GRENADE

/obj/item/mecha_ammo/vendable/flamer
	name = "火焰喷射器凝固汽油罐"
	desc = "一种专用燃料罐,用于补充TGMC标准配发机甲火焰喷射器."
	icon_state = "flamer_ammo"
	rounds = 10
	ammo_type = MECHA_AMMO_FLAMER
