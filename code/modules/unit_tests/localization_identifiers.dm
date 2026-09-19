/// Test-only reagents model distinct translated labels that ckey() would erase.
/datum/reagent/localization_test_water
	name = "测试清水"

/datum/reagent/localization_test_acid
	name = "测试酸液"

/datum/unit_test/localization_reagent_identifiers/Run()
	// Every type must retain an unambiguous ID, independent of its display name.
	for(var/reagent_type in subtypesof(/datum/reagent))
		TEST_ASSERT_EQUAL(GLOB.name2reagent["[reagent_type]"], reagent_type, "Stable reagent IDs must resolve to their exact type")
	TEST_ASSERT_EQUAL(GLOB.name2reagent[""], null, "An empty localized ckey must never resolve to a reagent")
	TEST_ASSERT_EQUAL(GLOB.name2reagent["/obj/item"], null, "Non-reagent paths must not resolve")
	TEST_ASSERT_EQUAL(GLOB.name2reagent["water"], /datum/reagent/water, "Saved English water macros must still resolve")
	TEST_ASSERT_EQUAL(GLOB.name2reagent["sulphuricacid"], /datum/reagent/toxin/acid, "Legacy IDs that differ from type names must still resolve")
	TEST_ASSERT_EQUAL(GLOB.name2reagent["universalenzyme"], /datum/reagent/consumable/enzyme, "Legacy drink macros must still resolve")

	var/obj/machinery/chem_dispenser/dispenser = allocate(/obj/machinery/chem_dispenser)
	dispenser.dispensable_reagents = list(/datum/reagent/water, /datum/reagent/oxygen, /datum/reagent/localization_test_water, /datum/reagent/localization_test_acid)
	var/list/legacy_recipe = list("water" = 10, "oxygen" = 5)
	var/list/normalized = dispenser.normalize_recipe(legacy_recipe)
	TEST_ASSERT_EQUAL(normalized["/datum/reagent/water"], 10, "Legacy recipes should normalize to stable IDs")
	TEST_ASSERT_EQUAL(normalized["/datum/reagent/oxygen"], 5, "Normalization must preserve quantities")
	TEST_ASSERT_EQUAL(legacy_recipe["water"], 10, "Reading a saved legacy recipe must not mutate it")

	var/list/translated_recipe = list("/datum/reagent/localization_test_water" = 10, "/datum/reagent/localization_test_acid" = 5)
	var/list/translated_normalized = dispenser.normalize_recipe(translated_recipe)
	TEST_ASSERT_EQUAL(length(translated_normalized), 2, "Distinct CJK reagent labels must not merge into one macro entry")
	TEST_ASSERT_EQUAL(translated_normalized["/datum/reagent/localization_test_water"], 10, "The first translated reagent must retain its quantity")
	TEST_ASSERT_EQUAL(translated_normalized["/datum/reagent/localization_test_acid"], 5, "The second translated reagent must retain its quantity")

	// Exercise the same savefile representation used by chem_macros preferences.
	var/savefile/saved = new
	saved["chem_macros"] << list("中文配方" = translated_normalized)
	var/list/loaded
	saved["chem_macros"] >> loaded
	var/list/reloaded_recipe = dispenser.normalize_recipe(loaded["中文配方"])
	TEST_ASSERT_EQUAL(reloaded_recipe["/datum/reagent/localization_test_water"], 10, "Stable IDs and CJK macro names must survive savefile round trips")
	TEST_ASSERT_EQUAL(reloaded_recipe["/datum/reagent/localization_test_acid"], 5, "Savefiles must preserve distinct translated reagent entries")

	var/list/mixed = dispenser.normalize_recipe(list("water" = 10, "/datum/reagent/water" = 5))
	TEST_ASSERT_EQUAL(mixed["/datum/reagent/water"], 15, "Recording legacy and new entries should combine the same reagent")
	TEST_ASSERT_EQUAL(dispenser.normalize_recipe(list("water" = 10, "sulphuricacid" = 5)), null, "Unavailable reagents must reject the whole recipe")
	TEST_ASSERT_EQUAL(dispenser.normalize_recipe(list("" = 5)), null, "Empty IDs must be rejected")
	TEST_ASSERT_EQUAL(dispenser.normalize_recipe(list("water" = -5)), null, "Negative quantities must be rejected")
	TEST_ASSERT_EQUAL(dispenser.normalize_recipe(list("water" = "five")), null, "Non-numeric quantities must be rejected")
