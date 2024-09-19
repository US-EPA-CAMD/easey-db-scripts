DROP FUNCTION IF EXISTS camdecmpswks.get_test_extension_exemption_feedback(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.get_test_extension_exemption_feedback(teeid text)
RETURNS TABLE(
    unit_stack_pipe character varying,
    extens_exempt_cd character varying,
    tee_year_quarter character varying,
    sys_id_type text,
    component text,
    span_fuel character varying)
LANGUAGE plpgsql
AS $$
BEGIN
RETURN QUERY
SELECT DISTINCT
    COALESCE(ml.stack_name, ml.unitid) AS unit_stack_pipe,
    tee.extens_exempt_cd,
    rp.period_abbreviation AS tee_year_quarter,
    ms.system_identifier || '/' || ms.sys_type_cd AS sys_id_type,
    c.component_identifier || '/' || c.component_type_cd AS component,
    COALESCE(tee.span_scale_cd, tee.fuel_cd) AS span_fuel
FROM camdecmpswks.test_extension_exemption tee
         INNER JOIN (
    SELECT cl.chk_session_id, cl.severity_cd
    FROM camdecmpswks.check_log cl
    WHERE cl.severity_cd <> 'NONE'
) AS cl_filtered ON cl_filtered.chk_session_id = tee.chk_session_id
         INNER JOIN camdecmpswks.vw_monitor_location ml ON tee.mon_loc_id = ml.mon_loc_id
         LEFT OUTER JOIN camdecmpsmd.reporting_period rp ON tee.rpt_period_id = rp.rpt_period_id
         LEFT OUTER JOIN camdecmpswks.component c ON tee.component_id = c.component_id
         LEFT OUTER JOIN camdecmpswks.monitor_system ms ON tee.mon_sys_id = ms.mon_sys_id
WHERE tee.test_extension_exemption_id = ANY(STRING_TO_ARRAY(teeid, ','));
END;
$$;
