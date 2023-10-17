DROP FUNCTION IF EXISTS camdecmps.get_7day_statistics(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.get_7day_statistics(
    testsumid text
)
RETURNS TABLE(
    "injectionDateHour" character varying,
    "gasCd" character varying(7),
    "pctDiff" numeric,
    "referenceValue" numeric,
    "measuredValue" numeric,
    "reportedValue" numeric,
    "reportedAPS" numeric,
    "calcReportedValue" numeric,
    "calcReportedAPS" numeric,
    "date" date,
    "hour" numeric) 
LANGUAGE 'plpgsql'
COST 100
VOLATILE 
ROWS 1000
AS $BODY$
BEGIN
    RETURN QUERY (
        SELECT * FROM camdecmps.get_7day(testsumid, 'zero')
        UNION
        SELECT * FROM camdecmps.get_7day(testsumid, 'upscale')
		ORDER BY "date", "hour", "gasCd" DESC
    );
END;
$BODY$;
