CREATE OR REPLACE FUNCTION camdecmpsaux.get_last_submission(
    v_mon_plan_id character varying,
    v_rpt_period_id numeric,
    v_process_cd character varying,
    v_test_sum_id character varying,
    v_qa_cert_event_id  character varying,
    v_test_extension_exemption_id character varying
)
 RETURNS bigint
 LANGUAGE plpgsql
COST 100
VOLATILE 
AS $BODY$
DECLARE
    v_submission_id bigint := NULL;
BEGIN
    select  lsq.submission_id
    into  v_submission_id
    from  camdecmpsaux.SUBMISSION_QUEUE lsq
                    join camdecmpsaux.SUBMISSION_SET lss using ( submission_set_id )
             where  (
                        ( ( v_process_cd = 'MP' ) and ( lss.mon_plan_id = v_mon_plan_id  ))
                        or
                        ( ( v_process_cd= 'EM' ) and ( lss.mon_plan_id = v_mon_plan_id  ) and ( lsq.rpt_period_id = v_rpt_period_id ) )
                        or
                        ( ( v_process_cd = 'QA' ) and ( ( lsq.test_sum_id = v_test_sum_id ) ) )
                        or
                        ( ( v_process_cd= 'QA' ) and ( ( lsq.qa_cert_event_id = v_qa_cert_event_id) ) )
                        or
                        ( ( v_process_cd = 'QA' ) and ( ( lsq.test_extension_exemption_id = v_test_extension_exemption_id ) ) )
                        or
                        (( v_process_cd NOT IN ('EM', 'QA', 'MP') ) and ( lss.mon_plan_id = v_mon_plan_id ))
                    
                    )
               and  lsq.status_cd = 'COMPLETE'
               and  lss.mon_plan_Id = v_mon_plan_id
             order
                by  lsq.completed_time desc,
                    lsq.submission_id desc
             limit  1;

    RETURN v_submission_id;
END;
$BODY$;