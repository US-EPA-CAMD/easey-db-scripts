-- View: camdecmpswks.vw_mp_location_unit_type

-- DROP VIEW camdecmpswks.vw_mp_location_unit_type;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_location_unit_type
 AS
 SELECT mpl.mon_plan_id,
    mpl.mon_loc_id,
    uc.unit_boiler_type_id,
    uc.unit_id,
    u.unitid,
    uc.unit_type_cd,
    uc.begin_date,
    uc.end_date
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camd.unit_boiler_type uc ON usc.unit_id = uc.unit_id
     JOIN camd.unit u ON u.unit_id = usc.unit_id
UNION
 SELECT mpl.mon_plan_id,
    mpl.mon_loc_id,
    uc.unit_boiler_type_id,
    uc.unit_id,
    u.unitid,
    uc.unit_type_cd,
    uc.begin_date,
    uc.end_date
   FROM camdecmpswks.monitor_plan_location mpl
     JOIN camdecmpswks.monitor_location ml ON mpl.mon_loc_id::text = ml.mon_loc_id::text
     JOIN camd.unit_boiler_type uc ON ml.unit_id = uc.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id;
