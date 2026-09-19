// Surgery Tools
/obj/item/tool/surgery
	icon = 'icons/obj/items/surgery_tools.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/equipment/surgery_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/equipment/surgery_right.dmi',
	)
	attack_speed = 11 //Used to be 4 which made them attack insanely fast.

/obj/item/tool/surgery/retractor
	name = "牵开器"
	desc = "用于手术中的精细操作."
	icon_state = "retractor"
	atom_flags = CONDUCT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/tool/surgery/hemostat
	name = "止血钳"
	desc = "用于手术中移除异物."
	icon_state = "hemostat"
	atom_flags = CONDUCT
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("attacks", "pinches")

/obj/item/tool/surgery/cautery
	name = "烧灼器"
	desc = "用于闭合切口以完成手术."
	icon_state = "cautery"
	atom_flags = CONDUCT
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("burns")

/obj/item/tool/surgery/surgicaldrill
	name = "手术钻"
	desc = "你可以用这个物品钻孔. 你懂吗?"
	icon_state = "drill"
	hitsound = 'sound/weapons/circsawhit.ogg'
	atom_flags = CONDUCT
	force = 15
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("drills")

/obj/item/tool/surgery/scalpel
	name = "手术刀"
	desc = "切, 切, 再切一次."
	icon_state = "scalpel"
	atom_flags = CONDUCT
	force = 20
	sharp = IS_SHARP_ITEM_ACCURATE
	edge = 1
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	attack_verb = list("attacks", "slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")

/*
* Researchable Scalpels
*/
/obj/item/tool/surgery/scalpel/laser3
	name = "激光手术刀"
	desc = "附有定向激光的手术刀, 可进行更精确的切割, 且不会让血液进入术野. 这把看起来是精密能量刀具的巅峰之作!"
	icon_state = "scalpel_laser3_on"
	damtype = BURN
	force = 15

/obj/item/tool/surgery/scalpel/manager
	name = "切口管理系统"
	desc = "外科医生身体的真正延伸, 这一奇迹能瞬间且完全地准备好切口, 以便立即开始治疗步骤."
	icon_state = "scalpel_manager_on"
	force = 7.5

/*
* Circular Saw
*/
/obj/item/tool/surgery/circular_saw
	name = "圆锯"
	desc = "用于以手术方式打开某人的胸腔."
	icon_state = "saw"
	hitsound = 'sound/weapons/circsawhit.ogg'
	atom_flags = CONDUCT
	force = 30
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 9
	throw_speed = 3
	throw_range = 5
	attack_verb = list("attacks", "slashes", "saws", "cuts")
	sharp = IS_SHARP_ITEM_BIG
	edge = 1

//misc, formerly from code/defines/weapons.dm
/obj/item/tool/surgery/bonegel
	name = "骨胶"
	desc = "用于修复骨折和闭合胸腔."
	icon_state = "bone-gel"
	force = 0
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 1

/obj/item/tool/surgery/FixOVein
	name = "FixOVein"
	desc = "用于修复内出血."
	icon_state = "fixovein"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	var/usage_amount = 10

/obj/item/tool/surgery/bonesetter
	name = "正骨器"
	desc = "用于在涂抹骨胶后复位骨折的骨头."
	icon_state = "bonesetter"
	force = 8
	throwforce = 9
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("attacks", "hits", "bludgeons")

/obj/item/tool/surgery/suture
	name = "手术缝合线"
	desc = "用于在手术中治疗基本的钝击和烧伤伤害."
	icon_state = "suture"
	force = 3
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("needles", "sews", "stabs")

/obj/item/tool/surgery/surgical_membrane
	name = "手术膜"
	desc = "用于在手术中修复受损器官和坏死组织."
	icon_state = "surgical_membrane"
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL

//pred shit

/obj/item/tool/surgery/retractor/predatorretractor
	name = "开膛器"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_retractor"

/obj/item/tool/surgery/hemostat/predatorhemostat
	name = "钳夹器"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_hemostat"

/obj/item/tool/surgery/cautery/predatorcautery
	name = "烧灼器"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_cautery"
	item_flags = ITEM_PREDATOR

/obj/item/tool/surgery/surgicaldrill/predatorsurgicaldrill
	name = "骨钻"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_drill"

/obj/item/tool/surgery/scalpel/predatorscalpel
	name = "切割器"
	icon_state = "predator_scalpel"
	force = 20

/obj/item/tool/surgery/circular_saw/predatorbonesaw
	name = "骨锯"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_bonesaw"
	item_flags = ITEM_PREDATOR
	force = 20

/obj/item/tool/surgery/bonegel/predatorbonegel
	name = "凝胶枪"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_bone-gel"

/obj/item/tool/surgery/FixOVein/predatorFixOVein
	name = "静脉修复器"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_fixovein"

/obj/item/tool/surgery/bonesetter/predatorbonesetter
	name = "正骨器"
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "predator_bonesetter"

/*
 * MEDICOMP TOOLS
 */

/obj/item/tool/surgery/stabilizer_gel
	name = "稳定凝胶瓶"
	desc = "用于稳定伤口以便治疗."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "stabilizer_gel"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	item_flags = ITEM_PREDATOR

/obj/item/tool/surgery/healing_gun
	name = "治疗枪"
	desc = "用于缝合已稳定的伤口."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "healing_gun"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	item_flags = ITEM_PREDATOR
	var/loaded  = TRUE

/obj/item/tool/surgery/healing_gun/update_icon()
	. = ..()
	if(loaded)
		icon_state = "healing_gun"
	else
		icon_state = "healing_gun_empty"

/obj/item/tool/surgery/healing_gun/attackby(obj/item/O, mob/user)
	if(!HAS_TRAIT(user, TRAIT_YAUTJA_TECH))
		to_chat(user, span_warning("你不知道如何将\the [O]放入\the [src]!"))
		return
	if(istype(O, /obj/item/tool/surgery/healing_gel))
		if(loaded)
			to_chat(user, span_warning("治疗枪内已经有一个胶囊了!"))
			return
		user.visible_message(span_warning("[user]将\a [O]装入\the [src]."), span_warning("你将\a [O]装入\the [src]."))
		playsound(loc, 'sound/items/air_release.ogg',25)
		loaded = TRUE
		update_icon()
		qdel(O)
		return
	return ..()

/obj/item/tool/surgery/healing_gel
	name = "治疗凝胶胶囊"
	desc = "用于重新装填治疗枪."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "healing_gel"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	item_flags = ITEM_PREDATOR

/obj/item/tool/surgery/wound_clamp
	name = "伤口夹"
	desc = "用于在治疗后夹合伤口."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "wound_clamp"
	force = 0
	throwforce = 1
	w_class = WEIGHT_CLASS_SMALL
	item_flags = ITEM_PREDATOR
