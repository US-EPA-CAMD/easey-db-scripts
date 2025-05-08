-- FUNCTION: camdecmpswks.update_collateral_em_data_for_em_updates(character varying, integer)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_collateral_em_data_for_em_updates(character varying, integer);

CREATE OR REPLACE FUNCTION camdecmpswks.update_collateral_em_data_for_em_updates(
	vmon_plan_id character varying,
	vperiod_id integer)
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
       FROM camdecmpswks.EMISSION_EVALUATION E,
            camdecmpsaux.EM_SUBMISSION_ACCESS ESA,
            camdecmpswks.MONITOR_PLAN_LOCATION M,
            camdecmpsmd.REPORTING_PERIOD R,
    (SELECT MON_LOC_ID, EE.MON_PLAN_ID, EE.RPT_PERIOD_ID,CALENDAR_YEAR, QUARTER
        FROM camdecmpswks.EMISSION_EVALUATION EE
            INNER JOIN camdecmpsmd.REPORTING_PERIOD RP ON EE.RPT_PERIOD_ID = RP.RPT_PERIOD_ID
            INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION MPL ON EE.MON_PLAN_ID = MPL.MON_PLAN_ID) T
        WHERE E.MON_PLAN_ID = M.MON_PLAN_ID
          AND E.RPT_PERIOD_ID = R.RPT_PERIOD_ID
          AND E.MON_PLAN_ID = ESA.MON_PLAN_ID
          AND E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID
          AND ESA.SUB_AVAILABILITY_CD IN ('GRANTED','REQUIRE')
          AND M.MON_LOC_ID = T.MON_LOC_ID
          AND (R.CALENDAR_YEAR > T.CALENDAR_YEAR OR
                (R.CALENDAR_YEAR = T.CALENDAR_YEAR AND R.QUARTER > T.QUARTER))
          AND T.MON_PLAN_ID = vmon_plan_id
          AND T.RPT_PERIOD_ID = vperiod_id;

       -- camdecmpswks.emission_evaluation has column=SUBMISSION_AVAILABILITY_CD
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
    error_msg :='From update_collateral_em_data_for_em_updates' ||' '|| error_msg;
	 
    RETURN NEXT; -- Add row to return table.
END;
$BODY$;

