create or replace
view camdecmpsaux.vw_submission_window_job_close
as
select
	MP.FAC_ID,
	MP.ORIS_CODE,
	MP.FACILITY_NAME,
	ESA.MON_PLAN_ID,
	MP.LOCATIONS,
	ESA.RPT_PERIOD_ID,
	RP.CALENDAR_YEAR,
	RP.QUARTER,
	ESA.EM_SUB_ACCESS_ID,
	ESA.ACCESS_BEGIN_DATE,
	ESA.ACCESS_END_DATE,
	ESA.SUB_AVAILABILITY_CD,
	ESA.EM_STATUS_CD,
	ESA.EM_SUB_TYPE_CD,
	S.STATUS_CD as SUBMISSION_STATUS_CD,
	S.SEVERITY_CD,
	case 
		when ESA.SUB_AVAILABILITY_CD = 'UPDATED' AND
			S.SEVERITY_CD = 'CRIT2' then 'T'
		else 'F'
	end as REOPEN_CRIT2,
	case
		when ESA.EM_SUB_TYPE_CD = 'INITIAL' AND
			(ESA.SUB_AVAILABILITY_CD <> 'UPDATED' OR
			 S.SEVERITY_CD = 'CRIT2') then 'T'
		else 'F'
	end as CHECK_FOR_REMINDER,
	case
		when ESA.EM_SUB_TYPE_CD = 'INITIAL' OR 
			S.STATUS_CD IN ('NOLOAD', 'RECCRIT') OR
			S.SEVERITY_CD = 'CRIT2' then 'T'
		else 'F'
	end as EXTEND_WINDOW	
from
	CAMDECMPSAUX.EM_SUBMISSION_ACCESS ESA
join CAMDECMPS.VW_MONITOR_PLAN MP on
	ESA.MON_PLAN_ID = MP.MON_PLAN_ID
join CAMDECMPSMD.REPORTING_PERIOD RP on
	ESA.RPT_PERIOD_ID = RP.RPT_PERIOD_ID
left join camdecmpsaux.vw_last_submission_in_window lsiw 
	on	esa.mon_plan_id = lsiw.mon_plan_id
	and esa.rpt_period_id = lsiw.rpt_period_id
	and esa.ACCESS_BEGIN_DATE = lsiw.ACCESS_BEGIN_DATE
	and esa.ACCESS_END_DATE = lsiw.ACCESS_END_DATE
left join CAMDECMPSAUX.SUBMISSION_QUEUE S 
	on	lsiw.submission_id = s.submission_id
where
	(ESA.SUB_AVAILABILITY_CD in ('REQUIRE', 'GRANTED')
		or (ESA.SUB_AVAILABILITY_CD = 'UPDATED'
			and S.SEVERITY_CD = 'CRIT2'));