/obj/item/clothing/gloves/captain
	desc = "华丽的蓝色手套, 带有漂亮的金色镶边. 时髦."
	name = "舰长手套"
	icon_state = "captain"
	cold_protection_flags = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/swat
	desc = "这双战术手套具有一定的防火和抗冲击能力."
	name = "\improper SWAT手套"
	icon_state = "black"
	siemens_coefficient = 0.6
	permeability_coefficient = 0.05

	cold_protection_flags = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/combat //Combined effect of SWAT gloves and insulated gloves
	desc = "这双战术手套具有一定的防火和抗冲击能力."
	name = "战斗手套"
	icon_state = "black"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	cold_protection_flags = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/ruggedgloves
	desc = "一双在危险环境中工作的工人使用的手套."
	name = "粗犷手套"
	icon_state = "black"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	cold_protection_flags = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection_flags = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
	soft_armor = list(MELEE = 10, BULLET = 10, LASER = 15, ENERGY = 10, BOMB = 10, BIO = 10, FIRE = 10, ACID = 10)

/obj/item/clothing/gloves/latex
	name = "乳胶手套"
	desc = "无菌乳胶手套."
	icon_state = "latex"
	siemens_coefficient = 0.30
	permeability_coefficient = 0.01

/obj/item/clothing/gloves/latex/blue
	icon_state = "bluelatex"

/obj/item/clothing/gloves/botanic_leather
	desc = "这双皮革手套可以抵御荆棘, 倒刺, 尖刺以及其他植物来源的有害物体."
	name = "植物学家皮革手套"
	icon_state = "leather"
	permeability_coefficient = 0.9
	siemens_coefficient = 0.9

//Special type of gloves. Alt click and you get some special nodrop gloves
/obj/item/clothing/gloves/heldgloves
	name = "手套"
	/// What type of glove we use for the right hand
	var/rightglove_path
	/// What type of glove we use for the left hand
	var/leftglove_path
	/// The glove we're currently using in the right hand
	var/obj/item/weapon/heldglove/rightglove
	/// The glove we're currently using in the left hand
	var/obj/item/weapon/heldglove/leftglove

/obj/item/clothing/gloves/heldgloves/Destroy()
	QDEL_NULL(rightglove)
	QDEL_NULL(leftglove)
	return ..()

/obj/item/clothing/gloves/heldgloves/examine(mob/user)
	. = ..()
	. += "Alt-click the gloves when worn to strap them into your hands."

/obj/item/clothing/gloves/heldgloves/unequipped(mob/unequipper, slot)
	. = ..()
	remove_gloves(unequipper)
	REMOVE_TRAIT(src, TRAIT_NODROP, HELDGLOVE_TRAIT)

//We use alt-click to activate/deactive the gloves in-hand
/obj/item/clothing/gloves/heldgloves/AltClick(mob/user)
	var/mob/living/carbon/human/wearer = user
	if(wearer.gloves != src) //We have to be wearing the gloves first
		return

	if(remove_gloves(user))
		REMOVE_TRAIT(src, TRAIT_NODROP, HELDGLOVE_TRAIT)
		return

	user.drop_all_held_items() //Gloves require free hands
	if(create_gloves(user))
		ADD_TRAIT(src, TRAIT_NODROP, HELDGLOVE_TRAIT) //Make sure the gloves aren't able to be taken off

/// Creates the held items for user and puts it in their hand
/obj/item/clothing/gloves/heldgloves/proc/create_gloves(mob/user)
	if(user.l_hand || user.r_hand)
		return FALSE

	rightglove = new rightglove_path()
	leftglove = new leftglove_path()

	if(user.put_in_r_hand(rightglove, TRUE) && user.put_in_l_hand(leftglove, TRUE))
		return TRUE

/// Removes gloves. Returns false if gloves are not currently worn
/obj/item/clothing/gloves/heldgloves/proc/remove_gloves(mob/user)
	var/removed = FALSE
	if(leftglove)
		QDEL_NULL(leftglove)
		removed = TRUE
	if(rightglove)
		QDEL_NULL(rightglove)
		removed = TRUE
	return removed

/obj/item/weapon/heldglove
	name = "手套"

/obj/item/weapon/heldglove/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HELDGLOVE_TRAIT)

//Boxing gloves
/obj/item/clothing/gloves/heldgloves/boxing
	name = "拳击手套"
	desc = "因为你真的需要另一个借口来揍你的船员."
	icon = 'icons/obj/clothing/boxing.dmi'
	icon_state = "boxing"
	rightglove_path = /obj/item/weapon/heldglove/boxing/hook
	leftglove_path = /obj/item/weapon/heldglove/boxing/jab

/obj/item/clothing/gloves/heldgloves/boxing/attackby(obj/item/I, mob/user, params)
	if(iswirecutter(I) || istype(I, /obj/item/tool/surgery/scalpel))
		to_chat(user, span_notice("那样行不通."))
		return
	return ..()

/obj/item/weapon/heldglove/boxing
	name = "拳击手套"
	desc = "因为你真的需要另一个借口来揍你的船员."
	icon = 'icons/obj/clothing/boxing.dmi'
	icon_state = "boxing"
	damtype = STAMINA
	force = 10
	w_class = WEIGHT_CLASS_BULKY
	hitsound = "punch"

/obj/item/weapon/heldglove/boxing/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!ishuman(M))
		return

	var/mob/living/carbon/human/target = M
	if(!(target.get_stamina_loss() > 10 && (target.stat != UNCONSCIOUS)))
		return

	playsound(loc, 'sound/effects/knockout.ogg', 25, FALSE)
	target.balloon_alert_to_viewers("[target]精疲力竭地倒在地上! K.O!", "你放弃了并倒下! K.O!")
	target.Sleeping(10 SECONDS)

/obj/item/weapon/heldglove/boxing/hook
	icon_state = "boxing_p"
	attack_verb = list("punches")

/obj/item/weapon/heldglove/boxing/jab
	icon_state = "boxing_j"
	attack_verb = list("jabs")

/obj/item/clothing/gloves/heldgloves/boxing/green
	icon_state = "boxinggreen"
	rightglove_path = /obj/item/weapon/heldglove/boxing/hook/green
	leftglove_path = /obj/item/weapon/heldglove/boxing/jab/green

/obj/item/weapon/heldglove/boxing/hook/green
	icon_state = "boxing_p_g"

/obj/item/weapon/heldglove/boxing/jab/green
	icon_state = "boxing_j_g"

/obj/item/clothing/gloves/heldgloves/boxing/blue
	icon_state = "boxingblue"
	rightglove_path = /obj/item/weapon/heldglove/boxing/hook/blue
	leftglove_path = /obj/item/weapon/heldglove/boxing/jab/blue

/obj/item/weapon/heldglove/boxing/hook/blue
	icon_state = "boxing_p_b"

/obj/item/weapon/heldglove/boxing/jab/blue
	icon_state = "boxing_j_b"

/obj/item/clothing/gloves/heldgloves/boxing/yellow
	icon_state = "boxingyellow"
	rightglove_path = /obj/item/weapon/heldglove/boxing/hook/yellow
	leftglove_path = /obj/item/weapon/heldglove/boxing/jab/yellow

/obj/item/weapon/heldglove/boxing/hook/yellow
	icon_state = "boxing_p_y"

/obj/item/weapon/heldglove/boxing/jab/yellow
	icon_state = "boxing_j_y"

//Punching bag. Both punches and attacking with weapons causes it to
/obj/structure/punching_bag
	name = "沙袋"
	desc = "一个纳米传讯沙袋. 在离太阳系这么远的地方很常见.\nCheap而且很脆弱, 如果被太重的东西击中可能会破裂."
	max_integrity = 750 //This is going to get hit, a lot
	icon = 'icons/obj/clothing/boxing.dmi'
	icon_state = "punchingbag"

/obj/structure/punching_bag/attackby(obj/item/I, mob/user, params)
	. = ..()
	flick("[icon_state]-punch", src)

/obj/item/clothing/gloves/white
	name = "白手套"
	desc = "这些看起来相当花哨."
	icon_state = "white"

/obj/item/clothing/gloves/techpriest
	name = "技术神甫手套"
	desc = "赞美万机神!"
	icon_state = "tp_gloves"
