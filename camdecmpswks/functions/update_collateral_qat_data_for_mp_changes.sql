-- FUNCTION: camdecmpswks.update_collateral_qat_data_for_mp_changes(character varying)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_collateral_qat_data_for_mp_changes(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_collateral_qat_data_for_mp_changes(
	vMonLocId character varying)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare

begin

    error_msg := '';
    result := 'T';

    create temp table tmpTestsStatus (TEST_SUM_ID character varying PRIMARY KEY);
       -- wipe out calculated test data for related tests
       INSERT INTO tmpTestsStatus
            SELECT TT.TEST_SUM_ID FROM (
                SELECT DISTINCT T.TEST_SUM_ID
                FROM camdecmpswks.TEST_SUMMARY T
                WHERE
                    T.MON_LOC_ID = vMonLocId AND
                    T.NEEDS_EVAL_FLG = 'N' ) TT
                LEFT OUTER JOIN camdecmpswks.QA_SUPP_DATA QS ON TT.TEST_SUM_ID = QS.TEST_SUM_ID
                WHERE QS.SUBMISSION_AVAILABILITY_CD IS NULL OR
                    QS.SUBMISSION_AVAILABILITY_CD IN ('GRANTED','REQUIRE');

    ----calling deletion for ID in tmpTestsStatus
    select * into result, error_msg
      from camdecmpswks.Delete_Calculated_QA_Data_from_Workspace();

   return next; -- Add row to return table.

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
    error_msg :='From camdecmpswks.update_collateral_qat_data_for_mp_changes ' ||' '|| error_msg;
	
   return next; -- Add row to return table.
END;
$BODY$;
