CREATE OR REPLACE  VIEW camdecmpswks.vw_qa_supp_data (qa_supp_data_id, test_sum_id, mon_loc_id, mon_sys_id, component_id, test_num, gp_ind, test_type_cd, test_reason_cd, test_result_cd, rpt_period_id, calendar_year, quarter, op_level_cd, span_scale, begin_date, begin_hour, begin_min, end_date, end_hour, end_min, reinstallation_date, reinstallation_hour, reinstall_date, reinstall_hour, test_expire_date, test_expire_hour, userid, add_date, update_date, fac_id, location_identifier, component_type_cd, component_identifier, system_identifier, sys_type_cd, sys_designation_cd, can_submit, must_submit, fuel_cd, fuel_group_cd, unit_fuel_cd, fuel_cd_description, operating_condition_cd, op_condition_cd_description, submission_availability_cd, pending_status_cd, oris_code, facility_name, submission_id) AS
SELECT
    qa.qa_supp_data_id, qa.test_sum_id, qa.mon_loc_id, qa.mon_sys_id, qa.component_id, qa.test_num, qa.gp_ind, qa.test_type_cd, qa.test_reason_cd, qa.test_result_cd, qa.rpt_period_id,
    CASE
        WHEN qa.end_date IS NULL THEN rp.calendar_year
        ELSE date_part('year', qa.end_date::TIMESTAMP)
    END AS calendar_year,
    CASE
        WHEN qa.end_date IS NULL THEN rp.quarter
        ELSE FLOOR((date_part('month', qa.end_date::TIMESTAMP) + 2) / 3)
    END AS quarter, qa.op_level_cd, qa.span_scale, qa.begin_date, qa.begin_hour, qa.begin_min, qa.end_date, qa.end_hour, qa.end_min, qa.reinstallation_date, qa.reinstallation_hour, qa.reinstallation_date AS reinstall_date, qa.reinstallation_hour AS reinstall_hour, qa.test_expire_date, qa.test_expire_hour, qa.userid, qa.add_date, qa.update_date, ml.fac_id, location_identifier, c.component_type_cd, c.component_identifier, ms.system_identifier, ms.sys_type_cd, ms.sys_designation_cd,
    CASE
        WHEN qa.submission_availability_cd IS NULL OR qa.submission_availability_cd IN ('GRANTED', 'REQUIRE') THEN 'Y'
        ELSE 'N'
    END AS can_submit,
    CASE
        WHEN qa.submission_availability_cd IS NULL OR qa.submission_availability_cd = 'REQUIRE' THEN 'Y'
        ELSE 'N'
    END AS must_submit, qa.fuel_cd, fc.fuel_group_cd, fc.unit_fuel_cd, fc.fuel_cd_description, qa.operating_condition_cd, occ.op_condition_cd_description, qa.submission_availability_cd, qa.pending_status_cd, ml.oris_code, ml.facility_name, qa.submission_id
    FROM camdecmps.qa_supp_data AS qa
    LEFT OUTER JOIN camdecmpswks.vw_monitor_location AS ml
        ON qa.mon_loc_id = ml.mon_loc_id
    LEFT OUTER JOIN camdecmpswks.monitor_system AS ms
        ON qa.mon_sys_id = ms.mon_sys_id
    LEFT OUTER JOIN camdecmpswks.component AS c
        ON qa.component_id = c.component_id
    LEFT OUTER JOIN camdecmpsmd.reporting_period AS rp
        ON qa.rpt_period_id = rp.rpt_period_id
    LEFT OUTER JOIN camdecmpsmd.fuel_code AS fc
        ON fc.fuel_cd = qa.fuel_cd
    LEFT OUTER JOIN camdecmpsmd.operating_condition_code AS occ
        ON qa.operating_condition_cd = occ.operating_condition_cd;