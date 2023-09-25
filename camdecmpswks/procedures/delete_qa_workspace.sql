-- PROCEDURE: camdecmpswks.delete_qa_workspace()

DROP PROCEDURE IF EXISTS camdecmpswks.delete_qa_workspace();

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_qa_workspace(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	TRUNCATE TABLE camdecmpswks.qa_supp_data CASCADE;
	TRUNCATE TABLE camdecmpswks.test_summary CASCADE;
	TRUNCATE TABLE camdecmpswks.qa_cert_event CASCADE;
	TRUNCATE TABLE camdecmpswks.test_extension_exemption CASCADE;
END;
$BODY$;
