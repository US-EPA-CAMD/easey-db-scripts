-- View: camdecmpswks.vw_mp_monitor_method

DROP VIEW IF EXISTS camdecmpswks.vw_mp_monitor_method;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_monitor_method
 AS
 SELECT mm.mon_method_id,
    mp.mon_plan_id,
    ml.mon_loc_id,
    mm.parameter_cd,
    mm.sub_data_cd,
    mm.bypass_approach_cd,
    mm.method_cd,
    mm.begin_date + ((mm.begin_hour || ' HOUR'::text)::interval) AS begin_datehour,
    mm.begin_date,
    mm.begin_hour,
    mm.end_date + ((mm.end_hour || ' HOUR'::text)::interval) AS end_datehour,
    mm.end_date,
    mm.end_hour,
    sp.stack_pipe_id,
    sp.stack_name,
    u.unit_id,
    u.unitid
   FROM camdecmpswks.monitor_location ml
     JOIN camdecmpswks.monitor_method mm ON ml.mon_loc_id::text = mm.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan_location mpl ON ml.mon_loc_id::text = mpl.mon_loc_id::text
     JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id::text = mp.mon_plan_id::text
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text;
