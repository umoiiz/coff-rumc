// ammo boxes

/obj/item/ammo_magazine/packet
	name = "某种弹药的盒子"
	desc = "一包装有某种弹药的盒子."
	icon = 'icons/obj/items/ammo/packet.dmi'
	icon_state_mini = "ammo_packet"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_magazine/packet/attack_hand_alternate(mob/living/user)
	. = ..()
	if(current_rounds <= 0)
		balloon_alert(user, "空")
		return
	create_handful(user)

/obj/item/ammo_magazine/packet/p10x24mm
	name = "10x24mm全金属被甲弹盒"
	desc = "一盒装有150发10x24mm无壳弹."
	caliber = CALIBER_10X24_CASELESS
	icon_state = "box_10x24mm"
	ammo_band_icon = "box_10x24mm_band"
	default_ammo = /datum/ammo/bullet/rifle
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/p602x41
	name = "6.02x41mm弹盒"
	desc = "一盒装有125发6.02x41mm."
	caliber = CALIBER_602X41
	icon_state = "box_602x41"
	default_ammo = /datum/ammo/bullet/rifle/type16
	current_rounds = 125
	max_rounds = 125

/obj/item/ammo_magazine/packet/pnato
	name = "5.56x45mm弹盒"
	desc = "一盒装有150发5.56x45mm."
	caliber = CALIBER_556X45
	icon_state = "box_556mm"
	default_ammo = /datum/ammo/bullet/rifle
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/p10x265mm
	name = "10x26.5mm弹盒"
	desc = "一盒装有100发10x26.5mm无壳弹."
	caliber = CALIBER_10X265_CASELESS
	icon_state = "box_10x265mm"
	default_ammo = /datum/ammo/bullet/rifle/br64
	current_rounds = 100
	max_rounds = 100

/obj/item/ammo_magazine/packet/p10x27mm
	name = "10x27mm弹盒"
	desc = "一盒装有100发10x27mm无壳弹."
	caliber = CALIBER_10X27_CASELESS
	icon_state = "box_10x27mm"
	default_ammo = /datum/ammo/bullet/rifle/dmr37
	current_rounds = 100
	max_rounds = 100

/obj/item/ammo_magazine/packet/p10x25mm
	name = "10x25mm全金属被甲弹盒"
	desc = "一盒装有125发10x25mm无壳弹."
	caliber = CALIBER_10X25_CASELESS
	icon_state = "box_10x25mm"
	ammo_band_icon = "box_10x25mm_band"
	default_ammo = /datum/ammo/bullet/rifle/heavy
	current_rounds = 125
	max_rounds = 125

/obj/item/ammo_magazine/packet/p492x34mm
	name = "4.92x34mm弹盒"
	desc = "一盒装有210发4.92x34mm无壳弹."
	caliber = CALIBER_492X34_CASELESS
	icon_state = "box_492x34mm"
	default_ammo = /datum/ammo/bullet/rifle/hv
	current_rounds = 210
	max_rounds = 210

/obj/item/ammo_magazine/packet/p86x70mm
	name = "8.6x70mm弹盒"
	desc = "一盒装有50发8.6x70mm无壳弹."
	caliber = CALIBER_86X70
	icon_state = "box_86x70mm"
	default_ammo = /datum/ammo/bullet/sniper/pfc
	current_rounds = 50
	max_rounds = 50

/obj/item/ammo_magazine/packet/smart_minigun
	name = "SG-85弹药箱"
	desc = "一个沉重的容器,里面塞得满满当当,装有500发SG-85能量包弹药."
	icon_state = "box_smartminigun"
	default_ammo = /datum/ammo/bullet/smart_minigun
	caliber = CALIBER_10X26_CASELESS
	current_rounds = 500
	max_rounds = 500

/obj/item/ammo_magazine/packet/scout_rifle
	name = "A19高速弹盒"
	desc = "一盒装有150发A19超压高速弹."
	icon_state = "box_tx8"
	default_ammo = /datum/ammo/bullet/rifle/tx8
	caliber = CALIBER_10X28_CASELESS
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/scout_rifle/impact
	name = "A19高速冲击弹盒"
	desc = "一盒装有150发A19冲击高速弹."
	icon_state = "box_tx8_impact"
	default_ammo = /datum/ammo/bullet/rifle/tx8/impact

/obj/item/ammo_magazine/packet/scout_rifle/incendiary
	name = "A19高速燃烧弹盒"
	desc = "一盒装有150发A19燃烧高速弹."
	icon_state = "box_tx8_incendiary"
	default_ammo = /datum/ammo/bullet/rifle/tx8/incendiary

/obj/item/ammo_magazine/packet/sr81
	name = "低压8.6x70mm弹盒"
	desc = "一盒装有120发8.6x70mm低速弹."
	icon_state = "box_t81"
	default_ammo = /datum/ammo/bullet/sniper/auto
	caliber = CALIBER_86X70
	current_rounds = 100
	max_rounds = 100

/obj/item/ammo_magazine/packet/standardautoshotgun
	name = "16号霰弹独头弹盒"
	desc = "一盒装有16号独头弹,看起来能装进SH-15."
	icon_state = "box_16gslug"
	default_ammo = /datum/ammo/bullet/shotgun/sh15_slug
	caliber = CALIBER_16G
	current_rounds = 60
	max_rounds = 60

/obj/item/ammo_magazine/packet/standardautoshotgun/flechette
	name = "16号霰弹箭形弹盒"
	desc = "一盒装有16号箭形弹,看起来能装进SH-15."
	icon_state = "box_16gflech"
	default_ammo = /datum/ammo/bullet/shotgun/sh15_flechette

// pistol packets

/obj/item/ammo_magazine/packet/p9mm
	name = "9mm弹包"
	desc = "一包装有70发9mm."
	caliber = CALIBER_9X19
	icon_state = "box_9mm"
	ammo_band_icon = "box_9mm_band"
	current_rounds = 70
	max_rounds = 70
	w_class = WEIGHT_CLASS_SMALL
	default_ammo = /datum/ammo/bullet/pistol

/obj/item/ammo_magazine/packet/magnum
	name = ".44马格南弹包"
	desc = "一包装有49发.44马格南."
	icon_state = "box_44mag" //Maybe change this
	default_ammo = /datum/ammo/bullet/revolver/r44
	caliber = CALIBER_44
	current_rounds = 49
	max_rounds = 49
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_magazine/packet/mateba
	name = ".454卡苏尔弹包"
	desc = "一包装有42发.454卡苏尔."
	icon_state = "box_454"
	default_ammo = /datum/ammo/bullet/revolver/highimpact
	caliber = CALIBER_454
	current_rounds = 42
	max_rounds = 42

/obj/item/ammo_magazine/packet/acp
	name = ".45 ACP手枪弹盒"
	desc = "一包装有50发.45 ACP手枪弹."
	icon_state = "box_.45acp"
	default_ammo = /datum/ammo/bullet/smg/acp
	caliber = CALIBER_45ACP
	current_rounds = 160
	max_rounds = 160

/obj/item/ammo_magazine/packet/rifle762x39
	name = "7.62X39弹盒"
	desc = "一盒装有150发7.62x39mm."
	icon_state = "box_7.62x39mm"
	default_ammo = /datum/ammo/bullet/rifle/mpi_km
	caliber = CALIBER_762X39
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/svd762x54mmR
	name = "7.62X54弹盒"
	icon_state = "box_7.62x54mm"
	default_ammo = /datum/ammo/bullet/sniper/svd
	caliber = CALIBER_762X54
	current_rounds = 50
	max_rounds = 50

/obj/item/ammo_magazine/packet/p9mm/incendiary
	name = "9mm燃烧弹包"
	desc = "一包装有70发9mm燃烧弹."
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY
	default_ammo = /datum/ammo/bullet/pistol/incendiary

/obj/item/ammo_magazine/packet/p10x26mm
	name = "10x26mm弹包"
	desc = "一包装有100发10x26mm无壳弹."
	icon_state = "box_10x26mm"
	caliber = CALIBER_10X26_CASELESS
	default_ammo = /datum/ammo/bullet/rifle/machinegun
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 100
	max_rounds = 100

/obj/item/ammo_magazine/packet/p10x20mm
	name = "10x20mm弹包"
	desc = "一包装有240发10x20mm无壳弹."
	icon_state = "box_10x20mm"
	caliber = CALIBER_10X20_CASELESS
	default_ammo = /datum/ammo/bullet/smg
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 240
	max_rounds = 240

/obj/item/ammo_magazine/packet/p4570
	name = ".45-70弹包"
	desc = "一包装有50发.45-70政府型."
	caliber = CALIBER_4570
	icon_state = "box_4570rim_mag"
	icon_state_mini = "ammo_packet_blue"
	default_ammo = /datum/ammo/bullet/rifle/repeater
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 50
	max_rounds = 50

/obj/item/ammo_magazine/packet/p380acp
	name = ".380 ACP弹包"
	desc = "一包装有210发.380 ACP."
	caliber = CALIBER_380ACP
	icon_state = "box_380acp"
	default_ammo = /datum/ammo/bullet/pistol/tiny/ap
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 210
	max_rounds = 210

/obj/item/ammo_magazine/packet/long_special
	name = ".44长特种弹盒"
	desc = "一包装有40发.44长特种弹."
	icon_state = "44LSbox"
	default_ammo = /datum/ammo/bullet/revolver/rifle
	caliber = CALIBER_44LS
	current_rounds = 40
	icon_state_mini = "44LSbox"
	max_rounds = 40

/obj/item/ammo_magazine/packet/t25
	name = "10x26mm高压弹盒"
	desc = "一盒装有300发为智能枪调校的10x26mm'HP'无壳弹."
	icon_state = "box_t25"
	default_ammo = /datum/ammo/bullet/rifle/t25
	caliber = CALIBER_10X26_CASELESS
	current_rounds = 300
	max_rounds = 300

/obj/item/ammo_magazine/packet/acp_smg
	name = ".45 ACP空尖弹盒"
	desc = "一盒装有常见的.45 ACP空尖弹."
	icon_state = "box_45acp"
	default_ammo = /datum/ammo/bullet/smg/acp
	w_class = WEIGHT_CLASS_SMALL
	caliber = CALIBER_45ACP
	current_rounds = 120
	max_rounds = 120

/obj/item/ammo_magazine/packet/t500
	name = ".500尼格罗快车弹包"
	icon_state = "boxt500"
	default_ammo = /datum/ammo/bullet/revolver/t500
	caliber = CALIBER_500
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 50
	max_rounds = 50
	used_casings = 5

/obj/item/ammo_magazine/packet/t500/qk
	name = ".500'女王杀手'弹包"
	icon_state = "boxt500_qk"
	default_ammo = /datum/ammo/bullet/revolver/t500/qk

/obj/item/ammo_magazine/packet/t500/slavs
	name = ".500'斯拉夫'弹包"
	icon_state = "boxt500_sv"
	default_ammo = /datum/ammo/bullet/revolver/t500/slavs

/obj/item/ammo_magazine/packet/t312
	name = ".500白色快车弹包"
	desc = "一盒装有常见的.500白色快车弹."
	icon_state = "boxt500_we"
	default_ammo = /datum/ammo/bullet/revolver/t312
	caliber = CALIBER_500_EMB
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 50
	max_rounds = 50
	used_casings = 5

/obj/item/ammo_magazine/packet/t312/Initialize(mapload)
	. = ..()
	if(prob(1))
		icon_state = "boxt500_ke"

/obj/item/ammo_magazine/packet/t312/med
	used_casings = 1

/obj/item/ammo_magazine/packet/t312/med/adrenaline
	name = ".500肾上腺素EMB弹包"
	desc = "含有肾上腺素.这些弹药对患者的神经系统和心脏有刺激作用,能够将一名陆战队员从危急状态中救回,还能让他比平常跑得更久."
	icon_state = "boxt500_adr"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/adrenaline

/obj/item/ammo_magazine/packet/t312/med/rr
	name = ".500俄罗斯红EMB弹包"
	desc = "含有5单位俄罗斯红.仅在绝对必要时使用.能治疗大量物理伤害,但会造成克隆损伤."
	icon_state = "boxt500_rr"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/rr

/obj/item/ammo_magazine/packet/t312/med/md
	name = ".500 Meraderm EMB弹包"
	desc = "最好的EMB弹药,能治疗多名患者的伤势且无任何副作用.含有2.5单位Meralyne和2.5单位Dermaline."
	icon_state = "boxt500_md"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/md

/obj/item/ammo_magazine/packet/t312/med/neu
	name = "一包.500 Neuraline EMB"
	desc = "含有3.1单位Neuraline和1.9单位Hyronalin.警告:虽然该子弹能够使陆战队员脱离濒死状态,但无法中和Neuraline产生的所有毒素."
	icon_state = "boxt500_neu"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/neu

/obj/item/ammo_magazine/packet/standard_magnum
	name = "一包.12x7mm"
	icon_state = "box_t76"
	default_ammo = /datum/ammo/bullet/revolver/t76
	caliber = CALIBER_12X7
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 50
	max_rounds = 50
	used_casings = 5

/obj/item/ammo_magazine/packet/p10x20mm/ap
	desc = "一包内含240发10x20mm无壳弹."
	icon_state = "box_10x20mm_ap"
	default_ammo = /datum/ammo/bullet/smg/ap

/obj/item/ammo_magazine/packet/sg62
	name = "一盒10x27mm"
	desc = "一盒内含200发10x27mm无壳弹."
	icon_state = "box_sg62"
	default_ammo = /datum/ammo/bullet/sg62
	caliber = CALIBER_10X27_CASELESS
	current_rounds = 200
	max_rounds = 200

/obj/item/ammo_magazine/packet/sg153
	name = "一盒12.7mm智能马格南"
	desc = "一盒内含25发12.7mm观测步枪弹."
	icon_state = "sg153"
	default_ammo = /datum/ammo/bullet/sg153
	caliber = CALIBER_12X7
	current_rounds = 25
	max_rounds = 25

/obj/item/ammo_magazine/packet/musket
	name = "一袋火枪铅弹"
	desc = "一袋装满铅弹的袋子."
	icon_state = "musket_sack_m"
	default_ammo = /datum/ammo/bullet/sniper/musket
	max_rounds = 54
	caliber = CALIBER_19MM
	icon_state_mini = "musket_sack_m"

/obj/item/ammo_magazine/packet/musket/small
	name = "一小袋火枪铅弹"
	desc = "一小袋装满铅弹的袋子."
	icon_state = "musket_sack_s"
	max_rounds = 27
	w_class = WEIGHT_CLASS_SMALL
	icon_state_mini = "musket_sack_s"

/obj/item/ammo_magazine/packet/p41ae
	name = "一包.41 AE"
	desc = "一包内含160发.41 AE弹."
	caliber = CALIBER_41AE
	icon_state = "41AE"
	default_ammo = /datum/ammo/bullet/smg/heavy
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 165
	max_rounds = 165

/obj/item/ammo_magazine/packet/p41ae_squashhead
	name = "一包.41 AE平头弹"
	desc = "一包内含160发.41 AE平头弹."
	caliber = CALIBER_41AE
	icon_state = "41AE_squash"
	default_ammo = /datum/ammo/bullet/smg/squash
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 165
	max_rounds = 165
