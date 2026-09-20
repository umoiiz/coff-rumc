#define ENCRYPT_CUSTOM_TERRAGOV (1<<0)
#define ENCRYPT_CUSTOM_SOM (1<<1)
GLOBAL_LIST_EMPTY_TYPED(custom_updating_encryptkeys, /obj/item/encryptionkey)

/obj/item/encryptionkey
	name = "标准加密钥匙"
	desc = "无线电耳机的加密钥匙."
	icon = 'icons/obj/items/radio.dmi'
	icon_state = "cypherkey"
	worn_icon_state = ""
	w_class = WEIGHT_CLASS_TINY
	var/list/channels = list()
	var/independent = FALSE
	///bitflags for factions that make this key grant certain factions custom squad frequencies automatically
	var/custom_squad_factions = NONE

/obj/item/encryptionkey/Initialize(mapload)
	. = ..()
	if(custom_squad_factions)
		GLOB.custom_updating_encryptkeys += src

/obj/item/encryptionkey/Destroy()
	. = ..()
	GLOB.custom_updating_encryptkeys -= src

/obj/item/encryptionkey/engi
	name = "工程无线电加密钥匙"
	icon_state = "eng_cypherkey"
	channels = list(RADIO_CHANNEL_ENGINEERING = TRUE,RADIO_CHANNEL_CAS = TRUE)

/obj/item/encryptionkey/cas
	name = "火力支援无线电加密钥匙"
	icon_state = "sec_cypherkey"
	channels = list(RADIO_CHANNEL_CAS = TRUE)

/obj/item/encryptionkey/med
	name = "医疗无线电加密钥匙"
	icon_state = "med_cypherkey"
	channels = list(RADIO_CHANNEL_MEDICAL = TRUE, RADIO_CHANNEL_REQUISITIONS = TRUE)

/obj/item/encryptionkey/cas
	name = "\improper 火力支援专家无线电加密钥匙"
	icon_state = "rob_cypherkey"
	channels = list(RADIO_CHANNEL_CAS = TRUE)

/obj/item/encryptionkey/mcom
	name = "\improper 陆战队指挥部无线电加密钥匙"
	icon_state = "cap_cypherkey"
	channels = list(RADIO_CHANNEL_COMMAND = TRUE, RADIO_CHANNEL_CAS = TRUE, RADIO_CHANNEL_ALPHA = TRUE, RADIO_CHANNEL_BRAVO = TRUE, RADIO_CHANNEL_CHARLIE = TRUE, RADIO_CHANNEL_DELTA = TRUE, RADIO_CHANNEL_ENGINEERING = TRUE, RADIO_CHANNEL_MEDICAL = TRUE, RADIO_CHANNEL_REQUISITIONS = TRUE)
	custom_squad_factions = ENCRYPT_CUSTOM_TERRAGOV

/obj/item/encryptionkey/mcom/ai //AI only.
	channels = list(RADIO_CHANNEL_COMMAND = TRUE, RADIO_CHANNEL_CAS = TRUE, RADIO_CHANNEL_ALPHA = TRUE, RADIO_CHANNEL_BRAVO = TRUE, RADIO_CHANNEL_CHARLIE = TRUE, RADIO_CHANNEL_DELTA = TRUE, RADIO_CHANNEL_ENGINEERING = TRUE, RADIO_CHANNEL_MEDICAL = TRUE, RADIO_CHANNEL_REQUISITIONS = TRUE)


/obj/item/encryptionkey/squadlead
	name = "\improper 小队队长加密钥匙"
	icon_state = "hop_cypherkey"
	channels = list(RADIO_CHANNEL_COMMAND = TRUE, RADIO_CHANNEL_CAS = TRUE)

/obj/item/encryptionkey/alpha
	name = "\improper 阿尔法小队无线电加密钥匙"
	icon_state = "eng_cypherkey"
	channels = list(RADIO_CHANNEL_ALPHA = TRUE)

/obj/item/encryptionkey/bravo
	name = "\improper 布拉沃小队无线电加密钥匙"
	icon_state = "cypherkey"
	channels = list(RADIO_CHANNEL_BRAVO = TRUE)

/obj/item/encryptionkey/charlie
	name = "\improper 查理小队无线电加密钥匙"
	icon_state = "sci_cypherkey"
	channels = list(RADIO_CHANNEL_CHARLIE = TRUE)

/obj/item/encryptionkey/delta
	name = "\improper 德尔塔小队无线电加密钥匙"
	icon_state = "hos_cypherkey"
	channels = list(RADIO_CHANNEL_DELTA = TRUE)

/obj/item/encryptionkey/general
	name = "\improper 通用无线电加密钥匙"
	icon_state = "cypherkey"
	channels = list(RADIO_CHANNEL_COMMON = TRUE, RADIO_CHANNEL_REQUISITIONS = TRUE)

//ERT
/obj/item/encryptionkey/dutch
	name = "\improper 殖民者加密钥匙"
	channels = list(RADIO_CHANNEL_COLONIST = TRUE)
	independent = TRUE


/obj/item/encryptionkey/PMC
	name = "\improper 纳米传讯加密钥匙"
	channels = list(RADIO_CHANNEL_PMC = TRUE)
	independent = TRUE


/obj/item/encryptionkey/usl
	name = "\improper USL加密钥匙"
	channels = list(RADIO_CHANNEL_USL = TRUE)
	independent = TRUE


/obj/item/encryptionkey/commando
	name = "\improper NT突击队加密钥匙"
	channels = list(RADIO_CHANNEL_DEATHSQUAD = TRUE)
	independent = TRUE


/obj/item/encryptionkey/imperial
	name = "\improper 帝国加密钥匙"
	channels = list(RADIO_CHANNEL_IMPERIAL = TRUE)
	independent = TRUE


/obj/item/encryptionkey/som
	name = "\improper 火星之子加密钥匙"
	channels = list(RADIO_CHANNEL_SOM = TRUE)
	independent = TRUE

/obj/item/encryptionkey/icc
	name = "\improper ICC加密钥匙"
	channels = list(RADIO_CHANNEL_ICC = TRUE)
	independent = TRUE

/obj/item/encryptionkey/retired
	name = "\improper 养老院加密钥匙"
	channels = list(RADIO_CHANNEL_RETIRED = TRUE)
	independent = TRUE

/obj/item/encryptionkey/sectoid
	name = "\improper 异形加密钥匙"
	channels = list(RADIO_CHANNEL_SECTOID = TRUE)
	independent = TRUE

/obj/item/encryptionkey/echo
	name = "\improper 回声特遣队加密钥匙"
	channels = list(RADIO_CHANNEL_ECHO = TRUE, RADIO_CHANNEL_COMMAND = TRUE, RADIO_CHANNEL_CAS = TRUE, RADIO_CHANNEL_ALPHA = TRUE, RADIO_CHANNEL_BRAVO = TRUE, RADIO_CHANNEL_CHARLIE = TRUE, RADIO_CHANNEL_DELTA = TRUE, RADIO_CHANNEL_ENGINEERING = TRUE, RADIO_CHANNEL_MEDICAL = TRUE, RADIO_CHANNEL_REQUISITIONS = TRUE)
	independent = TRUE

/obj/item/encryptionkey/vsd
	name = "\improper 安保分队加密钥匙"
	channels = list(RADIO_CHANNEL_VSD = TRUE)
	independent = TRUE

/obj/item/encryptionkey/erp
	name = "\improper 恶作剧者加密钥匙"
	channels = list(RADIO_CHANNEL_ERP = TRUE)
	independent = TRUE
