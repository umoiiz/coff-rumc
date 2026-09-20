world
	name = "IME probe (local only)"
	maxx = 15
	maxy = 15
	maxz = 1
	view = 7
	fps = 30
	mob = /mob/probe
	turf = /turf/probe
	visibility = 0

/world/New()
	log = file("probe.log")
	..()

/mob/probe
	maptext = "<span style='color:red;font-size:24px'>@</span>"

/mob/probe/Login()
	..()
	loc = locate(8,8,1)

/turf/probe/New()
	..()
	maptext = "<span style='color:#777'>.</span>"

/client/New()
	..()
	src << "Map: click above, then press W/A/S/D. Native text box: below map. Browser: right."
	spawn(10)
		src << browse(file2text("probe.html"))
		winset(src, "main.keyfocus", "focus=true")
		if(byond_version > 516 || (byond_version == 516 && byond_build >= 1674))
			winset(src, "default-focus-down", "parent=default;name=MouseDown;command=\".output main.browser:deferMapFocus x\";pass-through=true")
			winset(src, "default-focus-up", "parent=default;name=MouseUp;command=\".winset \\\"main.map.focus=true?main.keyfocus.focus=true\\\"\";pass-through=true")
		probe_record("connected", list("version" = byond_version, "build" = byond_build))

/client/verb/reload_browser()
	set hidden = TRUE
	src << browse(file2text("probe.html"))

/client/proc/probe_record(kind, list/data)
	var/list/entry = list("tick" = world.time, "kind" = kind, "data" = data)
	var/encoded = json_encode(entry)
	world.log << encoded
	src << output(url_encode(encoded), "main.browser:recordNative")

/client/verb/probe_down(key as text)
	set hidden = TRUE
	set instant = TRUE
	probe_record("macro-down", list("key" = key))
	switch(key)
		if("W", "North")
			step(mob, NORTH)
		if("A", "West")
			step(mob, WEST)
		if("S", "South")
			step(mob, SOUTH)
		if("D", "East")
			step(mob, EAST)

/client/verb/probe_up(key as text)
	set hidden = TRUE
	set instant = TRUE
	probe_record("macro-up", list("key" = key))

/client/verb/probe_focus(control as text)
	set hidden = TRUE
	probe_record("native-focus", list("control" = control))

/client/MouseDown(object, location, control, params)
	if(byond_build < 1674 && control == "main.map")
		winset(src, null, "main.map.focus=true?main.keyfocus.focus=true")
	probe_record("mouse-down", list("control" = control, "params" = params))
	spawn(1)
		probe_record("focus-after-down", list("focus" = winget(src, null, "focus")))
	return ..()

/client/MouseUp(object, location, control, params)
	if(byond_build < 1674 && control == "main.map")
		winset(src, null, "main.map.focus=true?main.keyfocus.focus=true")
	probe_record("mouse-up", list("control" = control, "params" = params))
	return ..()

/client/Click(object, location, control, params)
	probe_record("click", list("control" = control, "params" = params))
	return ..()

/client/MouseDrag(src_object, over_object, src_location, over_location, src_control, over_control, params)
	probe_record("mouse-drag", list("control" = src_control, "over" = over_control))
	return ..()

/client/MouseDrop(src_object, over_object, src_location, over_location, src_control, over_control, params)
	probe_record("mouse-drop", list("control" = src_control, "over" = over_control))
	return ..()

/client/Topic(href, list/params)
	if(params["event"])
		var/list/event = json_decode(params["event"])
		world.log << json_encode(list("tick" = world.time, "kind" = "browser", "data" = event))
	if(params["focus"] == "map")
		winset(src, "main.map", "focus=true")
	if(params["focus"] == "native")
		winset(src, "main.native", "focus=true")
	if(params["inspect"])
		probe_record("focus", list("value" = winget(src, null, "focus")))
	if(params["focus"] == "button")
		winset(src, "main.keyfocus", "focus=true")
	if(params["focus"] == "browser")
		winset(src, "main.browser", "focus=true")
	if(params["inspect"])
		for(var/property in list("focus", "caps-lock", "ime", "ime-mode", "input-language", "keyboard-layout"))
			probe_record("winget", list("property" = property, "value" = winget(src, null, property)))
