/datum/keybinding/xeno
	category = CATEGORY_XENO
	weight = WEIGHT_MOB

//
// Universal or multi-caste
//

/datum/keybinding/xeno/headbite
	name = "headbite"
	full_name = "头咬 / 灵能吸取"
	description = "Permanently kill a target. / Gather psy and larva points from a body."
	keybind_signal = COMSIG_XENOABILITY_HEADBITE
	hotkey_keys = list("J")

/datum/keybinding/xeno/regurgitate
	name = "regurgitate"
	full_name = "反刍 / 结茧"
	description = "Vomit whatever you have devoured. / Cocoon the targeted body, which will produce psy and larva points over time."
	keybind_signal = COMSIG_XENOABILITY_REGURGITATE
	hotkey_keys = list("K")

/datum/keybinding/xeno/blessingmenu
	name = "blessings menu"
	full_name = "打开祝福菜单"
	description = "Opens the Queen Mothers Blessings menu, where hive upgrades are bought"
	keybind_signal = COMSIG_XENOABILITY_BLESSINGSMENU
	hotkey_keys = list("P")

/datum/keybinding/xeno/drop_weeds
	name = "drop_weeds"
	full_name = "丢弃杂草"
	description = "Drop weeds to help grow your hive."
	keybind_signal = COMSIG_XENOABILITY_DROP_WEEDS
	hotkey_keys = list("V")

/datum/keybinding/xeno/choose_weeds
	name = "choose_weeds"
	full_name = "选择杂草"
	description = "Choose what weed you will drop."
	keybind_signal = COMSIG_XENOABILITY_CHOOSE_WEEDS
	hotkey_keys = list("ShiftV")

/datum/keybinding/xeno/secrete_resin
	name = "secrete_resin"
	full_name = "分泌树脂"
	description = "Builds whatever you've selected with (choose resin structure) on your tile."
	keybind_signal = COMSIG_XENOABILITY_SECRETE_RESIN
	hotkey_keys = list("R")

/datum/keybinding/xeno/recycle
	name = "Recycle"
	full_name = "回收异形"
	description = "Recycles a fellow dead xenomorph"
	keybind_signal = COMSIG_XENOABILITY_RECYCLE
	hotkey_keys = list("ShiftE")

/datum/keybinding/xeno/place_acid_well
	name = "place_acid_well"
	full_name = "放置酸液井"
	description = "Builds acid well on your tile."
	keybind_signal = COMSIG_XENOABILITY_PLACE_ACID_WELL
	hotkey_keys = list("G")

/datum/keybinding/xeno/emit_frenzy
	name = "emit_frenzy"
	full_name = "释放狂怒信息素"
	description = "Increases damage for yourself and nearby teammates."
	keybind_signal = COMSIG_XENOABILITY_EMIT_FRENZY
	hotkey_keys = list("7")

/datum/keybinding/xeno/emit_warding
	name = "emit_warding"
	full_name = "释放守护信息素"
	description = "Increases armor for yourself and nearby teammates."
	keybind_signal = COMSIG_XENOABILITY_EMIT_WARDING
	hotkey_keys = list("8")

/datum/keybinding/xeno/emit_recovery
	name = "emit_recovery"
	full_name = "释放恢复信息素"
	description = "Increases healing for yourself and nearby teammates."
	keybind_signal = COMSIG_XENOABILITY_EMIT_RECOVERY
	hotkey_keys = list("9")

/datum/keybinding/xeno/corrosive_acid
	name = "corrosive_acid"
	full_name = "腐蚀酸液"
	description = "Cover an object with acid to slowly melt it. Takes a few seconds."
	keybind_signal = COMSIG_XENOABILITY_CORROSIVE_ACID
	hotkey_keys = list("X")

/datum/keybinding/xeno/spray_acid
	name = "spray_acid"
	full_name = "酸液喷洒"
	description = "Sprays some acid"
	keybind_signal = COMSIG_XENOABILITY_SPRAY_ACID
	hotkey_keys = list("F")

/datum/keybinding/xeno/xeno_spit
	name = "xeno_spit"
	full_name = "吐痰"
	description = "Spit neurotoxin or acid at your target up to 7 tiles away."
	keybind_signal = COMSIG_XENOABILITY_XENO_SPIT
	hotkey_keys = list("Z")

/datum/keybinding/xeno/xenohide
	name = "xenohide"
	full_name = "隐藏"
	description = "Causes your sprite to hide behind certain objects and under tables. Not the same as stealth. Does not use plasma."
	keybind_signal = COMSIG_XENOABILITY_HIDE
	hotkey_keys = list("C")

/datum/keybinding/xeno/neurotox_sting
	name = "neurotox_sting"
	full_name = "神经毒素刺击"
	description = "A channeled melee attack that injects the target with neurotoxin over a few seconds, temporarily stunning them."
	keybind_signal = COMSIG_XENOABILITY_NEUROTOX_STING

/datum/keybinding/xeno/ozelomelyn_sting
	name = "ozelomelyn_sting"
	full_name = "奥泽洛梅林刺击"
	description = "A channeled melee attack that injects the target with Ozelomelyn over a few seconds, purging chemicals and dealing minor toxin damage to a moderate cap while inside them."
	keybind_signal = COMSIG_XENOABILITY_OZELOMELYN_STING
	hotkey_keys = list("ShiftE")

/datum/keybinding/xeno/transfer_plasma
	name = "transfer_plasma"
	full_name = "转移等离子体"
	description = "Give some of your plasma to a teammate."
	keybind_signal = COMSIG_XENOABILITY_TRANSFER_PLASMA
	hotkey_keys = list("N")

/datum/keybinding/xeno/toggle_charge
	name = "toggle_charge"
	full_name = "切换冲锋"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_TOGGLE_CHARGE
	hotkey_keys = list("Space")

/datum/keybinding/xeno/toxic_spit
	name = "toxic_spit"
	full_name = "哨兵: 毒性吐痰"
	description = "A type of spit that inflicts the Intoxicated debuff, dealing damage over time."
	keybind_signal = COMSIG_XENOABILITY_TOXIC_SPIT
	hotkey_keys = list("E")

/datum/keybinding/xeno/vent
	name = "vent"
	full_name = "通风管爬行"
	description = "Enter an air vent and crawl through the pipe system."
	keybind_signal = COMSIG_XENOABILITY_VENTCRAWL

/datum/keybinding/xeno/vent/down(client/user)
	. = ..()
	if(!isxeno(user.mob))
		return
	var/mob/living/carbon/xenomorph/xeno = user.mob
	xeno.vent_crawl()

/datum/keybinding/xeno/psychic_whisper
	name = "psychic_whisper"
	full_name = "灵能低语"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_PSYCHIC_WHISPER

/datum/keybinding/xeno/lay_egg
	name = "lay_egg"
	full_name = "产卵"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_LAY_EGG
	hotkey_keys = list("ShiftQ")

/datum/keybinding/xeno/call_of_the_burrowed
	name = "call_of_the_burrowed"
	full_name = "掘地者呼唤"
	description = "Attempts to summon all currently burrowed larva."
	keybind_signal = COMSIG_XENOABILITY_CALL_OF_THE_BURROWED

/datum/keybinding/xeno/rally_hive
	name = "rally_hive"
	full_name = "集结虫巢"
	description = "Rallies the hive to a target location."
	keybind_signal = COMSIG_XENOABILITY_RALLY_HIVE

/datum/keybinding/xeno/rally_minion
	name = "rally_minion"
	full_name = "集结仆从"
	description = "Rallies the minions to a target location, or yourself."
	keybind_signal = COMSIG_XENOABILITY_RALLY_MINION

/datum/keybinding/xeno/command_minions
	name = "command_minion"
	full_name = "指挥仆从"
	description = "Order the minions escorting you to be either agressive or passive."
	keybind_signal = COMSIG_XENOABILITY_MINION_BEHAVIOUR

//
// Single caste, alphabetical order
//
/datum/keybinding/xeno/baneling_explode
	name = "Explode"
	full_name = "爆虫: 爆炸"
	description = "Detonate yourself, spreading your currently selected reagent. Size depends on current stored plasma, more plasma is more reagent."
	keybind_signal = COMSIG_XENOABILITY_BANELING_EXPLODE
	hotkey_keys = list("E")

/datum/keybinding/xeno/long_range_sight
	name = "long_range_sight"
	full_name = "沸腾者: 远程视野"
	description = "Toggles the zoom in."
	keybind_signal = COMSIG_XENOABILITY_LONG_RANGE_SIGHT
	hotkey_keys = list("E")

/datum/keybinding/xeno/toggle_bomb
	name = "toggle_bomb"
	full_name = "沸腾者: 切换轰炸模式"
	description = "Toggles the type of glob ."
	keybind_signal = COMSIG_XENOABILITY_TOGGLE_BOMB

/datum/keybinding/xeno/toggle_bomb_radial
	name = "toggle_bomb_radial"
	full_name = "沸腾者: 选择轰炸类型 (径向)"
	description = "Will use the default toggle if you have two or less available glob types."
	keybind_signal = COMSIG_XENOABILITY_TOGGLE_BOMB_RADIAL
	hotkey_keys = list("X")

/datum/keybinding/xeno/create_bomb
	name = "create_bomb"
	full_name = "沸腾者: 制造轰炸弹药"
	description = "Create new globs to fire."
	keybind_signal = COMSIG_XENOABILITY_CREATE_BOMB
	hotkey_keys = list("F")

/datum/keybinding/xeno/root
	name = "root"
	full_name = "沸腾者: 原地扎根"
	description = "Begin rooting in place."
	keybind_signal = COMSIG_XENOABILITY_ROOT
	hotkey_keys = list("C")

/datum/keybinding/xeno/bombard
	name = "bombard"
	full_name = "沸腾者: 轰炸"
	description = "Fire globules."
	keybind_signal = COMSIG_XENOABILITY_BOMBARD
	hotkey_keys = list("R")

/datum/keybinding/xeno/acid_shroud
	name = "acid_shroud"
	full_name = "沸腾者: 酸液遮蔽"
	description = "Create a smokescreen for a getaway."
	keybind_signal = COMSIG_XENOABILITY_ACID_SHROUD
	hotkey_keys = list("Q")

/datum/keybinding/xeno/acid_shroud_select
	name = "select_acid_shroud"
	full_name = "沸腾者: 选择酸液遮蔽"
	description = "Create a smokescreen for a getaway."
	keybind_signal = COMSIG_XENOABILITY_ACID_SHROUD_SELECT

/datum/keybinding/xeno/acid_shroud_melter
	name = "Melter: Acid Shroud"
	full_name = "熔炼者: 酸液遮蔽"
	description = "Create a smokescreen for a getaway."
	keybind_signal = COMSIG_XENOABILITY_ACID_SHROUD_MELTER

/datum/keybinding/xeno/acid_charge
	name = "acid_charge"
	full_name = "公牛: 酸液冲锋"
	description = "A charge that leaves acid puddles."
	keybind_signal = COMSIG_XENOABILITY_ACIDCHARGE
	hotkey_keys = list("Q")

/datum/keybinding/xeno/headbutt_charge
	name = "headbutt_charge"
	full_name = "公牛: 头槌冲锋"
	description = "A charge that tosses the victim forward."
	keybind_signal = COMSIG_XENOABILITY_BULLHEADBUTT
	hotkey_keys = list("E")

/datum/keybinding/xeno/gore_charge
	name = "gore_charge"
	full_name = "公牛: 穿刺冲锋"
	description = "A charge that gores the victim."
	keybind_signal = COMSIG_XENOABILITY_BULLGORE
	hotkey_keys = list("R")

/datum/keybinding/xeno/tolerate
	name = "tolerate"
	full_name = "公牛: 忍耐"
	description = "Become resistant to slowdown, stagger and stuns"
	keybind_signal = COMSIG_XENOABILITY_TOLERATE
	hotkey_keys = list("F")
/datum/keybinding/xeno/throw_hugger
	name = "throw_hugger"
	full_name = "载体: 投掷抱脸虫"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_THROW_HUGGER
	hotkey_keys = list("E")

/datum/keybinding/xeno/call_younger
	name = "call_younger"
	full_name = "载体: 幼体呼唤"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_CALL_YOUNGER
	hotkey_keys = list("C")

/datum/keybinding/xeno/place_trap
	name = "place_trap"
	full_name = "载体: 放置陷阱"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_PLACE_TRAP
	hotkey_keys = list("G")

/datum/keybinding/xeno/spawn_hugger
	name = "spawn_hugger"
	full_name = "载体: 生成抱脸虫"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_SPAWN_HUGGER
	hotkey_keys = list("F")

/datum/keybinding/xeno/switch_hugger
	name = "switch_hugger"
	full_name = "载体: 切换抱脸虫"
	description = "Cycles the hugger type you will deploy with the Throw Hugger ability."
	keybind_signal = COMSIG_XENOABILITY_SWITCH_HUGGER

/datum/keybinding/xeno/choose_hugger
	name = "choose_hugger"
	full_name = "载体: 选择抱脸虫"
	description = "Prompt a wheel to choose which hugger you will deploy with the Throw Hugger ability."
	keybind_signal = COMSIG_XENOABILITY_CHOOSE_HUGGER
	hotkey_keys = list("X")

/datum/keybinding/xeno/drop_all_hugger
	name = "drop_all_hugger"
	full_name = "载体: 丢弃所有抱脸虫"
	description = "Drop all stored huggers in a fit of panic. Uses all remaining plasma!"
	keybind_signal = COMSIG_XENOABILITY_DROP_ALL_HUGGER
	hotkey_keys = list("Space")

/datum/keybinding/xeno/build_hugger_turret
	name = "build_hugger_turret"
	full_name = "载体: 建造抱脸虫炮塔"
	description = "Build a hugger turret."
	keybind_signal = COMSIG_XENOABILITY_BUILD_HUGGER_TURRET
	hotkey_keys = list("R")

/datum/keybinding/xeno/stomp
	name = "stomp"
	full_name = "碾压者: 践踏"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_STOMP
	hotkey_keys = list("Q")

/datum/keybinding/xeno/cresttoss
	name = "cresttoss_away"
	full_name = "碾压者: 甲冠抛掷"
	description = "Fling an adjacent target away from you."
	description = ""
	keybind_signal = COMSIG_XENOABILITY_CRESTTOSS
	hotkey_keys = list("E")

/datum/keybinding/xeno/cresttoss_behind
	name = "cresttoss_behind"
	full_name = "碾压者: 甲冠后抛"
	description = "Fling an adjacent target behind you."
	keybind_signal = COMSIG_XENOABILITY_CRESTTOSS_BEHIND
	hotkey_keys = list("R")

/datum/keybinding/xeno/advance
	name = "advance"
	full_name = "碾压者: 快速突进"
	description = "Charges up the crushers charge, then unleashes the full bulk of the crusher into a direction."
	keybind_signal = COMSIG_XENOABILITY_ADVANCE
	hotkey_keys = list("F")

/datum/keybinding/xeno/forward_charge
	name = "forward charge"
	full_name = "防御者: 前冲"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_FORWARD_CHARGE
	hotkey_keys = list("R")

/datum/keybinding/xeno/tail_sweep
	name = "tail_sweep"
	full_name = "防御者: 扫尾"
	description = "Hit all adjacent units around you, knocking them away and down."
	keybind_signal = COMSIG_XENOABILITY_TAIL_SWEEP
	hotkey_keys = list("E")

/datum/keybinding/xeno/crest_defense
	name = "crest_defense"
	full_name = "防御者: 甲冠防御"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_CREST_DEFENSE
	hotkey_keys = list("Z")

/datum/keybinding/xeno/fortify
	name = "fortify"
	full_name = "防御者: 筑垒"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_FORTIFY
	hotkey_keys = list("Space")

/datum/keybinding/xeno/headbutt
	name = "headbutt"
	full_name = "钢甲冠: 头槌"
	description = "Headbutts into the designated target."
	keybind_signal = COMSIG_XENOABILITY_STEELCREST_HEADBUTT
	hotkey_keys = list("F")

/datum/keybinding/xeno/soak
	name = "soak"
	full_name = "钢甲冠: 吸收"
	description = "Healing after taking damage"
	keybind_signal = COMSIG_XENOABILITY_STEELCREST_SOAK
	hotkey_keys = list("E")

/datum/keybinding/xeno/regenerate_skin
	name = "regenerate_skin"
	full_name = "防御者: 再生皮肤"
	description = "Regenerate your skin, restoring some health and removing all armor sunder."
	keybind_signal = COMSIG_XENOABILITY_REGENERATE_SKIN
	hotkey_keys = list("F")

/datum/keybinding/xeno/centrifugal_force
	name = "centrifugal_force"
	full_name = "防御者: 离心力"
	description = "Rapidly spin and hit all adjacent humans around you, knocking them away and down."
	keybind_signal = COMSIG_XENOABILITY_CENTRIFUGAL_FORCE
	hotkey_keys = list("X")

/datum/keybinding/xeno/emit_neurogas
	name = "emit_neurogas"
	full_name = "污染者: 释放神经毒气"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_EMIT_NEUROGAS
	hotkey_keys = list("E")

/datum/keybinding/xeno/select_reagent
	name = "select_reagent"
	full_name = "污染者: 选择试剂"
	description = "Cycles through reagents to choose one for Defiler abilities."
	keybind_signal = COMSIG_XENOABILITY_SELECT_REAGENT
	hotkey_keys = list("C")

/datum/keybinding/xeno/radial_select_reagent
	name = "radial_select_reagent"
	full_name = "污染者: 选择试剂 (径向)"
	description = "Chooses a reagent from a radial menu to use for Defiler abilities."
	keybind_signal = COMSIG_XENOABILITY_RADIAL_SELECT_REAGENT
	hotkey_keys = list("X")

/datum/keybinding/xeno/reagent_slash
	name = "reagent_slash"
	full_name = "污染者: 试剂斩击"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_REAGENT_SLASH
	hotkey_keys = list("R")

/datum/keybinding/xeno/defile
	name = "defile"
	full_name = "污染者: 亵渎"
	description = "Purges xeno toxins in exchange for dealing toxin damage and generating toxic sanguinal smoke."
	keybind_signal = COMSIG_XENOABILITY_DEFILE
	hotkey_keys = list("F")

/datum/keybinding/xeno/tentacle
	name = "tentacle"
	full_name = "污染者: 触手"
	description = "Allows the defiler to grab a tallhost or item from range and bring it towards the defiler."
	keybind_signal = COMSIG_XENOABILITY_TENTACLE
	hotkey_keys = list("Q")

/datum/keybinding/xeno/inject_egg_neurogas
	name = "inject_egg_neurogas"
	full_name = "污染者: 注入卵 (神经毒气)"
	description = "Inject an egg with neurogas, killing the little one inside"
	keybind_signal = COMSIG_XENOABILITY_INJECT_EGG_NEUROGAS
	hotkey_keys = list("F")

/datum/keybinding/xeno/acidic_salve
	name = "acidic_salve"
	full_name = "雄蜂: 酸性药膏"
	description = "Heal a xenomorph with this."
	keybind_signal = COMSIG_XENOABILITY_ACIDIC_SALVE
	hotkey_keys = list("F")

/datum/keybinding/xeno/essence_link
	name = "essence_link"
	full_name = "雄蜂: 精华链接"
	description = "Establish a link of plasma with a sister."
	keybind_signal = COMSIG_XENOABILITY_ESSENCE_LINK
	hotkey_keys = list("Q")

/datum/keybinding/xeno/essence_link_remove
	name = "essence_link_remove"
	full_name = "雄蜂: 终止精华链接"
	description = "Forcibly end an Essence Link."
	keybind_signal = COMSIG_XENOABILITY_ESSENCE_LINK_REMOVE
	hotkey_keys = list("E")

/datum/keybinding/xeno/enhancement
	name = "enhancement"
	full_name = "雄蜂: 强化"
	description = "Using an Essence Link, increase a sister's capabilities beyond their limits."
	keybind_signal = COMSIG_XENOABILITY_ENHANCEMENT
	hotkey_keys = list("R")

/datum/keybinding/xeno/devour
	name = "devour"
	full_name = "吞食者: 吞噬"
	description = "Devour your victim to be able to carry it faster."
	keybind_signal = COMSIG_XENOABILITY_DEVOUR
	hotkey_keys = list("X")

/datum/keybinding/xeno/drain
	name = "drain"
	full_name = "吞食者: 吸取"
	description = "Stagger a marine and drain some of their blood. When used on a dead human, you heal gradually and don't gain blood."
	keybind_signal = COMSIG_XENOABILITY_DRAIN
	hotkey_keys = list("E")

/datum/keybinding/xeno/transfusion
	name = "transfusion"
	full_name = "吞食者: 输血"
	description = "Restores some of the health of another xenomorph, or overheals, at the cost of blood."
	keybind_signal = COMSIG_XENOABILITY_TRANSFUSION
	hotkey_keys = list("H")

/datum/keybinding/xeno/rejuvenate
	name = "rejuvenate"
	full_name = "吞食者: 恢复活力"
	description = "Drains blood continuosly, slows you down and reduces damage taken, while restoring some health over time. Cancel by activating again."
	keybind_signal = COMSIG_XENOABILITY_REJUVENATE
	hotkey_keys = list("R")

/datum/keybinding/xeno/oppose
	name = "oppose"
	full_name = "吞食者: 对抗"
	description = "Violently suffuse the nearby ground with stored blood, staggering nearby marines and healing nearby xenomorphs."
	keybind_signal = COMSIG_XENOABILITY_OPPOSE
	hotkey_keys = list("G")

/datum/keybinding/xeno/psychic_link
	name = "psychic link"
	full_name = "吞食者: 心灵链接"
	description = "Link to a xenomorph and take some damage in their place. During this time, you can't move. Use rest action to cancel."
	keybind_signal = COMSIG_XENOABILITY_PSYCHIC_LINK
	hotkey_keys = list("Q")

/datum/keybinding/xeno/carnage
	name = "carnage"
	full_name = "吞食者: 杀戮"
	description = "For a while your attacks drain blood and heal you. During Feast you also heal nearby allies."
	keybind_signal = COMSIG_XENOABILITY_CARNAGE
	hotkey_keys = list("C")

/datum/keybinding/xeno/feast
	name = "feast"
	full_name = "吞食者: 盛宴"
	description = "Enter a state of rejuvenation. During this time you use a small amount of blood and heal. You can cancel this early."
	keybind_signal = COMSIG_XENOABILITY_FEAST
	hotkey_keys = list("F")

/datum/keybinding/xeno/resin_walker
	name = "resin_walker"
	full_name = "巢穴领主: 切换树脂行者"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_RESIN_WALKER
	hotkey_keys = list("E")

/datum/keybinding/xeno/build_tunnel
	name = "build_tunnel"
	full_name = "巢穴领主: 建造隧道"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_BUILD_TUNNEL
	hotkey_keys = list("ShiftQ")

/datum/keybinding/xeno/place_jelly_pod
	name = "place_jelly_pod"
	full_name = "巢穴领主: 放置凝胶荚"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_PLACE_JELLY_POD

/datum/keybinding/xeno/create_jelly
	name = "create_jelly"
	full_name = "巢穴领主: 制造凝胶"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_CREATE_JELLY
	hotkey_keys = list("F")

/datum/keybinding/xeno/healing_infusion
	name = "healing_infusion"
	full_name = "巢穴领主: 治疗注入"
	description = "Imbues a target xeno with healing energy, restoring extra Sunder and Health once every 2 seconds up to 5 times whenever it regenerates normally. 60 second duration."
	keybind_signal = COMSIG_XENOABILITY_HEALING_INFUSION
	hotkey_keys = list("H")

/datum/keybinding/xeno/sow
	name = "sow"
	full_name = "巢穴领主: 播种"
	description = "Plant the seeds of an alien plant."
	keybind_signal = COMSIG_XENOABILITY_DROP_PLANT
	hotkey_keys = list("C")

/datum/keybinding/xeno/sow_select_plant
	name = "choose_plant"
	full_name = "巢穴领主: 选择植物"
	description = "Pick what type of plant to sow."
	keybind_signal = COMSIG_XENOABILITY_CHOOSE_PLANT

/datum/keybinding/xeno/change_form
	name = "change_form"
	full_name = "巢群意识: 改变形态"
	description = "Change form to/from incorporeal."
	keybind_signal = COMSIG_XENOMORPH_HIVEMIND_CHANGE_FORM
	hotkey_keys = list("F")

/datum/keybinding/xeno/teleport_minimap
	name = "teleport_minimap"
	full_name = "巢群意识: 打开传送小地图"
	description = "Opens up the minimap which, when you click somewhere, tries to teleport you to the selected location"
	keybind_signal = COMISG_XENOMORPH_HIVEMIND_TELEPORT
	hotkey_keys = list("C")

/datum/keybinding/xeno/hunter_pounce
	name = "hunter_pounce"
	full_name = "猎手: 扑击"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_HUNTER_POUNCE
	hotkey_keys = list("E")

/datum/keybinding/xeno/toggle_stealth
	name = "toggle_stealth"
	full_name = "猎手: 切换潜行"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_TOGGLE_STEALTH
	hotkey_keys = list("Q")

/datum/keybinding/xeno/hunter_blink
	name = "hunter_blink"
	full_name = "猎手: 猎手闪现"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_HUNTER_BLINK
	hotkey_keys = list("F")

/datum/keybinding/xeno/mirage
	name = "mirage"
	full_name = "猎手: 幻影"
	description = "Creates multiple mirror images of the xeno."
	keybind_signal = COMSIG_XENOABILITY_MIRAGE
	hotkey_keys = list("R")

/datum/keybinding/xeno/silence
	name = "impair senses"
	full_name = "猎手: 沉默"
	description = "Impairs the ability of hostile living creatures we can see in a 5x5 area. Targets will be unable to speak and hear for 10 seconds."
	keybind_signal = COMSIG_XENOABILITY_SILENCE
	hotkey_keys = list("X")

/datum/keybinding/xeno/mark
	name = "mark"
	full_name = "猎手: 标记"
	description = "Mark that lonely marine so that you can track with Psychic Trace."
	keybind_signal = COMSIG_XENOABILITY_HUNTER_MARK
	hotkey_keys = list("C")

/datum/keybinding/xeno/psychic_trace
	name = "psychic_trace"
	full_name = "猎手: 心灵追踪"
	description = "Locate direction of marine that you've marked."
	keybind_signal = COMSIG_XENOABILITY_PSYCHIC_TRACE
	hotkey_keys = list("G")

/datum/keybinding/xeno/nightfall
	hotkey_keys = list("F")
	name = "nightfall"
	full_name = "国王: 夜幕降临"
	description = "Shut down all nearby electric lights for 10 seconds"
	keybind_signal = COMSIG_XENOABILITY_NIGHTFALL

/datum/keybinding/xeno/petrify
	hotkey_keys = list("E")
	name = "petrify"
	full_name = "King: 石化"
	description = "Petrifies all humans within view. While petrified humans can neither be damaged or take any actions."
	keybind_signal = COMSIG_XENOABILITY_PETRIFY

/datum/keybinding/xeno/off_guard
	hotkey_keys = list("Q")
	name = "off_guard"
	full_name = "King: 破防"
	description = "Muddles the mind of an enemy, increasing their scatter for a while."
	keybind_signal = COMSIG_XENOABILITY_OFFGUARD

/datum/keybinding/xeno/shattering_roar
	hotkey_keys = list("R")
	name = "shattering_roar"
	full_name = "King: 碎裂咆哮"
	description = "Unleash a mighty psychic roar, knocking down any foes in your path and weakening them."
	keybind_signal = COMSIG_XENOABILITY_SHATTERING_ROAR

/datum/keybinding/xeno/zero_form_beam
	hotkey_keys = list("R")
	name = "zero_form_beam"
	full_name = "King: 零式光束"
	description = "After a windup, concentrates the hives energy into a forward-facing beam that pierces everything, but only hurts living beings."
	keybind_signal = COMSIG_XENOABILITY_ZEROFORMBEAM

/datum/keybinding/xeno/psychic_summon
	name = "psychic_summon"
	full_name = "King: 灵能召唤"
	description = "Summons all xenos in a hive to the caller's location, uses all plasma to activate."
	keybind_signal = COMSIG_XENOABILITY_HIVE_SUMMON

/datum/keybinding/xeno/dash
	name = "dash"
	full_name = "Praetorian: 冲刺"
	description = "Quickly dash forward."
	keybind_signal = COMSIG_XENOABILITY_DASH
	hotkey_keys = list("E")

/datum/keybinding/xeno/acid_dash
	name = "acid_dash"
	full_name = "Praetorian: 酸液冲刺"
	description = "Quickly dash, leaving acid in your path and knocking down the first marine hit. Has reset potential."
	keybind_signal = COMSIG_XENOABILITY_ACID_DASH
	hotkey_keys = list("E")

/datum/keybinding/xeno/acid_dash_melter
	name = "Melter: Acid Dash"
	full_name = "Melter: 酸液冲刺"
	description = "Quickly dash, leaving acid in your path and knocking down the first marine hit. Has reset potential."
	keybind_signal = COMSIG_XENOABILITY_ACID_DASH_MELTER

/datum/keybinding/xeno/acidic_missile
	name = "Melter: Acidic Missile"
	full_name = "Melter: 酸液导弹"
	description = "Begin building up acid. If you're already building up acid, launch yourself at a target and splash acid all around you."
	keybind_signal = COMSIG_XENOABILITY_ACIDIC_MISSILE

/datum/keybinding/xeno/dodge
	name = "Dodge"
	full_name = "Dancer: 闪避"
	description = "Flood your body with adrenaline, gaining a speed boost upon activation and the ability to pass through mobs. Enemies automatically receive bump attacks when passed."
	keybind_signal = COMSIG_XENOABILITY_DODGE
	hotkey_keys = list("Q")

/datum/keybinding/xeno/impale
	name = "Impale"
	full_name = "Dancer: 穿刺"
	description = "Skewer an object next to you with your tail. The more debuffs on a living target, the greater the damage done. Penetrates the armor of marked targets."
	keybind_signal = COMSIG_XENOABILITY_IMPALE
	hotkey_keys = list("Z")

/datum/keybinding/xeno/tail_trip
	name = "Tail Trip"
	full_name = "Dancer: 尾扫绊倒"
	description = "Twirl your tail around low to the ground, knocking over and disorienting any adjacent marines. Marked enemies receive stronger debuffs and are briefly stunned."
	keybind_signal = COMSIG_XENOABILITY_TAIL_TRIP
	hotkey_keys = list("R")

/datum/keybinding/xeno/tail_hook
	name = "Tail Hook"
	full_name = "Dancer: 尾钩"
	description = "Swing your tail high, sending the hooked edge gouging into any targets within 2 tiles. Hooked marines have their movement slowed and are dragged, spinning, towards you. Marked marines are slowed for longer and briefly knocked over."
	keybind_signal = COMSIG_XENOABILITY_TAILHOOK
	hotkey_keys = list("F")

/datum/keybinding/xeno/baton_pass
	name = "Baton Pass"
	full_name = "Dancer: 接力棒"
	description = "Inject another xenomorph with your built-up adrenaline, increasing their movement speed considerably for 6 seconds. Puts dodge on cooldown when used. Less effect on quick xenos."
	keybind_signal = COMSIG_XENOABILITY_BATONPASS
	hotkey_keys = list("C")

/datum/keybinding/xeno/abduct
	name = "Abduct"
	full_name = "Oppressor: 绑架"
	description = "After a delay, grab marines from a 7 tiles away. Canceling early has consequences."
	keybind_signal = COMSIG_XENOABILITY_ABDUCT
	hotkey_keys = list("Q")

/datum/keybinding/xeno/dislocate
	name = "Dislocate"
	full_name = "Oppressor: 脱臼"
	description = "Punch a marine and knock them back by two tiles."
	keybind_signal = COMSIG_XENOABILITY_DISLOCATE
	hotkey_keys = list("F")

/datum/keybinding/xeno/item_throw
	name = "Item Throw"
	full_name = "Oppressor: 投掷物品"
	description = "Pick up an item and throw it. Damage and range varies based on item's size."
	keybind_signal = COMSIG_XENOABILITY_ITEM_THROW
	hotkey_keys = list("Z")

/datum/keybinding/xeno/tail_lash
	name = "Tail Lash"
	full_name = "Oppressor: 尾鞭"
	description = "Knock back marines in a 2x3 radius where you're facing by two tiles."
	keybind_signal = COMSIG_XENOABILITY_TAIL_LASH
	hotkey_keys = list("C")

/datum/keybinding/xeno/tail_lash_select
	name = "Tail Lash (Select)"
	full_name = "Oppressor: 选择尾鞭"
	description = "Knock back marines in a 2x3 radius where you're facing by two tiles."
	keybind_signal = COMSIG_XENOABILITY_TAIL_LASH_SELECT

/datum/keybinding/xeno/advance_oppressor
	name = "Advance (Oppressor)"
	full_name = "Oppressor: 推进"
	description = "Launch yourself with tremendous speed toward a location. Hitting a marine will cause them to be launched incredibly far."
	keybind_signal = COMSIG_XENOABILITY_ADVANCE_OPPRESSOR
	hotkey_keys = list("E")

/datum/keybinding/xeno/screech
	name = "screech"
	full_name = "Queen: 尖啸"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_SCREECH
	hotkey_keys = list("E")

/datum/keybinding/xeno/toggle_queen_zoom
	name = "toggle_queen_zoom"
	full_name = "Queen: 切换缩放"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_TOGGLE_QUEEN_ZOOM
	hotkey_keys = list("C")

/datum/keybinding/xeno/xeno_leaders
	name = "xeno_leaders"
	full_name = "Queen: 设置首领"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_XENO_LEADERS

/datum/keybinding/xeno/queen_heal
	name = "queen_heal"
	full_name = "Queen: 给予治疗"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_QUEEN_HEAL
	hotkey_keys = list("H")

/datum/keybinding/xeno/queen_give_plasma
	name = "queen_give_plasma"
	full_name = "Queen: 给予血浆"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_QUEEN_GIVE_PLASMA
	hotkey_keys = list("N")

/datum/keybinding/xeno/queen_hive_message
	name = "queen_hive_message"
	full_name = "Queen: 巢穴讯息"
	description = "Instantly displays a bolded announcement to all xenos in the hive."
	keybind_signal = COMSIG_XENOABILITY_QUEEN_HIVE_MESSAGE

/datum/keybinding/xeno/deevolve
	name = "deevolve"
	full_name = "Queen: 退化异形"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_DEEVOLVE

/datum/keybinding/xeno/ravager_charge
	name = "ravager_charge"
	full_name = "Ravager: 剔骨冲锋"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_RAVAGER_CHARGE
	hotkey_keys = list("E")

/datum/keybinding/xeno/ravager_endure
	name = "ravager_endure"
	full_name = "Ravager: 忍耐"
	description = "For the next few moments you will not go into crit and become resistant to explosives and immune to stagger and slowdown, but you still die if you take damage exceeding your crit health."
	keybind_signal = COMSIG_XENOABILITY_ENDURE
	hotkey_keys = list("F")

/datum/keybinding/xeno/ravager_vampirism
	name = "togglevampirism"
	full_name = "Ravager: 切换吸血"
	description = "While active, will increase the ravagers healing for a while for every time it hits a new enemy. Effects stack."
	keybind_signal = COMSIG_XENOABILITY_VAMPIRISM

/datum/keybinding/xeno/ravager_immortality
	name = "ravager_immortality"
	full_name = "Ravager: 不朽"
	description = "For the next few moments we will be immune to damage."
	keybind_signal = COMSIG_XENOABILITY_IMMORTALITY
	hotkey_keys = list("X")

/datum/keybinding/xeno/ravage
	name = "ravage"
	full_name = "Ravager: 蹂躏"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_RAVAGE

/datum/keybinding/xeno/ravage_select
	name = "ravage select"
	full_name = "Ravager: 选择蹂躏"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_RAVAGE_SELECT
	hotkey_keys = list("R")

/datum/keybinding/xeno/pounce
	name = "pounce"
	full_name = "Runner: 扑击"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_RUNNER_POUNCE
	hotkey_keys = list("E")

/datum/keybinding/xeno/toggle_savage
	name = "toggle_savage"
	full_name = "Runner: 切换凶暴"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_TOGGLE_SAVAGE

/datum/keybinding/xeno/evasion
	name = "evasion"
	full_name = "Runner: 闪避"
	description = "Take evasive action, forcing non-friendly projectiles that would hit you to miss so long as you keep moving."
	keybind_signal = COMSIG_XENOABILITY_EVASION
	hotkey_keys = list("Z")

/datum/keybinding/xeno/auto_evasion
	name = "auto_evasion"
	full_name = "Runner: 切换自动闪避"
	description = "Toggles Auto Evasion on or off. While active, Auto Evasion will automatically use Evasion when you gain its cooldown reset bonus."
	keybind_signal = COMSIG_XENOABILITY_AUTO_EVASION

/datum/keybinding/xeno/snatch
	name = "snatch"
	full_name = "Runner: 抢夺"
	description = "Take an item equipped by your target in your mouth, and carry it away."
	keybind_signal = COMSIG_XENOABILITY_SNATCH
	hotkey_keys = list("Q")

/datum/keybinding/xeno/toxic_slash
	name = "toxic_slash"
	full_name = "Sentinel: 剧毒斩击"
	description = "Imbue your claws with toxins, inflicting the Intoxicated debuff on hit and dealing damage over time."
	keybind_signal = COMSIG_XENOABILITY_TOXIC_SLASH
	hotkey_keys = list("R")

/datum/keybinding/xeno/drain_sting
	name = "drain_sting"
	full_name = "Sentinel: 吸取刺击"
	description = "Sting a victim, draining any Intoxicated debuffs they may have, restoring you and dealing damage."
	keybind_signal = COMSIG_XENOABILITY_DRAIN_STING
	hotkey_keys = list("F")

/datum/keybinding/xeno/toxicgrenade
	name = "toxic_grenade"
	full_name = "Sentinel: 剧毒手雷"
	description = "Throws a ball of resin containing a toxin that inflicts the Intoxicated debuff, dealing damage over time."
	keybind_signal = COMSIG_XENOABILITY_TOXIC_GRENADE
	hotkey_keys = list("Q")

/datum/keybinding/xeno/psychic_fling
	name = "psychic_fling"
	full_name = "Shrike: 灵能投掷"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_PSYCHIC_FLING
	hotkey_keys = list("E")

/datum/keybinding/xeno/unrelenting_force
	name = "unrelenting_force"
	full_name = "Shrike: 无情的原力"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_UNRELENTING_FORCE
	hotkey_keys = list("Q")

/datum/keybinding/xeno/unrelenting_force_select
	name = "unrelenting_force_select"
	full_name = "Shrike: 选择无情的原力"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_UNRELENTING_FORCE_SELECT

/datum/keybinding/xeno/psychic_heal
	name = "psychic_cure"
	full_name = "Shrike: 灵能治愈"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_PSYCHIC_CURE
	hotkey_keys = list("F")

/* RUTGMC EDIT DELETION, PSYCHIC_GRAB
/datum/keybinding/xeno/psychic_storm
	name = "gravnade"
	full_name = "Shrike: Psychic Vortex"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_PSYCHIC_VORTEX
	hotkey_keys = list("X")
*/

/datum/keybinding/xeno/scatter_spit
	name = "scatter_spit"
	full_name = "Spitter: 散射唾液"
	description = "Fires a scattershot of 6 acid globules which create acid puddles on impact or at the end of their range."
	keybind_signal = COMSIG_XENOABILITY_SCATTER_SPIT
	hotkey_keys = list("V")

/datum/keybinding/xeno/toss_grenade
	name = "toss_grenade"
	full_name = "GLobadier: 投掷手雷"
	description = "Toss a grenade at your target."
	keybind_signal = COMSIG_XENOABILITY_TOSS_GRENADE
	hotkey_keys = list("R")

/datum/keybinding/xeno/pick_grenade
	name = "pick_grenade"
	full_name = "Globadier: 拾取手雷"
	description = "Pick which grenade to use with Toss Grenade."
	keybind_signal = COMSIG_XENOABILITY_PICK_GRENADE
	hotkey_keys = list("F")

/datum/keybinding/xeno/acid_mine
	name = "acid_mine"
	full_name = "Globadier: 放置地雷"
	description = "Place a Mine at your location. Its effects depend on your selected grenade."
	keybind_signal = COMSIG_XENOABILITY_ACID_MINE
	hotkey_keys = list("G")

/datum/keybinding/xeno/gas_mine
	name = "gas_mine"
	full_name = "Globadier: 毒气地雷"
	description = "Place a Gas Mine at your location."
	keybind_signal = COMSIG_XENOABILITY_GAS_MINE
	hotkey_keys = list("H")

/datum/keybinding/xeno/acid_rocket
	name = "acid_rocket"
	full_name = "GLobadier: 酸液火箭"
	description = "Fire a acid rocket at your target, after a short charge up."
	keybind_signal = COMSIG_XENOABILITY_ACID_ROCKET
	hotkey_keys = list("Y")

/datum/keybinding/xeno/slime_grenade
	name = "slime_grenade"
	full_name = "Spitter: 黏液手雷"
	description = "Throws a lump of compressed acid to stick to a target, which will leave a trail of acid behind them."
	keybind_signal = COMSIG_XENOABILITY_SLIME_GRENADE
	hotkey_keys = list("Q")

/datum/keybinding/xeno/psychic_shield
	name = "Psychic Shield"
	full_name = "Warlock: 灵能护盾"
	description = "Channel a psychic shield at your current location that can reflect most projectiles. Activate again while the shield is active to detonate the shield forcibly, producing knockback."
	keybind_signal = COMSIG_XENOABILITY_PSYCHIC_SHIELD
	hotkey_keys = list("E")

/datum/keybinding/xeno/trigger_psychic_shield
	name = "Trigger Psychic Shield"
	full_name = "Warlock: 触发灵能护盾"
	description = "Triggers the Psychic Shield ability without selecting it."
	keybind_signal = COMSIG_XENOABILITY_TRIGGER_PSYCHIC_SHIELD

/datum/keybinding/xeno/psychic_blast
	name = "Psychic Blast"
	full_name = "Warlock: 灵能冲击"
	description = "Fire a lightly-damaging AOE psychic beam which knocks back enemies after a short charge-up."
	keybind_signal = COMSIG_XENOABILITY_PSYCHIC_BLAST
	hotkey_keys = list("R")

/datum/keybinding/xeno/toggle_warlock_zoom
	name="Warlock Zoom"
	full_name = "Warlock: 切换缩放"
	description = "Zoom out for a larger view around wherever you are looking"
	keybind_signal = COMSIG_XENOABILITY_TOGGLE_WARLOCK_ZOOM
	hotkey_keys = list("F")

/datum/keybinding/xeno/psychic_crush
	name = "Psychic Crush"
	full_name = "Warlock: 灵能碾压"
	description = "Channel an expanding AOE crush effect, activating it again pre-maturely crushes enemies over an area."
	keybind_signal = COMSIG_XENOABILITY_PSYCHIC_CRUSH
	hotkey_keys = list("Q")

/datum/keybinding/xeno/toggle_agility
	name = "toggle_agility"
	full_name = "Warrior: 切换敏捷"
	description = "Toggles Agility mode. While in Agility mode, you move much more quickly but can't use abilities and your armor is greatly reduced."
	keybind_signal = COMSIG_XENOABILITY_TOGGLE_AGILITY
	hotkey_keys = list("Shift")

/datum/keybinding/xeno/lunge
	name = "lunge"
	full_name = "Warrior: 突刺"
	description = "Charges towards a target, then neckgrabs them if they're adjacent to you. Stuns on upon grabbing for 1 second."
	keybind_signal = COMSIG_XENOABILITY_LUNGE
	hotkey_keys = list("E")

/datum/keybinding/xeno/fling
	name = "fling"
	full_name = "Warrior: 投掷"
	description = "Quickly flings a target 4 tiles away and inflicts a short stun. Shared cooldown with Grapple Toss."
	keybind_signal = COMSIG_XENOABILITY_FLING
	hotkey_keys = list("V")

/datum/keybinding/xeno/grapple_toss
	name = "grapple_toss"
	full_name = "Warrior: 擒抱投掷"
	description = "Throw a target you're grabbing up to 5 tiles away. Inflicts a short stun and stagger and slow stacks. Shared cooldown with Fling."
	keybind_signal = COMSIG_XENOABILITY_GRAPPLE_TOSS
	hotkey_keys = list("F")

/datum/keybinding/xeno/punch
	name = "punch"
	full_name = "Warrior: 拳击"
	description = "Punch a hostile creature, a structure or piece of machinery. Damage and status durations are doubled vs creatures you are grabbing. Damage is quadrupled vs structures and machinery."
	keybind_signal = COMSIG_XENOABILITY_PUNCH
	hotkey_keys = list("Z")

/datum/keybinding/xeno/jab
	name = "jab"
	full_name = "Warrior: 刺拳"
	description = "Precisely strike your target from further away. Resets punch cooldown."
	keybind_signal = COMSIG_XENOABILITY_JAB
	hotkey_keys = list("C")

/datum/keybinding/xeno/encased_plates
	name = "encased_plates"
	full_name = "Bulwark: 覆甲"
	description = "Raise or lower your armored plates."
	keybind_signal = COMSIG_XENOABILITY_ENCASED_PLATES
	hotkey_keys = list("C")

/datum/keybinding/xeno/plate_bash
	name = "plate_bash"
	full_name = "Bulwark: 甲壳猛击"
	description = "Dash at a target and shove it. While encased: launches adjacent targets away with knockdown."
	keybind_signal = COMSIG_XENOABILITY_PLATE_BASH
	hotkey_keys = list("V")

/datum/keybinding/xeno/reflective_shield
	name = "reflective_shield"
	full_name = "Bulwark: 反射护盾"
	description = "Lock your facing and reflect frontal bullets back at the firer."
	keybind_signal = COMSIG_XENOABILITY_REFLECTIVE_SHIELD
	hotkey_keys = list("B")

/datum/keybinding/xeno/shield_shatter
	name = "shield_shatter"
	full_name = "Bulwark: 护盾碎裂"
	description = "Shatter your reflective shield outward, throwing nearby enemies back. Primordial only."
	keybind_signal = COMSIG_XENOABILITY_SHIELD_SHATTER
	hotkey_keys = list("X")

/datum/keybinding/xeno/flurry
	name = "flurry"
	full_name = "Warrior: 连击"
	description = "Strike at your target with blinding speed."
	keybind_signal = COMSIG_XENOABILITY_FLURRY
	hotkey_keys = list("Q")

/datum/keybinding/xeno/earth_riser
	name = "Earth Riser"
	full_name = "Behemoth: 大地隆起"
	description = "Create or interact with an Earth Pillar. If holding one, you will instead throw it."
	keybind_signal = COMSIG_XENOABILITY_EARTH_RISER
	hotkey_keys = list("R")

/datum/keybinding/xeno/earth_riser_alternate
	name = "Destroy Earth Pillar"
	full_name = "Behemoth: 摧毁土柱"
	description = "Destroy active Earth Pillars, from oldest to newest."
	keybind_signal = COMSIG_XENOABILITY_EARTH_RISER_ALTERNATE
	hotkey_keys = list("ShiftC")

/datum/keybinding/xeno/behemoth_seize
	name = "Targeted Seize"
	full_name = "Behemoth: 擒抓 (指定)"
	description = "Dash towards a target Earth Pillar and grab it."
	keybind_signal = COMSIG_XENOABILITY_BEHEMOTH_SEIZE

/datum/keybinding/xeno/behemoth_seize_alternate
	name = "Seize Nearest"
	full_name = "Behemoth: 擒抓 (最近)"
	description = "Dash towards the nearest Earth Pillar and grab it."
	keybind_signal = COMSIG_XENOABILITY_BEHEMOTH_SEIZE_ALTERNATE
	hotkey_keys = list("E")

/datum/keybinding/xeno/landslide
	name = "Landslide"
	full_name = "Behemoth: 山崩"
	description = "Charge forward in the nearest cardinal direction, affecting eligible targets in a wide path."
	keybind_signal = COMSIG_XENOABILITY_LANDSLIDE
	hotkey_keys = list("C")

/datum/keybinding/xeno/geocrush
	name = "Geocrush"
	full_name = "Behemoth: 地裂"
	description = "Recover all damage recently received, and gain a brief moment of invulnerability, in exchange for a stacking debuff."
	keybind_signal = COMSIG_XENOABILITY_GEOCRUSH
	hotkey_keys = list("F")

/datum/keybinding/xeno/primal_wrath
	name = "Primal Wrath"
	full_name = "Behemoth: 原始之怒"
	description = "Unleash your wrath. Enhances your abilities, changing their functionality and allowing them to apply a damage over time debuff."
	keybind_signal = COMSIG_XENOABILITY_PRIMAL_WRATH
	hotkey_keys = list("F")

/datum/keybinding/xeno/tearing_tail
	name = "Tearing Tail"
	full_name = "黑豹: 撕尾"
	description = "Hit all adjacent units around you, poisoning them toxin for their mind."
	keybind_signal = COMSIG_XENOABILITY_TEARING_TAIL
	hotkey_keys = list("R")

/datum/keybinding/xeno/panther_pounce
	name = "panther_pounce"
	full_name = "黑豹: 扑击"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_PANTHER_POUNCE
	hotkey_keys = list("E")

/datum/keybinding/xeno/adrenaline_jump
	name = "Adrenaline Jump"
	full_name = "黑豹: 肾上腺素跳跃"
	description = "Jump from some distance to target, knocking them down."
	keybind_signal = COMSIG_XENOABILITY_ADRENALINE_JUMP
	hotkey_keys = list("F")

/datum/keybinding/xeno/evasive_maneuvers
	name = "Toggle evasive maneuvers"
	full_name = "黑豹: 闪避机动"
	description = "Toggle evasive action, forcing non-friendly projectiles that would hit you to miss."
	keybind_signal = COMSIG_XENOABILITY_EVASIVE_MANEUVERS
	hotkey_keys = list("Q")

/datum/keybinding/xeno/adrenaline_rush
	name = "Adrenaline rush"
	full_name = "黑豹: 肾上腺素激增"
	description = "Move faster."
	keybind_signal = COMSIG_XENOABILITY_ADRENALINE_RUSH
	hotkey_keys = list("V")

/datum/keybinding/xeno/panther_select_reagent
	name = "Select Reagent"
	full_name = "黑豹: 选择试剂"
	description = "Cycles through reagents to choose one for Defiler abilities."
	keybind_signal = COMSIG_XENOABILITY_PANTHER_SELECT_REAGENT
	hotkey_keys = list("V")

/datum/keybinding/xeno/psychic_grab
	name = "psychic_grab"
	full_name = "伯劳: 精神抓取"
	description = ""
	keybind_signal = COMSIG_XENOABILITY_PSYCHIC_GRAB
	hotkey_keys = list("X")

/datum/keybinding/xeno/plasma_screech
	name = "plasma_screech"
	full_name = "女王: 等离子尖啸"
	description = "Screech that increases plasma regeneration for nearby xenos."
	keybind_signal = COMSIG_XENOABILITY_PLASMA_SCREECH

/datum/keybinding/xeno/frenzy_screech
	name = "frenzy_screech"
	full_name = "女王: 狂乱尖啸"
	description = "Screech that increases damage for nearby xenos."
	keybind_signal = COMSIG_XENOABILITY_FRENZY_SCREECH

/datum/keybinding/xeno/phantom
	name = "phantom"
	full_name = "奇美拉: 幻影"
	description = "Create a physical clone and hide in shadows."
	keybind_signal = COMSIG_XENOABILITY_CHIMERA_PHANTOM
	hotkey_keys = list("R")

/datum/keybinding/xeno/abduction
	name = "abduction"
	full_name = "奇美拉: 绑架"
	description = "Abduct the prey."
	keybind_signal = COMSIG_XENOABILITY_CHIMERA_ABDUCTION
	hotkey_keys = list("Q")

/datum/keybinding/xeno/chimera_blink
	name = "chimera_blink"
	full_name = "奇美拉: 闪现"
	description = "Teleport to a space a short distance away within line of sight. Can teleport mobs you're dragging with you at the cost of higher cooldown."
	keybind_signal = COMSIG_XENOABILITY_CHIMERA_BLINK
	hotkey_keys = list("E")

/datum/keybinding/xeno/warp_blast
	name = "warp_blast"
	full_name = "奇美拉: 传送冲击"
	description = "Create a pure force explosion that damages and knockbacks targets around."
	keybind_signal = COMSIG_XENOABILITY_CHIMERA_WARP_BLAST
	hotkey_keys = list("F")

/datum/keybinding/xeno/bodyswap
	name = "bodyswap"
	full_name = "奇美拉: 换体"
	description = "Swap places with another alien."
	keybind_signal = COMSIG_XENOABILITY_CHIMERA_BODYSWAP
	hotkey_keys = list("X")

/datum/keybinding/xeno/chimera_stealth
	name = "stealth"
	full_name = "奇美拉: 切换潜行"
	description = "Activates invisibility."
	keybind_signal = COMSIG_XENOABILITY_CHIMERA_STEALTH
	hotkey_keys = list("C")

/datum/keybinding/xeno/crippling_strike
	name = "crippling_strike"
	full_name = "奇美拉: 致残打击"
	description = "Toggle on to enable crippling attacks"
	keybind_signal = COMSIG_XENOABILITY_CHIMERA_CRIPPLING_STRIKE

/datum/keybinding/xeno/hugger_pounce
	name = "hugger_pounce"
	full_name = "抱脸虫: 扑击"
	description = "Leap at your target and knock them down, if you jump close you will hug the target."
	keybind_signal = COMSING_XENOABILITY_HUGGER_POUNCE
	hotkey_keys = list("E")

/datum/keybinding/xeno/roar
	name = "Roar"
	full_name = "掠食异形: 咆哮"
	description = "Give bonuses to teamates and deactivate hitech utilities."
	keybind_signal = COMSIG_XENOABILITY_ROAR

/datum/keybinding/xeno/smash
	name = "Smash"
	full_name = "掠食异形: 猛击"
	description = "Stomp and stun your enemies."
	keybind_signal = COMSIG_XENOABILITY_SMASH

/datum/keybinding/xeno/devastate
	name = "Devastate"
	full_name = "掠食异形: 毁灭"
	description = "Rip enemy gut."
	keybind_signal = COMSIG_XENOABILITY_DEVASTATE

/datum/keybinding/xeno/short_spray_acid
	name = "short_spray_acid"
	full_name = "禁卫: 短程酸液喷射"
	description = "Sprays some acid"
	keybind_signal = COMSIG_XENOABILITY_SHORT_SPRAY_ACID
	hotkey_keys = list("C")

/datum/keybinding/xeno/burrow
	name = "burrow"
	full_name = "掘地"
	description = "Dig to the ground, making you invisible."
	keybind_signal = COMSIG_XENOABILITY_BURROW
	hotkey_keys = list("C")

/datum/keybinding/xeno/leash_ball
	name = "Leash Ball"
	full_name = "寡妇: 束缚球"
	description = "Spit a huge web ball of web that snares groups of targets for a brief while."
	keybind_signal = COMSIG_XENOABILITY_LEASH_BALL
	hotkey_keys = list("E")

/datum/keybinding/xeno/create_spiderling
	name = "Birth Spiderling"
	full_name = "寡妇: 产卵"
	description = "Give birth to a spiderling after a short charge-up."
	keybind_signal = COMSIG_XENOABILITY_CREATE_SPIDERLING
	hotkey_keys = list("F")

/datum/keybinding/xeno/attach_spiderlings
	name = "Attach Spiderlings"
	full_name = "寡妇: 附着幼蛛"
	description = "Scoop up and carry your spawn with you."
	keybind_signal = COMSIG_XENOABILITY_ATTACH_SPIDERLINGS
	hotkey_keys = list("X")

/datum/keybinding/xeno/web_spit
	name = "Web Spit"
	full_name = "寡妇: 吐网"
	description = "Stun and blind the target with a web projectile"
	keybind_signal = COMSIG_XENOABILITY_WEB_SPIT
	hotkey_keys = list("R")

/datum/keybinding/xeno/widow_unleash
	name = "Unleash Spiderlings"
	full_name = "寡妇: 释放幼蛛"
	description = "Send out your spawn to attack nearby humans"
	keybind_signal = COMSIG_XENOABILITY_UNLEASH_SPIDERLINGS
	hotkey_keys = list("O")

/datum/keybinding/xeno/widow_recall
	name = "Recall Spiderlings"
	full_name = "寡妇: 召回幼蛛"
	description = "Recall your siderlings to follow you once more"
	keybind_signal = COMSIG_XENOABILITY_RECALL_SPIDERLINGS
	hotkey_keys = list("P")

/datum/keybinding/xeno/flay
	name = "Flay"
	full_name = "傀儡师: 剥皮"
	description = "Takes a chunk of flesh from the victim marine through a quick swiping motion, adding biomass to your collection."
	keybind_signal = COMSIG_XENOABILITY_FLAY

/datum/keybinding/xeno/pincushion
	name = "Pincushion"
	full_name = "傀儡师: 针刺"
	description = "Launch a spine from your tail."
	keybind_signal = COMSIG_XENOABILITY_PINCUSHION

/datum/keybinding/xeno/dread
	name = "Dreadful Presence"
	full_name = "傀儡师: 恐怖威压"
	description = "Emit a menacing presence, striking fear into nearby organics."
	keybind_signal = COMSIG_XENOABILITY_DREADFULPRESENCE

/datum/keybinding/xeno/refurbish_husk
	name = "Refurbish Husk"
	full_name = "傀儡师: 修复躯壳"
	description = "Harvest an unrevivable body to create a meat puppet."
	keybind_signal = COMSIG_XENOABILITY_REFURBISHHUSK

/datum/keybinding/xeno/stitch_puppet
	name = "Stitch Puppet"
	full_name = "傀儡师: 缝合傀儡"
	description = "Create a flesh homunculus to do your bidding."
	keybind_signal = COMSIG_XENOABILITY_PUPPET

/datum/keybinding/xeno/organic_bomb
	name = "Organic Bomb"
	full_name = "傀儡师: 有机炸弹"
	description = "Order one of your puppets to detonate."
	keybind_signal = COMSIG_XENOABILITY_ORGANICBOMB

/datum/keybinding/xeno/tendrils
	name = "Tendrils"
	full_name = "傀儡师: 触须"
	description = "Burrow freshly created tendrils to tangle organics."
	keybind_signal = COMSIG_XENOABILITY_TENDRILS

/datum/keybinding/xeno/unleash_puppet
	name = "Unleash Puppets"
	full_name = "傀儡师: 释放傀儡"
	description = "Unleash puppets to attack nearby humans."
	keybind_signal = COMSIG_XENOABILITY_UNLEASHPUPPETS

/datum/keybinding/xeno/recall_puppet
	name = "Recall Puppets"
	full_name = "傀儡师: 召回傀儡"
	description = "Recall your puppets, making them follow you once more."
	keybind_signal = COMSIG_XENOABILITY_RECALLPUPPETS

/datum/keybinding/xeno/bestow_blessing
	name = "Bestow Blessings"
	full_name = "傀儡师: 赐福"
	description = "Give blessings to your puppets."
	keybind_signal = COMSIG_XENOABILITY_BESTOWBLESSINGS

/datum/keybinding/xeno/firecharge
	name = "Fire Charge"
	full_name = "焚化者: 火焰冲锋"
	description = "Charge forward and attack a marine."
	keybind_signal = COMSIG_XENOABILITY_FIRECHARGE

/datum/keybinding/xeno/firenado
	name = "Fire Storm"
	full_name = "焚化者: 火焰风暴"
	description = "Unleash firestorms that move towards your targeted turf."
	keybind_signal = COMSIG_XENOABILITY_FIRENADO

/datum/keybinding/xeno/fireball
	name = "Fireball"
	full_name = "焚化者: 火球"
	description = "Unleash a fireball after a small windup."
	keybind_signal = COMSIG_XENOABILITY_FIREBALL

/datum/keybinding/xeno/inferno
	name = "Inferno"
	full_name = "焚化者: 地狱火"
	description = "Release a large radius of fire."
	keybind_signal = COMSIG_XENOABILITY_INFERNO

/datum/keybinding/xeno/infernal_trigger
	name = "Infernal Trigger"
	full_name = "焚化者: 地狱触发"
	description = "Cause a burning marine to explode their flames outward."
	keybind_signal = COMSIG_XENOABILITY_INFERNAL_TRIGGER

/datum/keybinding/xeno/backhand
	name = "Backhand"
	full_name = "巨龙: 反手击"
	description = "Smack a group of marines in front of you away and stun them."
	keybind_signal = COMSIG_XENOABILITY_BACKHAND
	hotkey_keys = list("Z")

/datum/keybinding/xeno/fly
	name = "Fly"
	full_name = "巨龙: 飞行"
	description = "After a windup, begin to fly away. If you're already flying, land."
	keybind_signal = COMSIG_XENOABILITY_FLY
	hotkey_keys = list("F")

/datum/keybinding/xeno/dragon_breath
	name = "Dragon Breath"
	full_name = "巨龙: 龙息"
	description = "After a windup, continuously blast fire in a cardinal direction."
	keybind_signal = COMSIG_XENOABILITY_DRAGON_BREATH
	hotkey_keys = list("C")

/datum/keybinding/xeno/wind_current
	name = "Wind Current"
	full_name = "巨龙: 气流"
	description = "After a windup, clear gas and knock away marines in a cone in front of you."
	keybind_signal = COMSIG_XENOABILITY_WIND_CURRENT
	hotkey_keys = list("V")

/datum/keybinding/xeno/grab
	name = "Grab"
	full_name = "巨龙: 抓取"
	description = "After a windup, firmly grab a nearby marine in front of you."
	keybind_signal = COMSIG_XENOABILITY_GRAB
	hotkey_keys = list("B")

/datum/keybinding/xeno/scorched_land
	name = "Scorched Land"
	full_name = "巨龙: 焦土"
	description = "While flying, blast a line of fire in a direction."
	keybind_signal = COMSIG_XENOABILITY_SCORCHED_LAND
	hotkey_keys = list("G")
