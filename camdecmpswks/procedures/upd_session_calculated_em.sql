-- PROCEDURE: camdecmpswks.upd_session_calculated_em(numeric, character varying, integer, character varying, character, character varying)

DROP PROCEDURE IF EXISTS camdecmpswks.upd_session_calculated_em(numeric, character varying, integer, character varying, character, character varying);

CREATE OR REPLACE PROCEDURE camdecmpswks.upd_session_calculated_em(
	par_v_session_id numeric,
	par_v_mon_plan_id character varying,
	par_v_rpt_period_id integer,
	par_v_current_userid character varying,
	INOUT par_v_result character,
	INOUT par_v_error_msg character varying)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    var_V_SUBMISSION_AVAILABILITY_CD VARCHAR(7);
    error_catch$ERROR_NUMBER TEXT;
    error_catch$ERROR_SEVERITY TEXT;
    error_catch$ERROR_STATE TEXT;
    error_catch$ERROR_LINE TEXT;
    error_catch$ERROR_PROCEDURE TEXT;
    error_catch$ERROR_MESSAGE TEXT;
BEGIN
    par_V_RESULT := 'F';
    par_V_ERROR_MSG := '';
   
    BEGIN
        /* Get Submission Availability Code */
        SELECT
            sub_availability_cd
            INTO var_V_SUBMISSION_AVAILABILITY_CD
            FROM camdaux.em_submission_access
            WHERE mon_plan_id = par_V_MON_PLAN_ID AND rpt_period_id = par_V_RPT_PERIOD_ID;
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
	    AND wks.HRLY_GFM_ID = calc.HRLY_GFM_ID;        /* ------------------------- */
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
            WHERE calc.CHK_SESSION_ID = par_v_session_id
            AND wks.MON_LOC_ID = calc.MON_LOC_ID
            AND wks.RPT_PERIOD_ID = calc.RPT_PERIOD_ID
            AND wks.PARAMETER_CD = calc.PARAMETER_CD
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
            DELETE FROM camdecmpswks.operating_supp_data
                WHERE rpt_period_id = par_V_RPT_PERIOD_ID AND mon_loc_id = par_V_MON_PLAN_ID;
                    
            INSERT INTO camdecmpswks.operating_supp_data (op_supp_data_id, mon_loc_id, rpt_period_id, fuel_cd, op_type_cd, op_value, userid, update_date)
            SELECT
                uuid_generate_v4(), calc.mon_loc_id, calc.rpt_period_id, calc.fuel_cd, calc.op_type_cd, calc.op_value, par_V_CURRENT_USERID, CURRENT_TIMESTAMP
                FROM camdecmpscalc.operating_supp_data calc
                WHERE calc.CHK_SESSION_ID = par_v_session_id;
        END IF;
        /* Recreate the View Emission grid data */
        /* EXEC Client_EM_Grid_Data @V_MON_PLAN_ID, @V_RPT_PERIOD_ID; */
        par_V_RESULT := 'T';

        /* TODO: Implement these procedures

        -- Handle Sorbent Trap and Sampling Train Supplemental Data Tables 
        CALL camdecmpswks.upd_session_calculated_em_st_supp(par_V_MON_PLAN_ID, par_V_RPT_PERIOD_ID, par_V_CURRENT_USERID, par_V_RESULT => par_V_RESULT, par_V_ERROR_MSG => par_V_ERROR_MSG);

        IF LOWER(par_V_RESULT) = LOWER('T') THEN
            CALL camdecmpswks.upd_session_calculated_em_train_supp(par_V_SESSION_ID, par_V_MON_PLAN_ID, par_V_RPT_PERIOD_ID, par_V_CURRENT_USERID, par_V_RESULT => par_V_RESULT, par_V_ERROR_MSG => par_V_ERROR_MSG);
        END IF;
        -- Handle QA Certification Event Supplementa Data 

        IF LOWER(par_V_RESULT) = LOWER('T') THEN
            CALL "ECMPS_2022-04-26_Supp".upd_session_calculated_em_qce_supp(par_V_SESSION_ID, par_V_MON_PLAN_ID, par_V_RPT_PERIOD_ID, par_V_CURRENT_USERID, par_V_RESULT => par_V_RESULT, par_V_ERROR_MSG => par_V_ERROR_MSG);
        END IF;
        -- Handle QA Certification Event Supplementa Data 

        IF LOWER(par_V_RESULT) = LOWER('T') THEN
            CALL "ECMPS_2022-04-26_Supp".upd_session_calculated_em_sys_supp(par_V_SESSION_ID, par_V_MON_PLAN_ID, par_V_RPT_PERIOD_ID, par_V_CURRENT_USERID, par_V_RESULT => par_V_RESULT, par_V_ERROR_MSG => par_V_ERROR_MSG);
        END IF;
        -- Handle QA Certification Event Supplementa Data 

        IF LOWER(par_V_RESULT) = LOWER('T') THEN
            CALL "ECMPS_2022-04-26_Supp".upd_session_calculated_em_cmp_supp(par_V_SESSION_ID, par_V_MON_PLAN_ID, par_V_RPT_PERIOD_ID, par_V_CURRENT_USERID, par_V_RESULT => par_V_RESULT, par_V_ERROR_MSG => par_V_ERROR_MSG);
        END IF;
        -- Handle Last Quality Assured Value Supplementa Data 

        IF LOWER(par_V_RESULT) = LOWER('T') THEN
            CALL "ECMPS_2022-04-26_Supp".upd_session_calculated_em_lqa_supp(par_V_SESSION_ID, par_V_MON_PLAN_ID, par_V_RPT_PERIOD_ID, par_V_CURRENT_USERID, par_V_RESULT => par_V_RESULT, par_V_ERROR_MSG => par_V_ERROR_MSG);
        END IF;
         Handle Daily Test (and Daily Test System) Supplementa Data

        IF LOWER(par_V_RESULT) = LOWER('T') THEN
            CALL "ECMPS_2022-04-26_Supp".upd_session_calculated_em_dt_supp(par_V_SESSION_ID, par_V_MON_PLAN_ID, par_V_RPT_PERIOD_ID, par_V_CURRENT_USERID, par_V_RESULT => par_V_RESULT, par_V_ERROR_MSG => par_V_ERROR_MSG);
        END IF;

        */

        EXCEPTION
            WHEN OTHERS THEN
                error_catch$ERROR_NUMBER := '0';
                error_catch$ERROR_SEVERITY := '0';
                error_catch$ERROR_LINE := '0';
                error_catch$ERROR_PROCEDURE := 'UPD_SESSION_CALCULATED_EM';
                GET STACKED DIAGNOSTICS error_catch$ERROR_STATE = RETURNED_SQLSTATE,
                    error_catch$ERROR_MESSAGE = MESSAGE_TEXT;
                par_V_ERROR_MSG := error_catch$ERROR_PROCEDURE || ': ' || error_catch$ERROR_MESSAGE || ' (' || CAST (error_catch$ERROR_LINE AS VARCHAR(30)) || ')';
                par_V_RESULT := 'F';
    END;
END;
$BODY$;
