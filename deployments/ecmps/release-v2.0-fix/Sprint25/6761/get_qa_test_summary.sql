-- FUNCTION: camdecmps.get_qa_test_summary(character varying, numeric, character varying)

-- DROP FUNCTION IF EXISTS camdecmps.get_qa_test_summary(character varying, numeric, character varying);

CREATE OR REPLACE FUNCTION camdecmps.get_qa_test_summary(
	vtestsumid character varying,
	voriscode numeric,
	vunitid character varying)
    RETURNS TABLE(test_sum_id character varying, location_id character varying, oris_code numeric, unit_stack character varying, system_identifier character varying, component_identifier character varying, test_number character varying, grace_period_indicator numeric, test_type_cd character varying, test_reason_cd character varying, test_result_cd character varying, year_quarter text, test_description character varying, begin_date_time text, end_date_time text, test_comment character varying, span_scale_cd character varying, injection_protocol_cd character varying, resub_explanation character varying, submission_availability_cd character varying, submission_availability_description character varying, severity_cd character varying, severity_description character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

BEGIN
   RETURN QUERY
	select  tst.test_sum_id,
        loc.mon_loc_id as location_id,
        fac.oris_code,
        coalesce( unt.unitid, stp.stack_name ) as unit_stack,
        sys.system_identifier,
        cmp.component_identifier,
        tst.test_num as test_number,
        tst.gp_ind as grace_period_indicator,
        tst.test_type_cd,
        tst.test_reason_cd,
        tst.test_result_cd,
		rp.period_abbreviation as year_quarter,
        tst.test_description,
        case
            when tst.begin_hour is not null
            then to_char( tst.begin_date, 'MM/DD/YYYY' ) || ' ' || to_char( tst.begin_hour, 'fm00' ) || ':' || to_char( coalesce( tst.begin_min, 0 ), 'fm00' ) 
            else to_char( tst.begin_date, 'MM/DD/YYYY' )
        end as begin_date_time,
        case
            when tst.end_hour is not null
            then to_char( tst.end_date, 'MM/DD/YYYY' ) || ' ' || to_char( tst.end_hour, 'fm00' ) || ':' || to_char( coalesce( tst.end_min, 0 ), 'fm00' ) 
            else to_char( tst.end_date, 'MM/DD/YYYY' )
        end as end_date_time,
        tst.test_comment,
        tst.span_scale_cd,
        tst.injection_protocol_cd,
        qsd.resub_explanation,
        sac.submission_availability_cd,
        sac.sub_avail_cd_description as submission_availability_description,
        svc.severity_cd,
        svc.severity_cd_description as severity_description
  from  camdecmps.MONITOR_LOCATION loc
        left join camd.UNIT unt using ( unit_id )
        left join camdecmps.STACK_PIPE stp using ( stack_pipe_id )
        join camd.PLANT fac on fac.fac_id in ( unt.fac_id, stp.fac_id )
        join camdecmps.TEST_SUMMARY tst using ( mon_loc_id )
		left join camdecmpsmd.reporting_period rp on rp.rpt_period_id = tst.rpt_period_id
        left join camdecmps.MONITOR_SYSTEM sys using ( mon_sys_id )
        left join camdecmps.COMPONENT cmp using ( component_id )
        join camdecmps.qa_supp_data qsd using ( test_sum_id )
        join camdecmpsmd.SUBMISSION_AVAILABILITY_CODE sac using ( submission_availability_cd )
        LEFT JOIN camdecmpsaux.CHECK_SESSION chs on chs.chk_session_id = tst.chk_session_id
        left join camdecmpsmd.SEVERITY_CODE svc using ( severity_cd )
  where (case 
            when  vtestsumid is not null then
			      qsd.test_sum_id=vtestsumid
			when  voriscode is not null then 
			      fac.oris_code = voriscode			
			when  vunitid is not null then
			      unt.unitid=vunitid 
		   end )
		 ;
  
END;
$BODY$;

GRANT EXECUTE ON FUNCTION camdecmps.get_qa_test_summary(character varying, numeric, character varying) TO PUBLIC;

GRANT EXECUTE ON FUNCTION camdecmps.get_qa_test_summary(character varying, numeric, character varying) TO "r_quartz-scheduler";
