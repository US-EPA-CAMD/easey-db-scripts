CREATE OR REPLACE FUNCTION camdecmpswks.get_on_off_cal(
    testsumid text,
    gasgrp text,
    caltype text
)
RETURNS TABLE(
    "calType" text,
    "injectionDateHour" character varying,
    "gasCd" character varying(7),
    "referenceValue" numeric,
    "measuredValue" numeric,
    "reportedValue" numeric,
    "reportedAPS" numeric,
    "calcReportedValue" numeric,
    "calcReportedAPS" numeric
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
            %L AS "calType",
            camdecmpswks.format_date_hour(%1$s_%2$I_injection_date, %1$s_%2$I_injection_hour, NULL) AS "injectionDateHour",
            CASE
                WHEN %2$L = %3$L THEN %4$L
                ELSE upscale_gas_level_cd
            END AS "gasCd",
            %1$s_%2$I_ref_value as "referenceValue",
            %1$s_%2$I_measured_value as "measuredValue",
            %1$s_%2$I_cal_error as "reportedValue",
            %1$s_%2$I_aps_ind as "reportedAPS",
            calc_%1$s_%2$I_cal_error as "calcReportedValue",
            calc_%1$s_%2$I_aps_ind as "calcReportedAPS"
        FROM camdecmpswks.on_off_cal
        WHERE test_sum_id = %5$L;
    ', caltype, gasgrp, 'zero', 'ZERO', testsumid);
    RETURN QUERY EXECUTE sqlStatement;
END;
$BODY$;