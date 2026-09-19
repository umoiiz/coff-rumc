/obj/item/storage/belt
	name = "腰带"
	desc = "可以装各种东西."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utilitybelt"
	worn_icon_state = "utility"
	worn_icon_state_worn = TRUE
	equip_slot_flags = ITEM_SLOT_BELT
	attack_verb = list("whips", "lashes", "disciplines")
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/belt

/obj/item/storage/belt/equipped(mob/user, slot)
	if(slot == SLOT_BELT)
		mouse_opacity = 2 //so it's easier to click when properly equipped.
	return ..()

/obj/item/storage/belt/dropped(mob/user)
	mouse_opacity = initial(mouse_opacity)
	return ..()

/obj/item/storage/belt/vendor_equip(mob/user)
	. = ..()
	return user.equip_to_appropriate_slot(src)

/obj/item/storage/belt/champion
	name = "冠军腰带"
	desc = "向世界证明你是最强的!"
	icon_state = "championbelt"
	worn_icon_state = "champion"
	storage_type = /datum/storage/belt/champion

/*============================//MARINE BELTS\\==================================
=======================================================================*/

/obj/item/storage/belt/utility
	name = "\improper M276型工具腰带挂具" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "M276是TGMC的标准负重装备.它由一条带有各种卡扣的模块化腰带组成.这个版本没有任何战斗功能,通常被工程师用来运输重要工具."
	icon_state = "utilitybelt"
	worn_icon_state = "utility"
	storage_type = /datum/storage/belt/utility

/obj/item/storage/belt/utility/full/PopulateContents()
	new /obj/item/tool/screwdriver (src)
	new /obj/item/tool/wirecutters (src)
	new /obj/item/tool/weldingtool (src)
	new /obj/item/tool/wrench (src)
	new /obj/item/tool/crowbar (src)
	new /obj/item/stack/cable_coil(src, 30, pick("red", "yellow", "orange"))
	new /obj/item/tool/multitool(src)

/obj/item/storage/belt/utility/atmostech/PopulateContents()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/t_scanner(src)

/obj/item/storage/belt/medical_small
	name = "\improper M276型轻型医疗挂具"
	desc = "M276是TGMC的标准负重装备.它由一条带有各种卡扣的模块化腰带组成.这种轻量配置常被陆战队员用于大量携带医疗用品."
	icon_state = "medicalbelt_small"
	worn_icon_state = "medicbag"
	storage_type = /datum/storage/belt/medical_small

/obj/item/storage/belt/lifesaver
	name = "\improper M276型救生包"
	desc = "M276是TGMC的标准负重装备.这种配置挂载了一个装满各种注射器和轻型医疗用品的行李袋,在医疗兵中很常见."
	icon_state = "medicalbag"
	worn_icon_state = "medicbag"
	storage_type = /datum/storage/belt/lifesaver

/obj/item/storage/belt/lifesaver/full/PopulateContents()  //The belt, with all it's magic inside!
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/tricordrazine(src)
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/isotonic(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/spaceacillin(src)
	new /obj/item/storage/pill_bottle/imialky(src)
	new /obj/item/storage/pill_bottle/hypervene(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/belt/lifesaver/quick/PopulateContents()  //quick load for combat patrol
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/tricordrazine(src)
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/imialky(src)
	new /obj/item/storage/pill_bottle/quickclot(src)
	new /obj/item/storage/pill_bottle/hypervene(src)
	new /obj/item/storage/pill_bottle/meralyne(src)
	new /obj/item/storage/pill_bottle/dermaline(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/dexalinplus(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/belt/lifesaver/beginner/PopulateContents() //For beginner vendor
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/meralyne(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/dermaline(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/tricordrazine(src)
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/isotonic(src)
	new /obj/item/storage/pill_bottle/spaceacillin(src)
	new /obj/item/storage/pill_bottle/imialky(src)
	new /obj/item/storage/pill_bottle/hypervene(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/belt/lifesaver/full/upp
	name = "\improper 41式救生包"
	desc = "41式负重挂具是UPP军队的标准配发负重装备.这种配置挂载了一个装满各种注射器和轻型医疗用品的挎包,在医疗兵和游击队员中很常见."
	icon_state = "medicbag_upp"
	worn_icon_state = "medicbag_upp"

/obj/item/storage/belt/lifesaver/som
	name = "\improper S17救生包"
	desc = "一款腰带,其厚重起源来自旧采矿殖民地护理人员和医生使用的腰带."
	icon_state = "medicbag_som"
	worn_icon_state = "medicbag_som"

/obj/item/storage/belt/lifesaver/som/ert/PopulateContents()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/tricordrazine(src)
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/quickclot(src)
	new /obj/item/storage/pill_bottle/hypervene(src)
	new /obj/item/storage/pill_bottle/meralyne(src)
	new /obj/item/storage/pill_bottle/dermaline(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/belt/lifesaver/som/quick/PopulateContents()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/tricordrazine(src)
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/quickclot(src)
	new /obj/item/storage/pill_bottle/imialky(src)
	new /obj/item/storage/pill_bottle/hypervene(src)
	new /obj/item/storage/pill_bottle/meralyne(src)
	new /obj/item/storage/pill_bottle/dermaline(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/reagent_containers/hypospray/autoinjector/dexalinplus(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/belt/lifesaver/icc
	name = "\improper 莫德勒/129救生包"
	desc = "一款由合成棕褐色纤维制成的医疗腰带,几乎可以携带你在战斗中应对创伤性损伤所需的一切."
	icon_state = "medicbag_icc"
	worn_icon_state = "medicbag_icc"

/obj/item/storage/belt/lifesaver/icc/ert/PopulateContents()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/tricordrazine(src)
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/quickclot(src)
	new /obj/item/storage/pill_bottle/hypervene(src)
	new /obj/item/storage/pill_bottle/meralyne(src)
	new /obj/item/storage/pill_bottle/dermaline(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/belt/rig
	name = "\improper M276型医疗储存挂具"
	desc = "M276是TGMC的标准负重装备.它由一条带有各种卡扣的模块化腰带组成.这个版本是一种不太常见的配置,设计用于运输医疗用品和较重的医疗工具."
	icon_state = "medicalbelt"
	worn_icon_state = "medical"
	storage_type = /datum/storage/belt/rig

/obj/item/storage/belt/rig/medical/PopulateContents()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/tricordrazine(src)
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/isotonic(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/spaceacillin(src)
	new /obj/item/storage/pill_bottle/imialky(src)
	new /obj/item/storage/pill_bottle/hypervene(src)
	new /obj/item/bodybag/cryobag(src)
	new /obj/item/roller(src)
	new /obj/item/defibrillator(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/belt/rig/research/PopulateContents()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/tricordrazine(src)
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/storage/pill_bottle/spaceacillin(src)
	new /obj/item/storage/pill_bottle/alkysine(src)
	new /obj/item/storage/pill_bottle/imidazoline(src)
	new /obj/item/storage/pill_bottle/isotonic(src)
	new /obj/item/storage/pill_bottle/hypervene(src)
	new /obj/item/defibrillator(src)
	new /obj/item/tool/research/excavation_tool(src)
	new /obj/item/tool/research/xeno_analyzer(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/belt/hypospraybelt
	name = "\improper M276型喷雾腰带"
	desc = "M276是TGMC的标准负重装备.它由一条带有各种卡扣的模块化腰带组成.这个版本是一种不太常见的配置,设计用于运输喷雾器和试剂容器.你大概还能塞下一个注射器盒."
	icon_state = "hypospraybelt"
	worn_icon_state = "medicbag"
	storage_type = /datum/storage/belt/hypospraybelt

/obj/item/storage/belt/hypospraybelt/full/PopulateContents()
	new /obj/item/reagent_containers/glass/bottle/bicaridine(src)
	new /obj/item/reagent_containers/glass/bottle/kelotane(src)
	new /obj/item/reagent_containers/glass/bottle/tramadol(src)
	new /obj/item/reagent_containers/glass/bottle/tricordrazine(src)
	new /obj/item/reagent_containers/glass/bottle/combatmix(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/bicaridine(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/kelotane(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/tramadol(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/tricordrazine(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/combatmix(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/dylovene(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/inaprovaline(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/isotonic(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/spaceacillin(src)
	new /obj/item/reagent_containers/hypospray/advanced/imialky(src)
	new /obj/item/reagent_containers/hypospray/advanced/hypervene(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/belt/hypospraybelt/beginner/PopulateContents()
	new /obj/item/reagent_containers/glass/bottle/bicaridine(src)
	new /obj/item/reagent_containers/glass/bottle/kelotane(src)
	new /obj/item/reagent_containers/glass/bottle/tramadol(src)
	new /obj/item/reagent_containers/glass/bottle/tricordrazine(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/bicaridine(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/kelotane(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/tramadol(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/tricordrazine(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/combatmix(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/dylovene(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/inaprovaline(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/isotonic(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/spaceacillin(src)
	new /obj/item/reagent_containers/hypospray/advanced/big/quickclot(src)
	new /obj/item/reagent_containers/hypospray/advanced/imialky(src)
	new /obj/item/reagent_containers/hypospray/advanced/hypervene(src)
	new /obj/item/reagent_containers/hypospray/advanced/peridaxon(src)
	new /obj/item/reagent_containers/hypospray/advanced/quickclot(src)
	new /obj/item/storage/syringe_case/meraderm(src)
	new /obj/item/storage/syringe_case/meraderm(src)
	new /obj/item/reagent_containers/hypospray/advanced/meraderm(src)

/obj/item/storage/belt/security
	name = "\improper M276型安保挂具"
	desc = "M276是TGMC的标准负重装备.它由一条带有各种卡扣的模块化腰带组成.这种配置常见于TGMC宪兵和维和人员,不过也能装一些轻型弹药."
	icon_state = "securitybelt"
	worn_icon_state = "security"//Could likely use a better one.
	storage_type = /datum/storage/belt/security

/obj/item/storage/belt/security/tactical
	name = "战斗腰带"
	desc = "可以装手铐和闪光弹等安保装备,还有更多小包提供更多储存空间."
	icon_state = "swatbelt"
	worn_icon_state = "swatbelt"
	storage_type = /datum/storage/belt/security/tactical

/obj/item/storage/belt/security/mp/PopulateContents()
	new /obj/item/explosive/grenade/flashbang(src)
	new /obj/item/explosive/grenade/chem_grenade/teargas(src)
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/flash(src)
	new /obj/item/weapon/baton(src)

/obj/item/storage/belt/marine
	name = "\improper M276型弹药负重挂具"
	desc = "M276是TGMC的标准负重装备.它由一条带有各种卡扣的模块化腰带组成.这个版本是标准型号,专为大量携带弹药的操作设计."
	icon_state = "marinebelt"
	worn_icon_state = "marinebelt"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/belt/marine

/obj/item/storage/belt/marine/auto_catch
	name = "\improper M344型弹药负重挂具"
	desc = "M344是TGMC的现代负重装备.它由一条带有各种卡扣的模块化腰带组成.让你在战斗行动中快速获取和使用装备."
	icon_state = "autocathbelt"
	storage_type = /datum/storage/belt/marine/auto_catch

/obj/item/storage/belt/marine/auto_catch/Initialize(mapload, ...)
	. = ..()
	AddComponent(/datum/component/magazine_catcher)
	AddComponent(/datum/component/easy_restock)

/obj/item/storage/belt/marine/ar12/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/ar12(src)

/obj/item/storage/belt/marine/ar18/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/ar18(src)

/obj/item/storage/belt/marine/ar21/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/ar21(src)

/obj/item/storage/belt/marine/br64/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/br64(src)

/obj/item/storage/belt/marine/t90/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/smg/smg90(src)

/obj/item/storage/belt/marine/secondary/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/smg/m25(src)

/obj/item/storage/belt/marine/antimaterial/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/sniper(src)

/obj/item/storage/belt/marine/tx8/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/tx8(src)

/obj/item/storage/belt/marine/combat_rifle/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/ar11(src)

/obj/item/storage/belt/marine/alf_machinecarbine/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/alf_machinecarbine(src)

/obj/item/storage/belt/marine/auto_shotgun/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/ammo_magazine/rifle/sh15_slug(src)
	for(var/i in 1 to 3)
		new /obj/item/ammo_magazine/rifle/sh15_flechette(src)

/obj/item/storage/belt/marine/te_cells/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/cell/lasgun/lasrifle(src)

/obj/item/storage/belt/marine/oicw/PopulateContents()
	new /obj/item/ammo_magazine/rifle/ar12(src)
	new /obj/item/ammo_magazine/rifle/ar12(src)
	new /obj/item/ammo_magazine/rifle/tx54/incendiary(src)
	new /obj/item/ammo_magazine/rifle/tx54/incendiary(src)
	new /obj/item/ammo_magazine/rifle/tx54(src)
	new /obj/item/ammo_magazine/rifle/tx54(src)

/obj/item/storage/belt/marine/smartgun/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/sg29(src)

/obj/item/storage/belt/marine/sg62/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/sg62(src)

/obj/item/storage/belt/marine/upp
	name = "\improper 41式负重挂具"
	desc = "41式负重挂具是USL海盗的标准配发负重装备.这条腰带的主要功能是在行动中方便取用71式弹匣.尽管是为71式武器系统设计的,但这些小包足够模块化,可以装其他类型的弹药和装备."
	icon_state = "upp_belt"
	worn_icon_state = "upp_belt"

//version full of type 71 mags
/obj/item/storage/belt/marine/upp/full/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/type71(src)

/obj/item/storage/belt/marine/som
	name = "\improper S18弹药腰带"
	desc = "一款腰带,其起源可追溯到M276弹药腰带和一些旧殖民地安保装备."
	icon_state = "som_belt"
	worn_icon_state = "som_belt"

/obj/item/storage/belt/marine/som/som_rifle/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/som(src)

/obj/item/storage/belt/marine/som/som_rifle_ap/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/som/ap(src)

/obj/item/storage/belt/marine/som/som_smg/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/smg/som(src)

/obj/item/storage/belt/marine/som/som_smg_ap/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/smg/som/ap(src)

/obj/item/storage/belt/marine/som/volkite/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/cell/lasgun/volkite(src)

/obj/item/storage/belt/marine/som/mpi_plum/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/mpi_km/plum(src)

/obj/item/storage/belt/marine/som/mpi_black/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/mpi_km/black(src)

/obj/item/storage/belt/marine/som/carbine/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/mpi_km/carbine(src)

/obj/item/storage/belt/marine/som/carbine_black/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_magazine/rifle/mpi_km/carbine/black(src)

/obj/item/storage/belt/marine/icc
	name = "\improper 莫德罗/120弹药腰带"
	desc = "一款专为携带弹药而设计的腰带,由棕褐色合成纤维制成."
	icon_state = "icc_belt"

/obj/item/storage/belt/marine/sectoid
	name = "\improper 奇怪的弹药带"
	desc = "一条由坚固但不同寻常的织物制成的腰带,带有用于固定装备的卡扣."
	icon_state = "swatbelt"
	worn_icon_state = "swatbelt"
	storage_type = /datum/storage/belt/marine/sectoid

/obj/item/storage/belt/marine/sectoid/full/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/ammo_magazine/rifle/sectoid_rifle(src)
	new /obj/item/tool/crowbar/red(src)

/obj/item/storage/belt/shotgun
	name = "\improper 霰弹枪弹药装载带"
	desc = "一种设计用于容纳霰弹枪弹壳或单发子弹的弹药带."
	icon_state = "shotgunbelt"
	worn_icon_state = "shotgunbelt"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/belt/shotgun

/obj/item/storage/belt/shotgun/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/ammo_magazine))
		var/obj/item/ammo_magazine/M = I
		if(CHECK_BITFIELD(M.magazine_flags, MAGAZINE_HANDFUL))
			return ..()
		if(M.magazine_flags & MAGAZINE_REFILLABLE)
			if(!M.current_rounds)
				to_chat(user, span_warning("[M]是空的."))
				return

			if(length(contents) >= storage_datum.storage_slots)
				to_chat(user, span_warning("[src]是满的."))
				return

			to_chat(user, span_notice("你开始用[M]重新装填[src]."))
			if(!do_after(user, 1.5 SECONDS, NONE, src, BUSY_ICON_GENERIC))
				return

			for(var/x in 1 to (storage_datum.storage_slots - length(contents)))
				var/cont = storage_datum.handle_item_insertion(M.create_handful(), 1, user)
				if(!cont)
					break

			playsound(user.loc, SFX_RUSTLE, 15, TRUE, 6)
			to_chat(user, span_notice("你用[M]重新装填了[src]."))
			return TRUE
	return ..()

/obj/item/storage/belt/shotgun/flechette/PopulateContents()
	for(var/i in 1 to 14)
		new /obj/item/ammo_magazine/handful/flechette(src)

/obj/item/storage/belt/shotgun/mixed/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_magazine/handful/buckshot(src)
	for(var/i in 1 to 7)
		new /obj/item/ammo_magazine/handful/flechette(src)

/obj/item/storage/belt/shotgun/som
	desc = "一种设计用于容纳霰弹枪弹壳或单发子弹的弹药带.由传统的SOM皮革制成."
	icon_state = "shotgunbelt_som"

/obj/item/storage/belt/shotgun/som/flechette/PopulateContents()
	for(var/i in 1 to 14)
		new /obj/item/ammo_magazine/handful/flechette(src)

/obj/item/storage/belt/shotgun/som/mixed/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_magazine/handful/buckshot(src)
	for(var/i in 1 to 7)
		new /obj/item/ammo_magazine/handful/flechette(src)

/obj/item/storage/belt/shotgun/icc
	name = "\improper Modelle/121弹药装载带"
	desc = "一种设计用于容纳霰弹枪弹壳或单发子弹的弹药带,由合成棕褐色纤维制成."
	icon_state = "shotgunbelt_icc"

/obj/item/storage/belt/shotgun/icc/flechette/PopulateContents()
	for(var/i in 1 to 14)
		new /obj/item/ammo_magazine/handful/flechette(src)

/obj/item/storage/belt/shotgun/icc/mixed/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_magazine/handful/heavy_buckshot(src)
	for(var/i in 1 to 7)
		new /obj/item/ammo_magazine/handful/barrikada(src)

/obj/item/storage/belt/shotgun/martini
	name = "马提尼亨利弹药带"
	desc = "一条足以容纳你所有.577/400球形弹的腰带."
	icon_state = "martini_belt"
	atom_flags = DIRLOCK
	storage_type = /datum/storage/belt/shotgun/martini

/obj/item/storage/belt/shotgun/martini/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/storage/belt/shotgun/martini/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/ammo_magazine))
		var/obj/item/ammo_magazine/new_mag = I
		if(new_mag.caliber != CALIBER_557)
			to_chat(user, span_notice("[src]只能装填.557/440球形步枪弹."))
			return
	. = ..()
	update_icon()

/obj/item/storage/belt/shotgun/martini/attack_hand(mob/living/user)
	if (loc != user)
		. = ..()
		for(var/mob/watcher_mobs in storage_datum.content_watchers)
			storage_datum.close(watcher_mobs)

	if(!storage_datum.draw_mode || !ishuman(user) && !length(contents))
		storage_datum.open(user)

	if(!length(contents))
		return

	var/obj/item/I = contents[length(contents)]
	if(!istype(I, /obj/item/ammo_magazine/handful))
		return

	var/obj/item/ammo_magazine/handful/existing_handful = I

	if(existing_handful.current_rounds == 1)
		user.put_in_hands(existing_handful)
		return

	existing_handful.create_handful(user, 1)
	update_icon()

/obj/item/storage/belt/knifepouch
	name = "\improper M276型刀具挂具"
	desc = "M276是TGMC的标准承载装备.它由一条带有各种卡扣的模块化腰带组成.此版本特别设计了六个刀套用于存放飞刀.不常配发,但仍在服役."
	icon_state = "knifebelt"
	worn_icon_state = "knifebelt"
	storage_type = /datum/storage/belt/knifepouch

/obj/item/storage/belt/knifepouch/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/stack/throwing_knife(src)

/obj/item/storage/belt/grenade
	name = "\improper M276型M40 HEDP挂具"
	desc = "M276是TGMC的标准承载装备.它由一条带有各种卡扣的模块化腰带组成.此版本设计用于携带大量M40 HEDP手榴弹."
	icon_state = "grenadebelt"
	worn_icon_state = "grenadebelt"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/belt/grenade

/obj/item/storage/belt/grenade/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/tac_reload_storage)

/obj/item/storage/belt/grenade/standard/PopulateContents()
	new /obj/item/explosive/grenade/incendiary(src)
	new /obj/item/explosive/grenade/incendiary(src)
	for(var/i in 1 to 6)
		new /obj/item/explosive/grenade(src)

/obj/item/storage/belt/grenade/som
	name = "\improper S16型手榴弹挂具"
	desc = "一种有多种配置的简单背带系统.此版本设计用于携带大量手榴弹."
	icon_state = "grenadebelt_som"

/obj/item/storage/belt/grenade/som/standard/PopulateContents()
	new /obj/item/explosive/grenade/incendiary/som(src)
	new /obj/item/explosive/grenade/incendiary/som(src)
	for(var/i in 1 to 6)
		new /obj/item/explosive/grenade/som(src)

/obj/item/storage/belt/grenade/b17
	name = "\improper M276型M40 HEDP挂具Mk II"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/belt/grenade/b17

/obj/item/storage/belt/grenade/b17/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/explosive/grenade/incendiary(src)
	for(var/i in 1 to 8)
		new /obj/item/explosive/grenade(src)

/obj/item/storage/belt/sparepouch
	name = "\improper G8通用工具袋"
	desc = "一个小巧轻便的袋子,可以夹在Armat Systems M3型装甲或你的腰带上,为杂项装备或盒装和弹鼓弹匣提供额外存储空间."
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "sparepouch"
	worn_icon_state = "sparepouch"
	storage_type = /datum/storage/belt/sparepouch

/obj/item/storage/belt/sparepouch/som
	name = "标准工具袋"
	desc = "一个小巧轻便的袋子,可以夹在装甲或你的腰带上,为杂项装备或盒装和弹鼓弹匣提供额外存储空间.由真正的SOM皮革制成."
	icon_state = "sparepouch_som"
	worn_icon_state = "som_belt"

/obj/item/storage/belt/protein_pack
	name = "\improper 蛋白质包装载带"
	desc = "一种储物腰带,设计用于为那些特别饥饿的陆战队员携带大量蛋白质包."
	icon_state = "p_belt"
	worn_icon_state = "shotgunbelt"
	storage_type = /datum/storage/belt/protein_pack

/obj/item/storage/belt/protein_pack/PopulateContents()
	for(var/i in 1 to storage_datum.storage_slots)
		new /obj/item/reagent_containers/food/snacks/protein_pack(src)

/obj/item/storage/belt/mortar_belt
	name = "TA-10迫击炮腰带"
	desc = "一条可容纳一门TA-10 50毫米迫击炮,测距仪以及大量弹药的腰带."
	icon_state = "kneemortar_holster"
	worn_icon_state = "m4a3_holster"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/belt/mortar_belt

/obj/item/storage/belt/mortar_belt/full/PopulateContents()
	new /obj/item/mortar_kit/knee(src)
	new /obj/item/binoculars/tactical/range(src)
