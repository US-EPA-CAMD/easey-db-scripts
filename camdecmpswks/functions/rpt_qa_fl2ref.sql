CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_fl2ref(
	testsumid text)
    RETURNS TABLE(
	"rataTestNumRef" text,
	"refRataEndDate" text,
	"averageGrossUnitLoad" numeric,
	"opLevelCode" text,
	"avgRefFlowRate" numeric,
	"refFlowLoadRatio" numeric,
	"avgHrlyHiRate" numeric,
	"refGHR" numeric,
	"sepRefInd" numeric) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	ftl.rata_test_num as "rataTestNumRef",
	TO_CHAR(d.end_date, 'YYYY-MM-DD') as "refRataEndDate",
	ftl.avg_gross_unit_load as "averageGrossUnitLoad",
	ftl.op_level_cd as "opLevelCode",
	ftl.avg_ref_method_flow as "avgRefFlowRate",
	ftl.ref_flow_load_ratio as "refFlowLoadRatio",
	ftl.avg_hrly_hi_rate as "avgHrlyHiRate",
	ftl.ref_ghr as "refGHR",
	ftl.calc_sep_ref_ind as "sepRefInd"
FROM camdecmpswks.flow_to_load_reference ftl
JOIN camdecmpswks.test_summary ts using(test_sum_id)
JOIN (
	select mon_loc_id, test_num, end_date
	from camdecmpswks.test_summary
	where test_type_cd = 'RATA'
) d ON ts.mon_loc_id = d.mon_loc_id and ts.test_num = d.test_num
WHERE test_sum_id = 'DC07381-2019CF9F19454F2C97871C062EB918D0'
ORDER BY "rataTestNumRef";
$BODY$;