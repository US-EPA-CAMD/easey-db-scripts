DROP FUNCTION IF EXISTS camdecmpsaux.get_last_submission_access(numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpsaux.get_last_submission_access(
    inmonplanid   numeric,
    inrptperiodid numeric)

    RETURNS numeric
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
    v_em_sub_access_id numeric;
BEGIN
    v_em_sub_access_id := NULL;

    SELECT esa.em_sub_access_id
      INTO v_em_sub_access_id
      FROM camdecmpsaux.em_submission_access esa
      JOIN (
            SELECT mon_plan_id,
                   rpt_period_id,
                   MAX(access_begin_date) AS access_begin_date
              FROM camdecmpsaux.em_submission_access
             WHERE sub_availability_cd <> 'DELETE'
                OR sub_availability_cd IS NULL
             GROUP BY mon_plan_id, rpt_period_id
      ) maxesa
        ON esa.mon_plan_id = maxesa.mon_plan_id
       AND esa.rpt_period_id = maxesa.rpt_period_id
       AND esa.access_begin_date = maxesa.access_begin_date
     WHERE esa.mon_plan_id = inmonplanid
       AND esa.rpt_period_id = inrptperiodid;

    RETURN v_em_sub_access_id;
END;
$BODY$;
