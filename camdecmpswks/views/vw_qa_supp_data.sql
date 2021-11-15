-- View: camdecmpswks.vw_qa_supp_data

-- DROP VIEW camdecmpswks.vw_qa_supp_data;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_supp_data
 AS
 SELECT qa.qa_supp_data_id,
    qa.test_sum_id,
    qa.mon_loc_id,
    qa.mon_sys_id,
    qa.component_id,
    qa.test_num,
    qa.gp_ind,
    qa.test_type_cd,
    qa.test_reason_cd,
    qa.test_result_cd,
    qa.rpt_period_id,
        CASE
            WHEN qa.end_date IS NULL THEN rp.calendar_year::double precision
            ELSE date_part('year'::text, qa.end_date::timestamp without time zone)
        END AS calendar_year,
        CASE
            WHEN qa.end_date IS NULL THEN rp.quarter::double precision
            ELSE floor((date_part('month'::text, qa.end_date::timestamp without time zone) + 2::double precision) / 3::double precision)
        END AS quarter,
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
    qa.reinstallation_date AS reinstall_date,
    qa.reinstallation_hour AS reinstall_hour,
    qa.test_expire_date,
    qa.test_expire_hour,
    qa.userid,
    qa.add_date,
    qa.update_date,
    ml.fac_id,
    ml.location_identifier,
    c.component_type_cd,
    c.component_identifier,
    ms.system_identifier,
    ms.sys_type_cd,
    ms.sys_designation_cd,
        CASE
            WHEN qa.submission_availability_cd IS NULL OR (qa.submission_availability_cd::text = ANY (ARRAY['GRANTED'::character varying, 'REQUIRE'::character varying]::text[])) THEN 'Y'::text
            ELSE 'N'::text
        END AS can_submit,
        CASE
            WHEN qa.submission_availability_cd IS NULL OR qa.submission_availability_cd::text = 'REQUIRE'::text THEN 'Y'::text
            ELSE 'N'::text
        END AS must_submit,
    qa.fuel_cd,
    fc.fuel_group_cd,
    fc.unit_fuel_cd,
    fc.fuel_cd_description,
    qa.operating_condition_cd,
    occ.op_condition_cd_description,
    qa.submission_availability_cd,
    NULL::text AS pending_status_cd,
    ml.oris_code,
    ml.facility_name,
    qa.submission_id
   FROM camdecmps.qa_supp_data qa
     LEFT JOIN camdecmpswks.vw_monitor_location ml ON qa.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON qa.mon_sys_id::text = ms.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON qa.component_id::text = c.component_id::text
     LEFT JOIN camdecmpsmd.reporting_period rp ON qa.rpt_period_id = rp.rpt_period_id
     LEFT JOIN camdecmpsmd.fuel_code fc ON fc.fuel_cd::text = qa.fuel_cd::text
     LEFT JOIN camdecmpsmd.operating_condition_code occ ON qa.operating_condition_cd::text = occ.operating_condition_cd::text;
