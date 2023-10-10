CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_ae_hi_gas(
	testsumid text)
    RETURNS TABLE("operatingLevelNo" numeric, "runNo" numeric, "sysId" text, "gasGCV" numeric, "gasVolume" numeric, "gasHI" numeric, "calculatedGasHI" numeric) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	ts.op_level_num as "operatingLevelNo",
	tr.run_num as "runNo",
	ms.system_identifier as "sysId",
	g.gas_gcv as "gasGCV",
	g.gas_volume as "gasVolume",
	g.gas_hi as "gasHI",
	g.calc_gas_hi as "calculatedGasHI"
	FROM camdecmps.ae_hi_gas g
	join camdecmps.ae_correlation_test_run tr using(ae_corr_test_run_id)
	join camdecmps.ae_correlation_test_sum ts using(ae_corr_test_sum_id)
	join camdecmps.monitor_system ms using(mon_sys_id)
	WHERE test_sum_id = testSumId
	ORDER BY "operatingLevelNo", "runNo", "sysId";
$BODY$;