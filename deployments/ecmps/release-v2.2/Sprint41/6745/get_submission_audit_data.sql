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
    PERIOD                          CHARACTER VARYING,
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
    select
		vmp.oris_code,
		vmp.facility_name,
		vmp.state,
		vmp.locations,
		rp.period_abbreviation as period,
		sq.process_cd as file_type_cd,
		sq.submission_id,
		sq.queued_time as submission_date,
		(
		select
			string_agg(sq_sub.submission_id::text, ',')
		from
			camdecmpsaux.submission_queue sq_sub
		where
			sq_sub.submission_set_id = ss.submission_set_id) as submission_set,
		sq.status_cd || ': ' || sq.note || case
			when sq.process_cd = 'EM'
			and not exists (
			select
					pr.pdem_report_id
			from
					camdecmpsaux.pdem_report pr
			where
					pr.submission_id = sq.submission_id
				and pr.status_cd = 'COMPLETE')
			then ' (PDEM missing)'
	    else ''
		end as queue_status,
		case
			when sq.process_cd = 'QA'
			and sq.test_sum_id is not null then 'Test'
			when sq.process_cd = 'QA'
			and sq.qa_cert_event_id is not null then 'Event'
			when sq.process_cd = 'QA'
			and sq.test_extension_exemption_id is not null then 'Extension/Exemption'
			else null
		end as qa_type,
		case
			when sq.process_cd = 'QA'
			and sq.test_sum_id is not null then qsd_wks.test_type_cd || ' ' || qsd_wks.test_num
			when sq.process_cd = 'QA'
			and sq.qa_cert_event_id is not null then 'Code ' || qce_wks.qa_cert_event_cd || ' Date/Hour ' || to_char(qce_wks.qa_cert_event_date, 'mm/dd/yyyy') || ' ' || qce_wks.qa_cert_event_hour
			when sq.process_cd = 'QA'
			and sq.test_extension_exemption_id is not null then 'Code ' || tee_wks.extens_exempt_cd
			else null
		end as qa_identifier,
		coalesce(ss.user_id , '') as submitter,
		case
			when sq.process_cd = 'EM' then ee_sq.submission_id
			when sq.process_cd = 'MP' then mp_sq.submission_id
			when sq.process_cd = 'QA'
			and sq.test_sum_id is not null then qa_ts_sq.submission_id
			when sq.process_cd = 'QA'
			and sq.qa_cert_event_id is not null then qa_qce_sq.submission_id
			when sq.process_cd = 'QA'
			and sq.test_extension_exemption_id is not null then qa_tee_sq.submission_id
			else null
		end as loaded_submission_id,
		case
			when sq.process_cd = 'EM' then ee_sq.queued_time
			when sq.process_cd = 'MP' then mp_sq.queued_time
			when sq.process_cd = 'QA'
			and sq.test_sum_id is not null then qa_ts_sq.queued_time
			when sq.process_cd = 'QA'
			and sq.qa_cert_event_id is not null then qa_qce_sq.queued_time
			when sq.process_cd = 'QA'
			and sq.test_extension_exemption_id is not null then qa_tee_sq.queued_time
			else null
		end as loaded_submission_date
	from
		camdecmpsaux.submission_set ss
	join camdecmpsaux.submission_queue sq on
		ss.submission_set_id = sq.submission_set_id
		and sq.queued_time is not null
		and (sq.STARTED_TIME is null
			or sq.COMPLETED_TIME is null
			or sq.STATUS_CD = 'WIP')
		AND date_trunc('day', sq.queued_time) BETWEEN COALESCE(v_begin_date, to_date('04/01/2026', 'mm/dd/yyyy')) AND COALESCE(v_end_date, now())
		AND sq.process_cd = coalesce(v_file_type_cd, sq.process_cd)
	join camdecmps.vw_monitor_plan vmp on
		ss.mon_plan_id = vmp.mon_plan_id
		AND vmp.oris_code = coalesce(v_oris_code, vmp.oris_code)
		AND vmp.facility_name = coalesce(v_facility_name, vmp.facility_name)
	join camdecmps.monitor_plan mp on
		vmp.mon_plan_id = mp.mon_plan_id
	left join camdecmpsmd.reporting_period rp on
		sq.rpt_period_id = rp.rpt_period_id
	left join camdecmps.emission_evaluation ee on
		ss.mon_plan_id = ee.mon_plan_id
		and coalesce(sq.rpt_period_id, 0) = ee.rpt_period_id
	left join camdecmpsaux.submission_queue ee_sq on
		ee.submission_id = ee_sq.submission_id
	left join camdecmpsaux.submission_queue mp_sq on
		mp.submission_id = mp_sq.submission_id
	left join camdecmps.qa_supp_data qsd on
		sq.test_sum_id = qsd.test_sum_id
	left join camdecmpsaux.submission_queue qa_ts_sq on
		qsd.submission_id = qa_ts_sq.submission_id
	left join camdecmps.qa_cert_event qce on
		sq.qa_cert_event_id = qce.qa_cert_event_id
	left join camdecmpsaux.submission_queue qa_qce_sq on
		qce.submission_id = qa_qce_sq.submission_id
	left join camdecmps.test_extension_exemption tee on
		sq.test_extension_exemption_id = tee.test_extension_exemption_id
	left join camdecmpsaux.submission_queue qa_tee_sq on
		tee.submission_id = qa_tee_sq.submission_id
	left join camdecmpswks.qa_supp_data qsd_wks on
		sq.test_sum_id = qsd_wks.test_sum_Id
	left join camdecmpswks.qa_cert_event qce_wks on
		sq.qa_cert_event_id = qce_wks.qa_cert_event_id
	left join camdecmpswks.test_extension_exemption tee_wks on
		sq.test_extension_exemption_id = tee_wks.test_extension_exemption_id
	where
		sq.submission_id > 0
		and 
		(
			sq.submission_id > coalesce(case
				when sq.process_cd = 'EM' then ee_sq.submission_id
				when sq.process_cd = 'MP' then mp_sq.submission_id
				when sq.process_cd = 'QA' and sq.test_sum_id is not null then qa_ts_sq.submission_id		
				when sq.process_cd = 'QA' and sq.qa_cert_event_id is not null then qa_qce_sq.submission_id		
				when sq.process_cd = 'QA' and sq.test_extension_exemption_id is not null then qa_tee_sq.submission_id
				else null
			end, 0)
			or
			( sq.process_cd = 'EM'
				and sq.submission_id = ee_sq.submission_id
				and not exists (
				select
					pr.pdem_report_id
				from
					camdecmpsaux.pdem_report pr
				where
					pr.submission_id = sq.submission_id
					and pr.status_cd = 'COMPLETE')
			)
		)
		and (
			sq.process_cd <> 'QA'
			or
			(
				sq.process_cd = 'QA' 
				and
				(
					(sq.test_sum_id is not null and qsd_wks.test_sum_id is not null)
					or
					(sq.qa_cert_event_id is not null and qce_wks.qa_cert_event_id is not null)
					or
					(sq.test_extension_exemption_id is not null and tee_wks.test_extension_exemption_id is not null)
				)
			)
		)
		and sq.note not like '%duplicate key value violates unique constraint%'
		and sq.note not like '%ENOSPC: no space left on device, mkdir%'
	order by
		sq.process_cd,
		sq.queued_time desc,
		sq.submission_id;


END;
$BODY$ LANGUAGE PLPGSQL;
