/obj/item/attachable/stock //Generic stock parent and related things.
	name = "默认枪托"
	desc = "默认父对象,不供使用。"
	slot = ATTACHMENT_SLOT_STOCK
	attach_features_flags = NONE //most stocks are not removable
	size_mod = 2
	pixel_shift_x = 30
	pixel_shift_y = 14

/obj/item/attachable/stock/mosin
	name = "莫辛木制枪托"
	desc = "一个非标准的长木制枪托,用于斯拉夫枪械。"
	icon_state = "mosinstock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/ppsh
	name = "PPSh-17b冲锋枪木制枪托"
	desc = "一个长木制枪托,用于PPSh-17b冲锋枪"
	icon_state = "ppshstock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/pal12
	name = "圣骑士-12泵动霰弹枪枪托"
	desc = "一个标准轻型枪托,用于圣骑士-12霰弹枪。"
	icon_state = "pal12stock"

/obj/item/attachable/stock/mpi_km
	name = "MPi-KM木制枪托"
	desc = "一个带有木制涂层的金属枪托,为适配MPi-KM而制造。"
	icon_state = "ak47stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/mpi_km/black
	name = "MPi-KM聚合物枪托"
	desc = "一个黑色聚合物枪托,为适配MPi-KM而制造。"
	icon_state = "ak47stock_black"

/obj/item/attachable/stock/lmg_d
	name = "lMG-D木制枪托"
	desc = "一个带有木制涂层的金属枪托,为适配lMG-D而制造。"
	icon_state = "ak47stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/sh15
	name = "\improper SH-15枪托"
	desc = "SH-15的标准枪托。无法移除。"
	icon_state = "tx15stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/sgstock
	name = "SG-29枪托"
	desc = "一个标准机枪枪托。"
	icon_state = "sg29stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/strstock
	name = "SG-62枪托"
	desc = "一个标准步枪枪托。"
	icon_state = "sg62stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/lasgun
	name = "\improper M43阳炎激光枪枪托"
	desc = "M43阳炎激光枪的标准枪托。"
	icon_state = "laserstock"
	pixel_shift_x = 41
	pixel_shift_y = 10

/obj/item/attachable/stock/lasgun/practice
	name = "\improper M43-P阳炎激光枪枪托"
	desc = "M43-P阳炎激光枪的标准枪托,看起来枪托是由塑料制成的。"
	icon_state = "laserstock"
	pixel_shift_x = 41
	pixel_shift_y = 10

/obj/item/attachable/stock/sr127stock
	name = "\improper SR-127枪托"
	desc = "一把不可拆卸的SR-127狙击步枪枪托."
	icon_state = "tl127stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/garand
	name = "\improper C1枪托"
	desc = "一把不可拆卸的C1枪托."
	icon_state = "garandstock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/trenchgun
	name = "\improper L-4043枪托"
	desc = "一把不可拆卸的L-4043枪托."
	icon_state = "trenchstock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/icc_heavyshotgun
	name = "\improper ML-101枪托"
	desc = "一把不可拆卸的ML-101枪托."
	icon_state = "ml101"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/icc_pdw
	name = "\improper L-40枪托"
	desc = "一把不可拆卸的L-40枪托."
	icon_state = "l40stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/icc_sharpshooter
	name = "\improper L-1枪托"
	desc = "一把不可拆卸的L-11枪托."
	icon_state = "l11stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/clf_heavyrifle
	name = "PTR-41/1785枪身"
	desc = "PTR-41/1785 A-MR的枪托."
	icon_state = "ptrs_stock"
	icon = 'icons/obj/items/gun/marksman64.dmi'
	pixel_shift_x = 15
	pixel_shift_y = 0

/obj/item/attachable/stock/dpm
	name = "\improper DP-27枪托"
	desc = "一把不可拆卸的DP枪托."
	icon_state = "dpstock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/t39stock
	name = "\improper SH-39枪托"
	desc = "SH-39的专用枪托."
	icon_state = "t39stock"
	pixel_shift_x = 32
	pixel_shift_y = 13
	size_mod = 1
	attach_features_flags = ATTACH_REMOVABLE
	wield_delay_mod = 0.2 SECONDS
	accuracy_mod = 0.15
	recoil_mod = -2
	scatter_mod = -2

/obj/item/attachable/stock/t60stock
	name = "MG-60枪托"
	desc = "一把不可拆卸的MG-60通用机枪枪托."
	icon_state = "t60stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/t70stock
	name = "\improper GL-70枪托"
	desc = "一把不可拆卸的GL-70榴弹发射器枪托."
	icon_state = "t70stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/t84stock
	name = "\improper FL-84枪托"
	desc = "一把不可拆卸的FL-84火焰喷射器枪托."
	icon_state = "tl84stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/m41a
	name = "PR-11枪托"
	icon_state = "m41a"

/obj/item/attachable/stock/ar11
	name = "AR-11枪托"
	icon_state = "tx11stock"

/obj/item/attachable/stock/som_mg_stock
	name = "\improper V-41枪托"
	desc = "一把不可拆卸的V-41机枪枪托."
	icon_state = "v41stock"
	pixel_shift_x = 0
	pixel_shift_y = 0

/obj/item/attachable/stock/ar18stock
	name = "\improper AR-18枪托"
	desc = "AR-18的专用枪托."
	icon_state = "t18stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/ar12stock
	name = "\improper AR-12枪托"
	desc = "AR-12的专用枪托."
	icon_state = "t12stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/t42stock
	name = "\improper MG-42枪托"
	desc = "MG-42的专用枪托."
	icon_state = "t42stock"
	pixel_shift_x = 32
	pixel_shift_y = 13

/obj/item/attachable/stock/br64stock
	name = "\improper BR-64枪托"
	desc = "BR-64的专用枪托."
	icon_state = "t64stock"

//You can remove the stock on the Magnum. So it has stats and is removeable.

/obj/item/attachable/stock/t76
	name = "T-76马格南枪托"
	desc = "R-76马格南枪托. 除了更难持握之外, 几乎能改善你所有的操控性能. 如果你珍惜你的肩膀, 建议一直装在R-76上."
	icon_state = "t76stock"
	attach_features_flags = ATTACH_REMOVABLE
	melee_mod = 5
	scatter_mod = -1
	size_mod = 2
	aim_speed_mod = 0.05
	recoil_mod = -2
	pixel_shift_x = 30
	pixel_shift_y = 14

/obj/item/attachable/stock/t500
	name = "R-500枪托"
	desc = "给酷炫左轮用的酷炫枪托."
	attach_features_flags = ATTACH_REMOVABLE
	wield_delay_mod = 0.2 SECONDS
	delay_mod = -0.4 SECONDS
	icon = 'icons/obj/items/attachments/attachments_64.dmi'
	icon_state = "stock"
	size_mod = 1
	accuracy_mod = 0.15
	recoil_mod = -1
	recoil_unwielded_mod = 1
	scatter_mod = -2
	scatter_unwielded_mod = 5
	melee_mod = 10
	pixel_shift_x = 0
	pixel_shift_y = 0
