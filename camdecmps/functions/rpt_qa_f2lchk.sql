DROP FUNCTION IF EXISTS camdecmps.rpt_qa_fl2chk(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_fl2chk(
	testsumid text)
    RETURNS TABLE("opLevel" text,
					"testBasis" text,
					"pctDiff" numeric,
					"adjFlowInd" numeric,
					"hoursUsed" numeric,
					"diffFuel" numeric,
					"loadRamping" numeric,
					"scrubberBypass" numeric,
					"preFlowRata" numeric,
					"preDiagTest" numeric,
					"multiStackDischarge" numeric) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
		chk.op_level_cd AS "opLevel",
		chk.test_basis_cd AS "testBasis",
		chk.avg_abs_pct_diff AS "pctDiff",
		chk.bias_adjusted_ind AS "adjFlowInd",
		chk.num_hrs AS "hoursUsed",	
		chk.nhe_fuel AS "diffFuel",
		chk.nhe_ramping AS "loadRamping",
		chk.nhe_bypass AS "scrubberBypass",
		chk.nhe_pre_rata AS "preFlowRata",
		chk.nhe_test AS "preDiagTest",
		chk.nhe_main_bypass AS "multiStackDischarge"
	FROM camdecmps.flow_to_load_check chk
	WHERE chk.test_sum_id = testSumId;
$BODY$;