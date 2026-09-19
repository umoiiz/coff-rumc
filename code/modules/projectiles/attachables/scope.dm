/obj/item/attachable/scope
	name = "导轨瞄准镜"
	icon_state = "sniperscope"
	desc = "一种安装在导轨上的变焦瞄准镜. 通过激活配件来变焦."
	slot = ATTACHMENT_SLOT_RAIL
	aim_speed_mod = 0.5 //Extra slowdown when aiming
	wield_delay_mod = 0.4 SECONDS
	scoped_accuracy_mod = SCOPE_RAIL //accuracy mod of 0.4 when scoped
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle
	scope_zoom_mod = TRUE // codex
	accuracy_unwielded_mod = -0.05
	zoom_tile_offset = 11
	zoom_viewsize = 10
	zoom_allow_movement = TRUE
	///how much slowdown the scope gives when zoomed. You want this to be slowdown you want minus aim_speed_mod
	var/zoom_slowdown = 1
	/// scope zoom delay, delay before you can aim.
	var/scope_delay = 0
	///boolean as to whether a scope can apply nightvision
	var/has_nightvision = FALSE
	///boolean as to whether the attachment is currently giving nightvision
	var/active_nightvision = FALSE
	///True if the scope is supposed to reactiveate when a deployed gun is turned.
	var/deployed_scope_rezoom = FALSE

/obj/item/attachable/scope/marine
	name = "T-47导轨瞄准镜"
	desc = "一种陆战队标准安装的变焦瞄准镜. 通过激活配件来变焦."
	icon_state = "marinescope"

/obj/item/attachable/scope/nightvision
	name = "T-46夜视瞄准镜"
	icon_state = "nvscope"
	desc = "一种由Roh-Easy工业为TGMC研发的导轨安装夜视瞄准镜. 通过激活配件来变焦."
	has_nightvision = TRUE

/obj/item/attachable/scope/optical
	name = "T-49光学成像瞄准镜"
	icon_state = "imagerscope"
	desc = "一种专为AR-55和GL-54设计的导轨安装瞄准镜. 具备微光光学成像能力并有助于精确瞄准. 通过激活配件来变焦."
	has_nightvision = TRUE
	aim_speed_mod = 0.3
	wield_delay_mod = 0.2 SECONDS
	zoom_tile_offset = 7
	zoom_viewsize = 2
	add_aim_mode = TRUE

/obj/item/attachable/scope/mosin
	name = "莫辛纳甘导轨瞄准镜"
	icon_state = "mosinscope"
	desc = "一种莫辛专用的安装式变焦瞄准镜. 通过激活配件来变焦."

/obj/item/attachable/scope/standard_magnum
	name = "R-76导轨瞄准镜"
	desc = "一种专为R-76马格南设计的定制导轨安装变焦瞄准镜. 通过激活配件来变焦."
	icon = 'icons/obj/items/attachments/attachments_64.dmi'
	icon_state = "t76scope"

/obj/item/attachable/scope/unremovable
	attach_features_flags = ATTACH_ACTIVATION

/obj/item/attachable/scope/unremovable/invisible
	icon_state = "sniperscope_invisible"

/obj/item/attachable/scope/unremovable/flaregun
	name = "远程机械瞄具"
	desc = "一套不可拆卸的照明枪远程机械瞄具."
	aim_speed_mod = 0
	wield_delay_mod = 0
	zoom_tile_offset = 5
	zoom_viewsize = 0
	scoped_accuracy_mod = SCOPE_RAIL_MINI
	zoom_slowdown = 0.50

/obj/item/attachable/scope/unremovable/sr127
	name = "T-45导轨瞄准镜"
	icon_state = "tl127_scope"
	aim_speed_mod = 0
	wield_delay_mod = 0
	desc = "一种专为SR-127狙击步枪特化的导轨安装变焦瞄准镜. 通过激活配件来变焦."

/obj/item/attachable/scope/unremovable/hmg08
	name = "HMG-08远程机械瞄具"
	desc = "一套不可拆卸的HMG-08机枪远程机械瞄具."
	icon_state = "sniperscope_invisible"
	zoom_viewsize = 0
	zoom_tile_offset = 5

/obj/item/attachable/scope/unremovable/mg27
	name = "MG-27导轨瞄准镜"
	icon_state = "miniscope"
	desc = "一种小型导轨安装变焦瞄准镜. 通过激活配件来变焦."
	wield_delay_mod = 0.2 SECONDS
	aim_speed_mod = 0.2
	scoped_accuracy_mod = SCOPE_RAIL_MINI
	zoom_slowdown = 0.3
	zoom_tile_offset = 5
	zoom_viewsize = 0

/obj/item/attachable/scope/unremovable/at36
	name = "AT-36远程瞄准镜"
	desc = "一套不可拆卸的远程瞄准镜, 非常难以正确测距. 需要时间瞄准.."
	icon_state = "sniperscope_invisible"
	scope_delay = 2 SECONDS
	zoom_tile_offset = 7

/obj/item/attachable/scope/unremovable/hsg102
	name = "HSG-102智能瞄具"
	desc = "一种专为hsg102使用而内置的不可拆卸智能瞄具, 它几乎能完成枪械集成IFF系统的所有瞄准工作."
	icon_state = "sniperscope_invisible"
	zoom_viewsize = 0
	zoom_tile_offset = 5
	deployed_scope_rezoom = TRUE

//all mounted guns with a nest use this
/obj/item/attachable/scope/unremovable/hsg102/nest
	scope_delay = 2 SECONDS
	zoom_tile_offset = 7
	zoom_viewsize = 2
	deployed_scope_rezoom = FALSE

/obj/item/attachable/scope/activate(mob/living/carbon/user, turn_off)
	if(turn_off)
		if(SEND_SIGNAL(user, COMSIG_ITEM_ZOOM) & COMSIG_ITEM_ALREADY_ZOOMED)
			zoom(user)
		return TRUE

	if(!(master_gun.item_flags & WIELDED) && !CHECK_BITFIELD(master_gun.deploy_flags, IS_DEPLOYED))
		if(user)
			to_chat(user, span_warning("你必须双手持握[master_gun]才能使用[src]."))
		return FALSE
	if(CHECK_BITFIELD(master_gun.deploy_flags, IS_DEPLOYED) && user.dir != master_gun.loc.dir)
		user.setDir(master_gun.loc.dir)
	if(!do_after(user, scope_delay, NONE, src, BUSY_ICON_BAR))
		return FALSE
	zoom(user)
	update_icon()
	return TRUE

/obj/item/attachable/scope/zoom_item_turnoff(datum/source, mob/living/carbon/user)
	if(ismob(source))
		INVOKE_ASYNC(src, PROC_REF(activate), source, TRUE)
	else
		INVOKE_ASYNC(src, PROC_REF(activate), user, TRUE)

/obj/item/attachable/scope/onzoom(mob/living/user)
	if(zoom_allow_movement)
		user.add_movespeed_modifier(MOVESPEED_ID_SCOPE_SLOWDOWN, TRUE, 0, NONE, TRUE, zoom_slowdown)
		RegisterSignal(user, COMSIG_CARBON_SWAPPED_HANDS, PROC_REF(zoom_item_turnoff))
	else
		RegisterSignals(user, list(COMSIG_MOVABLE_MOVED, COMSIG_CARBON_SWAPPED_HANDS), PROC_REF(zoom_item_turnoff))
	if(!CHECK_BITFIELD(master_gun.deploy_flags, IS_DEPLOYED))
		RegisterSignal(user, COMSIG_MOB_FACE_DIR, PROC_REF(change_zoom_offset))
	RegisterSignals(master_gun, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_UNWIELD, COMSIG_ITEM_DROPPED), PROC_REF(zoom_item_turnoff))
	master_gun.accuracy_mult += scoped_accuracy_mod
	if(has_nightvision)
		active_nightvision = TRUE
		user.reset_perspective(src)

/obj/item/attachable/scope/on_unzoomed(mob/living/user)
	if(zoom_allow_movement)
		user.remove_movespeed_modifier(MOVESPEED_ID_SCOPE_SLOWDOWN)
		UnregisterSignal(user, list(COMSIG_CARBON_SWAPPED_HANDS, COMSIG_MOB_FACE_DIR))
	else
		UnregisterSignal(user, list(COMSIG_MOVABLE_MOVED, COMSIG_CARBON_SWAPPED_HANDS, COMSIG_MOB_FACE_DIR))
	UnregisterSignal(master_gun, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_UNWIELD, COMSIG_ITEM_DROPPED))
	master_gun.accuracy_mult -= scoped_accuracy_mod
	if(has_nightvision)
		active_nightvision = FALSE
		user.reset_perspective(user)

/obj/item/attachable/scope/update_remote_sight(mob/living/user)
	. = ..()
	user.lighting_cutoff = LIGHTING_CUTOFF_MEDIUM
	user.sync_lighting_plane_cutoff()
	return TRUE

/obj/item/attachable/scope/zoom(mob/living/user, tileoffset, viewsize)
	. = ..()
	//Makes the gun zoom align with the attachment, used for projectile procs
	if(zoom)
		master_gun.zoom = TRUE
	else
		master_gun.zoom = FALSE

/obj/item/attachable/scope/unremovable/laser_sniper_scope
	name = "泰拉实验型激光狙击步枪导轨瞄准镜"
	desc = "一种为泰拉实验型激光狙击步枪 (简称TE-S) 制造的陆战队标准安装变焦瞄准镜, 通过激活配件来变焦. 如果你的HUD没有恢复请按F12."
	icon = 'icons/obj/items/attachments/attachments.dmi'
	icon_state = "tes"

/obj/item/attachable/scope/unremovable/plasma_sniper_scope
	name = "PL-02狙击步枪导轨瞄准镜"
	desc = "一种为PL-02等离子狙击步枪制造的陆战队标准安装变焦瞄准镜, 通过激活配件来变焦. 如果你的HUD没有恢复请按F12."
	icon_state = "plasma_scope"

/obj/item/attachable/scope/mini
	name = "迷你导轨瞄准镜"
	icon_state = "miniscope"
	desc = "一种小型导轨安装变焦瞄准镜. 通过激活配件来变焦."
	slot = ATTACHMENT_SLOT_RAIL
	wield_delay_mod = 0.2 SECONDS
	accuracy_unwielded_mod = -0.05
	aim_speed_mod = 0.2
	scoped_accuracy_mod = SCOPE_RAIL_MINI
	scope_zoom_mod = TRUE
	has_nightvision = FALSE
	zoom_allow_movement = TRUE
	zoom_slowdown = 0.3
	zoom_tile_offset = 5
	zoom_viewsize = 0
	variants_by_parent_type = list(/obj/item/weapon/gun/rifle/som = "")

/obj/item/attachable/scope/mini/ar11
	name = "AR-11迷你导轨瞄准镜"
	icon_state = "tx11scope"

/obj/item/attachable/scope/antimaterial
	name = "反器材导轨瞄准镜"
	desc = "一种专为反器材狙击步枪特化的导轨安装变焦瞄准镜. 通过激活配件来变焦. 可以在变焦时激活其瞄准激光来瞄准, 以增加伤害和穿透力."
	icon_state = "antimat"
	scoped_accuracy_mod = SCOPE_RAIL_SNIPER
	has_nightvision = TRUE
	zoom_allow_movement = FALSE
	attach_features_flags = ATTACH_ACTIVATION|ATTACH_REMOVABLE
	pixel_shift_x = 0
	pixel_shift_y = 17

/obj/item/attachable/scope/slavic
	icon_state = "slavicscope"

/obj/item/attachable/scope/pmc
	icon_state = "pmcscope"
	attach_features_flags = ATTACH_ACTIVATION

/obj/item/attachable/scope/mini/dmr
	name = "DMR-37迷你导轨瞄准镜"
	icon_state = "t37"
