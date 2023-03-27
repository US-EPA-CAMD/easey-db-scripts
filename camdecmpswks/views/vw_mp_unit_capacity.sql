-- View: camdecmpswks.vw_mp_unit_capacity

DROP VIEW IF EXISTS camdecmpswks.vw_mp_unit_capacity;

CREATE OR REPLACE VIEW camdecmpswks.vw_mp_unit_capacity
 AS
 SELECT mpl.mon_plan_id,
    uc.unit_id,
    uc.unit_cap_id,
    uc.begin_date,
    uc.end_date,
    uc.max_hi_capacity,
    ml.mon_loc_id
   FROM camdecmpswks.unit_capacity uc
     JOIN camd.unit u ON u.unit_id = uc.unit_id
     JOIN camdecmpswks.monitor_location ml ON ml.unit_id = u.unit_id
     JOIN camdecmpswks.monitor_plan_location mpl ON ml.mon_loc_id::text = mpl.mon_loc_id::text;
