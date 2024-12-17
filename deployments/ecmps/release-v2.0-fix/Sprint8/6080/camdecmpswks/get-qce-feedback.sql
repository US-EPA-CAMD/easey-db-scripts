DROP FUNCTION IF EXISTS camdecmpswks.get_qacert_event_feedback(text[]) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.get_qacert_event_feedback(qceId text[])
RETURNS TABLE(
    unit_stack_pipe character varying,
    qa_cert_event_cd character varying,
    sys_id_type text,
    component text,
    qa_cert_datehour character varying)
LANGUAGE plpgsql
AS $$
BEGIN
RETURN QUERY
SELECT DISTINCT
    COALESCE(ml.stack_name, ml.unitid) AS unit_stack_pipe,
    qe.qa_cert_event_cd,
    ms.system_identifier || '/' || ms.sys_type_cd AS sys_id_type,
    c.component_identifier || '/' || c.component_type_cd AS component,
    camdecmpswks.format_date_hour(qe.qa_cert_event_date, qe.qa_cert_event_hour, NULL) AS qa_cert_datehour
FROM camdecmpswks.qa_cert_event qe
         INNER JOIN (
    SELECT cl.chk_session_id, cl.severity_cd
    FROM camdecmpswks.check_log cl
    WHERE cl.severity_cd <> 'NONE'
) AS cl_filtered ON cl_filtered.chk_session_id = qe.chk_session_id
         INNER JOIN camdecmpswks.vw_monitor_location ml ON qe.mon_loc_id = ml.mon_loc_id
         LEFT OUTER JOIN camdecmpswks.component c ON qe.component_id = c.component_id
         LEFT OUTER JOIN camdecmpswks.monitor_system ms ON qe.mon_sys_id = ms.mon_sys_id
WHERE qe.qa_cert_event_id = ANY(qceId);
END;
$$;
