-- FUNCTION: camdecmpswks.update_collateral_em_data_for_mp_changes(character varying)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_collateral_em_data_for_mp_changes(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_collateral_em_data_for_mp_changes(
	vmon_plan_id character varying)
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
        SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID
        FROM camdecmpswks.EMISSION_EVALUATION E,
            camdecmpsaux.EM_SUBMISSION_ACCESS ESA,
            camdecmpswks.MONITOR_PLAN_LOCATION M,
            (
                SELECT  MON_LOC_ID, MP.MON_PLAN_ID
                  FROM  camdecmpswks.MONITOR_PLAN MP
                        INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION MPL ON MP.MON_PLAN_ID = MPL.MON_PLAN_ID
            ) T
        WHERE E.NEEDS_EVAL_FLG = 'N'
          AND E.MON_PLAN_ID = M.MON_PLAN_ID
          AND E.MON_PLAN_ID = ESA.MON_PLAN_ID
          AND E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID
          AND ESA.SUB_AVAILABILITY_CD IN ('GRANTED','REQUIRE')
          AND M.MON_LOC_ID = T.MON_LOC_ID
          AND T.MON_PLAN_ID = vmon_plan_id
    ) LOOP
        select * into result, error_msg
          from camdecmpswks.delete_calculated_em_data_from_workspace(emission_record.MON_PLAN_ID, emission_record.RPT_PERIOD_ID);
        -- Deleting Calculated data failed, bail (PJR)
        IF result = 'F' then
            EXIT;
        END IF;
    END LOOP;

        RETURN NEXT; -- Add row to return table.
  
exception when others then
    get stacked diagnostics error_msg:= message_text;
    result = 'F';
    error_msg :='From update_collateral_em_data_for_mp_changes' ||' '|| error_msg;
	 
    RETURN NEXT; -- Add row to return table.
END;
$BODY$;

