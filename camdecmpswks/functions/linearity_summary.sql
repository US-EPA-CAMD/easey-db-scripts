-- FUNCTION: camdecmpswks.linearity_summary(text)

DROP FUNCTION IF EXISTS camdecmpswks.linearity_summary(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.linearity_summary(
	v_test_sum_id text)
    RETURNS TABLE(test_num character varying, gp_ind numeric, test_type_cd character varying, test_reason_cd character varying, test_result_cd character varying, begin_date date, begin_hour numeric, begin_min numeric, end_date date, end_hour numeric, end_min numeric, span_scale_cd character varying, component_type_cd character varying, component_identifier character varying, component_id character varying, lin_sum_id character varying, test_sum_id character varying, mon_loc_id character varying, mean_ref_value numeric, mean_measured_value numeric, percent_error numeric, aps_ind numeric, gas_level_cd character varying, hg_converter_ind numeric, userid character varying, add_date timestamp without time zone, update_date timestamp without time zone) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN	
	return query SELECT ts.TEST_NUM,
		ts.GP_IND,
		ts.TEST_TYPE_CD,
		ts.TEST_REASON_CD, 
		ts.TEST_RESULT_CD,
		ts.BEGIN_DATE, ts.BEGIN_HOUR, ts.BEGIN_MIN, 
		ts.END_DATE, ts.END_HOUR, ts.END_MIN, 
		ts.SPAN_SCALE_CD, 
		c.COMPONENT_TYPE_CD,
		c.COMPONENT_IDENTIFIER,
		ts.COMPONENT_ID,
		ls.LIN_SUM_ID,
		ls.TEST_SUM_ID,
		ts.MON_LOC_ID,
		ls.MEAN_REF_VALUE,
		ls.MEAN_MEASURED_VALUE, 
		ls.PERCENT_ERROR,
		ls.APS_IND,
		ls.GAS_LEVEL_CD, 
		c.HG_CONVERTER_IND,
		ls.USERID, ls.ADD_DATE, ls.UPDATE_DATE
	FROM camdecmpswks.LINEARITY_SUMMARY ls
		INNER JOIN camdecmpswks.TEST_SUMMARY ts on ls.TEST_SUM_ID=ts.TEST_SUM_ID
		LEFT OUTER JOIN camdecmpswks.COMPONENT c ON ts.COMPONENT_ID = c.COMPONENT_ID
	WHERE ts.TEST_TYPE_CD IN ('LINE')
	and ls.TEST_SUM_ID=V_TEST_SUM_ID

	UNION ALL
	SELECT	ts.TEST_NUM,
		ts.GP_IND,
		ts.TEST_TYPE_CD,
		ts.TEST_REASON_CD, 
		ts.TEST_RESULT_CD,
		ts.BEGIN_DATE, ts.BEGIN_HOUR, ts.BEGIN_MIN, 
		ts.END_DATE, ts.END_HOUR, ts.END_MIN, 
		ts.SPAN_SCALE_CD, 
		c.COMPONENT_TYPE_CD,
		c.COMPONENT_IDENTIFIER,
		ts.COMPONENT_ID,
		hts.HG_TEST_SUM_ID as LIN_SUM_ID,
		hts.TEST_SUM_ID,
		ts.MON_LOC_ID,
		hts.MEAN_REF_VALUE,
		hts.MEAN_MEASURED_VALUE, 
		hts.PERCENT_ERROR,
		hts.APS_IND,
		hts.GAS_LEVEL_CD, 
		c.HG_CONVERTER_IND,
		hts.USERID, hts.ADD_DATE, hts.UPDATE_DATE
	FROM camdecmpswks.HG_TEST_SUMMARY hts
		INNER JOIN camdecmpswks.TEST_SUMMARY ts on hts.TEST_SUM_ID=ts.TEST_SUM_ID
		LEFT OUTER JOIN camdecmpswks.COMPONENT c ON ts.COMPONENT_ID = c.COMPONENT_ID
		WHERE ts.TEST_TYPE_CD IN ('HGLINE', 'HGSI3')
		and hts.TEST_SUM_ID=V_TEST_SUM_ID;
	
END;
$BODY$;
