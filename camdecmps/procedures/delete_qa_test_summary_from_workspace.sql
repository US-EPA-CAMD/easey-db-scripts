-- PROCEDURE: camdecmps.delete_qa_test_summary_from_workspace(character varying)

DROP PROCEDURE IF EXISTS camdecmps.delete_qa_test_summary_from_workspace(character varying);

CREATE OR REPLACE PROCEDURE camdecmps.delete_qa_test_summary_from_workspace(
	testsumid character varying)
LANGUAGE 'plpgsql'
AS $BODY$
	
BEGIN
	---------------------------------- DELETE WORKSPACE DATA ---------------------------------------------------
    DELETE FROM camdecmpswks.check_session
    WHERE chk_session_id = (
      SELECT chk_session_id FROM camdecmpswks.test_summary WHERE test_sum_id = testSumId
    );

    DELETE FROM camdecmpswks.test_summary WHERE test_sum_id = testSumId;
END;
$BODY$;
