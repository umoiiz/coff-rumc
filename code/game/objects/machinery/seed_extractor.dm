/obj/machinery/seed_extractor
	name = "seed extractor"
	desc = "从农产品中提取并装袋种子."
	icon = 'icons/obj/machines/hydroponics.dmi'
	icon_state = "sextractor"
	density = TRUE
	anchored = TRUE

/obj/machinery/seed_extractor/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	// Fruits and vegetables.
	if(istype(I, /obj/item/reagent_containers/food/snacks/grown) || istype(I, /obj/item/grown))
		if(!user.temporarilyRemoveItemFromInventory(I))
			return

		var/datum/seed/new_seed_type
		if(istype(I, /obj/item/grown))
			var/obj/item/grown/F = I
			new_seed_type = GLOB.seed_types[F.plantname]
		else
			var/obj/item/reagent_containers/food/snacks/grown/F = I
			new_seed_type = GLOB.seed_types[F.plantname]

		if(new_seed_type)
			to_chat(user, span_notice("你从[I]中提取了一些种子."))
			var/produce = rand(1, 4)
			for(var/i = 1 to produce)
				var/obj/item/seeds/seeds = new(get_turf(src), FALSE)
				seeds.seed_type = new_seed_type.name
				seeds.update_seed()
		else
			to_chat(user, "[I]里面似乎没有任何可用的种子.")

		qdel(I)

	//Grass.
	else if(istype(I, /obj/item/stack/tile/grass))
		var/obj/item/stack/tile/grass/S = I
		if(!S.use(1))
			return
		to_chat(user, span_notice("你从草地格中提取了一些种子."))
		new /obj/item/seeds/grassseed(loc)
