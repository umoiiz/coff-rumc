/obj/item/disk/botany
	name = "植物群数据磁盘"
	desc = "用于携带植物遗传数据的小磁盘."
	icon = 'icons/obj/items/disk.dmi'
	icon_state = "botanydisk"
	w_class = WEIGHT_CLASS_TINY
	var/list/genes = list()
	var/genesource = "unknown"

/obj/item/disk/botany/Initialize(mapload)
	. = ..()
	pixel_x = rand(-5,5)
	pixel_y = rand(-5,5)

/obj/item/disk/botany/attack_self(mob/user as mob)
	if(length(genes))
		var/choice = tgui_alert(user, "你确定要擦除磁盘吗?", "异星植物学数据", list("No", "Yes"))
		if(src && user && genes && choice == "Yes")
			to_chat(user, "你擦除了磁盘数据.")
			name = initial(name)
			desc = initial(name)
			genes = list()
			genesource = "unknown"

/obj/item/storage/box/botanydisk
	name = "植物群磁盘盒"
	desc = "显然是一盒植物群数据磁盘."
	spawn_type = /obj/item/disk/botany
	spawn_number = 7

/obj/machinery/botany
	icon = 'icons/obj/machines/hydroponics.dmi'
	icon_state = "hydrotray3"
	density = TRUE
	anchored = TRUE
	use_power = IDLE_POWER_USE
	interaction_flags = INTERACT_MACHINE_TGUI
	/// Currently loaded seed packet.
	var/obj/item/seeds/seed
	/// Currently loaded data disk.
	var/obj/item/disk/botany/loaded_disk

	var/open = 0
	var/active = 0
	var/action_time = 50
	var/last_action = 0
	var/eject_disk = 0
	var/failed_task = 0
	var/disk_needs_genes = 0

/obj/machinery/botany/process()
	. = ..()
	if(!active) return

	if(world.time > last_action + action_time)
		finished_task()

/obj/machinery/botany/proc/finished_task()
	active = 0
	if(failed_task)
		failed_task = 0
		visible_message("[icon2html(src, viewers(src))][src]不高兴地发出提示音,闪烁着红色警告灯.")
	else
		visible_message("[icon2html(src, viewers(src))][src]高兴地发出提示音.")

	if(eject_disk)
		eject_disk = 0
		if(loaded_disk)
			loaded_disk.loc = get_turf(src)
			visible_message("[icon2html(src, viewers(src))][src]发出哔哔声并吐出了[loaded_disk].")
			loaded_disk = null
	stop_processing()

/obj/machinery/botany/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/seeds))
		if(seed)
			to_chat(user, "已经装入了种子.")
			return
		var/obj/item/seeds/S = I
		if(S.seed?.immutable > 0)
			to_chat(user, "该种子与我们的遗传技术不兼容.")
			return

		user.drop_held_item()
		I.forceMove(src)
		seed = I
		to_chat(user, "你将[I]装入[src].")

	else if(istype(I, /obj/item/disk/botany))
		var/obj/item/disk/botany/B = I

		if(loaded_disk)
			to_chat(user, "已经装入了数据磁盘.")
			return

		if(length(B.genes) && !disk_needs_genes)
			to_chat(user, "该磁盘已加载基因数据.")
			return
		else if(disk_needs_genes)
			to_chat(user, "该磁盘未加载任何基因数据.")
			return

		user.drop_held_item()
		I.forceMove(src)
		loaded_disk = I
		to_chat(user, "你将[I]装入[src].")

/obj/machinery/botany/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	open = !open
	to_chat(user, span_notice("你[open ? "open" : "close"]维护面板."))

/obj/machinery/botany/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(open)
		deconstruct()


// Allows for a trait to be extracted from a seed packet, destroying that seed.
/obj/machinery/botany/extractor
	name = "lysis-isolation centrifuge"
	icon_state = "traitcopier"
	/// Currently scanned seed genetic structure.
	var/datum/seed/genetics
	/// Increments with each scan, stops allowing gene mods after a certain point.
	var/degradation = 0

/obj/machinery/botany/Topic(href, href_list)
	. = ..()
	if(.)
		return

	if(href_list["eject_packet"])
		if(!seed) return
		seed.loc = get_turf(src)

		if(seed.seed.name == "new line" || isnull(GLOB.seed_types[seed.seed.name]))
			seed.seed.uid = length(GLOB.seed_types) + 1
			seed.seed.name = "[seed.seed.uid]"
			GLOB.seed_types[seed.seed.name] = seed.seed

		seed.update_seed()
		visible_message("[icon2html(src, viewers(src))][src]发出哔哔声并吐出[seed].")

		seed = null

	if(href_list["eject_disk"])
		if(!loaded_disk) return
		loaded_disk.loc = get_turf(src)
		visible_message("[icon2html(src, viewers(src))][src]发出哔哔声并吐出[loaded_disk].")
		loaded_disk = null

/obj/machinery/botany/extractor/Topic(href, href_list)
	. = ..()
	if(.)
		return

	if(href_list["scan_genome"])

		if(!seed) return

		last_action = world.time
		active = 1
		start_processing()

		if(seed?.seed)
			genetics = seed.seed
			degradation = 0

		qdel(seed)
		seed = null

	if(href_list["get_gene"])

		if(!genetics || !loaded_disk) return

		last_action = world.time
		active = 1
		start_processing()

		var/datum/plantgene/P = genetics.get_gene(href_list["get_gene"])
		if(!P) return
		loaded_disk.genes += P

		loaded_disk.genesource = "[genetics.display_name]"
		if(!genetics.roundstart)
			loaded_disk.genesource += " (variety #[genetics.uid])"

		loaded_disk.name += " ([GLOB.gene_tag_masks[href_list["get_gene"]]], #[genetics.uid])"
		loaded_disk.desc += " The label reads \'gene [GLOB.gene_tag_masks[href_list["get_gene"]]], sampled from [genetics.display_name]\'."
		eject_disk = 1

		degradation += rand(20,60)
		if(degradation >= 100)
			failed_task = 1
			genetics = null
			degradation = 0

	if(href_list["clear_buffer"])
		if(!genetics) return
		genetics = null
		degradation = 0

	updateUsrDialog()

// Fires an extracted trait into another packet of seeds with a chance
// of destroying it based on the size/complexity of the plasmid.
/obj/machinery/botany/editor
	name = "bioballistic delivery system"
	icon_state = "traitgun"
	disk_needs_genes = 1

/obj/machinery/botany/editor/Topic(href, href_list)
	. = ..()
	if(.)
		return

	if(href_list["apply_gene"])
		if(!loaded_disk || !seed) return

		last_action = world.time
		active = 1
		start_processing()

		if(!isnull(GLOB.seed_types[seed.seed.name]))
			seed.seed = seed.seed.diverge(1)
			seed.seed_type = seed.seed.name
			seed.update_seed()

		if(prob(seed.modified))
			failed_task = 1
			seed.modified = 101

		for(var/datum/plantgene/gene in loaded_disk.genes)
			seed.seed.apply_gene(gene)
			seed.modified += rand(5,10)
