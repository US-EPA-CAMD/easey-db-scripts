-- View: camdecmpsaux.vw_em_submission_access

DROP VIEW IF EXISTS camdecmpsaux.vw_em_submission_access;

CREATE OR REPLACE VIEW camdecmpsaux.vw_em_submission_access
 AS
 SELECT em.em_sub_access_id,
    em.mon_plan_id,
    em.rpt_period_id,
    em.access_begin_date,
    em.access_end_date,
    em.em_sub_type_cd,
    em.userid,
    em.add_date,
    em.update_date,
    em.em_status_cd,
    em.sub_availability_cd,
    em.resub_explanation,
    pl.fac_id,
    pl.oris_code,
    pl.state,
    pl.facility_name,
    rp.calendar_year,
    rp.quarter,
    rp.period_abbreviation,
    rf.report_freq_cd,
    st.em_sub_type_cd_description,
    ee.submission_id,
    sc.severity_cd_description,
    string_agg((COALESCE(u.unitid, ''::character varying)::text || ''::text) || COALESCE(sp.stack_name, ''::character varying)::text, ', '::text) AS locations
   FROM camdecmpsaux.em_submission_access em
     JOIN camdecmps.monitor_plan mp USING (mon_plan_id)
     JOIN camdecmps.monitor_plan_location USING (mon_plan_id)
     JOIN camdecmps.monitor_location ml USING (mon_loc_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
     LEFT JOIN camd.unit u USING (unit_id)
     JOIN camd.plant pl ON pl.fac_id = mp.fac_id
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     LEFT JOIN camdecmps.emission_evaluation ee ON ee.rpt_period_id = em.rpt_period_id AND ee.mon_plan_id::text = em.mon_plan_id::text
     LEFT JOIN camdecmpsaux.check_session cs ON cs.chk_session_id::text = ee.chk_session_id::text
     LEFT JOIN camdecmpsmd.severity_code sc USING (severity_cd)
     JOIN camdecmpsmd.em_sub_type_code st USING (em_sub_type_cd)
     JOIN camdecmps.monitor_plan_reporting_freq rf ON mp.mon_plan_id::text = rf.mon_plan_id::text AND (rf.begin_rpt_period_id <= em.rpt_period_id AND rf.end_rpt_period_id IS NULL OR rf.begin_rpt_period_id <= em.rpt_period_id AND rf.end_rpt_period_id >= em.rpt_period_id)
  GROUP BY em.em_sub_access_id, em.mon_plan_id, em.rpt_period_id, em.access_begin_date, em.access_end_date, em.em_sub_type_cd, em.userid, em.add_date, em.update_date, em.em_status_cd, em.sub_availability_cd, pl.fac_id, pl.oris_code, pl.state, rp.calendar_year, rp.quarter, rf.report_freq_cd, ee.submission_id, sc.severity_cd_description, rp.period_abbreviation, st.em_sub_type_cd_description;
  