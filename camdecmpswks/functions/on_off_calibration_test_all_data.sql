CREATE OR REPLACE FUNCTION camdecmpswks.on_off_calibration_test_all_data(
	monplanid character varying)
    RETURNS TABLE(oris_code numeric, location_name character varying, component_type_cd character varying, component_identifier character varying, test_num character varying, test_reason_cd character varying, test_result_cd character varying, begin_date date, begin_hour numeric, begin_min numeric, begin_datetime timestamp without time zone, end_date date, end_hour numeric, end_min numeric, end_datetime timestamp without time zone, span_scale_cd character varying, acq_cd character varying, online_zero_injection_date date, online_zero_injection_hour numeric, on_off_cal_id character varying, online_zero_measured_value numeric, online_zero_ref_value numeric, online_zero_cal_error numeric, online_zero_aps_ind numeric, offline_zero_injection_date date, offline_zero_injection_hour numeric, offline_zero_measured_value numeric, offline_zero_ref_value numeric, offline_zero_cal_error numeric, offline_zero_aps_ind numeric, upscale_gas_level_cd character varying, online_upscale_injection_date date, online_upscale_injection_hour numeric, online_upscale_measured_value numeric, online_upscale_ref_value numeric, online_upscale_cal_error numeric, online_upscale_aps_ind numeric, offline_upscale_injection_date date, offline_upscale_injection_hour numeric, offline_upscale_measured_value numeric, offline_upscale_ref_value numeric, offline_upscale_cal_error numeric, offline_upscale_aps_ind numeric, mon_plan_id character varying, mon_loc_id character varying, test_sum_id character varying, component_id character varying, fac_id numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
 RETURN QUERY
SELECT	 fac.ORIS_CODE,
         COALESCE(stp.STACK_NAME, unt.UNITID) LOCATION_NAME,
		   cmp.COMPONENT_TYPE_CD, 
			cmp.COMPONENT_IDENTIFIER, 
			tst.TEST_NUM, 
			tst.TEST_REASON_CD, 
			tst.TEST_RESULT_CD, 
			tst.BEGIN_DATE, 
			tst.BEGIN_HOUR, 
			tst.BEGIN_MIN,
			camdecmpswks.Format_Date_Time(tst.BEGIN_DATE, tst.BEGIN_HOUR, tst.BEGIN_MIN) BEGIN_DATETIME, 
			tst.END_DATE, 
			tst.END_HOUR, 
			tst.END_MIN, 
			camdecmpswks.Format_Date_Time(tst.END_DATE, tst.END_HOUR, tst.END_MIN) END_DATETIME,
			tst.SPAN_SCALE AS SPAN_SCALE_CD, 
			cmp.ACQ_CD,
			ooc.ONLINE_ZERO_INJECTION_DATE, 
			ooc.ONLINE_ZERO_INJECTION_HOUR, 
			ooc.ON_OFF_CAL_ID,
			ooc.ONLINE_ZERO_MEASURED_VALUE, 
			ooc.ONLINE_ZERO_REF_VALUE, 
			ooc.ONLINE_ZERO_CAL_ERROR, 
			ooc.ONLINE_ZERO_APS_IND,
			ooc.OFFLINE_ZERO_INJECTION_DATE, 
			ooc.OFFLINE_ZERO_INJECTION_HOUR, 
			ooc.OFFLINE_ZERO_MEASURED_VALUE, 
			ooc.OFFLINE_ZERO_REF_VALUE, 
			ooc.OFFLINE_ZERO_CAL_ERROR, 
			ooc.OFFLINE_ZERO_APS_IND,
			ooc.UPSCALE_GAS_LEVEL_CD, 
			ooc.ONLINE_UPSCALE_INJECTION_DATE, 
			ooc.ONLINE_UPSCALE_INJECTION_HOUR, 
			ooc.ONLINE_UPSCALE_MEASURED_VALUE, 
			ooc.ONLINE_UPSCALE_REF_VALUE, 
			ooc.ONLINE_UPSCALE_CAL_ERROR, 
			ooc.ONLINE_UPSCALE_APS_IND,
			ooc.OFFLINE_UPSCALE_INJECTION_DATE, 
			ooc.OFFLINE_UPSCALE_INJECTION_HOUR, 
			ooc.OFFLINE_UPSCALE_MEASURED_VALUE, 
			ooc.OFFLINE_UPSCALE_REF_VALUE, 
			ooc.OFFLINE_UPSCALE_CAL_ERROR, 
			ooc.OFFLINE_UPSCALE_APS_IND, 
			mpl.MON_PLAN_ID,
			tst.MON_LOC_ID,
			tst.TEST_SUM_ID, 
			tst.COMPONENT_ID, 
			fac.FAC_ID
		FROM	(SELECT monPlanid MON_PLAN_ID) lst
				INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl ON mpl.MON_PLAN_ID = lst.MON_PLAN_ID
				INNER JOIN camdecmpswks.MONITOR_LOCATION loc ON loc.MON_LOC_ID = mpl.MON_LOC_ID
				LEFT OUTER JOIN CAMD.UNIT unt	ON unt.UNIT_ID = loc.UNIT_ID
				LEFT OUTER JOIN camdecmpswks.STACK_PIPE stp ON stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
				INNER JOIN CAMD.PLANT fac ON fac.FAC_ID IN (unt.FAC_ID, stp.FAC_ID)
				INNER JOIN camdecmpswks.QA_SUPP_DATA tst ON tst.MON_LOC_ID = mpl.MON_LOC_ID
				LEFT OUTER JOIN camdecmpswks.COMPONENT cmp ON cmp.COMPONENT_ID = tst.COMPONENT_ID
				LEFT OUTER JOIN camdecmpswks.ON_OFF_CAL ooc  ON ooc.TEST_SUM_ID = tst.TEST_SUM_ID
		WHERE	tst.TEST_TYPE_CD = 'ONOFF';

END;
$BODY$;