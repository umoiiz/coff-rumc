/// Regression coverage for text paths used by translated chat and UI strings.
/datum/unit_test/localization_text_safety

/datum/unit_test/localization_text_safety/Run()
	// Full-width punctuation must preserve speech bubble selection.
	TEST_ASSERT_EQUAL(say_test("你好？"), "1", "Full-width question mark should produce a question bubble")
	TEST_ASSERT_EQUAL(say_test("你好！"), "2", "Full-width exclamation mark should produce an exclamation bubble")
	TEST_ASSERT_EQUAL(say_test("你好。"), "4", "Full-width ideographic full stop should remain a normal bubble")
	TEST_ASSERT_EQUAL(say_test("Hello?"), "1", "ASCII question marks should keep their existing bubble")
	TEST_ASSERT_EQUAL(say_test("Hello!"), "2", "ASCII exclamation marks should keep their existing bubble")
	TEST_ASSERT_EQUAL(say_test("你好"), "4", "An unpunctuated CJK message should produce a normal bubble")

	// Character-aware previewing must retain complete CJK characters and honor the limit.
	TEST_ASSERT_EQUAL(TextPreview("甲乙丙丁戊己", 5), "甲乙...", "An over-limit preview should reserve room for the ellipsis")
	TEST_ASSERT_EQUAL(TextPreview("甲乙丙丁戊", 4), "甲...", "Truncation should not split a multibyte character")
	TEST_ASSERT_EQUAL(TextPreview("甲乙丙丁", 5), "甲乙丙丁", "A preview below the character limit should remain intact")
	TEST_ASSERT_EQUAL(TextPreview("甲乙丙丁", 4), "甲乙丙丁", "A preview exactly at the character limit should remain intact")
	TEST_ASSERT_EQUAL(TextPreview("甲乙ABC", 4), "甲...", "Mixed CJK and ASCII text should share a character limit")
	TEST_ASSERT_EQUAL(TextPreview("abcdef", 5), "ab...", "ASCII previews should obey the requested limit")
	TEST_ASSERT_EQUAL(TextPreview("甲乙丙丁", 3), "...", "A three-character limit should fit only the ellipsis")
	TEST_ASSERT_EQUAL(TextPreview("甲乙丙丁", 2), "..", "Short limits should also bound the ellipsis")
	TEST_ASSERT_EQUAL(TextPreview("甲", 0), "", "A zero-character limit should produce an empty preview")
	TEST_ASSERT_EQUAL(TextPreview(""), "\[...\]", "An empty input should retain the existing placeholder")

	// HTML stripping must apply the limit by character, before removing markup delimiters.
	TEST_ASSERT_EQUAL(strip_html("甲乙丙丁", 3), "甲乙", "strip_html should preserve complete CJK characters")
	TEST_ASSERT_EQUAL(strip_html("甲乙丙丁", 5), "甲乙丙丁", "A sufficiently large stripping limit should preserve the text")
	TEST_ASSERT_EQUAL(strip_html("甲", 1), "", "The stripping limit should retain its exclusive end-index convention")
	TEST_ASSERT_EQUAL(strip_html("<甲>乙"), "甲乙", "Removing HTML delimiters should preserve adjacent CJK characters")
