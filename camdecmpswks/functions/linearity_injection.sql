-- FUNCTION: camdecmpswks.linearity_injection(text)

-- DROP FUNCTION camdecmpswks.linearity_injection(text);

CREATE OR REPLACE FUNCTION camdecmpswks.linearity_injection(
	v_test_sum_id text)
    RETURNS TABLE(lin_inj_id character varying, lin_sum_id character varying, injection_date date, injection_hour numeric, injection_min numeric, measured_value numeric, ref_value numeric, userid character varying, add_date timestamp without time zone, update_date timestamp without time zone, test_num character varying, gp_ind numeric, test_reason_cd character varying, test_result_cd character varying, begin_date date, begin_hour numeric, begin_min numeric, end_date date, end_hour numeric, end_min numeric, span_scale_cd character varying, component_type_cd character varying, component_identifier character varying, gas_level_cd character varying, test_sum_id character varying, mon_loc_id character varying, component_id character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN	
	SELECT	li.LIN_INJ_ID,
		li.LIN_SUM_ID, 
		li.INJECTION_DATE, 
		li.INJECTION_HOUR,
		li.INJECTION_MIN,
		li.MEASURED_VALUE, 
		li.REF_VALUE,
		li.USERID, li.ADD_DATE, li.UPDATE_DATE,
		ts.TEST_NUM,
		ts.GP_IND, 
		ts.TEST_REASON_CD,
		ts.TEST_RESULT_CD, 
		ts.BEGIN_DATE, ts.BEGIN_HOUR, ts.BEGIN_MIN, 
		ts.END_DATE, ts.END_HOUR, ts.END_MIN, 
		ts.SPAN_SCALE_CD,
		c.COMPONENT_TYPE_CD,
		c.COMPONENT_IDENTIFIER,
		ls.GAS_LEVEL_CD, 
		ts.TEST_SUM_ID,
		ts.MON_LOC_ID,
		ts.COMPONENT_ID
	FROM camdecmpswks.LINEARITY_INJECTION li
		INNER JOIN camdecmpswks.LINEARITY_SUMMARY ls on ls.LIN_SUM_ID = li.LIN_SUM_ID
		INNER JOIN camdecmpswks.TEST_SUMMARY ts on ls.TEST_SUM_ID = ts.TEST_SUM_ID
		LEFT OUTER JOIN camdecmpswks.COMPONENT c ON ts.COMPONENT_ID = c.COMPONENT_ID
	WHERE ts.TEST_SUM_ID=V_TEST_SUM_ID
UNION
SELECT	hli.HG_TEST_INJ_ID as LIN_INJ_ID,
		hli.HG_TEST_SUM_ID as LIN_SUM_ID, 
		hli.INJECTION_DATE, 
		hli.INJECTION_HOUR,
		hli.INJECTION_MIN,
		hli.MEASURED_VALUE, 
		hli.REF_VALUE,
		hli.USERID, hli.ADD_DATE, hli.UPDATE_DATE,
		ts.TEST_NUM,
		ts.GP_IND, 
		ts.TEST_REASON_CD,
		ts.TEST_RESULT_CD, 
		ts.BEGIN_DATE, ts.BEGIN_HOUR, ts.BEGIN_MIN, 
		ts.END_DATE, ts.END_HOUR, ts.END_MIN, 
		ts.SPAN_SCALE_CD,
		c.COMPONENT_TYPE_CD,
		c.COMPONENT_IDENTIFIER,
		hgt.GAS_LEVEL_CD, 
		ts.TEST_SUM_ID,
		ts.MON_LOC_ID,
		ts.COMPONENT_ID
	FROM camdecmpswks.HG_TEST_INJECTION hli
		INNER JOIN camdecmpswks.HG_TEST_SUMMARY hgt on hli.HG_TEST_SUM_ID=hgt.HG_TEST_SUM_ID
		INNER JOIN  camdecmpswks.TEST_SUMMARY ts on hgt.TEST_SUM_ID = ts.TEST_SUM_ID
		LEFT OUTER JOIN camdecmpswks.COMPONENT c ON ts.COMPONENT_ID = c.COMPONENT_ID
	WHERE ts.TEST_SUM_ID=V_TEST_SUM_ID;
	
END;
$BODY$;
