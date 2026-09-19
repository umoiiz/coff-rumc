// Verb to link discord accounts to BYOND accounts
/client/verb/linkdiscord()
	set category = "OOC.Discord"
	set name = "Link Discord Account"
	set desc = "Register your account via the Discord bot."

	var/bot_url = CONFIG_GET(string/discord_bot_url)
	if(!bot_url)
		to_chat(src, span_warning("注册暂时不可用。"))
		return

	var/choice = tgui_alert(usr, "要绑定账号,需要在Discord机器人中完成注册。\n为此,请私信机器人发送命令'/reg'并附上你的昵称,然后按照说明操作。\n打开机器人?", "注册", list("Да", "Нет"))
	if(choice == "Да")
		DIRECT_OUTPUT(src, link(bot_url))

/client/verb/check_discord()
	set category = "OOC.Discord"
	set name = "Check Discord ID"
	set desc = "Check your Discord registration status"

	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_CHECK_DISCORD))
		to_chat(src, span_warning("请稍等片刻再重新检查。"))
		return
	TIMER_COOLDOWN_START(src, COOLDOWN_CHECK_DISCORD, 3 SECONDS)

	if(!SSdiscord)
		to_chat(src, span_notice("服务器仍在启动中。请稍等片刻。"))
		return

	if(!SSdiscord.is_aperture_api_configured())
		to_chat(src, span_warning("发生错误,请稍后再试。"))
		return

	var/result = SSdiscord.lookup_registration(usr.ckey)
	if(result == 0)
		to_chat(usr, span_notice("未找到数据。你确定你注册过吗?"))
		return

	if(!islist(result))
		to_chat(usr, span_warning("发生错误,请稍后再试。"))
		return

	var/list/data = result
	var/active = text2num(data["active"])
	switch(active)
		if(1)
			to_chat(usr, span_notice("注册未完成。请通过机器人继续注册,或联系管理员寻求帮助。"))
		if(2)
			to_chat(usr, span_notice("你已注册。"))
		else
			to_chat(usr, span_warning("发生错误,请稍后再试。"))

/client/verb/boosty_roly()
	set category = "OOC.Discord"
	set name = "Check Boosty"
	set desc = "Check your Boosty subscription tier"

	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_CHECK_DISCORD))
		to_chat(src, span_warning("请稍等片刻再重新检查。"))
		return
	TIMER_COOLDOWN_START(src, COOLDOWN_CHECK_DISCORD, 3 SECONDS)

	if(!SSdiscord)
		to_chat(src, span_notice("服务器仍在启动中。请稍等片刻。"))
		return

	var/tier = SSdiscord.get_boosty_tier(usr.ckey, TRUE)
	if(isnull(tier))
		to_chat(usr, span_warning("发生错误,请稍后再试。"))
		return

	if(tier == BOOSTY_TIER_0)
		to_chat(usr, span_notice("你没有订阅。"))
		return

	if(tier >= BOOSTY_TIER_1 && tier <= BOOSTY_TIER_3)
		to_chat(usr, span_notice("你的订阅等级为[tier]级。"))
		return

	to_chat(usr, span_warning("发生错误,请稍后再试。"))
