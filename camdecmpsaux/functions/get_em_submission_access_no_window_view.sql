DROP FUNCTION IF EXISTS camdecmpsaux.get_em_submission_access_no_window_view;

CREATE OR REPLACE FUNCTION camdecmpsaux.get_em_submission_access_no_window_view(
    v_orisCode numeric,
    v_calendarYear numeric,
    v_quarter numeric
)
RETURNS TABLE (
    em_sub_access_id              numeric,
    mon_plan_id                   text,
    rpt_period_id                 numeric,
    access_begin_date             date,
    access_end_date               date,
    em_sub_type_cd                text,
    em_sub_type_cd_description    text,
    userid                        text,
    add_date                      timestamp,
    update_date                   timestamp,
    em_status_cd                  text,
    em_status_cd_description      text,
    sub_availability_cd           text,
    sub_availability_cd_description text,
    resub_explanation             text,
    fac_id                        numeric,
    oris_code                     numeric,
    state                         text,
    facility_name                 text,
    calendar_year                 numeric,
    quarter                       numeric,
    period_abbreviation           text,
    report_freq_cd                text,
    submission_id                 numeric,
    severity_cd                   text,
    severity_cd_description       text,
    locations                     text
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        NULL::numeric       AS em_sub_access_id,
        vmp.mon_plan_id::text		AS mon_plan_id,
        em.rpt_period_id    AS rpt_period_id,
        NULL::date          AS access_begin_date,
        NULL::date          AS access_end_date,
        NULL::text          AS em_sub_type_cd,
        NULL::text          AS em_sub_type_cd_description,
        NULL::text          AS userid,
        NULL::timestamp     AS add_date,
        NULL::timestamp     AS update_date,
        NULL::text          AS em_status_cd,
        NULL::text          AS em_status_cd_description,
        NULL::text          AS sub_availability_cd,
        NULL::text          AS sub_availability_cd_description,
        NULL::text          AS resub_explanation,
        vmp.fac_id          AS fac_id,
        vmp.oris_code       AS oris_code,
        vmp.state::text          AS state,
        vmp.facility_name::text   AS facility_name,
        rp.calendar_year    AS calendar_year,
        rp.quarter          AS quarter,
        rp.period_abbreviation::text AS period_abbreviation,
        rf.report_freq_cd::text   AS report_freq_cd,
        NULL::numeric       AS submission_id,
        NULL::text          AS severity_cd,
        NULL::text          AS severity_cd_description,
        vmp.locations       AS locations
    FROM camdecmps.vw_monitor_plan vmp
    JOIN (
        SELECT 
            mp.mon_plan_id,
            rp.rpt_period_id,
            CONCAT(rp.calendar_year, ' Q', rp.quarter) AS period,
            camdecmpsaux.get_em_submission_status(mp.mon_plan_id, rp.calendar_year, rp.quarter) AS em_sub_status
        FROM camdecmps.monitor_plan mp
        JOIN camdecmpsmd.reporting_period rp
            ON mp.begin_rpt_period_id <= rp.rpt_period_id
           AND (mp.end_rpt_period_id IS NULL OR mp.end_rpt_period_id >= rp.rpt_period_id)
        JOIN camd.plant p 
            ON mp.fac_id = p.fac_id
        LEFT JOIN (
            SELECT DISTINCT e.mon_plan_id
            FROM camdecmps.emission_evaluation e
            WHERE e.submission_id IS NULL
        ) ee 
            ON mp.mon_plan_id = ee.mon_plan_id
        WHERE rp.end_date + INTERVAL '30 days' < CURRENT_DATE
          AND (rp.rpt_period_id >= p.first_ecmps_rpt_period_id OR ee.mon_plan_id IS NULL)
           AND p.oris_code = COALESCE(v_orisCode, p.oris_code)
           AND rp.calendar_year = COALESCE(v_calendarYear, rp.calendar_year)
           AND rp.quarter = COALESCE(v_quarter, rp.quarter)
    ) em 
        ON vmp.mon_plan_id = em.mon_plan_id
    LEFT JOIN camdecmps.monitor_plan_reporting_freq rf
        ON rf.mon_plan_id = em.mon_plan_id
       AND (
         (rf.begin_rpt_period_id <= em.rpt_period_id AND rf.end_rpt_period_id IS NULL) 
         OR (rf.begin_rpt_period_id <= em.rpt_period_id AND rf.end_rpt_period_id >= em.rpt_period_id)
       )
    JOIN camdecmpsmd.reporting_period rp 
        ON rp.rpt_period_id = em.rpt_period_id
    WHERE em.em_sub_status IS NOT NULL
      AND NOT EXISTS (
          SELECT 1
          FROM camdecmpsaux.em_submission_access esa
          WHERE esa.mon_plan_id = em.mon_plan_id
            AND esa.rpt_period_id = em.rpt_period_id
            AND esa.sub_availability_cd <> 'DELETE'
      );
END;
$$;
