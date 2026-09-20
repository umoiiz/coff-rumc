/datum/supply_packs/factory
	group = "工厂"
	containertype = /obj/structure/closet/crate

/datum/supply_packs/factory/assembler
	name = "组装机"
	contains = list(/obj/machinery/assembler)
	cost = 50

/datum/supply_packs/factory/junk
	name = "废料制造机"
	contains = list(/obj/machinery/fabricator/junk)
	cost = 1500 //expensive, but pays for itself in about 15 minutes

/datum/supply_packs/factory/gunpowder
	name = "火药制造机"
	contains = list(/obj/machinery/fabricator/gunpowder)
	cost = 800
