-- FUNCTION: camdecmpswks.update_collateral_em_data_for_mp_updates(character varying)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_collateral_em_data_for_mp_updates(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_collateral_em_data_for_mp_updates(
	vmon_plan_id character varying)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
declare 
	V_MON_PLAN_ID   character varying;
	V_RPT_PERIOD_ID int;
	EM_CSR 			CURSOR FOR SELECT MON_PLAN_ID, RPT_PERIOD_ID
					FROM tmpEmissionsStatus;
begin
    error_msg := '';
    result := 'T';

    create temp table tmpEmissionsStatus(MON_PLAN_ID character varying,RPT_PERIOD_ID int);

    INSERT INTO tmpEmissionsStatus
        SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID
        FROM camdecmpswks.EMISSION_EVALUATION E, camdecmpswks.MONITOR_PLAN_LOCATION M, camdecmpsaux.EM_SUBMISSION_ACCESS ESA
        WHERE E.NEEDS_EVAL_FLG = 'N'
          AND E.MON_PLAN_ID = M.MON_PLAN_ID
          AND E.MON_PLAN_ID = ESA.MON_PLAN_ID
          AND E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID
          AND ESA.SUB_AVAILABILITY_CD IN ('REQUIRE','GRANTED')
          AND E.MON_PLAN_ID = vmon_plan_id;

           OPEN EM_CSR;
             LOOP
                FETCH Next from EM_CSR INTO V_MON_PLAN_ID, V_RPT_PERIOD_ID;

                  Exit when not found;
                      select * into result, error_msg
                       from camdecmpswks.delete_calculated_em_data_from_workspace(V_MON_PLAN_ID, V_RPT_PERIOD_ID);
                     -- Deleting Calculated data failed, bail (PJR)
                     IF result = 'F' then
                        exit;
                      end if;
                 end loop;
                CLOSE EM_CSR;

        RETURN NEXT; -- Add row to return table.
  
exception when others then
    get stacked diagnostics error_msg:= message_text;
    result = 'F';
    error_msg :='From update_collateral_em_data_for_mp_updates' ||' '|| error_msg;
	 
    RETURN NEXT; -- Add row to return table.
END;
$BODY$;

