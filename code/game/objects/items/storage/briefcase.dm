/obj/item/storage/briefcase
	name = "公文包"
	desc = "它由正宗的仿皮制成, 还挂着价格标签. 它的主人一定是个真正的专业人士."
	icon_state = "briefcase"
	worn_icon_state = "briefcase"
	icon = 'icons/obj/items/storage/briefcase.dmi'
	atom_flags = CONDUCT
	force = 8
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/briefcase

/obj/item/storage/briefcase/standard_magnum
	name = "R-76马格南枪盒"
	desc = "一个做工精良, 外观昂贵的枪盒, 专为容纳一把R-76马格南及其配件而设计. 为有品位的枪主打造."
	icon_state = "magnum_case"
	worn_icon_state = "briefcase"
	atom_flags = CONDUCT
	force = 12
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/briefcase/standard_magnum

/obj/item/storage/briefcase/standard_magnum/PopulateContents()
	new /obj/item/weapon/gun/revolver/standard_magnum(src)
	new /obj/item/attachable/scope/standard_magnum(src)
	for(var/i in 1 to 15)
		new /obj/item/ammo_magazine/revolver/standard_magnum(src)

/obj/item/storage/briefcase/standard_magnum/gold/PopulateContents()
	new /obj/item/weapon/gun/revolver/standard_magnum/fancy/gold(src)
	new /obj/item/attachable/scope/standard_magnum(src)
	for(var/i in 1 to 15)
		new /obj/item/ammo_magazine/revolver/standard_magnum(src)

/obj/item/storage/briefcase/standard_magnum/silver/PopulateContents()
	new /obj/item/weapon/gun/revolver/standard_magnum/fancy/silver(src)
	new /obj/item/attachable/scope/standard_magnum(src)
	for(var/i in 1 to 15)
		new /obj/item/ammo_magazine/revolver/standard_magnum(src)

/obj/item/storage/briefcase/standard_magnum/nickle/PopulateContents()
	new /obj/item/weapon/gun/revolver/standard_magnum/fancy/nickle(src)
	new /obj/item/attachable/scope/standard_magnum(src)
	for(var/i in 1 to 15)
		new /obj/item/ammo_magazine/revolver/standard_magnum(src)

/obj/item/storage/briefcase/t500
	name = "\improper R-500 'Nigredo'特制枪盒"
	desc = "由BMSS制造的高科技枪盒, 用于运送他们的特种武器. 盒上的标签写着: '这是有史以来最伟大的手枪. 五发子弹. 足以杀死任何会动的东西'."
	icon_state = "t500case"
	w_class = WEIGHT_CLASS_NORMAL
	storage_type = /datum/storage/briefcase/t500

/obj/item/storage/briefcase/t500/PopulateContents()
	new /obj/item/attachable/stock/t500(src)
	new /obj/item/attachable/lace/t500(src)
	new /obj/item/attachable/t500_barrel/short(src)
	new /obj/item/attachable/t500_barrel(src)
	new /obj/item/weapon/gun/revolver/t500(src)

/obj/item/storage/briefcase/t312
	name = "R-312 'Albedo'左轮手枪特制枪盒"
	desc = "由BMSS制造的高科技枪盒, 用于运送他们的特种武器. 盒上的标签写着: '既然我们已将Nigredo称为死亡, 那么在同样的隐喻中, 我们可以将Albedo称为生命. 是时候合法地向人们开枪了.'"
	icon_state = "med_case"
	w_class = WEIGHT_CLASS_NORMAL
	storage_type = /datum/storage/briefcase/t312

/obj/item/storage/briefcase/t312/PopulateContents()
	new /obj/item/ammo_magazine/packet/t312/med/adrenaline(src)
	new /obj/item/ammo_magazine/packet/t312/med/rr(src)
	new /obj/item/ammo_magazine/packet/t312/med/md(src)
	new /obj/item/ammo_magazine/packet/t312/med/neu(src)
	new /obj/item/ammo_magazine/revolver/t312/med/adrenaline(src)
	new /obj/item/ammo_magazine/revolver/t312/med/rr(src)
	new /obj/item/ammo_magazine/revolver/t312/med/md(src)
	new /obj/item/ammo_magazine/revolver/t312/med/neu(src)
	new /obj/item/storage/pouch/medkit/t312(src)
	new /obj/item/attachable/lace/t500(src)
	new /obj/item/weapon/gun/revolver/t312(src)

/obj/item/storage/briefcase/inflatable
	name = "充气屏障盒"
	desc = "包含充气墙和充气门."
	icon_state = "inf_box"
	worn_icon_state = "syringe_kit"

/obj/item/storage/briefcase/inflatable/Initialize(mapload, ...)
	. = ..()
	storage_datum.max_storage_space = 21

/obj/item/storage/briefcase/inflatable/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/inflatable/door(src)
	for(var/i in 1 to 4)
		new /obj/item/inflatable/wall(src)
