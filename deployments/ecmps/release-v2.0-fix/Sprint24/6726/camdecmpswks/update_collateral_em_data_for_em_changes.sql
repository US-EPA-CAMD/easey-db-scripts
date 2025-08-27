-- FUNCTION: camdecmpswks.update_collateral_em_data_for_em_changes(character varying, integer)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_collateral_em_data_for_em_changes(character varying, integer);

CREATE OR REPLACE FUNCTION camdecmpswks.update_collateral_em_data_for_em_changes(
	vmon_plan_id character varying,
	vperiod_id integer)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
declare
    vSubmittable    char(1);
	emission_record RECORD;
begin
    vSubmittable :='N';
    error_msg := '';
    result := 'T';

    select  coalesce ( max( 'Y' ), 'N' ) as Submittable
      into  vSubmittable
      from  camdecmpsaux.EM_SUBMISSION_ACCESS
     where  mon_plan_id = vmon_plan_id
       and  sub_availability_cd IN ('GRANTED', 'REQUIRE')
	   and  RPT_PERIOD_ID = vperiod_id;

    if vSubmittable = 'Y' then
        FOR emission_record IN (
            SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID
              FROM camdecmpswks.EMISSION_EVALUATION E,
                   camdecmpsaux.EM_SUBMISSION_ACCESS ESA,
                   camdecmpswks.MONITOR_PLAN_LOCATION M,
                   camdecmpsmd.REPORTING_PERIOD R,
                   (SELECT MON_LOC_ID, EE.MON_PLAN_ID, EE.RPT_PERIOD_ID,CALENDAR_YEAR, QUARTER
                       FROM camdecmpswks.EMISSION_EVALUATION EE
                           INNER JOIN camdecmpsmd.REPORTING_PERIOD RP ON EE.RPT_PERIOD_ID = RP.RPT_PERIOD_ID
                           INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION MPL ON EE.MON_PLAN_ID = MPL.MON_PLAN_ID
                   ) T
               WHERE E.MON_PLAN_ID = M.MON_PLAN_ID
                 AND E.RPT_PERIOD_ID = R.RPT_PERIOD_ID
                 AND E.MON_PLAN_ID = ESA.MON_PLAN_ID
                 AND E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID
                 AND ESA.SUB_AVAILABILITY_CD IN ('GRANTED','REQUIRE')
                 AND M.MON_LOC_ID = T.MON_LOC_ID
                 AND (R.CALENDAR_YEAR > T.CALENDAR_YEAR OR
                       (R.CALENDAR_YEAR = T.CALENDAR_YEAR AND R.QUARTER > T.QUARTER))
                 AND T.MON_PLAN_ID = vmon_plan_id
                 AND T.RPT_PERIOD_ID = vperiod_id
        ) LOOP
            select * into result, error_msg
              from camdecmpswks.delete_calculated_em_data_from_workspace(emission_record.MON_PLAN_ID, emission_record.RPT_PERIOD_ID);
            IF result = 'F' then
                EXIT;
            END IF;
        END LOOP;

    end if; --vSubmittable if

    RETURN NEXT; -- Add row to return table.
  
exception when others then
    get stacked diagnostics error_msg:= message_text;
    result = 'F';
    error_msg :='From update_collateral_em_data_for_em_changes' ||' '|| error_msg;
	 
    RETURN NEXT; -- Add row to return table.
END;
$BODY$;

