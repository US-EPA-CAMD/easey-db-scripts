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
        rp.rpt_period_id    AS rpt_period_id,
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
    JOIN camdecmpsmd.reporting_period rp
        ON vmp.begin_rpt_period_id <= rp.rpt_period_id
       AND (vmp.end_rpt_period_id IS NULL OR vmp.end_rpt_period_id >= rp.rpt_period_id)
       AND rp.calendar_year = COALESCE(v_calendarYear, rp.calendar_year)
       AND rp.quarter = COALESCE(v_quarter, rp.quarter) 
       AND rp.end_date < CURRENT_DATE
    LEFT JOIN camdecmps.monitor_plan_reporting_freq rf
        ON vmp.mon_plan_id = rf.mon_plan_id
       AND (
         (rf.begin_rpt_period_id <= rp.rpt_period_id AND rf.end_rpt_period_id IS NULL) 
         OR (rf.begin_rpt_period_id <= rp.rpt_period_id AND rf.end_rpt_period_id >= rp.rpt_period_id)
       )
    WHERE rp.rpt_period_id >= coalesce(vmp.first_ecmps_rpt_period_id, (select first_ecmps_rp.rpt_period_id from camdecmpsmd.reporting_period first_ecmps_rp where first_ecmps_rp.calendar_year = 2009 and first_ecmps_rp.quarter = 1))
      AND vmp.oris_code = COALESCE(v_orisCode, vmp.oris_code)
	  AND EXISTS (
		  SELECT 1
		    FROM camdecmps.vw_em_reporting_status ers
	       WHERE ers.mon_plan_id = vmp.mon_plan_id
		     AND ers.rpt_period_id = rp.rpt_period_id
	         AND ers.calendar_year = COALESCE(2025, rp.calendar_year)
	         AND ers.quarter = COALESCE(2, rp.quarter)
		     and ers.em_reporting_status is not null	
		)
	  AND NOT EXISTS (
		   SELECT 1
		     FROM camdecmpsaux.em_submission_access esa
		    WHERE esa.mon_plan_id = vmp.mon_plan_id
		      AND esa.rpt_period_id = rp.rpt_period_id
		      AND esa.sub_availability_cd <> 'DELETE'
		)
    ORDER BY VMP.ORIS_CODE ASC, rp.period_abbreviation DESC, VMP.LOCATIONS ASC;
END;
$$;
