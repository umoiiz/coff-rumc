/* Weapons
* Contains:
*		Banhammer
*		Classic Baton
*		Energy Shield
*/

/*
* Banhammer
*/
/obj/item/weapon/banhammer/attack(mob/M as mob, mob/user as mob)
	to_chat(M, "<font color='red'><b>你已被[user]以毫无理由为由封禁<b></font>")
	to_chat(user, "<font color='red'>你已被<b>封禁</b>[M]</font>")


/*
* Classic Baton
*/
/obj/item/weapon/classic_baton
	name = "警棍"
	desc = "一根用来殴打罪犯渣滓的木制警棍。"
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "baton"
	worn_icon_state = "classic_baton"
	equip_slot_flags = ITEM_SLOT_BELT
	force = 10

/obj/item/weapon/classic_baton/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!.)
		return

	M.set_timed_status_effect(16 SECONDS, /datum/status_effect/speech/stutter, only_if_higher = TRUE)
	visible_message(span_danger("[M]被[user]用\the [src]打了!"), null, span_warning("你听到有人倒下的声音"), 2)

//Telescopic baton
/obj/item/weapon/telebaton
	name = "伸缩警棍"
	desc = "一种紧凑但经过重新平衡的个人防卫武器.折叠时可以隐藏."
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "telebaton_0"
	worn_icon_state = "telebaton_0"
	equip_slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	force = 3
	var/on = 0


/obj/item/weapon/telebaton/attack_self(mob/user as mob)
	on = !on
	if(on)
		user.visible_message(span_warning("[user]手腕一抖,展开了伸缩警棍."),\
		span_warning("你展开了警棍."),\
		"You hear an ominous click.")
		icon_state = "telebaton_1"
		worn_icon_state = "telebaton_1"
		w_class = WEIGHT_CLASS_NORMAL
		force = 20
		attack_verb = list("smacks", "strikes", "slaps")
	else
		user.visible_message(span_notice("[user]收起了伸缩警棍."),\
		span_notice("你收起了警棍."),\
		"You hear a click.")
		icon_state = "telebaton_0"
		worn_icon_state = "telebaton_0"
		w_class = WEIGHT_CLASS_SMALL
		force = 3//not so robust now
		attack_verb = list("hits", "punches")

	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		H.update_inv_l_hand(0)
		H.update_inv_r_hand()

	playsound(src.loc, 'sound/weapons/guns/fire/empty.ogg', 15, 1)

	if(blood_overlay) //updates blood overlay, if any
		overlays.Cut()//this might delete other item overlays as well but eeeeeeeh

		var/icon/I = new /icon(src.icon, src.icon_state)
		I.Blend(new /icon('icons/effects/blood.dmi', rgb(255,255,255)),ICON_ADD)
		I.Blend(new /icon('icons/effects/blood.dmi', "itemblood"),ICON_MULTIPLY)
		blood_overlay = I

		overlays += blood_overlay


/obj/item/weapon/telebaton/attack(mob/target as mob, mob/living/user as mob)
	if(on)
		if(..())
			//playsound(src.loc, "swing_hit", 25, 1, 6)
			return
	else
		return ..()
