// ammo boxes

/obj/item/ammo_magazine/packet
	name = "一盒某种弹药"
	desc = "一个装有某种弹药的包裹."
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
	name = "一盒10x24毫米全金属被甲弹"
	desc = "一盒装有150发10x24毫米无壳弹."
	caliber = CALIBER_10X24_CASELESS
	icon_state = "box_10x24mm"
	ammo_band_icon = "box_10x24mm_band"
	default_ammo = /datum/ammo/bullet/rifle
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/p602x41
	name = "一盒6.02x41毫米"
	desc = "一盒装有125发6.02x41毫米."
	caliber = CALIBER_602X41
	icon_state = "box_602x41"
	default_ammo = /datum/ammo/bullet/rifle/type16
	current_rounds = 125
	max_rounds = 125

/obj/item/ammo_magazine/packet/pnato
	name = "一盒5.56x45毫米"
	desc = "一盒装有150发5.56x45毫米."
	caliber = CALIBER_556X45
	icon_state = "box_556mm"
	default_ammo = /datum/ammo/bullet/rifle
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/p10x265mm
	name = "一盒10x26.5毫米"
	desc = "一盒装有100发10x26.5毫米无壳弹."
	caliber = CALIBER_10X265_CASELESS
	icon_state = "box_10x265mm"
	default_ammo = /datum/ammo/bullet/rifle/br64
	current_rounds = 100
	max_rounds = 100

/obj/item/ammo_magazine/packet/p10x27mm
	name = "一盒10x27毫米"
	desc = "一盒装有100发10x27毫米无壳弹."
	caliber = CALIBER_10X27_CASELESS
	icon_state = "box_10x27mm"
	default_ammo = /datum/ammo/bullet/rifle/dmr37
	current_rounds = 100
	max_rounds = 100

/obj/item/ammo_magazine/packet/p10x25mm
	name = "一盒10x25毫米全金属被甲弹"
	desc = "一盒装有125发10x25毫米无壳弹."
	caliber = CALIBER_10X25_CASELESS
	icon_state = "box_10x25mm"
	ammo_band_icon = "box_10x25mm_band"
	default_ammo = /datum/ammo/bullet/rifle/heavy
	current_rounds = 125
	max_rounds = 125

/obj/item/ammo_magazine/packet/p492x34mm
	name = "一盒4.92x34毫米"
	desc = "一盒装有210发4.92x34毫米无壳弹."
	caliber = CALIBER_492X34_CASELESS
	icon_state = "box_492x34mm"
	default_ammo = /datum/ammo/bullet/rifle/hv
	current_rounds = 210
	max_rounds = 210

/obj/item/ammo_magazine/packet/p86x70mm
	name = "一盒8.6x70毫米"
	desc = "一盒装有50发8.6x70毫米无壳弹."
	caliber = CALIBER_86X70
	icon_state = "box_86x70mm"
	default_ammo = /datum/ammo/bullet/sniper/pfc
	current_rounds = 50
	max_rounds = 50

/obj/item/ammo_magazine/packet/smart_minigun
	name = "SG-85弹药箱"
	desc = "一个沉重的容器,里面塞得满满当当,装有500发SG-85动力包弹药."
	icon_state = "box_smartminigun"
	default_ammo = /datum/ammo/bullet/smart_minigun
	caliber = CALIBER_10X26_CASELESS
	current_rounds = 500
	max_rounds = 500

/obj/item/ammo_magazine/packet/scout_rifle
	name = "一盒A19高速子弹"
	desc = "一盒装有150发A19超压高速弹."
	icon_state = "box_tx8"
	default_ammo = /datum/ammo/bullet/rifle/tx8
	caliber = CALIBER_10X28_CASELESS
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/scout_rifle/impact
	name = "一盒A19高速冲击子弹"
	desc = "一盒装有150发A19冲击高速弹."
	icon_state = "box_tx8_impact"
	default_ammo = /datum/ammo/bullet/rifle/tx8/impact

/obj/item/ammo_magazine/packet/scout_rifle/incendiary
	name = "一盒A19高速燃烧子弹"
	desc = "一盒装有150发A19燃烧高速弹."
	icon_state = "box_tx8_incendiary"
	default_ammo = /datum/ammo/bullet/rifle/tx8/incendiary

/obj/item/ammo_magazine/packet/sr81
	name = "一盒低压8.6x70毫米"
	desc = "一盒装有120发8.6x70毫米低速弹."
	icon_state = "box_t81"
	default_ammo = /datum/ammo/bullet/sniper/auto
	caliber = CALIBER_86X70
	current_rounds = 100
	max_rounds = 100

/obj/item/ammo_magazine/packet/standardautoshotgun
	name = "一盒16号霰弹独头弹"
	desc = "一盒装有16号独头弹,看起来能装进SH-15."
	icon_state = "box_16gslug"
	default_ammo = /datum/ammo/bullet/shotgun/sh15_slug
	caliber = CALIBER_16G
	current_rounds = 60
	max_rounds = 60

/obj/item/ammo_magazine/packet/standardautoshotgun/flechette
	name = "一盒16号霰弹飞镖弹"
	desc = "一盒装有16号飞镖弹,看起来能装进SH-15."
	icon_state = "box_16gflech"
	default_ammo = /datum/ammo/bullet/shotgun/sh15_flechette

// pistol packets

/obj/item/ammo_magazine/packet/p9mm
	name = "一包9毫米"
	desc = "一包装有70发9毫米."
	caliber = CALIBER_9X19
	icon_state = "box_9mm"
	ammo_band_icon = "box_9mm_band"
	current_rounds = 70
	max_rounds = 70
	w_class = WEIGHT_CLASS_SMALL
	default_ammo = /datum/ammo/bullet/pistol

/obj/item/ammo_magazine/packet/magnum
	name = "一包.44马格南"
	desc = "一包装有49发.44马格南."
	icon_state = "box_44mag" //Maybe change this
	default_ammo = /datum/ammo/bullet/revolver/r44
	caliber = CALIBER_44
	current_rounds = 49
	max_rounds = 49
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_magazine/packet/mateba
	name = "一包.454卡苏尔"
	desc = "一包装有42发.454卡苏尔."
	icon_state = "box_454"
	default_ammo = /datum/ammo/bullet/revolver/highimpact
	caliber = CALIBER_454
	current_rounds = 42
	max_rounds = 42

/obj/item/ammo_magazine/packet/acp
	name = "一盒手枪.45 ACP"
	desc = "一包装有50发手枪.45 ACP."
	icon_state = "box_.45acp"
	default_ammo = /datum/ammo/bullet/smg/acp
	caliber = CALIBER_45ACP
	current_rounds = 160
	max_rounds = 160

/obj/item/ammo_magazine/packet/rifle762x39
	name = "一盒7.62X39"
	desc = "一盒装有150发7.62x39毫米."
	icon_state = "box_7.62x39mm"
	default_ammo = /datum/ammo/bullet/rifle/mpi_km
	caliber = CALIBER_762X39
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/svd762x54mmR
	name = "一盒7.62X54"
	icon_state = "box_7.62x54mm"
	default_ammo = /datum/ammo/bullet/sniper/svd
	caliber = CALIBER_762X54
	current_rounds = 50
	max_rounds = 50

/obj/item/ammo_magazine/packet/p9mm/incendiary
	name = "一包9毫米燃烧弹"
	desc = "一包装有70发9毫米燃烧弹."
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY
	default_ammo = /datum/ammo/bullet/pistol/incendiary

/obj/item/ammo_magazine/packet/p10x26mm
	name = "一包10x26毫米"
	desc = "一包内含100发10x26mm无壳弹."
	icon_state = "box_10x26mm"
	caliber = CALIBER_10X26_CASELESS
	default_ammo = /datum/ammo/bullet/rifle/machinegun
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 100
	max_rounds = 100

/obj/item/ammo_magazine/packet/p10x20mm
	name = "一包10x20mm"
	desc = "一包内含240发10x20mm无壳弹."
	icon_state = "box_10x20mm"
	caliber = CALIBER_10X20_CASELESS
	default_ammo = /datum/ammo/bullet/smg
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 240
	max_rounds = 240

/obj/item/ammo_magazine/packet/p4570
	name = "一包.45-70"
	desc = "一包内含50发.45-70 Government弹."
	caliber = CALIBER_4570
	icon_state = "box_4570rim_mag"
	icon_state_mini = "ammo_packet_blue"
	default_ammo = /datum/ammo/bullet/rifle/repeater
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 50
	max_rounds = 50

/obj/item/ammo_magazine/packet/p380acp
	name = "一包.380 ACP"
	desc = "一包内含210发.380 ACP弹."
	caliber = CALIBER_380ACP
	icon_state = "box_380acp"
	default_ammo = /datum/ammo/bullet/pistol/tiny/ap
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 210
	max_rounds = 210

/obj/item/ammo_magazine/packet/long_special
	name = "一盒.44 Long Special"
	desc = "一包内含40发.44 Long Special弹."
	icon_state = "44LSbox"
	default_ammo = /datum/ammo/bullet/revolver/rifle
	caliber = CALIBER_44LS
	current_rounds = 40
	icon_state_mini = "44LSbox"
	max_rounds = 40

/obj/item/ammo_magazine/packet/t25
	name = "一盒10x26mm高压弹"
	desc = "一盒内含300发10x26mm 'HP'无壳弹,专为智能枪调校."
	icon_state = "box_t25"
	default_ammo = /datum/ammo/bullet/rifle/t25
	caliber = CALIBER_10X26_CASELESS
	current_rounds = 300
	max_rounds = 300

/obj/item/ammo_magazine/packet/acp_smg
	name = "一盒.45 ACP空尖弹"
	desc = "一盒内含常见的.45 ACP空尖弹."
	icon_state = "box_45acp"
	default_ammo = /datum/ammo/bullet/smg/acp
	w_class = WEIGHT_CLASS_SMALL
	caliber = CALIBER_45ACP
	current_rounds = 120
	max_rounds = 120

/obj/item/ammo_magazine/packet/t500
	name = "一包.500 Nigro Express"
	icon_state = "boxt500"
	default_ammo = /datum/ammo/bullet/revolver/t500
	caliber = CALIBER_500
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 50
	max_rounds = 50
	used_casings = 5

/obj/item/ammo_magazine/packet/t500/qk
	name = "一包.500 'Queen Killer'"
	icon_state = "boxt500_qk"
	default_ammo = /datum/ammo/bullet/revolver/t500/qk

/obj/item/ammo_magazine/packet/t500/slavs
	name = "一包.500 'Slavs'"
	icon_state = "boxt500_sv"
	default_ammo = /datum/ammo/bullet/revolver/t500/slavs

/obj/item/ammo_magazine/packet/t312
	name = "一包.500 White Express"
	desc = "一盒内含常见的.500 White Express弹."
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
	name = "一包.500肾上腺素EMB"
	desc = "含有肾上腺素. 这些弹药对患者的神经系统和心脏有刺激作用,能够将陆战队员从危急状态中救回,还能让他比平时跑得更久."
	icon_state = "boxt500_adr"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/adrenaline

/obj/item/ammo_magazine/packet/t312/med/rr
	name = "一包.500 Russian Red EMB"
	desc = "含有5单位Russian Red. 仅在绝对必要时使用. 能治疗大量物理伤害,但会造成克隆损失伤害."
	icon_state = "boxt500_rr"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/rr

/obj/item/ammo_magazine/packet/t312/med/md
	name = "一包.500 Meraderm EMB"
	desc = "最好的EMB弹药,能治疗患者的多种伤势且无任何副作用. 含有2.5单位Meralyne和2.5单位Dermaline."
	icon_state = "boxt500_md"
	default_ammo = /datum/ammo/bullet/revolver/t312/med/md

/obj/item/ammo_magazine/packet/t312/med/neu
	name = "一包.500 Neuraline EMB"
	desc = "含有3.1单位Neuraline和1.9单位Hyronalin. 警告: 虽然该子弹能够将陆战队员从危急状态中救回,但无法中和Neuraline带来的所有毒素."
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
	name = "一包.41 AE碎甲弹"
	desc = "一包内含160发.41 AE碎甲弹."
	caliber = CALIBER_41AE
	icon_state = "41AE_squash"
	default_ammo = /datum/ammo/bullet/smg/squash
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 165
	max_rounds = 165
