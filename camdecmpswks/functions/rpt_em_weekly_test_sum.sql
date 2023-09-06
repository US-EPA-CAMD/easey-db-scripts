-- FUNCTION: camdecmpswks.rpt_em_weekly_test_sum(text, numeric, numeric)

-- DROP FUNCTION camdecmpswks.rpt_em_weekly_test_sum(text, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_em_weekly_test_sum(
	monplanid text,
	vyear numeric,
	vquarter numeric)
    RETURNS TABLE(location character varying, "systemIdentifier" character varying, "componentIdentifier" character varying, "testDate" date, "testHour" numeric, "testMin" numeric, "testTypeCode" character varying, "testTypeCodeGroup" text, "testTypeCodeDescription" character varying, "testResultCode" character varying, "testResultCodeGroup" text, "testResultCodeDescription" character varying, "calcTestResultCode" character varying, "calcTestResultCodeGroup" text, "calcTestResultCodeDescription" character varying, "spanScaleCode" character varying, "spanScaleCodeGroup" text, "spanScaleCodeDescription" character varying) 
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
        camdecmpswks.get_config_by_loc_id(wts.mon_loc_id) as "location",
		ms.system_identifier as "systemIdentifier",
		c.component_identifier as "componentIdentifier",
		wts.test_date as "testDate",
		wts.test_hour as "testHour",
		wts.test_min as "testMin",
		
		wts.test_type_cd as "testTypeCode",
		'Test Type Codes' AS "testTypeCodeGroup",
		ttc.test_type_cd_description as "testTypeCodeDescription",
		
		wts.test_result_cd as "testResultCode",
		'Test Result Codes' AS "testResultCodeGroup",
		trc.test_result_cd_description as "testResultCodeDescription",
		
		wts.calc_test_result_cd as "calcTestResultCode",
		'Calc Test Result Codes' AS "calcTestResultCodeGroup",
		trc.test_result_cd_description as "calcTestResultCodeDescription",
		
		wts.span_scale_cd as "spanScaleCode",
		'Span Scale Codes' AS "spanScaleCodeGroup",
		ssc.span_scale_cd_description as "spanScaleCodeDescription"
		
    FROM camdecmpswks.weekly_test_summary wts
	left join camdecmpsmd.test_type_code ttc using (test_type_cd)
	left join camdecmpsmd.test_result_code trc using (test_result_cd)
	left join camdecmpsmd.span_scale_code ssc using(span_scale_cd)
	left join camdecmpswks.monitor_system ms using(mon_sys_id)
	left join camdecmpswks.component c using (component_id)
	WHERE wts.mon_loc_id = ANY (monLocIds) and wts.rpt_period_id = rptperiodid; 
END;
$BODY$;

ALTER FUNCTION camdecmpswks.rpt_em_weekly_test_sum(text, numeric, numeric)
    OWNER TO "uImcwuf4K9dyaxeL";
