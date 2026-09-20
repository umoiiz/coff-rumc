/* Closets for specific jobs
* Contains:
*		Bartender
*		Janitor
*		Lawyer
*/

/*
* Bartender
*/
/obj/structure/closet/gmcloset
	name = "正装柜"
	desc = "这是一个存放正装的储物柜."
	icon_state = "black"
	icon_closed = "black"

/obj/structure/closet/gmcloset/PopulateContents()
	new /obj/item/clothing/head/that(src)
	new /obj/item/clothing/head/that(src)
	new /obj/item/clothing/head/hairflower
	new /obj/item/clothing/under/sl_suit(src)
	new /obj/item/clothing/under/sl_suit(src)
	new /obj/item/clothing/under/rank/bartender(src)
	new /obj/item/clothing/under/rank/bartender(src)
	new /obj/item/clothing/under/dress/dress_saloon
	new /obj/item/clothing/suit/wcoat(src)
	new /obj/item/clothing/suit/wcoat(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)

/*
* Janitor
*/
/obj/structure/closet/jcloset
	name = "保洁柜"
	desc = "这是一个存放清洁工服装和装备的储物柜."
	icon_state = "mixed"
	icon_closed = "mixed"

/obj/structure/closet/jcloset/PopulateContents()
	new /obj/item/clothing/under/rank/janitor(src)
	new /obj/item/clothing/gloves/black(src)
	new /obj/item/clothing/head/soft/purple(src)
	new /obj/item/clothing/head/beret/jan(src)
	new /obj/item/flashlight(src)
	new /obj/item/tool/wet_sign(src)
	new /obj/item/tool/wet_sign(src)
	new /obj/item/tool/wet_sign(src)
	new /obj/item/tool/wet_sign(src)
	new /obj/item/lightreplacer(src)
	new /obj/item/storage/bag/trash(src)
	new /obj/item/clothing/shoes/galoshes(src)

/*
* Lawyer
*/
/obj/structure/closet/lawcloset
	name = "法务柜"
	desc = "这是一个存放法庭服装和物品的储物柜."
	icon_state = "blue"
	icon_closed = "blue"

/obj/structure/closet/lawcloset/PopulateContents()
	new /obj/item/clothing/under/lawyer/female(src)
	new /obj/item/clothing/under/lawyer/black(src)
	new /obj/item/clothing/under/lawyer/red(src)
	new /obj/item/clothing/under/lawyer/bluesuit(src)
	new /obj/item/clothing/suit/storage/lawyer/bluejacket(src)
	new /obj/item/clothing/under/lawyer/purpsuit(src)
	new /obj/item/clothing/suit/storage/lawyer/purpjacket(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/shoes/black(src)
