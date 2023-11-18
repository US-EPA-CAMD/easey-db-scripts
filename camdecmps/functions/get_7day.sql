DROP FUNCTION IF EXISTS camdecmps.get_7day(text,text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.get_7day(
    testsumid text,
    gasgrp text
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
    "hour" numeric
) 
LANGUAGE 'plpgsql'
COST 100
VOLATILE 
ROWS 1000
AS $BODY$
DECLARE
    sqlStatement text;
BEGIN
    sqlStatement := format('
        SELECT
            camdecmps.format_date_hour(%1$s_injection_date, %1$s_injection_hour, NULL) AS "injectionDateHour",
            CASE
                WHEN %1$L = %2$L THEN %3$L
                ELSE upscale_gas_level_cd
            END AS "gasCd",
            CASE 
                WHEN %1$I_ref_value = 0 OR ts.CALC_SPAN_VALUE = 0 OR %1$I_ref_value is null OR ts.CALC_SPAN_VALUE is null THEN null
                ELSE ROUND(%1$I_ref_value*100/ts.CALC_SPAN_VALUE, 2)
            END AS "pctDiff",
            %1$I_ref_value as "referenceValue",
            %1$I_measured_value as "measuredValue",
            %1$I_cal_error as "reportedValue",
            %1$I_aps_ind as "reportedAPS",
            calc_%1$I_cal_error as "calcReportedValue",
            calc_%1$I_aps_ind as "calcReportedAPS",
            %1$s_injection_date as "date",
            %1$s_injection_hour as "hour"
        FROM camdecmps.calibration_injection
        JOIN camdecmps.test_summary ts USING(test_sum_id)
        WHERE test_sum_id = %4$L;
    ',gasgrp, 'zero', 'ZERO', testsumid);
    RETURN QUERY EXECUTE sqlStatement;
END;
$BODY$;