CREATE OR REPLACE VIEW camdecmps.vw_test_extension_exemption_eval_and_submit
 AS
 SELECT p.oris_code,
    p.facility_name,
    mpl.mon_plan_id,
    COALESCE(u.unitid, sp.stack_name) AS location_info,
    tee.test_extension_exemption_id,
    tee.extens_exempt_cd,
    tee.mon_loc_id,
    COALESCE(ms.system_identifier, c.component_identifier) AS system_component_identifier,
    tee.rpt_period_id,
    tee.userid,
    COALESCE(tee.update_date, tee.add_date) AS update_date,
	tee.fuel_cd,
    tee.hours_used,
    tee.span_scale_cd,
    rp.period_abbreviation
   FROM camd.plant p
     JOIN camdecmps.monitor_plan mp USING (fac_id)
     JOIN camdecmps.monitor_plan_location mpl USING (mon_plan_id)
     JOIN camdecmps.monitor_location ml USING (mon_loc_id)
     JOIN camdecmps.test_extension_exemption tee USING (mon_loc_id)
     LEFT JOIN camdecmps.monitor_system ms USING (mon_sys_id)
     LEFT JOIN camdecmps.component c USING (component_id)
     LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = tee.rpt_period_id
     LEFT JOIN camd.unit u USING (unit_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
  ORDER BY p.oris_code, mp.mon_plan_id, u.unitid, sp.stack_name, tee.rpt_period_id;
