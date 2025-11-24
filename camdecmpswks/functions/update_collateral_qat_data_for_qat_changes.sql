-- FUNCTION: camdecmpswks.update_collateral_qat_data_for_qat_changes(character varying)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_collateral_qat_data_for_qat_changes(character varying);

/******************************************************************************************************************************
UPDATE_COLLATERAL_QAT_DATA_FOR_QAT_CHANGES:

    Executes camdecmpswks DELETE_CALCULATED_QA_DATA_FROM_WORKSPACE for collateral QA test reports that depend on an updated 
    (or deleted) QA test when the collateral test is required for submission.

Modifications:

Date        Programmer      Tecket      Change
----------  --------------  ----------  ---------------------------------------------------------------------------------------
2025-11-24  Dwayne Whitten  #6902       Replace unions with union alls since the sub-queries already have distincts.
******************************************************************************************************************************/
CREATE OR REPLACE FUNCTION camdecmpswks.update_collateral_qat_data_for_qat_changes(
	vtestsumid character varying)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare 
    vCount          int;
	vContinue       char(1);
	v_test_ids      character varying[];
	
begin    
    error_msg := '';
    result := 'T';
	vContinue:='Y';

    --Check no test_sum_id or can't submit
    SELECT count(*) into vCount
      FROM camdecmpswks.QA_SUPP_DATA
     WHERE  TEST_SUM_ID = vTestSumId
            AND (
                submission_availability_cd IS NULL OR
                submission_availability_cd = 'GRANTED' OR
                submission_availability_cd = 'REQUIRE'
                );

	if vCount=0 then 
		vContinue:='N';
    end if;
				   
	If vContinue='Y' then
	   	-- wipe out calculated test data for related tests		
				   SELECT array_agg(TT.TEST_SUM_ID) INTO v_test_ids FROM (
							SELECT DISTINCT T.TEST_SUM_ID
							FROM camdecmpswks.TEST_SUMMARY T,
							(SELECT TS.MON_SYS_ID, TS.END_DATE, TS.END_HOUR, TS.END_MIN, TS.TEST_SUM_ID
								FROM camdecmpswks.TEST_SUMMARY TS
									INNER JOIN camdecmpswks.MONITOR_SYSTEM MS ON TS.MON_SYS_ID = MS.MON_SYS_ID
								WHERE TEST_TYPE_CD = 'RATA' AND SYS_TYPE_CD = 'FLOW') T2
							WHERE T.MON_SYS_ID = T2.MON_SYS_ID AND T.TEST_TYPE_CD = 'F2LREF' AND
								(T.END_DATE > T2.END_DATE OR 
								(T.END_DATE = T2.END_DATE AND T.END_HOUR > T2.END_HOUR) OR
								(T.END_DATE = T2.END_DATE AND T.END_HOUR = T2.END_HOUR AND T.END_MIN >= T2.END_MIN)) AND
								T.NEEDS_EVAL_FLG = 'N' AND
								T2.TEST_SUM_ID =vTestSumId
							UNION ALL
                            SELECT DISTINCT T.TEST_SUM_ID
							FROM camdecmpswks.TEST_SUMMARY T, camdecmpsmd.REPORTING_PERIOD R,
							(SELECT TS.MON_SYS_ID, TS.TEST_SUM_ID,
									extract(year from TS.END_DATE) AS CALENDAR_YEAR,
									FLOOR((extract(month from TS.END_DATE) + 2) / 3) AS QUARTER
								FROM camdecmpswks.TEST_SUMMARY TS
									INNER JOIN camdecmpswks.MONITOR_SYSTEM MS ON TS.MON_SYS_ID = MS.MON_SYS_ID
								WHERE TEST_TYPE_CD IN ('RATA', 'F2LREF') AND SYS_TYPE_CD = 'FLOW') T2
							WHERE T.RPT_PERIOD_ID = R.RPT_PERIOD_ID AND
								T.MON_SYS_ID = T2.MON_SYS_ID AND T.TEST_TYPE_CD = 'F2LCHK' AND
								(R.CALENDAR_YEAR > T2.CALENDAR_YEAR OR 
								(R.CALENDAR_YEAR = T2.CALENDAR_YEAR AND R.QUARTER >= T2.QUARTER)) AND
								T.NEEDS_EVAL_FLG = 'N' AND
								T2.TEST_SUM_ID =vTestSumId
							UNION ALL
                            SELECT DISTINCT T.TEST_SUM_ID
							FROM camdecmpswks.TEST_SUMMARY T, camdecmpsmd.REPORTING_PERIOD R,
							(SELECT TS.MON_SYS_ID, TS.TEST_SUM_ID,
									extract(year from TS.END_DATE) AS CALENDAR_YEAR,
									FLOOR((extract(month from TS.END_DATE) + 2) / 3) AS QUARTER
								FROM camdecmpswks.TEST_SUMMARY TS
								WHERE TEST_TYPE_CD = 'FF2LBAS') T2
							WHERE T.RPT_PERIOD_ID = R.RPT_PERIOD_ID AND
								T.MON_SYS_ID = T2.MON_SYS_ID AND T.TEST_TYPE_CD = 'FF2LTST' AND
								(R.CALENDAR_YEAR > T2.CALENDAR_YEAR OR 
								(R.CALENDAR_YEAR = T2.CALENDAR_YEAR AND R.QUARTER >= T2.QUARTER)) AND
								T.NEEDS_EVAL_FLG = 'N' AND
								T2.TEST_SUM_ID =vTestSumId 
							UNION All
                            SELECT DISTINCT T.TEST_SUM_ID
							FROM camdecmpswks.TEST_SUMMARY T
								INNER JOIN camdecmpswks.FUEL_FLOW_TO_LOAD_BASELINE B ON T.TEST_SUM_ID = B.TEST_SUM_ID,
								(SELECT TS.MON_LOC_ID, TS.TEST_SUM_ID, TS.TEST_NUM
									FROM camdecmpswks.TEST_SUMMARY TS
									WHERE TEST_TYPE_CD IN ('FFACC', 'FFACCTT')) T2
							WHERE T.MON_LOC_ID = T2.MON_LOC_ID AND T.TEST_TYPE_CD = 'FF2LBAS' AND
								B.ACCURACY_TEST_NUMBER = T2.TEST_NUM AND
								T.NEEDS_EVAL_FLG = 'N' AND
								T2.TEST_SUM_ID =vTestSumId 
							UNION ALL
                            SELECT DISTINCT T.TEST_SUM_ID
							FROM camdecmpswks.TEST_SUMMARY T
								INNER JOIN camdecmpswks.FUEL_FLOW_TO_LOAD_BASELINE B ON T.TEST_SUM_ID = B.TEST_SUM_ID,
								(SELECT TS.MON_LOC_ID, TS.TEST_SUM_ID, TS.TEST_NUM
									FROM camdecmpswks.TEST_SUMMARY TS
									WHERE TEST_TYPE_CD = 'PEI') T2
							WHERE T.MON_LOC_ID = T2.MON_LOC_ID AND T.TEST_TYPE_CD = 'FF2LBAS' AND
								B.PEI_TEST_NUMBER = T2.TEST_NUM AND
								T.NEEDS_EVAL_FLG = 'N' AND
								T2.TEST_SUM_ID =vTestSumId ) TT
							LEFT OUTER JOIN camdecmpswks.QA_SUPP_DATA QS ON TT.TEST_SUM_ID = QS.TEST_SUM_ID
							WHERE QS.SUBMISSION_AVAILABILITY_CD IS NULL OR
								QS.SUBMISSION_AVAILABILITY_CD IN ('GRANTED','REQUIRE');
            
        -- Call deletion function with array parameter
        IF v_test_ids IS NOT NULL AND array_length(v_test_ids, 1) > 0 THEN
            select * into result, error_msg
              from camdecmpswks.Delete_Calculated_QA_Data_from_Workspace(v_test_ids);
        END IF;			                   

    end if;   --vContinue if
    
   return next; -- Add row to return table.

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
    error_msg :='From update_collateral_qat_data_for_qat_changes ' ||' '|| error_msg;
	
   return next; -- Add row to return table.
END;
$BODY$;
