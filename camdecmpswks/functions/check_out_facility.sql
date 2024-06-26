-- FUNCTION: camdecmpswks.check_out_facility(text, text)
DROP FUNCTION IF EXISTS camdecmpswks.check_out_facility (text, text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.check_out_facility (facid text, username text)
    RETURNS SETOF camdecmpswks.user_check_out
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE ROWS 1000
    AS $BODY$
DECLARE
    fac record;
    rec record;
BEGIN
    -- GET FACILITY --
    SELECT
        fac_id,
        facility_name INTO fac
    FROM
        camd.plant
    WHERE
        fac_id = facid;
    IF EXISTS (
        SELECT
            *
        FROM
            camdecmpswks.user_check_out_new
        WHERE
            fac_id = facid) THEN
    -- GET USER CHECK OUT --
    SELECT
        checked_out_by,
        checked_out_on INTO rec
    FROM
        camdecmpswks.user_check_out_new
    WHERE
        fac_id = facid;
    RAISE EXCEPTION 'Facility % (%) currently checked out by % on %', fac.facility_name, rec.checked_out_by, rec.checked_out_on;
END IF;
    -- CHECK OUT FACILITY --
    INSERT INTO camdecmpswks.user_check_out_new (facility_id, checked_out_on, checked_out_by, last_activity)
        VALUES (fac.fac_id, CURRENT_TIMESTAMP, userName, CURRENT_TIMESTAMP);
    RETURN QUERY
    SELECT
        *
    FROM
        camdecmpswks.user_check_out_new
    WHERE
        fac_id = facid;
END;
$BODY$;

