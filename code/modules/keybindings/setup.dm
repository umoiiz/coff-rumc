/datum/proc/keyLoop(client/user) // Called once every frame
	set waitfor = FALSE
	return

// removes all the existing macros
/client/proc/erase_all_macros()
	var/erase_output = ""
	var/list/macro_set = params2list(winget(src, "default.*", "command")) // The third arg doesnt matter here as we're just removing them all
	for(var/k in 1 to length(macro_set))
		var/list/split_name = splittext(macro_set[k], ".")
		var/macro_name = "[split_name[1]].[split_name[2]]" // [3] is "command"
		erase_output = "[erase_output];[macro_name].parent=null"
	winset(src, null, erase_output)


/client/proc/set_macros()
	set waitfor = FALSE

	//Reset the buffer
	for(var/key in keys_held)
		keyUp(key)

	erase_all_macros()

	var/list/macro_set = SSinput.macro_set
	for(var/k in 1 to length(macro_set))
		var/key = macro_set[k]
		var/command = macro_set[key]
		winset(src, "default-[REF(key)]", "parent=default;name=[key];command=[command]")

	// Mouse pass-through was added in 516.1674. Without it a mouse macro would
	// swallow the normal MouseDown/MouseUp handlers (including firing and clicks).
	if(byond_version > 516 || (byond_version == 516 && byond_build >= 1674))
		winset(src, "default-game-focus-down", "parent=default;name=MouseDown;command=\".output browseroutput:focusMapAfterClick x\";pass-through=true")
		winset(src, "default-game-focus-up", "parent=default;name=MouseUp;command=\".winset \\\"mapwindow.map.focus=true?mapwindow.keyboard_focus.focus=true\\\"\";pass-through=true")

	update_special_keybinds()
	// Registering chat bindings can focus the chat browser. Restore gameplay
	// after that finishes. This non-text control suspends IME composition until
	// a real input gains focus, without changing the user's input language.
	winset(src, "mapwindow.keyboard_focus", "focus=true")

/// Older clients and a loading/broken chat panel cannot perform the local
/// MouseDown focus handoff. Check focus on arrival so a delayed server reply
/// cannot steal focus from a chat input opened after the map click.
/client/proc/restore_game_keyboard_focus(control)
	if(control != "mapwindow.map")
		return
	if((byond_version > 516 || (byond_version == 516 && byond_build >= 1674)) && tgui_panel?.is_ready())
		return
	winset(src, null, "mapwindow.map.focus=true?mapwindow.keyboard_focus.focus=true")
