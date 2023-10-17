DROP FUNCTION IF EXISTS camdecmpswks.rpt_qa_rata_supp(text,text);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_rata_supp(
	testsumid text,
	oplevelcd text)
    RETURNS TABLE(
	"co2Method" text,
	"stackDiameter" numeric ,
	"noTraverse" numeric,
	"defaultWaf" numeric,
	"stackArea" numeric,
	"calcStackArea" numeric,
	"calcWaf" numeric,
	"calcCalcWaf" numeric
	) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	rs.co2_o2_ref_method_cd as "co2Method",
	rs.stack_diameter as "stackDiameter",
	rs.num_traverse_point as "noTraverse",
	rs.default_waf as "defaultWaf",
	rs.stack_area as "stackArea",
	rs.calc_stack_area as "calcStackArea",
	rs.calc_waf as "calcWaf",
	rs.calc_calc_waf as "calcCalcWaf"
	FROM camdecmpswks.rata_summary rs
	JOIN camdecmpswks.rata r USING(rata_id)
	WHERE r.test_sum_id = testSumId
	AND rs.op_level_cd = oplevelcd;
$BODY$;