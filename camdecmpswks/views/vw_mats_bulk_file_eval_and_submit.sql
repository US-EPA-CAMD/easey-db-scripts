CREATE OR REPLACE VIEW camdecmpswks.vw_mats_bulk_file_eval_and_submit
 AS
 SELECT mbf.oris_code,
    mbf.facility_name,
    mbf.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS location_info,
    mbf.mats_bulk_file_id,
    ml.mon_loc_id,
    COALESCE(ms.system_identifier, c.component_identifier) AS system_component_identifier,
    mbf.userid,
    mbf.add_date AS update_date,
    mbf.submission_availability_cd,
    sac.sub_avail_cd_description AS submission_availability_cd_description,
    mbf.test_num,
    mbf.filename,
    mbf.updated_status_flg
   FROM camdecmpswks.mats_bulk_file mbf
     JOIN camdecmpswks.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmpswks.monitor_location ml ON ml.mon_loc_id::text = mpl.mon_loc_id::text
     JOIN camdecmpsmd.submission_availability_code sac ON sac.submission_availability_cd::text = mbf.submission_availability_cd::text
     LEFT JOIN camdecmpswks.test_summary ts ON ts.test_num::text = mbf.test_num::text AND ts.mon_loc_id::text = ml.mon_loc_id::text
     LEFT JOIN camdecmpswks.monitor_system ms ON ms.mon_sys_id::text = ts.mon_sys_id::text
     LEFT JOIN camdecmpswks.component c ON c.component_id::text = ts.component_id::text
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
	 WHERE mbf.submission_availability_cd <> 'UPDATED'
  ORDER BY mbf.oris_code, mbf.mon_plan_id, u.unitid, sp.stack_name;