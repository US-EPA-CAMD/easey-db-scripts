DO $$
DECLARE
    v_sysdate text := '2025-09-10'; -- set to a different date to test behavior on that date
	v_fac_id numeric := null;  -- set to a valid fac_id to test behavior for a single facility
	v_result text := 'T';
	v_error_msg text := '';
BEGIN
    RAISE NOTICE 'v_sysdate: %', v_sysdate;
    RAISE NOTICE 'v_fac_id: %', v_fac_id;

	CALL camdecmpsaux.init_and_close_em_submission_access(v_sysdate, v_fac_id, v_result, v_error_msg);

    RAISE NOTICE 'v_result: %', v_result;
    RAISE NOTICE 'v_error_msg: %', v_error_msg;
END $$;