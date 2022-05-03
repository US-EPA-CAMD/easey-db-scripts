-- View: camdecmpswks.vw_qa_supp_attribute

-- DROP VIEW camdecmpswks.vw_qa_supp_attribute;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_supp_attribute
 AS
 SELECT at.qa_supp_attribute_id,
    qa.qa_supp_data_id,
    qa.test_sum_id,
    qa.mon_loc_id,
    qa.mon_sys_id,
    qa.component_id,
    at.attribute_name,
    at.attribute_value,
    qa.test_num,
    qa.gp_ind,
    qa.test_type_cd,
    qa.test_reason_cd,
    qa.test_result_cd,
    qa.rpt_period_id,
    rp.calendar_year,
    rp.quarter,
    qa.op_level_cd,
    qa.span_scale,
    qa.begin_date,
    qa.begin_hour,
    qa.begin_min,
    qa.end_date,
    qa.end_hour,
    qa.end_min,
    qa.reinstallation_date,
    qa.reinstallation_hour,
    qa.test_expire_date,
    qa.test_expire_hour,
    at.userid,
    at.add_date,
    at.update_date,
    ml.fac_id,
    COALESCE(ml.stack_name, ml.unitid) AS location_identifier,
    c.component_type_cd,
    c.component_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
        CASE
            WHEN qa.submission_availability_cd IS NULL OR (qa.submission_availability_cd::text = ANY (ARRAY['GRANTED'::character varying, 'REQUIRE'::character varying]::text[])) THEN 'Y'::text
            ELSE 'N'::text
        END AS can_submit,
    qa.fuel_cd,
    fc.fuel_group_cd,
    fc.unit_fuel_cd,
    fc.fuel_cd_description,
    qa.operating_condition_cd,
    occ.op_condition_cd_description
   FROM camdecmpswks.qa_supp_attribute at
     JOIN camdecmpswks.qa_supp_data qa ON at.qa_supp_data_id::text = qa.qa_supp_data_id::text
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON qa.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON qa.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON qa.component_id::text = c.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON qa.rpt_period_id = rp.rpt_period_id
     LEFT JOIN camdecmpsmd.fuel_code fc ON fc.fuel_cd::text = qa.fuel_cd::text
     LEFT JOIN camdecmpsmd.operating_condition_code occ ON qa.operating_condition_cd::text = occ.operating_condition_cd::text;
