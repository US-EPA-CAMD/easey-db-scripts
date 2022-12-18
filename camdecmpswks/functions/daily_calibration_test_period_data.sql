-- FUNCTION: camdecmpswks.daily_calibration_test_period_data(character varying, date, date)

-- DROP FUNCTION camdecmpswks.daily_calibration_test_period_data(character varying, date, date);

CREATE OR REPLACE FUNCTION camdecmpswks.daily_calibration_test_period_data(
	monplanid character varying,
	evalperiodbegandate date,
	evalperiodendeddate date)
    RETURNS TABLE(mon_plan_id character varying, mon_loc_id character varying, rpt_period_id numeric, oris_code numeric, location_name character varying, calendar_year numeric, quarter numeric, component_id character varying, mon_sys_id character varying, component_type_cd character varying, component_identifier character varying, acq_cd character varying, test_type_cd character varying, test_result_cd character varying, span_scale_cd character varying, daily_test_date date, daily_test_hour numeric, daily_test_min numeric, daily_test_datetime timestamp without time zone, daily_test_datehour timestamp without time zone, online_offline_ind numeric, upscale_gas_level_cd character varying, upscale_injection_date date, upscale_injection_hour numeric, upscale_injection_min numeric, upscale_injection_datetime timestamp without time zone, upscale_measured_value numeric, upscale_ref_value numeric, upscale_cal_error numeric, upscale_aps_ind numeric, upscale_op_time numeric, zero_injection_date date, zero_injection_hour numeric, zero_injection_min numeric, zero_injection_datetime timestamp without time zone, zero_measured_value numeric, zero_ref_value numeric, zero_cal_error numeric, zero_aps_ind numeric, zero_op_time numeric, system_identifier character varying, first_test_date date, first_test_hour numeric, first_test_min numeric, first_test_datetime timestamp without time zone, fac_id numeric, cal_inj_id character varying, daily_test_sum_id character varying, formatted_test_date text, overlap_exists integer, upscale_gas_type_cd character varying, vendor_id character varying, cylinder_id character varying, expiration_date date) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
   RETURN QUERY
   select	mpl.MON_PLAN_ID, 
			dts.MON_LOC_ID,  
			dts.RPT_PERIOD_ID, 
			fac.ORIS_CODE,  
			case
				when loc.UNIT_ID is not null then unt.UNITID 
				 when loc.STACK_PIPE_ID is not null then stp.STACK_NAME else null
			end LOCATION_NAME,  
			rpp.CALENDAR_YEAR,  
			rpp.QUARTER, 
			dts.COMPONENT_ID, 
			dts.MON_SYS_ID, 
			cmp.COMPONENT_TYPE_CD,  
			cmp.COMPONENT_IDENTIFIER,  
			cmp.ACQ_CD, 
			dts.TEST_TYPE_CD,  
			dts.TEST_RESULT_CD,  
			dts.SPAN_SCALE_CD,  
			dts.DAILY_TEST_DATE, 
			dts.DAILY_TEST_HOUR,  
			dts.DAILY_TEST_MIN,  
camdecmpswks.Format_Date_Time(dts.DAILY_TEST_DATE, dts.DAILY_TEST_HOUR, dts.DAILY_TEST_MIN) DAILY_TEST_DATETIME,
camdecmpswks.Format_Date_Time(dts.DAILY_TEST_DATE, dts.DAILY_TEST_HOUR, 0) DAILY_TEST_DATEHOUR,
			dcl.ONLINE_OFFLINE_IND, 
			dcl.UPSCALE_GAS_LEVEL_CD, 
			dcl.UPSCALE_INJECTION_DATE,  
			dcl.UPSCALE_INJECTION_HOUR, 
			dcl.UPSCALE_INJECTION_MIN,
camdecmpswks.Format_Date_Time(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, dcl.UPSCALE_INJECTION_MIN) UPSCALE_INJECTION_DATETIME,
			dcl.UPSCALE_MEASURED_VALUE,  
			dcl.UPSCALE_REF_VALUE, 
			dcl.UPSCALE_CAL_ERROR,  
			dcl.UPSCALE_APS_IND,  
			MAX(uop.OP_TIME) UPSCALE_OP_TIME,
			dcl.ZERO_INJECTION_DATE, 
			dcl.ZERO_INJECTION_HOUR,  
			dcl.ZERO_INJECTION_MIN,  
camdecmpswks.Format_Date_Time(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, dcl.ZERO_INJECTION_MIN) ZERO_INJECTION_DATETIME,
			dcl.ZERO_MEASURED_VALUE, 
			dcl.ZERO_REF_VALUE,  
			dcl.ZERO_CAL_ERROR,  
			dcl.ZERO_APS_IND,  
			MAX(zop.OP_TIME) ZERO_OP_TIME, 
			sys.SYSTEM_IDENTIFIER,
			-- The following four columns display the First Test date and time information
			--
			-- If the zero or upscale injection date/time information exist and are valid, use the earlier of the two sets of information.
			-- If one exists and is valid, use that date and time information.
			-- If neither exist and are valid, use the Daily Test date and time information.
			CASE
				WHEN (camdecmpswks.check_date_hour(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, 0) = 1) AND
				     (camdecmpswks.check_date_hour(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, 0) = 1) THEN
					CASE
						WHEN camdecmpswks.format_date_time(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, dcl.UPSCALE_INJECTION_MIN)
						     < camdecmpswks.format_date_time(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, dcl.ZERO_INJECTION_MIN)
							THEN dcl.UPSCALE_INJECTION_DATE
						ELSE dcl.ZERO_INJECTION_DATE
					END
				WHEN (camdecmpswks.check_date_hour(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, 0) = 1) AND
				     (camdecmpswks.check_date_hour(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, 0) = 0)
					THEN dcl.UPSCALE_INJECTION_DATE
				WHEN (camdecmpswks.check_date_hour(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, 0) = 0) AND
				     (camdecmpswks.check_date_hour(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, 0) = 1)
					THEN dcl.ZERO_INJECTION_DATE
				ELSE dts.DAILY_TEST_DATE
			END FIRST_TEST_DATE,
			CASE
				WHEN (camdecmpswks.check_date_hour(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, 0) = 1) AND
				     (camdecmpswks.check_date_hour(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, 0) = 1) THEN
					CASE
						WHEN camdecmpswks.format_date_time(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, dcl.UPSCALE_INJECTION_MIN)
						     < camdecmpswks.format_date_time(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, dcl.ZERO_INJECTION_MIN)
							THEN dcl.UPSCALE_INJECTION_HOUR
						ELSE dcl.ZERO_INJECTION_HOUR
					END
				WHEN (camdecmpswks.check_date_hour(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, 0) = 1) AND
				     (camdecmpswks.check_date_hour(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, 0) = 0)
					THEN dcl.UPSCALE_INJECTION_HOUR
				WHEN (camdecmpswks.check_date_hour(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, 0) = 0) AND
				     (camdecmpswks.check_date_hour(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, 0) = 1)
					THEN dcl.ZERO_INJECTION_HOUR
				ELSE dts.DAILY_TEST_HOUR
			END FIRST_TEST_HOUR,
			CASE
				WHEN (camdecmpswks.check_date_hour(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, 0) = 1) AND
				     (camdecmpswks.check_date_hour(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, 0) = 1) THEN
					CASE
						WHEN camdecmpswks.format_date_time(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, dcl.UPSCALE_INJECTION_MIN)
						     < camdecmpswks.format_date_time(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, dcl.ZERO_INJECTION_MIN)
							THEN dcl.UPSCALE_INJECTION_MIN
						ELSE dcl.ZERO_INJECTION_MIN
					END
				WHEN (camdecmpswks.check_date_hour(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, 0) = 1) AND
				     (camdecmpswks.check_date_hour(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, 0) = 0)
					THEN dcl.UPSCALE_INJECTION_MIN
				WHEN (camdecmpswks.check_date_hour(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, 0) = 0) AND
				     (camdecmpswks.check_date_hour(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, 0) = 1)
					THEN dcl.ZERO_INJECTION_MIN
				ELSE dts.DAILY_TEST_MIN
			END FIRST_TEST_MIN,
			CASE
				WHEN (camdecmpswks.check_date_hour(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, 0) = 1) AND
				     (camdecmpswks.check_date_hour(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, 0) = 1) THEN
					CASE
						WHEN camdecmpswks.format_date_time(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, dcl.UPSCALE_INJECTION_MIN)
						     < camdecmpswks.format_date_time(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, dcl.ZERO_INJECTION_MIN)
							THEN camdecmpswks.format_date_time(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, dcl.UPSCALE_INJECTION_MIN)
						ELSE camdecmpswks.format_date_time(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, dcl.ZERO_INJECTION_MIN)
					END
				WHEN (camdecmpswks.check_date_hour(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, 0) = 1) AND
				     (camdecmpswks.check_date_hour(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, 0) = 0)
					THEN camdecmpswks.format_date_time(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, dcl.UPSCALE_INJECTION_MIN)
				WHEN (camdecmpswks.check_date_hour(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, 0) = 0) AND
				     (camdecmpswks.check_date_hour(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, 0) = 1)
					THEN camdecmpswks.format_date_time(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, dcl.ZERO_INJECTION_MIN)
				ELSE camdecmpswks.format_date_time(dts.DAILY_TEST_DATE, dts.DAILY_TEST_HOUR, dts.DAILY_TEST_MIN)
			END FIRST_TEST_DATETIME,
			fac.FAC_ID,  
			dcl.CAL_INJ_ID,  
			dts.DAILY_TEST_SUM_ID,
			CASE 
				WHEN dts.DAILY_TEST_MIN IS NULL 
				  then to_char(dts.DAILY_TEST_DATE, 'dd-mm-yyyy')||' at hour ' ||dts.DAILY_TEST_HOUR 
			      ELSE to_char(dts.DAILY_TEST_DATE, 'dd-mm-yyyy')||' at ' ||dts.DAILY_TEST_HOUR||':' ||dts.DAILY_TEST_MIN 
			END FORMATTED_TEST_DATE,
			MAX(CASE WHEN ovr.MON_LOC_ID IS NOT NULL THEN 1 ELSE 0 END) OVERLAP_EXISTS,
      dcl.UPSCALE_GAS_TYPE_CD,
      dcl.VENDOR_ID,
      dcl.CYLINDER_IDENTIFIER,
      dcl.EXPIRATION_DATE
		FROM	(SELECT	monPlanid MON_PLAN_ID,
						evalPeriodBeganDate EVAL_PERIOD_BEGAN_DATE,
						evalPeriodEndedDate EVAL_PERIOD_ENDED_DATE) lst
				INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl
					ON (mpl.MON_PLAN_ID = lst.MON_PLAN_ID OR lst.MON_PLAN_ID IS NULL)
				INNER JOIN camdecmpswks.MONITOR_LOCATION loc
					ON loc.MON_LOC_ID = mpl.MON_LOC_ID
				LEFT OUTER JOIN camd.UNIT unt
					ON unt.UNIT_ID = loc.UNIT_ID
				LEFT OUTER JOIN camdecmpswks.STACK_PIPE stp
					ON stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
				INNER JOIN camd.plant fac
					ON fac.FAC_ID IN (unt.FAC_ID, stp.FAC_ID)
				INNER JOIN camdecmpswks.DAILY_TEST_SUMMARY dts
					ON dts.MON_LOC_ID = loc.MON_LOC_ID 
					   AND dts.TEST_TYPE_CD = 'DAYCAL'
					   AND (dts.DAILY_TEST_DATE >= lst.EVAL_PERIOD_BEGAN_DATE OR
					        lst.EVAL_PERIOD_BEGAN_DATE IS NULL)
					   AND (dts.DAILY_TEST_DATE <= lst.EVAL_PERIOD_ENDED_DATE OR
					        lst.EVAL_PERIOD_ENDED_DATE IS NULL)
				INNER JOIN camdecmpswks.DAILY_CALIBRATION dcl
					ON dts.DAILY_TEST_SUM_ID = dcl.DAILY_TEST_SUM_ID
				INNER JOIN camdecmpsmd.REPORTING_PERIOD rpp
					ON rpp.RPT_PERIOD_ID = dts.RPT_PERIOD_ID 
				LEFT OUTER JOIN camdecmpswks.COMPONENT cmp
					ON cmp.COMPONENT_ID = dts.COMPONENT_ID 
				LEFT OUTER JOIN camdecmpswks.MONITOR_SYSTEM sys
					ON sys.MON_SYS_ID = dts.MON_SYS_ID 
				LEFT OUTER JOIN camdecmpswks.DAILY_TEST_SUMMARY ovr
					ON ovr.MON_LOC_ID = loc.MON_LOC_ID 
					   AND ovr.DAILY_TEST_SUM_ID != dcl.DAILY_TEST_SUM_ID
					   AND ovr.TEST_TYPE_CD = 'DAYCAL'
					   AND ovr.TEST_RESULT_CD != 'INC'
					   AND ovr.COMPONENT_ID = DTS.COMPONENT_ID
					   AND COALESCE(ovr.SPAN_SCALE_CD, '') = COALESCE(dts.SPAN_SCALE_CD, '')
					   AND (camdecmpswks.format_date_time(ovr.DAILY_TEST_DATE, ovr.DAILY_TEST_HOUR, ovr.DAILY_TEST_MIN)
					          BETWEEN camdecmpswks.format_date_time(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, dcl.ZERO_INJECTION_MIN) AND
                                      camdecmpswks.format_date_time(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, dcl.UPSCALE_INJECTION_MIN) OR
					       camdecmpswks.format_date_time(ovr.DAILY_TEST_DATE, ovr.DAILY_TEST_HOUR, ovr.DAILY_TEST_MIN)
					          BETWEEN camdecmpswks.format_date_time(dcl.UPSCALE_INJECTION_DATE, dcl.UPSCALE_INJECTION_HOUR, dcl.UPSCALE_INJECTION_MIN) AND
                                      camdecmpswks.format_date_time(dcl.ZERO_INJECTION_DATE, dcl.ZERO_INJECTION_HOUR, dcl.ZERO_INJECTION_MIN))
				LEFT OUTER JOIN camdecmpswks.HRLY_OP_DATA zop
					ON zop.MON_LOC_ID = loc.MON_LOC_ID
					   AND zop.BEGIN_DATE = dcl.ZERO_INJECTION_DATE
					   AND zop.BEGIN_HOUR = dcl.ZERO_INJECTION_HOUR
				LEFT OUTER JOIN camdecmpswks.HRLY_OP_DATA uop
					ON uop.MON_LOC_ID = loc.MON_LOC_ID
					   AND uop.BEGIN_DATE = dcl.UPSCALE_INJECTION_DATE
					   AND uop.BEGIN_HOUR = dcl.UPSCALE_INJECTION_HOUR
		GROUP BY mpl.MON_PLAN_ID, 
				dts.MON_LOC_ID,  
				dts.RPT_PERIOD_ID, 
				fac.ORIS_CODE,  
				CASE
					WHEN loc.UNIT_ID IS NOT NULL THEN unt.UNITID
					WHEN loc.STACK_PIPE_ID IS NOT NULL THEN stp.STACK_NAME
					ELSE NULL
				END,  
				rpp.CALENDAR_YEAR,  
				rpp.QUARTER, 
				dts.COMPONENT_ID, 
				dts.MON_SYS_ID, 
				cmp.COMPONENT_TYPE_CD,  
				cmp.COMPONENT_IDENTIFIER,  
				cmp.ACQ_CD, 
				dts.TEST_TYPE_CD,  
				dts.TEST_RESULT_CD,  
				dts.SPAN_SCALE_CD,  
				dts.DAILY_TEST_DATE, 
				dts.DAILY_TEST_HOUR,  
				dts.DAILY_TEST_MIN,  
				dcl.ONLINE_OFFLINE_IND, 
				dcl.UPSCALE_GAS_LEVEL_CD, 
				dcl.UPSCALE_INJECTION_DATE,  
				dcl.UPSCALE_INJECTION_HOUR, 
				dcl.UPSCALE_INJECTION_MIN,  
				dcl.UPSCALE_MEASURED_VALUE,  
				dcl.UPSCALE_REF_VALUE, 
				dcl.UPSCALE_CAL_ERROR,  
				dcl.UPSCALE_APS_IND,  
				dcl.ZERO_INJECTION_DATE, 
				dcl.ZERO_INJECTION_HOUR,  
				dcl.ZERO_INJECTION_MIN,  
				dcl.ZERO_MEASURED_VALUE, 
				dcl.ZERO_REF_VALUE,  
				dcl.ZERO_CAL_ERROR,  
				dcl.ZERO_APS_IND,  
				sys.SYSTEM_IDENTIFIER,
				fac.FAC_ID,  
				dcl.CAL_INJ_ID,  
				dts.DAILY_TEST_SUM_ID,
				lst.EVAL_PERIOD_BEGAN_DATE,
        dcl.UPSCALE_GAS_TYPE_CD,
        dcl.VENDOR_ID,
        dcl.CYLINDER_IDENTIFIER,
        dcl.EXPIRATION_DATE;

END;
$BODY$;