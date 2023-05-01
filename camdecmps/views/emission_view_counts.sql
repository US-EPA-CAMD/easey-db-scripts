-- View: camdecmps.emission_view_counts

DROP VIEW IF EXISTS camdecmps.emission_view_counts;

CREATE OR REPLACE VIEW camdecmps.emission_view_counts
 AS
 SELECT vw.mon_plan_id,
    vw.mon_loc_id,
    COALESCE(u.unitid, sp.stack_name) AS unit_stack,
    vw.dataset_cd,    
    rp.rpt_period_id,
    rp.calendar_year AS rpt_period_year,
    rp.quarter AS rpt_period_qtr,
    vw.count
   FROM camdecmps.emission_view_count vw
     JOIN camdecmps.monitor_location ml USING (mon_loc_id)
     JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
     LEFT JOIN camdecmps.stack_pipe sp USING (stack_pipe_id)
     LEFT JOIN camd.unit u USING (unit_id);
