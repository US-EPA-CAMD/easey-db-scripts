DROP FUNCTION IF EXISTS camdecmpswks.get_on_off_cal_statistic(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.get_on_off_cal_statistic(
    testsumid text
)
RETURNS TABLE(
    "calType" text,
    "injectionDateHour" character varying,
    "gasCd" character varying(7),
    "pctDiff" numeric,
    "referenceValue" numeric,
    "measuredValue" numeric,
    "reportedValue" numeric,
    "reportedAPS" numeric,
    "calcReportedValue" numeric,
    "calcReportedAPS" numeric) 
LANGUAGE 'plpgsql'
COST 100
VOLATILE 
ROWS 1000
AS $BODY$
BEGIN
    RETURN QUERY (
        SELECT * FROM camdecmpswks.get_on_off_cal(testsumid, 'zero', 'online')
        UNION
        SELECT * FROM camdecmpswks.get_on_off_cal(testsumid, 'upscale', 'online')
        UNION 
        SELECT * FROM camdecmpswks.get_on_off_cal(testsumid, 'zero', 'offline')
        UNION
        SELECT * FROM camdecmpswks.get_on_off_cal(testsumid, 'upscale', 'offline')
		ORDER BY "calType" DESC, "gasCd" DESC
    );
END;
$BODY$;
