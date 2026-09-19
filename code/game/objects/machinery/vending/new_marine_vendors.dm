/obj/machinery/marine_selector
	name = "\improper Theoretical Marine selector"
	desc = ""
	icon = 'icons/obj/machines/vending.dmi'
	density = TRUE
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	req_access = null
	req_one_access = null
	interaction_flags = INTERACT_MACHINE_TGUI

	idle_power_usage = 60
	active_power_usage = 3000
	light_range = 1.5
	light_power = 0.5
	light_color = LIGHT_COLOR_BLUE

	var/gives_webbing = FALSE
	var/vendor_role //to be compared with job.type to only allow those to use that machine.
	var/squad_tag = ""
	var/use_points = FALSE
	var/icon_vend
	var/icon_deny

	var/list/categories
	var/list/listed_products

/obj/machinery/marine_selector/Initialize(mapload)
	. = ..()
	update_icon()

/obj/machinery/marine_selector/update_icon()
	. = ..()
	if(is_operational())
		set_light(initial(light_range))
	else
		set_light(0)

/obj/machinery/marine_selector/update_icon_state()
	. = ..()
	if(is_operational())
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]-off"

/obj/machinery/marine_selector/update_overlays()
	. = ..()
	if(!is_operational() || !icon_state)
		return
	. += emissive_appearance(icon, "[icon_state]_emissive", src)

/obj/machinery/marine_selector/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!allowed(H))
			to_chat(user, span_warning("访问被拒绝. 你被分配的角色无权使用此机器."))
			return FALSE

		var/obj/item/card/id/user_id = H.get_idcard()
		if(!istype(user_id)) //not wearing an ID
			return FALSE

		if(user_id.registered_name != H.real_name)
			return FALSE

		if(vendor_role && !istype(H.job, vendor_role))
			to_chat(user, span_warning("访问被拒绝. 此售货机受到严格限制."))
			return FALSE
	return TRUE

/obj/machinery/marine_selector/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)

	if(!ui)
		ui = new(user, src, "MarineSelector", name)
		ui.open()

/obj/machinery/marine_selector/ui_static_data(mob/user)
	. = list()
	.["displayed_records"] = list()

	for(var/c in categories)
		.["displayed_records"][c] = list()

	.["vendor_name"] = name
	.["show_points"] = use_points


	for(var/i in listed_products)
		var/list/myprod = listed_products[i]
		var/category = myprod[1]
		var/p_name = myprod[2]
		var/p_cost = myprod[3]
		var/atom/productpath = i

		LAZYADD(.["displayed_records"][category], list(list("prod_index" = i, "prod_name" = p_name, "prod_color" = myprod[4], "prod_cost" = p_cost, "prod_desc" = initial(productpath.desc))))

/obj/machinery/marine_selector/ui_data(mob/user)
	. = list()

	var/obj/item/card/id/I = user.get_idcard()
	var/list/buy_choices = I?.marine_buy_choices
	var/obj/item/card/id/dogtag/full/ptscheck = new /obj/item/card/id/dogtag/full

	.["cats"] = list()
	for(var/cat in GLOB.marine_selector_cats)
		if(!length(buy_choices))
			break
		.["cats"][cat] = list(
			"remaining" = buy_choices[cat],
			"total" = GLOB.marine_selector_cats[cat],
			"choice" = "choice",
			)

	for(var/cat in I?.marine_points)
		.["cats"][cat] = list(
			"remaining_points" = I?.marine_points[cat],
			"total_points" = ptscheck?.marine_points[cat],
			"choice" = "points",
			)

/obj/machinery/marine_selector/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	switch(action)
		if("vend")
			if(!allowed(usr))
				to_chat(usr, span_warning("访问被拒绝."))
				if(icon_deny)
					flick(icon_deny, src)
				return

			var/idx = text2path(params["vend"])
			var/obj/item/card/id/user_id = usr.get_idcard()

			var/list/L = listed_products[idx]
			var/item_category = L[1]
			var/cost = L[3]

			if(!(user_id.id_flags & CAN_BUY_LOADOUT)) //If you use the quick-e-quip, you cannot also use the GHMMEs
				to_chat(usr, span_warning("访问被拒绝. 你已经领取了一套装备."))
				return FALSE
			if(use_points && (item_category in user_id.marine_points) && user_id.marine_points[item_category] < cost)
				to_chat(usr, span_warning("点数不足."))
				if(icon_deny)
					flick(icon_deny, src)
				return

			var/turf/T = loc
			if(length(T.contents) > 25)
				to_chat(usr, span_warning("地面太杂乱了, 腾出一些空间."))
				if(icon_deny)
					flick(icon_deny, src)
				return

			if(item_category in user_id.marine_buy_choices)
				if(user_id.marine_buy_choices[item_category] && GLOB.marine_selector_cats[item_category])
					user_id.marine_buy_choices[item_category] -= 1
				else
					if(cost == 0)
						to_chat(usr, span_warning("你无法再从该类别购买物品了."))
						return

			var/list/vended_items = list()

			if (ispath(idx, /obj/effect/vendor_bundle))
				var/obj/effect/vendor_bundle/bundle = new idx(loc, FALSE)
				vended_items += bundle.spawned_gear
				qdel(bundle)
			else
				vended_items += new idx(loc)

			playsound(src, SFX_VENDING, 25, 0)

			if(icon_vend)
				flick(icon_vend, src)

			use_power(active_power_usage)

			if(item_category == CAT_STD && !issynth(usr))
				var/mob/living/carbon/human/H = usr
				if(!istype(H.job, /datum/job/terragov/command/fieldcommander))
					vended_items += new /obj/item/radio/headset/mainship/marine(loc, H.assigned_squad, vendor_role)
					if(istype(H.job, /datum/job/terragov/squad/leader))
						vended_items += new /obj/item/hud_tablet(loc, vendor_role, H.assigned_squad)
						vended_items += new /obj/item/squad_transfer_tablet(loc)

			for (var/obj/item/vended_item in vended_items)
				vended_item.on_vend(usr, faction, auto_equip = TRUE)

			if(use_points && (item_category in user_id.marine_points))
				user_id.marine_points[item_category] -= cost
			. = TRUE
			user_id.id_flags |= USED_GHMME

/obj/machinery/marine_selector/clothes
	name = "\improper GHMME Automated Closet"
	desc = "一个连接到巨大标准制服和护甲存储单元的自动衣柜."
	icon_state = "marineuniform"
	icon_vend = "marineuniform-vend"
	icon_deny = "marineuniform-deny"
	vendor_role = /datum/job/terragov/squad/standard
	use_points = TRUE
	categories = list(
		CAT_STD = 1,
		CAT_UNI = 1,
		CAT_GLO = 1,
		CAT_SHO = 1,
		CAT_GLA = 1,
		CAT_HEL = 1,
		CAT_AMR = 1,
		CAT_BAK = 1,
		CAT_WEB = 1,
		CAT_BEL = 1,
		CAT_POU = 2,
		CAT_MOD = 1,
		CAT_ARMMOD = 1,
		CAT_MAS = 1,
	)

/obj/machinery/marine_selector/clothes/Initialize(mapload)
	. = ..()
	listed_products = GLOB.marine_clothes_listed_products

/obj/machinery/marine_selector/clothes/engi
	name = "\improper GHMME Automated Engineer Closet"
	req_access = list(ACCESS_MARINE_ENGPREP)
	vendor_role = /datum/job/terragov/squad/engineer
	gives_webbing = FALSE

/obj/machinery/marine_selector/clothes/engi/Initialize(mapload)
	. = ..()
	listed_products = GLOB.engineer_clothes_listed_products

/obj/machinery/marine_selector/clothes/engi/valhalla
	vendor_role = /datum/job/fallen/marine/engineer
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/clothes/robo
	name = "GHMME Automated Combat Robot Closet"
	req_access = list(ACCESS_MARINE_ROBOT)
	vendor_role = /datum/job/terragov/squad/robot
	gives_webbing = FALSE

/obj/machinery/marine_selector/clothes/robo/Initialize(mapload)
	. = ..()
	listed_products = GLOB.robot_clothes_listed_products

/obj/machinery/marine_selector/clothes/robo/valhalla
	vendor_role = /datum/job/fallen/marine/combat_robot
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/clothes/medic
	name = "\improper GHMME Automated Corpsman Closet"
	req_access = list(ACCESS_MARINE_MEDPREP)
	vendor_role = /datum/job/terragov/squad/corpsman
	gives_webbing = FALSE

/obj/machinery/marine_selector/clothes/medic/Initialize(mapload)
	. = ..()
	listed_products = GLOB.medic_clothes_listed_products

/obj/machinery/marine_selector/clothes/medic/valhalla
	vendor_role = /datum/job/fallen/marine/corpsman
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/clothes/smartgun
	name = "\improper GHMME Automated Smartgunner Closet"
	req_access = list(ACCESS_MARINE_SMARTPREP)
	vendor_role = /datum/job/terragov/squad/smartgunner
	gives_webbing = FALSE

/obj/machinery/marine_selector/clothes/smartgun/Initialize(mapload)
	. = ..()
	listed_products = GLOB.smartgunner_clothes_listed_products

/obj/machinery/marine_selector/clothes/smartgun/valhalla
	vendor_role = /datum/job/fallen/marine/smartgunner
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/clothes/leader
	name = "\improper GHMME Automated Leader Closet"
	req_access = list(ACCESS_MARINE_LEADER)
	vendor_role = /datum/job/terragov/squad/leader
	gives_webbing = FALSE

/obj/machinery/marine_selector/clothes/leader/Initialize(mapload)
	. = ..()
	listed_products = GLOB.leader_clothes_listed_products

/obj/machinery/marine_selector/clothes/leader/valhalla
	vendor_role = /datum/job/fallen/marine/leader
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/clothes/valhalla
	vendor_role = /datum/job/fallen/marine/standard
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/clothes/commander
	name = "\improper GHMME Automated Commander Closet"
	req_access = list(ACCESS_MARINE_COMMANDER)
	vendor_role = /datum/job/terragov/command/fieldcommander
	gives_webbing = FALSE

/obj/machinery/marine_selector/clothes/commander/Initialize(mapload)
	. = ..()
	listed_products = GLOB.commander_clothes_listed_products

/obj/machinery/marine_selector/clothes/commander/valhalla
	vendor_role = /datum/job/fallen/marine/fieldcommander
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/clothes/synth
	name = "M57 Synthetic Equipment Vendor"
	desc = "一个连接到适度存储单元的自动合成人装备售货机."
	icon_state = "synth"
	icon_vend = "synth-vend"
	icon_deny = "synth-deny"
	vendor_role = /datum/job/terragov/silicon/synthetic

/obj/machinery/marine_selector/clothes/synth/valhalla
	vendor_role = /datum/job/fallen/marine/synthetic
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/clothes/synth/Initialize(mapload)
	. = ..()
	listed_products = GLOB.synthetic_clothes_listed_products + GLOB.synthetic_gear_listed_products

////////////////////// Gear ////////////////////////////////////////////////////////



/obj/machinery/marine_selector/gear
	name = "\improper NEXUS Automated Equipment Rack"
	desc = "一个连接到巨大存储单元的自动装备架."
	icon_state = "marinearmory"
	use_points = TRUE

/obj/machinery/marine_selector/gear/medic
	name = "\improper NEXUS automated medical equipment rack"
	desc = "一个连接到巨大医疗物资存储单元的自动装备架."
	icon_state = "medic"
	icon_vend = "medic-vend"
	icon_deny = "medic-deny"
	vendor_role = /datum/job/terragov/squad/corpsman
	req_access = list(ACCESS_MARINE_MEDPREP)

/obj/machinery/marine_selector/gear/medic/Initialize(mapload)
	. = ..()
	listed_products = GLOB.medic_gear_listed_products

/obj/machinery/marine_selector/gear/medic/valhalla
	vendor_role = /datum/job/fallen/marine/corpsman
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/gear/marine
	name = "NEXUS Automated Marine Gear Rack"
	desc = "一个连接到巨大存储单元的自动陆战队装备架."
	icon_state = "marine"
	icon_vend = "marine-vend"
	icon_deny = "marine-deny"
	vendor_role = /datum/job/terragov/squad/standard
	req_access = list(ACCESS_MARINE_PREP)

/obj/machinery/marine_selector/gear/marine/Initialize(mapload)
	. = ..()
	listed_products = GLOB.marine_gear_listed_products

/obj/machinery/marine_selector/gear/marine/valhalla
	vendor_role = /datum/job/fallen/marine
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/gear/robo
	name = "NEXUS Automated Combat Robot Gear Rack"
	desc = "一个连接到巨大存储单元的自动战斗机器人装备架."
	icon_state = "robo"
	icon_vend = "robo-vend"
	icon_deny = "robo-deny"
	vendor_role = /datum/job/terragov/squad/robot
	req_access = list(ACCESS_MARINE_ROBOT)

/obj/machinery/marine_selector/gear/robo/Initialize(mapload)
	. = ..()
	listed_products = GLOB.robot_gear_listed_products

/obj/machinery/marine_selector/gear/robo/valhalla
	vendor_role = /datum/job/fallen/marine/combat_robot
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/gear/engi
	name = "\improper NEXUS automated engineering equipment rack"
	desc = "一个连接到巨大工程相关物资存储单元的自动装备架."
	icon_state = "engineer"
	icon_vend = "engineer-vend"
	icon_deny = "engineer-deny"
	vendor_role = /datum/job/terragov/squad/engineer
	req_access = list(ACCESS_MARINE_ENGPREP)

/obj/machinery/marine_selector/gear/engi/Initialize(mapload)
	. = ..()
	listed_products = GLOB.engineer_gear_listed_products

/obj/machinery/marine_selector/gear/engi/valhalla
	vendor_role = /datum/job/fallen/marine/engineer
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/gear/smartgun
	name = "\improper NEXUS automated smartgun equipment rack"
	desc = "一个连接到巨大智能枪相关物资存储单元的自动装备架."
	icon_state = "smartgunner"
	icon_vend = "smartgunner-vend"
	icon_deny = "smartgunner-deny"
	vendor_role = /datum/job/terragov/squad/smartgunner
	req_access = list(ACCESS_MARINE_SMARTPREP)

/obj/machinery/marine_selector/gear/smartgun/Initialize(mapload)
	. = ..()
	listed_products = GLOB.smartgunner_gear_listed_products

/obj/machinery/marine_selector/gear/smartgun/valhalla
	vendor_role = /datum/job/fallen/marine/smartgunner
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/gear/leader
	name = "\improper NEXUS automated squad leader's equipment rack"
	desc = "一台自动化装备架,连接着一个巨大的基础驱猫设备储存库."
	icon_state = "squadleader"
	icon_vend = "squadleader-vend"
	icon_deny = "squadleader-deny"
	vendor_role = /datum/job/terragov/squad/leader
	req_access = list(ACCESS_MARINE_LEADER)

/obj/machinery/marine_selector/gear/leader/Initialize(mapload)
	. = ..()
	listed_products = GLOB.leader_gear_listed_products

/obj/machinery/marine_selector/gear/leader/valhalla
	vendor_role = /datum/job/fallen/marine/leader
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/marine_selector/gear/commander
	name = "\improper NEXUS automated command equipment rack"
	desc = "一台自动化装备架,连接着一个巨大的高级驱猫设备储存库."
	icon_state = "squadleader"
	icon_vend = "squadleader-vend"
	icon_deny = "squadleader-deny"
	vendor_role = /datum/job/terragov/command/fieldcommander
	req_access = list(ACCESS_MARINE_COMMANDER)

/obj/machinery/marine_selector/gear/commander/Initialize(mapload)
	. = ..()
	listed_products = GLOB.commander_gear_listed_products

/obj/machinery/marine_selector/gear/commander/valhalla
	vendor_role = /datum/job/fallen/marine/fieldcommander
	resistance_flags = INDESTRUCTIBLE

///Spawns a set of objects from specified typepaths. For vendors to spawn multiple items while only needing one path.
/obj/effect/vendor_bundle
	///The set of typepaths to spawn
	var/list/gear_to_spawn
	///Records the gear objects that have been spawned, so vendors can see what they just vended
	var/list/spawned_gear

///Spawns the gear from this vendor_bundle. Deletes itself after spawning gear; can be disabled to check what has been spawned (must then delete the bundle yourself)
/obj/effect/vendor_bundle/Initialize(mapload, autodelete = TRUE)
	. = ..()
	LAZYINITLIST(gear_to_spawn)
	for(var/typepath in gear_to_spawn)
		LAZYADD(spawned_gear, new typepath(loc))
	if (autodelete)
		qdel(src)

/obj/effect/vendor_bundle/basic
	gear_to_spawn = list(
		/obj/item/storage/box/mre,
		/obj/item/paper/tutorial/medical,
		/obj/item/paper/tutorial/mechanics,
	)

/obj/effect/vendor_bundle/medic
	gear_to_spawn = list(
		/obj/item/bodybag/cryobag,
		/obj/item/defibrillator,
		/obj/item/healthanalyzer,
		/obj/item/roller/medevac,
		/obj/item/medevac_beacon,
		/obj/item/roller,
		/obj/item/tweezers,
		/obj/item/reagent_containers/hypospray/advanced/oxycodone,
		/obj/item/storage/firstaid/adv,
		/obj/item/clothing/glasses/hud/health,
		/obj/item/tool/surgery/solderingtool,
	)

/obj/effect/vendor_bundle/stretcher
	desc = "标准配发的TerraGov陆战队医疗兵医疗后送担架.附带一个额外的信标,但多个床位可以连接到同一个信标."
	gear_to_spawn = list(
		/obj/item/roller/medevac,
		/obj/item/medevac_beacon,
	)

/obj/effect/vendor_bundle/engi
	gear_to_spawn = list(
		/obj/item/weapon/gun/sentry/basic,
		/obj/item/explosive/plastique,
		/obj/item/explosive/grenade/chem_grenade/razorburn_small,
		/obj/item/clothing/gloves/marine/insulated,
		/obj/item/cell/high,
		/obj/item/lightreplacer,
		/obj/item/circuitboard/apc,
		/obj/item/tool/surgery/solderingtool,
	)

/obj/effect/vendor_bundle/smartgunner_pistol
	gear_to_spawn = list(
		/obj/item/clothing/glasses/night/m56_goggles,
	)

/obj/effect/vendor_bundle/leader
	gear_to_spawn = list(
		/obj/item/explosive/plastique,
		/obj/item/supply_beacon,
		/obj/item/supply_beacon,
		/obj/item/orbital_bombardment_beacon,
		/obj/item/whistle,
		/obj/item/compass,
		/obj/item/binoculars/tactical,
		/obj/item/pinpointer,
		/obj/item/clothing/glasses/hud/health,
	)

/obj/effect/vendor_bundle/commander
	gear_to_spawn = list(
		/obj/item/explosive/plastique,
		/obj/item/supply_beacon,
		/obj/item/orbital_bombardment_beacon,
		/obj/item/healthanalyzer,
		/obj/item/roller/medevac,
		/obj/item/medevac_beacon,
		/obj/item/whistle,
		/obj/item/clothing/glasses/hud/health,
	)

/obj/effect/vendor_bundle/synth
	gear_to_spawn = list(
		/obj/item/stack/sheet/plasteel/medium_stack,
		/obj/item/stack/sheet/metal/large_stack,
		/obj/item/tool/weldingtool/hugetank,
		/obj/item/lightreplacer,
		/obj/item/tool/handheld_charger,
		/obj/item/defibrillator,
		/obj/item/medevac_beacon,
		/obj/item/roller/medevac,
		/obj/item/roller,
		/obj/item/bodybag/cryobag,
		/obj/item/reagent_containers/hypospray/advanced/oxycodone,
		/obj/item/tweezers,
		/obj/item/tool/surgery/solderingtool,
		/obj/item/supplytablet,
		/obj/item/cell/high,
		/obj/item/circuitboard/apc,
	)

/obj/effect/vendor_bundle/white_dress
	name = "Full set of TGMC white dress uniform"
	desc = "标准配发的TerraGov陆战队白色礼服制服.布料上的浆粉会带来些许摩擦感,但与你在新兵训练营毕业典礼上第一次穿上它时感受到的自豪相比,这根本不算什么.不过腰部似乎不太合身."
	gear_to_spawn = list(
		/obj/item/clothing/under/marine/whites,
		/obj/item/clothing/suit/white_dress_jacket,
		/obj/item/clothing/head/white_dress,
		/obj/item/clothing/shoes/white,
		/obj/item/clothing/gloves/white,
	)

/obj/effect/vendor_bundle/service_uniform
	name = "Full set of TGMC service uniform"
	desc = "标准配发的TerraGov陆战队礼服制服.有时,你讨厌穿这件衣服,因为你记得穿着它去步兵学校,而且面见委任军官时也必须穿它.这是你在未部署、在办公室工作时的着装.不过腰部似乎不太合身."
	gear_to_spawn = list(
		/obj/item/clothing/under/marine/service,
		/obj/item/clothing/head/garrisoncap,
		/obj/item/clothing/head/servicecap,
		/obj/item/clothing/shoes/marine/full,
	)

/obj/effect/vendor_bundle/jaeger_light
	desc = "一套轻型侦察型猎兵装甲,包括装甲服和头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/marine/scout,
		/obj/item/clothing/suit/modular/jaeger/light,
	)

/obj/effect/vendor_bundle/jaeger_skirmish
	desc = "一套轻型散兵型猎兵装甲,包括装甲服和头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/marine/skirmisher,
		/obj/item/clothing/suit/modular/jaeger/light/skirmisher,
	)

/obj/effect/vendor_bundle/jaeger_infantry
	desc = "一套中型步兵型猎兵装甲,包括装甲服和头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/marine,
		/obj/item/clothing/suit/modular/jaeger,
	)

/obj/effect/vendor_bundle/jaeger_eva
	desc = "一套中型EVA型猎兵装甲,包括装甲服和头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/marine/eva,
		/obj/item/clothing/suit/modular/jaeger/eva,
	)

/obj/effect/vendor_bundle/jaeger_hell_jumper
	desc = "一套中型地狱伞兵型猎兵装甲,包括装甲服和头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/marine/helljumper,
		/obj/item/clothing/suit/modular/jaeger/helljumper,
	)

/obj/effect/vendor_bundle/jaeger_ranger
	desc = "一套中型游骑兵型猎兵装甲,包括装甲服和头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/marine/ranger,
		/obj/item/clothing/suit/modular/jaeger/ranger,
	)

/obj/effect/vendor_bundle/jaeger_gungnir
	desc = "一套重型冈格尼尔型猎兵装甲,包括装甲服和头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/marine/gungnir,
		/obj/item/clothing/suit/modular/jaeger/heavy,
	)

/obj/effect/vendor_bundle/jaeger_assault
	desc = "一套重型突击型猎兵装甲,包括装甲服和头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/marine/assault,
		/obj/item/clothing/suit/modular/jaeger/heavy/assault,
	)

/obj/effect/vendor_bundle/jaeger_eod
	desc = "一套重型排爆型猎兵装甲,包括装甲服和头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/marine/eod,
		/obj/item/clothing/suit/modular/jaeger/heavy/eod,
	)

/obj/effect/vendor_bundle/xenonauten_light
	desc = "一套轻型异星战士型装甲,包括装甲服和头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/m10x,
		/obj/item/clothing/suit/modular/xenonauten/light,
	)

/obj/effect/vendor_bundle/xenonauten_medium
	desc = "一套中型异星战士型装甲,包括装甲服和头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/m10x,
		/obj/item/clothing/suit/modular/xenonauten,
	)

/obj/effect/vendor_bundle/xenonauten_heavy
	desc = "一套重型异星战士型装甲,包括装甲服和头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/m10x,
		/obj/item/clothing/suit/modular/xenonauten/heavy,
	)

/obj/effect/vendor_bundle/xenonauten_light/leader
	desc = "一套轻型异星战士型装甲,包括装甲服和高级头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/m10x/leader,
		/obj/item/clothing/suit/modular/xenonauten/light,
	)

/obj/effect/vendor_bundle/xenonauten_medium/leader
	desc = "一套中型异星战士型装甲,包括装甲服和高级头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/m10x/leader,
		/obj/item/clothing/suit/modular/xenonauten,
	)

/obj/effect/vendor_bundle/xenonauten_heavy/leader
	desc = "一套重型异星战士型装甲,包括装甲服和高级头盔."
	gear_to_spawn = list(
		/obj/item/clothing/head/modular/m10x/leader,
		/obj/item/clothing/suit/modular/xenonauten/heavy,
	)

/obj/effect/vendor_bundle/mimir
	desc = "一套防毒装备,用于保护人员免受毒气威胁."
	gear_to_spawn = list(
		/obj/item/armor_module/module/mimir_environment_protection/mimir_helmet/mark1,
		/obj/item/clothing/mask/gas/tactical,
		/obj/item/armor_module/module/mimir_environment_protection/mark1,
	)

/obj/effect/vendor_bundle/vali
	desc = "一套专为近距离战斗和增强化学效能而设计的装备."
	gear_to_spawn = list(
		/obj/item/armor_module/module/chemsystem,
		/obj/item/storage/holster/blade/harvester/full,
		/obj/item/paper/chemsystem,
	)
/obj/effect/vendor_bundle/tyr
	desc = "一套专为提升近距离战斗持久力而设计的装备."
	gear_to_spawn = list(
		/obj/item/armor_module/module/tyr_head,
		/obj/item/armor_module/module/tyr_extra_armor/mark1,
	)

/obj/effect/vendor_bundle/robot/light_armor
	gear_to_spawn = list(
		/obj/item/clothing/suit/modular/robot/light,
		/obj/item/clothing/head/modular/robot/light,
	)

/obj/effect/vendor_bundle/robot/medium_armor
	gear_to_spawn = list(
		/obj/item/clothing/suit/modular/robot,
		/obj/item/clothing/head/modular/robot,
	)

/obj/effect/vendor_bundle/robot/heavy_armor
	gear_to_spawn = list(
		/obj/item/clothing/suit/modular/robot/heavy,
		/obj/item/clothing/head/modular/robot/heavy,
	)

/obj/effect/vendor_bundle/mimir/two
	desc = "一套高级防毒装备,用于保护人员免受毒气威胁."
	gear_to_spawn = list(
		/obj/item/armor_module/module/mimir_environment_protection/mimir_helmet,
		/obj/item/armor_module/module/mimir_environment_protection,
		/obj/item/clothing/mask/gas/tactical,
	)

/obj/effect/vendor_bundle/tyr/two
	desc = "一套高级装备,用于提升近距离战斗持久力."
	gear_to_spawn = list(
		/obj/item/armor_module/module/tyr_head/mark2,
		/obj/item/armor_module/module/tyr_extra_armor,
	)

/obj/effect/vendor_bundle/veteran_uniform
	name = "Full set of TGMC veteran uniform"
	desc = "TerraGov陆战队老兵制服套装.主要由手工修改,但仍然相当有型."
	gear_to_spawn = list(
		/obj/item/clothing/mask/gas/veteran,
		/obj/item/clothing/under/marine/veteran/marine,
		/obj/item/clothing/gloves/marine/veteran/marine,
		/obj/item/clothing/shoes/marine/headskin,
	)

/obj/effect/vendor_bundle/separatist_uniform
	name = "Full set of civilian militia uniform"
	desc = "一套民兵制服.老旧,但仍然时髦."
	gear_to_spawn = list(
		/obj/item/clothing/mask/gas/separatist,
		/obj/item/clothing/under/marine/separatist,
		/obj/item/clothing/gloves/marine/separatist,
		/obj/item/clothing/shoes/marine/separatist,
	)

#undef MARINE_TOTAL_BUY_POINTS
#undef ROBOT_TOTAL_BUY_POINTS
#undef SMARTGUNNER_TOTAL_BUY_POINTS
#undef LEADER_TOTAL_BUY_POINTS
#undef MEDIC_TOTAL_BUY_POINTS
#undef ENGINEER_TOTAL_BUY_POINTS
#undef COMMANDER_TOTAL_BUY_POINTS
