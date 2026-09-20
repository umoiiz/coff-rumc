//antag spyglasses. meant to be an example for map_popups.dm
/obj/item/clothing/glasses/regular/spy
	desc = "由Nerd. Co的渗透与监视部门制造. 仔细观察的话, 每个镜片里都有一个小屏幕."
	var/obj/item/spy_bug/linked_bug

/obj/item/clothing/glasses/regular/spy/proc/show_to_user(mob/user)//this is the meat of it. most of the map_popup usage is in this.
	if(!user)
		return
	if(!user.client)
		return
	if(!linked_bug)
		user.audible_message(span_warning("[src]发出了一声尖锐的哔声!"))
	if("spypopup_map" in user.client.screen_maps) //alright, the popup this object uses is already IN use, so the window is open. no point in doing any other work here, so we're good.
		return
	user.client.setup_popup("spypopup", 3, 3, 2)
	linked_bug.cam_screen.display_to(user) // todo does not get removed
	linked_bug.update_view()

/obj/item/clothing/glasses/regular/spy/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_EYES)
		user.client.close_popup("spypopup")

/obj/item/clothing/glasses/regular/spy/dropped(mob/user)
	. = ..()
	user.client.close_popup("spypopup")

/obj/item/clothing/glasses/regular/spy/verb/activate_remote_view()
	//yada yada check to see if the glasses are in their eye slot
	if(ishuman(usr))
		var/mob/living/carbon/human/user = usr
		if(user.glasses == src)
			show_to_user(user)

/obj/item/clothing/glasses/regular/spy/Destroy()
	if(linked_bug)
		linked_bug.linked_glasses = null
		linked_bug = null
	return ..()


/obj/item/spy_bug
	name = "口袋护套"
	icon = 'icons/obj/clothing/accessories.dmi'
	icon_state = "pocketprotector"
	desc = "一件伪装成口袋护套的高级间谍设备. 它内置了360度摄像头, 满足你所有不可告人的需求. 不包含麦克风."

	var/obj/item/clothing/glasses/regular/spy/linked_glasses
	var/atom/movable/screen/map_view/cam_screen
	// Ranges higher than one can be used to see through walls.
	var/cam_range = 1
	var/datum/movement_detector/tracker

/obj/item/spy_bug/Initialize(mapload)
	. = ..()
	tracker = new /datum/movement_detector(src, CALLBACK(src, PROC_REF(update_view)))

	cam_screen = new
	cam_screen.generate_view("spypopup_map_[REF(src)]")

/obj/item/spy_bug/Destroy()
	if(linked_glasses)
		linked_glasses.linked_bug = null
	QDEL_NULL(cam_screen)
	QDEL_NULL(tracker)
	return ..()

/obj/item/spy_bug/proc/update_view()//this doesn't do anything too crazy, just updates the vis_contents of its screen obj
	cam_screen.vis_contents.Cut()
	for(var/turf/visible_turf in view(1,get_turf(src)))//fuck you usr
		cam_screen.vis_contents += visible_turf

//it needs to be linked, hence a kit.
/obj/item/storage/box/rxglasses/spyglasskit
	name = "间谍眼镜套装"
	desc = "这个盒子里装有<i>酷炫</i>的书呆子眼镜; 内置显示屏, 可查看连接的摄像头."

/obj/item/paper/fluff/nerddocs
	name = "间谍活动入门指南"
	color = "#FFFF00"
	desc = "一本黄得刺眼的小册子, 上面印着一个设计拙劣的侦探形象. 副标题写着\"侵犯隐私准则的最新方式!\""
	info = @{"

Thank you for your purchase of the Nerd Co SpySpeks <small>tm</small>, this paper will be your quick-start guide to violating the privacy of your crewmates in three easy steps!<br><br>Step One: Nerd Co SpySpeks <small>tm</small> upon your face. <br>
Step Two: Place the included "ProfitProtektor <small>tm</small>" camera assembly in a place of your choosing - make sure to make heavy use of it's inconspicous design!

Step Three: Press the "Activate Remote View" Button on the side of your SpySpeks <small>tm</small> to open a movable camera display in the corner of your vision, it's just that easy!<br><br><br><center><b>TROUBLESHOOTING</b><br></center>
My SpySpeks <small>tm</small> Make a shrill beep while attempting to use!

A shrill beep coming from your SpySpeks means that they can't connect to the included ProfitProtektor <small>tm</small>, please make sure your ProfitProtektor is still active, and functional!
	"}

/obj/item/storage/box/rxglasses/spyglasskit/PopulateContents()
	var/obj/item/spy_bug/newbug = new(src)
	var/obj/item/clothing/glasses/regular/spy/newglasses = new(src)
	newbug.linked_glasses = newglasses
	newglasses.linked_bug = newbug
	new /obj/item/paper/fluff/nerddocs(src)
