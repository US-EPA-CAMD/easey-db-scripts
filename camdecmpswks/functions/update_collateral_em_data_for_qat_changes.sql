-- FUNCTION: camdecmpswks.update_collateral_em_data_for_qat_changes(character varying)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_collateral_em_data_for_qat_changes(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_collateral_em_data_for_qat_changes(
	vTestSumId character varying)
    RETURNS TABLE(result text, error_msg character varying)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare
    vCount          int;
	vContinue       char(1);
	V_MON_PLAN_ID   character varying;
	V_RPT_PERIOD_ID  int;
	EM_CSR 			CURSOR FOR SELECT MON_PLAN_ID, RPT_PERIOD_ID
					FROM tmpEmissionsStatus;

begin
    error_msg := '';
    result := 'T';

	--common part for QA Test-------
	vContinue:='Y';

    --Check no test_sum_id or can't submit
    SELECT count(*) into vCount
      FROM camdecmpswks.QA_SUPP_DATA
     WHERE TEST_SUM_ID != vTestSumId
        OR (TEST_SUM_ID = vTestSumId AND
            (submission_availability_cd IS NULL OR
            submission_availability_cd = 'GRANTED' OR
            submission_availability_cd = 'REQUIRE' ));

	if vCount=0 then
		vContinue:='N';
    end if;

	If vContinue='Y' then

        --	update EM evaluation
        create temp table tmpEmissionsStatus(MON_PLAN_ID character varying,RPT_PERIOD_ID int);

        INSERT INTO tmpEmissionsStatus
         SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID
                    FROM camdecmpswks.EMISSION_EVALUATION E,
                        camdecmpsaux.EM_SUBMISSION_ACCESS ESA,
                        camdecmpswks.MONITOR_PLAN_LOCATION M,
                        camdecmpsmd.REPORTING_PERIOD R,
                        (SELECT MON_LOC_ID, TEST_SUM_ID,
                            CASE WHEN TS.RPT_PERIOD_ID IS NULL THEN extract(year from TS.END_DATE) ELSE RP.CALENDAR_YEAR END AS CALENDAR_YEAR,
                            CASE WHEN TS.RPT_PERIOD_ID IS NULL THEN FLOOR((extract(month from TS.END_DATE) + 2) / 3) ELSE RP.QUARTER END AS QUARTER
                            FROM camdecmpswks.TEST_SUMMARY TS
                                LEFT OUTER JOIN camdecmpsmd.REPORTING_PERIOD RP ON TS.RPT_PERIOD_ID = RP.RPT_PERIOD_ID
                        ) T
                    WHERE E.MON_PLAN_ID = M.MON_PLAN_ID AND
                        E.RPT_PERIOD_ID = R.RPT_PERIOD_ID AND
                        E.NEEDS_EVAL_FLG = 'N' AND
                        E.MON_PLAN_ID = ESA.MON_PLAN_ID AND
                        E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID AND
                        ESA.SUB_AVAILABILITY_CD IN ('GRANTED','REQUIRE') AND
                        M.MON_LOC_ID = T.MON_LOC_ID AND
                        (R.CALENDAR_YEAR > T.CALENDAR_YEAR OR
                        (R.CALENDAR_YEAR = T.CALENDAR_YEAR AND R.QUARTER >= T.QUARTER))
                        AND	TEST_SUM_ID = vTestSumId ;

        OPEN EM_CSR;

        LOOP
            FETCH NEXT FROM EM_CSR INTO V_MON_PLAN_ID, V_RPT_PERIOD_ID;
        EXIT WHEN NOT FOUND;
               select * into result, error_msg
               from camdecmpswks.delete_calculated_em_data_from_workspace(V_MON_PLAN_ID, V_RPT_PERIOD_ID);
                IF result = 'F' then
                 exit;
                end if;
        END LOOP;

        CLOSE EM_CSR;
    end if;   --vContinue if

   return next; -- Add row to return table.

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
    error_msg :='From update_collateral_em_data_for_qat_changes ' ||' '|| error_msg;

   return next; -- Add row to return table.
END;
$BODY$;