-- View: camdecmpswks.vw_mp_monitor_location

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_location;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_location
 AS
 SELECT mpl.monitor_plan_location_id,
    mp.mon_plan_id,
    ml.mon_loc_id,
    mp.fac_id,
    p.oris_code,
    vwm.location_name,
    sp.stack_pipe_id,
    u.unit_id,
    u.non_load_based_ind,
    sp.active_date AS stack_pipe_active_date,
    sp.retire_date AS stack_pipe_retire_date
   FROM camdecmpswks.monitor_plan mp
     FULL JOIN camd.plant p ON mp.fac_id = p.fac_id
     FULL JOIN (camdecmpswks.monitor_location ml
     JOIN camdecmpswks.monitor_plan_location mpl ON ml.mon_loc_id::text = mpl.mon_loc_id::text
     LEFT JOIN camdecmpswks.vw_monitor_location_merged vwm ON mpl.mon_loc_id::text = vwm.mon_loc_id::text) ON mp.mon_plan_id::text = mpl.mon_plan_id::text
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text;
