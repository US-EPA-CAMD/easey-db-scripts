DROP FUNCTION IF EXISTS camdecmpsaux.get_last_submission_list(character varying, numeric, character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpsaux.get_last_submission_list(
    v_mon_plan_id character varying,
    v_rpt_period_id numeric,
    v_submission_type character varying
)
RETURNS bigint
LANGUAGE plpgsql
COST 100
VOLATILE 
AS $BODY$
DECLARE
    v_submission_id bigint := NULL;
BEGIN
    select  sbq.submission_id
    into  v_submission_id
    from  camdecmpsaux.SUBMISSION_SET sbs
            join camdecmpsaux.SUBMISSION_QUEUE sbq using ( submission_set_id )
    where  sbs.mon_plan_Id = v_mon_plan_id
    and  sbq.process_cd = v_submission_type
    and  ( sbq.process_cd != 'EM' or sbq.rpt_period_id = v_rpt_period_id )
    order
        by  sbq.queued_time desc
    limit  1;

    RETURN v_submission_id;
END;
$BODY$;