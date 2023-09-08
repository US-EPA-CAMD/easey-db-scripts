-- FUNCTION: camdecmpswks.rpt_em_daily_test_sum(text, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_em_daily_test_sum(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_daily_test_sum(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "systemIdentifier" character varying, "componentIdentifier" character varying, "dailyTestDate" date, "dailyTestHour" numeric, "dailyTestMin" numeric, "testTypeCode" character varying, "testTypeCodeGroup" text, "testTypeCodeDescription" character varying, testresultcode character varying, testresultcodegroup text, testresultcodedescription character varying, calctestresultcode character varying, calctestresultcodegroup text, calctestresultcodedescription character varying, spanscalecode character varying, spanscalecodegroup text, spanscalecodedescription character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE 
    monLocIds character varying[];
	rptperiodid numeric;
BEGIN

	SELECT rpt_period_id 
	INTO rptperiodid
	FROM camdecmpsmd.reporting_period
	WHERE calendar_year = vyear and quarter = vquarter;

    SELECT ARRAY(
        SELECT mon_loc_id
        FROM camdecmpswks.monitor_plan_location
        WHERE mon_plan_id = monplanid 
    ) INTO monLocIds;

    RETURN QUERY
    SELECT
        camdecmpswks.get_config_by_loc_id(dts.mon_loc_id) as "location",
		ms.system_identifier as "systemIdentifier",
		c.component_identifier as "componentIdentifier",
		dts.daily_test_date as "dailyTestDate",
		dts.daily_test_hour as "dailyTestHour",
		dts.daily_test_min as "dailyTestMin",
		
		dts.test_type_cd as "testTypeCode",
		'Test Type Codes' AS "testTypeCodeGroup",
		ttc.test_type_cd_description as "testTypeCodeDescription",
		
		dts.test_result_cd as "testResultCode",
		'Test Result Codes' AS "testResultCodeGroup",
		trc.test_result_cd_description as "testResultCodeDescription",
		
		dts.calc_test_result_cd as "calcTestResultCode",
		'Calc Test Result Codes' AS "calcTestResultCodeGroup",
		trc.test_result_cd_description as "calcTestResultCodeDescription",
		
		dts.span_scale_cd as "spanScaleCode",
		'Span Scale Codes' AS "spanScaleCodeGroup",
		ssc.span_scale_cd_description as "spanScaleCodeDescription"
		
    FROM camdecmpswks.daily_test_summary dts
	left join camdecmpsmd.test_type_code ttc using (test_type_cd)
	left join camdecmpsmd.test_result_code trc on trc.test_result_cd = dts.test_result_cd and trc.test_result_cd = dts.calc_test_result_cd
	left join camdecmpsmd.span_scale_code ssc using(span_scale_cd)
	left join camdecmpswks.monitor_system ms using(mon_sys_id)
	left join camdecmpswks.component c using (component_id)
    WHERE dts.mon_loc_id = ANY (monLocIds) and dts.rpt_period_id = rptperiodid; 
END;
$BODY$;