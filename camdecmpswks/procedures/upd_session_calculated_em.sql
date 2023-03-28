-- PROCEDURE: camdecmpswks.upd_session_calculated_em(numeric, character varying, integer, character varying, character, character varying)

-- DROP PROCEDURE IF EXISTS camdecmpswks.upd_session_calculated_em(numeric, character varying, integer, character varying, character, character varying);

CREATE OR REPLACE PROCEDURE camdecmpswks.upd_session_calculated_em(
	par_v_session_id character varying,
	par_v_mon_plan_id character varying,
	par_v_rpt_period_id integer,
	par_v_current_userid character varying,
	INOUT par_v_result character,
	INOUT par_v_error_msg character varying)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    var_V_SUBMISSION_AVAILABILITY_CD VARCHAR(7);
    var_V_MON_LOC_ID VARCHAR(45);
    var_V_PERIOD_BEGIN_DATE DATE;
    var_V_PERIOD_END_DATE DATE;
    error_catch$ERROR_NUMBER TEXT;
    error_catch$ERROR_SEVERITY TEXT;
    error_catch$ERROR_STATE TEXT;
    error_catch$ERROR_LINE TEXT;
    error_catch$ERROR_PROCEDURE TEXT;
    error_catch$ERROR_MESSAGE TEXT;
	l_context TEXT;
BEGIN
    par_V_RESULT := 'F';
    par_V_ERROR_MSG := '';
   
    BEGIN
        /* Get Submission Availability Code */
        SELECT
            sub_availability_cd
            INTO var_V_SUBMISSION_AVAILABILITY_CD
            FROM camdecmpsaux.em_submission_access
            WHERE mon_plan_id = par_V_MON_PLAN_ID AND rpt_period_id = par_V_RPT_PERIOD_ID;

        /* Get Reporting period end / start date */
        SELECT
            begin_date, end_date
            INTO var_V_PERIOD_BEGIN_DATE, var_V_PERIOD_END_DATE
            FROM camdecmpsmd.reporting_period
            WHERE rpt_period_id = par_V_RPT_PERIOD_ID;

        /* Get mon_loc_id period end / start date */
        SELECT
            mpl.mon_loc_id
            INTO var_V_MON_LOC_ID
            FROM camdecmpswks.monitor_plan_location AS mpl
            WHERE mpl.mon_plan_id = par_V_MON_PLAN_ID;

        /* Derived Hourly Value */
        UPDATE camdecmpswks.derived_hrly_value AS wks
        SET 
        calc_unadjusted_hrly_value = calc.calc_unadjusted_hrly_value, 
        calc_adjusted_hrly_value = calc.calc_adjusted_hrly_value, 
        applicable_bias_adj_factor = calc.applicable_bias_adj_factor, 
        calc_pct_diluent = calc.calc_pct_diluent, 
        calc_pct_moisture = calc.calc_pct_moisture, 
        calc_rata_status = calc.calc_rata_status, 
        calc_appe_status = calc.calc_appe_status, 
        calc_hour_measure_cd = calc.calc_hour_measure_cd, 
        calc_fuel_flow_total = calc.calc_fuel_flow_total, 
        userid = par_V_CURRENT_USERID, 
        update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.derived_hrly_value calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.derv_id = calc.derv_id;

        /* MATS Derived Hourly Value */
        UPDATE camdecmpswks.mats_derived_hrly_value AS wks
        SET calc_unadjusted_hrly_value = calc.calc_unadjusted_hrly_value, calc_pct_diluent = calc.calc_pct_diluent, calc_pct_moisture = calc.calc_pct_moisture, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.mats_derived_hrly_value calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.MATS_DHV_ID = calc.MATS_DHV_ID;
        /* Monitor Hourly Value */
        UPDATE camdecmpswks.monitor_hrly_value AS wks
        SET calc_adjusted_hrly_value = calc.calc_adjusted_hrly_value, applicable_bias_adj_factor = calc.applicable_bias_adj_factor, calc_line_status = calc.calc_line_status, calc_rata_status = calc.calc_rata_status, calc_daycal_status = calc.calc_daycal_status, calc_leak_status = calc.calc_leak_status, calc_dayint_status = calc.calc_dayint_status, calc_f2l_status = calc.calc_f2l_status, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.monitor_hrly_value calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.MONITOR_HRLY_VAL_ID = calc.MONITOR_HRLY_VAL_ID;
        /* MATS Monitor Hourly Value */
        UPDATE camdecmpswks.mats_monitor_hrly_value AS wks
        SET calc_unadjusted_hrly_value = calc.calc_unadjusted_hrly_value, calc_hg_line_status = calc.calc_hg_line_status, calc_rata_status = calc.calc_rata_status, calc_daily_cal_status = calc.calc_daily_cal_status, calc_hgi1_status = calc.calc_hgi1_status, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.mats_monitor_hrly_value calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.MATS_MHV_ID = calc.MATS_MHV_ID;
        /* Hourly Fuel Flow */
        UPDATE camdecmpswks.hrly_fuel_flow AS wks
        SET calc_volumetric_flow_rate = calc.calc_volumetric_flow_rate, calc_mass_flow_rate = calc.calc_mass_flow_rate, calc_appd_status = calc.calc_appd_status, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.hrly_fuel_flow calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.HRLY_FUEL_FLOW_ID = calc.HRLY_FUEL_FLOW_ID;
        /* Hourly Parameter Fuel Flow */
        UPDATE camdecmpswks.hrly_param_fuel_flow AS wks
        SET calc_param_val_fuel = calc.calc_param_val_fuel, calc_appe_status = calc.calc_appe_status, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.hrly_param_fuel_flow calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.HRLY_PARAM_FF_ID = calc.HRLY_PARAM_FF_ID;
        /* Daily Emission */
        UPDATE camdecmpswks.daily_emission AS wks
        SET calc_total_daily_emission = calc.calc_total_daily_emission, calc_total_op_time = calc.calc_total_op_time, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.daily_emission calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.DAILY_EMISSION_ID = calc.DAILY_EMISSION_ID;
        /* Daily Fuel */
        UPDATE camdecmpswks.daily_fuel AS wks
        SET calc_fuel_carbon_burned = calc.calc_fuel_carbon_burned, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.daily_fuel calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.DAILY_FUEL_ID = calc.DAILY_FUEL_ID;
        /* Long Term Fuel Flow Updates */
        UPDATE camdecmpswks.long_term_fuel_flow AS wks
        SET calc_total_heat_input = calc.calc_total_heat_input,
        /* USERID = @V_CURRENT_USERID, */
        update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.long_term_fuel_flow calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.LTFF_ID = calc.LTFF_ID;
        /* -------------------------------- */
        /* Sorbent Trap Related Updates -- */
        /* -------------------------------- */
        /* Sorbent Trap */
        UPDATE camdecmpswks.sorbent_trap AS wks
        SET calc_paired_trap_agreement = calc.calc_paired_trap_agreement, calc_modc_cd = calc.calc_modc_cd, calc_hg_concentration = calc.calc_hg_concentration, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.sorbent_trap calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.TRAP_ID = calc.TRAP_ID;
        /* Sampling Train */
        UPDATE camdecmpswks.sampling_train AS wks
        SET calc_hg_concentration = calc.calc_hg_concentration, calc_percent_breakthrough = calc.calc_percent_breakthrough, calc_percent_spike_recovery = calc.calc_percent_spike_recovery, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.sampling_train calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.TRAP_TRAIN_ID = calc.TRAP_TRAIN_ID;
        /* Hourly Gas Flow Meter */
		
	
        UPDATE camdecmpswks.hrly_gas_flow_meter AS wks
        SET calc_flow_to_sampling_mult = calc.calc_flow_to_sampling_mult, calc_flow_to_sampling_ratio = calc.calc_flow_to_sampling_ratio, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.hrly_gas_flow_meter calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.hrly_gas_flow_meter_id = calc.hrly_gas_flow_meter_id;        /* ------------------------- */
		
		
        /* Summary Value Updates -- */
        /* ------------------------- */
        /* Summary Value Updates */
        UPDATE camdecmpswks.summary_value AS wks
        SET calc_current_rpt_period_total = calc.calc_current_rpt_period_total, calc_os_total = calc.calc_os_total, calc_year_total = calc.calc_year_total, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.summary_value calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.MON_LOC_ID = calc.MON_LOC_ID
        AND wks.RPT_PERIOD_ID = calc.RPT_PERIOD_ID
        AND wks.PARAMETER_CD = calc.PARAMETER_CD;
        /* Summary Value Inserts */
        INSERT INTO camdecmpswks.summary_value (sum_value_id, mon_loc_id, rpt_period_id, parameter_cd, calc_current_rpt_period_total, calc_os_total, calc_year_total, userid, update_date)
        SELECT
            uuid_generate_v4(), calc.mon_loc_id, calc.rpt_period_id, calc.parameter_cd, calc.calc_current_rpt_period_total, calc.calc_os_total, calc.calc_year_total, par_V_CURRENT_USERID, CURRENT_TIMESTAMP
            FROM camdecmpscalc.summary_value calc
			left join camdecmpswks.summary_value wks on 
				wks.MON_LOC_ID = calc.MON_LOC_ID AND 
				wks.RPT_PERIOD_ID = calc.RPT_PERIOD_ID AND 
				wks.PARAMETER_CD = calc.PARAMETER_CD
            WHERE calc.CHK_SESSION_ID = par_v_session_id
            AND wks.mon_loc_id IS NULL AND (calc.calc_current_rpt_period_total IS NOT NULL OR calc.calc_os_total IS NOT NULL OR calc.calc_year_total IS NOT NULL);
			
        /* -------------------------------- */
        /* Emission Test Updates -- */
        /* -------------------------------- */
        /* Daily Test Summary */
        UPDATE camdecmpswks.daily_test_summary AS wks
        SET calc_test_result_cd = calc.calc_test_result_cd, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.daily_test_summary calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.DAILY_TEST_SUM_ID = calc.DAILY_TEST_SUM_ID;
        /* Daily Calibration Test */
        UPDATE camdecmpswks.daily_calibration AS wks
        SET calc_online_offline_ind = calc.calc_online_offline_ind, calc_zero_cal_error = calc.calc_zero_cal_error, calc_zero_aps_ind = calc.calc_zero_aps_ind, calc_upscale_cal_error = calc.calc_upscale_cal_error, calc_upscale_aps_ind = calc.calc_upscale_aps_ind, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.daily_calibration calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.CAL_INJ_ID = calc.CAL_INJ_ID;
        /* Weekly Test Summary */
        UPDATE camdecmpswks.weekly_test_summary AS wks
        SET calc_test_result_cd = calc.calc_test_result_cd, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.weekly_test_summary calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.WEEKLY_TEST_SUM_ID = calc.WEEKLY_TEST_SUM_ID;
        /* Weekly System Integrity Test */
        UPDATE camdecmpswks.weekly_system_integrity AS wks
        SET calc_aps_ind = calc.calc_aps_ind, calc_system_integrity_error = calc.calc_system_integrity_error, userid = par_V_CURRENT_USERID, update_date = CURRENT_TIMESTAMP
        FROM camdecmpscalc.weekly_system_integrity calc
        WHERE calc.CHK_SESSION_ID = par_v_session_id
	    AND wks.WEEKLY_SYS_INTEGRITY_ID = calc.WEEKLY_SYS_INTEGRITY_ID;
        /* Emissions Evaluation Update */
        UPDATE camdecmpswks.emission_evaluation
        SET updated_status_flg = 'Y', last_updated = CURRENT_TIMESTAMP
            WHERE mon_plan_id = par_V_MON_PLAN_ID AND rpt_period_id = par_V_RPT_PERIOD_ID;
        /* Delete and read op supp data records for submittable em files */

        IF LOWER(var_V_SUBMISSION_AVAILABILITY_CD) = LOWER('REQUIRE') OR LOWER(var_V_SUBMISSION_AVAILABILITY_CD) = LOWER('GRANTED') THEN
           -- Operating Supp Data
            DELETE FROM camdecmpswks.operating_supp_data
                WHERE rpt_period_id = par_V_RPT_PERIOD_ID AND mon_loc_id = var_V_MON_LOC_ID;
            INSERT INTO camdecmpswks.operating_supp_data (op_supp_data_id, mon_loc_id, rpt_period_id, fuel_cd, op_type_cd, op_value, userid, update_date)
            SELECT
                uuid_generate_v4(), calc.mon_loc_id, calc.rpt_period_id, calc.fuel_cd, calc.op_type_cd, calc.op_value, par_V_CURRENT_USERID, CURRENT_TIMESTAMP
                FROM camdecmpscalc.operating_supp_data calc
                WHERE calc.CHK_SESSION_ID = par_v_session_id;

            -- sorbent train supplemental data
            DELETE FROM camdecmpswks.sorbent_trap_supp_data
                WHERE rpt_period_id = par_V_RPT_PERIOD_ID AND mon_loc_id = var_V_MON_LOC_ID;
            INSERT INTO camdecmpswks.sorbent_trap_supp_data (trap_id, mon_sys_id, begin_date, begin_hour, end_date, end_hour, modc_cd, rata_ind, sorbent_trap_aps_cd, hg_concentration, mon_loc_id, rpt_period_id, userid, add_date, update_date)
            SELECT
                src.trap_id, src.mon_sys_id, src.begin_date, src.begin_hour, src.end_date, src.end_hour, src.modc_cd, src.rata_ind, src.sorbent_trap_aps_cd, src.hg_concentration, src.mon_loc_id, src.rpt_period_id, par_V_CURRENT_USERID, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
                FROM camdecmpswks.sorbent_trap src
                WHERE src.rpt_period_id = par_V_RPT_PERIOD_ID AND src.mon_loc_id = var_V_MON_LOC_ID;

            -- sampling_train_supp_data
            DELETE FROM camdecmpswks.sampling_train_supp_data
                WHERE rpt_period_id = par_V_RPT_PERIOD_ID AND mon_loc_id = var_V_MON_LOC_ID;
            INSERT INTO camdecmpswks.sampling_train_supp_data (trap_train_id, trap_id, component_id, train_qa_status_cd, ref_flow_to_sampling_ratio, sampling_ratio_test_result_cd, hg_concentration, sfsr_total_count, sfsr_deviated_count, gfm_total_count, gfm_not_available_count, mon_loc_id, rpt_period_id, userid, add_date, update_date)
            SELECT
                src.trap_train_id, src.trap_id, src.component_id, src.train_qa_status_cd, src.ref_flow_to_sampling_ratio, src.sampling_ratio_test_result_cd, src.hg_concentration, src.sfsr_total_count, src.sfsr_deviated_count, src.gfm_total_count, src.gfm_not_available_count, src.mon_loc_id, src.rpt_period_id, par_V_CURRENT_USERID, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
                FROM camdecmpswks.sampling_train src
                JOIN camdecmpscalc.sampling_train_supp_data sup ON sup.chk_session_id = par_V_SESSION_ID AND sup.trap_train_id = src.trap_train_id
                WHERE src.rpt_period_id = par_V_RPT_PERIOD_ID AND src.mon_loc_id = var_V_MON_LOC_ID; 

            -- qa_cert_event_supp_data
            DELETE FROM camdecmpswks.qa_cert_event_supp_data
                WHERE rpt_period_id = par_V_RPT_PERIOD_ID AND mon_loc_id  = var_V_MON_LOC_ID;
            /* Insert the new supplemental data from the check session. */
            INSERT INTO camdecmpswks.qa_cert_event_supp_data (qa_cert_event_supp_data_id, qa_cert_event_id, qa_cert_event_supp_data_cd, qa_cert_event_supp_date_cd, count_from_datehour, count, count_from_included_ind, mon_loc_id, rpt_period_id, userid, add_date)
            SELECT
                uuid_generate_v4(), src.qa_cert_event_id, src.qa_cert_event_supp_data_cd, src.qa_cert_event_supp_date_cd, src.count_from_datehour, src.count, src.count_from_included_ind, src.mon_loc_id, src.rpt_period_id, par_V_CURRENT_USERID, CURRENT_TIMESTAMP
                FROM camdecmpscalc.qa_cert_event_supp_data AS src
                WHERE src.chk_session_id = par_V_SESSION_ID;

            -- system_op_supp_data
            DELETE FROM camdecmpswks.system_op_supp_data
                WHERE rpt_period_id = par_V_RPT_PERIOD_ID AND mon_sys_id IN (SELECT
                    sys.mon_sys_id
                    FROM camdecmpswks.monitor_plan_location AS mpl
                    JOIN camdecmpswks.monitor_system AS sys
                        ON sys.mon_loc_id = mpl.mon_loc_id
                    WHERE mpl.mon_plan_id = par_V_MON_PLAN_ID);
            /* Insert the new supplemental data from the check session. */
            INSERT INTO camdecmpswks.system_op_supp_data (sys_op_supp_data_id, mon_sys_id, rpt_period_id, op_supp_data_type_cd, days, hours, mon_loc_id, userid, add_date)
            SELECT
                uuid_generate_v4(), src.mon_sys_id, src.rpt_period_id, src.op_supp_data_type_cd, src.days, src.hours, src.mon_loc_id, par_V_CURRENT_USERID, CURRENT_TIMESTAMP
                FROM camdecmpscalc.system_op_supp_data AS src
                WHERE src.chk_session_id = par_V_SESSION_ID;

            -- component_op_supp_data
            DELETE FROM camdecmpswks.component_op_supp_data
                WHERE rpt_period_id = par_V_RPT_PERIOD_ID AND component_id IN (SELECT
                    cmp.component_id
                    FROM camdecmpswks.monitor_plan_location AS mpl
                    JOIN camdecmpswks.component AS cmp
                        ON cmp.mon_loc_id = mpl.mon_loc_id
                    WHERE mpl.mon_plan_id = par_V_MON_PLAN_ID);
            /* Insert the new supplemental data from the check session. */
            INSERT INTO camdecmpswks.component_op_supp_data (comp_op_supp_data_id, component_id, rpt_period_id, op_supp_data_type_cd, days, hours, mon_loc_id, userid, add_date)
            SELECT
                uuid_generate_v4(), src.component_id, src.rpt_period_id, src.op_supp_data_type_cd, src.days, src.hours, src.mon_loc_id, par_V_CURRENT_USERID, CURRENT_TIMESTAMP
                FROM camdecmpscalc.component_op_supp_data AS src
                WHERE src.chk_session_id = par_V_SESSION_ID;

            -- last_qa_value_supp_data
            DELETE FROM camdecmpswks.last_qa_value_supp_data
                WHERE rpt_period_id = par_V_RPT_PERIOD_ID AND mon_loc_id = var_V_MON_LOC_ID;
            /* Insert the new supplemental data from the check session. */
            INSERT INTO camdecmpswks.last_qa_value_supp_data (last_qa_value_supp_data_id, mon_loc_id, rpt_period_id, parameter_cd, moisture_basis, hourly_type_cd, mon_sys_id, component_id, op_datehour, unadjusted_hrly_value, adjusted_hrly_value, userid, add_date)
            SELECT
                uuid_generate_v4(), src.mon_loc_id, src.rpt_period_id, src.parameter_cd, src.moisture_basis, src.hourly_type_cd, src.mon_sys_id, src.component_id, src.op_datehour, src.unadjusted_hrly_value, src.adjusted_hrly_value, par_V_CURRENT_USERID, CURRENT_TIMESTAMP
                FROM camdecmpscalc.last_qa_value_supp_data AS src
                WHERE src.chk_session_id = par_V_SESSION_ID;


            --daily_test_system_supp_data / daily_test_supp_data
            DELETE FROM camdecmpswks.daily_test_system_supp_data
                WHERE rpt_period_id = par_V_RPT_PERIOD_ID AND mon_loc_id  = var_V_MON_LOC_ID;
            DELETE FROM camdecmpswks.daily_test_supp_data
                WHERE rpt_period_id = par_V_RPT_PERIOD_ID AND mon_loc_id = var_V_MON_LOC_ID;

            INSERT INTO camdecmpswks.daily_test_supp_data (daily_test_supp_data_id, component_id, rpt_period_id, test_type_cd, span_scale_cd, key_online_ind, key_valid_ind, op_hour_cnt, last_covered_nonop_datehour, first_op_after_nonop_datehour, daily_test_datehourmin, test_result_cd, online_offline_ind, sort_daily_test_datehourmin, calc_test_result_cd, daily_test_sum_id, mon_loc_id, userid, add_date)
            SELECT
                uuid_generate_v4(), dts.component_id, src.rpt_period_id, dts.test_type_cd, COALESCE(dts.span_scale_cd, 'N') AS span_scale_cd, src.key_online_ind, src.key_valid_ind, src.op_hour_cnt, src.last_covered_nonop_datehour, src.first_op_after_nonop_datehour, dts.daily_test_date + (dts.daily_test_hour::NUMERIC || ' HOUR')::INTERVAL + (dts.daily_test_min::NUMERIC || ' MINUTE')::INTERVAL AS daily_test_datehourmin, dts.test_result_cd, dcl.online_offline_ind, src.sort_daily_test_datehourmin, src.calc_test_result_cd, src.daily_test_sum_id, dts.mon_loc_id, par_V_CURRENT_USERID AS userid, CURRENT_TIMESTAMP AS add_date
                FROM camdecmpscalc.daily_test_supp_data AS src
                JOIN camdecmpswks.daily_test_summary AS dts
                    ON dts.daily_test_sum_id = src.daily_test_sum_id
                LEFT OUTER JOIN camdecmpswks.daily_calibration AS dcl
                    ON dcl.daily_test_sum_id = src.daily_test_sum_id
                WHERE src.chk_session_id = par_V_SESSION_ID AND (dts.test_type_cd = 'DAYCAL' AND dcl.daily_test_sum_id IS NOT NULL OR dts.test_type_cd != 'DAYCAL' AND dcl.daily_test_sum_id IS NULL);

            INSERT INTO camdecmpswks.daily_test_system_supp_data (daily_test_system_supp_data_id, daily_test_supp_data_id, mon_sys_id, op_hour_cnt, last_covered_nonop_datehour, first_op_after_nonop_datehour, mon_loc_id, rpt_period_id, userid, add_date)
            SELECT
                uuid_generate_v4(), sup.daily_test_supp_data_id, src.mon_sys_id, src.op_hour_cnt, src.last_covered_nonop_datehour, src.first_op_after_nonop_datehour, sup.mon_loc_id, src.rpt_period_id, par_V_CURRENT_USERID AS userid, CURRENT_TIMESTAMP AS add_date
                FROM camdecmpscalc.daily_test_system_supp_data AS src
                JOIN camdecmpswks.daily_test_supp_data AS sup
                    ON sup.daily_test_sum_id = src.daily_test_sum_id AND sup.rpt_period_id = src.rpt_period_id
                WHERE src.chk_session_id = par_V_SESSION_ID;
            
        END IF;
		

        par_V_RESULT := 'T';

        EXCEPTION
            WHEN OTHERS THEN
                error_catch$ERROR_NUMBER := '0';
                error_catch$ERROR_SEVERITY := '0';
                error_catch$ERROR_LINE := '0';
                error_catch$ERROR_PROCEDURE := 'UPD_SESSION_CALCULATED_EM';
                GET STACKED DIAGNOSTICS error_catch$ERROR_STATE = RETURNED_SQLSTATE,
                    error_catch$ERROR_MESSAGE = MESSAGE_TEXT,
				    l_context = PG_EXCEPTION_CONTEXT;
				
                par_V_ERROR_MSG := error_catch$ERROR_PROCEDURE || ': ' || l_context || error_catch$ERROR_MESSAGE || ' (' || CAST (error_catch$ERROR_LINE AS VARCHAR(30)) || ')';
                par_V_RESULT := 'F';
    END;
END;
$BODY$;
