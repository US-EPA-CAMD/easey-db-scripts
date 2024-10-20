DROP FUNCTION IF EXISTS camdecmps.rpt_qa_rata_supp(text,text);

CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_rata_supp(
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
	FROM camdecmps.rata_summary rs
	JOIN camdecmps.rata r USING(rata_id)
	WHERE r.test_sum_id = testSumId
	AND rs.op_level_cd = oplevelcd
	AND (
		rs.co2_o2_ref_method_cd is not null OR 
		rs.stack_diameter is not null OR 
		rs.num_traverse_point is not null OR 
		rs.default_waf is not null OR
		rs.stack_area is not null OR 
		rs.calc_stack_area is not null OR 
		rs.calc_waf is not null OR  
		rs.calc_calc_waf is not null
	);
$BODY$;