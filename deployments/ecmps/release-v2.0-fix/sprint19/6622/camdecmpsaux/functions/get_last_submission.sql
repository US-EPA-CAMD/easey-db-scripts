

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
    v_submission_id bigint;
BEGIN
    v_submission_id := NULL;

    WITH submission_log AS (
        SELECT 
            SQ.submission_set_id,
            SS.mon_plan_id,
            SQ.rpt_period_id,
            SQ.queued_time,
            SQ.process_cd,
            SQ.submission_id
        FROM camdecmpsaux.submission_set SS
        JOIN camdecmpsaux.submission_queue SQ USING(submission_set_id)
    ),
    latest_queued_time AS (
        SELECT 
            SL.mon_plan_id,
            SL.rpt_period_id,
            MAX(SL.queued_time) AS queued_time
        FROM submission_log SL
        LEFT JOIN (
            SELECT 
                mon_plan_id,
                MIN(
                    CASE 
                        WHEN access_begin_date > add_date THEN access_begin_date
                        ELSE add_date
                    END
                ) AS access_begin_date
            FROM camdecmpsaux.em_submission_access
            WHERE mon_plan_id = v_mon_plan_id
            AND CASE 
            WHEN v_submission_type = 'EM' 
            THEN COALESCE(v_rpt_period_id, 0, rpt_period_id)
            ELSE  0
            END = 
            CASE 
            WHEN v_submission_type = 'EM' 
            THEN COALESCE(v_rpt_period_id, 0)
            ELSE 0
            END
            GROUP BY mon_plan_id
        ) ESA 
        ON SL.mon_plan_id = ESA.mon_plan_id
          AND SL.mon_plan_id = v_mon_plan_id
          AND SL.rpt_period_id = v_rpt_period_id
          AND  SL.queued_time = ESA.access_begin_date
        GROUP BY SL.mon_plan_id, SL.rpt_period_id
    )
    SELECT SL2.submission_id
    INTO v_submission_id
    FROM submission_log SL2
    JOIN latest_queued_time LQT
      ON SL2.mon_plan_id = LQT.mon_plan_id
     AND SL2.rpt_period_id = LQT.rpt_period_id
     AND SL2.queued_time = LQT.queued_time
     AND SL2.process_cd = COALESCE(v_submission_type, SL2.process_cd )
     AND CASE 
            WHEN v_submission_type = 'EM' THEN 
                COALESCE(v_rpt_period_id, 0, SL2.rpt_period_id)
            ELSE 
                0
        END = 
        CASE 
            WHEN v_submission_type = 'EM' THEN 
                COALESCE(v_rpt_period_id, 0)
            ELSE 
                0
    END
    ORDER BY SL2.queued_time DESC
    LIMIT 1;

    RETURN v_submission_id;
END;
$BODY$;



