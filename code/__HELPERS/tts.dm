/proc/tts_speech_filter(text)
	// Keep Latin/Cyrillic/CJK text and punctuation. Punctuation is significant to
	// prosody, so it must survive the server-side filter instead of being dropped.
	var/static/regex/bad_chars_regex = regex(@"[^\x20-\x7E\u0410-\u044F\u0401\u0451\u4E00-\u9FFF\u3400-\u4DBF\u3000-\u303F\uFF00-\uFFEF\t\n]", "g")
	return bad_chars_regex.Replace(text, " ")
