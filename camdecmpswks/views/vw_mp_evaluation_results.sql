-- View: camdecmpswks.vw_mp_evaluation_results

-- DROP VIEW camdecmpswks.vw_mp_evaluation_results;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_evaluation_results
 AS
 SELECT cs.mon_plan_id AS monitorplanid,
        CASE
            WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
            WHEN ml.unit_id IS NOT NULL then u.unitid
			WHEN cl.mon_loc_id IS NULL then 'All Locations'
			ELSE 'Undetermined'
        END AS unitstackinformation,
    cl.severity_cd AS severitycode,
    ccd.category_cd_description AS categorycodedescription,
    (((cc.check_type_cd::text || '-'::text) || cc.check_number) || '-'::text) || ccr.check_result::text AS checkcode,
    cl.result_message AS resultmessage
   FROM camdecmpswks.check_log cl
     JOIN camdecmpswks.check_session cs ON cl.chk_session_id::text = cs.chk_session_id::text
	 LEFT JOIN camdecmpswks.monitor_location ml ON cl.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     JOIN camdecmpsmd.check_catalog_result ccr ON cl.check_catalog_result_id = ccr.check_catalog_result_id
     JOIN camdecmpsmd.check_catalog cc ON ccr.check_catalog_id = cc.check_catalog_id
     JOIN camdecmpsmd.rule_check rc ON cc.check_catalog_id = rc.check_catalog_id
     JOIN camdecmpsmd.category_code ccd ON rc.category_cd::text = ccd.category_cd::text AND ccd.process_cd::text = 'MP'::text;

ALTER TABLE camdecmpswks.vw_mp_evaluation_results
    OWNER TO "uImcwuf4K9dyaxeL";

