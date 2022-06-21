-- PROCEDURE: camdecmpswks.delete_qa_workspace()

-- DROP PROCEDURE camdecmpswks.delete_qa_workspace();

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_qa_workspace(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	-- QA_SUPP_DATA --
	TRUNCATE TABLE camdecmpswks.qa_supp_data CASCADE;

	-- TEST_SUMMARY --
	TRUNCATE TABLE camdecmpswks.test_summary CASCADE;

	-- QA_CERT_EVENT --
	TRUNCATE TABLE camdecmpswks.qa_cert_event CASCADE;

	-- TEST_EXTENSION_EXEMPTION --
	TRUNCATE TABLE camdecmpswks.test_extension_exemption CASCADE;
END;
$BODY$;
