-- FUNCTION: camdecmpswks.update_collateral_em_data_for_qce_updates(character varying)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_collateral_em_data_for_qce_updates(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_collateral_em_data_for_qce_updates(
	vQceId character varying)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare 
	V_MON_PLAN_ID   character varying;
	V_RPT_PERIOD_ID  int;
	EM_CSR CURSOR FOR SELECT MON_PLAN_ID, RPT_PERIOD_ID
					FROM tmpEmissionsStatus;

begin    
    error_msg := '';
    result := 'T';
	
	----------------------------------------------
    --EM evaluation part 
    create temp table tmpEmissionsStatus(MON_PLAN_ID character varying,RPT_PERIOD_ID int);
    
    --	update EM evaluation
    INSERT INTO tmpEmissionsStatus 
        SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID
            FROM camdecmps.EMISSION_EVALUATION E,
            camdecmpsaux.EM_SUBMISSION_ACCESS ESA,
            camdecmps.MONITOR_PLAN_LOCATION M, 
            camdecmpsmd.REPORTING_PERIOD R,
            (SELECT MON_LOC_ID, QA_CERT_EVENT_ID,
                (SELECT EXTRACT('year' FROM qa_cert_event_date ) )AS CALENDAR_YEAR,
                FLOOR((extract(month from QA_CERT_EVENT_DATE) + 2) / 3) AS QUARTER
                FROM camdecmps.QA_CERT_EVENT) T
            WHERE E.MON_PLAN_ID = M.MON_PLAN_ID AND 
                    E.RPT_PERIOD_ID = R.RPT_PERIOD_ID AND
                    E.NEEDS_EVAL_FLG = 'N' AND
                    E.MON_PLAN_ID = ESA.MON_PLAN_ID AND 
                    E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID AND
                    ESA.SUB_AVAILABILITY_CD IN ('GRANTED','REQUIRE') AND
                    M.MON_LOC_ID = T.MON_LOC_ID AND
                    (R.CALENDAR_YEAR > T.CALENDAR_YEAR OR 
                    (R.CALENDAR_YEAR = T.CALENDAR_YEAR AND R.QUARTER >= T.QUARTER)) AND
                    QA_CERT_EVENT_ID =vQceId;					

    OPEN EM_CSR;	
    LOOP
        FETCH NEXT FROM EM_CSR INTO V_MON_PLAN_ID, V_RPT_PERIOD_ID;
    EXIT WHEN NOT FOUND;
        select * into result, error_msg 
          from camdecmpswks.delete_calculated_em_data_from_workspace(V_MON_PLAN_ID, V_RPT_PERIOD_ID);	
        
        if result = 'F' then
            exit;
        end if;
    END LOOP;
    CLOSE EM_CSR;
				    
    return next; -- Add row to return table.

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
    error_msg :='From update_collateral_em_data_for_qce_updates' ||' '|| error_msg;
	
    return next; -- Add row to return table.
END;
$BODY$;
