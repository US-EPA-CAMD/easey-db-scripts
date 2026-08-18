DO $$ 
DECLARE
    errorJson_out json;
    result_out boolean;
BEGIN
    -- Call the procedure and pass the variables
    CALL camddmw.dm_refresh_program_year_dim(errorJson_out, result_out);

	if not result_out then
		RAISE EXCEPTION 'Failure: %: %', result_out, errorJson_out;
	else
		RAISE NOTICE 'Success: %: %', result_out, errorJson_out;
	end if;

exception when others then
	RAISE NOTICE 'Failure: %', SQLERRM;
END $$;