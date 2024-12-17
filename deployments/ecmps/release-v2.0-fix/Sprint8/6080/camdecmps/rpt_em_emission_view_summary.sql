-- FUNCTION: camdecmps.rpt_em_emission_view_summary(text, text, text)

DROP FUNCTION IF EXISTS camdecmps.rpt_em_emission_view_summary(text, text, text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_em_emission_view_summary(
    monitorPlanId text,
    locationId text,
    reportingPeriodIds text
)

RETURNS TABLE (
    "period_description" varchar,
    "row_name" text,
    "op_hours" numeric,
    "op_time" numeric,
    "heat_input" numeric,
    "so2_mass" numeric,
    "co2_mass" numeric,
    "nox_rate" numeric,
    "nox_mass" numeric
)
LANGUAGE 'plpgsql'
COST 100
VOLATILE
ROWS 1000

AS $BODY$
BEGIN

RETURN QUERY
SELECT
    vw.period_description,
    vw.row_name,
    vw.op_hours,
    vw.op_time,
    vw.heat_input,
    vw.so2_mass,
    vw.co2_mass,
    vw.nox_rate,
    vw.nox_mass
FROM camdecmps.emission_view_sumval vw
         INNER JOIN camdecmpsmd.reporting_period rp ON vw.rpt_period_id = rp.rpt_period_id
WHERE vw.mon_plan_id = monitorPlanId
  AND vw.mon_loc_id = locationId
  AND vw.rpt_period_id IN (SELECT unnest(string_to_array(reportingPeriodIds, ',')::numeric[]));
END;
$BODY$;
