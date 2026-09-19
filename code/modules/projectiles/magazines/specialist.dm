//-------------------------------------------------------
//SNIPER RIFLES
//Keyword rifles. They are subtype of rifles, but still contained here as a specialist weapon.

/obj/item/ammo_magazine/sniper
	name = "\improper SR-26弹匣(10x28mm)"
	desc = "一匣反器材步枪弹药."
	caliber = CALIBER_10X28
	icon_state = "t26"
	w_class = WEIGHT_CLASS_NORMAL
	max_rounds = 15
	default_ammo = /datum/ammo/bullet/sniper/smart
	reload_delay = 3
	icon_state_mini = "mag_sniper"
	ammo_band_icon = "t26_band"

/obj/item/ammo_magazine/sniper/incendiary
	name = "\improper SR-26燃烧弹匣(10x28mm)"
	default_ammo = /datum/ammo/bullet/sniper/incendiary/smart
	icon_state_mini = "mag_sniper_red"
	bonus_overlay = "t26_incend"
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/sniper/flak
	name = "\improper SR-26破片弹匣(10x28mm)"
	default_ammo = /datum/ammo/bullet/sniper/flak/smart
	icon_state_mini = "mag_sniper_blue"
	bonus_overlay = "t26_flak"
	ammo_band_color = AMMO_BAND_COLOR_IMPACT

//SR-42 magazine

/obj/item/ammo_magazine/sniper/elite
	name = "\improper SR-42精确射手弹匣(10x99mm)"
	default_ammo = /datum/ammo/bullet/sniper/elite
	caliber = CALIBER_10X99
	icon_state = "m42c"
	icon_state_mini = "mag_rifle_big_white"
	max_rounds = 6


//SVD //Based on the actual Dragunov sniper rifle.

/obj/item/ammo_magazine/sniper/svd
	name = "\improper SVD弹匣(7.62x54mmR)"
	desc = "一把用于SVD狙击步枪的大口径弹匣."
	caliber = CALIBER_762X54
	icon_state = "svd"
	default_ammo = /datum/ammo/bullet/sniper/svd
	max_rounds = 10
	icon_state_mini = "mag_rifle"



//tx8 magazines

/obj/item/ammo_magazine/rifle/tx8
	name = "\improper 高速弹匣(10x28mm)"
	desc = "一匣超压高速弹药,用于BR-8战斗步枪.BR-8战斗步枪是唯一能装填这些弹药的枪械."
	icon_state = "tx8"
	caliber = CALIBER_10X28_CASELESS
	default_ammo = /datum/ammo/bullet/rifle/tx8
	max_rounds = 25
	icon_state_mini = "mag_rifle_big"
	ammo_band_icon = "tx8_band"

/obj/item/ammo_magazine/rifle/tx8/incendiary
	name = "\improper 高速燃烧弹匣(10x28mm)"
	desc = "一匣超压高速燃烧弹药,用于BR-8战斗步枪.BR-8战斗步枪是唯一能装填这些弹药的枪械."
	caliber = CALIBER_10X28_CASELESS
	default_ammo = /datum/ammo/bullet/rifle/tx8/incendiary
	icon_state_mini = "mag_rifle_big_red"
	bonus_overlay = "tx8_incend"
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/tx8/impact
	name = "\improper 高速冲击弹匣(10x28mm)"
	desc = "一匣超压高速冲击弹药,用于BR-8战斗步枪.BR-8战斗步枪是唯一能装填这些弹药的枪械."
	default_ammo = /datum/ammo/bullet/rifle/tx8/impact
	icon_state_mini = "mag_rifle_big_blue"
	bonus_overlay = "tx8_impact"
	ammo_band_color = AMMO_BAND_COLOR_IMPACT

//-------------------------------------------------------
//M5 RPG

/obj/item/ammo_magazine/rocket
	name = "\improper 通用高爆火箭弹"
	desc = "各种不适合正常使用的火箭弹的前身.你到底是怎么弄到这个的?"
	caliber = CALIBER_84MM
	icon = 'icons/obj/items/ammo/rocket.dmi'
	icon_state = "rocket"
	w_class = WEIGHT_CLASS_NORMAL
	magazine_flags = MAGAZINE_REFUND_IN_CHAMBER
	max_rounds = 1
	default_ammo = /datum/ammo/rocket
	reload_delay = 60

/obj/item/ammo_magazine/rocket/attack_self(mob/user)
	if(current_rounds > 0)
		to_chat(user, span_notice("里面可没有导弹!"))
		return
	to_chat(user, span_notice("你开始拆解空管框架..."))
	if(!do_after(user, 10, NONE, src))
		return
	user.visible_message("[user]拆解了火箭弹管框架.",span_notice("你拆解了空框架."))
	var/obj/item/stack/sheet/metal/metal = new(get_turf(user))
	metal.amount = 2
	user.drop_held_item()
	qdel(src)

/obj/item/ammo_magazine/rocket/update_name(updates)
	. = ..()
	if(current_rounds > 0)
		return
	name = "empty rocket frame"

/obj/item/ammo_magazine/rocket/update_desc(updates)
	. = ..()
	if(current_rounds > 0)
		return
	desc = "A spent rocket rube. Activate it to deconstruct it and receive some materials."

/obj/item/ammo_magazine/rocket/update_icon_state()
	. = ..()
	if(current_rounds > 0)
		return
	icon_state = istype(src, /obj/item/ammo_magazine/rocket/m57a4) ? "quad_rocket_e" : "rocket_e"

//-------------------------------------------------------
//RL-152

/obj/item/ammo_magazine/rocket/sadar
	name = "\improper 84mm\"L-G\"高爆火箭弹"
	desc = "一枚用于RL-152火箭发射器的弹头.搭载一枚标准的会爆炸的高爆弹头.由于采用激光制导,它会精确命中你瞄准的位置,但因此需要内部空间用于制导,所以装药量较小.  空置时,使用此框架将其拆解."
	caliber = CALIBER_84MM
	icon_state = "rocket_he"
	w_class = WEIGHT_CLASS_NORMAL
	max_rounds = 1
	default_ammo = /datum/ammo/rocket/he
	reload_delay = 60
	bonus_overlay = "rocket_he"

/obj/item/ammo_magazine/rocket/sadar/unguided
	name = "\improper 84mm\"无制导\"高爆火箭弹"
	desc = "一枚用于RL-152火箭发射器的弹头.搭载一枚标准的会爆炸的高爆弹头.它完全无制导,因此\"愚蠢\",这允许更大的装药量,熟练的操作员可以命中激光制导火箭根本无法企及的更远距离目标.  空置时,使用此框架将其拆解."
	icon_state = "rocket_he_unguided"
	default_ammo = /datum/ammo/rocket/he/unguided

/obj/item/ammo_magazine/rocket/sadar/ap
	name = "\improper 84mm 'L-G' 反装甲火箭弹"
	desc = "用于AP火箭弹的发射管,其内部弹头是一种导弹辅助动能穿甲弹,几乎能摧毁任何被其命中内部的目标,并在此过程中破坏其装甲.空置时,使用此框架将其拆解."
	icon_state = "rocket_ap"
	default_ammo = /datum/ammo/rocket/ap
	bonus_overlay = "rocket_ap"

/obj/item/ammo_magazine/rocket/sadar/wp
	name = "\improper 84mm 'L-G' 白磷火箭弹"
	desc = "一种极具破坏性的弹头,命中时会爆发出致命火焰.由于采用激光制导,它会精确命中你的瞄准位置,但由于内部所需空间,其装药量较小.在手中使用以将其拆解."
	icon_state = "rocket_wp"
	default_ammo = /datum/ammo/rocket/wp
	bonus_overlay = "rocket_wp"

/obj/item/ammo_magazine/rocket/sadar/wp/unguided
	name = "\improper 84mm '无制导' 白磷火箭弹"
	desc = "一种极具破坏性的弹头,命中时会爆发出致命火焰.它完全无制导,因此被称为'傻瓜弹',其优势是整体装药量更大,熟练的操作员可以打出激光制导火箭弹完全无法企及的远距离命中.在手中使用以将其拆解."
	icon_state = "rocket_wp_unguided"
	default_ammo = /datum/ammo/rocket/wp/unguided

//-------------------------------------------------------
//RL-160 recoilless rifle

/obj/item/ammo_magazine/rocket/recoilless
	name = "\improper 67mm 高爆弹"
	desc = "用于RL-160无后坐力步枪的高爆弹.在小范围内造成剧烈爆炸.需要专用储存空间才能携带."
	caliber = CALIBER_67MM
	icon_state = "shell"
	w_class = WEIGHT_CLASS_NORMAL
	max_rounds = 1
	default_ammo = /datum/ammo/rocket/recoilless
	reload_delay = 30

/obj/item/ammo_magazine/rocket/recoilless/light
	name = "\improper 67mm 轻型爆炸弹"
	desc = "用于RL-160无后坐力步枪的轻型爆炸弹.在大范围内造成轻微爆炸.由于装药较轻,其射程比其他同类型炮弹更远.需要专用储存空间才能携带."
	icon_state = "shell_le"
	default_ammo = /datum/ammo/rocket/recoilless/light
	reload_delay = 10

/obj/item/ammo_magazine/rocket/recoilless/low_impact
	name = "\improper 67mm 轻型爆炸弹"
	desc = "用于RL-160无后坐力步枪的轻型爆炸弹.在大范围内造成轻微爆炸,但冲击伤害较低.由于装药较轻,其射程比其他同类型炮弹更远.需要专用储存空间才能携带."
	icon_state = "shell_le"
	default_ammo = /datum/ammo/rocket/recoilless/low_impact
	reload_delay = 10

/obj/item/ammo_magazine/rocket/recoilless/heat
	name = "\improper 67mm 破甲弹"
	desc = "用于RL-160无后坐力步枪的高爆反坦克弹.发射一枚无爆炸的穿透弹.它会对所有类型的敌人造成中等伤害,并削弱其装甲.需要专用储存空间才能携带."
	icon_state = "shell_heat"
	default_ammo = /datum/ammo/rocket/recoilless/heat

/obj/item/ammo_magazine/rocket/recoilless/heam
	name = "\improper 67mm 反机甲破甲弹"
	desc = "用于RL-160无后坐力步枪的高爆反机甲弹.发射一枚专为穿透机甲装甲而设计的穿透弹,但对其他目标精度较差.需要专用储存空间才能携带."
	icon_state = "shell_heat"
	default_ammo = /datum/ammo/rocket/recoilless/heat/mech

/obj/item/ammo_magazine/rocket/recoilless/smoke
	name = "\improper 67mm 化学(烟雾)弹"
	desc = "用于RL-160无后坐力步枪的化学弹.发射一枚低速炮弹,用于近距离施放化学气体,由于速度较低,友军可以轻松躲开.此弹头装有浓密的遮蔽烟雾.需要专用储存空间才能携带."
	icon_state = "shell_smoke"
	default_ammo = /datum/ammo/rocket/recoilless/chemical

/obj/item/ammo_magazine/rocket/recoilless/cloak
	name = "\improper 67mm 化学(隐形)弹"
	desc = "用于RL-160无后坐力步枪的化学弹.发射一枚低速炮弹,用于近距离施放化学气体,由于速度较低,友军可以轻松躲开.此弹头装有先进的隐形烟雾.需要专用储存空间才能携带."
	icon_state = "shell_cloak"
	default_ammo = /datum/ammo/rocket/recoilless/chemical/cloak

/obj/item/ammo_magazine/rocket/recoilless/plasmaloss
	name = "\improper 67mm 化学(缠足)弹"
	desc = "用于RL-160无后坐力步枪的化学弹.发射一枚低速炮弹,用于近距离施放化学气体,由于速度较低,友军可以轻松躲开.此弹头装有消耗等离子体的缠足烟雾.需要专用储存空间才能携带."
	icon_state = "shell_tanglefoot"
	default_ammo = /datum/ammo/rocket/recoilless/chemical/plasmaloss


//-------------------------------------------------------
//one use rpg

/obj/item/ammo_magazine/rocket/oneuse
	name = "\improper 68mm 高爆弹"
	desc = "一种用于为一次性火箭弹重新装填的火箭弹,需返回军械库进行装填."
	caliber = CALIBER_68MM
	icon_state = "rocket"
	w_class = WEIGHT_CLASS_BULKY
	max_rounds = 1
	default_ammo = /datum/ammo/rocket/oneuse
	reload_delay = 30

/obj/item/ammo_magazine/internal/launcher/rocket/oneuse
	name = "\improper 67mm 内管"
	desc = "一次性RPG的内管."
	caliber = CALIBER_68MM
	default_ammo = /datum/ammo/rocket/recoilless
	max_rounds = 1
	current_rounds = 0
	reload_delay = 30

//-------------------------------------------------------
//M5 RPG'S MEAN FUCKING COUSIN

/obj/item/ammo_magazine/rocket/m57a4
	name = "\improper 84mm 温压火箭弹阵列"
	desc = "用于RL-57四联发射器的温压火箭弹管.用尽后在手中激活可获得一些金属.火箭弹直接命中的伤害不高,但火焰效果很强.."
	caliber = CALIBER_ROCKETARRAY
	icon_state = "quad_rocket"
	max_rounds = 4
	default_ammo = /datum/ammo/rocket/wp/quad
	reload_delay = 10 SECONDS

/obj/item/ammo_magazine/rocket/m57a4/ds
	name = "\improper 84mm 温压火箭弹阵列"
	desc = "用于RL-57四联发射器的温压火箭弹管.用尽后在手中激活可获得一些金属.带有巨大的红色标记..."
	caliber = CALIBER_ROCKETARRAY
	icon_state = "quad_rocket"
	max_rounds = 4
	default_ammo = /datum/ammo/rocket/wp/quad/ds
	reload_delay = 2 SECONDS

/obj/item/ammo_magazine/internal/launcher/rocket/m57a4
	desc = "RL-57温压发射器的内管."
	caliber = CALIBER_ROCKETARRAY
	default_ammo = /datum/ammo/rocket/wp/quad
	max_rounds = 4

/obj/item/ammo_magazine/internal/launcher/rocket/m57a4/ds
	default_ammo = /datum/ammo/rocket/wp/quad/ds

//SOM RPG
/obj/item/ammo_magazine/rocket/som
	name = "\improper 84mm 高爆RPG"
	desc = "用于V-71火箭发射器的高爆弹头.在相当可观的范围内造成强烈爆炸."
	icon_state = "rpg_he"
	default_ammo = /datum/ammo/rocket/som
	reload_delay = 2 SECONDS
	bonus_overlay = "rpg_he"

/obj/item/ammo_magazine/rocket/som/light
	name = "\improper 84mm 轻型爆炸RPG"
	desc = "用于V-71火箭发射器的轻型爆炸弹头.在大范围内造成轻微爆炸,但冲击伤害较低."
	icon_state = "rpg_le"
	default_ammo = /datum/ammo/rocket/som/light
	reload_delay = 1 SECONDS
	bonus_overlay = "rpg_le"

/obj/item/ammo_magazine/rocket/som/heat
	name = "\improper 84mm 破甲RPG"
	desc = "用于V-71火箭发射器的高爆反装甲弹头.专为击穿最坚固的装甲而设计."
	icon_state = "rpg_heat"
	default_ammo = /datum/ammo/rocket/som/heat
	bonus_overlay = "rpg_heat"

/obj/item/ammo_magazine/rocket/som/thermobaric
	name = "\improper 84mm 温压RPG"
	desc = "用于V-71火箭发射器的温压弹头.在中等范围内造成强大的燃料空气爆炸."
	icon_state = "rpg_thermobaric"
	default_ammo = /datum/ammo/rocket/som/thermobaric
	bonus_overlay = "rpg_thermobaric"

/obj/item/ammo_magazine/rocket/som/rad
	name = "\improper 84mm 辐射RPG"
	desc = "用于V-71火箭发射器的辐射弹头.释放一次毁灭性的毫秒级辐射爆发,使爆炸半径内的任何目标衰弱."
	icon_state = "rpg_rad"
	default_ammo = /datum/ammo/rocket/som/rad
	bonus_overlay = "rpg_rad"

/obj/item/ammo_magazine/rocket/som/incendiary
	name = "\improper 84mm 燃烧RPG"
	desc = "用于V-71火箭发射器的燃烧弹头.释放白磷装药,在中等爆炸半径内烧毁一切."
	icon_state = "rpg_incendiary"
	default_ammo = /datum/ammo/rocket/wp/quad/som
	bonus_overlay = "rpg_incendiary"

//ICC RPG
/obj/item/ammo_magazine/rocket/icc
	name = "\improper 84mm 高爆管"
	desc = "用于MP-IRL火箭发射器的高爆弹头.在相当可观的范围内造成强烈爆炸."
	icon_state = "iccrpg_he"
	default_ammo = /datum/ammo/rocket/som
	reload_delay = 2 SECONDS
	bonus_overlay = "iccrpg_he"

/obj/item/ammo_magazine/rocket/icc/light
	name = "\improper 84mm 轻型爆炸管"
	desc = "用于MP-IRL火箭发射器的轻型爆炸弹头.在大范围内造成轻微爆炸,但冲击伤害较低."
	icon_state = "iccrpg_le"
	default_ammo = /datum/ammo/rocket/som/light
	reload_delay = 1 SECONDS
	bonus_overlay = "iccrpg_le"

/obj/item/ammo_magazine/rocket/icc/heat
	name = "\improper 84mm 破甲管"
	desc = "用于MP-IRL火箭发射器的高爆反装甲弹头.专为击穿最坚固的装甲而设计."
	icon_state = "iccrpg_heat"
	default_ammo = /datum/ammo/rocket/som/heat
	bonus_overlay = "iccrpg_heat"

/obj/item/ammo_magazine/rocket/icc/thermobaric
	name = "\improper 84mm 温压管"
	desc = "用于MP-IRL火箭发射器的温压弹头.在中等范围内造成强大的燃料空气爆炸."
	icon_state = "iccrpg_thermobaric"
	default_ammo = /datum/ammo/rocket/som/thermobaric
	bonus_overlay = "iccrpg_thermobaric"

//VSD RPG

/obj/item/ammo_magazine/rocket/vsd/he
	name = "\improper 84mm 高爆'反人员'弹壳"
	desc = "84mm反人员弹壳.标签上写着:'制造大爆炸'."
	icon_state = "c153_he"
	default_ammo = /datum/ammo/rocket/som
	reload_delay = 2 SECONDS
	bonus_overlay = "c153_he"

/obj/item/ammo_magazine/rocket/vsd/incendiary
	name = "\improper 84mm 燃烧'反人员'弹壳"
	desc = "84mm燃烧反人员弹壳.标签上写着:'让人发出AAAAAAAHH的惨叫'."
	icon_state = "c153_incendiary"
	default_ammo = /datum/ammo/rocket/wp/quad/som
	bonus_overlay = "c153_incendiary"

/obj/item/ammo_magazine/rocket/vsd/chemical
	name = "\improper 84mm 化学弹头'反人员'弹壳"
	desc = "化学封顶的84mm反人员弹壳.标签上写着:'让人他妈的去死'."
	icon_state = "c153_chemical"
	default_ammo = /datum/ammo/rocket/recoilless/chemical/harmgas/vsd
	bonus_overlay = "c153_chemical"

// railgun

/obj/item/ammo_magazine/railgun
	name = "电磁炮罐(尾翼稳定脱壳穿甲弹)"
	desc = "一个装有用于电磁炮内部的钨弹丸的罐体.罐体上写着APDS.此弹会穿透大多数装甲,但不会留下太大的孔洞."
	caliber = CALIBER_RAILGUN
	icon = 'icons/obj/items/ammo/misc.dmi'
	icon_state = "railgun"
	default_ammo = /datum/ammo/bullet/railgun
	max_rounds = 3
	reload_delay = 20 //Hard to reload.
	w_class = WEIGHT_CLASS_NORMAL
	icon_state_mini = "mag_railgun"

/obj/item/ammo_magazine/railgun/hvap
	name = "电磁炮罐(高速穿甲弹)"
	desc = "一个装有钨制弹丸的罐体,用于轨道炮内部.罐体上印有HVAP字样.这种弹药的穿透力不如其他轨道炮弹药类型,但会在目标装甲上留下相当大的孔洞."
	icon_state = "railgun_hvap"
	icon_state_mini = "mag_railgun_blue"
	default_ammo = /datum/ammo/bullet/railgun/hvap

/obj/item/ammo_magazine/railgun/smart
	name = "轨道炮弹药罐(智能穿甲)"
	desc = "一个装有钨制弹丸的罐体,用于轨道炮内部.罐体上印有SAP字样.由于智能弹药的初速较低,这种弹药的穿透力较差,但会因冲击力使目标严重踉跄和眩晕."
	icon_state = "railgun_smart"
	icon_state_mini = "mag_railgun_green"
	default_ammo = /datum/ammo/bullet/railgun/smart

// pepperball

/obj/item/ammo_magazine/rifle/pepperball
	name = "胡椒球罐(SAN球)"
	desc = "一个装有弹丸的罐体,用于胡椒球枪."
	caliber = CALIBER_PEPPERBALL
	icon = 'icons/obj/items/ammo/misc.dmi'
	icon_state = "pepperball"
	default_ammo = /datum/ammo/bullet/pepperball
	max_rounds = 100
	w_class = WEIGHT_CLASS_NORMAL
	icon_state_mini = "mag_pepperball"

/obj/item/ammo_magazine/rifle/pepperball/pepperball_mini
	name = "小型胡椒球罐(SAN球)"
	desc = "用于微型胡椒球枪的小型罐体."
	icon_state = "pepperball_mini"
	default_ammo = /datum/ammo/bullet/pepperball/pepperball_mini
	max_rounds = 20
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_magazine/minigun_powerpack
	name = "\improper MG-100维护者动力背包"
	desc = "一个重型加固背包,内含支援设备,电池和MG-100转轮机枪系统的备用弹药.\nClick左上角的图标来为你的MG-100重新装填."
	icon = 'icons/obj/items/ammo/powerpack.dmi'
	icon_state = "powerpack"
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BACK
	magazine_flags = MAGAZINE_WORN
	w_class = WEIGHT_CLASS_HUGE
	default_ammo = /datum/ammo/bullet/minigun
	current_rounds = 600
	max_rounds = 600
	item_map_variant_flags = (ITEM_JUNGLE_VARIANT|ITEM_ICE_VARIANT|ITEM_PRISON_VARIANT)

/obj/item/ammo_magazine/minigun_powerpack/snow
	icon_state = "s_powerpack"
	item_map_variant_flags = null

/obj/item/ammo_magazine/minigun_powerpack/fancy
	icon_state = "powerpackw"
	item_map_variant_flags = null

/obj/item/ammo_magazine/minigun_powerpack/merc
	icon_state = "powerpackp"
	item_map_variant_flags = null

/obj/item/ammo_magazine/minigun_powerpack/smartgun
	name = "\improper SG-85动力背包"
	desc = "一个加固背包,装满了IFF修改弹药,内置微型发电机和大量冷却系统,使SG-85加特林机枪能够运作.\nUse背包上的SG-85来将它们连接."
	icon_state = "powerpacksg"
	magazine_flags = MAGAZINE_WORN|MAGAZINE_REFILLABLE
	default_ammo = /datum/ammo/bullet/smart_minigun
	current_rounds = 1000
	max_rounds = 1000
	caliber = CALIBER_10X26_CASELESS
	item_map_variant_flags = null

//"External magazine" for the wheelchair-mounted minigun
/obj/item/ammo_magazine/minigun_wheelchair
	name = "\improper 固定式MG-100维护者弹药架"
	desc = "一个装满弹药的箱子.似乎是定制设计,可插入供弹系统."
	icon = 'icons/obj/items/ammo/stationary.dmi'
	icon_state = "minigun"
	atom_flags = CONDUCT
	magazine_flags = MAGAZINE_REFILLABLE
	equip_slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	default_ammo = /datum/ammo/bullet/minigun
	current_rounds = 1000
	max_rounds = 1000
	reload_delay = 0.75 SECONDS

// ICC coilgun

/obj/item/ammo_magazine/rifle/icc_coilgun
	name = "线圈炮弹药罐"
	desc = "一个装有钨制弹丸的罐体,用于线圈炮.大概能穿透几乎所有东西."
	caliber = CALIBER_RAILGUN
	icon_state = "coilgun"
	default_ammo = /datum/ammo/bullet/coilgun
	max_rounds = 5
	reload_delay = 10
	icon_state_mini = "mag_dmr"
