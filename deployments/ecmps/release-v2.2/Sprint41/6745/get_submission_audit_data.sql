DROP FUNCTION IF EXISTS camdecmpsaux.GET_SUBMISSION_AUDIT_DATA(NUMERIC, CHARACTER VARYING, DATE, DATE, CHARACTER VARYING) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpsaux.GET_SUBMISSION_AUDIT_DATA(
    V_ORIS_CODE         NUMERIC,
    V_FACILITY_NAME     CHARACTER VARYING,
    V_BEGIN_DATE        DATE,
    V_END_DATE          DATE,
    V_FILE_TYPE_CD      CHARACTER VARYING
)
RETURNS TABLE (
    ORIS_CODE                       NUMERIC,
    FACILITY_NAME                   CHARACTER VARYING,
    STATE                           CHARACTER VARYING,
    LOCATIONS                       TEXT,
    PERIOD                          TEXT,
    FILE_TYPE_CD                    CHARACTER VARYING,
    SUBMISSION_ID                   BIGINT,
    SUBMISSION_DATE                 TIMESTAMP,
    SUBMISSION_SET                  TEXT,
    QUEUE_STATUS                    TEXT,
    QA_TYPE                         TEXT,
    QA_IDENTIFIER                   TEXT,
    SUBMITTER                       CHARACTER VARYING,
    LOADED_SUBMISSION_ID            BIGINT,
    LOADED_SUBMISSION_DATE          TIMESTAMP
) AS $BODY$
BEGIN
    RETURN QUERY
    with sq_filtered as (
		select
			sq.process_cd,
			sq.submission_id,
			sq.queued_time,
			sq.status_cd,
			sq.note,
			sq.test_sum_id,
			sq.qa_cert_Event_id,
			sq.test_extension_exemption_id,
			sq.submission_set_id,
			sq.rpt_period_id,
			ss.mon_plan_id,
			(select string_agg(sq_sub.submission_id::text, ',')
			   from	camdecmpsaux.submission_queue sq_sub
			  where	sq_sub.submission_set_id = ss.submission_set_id) as submission_set,
			ss.user_id,
			vmp.oris_code,
			vmp.facility_name,
			vmp.state,
			vmp.locations,
			mp.submission_id as mp_submission_id
		from camdecmpsaux.submission_queue sq
		join camdecmpsaux.submission_set ss on
			sq.submission_set_id = ss.submission_set_id
		join camdecmps.vw_monitor_plan vmp on
			ss.mon_plan_id = vmp.mon_plan_id
		join camdecmps.monitor_plan mp on
			vmp.mon_plan_id = mp.mon_plan_id
		where sq.submission_id > 0
		and sq.queued_time is not null
		and (sq.STARTED_TIME is null
			or sq.COMPLETED_TIME is null
			or sq.STATUS_CD = 'WIP')
		AND date_trunc('day', sq.queued_time) BETWEEN COALESCE(V_BEGIN_DATE, to_date('04/01/2026', 'mm/dd/yyyy')) AND COALESCE(V_END_DATE, date_trunc('day', now()))
		AND sq.process_cd = coalesce(V_FILE_TYPE_CD, sq.process_cd)
		AND vmp.oris_code = coalesce(V_ORIS_CODE, vmp.oris_code)
		AND vmp.facility_name = coalesce(V_FACILITY_NAME, vmp.facility_name)
	)
	select
		sq.oris_code,
		sq.facility_name,
		sq.state,
		sq.locations,
		null as period,
		sq.process_cd as file_type_cd,
		sq.submission_id,
		sq.queued_time as submission_date,
		sq.submission_set,
		sq.status_cd || ': ' || sq.note as queue_status,
		null as qa_type,
		null as qa_identifier,
		coalesce(sq.user_id , '') as submitter,
		mp_sq.submission_id as loaded_submission_id,
		mp_sq.queued_time as loaded_submission_date
	from
		sq_filtered sq
	left join camdecmpsaux.submission_queue mp_sq on
		mp_sq.process_cd = 'MP'
		and sq.mp_submission_id = mp_sq.submission_id
	where
		sq.process_cd = 'MP'
		and sq.submission_id > coalesce(mp_sq.submission_id, 0)
	union all
	select
		sq.oris_code,
		sq.facility_name,
		sq.state,
		sq.locations,
		null as period,
		sq.process_cd as file_type_cd,
		sq.submission_id,
		sq.queued_time as submission_date,
		sq.submission_set,
		sq.status_cd || ': ' || sq.note as queue_status,
		'Test' as qa_type,
		qsd_wks.test_type_cd || ' ' || qsd_wks.test_num as qa_identifier,
		coalesce(sq.user_id , '') as submitter,
		qa_ts_sq.submission_id as loaded_submission_id,
		qa_ts_sq.queued_time as loaded_submission_date
	from
		sq_filtered sq
	left join camdecmps.qa_supp_data qsd on
		sq.test_sum_id = qsd.test_sum_id
	left join camdecmpsaux.submission_queue qa_ts_sq on
		qa_ts_sq.process_cd = 'QA'
		and qa_ts_sq.test_sum_id = qsd.test_sum_id 
		and qsd.submission_id = qa_ts_sq.submission_id
	join camdecmpswks.qa_supp_data qsd_wks on
		sq.test_sum_id = qsd_wks.test_sum_Id
	where
		sq.process_cd = 'QA'
		and sq.submission_id > coalesce(qa_ts_sq.submission_id, 0)
		and sq.test_sum_id is not null
	union all
	select
		sq.oris_code,
		sq.facility_name,
		sq.state,
		sq.locations,
		null as period,
		sq.process_cd as file_type_cd,
		sq.submission_id,
		sq.queued_time as submission_date,
		sq.submission_set,
		sq.status_cd || ': ' || sq.note as queue_status,
		'Event' as qa_type,
		'Code ' || qce_wks.qa_cert_event_cd || 
		' Date/Hour ' || to_char(qce_wks.qa_cert_event_date, 'mm/dd/yyyy') || ' ' || qce_wks.qa_cert_event_hour || 
		case when qce_wks.mon_sys_id is not null then ' System ID ' || ms.system_identifier else '' end ||
        case when qce_wks.component_id is not null then ' Comp ID ' || c.component_identifier else '' end as qa_identifier,
		coalesce(sq.user_id , '') as submitter,
		qa_qce_sq.submission_id as loaded_submission_id,
		qa_qce_sq.queued_time as loaded_submission_date
	from
		sq_filtered sq
	left join camdecmps.qa_cert_event qce on
		sq.qa_cert_event_id = qce.qa_cert_event_id
	left join camdecmpsaux.submission_queue qa_qce_sq on
		qa_qce_sq.process_cd = 'QA'
		and qa_qce_sq.qa_cert_event_id = qce.qa_cert_event_id
		and qce.submission_id = qa_qce_sq.submission_id
	join camdecmpswks.qa_cert_event qce_wks on
		sq.qa_cert_event_id = qce_wks.qa_cert_event_id
    left join camdecmpswks.monitor_system ms on
		qce_wks.mon_sys_id = ms.mon_sys_id
    left join camdecmpswks.component c on
		qce_wks.component_id = c.component_id
	where
		sq.process_cd = 'QA'
		and sq.submission_id > coalesce(qa_qce_sq.submission_id, 0)
		and sq.qa_cert_event_id is not null
	union all
	select
		sq.oris_code,
		sq.facility_name,
		sq.state,
		sq.locations,
		null as period,
		sq.process_cd as file_type_cd,
		sq.submission_id,
		sq.queued_time as submission_date,
		sq.submission_set,
		sq.status_cd || ': ' || sq.note as queue_status,
		'Extension/Exemption' as qa_type,
		'Code ' || tee_wks.extens_exempt_cd || 
		case when tee_wks.mon_sys_id is not null then ' System ID ' || ms.system_identifier else '' end ||
        case when tee_wks.component_id is not null then ' Comp ID ' || c.component_identifier else '' end as qa_identifier,
		coalesce(sq.user_id , '') as submitter,
		qa_tee_sq.submission_id as loaded_submission_id,
		qa_tee_sq.queued_time as loaded_submission_date
	from
		sq_filtered sq
	left join camdecmps.test_extension_exemption tee on
		sq.test_extension_exemption_id = tee.test_extension_exemption_id
	left join camdecmpsaux.submission_queue qa_tee_sq on
		qa_tee_sq.process_cd = 'QA'
		and qa_tee_sq.test_extension_exemption_id = tee.test_extension_exemption_id
		and tee.submission_id = qa_tee_sq.submission_id
	join camdecmpswks.test_extension_exemption tee_wks on
		sq.test_extension_exemption_id = tee_wks.test_extension_exemption_id
    left join camdecmpswks.monitor_system ms on
		tee_wks.mon_sys_id = ms.mon_sys_id
    left join camdecmpswks.component c on
		tee_wks.component_id = c.component_id
	where
		sq.process_cd = 'QA'
		and sq.submission_id > coalesce(qa_tee_sq.submission_id, 0)
		and sq.test_extension_exemption_id is not null
	union all
	select
		sq.oris_code,
		sq.facility_name,
		sq.state,
		sq.locations,
		rp.period_abbreviation as period,
		sq.process_cd as file_type_cd,
		sq.submission_id,
		sq.queued_time as submission_date,
		sq.submission_set,
		sq.status_cd || ': ' || sq.note || case
			when not exists (
			select
				pr.pdem_report_id
			from
				camdecmpsaux.pdem_report pr
			where
				pr.mon_plan_id = sq.mon_plan_id 
				and pr.rpt_period_id = sq.rpt_period_id 
				and pr.submission_id >= sq.submission_id 
				and pr.status_cd = 'COMPLETE')
			then ' (PDEM missing)'
	    else ''
		end as queue_status,
		null as qa_type,
		null as qa_identifier,
		coalesce(sq.user_id , '') as submitter,
		ee_sq.submission_id as loaded_submission_id,
		ee_sq.queued_time as loaded_submission_date
	from
		sq_filtered sq
	left join camdecmpsmd.reporting_period rp on
		sq.rpt_period_id = rp.rpt_period_id
	left join camdecmps.emission_evaluation ee on
		sq.mon_plan_id = ee.mon_plan_id
		and coalesce(sq.rpt_period_id, 0) = ee.rpt_period_id
	left join camdecmpsaux.submission_queue ee_sq on
		ee_sq.process_cd = 'EM'
		and ee_sq.rpt_period_id = ee.rpt_period_id 
		and ee.submission_id = ee_sq.submission_id
	where
		sq.process_cd = 'EM'
		and 
		(
			sq.submission_id > coalesce(ee_sq.submission_id, 0)
			or
			not exists (
				select
					pr.pdem_report_id
				from
					camdecmpsaux.pdem_report pr
				where
					pr.mon_plan_id = sq.mon_plan_id 
					and pr.rpt_period_id = sq.rpt_period_id 
					and pr.submission_id >= sq.submission_id 
					and pr.status_cd = 'COMPLETE')
		)
	order by 
		file_type_cd,
		submission_date desc,
		submission_id;




END;
$BODY$ LANGUAGE PLPGSQL;
