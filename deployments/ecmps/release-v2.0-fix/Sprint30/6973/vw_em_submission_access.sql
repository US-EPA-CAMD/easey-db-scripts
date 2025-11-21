DROP VIEW IF EXISTS camdecmpsaux.vw_em_submission_access;

CREATE OR REPLACE VIEW camdecmpsaux.vw_em_submission_access AS
SELECT
    em.em_sub_access_id,
    em.mon_plan_id,
    em.rpt_period_id,
    em.access_begin_date,
    em.access_end_date,
    stc.em_sub_type_cd,
    stc.em_sub_type_cd_description,
    em.userid,
    em.add_date,
    em.update_date,
    statc.em_status_cd,
    statc.em_status_cd_description,
    sac.submission_availability_cd AS sub_availability_cd,
    sac.sub_avail_cd_description AS sub_availability_cd_description,
    em.resub_explanation,
    pl.fac_id,
    pl.oris_code,
    pl.state,
    pl.facility_name,
    rp.calendar_year,
    rp.quarter,
    rp.period_abbreviation,
    rf.report_freq_cd,
    sq.submission_id,
    sq.queued_time AS submission_date,
    sc.severity_cd,
    sc.severity_cd_description,
    CASE
        WHEN em.sub_availability_cd = 'DELETE' THEN 'Cancelled'
        WHEN em.em_status_cd = 'PENDING' THEN 'Pending Approval'
        WHEN em.sub_availability_cd IS NULL AND em.access_end_date::date >= CURRENT_DATE THEN 'Not Yet Open'
        WHEN em.sub_availability_cd IN ('GRANTED', 'REQUIRE') THEN 'Open'
        ELSE 'Closed'
    END AS window_status,
    CASE
        WHEN sc.severity_cd = 'CRIT1' THEN 'Received with Critical 1 Errors'
        WHEN sq.submission_id IS NULL AND em.em_status_cd = 'RECVD' AND em.mon_plan_id IS NOT NULL THEN 'Received via ETS'
        WHEN sc.severity_cd = 'CRIT2' THEN 'Received with Critical 2 Errors'
        WHEN sc.severity_cd IS NOT NULL THEN 'Received'
        WHEN sq.submission_id IS NOT NULL THEN 'Data Not Loaded'
        ELSE 'No Submission'
    END AS submission_status,
    mp.locations,
    CASE
        WHEN em.access_begin_date = (
            SELECT MAX(esa_max.access_begin_date) AS access_begin_date
              FROM camdecmpsaux.em_submission_access esa_max
             WHERE esa_max.mon_plan_id = em.mon_plan_id
               AND esa_max.rpt_period_id = em.rpt_period_id           
               AND (esa_max.sub_availability_cd <> 'DELETE' OR esa_max.sub_availability_cd IS null)
             GROUP BY esa_max.mon_plan_id, esa_max.rpt_period_id
             )
        THEN 'Yes'
        ELSE 'No'
    END AS last_window,
    CASE
        WHEN ee.mon_plan_id IS NULL THEN 'No'
        ELSE 'Yes'
    END AS accepted_submission_in_period,
    CASE
        WHEN ee.mon_plan_id IS NULL THEN 'No'
        WHEN sq.submission_id IS NULL AND em.em_status_cd = 'RECVD' AND ee.submission_id IS NULL THEN 'Yes'
        WHEN sq.submission_id IS NOT NULL AND ee.submission_id IS NOT NULL AND sq.submission_id = ee.submission_id THEN 'Yes'
        WHEN ee.submission_id IS NOT NULL THEN 'No'
        ELSE 'Unknown'
    END AS last_window_with_ok_submission,
    ss.user_id AS submitter_user_id
FROM camdecmpsaux.em_submission_access em
JOIN camdecmps.vw_monitor_plan mp USING(mon_plan_id)
JOIN camdecmps.monitor_plan_reporting_freq rf
    ON rf.mon_plan_id = em.mon_plan_id
    AND (
         (rf.begin_rpt_period_id <= em.rpt_period_id AND rf.end_rpt_period_id IS NULL)
         OR (rf.begin_rpt_period_id <= em.rpt_period_id AND rf.end_rpt_period_id >= em.rpt_period_id)
    )
JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
JOIN camdecmpsmd.em_status_code statc USING (em_status_cd)
JOIN camdecmpsmd.em_sub_type_code stc USING (em_sub_type_cd)
LEFT JOIN camdecmpsmd.submission_availability_code sac
    ON em.sub_availability_cd = sac.submission_availability_cd
JOIN camd.plant pl USING(fac_id)
LEFT JOIN camdecmpsaux.submission_queue sq
    ON sq.submission_id = em.submission_id
LEFT JOIN camdecmpsaux.submission_set ss
    ON ss.submission_set_id = sq.submission_set_id
LEFT JOIN camdecmpsmd.severity_code sc
    ON sq.severity_cd = sc.severity_cd
LEFT JOIN camdecmps.emission_evaluation ee
    ON ee.mon_plan_id = em.mon_plan_id
   AND ee.rpt_period_id = em.rpt_period_id
GROUP BY
    em.em_sub_access_id,
    em.mon_plan_id,
    em.rpt_period_id,
    em.access_begin_date,
    em.access_end_date,
    stc.em_sub_type_cd,
    stc.em_sub_type_cd_description,
    em.userid,
    em.add_date,
    em.update_date,
    statc.em_status_cd,
    statc.em_status_cd_description,
    sac.submission_availability_cd,
    sac.sub_avail_cd_description,
    em.resub_explanation,
    pl.fac_id,
    pl.oris_code,
    pl.state,
    pl.facility_name,
    rp.calendar_year,
    rp.quarter,
    rp.period_abbreviation,
    rf.report_freq_cd,
    sq.submission_id,
    sq.queued_time,
    sc.severity_cd,
    sc.severity_cd_description,
    mp.locations,
    ee.mon_plan_id,
    ee.submission_id,
	ss.user_id
ORDER BY
    em.rpt_period_id DESC,
    em.access_begin_date DESC;
