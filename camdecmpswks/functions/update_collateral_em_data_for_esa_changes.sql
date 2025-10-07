-- FUNCTION: camdecmpswks.update_collateral_em_data_for_esa_changes(character varying, integer)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_collateral_em_data_for_esa_changes(character varying, integer);

CREATE OR REPLACE FUNCTION camdecmpswks.update_collateral_em_data_for_esa_changes(
	vmonplanid character varying,
	vrptperiodid integer)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare 
	emission_record RECORD;
begin
    error_msg := '';
    result := 'T';

    FOR emission_record IN (
        SELECT DISTINCT
                uem.mon_plan_id,
                uem.rpt_period_id
          FROM camdecmps.EMISSION_EVALUATION sem
                JOIN camdecmpsmd.REPORTING_PERIOD srp
                  ON srp.rpt_period_id = sem.rpt_period_id
                JOIN camdecmps.MONITOR_PLAN_LOCATION spl
                  ON spl.mon_plan_id = sem.mon_plan_id
                JOIN camdecmps.MONITOR_PLAN_LOCATION upl
                  ON upl.mon_loc_id = spl.mon_loc_id
                JOIN camdecmps.EMISSION_EVALUATION uem
                  ON uem.mon_plan_id = upl.mon_plan_id
                 AND EXISTS
                     (
                        SELECT 1
                          FROM camdecmpsaux.EM_SUBMISSION_ACCESS esa
                         WHERE esa.mon_plan_id = uem.mon_plan_id
                           AND esa.rpt_period_id = uem.rpt_period_id
                           AND esa.sub_availability_cd IN ('GRANTED', 'REQUIRE')
                     )
                JOIN camdecmpsmd.REPORTING_PERIOD urp
                  ON urp.rpt_period_id = uem.rpt_period_id
         WHERE sem.rpt_period_id = vrptperiodid
           AND sem.mon_plan_id = vmonplanid
           AND (
                    urp.calendar_year > srp.calendar_year
                    OR
                    (urp.calendar_year = srp.calendar_year AND urp.quarter >= srp.quarter)
                )
    ) LOOP
        select * into result, error_msg
          from camdecmpswks.delete_calculated_em_data_from_workspace(emission_record.mon_plan_id, emission_record.rpt_period_id::integer);
        -- Deleting Calculated data failed, bail
        IF result = 'F' then
            EXIT;
        END IF;
    END LOOP;

    RETURN NEXT; -- Add row to return table.

exception when others then
    get stacked diagnostics error_msg := message_text;
    result := 'F';
    error_msg :='From update_collateral_em_data_for_esa_changes' ||' '|| error_msg;
	
    RETURN NEXT; -- Add row to return table.
END;
$BODY$;