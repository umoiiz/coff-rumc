/client/verb/who()
	set name = "玩家列表"
	set category = "OOC"

	SSwho.who.ui_interact(mob)

/client/verb/staffwho()
	set category = "Admin"
	set name = "Staffwho"

	SSwho.staff_who.ui_interact(mob)
