//A way to give them everything at once that still works with loadouts would be nice, but barring that make sure that your point calculation is set up so they don't get more than what they're supposed to
GLOBAL_LIST_INIT(smartgunner_gear_listed_products, list(
	/obj/item/clothing/glasses/night/m56_goggles = list(CAT_ESS, "KLTD智能护目镜", 0, "white"),
	/obj/item/weapon/gun/rifle/sg29 = list(CAT_SGSUP, "SG-29智能机枪", 29, "orange"), //If a smartgunner buys a SG-29, then they will have 16 points to purchase 4 SG-29 drums
	/obj/item/ammo_magazine/sg29 = list(CAT_SGSUP, "SG-29弹药鼓", 4, "orange"),
	/obj/item/weapon/gun/minigun/smart_minigun = list(CAT_SGSUP, "SG-85智能手持加特林机枪", 27, "red"), //If a smartgunner buys a SG-85, then they should be able to buy only 1 powerpack and 2 ammo bins
	/obj/item/ammo_magazine/minigun_powerpack/smartgun = list(CAT_SGSUP, "SG-85电源包", 10, "orange2"),
	/obj/item/ammo_magazine/packet/smart_minigun = list(CAT_SGSUP, "SG-85弹药箱", 4, "orange2"),
	/obj/item/weapon/gun/rifle/t25 = list(CAT_SGSUP, "T-25智能步枪", 26, "red"), //If smartganner buys a t25 , then they will have 2 mag and 3 ammo box
	/obj/item/ammo_magazine/rifle/t25 =  list(CAT_SGSUP, "T-25智能步枪弹匣", 2, "orange2"),
	/obj/item/ammo_magazine/packet/t25 = list(CAT_SGSUP, "T-25智能步枪弹药箱", 5, "orange2"),
	/obj/item/weapon/gun/rifle/sg62 = list(CAT_SGSUP, "SG-62目标步枪", 25, "red"), //If a SG buys a SG-62, they'll have 15 points left, should be enough to buy some mags and or extra SR ammo.
	/obj/item/ammo_magazine/rifle/sg62 = list(CAT_SGSUP, "SG-62目标步枪弹匣", 3, "orange2"),
	/obj/item/ammo_magazine/packet/sg62 = list(CAT_SGSUP, "SG-62智能目标步枪弹药箱", 5, "orange2"),
	/obj/item/ammo_magazine/packet/sg153 = list(CAT_SGSUP, "SG-153观测步枪弹药箱", 4, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153 = list(CAT_SGSUP, "SG-153观测步枪弹匣", 2, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153/highimpact = list(CAT_SGSUP, "SG-153观测步枪高冲击弹匣", 2, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153/heavyrubber = list(CAT_SGSUP, "SG-153观测步枪重型橡胶弹匣", 2, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153/tungsten = list(CAT_SGSUP, "SG-153观测步枪钨芯弹匣", 2, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153/flak = list(CAT_SGSUP, "SG-153观测步枪防空弹匣", 2, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153/plasmaloss = list(CAT_SGSUP, "SG-153观测步枪缠绕弹匣", 3, "orange2"),
	/obj/item/ammo_magazine/rifle/sg153/incendiary = list(CAT_SGSUP, "SG-153观测步枪燃烧弹匣", 3, "orange2"),
	/obj/item/ammo_magazine/pistol/p14/smart_pistol = list(CAT_SGSUP, "SP-13智能手枪弹药", 2, "orange2"),
))
