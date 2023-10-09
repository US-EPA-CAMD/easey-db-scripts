CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_ae_hi_oil(
	testsumid text)
    RETURNS TABLE("operatingLevelNo" numeric, "runNo" numeric, "sysId" text, "oilMass" numeric,  "oilGCV" numeric, "oilGCVUOM" text, "oilVolume" numeric, "oilVolumeUOM" text, "oilDensity" numeric, "oilDensityUOM" text, "oilHI" numeric, "calculatedOilHI" numeric) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	ts.op_level_num as "operatingLevelNo",
	tr.run_num as "runNo",
	ms.system_identifier as "sysId",
	o.oil_mass as "oilMass",
	o.oil_gcv as "oilGCV",
	o.oil_gcv_uom_cd as "oilGCVUOM",
	o.oil_volume as "oilVolume",
	o.oil_volume_uom_cd as "oilVolumeUOM",
	o.oil_density as "oilDensity",
	o.oil_density_uom_cd as "oilDensityUOM",
	o.oil_hi as "oilHI",
	o.calc_oil_hi as "calculatedOilHI"
	FROM camdecmps.ae_hi_oil o
	join camdecmps.ae_correlation_test_run tr using(ae_corr_test_run_id)
	join camdecmps.ae_correlation_test_sum ts using(ae_corr_test_sum_id)
	join camdecmps.monitor_system ms using(mon_sys_id)
	WHERE test_sum_id = testSumId
	ORDER BY "operatingLevelNo", "runNo", "sysId";
$BODY$;