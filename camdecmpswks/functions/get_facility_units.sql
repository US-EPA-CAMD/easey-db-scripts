-- FUNCTION: camdecmpswks.get_facility_units(integer[])

DROP FUNCTION IF EXISTS camdecmpswks.get_facility_units (integer[]) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.get_facility_units (oriscodes integer[])
    RETURNS SETOF numeric
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE ROWS 1000
    AS $BODY$
BEGIN
    RETURN query
    SELECT
        unit_id
    FROM
        camd.plant
        JOIN camd.unit USING (fac_id)
    WHERE
        oris_code = ANY (orisCodes);
END;
$BODY$;

