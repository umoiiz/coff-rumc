#define JOB_REPORT_MENU_FAIL_REASON_TRACKING_DISABLED 1
#define JOB_REPORT_MENU_FAIL_REASON_NO_RECORDS 2

/// Read-only playtime report, ported from tgstation/tgstation#54681.
/datum/job_report_menu
	/// Client whose playtime is being viewed, which may differ from the viewer.
	var/client/owner

/datum/job_report_menu/New(client/owner, mob/viewer)
	. = ..()
	src.owner = owner
	ui_interact(viewer)

/datum/job_report_menu/ui_state(mob/user)
	return GLOB.always_state

/datum/job_report_menu/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TrackedPlaytime", "Playtime for [owner.key]")
		ui.open()
		ui.set_autoupdate(FALSE)

/datum/job_report_menu/ui_static_data(mob/user)
	if(!CONFIG_GET(flag/use_exp_tracking))
		return list("failReason" = JOB_REPORT_MENU_FAIL_REASON_TRACKING_DISABLED)

	if(!owner?.prefs)
		return list("failReason" = JOB_REPORT_MENU_FAIL_REASON_NO_RECORDS)
	var/list/play_records = owner.prefs.exp
	if(!length(play_records))
		owner.set_exp_from_db()
		play_records = owner?.prefs?.exp
		if(!length(play_records))
			return list("failReason" = JOB_REPORT_MENU_FAIL_REASON_NO_RECORDS)

	var/list/data = list()
	var/list/job_playtimes = list()
	var/list/special_playtimes = list()
	var/list/caste_playtimes = list()

	for(var/job_name in SSjob.name_occupations)
		if(!(job_name in GLOB.jobs_regular_all))
			continue
		job_playtimes[job_name] = text2num(play_records[job_name]) || 0

	for(var/special_name in GLOB.exp_specialmap[EXP_TYPE_XENO])
		special_playtimes[special_name] = text2num(play_records[special_name]) || 0
	special_playtimes[EXP_TYPE_ADMIN] = text2num(play_records[EXP_TYPE_ADMIN]) || 0

	for(var/caste_typepath AS in GLOB.xeno_caste_datums)
		var/datum/xeno_caste/caste_type = GLOB.xeno_caste_datums[caste_typepath][XENO_UPGRADE_BASETYPE]
		caste_playtimes[caste_type.caste_name] = text2num(play_records[caste_type.caste_name]) || 0

	data["jobPlaytimes"] = job_playtimes
	data["specialPlaytimes"] = special_playtimes
	data["castePlaytimes"] = caste_playtimes
	data["livingTime"] = text2num(play_records[EXP_TYPE_LIVING]) || 0
	data["ghostTime"] = text2num(play_records[EXP_TYPE_GHOST]) || 0
	return data

#undef JOB_REPORT_MENU_FAIL_REASON_TRACKING_DISABLED
#undef JOB_REPORT_MENU_FAIL_REASON_NO_RECORDS
