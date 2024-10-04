DROP FUNCTION IF EXISTS camdecmpswks.get_qatest_feedback(text[]) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.get_qatest_feedback(testId text[])
RETURNS TABLE(
    unit_stack_pipe character varying,
    test_type_cd character varying,
    test_num character varying,
    sys_comp text,
    end_test character varying)
LANGUAGE plpgsql
AS $$
BEGIN
RETURN QUERY
SELECT DISTINCT
    COALESCE(ml.stack_name, ml.unitid) AS unit_stack_pipe,
    ts.test_type_cd,
    ts.test_num,
    COALESCE(c.component_identifier, ms.system_identifier, '') || '/' ||
    COALESCE(c.component_type_cd || ' ' || COALESCE(ts.span_scale_cd, ''), ms.sys_type_cd, '') AS sys_comp,
    CASE
        WHEN rp.calendar_year IS NOT NULL THEN rp.period_abbreviation
        ELSE camdecmpswks.format_date_hour(ts.end_date, ts.end_hour, ts.end_min)
        END AS end_test
FROM camdecmpswks.test_summary ts
         INNER JOIN (
    SELECT cl.chk_session_id, cl.severity_cd
    FROM camdecmpswks.check_log cl
    WHERE cl.severity_cd <> 'NONE' OR cl.severity_cd IS NULL
) AS cl_filtered ON cl_filtered.chk_session_id = ts.chk_session_id
         INNER JOIN camdecmpswks.vw_monitor_location ml ON ts.mon_loc_id = ml.mon_loc_id
         LEFT OUTER JOIN camdecmpsmd.reporting_period rp ON ts.rpt_period_id = rp.rpt_period_id
         LEFT OUTER JOIN camdecmpswks.component c ON ts.component_id = c.component_id
         LEFT OUTER JOIN camdecmpswks.monitor_system ms ON ts.mon_sys_id = ms.mon_sys_id
WHERE ts.test_sum_id = ANY(testId);
END;
$$;
