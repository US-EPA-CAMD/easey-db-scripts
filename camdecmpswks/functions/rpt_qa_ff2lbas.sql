DROP FUNCTION IF EXISTS camdecmpswks.rpt_qa_ffl2bas(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_ffl2bas(
	testsumid text)
    RETURNS TABLE(
		"avgFlowRate" numeric,
		"avgGrossLoad" numeric,
		"baseRatio" numeric,
		"UOM" text,
		"avgHHIP" numeric,
		"baseGrossHeat" numeric,
		"ghrUOM" text,
		"hoursExcludedCo" numeric,
		"hoursExcludedRamp" numeric,
		"hoursExcludedRange" numeric) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	bas.avg_fuel_flow_rate AS "avgFlowRate",
	bas.avg_load AS "avgGrossLoad",
	bas.baseline_fuel_flow_load_ratio AS "baseRatio",
	bas.fuel_flow_load_uom_cd AS "UOM",
	bas.avg_hrly_hi_rate AS "avgHHIP",
	bas.baseline_ghr AS "baseGrossHeat",
	bas.ghr_uom_cd AS "ghrUOM",
	bas.nhe_cofiring AS "hoursExcludedCo",
	bas.nhe_ramping AS "hoursExcludedRamp",
	bas.nhe_low_range AS "hoursExcludedRange"
	FROM camdecmpswks.fuel_flow_to_load_baseline bas
	WHERE bas.test_sum_id = testSumId;
$BODY$;