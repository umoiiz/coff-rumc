/obj/structure/prop/brazier
	name = "火盆"
	desc = "火盆内的火焰发出的光芒比手电筒和照明弹相对暗淡,但没有什么能取代与朋友坐在壁炉旁的感觉."
	icon = 'icons/obj/structures/torch.dmi'
	icon_state = "brazier"
	density = TRUE
	light_on = TRUE
	light_range = 5
	light_power = 2
	light_system = STATIC_LIGHT
	light_color = "#b49a27"

/obj/structure/prop/brazier/Initialize(...)
	. = ..()
	set_light_on(FALSE)
	if(light_on)
		set_light_on(TRUE)

/obj/structure/prop/brazier/frame
	name = "空火盆"
	desc = "一个空火盆."
	icon_state = "brazier_frame"
	light_range = 0
	light_on = FALSE

/obj/structure/prop/brazier/frame/attackby(obj/item/hit_item, mob/user)
	if(!istype(hit_item, /obj/item/stack/sheet/wood))
		return ..()
	var/obj/item/stack/wooden_boards = hit_item
	if(wooden_boards.amount < 5)
		to_chat(user, span_warning("木头不够!"))
		return
	wooden_boards.use(5)
	user.visible_message(span_notice("[user]用木头填满了火盆."))
	new /obj/structure/prop/brazier/frame_woodened(loc)
	qdel(src)

/obj/structure/prop/brazier/frame_woodened
	name = "空满火盆"
	desc = "一个空的火盆. 但它又是满的. 什么???  用热的东西点燃它, 比如焊接工具."
	icon_state = "brazier_frame_filled"
	light_range = 0
	light_on = FALSE

/obj/structure/prop/brazier/frame_woodened/attackby(obj/item/hit_item, mob/user)
	if(hit_item.damtype != BURN)
		return ..()
	user.visible_message(span_notice("[user]用[hit_item]点燃了火盆."))
	new /obj/structure/prop/brazier(loc)
	qdel(src)

/obj/structure/prop/brazier/torch
	name = "火把"
	desc = "这是一支火把."
	icon = 'icons/obj/structures/torch.dmi'
	icon_state = "torch"
	density = FALSE
	light_range = 7
	light_power = 1

/obj/structure/prop/brazier/torch/frame
	name = "未点燃的火把"
	desc = "这是一支火把, 但它没有点燃.  用热的东西点燃它, 比如焊接工具."
	icon_state = "torch_frame"
	light_range = 0

/obj/structure/prop/brazier/torch/frame/attackby(obj/item/hit_item, mob/user)
	if(hit_item.damtype != BURN)
		return ..()
	user.visible_message(span_notice("[user]用[hit_item]点燃了火把."))
	new /obj/structure/prop/brazier/torch(loc)
	qdel(src)

/obj/item/frame/torch_frame
	name = "未点燃的火把"
	icon = 'icons/obj/structures/torch.dmi'
	desc = "这是一支火把, 但它没有点燃或放置下来. 点击墙壁来放置它."
	icon_state = "torch_frame"

/obj/item/frame/torch_frame/proc/try_build(turf/on_wall)
	if(get_dist(on_wall, usr) > 1)
		return
	var/ndir = get_dir(usr, on_wall)
	if(!(ndir in GLOB.cardinals))
		return
	var/turf/loc = get_turf(usr)
	if(!isfloorturf(loc))
		to_chat(usr, span_warning("[src.name]无法放置在这个位置."))
		return
	to_chat(usr, "正在将[src]附着到墙上.")
	playsound(src.loc, 'sound/machines/click.ogg', 15, 1)
	var/constrdir = usr.dir
	if(!do_after(usr, 30, TRUE, on_wall, BUSY_ICON_BUILD))
		return
	var/obj/structure/prop/brazier/torch/frame/newlight = new /obj/structure/prop/brazier/torch/frame(get_turf(on_wall))
	newlight.setDir(constrdir)

	usr.visible_message("[usr.name]将[src]附着到了墙上.", \
		"You attach [src] to the wall.")
	qdel(src)
