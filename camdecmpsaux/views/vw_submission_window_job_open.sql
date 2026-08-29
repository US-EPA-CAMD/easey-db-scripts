drop view if exists camdecmpsaux.vw_submission_window_job_open;

create or replace
view camdecmpsaux.vw_submission_window_job_open
as
select
	mp.fac_id,
	mp.oris_code,
	mp.facility_name,
	MP.MON_PLAN_ID,
	mp.locations,
	ers.rpt_period_id,
	ers.calendar_year,
	ers.quarter,
	max(ers.em_reporting_status) as EM_SUB_STATUS,
	em.sub_availability_cd,
	em.em_status_cd,
	em.em_sub_access_id,
	case
		when sum(case when exists(select 1
									from CAMDECMPS.MONITOR_PLAN_LOCATION MPL 
										join CAMDECMPS.MONITOR_LOCATION ML 
											on MPL.MON_LOC_ID = ML.MON_LOC_ID
										join CAMDECMPS.OPERATING_SUPP_DATA O 
											on MPL.MON_LOC_ID = O.MON_LOC_ID
									where mpl.mon_plan_id = mp.mon_plan_id) then 0 else 1 end) > 0 then 'T'
		else 'F'
	end as CREATE_PENDING
	from
		CAMDECMPS.VW_MONITOR_PLAN MP
	join CAMDECMPS.vw_em_reporting_status ers 
	on
		mp.fac_id = ers.fac_id
		and mp.mon_plan_id = ers.mon_plan_id
		and ers.em_reporting_status is not null
	left join CAMDECMPSAUX.EM_SUBMISSION_ACCESS EM 
	on
		ERS.MON_PLAN_ID = EM.MON_PLAN_ID
		and ERS.rpt_period_id = EM.rpt_period_id
		and EM.EM_SUB_TYPE_CD = 'INITIAL'
	group by
		mp.fac_id,
		mp.oris_code,
		mp.facility_name,
		MP.mon_plan_id,
		mp.locations,
		ers.rpt_period_id,
		ers.calendar_year,
		ers.quarter,
		em.em_sub_access_id;