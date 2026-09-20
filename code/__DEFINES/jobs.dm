#define SSJOB_OVERRIDE_JOBS_START (1<<0)

#define JOB_DISPLAY_ORDER_DEFAULT 0

#define JOB_DISPLAY_ORDER_CAPTAIN 1
#define JOB_DISPLAY_ORDER_EXECUTIVE_OFFICER 2
#define JOB_DISPLAY_ORDER_STAFF_OFFICER 3
#define JOB_DISPLAY_ORDER_PILOT_OFFICER 4
#define JOB_DISPLAY_ORDER_TRANSPORT_OFFICER 5
#define JOB_DISPLAY_ORDER_MECH_PILOT 6
#define JOB_DISPLAY_ORDER_SQUAD_LEADER 7
#define JOB_DISPLAY_ORDER_SQUAD_SMARTGUNNER 8
#define JOB_DISPLAY_ORDER_SQUAD_CORPSMAN 9
#define JOB_DISPLAY_ORDER_SUQAD_ENGINEER 10
#define JOB_DISPLAY_ORDER_SQUAD_MARINE 11
#define JOB_DISPLAY_ORDER_SQUAD_ROBOT 12
#define JOB_DISPLAY_ORDER_XENO_QUEEN 13
#define JOB_DISPLAY_ORDER_XENOMORPH 14
#define JOB_DISPLAY_ORDER_REQUISITIONS_OFFICER 15
#define JOB_DISPLAY_ORDER_SHIP_TECH 16
#define JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER 17
#define JOB_DISPLAY_ORDER_DOCTOR 18
#define JOB_DISPLAY_ORDER_FIELD_RESEARCHER 19
#define JOB_DISPLAY_ORDER_AI 20
#define JOB_DISPLAY_ORDER_SYNTHETIC 21
#define JOB_DISPLAY_ORDER_CORPORATE_LIAISON 22
#define JOB_DISPLAY_ORDER_SURVIVOR 23
#define JOB_DISPLAY_ORDER_CLOWN 24
#define JOB_DISPLAY_ORDER_MILITARY_POLICE 25
#define JOB_DISPLAY_ORDER_PREDATOR 26

#define JOB_FLAG_SPECIALNAME (1<<0)
#define JOB_FLAG_LATEJOINABLE (1<<1) //Can this job be selected for prefs to join as?
#define JOB_FLAG_ROUNDSTARTJOINABLE (1<<2) //Joinable at roundstart
#define JOB_FLAG_NOHEADSET (1<<3) //Doesn't start with a headset on spawn.
#define JOB_FLAG_ALLOWS_PREFS_GEAR (1<<4) //Allows preference loadouts.
#define JOB_FLAG_PROVIDES_BANK_ACCOUNT (1<<5) //$$$
#define JOB_FLAG_OVERRIDELATEJOINSPAWN (1<<6) //AIs and xenos, for example.
#define JOB_FLAG_ADDTOMANIFEST (1<<7) //Add info to datacore.
#define JOB_FLAG_ISCOMMAND (1<<8)
#define JOB_FLAG_BOLD_NAME_ON_SELECTION (1<<9)
#define JOB_FLAG_PROVIDES_SQUAD_HUD (1<<10)
#define JOB_FLAG_HIDE_CURRENT_POSITIONS (1<<11) //You can't see how many people have joined as on the latejoin menu.
#define JOB_FLAG_CAN_SEE_ORDERS (1<<12) //Able to see rally and CIC orders
#define JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP (1<<13) //Will appear on all minimaps, including squad minimaps
#define JOB_FLAG_SHOW_OPEN_POSITIONS (1<<14) //You can only see how many positions are opened, and not how many positions are fullfilled

#define CAPTAIN "舰长"
#define EXECUTIVE_OFFICER "执行官" //Currently disabled.
#define FIELD_COMMANDER "战地指挥官"
#define STAFF_OFFICER "参谋官"
#define TRANSPORT_OFFICER "运输官"
#define PILOT_OFFICER "飞行员"
#define MECH_PILOT "机甲驾驶员"
#define ASSAULT_CREWMAN "突击队员"
#define TRANSPORT_CREWMAN "运输船员"
#define REQUISITIONS_OFFICER "军需官"
#define CHIEF_MEDICAL_OFFICER "首席医疗官"
#define CORPORATE_LIAISON "企业联络员"
#define SYNTHETIC "合成人"
#define SHIP_TECH "舰船技术员"
#define MEDICAL_DOCTOR "医生"
#define FIELD_RESEARCHER "实地研究员"
#define SQUAD_LEADER "小队队长"
#define SQUAD_SPECIALIST "小队专家"
#define SQUAD_SMARTGUNNER "小队智能枪手"
#define SQUAD_CORPSMAN "小队医护兵"
#define SQUAD_ENGINEER "小队工程师"
#define SQUAD_MARINE "小队陆战队员"
#define SQUAD_ROBOT "小队机器人"
#define SQUAD_VATGROWN "小队培育兵"
#define SILICON_AI "人工智能"
#define JOB_PREDATOR "铁血战士"
#define CLOWN "舰船小丑"
#define MILITARY_POLICE "宪兵"
#define SURVIVOR "幸存者"

#define JOB_CAT_COMMAND "指挥"
#define JOB_CAT_SILICON "硅基"
#define JOB_CAT_REQUISITIONS "军需"
#define JOB_CAT_MEDICAL "医疗"
#define JOB_CAT_ENGINEERING "工程"
#define JOB_CAT_CIVILIAN "平民"
#define JOB_CAT_MARINE "陆战队员"
#define JOB_CAT_XENO "异形"
#define JOB_CAT_YAUTJA "铁血"
#define JOB_CAT_UNASSIGNED "Unassigned"

#define JOB_COMM_TITLE_SQUAD_LEADER "SL"

#define ROLE_XENOMORPH "Xenomorph"
#define ROLE_XENO_QUEEN "Xeno Queen"
#define ROLE_ERT "Emergency Response Team"
#define ROLE_VALHALLA "Valhalla"

#define ROLE_FALLEN(role) ("Fallen " + ##role)

GLOBAL_LIST_EMPTY(jobs_command)
GLOBAL_LIST_INIT(jobs_officers, list(
	CAPTAIN,
	FIELD_COMMANDER,
	STAFF_OFFICER,
	CORPORATE_LIAISON,
	PILOT_OFFICER,
	TRANSPORT_OFFICER,
	SYNTHETIC,
	SILICON_AI,
))
GLOBAL_LIST_INIT(jobs_support, list(
	PILOT_OFFICER,
	TRANSPORT_OFFICER,
	MECH_PILOT,
	ASSAULT_CREWMAN,
	TRANSPORT_CREWMAN,
	REQUISITIONS_OFFICER,
	SYNTHETIC,
	SILICON_AI,
))
GLOBAL_LIST_INIT(jobs_engineering, list(
	SQUAD_ENGINEER,
	SHIP_TECH,
))
GLOBAL_LIST_INIT(jobs_requisitions, list(
	REQUISITIONS_OFFICER,
	SHIP_TECH,
))
GLOBAL_LIST_INIT(jobs_medical, list(
	CHIEF_MEDICAL_OFFICER,
	MEDICAL_DOCTOR,
	FIELD_RESEARCHER,
	SQUAD_CORPSMAN,
))
GLOBAL_LIST_INIT(jobs_marines, list(
	SQUAD_LEADER,
	SQUAD_SMARTGUNNER,
	SQUAD_CORPSMAN,
	SQUAD_ENGINEER,
	SQUAD_MARINE,
	SQUAD_ROBOT,
))
GLOBAL_LIST_INIT(jobs_regular_all, list(
	CAPTAIN,
	FIELD_COMMANDER,
	STAFF_OFFICER,
	PILOT_OFFICER,
	TRANSPORT_OFFICER,
	MECH_PILOT,
	REQUISITIONS_OFFICER,
	CHIEF_MEDICAL_OFFICER,
	SYNTHETIC,
	SILICON_AI,
	CORPORATE_LIAISON,
	SHIP_TECH,
	MEDICAL_DOCTOR,
	FIELD_RESEARCHER,
	SQUAD_LEADER,
	SQUAD_SMARTGUNNER,
	SQUAD_CORPSMAN,
	SQUAD_ENGINEER,
	SQUAD_MARINE,
	SQUAD_ROBOT,
	SURVIVOR,
))
GLOBAL_LIST_INIT(jobs_xenos, list(
	ROLE_XENOMORPH,
	ROLE_XENO_QUEEN,
))
GLOBAL_LIST_INIT(jobs_fallen_marine, typecacheof(list(/datum/job/fallen/marine), TRUE))

//Playtime tracking system, see jobs_exp.dm
#define EXP_TYPE_LIVING "Living"
#define EXP_TYPE_REGULAR_ALL "Any TGMC"
#define EXP_TYPE_COMMAND "Command"
#define EXP_TYPE_ENGINEERING "Engineering"
#define EXP_TYPE_MEDICAL "Medical"
#define EXP_TYPE_MARINES "Marines"
#define EXP_TYPE_REQUISITIONS "Requisitions"
#define EXP_TYPE_SILICON "Silicon"
/// Used to limit synthetic to those who played at least medical or engineering.
#define EXP_TYPE_SYNTHETIC "Medical/Engineering"
/// Used to limit squad leader to those who played either marine or command. Also helps to unlock fc faster
#define EXP_TYPE_SL "Marines/Command"
#define EXP_TYPE_XENO "Xenomorph"
#define EXP_TYPE_GHOST "Ghost"
#define EXP_TYPE_ADMIN "Admin"
#define EXP_TYPE_FACEHUGGER_STAT "Facehugger_Stat"

// hypersleep bay flags
#define CRYO_MED "Medical"
#define CRYO_ENGI "Engineering"
#define CRYO_REQ "Requisitions"
#define CRYO_ALPHA "Alpha Squad"
#define CRYO_BRAVO "Bravo Squad"
#define CRYO_CHARLIE "Charlie Squad"
#define CRYO_DELTA "Delta Squad"

// Those are in minutes, and we convert them to hours
#define XP_REQ_NOVICE 300
#define XP_REQ_UNSEASONED 600
#define XP_REQ_INTERMEDIATE 1200
#define XP_REQ_UPPER_INTERMEDIATE 1800
#define XP_REQ_EXPERIENCED 2400
#define XP_REQ_MASTER 3000
#define XP_REQ_EXPERT 3600

// how much a job is going to contribute towards burrowed larva. see config for points required to larva. old balance was 1 larva per 3 humans.
#define LARVA_POINTS_SHIPSIDE 1
#define LARVA_POINTS_SHIPSIDE_STRONG 1.5
#define LARVA_POINTS_REGULAR 3.25
#define LARVA_POINTS_STRONG 6

#define SURVIVOR_POINTS_REGULAR 1

#define SMARTIE_POINTS_REGULAR 1
#define SMARTIE_POINTS_MEDIUM 2
#define SMARTIE_POINTS_HIGH 3
#define SYNTH_POINTS_REGULAR 1
#define MECH_POINTS_REGULAR 1
#define ARMORED_VEHICLE_POINTS_REGULAR 1

#define VETERAN_POINTS_REGULAR 1

#define MARINE_SPAWN_ORIGIN "xenos from marine spawn"
#define PSY_DRAIN_ORIGIN "xenos from psy drained bodies"
#define COCOON_ORIGIN "xenos from cocoon that reached its endlife"
#define SILO_ORIGIN "xenos from silo generation"

#define SQUAD_MAX_POSITIONS(total_positions) CEILING(total_positions / length(SSjob.active_squads), 1)
