DROP FUNCTION IF EXISTS camdecmpswks.rpt_qa_rata_flow_run(text,text);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_rata_flow_run(
	testsumid text,
	oplevelcd text)
    RETURNS TABLE(
		"runNum" numeric,
		"noTrav" numeric,
		"barPressure" numeric,
		"staticPressure" numeric,
		"pctCO2" numeric,
		"pctO2" numeric,
		"pctH2O" numeric,
		"dryRep" numeric,
		"dryCalc" numeric,
		"wetRep" numeric,
		"wetCalc" numeric,
		"unadjRep" numeric,
		"unadjCalc" numeric,
		"avgRep" numeric,
		"avgRepCalc" numeric,
		"calcWafRep" numeric,
		"calcWafCal" numeric,
		"avgFlow" numeric
		) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	rr.run_num as "runNum",
	frr.num_traverse_point as "noTrav",
	frr.barometric_pressure as "barPressure",
	frr.static_stack_pressure as "staticPressure",
	frr.percent_co2 as "pctCO2",
	frr.percent_o2 as "pctO2",
	frr.percent_moisture as "pctH2O",
	frr.dry_molecular_weight as "dryRep",
	frr.calc_dry_molecular_weight as "dryCalc",
	frr.wet_molecular_weight as "wetRep",
	frr.calc_wet_molecular_weight as "wetCalc",
	frr.avg_vel_wo_wall as "unadjRep",
	frr.calc_avg_vel_wo_wall as "unadjCalc",
	frr.avg_vel_w_wall as "avgRep",
	frr.calc_avg_vel_w_wall as "avgRepCalc",
	frr.calc_waf as "calcWafRep",
	frr.calc_calc_waf as "calcWafCal",
	frr.avg_stack_flow_rate "avgFlow"
	FROM camdecmpswks.flow_rata_run frr
	join camdecmpswks.rata_run rr using(rata_run_id)
	join camdecmpswks.rata_summary rs using(rata_sum_id)
	join camdecmpswks.rata r using(rata_id)
	WHERE test_sum_id = testSumId
	AND rs.op_level_cd = oplevelcd
	ORDER BY "runNum";
$BODY$;