-- FUNCTION: camdecmpswks.rpt_em_emission_view_summary(text, text, text)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_emission_view_summary(text, text, text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_emission_view_summary(
    monitorPlanId text,
    locationId text,
    reportingPeriodIds text
)

RETURNS TABLE (
    "period_description" varchar,
    "op_hours" NUMERIC,
    "op_time" NUMERIC,
    "heat_input" NUMERIC,
    "so2_mass" NUMERIC,
    "co2_mass" NUMERIC,
    "nox_rate" NUMERIC,
    "nox_mass" NUMERIC
) 
LANGUAGE 'plpgsql'
COST 100
VOLATILE
ROWS 1000

AS $BODY$

DECLARE
    year NUMERIC;
    maxQuarter NUMERIC;
BEGIN
    FOR year IN
        SELECT DISTINCT rp.calendar_year 
        FROM camdecmpsmd.reporting_period rp
        WHERE rp.rpt_period_id IN (SELECT unnest(string_to_array(reportingPeriodIds, ',')::NUMERIC[]))
        ORDER BY rp.calendar_year
    LOOP
        -- Get the last quarter for this year from the passed-in reporting period id list
        SELECT MAX(rp.quarter) INTO maxQuarter
        FROM camdecmpsmd.reporting_period rp
        WHERE rp.calendar_year = year
          AND rp.rpt_period_id IN (SELECT unnest(string_to_array(reportingPeriodIds, ',')::NUMERIC[]));

        RETURN QUERY
        -- get data for current quarter and all previous quarters for the calender year
        SELECT evs.period_description,
               evs.op_hours,
               evs.op_time,
               evs.heat_input,
               evs.so2_mass,
               evs.co2_mass,
               evs.nox_rate,
               evs.nox_mass
        FROM camdecmpswks.emission_view_sumval evs
            JOIN camdecmpsmd.reporting_period rp USING(rpt_period_id)
        WHERE evs.mon_plan_id = monitorPlanId
          AND evs.mon_loc_id = locationId
          AND rp.quarter <= maxQuarter
          AND evs.row_num = 1 -- quarterly reported data
          AND rp.calendar_year = year

        UNION ALL

        -- get ozone season data
        SELECT year || ' Ozone Season' AS period_description,
               evs.op_hours,
               evs.op_time,
               evs.heat_input,
               evs.so2_mass,
               evs.co2_mass,
               evs.nox_rate,
               evs.nox_mass
        FROM camdecmpswks.emission_view_sumval evs
            JOIN camdecmpsmd.reporting_period rp USING(rpt_period_id)
        WHERE evs.mon_plan_id = monitorPlanId
          AND evs.mon_loc_id = locationId
          AND rp.quarter = maxQuarter
          AND evs.row_num = 5 -- ozone season reported data
          AND rp.calendar_year = year

        UNION ALL

        -- get year-to-date data
        SELECT year || ' Year-to-Date' AS period_description,
               evs.op_hours,
               evs.op_time,
               evs.heat_input,
               evs.so2_mass,
               evs.co2_mass,
               evs.nox_rate,
               evs.nox_mass
        FROM camdecmpswks.emission_view_sumval evs
        JOIN camdecmpsmd.reporting_period rp USING(rpt_period_id)
        WHERE evs.mon_plan_id = monitorPlanId
          AND evs.mon_loc_id = locationId
          AND rp.quarter = maxQuarter
          AND evs.row_num = 3 -- year to date reported data
          AND rp.calendar_year = year; 
    END LOOP;
END;
$BODY$;
