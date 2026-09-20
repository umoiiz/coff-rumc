/obj/item/stack/gun_powder
	name = "火药堆"
	desc = "一些火药堆."
	singular_name = "layer"
	icon_state = "gun_powder"
	w_class = WEIGHT_CLASS_HUGE
	merge_type = /obj/item/stack/gun_powder
	force = 2
	throw_speed = 5
	throw_range = 1
	max_amount = 25

/obj/item/stack/gun_powder/large_stack
	amount = 25

/obj/item/stack/sheet/composite
	name = "铁铜复合材料"
	desc = "由铁板和铜板制成的复合材料"
	singular_name = "composite sheet"
	icon_state = "CuFe_composite"
	worn_icon_state = "CuFe_composite"
	item_flags = NOBLUDGEON
	throwforce = 14
	atom_flags = CONDUCT
	merge_type = /obj/item/stack/sheet/composite
	number_of_extra_variants = 1

/obj/item/stack/sheet/composite/large_stack
	amount = 50

/obj/item/stack/sheet/jeweler_steel
	name = "珠宝钢"
	desc = "珠宝钢,含有贵金属"
	singular_name = "steel sheet"
	icon_state = "jeweler_steel"
	worn_icon_state = "jeweler_steel"
	item_flags = NOBLUDGEON
	throwforce = 14
	atom_flags = CONDUCT
	merge_type = /obj/item/stack/sheet/jeweler_steel
	number_of_extra_variants = 3

/obj/item/stack/sheet/jeweler_steel/large_stack
	amount = 50
